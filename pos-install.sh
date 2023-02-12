#!/usr/bin/env bash
#
#-----------------------------------------------------------------
# Contato -->
#
# Criando por Eduardo Silva, Email: eduardofox989@protonmail.com
# 
# Por Favor se estiver com qualquer problema
# me envie um email ou reporte no github, Obrigado :D
#
#-----------------------------------------------------------------
# Objetivo -->
#
# Eu sou uma pessoa que esta sempre mudando muito meu sistema Linux
# e de vez em quanto eu acabo tento que formatar meu pc inteiro
# então para facilitar minha vida criei esse script para automatizar
# todo o meu pos instalação.
#
# Este Script tem a ideia de ser facil de usar e util para qualquer
# pessoa que use arch linux, Com isso em mente eu criei Opçoes com 
# Pacote de softwares, assim caso o usuario queria instalar por exemplo
# apenas a minhas customizaçoes do terminal, ela seleciona e instalar 
# apenas isso.
#
#-----------------------------------------------------------------
# Variaveis de instalação ->
menu=("AURhelper" "games" "zsh" "flatpak" "Sair")
#-----------------------------------------------------------------
#
# bloco de codigo para testar, se o usuario é Root, testando a internet e atualizado o sistema
function test(){
    #Teste de internet
    echo "Testando sua Internet..."
        sleep 2s
            wget -q --spider www.google.com && echo "Internet OK..." || { echo "sem Internet, Verifique sua Rede [ERROR]" } ; exit 1 ;}
    #atualizado o sistema
    echo "Atualizado o sistema, Sera Necessario sua senha Root"
        sleep 2s
           sudo pacman -Syu --noconfirm
}

# Bloco de codigo para instalar o aur Paru ou Yay
function aurinstall(){
    read -p "Qual AUR Helper você gostaria de instalar ? [Yay/Paru] " opcao
        if ((opcao == "Yay")); then
            sudo pacman -S --needed base-devel --noconfirm
            git clone https://aur.archlinux.org/paru.git
            cd paru
            makepkg -si
        elif ((opcao == "Paru")); then
            sudo pacman -S --needed git base-devel --noconfirm
            git clone https://aur.archlinux.org/yay.git
            cd yay
            makepkg -si
        else echo "opção incorreta saindo... [ERROR]" ; exit 1
        fi
}

# Bloco de Codigo para instalar o zsh e oh my zsh
function zshinstall(){
    sudo pacman -S zsh --noconfirm
    [[ $(type -p curla) ]] || { echo "Necessita do software 'CURL' para instalar o oh my zsh." ; exit 1;}
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

# Bloco de codigo para instalar Steam e lutris
function gameinstall(){
    read -p "Gostaria de instalar STEAM ?? [S/n] " opcao
        if [[ -z $opcao ]]; then
            opcao="S"
        fi
        echo 
        if [[ $opcao = "S" ]]; then
            sudo pacman -S steam --noconfirm
        fi
    read -p "Gostaria de instalar Lutris ?? [S/n] " opcao
        if [[ -z $opcao ]]; then
            opcao="S"
        fi
        if [[ $opcao = "S" ]]; then
            sudo pacman -S lutris --noconfirm
        fi 
}

# Bloco de codigo para instalar o flatpak e adicionar o flathub
function flatinstall(){
    sudo pacman -S flatpak --noconfirm
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

# Menu de opções para o usuario
select opt in "${menu[@]}"; do
    case $opt in
        "AURhelper")
            echo "aur" ;;
        "games")
            echo "games" ;;
        "zsh")
            echo "zsh" ;;
        "flatpak") 
            flatinstall ;;
        "Sair")
            break ;;
        *) echo "opcão invalida";;
    esac
done
