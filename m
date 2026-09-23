Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B213E5EF8;
	Wed, 23 Sep 2026 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154807; cv=none; b=PODTPuxzxFWW1jp1cH+U4ZJ9ZNmDACTgv9O2wZ1W8y6NbygnOVelduihnuU1nAJxhHCZQGtGIJEt+jfMKW3cDfdzJftTIbq2Ti/ekAmxf7N1H4nBuA6IMOOzWD+nwzW+ebhMaLWm6w62prBkKAIvEMhNWU/KdAMSJyciLRhc9yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154807; c=relaxed/simple;
	bh=JwH8Q6oNplj3Zfwo9tsLq5vZLEy4iiGulguAjUclFg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=stSxc63/Twb6E9O1PiEeWExWHVwpW0aWp8Rujdhk56Zykltuvs7rMenqvJ1gPQkBq7oz0HxmEcfQuQbze2WHU4mKWINc5sShfkRkU3pfjToU+RyxCurBBLUw4hebmkhgEqzgR7pqnUrPWm1WuzgdZ1sJ5DpDDCAnnTS36HwpmRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpcSnZj9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpcSnZj9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31925C2BCFB;
	Wed, 23 Sep 2026 09:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790154807;
	bh=JwH8Q6oNplj3Zfwo9tsLq5vZLEy4iiGulguAjUclFg8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NpcSnZj9eNfJKU00do051Va9MokLBQMMsLTelNH7RRQJrcqgXsqgRzHM90f9DOqsx
	 7rIUtcZCOQ42JkaynQZXO70UHL+lXbMfNjgvkawl1G4DC7YLVvQLE2pK2JuHyOCXra
	 aSDpnxLhLzQmqDPWefmBj1YlWONOCPy0HAQ9u+kJ4tGMslFNNoZEPj+XyRvHFh0shP
	 MbDn20Ai/4zJKMh1XgAzIiNbrCJ6plstYZtWMWyaHJDSoqBle9WnJXOKwamLdWXLP4
	 5F91WaDcLZo15lLUKiE8+YA6oCGya/drsMFzdmgoxh2pToxraxSfYL8rgGiNNC6sKx
	 PCDI8zs2YCTqQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C96C982FA;
	Wed, 23 Sep 2026 09:13:27 +0000 (UTC)
From: Kim Wooseok via B4 Relay <devnull+5mghybrid.khu.ac.kr@kernel.org>
Date: Wed, 23 Sep 2026 18:13:27 +0900
Subject: [PATCH net-next v2 3/3] net: macb: Clear SRTSM outside PTPv2
 receive filters
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-macb-hwtstamp-rework-v2-3-75c909b2676d@khu.ac.kr>
References: <20260923-macb-hwtstamp-rework-v2-0-75c909b2676d@khu.ac.kr>
In-Reply-To: <20260923-macb-hwtstamp-rework-v2-0-75c909b2676d@khu.ac.kr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790154804; l=2127;
 i=5mghybrid@khu.ac.kr; s=kernel-20260913; h=from:subject:message-id;
 bh=WiaT0nCaU15dA1T8GkP2fmhDBGDx/aNqNtDuGkweupA=;
 b=0N7PocSRbYgU05JIYfAPz0pnVoXtFrYkAN3zVWXha3BIC3O+1hbZZA4+qI4C8YWab9iOVP7j1
 YTZqNNYyCEkAoHtH8nPgJTcqrNTndP/jGaGOY1ELzsAnHZgiMKua6vE
X-Developer-Key: i=5mghybrid@khu.ac.kr; a=ed25519;
 pk=1az/6lC8Tmd6BcvyarPc8FWoSxsV/WRr5NLs1v+kjlE=
X-Endpoint-Received: by B4 Relay for 5mghybrid@khu.ac.kr/kernel-20260913
 with auth_id=1028
X-Original-From: Kim Wooseok <5mghybrid@khu.ac.kr>
Reply-To: 5mghybrid@khu.ac.kr

From: Kim Wooseok <5mghybrid@khu.ac.kr>

A PTPv2 receive filter sets NCR.SRTSM, but switching to NONE, ALL or a
PTPv1 filter leaves it set. As a result, selecting the same filter can
produce a different register setting depending on whether PTPv2 was
used before.

Update SRTSM whenever the RX filter changes, setting it only for PTPv2.
Switching away from PTPv2 then clears the old setting, so the bit follows
the currently selected filter.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
Tested-by: Nicolai Buchwitz <nb@tipi-net.de>
Assisted-by: GPT-6 Astra
Signed-off-by: Kim Wooseok <5mghybrid@khu.ac.kr>
---
 drivers/net/ethernet/cadence/macb_ptp.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index af2e36f81..2fd063394 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -394,8 +394,8 @@ int gem_set_hwtst(struct net_device *netdev,
 	enum macb_bd_control rx_bd_control = TSTAMP_DISABLED;
 	int rx_filter = tstamp_config->rx_filter;
 	struct macb *bp = netdev_priv(netdev);
+	u32 ncr_mask = MACB_BIT(SRTSM);
 	unsigned long flags;
-	u32 ncr_mask = 0;
 	u32 ncr_bits = 0;
 	u32 regval;
 
@@ -432,7 +432,6 @@ int gem_set_hwtst(struct net_device *netdev,
 	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
 		rx_bd_control = TSTAMP_ALL_PTP_FRAMES;
 		rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
-		ncr_mask |= MACB_BIT(SRTSM);
 		ncr_bits |= MACB_BIT(SRTSM);
 		break;
 	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
@@ -447,11 +446,9 @@ int gem_set_hwtst(struct net_device *netdev,
 	}
 
 	spin_lock_irqsave(&bp->lock, flags);
-	if (ncr_mask) {
-		regval = macb_readl(bp, NCR);
-		regval = (regval & ~ncr_mask) | ncr_bits;
-		macb_writel(bp, NCR, regval);
-	}
+	regval = macb_readl(bp, NCR);
+	regval = (regval & ~ncr_mask) | ncr_bits;
+	macb_writel(bp, NCR, regval);
 
 	gem_writel(bp, TXBDCTRL, GEM_BF(TXTSMODE, tx_bd_control));
 	gem_writel(bp, RXBDCTRL, GEM_BF(RXTSMODE, rx_bd_control));

-- 
2.53.0


