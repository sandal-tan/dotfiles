function export_status --on-event fish_postexec
    set -gx STATUS $status
end
