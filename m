Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407507;
	b=NAkeZz9RM2Ux+ruydyKhO/ijuNiDJkFtuTngCbaI/FPvD16J65Kf+jHPUX8X3DklbwBM
	 FjB5MOkEwp3pl8ozK/9Rh+a2af9RDaK44LP8aSELKG2w9mQZSgCvtSzyxlJWbsSogUqPm
	 cmm7JQ4xQmA+jm5y4A7duReKlc8mzFK23IlHcI2ekN1rwnpPQfuW/hbKdoiMwY94Cwq0q
	 td1iJT92+J153x9kdDK9bNEzhpWcyr8rlGgN9qFcrUY1zTwfSsweor9PbgFZ9ygxQxKq/
	 7dIOYkl/rGpTXduo16s87KPYhWoOZ9htaM59FgzT9IxEZfXjQfWMuHJ7xlgygImAcaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407507;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
	bh=3okpg6N7hZifdOOQYALchEFq4MJOg1SGqpEmiV0Q8Ds=;
	b=j2Swon9/3A2bfzYsDcRaUtC8IUZd8+UWXkMi87q4RHPJqRJ3sLnuI52gFmjebqoty7h0
	 Xewl9njhXcBLijBh67T5H6Yi2hJLoJBewoorAyDZA2Y0OsOJlLOHSewxbcGjZ90HXVHEa
	 zD6+wiYRrOsCvQauIKczfgEOObYo/1E6VSRRT6GfuM0sEUOMAzVW+SzuD7+0kLwuMf8PS
	 W+yEKaz5FV3EDnyNrJcUVvigdo5Ah6ffkQ1nZ1g9US8OpMBjwt43eSLWxIav7xOCEdmwz
	 EBYhkz79ehN9zmOXj8J7RyP2uuhucKncyNM8FDAhOrUvDGOBcKyi3tLJlBDSsVIURwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=OPCLDk7z;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDD6606A894;
	Wed, 11 Nov 2026 14:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FDD6606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=OPCLDk7z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794407514; x=1825943514;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=nDwYucNkwSvQffreH6bAXIM7sx59sPbskRQSM3xtrGk=;
  b=OPCLDk7z9mVierhDaiZcB08LDwpG+hVsdkln0Yd8bHR81/pPudLbqH4L
   W1YS/Dm1SpXUjI+R5/CeOxWct9wZ6AuOQ/92iAr9v/PVMpqAkAUM85lgJ
   MvKPacbRLhF/gjhOAwW7vmno85nVe21kt332CLkW0t9FSbjxv42BLatKh
   FK/kxHyDKN3s+633wQIm3pev0bMK4z9eZrbEQmyREx7InkheELIRy2D6T
   OHK/ueRJgI2cHSCmwOA8gNFqeEfPufa/+RYE8Ex0SNfQ831eB4NfyjbCb
   FvFepp1GI5wNuxlM2yNBep+CIc0t8FCeOticHCEcPEgGCcDbtgTFciXde
   w==;
X-CSE-ConnectionGUID: 1xDGokrxTw2f4OIHtVbb/g==
X-CSE-MsgGUID: Iut745tzTJahcelyXQzTHQ==
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="77022907"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 07:31:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Wed, 11 Nov 2026 07:31:46 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 11 Nov 2026 07:31:43 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 11 Nov 2026 15:31:17 +0100
Subject: [PATCH net-next v2 7/9] net: sparx5/lan969x: scale the queue
 watermarks with the MTU
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
Message-ID: <20261111-sparx5-mtu-change-v2-7-59c91357e8f6@microchip.com>
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

The queue system of a port has pause watermarks (PAUSE_START and
PAUSE_STOP), which control when pause frames are sent if TX pause is
enabled, and a tail drop watermark (ATOP), above which frames received
on the port are dropped. They are set in units of buffer cells, and are
currently fixed multiples of a 1518 byte frame. With a larger MTU, a
single frame can exceed PAUSE_START, so with TX pause enabled, a pause
frame would be sent for every received frame.

Instead, compute the watermarks from the MTU of the port, plus the
Ethernet header, FCS and two VLAN tags, rounded up to whole buffer
cells. Program them at port init and when pause is resolved, and add
sparx5_port_wm_update() for use when the MTU changes. As the MTU and
phylink paths can run concurrently, protect the watermarks and the
resolved pause mode with a per-port lock.

The top bit of the watermark fields is a x16 multiplier, so take its
position from the field width, which is 11 bits on lan969x and 12 bits
on Sparx5.

