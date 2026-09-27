Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA7D3F1AD7
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790516237; cv=none; b=tlIGC8mmLnFKvGGU6H0y0zq3KQS3JUy79+/jaYyWM0r2IgcFOU+jPffXBB8ratbG8fgnZbKfX4WUBbg5W8M8mJCLNSyk9ABnr/2+CFLxjADRmBq5y5j4j/Ktx+AfCFZf/OSSb/qgeX+hAqX19xNklpF0IoW7FN1RfFPRvBmjnxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790516237; c=relaxed/simple;
	bh=XjdMjdbNryzH/p56jpIZHC0URawcHZJP8NEiTTVMQKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwn28GTIEJ1qEo0pdQDKSUKSNhf++P3WMQkWH2Q5OTmRpGZYf7Md4pYBGeJxqo3Lh5S/qkTlxMkcimeLUiqU3AV5TkzeXIBVacXYy2wbA21vYB/pxE+nf+LWSAxJcmTCHRiJqByUVLn3YZ1z72/LsnFhYPY3kixAvGZtP1JjDdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=st9cofMu; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="st9cofMu"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0F2291A0FDB;
	Sun, 27 Sep 2026 13:37:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D62A9604FF;
	Sun, 27 Sep 2026 13:37:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AEE27102F1E7B;
	Sun, 27 Sep 2026 15:37:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790516230; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=+wqdEu2XjHr9MBUryD7ahkZW78s8r46Q6rq1LUNTqEM=;
	b=st9cofMuC7AL0kvyWsHxOJ5g/nEI3V5cAnJyN47UcxdKxAiyBrLgdyrUaz9rOaZ4D142r/
	RdkGvMGLEObMyV2Yww33QEh5T8UPCEYBO61k2fiu3ijioIxiXaoVGn2JboBB4AzIIBFaI+
	W6TSTDYN6yHJx97UJ/xOR4NomeeGZVGZg7QS2A83D5XVAK30/ERMgC51gtCV4tWWG40C9e
	ls/AJEoPXP7qdtm2hWtQNcsrEHPAULshL2JfsdLQ0ZyonnUt2FbQOLXrPV8R0xr+DVQYS6
	E3seGPEfahh6QCutwmheymBuhkgxAeXjLlql1wYxYb2rabG0cF8cx/xev1kZqw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Frank Wunderlich <frank.wunderlich@linux.dev>,
	Pietro Ameruoso <p.ameruoso@live.it>,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH net-next v18 08/10] netlink: specs: Add ethernet port listing with ethtool
Date: Sun, 27 Sep 2026 15:36:17 +0200
Message-ID: <20260927133619.955236-9-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260927133619.955236-1-maxime.chevallier@bootlin.com>
References: <20260927133619.955236-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Ethernet network interfaces may have more than one front-facing port.
The phy_port infrastructure was introduced to keep track of
these ports, and allow userspace to know about the presence and
capability of these ports. Add a ethnl netlink message to report this
information.

Tested-by: Aleksei Sviridkin <f@lex.la>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 Documentation/netlink/specs/ethtool.yaml      | 55 +++++++++++++++++++
 Documentation/networking/ethtool-netlink.rst  | 36 ++++++++++++
 .../uapi/linux/ethtool_netlink_generated.h    | 22 ++++++++
 3 files changed, 113 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 5dd4d1b5d94b..35e028c0be29 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -210,6 +210,11 @@ definitions:
       -
         name: discard
         value: 31
+  -
+    name: port-type
+    doc: type of physical connector
+    type: enum
+    entries: [mdi, sfp]
 
 attribute-sets:
   -
@@ -1905,6 +1910,32 @@ attribute-sets:
         name: link
         type: nest
         nested-attributes: mse-snapshot
+  -
+    name: port
+    attr-cnt-name: --ethtool-a-port-cnt
+    attributes:
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: id
+        type: u32
+      -
+        name: supported-modes
+        type: nest
+        nested-attributes: bitset
+      -
+        name: supported-interfaces
+        type: nest
+        nested-attributes: bitset
+      -
+        name: type
+        type: u32
+        enum: port-type
+      -
+        name: upstream-port
+        type: u32
 
 operations:
   enum-model: directional
@@ -2859,6 +2890,30 @@ operations:
             - worst-channel
             - link
       dump: *mse-get-op
+    -
+      name: port-get
+      doc: Get ports attached to an interface
+
+      attribute-set: port
+
+      do:
+        request:
+          attributes:
+            - header
+            - id
+        reply: &port-get-op-reply
+          attributes:
+            - header
+            - id
+            - supported-modes
+            - supported-interfaces
+            - type
+            - upstream-port
+      dump:
+        request:
+          attributes:
+            - header
+        reply: *port-get-op-reply
 
 mcast-groups:
   list:
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 393f2b6d3863..eba226c79ec3 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -247,6 +247,7 @@ Userspace to kernel:
   ``ETHTOOL_MSG_RSS_CREATE_ACT``        create an additional RSS context
   ``ETHTOOL_MSG_RSS_DELETE_ACT``        delete an additional RSS context
   ``ETHTOOL_MSG_MSE_GET``               get MSE diagnostic data
