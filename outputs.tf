output "codepipelines_id" {
  description = "Map of id values across all codepipelines, keyed the same as var.codepipelines"
  value       = { for k, v in aws_codepipeline.codepipelines : k => v.id if v.id != null && length(v.id) > 0 }
}
output "codepipelines_arn" {
  description = "Map of arn values across all codepipelines, keyed the same as var.codepipelines"
  value       = { for k, v in aws_codepipeline.codepipelines : k => v.arn if v.arn != null && length(v.arn) > 0 }
}
output "codepipelines_artifact_store" {
  description = "Map of artifact_store values across all codepipelines, keyed the same as var.codepipelines"
  value       = { for k, v in aws_codepipeline.codepipelines : k => v.artifact_store if v.artifact_store != null && length(v.artifact_store) > 0 }
}
output "codepipelines_execution_mode" {
  description = "Map of execution_mode values across all codepipelines, keyed the same as var.codepipelines"
  value       = { for k, v in aws_codepipeline.codepipelines : k => v.execution_mode if v.execution_mode != null && length(v.execution_mode) > 0 }
}
output "codepipelines_name" {
  description = "Map of name values across all codepipelines, keyed the same as var.codepipelines"
  value       = { for k, v in aws_codepipeline.codepipelines : k => v.name if v.name != null && length(v.name) > 0 }
}
output "codepipelines_pipeline_type" {
  description = "Map of pipeline_type values across all codepipelines, keyed the same as var.codepipelines"
  value       = { for k, v in aws_codepipeline.codepipelines : k => v.pipeline_type if v.pipeline_type != null && length(v.pipeline_type) > 0 }
}
output "codepipelines_region" {
  description = "Map of region values across all codepipelines, keyed the same as var.codepipelines"
  value       = { for k, v in aws_codepipeline.codepipelines : k => v.region if v.region != null && length(v.region) > 0 }
}
output "codepipelines_role_arn" {
  description = "Map of role_arn values across all codepipelines, keyed the same as var.codepipelines"
  value       = { for k, v in aws_codepipeline.codepipelines : k => v.role_arn if v.role_arn != null && length(v.role_arn) > 0 }
}
output "codepipelines_stage" {
  description = "Map of stage values across all codepipelines, keyed the same as var.codepipelines"
  value       = { for k, v in aws_codepipeline.codepipelines : k => v.stage if v.stage != null && length(v.stage) > 0 }
}
output "codepipelines_tags" {
  description = "Map of tags values across all codepipelines, keyed the same as var.codepipelines"
  value       = { for k, v in aws_codepipeline.codepipelines : k => v.tags if v.tags != null && length(v.tags) > 0 }
}
output "codepipelines_tags_all" {
  description = "Map of tags_all values across all codepipelines, keyed the same as var.codepipelines"
  value       = { for k, v in aws_codepipeline.codepipelines : k => v.tags_all if v.tags_all != null && length(v.tags_all) > 0 }
}
output "codepipelines_trigger" {
  description = "Map of trigger values across all codepipelines, keyed the same as var.codepipelines"
  value       = { for k, v in aws_codepipeline.codepipelines : k => v.trigger if v.trigger != null && length(v.trigger) > 0 }
}
output "codepipelines_trigger_all" {
  description = "Map of trigger_all values across all codepipelines, keyed the same as var.codepipelines"
  value       = { for k, v in aws_codepipeline.codepipelines : k => v.trigger_all if v.trigger_all != null && length(v.trigger_all) > 0 }
}
output "codepipelines_variable" {
  description = "Map of variable values across all codepipelines, keyed the same as var.codepipelines"
  value       = { for k, v in aws_codepipeline.codepipelines : k => v.variable if v.variable != null && length(v.variable) > 0 }
}