With the default MTU of 1500, the watermarks grow from 8 to 9 cells per
frame, as the frame length is now rounded up instead of down.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |  1 +
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  2 +
 .../net/ethernet/microchip/sparx5/sparx5_port.c    | 73 ++++++++++++++--------
 .../net/ethernet/microchip/sparx5/sparx5_port.h    |  1 +
 4 files changed, 51 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index cf9cdd494674f..8161685c652b5 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -340,6 +340,7 @@ static int sparx5_create_port(struct sparx5 *sparx5,
 	spx5_port->phylink_pcs.ops = &sparx5_phylink_pcs_ops;
 	spx5_port->is_mrouter = false;
 	INIT_LIST_HEAD(&spx5_port->tc_templates);
+	mutex_init(&spx5_port->wm_lock);
 	sparx5->ports[config->portno] = spx5_port;
 
 	err = sparx5_port_init(sparx5, spx5_port, &config->conf);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 97bf8a6cb83f5..59deeb91ad921 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -215,6 +215,8 @@ struct sparx5_port {
 	struct device_node *of_node;
 	struct phy *serdes;
 	struct sparx5_port_config conf;
+	struct mutex wm_lock; /* Protects the QSYS watermarks and wm_pause */
+	u8 wm_pause;
 	struct phylink_config phylink_config;
 	struct phylink *phylink;
 	struct phylink_pcs phylink_pcs;
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
index 701d310df0ba6..87aa0b7841359 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
@@ -373,11 +373,14 @@ static int sparx5_port_disable(struct sparx5 *sparx5, struct sparx5_port *port,
 		 sparx5,
 		 HSCH_PORT_MODE(port->portno));
 
-	/* 5: Disable Flowcontrol */
+	/* 5: Disable Flowcontrol, and keep an MTU change from re-enabling it */
+	mutex_lock(&port->wm_lock);
+	port->wm_pause = 0;
 	spx5_rmw(QSYS_PAUSE_CFG_PAUSE_STOP_SET(0xFFF - 1),
 		 QSYS_PAUSE_CFG_PAUSE_STOP,
 		 sparx5,
 		 QSYS_PAUSE_CFG(port->portno));
+	mutex_unlock(&port->wm_lock);
 
 	spd_prm = spd == SPEED_10 ? 1000 : spd == SPEED_100 ? 100 : 10;
 	/* 6: Wait while the last frame is exiting the queues */
@@ -676,24 +679,53 @@ int sparx5_port_fwd_urg(struct sparx5 *sparx5, u32 speed)
 	return urg / clk_period_ps - 1;
 }
 
+/* The top bit of the watermark field is a x16 multiplier */
 static u16 sparx5_wm_enc(u16 value)
 {
-	if (value >= 2048)
-		return 2048 + value / 16;
+	u16 mult = BIT(regs->fsize[FW_QSYS_ATOP_ATOP] - 1);
+
+	if (value >= mult)
+		return mult + value / 16;
 
 	return value;
 }
 
+/* Pause start/stop and tail drop at 6/4/20 frames of the port MTU */
+static void sparx5_port_wm_set(struct sparx5 *sparx5, struct sparx5_port *port,
+			       u8 pause)
+{
+	u32 len = SPX5_HW_MTU(READ_ONCE(port->ndev->mtu)) + 2 * VLAN_HLEN;
+	u32 cells = DIV_ROUND_UP(len, SPX5_BUFFER_CELL_SZ);
+	u32 pause_stop = 0xFFF - 1; /* FC gen disabled */
+
+	if (pause & MLO_PAUSE_TX)
+		pause_stop = sparx5_wm_enc(4 * cells);
+
+	spx5_rmw(QSYS_PAUSE_CFG_PAUSE_START_SET(sparx5_wm_enc(6 * cells)) |
+		 QSYS_PAUSE_CFG_PAUSE_STOP_SET(pause_stop),
+		 QSYS_PAUSE_CFG_PAUSE_START |
+		 QSYS_PAUSE_CFG_PAUSE_STOP,
+		 sparx5,
+		 QSYS_PAUSE_CFG(port->portno));
+
+	/* Port ATOP. Frames are tail dropped when this WM is hit */
+	spx5_wr(QSYS_ATOP_ATOP_SET(sparx5_wm_enc(20 * cells)),
+		sparx5,
+		QSYS_ATOP(port->portno));
+}
+
+void sparx5_port_wm_update(struct sparx5 *sparx5, struct sparx5_port *port)
+{
+	mutex_lock(&port->wm_lock);
+	sparx5_port_wm_set(sparx5, port, port->wm_pause);
+	mutex_unlock(&port->wm_lock);
+}
+
 static int sparx5_port_fc_setup(struct sparx5 *sparx5,
 				struct sparx5_port *port,
 				struct sparx5_port_config *conf)
 {
 	bool fc_obey = conf->pause & MLO_PAUSE_RX ? 1 : 0;
-	u32 pause_stop = 0xFFF - 1; /* FC gen disabled */
-
-	if (conf->pause & MLO_PAUSE_TX)
-		pause_stop = sparx5_wm_enc(4  * (ETH_MAXLEN /
-						 SPX5_BUFFER_CELL_SZ));
 
 	/* Set HDX flowcontrol */
 	spx5_rmw(DSM_MAC_CFG_HDX_BACKPREASSURE_SET(conf->duplex == DUPLEX_HALF),
@@ -714,10 +746,10 @@ static int sparx5_port_fc_setup(struct sparx5 *sparx5,
 		 QSYS_FWD_PRESSURE(port->portno));
 
 	/* Generate pause frames */
-	spx5_rmw(QSYS_PAUSE_CFG_PAUSE_STOP_SET(pause_stop),
-		 QSYS_PAUSE_CFG_PAUSE_STOP,
-		 sparx5,
-		 QSYS_PAUSE_CFG(port->portno));
+	mutex_lock(&port->wm_lock);
+	port->wm_pause = conf->pause;
+	sparx5_port_wm_set(sparx5, port, conf->pause);
+	mutex_unlock(&port->wm_lock);
 
 	return 0;
 }
@@ -1101,15 +1133,12 @@ int sparx5_port_init(struct sparx5 *sparx5,
 		     struct sparx5_port *port,
 		     struct sparx5_port_config *conf)
 {
-	u32 pause_start = sparx5_wm_enc(6  * (ETH_MAXLEN / SPX5_BUFFER_CELL_SZ));
-	u32 atop = sparx5_wm_enc(20 * (ETH_MAXLEN / SPX5_BUFFER_CELL_SZ));
 	const struct sparx5_ops *ops = sparx5->data->ops;
 	u32 pix = sparx5_port_dev_index(sparx5, port->portno);
 	u32 pcs = sparx5_to_pcs_dev(sparx5, port->portno);
 	bool sd_pol = port->signd_active_high;
 	bool sd_sel = !port->signd_internal;
 	bool sd_ena = port->signd_enable;
-	u32 pause_stop = 0xFFF - 1; /* FC generate disabled */
 	void __iomem *pcsinst;
 	int err;
 
@@ -1120,21 +1149,13 @@ int sparx5_port_init(struct sparx5 *sparx5,
 	if (err)
 		return err;
 
-	/* Set Pause WM hysteresis */
-	spx5_rmw(QSYS_PAUSE_CFG_PAUSE_START_SET(pause_start) |
-		 QSYS_PAUSE_CFG_PAUSE_STOP_SET(pause_stop) |
-		 QSYS_PAUSE_CFG_PAUSE_ENA_SET(1),
-		 QSYS_PAUSE_CFG_PAUSE_START |
-		 QSYS_PAUSE_CFG_PAUSE_STOP |
+	/* Set Pause WM hysteresis and ATOP, FC generate disabled */
+	sparx5_port_wm_set(sparx5, port, 0);
+	spx5_rmw(QSYS_PAUSE_CFG_PAUSE_ENA_SET(1),
 		 QSYS_PAUSE_CFG_PAUSE_ENA,
 		 sparx5,
 		 QSYS_PAUSE_CFG(port->portno));
 
-	/* Port ATOP. Frames are tail dropped when this WM is hit */
-	spx5_wr(QSYS_ATOP_ATOP_SET(atop),
-		sparx5,
-		QSYS_ATOP(port->portno));
-
 	/* Discard pause frame 01-80-C2-00-00-01 */
 	spx5_wr(PAUSE_DISCARD, sparx5, ANA_CL_CAPTURE_BPDU_CFG(port->portno));
 
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.h b/drivers/net/ethernet/microchip/sparx5/sparx5_port.h
index 912f97a506768..06d2becfd9aac 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.h
@@ -91,6 +91,7 @@ int sparx5_port_init(struct sparx5 *sparx5,
 void sparx5_port_max_len_set(struct sparx5 *sparx5,
 			     struct sparx5_port *port,
 			     u32 len);
+void sparx5_port_wm_update(struct sparx5 *sparx5, struct sparx5_port *port);
 
 int sparx5_port_config(struct sparx5 *sparx5,
 		       struct sparx5_port *spx5_port,

-- 
2.34.1

