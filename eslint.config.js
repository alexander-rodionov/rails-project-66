// eslint.config.js
import js from '@eslint/js';
import globals from 'globals';

export default [
  // Base ESLint recommended config
  js.configs.recommended,

  // Environment and parser config
  {
    languageOptions: {
      ecmaVersion: 'latest',
      sourceType: 'module',
      globals: {
        ...globals.browser,
        ...globals.node,
        ...globals.es2021
      }
    }
  },

  // Rules configuration
  {
    rules: {
      // Basic errors from terrible.js
      'no-undef': 'error',
      'no-var': 'error',
      'no-const-assign': 'error',
      'no-unused-vars': 'error',
      'semi': ['error', 'always'],
      'eqeqeq': 'error',
      'no-inner-declarations': 'error',
      'quotes': ['error', 'single'],
      'no-trailing-spaces': 'error',
      'no-console': 'error',
      'no-unreachable': 'error',
      'comma-dangle': ['error', 'never'],
      'indent': ['error', 2],
      'no-dupe-keys': 'error',
      'no-eval': 'error',
      'no-plusplus': 'error',
      'no-nested-ternary': 'error',
      'no-shadow': 'error',
      'default-case': 'error',

      // Extra paranoid rules
      'strict': ['error', 'global'],
      'no-implicit-globals': 'error',
      'no-multi-spaces': 'error',
      'no-extra-semi': 'error',
      'no-unexpected-multiline': 'error',
      'block-scoped-var': 'error',
      'no-redeclare': 'error',
      'no-implied-eval': 'error',
      'no-script-url': 'error',
      'no-prototype-builtins': 'error',
      'no-sequences': 'error',
      'no-throw-literal': 'error',
      'no-useless-concat': 'error',
      'no-useless-escape': 'error',
      'radix': 'error',
      'require-await': 'error',
      'valid-typeof': ['error', { requireStringLiterals: true }],
      'no-unsafe-optional-chaining': 'error',
      'no-unused-private-class-members': 'error'
    }
  }
];
