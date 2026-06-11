Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E549438239D
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 21:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781214983; cv=none; b=Vzw2T3XBD/UGDmHcR8+sehXq4Hv6npi6MYDlfXTyScf+KLrUhbXIzJyG2HlaLg51NLwD4vGFRZipb16IEZTldM3AZTGo24TO0U+51OplLy51Nr9IrYi9ND0B/C1znm1ifrtSv+pgKFEzek0yuouGLJbddLGNIsN3xRhl7bX0vMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781214983; c=relaxed/simple;
	bh=7u2PnTF6vRG4zqdOiVjkHbM5CmctF7HcEJ5rK+rVga8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kNZuW5M+Q/Lu77mSw6t79SQHrIBE7ay9FlzQBd7bgAOqvqCOxstcMoDEeHmkOCfUmiJcdAhniHYSMLCbPwu1H2x5urHUbicZqVdG4+U7d0o3DcNJCTtoYZ2SnSzoDEJNEoGbLiy1zJ3Z47Q1YUhelilmKwAJemYQC/ZqHMWTCTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTMU/tP7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTMU/tP7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DEE1F00A3D;
	Thu, 11 Jun 2026 21:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781214981;
	bh=rTEwU+X4CO3t0uj+sa+dX/WlP4z2O2FfvpMB35ZZWFs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lTMU/tP7ZM3u0j1bz4PFkWVibbRMYRL6JZAO8qnsfCunB7MI/mhfsV+ztCqR7LW0Z
	 XPGG3+LAnol7R+ek97CvGa7zeBxd45Obckt3m2hUWZDNWIz51/4DW3RckTMCTNQDvv
	 UNFqOnI51MurIwMwt7XeFzyxjjmyrfPXflEAjDGeecGVuxMNBTBphHq7iM+sb0UZVE
	 rr7jbq1YVIO8iXVvo2NoQ2Jvv6Kc3pJbNT1QP/7bt5bh82Z3RkP9pby+woN0B6LVbE
	 eY0FEFCKp0mx5oteFxOBSg2yJBpk8Tk7UqcIGUdlAqFUug1hIm9dqPtbIkpuQB0lZY
	 bGdVhsOjzk+ig==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 11 Jun 2026 23:55:52 +0200
Subject: [PATCH net-next v5 2/3] net: airoha: refactor QDMA start/stop into
 reusable helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-airoha-ethtool-priv_flags-v5-2-c11de08486d1@kernel.org>
References: <20260611-airoha-ethtool-priv_flags-v5-0-c11de08486d1@kernel.org>
In-Reply-To: <20260611-airoha-ethtool-priv_flags-v5-0-c11de08486d1@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Madhur Agrawal <madhur.agrawal@airoha.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
X-Mailer: b4 0.14.3

Factor out airoha_qdma_start() and airoha_qdma_stop() from
airoha_dev_open() and airoha_dev_stop(). These helpers will be reused
by the QDMA hot-migration logic introduced in the next patch to
dynamically switch GDM3/GDM4 ports between LAN and WAN QDMA blocks.
Add a DMA engine busy poll in airoha_qdma_stop() to wait for in-flight
DMA transfers to complete before cleaning up TX queues.

Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 53 ++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 9eb9b6a139b3..72ec6c888948 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1774,6 +1774,40 @@ static void airoha_update_hw_stats(struct airoha_gdm_dev *dev)
 	spin_unlock(&port->stats.lock);
 }
 
+static void airoha_qdma_start(struct airoha_qdma *qdma)
+{
+	airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
+			GLOBAL_CFG_TX_DMA_EN_MASK |
+			GLOBAL_CFG_RX_DMA_EN_MASK);
+	qdma->users++;
+}
+
+static void airoha_qdma_stop(struct airoha_qdma *qdma)
+{
+	u32 status;
+
+	if (--qdma->users)
+		return;
+
+	airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
+			  GLOBAL_CFG_TX_DMA_EN_MASK |
+			  GLOBAL_CFG_RX_DMA_EN_MASK);
+
+	if (read_poll_timeout(airoha_qdma_rr, status,
+			      !(status & (GLOBAL_CFG_TX_DMA_BUSY_MASK |
+					  GLOBAL_CFG_RX_DMA_BUSY_MASK)),
+			      USEC_PER_MSEC, 50 * USEC_PER_MSEC, true,
+			      qdma, REG_QDMA_GLOBAL_CFG))
+		dev_warn(qdma->eth->dev, "QDMA DMA engine busy timeout\n");
+
+	for (int i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
+		if (!qdma->q_tx[i].ndesc)
+			continue;
+
+		airoha_qdma_cleanup_tx_queue(&qdma->q_tx[i]);
+	}
+}
+
 static int airoha_dev_open(struct net_device *netdev)
 {
 	int err, len = ETH_HLEN + netdev->mtu + ETH_FCS_LEN;
@@ -1809,10 +1843,7 @@ static int airoha_dev_open(struct net_device *netdev)
 	}
 	port->users++;
 
-	airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
-			GLOBAL_CFG_TX_DMA_EN_MASK |
-			GLOBAL_CFG_RX_DMA_EN_MASK);
-	qdma->users++;
+	airoha_qdma_start(qdma);
 
 	if (!airoha_is_lan_gdm_dev(dev) &&
 	    airoha_ppe_is_enabled(qdma->eth, 1))
@@ -1865,19 +1896,7 @@ static int airoha_dev_stop(struct net_device *netdev)
 		airoha_set_gdm_port_fwd_cfg(qdma->eth,
 					    REG_GDM_FWD_CFG(port->id),
 					    FE_PSE_PORT_DROP);
-
-	if (!--qdma->users) {
-		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
-				  GLOBAL_CFG_TX_DMA_EN_MASK |
-				  GLOBAL_CFG_RX_DMA_EN_MASK);
-
-		for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
-			if (!qdma->q_tx[i].ndesc)
-				continue;
-
-			airoha_qdma_cleanup_tx_queue(&qdma->q_tx[i]);
-		}
-	}
+	airoha_qdma_stop(qdma);
 
 	return 0;
 }

-- 
2.54.0

