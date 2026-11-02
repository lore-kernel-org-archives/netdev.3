Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622099;
	b=0MF/NEFlk2+ovW9dlpCuVTLyDnFEi6yq5zbVJtm7/UFQUGpu2KoUbjIcA6EXJYoaqYmT
	 hAiy4MqEa7qI8n3WEm8Mj9etlANt9SyZRaGwHqi+/sZ7929PR1MGDvq2a2ikJ9/BnIfQk
	 QQJ3ay9oVH9HNHXCz6Ej//KLjV9+H87SSQPW82fnzP1EgRY352eNtgY7WrkayOs1yVN/V
	 vEvTGnrfflJZ5jgZ0FjtTuqeYFRkSPTKXKYHFJRdsv8AZqA98mtSyOgaD6xWimw/2AmF0
	 7UQAbZMh0Kim5kQe4iiqfHE5s/DIHlMgiSVv/l/xDO/VDZM/LwZ1bxUipp06VmuqW0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622099;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
	bh=azaQOzlj0RhM8KeJcyS6f9kkUk/eS0E3MUqrAk4Osro=;
	b=zVlCjMHJmUvvKiJPRf+k0caCAtk3jxJ3pB20WYI2UBS1GsEY3YtEV/MIKSsS3eUZ/IVP
	 KCU778/1vr20dtjJfIfR8s0pIXXsLLhdgJOoLhaKY7JK7suhHIyfyZlUItX1vunLD3Yku
	 jD7LYSCLN4uAXOxlLjred4Cw8e8HKGa5WXOV1bjr6TS0wCktecFT2Egt2l65ivTl/lqrB
	 rGK3yRwCl/Xeh+IX82PRCU+aCkgnKvfn5+hxTwiXhGNIsvSVGl99ZvHw5+g0ab4cspGn/
	 cb43EuR5J1iclXxxBkqcnM1SW9CttofldmW5spYjAsKAVE4xVOZEIRldbSuPU006AkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=tOPrLLT1;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A2860A2616;
	Mon,  2 Nov 2026 12:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2A2860A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=tOPrLLT1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793622099; x=1825158099;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=/dxp1HNr4bOfre6BcTJskH3EOXgB0EOGaJbHHFAEC+Y=;
  b=tOPrLLT1k6LAPtezT5mzee8quMRCCIXhBMNfJxQxaCSZRav7oK/z3RIa
   jUxOXfJUfb3GeANwpaIFYP/x/EeUZniwdGUz6u+GdVmPhVw9Qc6hiXPD2
   AkRhvAZNVvFEnF4blvpbfUg9giohdribJfhJw37XV97zPncXH53ia5kKh
   orNYj8GaicJlMmvFhB84zlmBM2XMmPqMoC8Ool5rPDz2HI9+w98wKZBSB
   25ABFtaa4SSmqBWb2MGwAZ6qGGAlzDBOgh8A6RD/P9vpqqQAL4vMBHR7j
   4sm3ygWbXoXRpYdBboIfmx6Dc/Vx/ag5YIJ08VhG8yhFzSfkup1jYp5uK
   g==;
X-CSE-ConnectionGUID: g05f8bhRQVqXZs8wI2QhfA==
X-CSE-MsgGUID: kKn4VaGiQTGDVVPwOzQ2+A==
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="232950953"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 05:21:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 2 Nov 2026 05:21:38 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 2 Nov 2026 05:21:36 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 2 Nov 2026 13:21:26 +0100
Subject: [PATCH net-next v2 3/5] net: sparx5: Track shared tc blocks and
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
Message-ID: <20261102-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v2-3-3bd47ec1b227@microchip.com>
References: <20261102-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v2-0-3bd47ec1b227@microchip.com>
In-Reply-To: <20261102-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v2-0-3bd47ec1b227@microchip.com>
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

