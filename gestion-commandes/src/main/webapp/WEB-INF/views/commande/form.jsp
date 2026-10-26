<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Commande"/>
<%@ include file="/WEB-INF/views/header.jspf" %>
<div class="page-heading"><div><div class="eyebrow">SUIVI COMMERCIAL</div><h1><c:out value="${commande.id == 0 ? 'Nouvelle commande' : 'Modifier la commande'}"/></h1><p class="page-subtitle">Associez un client, définissez le statut et composez la commande à partir des produits du catalogue.</p></div><a class="btn secondary" href="<c:url value='/commandes'/>">← Retour aux commandes</a></div>
<c:if test="${not empty error}"><div class="alert"><c:out value="${error}"/></div></c:if>
<div class="form-layout">
<form class="card form-card" method="post" action="<c:url value='/commandes'/>" data-loading id="order-form">
  <input type="hidden" name="action" value="save"><input type="hidden" name="id" value="${commande.id == 0 ? '' : commande.id}">
  <section class="form-section"><div class="form-section-title"><span class="section-number">01</span><div><h2>Informations générales</h2><p>Les informations de suivi de la commande.</p></div></div>
    <div class="form-grid">
      <div class="field full"><label for="clientId">Client associé <span aria-hidden="true">*</span></label><select id="clientId" name="clientId" required><option value="">Sélectionner un client</option><c:forEach items="${clients}" var="cl"><option value="${cl.id}" ${cl.id == commande.client.id ? 'selected' : ''}><c:out value="${cl.nomComplet}"/> · <c:out value="${cl.email}"/></option></c:forEach></select><span class="field-hint">Le client doit déjà être enregistré dans l'application.</span></div>
      <div class="field"><label for="dateCommande">Date de commande <span aria-hidden="true">*</span></label><input id="dateCommande" type="date" name="dateCommande" required value="<fmt:formatDate value='${commande.dateCommande}' pattern='yyyy-MM-dd'/>"></div>
      <div class="field"><label for="statut">Statut</label><select id="statut" name="statut"><c:forTokens items="EN_ATTENTE,VALIDEE,LIVREE,ANNULEE" delims="," var="s"><option value="${s}" ${s == commande.statut ? 'selected' : ''}><c:out value="${s}"/></option></c:forTokens></select></div>
    </div>
  </section>
  <section class="form-section"><div class="form-section-title"><span class="section-number">02</span><div><h2>Articles de la commande</h2><p>Choisissez les produits et les quantités souhaitées.</p></div></div>
    <div class="table-wrap"><table style="min-width:500px"><thead><tr><th>Produit</th><th style="width:120px">Quantité</th><th style="width:55px"></th></tr></thead><tbody id="lignes">
      <c:forEach items="${commande.lignes}" var="l"><tr><td><select name="produitId" aria-label="Produit de la ligne"><option value="">Choisir un produit</option><c:forEach items="${produits}" var="p"><option value="${p.id}" ${p.id == l.produit.id ? 'selected' : ''}><c:out value="${p.designation}"/> · <c:out value="${p.prix}"/> MAD</option></c:forEach></select></td><td><input type="number" name="quantite" min="1" step="1" value="${l.quantite}" aria-label="Quantité"></td><td><button type="button" class="btn small danger remove-line" aria-label="Retirer cette ligne">×</button></td></tr></c:forEach>
    </tbody></table></div>
    <template id="rowTpl"><tr><td><select name="produitId" aria-label="Produit de la ligne"><option value="">Choisir un produit</option><c:forEach items="${produits}" var="p"><option value="${p.id}"><c:out value="${p.designation}"/> · <c:out value="${p.prix}"/> MAD</option></c:forEach></select></td><td><input type="number" name="quantite" min="1" step="1" value="1" aria-label="Quantité"></td><td><button type="button" class="btn small danger remove-line" aria-label="Retirer cette ligne">×</button></td></tr></template>
    <div style="display:flex;justify-content:space-between;align-items:center;gap:12px;flex-wrap:wrap;margin-top:15px"><span class="field-hint">Ajoutez au moins une ligne avec un produit et une quantité supérieure à zéro.</span><button type="button" class="btn secondary" id="add-line">＋ Ajouter un produit</button></div>
  </section>
  <div class="form-actions"><a class="btn secondary" href="<c:url value='/commandes'/>">Annuler</a><button class="btn" type="submit">✓ Enregistrer la commande</button></div>
</form>
<aside class="card form-aside"><div class="aside-symbol">↗</div><h3>Avant d'enregistrer</h3><p>Vérifiez le client, la date et les articles sélectionnés.</p><ul><li>Une commande doit contenir au moins une ligne valide.</li><li>Le prix unitaire est repris depuis le produit au moment de l'enregistrement.</li><li>Les références produits doivent exister dans le catalogue.</li></ul><div class="alert" style="margin-top:18px">Le formulaire applique les règles de validation présentes dans le backend.</div></aside>
</div>
<script>
(function () {
  var rows = document.getElementById('lignes');
  var template = document.getElementById('rowTpl');
  function addRow() { rows.appendChild(template.content.cloneNode(true)); }
  document.getElementById('add-line').addEventListener('click', addRow);
  rows.addEventListener('click', function (event) {
    var button = event.target.closest('.remove-line');
    if (!button) return;
    button.closest('tr').remove();
    if (!rows.querySelector('tr')) addRow();
  });
  if (!rows.querySelector('tr')) addRow();
})();
</script>
<%@ include file="/WEB-INF/views/footer.jspf" %>
