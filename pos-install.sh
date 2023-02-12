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
# Pacotes de software, assim caso o usuario queria instalar por exemplo
# apenas a minhas customizaçoes do terminal, ela seleciona e instalar 
# apenas isso.
#
#-----------------------------------------------------------------
# Variaveis de instalação ->

#-----------------------------------------------------------------
#
# bloco de codigo para testar, se o usuario é Root, testando a internet e atualizado o sistema
function test(){
    #teste de root
    (("$UID" == "0")) || { echo "Apenas Root pode executar esse script, por favor tente novamente usando sudo." ; exit 1 ;}
    #Teste de internet
    echo "Testando sua Internet..."
    sleep 2s
    wget -q -spider www.google.com && echo "Internet OK..." || { echo "sem Internet, Verifique sua Rede [ERROR]" } ; exit 1 ;}
    #atualizado o sistema
    echo "Atualizado o sistema.."
    sleep 2s
    yes | pacman -Syu
}

# Bloco de codigo para instalar o aur Paru ou Yay
function aurinstall(){
    read -p "Qual AUR Helper você gostaria de instalar ? [Yay/Paru] " opcao
        if ((opcao == "Yay")); then
            yes | pacman -S --needed base-devel
            git clone https://aur.archlinux.org/paru.git
            cd paru
            makepkg -si
        elif ((opcao == "Paru")); then
            yes | pacman -S --needed git base-devel
            git clone https://aur.archlinux.org/yay.git
            cd yay
            makepkg -si
        else echo "opção incorreta saindo... [ERROR]" ; exit 1
        fi
}

function zshinstall(){
    yes | pacman -S zsh
    if which curl > /dev/null; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else echo "Curl não encontrado, Por favor instale o curl antes de instalar o zsh." ; exit 1
    fi
}

function gameinstall(){
    read -p "Gostaria de instalar STEAM ?? [S/n] " opcao
    if (( $opcao == "S")); then
        pacman -S steam
    else
        echo "Ok..."
    fi
}
