// JavaScript Document
	var titleData='{"data":['+
	'{"title":""},'+	
	'{"title":"ORDINARIO "},'+
	'{"title":"TARJETA TAVA"},'+
	'{"title":"EDUCACIÓN"},'+
	'{"title":"SOBRE APORTES"},'+
	'{"title":"SOBREPRIMA"},'+
	'{"title":"FIDELIDAD"},'+
	'{"title":"COMPRAS"},'+
	'{"title":"COMPRA DE CARTERA"},'+
	'{"title":"CREDI YA"}]}';
	var destinationData='{"data":['+
		'{"id":"0","destination":""},'+
		'{"id":"1","destination":"Destinado para cualquier tipo de consumo o libre inversión"},'+
		'{"id":"2","destination":"Brindar al Asociado liquidez inmediata, mediante un credito rotativo, que  permite realizar avances en efectivo en toda la red de cajeros electronicos  y compras  en numerosos establecimientos de todo el país y  de franquicia VISA."},'+
		'{"id":"3","destination":"Sufragar los gastos de educación del Asociado, su cónyuge o compañera permanente y/o de sus hijos"},'+
		'{"id":"4","destination":"Los créditos Sobreaportes serán destinados a facilitar el cubrimiento parcial o total de las necesidades que busquen el bienestar social de los Asociados y de su núcleo familiar."},'+
		'{"id":"5","destination":"Los créditos Sobreprima serán destinados a facilitar en un corto plazo el cubrimiento parcial o total de las necesidades que busquen el bienestar social de los Asociados y de su núcleo familiar."},'+
		'{"id":"6","destination":"Premiar a los asociados por su fidelidad y continuidad con la Cooperativa."},'+
		'{"id":"7","destination":"Brindar un crédito que le permita al asociado gestionar la obtención de   bienes y servicios a través de los convenios suscritos por Coominobras."},'+
		'{"id":"8","destination":"Compra de obligaciones financieras."},'+
		'{"id":"9","destination":"Liquidez inmediata"}]}';

		
	var conditionData='{"data":['
		+'{"id":"0","condition":""},'
		+'{"id":"1","condition":"Asociados nombrados en carrera administrativa, provisionalidad y  pensionados, hasta 6 veces el valor de los aportes. Asociados de Libre nombramiento y remoción, e independientes hasta 3 veces el valor de los aportes. No obstante lo anterior, el monto máximo no podrá superar los 110 SMMLV."},'
		+'{"id":"2","condition":"Hasta 1,5 salario básico (según capacidad de pago), con un monto máximo de $8000,000, Esta tarjeta excluye la adquisición de crediya de manera automática.</br>Suspensión:  Más de 60 días de mora, tendrá suspensión de aprobación de todas las lineas de crédito durante un  año"},'
		+'{"id":"3","condition":"Asociados nombrados en carrera administrativa, provisionalidad y  pensionados, hasta 6 veces el valor de los aportes. Asociados de Libre nombramiento y remoción, e independientes hasta 3 veces el valor de los aportes. No obstante lo anterior, el monto máximo no podrá superar los 110 SMMLV."},'
		+'{"id":"4","condition":"Asociados nombrados en carrera administrativa, provisionalidad y pensionados, hasta 100% del valor de los aportes.</br>Asociados de libre nombramiento y remoción hasta el 70% del valor de sus aportes.</br>No obstante lo anterior, el monto máximo no podrá superar los 110 SMMLV</br>Un solo crédito por está línea si el asociado requiere otro préstamo sobre aportes, se debe recoger el saldo pendiente."},'
		+'{"id":"5","condition":"Se otorgará dos (2) veces al año: Primer Semestre: De Abril 1 a Junio 5</br>Segundo Semestre: De Septiembre 1 a Noviembre 5 Un solo credito por semestre."},'
		+'{"id":"6","condition":"10 años continuos de estar afiliado a la Cooperativa."},'
		+'{"id":"7","condition":""},'
		+'{"id":"8","condition":"Carrera, provisionalidad, pensionados, empleados hasta 6 veces el valor de los aportes Libre nombramiento y remoción, independientes hasta 3 veces el valor de los aportes"},'
		+'{"id":"9","condition":"Solo podra solicitar un nuevo crediya hasta que haya cancelado el anterior"}]}';
	var benefitData='{"data":['+
		'{"id":"0","benefit":""},'+
		'{"id":"1","benefit":"Mejoramiento de calidad de vida Adquisición de elementos para el hogar Bienestar familiar"},'+
		'{"id":"2","benefit":"Disponibilidad de efectivo en cajeros electrónicos</br>Compras en establecimientos comerciales</br>Cupo rotativo</br>Baja cuota de manejo"},'+
		'{"id":"3","benefit":"Facilidad en el pago de estudios </br>Mejores oportunidades laborales"},'+
		'{"id":"4","benefit":"Cubrimiento de necesidades del grupo familia"},'+
		'{"id":"5","benefit":"Cubrimiento de necesidades grupo familiar Disfrute anticipado de la prima"},'+
		'{"id":"6","benefit":"Tasa Preferencial"},'+
		'{"id":"7","benefit":"Facilitar la adquisición de bienes y servicios al Asociado"},'+
		'{"id":"8","benefit":"Tasa preferencial Mejoramiento de ingresos Liberación capacidad de pago"},'+
		'{"id":"9","benefit":"Crédito inmediato"}]}';
	
	var termData='{"data":['+
		'{"id":['+'{"term":"","rate":"","nmv":""}]},'+
		
		'{"id":['+
		'{"term":"1-18","rate":"1.4","nmv":"18.16"},'+
		'{"term":"19-36","rate":"1.5","nmv":"19.56"},'+
		'{"term":"37-60","rate":"1.6","nmv":"20.98"}]},'+
		
		'{"id":[{"term":"1-24","rate":"1.78","nmv":"23.58"}]},'+
		
		'{"id":['+
		'{"term":"1-6","rate":"0.8","nmv":"10.03"},'+
		'{"term":"7-12","rate":"0.9","nmv":"11.35"},'+
		'{"term":"13-36","rate":"1","nmv":"12.68"}]},'+
		
		'{"id":['+
		'{"term":"1-12","rate":"0.50","nmv":"6.17"},'+
		'{"term":"13-24","rate":"0.75","nmv":"9.38"},'+
		'{"term":"25-36","rate":"1","nmv":"12.68"}]},'+
		
		'{"id":[{"term":"1-1","rate":"1.5","nmv":"19.56"}]},'+
		
		'{"id":['+
		'{"term":"1-12","rate":"0.6","nmv":"7.44"},'+
		'{"term":"13-24","rate":"0.7","nmv":"8.73"},'+
		'{"term":"25-36","rate":"0.8","nmv":"10.03"}]},'+
		
		'{"id":[{"term":"1-12","rate":"1","nmv":"12.68"}]},'+
		
		'{"id":['+
		'{"term":"1-18","rate":"1","nmv":"12.68"},'+
		'{"term":"19-36","rate":"1.3","nmv":"16.77"},'+
		'{"term":"37-60","rate":"1.5","nmv":"19.56"}]},'+
		
		'{"id":[{"term":"1-6","rate":"1.87","nmv":"23.87"}]}]}';

	var itemSelectLine=0;
	var selectList;
	var newOption;
	var containerSelect;
	var dataRode;
	var selectWeek;
	var titleLine="";
	var varEvent;
	//Function select list credit line
	function selectItems(data){
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
	
	}
	//Function create select week
	function  createSelect(max, mini){
	
			
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

	}
	
	
	//Function get rate and nmv
	function validateRate(arrayRate, week){
		
		for( var i=0;i<arrayRate.id.length;i++){
			var term=arrayRate.id[i].term.split("-");
			
			if(week>=parseInt(term[0]) && week<=parseInt(term[1])){
				console.log(arrayRate.id[i].rate);
				dataRate=arrayRate.id[i].rate;
				console.log(arrayRate.id[i].nmv);
			}
			
		}
			
	}
	//Function set decimal text	
	function setDecimal(element) {
		
		var textlong=element.value.length;
		var text=element.value.replace(/\./g,"");
		var number=""+text;
		var longNumber=number.length;
		var newNumbwe="";
		var cont=0;

		for(var i=longNumber;i>=1;i--){
			var res = number.slice(i-1,i);
			if(cont==3){
				res+=".";
				cont=0;
			}
			newNumbwe=res+newNumbwe;

			cont++;
			
		}
		
		element.value=newNumbwe;
		}
	//Function validate set type data
	function validateText(id){
		
		var textNumer=document.getElementById(id);
		var textValue=textNumer.value.replace(/[\D]/g,"");
		textNumer.value=textValue;
		if(textValue.length>3){
		setDecimal(textNumer);
			}
	}	
	//Function calculate
	function calculate(e){
		varEvent=e;
		selectWeek=document.getElementById("selectWeek");
	
		if(itemSelectLine==0){
		
			alerts(0,"#alert");
			return false;	
		}
		 if(selectWeek){
			var selectItemsWeek=selectList.options[selectList.selectedIndex].value;
			if(selectItemsWeek==0){
	
				alerts(1,"#alert");
				validate(selectWeek, 1);
				return false;
			}
			else{
			validateRate(objTermData.data[itemSelectLine],selectItemsWeek);
				validate(selectWeek, 0);
			
			}

			
			if(dataRode.value==null ||dataRode.value=="" ||dataRode.value.length==0){
			
				alerts(2,"#alert");
				 validate(dataRode, 1);
				return false;
			} 
			 else{
				 var text=dataRode.value.replace(/\./g,"");
				 console.log(text.length);
				 if(text.length<6){
					 
					 alerts(3,"#alert");
					 
					cleanTable();
					 validate(dataRode, 1);
					return false;
				 }else{
					 validate(dataRode, 0);
					 
					 createTableAmortization("tableResult",selectItemsWeek,dataRate,text);
					 $(".ContainerTableResult").fadeIn();
					 anchor(e,"#result");
				 }
			 }
		}	
	}
	//Function create table result
	function createTableAmortization(idTable,term,rate,rode){	
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
		
	}
	function numberWithCommas(x) {
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
	}	
	
	function validate(idElement, select){
		if(select==0){
		idElement.classList.remove("invalidate");
		idElement.classList.add("validate");
			}else{
		idElement.classList.remove("validate");
		idElement.classList.add("invalidate");	
			}
	}
	function cleanElements(){
		$("#selectWeek > option").remove();
		dataRode.value="";
		dataRode.disabled=true;
		validaSection(1);
		
	}
	function cleanElementsNewline(){
		dataRode.value="";
		dataRode.disabled=false;
		dataRode.classList.remove("validate");
		$("#selectWeek > option").remove();
		validaSection(1);
		cleanTable();
		
	}
	function cleanTable(){
		$(".ContainerTableResult").fadeOut();
		$("#tableResult >thead").remove();
		$("#tableResult >tbody").remove();
		$("#tableResult >tfoot").remove();
	}
	function validaSection(data){
		$("#contInfo0").css("display","none");
		$("#contInfo1").css("display","none");
		$("#contInfo"+data).fadeIn(1000);
	}

	function alerts(select,id){
	var listMenssage=new Array("Seleccione un linéa de credito","Seleccione el plazo","Digite un monto","Verifique el monto","Los valores presentados en el simulador de crédito son aproximado y pueden generar variacion  al momento que realices esta solicitud.");	
		var alerts=$(id);
		
		alerts.fadeOut(10,function(){
			alerts.fadeIn(100,function(){
				$(".textAlert").html("<strong>Información! </strong>"+listMenssage[select]);
				setTimeout(function(){
					alerts.fadeOut(150);
				},4000);
			});
		});
		//anchor(varEvent,"#result");
	}
	function anchor(e,id){				
			e.preventDefault();		//evitar el eventos del enlace normal
			var strAncla=id; //id del ancla
				$('body,html').stop(true,true).animate({				
					scrollTop: $(strAncla).offset().top
				},1000);
		  

		};
