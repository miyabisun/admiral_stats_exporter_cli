import times, os, httpclient, strutils, sequtils

proc upload* (token: string, file_type: string, body: string): bool =
  let time = format(now(), "yyyyMMdd,HHmmss").split(",").join("_")
  let url = "https://www.admiral-stats.com/api/v1/import/" & file_type & "/" & time
  let client = newHttpClient()
  client.headers = newHttpHeaders({
    "User-Agent": "AdmiralStatsExporter-Nim-CLI",
    "Authorization": "Bearer " & token,
  })
  let response = client.request(url, HttpPost, body)
  echo file_type & "(" & response.status & "): " & response.body
  result = response.status == "201 Created"
