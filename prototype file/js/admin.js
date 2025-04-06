    // ================================
// 0) 页面加载时检查登录状态
// ================================
// 在页面加载时初始化
document.addEventListener('DOMContentLoaded', () => {
    document.getElementById("year").textContent = new Date().getFullYear();
    setupEventListeners();
    checkAuth();
    loadLogs(1);
    loadMovieTypes();
});

// 前端保存的静态数据，用于演示
let usersData = [ /* ... */ ];
const bookingsData = [

];
const moviesData = [

];
const promotionsData = [
];
const reviewsData = [
];
const logsData = [
];

// ================================
// 登录检测：localStorage 存储状态
// ================================
async function checkAuth() {
    const token = localStorage.getItem('adminToken');
    if (token) {
        document.getElementById("login-screen").style.display = "none";
        document.getElementById("admin-system").style.display = "block";
        
        // 加载所有数据
        loadMovies();
        loadPromotions();
        fetchUsers();
        fetchBookings();
        loadLogs();
    } else {
        document.getElementById("login-screen").style.display = "block";
        document.getElementById("admin-system").style.display = "none";
    }
}

// ================================
// 登录逻辑
// ================================
async function login() {
    const username = document.getElementById("login-username").value.trim();
    const password = document.getElementById("login-password").value.trim();

    if (!username || !password) {
        alert("Please enter both username and password!");
        return;
    }

    try {
        const response = await fetch('/api/admin/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                username: username.toLowerCase(),
                password: password
            })
        });

        const data = await response.json();

        if (data.success) {
            localStorage.setItem('adminToken', data.token);
            document.getElementById("login-screen").style.display = "none";
            document.getElementById("admin-system").style.display = "block";
            localStorage.setItem('adminData',JSON.stringify(data.admin))
            // 加载所有数据
            loadMovies();
            loadPromotions();
            fetchUsers();
            fetchBookings();
            loadLogs();
            fetchReviews();
        } else {
            alert(data.error || 'Login failed! Please try again.');
        }
    } catch (error) {
        console.error('Error during login:', error);
        alert('Login failed! Please try again.');
    }
}

