function manageFilters(tipologia, lastTaglia, lastCollezione, lastProduttore) {
    var xhttp = new XMLHttpRequest();

    xhttp.onreadystatechange = function() {
        if (this.readyState === 4 && this.status === 200) {

            // prendi il json scritto dalla servlet
            const data = JSON.parse(this.responseText);
            const taglie = data.taglie;
            const collezioni = data.collezioni;
            const produttori = data.produttori;

            // mostra select
            const selects = document.querySelectorAll(".filters select");
            selects.forEach(select => {
                select.classList.remove("hidden");
            });

            // se non è maglia, nascondi la select della squadra
            if (tipologia !== "Maglia" && tipologia !== "All") {
                document.getElementById("selectSquadra").classList.add("hidden");
            }

            // aggiorna taglie
            const selectTaglia = document.getElementById("selectTaglia");
            selectTaglia.innerHTML =
                '<option value="" disabled selected>Taglia</option>';

            taglie.forEach(taglia => {
                const option = document.createElement("option");
                option.value = taglia.taglia;
                option.text = taglia.taglia;
                if (taglia.taglia === lastTaglia) option.selected = true;
                selectTaglia.appendChild(option);
            });

            // aggiorna produttori
            const selectProduttore = document.getElementById("selectProduttore");
            selectProduttore.innerHTML =
                '<option value="" disabled selected>Produttore</option>';

            produttori.forEach(produttore => {
                const option = document.createElement("option");
                option.value = produttore.nome;
                option.text = produttore.nome;
                if (produttore.nome === lastProduttore) option.selected = true;
                selectProduttore.appendChild(option);
            });

            // aggiorna collezioni
            const selectCollezione = document.getElementById("selectCollezione");
            selectCollezione.innerHTML = '<option value="" disabled selected>Collezione</option>';

            collezioni.forEach(collezione => {
                const option = document.createElement("option");
                option.value = collezione.nome;
                option.text = collezione.nome;
                if (collezione.nome === lastCollezione) option.selected = true;
                selectCollezione.appendChild(option);
            });

            updateCards();
        }
    }


        // apri connessione ed invia richiesta alla servlet
    xhttp.open("GET", `showFilter-servlet?tipologia=${tipologia}`, true);
    xhttp.send();
}

function updateCards() {
    var xhttp = new XMLHttpRequest();
    const container = document.querySelector(".grid-container");

    // prendi i valori di tutte le select
    const tipologia = document.getElementById("selectTipologia").value || "";
    const taglia = document.getElementById("selectTaglia").value || "";
    const produttore = document.getElementById("selectProduttore").value || "";
    const collezione = document.getElementById("selectCollezione").value || "";
    const squadra = document.getElementById("selectSquadra").value || "";
    const prezzo = document.getElementById("selectPrezzo").value || "";

    container.innerHTML = '';

    xhttp.onreadystatechange = function() {
        if (this.readyState === 4 && this.status === 200) {

            const prodotti = JSON.parse(this.responseText);

            // crea card per ogni prodotto
            prodotti.forEach(prodotto => {
                container.innerHTML += generateCard(prodotto);
            });
        }
    };

    // query string con tutti i valori delle select
    const queryString =
        `tipologia=${encodeURIComponent(tipologia)}` +
        `&taglia=${encodeURIComponent(taglia)}` +
        `&produttore=${encodeURIComponent(produttore)}` +
        `&collezione=${encodeURIComponent(collezione)}` +
        `&squadra=${encodeURIComponent(squadra)}` +
        `&prezzo=${encodeURIComponent(prezzo)}`;

    xhttp.open("GET",
        `updateCards-servlet?${queryString}`,
        true);
    xhttp.send();
}

function generateCard(prodotto) {

    // template literal

    return `
        <div class="card scale-in-center">
            <img src="${prodotto.urlImmagine}" alt="">
            <h4 class="small-text">${prodotto.nome}</h4>
            <h2 class="normal-text">€ ${prodotto.prezzo}</h2>
            <form action="overview-servlet" method="post">
                <input name="idProdotto" value="${prodotto.id}" type="hidden">
                <button>
                    <img src="img/arrow-right-circle.svg" alt="arrow">
                </button>
            </form>
        </div>
    `;
}

function searchCards(queryString){
    var xhttp = new XMLHttpRequest();

    // svuota container
    const container = document.querySelector(".grid-container"); // prende solo il primo
    container.innerHTML = "";

    // prendi classe dei filtri
    const filters = document.querySelector(".filters");

    // se l'utente cerca una stringa vuota
    if (queryString === "") {
        container.innerHTML = "No results..."

        // adegua design
        if (filters != null && filters.classList.contains("none")) {
            filters.classList.remove("none")
            container.style.marginTop = "0";
        }

        return
    }

    xhttp.onreadystatechange = function () {
        if(xhttp.readyState === 4 && xhttp.status === 200){

            // ottieni ciò che è stato scritto dalla servlet nella risposta
            const prodotti = JSON.parse(this.responseText);

            // adegua e nascondi filtri
            if (filters != null && !filters.classList.contains("none")) {
                filters.classList.add("none");
                container.style.marginTop = "20vh";
            }

            // se non ci sono prodotti per quella ricerca
            if (prodotti.length === 0) {
                container.innerHTML = "No results..."
                return
            }

            // per ogni prodotto crea una card e mettila nel containe
            prodotti.forEach(prodotto => {
                container.innerHTML += generateCard(prodotto);
            });
        }
    }

    // prepara chiamata asincrona alla servlet
    xhttp.open("GET","searchBar-servlet?queryString="+queryString, true)
    xhttp.send();
}