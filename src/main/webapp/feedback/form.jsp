<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:if test="${empty sessionScope.admin}">
    <c:redirect url="/login"/>
</c:if>
<c:set var="isEdit" value="${not empty feedback}"/>
<jsp:include page="/includes/header.jsp"/>
<jsp:include page="/includes/navbar.jsp"/>

<div class="main-content">

    <div class="page-header">
        <div>
            <h2>
                <i class="fas fa-comments me-2"></i>
                <c:choose><c:when test="${isEdit}">Edit Feedback</c:when><c:otherwise>Submit Feedback</c:otherwise></c:choose>
            </h2>
            <p class="mb-0 mt-1 small" style="color:#64748b">
                <c:choose><c:when test="${isEdit}">Update this feedback record</c:when><c:otherwise>Record student feedback for a course</c:otherwise></c:choose>
            </p>
        </div>
        <a href="<c:url value='/feedback'/>" class="btn btn-outline-secondary btn-sm">
            <i class="fas fa-arrow-left me-1"></i> Back to List
        </a>
    </div>

    <div class="form-card">
        <form method="post" action="<c:url value='/feedback'/>" novalidate id="feedbackForm">
            <input type="hidden" name="action" value="${isEdit ? 'update' : 'add'}">
            <c:if test="${isEdit}">
                <input type="hidden" name="feedbackId" value="${feedback.feedbackId}">
            </c:if>

            <div class="row g-3">

                <div class="col-md-6">
                    <label for="studentId" class="form-label">Student <span class="text-danger">*</span></label>
                    <select id="studentId" name="studentId" class="form-select" required>
                        <option value="">-- Select Student --</option>
                        <c:forEach var="s" items="${students}">
                            <option value="${s.studentId}"
                                <c:if test="${s.studentId == feedback.studentId}">selected</c:if>>
                                <c:out value="${s.studentId}"/> — <c:out value="${s.fullName}"/>
                            </option>
                        </c:forEach>
                    </select>
                    <div class="invalid-feedback">Please select a student.</div>
                </div>

                <div class="col-md-6">
                    <label for="courseCode" class="form-label">Course <span class="text-danger">*</span></label>
                    <select id="courseCode" name="courseCode" class="form-select" required>
                        <option value="">-- Select Course --</option>
                        <c:forEach var="c" items="${courses}">
                            <option value="${c.courseCode}"
                                <c:if test="${c.courseCode == feedback.courseCode}">selected</c:if>>
                                <c:out value="${c.courseCode}"/> — <c:out value="${c.title}"/>
                            </option>
                        </c:forEach>
                    </select>
                    <div class="invalid-feedback">Please select a course.</div>
                </div>

                <div class="col-md-4">
                    <label for="rating" class="form-label">Rating <span class="text-danger">*</span></label>
                    <select id="rating" name="rating" class="form-select" required>
                        <option value="">-- Select Rating --</option>
                        <option value="5" <c:if test="${feedback.rating == 5}">selected</c:if>>Excellent (5 stars)</option>
                        <option value="4" <c:if test="${feedback.rating == 4}">selected</c:if>>Good (4 stars)</option>
                        <option value="3" <c:if test="${feedback.rating == 3}">selected</c:if>>Average (3 stars)</option>
                        <option value="2" <c:if test="${feedback.rating == 2}">selected</c:if>>Poor (2 stars)</option>
                        <option value="1" <c:if test="${feedback.rating == 1}">selected</c:if>>Very Poor (1 star)</option>
                    </select>
                    <div class="invalid-feedback">Please select a rating.</div>
                </div>

                <div class="col-md-4">
                    <label for="submissionDate" class="form-label">Submission Date <span class="text-danger">*</span></label>
                    <input type="date" id="submissionDate" name="submissionDate" class="form-control"
                           value="<c:out value='${feedback.submissionDate}'/>" required>
                    <div class="invalid-feedback">Please select a date.</div>
                </div>

                <div class="col-md-4 d-flex align-items-end pb-1">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="isAnonymous" name="isAnonymous"
                               value="true" onchange="toggleAnonymous()"
                               ${feedback.anonymous ? 'checked' : ''}>
                        <label class="form-check-label fw-semibold" for="isAnonymous" style="font-size:0.875rem;color:#475569">
                            <i class="fas fa-user-secret me-1" style="color:#94a3b8"></i>Submit Anonymously
                        </label>
                    </div>
                </div>

                <div class="col-12" id="studentNameSection">
                    <label for="studentName" class="form-label">Student Display Name</label>
                    <input type="text" id="studentName" name="studentName" class="form-control"
                           placeholder="Name shown on feedback (optional)">
                    <c:if test="${isEdit}">
                        <div class="form-text" style="color:#f59e0b;font-size:0.78rem">
                            <i class="fas fa-exclamation-triangle fa-xs me-1"></i>Re-enter student name when editing if needed.
                        </div>
                    </c:if>
                </div>

                <div class="col-12">
                    <label for="comment" class="form-label">Comment</label>
                    <textarea id="comment" name="comment" class="form-control" rows="4"
                              placeholder="Write your feedback here…"><c:out value="${feedback.comment}"/></textarea>
                </div>

            </div>

            <hr class="my-4" style="border-color:#e2e8f0">
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary px-4">
                    <i class="fas fa-save me-1"></i>
                    <c:choose><c:when test="${isEdit}">Update Feedback</c:when><c:otherwise>Submit Feedback</c:otherwise></c:choose>
                </button>
                <a href="<c:url value='/feedback'/>" class="btn btn-outline-secondary px-4">
                    <i class="fas fa-times me-1"></i> Cancel
                </a>
            </div>
        </form>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function toggleAnonymous() {
        const isAnon = document.getElementById('isAnonymous').checked;
        document.getElementById('studentNameSection').style.display = isAnon ? 'none' : 'block';
    }

    const dateField = document.getElementById('submissionDate');
    if (!dateField.value) dateField.value = new Date().toISOString().split('T')[0];

    toggleAnonymous();

    (() => {
        'use strict';
        const form = document.getElementById('feedbackForm');
        form.addEventListener('submit', e => {
            if (!form.checkValidity()) { e.preventDefault(); e.stopPropagation(); }
            form.classList.add('was-validated');
        });
    })();
</script>
</div>
</body>
</html>
