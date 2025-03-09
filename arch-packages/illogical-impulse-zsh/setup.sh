post_install() {
  sh -c "$(curl -fsSL https://install.ohmyz.sh)"

  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions


  rm -f ~/.zshrc
  cp -f .zshrc ~/.zshrc
}

post_upgrade() {
  rm -f ~/.zshrc
  cp -f .zshrc ~/.zshrc
}
