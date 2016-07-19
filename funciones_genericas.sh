#
## Inventos creativos, quizás existen mejores formas de resolverlo.
#

#### Genera un string aleatorio, puede ser asignado a un archivo temporal. ####

LETTERS=("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" \
	     "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" \
	     "Z" "MA" "PA" "TI" "CA" "SA" "MU" "LA" "EL" "LOS" \
	     "SI" "MI" "NO" "MO" "DA" "HI" "MU" "FE" "HU" "GE" "DI" \
	     "GUA" "FU" "RE" "EX" "RO" "ER" "CO" "LL" "PH" "ZO" \
	     "LI" "FA" "TE" "ES")

function my_seconds () {
    echo $(( ( RANDOM % 60 ) + 1 ))
}

function pseudo-random-string () {
    FIRST_FONT=$(date +'%m%d%y.%H%M%S')
    SECOND=$(my_seconds)
    NUMBER_TO_LETTER=$(echo "${LETTERS[$SECOND]}")
    SECOND_FONT=$(echo "$RANDOM")
    STATIC_STRING=$(echo "${NUMBER_TO_LETTER}${SECOND_FONT}" | sha512sum)
    RANDOM_STRING=$(echo ${STATIC_STRING:0:$SECOND})
    echo "${FIRST_FONT}.${RANDOM_STRING}"
}

CAPTURE_RANDOM_STRING=$(pseudo-random-string) #esta variable puede ser pasada a un archivo temporal.


#### Chequear si eres root, lo muestra en pantalla y sale del script.

function check-root () {
    WHO=$(whoami)

    if [ $WHO != "root" ]; then
	echo "You need root privileges."
	sleep 3
	exit 1
    fi
}


#### porcentaje del "cpu", ver información sobre /proc/stat. Puede usarse dentro de una función tipo `high-cpu-use'

function cpu-percent () {
    grep 'cpu' /proc/stat | \
	awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage}'
}
