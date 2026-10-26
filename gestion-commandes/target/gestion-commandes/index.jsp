<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Accueil"/>
<%@ include file="/WEB-INF/views/header.jspf" %>
<section class="dashboard-hero">
  <div class="hero-orb"></div>
  <div class="eyebrow">VOTRE ESPACE DE PILOTAGE</div>
  <h1>Tout votre quotidien commercial, au même endroit.</h1>
  <p>Retrouvez vos clients, gardez votre catalogue à jour et suivez vos commandes depuis un espace clair, pensé pour aller à l'essentiel.</p>
  <div class="hero-actions">
    <a class="btn light" href="<c:url value='/commandes'><c:param name='action' value='new'/></c:url>">＋ Créer une commande</a>
    <a class="btn translucent" href="<c:url value='/clients'><c:param name='action' value='new'/></c:url>">Ajouter un client ↗</a>
  </div>
</section>
<div class="section-title"><h2>Accès rapide</h2><span>Les espaces de votre application</span></div>
<div class="grid">
  <a class="card module-card" href="<c:url value='/clients'/>">
    <div class="module-icon">♙</div><h2>Gestion des clients</h2>
    <p>Centralisez les coordonnées et les informations de vos clients. Créez, mettez à jour ou consultez une fiche en quelques instants.</p>
    <div class="module-link"><span>Ouvrir les clients</span><span>↗</span></div>
  </a>
  <a class="card module-card" href="<c:url value='/produits'/>">
    <div class="module-icon cyan">▦</div><h2>Produits & stock</h2>
    <p>Consultez les prix et les quantités disponibles, puis maintenez votre catalogue produit à jour.</p>
    <div class="module-link"><span>Explorer le catalogue</span><span>↗</span></div>
  </a>
  <a class="card module-card" href="<c:url value='/commandes'/>">
    <div class="module-icon violet">↗</div><h2>Suivi des commandes</h2>
    <p>Retrouvez les commandes, leur statut et leur montant. Accédez au détail des lignes et aux informations client.</p>
    <div class="module-link"><span>Consulter les commandes</span><span>↗</span></div>
  </a>
</div>
<div class="section-title"><h2>Un espace pensé pour le suivi</h2><span>Fonctionnalités disponibles</span></div>
<div class="grid">
  <div class="card"><div class="module-icon">⌕</div><h3>Recherche rapide</h3><p class="page-subtitle">Filtrez les listes de clients, de produits et de commandes directement depuis les tableaux.</p></div>
  <div class="card"><div class="module-icon cyan">✓</div><h3>Données cohérentes</h3><p class="page-subtitle">Les informations affichées proviennent de votre base de données, sans statistiques simulées.</p></div>
  <div class="card"><div class="module-icon violet">◇</div><h3>Actions sécurisées</h3><p class="page-subtitle">Les suppressions demandent une confirmation et les contraintes métier de la base restent appliquées.</p></div>
</div>
<%@ include file="/WEB-INF/views/footer.jspf" %>
