Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01662388881
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940342; cv=none; b=Hde3t+heDA/6px+yc6I0S67ReyWBqpavYBGIrFxVZl7eIBHLC3oLESBwPSOx0UU4+Y9obigxwxUWe2qzL4tOegGsys8SRcwlv/0xv3TD7CFgSaH0jlvMbTOIciwu9/N05eOYuoTKqJs8+34o7gU/OpqCJJ+N+bydu2NjWfZSE/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940342; c=relaxed/simple;
	bh=wu1G6dRUyJA61ns2lGtMsqmPiKV92wezp4R3V3JKze4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnnAPzngNM9vHYrYlGU7BxpT16Wxc6S+Kz2IuxWYNSfcYO4J6ZFYfYnlAb+frrxpmbhjHq3hqH7zKygE8hXyGZCD3bt3kOTdDB2rVq3EjALzjX/1Vn+U1A8sno2DgoLqJU3Pl1Pfod6ffvRHf4GrgN5v2n6s6xDlhXTRMNiuj/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=uEBHodpN; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="uEBHodpN"
Received: from kero.packetmixer.de (p200300c5970b56d88Eebac4310d100Aa.dip0.t-ipconnect.de [IPv6:2003:c5:970b:56d8:8eeb:ac43:10d1:aa])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 98046FA1DF;
	Wed, 05 Aug 2026 16:32:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785940330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fEO3/kLmL6SmU2jKGwS0RERQbRf/VGCpfalTmiKvqFQ=;
	b=uEBHodpN6od0b8IqamW7zwKjeL1kIk0tynwpZjIZtXk8TI1pHWru6WgQU0PMKLz63xecVE
	0o60Bwe8TQNahWikFNII/UQ2O7+5rCkod7tS1GxYajIjF4GA6ExLycNzYE1cUWlFg00Xw1
	mDexgIJne3my67eps6ieyVdfhKFP6wLeLSUb+3cpAnIwoGdx04ChOoKtlxyRJBWEXYRlzS
	QaMQm2NtQXdXW1CZrdvrwWRMWV/zfWVcUqpGFOZb57G+HptCBecAcVHVFcLkKPMpdOY90w
	Hr7C2xiGWvJJEP3CesCCZsW3cu7eTQwlinxRpKtPFlwbWGBBrAvMGDeSbJNhIw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Minhong He <heminhong@kylinos.cn>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 08/10] batman-adv: handle errors in batadv_init()
Date: Wed,  5 Aug 2026 16:27:22 +0200
Message-ID: <20260805143200.722098-9-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260805143200.722098-1-sw@simonwunderlich.de>
References: <20260805143200.722098-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Minhong He <heminhong@kylinos.cn>

batadv_init() ignores errors from several initialization helpers, so the
module can load without those registrations in place.

Check the fallible init steps and unwind prior initialization in reverse
order of acquisition on failure.

Signed-off-by: Minhong He <heminhong@kylinos.cn>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c |  8 +++++++
 net/batman-adv/bat_iv_ogm.h |  1 +
 net/batman-adv/bat_v.c      |  9 ++++++++
 net/batman-adv/bat_v.h      |  5 +++++
 net/batman-adv/main.c       | 45 ++++++++++++++++++++++++++++---------
 net/batman-adv/netlink.c    |  6 ++++-
 net/batman-adv/netlink.h    |  2 +-
 7 files changed, 63 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index aff279b83da49..53fbdbbe8f4f7 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -2802,3 +2802,11 @@ int __init batadv_iv_init(void)
 out:
 	return ret;
 }
+
+/**
+ * batadv_iv_deinit() - B.A.T.M.A.N. IV deinitialization function
+ */
+void batadv_iv_deinit(void)
+{
+	batadv_recv_handler_unregister(BATADV_IV_OGM);
+}
diff --git a/net/batman-adv/bat_iv_ogm.h b/net/batman-adv/bat_iv_ogm.h
index 04b01bd684e80..90318801aeaff 100644
--- a/net/batman-adv/bat_iv_ogm.h
+++ b/net/batman-adv/bat_iv_ogm.h
@@ -10,5 +10,6 @@
 #include "main.h"
 
 int batadv_iv_init(void);
+void batadv_iv_deinit(void);
 
 #endif /* _NET_BATMAN_ADV_BAT_IV_OGM_H_ */
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index ee372fc9d44e9..0c27447cf6889 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -947,3 +947,12 @@ int __init batadv_v_init(void)
 
 	return ret;
 }
