<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Registration System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root {
            --primary:       #6366f1;
            --primary-dark:  #4f46e5;
            --primary-light: #eef2ff;
            --sidebar-bg:    #0f172a;
            --sidebar-hover: rgba(99,102,241,0.15);
            --sidebar-active:#6366f1;
            --bg:            #f1f5f9;
            --card:          #ffffff;
            --text:          #1e293b;
            --muted:         #64748b;
            --border:        #e2e8f0;
        }

        *, *::before, *::after { box-sizing: border-box; }

        body {
            background-color: var(--bg);
            font-family: 'Segoe UI', system-ui, sans-serif;
            color: var(--text);
        }

        /* ── Scrollbar ── */
        ::-webkit-scrollbar { width: 5px; }
        ::-webkit-scrollbar-track { background: transparent; }
        ::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 10px; }

        /* ─────────────────────────────────
           SIDEBAR
        ───────────────────────────────── */
        .sidebar {
            background-color: var(--sidebar-bg);
            width: 250px;
            min-height: 100vh;
            position: fixed;
            top: 0; left: 0;
            z-index: 100;
            display: flex;
            flex-direction: column;
            overflow-y: auto;
            box-shadow: 4px 0 24px rgba(0,0,0,0.18);
        }

        .sidebar .brand {
            padding: 1.5rem 1.25rem 1rem;
            display: flex;
            align-items: center;
            gap: 0.65rem;
            border-bottom: 1px solid rgba(255,255,255,0.07);
            margin-bottom: 0.5rem;
        }

        .sidebar .brand-icon {
            width: 36px; height: 36px;
            background: linear-gradient(135deg, var(--primary), #818cf8);
            border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1rem; color: #fff;
            flex-shrink: 0;
        }

        .sidebar .brand-text {
            font-size: 0.95rem;
            font-weight: 700;
            color: #fff;
            line-height: 1.2;
        }

        .sidebar .brand-text span {
            display: block;
            font-size: 0.7rem;
            font-weight: 400;
            color: rgba(255,255,255,0.45);
            text-transform: uppercase;
            letter-spacing: 0.6px;
        }

        .sidebar .admin-pill {
            margin: 0 1rem 0.75rem;
            background: rgba(255,255,255,0.06);
            border-radius: 10px;
            padding: 0.6rem 0.85rem;
            display: flex;
            align-items: center;
            gap: 0.6rem;
        }

        .sidebar .admin-pill .avatar {
            width: 30px; height: 30px;
            background: linear-gradient(135deg, #6366f1, #a78bfa);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 0.75rem; color: #fff; font-weight: 700;
            flex-shrink: 0;
        }

        .sidebar .admin-pill .admin-name {
            font-size: 0.82rem;
            font-weight: 600;
            color: #fff;
        }

        .sidebar .admin-pill .admin-role {
            font-size: 0.7rem;
            color: rgba(255,255,255,0.45);
        }

        .sidebar .nav-section-label {
            font-size: 0.65rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: rgba(255,255,255,0.3);
            padding: 0.5rem 1.25rem 0.25rem;
            margin-top: 0.25rem;
        }

        .sidebar .nav-link {
            color: rgba(255,255,255,0.6);
            padding: 0.6rem 1rem;
            border-radius: 8px;
            margin: 1px 0.75rem;
            font-size: 0.875rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.7rem;
            transition: all 0.18s ease;
            text-decoration: none;
        }

        .sidebar .nav-link .nav-icon {
            width: 32px; height: 32px;
            border-radius: 8px;
            display: flex; align-items: center; justify-content: center;
            font-size: 0.85rem;
            flex-shrink: 0;
            transition: all 0.18s;
        }

        /* Module icon colours */
        .sidebar .nav-link[href*="dashboard"] .nav-icon { background: rgba(99,102,241,0.15); color: #818cf8; }
        .sidebar .nav-link[href*="students"]   .nav-icon { background: rgba(14,165,233,0.15); color: #38bdf8; }
        .sidebar .nav-link[href*="courses"]    .nav-icon { background: rgba(16,185,129,0.15); color: #34d399; }
        .sidebar .nav-link[href*="enrollment"] .nav-icon { background: rgba(139,92,246,0.15); color: #a78bfa; }
        .sidebar .nav-link[href*="attendance"] .nav-icon { background: rgba(245,158,11,0.15); color: #fbbf24; }
        .sidebar .nav-link[href*="feedback"]   .nav-icon { background: rgba(236,72,153,0.15); color: #f472b6; }
        .sidebar .nav-link[href*="admins"]     .nav-icon { background: rgba(239,68,68,0.15);  color: #f87171; }

        .sidebar .nav-link:hover {
            background: var(--sidebar-hover);
            color: #fff;
        }

        .sidebar .nav-link:hover .nav-icon {
            transform: scale(1.1);
        }

        .sidebar .nav-link.active {
            background: rgba(99,102,241,0.22);
            color: #fff;
            font-weight: 600;
            box-shadow: inset 3px 0 0 var(--primary);
        }

        .sidebar .nav-link.active .nav-icon {
            background: var(--primary) !important;
            color: #fff !important;
            box-shadow: 0 4px 12px rgba(99,102,241,0.45);
        }

        .sidebar .logout-area {
            padding: 1rem 0.75rem;
            border-top: 1px solid rgba(255,255,255,0.07);
            margin-top: auto;
        }

        .sidebar .btn-logout {
            width: 100%;
            background: rgba(239,68,68,0.12);
            border: 1px solid rgba(239,68,68,0.25);
            color: #fca5a5;
            border-radius: 8px;
            padding: 0.5rem;
            font-size: 0.85rem;
            font-weight: 500;
            transition: all 0.18s;
        }

        .sidebar .btn-logout:hover {
            background: rgba(239,68,68,0.22);
            color: #fff;
        }

        /* ─────────────────────────────────
           MAIN CONTENT
        ───────────────────────────────── */
        .main-content {
            margin-left: 250px;
            padding: 1.75rem 2rem;
            min-height: 100vh;
        }

        /* ─────────────────────────────────
           PAGE HEADER
        ───────────────────────────────── */
        .page-header {
            background: var(--card);
            border-radius: 14px;
            padding: 1.25rem 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.06), 0 1px 2px rgba(0,0,0,0.04);
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-left: 4px solid var(--primary);
        }

        .page-header h2 {
            color: var(--text);
            font-weight: 700;
            margin: 0;
            font-size: 1.35rem;
        }

        .page-header h2 i {
            color: var(--primary);
        }

        /* ─────────────────────────────────
           STAT CARDS
        ───────────────────────────────── */
        .stat-card {
            border: none;
            border-radius: 14px;
            overflow: hidden;
            transition: transform 0.2s, box-shadow 0.2s;
            cursor: default;
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 32px rgba(0,0,0,0.12) !important;
        }

        .stat-card .card-body {
            padding: 1.25rem;
        }

        .stat-card .stat-label {
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.6px;
            color: rgba(255,255,255,0.75);
            margin-bottom: 0.3rem;
        }

        .stat-card .stat-value {
            font-size: 2.25rem;
            font-weight: 800;
            color: #fff;
            line-height: 1;
        }

        .stat-card .stat-icon {
            font-size: 2rem;
            color: rgba(255,255,255,0.3);
        }

        /* ─────────────────────────────────
           TABLES
        ───────────────────────────────── */
        .table-card {
            background: var(--card);
            border-radius: 14px;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0,0,0,0.06), 0 1px 2px rgba(0,0,0,0.04);
        }

        .table {
            margin-bottom: 0;
        }

        .table thead th {
            background-color: #1e293b;
            color: rgba(255,255,255,0.9);
            font-weight: 600;
            font-size: 0.78rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border: none;
            padding: 0.9rem 1rem;
            white-space: nowrap;
        }

        .table tbody td {
            padding: 0.85rem 1rem;
            border-color: var(--border);
            vertical-align: middle;
            font-size: 0.9rem;
            color: var(--text);
        }

        .table-hover tbody tr:hover {
            background-color: var(--primary-light);
        }

        .table tbody tr:last-child td {
            border-bottom: none;
        }

        /* ─────────────────────────────────
           FILTER / SEARCH CARD
        ───────────────────────────────── */
        .filter-card {
            background: var(--card);
            border-radius: 14px;
            padding: 0.85rem 1.25rem;
            margin-bottom: 1rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }

        /* ─────────────────────────────────
           FORMS
        ───────────────────────────────── */
        .form-card {
            background: var(--card);
            border-radius: 14px;
            padding: 2rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.06), 0 1px 2px rgba(0,0,0,0.04);
            max-width: 760px;
        }

        .form-label {
            font-weight: 600;
            font-size: 0.83rem;
            color: var(--muted);
            text-transform: uppercase;
            letter-spacing: 0.4px;
            margin-bottom: 0.35rem;
        }

        .form-control, .form-select {
            border-color: var(--border);
            border-radius: 9px;
            padding: 0.55rem 0.85rem;
            font-size: 0.9rem;
            color: var(--text);
            transition: border-color 0.15s, box-shadow 0.15s;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(99,102,241,0.12);
        }

        .form-section-card {
            background: var(--bg);
            border-radius: 10px;
            border: 1px solid var(--border);
            padding: 1.25rem;
        }

        /* ─────────────────────────────────
           BUTTONS
        ───────────────────────────────── */
        .btn {
            border-radius: 9px;
            font-weight: 600;
            font-size: 0.875rem;
            transition: all 0.18s;
        }

        .btn-primary {
            background: var(--primary);
            border-color: var(--primary);
        }

        .btn-primary:hover {
            background: var(--primary-dark);
            border-color: var(--primary-dark);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(99,102,241,0.35);
        }

        .btn-success:hover, .btn-danger:hover, .btn-warning:hover,
        .btn-info:hover, .btn-outline-secondary:hover {
            transform: translateY(-1px);
        }

        /* ─────────────────────────────────
           BADGES
        ───────────────────────────────── */
        .badge {
            border-radius: 6px;
            font-size: 0.75rem;
            font-weight: 600;
            padding: 0.35em 0.65em;
        }

        .badge-present { background-color: #059669 !important; }
        .badge-absent  { background-color: #dc2626 !important; }
        .badge-late    { background-color: #d97706 !important; color: #fff !important; }

        /* ─────────────────────────────────
           DASHBOARD QUICK ACTIONS
        ───────────────────────────────── */
        .quick-action {
            border-radius: 10px;
            padding: 0.65rem 1.1rem;
            font-size: 0.88rem;
            font-weight: 600;
            transition: all 0.18s;
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
        }

        .quick-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 14px rgba(0,0,0,0.18);
        }

        /* ─────────────────────────────────
           MODULE OVERVIEW CARDS
        ───────────────────────────────── */
        .module-card {
            border: none;
            border-radius: 14px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.06);
            transition: all 0.2s;
            overflow: hidden;
        }

        .module-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 24px rgba(0,0,0,0.1);
        }

        .module-card .module-icon-wrap {
            width: 52px; height: 52px;
            border-radius: 14px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.4rem;
            margin: 0 auto 0.75rem;
        }

        /* ─────────────────────────────────
           ALERTS
        ───────────────────────────────── */
        .alert {
            border-radius: 10px;
            border: none;
        }

        /* ─────────────────────────────────
           EMPTY STATE
        ───────────────────────────────── */
        .empty-state {
            padding: 3.5rem 1rem;
            text-align: center;
        }

        .empty-state-icon {
            width: 72px; height: 72px;
            border-radius: 20px;
            background: var(--bg);
            display: flex; align-items: center; justify-content: center;
            font-size: 1.8rem;
            color: var(--muted);
            margin: 0 auto 1rem;
        }
    </style>
</head>
<body>
<div class="d-flex">
