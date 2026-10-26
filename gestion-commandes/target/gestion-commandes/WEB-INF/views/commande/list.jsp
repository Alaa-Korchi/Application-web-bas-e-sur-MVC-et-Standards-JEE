<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Commandes"/>
<%@ include file="/WEB-INF/views/header.jspf" %>
<div class="page-heading"><div><div class="eyebrow">SUIVI COMMERCIAL</div><h1>Commandes</h1><p class="page-subtitle">Suivez les commandes, retrouvez leur client et consultez le montant de chaque opération.</p></div><a class="btn" href="<c:url value='/commandes'><c:param name='action' value='new'/></c:url>">＋ Créer une commande</a></div>
<section class="card">
  <div class="card-heading"><div><h2>Historique des commandes</h2><p>Dates, statuts et montants enregistrés</p></div><span class="badge neutral">Suivi des opérations</span></div>
  <div class="table-meta"><div class="search-box"><span class="search-symbol">⌕</span><input type="search" placeholder="Rechercher une commande…" aria-label="Rechercher dans les commandes" data-table-search="#orders-table" data-count-target="#order-count"></div><span class="result-count" id="order-count"><c:out value="${empty commandes ? 0 : commandes.size()}"/> commande(s)</span></div>
  <div class="table-wrap"><table id="orders-table">
    <thead><tr><th>Commande</th><th>Date</th><th>Client</th><th>Statut</th><th class="right">Total</th><th class="actions-cell">Actions</th></tr></thead>
    <tbody>
    <c:forEach items="${commandes}" var="cmd">
      <tr data-searchable>
        <td><div class="entity-cell"><span class="entity-avatar order-avatar">↗</span><div><div class="entity-primary">Commande #<c:out value="${cmd.id}"/></div><div class="entity-secondary">Référence de suivi</div></div></div></td>
        <td><fmt:formatDate value="${cmd.dateCommande}" pattern="dd/MM/yyyy"/></td>
        <td><span class="entity-primary"><c:out value="${cmd.client.nomComplet}"/></span></td>
        <td><c:choose><c:when test="${cmd.statut == 'VALIDEE' || cmd.statut == 'LIVREE'}"><span class="badge success"><c:out value="${cmd.statut}"/></span></c:when><c:when test="${cmd.statut == 'ANNULEE'}"><span class="badge danger"><c:out value="${cmd.statut}"/></span></c:when><c:otherwise><span class="badge warning"><c:out value="${cmd.statut}"/></span></c:otherwise></c:choose></td>
        <td class="right"><span class="price"><fmt:formatNumber value="${cmd.total}" minFractionDigits="2" maxFractionDigits="2"/> MAD</span></td>
        <td class="actions-cell"><div class="row-actions">
          <a class="btn small" href="<c:url value='/commandes'><c:param name='action' value='view'/><c:param name='id' value='${cmd.id}'/></c:url>">Voir ↗</a>
          <a class="btn small secondary" href="<c:url value='/commandes'><c:param name='action' value='edit'/><c:param name='id' value='${cmd.id}'/></c:url>" aria-label="Modifier la commande">✎</a>
          <form class="inline" method="post" action="<c:url value='/commandes'/>" data-confirm="Supprimer définitivement la commande #${cmd.id} ?"><input type="hidden" name="action" value="delete"><input type="hidden" name="id" value="${cmd.id}"><button class="btn small danger" type="submit" aria-label="Supprimer la commande">×</button></form>
        </div></td>
      </tr>
    </c:forEach>
    <c:if test="${empty commandes}"><tr><td colspan="6" class="empty-state"><div class="empty-illustration">↗</div><strong>Aucune commande enregistrée</strong><span>Créez une commande pour commencer à suivre les opérations.</span><div style="margin-top:16px"><a class="btn" href="<c:url value='/commandes'><c:param name='action' value='new'/></c:url>">＋ Créer une commande</a></div></td></tr></c:if>
    </tbody>
  </table></div>
</section>
<%@ include file="/WEB-INF/views/footer.jspf" %>
