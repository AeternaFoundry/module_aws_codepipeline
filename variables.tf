variable "codepipelines" {
  description = <<EOT
Map of codepipelines, attributes below
Required:
    - name
    - role_arn
    - artifact_store (block):
        - encryption_key (optional, block):
            - id (required)
            - type (required)
        - location (required)
        - region (optional)
        - type (required)
    - stage (block):
        - action (required, block):
            - category (required)
            - commands (optional)
            - configuration (optional)
            - input_artifacts (optional)
            - name (required)
            - namespace (optional)
            - output_artifacts (optional)
            - output_artifacts_for_compute_action (optional, block):
                - files (optional)
                - name (required)
            - output_variables (optional)
            - owner (required)
            - provider (required)
            - region (optional)
            - role_arn (optional)
            - run_order (optional)
            - timeout_in_minutes (optional)
            - version (required)
        - before_entry (optional, block):
            - condition (required, block):
                - result (optional)
                - rule (required, block):
                    - commands (optional)
                    - configuration (optional)
                    - input_artifacts (optional)
                    - name (required)
                    - region (optional)
                    - role_arn (optional)
                    - rule_type_id (required, block):
                        - category (required)
                        - owner (optional)
                        - provider (required)
                        - version (optional)
                    - timeout_in_minutes (optional)
        - name (required)
        - on_failure (optional, block):
            - condition (optional, block):
                - result (optional)
                - rule (required, block):
                    - commands (optional)
                    - configuration (optional)
                    - input_artifacts (optional)
                    - name (required)
                    - region (optional)
                    - role_arn (optional)
                    - rule_type_id (required, block):
                        - category (required)
                        - owner (optional)
                        - provider (required)
                        - version (optional)
                    - timeout_in_minutes (optional)
            - result (optional)
            - retry_configuration (optional, block):
                - retry_mode (optional)
        - on_success (optional, block):
            - condition (required, block):
                - result (optional)
                - rule (required, block):
                    - commands (optional)
                    - configuration (optional)
                    - input_artifacts (optional)
                    - name (required)
                    - region (optional)
                    - role_arn (optional)
                    - rule_type_id (required, block):
                        - category (required)
                        - owner (optional)
                        - provider (required)
                        - version (optional)
                    - timeout_in_minutes (optional)
Optional:
    - execution_mode
    - pipeline_type
    - region
    - tags
    - tags_all
    - trigger (block):
        - git_configuration (required, block):
            - pull_request (optional, block):
                - branches (optional, block):
                    - excludes (optional)
                    - includes (optional)
                - events (optional)
                - file_paths (optional, block):
                    - excludes (optional)
                    - includes (optional)
            - push (optional, block):
                - branches (optional, block):
                    - excludes (optional)
                    - includes (optional)
                - file_paths (optional, block):
                    - excludes (optional)
                    - includes (optional)
                - tags (optional, block):
                    - excludes (optional)
                    - includes (optional)
            - source_action_name (required)
        - provider_type (required)
    - variable (block):
        - default_value (optional)
        - description (optional)
        - name (required)
EOT

  type = map(object({
    name           = string
    role_arn       = string
    execution_mode = optional(string)
    pipeline_type  = optional(string)
    region         = optional(string)
    tags           = optional(map(string))
    tags_all       = optional(map(string))
    artifact_store = list(object({
      encryption_key = optional(object({
        id   = string
        type = string
      }))
      location = string
      region   = optional(string)
      type     = string
    }))
    stage = list(object({
      action = list(object({
        category         = string
        commands         = optional(list(string))
        configuration    = optional(map(string))
        input_artifacts  = optional(list(string))
        name             = string
        namespace        = optional(string)
        output_artifacts = optional(list(string))
        output_artifacts_for_compute_action = optional(list(object({
          files = optional(list(string))
          name  = string
        })))
        output_variables   = optional(list(string))
        owner              = string
        provider           = string
        region             = optional(string)
        role_arn           = optional(string)
        run_order          = optional(number)
        timeout_in_minutes = optional(number)
        version            = string
      }))
      before_entry = optional(object({
        condition = object({
          result = optional(string)
          rule = list(object({
            commands        = optional(list(string))
            configuration   = optional(map(string))
            input_artifacts = optional(list(string))
            name            = string
            region          = optional(string)
            role_arn        = optional(string)
            rule_type_id = object({
              category = string
              owner    = optional(string)
              provider = string
              version  = optional(string)
            })
            timeout_in_minutes = optional(number)
          }))
        })
      }))
      name = string
      on_failure = optional(object({
        condition = optional(object({
          result = optional(string)
          rule = list(object({
            commands        = optional(list(string))
            configuration   = optional(map(string))
            input_artifacts = optional(list(string))
            name            = string
            region          = optional(string)
            role_arn        = optional(string)
            rule_type_id = object({
              category = string
              owner    = optional(string)
              provider = string
              version  = optional(string)
            })
            timeout_in_minutes = optional(number)
          }))
        }))
        result = optional(string)
        retry_configuration = optional(object({
          retry_mode = optional(string)
        }))
      }))
      on_success = optional(object({
        condition = object({
          result = optional(string)
          rule = list(object({
            commands        = optional(list(string))
            configuration   = optional(map(string))
            input_artifacts = optional(list(string))
            name            = string
            region          = optional(string)
            role_arn        = optional(string)
            rule_type_id = object({
              category = string
              owner    = optional(string)
              provider = string
              version  = optional(string)
            })
            timeout_in_minutes = optional(number)
          }))
        })
      }))
    }))
    trigger = optional(list(object({
      git_configuration = object({
        pull_request = optional(list(object({
          branches = optional(object({
            excludes = optional(list(string))
            includes = optional(list(string))
          }))
          events = optional(list(string))
          file_paths = optional(object({
            excludes = optional(list(string))
            includes = optional(list(string))
          }))
        })))
        push = optional(list(object({
          branches = optional(object({
            excludes = optional(list(string))
            includes = optional(list(string))
          }))
          file_paths = optional(object({
            excludes = optional(list(string))
            includes = optional(list(string))
          }))
          tags = optional(object({
            excludes = optional(list(string))
            includes = optional(list(string))
          }))
        })))
        source_action_name = string
      })
      provider_type = string
    })))
    variable = optional(list(object({
      default_value = optional(string)
      description   = optional(string)
      name          = string
    })))
  }))
  validation {
    condition = alltrue([
      for k, v in var.codepipelines : (
        length(v.artifact_store) >= 1
      )
    ])
    error_message = "Each artifact_store list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.codepipelines : (
        length(v.stage) >= 2
      )
    ])
    error_message = "Each stage list must contain at least 2 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.codepipelines : (
        alltrue([for item in v.stage : (length(item.action) >= 1)])
      )
    ])
    error_message = "Each action list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.codepipelines : (
        alltrue([for item in v.stage : (item.before_entry == null || (length(item.before_entry.condition.rule) >= 1 && length(item.before_entry.condition.rule) <= 5))])
      )
    ])
    error_message = "Each rule list must contain between 1 and 5 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.codepipelines : (
        alltrue([for item in v.stage : (item.on_failure == null || (item.on_failure.condition == null || (length(item.on_failure.condition.rule) >= 1 && length(item.on_failure.condition.rule) <= 5)))])
      )
    ])
    error_message = "Each rule list must contain between 1 and 5 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.codepipelines : (
        alltrue([for item in v.stage : (item.on_success == null || (length(item.on_success.condition.rule) >= 1 && length(item.on_success.condition.rule) <= 5))])
      )
    ])
    error_message = "Each rule list must contain between 1 and 5 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.codepipelines : (
        v.trigger == null || (length(v.trigger) <= 50)
      )
    ])
    error_message = "Each trigger list must contain at most 50 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.codepipelines : (
        v.trigger == null || alltrue([for item in v.trigger : (item.git_configuration.pull_request == null || (length(item.git_configuration.pull_request) <= 3))])
      )
    ])
    error_message = "Each pull_request list must contain at most 3 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.codepipelines : (
        v.trigger == null || alltrue([for item in v.trigger : (item.git_configuration.push == null || (length(item.git_configuration.push) <= 3))])
      )
    ])
    error_message = "Each push list must contain at most 3 items"
  }
  # Note: 46 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

