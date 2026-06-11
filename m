Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17ED28A72F
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 05:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781155339; cv=none; b=QGVUYgzKtpq1iLwuHszR34Xmv+IMUqjkkcomgJOut6di6xr7KEqyexZ0EXFn231yqBPeSLsboPVc1agC/dyk5sVHRJdy8uXTfmIj38xrcE5MvUGeWi8OLXJycBD4p8fbKw0BWgt9kZCoPJ/BBdHBtaxGrRJxXbtTURaVXRmHD/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781155339; c=relaxed/simple;
	bh=yk0JlGxnrDxuXY3w9TJpwBO5Z585Qhb53ArJfyqHE7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqpuurmtmDDK2/6F8rHl39hFJZ7mMPuwudCPLLWHzGLrTp67UvMKlu2H0Rt7SgLwP3UVd5gd7FY/rbYPzbziNhHrIsh5feOqeCci9/sovY3tmqonE7C7uMlEW36vbzK1Oo5dYUs1l+RPYEY1KRYgOBqUj/S90fb2a6gl1sG3tbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dELnd1kn; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dELnd1kn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781155333; x=1812691333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yk0JlGxnrDxuXY3w9TJpwBO5Z585Qhb53ArJfyqHE7o=;
  b=dELnd1knpdRttRavQKrtjs1Y/uZ5Inm7NXXYj9SyTqUshJSS45okPkNG
   C0XEsV9Kstva33fSgNdSaqHfAbDfELr/IwrdGYHtaOailtG0ong/16n4C
   dh9DYQDzaqxUppjxdvcCuOXTgAMabD7x9xPG1dapdtIqxwN18X7Du6s6+
   +PaxaqvPh339A+mFuyvNVBSCzILBbQcvpCUeqMc1nXSkWWZtBB/vEKgEW
   6FO054Ev3d2aZomsW2Inay5IxE2pSZNrZQ/Vrbfv8SXk/R6JAj0+fFHhQ
   barmWn4/bIJpdNWa1Pn/CfabGd+O2/i+xXgEGHcasOBXLgmLeYBZJbDYq
   A==;
X-CSE-ConnectionGUID: ft29E5tsSteLSKMfml323A==
X-CSE-MsgGUID: vyThFk14QYSkVUtUHrB6Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82069844"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="82069844"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 22:22:13 -0700
X-CSE-ConnectionGUID: a6MufSHNT02uvhNG/1xDKA==
X-CSE-MsgGUID: vsmq5MzESmCQeRXUSy1LfA==
X-ExtLoop1: 1
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 22:22:07 -0700
From: Riana Tauro <riana.tauro@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org
Cc: aravind.iddamsetty@linux.intel.com,
	anshuman.gupta@intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	kuba@kernel.org,
	simona.vetter@ffwll.ch,
	airlied@gmail.com,
	pratik.bari@intel.com,
	joshua.santosh.ranjan@intel.com,
	ashwin.kumar.kulkarni@intel.com,
	shubham.kumar@intel.com,
	ravi.kishore.koppuravuri@intel.com,
	raag.jadav@intel.com,
	maarten.lankhorst@linux.intel.com,
	mallesh.koujalagi@intel.com,
	soham.purkait@intel.com,
	Riana Tauro <riana.tauro@intel.com>,
	Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH v2 1/2] drm/drm_ras: Add drm_ras netlink error event
Date: Thu, 11 Jun 2026 10:51:46 +0530
Message-ID: <20260611052144.784969-5-riana.tauro@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260611052144.784969-4-riana.tauro@intel.com>
References: <20260611052144.784969-4-riana.tauro@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define a new netlink event 'error-event' and a new multicast group
'error-notify' in drm_ras. Each event contains device name, node and
error information to identify the error triggering the event.

Add drm_ras_nl_error_event() to trigger an event from the driver.
Userspace must subscribe to 'error-notify' to receive 'error-event'
notifications.

Usage:

$ sudo ynl --family drm_ras --subscribe error-notify

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Riana Tauro <riana.tauro@intel.com>
---
v2: remove redundant initialization
    remove unnecessary space
    use ynl in commit message and doc (Raag)
    simplify doc for error-event attrs
---
 Documentation/gpu/drm-ras.rst            | 21 ++++++
 Documentation/netlink/specs/drm_ras.yaml | 48 +++++++++++++
 drivers/gpu/drm/drm_ras.c                | 88 ++++++++++++++++++++++++
 drivers/gpu/drm/drm_ras_nl.c             |  6 ++
 drivers/gpu/drm/drm_ras_nl.h             |  4 ++
 include/drm/drm_ras.h                    |  5 ++
 include/uapi/drm/drm_ras.h               | 15 ++++
 7 files changed, 187 insertions(+)

diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
index 83c21853b74b..60f986da5876 100644
--- a/Documentation/gpu/drm-ras.rst
+++ b/Documentation/gpu/drm-ras.rst
@@ -56,6 +56,7 @@ User space tools can:
   ``node-id`` and ``error-id`` as parameters.
 * Clear specific error counters with the ``clear-error-counter`` command, using both
   ``node-id`` and ``error-id`` as parameters.
+* Subscribe to the ``error-notify`` multicast group to receive ``error-event`` notifications.
 
 YAML-based Interface
 --------------------
@@ -111,3 +112,23 @@ Example: Clear an error counter for a given node
 
     sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
     None
+
+Example: Subscribe to ``error-notify`` multicast group
+
+.. code-block:: bash
+
+    sudo ynl --family drm_ras --output-json --subscribe error-notify
+
+.. code-block:: json
+
+    {
+        "name": "error-event",
+        "msg": {
+            "device-name": "0000:03:00.0",
+            "node-id": 1,
+            "node-name": "uncorrectable-errors",
+            "error-id": 1,
+            "error-name": "error_name1",
+            "error-value": 1
+        }
+    }
diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
index e113056f8c01..13e25d996dbd 100644
--- a/Documentation/netlink/specs/drm_ras.yaml
+++ b/Documentation/netlink/specs/drm_ras.yaml
@@ -69,6 +69,33 @@ attribute-sets:
         name: error-value
         type: u32
         doc: Current value of the requested error counter.
+  -
+    name: error-event-attrs
+    attributes:
+      -
+        name: device-name
+        type: string
+        doc: Device (PCI BDF, UUID) that reported the error.
+      -
+        name: node-id
+        type: u32
+        doc: ID of the node that reported the error.
+      -
+        name: node-name
+        type: string
+        doc: Name of the node that reported the error.
+      -
+        name: error-id
+        type: u32
+        doc: ID of the error counter.
+      -
+        name: error-name
+        type: string
+        doc: Name of the error.
+      -
+        name: error-value
+        type: u32
+        doc: Current value of the error counter.
 
 operations:
   list:
@@ -124,3 +151,24 @@ operations:
       do:
         request:
           attributes: *id-attrs
+    -
+      name: error-event
+      doc: >-
+           Notify userspace of an error event.
+           The event includes the device, node and error information
+           of the error that triggered the event.
+      attribute-set: error-event-attrs
+      mcgrp: error-notify
+      event:
+        attributes:
+          - device-name
+          - node-id
+          - node-name
+          - error-id
+          - error-name
+          - error-value
+
+mcast-groups:
+  list:
+    -
+      name: error-notify
diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index d6eab29a1394..503d555e067c 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -41,6 +41,11 @@
  *    Userspace must provide Node ID, Error ID.
  *    Clears specific error counter of a node if supported.
  *
+ * 4. ERROR_NOTIFY: Subscribe to this multicast group to receive error events
+ *
+ * 5. ERROR_EVENT: Notify userspace of an error event. The event contains device, node
+ *    and error information that triggered the event.
+ *
  * Node registration:
  *
  * - drm_ras_node_register(): Registers a new node and assigns
@@ -186,6 +191,34 @@ static int msg_reply_value(struct sk_buff *msg, u32 error_id,
 			   value);
 }
 
+static int msg_put_error_event_attrs(struct sk_buff *msg, struct drm_ras_node *node,
+				     u32 error_id, const char *error_name, u32 value)
+{
+	int ret;
+
+	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_DEVICE_NAME, node->device_name);
+	if (ret)
+		return ret;
+
+	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_ID, node->id);
+	if (ret)
+		return ret;
+
+	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_NAME, node->node_name);
+	if (ret)
+		return ret;
+
+	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_ID, error_id);
+	if (ret)
+		return ret;
+
+	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_NAME, error_name);
+	if (ret)
+		return ret;
+
+	return nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_VALUE, value);
+}
+
 static int doit_reply_value(struct genl_info *info, u32 node_id,
 			    u32 error_id)
 {
@@ -222,6 +255,61 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
 	return genlmsg_reply(msg, info);
 }
 
