Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEEA529408;
	Tue, 22 Sep 2026 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068250; cv=none; b=S2bTdV8mQvzz+Ukqx2p9QMdcF5ZgAj24w0x6KFm3o1I9gPc0ETfqV5l0NwKCuTvsh7L63B9d33MWtcKls10o0+XJqvwK3GfGvBuliXRSZ/e6qmkhyz1efM3gNBM9eMwSBlJJQQlWDTSByNAMeZMbpXUfPavvsVkW+ZM+G1bJRpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068250; c=relaxed/simple;
	bh=9jriPDQBC/KTJgeJYQ3RuQgz+27ygu37cdClGVWR5n0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZZ6uWykmO/cUEB51JmTrvzWpDUT/zN0Y5aaVlHSKaVLEDOJkIzahjiAo91uy6ga3GDb8kv2DAObwpBpwC9eqxQzApClNNxNTL/Q5Br+ulUzc94mX0jyf1iB6ZpUUSCJXdXLoMrKtQ7Tknj7ndS9ZPVw4OiP7Z2yw1PPzasm0rHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+uK+Ej+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+uK+Ej+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4791EC2BCFA;
	Tue, 22 Sep 2026 09:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790068250;
	bh=9jriPDQBC/KTJgeJYQ3RuQgz+27ygu37cdClGVWR5n0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Q+uK+Ej+wf13RsTBRUSuxKeftLkcZoftEYbRAn7ang30Z6eFcmcW/4eIU+fKivNSX
	 IL6TVN9OVPa5AgSN/1GbHQG3TFiMCIrJnrObDTc45aD64Yc0FiMmkAm/Y70BYGcN4P
	 4y5rzqKSJ0kokr0+urCZ02olxUUDcr5nd3u3byHOq3qArHs2DMcoWy1C4pCG06cgsG
	 SrUIZKKgw6yYUAuduXQfYSGbruZbezHhiO/JHSjTuj9IERUzocnwhCzJy0IobVxuo6
	 WPM7Bk1nUX7zzBzc5krEibqHu2mSr6LVkIB55+4Gfea3zg/lOUNOoLmtqNJOgmtE+6
	 wVwLAQSaXjEcA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C10C982FA;
	Tue, 22 Sep 2026 09:10:50 +0000 (UTC)
From: Kim Wooseok via B4 Relay <devnull+5mghybrid.khu.ac.kr@kernel.org>
Date: Tue, 22 Sep 2026 18:10:49 +0900
Subject: [PATCH net-next 1/4] net: macb: Preserve timestamp settings on
 rejected requests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-codex-macb-hwtstamp-submit-v1-1-9d1abaa53296@khu.ac.kr>
References: <20260922-codex-macb-hwtstamp-submit-v1-0-9d1abaa53296@khu.ac.kr>
In-Reply-To: <20260922-codex-macb-hwtstamp-submit-v1-0-9d1abaa53296@khu.ac.kr>
To: netdev@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Rafal Ozieblo <rafalo@cadence.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>, linux-kernel@vger.kernel.org, 
 Kim Wooseok <5mghybrid@khu.ac.kr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790068248; l=4610;
 i=5mghybrid@khu.ac.kr; s=kernel-20260913; h=from:subject:message-id;
 bh=qRHnG5Rcj/5VZMQiLamET5Ab6WNIq7AKyvTVMs8H0xs=;
 b=CjCF8bM1TjeKCip+lzLWcqYxrNrO6PfxVq5s0Nu5yF/Nifi+Q2IGU7ZA2keh2RKnV5oKMdXJi
 j81mVGc7YiEBdwDvft8F/OrXgPpXpPUk3QGWl4pEvNTCuQJG7uTr9Fs
X-Developer-Key: i=5mghybrid@khu.ac.kr; a=ed25519;
 pk=1az/6lC8Tmd6BcvyarPc8FWoSxsV/WRr5NLs1v+kjlE=
X-Endpoint-Received: by B4 Relay for 5mghybrid@khu.ac.kr/kernel-20260913
 with auth_id=1028
X-Original-From: Kim Wooseok <5mghybrid@khu.ac.kr>
Reply-To: 5mghybrid@khu.ac.kr

From: Kim Wooseok <5mghybrid@khu.ac.kr>

gem_set_hwtst() can reject a request after changing the TX one-step
setting, because it programs the TX mode before checking the RX
filter. The call returns -ERANGE, but the hardware may no longer match
the cached configuration.

Validate both settings first and keep the adjusted RX filter local
until validation succeeds. Then apply the register settings and update
the configuration. A rejected request now leaves the hardware, the
caller's settings and the cached configuration unchanged.

Protect the NCR read-modify-write with bp->lock, keeping the descriptor
writes and cache update in the same section. With the register writes
now in the setter, remove gem_ptp_set_one_step_sync() and
gem_ptp_set_ts_mode().

