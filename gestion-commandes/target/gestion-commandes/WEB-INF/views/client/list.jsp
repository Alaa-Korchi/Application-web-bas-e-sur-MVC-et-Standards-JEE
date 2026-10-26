<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Clients"/>
<%@ include file="/WEB-INF/views/header.jspf" %>
<div class="page-heading">
  <div><div class="eyebrow">RELATION CLIENT</div><h1>Clients</h1><p class="page-subtitle">Toutes les coordonnées de vos clients dans une vue simple à parcourir et à administrer.</p></div>
  <a class="btn" href="<c:url value='/clients'><c:param name='action' value='new'/></c:url>">＋ Ajouter un client</a>
</div>
<c:if test="${not empty error}"><div class="alert"><c:out value="${error}"/></div></c:if>
<section class="card">
  <div class="card-heading"><div><h2>Répertoire clients</h2><p>Coordonnées et informations de contact</p></div><span class="badge neutral">Données réelles</span></div>
  <div class="table-meta"><div class="search-box"><span class="search-symbol">⌕</span><input type="search" placeholder="Rechercher un client…" aria-label="Rechercher dans les clients" data-table-search="#clients-table" data-count-target="#client-count"></div><span class="result-count" id="client-count"><c:out value="${empty clients ? 0 : clients.size()}"/> client(s)</span></div>
  <div class="table-wrap"><table id="clients-table">
    <thead><tr><th>Client</th><th>E-mail</th><th>Téléphone</th><th>Adresse</th><th class="actions-cell">Actions</th></tr></thead>
    <tbody>
    <c:forEach items="${clients}" var="c">
      <tr data-searchable>
        <td><div class="entity-cell"><span class="entity-avatar">CL</span><div><div class="entity-primary"><c:out value="${c.nomComplet}"/></div><div class="entity-secondary">Référence #<c:out value="${c.id}"/></div></div></div></td>
        <td><c:out value="${c.email}"/></td><td><c:out value="${empty c.telephone ? '—' : c.telephone}"/></td><td><c:out value="${empty c.adresse ? '—' : c.adresse}"/></td>
        <td class="actions-cell"><div class="row-actions">
          <a class="btn small secondary" aria-label="Modifier le client" href="<c:url value='/clients'><c:param name='action' value='edit'/><c:param name='id' value='${c.id}'/></c:url>">✎ Modifier</a>
          <form class="inline" method="post" action="<c:url value='/clients'/>" data-confirm="Supprimer ce client ? Cette opération peut être refusée s'il possède des commandes."><input type="hidden" name="action" value="delete"><input type="hidden" name="id" value="${c.id}"><button class="btn small danger" type="submit">Supprimer</button></form>
        </div></td>
      </tr>
    </c:forEach>
    <c:if test="${empty clients}"><tr><td colspan="5" class="empty-state"><div class="empty-illustration">♙</div><strong>Aucun client pour le moment</strong><span>Ajoutez votre premier client pour commencer à organiser votre répertoire.</span><div style="margin-top:16px"><a class="btn" href="<c:url value='/clients'><c:param name='action' value='new'/></c:url>">＋ Ajouter un client</a></div></td></tr></c:if>
    </tbody>
  </table></div>
</section>
<%@ include file="/WEB-INF/views/footer.jspf" %>
