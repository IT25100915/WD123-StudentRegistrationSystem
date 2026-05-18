<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Registration — Student Registration System</title>
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
            padding: 2rem 1rem;
        }

        body::before {
            content: '';
            position: fixed;
            inset: 0;
            background-image: radial-gradient(circle at 1px 1px, rgba(255,255,255,0.04) 1px, transparent 0);
            background-size: 36px 36px;
            pointer-events: none;
        }

        .reg-wrapper {
            width: 100%;
            max-width: 580px;
            position: relative;
            z-index: 1;
        }

        .reg-card {
            background: #ffffff;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 25px 60px rgba(0,0,0,0.45), 0 0 0 1px rgba(255,255,255,0.05);
        }

        .reg-header {
            background: linear-gradient(135deg, var(--primary) 0%, #818cf8 100%);
            padding: 2.25rem 2rem 2rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .reg-header::before {
            content: '';
            position: absolute;
            top: -40px; right: -40px;
            width: 140px; height: 140px;
            border-radius: 50%;
            background: rgba(255,255,255,0.08);
        }

        .reg-header::after {
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

        .reg-header h1 {
            color: #fff;
            font-size: 1.35rem;
            font-weight: 800;
            margin-bottom: 0.3rem;
            position: relative;
            z-index: 1;
        }

        .reg-header p {
            color: rgba(255,255,255,0.7);
            font-size: 0.85rem;
            margin: 0;
            position: relative;
            z-index: 1;
        }

        .reg-body {
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

        .form-control, .form-select {
            border-color: #e2e8f0;
            border-radius: 10px;
            padding: 0.6rem 0.9rem;
            font-size: 0.9rem;
            color: #1e293b;
        }

        .form-control.has-icon {
            border-left: none;
            border-radius: 0 10px 10px 0;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(99,102,241,0.12);
        }

        .input-group:focus-within .input-group-text {
            border-color: var(--primary);
        }

        .section-card {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 1.25rem;
            margin-top: 0.5rem;
        }

        .section-label {
            font-size: 0.8rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: var(--primary);
            margin-bottom: 1rem;
        }

        .btn-register {
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

        .btn-register:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(99,102,241,0.45);
            background: linear-gradient(135deg, var(--primary-dark) 0%, #3730a3 100%);
            color: #fff;
        }

        .btn-register:active { transform: translateY(0); }

        .alert-danger {
            background: #fef2f2;
            border: 1px solid #fecaca;
            color: #dc2626;
            border-radius: 10px;
            font-size: 0.875rem;
        }

        .reg-footer {
            text-align: center;
            padding: 0 2rem 1.5rem;
            font-size: 0.82rem;
            color: #64748b;
        }

        .reg-footer a {
            color: var(--primary);
            font-weight: 600;
            text-decoration: none;
        }

        .reg-footer a:hover { text-decoration: underline; }
    </style>
</head>
<body>

<div class="reg-wrapper">
    <div class="reg-card">

        <div class="reg-header">
            <div class="brand-logo">
                <i class="fas fa-user-plus"></i>
            </div>
            <h1>Create Your Account</h1>
            <p>Student Registration &mdash; Fill in your details below</p>
        </div>

        <div class="reg-body">
            <c:if test="${not empty error}">
                <div class="alert alert-danger d-flex align-items-center mb-3" role="alert">
                    <i class="fas fa-exclamation-circle me-2 flex-shrink-0"></i>
                    <c:out value="${error}"/>
                </div>
            </c:if>

            <form method="post" action="<c:url value='/register'/>" novalidate id="regForm">
                <div class="row g-3">

                    <div class="col-md-6">
                        <label for="studentId" class="form-label">Student ID <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-id-badge fa-sm"></i></span>
                            <input type="text" id="studentId" name="studentId" class="form-control has-icon"
                                   placeholder="e.g. IT25100001" required>
                        </div>
                        <div class="invalid-feedback">Student ID is required.</div>
                    </div>

                    <div class="col-md-6">
                        <label for="fullName" class="form-label">Full Name <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-user fa-sm"></i></span>
                            <input type="text" id="fullName" name="fullName" class="form-control has-icon"
                                   placeholder="Enter your full name" required>
                        </div>
                        <div class="invalid-feedback">Full name is required.</div>
                    </div>

                    <div class="col-md-6">
                        <label for="email" class="form-label">Email Address <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-envelope fa-sm"></i></span>
                            <input type="email" id="email" name="email" class="form-control has-icon"
                                   placeholder="you@sliit.lk" required>
                        </div>
                        <div class="invalid-feedback">Please enter a valid email.</div>
                    </div>

                    <div class="col-md-6">
                        <label for="phone" class="form-label">Phone Number</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-phone fa-sm"></i></span>
                            <input type="text" id="phone" name="phone" class="form-control has-icon"
                                   placeholder="+94 77 123 4567">
                        </div>
                    </div>

                    <div class="col-md-6">
                        <label for="studentType" class="form-label">Student Type <span class="text-danger">*</span></label>
                        <select id="studentType" name="studentType" class="form-select" required onchange="toggleType()">
                            <option value="">-- Select Type --</option>
                            <option value="Undergraduate">Undergraduate</option>
                            <option value="Postgraduate">Postgraduate</option>
                        </select>
                        <div class="invalid-feedback">Please select your student type.</div>
                    </div>

                    <div class="col-12" id="ugSection" style="display:none">
                        <div class="section-card">
                            <div class="section-label"><i class="fas fa-layer-group me-1"></i>Undergraduate Details</div>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="yearOfStudy" class="form-label">Year of Study <span class="text-danger">*</span></label>
                                    <input type="number" id="yearOfStudy" name="yearOfStudy" class="form-control"
                                           min="1" max="4" placeholder="1 – 4">
                                    <div class="invalid-feedback">Year of study is required.</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-12" id="pgSection" style="display:none">
                        <div class="section-card">
                            <div class="section-label" style="color:#8b5cf6"><i class="fas fa-scroll me-1"></i>Postgraduate Details</div>
                            <div class="row g-3">
                                <div class="col-12">
                                    <label for="thesisTitle" class="form-label">Thesis Title</label>
                                    <input type="text" id="thesisTitle" name="thesisTitle" class="form-control"
                                           placeholder="Enter your thesis title (optional)">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <label for="password" class="form-label">Password <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-lock fa-sm"></i></span>
                            <input type="password" id="password" name="password" class="form-control has-icon"
                                   placeholder="Create a password" required minlength="6">
                        </div>
                        <div class="invalid-feedback">Password must be at least 6 characters.</div>
                    </div>

                    <div class="col-md-6">
                        <label for="confirmPassword" class="form-label">Confirm Password <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-lock fa-sm"></i></span>
                            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control has-icon"
                                   placeholder="Re-enter your password" required>
                        </div>
                        <div class="invalid-feedback">Please confirm your password.</div>
                        <div id="pwMismatch" class="text-danger mt-1" style="font-size:0.8rem;display:none">
                            <i class="fas fa-exclamation-triangle me-1"></i>Passwords do not match.
                        </div>
                    </div>

                </div>

                <hr class="my-4" style="border-color:#e2e8f0">

                <button type="submit" class="btn-register">
                    <i class="fas fa-user-plus me-2"></i>Register Now
                </button>
            </form>
        </div>

        <div class="reg-footer">
            Already registered? <a href="<c:url value='/login'/>">Sign in here</a>
            &nbsp;&mdash;&nbsp; &copy; 2024 Student Registration System &mdash; SLIIT
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function toggleType() {
        const type = document.getElementById('studentType').value;
        document.getElementById('ugSection').style.display = type === 'Undergraduate' ? 'block' : 'none';
        document.getElementById('pgSection').style.display = type === 'Postgraduate'  ? 'block' : 'none';
        document.getElementById('yearOfStudy').required = (type === 'Undergraduate');
    }

    (() => {
        'use strict';
        const form = document.getElementById('regForm');
        const pw  = document.getElementById('password');
        const cpw = document.getElementById('confirmPassword');
        const msg = document.getElementById('pwMismatch');

        cpw.addEventListener('input', () => {
            msg.style.display = (pw.value !== cpw.value && cpw.value.length > 0) ? 'block' : 'none';
        });

        form.addEventListener('submit', e => {
            if (pw.value !== cpw.value) {
                e.preventDefault();
                msg.style.display = 'block';
            }
            if (!form.checkValidity()) { e.preventDefault(); e.stopPropagation(); }
            form.classList.add('was-validated');
        });
    })();
</script>
</body>
</html>
