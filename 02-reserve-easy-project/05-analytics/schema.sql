-- ============================================
-- ReserveEasy Database Schema
-- PostgreSQL 14+
-- ============================================

-- Enable UUID extension for generating unique IDs
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================
-- USERS TABLE
-- ============================================
CREATE TABLE users (
    user_id BIGSERIAL PRIMARY KEY,
    uuid UUID DEFAULT uuid_generate_v4() UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    password_hash VARCHAR(255) NOT NULL,
    email_verified BOOLEAN DEFAULT FALSE,
    phone_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    last_login_at TIMESTAMP
);

-- Indexes for performance
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_phone ON users(phone);
CREATE INDEX idx_users_created ON users(created_at);

COMMENT ON TABLE users IS 'Registered users (diners) of the platform';
COMMENT ON COLUMN users.uuid IS 'Public-facing unique identifier (never expose user_id)';

-- ============================================
-- RESTAURANTS TABLE
-- ============================================
CREATE TABLE restaurants (
    restaurant_id BIGSERIAL PRIMARY KEY,
    uuid UUID DEFAULT uuid_generate_v4() UNIQUE NOT NULL,
    name VARCHAR(200) NOT NULL,
    slug VARCHAR(200) UNIQUE NOT NULL, -- URL-friendly name
    cuisine VARCHAR(50),
    description TEXT,
    address TEXT NOT NULL,
    city VARCHAR(100),
    state VARCHAR(50),
    zip_code VARCHAR(20),
    country VARCHAR(50) DEFAULT 'USA',
    lat DECIMAL(10, 7), -- Latitude for geo-search
    lng DECIMAL(10, 7), -- Longitude for geo-search
    phone VARCHAR(20),
    email VARCHAR(255),
    website VARCHAR(500),
    price_range INT CHECK (price_range >= 1 AND price_range <= 4), -- 1=cheap, 4=fine dining
    capacity INT, -- Total seating capacity
    accepts_deposits BOOLEAN DEFAULT TRUE,
    deposit_amount DECIMAL(10, 2) DEFAULT 10.00,
    cancellation_policy TEXT,
    status VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'suspended')),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Indexes
CREATE INDEX idx_restaurants_cuisine ON restaurants(cuisine);
CREATE INDEX idx_restaurants_city ON restaurants(city);
CREATE INDEX idx_restaurants_location ON restaurants USING GIST(ll_to_earth(lat, lng)); -- Geo-spatial index
CREATE INDEX idx_restaurants_slug ON restaurants(slug);

COMMENT ON TABLE restaurants IS 'Restaurant partners on the platform';
COMMENT ON COLUMN restaurants.slug IS 'SEO-friendly URL identifier (e.g., "bella-italia-nyc")';
COMMENT ON COLUMN restaurants.price_range IS '1=Budget ($), 2=Mid ($$ ), 3=Upscale ($$$), 4=Fine Dining ($$$$)';

