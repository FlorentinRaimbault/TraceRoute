#!/bin/bash
# Florentin Raimbault
# RT2-A1 - M3102 - Script Traceroute

TTL=1																											#Déclaration de la variable TTL
IP=${1:?"Veuillez fournir l'adresse à tester en tant qu'argument"}												#Affectation de la valeur rentrée en argument à la variable addresse IP				
opt=("-I" "-U -p 53" "-T -p 443" "-T -p 22" "-T -p 25" "-T -p 80")												#Définition des différentes options utilisées

for TTL in $(seq 1 29)																							#Démarrage de notre boucle principale pour tester 30 routeurs au maximum
do  																																																				#Incrémentation du TTL
	for i  in "${opt[@]}"; do																					#Démarage de notre boucle testant les différentes options en fonction de la compatibilité avec les routeurs
		echo "Lancement de la commande : traceroute -n $i -q1 -f $TTL $IP"  									#Affichage sur le terminal qu'on va éxecuter une commande traceroute
		res=`traceroute -n $i -w2 -q1 -m $TTL -f $TTL $IP | sed -n "2p" | sed "s/ //" | cut -d" " -f3,2`			#Récupération de l'addresse IP du routeur testé	dans une variable
		echo "$res"																																
		if [ "$res" != '*' ]; then																				#Si on obtient une addresse IP,
			echo "$res" >> /root/res.txt																		#Alors on enregistre le résultat dans le fichier txt
			break
		else 
			$res = "Unreable router n° $TTL"																	#Sinon on remplace le texte par une message d'erreur
		fi
		echo "$res" >> /root/res.txt																			#Puis on enregsitre le résultat dans le fichier res.txt																		
done																									
done 
