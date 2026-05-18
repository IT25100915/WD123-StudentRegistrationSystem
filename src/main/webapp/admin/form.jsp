<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:if test="${empty sessionScope.admin}">
    <c:redirect url="/login"/>
</c:if>
<c:set var="isEdit" value="${not empty editAdmin}"/>
<jsp:include page="/includes/header.jsp"/>
<jsp:include page="/includes/navbar.jsp"/>

<div class="main-content">

    <div class="page-header">
        <div>
            <h2>
                <i class="fas fa-user-shield me-2"></i>
                <c:choose><c:when test="${isEdit}">Edit Admin</c:when><c:otherwise>Add New Admin</c:otherwise></c:choose>
            </h2>
            <p class="mb-0 mt-1 small" style="color:#64748b">
                <c:choose><c:when test="${isEdit}">Update administrator account details</c:when><c:otherwise>Create a new administrator account</c:otherwise></c:choose>
            </p>
        </div>
        <a href="<c:url value='/admins'/>" class="btn btn-outline-secondary btn-sm">
            <i class="fas fa-arrow-left me-1"></i> Back to List
        </a>
    </div>

    <div class="form-card">
        <form method="post" action="<c:url value='/admins'/>" novalidate id="adminForm">
            <input type="hidden" name="action" value="${isEdit ? 'update' : 'add'}">
            <c:if test="${isEdit}">
                <input type="hidden" name="adminId" value="${editAdmin.adminId}">
            </c:if>

            <div class="row g-3">

                <div class="col-md-6">
                    <label for="username" class="form-label">Username <span class="text-danger">*</span></label>
                    <input type="text" id="username" name="username" class="form-control"
                           value="<c:out value='${editAdmin.username}'/>"
                           placeholder="Enter username" required minlength="3">
                    <div class="invalid-feedback">Username must be at least 3 characters.</div>
                </div>

                <div class="col-md-6">
                    <label for="role" class="form-label">Role <span class="text-danger">*</span></label>
                    <select id="role" name="role" class="form-select" required>
                        <option value="">-- Select Role --</option>
                        <option value="Admin"       <c:if test="${editAdmin.role == 'Admin'}">selected</c:if>>Admin</option>
                        <option value="Super Admin" <c:if test="${editAdmin.role == 'Super Admin'}">selected</c:if>>Super Admin</option>
                    </select>
                    <div class="invalid-feedback">Please select a role.</div>
                </div>

                <div class="col-12">
                    <label for="email" class="form-label">Email Address <span class="text-danger">*</span></label>
                    <input type="email" id="email" name="email" class="form-control"
                           value="<c:out value='${editAdmin.email}'/>"
                           placeholder="admin@sliit.lk" required>
                    <div class="invalid-feedback">Please enter a valid email address.</div>
                </div>

                <div class="col-12">
                    <label for="password" class="form-label">
                        Password
                        <c:if test="${not isEdit}"><span class="text-danger">*</span></c:if>
                        <c:if test="${isEdit}">
                            <span style="color:#94a3b8;font-weight:400;font-size:0.78rem;text-transform:none">(leave blank to keep current)</span>
                        </c:if>
                    </label>
                    <input type="password" id="password" name="password" class="form-control"
                           placeholder="${isEdit ? 'Leave blank to keep current password' : 'Enter password (min. 6 characters)'}"
                           ${not isEdit ? 'required minlength="6"' : ''}>
                    <div class="invalid-feedback">Password must be at least 6 characters.</div>
                </div>

            </div>

            <hr class="my-4" style="border-color:#e2e8f0">
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary px-4">
                    <i class="fas fa-save me-1"></i>
                    <c:choose><c:when test="${isEdit}">Update Admin</c:when><c:otherwise>Save Admin</c:otherwise></c:choose>
                </button>
                <a href="<c:url value='/admins'/>" class="btn btn-outline-secondary px-4">
                    <i class="fas fa-times me-1"></i> Cancel
                </a>
            </div>
        </form>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    (() => {
        'use strict';
        const form = document.getElementById('adminForm');
        form.addEventListener('submit', e => {
            if (!form.checkValidity()) { e.preventDefault(); e.stopPropagation(); }
            form.classList.add('was-validated');
        });
    })();
</script>
</div>
</body>
</html>
