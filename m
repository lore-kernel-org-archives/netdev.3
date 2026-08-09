Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4800E3B1EC7
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 20:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786307504; cv=none; b=Vy1CRgCDqbuFxq53Cs0mhG7sesD829FZXUhFz06tYv3Fx5TtvioOXGZfacoJXZogk6euotXP3jV3FYuhGTIp3TjA1xknZ3vQK2MAdrv0pm2gdoLJJMkoVWyNyibrG7G+NXXs4nmJEItoT0JWDQz+zTkoRNq5Q4C3XLZlh3n40GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786307504; c=relaxed/simple;
	bh=/3c5XHbYCAQ3UVTASxSlQWAbVk+UeBL6n9ULo+WTNyk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkIguBzaiRzsNkjFzraFIqQYa4/CyTV4UqtVHDAcHA0wphWaw3+Hby7nmDtab+fCFadUBszWF1KNvB5Ex6kPcL0kZta0fu9v86zDkg0heXtubz+rA6/gafWtp+p0nxDlIu9+nImCpGSlt0XD7Y4I7av7xdW4NuWRlgZhBqkZILM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHN6ktZs; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHN6ktZs"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4956869750eso7453615e9.2
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 13:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786307499; x=1786912299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xRvacLN+57DJnBMudtYrTXU7KiHkZYvlMNwzIQQLHng=;
        b=fHN6ktZsoUV84yy1gnJxVWW87zYC4W+wuXIl0Ew5G5xgP9A71djDGqm2LukIIDIpoM
         YtXHFb0Ut4oK+IBP3xzTO2QZy3OXazxzGwWRH1Yl97Mow0o/RPnBQyET1gAVP183kOir
         QFqTckWLwvo0UXDKSeAuYU+mZLGZC5UhX0PuVF7n3Av880nK7304XbyX1moVEHtwmwmA
         /8abjCN26s4Ty0eVfniZttkLxO5H51y4THb9ZovK3Gz+Y3LMWwazsALIddJyrQUAr9G+
         XDinfMO3NIHbaizTbrWpsxjPGhZIMAa2FJdTdi7xVGQnq0Ywin3VuXr20X7TgEg2ypoM
         bV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786307499; x=1786912299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xRvacLN+57DJnBMudtYrTXU7KiHkZYvlMNwzIQQLHng=;
        b=KzCnchL/TjNEBg2qXN6svtNa8Mc3sd00CdZR7JogDhvPOj/f7IJ4yrgJ3js6LnYnos
         CRpf84cTBduKPCapInyel0pzH5MPBM2j+LGZYPwNzoJrk2sbjdu5iXUDzF3G53m4B77a
         Jpd83iTycgoEiiUY3AvxbqsOU7xM7qk+yxS/EA+Li0q8fXIX+iqM741Gj9Jk59O7UIt2
         vfPJMTkgbnMslpySReidiYH00udYcEJdivzf17YmHxKJSmEWbd132zESRAOY2DzMG6wu
         H9YO/cMs/h5KGjNwk8OA3ax3UTNslZL1c5vSPskTt0b3qAAKCGnsBBnClJnaUc/XftR+
         IlBg==
X-Forwarded-Encrypted: i=1; AHgh+RqJ4GL369aRPWKWTP3pLk8mRAKlobvt35xkM48nyGBHIpxR1L55v9ZGLBCsJcy6SlmJem8VzgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoXs8tC4NbZ/fr9hFlKMWofRs04r+y+0IjySpjmwxYFLnjcpfZ
	db6NfZjsTbd1NUEzwG5gZvWyggp+V3ypcF/6LQlrAB9OPChV6FIFzhyt
X-Gm-Gg: AR+sD11zgIDN5qhj+zJ3+Wa+nh+hiZrNlYNUW2lvqoJs6riLb4RfGVQhViHXnQt5/s8
	+ELe2DfLny87U+N/xuxZblTtFrjVSUzo3VKFrYzbt/Y+VcpO9Dq436eo1RoGWpYxWsszsjXgrYg
	w9ME0BUsPgUUfoNewGRJPvleHzAGPRrfo648ur3LFb7eGTfSokQMKtUNT6V4bLkLZxAe71I0oCJ
	xcjzeNHh+4uQg+J1Ic+6jw+SrtPjwd+7bs9brxXrN7doniOC0uAMS9DugtIn8vkjLuR6M3d+5RJ
	KoUfs8+CBPJW6ThlN1M/INWF+6goGHfS1lEkpP68xbacp6eDnxDTYzJr4nJONgIOM1/rDMQL3Q3
	rAZTmn3FKkP+ZxoRpLbMoM4MkGUvX3M4RuSRdbVfCFAdDkgUfIfZC1OJdiAPPTcixAEvUn1MLaW
	U1/Yb9YvP0qYMg/jJZlVgShSynaRKTLr25hz9VgWWKNnGcHYUyQmj2STZPUoR/zH+1WU1ttTL9V
	O4Z2wUQ9XejGB5BDKJthdVObNmXLgegaVoi6a54aEhnhzE7ktFRbr6jwr0=
