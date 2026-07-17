Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993F83D301F
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 06:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271321; cv=none; b=oL2FdCBCVCJ5gGx+o1sX1Gd7mLq1l63vYhfmlj3fY13ZXclaRQqzBmwgli2uATA816sEHzzCR5IRhWtZymfyIxbTvJ+P7MKBVh19zSaPea9sLNIe2HEKa7rUkcXSTYHzZaN21Ww2jiXXPZRAZR92A+pQaMoQgrSibNwmCwVF6wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271321; c=relaxed/simple;
	bh=4eqoP+s2+JqAZQlqTLx51+/8/l4sNzYIUOFeJtwf2OQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jxmz4heJjC6w3QG03LqIj+nlVtz1ClwqU2lFVMDQq+F7HfYWBglqPha9yvNsUpZJexr4L5ZaJ92W3CGcKYuCkJOgM8dkFxcv5wmlaPv4zzQzXw4S9OQEHzekSQyEk3YoDvBihTuv9jKw8GWWxEn0uOFY2ekbX79j7DaWrjA9efY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oeO207zn; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeO207zn"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-495437bb891so8432615e9.1
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 23:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784271318; x=1784876118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jXV1EkKmwAx+0z/m+fIyfmIJJ6i6rQN4CZmFJpnKgDc=;
        b=oeO207zndOgFv2rShkaXnImr9mHjmwiRQ6PNr66769D2NVJDYNqoJtW0p8eRZBRtRh
         +HdJ8LWbP4Au6tMe6qk8Q8chRx1wOE1SsB6TLxkjoboKu68newsllc9IquxJEyXSbvYu
         k1meNh87852wHPQ5zdoUj62qcQsIyptmy/FIEJ5SG6nCcDDLH3EZIFLhjeZWaEAvrYvm
         tKkqdhlIiZUfGwHypuiDtmZsycFKZZIObM13Y2ldikx4RbAFCbIPGCij4zcblSGKLsGf
         DrUw5ZeKSBtt3qECszLP5nYv3QA8Oj0otwlnfWP5mt4RmQ5Ax9H8MlCJgV9icSDg+rev
         NXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784271318; x=1784876118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jXV1EkKmwAx+0z/m+fIyfmIJJ6i6rQN4CZmFJpnKgDc=;
        b=RbjbIePlqV/m+qJGGeeHf5+ZbiBkKFendqF719JkfVMVH7CZqH/25ryO+A0eqllP6x
         raoaunBxB0DgH0GUGGmYIVVX7yMcm9BrUwRkmSgEJOUAf2ci7YA2Jo9l5l/t7Hw7ac7I
         aOJ9JvDxo8x5vqtidCc3JVty4BEM5bjyWg0UPSzMGbfuHUf7Ub2WShU34oQ5GrFML6AE
         KeXvBiQPvGMQlZ6Uin2hwUFCK8ChTKwpKF1ZISXV6s4NmvVYBnVgixnMiiaDQKSy7R6E
         386ByVea88fqRmd1d4IqqR6dsrd03HYesJoCMZ67LYpSwaIgqodCgxlhud8jraAWNvOu
         RIew==
X-Forwarded-Encrypted: i=1; AHgh+RooJjmb1Y9aeuDX1udCrjd9QpguEU75GVPrRgR05LjlIcSs7TjXNbVrPAKf5zEv4V2d3fvW9/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlRPaPJ5qn4mtZ+B0G+WRxk/k4RUOCJtJaSwigznR45OZmBF4P
	oiGzCzY3uuy7fM+Odl5vIuHvotdQJJ/gXRuIlRPRdZkFeQG5nZCxPKmo
X-Gm-Gg: AfdE7clza9GhTqxsq71//6LF+5T9knBZxecalsNqMPQ+Kz6M4pjMfpze+z1YB2rO2sF
	Vg1XbldyRVm82zjS2ytmjgRnKc/j0EUiaXCZ5iO5reOYNDIEyG6F4/LPqrsegFDMigwPsvKi4mq
	CZ+/P83U5oORAc+PQ4GtNbyOlxG7wWuzMeGM6ZGq1D3ZkPJC4OnuMxWjPEH8aHHc9Exppmd5vzk
	zgXiQVv8Ff0p16lCOoESotjLiSIGf63ewasDsKcd7IsddWv3cGbRPlTQXrQ/FfgHvtNvSvYJo25
	atkmXQUR+hlNHBoGpDs3phxUgPPCUGO29wnhpAFIBwGRs6UfdXE8IsO3w+2d59IhYjPXEynS4IM
	ybIyYTEr8hZhWrXJvtY+yJmAUks2XlyXACK7a0cfC4tSC6TppzG+a4jBxiihHFm9FlB8BrxIJ6T
	LTqtDkvXHzw6g4PIBfmmd490rhIqMYGu7DTU1tbmvL6s7J9U9EZLSaJF6Zy3rIZMX5dLaJDQ==
