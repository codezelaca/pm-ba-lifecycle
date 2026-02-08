// Custom theme extending VitePress default
// by Codezela Career Accelerator

import DefaultTheme from "vitepress/theme";
import "./custom.css";

export default {
  extends: DefaultTheme,
  enhanceApp({ app }) {
    // Register custom components here if needed
  },
};
