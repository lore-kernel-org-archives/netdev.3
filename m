Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6442935EDBF
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521371; cv=none; b=Fx8DTsX1FaCX++sa+MvX2/cRuKJmnQpEGhZo48BlfGsFJnU5Qq0TRu1zxQpP/Na4jSO22uY23/vmIoJG8sSDHhG2GMxvcxOqTVerAvSDcIu3S9ZE1jgi4bHDPRiOogbHUyME6jUOShN+Nf+ylkqJ+XPEmuNXLGnswkvxEwY3BeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521371; c=relaxed/simple;
	bh=dIW9DmuRZ6tKWsiS7mSRMUwkt75gVBWc0F9T4GKBWXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1Xw8aJcTuL1ZTbXpAvKR05bhfXLjmcZOw0QT8pEdvDW1+y4X6UmwjwoKF4j/VgWi+UtRMtanZU5Ae8pUxRP7Xiepppn+FmpRMYfosd9+1z1bSGLTPWG5fuhj/vuM+c4yHXS+lQ1zEMgeO0OqgBS+bIXuW1DdkQgTpzxs8anSR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QFgv3IBR; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QFgv3IBR"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 14AA11A2A84;
	Tue, 27 Jan 2026 13:42:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DC03B606F5;
	Tue, 27 Jan 2026 13:42:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7971F119A8647;
	Tue, 27 Jan 2026 14:42:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769521367; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=JE1ajPZV3RBLMmNHm3FO3KqAiha9kx7cpVHokUOQiNc=;
	b=QFgv3IBR6MRr+C4KXQbQZIogintzCljAemoiXBDCIzOurWAzlnU+RQBeMNYVARGhEHvCGP
	G17QkATcyvP/pkbseAvcJ19VEUhfrTmAZO8+G1WwjwvZM0XhgjjYxDnP/hX4z2pK2s6WdG
	Gxox07/cc92+8cvAqSXTtYti4JLg2Y2cI28lwlO462+07wIsJ8YnJtLXEQzYpm1HdmDYLn
	GN0C7wT3nVm9ma2RSE9MwQWSwEuTF1HFmBwrzxmFu/vihzjxKcwjHbsELtn82wy76HqBwR
	A4WCd71MjPQLQWUrFzeRCo06BktvzaR+4DlyH35XeJ0Doko8bPTwnkjcmPDRGw==
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
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: [PATCH net-next 12/13] netlink: specs: Add ethernet port listing with ethtool
Date: Tue, 27 Jan 2026 14:42:00 +0100
Message-ID: <20260127134202.8208-13-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127134202.8208-1-maxime.chevallier@bootlin.com>
References: <20260127134202.8208-1-maxime.chevallier@bootlin.com>
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

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 Documentation/netlink/specs/ethtool.yaml      | 50 +++++++++++++++++++
 Documentation/networking/ethtool-netlink.rst  | 35 +++++++++++++
 .../uapi/linux/ethtool_netlink_generated.h    | 19 +++++++
 3 files changed, 104 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 0a2d2343f79a..f0f424009fb0 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -210,6 +210,10 @@ definitions:
       -
         name: discard
         value: 31
+  -
+    name: port-type
+    type: enum
+    entries: [mdi, sfp]
 
 attribute-sets:
   -
@@ -1890,6 +1894,32 @@ attribute-sets:
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
+        type: u8
+        enum: port-type
+      -
+        name: occupied
+        type: u8
 
 operations:
   enum-model: directional
@@ -2842,6 +2872,26 @@ operations:
             - worst-channel
             - link
       dump: *mse-get-op