X-Received: by 2002:a05:600c:1d23:b0:499:516b:83d5 with SMTP id 5b1f17b1804b1-499516b83d9mr386176995e9.11.1786307499071;
        Sun, 09 Aug 2026 13:31:39 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-20-3-207.retail.telecomitalia.it. [87.20.3.207])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4995e9ea92csm229357065e9.4.2026.08.09.13.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 13:31:38 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH net-next v12 05/12] net: phylink: support PCS provider release
Date: Sun,  9 Aug 2026 22:31:02 +0200
Message-ID: <20260809203116.640271-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809203116.640271-1-ansuelsmth@gmail.com>
References: <20260809203116.640271-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for release of fwnode PCS from a PCS provider.
This works by creating a global notifier for the PCS provider and
making each phylink instance that makes use of fwnode subscribe to
this notifier.

The PCS notifier will emit the event FWNODE_PCS_PROVIDER_DEL every time
a new PCS provider is released.

phylink will then react to this event and will call the new function
fwnode_pcs_matches_provider() on each PCS of the phylink instance and
will check if the PCS is provided by the PCS provider that is getting
released.

If a related PCS is found, then such PCS is removed from the phylink
instance PCS list and the supported_interfaces value is updated.

The flag force_major_config is set to make phylink resolve reconfigure
the interface (even if it didn't change).
This is needed to handle the special case when the current PCS used
by phylink is removed and a major_config is needed to propagae the
configuration change. With this option enabled we also force mac_config
even if the PHY link is not up for the in-band case.

Finally a phylink resolve is triggered to handle the PCS removal.

Protect every access of phylink pcs_list with state_mutex to handle async
PCS provider release.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/pcs/pcs.c     |  47 +++++++++++++++
 drivers/net/phy/phylink.c | 118 +++++++++++++++++++++++++++++++++++++-
 include/linux/pcs/pcs.h   |  69 ++++++++++++++++++++++
 3 files changed, 231 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pcs/pcs.c b/drivers/net/pcs/pcs.c
index c1bb93bc0892..52097466ce91 100644
--- a/drivers/net/pcs/pcs.c
+++ b/drivers/net/pcs/pcs.c
@@ -22,6 +22,19 @@ struct fwnode_pcs_provider {
 
 static LIST_HEAD(fwnode_pcs_providers);
 static DEFINE_MUTEX(fwnode_pcs_mutex);
+static BLOCKING_NOTIFIER_HEAD(fwnode_pcs_notify_list);
+
+int register_fwnode_pcs_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&fwnode_pcs_notify_list, nb);
+}
+EXPORT_SYMBOL_GPL(register_fwnode_pcs_notifier);
+
+int unregister_fwnode_pcs_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&fwnode_pcs_notify_list, nb);
+}
+EXPORT_SYMBOL_GPL(unregister_fwnode_pcs_notifier);
 
 struct phylink_pcs *fwnode_pcs_simple_xlate(struct fwnode_reference_args *pcsspec,
 					    void *data)
@@ -74,6 +87,11 @@ void fwnode_pcs_del_provider(struct fwnode_pcs_provider *pp)
 
 	mutex_unlock(&fwnode_pcs_mutex);
 
+	/* Signal phylink to release any PCS from this provider */
+	blocking_notifier_call_chain(&fwnode_pcs_notify_list,
+				     FWNODE_PCS_PROVIDER_DEL,
+				     pp);
+
 	fwnode_handle_put(pp->fwnode);
 	kfree(pp);
 }
@@ -183,6 +201,35 @@ struct phylink_pcs *fwnode_pcs_get(const struct fwnode_handle *fwnode, unsigned
 }
 EXPORT_SYMBOL_GPL(fwnode_pcs_get);
 
