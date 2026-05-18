<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In — Student Registration System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root {
            --primary:      #6366f1;
            --primary-dark: #4f46e5;
        }

        body {
            background: linear-gradient(135deg, #0f172a 0%, #1e1b4b 50%, #0f172a 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', system-ui, sans-serif;
        }

        /* Background dots pattern */
        body::before {
            content: '';
            position: fixed;
            inset: 0;
            background-image: radial-gradient(circle at 1px 1px, rgba(255,255,255,0.04) 1px, transparent 0);
            background-size: 36px 36px;
            pointer-events: none;
        }

        .login-wrapper {
            width: 100%;
            max-width: 440px;
            padding: 1rem;
            position: relative;
            z-index: 1;
        }

        .login-card {
            background: #ffffff;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 25px 60px rgba(0,0,0,0.45), 0 0 0 1px rgba(255,255,255,0.05);
        }

        .login-header {
            background: linear-gradient(135deg, var(--primary) 0%, #818cf8 100%);
            padding: 2.25rem 2rem 2rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .login-header::before {
            content: '';
            position: absolute;
            top: -40px; right: -40px;
            width: 140px; height: 140px;
            border-radius: 50%;
            background: rgba(255,255,255,0.08);
        }

        .login-header::after {
            content: '';
            position: absolute;
            bottom: -50px; left: -30px;
            width: 120px; height: 120px;
            border-radius: 50%;
            background: rgba(255,255,255,0.06);
        }

        .brand-logo {
            width: 64px; height: 64px;
            background: rgba(255,255,255,0.18);
            border: 2px solid rgba(255,255,255,0.3);
            border-radius: 18px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.6rem;
            color: #fff;
            margin-bottom: 1rem;
            position: relative;
            z-index: 1;
            backdrop-filter: blur(4px);
        }

        .login-header h1 {
            color: #fff;
            font-size: 1.35rem;
            font-weight: 800;
            margin-bottom: 0.3rem;
            position: relative;
            z-index: 1;
        }

        .login-header p {
            color: rgba(255,255,255,0.7);
            font-size: 0.85rem;
            margin: 0;
            position: relative;
            z-index: 1;
        }

        .login-body {
            padding: 2rem;
        }

        .form-label {
            font-size: 0.8rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #475569;
            margin-bottom: 0.4rem;
        }

        .input-group-text {
            background: #f8fafc;
            border-right: none;
            border-color: #e2e8f0;
            color: #94a3b8;
            border-radius: 10px 0 0 10px;
        }

        .form-control {
            border-left: none;
            border-color: #e2e8f0;
            border-radius: 0 10px 10px 0;
            padding: 0.6rem 0.9rem;
            font-size: 0.9rem;
            color: #1e293b;
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(99,102,241,0.12);
        }

        .form-control:focus + .input-group-text,
        .input-group:focus-within .input-group-text {
            border-color: var(--primary);
        }

        .btn-signin {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            border: none;
            border-radius: 10px;
            padding: 0.7rem;
            font-weight: 700;
            font-size: 0.95rem;
            letter-spacing: 0.3px;
            color: #fff;
            width: 100%;
            transition: all 0.2s;
            box-shadow: 0 4px 14px rgba(99,102,241,0.35);
        }

        .btn-signin:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(99,102,241,0.45);
            background: linear-gradient(135deg, var(--primary-dark) 0%, #3730a3 100%);
            color: #fff;
        }

        .btn-signin:active {
            transform: translateY(0);
        }

        .alert-danger {
            background: #fef2f2;
            border: 1px solid #fecaca;
            color: #dc2626;
            border-radius: 10px;
            font-size: 0.875rem;
        }

        .login-footer {
            text-align: center;
            padding: 0 2rem 1.5rem;
            font-size: 0.78rem;
            color: #94a3b8;
        }
    </style>
</head>
<body>

<div class="login-wrapper">
    <div class="login-card">

        <div class="login-header">
            <div class="brand-logo">
                <i class="fas fa-graduation-cap"></i>
            </div>
            <h1>Student Registration System</h1>
            <p>Sign in as Admin or Student to continue</p>
        </div>

        <div class="login-body">
            <c:if test="${param.registered eq 'true'}">
                <div class="alert alert-success d-flex align-items-center mb-3" role="alert"
                     style="background:#f0fdf4;border:1px solid #bbf7d0;color:#16a34a;border-radius:10px;font-size:0.875rem">
                    <i class="fas fa-check-circle me-2 flex-shrink-0"></i>
                    Registration successful! You can now sign in.
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger d-flex align-items-center mb-3" role="alert">
                    <i class="fas fa-exclamation-circle me-2 flex-shrink-0"></i>
                    <c:out value="${error}"/>
                </div>
            </c:if>

            <form method="post" action="<c:url value='/login'/>">

                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user fa-sm"></i></span>
                        <input type="text" id="username" name="username" class="form-control"
                               placeholder="Enter your username" required autofocus>
                    </div>
                </div>

                <div class="mb-4">
                    <label for="password" class="form-label">Password</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock fa-sm"></i></span>
                        <input type="password" id="password" name="password" class="form-control"
                               placeholder="Enter your password" required>
                    </div>
                </div>

                <button type="submit" class="btn-signin">
                    <i class="fas fa-sign-in-alt me-2"></i>Sign In
                </button>
            </form>
        </div>

        <div class="login-footer">
            New student? <a href="<c:url value='/register'/>"
                style="color:#6366f1;font-weight:600;text-decoration:none">Register here</a>
            &nbsp;&mdash;&nbsp; &copy; 2024 Student Registration System &mdash; SLIIT
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
