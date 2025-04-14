window.addEventListener('DOMContentLoaded', event => {
  // Simple-DataTables
  // https://github.com/fiduswriter/Simple-DataTables/wiki

  const datatablesSimple = document.getElementById('datatablesSimple');
  if (datatablesSimple) {

    let options = {
      labels: {
        perPage: "件表示",
        info: "{rows}件中、{start} 〜 {end}件を表示",
        noResults: "該当するデータはありません"

      },
      columns: [
        { select: 0, sort: "desc"},
        { select: 2, filter: ["データなし"]}
      ],
      searchable: false,
      fixedHeight: true,
    };
    
    let dataTable = new simpleDatatables.DataTable(datatablesSimple, options);
  }
});