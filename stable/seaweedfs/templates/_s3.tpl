{{/* All s3 specific versions of _helpers */}}

{{- define "s3.fullname" -}}
{{- printf "%s-%s" (include "seaweedfs.fullname" .) "s3" -}}
{{- end -}}

{{- define "s3.labels" -}}
{{ include "seaweedfs.labels" . }}
app.kubernetes.io/component: s3
{{- end -}}

{{- define "s3.selectorLabels" -}}
{{ include "seaweedfs.selectorLabels" . }}
app.kubernetes.io/component: s3
{{- end -}}

{{- define "s3.serviceAccountName" -}}
{{- if .Values.s3.serviceAccount.create -}}
    {{ default (include "s3.fullname" .) .Values.s3.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.s3.serviceAccount.name }}
{{- end -}}
{{- end -}}
