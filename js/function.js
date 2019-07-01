// JavaScript Document

var itemSelectLine = 0;
var selectList;
var newOption;
var containerSelect;
var dataRode;
var selectWeek;
var titleLine = "";
var varEvent;
var objCredit;
var objCondition;
var obj;
var arrayTerm;
//Function get data data base
function getDataSimulators(data) {

	//console.log(obj);
	var xhttp = new XMLHttpRequest();
	xhttp.open("POST", "php/bo/bo_simulator.php", true);
	xhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xhttp.onreadystatechange = function () {
		if (this.readyState === 4 && this.status === 200) {
			if (data === 0) {
				objCredit = JSON.parse(xhttp.responseText);
				//console.log(xhttp.responseText);
				createElementList();
			} else if (data === 1) {
				objCondition = JSON.parse(xhttp.responseText);
				//console.log(objCondition);
			}
		} else {
		}
	};

	xhttp.send(obj);
}
//Function  create  list select  option 
function createElementList() {
	var selectCredit = document.getElementById("credit-line");
	var option = "<option value='0'>Seleccione crédito</option>";
	let aux = document.getElementsByClassName("nice-select")[0];
	let option2 = '<span class="current">Seleccione crédito</span><ul class="list"><li data-value="0" class="option selected focus">Seleccione crédito</li>';
	for (var i = 0; i < objCredit.length; i++) {
		option += "<option value='" + objCredit[i].Sim_id + "'>" + objCredit[i].Sim_name + "</option>";
		option2 += '<li data-value="' + objCredit[i].Sim_id + '" class="option">' + objCredit[i].Sim_name + '</li>';
	}
	option2 += '</ul>';
	selectCredit.innerHTML = option;
	aux.innerHTML = option2;

}
//Function select list credit line
function selectItems(data) {
	itemSelectLine = data;
	//console.log(data);
	if (data != 0) {
		dataRode = document.getElementById("rode");
		var maxMin = sectionMaxMin(data);
		//console.log(maxMin);
		for (var i = 0; i < objCredit.length; i++) {
			if (objCredit[i].Sim_id === data) {
				//alert();
				document.getElementById('description').innerHTML = "<p>" + objCredit[i].Sim_description + "</p>";
				document.getElementById('destination').innerHTML = "<p>" + objCredit[i].Sim_destination + "</p>";
				document.getElementById('conditions').innerHTML = "<p>" + objCredit[i].Sim_conditions + "</p>";
				document.getElementById('benefits').innerHTML = "<p>" + objCredit[i].Sim_benefits + "</p>";
				titleLine = objCredit[i].Sim_name;
				document.getElementById("titleLine").innerHTML = "<span class='d-block'>" + titleLine + "</span>";
				cleanElementsNewline();
				createSelect(maxMin[1], maxMin[0]);
				validaSection(0);
			}
		}
	} else {
		cleanElements();
	}
}
//Function select items list 
function sectionMaxMin(data) {
	arrayTerm = new Array();
	var arrayMaxMin = new Array();
	var aux = new Array();
	for (var i = 0; i < objCondition.length; i++) {
		if (objCondition[i].Sim_id === data) {
			arrayTerm.push(objCondition[i]);
		}
	}

	for (var j = 0; j < arrayTerm.length; j++) {
		arrayMaxMin[0] = arrayTerm[j].Cond_initial;
		arrayMaxMin[1] = arrayTerm[j].Cond_final;
		if (j === 0) {
			aux[0] = parseInt(arrayMaxMin[0]);
			aux[1] = parseInt(arrayMaxMin[1]);
		} else {
			if (parseInt(arrayMaxMin[1]) > aux[1]) {
				aux[1] = parseInt(arrayMaxMin[1]);
			}
			if (parseInt(arrayMaxMin[0]) < aux[0]) {
				aux[0] = parseInt(arrayMaxMin[0]);
			}
		}
	}
	//console.log(aux);
	return aux;
}
//Function create select week
function createSelect(max, mini) {
	selectList = document.getElementById("term");
	var option = "<option value='0'>Número de cuotas</option>";
	let aux = document.getElementsByClassName("nice-select")[1];
	let option2 = '<span class="current">Número de cuotas</span><ul class="list"><li data-value="0" class="option selected focus">Número de cuotas</li>';
	for (var i = mini - 1; i <= max; i++) {
		if (i != 0) {
			option += "<option value='" + i + "'>" + i + "</option>";
			option2 += '<li data-value="' + i + '" class="option">' + i + '</li>';
		}
	}
	option2 += '</ul>';
	selectList.innerHTML = option;
	aux.innerHTML = option2;
}
//Function get rate and nmv
function selectRate(select) {
	var rate;
	var aMaxMin = new Array();
	for (var i = 0; i < arrayTerm.length; i++) {
		aMaxMin[0] = arrayTerm[i].Cond_initial;
		aMaxMin[1] = arrayTerm[i].Cond_final;
		//console.log(aMaxMin);
		if ((select >= parseInt(aMaxMin[0])) && (select <= parseInt(aMaxMin[1]))) {
			rate = arrayTerm[i].Cond_percent;
		}
	}
	//console.log(rate);
	return rate;
}

