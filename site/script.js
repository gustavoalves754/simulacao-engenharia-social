// Gera os e-mails iniciais
const generateInbox = () => {
  const subjects = [
    'Boas-vindas ao campus virtual',
    'Fatura cartão de crédito',
    'Convite: seminário online',
    'Atualização de senha',
    'Nova grade de horários',
    'Pesquisa de satisfação',
    'Confirmação de matrícula',
    'Ata da reunião docente'
  ];
  const spamSubjects = [
    'Ganhe dinheiro rápido!',
    'Promoção relâmpago',
    'Clique e ganhe prêmios',
    'Oferta limitada',
    'Vacina milagrosa',
    'Você foi sorteado',
    'Baixe este anexo',
    'Atualize seu antivírus'
  ];

  const fill = (subs, folder) => {
    const cont = document.getElementById(folder);
    cont.innerHTML = '';
    subs.forEach((s, i) => {
      const d = document.createElement('div');
      d.className = 'email-item';
      d.innerHTML = `
        <div class="text">
          <a href="#" class="subject-link">${s}</a>
          <div class="meta">de: fake${i+1}@exemplo.com</div>
        </div>
        <div class="actions"><button>Excluir</button></div>
      `;
      cont.appendChild(d);
    });
  };

  fill(subjects, 'inbox-view');
  fill([], 'sent-view');
  fill([], 'drafts-view');
  fill(spamSubjects, 'spam-view');
  fill([], 'deleted-view');
  fill([], 'notes-view');
  fill([], 'archive-view');
  fill([], 'history-view');
};

document.addEventListener('DOMContentLoaded', () => {
  generateInbox();

  // Navegação lateral
  document.querySelectorAll('.sidebar li').forEach(item => {
    item.addEventListener('click', () => {
      document.querySelectorAll('.sidebar li').forEach(i => i.classList.remove('active'));
      item.classList.add('active');
      showView(item.dataset.view);
    });
  });

  // Novo / cancelar
  document.querySelector('.new-email').addEventListener('click', () => showView('compose-view'));
  document.getElementById('cancel-compose').addEventListener('click', () => showView('inbox-view'));

  // Enviar compose
  document.getElementById('compose-form').addEventListener('submit', e => {
    e.preventDefault();
    const to = e.target.to.value, subject = e.target.subject.value;
    const sent = document.getElementById('sent-view');
    const div = document.createElement('div');
    div.className = 'email-item';
    div.innerHTML = `
      <div class="text">
        <a href="#" class="subject-link">${subject}</a>
        <div class="meta">para: ${to}</div>
      </div>
      <div class="actions"><button>Excluir</button></div>
    `;
    sent.appendChild(div);
    e.target.reset();
    showView('sent-view');
  });

  // Clique em e-mail da inbox
  document.getElementById('inbox-view').addEventListener('click', e => {
    if (!e.target.classList.contains('subject-link')) return;
    e.preventDefault();

    document.getElementById('detail-subject').textContent = e.target.textContent;
    document.getElementById('detail-from').innerHTML = '<strong>De:</strong> unacontagemfake@outluuk..com';
    document.getElementById('detail-to').innerHTML   = '<strong>Para:</strong> aluno@faculdadeuna.com';
    document.getElementById('detail-date').innerHTML = '<strong>Data:</strong> ' + new Date().toLocaleString();

    document.getElementById('detail-body').innerHTML = `
      <p>Olá,</p>
      <p>Identificamos que sua mensalidade está em atraso. Para não perder sua bolsa na UNA Contagem,
      <a href="#" id="phish-link">clique aqui</a> e regularize imediatamente.</p>
      <p>Ou fale com a coordenação: (31) 99999-0000.</p>
      <p>Atenciosamente,<br><em>Secretaria Acadêmica – UNA Contagem</em></p>
      <img src="https://via.placeholder.com/600x200?text=UNA+Contagem+Logo+Fake" alt="Logo" class="email-img"/>
    `;
    showView('email-detail-view');

    // dispara o PowerShell no servidor
    document.getElementById('phish-link').addEventListener('click', ev => {
      ev.preventDefault();
      fetch('/executar')
        .then(r => r.json())
        .then(j => console.log(j.status))
        .catch(console.error);
    });
  });

  // Excluir e-mail
  document.addEventListener('click', e => {
    if (e.target.closest('.actions button, .delete-btn')) {
      e.preventDefault();
      const safe = document.getElementById('safe-alert');
      safe.classList.add('active');
    }
  });

  // Fechar modais
  document.getElementById('close-hack').addEventListener('click', () => {
    document.getElementById('hack-alert').classList.remove('active', 'shake');
  });
  document.getElementById('close-safe').addEventListener('click', () => {
    document.getElementById('safe-alert').classList.remove('active', 'shake');
  });
});

// mostra só a view pedida
function showView(id) {
  document.querySelectorAll('.view').forEach(v => v.style.display = 'none');
  document.getElementById(id).style.display = 'block';
}
