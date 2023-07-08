package {{.PkgName}}

import (
"net/http"

"github.com/zeromicro/go-zero/rest/httpx"
{{.ImportPackages}}
)

func {{.HandlerName}}(svcCtx *svc.ServiceContext) http.HandlerFunc {
return func(w http.ResponseWriter, r *http.Request) {
{{if .HasRequest}}var req dto.{{.RequestType}}
if err := httpx.Parse(r, &req); err != nil {
httpx.ErrorCtx(r.Context(), w, err)
return
}
{{end}}
{{/* workaround: Capitalized .LogicName replaced with lowercase .PkgName since it must be equal (use/web groups have same subpackages names */}}
l := {{.PkgName}}.New{{.LogicType}}(r.Context(), svcCtx)
{{if .HasResp}}resp, {{end}}err := l.{{.Call}}({{if .HasRequest}}&req{{end}})
if err != nil {
httpx.ErrorCtx(r.Context(), w, err)
} else {
{{if .HasResp}}httpx.OkJsonCtx(r.Context(), w, resp){{else}}httpx.Ok(w){{end}}
}
}
}