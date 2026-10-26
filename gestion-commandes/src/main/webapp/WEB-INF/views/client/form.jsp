<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Client"/>
<%@ include file="/WEB-INF/views/header.jspf" %>
<div class="page-heading"><div><div class="eyebrow">RELATION CLIENT</div><h1><c:out value="${client.id == 0 ? 'Nouveau client' : 'Modifier le client'}"/></h1><p class="page-subtitle">Renseignez les coordonnées utiles pour garder une fiche client fiable.</p></div><a class="btn secondary" href="<c:url value='/clients'/>">← Retour aux clients</a></div>
<c:if test="${not empty error}"><div class="alert"><c:out value="${error}"/></div></c:if>
<div class="form-layout">
  <form class="card form-card" method="post" action="<c:url value='/clients'/>" data-loading>
    <input type="hidden" name="action" value="save"><input type="hidden" name="id" value="${client.id == 0 ? '' : client.id}">
    <section class="form-section"><div class="form-section-title"><span class="section-number">01</span><div><h2>Identité du client</h2><p>Les informations permettant d'identifier le client.</p></div></div>
      <div class="form-grid">
        <div class="field"><label for="prenom">Prénom <span aria-hidden="true">*</span></label><input id="prenom" name="prenom" autocomplete="given-name" required maxlength="100" placeholder="Ex. Sara" value="<c:out value='${client.prenom}'/>"></div>
        <div class="field"><label for="nom">Nom <span aria-hidden="true">*</span></label><input id="nom" name="nom" autocomplete="family-name" required maxlength="100" placeholder="Ex. Alaoui" value="<c:out value='${client.nom}'/>"></div>
      </div>
    </section>
    <section class="form-section"><div class="form-section-title"><span class="section-number">02</span><div><h2>Coordonnées</h2><p>Un moyen de contact et une adresse, si disponibles.</p></div></div>
      <div class="form-grid">
        <div class="field full"><label for="email">Adresse e-mail <span aria-hidden="true">*</span></label><input id="email" type="email" name="email" autocomplete="email" required maxlength="150" placeholder="nom@exemple.ma" value="<c:out value='${client.email}'/>"><span class="field-hint">L'adresse e-mail doit être unique.</span></div>
        <div class="field"><label for="telephone">Téléphone</label><input id="telephone" name="telephone" autocomplete="tel" maxlength="30" placeholder="+212 6 00 00 00 00" value="<c:out value='${client.telephone}'/>"></div>
        <div class="field"><label for="adresse">Adresse</label><input id="adresse" name="adresse" autocomplete="street-address" maxlength="255" placeholder="Ville ou adresse" value="<c:out value='${client.adresse}'/>"></div>
      </div>
    </section>
    <div class="form-actions"><a class="btn secondary" href="<c:url value='/clients'/>">Annuler</a><button class="btn" type="submit">✓ Enregistrer le client</button></div>
  </form>
  <aside class="card form-aside"><div class="aside-symbol">♙</div><h3>Une fiche bien renseignée</h3><p>Des coordonnées exactes facilitent le suivi des commandes et la communication avec vos clients.</p><ul><li>Les champs marqués d'un astérisque sont obligatoires.</li><li>L'e-mail est unique dans la base de données.</li><li>Un client lié à des commandes ne peut pas être supprimé tant que ces relations existent.</li></ul></aside>
</div>
<%@ include file="/WEB-INF/views/footer.jspf" %>
