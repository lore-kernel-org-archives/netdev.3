Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407495;
	b=0f8XTzxt0CC3A9PUDvdwnAoisOxfQtHpyC1K78+YiTDfeMHEyNysV/jPDojly5WSw96H
	 zI1v5uCJiQmX295rRtVPojEKGnftkzBnVjqnCOCCCoxa4MZAtQlo0AImMLLOULXKPHPp9
	 iFE3NUC7sQoml+1dFo6Sl5yTb7AZ/+8aamJZ5S7kSIq8EuoBBEmk7EwxmcJoj7HVw8pxy
	 NCu8bXyNwTWom40aoDqCi2tqcSiaJdoTvJdwu8hHReuHO9AS+POyIBg8sV9SAe7Ugkl2X
	 1If/f18z/V3In5Ton0ekIs6RXpLwT6vU1WRr88nTELNIOA6b9ZwUwp05NAfG6FXkTgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407495;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
	bh=1hD9UnFUoPw7mpXyEiUYUOLSoqgMlHjlWfYdwenzm8Y=;
	b=Milq16CUgp3qWVIzdUNh8621NiCLaMoe3LcRCHq+RD24ooeROc6ExgrTyWmpu0yurdxD
	 ST46OqZFB/TqbFcxzwx3F4S3q0ETJP9mimh5Rs1DXEJx1heanzyL7c0PjU9v0U3VSXruC
	 c3ULRGLoOQwo1XxgvlHzmfwHvVNeP2bnHVn2D0VydXAPstyw/yVLyxarZAasVwHHD5PeB
	 V5b1c1KqTuBSnQtOMtMUZOWo9voSl6Elq9roOw5aPALpYiyhGrApGJUYyDzHpRTrhyppI
	 VDki9iruZ3SRwPr5FsNpbnxC2NoLzVAG11j/jhRM97TqcQra58QSZbYa4cSTJhZPMrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=nVE+EZvC;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F4F606A327;
	Wed, 11 Nov 2026 14:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67F4F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=nVE+EZvC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794407495; x=1825943495;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=SW1hK4buuMn4e9UpYlOurWbuC9mLjcKJ06uapBXeTkg=;
  b=nVE+EZvC9IXGxMCpY2LME0eO9YLNUp9m3ZFIbQtnbGOn5ZkFYhQqlcP0
   6Uc9hrRBzAk8YkYe2c84cNOjAmAnzw0H05BdMl1kaNabwt3jrq5ztNkho
   HoPLwgwzo4mOuDswVCYzcmVHVX3drCdD5/sSRY41rEllZIHd4TtXAKWM0
   Wet8wxbh6U6I7nx8ixKnPeBKVIN4qGE/2wtut5WaldKGcCdRSdKxi4FYB
   tgZDi69pkJJHCbYGZfRXKb4P8eDje9JfsTy8NZBSoeChVBYUlAXBdbkhh
   0EgG2eVUa9I9Ehx57YfbLxqcLRxIIsaOQDB/2x+11k6JijbZyY1TS2nGI
   w==;
X-CSE-ConnectionGUID: pKPNovUBQHKULKfwbxwNUg==
X-CSE-MsgGUID: 6qGPi11zQC2+fqlEtccgAA==
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="66598096"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2026 07:31:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 11 Nov 2026 07:31:34 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 11 Nov 2026 07:31:32 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 11 Nov 2026 15:31:13 +0100
Subject: [PATCH net-next v2 3/9] net: sparx5/lan969x: add a helper for
 setting the MAC max frame length
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261111-sparx5-mtu-change-v2-3-59c91357e8f6@microchip.com>
References: <20261111-sparx5-mtu-change-v2-0-59c91357e8f6@microchip.com>
In-Reply-To: <20261111-sparx5-mtu-change-v2-0-59c91357e8f6@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Richard
 Cochran" <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Robert Marko <robert.marko@sartura.hr>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.14.3

The maximum frame length accepted by a port is set in the MAC_MAXLEN_CFG
register of its MAC. All ports have a 2G5 device, the 5G, 10G and 25G
ports also have a high speed device, and the lan969x RGMII ports have an
RGMII device instead. The register is currently written open-coded in
sparx5_port_init(), with a fixed length of 1518 bytes.

