#include <cstdio> 
#include <iostream>
#include <fstream>
#include <chrono>
#include <ctime>
#include "dependencies/include/libpq-fe.h"

#define PG_HOST "127.0.0.1" //oppure "localhost" o "postgresql" 
#define PG_USER "postgres" //il vostro nome utente
#define PG_DB "APOLLON" //il nome del database 
#define PG_PASS "" //la vostra password
#define PG_PORT 5432

using namespace std;


//UTILITY
string getTodayDate(){
    std::time_t t = std::time(0);   
    std::tm* now = std::localtime(&t);
    string date = to_string(now->tm_year + 1900) + '-' + to_string(now->tm_mon + 1) + '-' + to_string(now->tm_mday);
    return date; 
}
// MENU
int selectQuery() {
	int a=0;
	while(a==0) {
        cout << "1- Il nome delle etichette discografiche che producono artisti vincitori di almeno due dischi d’oro o di platino, con i relativi artisti. \n";
        cout << "2- L’album di un’artista del genere POP con più brani premiati dalla discografia. \n";
        cout << "3- Artisti americani nati prima dell’11 Novembre dell’anno 2000 con più di un brano registrato. \n";
        cout << "4- Gli utenti con il numero di artisti totali ascoltati per ciascun genere musicale. \n";
        cout << "5- Gli utenti che hanno un abbonamento Premium e hanno aggiunto alle proprie playlist almeno una canzone di un determinato artista a una playlist privata\n";
        cout << "6- Vincoli \n";
		cout << "7- Inserimento di un nuovo brano \n";
		cout << "Inserire il numero della query desiderata (-1 per uscire): ";
		if(!(cin >> a)) {
			cin.clear();
			cin.ignore(10000,'\n');
			cout << "invalid input error try again \n";
		}

	}
	return a;
}

int selectVincolo() {
	int a=0;
	while(a==0) {
		
        cout << "1- Utenti che ascoltano due brani contemporaneamente \n";
        cout << "2- Ascolti il cui l’ora di fine risulta maggiore dell’ora di inizio sommata alla durata del brano \n";
		cout << "Inserire il numero della query desiderata (-1 per uscire): ";
		if(!(cin >> a)) {
			cin.clear();
			cin.ignore(10000,'\n');
			cout << "invalid input error try again \n";
		}

	}
	return a;
}

//QUERY
void checkResults(PGresult* res, const PGconn* conn) {
	if (PQresultStatus(res) != PGRES_TUPLES_OK) {
		cout << "Risultati inconsistenti! \n" << PQerrorMessage(conn) << endl;
		PQclear(res); 
		exit(1);
	} 
}

void executeQuery(PGconn * conn, const char* q){
	PGresult *res;
	res = PQexec(conn, q);
	checkResults(res, conn);
	int tuple = PQntuples(res);
	int campi = PQnfields(res); 
	// Stampo intestazioni
	for(int i=0; i<campi; ++i){
		cout << left << setw(25) << PQfname(res,i); 
	}
	cout << endl; 
	// Stampo i valori selezionati 
	for(int i=0; i<tuple;++i){
		for (int j = 0; j < campi; ++j){
			cout << left << setw(25) << PQgetvalue(res, i, j);
		}
		cout << endl;
	}	
	cout << endl;
	cout << endl;
	cout << endl;
	cout << endl;
	PQclear(res);
	
}

void printArtists(PGconn * conn){
    const char* query = "SELECT cf, nome, cognome, nomedArte FROM ARTISTA";
    executeQuery(conn, query);
}