X-Received: by 2002:a05:600c:e54a:20b0:495:4b40:88af with SMTP id 5b1f17b1804b1-4954b408964mr3008605e9.8.1784271317741;
        Thu, 16 Jul 2026 23:55:17 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-95-248-227-210.retail.telecomitalia.it. [95.248.227.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-495499f3f99sm24260835e9.0.2026.07.16.23.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 23:55:17 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
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
	Saravana Kannan <saravanak@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v9 05/12] net: phylink: support late PCS provider attach
Date: Fri, 17 Jul 2026 08:54:05 +0200
Message-ID: <20260717065448.1498335-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717065448.1498335-1-ansuelsmth@gmail.com>
References: <20260717065448.1498335-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for late PCS provider attachment to a phylink instance.
This works by creating a global notifier for the PCS provider and
making each phylink instance that makes use of fwnode subscribe to
this notifier.

The PCS notifier will emit the event FWNODE_PCS_PROVIDER_ADD every time
a new PCS provider is added.

phylink will then react to this event and will call the new function
fwnode_phylink_pcs_get_from_fwnode() that will check if the PCS fwnode
provided by the event is present in the pcs-handle property of the
phylink instance.

If a related PCS is found, then such PCS is added to the phylink
instance PCS list.

Then we link the PCS to the phylink instance and we refresh the supported
interfaces of the phylink instance.

Finally we check if we are in a major_config_failed scenario and trigger
an interface reconfiguration in the next phylink resolve.

In the example scenario where the link was previously torn down due to
removal of PCS, the link will be established again as the PCS came back
and is now available to phylink.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/pcs/pcs.c     | 49 +++++++++++++++++++++++++++++
 drivers/net/phy/phylink.c | 60 +++++++++++++++++++++++++++++++++++-
 include/linux/pcs/pcs.h   | 65 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 173 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs.c b/drivers/net/pcs/pcs.c
index 0cc4daf7beea..7a9d91b2a34d 100644
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
 
 struct phylink_pcs *fwnode_pcs_simple_get(struct fwnode_reference_args *pcsspec,
 					  void *data)
@@ -55,6 +68,10 @@ int fwnode_pcs_add_provider(struct fwnode_handle *fwnode,
 
 	fwnode_dev_initialized(fwnode, true);
 
+	blocking_notifier_call_chain(&fwnode_pcs_notify_list,
+				     FWNODE_PCS_PROVIDER_ADD,
+				     fwnode);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fwnode_pcs_add_provider);
@@ -150,6 +167,38 @@ struct phylink_pcs *fwnode_pcs_get(struct fwnode_handle *fwnode, unsigned int in
 }
 EXPORT_SYMBOL_GPL(fwnode_pcs_get);
 