+
+/**
+ * batadv_v_deinit() - B.A.T.M.A.N. V deinitialization function
+ */
+void batadv_v_deinit(void)
+{
+	batadv_recv_handler_unregister(BATADV_OGM2);
+	batadv_recv_handler_unregister(BATADV_ELP);
+}
diff --git a/net/batman-adv/bat_v.h b/net/batman-adv/bat_v.h
index 964431f4dc8de..76bd969e79a26 100644
--- a/net/batman-adv/bat_v.h
+++ b/net/batman-adv/bat_v.h
@@ -12,6 +12,7 @@
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 
 int batadv_v_init(void);
+void batadv_v_deinit(void);
 void batadv_v_hardif_init(struct batadv_hard_iface *hardif);
 int batadv_v_mesh_init(struct batadv_priv *bat_priv);
 void batadv_v_mesh_free(struct batadv_priv *bat_priv);
@@ -23,6 +24,10 @@ static inline int batadv_v_init(void)
 	return 0;
 }
 
+static inline void batadv_v_deinit(void)
+{
+}
+
 static inline void batadv_v_hardif_init(struct batadv_hard_iface *hardif)
 {
 }
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index c2d5b39b02f47..77597171d6376 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -102,35 +102,58 @@ static int __init batadv_init(void)
 
 	batadv_recv_handler_init();
 
-	batadv_v_init();
-	batadv_iv_init();
+	ret = batadv_v_init();
+	if (ret < 0)
+		goto err_tt;
+
+	ret = batadv_iv_init();
+	if (ret < 0)
+		goto err_v;
+
 	batadv_tp_meter_init();
 
+	ret = batadv_wifi_net_devices_init();
+	if (ret < 0)
+		goto err_iv;
+
 	batadv_event_workqueue = create_singlethread_workqueue("bat_events");
 	if (!batadv_event_workqueue) {
 		ret = -ENOMEM;
-		goto err_create_wq;
+		goto err_wifi;
 	}
 
-	ret = batadv_wifi_net_devices_init();
+	ret = register_netdevice_notifier(&batadv_hard_if_notifier);
 	if (ret < 0)
-		goto err_init_wifi;
+		goto err_wq;
 
-	register_netdevice_notifier(&batadv_hard_if_notifier);
-	rtnl_link_register(&batadv_link_ops);
-	batadv_netlink_register();
+	ret = rtnl_link_register(&batadv_link_ops);
+	if (ret < 0)
+		goto err_notifier;
+
+	ret = batadv_netlink_register();
+	if (ret < 0)
+		goto err_rtnl;
 
 	pr_info("B.A.T.M.A.N. advanced %s (compatibility version %i) loaded\n",
 		init_utsname()->release, BATADV_COMPAT_VERSION);
 
 	return 0;
 
-err_init_wifi:
+err_rtnl:
+	rtnl_link_unregister(&batadv_link_ops);
+err_notifier:
+	unregister_netdevice_notifier(&batadv_hard_if_notifier);
+err_wq:
 	destroy_workqueue(batadv_event_workqueue);
 	batadv_event_workqueue = NULL;
 	rcu_barrier();
-
-err_create_wq:
+err_wifi:
+	batadv_wifi_net_devices_deinit();
+err_iv:
+	batadv_iv_deinit();
+err_v:
+	batadv_v_deinit();
+err_tt:
 	batadv_tt_cache_destroy();
 
 	return ret;
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 926210a67d640..107647c9badad 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -1556,14 +1556,18 @@ struct genl_family batadv_netlink_family __ro_after_init = {
 
 /**
  * batadv_netlink_register() - register batadv genl netlink family
+ *
+ * Return: 0 on success or negative error number in case of failure
  */
-void __init batadv_netlink_register(void)
+int __init batadv_netlink_register(void)
 {
 	int ret;
 
 	ret = genl_register_family(&batadv_netlink_family);
 	if (ret)
 		pr_warn("unable to register netlink family\n");
+
+	return ret;
 }
 
 /**
diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
index 4eae9e5ff1354..f92d3ea7d06cb 100644
--- a/net/batman-adv/netlink.h
+++ b/net/batman-adv/netlink.h
@@ -12,7 +12,7 @@
 #include <linux/netlink.h>
 #include <linux/types.h>
 
-void batadv_netlink_register(void);
+int batadv_netlink_register(void);
 void batadv_netlink_unregister(void);
 struct net_device *batadv_netlink_get_meshif(struct netlink_callback *cb);
 struct batadv_hard_iface *
-- 
2.47.3