+  ``ETHTOOL_MSG_PORT_GET``              get port information
   ===================================== =================================
 
 Kernel to userspace:
@@ -305,6 +306,7 @@ Kernel to userspace:
   ``ETHTOOL_MSG_RSS_CREATE_NTF``           additional RSS context created
   ``ETHTOOL_MSG_RSS_DELETE_NTF``           additional RSS context deleted
   ``ETHTOOL_MSG_MSE_GET_REPLY``            MSE diagnostic data
+  ``ETHTOOL_MSG_PORT_GET_REPLY``           port information
   ======================================== =================================
 
 ``GET`` requests are sent by userspace applications to retrieve device
@@ -2537,6 +2539,39 @@ Within each channel nest, only the metrics supported by the PHY will be present.
 See ``struct phy_mse_snapshot`` kernel documentation in
 ``include/linux/phy.h``.
 
+PORT_GET
+========
+
+Retrieve information about the physical connection points of a network device,
+referred to as "ports". User needs to specify a PORT_ID for the DO operation,
+in which case the DO request returns information about that specific port.
+
+As there can be more than one port, the DUMP operation can be used to list the
+ports present on a given interface, by passing an interface index or name in
+the dump request.
+
+Request contents:
+
+  ===================================== ======  ===============================
+  ``ETHTOOL_A_PORT_HEADER``             nested  request header
+  ``ETHTOOL_A_PORT_ID``                 u32     port id
+  ===================================== ======  ===============================
+
+Kernel response contents:
+
+  ======================================= ======  =============================
+  ``ETHTOOL_A_PORT_HEADER``               nested  request header
+  ``ETHTOOL_A_PORT_ID``                   u32     the port's unique identifier,
+                                                  per netdevice.
+  ``ETHTOOL_A_PORT_SUPPORTED_MODES``      bitset  bitset of supported linkmodes
+  ``ETHTOOL_A_PORT_SUPPORTED_INTERFACES`` bitset  bitset of supported MII
+                                                  interfaces
+  ``ETHTOOL_A_PORT_TYPE``                 u32     the port type
+  ``ETHTOOL_A_PORT_UPSTREAM_PORT``        u32     If any, the index of the MII
+                                                  port that feeds into this
+                                                  port.
+  ======================================= ======  =============================
+
 Request translation
 ===================
 
@@ -2647,4 +2682,5 @@ are netlink only.
   n/a                                 ``ETHTOOL_MSG_PHY_GET``
   ``SIOCGHWTSTAMP``                   ``ETHTOOL_MSG_TSCONFIG_GET``
   ``SIOCSHWTSTAMP``                   ``ETHTOOL_MSG_TSCONFIG_SET``
+  n/a                                 ``ETHTOOL_MSG_PORT_GET``
   =================================== =====================================
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 8134baf7860f..660e0c08a766 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -78,6 +78,14 @@ enum ethtool_pse_event {
 	ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR = 64,
 };
 
+/*
+ * type of physical connector
+ */
+enum ethtool_port_type {
+	ETHTOOL_PORT_TYPE_MDI,
+	ETHTOOL_PORT_TYPE_SFP,
+};
+
 enum {
 	ETHTOOL_A_HEADER_UNSPEC,
 	ETHTOOL_A_HEADER_DEV_INDEX,
@@ -840,6 +848,18 @@ enum {
 	ETHTOOL_A_MSE_MAX = (__ETHTOOL_A_MSE_CNT - 1)
 };
 
+enum {
+	ETHTOOL_A_PORT_HEADER = 1,
+	ETHTOOL_A_PORT_ID,
+	ETHTOOL_A_PORT_SUPPORTED_MODES,
+	ETHTOOL_A_PORT_SUPPORTED_INTERFACES,
+	ETHTOOL_A_PORT_TYPE,
+	ETHTOOL_A_PORT_UPSTREAM_PORT,
+
+	__ETHTOOL_A_PORT_CNT,
+	ETHTOOL_A_PORT_MAX = (__ETHTOOL_A_PORT_CNT - 1)
+};
+
 enum {
 	ETHTOOL_MSG_USER_NONE = 0,
 	ETHTOOL_MSG_STRSET_GET = 1,
@@ -893,6 +913,7 @@ enum {
 	ETHTOOL_MSG_RSS_CREATE_ACT,
 	ETHTOOL_MSG_RSS_DELETE_ACT,
 	ETHTOOL_MSG_MSE_GET,
+	ETHTOOL_MSG_PORT_GET,
 
 	__ETHTOOL_MSG_USER_CNT,
 	ETHTOOL_MSG_USER_MAX = (__ETHTOOL_MSG_USER_CNT - 1)
@@ -954,6 +975,7 @@ enum {
 	ETHTOOL_MSG_RSS_CREATE_NTF,
 	ETHTOOL_MSG_RSS_DELETE_NTF,
 	ETHTOOL_MSG_MSE_GET_REPLY,
+	ETHTOOL_MSG_PORT_GET_REPLY,
 
 	__ETHTOOL_MSG_KERNEL_CNT,
 	ETHTOOL_MSG_KERNEL_MAX = (__ETHTOOL_MSG_KERNEL_CNT - 1)
-- 
2.55.0

