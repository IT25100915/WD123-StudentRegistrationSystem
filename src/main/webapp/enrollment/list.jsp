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
            <h2><i class="fas fa-clipboard-list me-2"></i>Enrollment Management</h2>
            <p class="mb-0 mt-1 small" style="color:#64748b">Track student course enrollments</p>
        </div>
        <a href="<c:url value='/enrollments?action=add'/>" class="btn btn-primary">
            <i class="fas fa-plus me-1"></i> New Enrollment
        </a>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show mb-3">
            <i class="fas fa-exclamation-circle me-2"></i><c:out value="${error}"/>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="table-card">
        <c:choose>
            <c:when test="${empty enrollments}">
                <div class="empty-state">
                    <div class="empty-state-icon">
                        <i class="fas fa-clipboard-list"></i>
                    </div>
                    <h6 class="fw-bold mb-1" style="color:#1e293b">No enrollments found</h6>
                    <p class="small mb-3" style="color:#64748b">Start by enrolling a student in a course.</p>
                    <a href="<c:url value='/enrollments?action=add'/>" class="btn btn-primary btn-sm px-4">
                        <i class="fas fa-plus me-1"></i>Add First Enrollment
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-hover table-bordered mb-0">
                        <thead>
                            <tr>
                                <th style="width:50px">#</th>
                                <th>Enrollment ID</th>
                                <th>Student ID</th>
                                <th>Course Code</th>
                                <th>Date</th>
                                <th>Type</th>
                                <th class="text-center" style="width:120px">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="e" items="${enrollments}" varStatus="s">
                                <tr>
                                    <td style="color:#94a3b8">${s.count}</td>
                                    <td><code style="color:#8b5cf6;font-size:0.85rem">#${e.enrollmentId}</code></td>
                                    <td><code style="color:#6366f1;font-size:0.85rem"><c:out value="${e.studentId}"/></code></td>
                                    <td><code style="color:#0ea5e9;font-size:0.85rem"><c:out value="${e.courseCode}"/></code></td>
                                    <td style="color:#64748b"><c:out value="${e.enrollmentDate}"/></td>
                                    <td>
                                        <span class="badge" style="${e.enrollmentType == 'FullTime' ? 'background:#eef2ff;color:#6366f1' : 'background:#fffbeb;color:#d97706'}">
                                            <c:out value="${e.enrollmentType}"/>
                                        </span>
                                    </td>
                                    <td class="text-center">
                                        <a href="<c:url value='/enrollments'><c:param name='action' value='edit'/><c:param name='id' value='${e.enrollmentId}'/></c:url>"
                                           class="btn btn-sm me-1" style="background:#ede9fe;color:#7c3aed;border:none" title="Edit">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <form method="post" action="<c:url value='/enrollments'/>" style="display:inline"
                                              onsubmit="return confirm('Delete this enrollment record? This cannot be undone.')">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="enrollmentId" value="${e.enrollmentId}">
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
                    Total <strong style="color:#1e293b">${enrollments.size()}</strong> enrollment(s)
                </div>
            </c:otherwise>
        </c:choose>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</div>
</body>
</html>
