#!/bin/bash
view_menu_recommendations(){

    RESOUCES=$(whiptail --title "$TITLE_APP" --checklist \
                "SE ESSA FOR A PRIMEIRA VEZ QUE EXECULTA ESSE SCRIPT, RECOMENDO QUE EXECUTE TODAS ESSAS OPÇÕES!" 12 105 4 \
                "Update" "Lê e atualizando os pacotes do sistema" OFF \
                "Upgrade" " Atualizando a distribução do sistema." OFF \
                "Recursos" "Instala alguns pacotes que serão necessários para realizar nossa configuração." OFF 3>&1 1>&2 2>&3
            )
    status=$?
    if [ $status = 0 ]
    then

        if  echo "$RESOUCES" | grep -q "Update"; then 
            fn_update_upgrade
            
        fi

        if  echo "$RESOUCES" | grep -q "Upgrade"; then 
            fn_upgrade_dist
        fi

        if  echo "$RESOUCES" | grep -q "Recursos"; then 
            fn_install_resources
        fi
        
        view_menu
    else
        view_cancel 1
    fi

}
