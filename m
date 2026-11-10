Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320173;
	b=z55qP7v7b508iN7Emrz03Be3EIIf7w8BbkzPyymlZoi/1HieGlWTvKlgzVGZr9fXEWby
	 cdN2hCdK2+/aRbPy5sC4dLWSoADUf9mY0/eSetQBZD+mlhwvAfgEbvH/bWg9uW2YnOV8B
	 quxLtRhCAS83Y+26ZWf2QJZ2/43FZ/IJf4hqM0rEe8emm3FpeWV95Nu4eW4T3AhiQEpSR
	 4pBEpOvGF4NMu4z/m9ZFgJbjtF0R75rdKzBFCU2vTBAo6cQzZ+SQGQBDcgnUZVve0hKf6
	 pv+IJfpoI1s5cZKiZOc96by2C22ABYgphJZZDeKed+XIzrA8en/E6Kppc5zR1IMPEsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320173;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VDBa7ICnLUp1aVDfFTsTk+E27gQOyZDcw2Zyxi9zyY8=;
	b=YTUr2nwCK3FGpf9WyZCwsDlQXtABkL94y1dii7NmPrHuUUtbiyQZnJUSk2lGdIiCMJ+b
	 gavwUg//Hy3pKtlI6KjWY6ft2PjKhFiLe4SqoztHQ0n2IRQeC2OV1aYdxtd4d1H4F6Nid
	 +fHw0RUrXkDn74W0UU4/4oCRkO10KDaci4ErrXVs0NfG1NFa6aDukme0CSIvrmjID2395
	 msFS2IJ0vdKHzWXojS8/W3etWyLOTsE+y+hPTLq8zX7IMvjqhPxIMplvBUoHnzrU/qseY
	 wgdm7cPonXammYDPRLqNjLehxGdhE61YO8Tbaa6qIqyV4iwLTBmxRV+Tw4udTJWaIZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i7CvaUoV;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B376A60A2620
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B376A60A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i7CvaUoV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794320171; x=1825856171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MOEj/9xHCsNFhEMcPgHMYoczoERHiVdf5fsGL3sxt+A=;
  b=i7CvaUoViAo08/9EYLcuARHT9OaKRYW/EhOu2m34e81WULEL32VtFAUZ
   tb5xC5SmmZA9yk5En2E/KAl7nt5r08XEBBbMdgxvzZcondHPCUp0X6ciW
   W5lU1joH7ED1eJ3cetCJnq5Foq6bKFUKzzhhztFZbOeXlnPMJ5Ke/0yko
   FyjICnjbQ/MiNFeX5OSuJh+UUsa8Wsyz0mzyeP8K3srTLnRsxVmXE/Q8I
   stCpewOpyOBS463MqfdNpNc3875n97dl0igMJZsPxBYlprjQCwH75sg3N
   swLO0ZQhZhaJJxeGZzD9Mx7vhVpbkSz723K8V+XStz0cErQ9d7bOtrQH0
   w==;
X-CSE-ConnectionGUID: owpvxARmSgq8Xn0/sAVwbA==
X-CSE-MsgGUID: d+JcR/L7Qzi9WhweXBhkGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3091208"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3091208"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 06:16:11 -0800
X-CSE-ConnectionGUID: VnkQXWg7T7Kzx8uVYhCrZg==
X-CSE-MsgGUID: PIq6IcTEQWuYDpqShDyyLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8327670"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa003.fm.intel.com with ESMTP; 10 Nov 2026 06:16:06 -0800
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.244.251])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 2FFAE2FC57;
	Tue, 10 Nov 2026 14:16:04 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	edumazet@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	andrew+netdev@lunn.ch,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	leon@kernel.org,
	mbloch@nvidia.com,
	jacob.e.keller@intel.com,
	jedrzej.jagielski@intel.com,
	anzaki@gmail.com,
	brett.creeley@amd.com,
	ohartoov@nvidia.com,
	Petr Oros <poros@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v5 12/15] devlink: give user option to allocate resources
Date: Tue, 10 Nov 2026 15:07:21 +0100
Message-ID: <20261110141534.95614-13-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20261110141534.95614-1-przemyslaw.kitszel@intel.com>
References: <20261110141534.95614-1-przemyslaw.kitszel@intel.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current devlink resources are designed as a thing that user could limit,
but there is not much otherwise that could be done with them.
Perhaps that's the reason there is not much adoption despite API being
there for multiple years.

Add new mode of operation, where user could allocate/assign resources
(from a common pool) to specific devices.

