<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Détail commande"/>
<%@ include file="/WEB-INF/views/header.jspf" %>
<div class="page-heading"><div><div class="eyebrow">DÉTAIL DE L'OPÉRATION</div><h1>Commande #<c:out value="${commande.id}"/></h1><p class="page-subtitle">Récapitulatif de la commande, des coordonnées client et des lignes enregistrées.</p></div><div class="hero-actions"><a class="btn secondary" href="<c:url value='/commandes'/>">← Toutes les commandes</a><a class="btn" href="<c:url value='/commandes'><c:param name='action' value='edit'/><c:param name='id' value='${commande.id}'/></c:url>">✎ Modifier</a></div></div>
<div class="detail-grid">
  <div>
    <section class="card detail-hero"><span class="entity-avatar order-avatar">↗</span><div><div class="detail-label">Commande</div><h2>Référence #<c:out value="${commande.id}"/></h2><div class="entity-secondary">Créée le <fmt:formatDate value="${commande.dateCommande}" pattern="dd/MM/yyyy"/></div></div></section>
    <section class="card"><div class="card-heading"><div><h2>Articles commandés</h2><p>Détail des produits et des quantités</p></div><span class="badge neutral"><c:out value="${commande.lignes.size()}"/> ligne(s)</span></div>
      <div class="table-wrap"><table class="order-line-table" style="min-width:500px"><thead><tr><th>Produit</th><th class="right">Prix unitaire</th><th class="right">Qté</th><th class="right">Sous-total</th></tr></thead><tbody>
      <c:forEach items="${commande.lignes}" var="l"><tr><td><div class="entity-primary"><c:out value="${l.produit.designation}"/></div><div class="entity-secondary">Réf. PR-<c:out value="${l.produit.id}"/></div></td><td class="right"><fmt:formatNumber value="${l.prixUnitaire}" minFractionDigits="2" maxFractionDigits="2"/> MAD</td><td class="right"><c:out value="${l.quantite}"/></td><td class="right"><strong><fmt:formatNumber value="${l.sousTotal}" minFractionDigits="2" maxFractionDigits="2"/> MAD</strong></td></tr></c:forEach>
      </tbody><tfoot><tr><th colspan="3" class="right">Total de la commande</th><th class="right"><fmt:formatNumber value="${commande.total}" minFractionDigits="2" maxFractionDigits="2"/> MAD</th></tr></tfoot></table></div>
    </section>
  </div>
  <div>
    <section class="card"><div class="card-heading"><div><h2>Résumé</h2><p>Informations principales</p></div></div>
      <div class="detail-item"><div class="detail-label">Statut</div><div style="margin-top:7px"><c:choose><c:when test="${commande.statut == 'VALIDEE' || commande.statut == 'LIVREE'}"><span class="badge success"><c:out value="${commande.statut}"/></span></c:when><c:when test="${commande.statut == 'ANNULEE'}"><span class="badge danger"><c:out value="${commande.statut}"/></span></c:when><c:otherwise><span class="badge warning"><c:out value="${commande.statut}"/></span></c:otherwise></c:choose></div></div>
      <div class="detail-item"><div class="detail-label">Date de commande</div><div class="detail-value" style="margin-top:6px"><fmt:formatDate value="${commande.dateCommande}" pattern="dd MMMM yyyy"/></div></div>
      <div class="detail-item"><div class="detail-label">Client associé</div><div class="detail-value" style="margin-top:6px"><c:out value="${commande.client.nomComplet}"/></div><div class="entity-secondary"><c:out value="${commande.client.email}"/></div></div>
      <div class="total-panel" style="margin-top:20px"><span>Montant total · MAD</span><strong><fmt:formatNumber value="${commande.total}" minFractionDigits="2" maxFractionDigits="2"/></strong></div>
    </section>
  </div>
</div>
<%@ include file="/WEB-INF/views/footer.jspf" %>