// 设置所有事件监听器
function setupEventListeners() {
    // 避免重复添加事件监听器
    if (isEventListenersSet) {
        return;
    }
    isEventListenersSet = true;

    // 用户管理
    document.getElementById("btn-view-users").addEventListener("click", fetchUsers);
    document.getElementById("btn-search-users-toggle").addEventListener("click", () => {
        document.getElementById("search-users-form").classList.toggle("hidden");
    });
    document.getElementById("btn-search-users").addEventListener("click", searchUsers);

    // 预订管理
    document.getElementById("btn-view-bookings").addEventListener("click", fetchBookings);
    document.getElementById("btn-filter-bookings-toggle").addEventListener("click", () => {
        document.getElementById("filter-bookings-form").classList.toggle("hidden");
    });
    document.getElementById("btn-filter-bookings").addEventListener("click", filterBookings);

    // 电影管理
    document.getElementById("btn-view-movies").addEventListener("click", loadMovies);
    document.getElementById("btn-add-movie-toggle").addEventListener("click", () => {
        resetMovieForm(); // 重置表单
        document.getElementById("modal-add-movie").style.display = "flex";
        loadMovieTypes();
    });
    document.getElementById("modal-add-movie-close").addEventListener("click", () => {
        document.getElementById("modal-add-movie").style.display = "none";
        resetMovieForm(); // 关闭时重置表单
    });

    const submitMovieButton = document.getElementById("btn-submit-new-movie");
    submitMovieButton.addEventListener("click", handleMovieSubmit);

    // 会员管理
    document.getElementById("btn-view-members").addEventListener("click", () => {
        fetch('/api/admin/membership/list', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
        }).then(res=>res.json()).then(res=>{
            let table = document.getElementById("membership-table-body")
            table.innerHTML = "";
            res.data.forEach(e=>{
                const tr = document.createElement("tr");
                tr.innerHTML = `
                    <td>${e.id}</td>
                    <td>${e.level}</td>
                    <td>${e.username}</td>
                    <td>
                        <button class="button" onclick="editMembership(${e.id})">Edit</button>
                    </td>
                `;
                table.appendChild(tr);
            })
        });
    });

    // 促销管理相关变量
    let editPromotionType = false;
    let currentPromoId = null;
    let submitHandler = null;

    document.getElementById('btn-view-promotions').addEventListener('click', loadPromotions);
    document.getElementById('btn-add-promo-toggle').addEventListener('click', () => {
        resetPromoForm();
        document.getElementById('modal-add-promo').style.display = 'flex';
    });

    document.getElementById('modal-add-promo-close').addEventListener('click', () => {
        document.getElementById('modal-add-promo').style.display = 'none';
        resetPromoForm();
    });

    // 移除旧的事件监听器并添加新的
    const submitButton = document.getElementById('btn-submit-new-promo');
    if (submitHandler) {
        submitButton.removeEventListener('click', submitHandler);
    }
    submitHandler = handlePromoSubmit;
    submitButton.addEventListener('click', submitHandler);

    // 评论管理
    document.getElementById("btn-view-reviews").addEventListener("click", () => {
        fetchReviews();
    });

    const prevPageBtn = document.getElementById('prev-page');
    const nextPageBtn = document.getElementById('next-page');
    
    prevPageBtn.addEventListener('click', () => {
        console.log('Previous page clicked, current page:', currentPage);
        if (currentPage > 1) {
            loadLogs(currentPage - 1);
        }
    });
    
    nextPageBtn.addEventListener('click', () => {
        console.log('Next page clicked, current page:', currentPage, 'total pages:', totalPages);
        if (currentPage < totalPages) {
            loadLogs(currentPage + 1);
        }
    });

    document.getElementById("modal-seat-map-close").addEventListener("click", () => {
        document.getElementById("modal-seat-map").style.display = "none";
    });

    // 登出按钮
    document.getElementById("btn-logout").addEventListener("click", logout);

    // 设置年份
    document.getElementById("year").textContent = new Date().getFullYear();
}

// 重置电影表单
function resetMovieForm() {
    document.getElementById('movie-title').value = '';
    document.getElementById('movie-genre').value = '';
    document.getElementById('movie-director').value = '';
    document.getElementById('movie-duration').value = '';
    document.getElementById('movie-price').value = '';
    document.getElementById('movie-release-year').value = '';
    document.getElementById('movie-rating').value = '';
    document.getElementById('movie-description').value = '';
    document.getElementById('movie-image-url').value = '';
    // 重置提交按钮
    const submitButton = document.getElementById('btn-submit-new-movie');
    submitButton.textContent = 'Add Movie';
    submitButton.onclick = null;
}

// ================================
// 退出逻辑（可选）
// ================================
function logout() {
    // 清除管理员数据
    localStorage.removeItem('adminToken');
    // 显示登录界面，隐藏管理系统
    document.getElementById('login-screen').style.display = 'block';
    document.getElementById('admin-system').style.display = 'none';
}

// ================================
// 1) USER MANAGEMENT (本地静态数据)
// ================================
async function fetchUsers() {
    try {
      //  const adminData = JSON.parse(localStorage.getItem('adminData'));
        const response = await fetch('/api/admin/users', {

        });
        
        if (!response.ok) {
            throw new Error('Failed to fetch users');
        }

        usersData = await response.json();
        renderUserTable(usersData);
    } catch (error) {
        console.error('Error fetching users:', error);
        alert('Failed to load users. Please try again.');
    }
}

function renderUserTable(users) {
    const userTableBody = document.getElementById("user-table-body");
    userTableBody.innerHTML = "";
    users.forEach(u => {
        const tr = document.createElement("tr");
        tr.innerHTML = `
            <td>${u.id}</td>
            <td>${u.username}</td>
            <td>${u.email}</td>
            <td>
                <button class="button" onclick="editUser(${u.id})">Edit</button>
                <button class="button danger" onclick="deleteUser(${u.id})">Delete</button>
            </td>
        `;
        userTableBody.appendChild(tr);
    });
}