function validateRate(arrayRate, week) {
	for (var i = 0; i < arrayRate.id.length; i++) {
		var term = arrayRate.id[i].term.split("-");

		if (week >= parseInt(term[0]) && week <= parseInt(term[1])) {
			//console.log(arrayRate.id[i].rate);
			dataRate = arrayRate.id[i].rate;
			//console.log(arrayRate.id[i].nmv);
		}

	}

}
//Function set decimal text	
function setDecimal(element) {
	var textlong = element.value.length;
	var text = element.value.replace(/\./g, "");
	var number = "" + text;
	var longNumber = number.length;
	var newNumbwe = "";
	var cont = 0;

	for (var i = longNumber; i >= 1; i--) {
		var res = number.slice(i - 1, i);
		if (cont == 3) {
			res += ".";
			cont = 0;
		}
		newNumbwe = res + newNumbwe;

		cont++;

	}

	element.value = newNumbwe;
}
//Function validate set type data
function validateText(id) {
	var textNumer = document.getElementById(id);
	var textValue = textNumer.value.replace(/[\D]/g, "");
	textNumer.value = textValue;
	if (textValue.length > 3) {
		setDecimal(textNumer);
	}
}
//Function calculate
function calculate(e) {
	

	e.preventDefault();
	
}
//Function create table result
function createTableAmortization(idTable, term, rate, rode) {
	var table = document.getElementById(idTable);
	var headerTable = "<thead><tr><th>Períodos</th><th>Cuota</th><th>Interés</th><th>Abono a Capital</th><th>Saldo</th></tr></thead>";
	var bodyTable = "<tbody>";
	var newTable = "";
	var row = "";
	var footer = "";
	rate = rate / 100;
	var tazaAnual = rate * 12;
	var balances = [3];
	var previousBalance = rode;
	var operation = (Math.pow((1 + rate), term) * rate) / ((Math.pow((1 + rate), term) - 1));
	var ressult = rode * (operation);

	for (var i = 1; i <= term; i++) {
		var interest = previousBalance * rate;
		var deposit = ressult - interest;
		previousBalance = previousBalance - deposit;

		if (previousBalance < 1) {
			previousBalance = 0;
		}
		row += "<tr><td>" + i + "</td>" + "<td> $" + numberWithCommas(ressult.toFixed(0)) + "</td>" + "<td> $" + numberWithCommas(interest.toFixed(0)) + "</td>" + "<td> $" + numberWithCommas(deposit.toFixed(0)) + "</td>" + "<td> $" + numberWithCommas(previousBalance.toFixed(0)) + "</td></tr>";
		if (i == 1) {
			balances[0] = ressult;
			balances[1] = interest;
			balances[2] = deposit;
			//alert("i === 1");
		} else {
			balances[0] = ressult + balances[0];
			balances[1] = interest + balances[1];
			balances[2] = deposit + balances[2];
			//alert("else");
		}
	}
	footer += "<tfoot><tr class='success'><td >Totales</td><td>$" + numberWithCommas(balances[0].toFixed(0)) + "</td><td> $" + numberWithCommas(balances[1].toFixed(0)) + "</td><td> $" + numberWithCommas(balances[2].toFixed(0)) + "</td></tr></tfoot>";
	newTable = headerTable + bodyTable + row + "</tbody>" + footer;
	table.innerHTML = newTable;
	rate = parseFloat(rate * 100).toFixed(2);

	var textInfo = "<ul class='listInfoTable'><li><span><b> Línea de crédito: </b></span> " + titleLine + " </li><li><i class='fa fa-map-marker'></i> <span> <b>Plazo:</b></span> " + term + " Meses </li><li><i class='fa fa-phone'></i> <span> <b>Tasa de Interés:</b></span> " + rate + " %</li><li><i class='fa fa-phone'></i> <span> <b>Valor de la cuota aproximado :</b></span> $" + numberWithCommas(ressult.toFixed(0)) + "</li><li><i class='fa fa-envelope'></i> <span><b> Valor Solicitado:</b></span> $" + numberWithCommas(rode) + "</li></ul>";


	
	$(".detail").html(textInfo);

}

function numberWithCommas(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
}

function validate(idElement, select) {
	if (select == 0) {
		idElement.classList.remove("invalidate");
		idElement.classList.add("validate");
	} else {
		idElement.classList.remove("validate");
		idElement.classList.add("invalidate");
	}
}

function cleanElements() {
	$("#term > option").remove();
	dataRode.value = "";
	dataRode.disabled = true;
	validaSection(1);

}

function cleanElementsNewline() {
	dataRode.value = "";
	dataRode.disabled = false;
	dataRode.classList.remove("validate");
	$("#term > option").remove();
	validaSection(1);
	cleanTable();
}

function cleanTable() {
	$(".ContainerTableResult").fadeOut();
	$("#tableResult >thead").remove();
	$("#tableResult >tbody").remove();
	$("#tableResult >tfoot").remove();
}

function validaSection(data) {
	$("#contInfo0").css("display", "none");
	$("#contInfo1").css("display", "none");
	$("#contInfo" + data).fadeIn(1000);
}

function alerts(select, id) {
	var listMenssage = new Array("Seleccione un linéa de credito", "Seleccione el plazo", "Digite un monto", "Verifique el monto", "Los valores presentados en el simulador de crédito son aproximado y pueden generar variacion  al momento que realices esta solicitud.");
	var alerts = $(id);
	alerts.fadeOut(10, function () {
		alerts.fadeIn(100, function () {
			$(".textAlert").html("<strong>Información! </strong>" + listMenssage[select]);
			setTimeout(function () {
				alerts.fadeOut(150);
			}, 4000);
		});
	});
	//anchor(varEvent,"#result");
}

function anchor(e, id) {
	e.preventDefault(); //evitar el eventos del enlace normal
	var strAncla = id; //id del ancla
	$('body,html').stop(true, true).animate({
		scrollTop: $(strAncla).offset().top
	}, 1000);

};