Fixes: ab91f0a9b5f4 ("net: macb: Add hardware PTP support")
Assisted-by: GPT-6 Astra
Signed-off-by: Kim Wooseok <5mghybrid@khu.ac.kr>
---
 drivers/net/ethernet/cadence/macb_ptp.c | 61 ++++++++++++++-------------------
 1 file changed, 25 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index 14ae57fa0..4dbb6daa6 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -374,16 +374,6 @@ void gem_ptp_remove(struct net_device *netdev)
 		 GEM_PTP_TIMER_NAME);
 }
 
-static int gem_ptp_set_ts_mode(struct macb *bp,
-			       enum macb_bd_control tx_bd_control,
-			       enum macb_bd_control rx_bd_control)
-{
-	gem_writel(bp, TXBDCTRL, GEM_BF(TXTSMODE, tx_bd_control));
-	gem_writel(bp, RXBDCTRL, GEM_BF(RXTSMODE, rx_bd_control));
-
-	return 0;
-}
-
 int gem_get_hwtst(struct net_device *netdev,
 		  struct kernel_hwtstamp_config *tstamp_config)
 {
@@ -396,25 +386,17 @@ int gem_get_hwtst(struct net_device *netdev,
 	return 0;
 }
 
-static void gem_ptp_set_one_step_sync(struct macb *bp, u8 enable)
-{
-	u32 reg_val;
-
-	reg_val = macb_readl(bp, NCR);
-
-	if (enable)
-		macb_writel(bp, NCR, reg_val | MACB_BIT(OSSMODE));
-	else
-		macb_writel(bp, NCR, reg_val & ~MACB_BIT(OSSMODE));
-}
-
 int gem_set_hwtst(struct net_device *netdev,
 		  struct kernel_hwtstamp_config *tstamp_config,
 		  struct netlink_ext_ack *extack)
 {
+	u32 ncr_mask = 0;
 	enum macb_bd_control tx_bd_control = TSTAMP_DISABLED;
 	enum macb_bd_control rx_bd_control = TSTAMP_DISABLED;
+	int rx_filter = tstamp_config->rx_filter;
 	struct macb *bp = netdev_priv(netdev);
+	unsigned long flags;
+	u32 ncr_bits = 0;
 	u32 regval;
 
 	if (!macb_dma_ptp(bp))
@@ -424,18 +406,17 @@ int gem_set_hwtst(struct net_device *netdev,
 	case HWTSTAMP_TX_OFF:
 		break;
 	case HWTSTAMP_TX_ONESTEP_SYNC:
-		gem_ptp_set_one_step_sync(bp, 1);
-		tx_bd_control = TSTAMP_ALL_FRAMES;
-		break;
+		ncr_bits |= MACB_BIT(OSSMODE);
+		fallthrough;
 	case HWTSTAMP_TX_ON:
-		gem_ptp_set_one_step_sync(bp, 0);
+		ncr_mask |= MACB_BIT(OSSMODE);
 		tx_bd_control = TSTAMP_ALL_FRAMES;
 		break;
 	default:
 		return -ERANGE;
 	}
 
-	switch (tstamp_config->rx_filter) {
+	switch (rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		break;
 	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
@@ -451,25 +432,33 @@ int gem_set_hwtst(struct net_device *netdev,
 	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
 	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
 	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
-		rx_bd_control =  TSTAMP_ALL_PTP_FRAMES;
-		tstamp_config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
-		regval = macb_readl(bp, NCR);
-		macb_writel(bp, NCR, (regval | MACB_BIT(SRTSM)));
+		rx_bd_control = TSTAMP_ALL_PTP_FRAMES;
+		rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
+		ncr_mask |= MACB_BIT(SRTSM);
+		ncr_bits |= MACB_BIT(SRTSM);
 		break;
 	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
 	case HWTSTAMP_FILTER_ALL:
 		rx_bd_control = TSTAMP_ALL_FRAMES;
-		tstamp_config->rx_filter = HWTSTAMP_FILTER_ALL;
+		rx_filter = HWTSTAMP_FILTER_ALL;
 		break;
 	default:
-		tstamp_config->rx_filter = HWTSTAMP_FILTER_NONE;
 		return -ERANGE;
 	}
 
-	bp->tstamp_config = *tstamp_config;
+	spin_lock_irqsave(&bp->lock, flags);
+	if (ncr_mask) {
+		regval = macb_readl(bp, NCR);
+		regval = (regval & ~ncr_mask) | ncr_bits;
+		macb_writel(bp, NCR, regval);
+	}
 
-	if (gem_ptp_set_ts_mode(bp, tx_bd_control, rx_bd_control) != 0)
-		return -ERANGE;
+	gem_writel(bp, TXBDCTRL, GEM_BF(TXTSMODE, tx_bd_control));
+	gem_writel(bp, RXBDCTRL, GEM_BF(RXTSMODE, rx_bd_control));
+
+	tstamp_config->rx_filter = rx_filter;
+	bp->tstamp_config = *tstamp_config;
+	spin_unlock_irqrestore(&bp->lock, flags);
 
 	return 0;
 }

-- 
2.53.0


