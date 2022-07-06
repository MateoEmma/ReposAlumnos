import random as r
class Juego_Pila(object):
    def __init__(self):
        self.__list = []

    def crear_pila(self):
        self.__list= list(range(1,21))

    def Jugar(self):
        self.crear_pila()
        self.__desordenar_lista
        calificacion = 10
        nro = 20
        lista_esperados= ['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20']
        while nro < 19:
            nro = input('ingrese la cantidad de elementos')
            if nro not in lista_esperados:
                nro = 20
            else:
                nro = int(nro)
        print('Pila original:')
        self.__mostrarpila()
        suma = 0
        while nro > 0:
            suma += self.__pop()
            nro -= 1

        print('Pila  Obtenida')
        self.__mostrarpila()
        nro = self.__size()
        print('Con esa cantidad de elementos se sumo:', suma)
        if suma > 50:
            print('Game Over')
        else:
            while suma <= 50:
                suma += self.__pop()
                if suma <= 50:
                    calificacion -= 1
            print('Winner!!!, scoring:', calificacion)

    def __desordenar_lista(self):
        for i in range(0, 20):
            aux = self.__list[i]
            i_rand = randint(0, 19)
            self.__list[i] = self.__list[i_rand]
            self.__list[i_rand] = aux

    def __mostrarpila(self):
        print(self.__list)

    def __pop(self):
        return self.__list.pop()

    def __size(self):
        return len(self.__list)

     

i = Juego_Pila()
i.Jugar()

