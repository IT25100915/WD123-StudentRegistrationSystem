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
            <h2><i class="fas fa-user-graduate me-2"></i>Student Management</h2>
            <p class="mb-0 mt-1 small" style="color:#64748b">Manage undergraduate and postgraduate student records</p>
        </div>
        <a href="<c:url value='/students?action=add'/>" class="btn btn-primary">
            <i class="fas fa-user-plus me-1"></i> Add Student
        </a>
    </div>

    <%-- Search --%>
    <div class="filter-card d-flex align-items-center gap-2 flex-wrap">
        <form method="get" action="<c:url value='/students'/>" class="d-flex gap-2 align-items-center">
            <input type="hidden" name="action" value="search">
            <div class="input-group" style="max-width:320px">
                <span class="input-group-text" style="background:#f8fafc;border-color:#e2e8f0;border-right:none;border-radius:9px 0 0 9px">
                    <i class="fas fa-search" style="color:#94a3b8;font-size:0.8rem"></i>
                </span>
                <input type="text" name="keyword" class="form-control" style="border-left:none;border-radius:0 9px 9px 0"
                       placeholder="Search by ID, name or email…"
                       value="<c:out value='${keyword}'/>">
            </div>
            <button type="submit" class="btn btn-primary btn-sm px-3">Search</button>
            <c:if test="${not empty keyword}">
                <a href="<c:url value='/students'/>" class="btn btn-outline-secondary btn-sm">
                    <i class="fas fa-times me-1"></i>Clear
                </a>
            </c:if>
        </form>
        <c:if test="${not empty keyword}">
            <span class="badge ms-auto" style="background:#eef2ff;color:#6366f1;font-size:0.8rem;padding:0.45em 0.8em;border-radius:8px">
                <i class="fas fa-filter me-1"></i>${students.size()} result(s) for "<c:out value='${keyword}'/>"
            </span>
        </c:if>
    </div>

    <%-- Table --%>
    <div class="table-card">
        <c:choose>
            <c:when test="${empty students}">
                <div class="empty-state">
                    <div class="empty-state-icon">
                        <i class="fas fa-user-graduate"></i>
                    </div>
                    <h6 class="fw-bold mb-1" style="color:#1e293b">No students found</h6>
                    <p class="small mb-3" style="color:#64748b">
                        <c:choose>
                            <c:when test="${not empty keyword}">No results for "<c:out value='${keyword}'/>". Try a different search.</c:when>
                            <c:otherwise>Get started by adding your first student.</c:otherwise>
                        </c:choose>
                    </p>
                    <c:if test="${empty keyword}">
                        <a href="<c:url value='/students?action=add'/>" class="btn btn-primary btn-sm px-4">
                            <i class="fas fa-user-plus me-1"></i>Add First Student
                        </a>
                    </c:if>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-hover table-bordered mb-0">
                        <thead>
                            <tr>
                                <th>Student ID</th>
                                <th>Full Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Type</th>
                                <th>Course</th>
                                <th class="text-center" style="width:120px">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="s" items="${students}">
                                <tr>
                                    <td><code style="color:#6366f1;font-size:0.85rem"><c:out value="${s.studentId}"/></code></td>
                                    <td class="fw-semibold"><c:out value="${s.fullName}"/></td>
                                    <td style="color:#64748b"><c:out value="${s.email}"/></td>
                                    <td style="color:#64748b"><c:out value="${s.phone}"/></td>
                                    <td>
                                        <span class="badge" style="${s.studentType == 'Undergraduate' ? 'background:#eef2ff;color:#6366f1' : 'background:#f0fdf4;color:#16a34a'}">
                                            <c:out value="${s.studentType}"/>
                                        </span>
                                    </td>
                                    <td><code style="color:#0ea5e9;font-size:0.85rem"><c:out value="${s.courseCode}"/></code></td>
                                    <td class="text-center">
                                        <a href="<c:url value='/students'><c:param name='action' value='edit'/><c:param name='id' value='${s.studentId}'/></c:url>"
                                           class="btn btn-sm me-1" style="background:#eef2ff;color:#6366f1;border:none" title="Edit">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <form method="post" action="<c:url value='/students'/>" style="display:inline"
                                              onsubmit="return confirm('Delete student &quot;${s.fullName}&quot;? This cannot be undone.')">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="studentId" value="${s.studentId}">
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
                    Showing <strong style="color:#1e293b">${students.size()}</strong> student(s)
                </div>
            </c:otherwise>
        </c:choose>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</div>
</body>
</html>