void premiumUsersWithPlaylistContainingSongsFrom(PGconn * conn){
	string codiceFiscale;
	printArtists(conn);
	cout << "Inserisci il codice fiscale dell'artista: ";
    cin >> codiceFiscale;
    // Preparazione della query
	const char* query = "SELECT UTENTE.nome AS nome_utente, SUONA.cfArtista AS artista_aggiunto, PLAYLIST.nome AS playlist, BRANO.titolo AS brano_aggiunto FROM UTENTE JOIN ABBONAMENTO ON UTENTE.abbonamento = ABBONAMENTO.id JOIN PLAYLIST ON UTENTE.id = PLAYLIST.idutente JOIN CONTIENE ON PLAYLIST.id = CONTIENE.idplaylist JOIN BRANO ON CONTIENE.idbrano = BRANO.id JOIN SUONA ON BRANO.id = SUONA.idbrano WHERE ABBONAMENTO.premium = TRUE AND PLAYLIST.privata = TRUE AND SUONA.cfArtista = $1";  // Parametro codice fiscale

	// Preparazione dello statement
	PGresult* stmt = PQprepare(conn, "", query, 1, nullptr);
	if (PQresultStatus(stmt) != PGRES_COMMAND_OK) {
		std::cerr << "Errore durante la preparazione dello statement: " << PQerrorMessage(conn) << std::endl;
		PQclear(stmt);
		PQfinish(conn);
					
	}

	// Esecuzione dello statement con il codice fiscale inserito dall'utente come parametro
	const char* paramValues[1] = {codiceFiscale.c_str()};
	const int paramLengths[1] = {static_cast<int>(codiceFiscale.length())};
	const int paramFormats[1] = {0};
	PGresult* res = PQexecPrepared(conn, "", 1, paramValues, paramLengths, paramFormats, 0);

	checkResults(res, conn);
	int tuple = PQntuples(res);
	int campi = PQnfields(res); 
	// Stampo intestazioni
	for(int i=0; i<campi; ++i){
		cout << left << setw(25) << PQfname(res,i); 
	}
	cout << endl; 
	// Stampo i valori selezionati 
	for(int i=0; i<tuple;++i){
		for (int j = 0; j < campi; ++j){
			cout << left << setw(25) << PQgetvalue(res, i, j);
		}
		cout << endl;
	}	
	cout << endl;
	cout << endl;
	cout << endl;
	cout << endl;
	PQclear(res);
    PQclear(stmt);
}



void insertSongWithArtist(PGconn * conn){
    string idBrano, titolo, cfArtista;
    int durata;
    double guadagnoSecondo;
    string dataRilascio = getTodayDate();

    // Acquisizione dei dati dall'utente
    cout << "Inserisci l'id del brano: ";
    cin >> idBrano;
    cout << "Inserisci il titolo del brano: ";
    cin.ignore();
    getline(std::cin, titolo);
    cout << "Inserisci la durata del brano: ";
    cin >> durata;
    cout << "Inserisci il guadagno per secondo: ";
    cin >> guadagnoSecondo;
	printArtists(conn);
    cout << "Inserisci il codice fiscale dell'artista: ";
    cin >> cfArtista;

    // Inizio della transazione
    PGresult *beginRes = PQexec(conn, "BEGIN");
    if (PQresultStatus(beginRes) != PGRES_COMMAND_OK)
    {
        std::cerr << "Errore durante l'inizio della transazione: " << PQerrorMessage(conn) << std::endl;
        PQclear(beginRes);
        PQfinish(conn);
        return;
    }
    PQclear(beginRes);

    // Creazione e esecuzione della prima query
    std::string query1 = "INSERT INTO BRANO(id, titolo, durata, guadagnoSecondo, dataRilascio) "
                         "VALUES ($1, $2, $3, $4, $5)";
    const char *params1[5] = {idBrano.c_str(), titolo.c_str(), std::to_string(durata).c_str(),
                              std::to_string(guadagnoSecondo).c_str(), dataRilascio.c_str()};
    PGresult *res1 = PQexecParams(conn, query1.c_str(), 5, nullptr, params1, nullptr, nullptr, 0);
    if (PQresultStatus(res1) != PGRES_COMMAND_OK)
    {
        std::cerr << "Errore durante l'esecuzione della prima query: " << PQerrorMessage(conn) << std::endl;
        PQclear(res1);
        PQfinish(conn);
        return;
    }
    PQclear(res1);

    // Creazione e esecuzione della seconda query
    std::string query2 = "INSERT INTO SUONA(idBrano, cfArtista) VALUES ($1, $2)";
    const char *params2[2] = {idBrano.c_str(), cfArtista.c_str()};
    PGresult *res2 = PQexecParams(conn, query2.c_str(), 2, nullptr, params2, nullptr, nullptr, 0);
    if (PQresultStatus(res2) != PGRES_COMMAND_OK)
    {
        std::cerr << "Errore durante l'esecuzione della seconda query: " << PQerrorMessage(conn) << std::endl;
        PQclear(res2);
        PQfinish(conn);
        return;
    }
    PQclear(res2);

    // Esecuzione del COMMIT per confermare le modifiche
    PGresult *commitRes = PQexec(conn, "COMMIT");
    if (PQresultStatus(commitRes) != PGRES_COMMAND_OK)
    {
        std::cerr << "Errore durante l'esecuzione del COMMIT: " << PQerrorMessage(conn) << std::endl;
        PQclear(commitRes);
        PQfinish(conn);
        return;
    }
    PQclear(commitRes);
}


