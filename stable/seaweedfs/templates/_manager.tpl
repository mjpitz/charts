{{/* All manager specific versions of _helpers */}}

{{- define "manager.servers" -}}
{{- $ingressPaths := "" -}}
{{- $serviceName := (include "manager.fullname" .) -}}
{{- range $i := until (int .Values.manager.replicas) -}}
{{- $hostName := printf "%s-%d" $serviceName $i -}}
{{- $ingressPaths = printf "%s%s.%s:9333," $ingressPaths $hostName $serviceName -}}
{{- end -}}
{{- trimSuffix "," $ingressPaths -}}
{{- end -}}

{{- define "manager.fullname" -}}
{{- printf "%s-%s" (include "seaweedfs.fullname" .) "manager" -}}
{{- end -}}

{{- define "manager.labels" -}}
{{ include "seaweedfs.labels" . }}
app.kubernetes.io/component: manager
{{- end -}}

{{- define "manager.selectorLabels" -}}
{{ include "seaweedfs.selectorLabels" . }}
app.kubernetes.io/component: manager
{{- end -}}

{{- define "manager.serviceAccountName" -}}
{{- if .Values.manager.serviceAccount.create -}}
    {{ default (include "manager.fullname" .) .Values.manager.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.manager.serviceAccount.name }}
{{- end -}}
{{- end -}}