+    -
+      name: port-get
+      doc: Get ports attached to an interface
+
+      attribute-set: port
+
+      do: &port-get-op
+        request:
+          attributes:
+            - header
+            - id
+        reply:
+          attributes:
+            - header
+            - id
+            - supported-modes
+            - supported-interfaces
+            - type
+            - occupied
+      dump: *port-get-op
 
 mcast-groups:
   list:
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index af56c304cef4..450004d545b8 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -2522,6 +2522,40 @@ Within each channel nest, only the metrics supported by the PHY will be present.
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
+====================================  ======  =================================
+  ``ETHTOOL_A_PORT_HEADER``             nested  request header
+  ``ETHTOOL_A_PORT_ID``                 u32     port id
+  ====================================  ======  ===============================
+
+Kernel response contents:
+
+  =====================================   ======  =============================
+  ``ETHTOOL_A_PORT_HEADER``               nested  request header
+  ``ETHTOOL_A_PORT_ID``                   u32     the port's unique identifier,
+                                                  per netdevice.
+  ``ETHTOOL_A_PORT_SUPPORTED_MODES``      bitset  bitset of supported linkmodes
+  ``ETHTOOL_A_PORT_SUPPORTED_INTERFACES`` bitset  bitset of supported MII
+                                                  interfaces
+  ``ETHTOOL_A_PORT_TYPE``                 u32     the port type
+  ``ETHTOOL_A_PORT_OCCUPIED``             u8      for non-mdi ports, indicates
+                                                  if the port is connected
+                                                  another device that could
+                                                  expose a MDI
+  =====================================   ======  =============================
+
 Request translation
 ===================
 
@@ -2632,4 +2666,5 @@ are netlink only.
   n/a                                 ``ETHTOOL_MSG_PHY_GET``
   ``SIOCGHWTSTAMP``                   ``ETHTOOL_MSG_TSCONFIG_GET``
   ``SIOCSHWTSTAMP``                   ``ETHTOOL_MSG_TSCONFIG_SET``
+  n/a                                 ``ETHTOOL_MSG_PORT_GET``
   =================================== =====================================
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 556a0c834df5..7ccd864a6e38 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -78,6 +78,11 @@ enum ethtool_pse_event {
 	ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR = 64,
 };
 
+enum ethtool_port_type {
+	ETHTOOL_PORT_TYPE_MDI,
+	ETHTOOL_PORT_TYPE_SFP,
+};
+
 enum {
 	ETHTOOL_A_HEADER_UNSPEC,
 	ETHTOOL_A_HEADER_DEV_INDEX,
@@ -837,6 +842,18 @@ enum {
 	ETHTOOL_A_MSE_MAX = (__ETHTOOL_A_MSE_CNT - 1)
 };
 
+enum {
+	ETHTOOL_A_PORT_HEADER = 1,
+	ETHTOOL_A_PORT_ID,
+	ETHTOOL_A_PORT_SUPPORTED_MODES,
+	ETHTOOL_A_PORT_SUPPORTED_INTERFACES,
+	ETHTOOL_A_PORT_TYPE,
+	ETHTOOL_A_PORT_OCCUPIED,
+
+	__ETHTOOL_A_PORT_CNT,
+	ETHTOOL_A_PORT_MAX = (__ETHTOOL_A_PORT_CNT - 1)
+};
+
 enum {
 	ETHTOOL_MSG_USER_NONE = 0,
 	ETHTOOL_MSG_STRSET_GET = 1,
@@ -890,6 +907,7 @@ enum {
 	ETHTOOL_MSG_RSS_CREATE_ACT,
 	ETHTOOL_MSG_RSS_DELETE_ACT,
 	ETHTOOL_MSG_MSE_GET,
+	ETHTOOL_MSG_PORT_GET,
 
 	__ETHTOOL_MSG_USER_CNT,
 	ETHTOOL_MSG_USER_MAX = (__ETHTOOL_MSG_USER_CNT - 1)
@@ -951,6 +969,7 @@ enum {
 	ETHTOOL_MSG_RSS_CREATE_NTF,
 	ETHTOOL_MSG_RSS_DELETE_NTF,
 	ETHTOOL_MSG_MSE_GET_REPLY,
+	ETHTOOL_MSG_PORT_GET_REPLY,
 
 	__ETHTOOL_MSG_KERNEL_CNT,
 	ETHTOOL_MSG_KERNEL_MAX = (__ETHTOOL_MSG_KERNEL_CNT - 1)
-- 
2.49.0

