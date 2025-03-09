post_install() {
  sh -c "$(curl -fsSL https://install.ohmyz.sh)"
  rm -f ~/.zshrc
  cp -f .zshrc ~/.zshrc
}

post_upgrade() {
  rm -f ~/.zshrc
  cp -f .zshrc ~/.zshrc
}
