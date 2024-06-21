// script per gestione carrello con ajax
    function loadData(id,taglia){
        var xml = new XMLHttpRequest();
        xml.onreadystatechange = function(){
        if(xml.readyState === 4 && xml.status === 200){
            const gridContainer = document.getElementsByClassName("grid-container")[0];
            gridContainer.innerHTML = "";
            const prodotti = JSON.parse(xml.responseText);
            prodotti.forEach(prodotto => { //scorro tutti i prodotti
                gridContainer.innerHTML += addProdotto(prodotto);
            })
        }
    }

    xml.open("POST","removeByCart-servlet", true);
        xml.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xml.send("idProdotto="+encodeURIComponent(id)+"&taglia="+encodeURIComponent(taglia));
}
    //alt 96 (Bloc Num)
    function addProdotto(prodotto){ //tutto il codice html che si deve aggiornare dopo l'eliminazione
    let result =  `<div class="card scale-in-center">
        <div class="img">
             <img src="${prodotto.urlImmagine}" alt="">
        </div>
        <div class="content">
        <h4 class="small-text">${prodotto.nome}</h4> `

    prodotto.taglieQuantita.forEach(element => {
    result += `<div class="sizes">
        <p><span>Size</span>: ${element["taglia"]}, <span>Amount</span>: ${element["quantita"]}</p>

        <button onclick="loadData(${prodotto.id}, ${element[0]})">
             <img src="img/trash.svg" alt="arrow">
        </button>
        </div>`
    });


    result += `<h2 class="normal-text">€ ${prodotto.prezzo}</h2>
    </div>
    </div>`
        return result;
}

