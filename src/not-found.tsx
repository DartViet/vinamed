function NotFoundPage() {
    return (
        <div className="container text-center vh-100 d-flex flex-column justify-content-center align-items-center">
        <h1 className="display-1 fw-bold text-danger">404</h1>
        <h2 className="mb-3">Rất tiếc! Không tìm thấy trang</h2>
        <p className="text-muted">Trang bạn đang tìm kiếm có thể đã bị xóa hoặc tạm thời không khả dụng.</p>
        <a href="/" className="btn btn-primary">Trang chủ</a>
    </div>
    );
}

export default NotFoundPage;