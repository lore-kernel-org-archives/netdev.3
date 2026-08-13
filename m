Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990173E5ED0
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 08:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610168; cv=none; b=mCyhJHNYf31rchuKCHq21sAWaiYWAQ/R1Sb0PB0HJxryD8r562hmH7PfynSrjq9QLVib3c36oOipzBqyZyjvfEQazc36dLeEpLT9fhuMhrFVva9hl+WrVT7jWG2db0DGKAMiE+qBD0f+LFCXcOSN45587WqaIk6SbQKXKOSx+68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610168; c=relaxed/simple;
	bh=Qti9OVqgxHaC2hGhVvxEKy+qZAYBuimRuqkq4y/5ml4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSJbdRvEsj5BIOTGaSHbGs/uP5qRuZXzWcHvjuO5OlkM7au0Ye/DKVPKK4r682AjB36BC99jFbl8TvNbauRhztAuDZkI2Iv2cHfUGAWFtRmaLY2K0UNO48xabbZk6RKnxBzonipvTUchGMFcQDUeZ2lbrvv7oBtGf/lbnHTFVdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I44/z42G; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I44/z42G"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso4883325e9.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 01:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786610162; x=1787214962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b63L1TrP0U7rRym732TrvoKjas6MduGTnxcirzTMOXU=;
        b=I44/z42GkMqduQDh2ym6vvfFIXHgCTtPqSiIoSXaxMdeDzB3mf6sXjPxwAGCFQzLaQ
         fO5+L48mwVQRYPBdfIEQ5TcYimWli1Fid569czXcj6l70V2OfwLRgDv596av7o7HopJD
         c6/cIfA6/y+I1frOeIx+sCJslVWkDRFUuWO8a6By7bTAy8vbs8XDm9iVJzX1b9r3FhOI
         3qgq1tGjow9/L/YeybCTn6Lw+S/EvU1ALKVXfmy6cAOvjeebUCzhMj4XizT9pISZDa2I
         sw6VFTRNtS+GgcOMkqVWwFNzEwk8B8Zcl/o48fuVZDScSd6Xtoy6GFk1AH2/lxlHRIxw
         XGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786610162; x=1787214962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=b63L1TrP0U7rRym732TrvoKjas6MduGTnxcirzTMOXU=;
        b=j/FI+uv+2k0V6k7fDWCJDN8820wGBXL7HoJHypM86owm/M+yQFn76FO76bjwExYehx
         SmpP6z1l0Fma0/WXW/TvrdDBln2gB3AJUdX/4HqoIX85PzkG/kUVKq1ZOhScWXmQlMPw
         XJU9l6WICTbYxzVwC3nTvZRPRGsDBUQSvI3i3mh/OT/rvSfV2RkhfuStfsE1zEfshve/
         8NbmtDFNuTV5FaFlOAKMZpLjYABaiZOFlBjix34qLG0j0yWnOiKcbRGqdEibW2I0Lwie
         KqdcdL6OCUNNDv4HvJs6PfVjw05SgnivLqbsUif5iO7/of0dHRA9RhLcR0SDRR/P6Vur
         Hwyw==
X-Forwarded-Encrypted: i=1; AHgh+RrHASGStz9EwLAnLKDuarhc2+n5mSH86lrExbH6SpgS3hL+8rUOSgYdcOYqUqLY3yDaYNjGDBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YycxdvD/EFx4r5BJBfzwy7RcmTyLkvfDTmHyDcFKgKR17rXftXJ
	opgRpSDRGOBqpiZ7tkcWgBw8Nisl2L7jiqk8Jxy/M2SHO/zzNAk5975R