async function searchUsers() {
    try {
        const searchTerm = document.getElementById('search-users-input').value;
        const adminData = JSON.parse(localStorage.getItem('adminData'));
        
        const response = await fetch(`/api/admin/users/search?query=${encodeURIComponent(searchTerm)}`, {
            headers: {
                'username': adminData.username
            }
        });
        
        if (!response.ok) {
            throw new Error('搜索失败');
        }

        const users = await response.json();
        renderUserTable(users);
    } catch (error) {
        console.error('搜索用户时出错:', error);
        alert('搜索失败，请重试');
    }
}
function editMembership(id){
    const newlevel = prompt("Enter new level:");
    if (!newlevel) return;
    fetch('/api/admin/membership/update', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            id: id,
            level: newlevel
        })
    }).then(res=>res.json()).then(res=>{
        document.getElementById("btn-view-members").click();
    })
}

async function editUser(userId) {
    const user = usersData.find(u => u.id === userId);
    if (!user) return;
    
    const newUsername = prompt("Enter new username:", user.username);
    const newEmail = prompt("Enter new email:", user.email);
    if (!newUsername || !newEmail) return;

    try {
        const adminData = JSON.parse(localStorage.getItem('adminData'));
        const response = await fetch(`/api/admin/users/${userId}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
                'username': adminData.username,
                'password': 'admin123'
            },
            body: JSON.stringify({
                username: newUsername,
                email: newEmail
            })
        });

        if (!response.ok) {
            throw new Error('Failed to update user');
        }

        alert('User updated successfully');
        fetchUsers();
    } catch (error) {
        console.error('Error updating user:', error);
        alert('Failed to update user. Please try again.');
    }
}

async function deleteUser(userId) {
    if (!confirm('Are you sure you want to delete this user?')) return;

    try {
        const adminData = JSON.parse(localStorage.getItem('adminData'));
        const response = await fetch(`/api/admin/users/${userId}`, {
            method: 'DELETE',
            headers: {
                'username': adminData.username,
                'password': 'admin123'
            }
        });

        if (!response.ok) {
            throw new Error('Failed to delete user');
        }

        alert('User deleted successfully');
        fetchUsers();
    } catch (error) {
        console.error('Error deleting user:', error);
        alert('Failed to delete user. Please try again.');
    }
}

// ================================
// 2) BOOKING MANAGEMENT
// ================================
async function fetchBookings() {
    try {
        const response = await fetch('/api/bookings');
        const data = await response.json();
        
        if (data.success) {
            renderBookings(data.data);
        } else {
            console.error('Failed to fetch bookings:', data.error);
        }
    } catch (error) {
        console.error('Error fetching bookings:', error);
    }
}

function renderBookings(bookings) {
    const tbody = document.getElementById('booking-table-body');
    tbody.innerHTML = '';
    
    bookings.forEach(booking => {
        // 格式化时间
        const date = new Date(booking.showTime);
        const formattedTime = date.toLocaleString('en-US', {
            year: 'numeric',
            month: '2-digit',
            day: '2-digit',
            hour: '2-digit',
            minute: '2-digit',
            hour12: false
        });

        const tr = document.createElement('tr');
        tr.innerHTML = `
            <td>${booking.id}</td>
            <td>${booking.userName}</td>
            <td>${booking.movieTitle}</td>
            <td>${booking.seat_number}</td>
            <td>${formattedTime}</td>
            <td>
                <button class="button danger" onclick="deleteBooking(${booking.id})">Delete</button>
            </td>
        `;
        tbody.appendChild(tr);
    });
}

async function deleteBooking(bookingId) {
    if (!confirm('Are you sure you want to delete this booking?')) return;
    
    try {
        const response = await fetch(`/api/bookings/${bookingId}`, {
            method: 'DELETE'
        });
        const data = await response.json();
        
        if (data.success) {
            alert('Booking deleted successfully');
            fetchBookings(); // 刷新列表
        } else {
            alert('Failed to delete booking: ' + data.error);
        }
    } catch (error) {
        console.error('Error deleting booking:', error);
        alert('Error deleting booking. Please try again.');
    }
}

async function filterBookings() {
    const userName = document.getElementById('filter-user-id').value;
    const bookingId = document.getElementById('filter-movie-id').value;
    
    try {
        let url = '/api/bookings';
        const params = new URLSearchParams();
        
        if (userName) params.append('userName', userName);
        if (bookingId) params.append('bookingId', bookingId);
        
        // 只有在有参数的情况下才添加 ? 
        if (params.toString()) {
            url += '?' + params.toString();
        }
        
        const response = await fetch(url);
        const data = await response.json();
        
        if (data.success) {
            renderBookings(data.data);
        } else {
            console.error('Failed to filter bookings:', data.error);
        }
    } catch (error) {
        console.error('Error filtering bookings:', error);
    }
}

// ================================
// 3) MOVIE MANAGEMENT
// ================================
async function loadMovies() {
    try {
        const response = await fetch('/api/movies');
        const data = await response.json();
        
        if (data.success) {
            const movieTableBody = document.getElementById('movie-table-body');
            movieTableBody.innerHTML = '';
            
            data.data.forEach(movie => {
                const tr = document.createElement('tr');
                tr.innerHTML = `
                    <td>${movie.id}</td>
                    <td>${movie.title}</td>
                    <td>${movie.type?.name || 'N/A'}</td>
                    <td>${movie.director || 'N/A'}</td>
                    <td>${movie.duration || 'N/A'}</td>
                    <td>${movie.price ? '¥' + movie.price : 'N/A'}</td>
                    <td>${movie.releaseYear || 'N/A'}</td>
                    <td>${movie.rating || 'N/A'}</td>
                    <td>
                        <button class="button warning" onclick="editMovie(${movie.id})">Edit</button>
                        <button class="button danger" onclick="deleteMovie(${movie.id})">Delete</button>
                    </td>
                `;
                movieTableBody.appendChild(tr);
            });

            // 显示电影表格
            document.getElementById('movie-table').style.display = 'block';
        } else {
            console.error('Failed to load movies:', data.error);
            alert('Failed to load movies: ' + data.error);
        }
    } catch (error) {
        console.error('Error loading movies:', error);
        alert('Failed to load movies. Please try again.');
    }
}

async function loadMovieTypes() {
    try {
        const response = await fetch('/api/types');
        const data = await response.json();
        
        if (data.success) {
            const select = document.getElementById('movie-genre');
            select.innerHTML = '<option value="">Select a type</option>' + 
                data.types.map(type => `
                    <option value="${type.id}">${type.name}</option>
                `).join('');
        }
    } catch (error) {
        console.error('Error loading movie types:', error);
    }
}

async function deleteMovie(movieId) {
    if (!confirm('Are you sure you want to delete this movie?')) {
        return;
    }

    try {
        const response = await fetch(`/api/movies/${movieId}`, {
            method: 'DELETE'
        });
        const data = await response.json();

        if (data.success) {
            alert('Movie deleted successfully');
            loadMovies();
        } else {
            alert('Failed to delete movie: ' + data.error);
        }
    } catch (error) {
        console.error('Error deleting movie:', error);
        alert('Failed to delete movie. Please try again.');
    }
}

async function addMovie() {
    const title = document.getElementById('movie-title').value;
    const type_id = document.getElementById('movie-genre').value;
    const director = document.getElementById('movie-director').value;
    const duration = document.getElementById('movie-duration').value;
    const price = document.getElementById('movie-price').value;
    const releaseYear = document.getElementById('movie-release-year').value;
    const rating = document.getElementById('movie-rating').value;
    const description = document.getElementById('movie-description').value;
    const imageUrl = document.getElementById('movie-image-url').value;

    if (!title || !type_id || !director || !duration || !price || !releaseYear) {
        alert('Please fill in all required fields.');
        return;
    }

    try {
        const response = await fetch('/api/movies', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                title,
                type_id,
                director,
                duration: parseInt(duration),
                price: parseFloat(price),
                release_year: parseInt(releaseYear),
                rating: rating ? parseFloat(rating) : null,
                description,
                image_url: imageUrl
            })
        });

        const data = await response.json();
        
        if (data.success) {
            alert('Movie added successfully!');
            document.getElementById('modal-add-movie').style.display = 'none';
            
            // Clear form
            document.getElementById('movie-title').value = '';
            document.getElementById('movie-genre').value = '';
            document.getElementById('movie-director').value = '';
            document.getElementById('movie-duration').value = '';
            document.getElementById('movie-price').value = '';
            document.getElementById('movie-release-year').value = '';
            document.getElementById('movie-rating').value = '';
            document.getElementById('movie-description').value = '';
            document.getElementById('movie-image-url').value = '';
            
            loadMovies(); // Reload movie list
        } else {
            alert('Failed to add movie: ' + (data.error || 'Unknown error'));
        }
    } catch (error) {
        console.error('Error adding movie:', error);
        alert('Failed to add movie. Please try again.');
    }
}

async function editMovie(movieId) {
    try {
        // 确保先加载电影类型
        await loadMovieTypes();
        
        const response = await fetch(`/api/movies/${movieId}`);
        const data = await response.json();
        
        if (data.success) {
            const movie = data.data;
            console.log('Movie data:', movie); // 调试用
            
            // 填充表单
            document.getElementById('movie-title').value = movie.title;
            document.getElementById('movie-director').value = movie.director;
            document.getElementById('movie-duration').value = movie.duration;
            document.getElementById('movie-price').value = movie.price;
            document.getElementById('movie-release-year').value = movie.releaseYear;
            document.getElementById('movie-rating').value = movie.rating || '';
            document.getElementById('movie-description').value = movie.description || '';
            document.getElementById('movie-image-url').value = movie.image || '';
            document.getElementById('movie-genre').value = movie.type_id;

            
            
            // 更改模态框标题和按钮文本
            document.querySelector('#modal-add-movie h3').textContent = 'Edit Movie';
            const submitButton = document.getElementById('btn-submit-new-movie');
            submitButton.textContent = 'Update Movie';
            submitButton.dataset.movieId = movieId;
            
            // 显示模态框
            document.getElementById('modal-add-movie').style.display = 'flex';
        } else {
            throw new Error(data.message || 'Failed to load movie');
        }
    } catch (error) {
        console.error('Error fetching movie:', error);
        alert('Failed to load movie details: ' + error.message);
    }
}

async function handleMovieSubmit(event) {
    event.preventDefault();
    const submitButton = document.getElementById('btn-submit-new-movie');
    const movieId = submitButton.dataset.movieId;
    const isEdit = !!movieId;

    const formData = {
        title: document.getElementById('movie-title').value,
        type_id: document.getElementById('movie-genre').value,  // 使用type_id
        director: document.getElementById('movie-director').value,
        duration: document.getElementById('movie-duration').value,
        price: document.getElementById('movie-price').value,
        release_year: document.getElementById('movie-release-year').value,
        rating: document.getElementById('movie-rating').value,
        description: document.getElementById('movie-description').value,
        image_url: document.getElementById('movie-image-url').value
    };

    try {
        const url = isEdit ? `/api/movies/${movieId}` : '/api/movies';
        const method = isEdit ? 'PUT' : 'POST';
        
        const response = await fetch(url, {
            method: method,
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(formData)
        });

        const data = await response.json();

        if (data.success) {
            alert(isEdit ? 'Movie updated successfully!' : 'Movie added successfully!');
            document.getElementById('modal-add-movie').style.display = 'none';
            loadMovies();
            resetMovieForm();
        } else {
            throw new Error(data.message || 'Operation failed');
        }
    } catch (error) {
        console.error('Error:', error);
        alert('Failed to ' + (isEdit ? 'update' : 'add') + ' movie: ' + error.message);
    }
}

// On close modal, reset state
document.getElementById('modal-add-movie-close').addEventListener('click', () => {
    document.querySelector('#modal-add-movie h3').textContent = 'Add New Movie';
    const submitButton = document.getElementById('btn-submit-new-movie');
    submitButton.textContent = 'Add Movie';
    if (submitButton.dataset.movieId) {
        delete submitButton.dataset.movieId;
    }
    document.getElementById('movie-title').value = '';
    document.getElementById('movie-genre').value = '';
    document.getElementById('movie-director').value = '';
    document.getElementById('movie-duration').value = '';
    document.getElementById('movie-price').value = '';
    document.getElementById('movie-release-year').value = '';
    document.getElementById('movie-rating').value = '';
    document.getElementById('movie-description').value = '';
    document.getElementById('movie-image-url').value = '';
});

// ================================
// 4) MEMBER MANAGEMENT (演示)
// ================================
function updateTier() {
    const userId = prompt("Enter user ID to update membership tier:");
    if(!userId) return;
    const user = usersData.find(u => u.id.toString() === userId);
    if(!user) {
        alert("User not found");
        return;
    }
    const newTier = prompt("Enter new tier: Basic/Silver/Gold/Platinum", user.membership);
    if(!newTier) return;
    user.membership = newTier;
    alert(`Membership updated for user #${user.id} to ${newTier}`);
    renderUserTable(usersData);
}

// ================================
// 5) PROMOTIONS
// ================================
async function loadPromotions() {
    try {
        const response = await fetch('/api/promos');
        const data = await response.json();
        
        if (data.success) {
            const promos = data.promotions || data.data || [];  // 兼容不同的数据结构
            const tbody = document.getElementById('promo-table-body');
            tbody.innerHTML = '';
            
            if (promos && promos.length > 0) {
                promos.forEach(promo => {
                    const tr = document.createElement('tr');
                    const editBtn = document.createElement('button');
                    editBtn.className = 'button info';
                    editBtn.textContent = 'Edit';
                    editBtn.onclick = () => editPromotion(promo.id);

                    const deleteBtn = document.createElement('button');
                    deleteBtn.className = 'button danger';
                    deleteBtn.textContent = 'Delete';
                    deleteBtn.onclick = () => deletePromotion(promo.id);

                    tr.innerHTML = `
                        <td>${promo.id || ''}</td>
                        <td>${promo.name }</td>
                        <td>${promo.discount }%</td>
                        <td>${promo.start_date ? new Date(promo.start_date).toLocaleDateString() : ''}</td>
                        <td>${promo.end_date ? new Date(promo.end_date).toLocaleDateString() : ''}</td>
                        <td></td>
                    `;
                    const actionCell = tr.querySelector('td:last-child');
                    actionCell.appendChild(editBtn);
                    actionCell.appendChild(deleteBtn);
                    
                    tbody.appendChild(tr);
                });
            } else {
                // 如果没有数据，显示提示信息
                const tr = document.createElement('tr');
                tr.innerHTML = '<td colspan="5" style="text-align: center;">No promotions found</td>';
                tbody.appendChild(tr);
            }
        } else {
            console.error('Failed to load promotions:', data.message || 'Unknown error');
            alert('Failed to load promotions. Please try again.');
        }
    } catch (error) {
        console.error('Error loading promotions:', error);
        alert('Failed to load promotions. Please check your connection and try again.');
    }
}

async function addPromotion() {

    const name = document.getElementById('promo-name').value;
    const discount = document.getElementById('promo-discount').value;
    const startDate = document.getElementById('promo-start-date').value;
    const endDate = document.getElementById('promo-end-date').value;

    if (!name || !discount || !startDate || !endDate) {
        alert('Please fill in all fields');
        return;
    }

    try {
        const response = await fetch('/api/promos', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                name,
                discount: parseFloat(discount),
                start_date: startDate,
                end_date: endDate
            })
        });

        const data = await response.json();
        
        if (data.success) {
            alert('Promotion added successfully');
            document.getElementById('modal-add-promo').style.display = 'none';
            resetPromoForm();
            loadPromotions();
        } else {
            alert('Failed to add promotion: ' + data.error);
        }
    } catch (error) {
        console.error('Error adding promotion:', error);
        alert('Failed to add promotion. Please try again.');
    }
}

