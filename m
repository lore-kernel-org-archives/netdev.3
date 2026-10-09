Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E4B4D489C;
	Fri,  9 Oct 2026 11:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546853; cv=none; b=kqu5ekUMir7ZkPY9QsA3skyDB/F0HP92F3UQHQfjOOWcs/1BBOVFas1B6zYqfSz5WSwskO9SoJlnjGqnZQB1SJHanS12U3fKX0cis8CNwM/HvOhYK+u26XmB9RF16MZ/YceSLB5+Xa2/cD7bmEqzkror1VD4vysFVY1vosAa8f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546853; c=relaxed/simple;
	bh=3G6/3+7U1vOnQC9zPE7ZSPxtWgsWrbbZkl5rpRYDYl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eZBwTcNnOrtMceiFZP18bEyu0WdhUOcIZPCk2/WbrZGzwgYSdzS5UH7qnW90hZ4WfN7M5Fgl2fJmp2l+hQlBdgxGMtur4nCXhNXq/Ogyv+x7ndfWRewzaeGpQzNpRayhIJm/Sy70wagRiXZWDQYIT5x7jA8Pv0gpm6VMsaTvpPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=10Bzok7j; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="10Bzok7j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791546848; x=1823082848;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=3G6/3+7U1vOnQC9zPE7ZSPxtWgsWrbbZkl5rpRYDYl8=;
  b=10Bzok7jQHxlhgV4I7MJbkUxXENqx7ijjcC1LI2Hm7rEutEGXnvGrPJn
   VEg1dKqy8WbcfGfvetgLNWSVrOa4IV0RixDFjCuLf6/PcGepn/R3BnFdP
   otk31wKKT0YnFSFIi0peLMoi2omDHxayGx76QfyWqJuXTPeEg6yUdq/fP
   NM8duuNBRA5AsTEEZJUheMnQET6DRjm187vp4SkNtE+DOhMdLuqWQB/QY
   B26MPReLO5JAbz8IlKKvD+gf7b+oKUjwIkTWG+2pOwuPkzSpHFJw7vvQn
   MVH/fMg4CEVBNs8Ruywxf/9v/xugn1Ar4/vt9xfqoXsy32H4LDuBj+y6H
   g==;
X-CSE-ConnectionGUID: AW1woLrPQbulzhFNMijsmg==
X-CSE-MsgGUID: 3hTGxRhOQaiRuZt4QemWWw==
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="296224245"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2026 04:54:07 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 9 Oct 2026 04:54:06 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 9 Oct 2026 04:54:04 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 9 Oct 2026 13:52:03 +0200
Subject: [PATCH net-next 3/5] net: sparx5: Track shared tc blocks and
 per-port policer state
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261009-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v1-3-4916708a7ea2@microchip.com>
References: <20261009-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v1-0-4916708a7ea2@microchip.com>
In-Reply-To: <20261009-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v1-0-4916708a7ea2@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Daniel Machon <daniel.machon@microchip.com>
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
index 0f7d8440f614..021ac7a52034 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -206,6 +206,21 @@ struct sparx5_port_config {
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
@@ -229,6 +244,7 @@ struct sparx5_port {
 	enum sparx5_vlan_port_type vlan_type;
 	u32 custom_etype;
 	bool vlan_aware;
+	struct sparx5_port_tc tc;
 	struct hrtimer inj_timer;
 	/* ptp */
 	u8 ptp_cmd;
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc.c
index 28b2514c8330..9ac99627eafc 100644
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

