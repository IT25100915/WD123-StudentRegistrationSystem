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
            <h2><i class="fas fa-calendar-check me-2"></i>Attendance Management</h2>
            <p class="mb-0 mt-1 small" style="color:#64748b">
                Mark and review student attendance records
                <c:if test="${not empty filterType}">
                    &mdash; <span style="color:#f59e0b"><i class="fas fa-filter me-1"></i>Filtered by ${filterType}</span>
                </c:if>
            </p>
        </div>
        <a href="<c:url value='/attendance?action=add'/>" class="btn btn-primary">
            <i class="fas fa-calendar-plus me-1"></i> Mark Attendance
        </a>
    </div>

    <%-- Filter controls --%>
    <div class="filter-card">
        <div class="d-flex flex-wrap gap-3 align-items-center">
            <form method="get" action="<c:url value='/attendance'/>" class="d-flex gap-2 align-items-center">
                <input type="hidden" name="action" value="byStudent">
                <span class="small fw-semibold" style="color:#64748b;white-space:nowrap">By Student:</span>
                <input type="text" name="studentId" class="form-control form-control-sm"
                       placeholder="Student ID" style="width:140px">
                <button type="submit" class="btn btn-sm btn-primary px-3">
                    <i class="fas fa-search"></i>
                </button>
            </form>

            <div class="vr d-none d-md-block" style="color:#e2e8f0"></div>

            <form method="get" action="<c:url value='/attendance'/>" class="d-flex gap-2 align-items-center">
                <input type="hidden" name="action" value="byCourse">
                <span class="small fw-semibold" style="color:#64748b;white-space:nowrap">By Course:</span>
                <input type="text" name="courseCode" class="form-control form-control-sm"
                       placeholder="Course Code" style="width:140px">
                <button type="submit" class="btn btn-sm btn-primary px-3">
                    <i class="fas fa-search"></i>
                </button>
            </form>

            <c:if test="${not empty filterType}">
                <a href="<c:url value='/attendance'/>" class="btn btn-outline-secondary btn-sm ms-auto">
                    <i class="fas fa-times me-1"></i>Show All
                </a>
            </c:if>
        </div>
    </div>

    <%-- Table --%>
    <div class="table-card">
        <c:choose>
            <c:when test="${empty attendanceList}">
                <div class="empty-state">
                    <div class="empty-state-icon">
                        <i class="fas fa-calendar-times"></i>
                    </div>
                    <h6 class="fw-bold mb-1" style="color:#1e293b">No attendance records found</h6>
                    <p class="small mb-3" style="color:#64748b">
                        <c:choose>
                            <c:when test="${not empty filterType}">No records match the current filter.</c:when>
                            <c:otherwise>Start by marking attendance for a student.</c:otherwise>
                        </c:choose>
                    </p>
                    <c:choose>
                        <c:when test="${not empty filterType}">
                            <a href="<c:url value='/attendance'/>" class="btn btn-outline-secondary btn-sm px-4">
                                <i class="fas fa-times me-1"></i>Clear Filter
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="<c:url value='/attendance?action=add'/>" class="btn btn-primary btn-sm px-4">
                                <i class="fas fa-calendar-plus me-1"></i>Mark First Attendance
                            </a>
                        </c:otherwise>
                    </c:choose>
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
                                <th>Date</th>
                                <th>Status</th>
                                <th class="text-center" style="width:120px">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="a" items="${attendanceList}" varStatus="s">
                                <tr>
                                    <td style="color:#94a3b8">${s.count}</td>
                                    <td><code style="color:#f59e0b;font-size:0.85rem">#${a.attendanceId}</code></td>
                                    <td><code style="color:#6366f1;font-size:0.85rem"><c:out value="${a.studentId}"/></code></td>
                                    <td><code style="color:#0ea5e9;font-size:0.85rem"><c:out value="${a.courseCode}"/></code></td>
                                    <td style="color:#64748b"><c:out value="${a.date}"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${a.status == 'Present'}">
                                                <span class="badge badge-present">
                                                    <i class="fas fa-check me-1"></i>Present
                                                </span>
                                            </c:when>
                                            <c:when test="${a.status == 'Absent'}">
                                                <span class="badge badge-absent">
                                                    <i class="fas fa-times me-1"></i>Absent
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-late">
                                                    <i class="fas fa-clock me-1"></i>Late
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <a href="<c:url value='/attendance'><c:param name='action' value='edit'/><c:param name='id' value='${a.attendanceId}'/></c:url>"
                                           class="btn btn-sm me-1" style="background:#fffbeb;color:#d97706;border:none" title="Edit">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <form method="post" action="<c:url value='/attendance'/>" style="display:inline"
                                              onsubmit="return confirm('Delete this attendance record? This cannot be undone.')">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="attendanceId" value="${a.attendanceId}">
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
                    Total <strong style="color:#1e293b">${attendanceList.size()}</strong> record(s)
                </div>
            </c:otherwise>
        </c:choose>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</div>
</body>
</html>
