/* Botão feedback abre dropdow */
document.getElementById('bot-fed').addEventListener('click', function() {
    var dropdown = document.getElementById('dropdown-fed');
    if (dropdown.style.display === 'none' || dropdown.style.display === '') {
        dropdown.style.display = 'block';
    } else {
        dropdown.style.display = 'none';
    }
});

/* popup deleta feedbacks */
document.querySelector('.bot-deleta-feed').addEventListener('click', function() {
    var modal = document.getElementById('confirmation-modal-feed');
    modal.classList.remove('hidden');
});

document.getElementById('confirm-delete-feed').addEventListener('click', function() {
    var feedForm = document.getElementById('feed-form');
    feedForm.remove();
    var modal = document.getElementById('confirmation-modal-feed');
    modal.classList.add('hidden');
});

document.getElementById('cancel-delete-feed').addEventListener('click', function() {
    var modal = document.getElementById('confirmation-modal-feed');
    modal.classList.add('hidden');
});