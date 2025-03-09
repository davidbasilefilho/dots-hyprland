post_install() {
  sh -c "$(curl -fsSL https://install.ohmyz.sh)"
  rm -f ~/.zshrc
  ln -sf .zshrc ~/.zshrc
}

post_upgrade() {
  rm -f ~/.zshrc
  ln -sf .zshrc ~/.zshrc
}
