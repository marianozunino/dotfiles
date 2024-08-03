# Autocomplete function for run-on-pod
_get_kubectx_environments() {
  local context_state

  # Define different states for the arguments
  _arguments \
    '1: :->contexts' \
    '2: :->files'

  case $state in
    contexts)
      local clusters
      clusters=("${(@f)$(kubectx)}")
      _describe -t clusters 'Kubernetes clusters' clusters
      ;;
    files)
      _files
      ;;
  esac
}

# Register the autocomplete function with zsh
compdef _get_kubectx_environments run-on-pod

