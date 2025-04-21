
// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

const co2canvas = document.getElementById("Co2ChartBar");

const labels = JSON.parse(co2canvas.dataset.labels);
const values = JSON.parse(co2canvas.dataset.values);

const ctx = co2canvas.getContext('2d');


var myLineChart = new Chart(ctx, {
  type: 'bar',
  data: {
    labels: labels,
    datasets: [{
      label: "CO2排出量(ton)",
      backgroundColor: "rgba(2,117,216,1)",
      borderColor: "rgba(2,117,216,1)",
      data: values,
    }],
  },
  options: {
    scales: {
      xAxes: [{
        gridLines: {
          display: false
        },
        ticks: {
          maxTicksLimit: 6,
          callback: function(value, index, values){
            return  value +  '年度'
          }
        }
      }],
      yAxes: [{
        ticks: {
          min: 0,
          maxTicksLimit: 6,
          callback: function(value, index, values){
            return  value +  'tCO2'}
        },
        gridLines: {
          display: true
        }
      }],
    },
    legend: {
      display: false
    }
  }
});
