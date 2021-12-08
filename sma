
def paquet():
    s = ''
    paquet = []
    j = 0
    l = ["As","Roi", "Dame", "Valet"]
    type = ["carreaux", "trèfles", "coeurs", "piques"]
    while j < 4:
        for i in range(2,11):
            s = str(i) + " de "+ type[j]
            paquet.append(s)
        j += 1    
    j = 0
    i = 0
    while j< len(type) :  
        for i in range(len(l)):
            s = l[i]+ " de "+ type[j]
            paquet.append(s)  
        j += 1    
    return paquet
def valeurCarte(carte):
    l = (carte.split(' '))
    nombre = (carte.split(' '))[0]
    if nombre in '12345678910':
        nombre = int((carte.split(' '))[0])
        while nombre >10:
            nombre = int(input("Entrer une valeur exacte de la carte: "))
    if nombre in range(2,11):
        valeur = nombre
    elif str(nombre).lower() in ["roi", "dame", "valet"]:
        valeur = 10
    elif str(nombre).lower() == "as":
        valeur = 2
        while valeur not in [1, 11]:
            valeur = int(input("Quelle valeur souhaitez-vous? (1 ou 11?) ")) 
    l[0] = str(nombre)
    carte = ' '.join(l)
    s = "La valeur de la carte " + "' " + carte + " ' est: " + str(valeur)  
    return valeur  
#print(valeurCarte("23 de trèfle"))    
def initPioche(n):
    import random
    pioche = []
    i = 0
    while i < n:
        pioche.extend(paquet())
        i += 1
    i = 0
    while i < len(pioche):
        a = random.randint(0,len(pioche)-1)
        b = random.randint(0,len(pioche)-1)
        temp = pioche[b]   
        pioche[b] = pioche[a]
        pioche[a] = temp
        i += 1
    return pioche
#print(initPioche(3))    
def piocheCarte(pioche, x):
    import random
    i = 0
    l = []
    while i < x:
        a = random.randint(0, len(pioche)-1)
        l.append(pioche[a])
        pioche.pop(a)
        i += 1
    return l
#print(piocheCarte(initPioche(4), 7))        
def initJoueurs(n):
    Joueurs = []
    for i in range(1,n + 1):
        a = input("Joueur " + str(i) + ": ")
        Joueurs.append(a)
    return Joueurs
#print(initJoueurs(4))        
def initScores(joueurs):
    dictionnaire = {}
    for i in range(len(joueurs)):
        dictionnaire[joueurs[i]] = 0
    return dictionnaire
#print(initScores(["SAL", "ADAM", "LISE"]))

def premierTourjoueurs(joueurs):
    score_joueurs = initScores(joueurs)
    
    for i in range(len(joueurs)):
        for j in range(2):
            s = piocheCarte(initPioche(1), 2)
            score_joueurs[joueurs[i]] += valeurCarte(s[j])
            
    return score_joueurs
#print(premierTourjoueurs(["Hi", "Sam", "ASJZ"]))
def gagnant(scores):
    joueur = list(scores.keys())
    max = 1
    gagnant = ''
    print(joueur)
    for i in range(len(joueur)):
        if  max<=(scores[joueur[i]][joueur[i]])<=21 :
            max = (scores[joueur[i]][joueur[i]])
            gagnant = joueur[i]
    s = "le gagnant est : " ,gagnant , " avec le score: " , str(max)
    print(s)
    return gagnant
#print(gagnant(premierTourjoueurs(initJoueurs(3))))        
def continuer():
    oui =["oui","yes","continue","continuer","go"]
    non = ["stop","non","no","clear","pas"]
    a = input("Tu veux continuer ou pas? \n")
    while (a not in oui) and (a not in non):
        a = input("Tu veux continuer ou pas?(Je suis qu'un robot, j'ai pas compris :) \n")
        pass
    if a.lower() in oui:
        return True
    elif a.lower() in non:
        return False
#print(continuer())    
def tourJoueur(j):
    
    num_tour = 1
    score = initScores(j) 
    score_joueurs = 0
    continuer = False         
    i = 0        
    while i<1:
        j = j[0]
        continuer = True
        i += 1
    print("Nom du joueur: " + j + "\n")    
    while continuer == True:
        scoree = "Votre score est : " + str(score[j]) + "\n"
        print("Le tour Numéro "+ str(num_tour) + "\n")
        print(scoree)
        if score == 21:
            print("You win")
            break
        if score[j] > 21:
            print("You lose")
            break        
        oui =["oui","yes","continue","continuer","go"]
        non = ["stop","non","no","clear","pas"]
        a = input("Tu veux continuer ou pas? \n")
        while (a not in oui) and (a not in non):
            a = input("Tu veux continuer ou pas?(Je suis qu'un robot, j'ai pas compris :) \n")
        if a.lower() in oui:
            continuer =  True
        elif a.lower() in non:
            continuer = False     
        for i in range(1):
            s = piocheCarte(initPioche(1), 1)
            score_joueurs = valeurCarte(s[0])          
        score[j] += score_joueurs
        num_tour += 1
    return score     
#print(tourJoueur(["Islam"]))        
def tourComplet(n):   
    scores = {}
    a = initJoueurs(n)
    temp = a
    i = 0
    j = 0
    for i in range(len(a)):
        scores[temp[i]] = tourJoueur([temp[i]])[temp[i]]
        j += 1
    return scores,a   
     
    

def partieComplete(n,a):
    l_joueurs = initJoueurs(a)
    score_final = {}
    victoires = {}
    for i in range(a):
        victoires[l_joueurs[i]] = 0
    for i in range(n):
        round = "Round " + str(i+1)
        print(round)
        b = tourJoueur(l_joueurs)[l_joueurs[0]]
        score_final[l_joueurs[0]] = b
        victoires[l_joueurs[0]] += 1
        l_joueurs.pop(0)
    return victoires 
    return gagnant(score_final)
    d = 0
    while d<1000: 
        g=input("voulez-vous rejouer a ce jeu ? ")
        if g in ["yes","oui","si","bien sur","ok"] :
            score_final1 = {}
            victoires1 = {}
            for i in range(a):
                victoires1[l_joueurs[i]] = 0
            for i in range(n):
                round = "Round " + str(i+1)
                print(round)
                b = tourJoueur(l_joueurs)[l_joueurs[0]]
                score_final1[l_joueurs[0]] = b
                victoires1[l_joueurs[0]] += 1
                l_joueurs.pop(0)
            return victoires1
            return gagnant1(score_final)
    
            d=d+1
        elif g in ["no","non","pas envie"] :
            print("merci d'avoir joue a notre jeu et a la prochaine !")
            break
    
    


a = int(input("Combien de joueurs vont participer a notre jeu ?"))
n = int(input("Combien de tours ?"))
print(partieComplete(n,a))

#i = 0
# while i<1000: 
#    g=input("voulez-vous rejouer a ce jeu ? ")
#    if g in ["yes","oui","si","bien sur","ok"] :
#        n = int(input("Combien de tours ?"))
#       print(partieComplete(n,a))

#        i=i+1
#    elif g in ["no","non","pas envie"] :
#        print("merci d'avoir joue a notre jeu et a la prochaine !")
#       break
