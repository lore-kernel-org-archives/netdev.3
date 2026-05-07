Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8A02DAFAF;
	Thu,  7 May 2026 21:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778188961; cv=none; b=Pp2d+UoNkiBUxA+C1t8rx+wIQA5nNSLlrfBVgR1J14wmWgMtiMleaxQw1PzPM3JqZ9CcWozRZd/w5EoTgDpLIdpvVwdYnKk/IB5lkAtGbjG+Cs3Zf3JnqYtLRVY7RbaAOS9aYChOXuCqIG1IL/gju5hGnh/Z59l0BU3imFCRFms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778188961; c=relaxed/simple;
	bh=ntCn7RD6JC3nMILzWuzPOi+iBfoNuf2XQgtLlxP48S4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C6aNbtAXLIDo/Alllnww2dCv57Bi+Ezq3zzM8RsTR72aCqUI9QWnSPNfMgpzUT9l28toarhPjYfT4NNeWIsMk2RXdxLgdip/TlzRB7e8R1KhBB9DZjbflw2uaciWyKsqhuB43WHHk9Mhi4wQZ1RD/c57Bwu8ZFEUqCrrplBMCB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InqEModl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InqEModl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C543C2BCF7;
	Thu,  7 May 2026 21:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778188960;
	bh=ntCn7RD6JC3nMILzWuzPOi+iBfoNuf2XQgtLlxP48S4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=InqEModlSofPyVkBR7VlqsNU4FwzykZnXrLWMWJm7kMzaQxLeWo/oaewXxLEOvSEO
	 H5U69KZaHjNsrC1Uzfx5nJZxITJXYXXDdf0zUNd0xIwmY51GqrdiRdWeJLTEOBVffI
	 3nr78G1xX6XvjcROcDjrFDi0RHkDeRhM7ekg7kWjeOroud60IoxFF8HTJymOUTCFQu
	 645/nrsOBXtt5hgf+y9a8ZGB6ORp0QyX5JEHFJQ6aL43V2rfLpBDzvAODxAPylwicp
	 1kole/Z8ANK4JjuYfI1NGgFvPrX20FrnX8zgVEnL+KqLhGCtZh/Emfo/Fynulpgw5f
	 S4HFi6oggod7A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 07 May 2026 23:21:49 +0200
Subject: [PATCH net-next v4 06/10] net: airoha: Move {cpu,fwd}_tx_packets
 in airoha_qdma struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-airoha-eth-multi-serdes-v4-6-af613b61ae02@kernel.org>
References: <20260507-airoha-eth-multi-serdes-v4-0-af613b61ae02@kernel.org>
In-Reply-To: <20260507-airoha-eth-multi-serdes-v4-0-af613b61ae02@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.3

Since now multiple net_devices connected to different QDMA blocks can
share the same GDM port, cpu_tx_packets and fwd_tx_packets fields can
be overwritten with the value from a different QDMA block. In order to
fix the issue move cpu_tx_packets and fwd_tx_packets fields from
airoha_gdm_port struct to airoha_qdma one.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 15 +++++++--------
 drivers/net/ethernet/airoha/airoha_eth.h |  8 ++++----
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 69a4c2e0d58b..786bc677af3c 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2306,19 +2306,18 @@ static int airoha_qdma_get_tx_ets_stats(struct net_device *netdev, int channel,
 					struct tc_ets_qopt_offload *opt)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
+	struct airoha_qdma *qdma = dev->qdma;
 
-	u64 cpu_tx_packets = airoha_qdma_rr(dev->qdma,
-					    REG_CNTR_VAL(channel << 1));
-	u64 fwd_tx_packets = airoha_qdma_rr(dev->qdma,
+	u64 cpu_tx_packets = airoha_qdma_rr(qdma, REG_CNTR_VAL(channel << 1));
+	u64 fwd_tx_packets = airoha_qdma_rr(qdma,
 					    REG_CNTR_VAL((channel << 1) + 1));
-	u64 tx_packets = (cpu_tx_packets - port->cpu_tx_packets) +
-			 (fwd_tx_packets - port->fwd_tx_packets);
+	u64 tx_packets = (cpu_tx_packets - qdma->cpu_tx_packets) +
+			 (fwd_tx_packets - qdma->fwd_tx_packets);
 
 	_bstats_update(opt->stats.bstats, 0, tx_packets);
 
-	port->cpu_tx_packets = cpu_tx_packets;
-	port->fwd_tx_packets = fwd_tx_packets;
+	qdma->cpu_tx_packets = cpu_tx_packets;
+	qdma->fwd_tx_packets = fwd_tx_packets;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 34f1fef51640..3e93919a175c 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -533,6 +533,10 @@ struct airoha_qdma {
 	struct airoha_queue q_rx[AIROHA_NUM_RX_RING];
 
 	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
+
+	/* qos stats counters */
+	u64 cpu_tx_packets;
+	u64 fwd_tx_packets;
 };
 
 struct airoha_gdm_dev {
@@ -549,10 +553,6 @@ struct airoha_gdm_port {
 
 	struct airoha_hw_stats stats;
 
-	/* qos stats counters */
-	u64 cpu_tx_packets;
-	u64 fwd_tx_packets;
-
 	struct metadata_dst *dsa_meta[AIROHA_MAX_DSA_PORTS];
 };
 

-- 
2.54.0

