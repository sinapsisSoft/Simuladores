var dataRate = 1;
	varEvent = e;
	selectWeek = document.getElementById("term");
	debugger;
	if (itemSelectLine == 0) {
		//alerts(0, "#alertTable");
		return false;
	}
	if (selectWeek) {
		var selectItemsWeek = selectList.options[selectList.selectedIndex].value;
		if (selectItemsWeek == 0) {

			//alerts(1, "#alertTable");
			validate(selectWeek, 1);
			debugger;
		} else {
			//validateRate(objTermData.data[itemSelectLine],selectItemsWeek);
			dataRate = selectRate(selectItemsWeek);
			//console.log(selectItemsWeek);
			//alert(dataRate);
			validate(selectWeek, 0);
			debugger;
		}

		if (dataRode.value === null || dataRode.value === "" || dataRode.value.length === 0) {

			//alerts(2, "#alertTable");
			validate(dataRode, 1);
			debugger;
		} else {
			var text = dataRode.value.replace(/\./g, "");
			//console.log(text.length);
			if (text.length < 6) {

				//alerts(3, "#alertTable");

				cleanTable();
				validate(dataRode, 1);
				debugger;
			} else {
				validate(dataRode, 0);

				//createTableAmortization("tableResult", selectItemsWeek, dataRate, text);
				$(".ContainerTableResult").fadeIn();
				$("#contInfo2").fadeIn(1000);
				//anchor(e, "#result");
				//document.location.href = "#result";
				debugger;
			}
		}
	}