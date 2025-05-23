# frozen_string_literal: true

Premailer::Rails.config.merge!(
  preserve_styles: false,   # Don't preserve any CSS
  remove_ids: true,         # Remove IDs from elements
  remove_classes: true,     # Remove classes from elements
  remove_scripts: true      # Remove scripts
)
