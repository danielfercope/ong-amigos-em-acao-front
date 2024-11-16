// Seleciona todos os botões que abrem modais
const btnsOpenModal = document.querySelectorAll('.btnOpenModal');

// Adiciona event listeners a cada botão para abrir a modal correspondente
btnsOpenModal.forEach(btn => {
    btn.addEventListener('click', (event) => {
        const modalId = event.target.getAttribute('data-modal');
        openModal(modalId);
    });
});

// Função para abrir uma modal específica
function openModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) {
        modal.classList.add('active');
    }
}

// Função para fechar uma modal específica
function closeModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) {
        modal.classList.remove('active');
    }
}

// Event listener para fechar a modal ao clicar fora dela
window.addEventListener('click', (event) => {
    if (event.target.classList.contains('modal-container')) {
        event.target.classList.remove('active');
    }
});
