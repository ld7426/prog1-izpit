def dodaj_korak(cena, korak, pot): #prekopirano iz skripte, ker se mi je zdela podobna naloga, vendar me negativna stevila matrajo
    cena_poti, koraki_poti = pot
    return cena + cena_poti, korak + koraki_poti

pustni_torek = [
    [10, 20, -30, -100, 9],
    [0, 0, 50, 50, 2],
    [10, 20, 300, -10, 0],
    [40, 30, -200, -10, 5],
]

def najdrazja_pot(mat): #tole ne uposteva da ne sme biti nikoli negativno bobov
    m, n = len(mat), len(mat[0])
    poti = [[None for _ in vrstica] for vrstica in mat]
    poti[-1][-1] = (mat[-1][-1], "o")
    for j in range(n - 2, -1, -1):
        poti[-1][j] = dodaj_korak(mat[-1][j], "→", poti[-1][j + 1])
    for i in range(m - 2, -1, -1):
        poti[i][-1] = dodaj_korak(mat[i][-1], "↓", poti[i + 1][-1])
        for j in range(n - 2, -1, -1):
            poti[i][j] = min(
                dodaj_korak(mat[i][j], "↓", poti[i + 1][j]),
                dodaj_korak(mat[i][j], "→", poti[i][j + 1])
            ) 
    return poti
	
def najvec_bobov(matrika):
	m, n = len(matrika), len(matrika[0])
	potidodesnospodaj = najdrazja_pot(matrika)
	potidolevozgoraj = najdrazja_pot([[matrika[-i-1][-j-1] for j in range(n)] for i in range(m)])
	
	maxdodesnospodaj =(
	for i in potidodesnospodaj:
	
	return potidodesnospodaj,"\n", potidolevozgoraj

print(najvec_bobov(pustni_torek))