-- ============================================
-- TABLES (Physical Restaurant Tables)
-- ============================================
CREATE TABLE tables (
    table_id BIGSERIAL PRIMARY KEY,
    restaurant_id BIGINT NOT NULL REFERENCES restaurants(restaurant_id) ON DELETE CASCADE,
    table_number VARCHAR(20) NOT NULL, -- e.g., "T1", "Patio-3"
    capacity INT NOT NULL CHECK (capacity >= 1 AND capacity <= 20),
    location VARCHAR(50), -- e.g., "Main Floor", "Patio", "Private Room"
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Indexes
CREATE INDEX idx_tables_restaurant ON tables(restaurant_id);
CREATE UNIQUE INDEX idx_tables_restaurant_number ON tables(restaurant_id, table_number); -- Prevent duplicate table numbers within a restaurant

COMMENT ON TABLE tables IS 'Individual tables at each restaurant for availability management';

-- ============================================
-- BOOKINGS TABLE
-- ============================================
CREATE TABLE bookings (
    booking_id BIGSERIAL PRIMARY KEY,
    uuid UUID DEFAULT uuid_generate_v4() UNIQUE NOT NULL,
    user_id BIGINT REFERENCES users(user_id) ON DELETE SET NULL, -- Nullable: Allow guest bookings
    restaurant_id BIGINT NOT NULL REFERENCES restaurants(restaurant_id) ON DELETE CASCADE,
    table_id BIGINT REFERENCES tables(table_id) ON DELETE SET NULL, -- Can be NULL if table not assigned yet
    
    -- Booking Details
    booking_date DATE NOT NULL,
    booking_time TIME NOT NULL,
    party_size INT NOT NULL CHECK (party_size >= 1 AND party_size <= 20),
    
    -- Customer Info (for guest bookings or backup)
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(255) NOT NULL,
    customer_phone VARCHAR(20) NOT NULL,
    special_requests TEXT,
    
    -- Status & Confirmation
    status VARCHAR(20) DEFAULT 'confirmed' CHECK (status IN ('confirmed', 'pending', 'cancelled', 'completed', 'no_show')),
    confirmation_code VARCHAR(10) UNIQUE NOT NULL, -- e.g., "ABC123"
    
    -- Payment & Deposits
    deposit_paid DECIMAL(10, 2) DEFAULT 0.00,
    deposit_refunded BOOLEAN DEFAULT FALSE,
    payment_method VARCHAR(50), -- e.g., "stripe", "cash"
    payment_transaction_id VARCHAR(100),
    
    -- Communication Tracking
    sms_sent BOOLEAN DEFAULT FALSE,
    sms_delivered BOOLEAN DEFAULT FALSE,
    email_sent BOOLEAN DEFAULT FALSE,
    reminder_sent BOOLEAN DEFAULT FALSE,
    
    -- Metadata
    source VARCHAR(50) DEFAULT 'web', -- e.g., "web", "mobile", "phone", "walkin"
    notes TEXT, -- Internal notes for restaurant staff
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    cancelled_at TIMESTAMP,
    completed_at TIMESTAMP
);

-- Indexes for Performance
CREATE INDEX idx_bookings_user ON bookings(user_id);
CREATE INDEX idx_bookings_restaurant ON bookings(restaurant_id);
CREATE INDEX idx_bookings_date ON bookings(booking_date);
CREATE INDEX idx_bookings_status ON bookings(status);
CREATE INDEX idx_bookings_created ON bookings(created_at);
CREATE INDEX idx_bookings_restaurant_date ON bookings(restaurant_id, booking_date); -- Composite index for availability queries
CREATE INDEX idx_bookings_confirmation ON bookings(confirmation_code);

COMMENT ON TABLE bookings IS 'Customer restaurant reservations';
COMMENT ON COLUMN bookings.uuid IS 'Public-facing booking identifier';
COMMENT ON COLUMN bookings.status IS 'confirmed=active reservation, pending=awaiting payment, cancelled=user cancelled, completed=diner showed up, no_show=diner did not show';
COMMENT ON COLUMN bookings.source IS 'How the booking was made (web app, mobile app, phone call, walk-in)';

-- ============================================
-- REVIEWS TABLE
-- ============================================
CREATE TABLE reviews (
    review_id BIGSERIAL PRIMARY KEY,
    booking_id BIGINT NOT NULL REFERENCES bookings(booking_id) ON DELETE CASCADE,
    user_id BIGINT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    restaurant_id BIGINT NOT NULL REFERENCES restaurants(restaurant_id) ON DELETE CASCADE,
    
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5), -- 1-5 stars
    review_text TEXT,
    food_rating INT CHECK (food_rating >= 1 AND food_rating <= 5),
    service_rating INT CHECK (service_rating >= 1 AND service_rating <= 5),
    ambiance_rating INT CHECK (ambiance_rating >= 1 AND ambiance_rating <= 5),
    
    is_verified BOOLEAN DEFAULT TRUE, -- Only users who completed a booking can review
    is_flagged BOOLEAN DEFAULT FALSE, -- Flagged for moderation
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Indexes
CREATE INDEX idx_reviews_restaurant ON reviews(restaurant_id);
CREATE INDEX idx_reviews_user ON reviews(user_id);
CREATE INDEX idx_reviews_booking ON reviews(booking_id);
CREATE UNIQUE INDEX idx_reviews_booking_unique ON reviews(booking_id); -- One review per booking

COMMENT ON TABLE reviews IS 'Customer reviews of restaurant experiences';

-- ============================================
-- ANALYTICS EVENTS TABLE
-- ============================================
CREATE TABLE analytics_events (
    event_id BIGSERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES users(user_id) ON DELETE SET NULL,
    session_id UUID,
    event_name VARCHAR(100) NOT NULL, -- e.g., "page_view", "search", "booking_started", "booking_completed"
    event_properties JSONB, -- Flexible JSON for event-specific data
    page_url TEXT,
    referrer TEXT,
    user_agent TEXT,
    ip_address INET,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Indexes
CREATE INDEX idx_events_user ON analytics_events(user_id);
CREATE INDEX idx_events_name ON analytics_events(event_name);
CREATE INDEX idx_events_created ON analytics_events(created_at);
CREATE INDEX idx_events_session ON analytics_events(session_id);

COMMENT ON TABLE analytics_events IS 'User behavior tracking for funnel analysis and product analytics';

-- ============================================
-- SAMPLE DATA FOR TESTING
-- ============================================

-- Insert sample users
INSERT INTO users (name, email, phone, password_hash, email_verified) VALUES
('Sarah Chen', 'sarah@example.com', '+15551234567', 'hashed_password_123', TRUE),
('Restaurant Manager Raj', 'raj@example.com', '+15559876543', 'hashed_password_456', TRUE);

-- Insert sample restaurant
INSERT INTO restaurants (name, slug, cuisine, description, address, city, state, zip_code, lat, lng, phone, price_range, capacity) VALUES
('Bella Italia', 'bella-italia-nyc', 'Italian', 'Authentic Italian cuisine in the heart of Manhattan', '123 Main St', 'New York', 'NY', '10001', 40.7589, -73.9851, '+15555551234', 3, 50);

-- Insert sample tables for the restaurant
INSERT INTO tables (restaurant_id, table_number, capacity, location) VALUES
(1, 'T1', 2, 'Main Floor'),
(1, 'T2', 4, 'Main Floor'),
(1, 'T3', 6, 'Patio'),
(1, 'VIP1', 8, 'Private Room');

-- Insert sample booking
INSERT INTO bookings (user_id, restaurant_id, table_id, booking_date, booking_time, party_size, customer_name, customer_email, customer_phone, confirmation_code, status) VALUES
(1, 1, 2, '2026-02-15', '19:00:00', 4, 'Sarah Chen', 'sarah@example.com', '+15551234567', 'ABC123', 'confirmed');
