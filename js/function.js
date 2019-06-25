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

	var xhttp = new XMLHttpRequest();
	xhttp.open("POST", "php/bo_credit.php", true);
	xhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xhttp.onreadystatechange = function () {
		if (this.readyState === 4 && this.status === 200) {
			if (data === 0) {
				objCredit = JSON.parse(xhttp.responseText);
				//console.log(objCredit);
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
	var selectCredit = document.getElementById("selectLineCredit");
	var option = "<option value='0'>Seleccione una línea de crédito</option>";
	for (var i = 0; i < objCredit.length; i++) {
		option += "<option value='" + objCredit[i].credId + "'>" + objCredit[i].credName + "</option>";
	}
	selectCredit.innerHTML = option;

}
//Function select list credit line
function selectItems(data) {

	itemSelectLine = data;
	//console.log(data);
	if (data != 0) {
		dataRode = document.getElementById("rode");

		var maxMin = sectionMaxMin(data);
		

		for (var i = 0; i < objCredit.length; i++) {
			if (objCredit[i].credId === data) {
				//alert();
				document.getElementById('destination').innerHTML = "<p>" + objCredit[i].credDestination + "</p>";
				document.getElementById('condition').innerHTML = "<p>" + objCredit[i].credCondition + "</p>";
				document.getElementById('benefit').innerHTML = "<p>" + objCredit[i].credBenefits + "</p>";
				titleLine = objCredit[i].credName;
				document.getElementById("titleLine").innerHTML = "Línea de crédito: <strong>" + titleLine + "</strong>";
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
		if (objCondition[i].idCredit === data) {
			arrayTerm.push(objCondition[i]);
		}
	}
	//console.log(arrayTerm);
	for (var j = 0; j < arrayTerm.length; j++) {
		arrayMaxMin = arrayTerm[j].condTerm.split("-");
		
		if (j === 0) {
			aux[0] = parseInt(arrayMaxMin[0]);
			aux[1] = parseInt(arrayMaxMin[1]);
		} else {
			
			if (parseInt(arrayMaxMin[1]) > aux[1]) {
				aux[1] = arrayMaxMin[1];
			}
			if (parseInt(arrayMaxMin[0]) < aux[0]) {
				aux[0] = arrayMaxMin[0];
			}
		}
	}
	//console.log(aux);
	return aux;
}
//Function create select week
function createSelect(max, mini) {
	selectList = document.getElementById("selectWeek");
	var option = "<option value='0'>Número de cuotas</option>";
	for (var i = mini - 1; i <= max; i++) {
		if (i != 0) {
			option += "<option value='" + i + "'>" + i + "</option>";
		}
	}
	selectList.innerHTML = option;
}
//Function get rate and nmv
function selectRate(select) {
	var rate;
	var aMaxMin = new Array();
	for (var i = 0; i < arrayTerm.length; i++) {
		aMaxMin = arrayTerm[i].condTerm.split("-");
		//console.log(aMaxMin);
		if ((select >= parseInt(aMaxMin[0])) && (select <= parseInt(aMaxMin[1]))) {
			rate = arrayTerm[i].condRate;
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
	var dataRate = 1;
	varEvent = e;
	selectWeek = document.getElementById("selectWeek");
	if (itemSelectLine == 0) {
		alerts(0, "#alert");
		return false;
	}
	if (selectWeek) {
		var selectItemsWeek = selectList.options[selectList.selectedIndex].value;
		if (selectItemsWeek == 0) {

			alerts(1, "#alert");
			validate(selectWeek, 1);
			return false;
		} else {
			//validateRate(objTermData.data[itemSelectLine],selectItemsWeek);
			dataRate = selectRate(selectItemsWeek);
			//console.log(selectItemsWeek);
			//alert(dataRate);
			validate(selectWeek, 0);

		}

		if (dataRode.value === null || dataRode.value === "" || dataRode.value.length === 0) {

			alerts(2, "#alert");
			validate(dataRode, 1);
			return false;
		} else {
			var text = dataRode.value.replace(/\./g, "");
			//console.log(text.length);
			if (text.length < 6) {

				alerts(3, "#alert");

				cleanTable();
				validate(dataRode, 1);
				return false;
			} else {
				validate(dataRode, 0);

				createTableAmortization("tableResult", selectItemsWeek, dataRate, text);
				$(".ContainerTableResult").fadeIn();
				//anchor(e, "#result");
				document.location.href = "#result";
			}
		}
	}
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

		} else {

			balances[0] = ressult + balances[0];
			balances[1] = interest + balances[1];
			balances[2] = deposit + balances[2];
		}

	}
	footer += "<tfoot><tr class='success'><td >Totales</td><td>$" + numberWithCommas(balances[0].toFixed(0)) + "</td><td> $" + numberWithCommas(balances[1].toFixed(0)) + "</td><td> $" + numberWithCommas(balances[2].toFixed(0)) + "</td></tr></tfoot>";
	newTable = headerTable + bodyTable + row + "</tbody>" + footer;
	table.innerHTML = newTable;
	//var titleLine = "Diego";
	rate = parseFloat(rate * 100).toFixed(2);

	var textInfo = "<ul class='address listInfoTable'><li><i class='fa fa-map-marker'></i> <span><b> Línea de crédito: </b></span> " + titleLine + " </li><li><i class='fa fa-map-marker'></i> <span> <b>Plazo:</b></span> " + term + " Meses </li><li><i class='fa fa-phone'></i> <span> <b>Tasa de Interés:</b></span> " + rate + " %</li><li><i class='fa fa-phone'></i> <span> <b>Valor de la cuota aproximado :</b></span> $" + numberWithCommas(ressult.toFixed(0)) + "</li><li><i class='fa fa-envelope'></i> <span><b> Valor Solicitado:</b></span> $" + numberWithCommas(rode) + "</li></ul>";


	alerts(4, "#alertTable");
	$(".listInfoTable").remove();
	$(".detail").html(textInfo);
	$("#myModal").modal();


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
	$("#selectWeek > option").remove();
	dataRode.value = "";
	dataRode.disabled = true;
	validaSection(1);

}

function cleanElementsNewline() {
	dataRode.value = "";
	dataRode.disabled = false;
	dataRode.classList.remove("validate");
	$("#selectWeek > option").remove();
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
/*function selectItems(data){
	itemSelectLine=data;
	if(data!=0){
	dataRode=document.getElementById("rode");
	objDestination=JSON.parse(destinationData);
	objCondition=JSON.parse(conditionData);
	objBenefit=JSON.parse(benefitData);	
	objTermData=JSON.parse(termData);
	objTitle=JSON.parse(titleData);
	
	document.getElementById("destination").innerHTML="<p>"+objDestination.data[data].destination+"</p>";
	document.getElementById("condition").innerHTML="<p>"+objCondition.data[data].condition+"</p>";
	document.getElementById("benefit").innerHTML="<p>"+objBenefit.data[data].benefit+"</p>";
	titleLine=objTitle.data[data].title;
	document.getElementById("titleLine").innerHTML="Línea de crédito: <strong>"+titleLine+"</strong>";
	var longObject=objTermData.data[data].id.length;

		var termList=new Array();
		var min=termList[0]=objTermData.data[data].id[0].term.split("-");
		var max=termList[longObject-1]=objTermData.data[data].id[longObject-1].term.split("-");
		cleanElementsNewline();
		createSelect(max[1], min[0]);
		validaSection(0);
		}
	else{

		cleanElements();
	}
	
}*/

/*function  createSelect(max, mini){
	
		
		selectList=document.getElementById("selectWeek");
		
		for(var i=mini-1;i<=max;i++){
		newOption=document.createElement("option");
			if(i==0){
		newOption.value=i;
		newOption.text="Número de cuotas";
			}
			else{
		newOption.value=i;
		newOption.text=i;
				}
		selectList.appendChild(newOption);
		
	
		}

}*/


/*function createTableAmortization(idTable,term,rate,rode){	
	rate=rate/100;
	var tazaAnual=rate*12;
	var balances=[3];
	var previousBalance=rode;
	cleanTable();
	var table=$("#"+idTable);
	table+="<thead><tr><th>Períodos</th><th>Cuota</th><th>Interés</th><th>Abono a Capital</th><th>Saldo</th></tr></thead><tbody>";
	var operation=(Math.pow((1+rate),term)*rate)/((Math.pow((1+rate),term)-1));
	var ressult=rode*(operation);
	for(var i=1;i<=term;i++){
		table+="<tr>";
	var interest=previousBalance*rate;
	var deposit=ressult-interest;
		
	previousBalance=previousBalance-deposit;
	
		if(previousBalance<1){
			previousBalance=0;
		}
	
	
		table+="<td>"+i+"</td>"+"<td> $"+numberWithCommas(ressult.toFixed(0))+"</td>"+"<td> $"+numberWithCommas(interest.toFixed(0))+"</td>"+"<td> $"+numberWithCommas(deposit.toFixed(0))+"</td>"+"<td> $"+numberWithCommas(previousBalance.toFixed(0))+"</td>";

		if(i==1){
		balances[0]=ressult;
		balances[1]=interest;
		balances[2]=deposit;
			
			}
		else{
			
		balances[0]=ressult+balances[0];
		balances[1]=interest+balances[1];
		balances[2]=deposit+balances[2];
		}
	
	table+="</tr></tbody>";	
	}
	
	table+="<tfoot><tr class='success'><td >Totales</td><td>$"+numberWithCommas(balances[0].toFixed(0))+"</td><td> $"+numberWithCommas(balances[1].toFixed(0))+"</td><td> $"+numberWithCommas(balances[2].toFixed(0))+"</td></tr></tfoot>";
	
	
	$("#tableResult").append(table);
	rate=parseFloat(rate*100).toFixed(2);
	var textInfo="<ul class='address listInfoTable'><li><i class='fa fa-map-marker'></i> <span><b> Línea de crédito: </b></span> "+titleLine+" </li><li><i class='fa fa-map-marker'></i> <span> <b>Plazo:</b></span> "+term+" Meses </li><li><i class='fa fa-phone'></i> <span> <b>Tasa de Interés:</b></span> "+rate+" %</li><li><i class='fa fa-phone'></i> <span> <b>Valor de la cuota aproximado :</b></span> $"+numberWithCommas(ressult.toFixed(0))+"</li><li><i class='fa fa-envelope'></i> <span><b> Valor Solicitado:</b></span> $"+numberWithCommas(rode)+"</li></ul>";
	alerts(4,"#alertTable");
	$(".listInfoTable").remove();
	$(".detail").append(textInfo);
	$("#myModal").modal();
	
}*/