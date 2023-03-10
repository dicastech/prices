const url = "http://localhost:3000/prices"

$('#price-form').on('submit', (event) => {
  var $inputs = $('#price-form input[type!=submit]');

  var values = {};

  $inputs.each(function () {
    values[this.name] = $(this).val();
  });

  fetch(url, { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify(values) }).then((response) => {
    loadData();
  })

  event.preventDefault();
})

async function loadData(){
  let response = await fetch(url, { method: "GET" }).then((response) => response.json());

  // console.table(response);

  $('#global-average').html(`A soma da sua média é ${number_to_currency(response['total_average'])}`);

  let tbody = '';

  for(let key in response['detailed_report']) {
    let detailed_report = response['detailed_report'][key];

    let row = `
      <tr>
        <th>${i18n(key)}</th>
        <td>${number_to_currency(detailed_report["min"])}</td>
        <td>${number_to_currency(detailed_report["max"])}</td>
        <td>${number_to_currency(detailed_report["avg"])}</td>
      </tr>
    `;

    tbody += row;
  }

  $('#price-table tbody').html(tbody);
}

function number_to_currency(value) {
  return new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL' }).format(value)
}

function i18n(key) {
  let strings = {
    'rental_price': 'Aluguel',
    'water_price': 'Água',
    'energy_price': 'Luz',
    'internet_price': 'Intenet',
    'marketplace_price': 'Supermercado',
    'transport_price': 'Transport',
    'leisure_price': 'Lazer',
  }

  return strings[key];

}

$(document).ready(()=>{
  loadData();
})
