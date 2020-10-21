document.addEventListener("turbolinks:load", function() {
  let box = document.getElementsByClassName("articlebox");
  
  for (let i = 0; i < box.length; i++)
  {
    box[i].addEventListener('click', function(){
      let id = this.getAttribute('id');
      window.location.replace(id);
    })
  }
});