Add sparx5_port_max_len_set(), which sets the maximum frame length in the
devices of a port, and use it in sparx5_port_init(). To support the
RGMII devices, add the DEVRGMII_MAC_MAXLEN_CFG register, and make
lan969x_port_dev_mapping() return the RGMII device index for the RGMII
ports.

The helper is used to change the maximum frame length with the MTU, later
in this series.

No functional change intended.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../ethernet/microchip/sparx5/lan969x/lan969x.c    |  9 ++++
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   | 11 +++++
 .../net/ethernet/microchip/sparx5/sparx5_port.c    | 50 ++++++++++++++++------
 .../net/ethernet/microchip/sparx5/sparx5_port.h    |  4 ++
 4 files changed, 61 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
index c02499d1b297a..e8c30049b54cf 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
@@ -180,6 +180,15 @@ static u32 lan969x_port_dev_mapping(struct sparx5 *sparx5, int port)
 		}
 	}
 
+	if (lan969x_port_is_rgmii(port)) {
+		switch (port) {
+		case 28:
+			return 0;
+		case 29:
+			return 1;
+		}
+	}
+
 	/* 2g5 port */
 	return port;
 }
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
index df438be0ec552..5302c7686e207 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
@@ -8430,6 +8430,17 @@ extern const struct sparx5_regs *regs;
 #define DEVRGMII_MAC_ENA_CFG_TX_ENA_GET(x)\
 	FIELD_GET(DEVRGMII_MAC_ENA_CFG_TX_ENA, x)
 
+/* LAN969X ONLY */
+/* DEV1G:MAC_CFG_STATUS:MAC_MAXLEN_CFG */
+#define DEVRGMII_MAC_MAXLEN_CFG(t)                                             \
+	__REG(TARGET_DEVRGMII, t, 2, 36, 0, 1, 36, 8, 0, 1, 4)
+
+#define DEVRGMII_MAC_MAXLEN_CFG_MAX_LEN          GENMASK(15, 0)
+#define DEVRGMII_MAC_MAXLEN_CFG_MAX_LEN_SET(x)\
+	FIELD_PREP(DEVRGMII_MAC_MAXLEN_CFG_MAX_LEN, x)
+#define DEVRGMII_MAC_MAXLEN_CFG_MAX_LEN_GET(x)\
+	FIELD_GET(DEVRGMII_MAC_MAXLEN_CFG_MAX_LEN, x)
+
 /* LAN969X ONLY */
 /* DEV1G:MAC_CFG_STATUS:MAC_TAGS_CFG */
 #define DEVRGMII_MAC_TAGS_CFG(t)                                               \
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
index ef06bed3a9cc4..701d310df0ba6 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
@@ -613,6 +613,42 @@ static int sparx5_port_max_tags_set(struct sparx5 *sparx5,
 	return 0;
 }
 