int main (int argc, char **argv) { 
    //PGconn * conn;
    //conn = PQconnectdb ("");
    char conninfo [250];
    

    sprintf(conninfo, "user=%s password=%s  hostaddr=%s port=%d dbname=%s", PG_USER, PG_PASS, PG_HOST, PG_PORT, PG_DB);

    PGconn * conn = PQconnectdb(conninfo);
    if(PQstatus(conn) != CONNECTION_OK){
    cout<<"Errore di connessione "<<PQerrorMessage(conn)<<"\n";
    PQfinish(conn); 
    exit(1);
    } else{
       cout<<"Connessione avvenuta correttamente \n"; 
    }
    
    char* q1 = " SELECT DISTINCT ETICHETTA.nome AS etichetta, T.nome, cognome, nomedArte FROM ETICHETTA JOIN (SELECT contratto, nome, cognome, nomedArte FROM ARTISTA JOIN SUONA ON ARTISTA.cf = SUONA.cfArtista JOIN VINCITA ON VINCITA.idBrano = SUONA.idBrano WHERE codPremio = 'DORO' OR codPremio = 'DPLA') AS T ON T.contratto = ETICHETTA.pIVA";
    char* q2 = " SELECT idAlbum, numPremiAlbum FROM( SELECT RACCOGLIERE.idAlbum, SUM(numPremi) AS numPremiAlbum FROM ( SELECT RILASCIO.idAlbum FROM GENERE JOIN RILASCIO ON  genere.cf = RILASCIO.cfArtista WHERE GENERE.nome='POP') AS AlbumPOP JOIN RACCOGLIERE ON RACCOGLIERE.idAlbum = AlbumPOP.idAlbum JOIN (SELECT COUNT(codPremio) AS numPremi, idBrano FROM VINCITA JOIN PREMIO ON VINCITA.codPremio = PREMIO.codice WHERE numeroStream IS NOT NULL GROUP BY idBrano) AS ConteggioPremi ON RACCOGLIERE.idBrano = ConteggioPremi.idBrano GROUP BY RACCOGLIERE.idAlbum ) AS temp ORDER BY  numPremiAlbum DESC LIMIT 1";
    char* q3 = " SELECT ARTISTA.nome, ARTISTA.cognome, ARTISTA.nomedarte, COUNT( SUONA.idbrano) AS NumeroBrani FROM ARTISTA JOIN SUONA ON ARTISTA.cf = SUONA.cfartista WHERE ARTISTA.datanascita <= '2000-02-11' AND ARTISTA.nazionalita = 'US' GROUP BY ARTISTA.cf HAVING COUNT(SUONA.idbrano) > 1";
    char* q4 = " SELECT DISTINCT UTENTE.nome,UTENTE.cognome, GENERE.nome AS Genere, COUNT (DISTINCT ARTISTA.cf) AS NumeroArtistiAscoltati FROM UTENTE JOIN ASCOLTO ON UTENTE.id =ASCOLTO.idUtente JOIN BRANO ON ASCOLTO.idBrano = BRANO.id JOIN SUONA ON BRANO.id = SUONA.idBrano JOIN ARTISTA ON SUONA.cfartista = ARTISTA.cf JOIN GENERE ON ARTISTA.cf = GENERE.cf GROUP BY UTENTE.id,GENERE.nome";
    char* v1 = " SELECT A1.idUtente, A1.idBrano AS brano1, A2.idBrano AS brano2 FROM ASCOLTO A1 JOIN ASCOLTO A2 ON A1.idUtente = A2.idUtente WHERE A1.idBrano <> A2.idBrano AND ((A1.oraInizio >= A2.oraInizio AND A1.oraInizio < A2.oraFine) OR (A2.oraInizio >= A1.oraInizio AND A2.oraInizio < A1.oraFine))";
    char* v2 = " SELECT * FROM ASCOLTO JOIN BRANO ON ASCOLTO.idBrano = BRANO.id WHERE ASCOLTO.oraFine > ASCOLTO.oraInizio + INTERVAL '1 second' * BRANO.durata";
    bool end=false;
	while(end!=true) {
		switch(selectQuery()) {
			case -1:{
				end=true;
				break;
			}	
			case 1:{
				executeQuery(conn, q1);
				break;
			}	
			case 2:{
				executeQuery(conn, q2);
				break;
			}	
			case 3:{
				executeQuery(conn, q3);
				break;
			}
			case 4:{
				executeQuery(conn, q4);
				break;
			}
			case 5:{
				premiumUsersWithPlaylistContainingSongsFrom(conn);
				break;
			}
			case 6:{
				switch(selectVincolo()) {
					case -1:
						end=true;
						break;
					case 1:
						executeQuery(conn, v1);
						break;
					case 2:
						executeQuery(conn, v2);
						break;
				}		
				break;
			}
			case 7:{
				insertSongWithArtist(conn);
                break;	
			}	
			default: 
				cout << "invalid input number \n";
		}
	}

    PQfinish(conn);
    return 0; 
}






