package common.access

access_map := {
  "workspace-1": {
    "allow_users": ["alfiiaqa@gmail.com"],
    "deny_users": ["a.barylenko@scalr.com"],
    "allow_groups": [],
    "deny_groups": []
  },
  "workspace-2": {
    "allow_users": [],
    "deny_users": [],
    "allow_groups": ["ScalrAdmins"],
    "deny_groups": []
  },
  "ws-3": {
    "allow_users": [],
    "deny_users": ["alfiiaqa@gmail.com"],
    "allow_groups": [],
    "deny_groups": ["ScalrViewers"]
  }
}

ws_access(ws) := a if {
  a := access_map[ws]
} else := {
  "allow_users": [],
  "deny_users": [],
  "allow_groups": [],
  "deny_groups": []
}
