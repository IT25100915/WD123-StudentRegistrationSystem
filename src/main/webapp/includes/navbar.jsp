<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<nav class="sidebar">

    <%-- Brand --%>
    <div class="brand">
        <div class="brand-icon">
            <i class="fas fa-graduation-cap"></i>
        </div>
        <div class="brand-text">
            SRS Portal
            <span>Admin Dashboard</span>
        </div>
    </div>

    <%-- Admin pill --%>
    <div class="admin-pill">
        <div class="avatar">${sessionScope.admin.username.substring(0,1).toUpperCase()}</div>
        <div>
            <div class="admin-name">${sessionScope.admin.username}</div>
            <div class="admin-role">${sessionScope.admin.role}</div>
        </div>
    </div>

    <%-- Navigation --%>
    <div class="nav-section-label">Main Menu</div>
    <ul class="nav flex-column flex-grow-1">

        <li class="nav-item">
            <a class="nav-link" id="nav-dashboard" href="<c:url value='/dashboard'/>">
                <span class="nav-icon"><i class="fas fa-tachometer-alt"></i></span>
                Dashboard
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link" id="nav-students" href="<c:url value='/students'/>">
                <span class="nav-icon"><i class="fas fa-user-graduate"></i></span>
                Students
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link" id="nav-courses" href="<c:url value='/courses'/>">
                <span class="nav-icon"><i class="fas fa-book-open"></i></span>
                Courses
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link" id="nav-enrollments" href="<c:url value='/enrollments'/>">
                <span class="nav-icon"><i class="fas fa-clipboard-list"></i></span>
                Enrollments
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link" id="nav-attendance" href="<c:url value='/attendance'/>">
                <span class="nav-icon"><i class="fas fa-calendar-check"></i></span>
                Attendance
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link" id="nav-feedback" href="<c:url value='/feedback'/>">
                <span class="nav-icon"><i class="fas fa-comments"></i></span>
                Feedback
            </a>
        </li>

        <div class="nav-section-label mt-2">System</div>

        <li class="nav-item">
            <a class="nav-link" id="nav-admins" href="<c:url value='/admins'/>">
                <span class="nav-icon"><i class="fas fa-user-shield"></i></span>
                Admins
            </a>
        </li>

    </ul>

    <%-- Logout --%>
    <div class="logout-area">
        <a href="<c:url value='/logout'/>" class="btn-logout">
            <i class="fas fa-sign-out-alt me-2"></i>Sign Out
        </a>
    </div>
</nav>

<script>
    (function () {
        var path = window.location.pathname;
        var map = {
            '/dashboard':   'nav-dashboard',
            '/students':    'nav-students',
            '/courses':     'nav-courses',
            '/enrollments': 'nav-enrollments',
            '/attendance':  'nav-attendance',
            '/feedback':    'nav-feedback',
            '/admins':      'nav-admins'
        };
        for (var key in map) {
            if (path.indexOf(key) !== -1) {
                var el = document.getElementById(map[key]);
                if (el) el.classList.add('active');
                break;
            }
        }
    })();
</script>
