# Collections of my dotfiles

## Deploy

```bash
# manually install chezmoi if needed 
mkdir -p ~/.bin
cd ~/.bin

sh -c "$(curl -fsLS git.io/chezmoi)"
export -U PATH=$HOME/.bin/:$PATH

chezmoi init --apply marianozunino
```

To preview the change,

```bash
chezmoi apply --dry-run --verbose
```