That requires a new .occ_set() driver callback, called on
DEVLINK_CMD_RESOURCE_SET with the requested DEVLINK_ATTR_RESOURCE_SIZE,
instead of staging the size until the next reload. Driver registers it
together with .occ_get() by devl_resource_occ_set_get_register(). For
such resources the getter value is reported as DEVLINK_ATTR_RESOURCE_SIZE,
as opposed to DEVLINK_ATTR_RESOURCE_OCC (current occupation) in the
"legacy" mode, and there is no DEVLINK_ATTR_RESOURCE_SIZE_NEW.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
RFC, Feb '25
https://lore.kernel.org/intel-wired-lan/20250219164410.35665-3-przemyslaw.kitszel@intel.com

I have structured code to just choose "the mode" of operation based on
the presence of .occ_set callback, instead of naming the mode, what,
even if not the most clear code, avoids the need of naming the modes.

v4:
 * return -EMSGSIZE directly on devlink_resource_occ_size_put_legacy()
   failure (Jakub)

v3:
 * keep size and size_new of .occ_set() resources in sync with the
   getter, after a successful set and in devl_resource_size_get() (me)
 * WARN on registering .occ_set() without .occ_get(), or vice versa

v2:
 * avoid setting DEVLINK_ATTR_RESOURCE_SIZE_VALID for leaf resources
   (Sashiko)
 * minor kdoc update (Sashiko)
 * add more WARN_ONs (Sashiko)
 * document the occ_set mode in devlink-resource.rst
 * commit message: describe the .occ_set() callback and how the reported
   attributes differ from the "legacy" mode
---
 .../networking/devlink/devlink-resource.rst   |  5 +
 include/net/devlink.h                         |  7 ++
 net/devlink/resource.c                        | 97 ++++++++++++++++---
 3 files changed, 93 insertions(+), 16 deletions(-)

diff --git a/Documentation/networking/devlink/devlink-resource.rst b/Documentation/networking/devlink/devlink-resource.rst
index b7172d94b2c6..9c48155fcb1e 100644
--- a/Documentation/networking/devlink/devlink-resource.rst
+++ b/Documentation/networking/devlink/devlink-resource.rst
@@ -75,6 +75,11 @@ attribute, which represents the pending change in size. For example:
 Note that changes in resource size may require a device reload to properly
 take effect.
 
+Resources registered with ``devl_resource_occ_set_get_register()`` behave
+differently: the new size is passed to the driver and applies immediately,
+there is neither ``size_new`` nor ``occ`` reported, and ``size`` is the value
+returned by the driver's getter.
+
 Port-level Resources and Full Dump
 ==================================
 
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 98bdde4f72ca..d01128ef393d 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -420,6 +420,8 @@ devlink_resource_size_params_init(struct devlink_resource_size_params *size_para
 }
 
 typedef u64 devlink_resource_occ_get_t(void *priv);
+typedef int devlink_resource_occ_set_t(u64 size, struct netlink_ext_ack *extack,
+				       void *priv);
 
 #define DEVLINK_RESOURCE_ID_PARENT_TOP 0
 
@@ -1959,6 +1961,11 @@ void devl_resource_occ_get_register(struct devlink *devlink,
 				    void *occ_get_priv);
 void devl_resource_occ_get_unregister(struct devlink *devlink,
 				      u64 resource_id);
+void devl_resource_occ_set_get_register(struct devlink *devlink,
+					u64 resource_id,
+					devlink_resource_occ_set_t *occ_set,
+					devlink_resource_occ_get_t *occ_get,
+					void *occ_priv);
 int devl_params_register(struct devlink *devlink,
 			 const struct devlink_param *params,
 			 size_t params_count);
diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index c3cfda7ea070..c4502c480a6b 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -19,7 +19,8 @@
  * @list: parent list
  * @resource_list: list of child resources
  * @occ_get: occupancy getter callback
