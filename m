Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203E5509F0F
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570558; cv=none; b=gkEdoDwZFlJZBqe0UspCah6rHDlxT/08D7RGgC8pFufxYBLXW5uQqWSCYybVOSqTdbZPl6wwhinUen6CSgeX64M5UJ9i11Mq7kX2kvPa2pSbAFJZQy3RPr+W0JcXd3jPLNJ7QB+FDWtTJ92EIFg3UI/5KJRd/gIK4AmphlcaJc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570558; c=relaxed/simple;
	bh=mywYGvl4RsZA/paCQINARoXRX2DunX2Pju/dKnSFr7c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uEfHXHJ6O77eNEL1MX/hngHgLbRyVRaOu1JzTdGqgxHIBskehcc6m0iCwriK+9mDkK1y03oyhh+t33+s2pV+OMTTXk9mhB6w8pVk7a7AaRpTqBbTpAItfkb9++/LuFVNDdEkfUxX6MxTepSbErpMFjTz1AVKTLLDKY1dpsu5fKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ct304/lJ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ct304/lJ"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso59131f8f.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 11:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791570549; x=1792175349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zgVxN7jjDBBi7QLO/S2lw+BavtVzIiBwIreDYz7qKS8=;
        b=ct304/lJCazXpw8sj5wQl4y1PrGXHowVvcjbJLoPDwe2nrZ8xHCBLHldkNGqRszb6N
         Z+Q7tjpZenKS6e7MhCxGFoWG5fwb6CDslWxVwG1lIIj1+Z5m31J0LjS5zIri+OeNhHfT
         sHG2KXPRkVGkfJZZaz/a8DNN4j9Qc1+gSeeXCiOLY/g7AliR4Y5NiX0mlhBtAuqeDnyS
         pfNBU79B39Avv7pz0KeRTHPqlUcg/vuPybbWtR3gxqjmhRhvJKHx0lbbGlby705MxP9V
         YpcQEDGClAJEMYG5248eMZxBUjGOkIXfmZ/6m2NqGGdrzobzb764nrJF9V0rF25aZ7Mx
         kKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791570549; x=1792175349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zgVxN7jjDBBi7QLO/S2lw+BavtVzIiBwIreDYz7qKS8=;
        b=g8IhxLuhgP6IgX7UYcnjGcRiGRkevB2VCpamomyxQGb1jl5BKJui+M62tds78+DJBO
         pXzVfjJO/G2dmPscLBzCKHN31D3sKefUHAtn7P2D5dC5HZUTuFq3Fe91foX7UGr5o5bT
         JXD/bBI8Ehb3EKdWt6V0S9d4ukAeKWiz1gS4nV0Dby6YrmMmZgERmzsN6n28nMKKnRUH
         wgNKEWXBL7RgfxYbhz9fa3FJOTogx7ld9wHprykur/ijhe3v1qQgRDNCwy9DOZ8pUGmX
         M217IzMAm0kQGzhQeLMrYZx1TXCdEHeR99p2nkpwYeGOuSd90SRmSpTwOf/6pBJsycxP
         YUBA==
X-Forwarded-Encrypted: i=1; AKwUvBxrRShUn6g1nBsdIUVDDjocqVB54+4EBuw6uoUXHX86eG8hOKZzw09KFfXWgXLuFk3ydGajxYc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJvkvmo0G3BRWebr7szWiT8cCTdloY33q0wjL7QviLWKQ4CNa4
	uOSoOQl01CMjfQHPpruuws88P6rAz8YqpqXBSooyaM5FlY/BkHhtt5nh
X-Gm-Gg: AYBFou0wJXXw5Y/Zplh6KtRYN+FAxFjSPi+Ur0WZ59giHL73+ERnDnLctmAseRwfHJ8
	zjf6YL6utskY2/2BzMw6wQHDimTLw8trNIplBd25DbmCZxlRA/aeq3v12J+tyFR26GYCLAXyOZ6
	jcXdoqjSHnJbnPiI2yMb7+5PkNBkpGEeShC712Wu/dZD7KJADYYZgznlcT6olpQ908ntHXNN9E0
	Q4NKglxa+wL2MrRI2pqUUjVPCiDuwPMV21CcSZsu5d3fh3DGxN3s8KvmNK8EssxLJD7edJ+kUXn
	qTkNtPERjYc3WG5KNgvwi8bj7YpkPBm6jcvnA8f7HbFzyHnxdfgCAjRAmAGIlLipPl7pHVYtxx8
	1PtIGOpILeNHa56Niq0fxaHRMgGV4AGlKVqFtBl8p25jXHagxNlecN0/qnR+pUPsxqD+O3x4RLp
	sDSVWo7fDLE3NXdfb5m5JAhdusKOeRxPZZpDD6PjAW/rueWTdkeCyzn75WDWM5iTaoNLEdNj0f8
	l1kyMG/ANTy68AbfHSH4eG8/8Sa2/3Vo0fpgeZvMUEUduvY57+2rN+hudxKQarkAYHz6t2Crnk4
	6+RwiR2J3CkRZAPwFSuhefsUYsAQ
