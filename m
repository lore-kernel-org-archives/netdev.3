Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBFA495AE1
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602759; cv=none; b=I6Fw0M1RlPNqUZjdOJgcKhmFqhR+4s6zfa7l9TKmOGyjzLawYF6+xL5X3LB7ODV8rbfSPUzrGIBZhCdZhe4MheH2DiDGQA0hrwGH/JovLvtif/BUfVadcIVKlzVxs31MuscO2dttw3ktAbVNgD+1Fs7/yFGhT1YIo98hoBLmNx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602759; c=relaxed/simple;
	bh=KGqO6VCb3liDBk6w1S5YlJMR6eW9BmXaCVbJL5H8U78=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQiG0qAuS6Wh7/0aYfWzXOffuH2Ad+BHPC0Xb573PjtPE4BRtJqV1tMzqzK6iSWvK51gJB4Pi3p5LEpGLMus6u8UPz3RYEI6C6vYBu/WcKwjSFGuWjf1BmxRsoNNZg0KzP9vn6xrLMa3nz1NkM9d9ttALdeZqEcNX/eCeuwC9SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPXMydUU; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPXMydUU"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843cedd129so169863f8f.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789602748; x=1790207548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I6vHaZFFw3iOWw8/jtHHFZibW/y6sOiPqWI9OvgWuHw=;
        b=ZPXMydUUaNLuNjC3aaXcMaSdPObfqqWuKM7KlvRu8enopVgf+xsgoJ+DbKC03XmejF
         FW4xlyMjZ/3ysdmGOxBxS40i8FVRgzaLahWN6TJJzAeMGX+oeLB0d62ay7Tpx3V7+mmP
         AtQp5GsAtUa/Tr/Pu67KMABDzP32sTlXiRGZ0Wpkoi6JDP971rhKGy9T+j40zPdu5g8v
         EHOZdpTLYgSba7dHg3ANg2+O/hTymBLCFxUFlS7t20CZfYuxGHyMD+U8KlJh/aoIbuBp
         SBDNGU/n/xJJwwnhiALzwPXp5Ovf1ZGOEUNDD/cmkAHuzpJ6v8dTT6hq7iLS/oP419sQ
         k3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789602748; x=1790207548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=I6vHaZFFw3iOWw8/jtHHFZibW/y6sOiPqWI9OvgWuHw=;
        b=hyDIRmMq2Wj4CTXVh4wUwfeWNr8JWzVUWxuYLPVSolgb8OnWPQbpgZrkAupB/mJVbs
         XgvpbovrLXw0V7y0+Dio6L0x7UgLQR0zqeuF1VN5z3QitbqVEc3OMcOc80cnezYT1lNI
         olk32bvbTSJXdfsLcyOrgIz4VXMu3HpIzstsbk4qa/pckXdWfVDeMkutsmBJxMlt9uym
         FOkicd7icVKqGVA3p3LwBb8q68NkvZ7+uzR+w4pVnZ/IBRi0F7nKvB4/ExcM2rvzYdKq
         QLirPoH9M4FqZJoRMKHn+ihu1FHP8m9QHLhTdJ9PYHVct8GyJBtw05vUmXouWCnaYpxT
         e9tw==
X-Forwarded-Encrypted: i=1; AKwUvBz53Ibw/k8EzjRJGcB/ONNBun9UBYjV4MlvdaMK9CtfRbpaRkWlDeImvsNa8NutqU1EYFffa58=@vger.kernel.org
X-Gm-Message-State: AFuF++m8u9eJHSyaAKz3mqywSiwL+ysTbMJa/Muwr7XEdmcxeQKmpiSW
	uiqAGcBvMQMjz6bv1v+/B5g+eCMDVxit3cswK2tqOROCk5ggSfC189YB
X-Gm-Gg: AYBFou37uwR59nI9XS4S87LstzPilX10Ued3CHqHP3x/5Cr0o3jwPikZ3K6WAP77xB9
	h7wFB5CuzgimxFCu13gbODDwN02qaZAdj8VvMzfRsPUq8J6w2UnCNJqN35Y3PAdO7doefx7WS3W
	4koyscbtWBPLCuews+x/MlXAuQGuFJCAB4foxIFBUzXfMz7y9kHDPrWIES9ZQtBhH/41+L4AFwG
	xafhS/7NfdAkuJ1zyJnuslnl7B7b2MfkY7nxNH5q6aZGJumB/4I7NurPOUe7XBTOgpkq8qhpzKO
	8XyxHrIU1W0GedqXFCVzGyOE9G/OLxHQkC0AFvJQTb83jEQuqOqfAkZx3DQj2V/NLkktujYWiyV
	0gRzpR2EfLyeUiljsno9/P98IDHFnyh05Uhrg8zmWZQXu8HCg4fi48zNmM8XxqgwAgEzBM4QVDl
	q3C8gb9DD8Z2qBdSKa/P1tYD8pZE5Jtx+ikf/Q8t3bRxVTxB3sDpmKuCKCTqFvYl21JYMwaZsDD
	JFT93o1JPFJ7kNvCmw1aY6tAgHkoyWQOlx0MtMaYApzCZ0LYcSK4SVvpidII14=
X-Received: by 2002:a05:6000:654:b0:487:72f:fb42 with SMTP id ffacd0b85a97d-4870cf29d90mr10063576f8f.14.1789602748293;
        Wed, 16 Sep 2026 16:52:28 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-26-252-140.retail.telecomitalia.it. [79.26.252.140])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4870bef7687sm11861104f8f.1.2026.09.16.16.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 16:52:27 -0700 (PDT)
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
	llvm@lists.linux.dev
Subject: [PATCH net-next v16 06/12] net: phylink: support late PCS provider attach
Date: Thu, 17 Sep 2026 01:51:32 +0200
Message-ID: <20260916235200.20712-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916235200.20712-1-ansuelsmth@gmail.com>
References: <20260916235200.20712-1-ansuelsmth@gmail.com>
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
index 88570a59ba9e..fb3fb522769b 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1928,6 +1928,27 @@ int phylink_set_fixed_link(struct phylink *pl,
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
@@ -1960,7 +1981,7 @@ static int phylink_fill_available_pcs(struct phylink *pl,
 		if (!pcs)
 			continue;
 
-		list_add_tail(&pcs->list, &pl->pcs_list);
+		phylink_add_pcs(pl, pcs);
 	}
 
 out:
@@ -2006,27 +2027,57 @@ static int pcs_provider_notify(struct notifier_block *self,
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
 
@@ -2040,7 +2091,8 @@ static int pcs_provider_notify(struct notifier_block *self,
 
 	mutex_unlock(&pl->state_mutex);
 
-	rtnl_unlock();
+	if (val == FWNODE_PCS_PROVIDER_DEL)
+		rtnl_unlock();
 
 	phylink_run_resolve(pl);
 
@@ -2268,10 +2320,6 @@ struct phylink *phylink_create(struct phylink_config *config,
 
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

