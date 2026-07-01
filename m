Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EF2477989;
	Wed,  1 Jul 2026 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903902; cv=none; b=mSFoKEw5mWbQaQcA56jf608yfWH7m0isLKwBxICuahDLTQuAHFQbyafFHwlSMJ7blTcY8bg+zFLMK3rBDDnew9HuKbg97CDO1C5Q7Ytl5gSiwXAQJhHT0D1Dk1ddVz8Vvyt4SpzbOXt7H9YPA0ezXFE42LfIKn84HvqqHS2p2vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903902; c=relaxed/simple;
	bh=LBz9z/8yzN5MJgzQKD9TqnSz0kA6DAm5VPD7mp6p4Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3yg1+iuMveuI+hMv0avPnQUozY4UE9rTQKuhUozcecnm0tTYqYnYKjUGs4+o30QFeCBZZsFD6jjhMfrOV3Rp9Fvs9gj3AQ0XwNghD51feqifsDuIiZaOMLX7N1iIcEyBuxZT6vSrPGM8DhCV7hV5loJR9I14g9Vzgx0mEIJAUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GolGusTS; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GolGusTS"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EE4051A0DB1;
	Wed,  1 Jul 2026 11:04:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BBD7E60288;
	Wed,  1 Jul 2026 11:04:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 923B2104C9E58;
	Wed,  1 Jul 2026 13:04:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782903898; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=fTt2+3DnkOasaUznpixanWNZVOZMICdYArGvwG1a69E=;
	b=GolGusTSjHfeFcGl0kiisYMGCs4a9m8U/687pufRNQlKFBMexM0z+kJtGMKLnkfNlNQWYE
	I4nGtmvH0nkpE6vP7yQLl3UT7TcWcGc+GRHghZCZ9r0DYRbWbv4g0jEMNeK7OIl1uWfNOw
	fxz8B1P74bvlQG0WcTAgEWYYMl+/p+1U2cbMDedLBbMge8WJ68LK+oKyTyHiHk906tYUri
	WQePQxRClFSU4qwneUbgK0WCQbetSo0WKjrRH89OqM9F24vivCaaNzAYzzGJLy/sxHqvk8
	bOVIcDfoM0Q+Bw3iazz4beKOWa8sQJUSIsS7qmCBjWLc5QT0CTh/RxWOkyDcaQ==
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
	Frank Wunderlich <frank.wunderlich@linux.dev>
Subject: [PATCH net-next v13 08/10] netlink: specs: Add ethernet port listing with ethtool
Date: Wed,  1 Jul 2026 13:04:24 +0200
Message-ID: <20260701110427.143945-9-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701110427.143945-1-maxime.chevallier@bootlin.com>
References: <20260701110427.143945-1-maxime.chevallier@bootlin.com>
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
 Documentation/networking/ethtool-netlink.rst  | 34 +++++++++++++
 .../uapi/linux/ethtool_netlink_generated.h    | 19 +++++++
 3 files changed, 103 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 5dd4d1b5d94b..d1151af335ca 100644
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
@@ -1905,6 +1909,32 @@ attribute-sets:
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
@@ -2859,6 +2889,26 @@ operations:
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
+            - upstream-port
+      dump: *port-get-op
 
 mcast-groups:
   list:
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index e92abf45faf5..b4326c89b075 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -2537,6 +2537,39 @@ Within each channel nest, only the metrics supported by the PHY will be present.
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
 
@@ -2647,4 +2680,5 @@ are netlink only.
   n/a                                 ``ETHTOOL_MSG_PHY_GET``
   ``SIOCGHWTSTAMP``                   ``ETHTOOL_MSG_TSCONFIG_GET``
   ``SIOCSHWTSTAMP``                   ``ETHTOOL_MSG_TSCONFIG_SET``
+  n/a                                 ``ETHTOOL_MSG_PORT_GET``
   =================================== =====================================
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 8134baf7860f..f9d8794eabc1 100644
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
@@ -840,6 +845,18 @@ enum {
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
@@ -893,6 +910,7 @@ enum {
 	ETHTOOL_MSG_RSS_CREATE_ACT,
 	ETHTOOL_MSG_RSS_DELETE_ACT,
 	ETHTOOL_MSG_MSE_GET,
+	ETHTOOL_MSG_PORT_GET,
 
 	__ETHTOOL_MSG_USER_CNT,
 	ETHTOOL_MSG_USER_MAX = (__ETHTOOL_MSG_USER_CNT - 1)
@@ -954,6 +972,7 @@ enum {
 	ETHTOOL_MSG_RSS_CREATE_NTF,
 	ETHTOOL_MSG_RSS_DELETE_NTF,
 	ETHTOOL_MSG_MSE_GET_REPLY,
+	ETHTOOL_MSG_PORT_GET_REPLY,
 
 	__ETHTOOL_MSG_KERNEL_CNT,
 	ETHTOOL_MSG_KERNEL_MAX = (__ETHTOOL_MSG_KERNEL_CNT - 1)
-- 
2.54.0

