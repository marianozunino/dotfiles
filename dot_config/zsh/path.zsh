function update_path() {
    dirs=(
        "/usr/local/texlive/2024/bin/x86_64-linux"
        "$HOME/.local/bin"
        "$HOME/.local/bin"
        "$HOME/.bin"
        "$HOME/.dotnet/tools"
        "$HOME/.local/share/npm/bin"
    )

    for dir in "${dirs[@]}"; do
        if [ -d "$dir" ]; then
            concated_paths="$concated_paths:$dir"
        fi
    done
    # Remove the leading colon from concated_paths if it exists
    concated_paths="${concated_paths#:}"

    export PATH=$concated_paths:$PATH
    export MANPATH=/usr/local/texlive/2024/texmf-dist/doc/man:$MANPATH
    export INFOPATH=/usr/local/texlive/2024/texmf-dist/doc/info:$INFOPATH
}

update_path