+/**
+ * drm_ras_nl_error_event() - Notify listeners of an error event
+ * @node: Node structure
+ * @error_id: ID of the error
+ * @error_name: Name of the error
+ * @value: Value associated with the error
+ * @flags: GFP flags for memory allocation
+ *
+ * Sends a notification to all listeners about an error event on a specific
+ * RAS node.
+ *
+ * Return: 0 on success, or negative errno on failure.
+ */
+int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id, const char *error_name,
+			   u32 value, gfp_t flags)
+{
+	struct genl_info info;
+	struct sk_buff *msg;
+	struct nlattr *hdr;
+	int ret;
+
+	if (!error_name)
+		return -EINVAL;
+
+	if (!genl_has_listeners(&drm_ras_nl_family, &init_net, DRM_RAS_NLGRP_ERROR_NOTIFY))
+		return 0;
+
+	genl_info_init_ntf(&info, &drm_ras_nl_family, DRM_RAS_CMD_ERROR_EVENT);
+
+	msg = genlmsg_new(NLMSG_GOODSIZE, flags);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_iput(msg, &info);
+	if (!hdr) {
+		ret = -EMSGSIZE;
+		goto free_msg;
+	}
+
+	ret = msg_put_error_event_attrs(msg, node, error_id, error_name, value);
+	if (ret)
+		goto cancel_msg;
+
+	genlmsg_end(msg, hdr);
+	genlmsg_multicast(&drm_ras_nl_family, msg, 0, DRM_RAS_NLGRP_ERROR_NOTIFY, flags);
+	return 0;
+
+cancel_msg:
+	genlmsg_cancel(msg, hdr);
+free_msg:
+	nlmsg_free(msg);
+	return ret;
+}
+EXPORT_SYMBOL(drm_ras_nl_error_event);
+
 /**
  * drm_ras_nl_get_error_counter_dumpit() - Dump all Error Counters
  * @skb: Netlink message buffer
diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
index dea1c1b2494e..ac724bb87a3b 100644
--- a/drivers/gpu/drm/drm_ras_nl.c
+++ b/drivers/gpu/drm/drm_ras_nl.c
@@ -58,6 +58,10 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
 	},
 };
 
+static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
+	[DRM_RAS_NLGRP_ERROR_NOTIFY] = { "error-notify", },
+};
+
 struct genl_family drm_ras_nl_family __ro_after_init = {
 	.name		= DRM_RAS_FAMILY_NAME,
 	.version	= DRM_RAS_FAMILY_VERSION,
@@ -66,4 +70,6 @@ struct genl_family drm_ras_nl_family __ro_after_init = {
 	.module		= THIS_MODULE,
 	.split_ops	= drm_ras_nl_ops,
 	.n_split_ops	= ARRAY_SIZE(drm_ras_nl_ops),
+	.mcgrps		= drm_ras_nl_mcgrps,
+	.n_mcgrps	= ARRAY_SIZE(drm_ras_nl_mcgrps),
 };
diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
index a398643572a5..17e1af8cc3b3 100644
--- a/drivers/gpu/drm/drm_ras_nl.h
+++ b/drivers/gpu/drm/drm_ras_nl.h
@@ -21,6 +21,10 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
 int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
 					struct genl_info *info);
 
+enum {
+	DRM_RAS_NLGRP_ERROR_NOTIFY,
+};
+
 extern struct genl_family drm_ras_nl_family;
 
 #endif /* _LINUX_DRM_RAS_GEN_H */
diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
index f2a787bc4f64..d4a275efdbb0 100644
--- a/include/drm/drm_ras.h
+++ b/include/drm/drm_ras.h
@@ -78,9 +78,14 @@ struct drm_device;
 #if IS_ENABLED(CONFIG_DRM_RAS)
 int drm_ras_node_register(struct drm_ras_node *node);
 void drm_ras_node_unregister(struct drm_ras_node *node);
+int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id, const char *error_name,
+			   u32 value, gfp_t flags);
 #else
 static inline int drm_ras_node_register(struct drm_ras_node *node) { return 0; }
 static inline void drm_ras_node_unregister(struct drm_ras_node *node) { }
+static inline int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id,
+					 const char *error_name, u32 value, gfp_t flags)
+{ return 0; }
 #endif
 
 #endif
diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
index 218a3ee86805..bb2a8a872a44 100644
--- a/include/uapi/drm/drm_ras.h
+++ b/include/uapi/drm/drm_ras.h
@@ -38,13 +38,28 @@ enum {
 	DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX = (__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX - 1)
 };
 
+enum {
+	DRM_RAS_A_ERROR_EVENT_ATTRS_DEVICE_NAME = 1,
+	DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_ID,
+	DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_NAME,
+	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_ID,
+	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_NAME,
+	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_VALUE,
+
+	__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX,
+	DRM_RAS_A_ERROR_EVENT_ATTRS_MAX = (__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX - 1)
+};
+
 enum {
 	DRM_RAS_CMD_LIST_NODES = 1,
 	DRM_RAS_CMD_GET_ERROR_COUNTER,
 	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
+	DRM_RAS_CMD_ERROR_EVENT,
 
 	__DRM_RAS_CMD_MAX,
 	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
 };
 
+#define DRM_RAS_MCGRP_ERROR_NOTIFY	"error-notify"
+
 #endif /* _UAPI_LINUX_DRM_RAS_H */
-- 
2.47.1