async function editPromotion(promoId) {
    editPromotionType = true;
    currentPromoId = promoId;
    
    try {
        const response = await fetch(`/api/promos/${promoId}`);
        const data = await response.json();
        
        if (data.success) {
            const promo = data.promotion || data.data;  // 兼容不同的数据结构
            if (!promo) {
                throw new Error('No promotion data received');
            }
            
            // 填充表单
            document.getElementById('promo-name').value = promo.name || '';
            document.getElementById('promo-discount').value = promo.discount || '';
            document.getElementById('promo-start-date').value = promo.start_date ? promo.start_date.split('T')[0] : '';
            document.getElementById('promo-end-date').value = promo.end_date ? promo.end_date.split('T')[0] : '';
            
            // 设置编辑状态
            editPromotionType = true;
            currentPromoId = promoId;
            
            // 更改模态框标题和按钮文本
            document.querySelector('#modal-add-promo h3').textContent = 'Edit Promotion';
            document.getElementById('btn-submit-new-promo').textContent = 'Update';
            
            // 显示模态框
            document.getElementById('modal-add-promo').style.display = 'flex';
        } else {
            throw new Error(data.message || 'Failed to load promotion');
        }
    } catch (error) {
        console.error('Error fetching promotion:', error);
        alert('Failed to load promotion details: ' + error.message);
    }
}