X-Received: by 2002:a05:6000:400d:b0:487:b2b:457b with SMTP id ffacd0b85a97d-48dba9bda77mr5891329f8f.15.1791570549146;
        Fri, 09 Oct 2026 11:29:09 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-213-45-9-252.retail.telecomitalia.it. [213.45.9.252])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48db9adf5e6sm5037794f8f.56.2026.10.09.11.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 11:29:08 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
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
	llvm@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v18 06/12] net: phylink: support late PCS provider attach
Date: Fri,  9 Oct 2026 20:28:02 +0200
Message-ID: <20261009182836.50631-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009182836.50631-1-ansuelsmth@gmail.com>
References: <20261009182836.50631-1-ansuelsmth@gmail.com>
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
 drivers/net/pcs/pcs.c     | 22 ++++++++++++
 drivers/net/phy/phylink.c | 72 +++++++++++++++++++++++++++++++--------
 include/linux/pcs/pcs.h   | 31 +++++++++++++++++
 3 files changed, 111 insertions(+), 14 deletions(-)

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
index 019ce3d89da0..59283564f72e 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1928,6 +1928,30 @@ int phylink_set_fixed_link(struct phylink *pl,
 }
 EXPORT_SYMBOL_GPL(phylink_set_fixed_link);
 
+static bool phylink_add_pcs(struct phylink *pl, struct phylink_pcs *pcs)
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
+	/* Make sure PCS is not already in the list */
+	list_for_each_entry(tmp, &pl->pcs_list, list)
+		if (tmp == pcs)
+			return false;
+
+	list_add_tail(&pcs->list, &pl->pcs_list);
+
+	/* Link PCS to phylink */
+	pcs->phylink = pl;
+
+	return true;
+}
+
 static int phylink_fill_available_pcs(struct phylink *pl,
 				      struct phylink_config *config)
 {
@@ -1960,7 +1984,7 @@ static int phylink_fill_available_pcs(struct phylink *pl,
 		if (!pcs)
 			continue;
 
-		list_add_tail(&pcs->list, &pl->pcs_list);
+		phylink_add_pcs(pl, pcs);
 	}
 
 out:
@@ -2006,27 +2030,51 @@ static int pcs_provider_notify(struct notifier_block *self,
 	struct fwnode_pcs_provider *pp = data;
 	struct phylink_pcs *pcs, *tmp;
 	bool resolve = false;
+	int count, i;
 
 	rtnl_lock();
 
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
+			/* Trigger a resolve only if a PCS is actually added */
+			if (phylink_add_pcs(pl, pcs))
+				resolve = true;
+		}
+
+		/* Force an interface reconfig if major config fail */
+		if (resolve && pl->major_config_failed)
+			pl->force_major_config = true;
+
+		break;
+	case FWNODE_PCS_PROVIDER_DEL:
+		/*
+		 * Loop all the PCS for phylink instance and check if
+		 * this notification is relevant for some of them.
+		 */
+		list_for_each_entry_safe(pcs, tmp, &pl->pcs_list, list) {
+			if (!fwnode_pcs_matches_provider(pp, pl->fwnode, pcs))
+				continue;
 
-		phylink_del_pcs(pl, pcs);
-		resolve = true;
+			phylink_del_pcs(pl, pcs);
+			resolve = true;
+		}
+		break;
 	}
 
 	/* Exit early if nothing has changed */
 	if (!resolve) {
 		mutex_unlock(&pl->state_mutex);
+
 		rtnl_unlock();
+
 		return NOTIFY_DONE;
 	}
 
@@ -2274,10 +2322,6 @@ struct phylink *phylink_create(struct phylink_config *config,
 
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
2.55.0

