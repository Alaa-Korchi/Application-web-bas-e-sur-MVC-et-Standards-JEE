<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Produit"/>
<%@ include file="/WEB-INF/views/header.jspf" %>
<div class="page-heading"><div><div class="eyebrow">CATALOGUE & INVENTAIRE</div><h1><c:out value="${produit.id == 0 ? 'Nouveau produit' : 'Modifier le produit'}"/></h1><p class="page-subtitle">Définissez la désignation, le prix et la quantité disponible pour cette référence.</p></div><a class="btn secondary" href="<c:url value='/produits'/>">← Retour au catalogue</a></div>
<c:if test="${not empty error}"><div class="alert"><c:out value="${error}"/></div></c:if>
<div class="form-layout">
  <form class="card form-card" method="post" action="<c:url value='/produits'/>" data-loading>
    <input type="hidden" name="action" value="save"><input type="hidden" name="id" value="${produit.id == 0 ? '' : produit.id}">
    <section class="form-section"><div class="form-section-title"><span class="section-number">01</span><div><h2>Informations produit</h2><p>Les informations principales de votre référence.</p></div></div>
      <div class="form-grid"><div class="field full"><label for="designation">Désignation <span aria-hidden="true">*</span></label><input id="designation" name="designation" required maxlength="150" placeholder="Ex. Clavier mécanique" value="<c:out value='${produit.designation}'/>"></div></div>
    </section>
    <section class="form-section"><div class="form-section-title"><span class="section-number">02</span><div><h2>Prix & disponibilité</h2><p>Montants en dirhams marocains (MAD).</p></div></div>
      <div class="form-grid"><div class="field"><label for="prix">Prix unitaire (MAD) <span aria-hidden="true">*</span></label><input id="prix" type="number" step="0.01" min="0" name="prix" required inputmode="decimal" placeholder="0,00" value="${produit.prix}"><span class="field-hint">Le prix ne peut pas être négatif.</span></div><div class="field"><label for="stock">Quantité en stock <span aria-hidden="true">*</span></label><input id="stock" type="number" min="0" step="1" name="stock" required inputmode="numeric" placeholder="0" value="${produit.stock}"><span class="field-hint">Utilisez un nombre entier positif ou nul.</span></div></div>
    </section>
    <div class="form-actions"><a class="btn secondary" href="<c:url value='/produits'/>">Annuler</a><button class="btn" type="submit">✓ Enregistrer le produit</button></div>
  </form>
  <aside class="card form-aside"><div class="aside-symbol">▦</div><h3>Conseils de saisie</h3><p>Une désignation claire permet de retrouver rapidement un produit dans le catalogue et lors de la création d'une commande.</p><ul><li>Le prix est exprimé en MAD.</li><li>La quantité doit être un entier supérieur ou égal à zéro.</li><li>Les produits associés à des commandes ne peuvent pas être supprimés.</li></ul></aside>
</div>
<%@ include file="/WEB-INF/views/footer.jspf" %>
