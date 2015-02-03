#!/bin/sh
#
# Script basico para realizar un backup de los archivos de configuracion de mi linux. Los archivos son comprimidos y subidos a ownCloud. 
#
# Variables
DATE=$(date +'%d-%m-%Y')
LINE="-----------------------------------------------------------------"

# Variables de directorios
MAIN=~/backup_temp
LOCK=$MAIN/backup.lock
WORK_DIR=~/backup_temp/$DATE
LOG_FILE=$WORK_DIR/log_file
DIRSAVE=~/ownCloud/backups/linux/
DIRPROF=$WORK_DIR/profanity
DIRZSH=$WORK_DIR/zsh
DIRVIM=$WORK_DIR/vim
DIRPENT=$WORK_DIR/pentadactyl
DIRXINI=$WORK_DIR/xinitrc
DIRRXVT=$WORK_DIR/urxvt
DIRRAN=$WORK_DIR/ranger
DIRAWE=$WORK_DIR/awesome
DIRMPD=$WORK_DIR/mpd
DIRNCM=$WORK_DIR/ncmpcpp
DIRMPL=$WORK_DIR/mplayer
DIRRSS=$WORK_DIR/newsbeuter
DIRSMB=$WORK_DIR/samba
DIRSSH=$WORK_DIR/ssh
DIRSYS=$WORK_DIR/system
DIRSLIM=$WORK_DIR/slim

# Creando directorio donde se trabajará, si es que no existe y los archivos de log y lock. En caso de que el archivo lock este creado el script se detiene.
if [ ! -e $LOCK ]
    then
        mkdir -p $WORK_DIR
        touch $LOCK
        touch $LOG_FILE
    else
        echo $LINE
        echo "El directorio de backup ya existe, saliendo del script"
        echo $LINE
        exit 1
fi

# Realizando copias de segurida.
# Se comprueba que la carpeta exista, si no existe se crea. Se copian los archivos deseados y se loguean los cambios.
# Profanity
if [ ! -d $DIRPROF ]
    then
        mkdir $DIRPROF
        cp $HOME/.config/profanity/profrc $DIRPROF -Rv >> $LOG_FILE
        cp -r $HOME/.local/share/profanity/* $DIRPROF -Rv >> $LOG_FILE && echo $LINE >> $LOG_FILE
fi

# Zsh
if [ ! -d $DIRZSH ]
    then
        mkdir $DIRZSH
        cp ~/.zshrc $DIRZSH -Rv >> $LOG_FILE && echo $LINE >> $LOG_FILE
fi

# Vim
if [ ! -d $DIRVIM ]
    then
        mkdir $DIRVIM
        cp ~/.vimrc $DIRVIM -Rv >> $LOG_FILE
        cp ~/.vim/colors/molokai.vim $DIRVIM -Rv >> $LOG_FILE && echo $LINE >> $LOG_FILE
fi

# Pentadactyl
if [ ! -d $DIRPENT ]
    then
        mkdir $DIRPENT
        cp ~/.pentadactylrc $DIRPENT -Rv >> $LOG_FILE && echo $LINE >> $LOG_FILE
fi

# Xinitrc
if [ ! -d $DIRXINI ]
    then
        mkdir $DIRXINI
        cp ~/.xinitrc $DIRXINI -Rv >> $LOG_FILE && echo $LINE >> $LOG_FILE
fi

# urxvt
if [ ! -d $DIRRXVT ]
    then
        mkdir $DIRRXVT
        cp ~/.Xresources $DIRRXVT -Rv >> $LOG_FILE && echo $LINE >> $LOG_FILE
fi

# Ranger
if [ ! -d $DIRRAN ]
    then
        mkdir $DIRRAN
        cp ~/.config/ranger/rc.conf  $DIRRAN -Rv >> $LOG_FILE
        cp ~/.config/ranger/rifle.conf $DIRRAN -Rv >> $LOG_FILE
        cp ~/.config/ranger/commands.py $DIRRAN -Rv >> $LOG_FILE && echo $LINE >> $LOG_FILE
fi

# Awesome
if [ ! -d $DIRAWE ] 
   then
        mkdir $DIRAWE 
        cp ~/.config/awesome/rc.lua $DIRAWE -Rv >> $LOG_FILE
        cp ~/.config/awesome/default/theme.lua $DIRAWE -Rv >> $LOG_FILE && echo $LINE >> $LOG_FILE        
fi

# MPD
if [ ! -d $DIRMPD ]
    then
        mkdir $DIRMPD
        cp ~/.mpd/config $DIRMPD -Rv >> $LOG_FILE && echo $LINE >> $LOG_FILE        
fi

# NCMPCPP
if [ ! -d $DIRNCM ]
    then
        mkdir $DIRNCM
        cp ~/.ncmpcpp/config $DIRNCM -Rv >> $LOG_FILE && echo $LINE >> $LOG_FILE
fi


# Mplayer
if [ ! -d $DIRMPL ]
    then
        mkdir $DIRMPL
        cp ~/.mplayer/config $DIRMPL -Rv >> $LOG_FILE && echo $LINE >> $LOG_FILE
fi


# Newsbeuter RSS
if [ ! -d $DIRRSS ]
    then
        mkdir $DIRRSS
        cp ~/.newsbeuter/config $DIRRSS -Rv >> $LOG_FILE
        cp ~/.newsbeuter/cache.db $DIRRSS -Rv >> $LOG_FILE && echo $LINE >> $LOG_FILE
fi

# Samba
if [ ! -d $DIRSMB ]
    then
        mkdir $DIRSMB
        sudo cp /etc/samba/smb.conf $DIRSMB -Rv >> $LOG_FILE && echo $LINE >> $LOG_FILE
fi


# SSH
if [ ! -d $DIRSSH ]
    then
        mkdir $DIRSSH
        sudo cp /etc/ssh/sshd_config $DIRSSH -Rv >> $LOG_FILE && echo $LINE >> $LOG_FILE
fi


# System
if [ ! -d $DIRSYS ]
    then
        mkdir $DIRSYS
        sudo cp /etc/fstab $DIRSYS -Rv >> $LOG_FILE
        sudo cp /etc/locale.conf $DIRSYS -Rv >> $LOG_FILE
        sudo cp /etc/pacman.conf $DIRSYS -Rv >> $LOG_FILE
        sudo cp /etc/resolv.conf $DIRSYS -Rv >> $LOG_FILE && echo $LINE >> $LOG_FILE
fi

# Slim
if [ ! -d $DIRSLIM ]
    then
        mkdir $DIRSLIM
        sudo cp /etc/slim.conf $DIRSLIM -Rv >> $LOG_FILE && echo $LINE >> $LOG_FILE
fi

# Comprimiendo todo el directorio.
cd $MAIN
tar czvf "$DATE.tar.gz" "$DATE"

# Envia el archivo comprimido a nuestro owncloud:
cp $DATE.tar.gz $DIRSAVE

# Eliminando directorio una vez comprimido.
rm -fR "$MAIN"

echo "                  #######################"
echo "                  ##  BACKUP REALIZADO ##"
echo "                  #######################"
     
# Fin del script.
exit 0 
