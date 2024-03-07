function item_price (){
const priceInput = document.getElementById("item-price");
priceInput.addEventListener("input", () => {
  const inputValue = priceInput.value;

  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");
  const price = priceInput.value;
  const fee = Math.floor(price * 0.10);
  const profit = price - fee;

  addTaxDom.innerHTML =  `販売手数料：${fee}`;
  profitDom.innerHTML = `利益：${profit}円`;
})
};
window.addEventListener('turbo:load', item_price);