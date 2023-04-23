// Add the code you want to test below:
let view = document.getElementById('view-button');
let close = document.getElementById('close-button');
let cat = document.getElementById('cat');

let open = function() {
    cat.style.display = 'block';
    close.style.display = 'block';
};

let hide = function() {
    cat.style.display = 'none';
    close.style.display = 'none';
};

view.onclick = open;
close.onclick = hide;

// identify element for text change
let textChange = function () {
    view.innerHTML = 'Hello, World!';
}

//function that changes the text back to the default
let textReturn = function (){
    view.innerHTML = 'View';
}

//assign click event to change the text

view.addEventListener('click', textChange);
close.addEventListener('click', textReturn);