- * @occ_get_priv: occupancy getter callback priv
+ * @occ_set: occupancy setter callback
+ * @occ_priv: occupancy callbacks priv
  */
 struct devlink_resource {
 	const char *name;
@@ -32,7 +33,8 @@ struct devlink_resource {
 	struct list_head list;
 	struct list_head resource_list;
 	devlink_resource_occ_get_t *occ_get;
-	void *occ_get_priv;
+	devlink_resource_occ_set_t *occ_set;
+	void *occ_priv;
 };
 
 static struct devlink_resource *
@@ -137,6 +139,16 @@ int devlink_nl_resource_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		return err;
 
+	if (resource->occ_set) {
+		err = resource->occ_set(size, info->extack, resource->occ_priv);
+		if (err)
+			return err;
+
+		resource->size = resource->occ_get(resource->occ_priv);
+		resource->size_new = resource->size;
+		return 0;
+	}
+
 	resource->size_new = size;
 	devlink_resource_validate_children(resource);
 	if (resource->parent)
@@ -162,13 +174,31 @@ devlink_resource_size_params_put(struct devlink_resource *resource,
 	return 0;
 }
 
-static int devlink_resource_occ_put(struct devlink_resource *resource,
-				    struct sk_buff *skb)
+static int
+devlink_resource_occ_size_put_legacy(struct devlink_resource *resource,
+				     struct sk_buff *skb)
 {
-	if (!resource->occ_get)
-		return 0;
-	return devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_OCC,
-				  resource->occ_get(resource->occ_get_priv));
+	if (devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_SIZE, resource->size))
+		return -EMSGSIZE;
+	if (resource->size != resource->size_new &&
+	    devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_SIZE_NEW,
+			       resource->size_new))
+		return -EMSGSIZE;
+	if (resource->occ_get &&
+	    devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_OCC,
+			       resource->occ_get(resource->occ_priv)))
+		return -EMSGSIZE;
+	return 0;
+}
+
+static int devlink_resource_occ_size_put(struct devlink_resource *resource,
+					 struct sk_buff *skb)
+{
+	if (!resource->occ_get || !resource->occ_set)
+		return devlink_resource_occ_size_put_legacy(resource, skb);
+
+	return devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_SIZE,
+				  resource->occ_get(resource->occ_priv));
 }
 
 static int devlink_resource_put(struct devlink *devlink, struct sk_buff *skb,
@@ -183,14 +213,9 @@ static int devlink_resource_put(struct devlink *devlink, struct sk_buff *skb,
 		return -EMSGSIZE;
 
 	if (nla_put_string(skb, DEVLINK_ATTR_RESOURCE_NAME, resource->name) ||
-	    devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_SIZE, resource->size) ||
 	    devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_ID, resource->id))
 		goto nla_put_failure;
-	if (resource->size != resource->size_new &&
-	    devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_SIZE_NEW,
-			       resource->size_new))
-		goto nla_put_failure;
-	if (devlink_resource_occ_put(resource, skb))
+	if (devlink_resource_occ_size_put(resource, skb))
 		goto nla_put_failure;
 	if (devlink_resource_size_params_put(resource, skb))
 		goto nla_put_failure;
@@ -634,12 +659,50 @@ int devl_resource_size_get(struct devlink *devlink,
 	resource = devlink_resource_find(devlink, NULL, resource_id);
 	if (!resource)
 		return -EINVAL;
+	if (resource->occ_set)
+		resource->size_new = resource->occ_get(resource->occ_priv);
 	*p_resource_size = resource->size_new;
 	resource->size = resource->size_new;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(devl_resource_size_get);
 
+/**
+ * devl_resource_occ_set_get_register - register occupancy getter and setter
+ *
+ * @devlink: devlink
+ * @resource_id: resource id
+ * @occ_set: occupancy setter callback
+ * @occ_get: occupancy getter callback
+ * @occ_priv: occupancy callbacks priv
+ *
+ * Setter will be called when the user wants to change the resource size,
+ * getter is called to show the user what is current size of the resource.
+ */
+void devl_resource_occ_set_get_register(struct devlink *devlink,
+					u64 resource_id,
+					devlink_resource_occ_set_t *occ_set,
+					devlink_resource_occ_get_t *occ_get,
+					void *occ_priv)
+{
+	struct devlink_resource *resource;
+
+	lockdep_assert_held(&devlink->lock);
+
+	if (WARN_ON(!occ_set || !occ_get))
+		return;
+
+	resource = devlink_resource_find(devlink, NULL, resource_id);
+	if (WARN_ON(!resource))
+		return;
+	WARN_ON(resource->occ_get || resource->occ_set);
+
+	resource->occ_set = occ_set;
+	resource->occ_get = occ_get;
+	resource->occ_priv = occ_priv;
+}
+EXPORT_SYMBOL_GPL(devl_resource_occ_set_get_register);
+
 /**
  * devl_resource_occ_get_register - register occupancy getter
  *
@@ -661,9 +724,10 @@ void devl_resource_occ_get_register(struct devlink *devlink,
 	if (WARN_ON(!resource))
 		return;
 	WARN_ON(resource->occ_get);
+	WARN_ON(resource->occ_set);
 
 	resource->occ_get = occ_get;
-	resource->occ_get_priv = occ_get_priv;
+	resource->occ_priv = occ_get_priv;
 }
 EXPORT_SYMBOL_GPL(devl_resource_occ_get_register);
 
@@ -684,9 +748,10 @@ void devl_resource_occ_get_unregister(struct devlink *devlink,
 	if (WARN_ON(!resource))
 		return;
 	WARN_ON(!resource->occ_get);
+	WARN_ON(resource->occ_set);
 
 	resource->occ_get = NULL;
-	resource->occ_get_priv = NULL;
+	resource->occ_priv = NULL;
 }
 EXPORT_SYMBOL_GPL(devl_resource_occ_get_unregister);
 
-- 
2.51.1

