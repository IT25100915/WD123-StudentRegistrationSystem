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
            <h2><i class="fas fa-book-open me-2"></i>Course Management</h2>
            <p class="mb-0 mt-1 small" style="color:#64748b">
                <c:choose>
                    <c:when test="${viewingFile}">
                        Viewing data from <code style="color:#16a34a;font-size:0.8rem">${filePath}</code>
                    </c:when>
                    <c:otherwise>Manage online and offline course offerings</c:otherwise>
                </c:choose>
            </p>
        </div>
        <div class="d-flex gap-2 align-items-center">
            <%-- File toggle buttons --%>
            <c:choose>
                <c:when test="${viewingFile}">
                    <a href="<c:url value='/courses'/>" class="btn btn-sm btn-outline-secondary">
                        <i class="fas fa-database me-1"></i> View from Database
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="<c:url value='/courses?action=viewFile'/>" class="btn btn-sm"
                       style="background:#f0fdf4;border:1px solid #86efac;color:#16a34a;font-weight:600">
                        <i class="fas fa-file-alt me-1"></i> View from File
                    </a>
                </c:otherwise>
            </c:choose>
            <a href="<c:url value='/courses?action=add'/>" class="btn btn-primary">
                <i class="fas fa-plus me-1"></i> Add Course
            </a>
        </div>
    </div>

    <%-- File sync info banner --%>
    <c:choose>
        <c:when test="${viewingFile}">
            <div class="d-flex align-items-center gap-2 mb-3 px-3 py-2"
                 style="background:#f0fdf4;border:1px solid #86efac;border-radius:10px">
                <i class="fas fa-file-alt" style="color:#16a34a"></i>
                <span class="small fw-semibold" style="color:#166534">
                    Reading from file — <code style="background:transparent;color:#15803d">${filePath}</code>
                </span>
                <span class="badge ms-auto" style="background:#dcfce7;color:#16a34a">File View</span>
            </div>
        </c:when>
        <c:otherwise>
            <div class="d-flex align-items-center gap-2 mb-3 px-3 py-2"
                 style="background:#f0fdf4;border:1px solid #86efac;border-radius:10px">
                <i class="fas fa-sync-alt" style="color:#16a34a"></i>
                <span class="small fw-semibold" style="color:#166534">
                    File sync active — course data is automatically saved to
                    <code style="background:transparent;color:#15803d">${filePath}</code>
                    on every change.
                </span>
                <span class="badge ms-auto" style="background:#dcfce7;color:#16a34a">Auto Sync</span>
            </div>
        </c:otherwise>
    </c:choose>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show mb-3">
            <i class="fas fa-exclamation-circle me-2"></i><c:out value="${error}"/>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <%-- Table --%>
    <div class="table-card">
        <c:choose>
            <c:when test="${empty courses}">
                <div class="empty-state">
                    <div class="empty-state-icon">
                        <i class="fas fa-book-open"></i>
                    </div>
                    <h6 class="fw-bold mb-1" style="color:#1e293b">
                        <c:choose>
                            <c:when test="${viewingFile}">No data found in file</c:when>
                            <c:otherwise>No courses found</c:otherwise>
                        </c:choose>
                    </h6>
                    <p class="small mb-3" style="color:#64748b">
                        <c:choose>
                            <c:when test="${viewingFile}">The file is empty. Add a course first to sync data.</c:when>
                            <c:otherwise>Get started by adding your first course.</c:otherwise>
                        </c:choose>
                    </p>
                    <c:if test="${not viewingFile}">
                        <a href="<c:url value='/courses?action=add'/>" class="btn btn-primary btn-sm px-4">
                            <i class="fas fa-plus me-1"></i>Add First Course
                        </a>
                    </c:if>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-hover table-bordered mb-0">
                        <thead>
                            <tr>
                                <th>Course Code</th>
                                <th>Title</th>
                                <th class="text-center">Credits</th>
                                <th>Mode</th>
                                <th>Coordinator</th>
                                <c:if test="${not viewingFile}">
                                    <th class="text-center" style="width:120px">Actions</th>
                                </c:if>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="c" items="${courses}">
                                <tr>
                                    <td><code style="color:#0ea5e9;font-size:0.85rem"><c:out value="${c.courseCode}"/></code></td>
                                    <td class="fw-semibold"><c:out value="${c.title}"/></td>
                                    <td class="text-center">
                                        <span class="badge" style="background:#f0fdf4;color:#16a34a;font-size:0.82rem">
                                            <c:out value="${c.credits}"/> cr
                                        </span>
                                    </td>
                                    <td>
                                        <span class="badge" style="${c.mode == 'Online' ? 'background:#e0f2fe;color:#0284c7' : 'background:#f3f4f6;color:#374151'}">
                                            <i class="fas ${c.mode == 'Online' ? 'fa-wifi' : 'fa-building'} me-1"></i>
                                            <c:out value="${c.mode}"/>
                                        </span>
                                    </td>
                                    <td style="color:#64748b"><c:out value="${c.coordinator}"/></td>
                                    <c:if test="${not viewingFile}">
                                        <td class="text-center">
                                            <a href="<c:url value='/courses'><c:param name='action' value='edit'/><c:param name='code' value='${c.courseCode}'/></c:url>"
                                               class="btn btn-sm me-1" style="background:#e0f2fe;color:#0284c7;border:none" title="Edit">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <form method="post" action="<c:url value='/courses'/>" style="display:inline"
                                                  onsubmit="return confirm('Delete course &quot;${c.title}&quot;? This cannot be undone.')">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="courseCode" value="${c.courseCode}">
                                                <button type="submit" class="btn btn-sm" style="background:#fef2f2;color:#ef4444;border:none" title="Delete">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </form>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="px-4 py-2 small border-top d-flex align-items-center justify-content-between" style="color:#94a3b8">
                    <span>
                        Showing <strong style="color:#1e293b">${courses.size()}</strong> course(s)
                        <c:if test="${viewingFile}">
                            <span style="color:#16a34a" class="ms-2">
                                <i class="fas fa-file-alt me-1"></i>from file
                            </span>
                        </c:if>
                    </span>
                    <c:if test="${viewingFile}">
                        <a href="<c:url value='/courses'/>" class="small" style="color:#6366f1;font-weight:600;text-decoration:none">
                            <i class="fas fa-database me-1"></i>Switch to Database view
                        </a>
                    </c:if>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</div>
</body>
</html>