+/* Set the maximum frame length accepted by the MAC of a port */
+void sparx5_port_max_len_set(struct sparx5 *sparx5,
+			     struct sparx5_port *port,
+			     u32 len)
+{
+	u32 pix = sparx5_port_dev_index(sparx5, port->portno);
+	const struct sparx5_ops *ops = sparx5->data->ops;
+	void __iomem *devinst;
+
+	if (ops->is_port_rgmii(port->portno)) {
+		spx5_rmw(DEVRGMII_MAC_MAXLEN_CFG_MAX_LEN_SET(len),
+			 DEVRGMII_MAC_MAXLEN_CFG_MAX_LEN,
+			 sparx5,
+			 DEVRGMII_MAC_MAXLEN_CFG(pix));
+		return;
+	}
+
+	/* All other ports have a 2G5 (shadow) device */
+	spx5_rmw(DEV2G5_MAC_MAXLEN_CFG_MAX_LEN_SET(len),
+		 DEV2G5_MAC_MAXLEN_CFG_MAX_LEN,
+		 sparx5,
+		 DEV2G5_MAC_MAXLEN_CFG(port->portno));
+
+	if (ops->is_port_2g5(port->portno))
+		return;
+
+	/* The MAXLEN_CFG register layout is shared by the high speed devices */
+	devinst = spx5_inst_get(sparx5,
+				sparx5_to_high_dev(sparx5, port->portno), pix);
+
+	spx5_inst_rmw(DEV10G_MAC_MAXLEN_CFG_MAX_LEN_SET(len),
+		      DEV10G_MAC_MAXLEN_CFG_MAX_LEN,
+		      devinst,
+		      DEV10G_MAC_MAXLEN_CFG(0));
+}
+
 int sparx5_port_fwd_urg(struct sparx5 *sparx5, u32 speed)
 {
 	u32 clk_period_ps = 1600; /* 625Mhz for now */
@@ -1068,18 +1104,15 @@ int sparx5_port_init(struct sparx5 *sparx5,
 	u32 pause_start = sparx5_wm_enc(6  * (ETH_MAXLEN / SPX5_BUFFER_CELL_SZ));
 	u32 atop = sparx5_wm_enc(20 * (ETH_MAXLEN / SPX5_BUFFER_CELL_SZ));
 	const struct sparx5_ops *ops = sparx5->data->ops;
-	u32 devhigh = sparx5_to_high_dev(sparx5, port->portno);
 	u32 pix = sparx5_port_dev_index(sparx5, port->portno);
 	u32 pcs = sparx5_to_pcs_dev(sparx5, port->portno);
 	bool sd_pol = port->signd_active_high;
 	bool sd_sel = !port->signd_internal;
 	bool sd_ena = port->signd_enable;
 	u32 pause_stop = 0xFFF - 1; /* FC generate disabled */
-	void __iomem *devinst;
 	void __iomem *pcsinst;
 	int err;
 
-	devinst = spx5_inst_get(sparx5, devhigh, pix);
 	pcsinst = spx5_inst_get(sparx5, pcs, pix);
 
 	/* Set the mux port mode  */
@@ -1119,10 +1152,7 @@ int sparx5_port_init(struct sparx5 *sparx5,
 		return err;
 
 	/* Set Max Length */
-	spx5_rmw(DEV2G5_MAC_MAXLEN_CFG_MAX_LEN_SET(ETH_MAXLEN),
-		 DEV2G5_MAC_MAXLEN_CFG_MAX_LEN,
-		 sparx5,
-		 DEV2G5_MAC_MAXLEN_CFG(port->portno));
+	sparx5_port_max_len_set(sparx5, port, ETH_MAXLEN);
 
 	/* 1G/2G5: Signal Detect configuration */
 	spx5_wr(DEV2G5_PCS1G_SD_CFG_SD_POL_SET(sd_pol) |
@@ -1171,12 +1201,6 @@ int sparx5_port_init(struct sparx5 *sparx5,
 	if (sparx5_is_baser(conf->portmode))
 		sparx5_dev_switch(sparx5, port->portno, true);
 
-	/* Set Max Length */
-	spx5_inst_rmw(DEV10G_MAC_MAXLEN_CFG_MAX_LEN_SET(ETH_MAXLEN),
-		      DEV10G_MAC_MAXLEN_CFG_MAX_LEN,
-		      devinst,
-		      DEV10G_MAC_MAXLEN_CFG(0));
-
 	/* Handle Signal Detect in 10G PCS */
 	spx5_inst_wr(PCS10G_BR_PCS_SD_CFG_SD_POL_SET(sd_pol) |
 		     PCS10G_BR_PCS_SD_CFG_SD_SEL_SET(sd_sel) |
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.h b/drivers/net/ethernet/microchip/sparx5/sparx5_port.h
index c8a37468a3d1d..912f97a506768 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.h
@@ -88,6 +88,10 @@ int sparx5_port_init(struct sparx5 *sparx5,
 		     struct sparx5_port *spx5_port,
 		     struct sparx5_port_config *conf);
 
+void sparx5_port_max_len_set(struct sparx5 *sparx5,
+			     struct sparx5_port *port,
+			     u32 len);
+
 int sparx5_port_config(struct sparx5 *sparx5,
 		       struct sparx5_port *spx5_port,
 		       struct sparx5_port_config *conf);

-- 
2.34.1

