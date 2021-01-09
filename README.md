# Implementazione dell'algortimo di Louvain
## Operazioni preliminari
Inserire nella directory *input* un file di tipo .txt contenente il grafo da analizzare.

Il file deve contenere, per ogni nodo del grafo, una coppia di numeri che raffiguri le sue coordinate nel piano cartesiano, si suppone che tutte le coppie di nodi siano collegate e che il peso dell'arco di una coppia di nodi sia il reciproco del quadrato della distanza euclidea dei nodi.
## Impostazione della sezione parametri nel main
Prima di eseguire la demo è necessario configurare la sezione parametri del file *main.m*, in particolare:

*name*: il nome del file di tipo .txt da cui vengono prese le coordinate in input, senza estensione

*random*: se true riordina in modo casuale i nodi in ingresso

*trials*: imposta quante volte viene iterato l'algoritmo, alla fine viene mostrato solo il risultato con modularità più alta

*maxDistance*: imposta qual è la distanza massima tra due nodi affinché venga creato un arco tra di loro, se è 0 tutte le coppie di nodi sono connesse
## Impostazione della sezione parametri in ImageCreator
È possibile modificare alcune caratteristiche delle immagini modificando i valori nella sezione parametri di *ImageCreator.m*, in particolare:

*standardX*: imposta la larghezza in pixel dell'immagine in output

*nodeDimension*: Imposta la dimensione del lato del quadrato con cui viene rappresentato un nodo.