package model;

import java.util.HashMap;
import java.util.Map;

public class Prodotto {
    int id;
    String nome, tipologia, squadra, produttore, collezione, urlImmagine;
    Double prezzo;

    // un prodotto può avere più taglie (String) ad ognuna delle quali
    // sono associate delle quantità (Integer)
    Map<String, Integer> taglieQuantita = new HashMap<>();

    public int getId_Prodotto() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getTipologia() {
        return tipologia;
    }

    public void setTipologia(String tipologia) {
        this.tipologia = tipologia;
    }

    public String getSquadra() {
        return squadra;
    }

    public void setSquadra(String squadra) {
        this.squadra = squadra;
    }

    public Double getPrezzo() {
        return prezzo;
    }

    public void setPrezzo(Double prezzo) {
        this.prezzo = prezzo;
    }

    public String getProduttore() {
        return produttore;
    }

    public void setProduttore(String produttore) {
        this.produttore = produttore;
    }

    public String getCollezione() {
        return collezione;
    }

    public void setCollezione(String collezione) {
        this.collezione = collezione;
    }

    public String getUrlImmagine() {
        return urlImmagine;
    }

    public void setUrlImmagine(String urlImmagine) {
        this.urlImmagine = urlImmagine;
    }

    public Map<String, Integer> getTaglieQuantita() {
        return taglieQuantita;
    }

    public void setTaglieQuantita(Map<String, Integer> taglieQuantita) {
        this.taglieQuantita = taglieQuantita;
    }
}
