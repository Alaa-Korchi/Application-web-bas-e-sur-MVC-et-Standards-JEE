<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Produits"/>
<%@ include file="/WEB-INF/views/header.jspf" %>
<div class="page-heading">
  <div><div class="eyebrow">CATALOGUE & INVENTAIRE</div><h1>Produits</h1><p class="page-subtitle">Gérez les références, les prix et les niveaux de stock de votre catalogue.</p></div>
  <a class="btn" href="<c:url value='/produits'><c:param name='action' value='new'/></c:url>">＋ Ajouter un produit</a>
</div>
<c:if test="${not empty error}"><div class="alert"><c:out value="${error}"/></div></c:if>
<section class="card">
  <div class="card-heading"><div><h2>Catalogue produits</h2><p>Prix exprimés en dirhams marocains (MAD)</p></div><span class="badge neutral">Inventaire</span></div>
  <div class="table-meta"><div class="search-box"><span class="search-symbol">⌕</span><input type="search" placeholder="Rechercher un produit…" aria-label="Rechercher dans les produits" data-table-search="#products-table" data-count-target="#product-count"></div><span class="result-count" id="product-count"><c:out value="${empty produits ? 0 : produits.size()}"/> produit(s)</span></div>
  <div class="table-wrap"><table id="products-table">
    <thead><tr><th>Produit</th><th>Référence</th><th class="right">Prix unitaire</th><th>Disponibilité</th><th class="actions-cell">Actions</th></tr></thead>
    <tbody>
    <c:forEach items="${produits}" var="p">
      <tr data-searchable>
        <td><div class="entity-cell"><span class="entity-avatar product-avatar">▦</span><div><div class="entity-primary"><c:out value="${p.designation}"/></div><div class="entity-secondary">Article du catalogue</div></div></div></td>
        <td><span class="id-chip">PR-<c:out value="${p.id}"/></span></td>
        <td class="right"><span class="price"><fmt:formatNumber value="${p.prix}" minFractionDigits="2" maxFractionDigits="2"/> MAD</span></td>
        <td><c:choose><c:when test="${p.stock == 0}"><span class="badge danger">Rupture</span></c:when><c:when test="${p.stock < 10}"><span class="badge warning">Stock faible · <c:out value="${p.stock}"/></span></c:when><c:otherwise><span class="badge success">En stock · <c:out value="${p.stock}"/></span></c:otherwise></c:choose></td>
        <td class="actions-cell"><div class="row-actions">
          <a class="btn small secondary" href="<c:url value='/produits'><c:param name='action' value='edit'/><c:param name='id' value='${p.id}'/></c:url>">✎ Modifier</a>
          <form class="inline" method="post" action="<c:url value='/produits'/>" data-confirm="Supprimer ce produit ? La suppression peut être refusée si le produit figure dans une commande."><input type="hidden" name="action" value="delete"><input type="hidden" name="id" value="${p.id}"><button class="btn small danger" type="submit">Supprimer</button></form>
        </div></td>
      </tr>
    </c:forEach>
    <c:if test="${empty produits}"><tr><td colspan="5" class="empty-state"><div class="empty-illustration">▦</div><strong>Votre catalogue est vide</strong><span>Créez une première référence pour suivre les prix et le stock.</span><div style="margin-top:16px"><a class="btn" href="<c:url value='/produits'><c:param name='action' value='new'/></c:url>">＋ Ajouter un produit</a></div></td></tr></c:if>
    </tbody>
  </table></div>
</section>
<%@ include file="/WEB-INF/views/footer.jspf" %>