+bool fwnode_pcs_matches_provider(struct fwnode_pcs_provider *provider,
+				 const struct fwnode_handle *fwnode,
+				 struct phylink_pcs *pl_pcs)
+{
+	struct fwnode_reference_args pcsspec;
+	int index = 0;
+	int ret;
+
+	while (true) {
+		struct phylink_pcs *pcs;
+
+		ret = fwnode_parse_pcsspec(fwnode, index, NULL, &pcsspec);
+		if (ret)
+			return false;
+
+		pcs = __fwnode_pcs_get_from_pcsspec_provider(&pcsspec, provider);
+		if (!IS_ERR(pcs) && pcs == pl_pcs) {
+			fwnode_handle_put(pcsspec.fwnode);
+			return true;
+		}
+
+		fwnode_handle_put(pcsspec.fwnode);
+		index++;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(fwnode_pcs_matches_provider);
+
 unsigned int fwnode_phylink_pcs_count(struct fwnode_handle *fwnode)
 {
 	struct fwnode_reference_args out_args;
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index b9a5cd123775..1d7223e95474 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -12,6 +12,7 @@
 #include <linux/netdevice.h>
 #include <linux/of.h>
 #include <linux/of_mdio.h>
+#include <linux/pcs/pcs.h>
 #include <linux/phy.h>
 #include <linux/phy_fixed.h>
 #include <linux/phylink.h>
@@ -63,6 +64,7 @@ struct phylink {
 
 	/* List of available PCS */
 	struct list_head pcs_list;
+	struct notifier_block fwnode_pcs_nb;
 
 	/* What interface are supported by the current link.
 	 * Can change on removal or addition of new PCS.
@@ -560,12 +562,14 @@ static int phylink_validate_mac_and_pcs(struct phylink *pl,
 	 * the requested interface.
 	 */
 	} else if (test_bit(state->interface, pl->config->pcs_interfaces)) {
+		mutex_lock(&pl->state_mutex);
 		list_for_each_entry(pcs, &pl->pcs_list, list) {
 			if (!phylink_validate_pcs_interface(pcs, state->interface)) {
 				pcs_found = true;
 				break;
 			}
 		}
+		mutex_unlock(&pl->state_mutex);
 	}
 
 	if (pcs_found) {
@@ -1004,12 +1008,14 @@ static unsigned int phylink_inband_caps(struct phylink *pl,
 						  interface);
 		pcs_found = !!pcs;
 	} else if (test_bit(interface, pl->config->pcs_interfaces)) {
+		mutex_lock(&pl->state_mutex);
 		list_for_each_entry(pcs, &pl->pcs_list, list) {
 			if (!phylink_validate_pcs_interface(pcs, interface)) {
 				pcs_found = true;
 				break;
 			}
 		}
+		mutex_unlock(&pl->state_mutex);
 	}
 
 	if (!pcs_found)
@@ -1553,11 +1559,13 @@ static void phylink_mac_initial_config(struct phylink *pl, bool force_restart)
 	link_state.link = false;
 
 	phylink_apply_manual_flow(pl, &link_state);
+	mutex_lock(&pl->state_mutex);
 	if (phy)
 		mutex_lock(&phy->lock);
 	phylink_major_config(pl, force_restart, &link_state);
 	if (phy)
 		mutex_unlock(&phy->lock);
+	mutex_unlock(&pl->state_mutex);
 }
 
 static const char *phylink_pause_to_str(int pause)
@@ -1927,6 +1935,8 @@ static int phylink_fill_available_pcs(struct phylink *pl,
 	if (ret < 0)
 		goto out;
 
+	mutex_lock(&pl->state_mutex);
+
 	for (i = 0; i < config->num_possible_pcs; i++) {
 		struct phylink_pcs *pcs = pcss[i];
 
@@ -1936,12 +1946,90 @@ static int phylink_fill_available_pcs(struct phylink *pl,
 		list_add_tail(&pcs->list, &pl->pcs_list);
 	}
 
+	mutex_unlock(&pl->state_mutex);
+
 out:
 	kfree(pcss);
 
 	return ret;
 }
 
+static void phylink_del_pcs(struct phylink *pl, struct phylink_pcs *pcs)
+{
+	lockdep_assert_held(&pl->state_mutex);
+
+	list_del(&pcs->list);
+	pcs->phylink = NULL;
+
+	/*
+	 * Check if we are removing the PCS currently
+	 * in use by this phylink instance. If this is the case,
+	 * tear down the link, force phylink resolve to reconfigure the
+	 * interface mode, disable the current PCS and set the
+	 * phylink PCS to NULL.
+	 */
+	if (pl->pcs == pcs) {
+		if (pl->old_link_state) {
+			phylink_link_down(pl);
+			pl->old_link_state = false;
+		}
+		if (pl->cfg_link_an_mode == MLO_AN_INBAND)
+			timer_delete_sync(&pl->link_poll);
+		phylink_pcs_disable(pl->pcs);
+
+		pl->force_major_config = true;
+		WRITE_ONCE(pl->pcs, NULL);
+	}
+}
+
+static int pcs_provider_notify(struct notifier_block *self,
+			       unsigned long val, void *data)
+{
+	struct phylink *pl = container_of(self, struct phylink, fwnode_pcs_nb);
+	struct fwnode_pcs_provider *pp = data;
+	struct phylink_pcs *pcs, *tmp;
+	bool resolve = false;
+
+	rtnl_lock();
+
+	mutex_lock(&pl->state_mutex);
+
+	/*
+	 * Loop all the PCS for phylink instance and check if
+	 * this notification is relevant for some of them.
+	 */
+	list_for_each_entry_safe(pcs, tmp, &pl->pcs_list, list) {
+		if (!fwnode_pcs_matches_provider(pp, pl->fwnode, pcs))
+			continue;
+
+		phylink_del_pcs(pl, pcs);
+		resolve = true;
+	}
+
+	/* Exit early if nothing has changed */
+	if (!resolve) {
+		mutex_unlock(&pl->state_mutex);
+		rtnl_unlock();
+		return NOTIFY_DONE;
+	}
+
+	/* Refresh supported interfaces */
+	phy_interface_copy(pl->supported_interfaces,
+			   pl->config->supported_interfaces);
+	list_for_each_entry(pcs, &pl->pcs_list, list)
+		phy_interface_or(pl->supported_interfaces,
+				 pl->supported_interfaces,
+				 pcs->supported_interfaces);
+
+	mutex_unlock(&pl->state_mutex);
+
+	rtnl_unlock();
+
+	phylink_run_resolve(pl);
+
+	return NOTIFY_OK;
+}
+
 /**
  * phylink_create() - create a phylink instance
  * @config: a pointer to the target &struct phylink_config
@@ -2005,10 +2093,18 @@ struct phylink *phylink_create(struct phylink_config *config,
 		goto free_pl;
 	}
 
+	/* First register notifier for hotplug PCS events */
+	if (!phy_interface_empty(config->pcs_interfaces)) {
+		pl->fwnode_pcs_nb.notifier_call = pcs_provider_notify;
+		register_fwnode_pcs_notifier(&pl->fwnode_pcs_nb);
+	}
+
 	/* Fill the PCS list with available PCS from phylink config */
 	ret = phylink_fill_available_pcs(pl, config);
 	if (ret < 0)
-		goto free_pl;
+		goto unregister_pcs_notify;
+
+	mutex_lock(&pl->state_mutex);
 
 	/* Link available PCS to phylink */
 	list_for_each_entry(pcs, &pl->pcs_list, list)
@@ -2023,6 +2119,8 @@ struct phylink *phylink_create(struct phylink_config *config,
 				 pl->supported_interfaces,
 				 pcs->supported_interfaces);
 
+	mutex_unlock(&pl->state_mutex);
+
 	pl->mac_supports_eee_ops = phylink_mac_implements_lpi(mac_ops);
 	pl->mac_supports_eee = pl->mac_supports_eee_ops &&
 			       pl->config->lpi_capabilities &&
@@ -2054,7 +2152,7 @@ struct phylink *phylink_create(struct phylink_config *config,
 
 	ret = phylink_parse_mode(pl, fwnode);
 	if (ret < 0)
-		goto unlink_pcs_list;
+		goto unregister_pcs_notify;
 
 	if (pl->cfg_link_an_mode == MLO_AN_FIXED) {
 		ret = phylink_parse_fixedlink(pl, fwnode);
@@ -2073,11 +2171,17 @@ struct phylink *phylink_create(struct phylink_config *config,
 release_link_gpio:
 	if (pl->link_gpio)
 		gpiod_put(pl->link_gpio);
-unlink_pcs_list:
+unregister_pcs_notify:
+	if (pl->fwnode_pcs_nb.notifier_call)
+		unregister_fwnode_pcs_notifier(&pl->fwnode_pcs_nb);
+	/* PCS notifier might queue a resolve, cancel it */
+	cancel_work_sync(&pl->resolve);
+	mutex_lock(&pl->state_mutex);
 	list_for_each_entry_safe(pcs, tmp, &pl->pcs_list, list) {
 		list_del(&pcs->list);
 		pcs->phylink = NULL;
 	}
+	mutex_unlock(&pl->state_mutex);
 free_pl:
 	fwnode_handle_put(pl->fwnode);
 	kfree(pl);
@@ -2102,14 +2206,22 @@ void phylink_destroy(struct phylink *pl)
 	if (pl->link_gpio)
 		gpiod_put(pl->link_gpio);
 
+	/* Unregister notifier for late PCS attach */
+	if (pl->fwnode_pcs_nb.notifier_call)
+		unregister_fwnode_pcs_notifier(&pl->fwnode_pcs_nb);
+
 	cancel_work_sync(&pl->resolve);
 
+	mutex_lock(&pl->state_mutex);
+
 	/* Remove every PCS from phylink PCS list */
 	list_for_each_entry_safe(pcs, tmp, &pl->pcs_list, list) {
 		pcs->phylink = NULL;
 		list_del(&pcs->list);
 	}
 
+	mutex_unlock(&pl->state_mutex);
+
 	fwnode_handle_put(pl->fwnode);
 
 	kfree(pl);
diff --git a/include/linux/pcs/pcs.h b/include/linux/pcs/pcs.h
index ef2134c578c7..83e0a2ad4b09 100644
--- a/include/linux/pcs/pcs.h
+++ b/include/linux/pcs/pcs.h
@@ -4,7 +4,38 @@
 
 #include <linux/phylink.h>
 
+enum fwnode_pcs_notify_event {
+	FWNODE_PCS_PROVIDER_DEL,
+};
+
+struct fwnode_pcs_provider;
+
 #if IS_ENABLED(CONFIG_FWNODE_PCS)
+/**
+ * register_fwnode_pcs_notifier - Register a notifier block for fwnode
+ *				  PCS events
+ * @nb: pointer to the notifier block
+ *
+ * Registers a notifier block to the fwnode_pcs_notify_list blocking
+ * notifier chain. This allows phylink instance to subscribe for
+ * PCS provider events.
+ *
+ * Returns: 0 or a negative error.
+ */
+int register_fwnode_pcs_notifier(struct notifier_block *nb);
+
+/**
+ * unregister_fwnode_pcs_notifier - Unregister a notifier block for fwnode
+ *				    PCS events
+ * @nb: pointer to the notifier block
+ *
+ * Unregisters a notifier block to the fwnode_pcs_notify_list blocking
+ * notifier chain.
+ *
+ * Returns: 0 or a negative error.
+ */
+int unregister_fwnode_pcs_notifier(struct notifier_block *nb);
+
 /**
  * fwnode_pcs_get - Retrieves a PCS from a firmware node
  * @fwnode: firmware node
@@ -19,6 +50,27 @@
 struct phylink_pcs *fwnode_pcs_get(const struct fwnode_handle *fwnode,
 				   unsigned int index);
 
+/**
+ * fwnode_pcs_matches_provider() - Check whether a PCS belongs to a provider
+ * @provider: PCS provider to check
+ * @fwnode: firmware node containing the PCS references
+ * @pl_pcs: PCS to check
+ *
+ * Parse the PCS references from the "pcs-handle" property of a firmware node
+ * and use provider to determine whether pl_pcs is one of the PCS provided by
+ * provider.
+ *
+ * This function is intended to be used when handling provider removal
+ * notifications, where the provider is already known and its PCS need to be
+ * identified among the PCS associated with a phylink instance.
+ *
+ * Returns: true if pl_pcs is provided by provider and referenced by fwnode,
+ * false otherwise.
+ */
+bool fwnode_pcs_matches_provider(struct fwnode_pcs_provider *provider,
+				 const struct fwnode_handle *fwnode,
+				 struct phylink_pcs *pl_pcs);
+
 /**
  * fwnode_phylink_pcs_count - Count PCS entries described in firmware node
  * @fwnode: firmware node
@@ -52,12 +104,29 @@ int fwnode_phylink_pcs_parse(struct fwnode_handle *fwnode,
 			     struct phylink_pcs **available_pcs,
 			     unsigned int num_pcs);
 #else
+static inline int register_fwnode_pcs_notifier(struct notifier_block *nb)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int unregister_fwnode_pcs_notifier(struct notifier_block *nb)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct phylink_pcs *fwnode_pcs_get(const struct fwnode_handle *fwnode,
 						 unsigned int index)
 {
 	return ERR_PTR(-ENOENT);
 }
 
+static inline bool fwnode_pcs_matches_provider(struct fwnode_pcs_provider *provider,
+					       const struct fwnode_handle *fwnode,
+					       struct phylink_pcs *pl_pcs)
+{
+	return false;
+}
+
 static inline unsigned int fwnode_phylink_pcs_count(struct fwnode_handle *fwnode)
 {
 	return 0;
-- 
2.53.0