X-Gm-Gg: AR+sD13bkHxa6FZoUXmonsQoTEjkn82gSsrPfvRLpeKVe9ypu3Eqjdwppc3Qctlmi/R
	Ui4OdqT2AQzCZ2SaHUT0FFxrsbSwHIk5JUOhVN8wtvopPmvKw7oc4ERawbYe48mOkxakwsBhGuM
	Rh0V26VYZxJDTdrlIVKiRtiX8mNUpmv7bMua2abkrqt34bU8VTMdIbIzdWmjWxY0KZmirLXPZ1P
	9lhHZb17S/qDsgW1zRNpeCAvtuVWNeyjy+jX+d6+IsIbQxsLAqp7Oj1fa2dX4qI/DsglSoRBOG5
	xAgMhKgECY3x+NBipMULR1N7mfvx1rggn0wi+sRnx648v2W1bvFT7S2SC79Zp0X30zbUukEfQTk
	l3v0rSGGmmL2gHpS3t6lAKdasr+uKNa01apW0FPf5G8vN4iU6uP6qvmGQD+l1qb7xxUyJh1Inzr
	jovL1kRC6/MZsztw7k5d4V3gOEMwkmStERZQM/3S5RuSKLOwQV2nP5g3aKOmByie1BFTCGzb1Ou
	EbxihPs72BVptjPP/bL+7TDlW96N2VkKNMSH1X8lCz1e4qm
X-Received: by 2002:a05:600c:1988:b0:493:c47f:3c55 with SMTP id 5b1f17b1804b1-4998215e5f2mr46441475e9.5.1786610161711;
        Thu, 13 Aug 2026 01:36:01 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-20-3-207.retail.telecomitalia.it. [87.20.3.207])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4998216d082sm45804425e9.13.2026.08.13.01.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 01:36:01 -0700 (PDT)
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
Subject: [PATCH v14 06/12] net: phylink: support late PCS provider attach
Date: Thu, 13 Aug 2026 10:35:11 +0200
Message-ID: <20260813083536.970196-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813083536.970196-1-ansuelsmth@gmail.com>
References: <20260813083536.970196-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for late PCS provider attachment to a phylink instance.
Similar to FWNODE_PCS_PROVIDER_DEL, FWNODE_PCS_PROVIDER_ADD is added to
address the case where a PCS provider is added after a phylink instance is
created and started.

The PCS notifier will emit the event FWNODE_PCS_PROVIDER_ADD every time
a new PCS provider is added.

If a related PCS is found, then such PCS is added to the phylink
instance PCS list.

Such PCS is then linked to the phylink instance and the supported
interfaces of the phylink instance get refreshed.

If we are in a major_config_failed scenario an interface reconfiguration
is triggered in the next phylink resolve.

In the example scenario where the link was previously torn down due to
removal of PCS, the link will be established again as the PCS came back
and is now available to phylink.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/pcs/pcs.c     | 22 +++++++++++
 drivers/net/phy/phylink.c | 82 +++++++++++++++++++++++++++++++--------
 include/linux/pcs/pcs.h   | 31 +++++++++++++++
 3 files changed, 118 insertions(+), 17 deletions(-)

