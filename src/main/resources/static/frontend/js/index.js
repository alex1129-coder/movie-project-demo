const moviesPerPage = 4; // 每頁9張
let currentPage = 1;

// 從後端 API 取得電影資料
let moviesData = [];

async function fetchMovies() {
    try {
        const response = await fetch('/api/movies');
        if (!response.ok) throw new Error('載入失敗');
        const data = await response.json();
        // 後端欄位: id, title, director, subtitle, rating, description, premiereDate, duration, posterUrl
        moviesData = data.map(m => ({
            title: m.title,
            subtitle: m.subtitle || '',
            director: m.director || '未知導演',
            rating: m.rating || 'PG',
            desc: m.description || '暫無描述',
            img: m.posterUrl || '/frontend/img/no.png', //如果沒有圖片，使用預設圖片
            duration: m.duration || 0,
            premiereDate: m.premiereDate || ''
        }));
        renderMovies();
        renderPagination();
    } catch (e) {
        alert('無法載入電影資料');
    }
}

function renderMovies() {
    const container = document.querySelector('.movie-container');
    container.innerHTML = '';
    const start = (currentPage - 1) * moviesPerPage;
    const end = start + moviesPerPage;
    const pageMovies = moviesData.slice(start, end);

    pageMovies.forEach(movie => {
        const card = document.createElement('div');
        card.className = 'movie-card';
        card.innerHTML = `
                    <img src="${movie.img}" alt="${movie.title}">
                    <div class="movie-card-body">
                        <h3>${movie.title}</h3>
                        <p class="director"><strong>導演:</strong> ${movie.director}</p>
                        ${movie.subtitle ? `<p class="subtitle"><strong>字幕:</strong> ${movie.subtitle}</p>` : ''}
                        <p class="rating"><strong>分級:</strong> ${movie.rating}</p>
                        <p class="description">${movie.desc}</p>
                        ${movie.premiereDate ? `<p class="premiere-date"><strong>上映日期:</strong> ${movie.premiereDate}</p>` : ''}
                        <p class="duration"><strong>片長:</strong> ${movie.duration ? movie.duration + '分鐘' : '未知'}</p>
                    </div>
                `;
        container.appendChild(card);
    });
}

function renderPagination() {
    const pagination = document.getElementById('pagination');
    pagination.innerHTML = '';
    const totalPages = Math.ceil(moviesData.length / moviesPerPage);

    const ul = document.createElement('ul');
    ul.className = 'pagination';

    for (let i = 1; i <= totalPages; i++) {
        const li = document.createElement('li');
        li.className = 'page-item';
        if (i === currentPage) {
            li.classList.add('active');
        }
        const a = document.createElement('a');
        a.className = 'page-link';
        a.href = '#';
        a.innerText = i;
        a.addEventListener('click', (e) => {
            e.preventDefault();
            currentPage = i;
            renderMovies();
            renderPagination();
        });
        li.appendChild(a);
        ul.appendChild(li);
    }
    pagination.appendChild(ul);
}

// 初始化
fetchMovies();

// 檢查會員
function checkMember() {
    fetch('/api/check-member')
        .then(response => response.json())
        .then(data => {
            if (data.isMember) {
                window.location.href = '/booking'; // 如果是會員，跳轉到購票頁面
            } else {
                alert('請先登入會員');
                window.location.href = '/login'; // 如果不是會員，跳轉到登入頁面
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('發生錯誤，請稍後再試');
        });
}

// 為 "購票" 按鈕添加事件監聽器
document.querySelector('nav a[href="checkMember"]').addEventListener('click', function (event) {
    event.preventDefault(); // 防止默認的跳轉行為
    checkMember(); // 呼叫檢查會員的函式
});