async function updatePromotion(promoId) {
    const name = document.getElementById('promo-name').value;
    const discount = document.getElementById('promo-discount').value;
    const startDate = document.getElementById('promo-start-date').value;
    const endDate = document.getElementById('promo-end-date').value;

    if (!name || !discount || !startDate || !endDate) {
        alert('Please fill in all required fields');
        return;
    }

    try {
        const response = await fetch(`/api/promos/${promoId}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                name,
                discount: parseFloat(discount),
                start_date: startDate,
                end_date: endDate
            })
        });

        const data = await response.json();

        if (data.success) {
            alert('Promotion updated successfully');
            document.getElementById('modal-add-promo').style.display = 'none';
            resetPromoForm();
            await loadPromotions();  // 重新加载列表
        } else {
            alert('Failed to update promotion: ' + (data.message || 'Unknown error'));
        }
    } catch (error) {
        console.error('Error updating promotion:', error);
        alert('Failed to update promotion. Please try again.');
    }
}

async function deletePromotion(promoId) {
    if (!confirm('Are you sure you want to delete this promotion?')) {
        return;
    }

    try {
        const response = await fetch(`/api/promos/${promoId}`, {
            method: 'DELETE'
        });

        const data = await response.json();
        
        if (data.success) {
            alert('Promotion deleted successfully');
            await loadPromotions();
        } else {
            alert('Failed to delete promotion: ' + (data.message || 'Unknown error'));
        }
    } catch (error) {
        console.error('Error deleting promotion:', error);
        alert('Failed to delete promotion. Please try again.');
    }
}

function resetPromoForm() {
    editPromotionType = false;
    currentPromoId = null;
    document.getElementById('promo-name').value = '';
    document.getElementById('promo-discount').value = '';
    document.getElementById('promo-start-date').value = '';
    document.getElementById('promo-end-date').value = '';
    document.querySelector('#modal-add-promo h3').textContent = 'Create New Promotion';
    document.getElementById('btn-submit-new-promo').textContent = 'Create';
}

// 处理促销表单提交
async function handlePromoSubmit(event) {
    if (event) {
        event.preventDefault();
        event.stopPropagation();
    }
    
    console.log('Submit type:', editPromotionType ? 'update' : 'create', 'ID:', currentPromoId);
    
    try {
        if (editPromotionType && currentPromoId) {
            await updatePromotion(currentPromoId);
        } else {
            await addPromotion();
        }
    } catch (error) {
        console.error('Error submitting promotion:', error);
        alert('An error occurred while saving the promotion.');
    }
}

// ================================
// 6) REVIEWS
// ================================
function fetchReviews() {
        fetch('/api/bookings/comment/list',{
        method:'POST'
       }).then(res=>res.json()).then(res=>{
            renderReviews(res.data);
       })

}
function renderReviews(revs) {
    const reviewTableBody = document.getElementById("review-table-body");
    reviewTableBody.innerHTML = "";
    revs.forEach(r => {
        const tr = document.createElement("tr");
        tr.innerHTML = `
            <td>${r.id}</td>
            <td>${r.title}</td>
            <td>${r.username}</td>
            <td>${r.rating ?? "-"}</td>
            <td>${r.text ?? ""}</td>
            <td>
                <button class="button danger" onclick="deleteReview(${r.id})">Delete</button>
            </td>
        `;
        reviewTableBody.appendChild(tr);
    });
}
function deleteReview(rid) {
    if(!confirm("Delete review #" + rid + "?")) return;
    fetch('/api/bookings/comment/del',{
        method:'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body:JSON.stringify({id:rid})
       }).then(res=>res.json()).then(res=>{
             alert("Review deleted.");
             fetchReviews();
       })

}
function approveReview(rid) {
    alert("Review approved (demo)!");
}

// ================================
// 8) LOGS
// ================================
let currentPage = 1;
let totalPages = 1;

async function loadLogs(page = 1) {
    try {
        const response = await fetch(`/api/admin/logs?page=${page}&pageSize=10`);
        const data = await response.json();
        
        if (data.success) {
            const tableBody = document.getElementById('logs-table-body');
            tableBody.innerHTML = '';
            
            data.logs.forEach(log => {
                const tr = document.createElement('tr');
                const time = new Date(log.created_at).toLocaleString();
                
                tr.innerHTML = `
                    <td>${time}</td>
                    <td>${log.action}</td>
                    <td>${log.username || '-'}</td>
                `;
                tableBody.appendChild(tr);
            });
            
            // 更新分页信息
            currentPage = page;
            totalPages = Math.ceil(data.pagination.total / data.pagination.pageSize);
            document.getElementById('page-info').textContent = `Page ${currentPage} of ${totalPages}`;
            
            // 更新按钮状态
            document.getElementById('prev-page').disabled = currentPage <= 1;
            document.getElementById('next-page').disabled = currentPage >= totalPages;
        } else {
            console.error('Failed to load logs:', data.error);
        }
    } catch (error) {
        console.error('Error loading logs:', error);
    }
}

// ================================
// 9) SEAT MAP MANAGEMENT
// ================================
document.getElementById("btn-show-seat-map").addEventListener("click",()=>{
    document.getElementById("modal-seat-map").style.display = "flex";
    loadSeatMap()
})
function loadSeatMap() {
    const seatMapContainer = document.getElementById("seat-map");
    seatMapContainer.innerHTML = "";
    // 简单示例：40个座位
    const occupied = [5, 6, 12, 13, 21, 31];

    fetch('/api/admin/seats',{
        method:'POST'
    }).then(res=>res.json()).then(res=>{
        res.data.forEach(e=>{
            const seatDiv = document.createElement("div");
            seatDiv.classList.add("seat");
            seatDiv.textContent = e.text;
            if(e.status == 2) {
                seatDiv.classList.add("occupied");
            }
            seatDiv.addEventListener("click", () => toggleSeat(seatDiv,e));
            seatMapContainer.appendChild(seatDiv);
        })

    })


}
function toggleSeat(seatDiv,item) {
    if(item.status == 2){
        fetch('/api/admin/seats/status',{
            method:'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                status: 1,
                id: item.id
            })
        }).then(res=>res.json()).then(res=>{
            loadSeatMap();
        })
    }else{
        fetch('/api/admin/seats/status',{
            method:'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                status: 2,
                id: item.id
            })
        }).then(res=>res.json()).then(res=>{
            loadSeatMap();
        })
       
    };
}
function saveSeatMap() {
    alert("Seat layout saved (demo).");
    document.getElementById("modal-seat-map").style.display = "none";
}

let isEventListenersSet = false;