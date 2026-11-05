Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884795;
	b=iLDjLbvpaOI5fWzhoT5HpvikwNeL7TW3+U56Pl2AVBxm1i3FhJTxJw0DgmF8NZ8JeK5I
	 amowsJzKvZ7SsS3XsHLGCsCk0dJmNjEcygSLOpsz30rg+pzoKwY2y+8AA2mFqd/qPwM5n
	 CEdgR7eQGwgXU12YxxsC1sy55E5kys1WvniKBdQadYz2QegBRZi39eiRUXzVVv0X0X1hx
	 7CfmI8cAjY2xc3IzHE7jYfgk5gPXLfCQT99e+97UG8+sF501BXFxn+zvzInsi/Ok/yNdj
	 CSv6Y0pBcMptG8SKfVm+sUB0LXHzcLgKi0cSOBB5K6yrk9iHAMxk//s7o+lK3oZizIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884795;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
	bh=azaQOzlj0RhM8KeJcyS6f9kkUk/eS0E3MUqrAk4Osro=;
	b=u4mT6nqoBTuItbG+TKtWAQecs+C5KmNkJ/iFKjc3asUPHVVrHGzAzx/fXW294xTV7BL0
	 V0nmQUxC5IApDxdej/2aMNJ+nvcH240SyXA+Q2cEoSJoPvn1v8fA1D1iogGzaf0c2QDJ5
	 OBvP9aTBXM66vHObPf9ovwtD2KdPpuUFuCY2SGx31oL9O80+Gdnaw7/rFfqSt1ITLu6qQ
	 A/5Q9Stw2tZL/JTnrB0xXXNgSaZFJZWjTJTvjX/1FRui6e9H9oK9+1zyBs8PM5ne4LC5d
	 yXI+LINqWvgmCfT+KY+ODFq/RDlUCmHFAbdcABlkA5ZStBKjUt9AGRnn1vKAInuz6fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b="viT/AFwx";
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EACE606A329;
	Thu,  5 Nov 2026 13:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EACE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=viT/AFwx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793884801; x=1825420801;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=/dxp1HNr4bOfre6BcTJskH3EOXgB0EOGaJbHHFAEC+Y=;
  b=viT/AFwxZ3iftWYGYwXQIzUvaz9UgTw/+jiw9FrLMKuNoZra/NoDjLSs
   BDyxPgK9jT6zyy+4fcgGmtabKYHKKljR77AUkFKTx/r2rq6z3nV8WDas6
   X9Hm+fAsSWrCXZJjPJnghQ3TL+GD2qt/Da8S6hFvuMTcJezCygUowkniQ
   URX9qRWIODHIfWRROS33mdhEKaMAZjulazu1UvqM2prrG+sayjVo8Nk4I
   x/2Yv7Bn+UMp57VrIxgZM1wAyhssi9pNbq9Zm0kWHhj29uEbQYutoBpQU
   QLc+zGK0iIOuhMxHshXJJ9IYK+eRU9rffYYNok8KVC8Wy+BMCF/whmPH2
   A==;
X-CSE-ConnectionGUID: jGqK3NriSvGxGit4MVVwog==
X-CSE-MsgGUID: hkiVttGBRoKKCYFK/utlzw==
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="76685349"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 06:20:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 5 Nov 2026 06:19:54 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 5 Nov 2026 06:19:52 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 5 Nov 2026 14:19:37 +0100
Subject: [PATCH net-next v3 3/5] net: sparx5: Track shared tc blocks and
 per-port policer state
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
Message-ID: <20261105-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v3-3-b45a3a26bed5@microchip.com>
References: <20261105-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v3-0-b45a3a26bed5@microchip.com>
In-Reply-To: <20261105-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v3-0-b45a3a26bed5@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>
CC: <robert.marko@sartura.hr>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.3

A police action on a shared tc block applies one aggregate rate to all
ports bound to the block, which a per-port policer cannot implement.
The port policer offload therefore needs to know whether the ingress
block of a port is shared.

Add struct sparx5_port_tc to each port, holding a flag that records
whether the ingress block is shared, and the state of the four policers
of the port.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h | 16 ++++++++++++++++
 drivers/net/ethernet/microchip/sparx5/sparx5_tc.c   | 14 ++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 8dc3a500c1c91..19217d443cc74 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -207,6 +207,21 @@ struct sparx5_port_config {
 	u32 sd_sgpio;
 };
 
+#define SPX5_POLICERS_PER_PORT 4 /* Number of ingress port policers */
+
+struct sparx5_port_policer {
+	struct flow_stats prev;
+	struct flow_stats stats;
+	/* Port policers hold the client reference (cookie) */
+	unsigned long policer;
+};
+
+struct sparx5_port_tc {
+	/* Ingress uses a shared filter block */
+	bool ingress_block_shared;
+	struct sparx5_port_policer port_policer[SPX5_POLICERS_PER_PORT];
+};
+
 struct sparx5_port {
 	struct net_device *ndev;
 	struct sparx5 *sparx5;
@@ -230,6 +245,7 @@ struct sparx5_port {
 	enum sparx5_vlan_port_type vlan_type;
 	u32 custom_etype;
 	bool vlan_aware;
+	struct sparx5_port_tc tc;
 	struct hrtimer inj_timer;
 	/* ptp */
 	u8 ptp_cmd;
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc.c
index 30da5db57ef35..fd5a75aa09603 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc.c
@@ -47,7 +47,9 @@ static int sparx5_tc_block_cb_egress(enum tc_setup_type type,
 static int sparx5_tc_setup_block(struct net_device *ndev,
 				 struct flow_block_offload *fbo)
 {
+	struct sparx5_port *port = netdev_priv(ndev);
 	flow_setup_cb_t *cb;
+	int err;
 
 	if (fbo->binder_type == FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS)
 		cb = sparx5_tc_block_cb_ingress;
@@ -56,8 +58,16 @@ static int sparx5_tc_setup_block(struct net_device *ndev,
 	else
 		return -EOPNOTSUPP;
 
-	return flow_block_cb_setup_simple(fbo, &sparx5_block_cb_list,
-					  cb, ndev, ndev, false);
+	err = flow_block_cb_setup_simple(fbo, &sparx5_block_cb_list,
+					 cb, ndev, ndev, false);
+	if (err)
+		return err;
+
+	if (fbo->binder_type == FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS)
+		port->tc.ingress_block_shared =
+			fbo->command == FLOW_BLOCK_BIND && fbo->block_shared;
+
+	return 0;
 }
 
 static void sparx5_tc_get_layer_and_idx(struct sparx5 *sparx5, u32 parent,

-- 
2.34.1