+struct phylink_pcs *
+fwnode_phylink_pcs_get_from_fwnode(struct fwnode_handle *fwnode,
+				   struct fwnode_handle *pcs_fwnode)
+{
+	struct fwnode_reference_args pcsspec;
+	int index = 0;
+	int ret;
+
+	/* Loop until we find a matching PCS node or
+	 * fwnode_parse_pcsspec() returns error
+	 * if we don't have any other PCS reference to check.
+	 */
+	while (true) {
+		ret = fwnode_parse_pcsspec(fwnode, index, NULL, &pcsspec);
+		if (ret)
+			return ERR_PTR(ret);
+
+		/* Exit loop if we found the matching PCS node */
+		if (pcsspec.fwnode == pcs_fwnode) {
+			fwnode_handle_put(pcsspec.fwnode);
+			break;
+		}
+
+		/* Check the next PCS reference */
+		fwnode_handle_put(pcsspec.fwnode);
+		index++;
+	}
+
+	return fwnode_pcs_get(fwnode, index);
+}
+EXPORT_SYMBOL_GPL(fwnode_phylink_pcs_get_from_fwnode);
+
 unsigned int fwnode_phylink_pcs_count(struct fwnode_handle *fwnode)
 {
 	struct fwnode_reference_args out_args;
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 986e0c1e3d67..1d83b31874fb 100644
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
@@ -62,6 +63,7 @@ struct phylink {
 
 	/* List of available PCS */
 	struct list_head pcs_list;
+	struct notifier_block fwnode_pcs_nb;
 
 	/* What interface are supported by the current link.
 	 * Can change on removal or addition of new PCS.
@@ -1999,6 +2001,53 @@ static int phylink_fill_available_pcs(struct phylink *pl,
 	return ret;
 }
 
+static int pcs_provider_notify(struct notifier_block *self,
+			       unsigned long val, void *data)
+{
+	struct phylink *pl = container_of(self, struct phylink, fwnode_pcs_nb);
+	struct fwnode_handle *pcs_fwnode = data;
+	struct phylink_pcs *pcs;
+
+	rtnl_lock();
+
+	/* Check if the just added PCS provider is
+	 * in the phylink instance pcs-handle property.
+	 */
+	pcs = fwnode_phylink_pcs_get_from_fwnode(dev_fwnode(pl->config->dev),
+						 pcs_fwnode);
+	if (IS_ERR(pcs)) {
+		rtnl_unlock();
+		return NOTIFY_DONE;
+	}
+
+	/* Add the PCS */
+	mutex_lock(&pl->state_mutex);
+
+	/* Link PCS with phylink */
+	list_add(&pcs->list, &pl->pcs_list);
+	pcs->phylink = pl;
+
+	/* Refresh supported interfaces */
+	phy_interface_copy(pl->supported_interfaces,
+			   pl->config->supported_interfaces);
+	list_for_each_entry(pcs, &pl->pcs_list, list)
+		phy_interface_or(pl->supported_interfaces,
+				 pl->supported_interfaces,
+				 pcs->supported_interfaces);
+
+	/* Force an interface reconfig if major config fail */
+	if (pl->major_config_failed)
+		pl->force_major_config = true;
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
@@ -2116,6 +2165,12 @@ struct phylink *phylink_create(struct phylink_config *config,
 	if (ret < 0)
 		goto unlink_pcs_list;
 
+	/* Register notifier for late PCS attach */
+	if (!phy_interface_empty(config->pcs_interfaces)) {
+		pl->fwnode_pcs_nb.notifier_call = pcs_provider_notify;
+		register_fwnode_pcs_notifier(&pl->fwnode_pcs_nb);
+	}
+
 	return pl;
 
 unlink_pcs_list:
@@ -2144,10 +2199,13 @@ void phylink_destroy(struct phylink *pl)
 	if (pl->link_gpio)
 		gpiod_put(pl->link_gpio);
 
+	/* Unregister notifier for late PCS attach */
+	if (pl->fwnode_pcs_nb.notifier_call)
+		unregister_fwnode_pcs_notifier(&pl->fwnode_pcs_nb);
+
 	cancel_work_sync(&pl->resolve);
 
 	/* Drop link between PCS and phylink */
-	/* Remove every PCS from phylink PCS list */
 	list_for_each_entry_safe(pcs, tmp, &pl->pcs_list, list) {
 		pcs->phylink = NULL;
 		list_del(&pcs->list);
diff --git a/include/linux/pcs/pcs.h b/include/linux/pcs/pcs.h
index b7cfdd680b2a..45e8f96662db 100644
--- a/include/linux/pcs/pcs.h
+++ b/include/linux/pcs/pcs.h
@@ -4,7 +4,36 @@
 
 #include <linux/phylink.h>
 
+enum fwnode_pcs_notify_event {
+	FWNODE_PCS_PROVIDER_ADD,
+};
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
@@ -20,6 +49,25 @@
 struct phylink_pcs *fwnode_pcs_get(struct fwnode_handle *fwnode,
 				   unsigned int index);
 
+/**
+ * fwnode_phylink_pcs_get_from_fwnode - Retrieves the PCS provided
+ *					by the firmware node from a
+ *					firmware node
+ * @fwnode: firmware node
+ * @pcs_fwnode: PCS firmware node
+ *
+ * Parse 'pcs-handle' in 'fwnode' and get the PCS that match
+ * 'pcs_fwnode' firmware node.
+ *
+ * Returns: a pointer to the phylink_pcs or a negative
+ * error pointer. Can return -EPROBE_DEFER if the PCS is not
+ * present in global providers list (either due to driver
+ * still needs to be probed or it failed to probe/removed)
+ */
+struct phylink_pcs *
+fwnode_phylink_pcs_get_from_fwnode(struct fwnode_handle *fwnode,
+				   struct fwnode_handle *pcs_fwnode);
+
 /**
  * fwnode_phylink_pcs_count - count PCS entries described in firmware node
  * @fwnode: firmware node
@@ -53,12 +101,29 @@ int fwnode_phylink_pcs_parse(struct fwnode_handle *fwnode,
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
 static inline struct phylink_pcs *fwnode_pcs_get(struct fwnode_handle *fwnode,
 						 unsigned int index)
 {
 	return ERR_PTR(-ENOENT);
 }
 
+static inline struct phylink_pcs *
+fwnode_phylink_pcs_get_from_fwnode(struct fwnode_handle *fwnode,
+				   struct fwnode_handle *pcs_fwnode)
+{
+	return ERR_PTR(-ENOENT);
+}
+
 static inline unsigned int fwnode_phylink_pcs_count(struct fwnode_handle *fwnode)
 {
 	return 0;
-- 
2.53.0

