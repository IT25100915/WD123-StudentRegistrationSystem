<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:if test="${empty sessionScope.admin}">
    <c:redirect url="/login"/>
</c:if>
<jsp:include page="/includes/header.jsp"/>
<jsp:include page="/includes/navbar.jsp"/>

<div class="main-content">

    <div class="page-header">
        <div>
            <h2><i class="fas fa-user-shield me-2"></i>Admin Management</h2>
            <p class="mb-0 mt-1 small" style="color:#64748b">Manage system administrator accounts</p>
        </div>
        <a href="<c:url value='/admins?action=add'/>" class="btn btn-primary">
            <i class="fas fa-plus me-1"></i> Add Admin
        </a>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show mb-3" role="alert">
            <i class="fas fa-check-circle me-2"></i><c:out value="${success}"/>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show mb-3" role="alert">
            <i class="fas fa-exclamation-circle me-2"></i><c:out value="${error}"/>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="table-card">
        <c:choose>
            <c:when test="${empty admins}">
                <div class="empty-state">
                    <div class="empty-state-icon">
                        <i class="fas fa-user-shield"></i>
                    </div>
                    <h6 class="fw-bold mb-1" style="color:#1e293b">No admin accounts found</h6>
                    <p class="small mb-3" style="color:#64748b">Add an administrator account to manage the system.</p>
                    <a href="<c:url value='/admins?action=add'/>" class="btn btn-primary btn-sm px-4">
                        <i class="fas fa-plus me-1"></i>Add First Admin
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-hover table-bordered mb-0">
                        <thead>
                            <tr>
                                <th style="width:50px">#</th>
                                <th>Username</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th class="text-center" style="width:130px">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="a" items="${admins}" varStatus="s">
                                <tr>
                                    <td style="color:#94a3b8">${s.count}</td>
                                    <td>
                                        <div class="d-flex align-items-center gap-2">
                                            <div style="width:30px;height:30px;border-radius:50%;background:linear-gradient(135deg,#6366f1,#818cf8);display:flex;align-items:center;justify-content:center;font-size:0.75rem;color:#fff;font-weight:700;flex-shrink:0">
                                                ${a.username.substring(0,1).toUpperCase()}
                                            </div>
                                            <span class="fw-semibold"><c:out value="${a.username}"/></span>
                                        </div>
                                    </td>
                                    <td style="color:#64748b"><c:out value="${a.email}"/></td>
                                    <td>
                                        <span class="badge" style="${a.role == 'Super Admin' ? 'background:#fef2f2;color:#dc2626' : 'background:#eef2ff;color:#6366f1'}">
                                            <i class="fas fa-shield-alt me-1"></i><c:out value="${a.role}"/>
                                        </span>
                                    </td>
                                    <td class="text-center">
                                        <a href="<c:url value='/admins'><c:param name='action' value='edit'/><c:param name='id' value='${a.adminId}'/></c:url>"
                                           class="btn btn-sm me-1" style="background:#eef2ff;color:#6366f1;border:none" title="Edit">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <form method="post" action="<c:url value='/admins'/>" style="display:inline"
                                              onsubmit="return confirm('Delete admin &quot;${a.username}&quot;? This cannot be undone.')">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="adminId" value="${a.adminId}">
                                            <button type="submit" class="btn btn-sm" style="background:#fef2f2;color:#ef4444;border:none" title="Delete">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="px-4 py-2 small border-top" style="color:#94a3b8">
                    Total <strong style="color:#1e293b">${admins.size()}</strong> admin account(s)
                </div>
            </c:otherwise>
        </c:choose>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</div>
</body>
</html>