diff --git a/drivers/net/pcs/pcs.c b/drivers/net/pcs/pcs.c
index 25b3248e8b93..fef560eddf2a 100644
--- a/drivers/net/pcs/pcs.c
+++ b/drivers/net/pcs/pcs.c
@@ -69,6 +69,10 @@ fwnode_pcs_add_provider(struct fwnode_handle *fwnode,
 
 	mutex_unlock(&fwnode_pcs_mutex);
 
+	blocking_notifier_call_chain(&fwnode_pcs_notify_list,
+				     FWNODE_PCS_PROVIDER_ADD,
+				     pp);
+
 	pr_debug("Added pcs provider from %pfwf\n", fwnode);
 
 	return pp;
@@ -201,6 +205,24 @@ struct phylink_pcs *fwnode_pcs_get(const struct fwnode_handle *fwnode, unsigned
 }
 EXPORT_SYMBOL_GPL(fwnode_pcs_get);
 
+struct phylink_pcs *fwnode_pcs_get_from_provider(struct fwnode_pcs_provider *provider,
+						 const struct fwnode_handle *fwnode,
+						 int index)
+{
+	struct fwnode_reference_args pcsspec;
+	struct phylink_pcs *pcs;
+	int ret;
+
+	ret = fwnode_parse_pcsspec(fwnode, index, NULL, &pcsspec);
+	if (ret)
+		return ERR_PTR(ret);
+
+	pcs = __fwnode_pcs_get_from_pcsspec_provider(&pcsspec, provider);
+	fwnode_handle_put(pcsspec.fwnode);
+	return pcs;
+}
+EXPORT_SYMBOL_GPL(fwnode_pcs_get_from_provider);
+
 bool fwnode_pcs_matches_provider(struct fwnode_pcs_provider *provider,
 				 const struct fwnode_handle *fwnode,
 				 struct phylink_pcs *pl_pcs)
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 967cc919a365..ba3efdb0a194 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1926,6 +1926,27 @@ int phylink_set_fixed_link(struct phylink *pl,
 }
 EXPORT_SYMBOL_GPL(phylink_set_fixed_link);
 
+static void phylink_add_pcs(struct phylink *pl, struct phylink_pcs *pcs)
+{
+	struct phylink_pcs *tmp;
+
+	/*
+	 * Make sure state mutex is locked to protect concurrent
+	 * access to phylink instance PCS list from
+	 * initial fill_available_pcs and late PCS attach
+	 */
+	lockdep_assert_held(&pl->state_mutex);
+
+	list_for_each_entry(tmp, &pl->pcs_list, list)
+		if (tmp == pcs)
+			return;
+
+	list_add_tail(&pcs->list, &pl->pcs_list);
+
+	/* Link PCS to phylink */
+	pcs->phylink = pl;
+}
+
 static int phylink_fill_available_pcs(struct phylink *pl,
 				      struct phylink_config *config)
 {
@@ -1958,7 +1979,7 @@ static int phylink_fill_available_pcs(struct phylink *pl,
 		if (!pcs)
 			continue;
 
-		list_add_tail(&pcs->list, &pl->pcs_list);
+		phylink_add_pcs(pl, pcs);
 	}
 
 out:
@@ -2004,27 +2025,57 @@ static int pcs_provider_notify(struct notifier_block *self,
 	struct fwnode_pcs_provider *pp = data;
 	struct phylink_pcs *pcs, *tmp;
 	bool resolve = false;
+	int count, i;
 
-	rtnl_lock();
+	/*
+	 * On PCS provider deletion hold rtnl lock as one of
+	 * PCS can be currently in use by the phylink instance
+	 * and ethtool OPs can reference it.
+	 */
+	if (val == FWNODE_PCS_PROVIDER_DEL)
+		rtnl_lock();
 
 	mutex_lock(&pl->state_mutex);
 
-	/*
-	 * Loop all the PCS for phylink instance and check if
-	 * this notification is relevant for some of them.
-	 */
-	list_for_each_entry_safe(pcs, tmp, &pl->pcs_list, list) {
-		if (!fwnode_pcs_matches_provider(pp, pl->fwnode, pcs))
-			continue;
+	switch (val) {
+	case FWNODE_PCS_PROVIDER_ADD:
+		count = fwnode_phylink_pcs_count(pl->fwnode);
+		for (i = 0; i < count; i++) {
+			pcs = fwnode_pcs_get_from_provider(pp, pl->fwnode, i);
+			if (IS_ERR(pcs))
+				continue;
+
+			phylink_add_pcs(pl, pcs);
+			resolve = true;
+		}
+
+		/* Force an interface reconfig if major config fail */
+		if (resolve && pl->major_config_failed)
+			pl->force_major_config = true;
 
-		phylink_del_pcs(pl, pcs);
-		resolve = true;
+		break;
+	case FWNODE_PCS_PROVIDER_DEL:
+		/*
+		 * Loop all the PCS for phylink instance and check if
+		 * this notification is relevant for some of them.
+		 */
+		list_for_each_entry_safe(pcs, tmp, &pl->pcs_list, list) {
+			if (!fwnode_pcs_matches_provider(pp, pl->fwnode, pcs))
+				continue;
+
+			phylink_del_pcs(pl, pcs);
+			resolve = true;
+		}
+		break;
 	}
 
 	/* Exit early if nothing has changed */
 	if (!resolve) {
 		mutex_unlock(&pl->state_mutex);
-		rtnl_unlock();
+
+		if (val == FWNODE_PCS_PROVIDER_DEL)
+			rtnl_unlock();
+
 		return NOTIFY_DONE;
 	}
 
@@ -2038,7 +2089,8 @@ static int pcs_provider_notify(struct notifier_block *self,
 
 	mutex_unlock(&pl->state_mutex);
 
-	rtnl_unlock();
+	if (val == FWNODE_PCS_PROVIDER_DEL)
+		rtnl_unlock();
 
 	phylink_run_resolve(pl);
 
@@ -2146,10 +2198,6 @@ struct phylink *phylink_create(struct phylink_config *config,
 
 	mutex_lock(&pl->state_mutex);
 
-	/* Link available PCS to phylink */
-	list_for_each_entry(pcs, &pl->pcs_list, list)
-		pcs->phylink = pl;
-
 	phy_interface_copy(pl->supported_interfaces,
 			   pl->config->supported_interfaces);
 
diff --git a/include/linux/pcs/pcs.h b/include/linux/pcs/pcs.h
index 83e0a2ad4b09..00a636c82c65 100644
--- a/include/linux/pcs/pcs.h
+++ b/include/linux/pcs/pcs.h
@@ -5,6 +5,7 @@
 #include <linux/phylink.h>
 
 enum fwnode_pcs_notify_event {
+	FWNODE_PCS_PROVIDER_ADD,
 	FWNODE_PCS_PROVIDER_DEL,
 };
 
@@ -50,6 +51,28 @@ int unregister_fwnode_pcs_notifier(struct notifier_block *nb);
 struct phylink_pcs *fwnode_pcs_get(const struct fwnode_handle *fwnode,
 				   unsigned int index);
 
+/**
+ * fwnode_pcs_get_from_provider() - Retrieve a PCS from a specific provider
+ * @provider: PCS provider to use
+ * @fwnode: firmware node
+ * @index: index fwnode PCS handle in firmware node
+ *
+ * Get a PCS from the firmware node at index specifically provided by
+ * passed PCS provider.
+ *
+ * Unlike fwnode_pcs_get(), this function does not search the global list of
+ * PCS providers. The caller must provide the provider responsible for the
+ * referenced PCS.
+ *
+ * Returns: a pointer to the phylink_pcs or a negative error pointer. Can
+ * return -ENODEV if the PCS is not present in global providers list (either
+ * due to driver still needs to be probed or it failed to probe/removed) or
+ * can return -EINVAL if the PCS provider doesn't expose any PCS for the fwnode.
+ */
+struct phylink_pcs *fwnode_pcs_get_from_provider(struct fwnode_pcs_provider *provider,
+						 const struct fwnode_handle *fwnode,
+						 int index);
+
 /**
  * fwnode_pcs_matches_provider() - Check whether a PCS belongs to a provider
  * @provider: PCS provider to check
@@ -120,6 +143,14 @@ static inline struct phylink_pcs *fwnode_pcs_get(const struct fwnode_handle *fwn
 	return ERR_PTR(-ENOENT);
 }
 
+static inline struct phylink_pcs *
+fwnode_pcs_get_from_provider(struct fwnode_pcs_provider *provider,
+			     const struct fwnode_handle *fwnode,
+			     int index)
+{
+	return ERR_PTR(-ENOENT);
+}
+
 static inline bool fwnode_pcs_matches_provider(struct fwnode_pcs_provider *provider,
 					       const struct fwnode_handle *fwnode,
 					       struct phylink_pcs *pl_pcs)
-- 
2.53.0

