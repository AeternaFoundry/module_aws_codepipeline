resource "aws_codepipeline" "codepipelines" {
  for_each = var.codepipelines

  name           = each.value.name
  role_arn       = each.value.role_arn
  execution_mode = each.value.execution_mode
  pipeline_type  = each.value.pipeline_type
  region         = each.value.region
  tags           = each.value.tags
  tags_all       = each.value.tags_all

  dynamic "artifact_store" {
    for_each = each.value.artifact_store
    content {
      dynamic "encryption_key" {
        for_each = artifact_store.value.encryption_key != null ? [artifact_store.value.encryption_key] : []
        content {
          id   = encryption_key.value.id
          type = encryption_key.value.type
        }
      }
      location = artifact_store.value.location
      region   = artifact_store.value.region
      type     = artifact_store.value.type
    }
  }

  dynamic "stage" {
    for_each = each.value.stage
    content {
      dynamic "action" {
        for_each = stage.value.action
        content {
          category         = action.value.category
          commands         = action.value.commands
          configuration    = action.value.configuration
          input_artifacts  = action.value.input_artifacts
          name             = action.value.name
          namespace        = action.value.namespace
          output_artifacts = action.value.output_artifacts
          dynamic "output_artifacts_for_compute_action" {
            for_each = action.value.output_artifacts_for_compute_action != null ? action.value.output_artifacts_for_compute_action : []
            content {
              files = output_artifacts_for_compute_action.value.files
              name  = output_artifacts_for_compute_action.value.name
            }
          }
          output_variables   = action.value.output_variables
          owner              = action.value.owner
          provider           = action.value.provider
          region             = action.value.region
          role_arn           = action.value.role_arn
          run_order          = action.value.run_order
          timeout_in_minutes = action.value.timeout_in_minutes
          version            = action.value.version
        }
      }
      dynamic "before_entry" {
        for_each = stage.value.before_entry != null ? [stage.value.before_entry] : []
        content {
          condition {
            result = before_entry.value.condition.result
            dynamic "rule" {
              for_each = before_entry.value.condition.rule
              content {
                commands        = rule.value.commands
                configuration   = rule.value.configuration
                input_artifacts = rule.value.input_artifacts
                name            = rule.value.name
                region          = rule.value.region
                role_arn        = rule.value.role_arn
                rule_type_id {
                  category = rule.value.rule_type_id.category
                  owner    = rule.value.rule_type_id.owner
                  provider = rule.value.rule_type_id.provider
                  version  = rule.value.rule_type_id.version
                }
                timeout_in_minutes = rule.value.timeout_in_minutes
              }
            }
          }
        }
      }
      name = stage.value.name
      dynamic "on_failure" {
        for_each = stage.value.on_failure != null ? [stage.value.on_failure] : []
        content {
          dynamic "condition" {
            for_each = on_failure.value.condition != null ? [on_failure.value.condition] : []
            content {
              result = condition.value.result
              dynamic "rule" {
                for_each = condition.value.rule
                content {
                  commands        = rule.value.commands
                  configuration   = rule.value.configuration
                  input_artifacts = rule.value.input_artifacts
                  name            = rule.value.name
                  region          = rule.value.region
                  role_arn        = rule.value.role_arn
                  rule_type_id {
                    category = rule.value.rule_type_id.category
                    owner    = rule.value.rule_type_id.owner
                    provider = rule.value.rule_type_id.provider
                    version  = rule.value.rule_type_id.version
                  }
                  timeout_in_minutes = rule.value.timeout_in_minutes
                }
              }
            }
          }
          result = on_failure.value.result
          dynamic "retry_configuration" {
            for_each = on_failure.value.retry_configuration != null ? [on_failure.value.retry_configuration] : []
            content {
              retry_mode = retry_configuration.value.retry_mode
            }
          }
        }
      }
      dynamic "on_success" {
        for_each = stage.value.on_success != null ? [stage.value.on_success] : []
        content {
          condition {
            result = on_success.value.condition.result
            dynamic "rule" {
              for_each = on_success.value.condition.rule
              content {
                commands        = rule.value.commands
                configuration   = rule.value.configuration
                input_artifacts = rule.value.input_artifacts
                name            = rule.value.name
                region          = rule.value.region
                role_arn        = rule.value.role_arn
                rule_type_id {
                  category = rule.value.rule_type_id.category
                  owner    = rule.value.rule_type_id.owner
                  provider = rule.value.rule_type_id.provider
                  version  = rule.value.rule_type_id.version
                }
                timeout_in_minutes = rule.value.timeout_in_minutes
              }
            }
          }
        }
      }
    }
  }

  dynamic "trigger" {
    for_each = each.value.trigger != null ? each.value.trigger : []
    content {
      git_configuration {
        dynamic "pull_request" {
          for_each = trigger.value.git_configuration.pull_request != null ? trigger.value.git_configuration.pull_request : []
          content {
            dynamic "branches" {
              for_each = pull_request.value.branches != null ? [pull_request.value.branches] : []
              content {
                excludes = branches.value.excludes
                includes = branches.value.includes
              }
            }
            events = pull_request.value.events
            dynamic "file_paths" {
              for_each = pull_request.value.file_paths != null ? [pull_request.value.file_paths] : []
              content {
                excludes = file_paths.value.excludes
                includes = file_paths.value.includes
              }
            }
          }
        }
        dynamic "push" {
          for_each = trigger.value.git_configuration.push != null ? trigger.value.git_configuration.push : []
          content {
            dynamic "branches" {
              for_each = push.value.branches != null ? [push.value.branches] : []
              content {
                excludes = branches.value.excludes
                includes = branches.value.includes
              }
            }
            dynamic "file_paths" {
              for_each = push.value.file_paths != null ? [push.value.file_paths] : []
              content {
                excludes = file_paths.value.excludes
                includes = file_paths.value.includes
              }
            }
            dynamic "tags" {
              for_each = push.value.tags != null ? [push.value.tags] : []
              content {
                excludes = tags.value.excludes
                includes = tags.value.includes
              }
            }
          }
        }
        source_action_name = trigger.value.git_configuration.source_action_name
      }
      provider_type = trigger.value.provider_type
    }
  }

  dynamic "variable" {
    for_each = each.value.variable != null ? each.value.variable : []
    content {
      default_value = variable.value.default_value
      description   = variable.value.description
      name          = variable.value.name
    }
  }
}

