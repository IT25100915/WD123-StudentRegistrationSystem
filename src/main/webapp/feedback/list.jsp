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
            <h2><i class="fas fa-comments me-2"></i>Feedback Management</h2>
            <p class="mb-0 mt-1 small" style="color:#64748b">View and manage student course feedback</p>
        </div>
        <a href="<c:url value='/feedback?action=add'/>" class="btn btn-primary">
            <i class="fas fa-plus me-1"></i> Add Feedback
        </a>
    </div>

    <%-- Filter --%>
    <div class="filter-card d-flex align-items-center gap-2 flex-wrap">
        <form method="get" action="<c:url value='/feedback'/>" class="d-flex gap-2 align-items-center">
            <input type="hidden" name="action" value="byCourse">
            <span class="small fw-semibold" style="color:#64748b;white-space:nowrap">Filter by Course:</span>
            <input type="text" name="courseCode" class="form-control form-control-sm"
                   placeholder="Course Code" style="width:160px">
            <button type="submit" class="btn btn-sm btn-primary px-3">
                <i class="fas fa-filter me-1"></i>Filter
            </button>
            <a href="<c:url value='/feedback'/>" class="btn btn-outline-secondary btn-sm">
                <i class="fas fa-list me-1"></i>Show All
            </a>
        </form>
    </div>

    <%-- Table --%>
    <div class="table-card">
        <c:choose>
            <c:when test="${empty feedbackList}">
                <div class="empty-state">
                    <div class="empty-state-icon">
                        <i class="fas fa-comments"></i>
                    </div>
                    <h6 class="fw-bold mb-1" style="color:#1e293b">No feedback found</h6>
                    <p class="small mb-3" style="color:#64748b">No feedback records have been submitted yet.</p>
                    <a href="<c:url value='/feedback?action=add'/>" class="btn btn-primary btn-sm px-4">
                        <i class="fas fa-plus me-1"></i>Add First Feedback
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-hover table-bordered mb-0">
                        <thead>
                            <tr>
                                <th style="width:50px">#</th>
                                <th>ID</th>
                                <th>Student ID</th>
                                <th>Course</th>
                                <th>Rating</th>
                                <th>Comment</th>
                                <th>Type</th>
                                <th>Date</th>
                                <th class="text-center" style="width:120px">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="f" items="${feedbackList}" varStatus="s">
                                <tr>
                                    <td style="color:#94a3b8">${s.count}</td>
                                    <td><code style="color:#ec4899;font-size:0.85rem">#${f.feedbackId}</code></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${f.anonymous}">
                                                <span style="color:#94a3b8;font-style:italic;font-size:0.85rem">hidden</span>
                                            </c:when>
                                            <c:otherwise>
                                                <code style="color:#6366f1;font-size:0.85rem"><c:out value="${f.studentId}"/></code>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><code style="color:#0ea5e9;font-size:0.85rem"><c:out value="${f.courseCode}"/></code></td>
                                    <td>
                                        <div class="d-flex align-items-center gap-1">
                                            <c:forEach begin="1" end="5" var="i">
                                                <i class="fas fa-star" style="font-size:0.8rem;color:${i <= f.rating ? '#f59e0b' : '#e2e8f0'}"></i>
                                            </c:forEach>
                                            <span class="ms-1 small" style="color:#64748b">${f.rating}/5</span>
                                        </div>
                                    </td>
                                    <td style="max-width:200px">
                                        <span class="d-inline-block text-truncate" style="max-width:180px;color:#64748b;font-size:0.875rem"
                                              title="<c:out value='${f.comment}'/>">
                                            <c:out value="${f.comment}"/>
                                        </span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${f.anonymous}">
                                                <span class="badge" style="background:#f1f5f9;color:#64748b">Anonymous</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge" style="background:#fdf4ff;color:#a21caf">Named</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="color:#64748b;font-size:0.875rem"><c:out value="${f.submissionDate}"/></td>
                                    <td class="text-center">
                                        <a href="<c:url value='/feedback'><c:param name='action' value='edit'/><c:param name='id' value='${f.feedbackId}'/></c:url>"
                                           class="btn btn-sm me-1" style="background:#fdf4ff;color:#a21caf;border:none" title="Edit">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <form method="post" action="<c:url value='/feedback'/>" style="display:inline"
                                              onsubmit="return confirm('Delete this feedback record? This cannot be undone.')">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="feedbackId" value="${f.feedbackId}">
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
                    Total <strong style="color:#1e293b">${feedbackList.size()}</strong> feedback record(s)
                </div>
            </c:otherwise>
        </c:choose>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</div>
</body>
</html>
