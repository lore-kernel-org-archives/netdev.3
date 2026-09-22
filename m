Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D16A52BE2F;
	Tue, 22 Sep 2026 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068250; cv=none; b=oM3b2OjT47kGow8hOIIkjKVjmg8PWgStKS0+OQEPv/GE5zweW+NCq3PzYxeAu9j+VSbrgYVgxg0BR6X0fbawTWzfOaoE0ArRZf9adKi26nFJRD54NAh7McU2XguBb9vTCu+OLP6qPstMFSOWaVn1TpMsmilnTVWT/d4nrkCTsk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068250; c=relaxed/simple;
	bh=MrNgRcDdpC2dVGAjP4fDmh16RT6zaRkGSIolJHIDVDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PlLrO3hf82z+2fe+D8FqCmVCiuESnc6pSyfLvDxs9G1vcl3kJyiUaFacUP/Q8GsyzIvG8tliI4MJC2e+axZhHIrclmtnfgskoFsPqm3QsTxBJge0Yp594WVPd5gvZ7Ckf1/+F9aLQPqC9BV2xhYnjEZ7QoWLevlMn/MxRGU1I9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzLiYovO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzLiYovO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66723C2BCB8;
	Tue, 22 Sep 2026 09:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790068250;
	bh=MrNgRcDdpC2dVGAjP4fDmh16RT6zaRkGSIolJHIDVDM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VzLiYovOipADl1rHpMTHpvQ7NNeZBMLMm+VJ9ddt+Z+iJLxVmHK3E6AEfWk1w+xXA
	 rigfGQapIOKUW9X3WktEcwGPmV/PEtxoWroN3AT5I+Y/Tkoppm8YWmTXjcwa84GHCB
	 QpvxqFdkMxRAwMpepjEoKcNUkiMco+54O4+8867arF9jXK2O9v5FrAiOWwJYz0Xa7O
	 I0ONsetjEwrCVCoHDHkfXS0zJ27r/PsGF0DIrCpNudayNT8i1q6q+qxmvT+2irfrAy
	 I/7TEbdyyRDNYA+pqAh577iY6lqdDetIFa092tL91gM2NhsD/fJVQhqA3xdAbeJgEK
	 9pysngSfhksBQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FDCC98305;
	Tue, 22 Sep 2026 09:10:50 +0000 (UTC)
From: Kim Wooseok via B4 Relay <devnull+5mghybrid.khu.ac.kr@kernel.org>
Date: Tue, 22 Sep 2026 18:10:51 +0900
Subject: [PATCH net-next 3/4] net: macb: Disable one-step mode when TX
 timestamping is off
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-codex-macb-hwtstamp-submit-v1-3-9d1abaa53296@khu.ac.kr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790068248; l=2010;
 i=5mghybrid@khu.ac.kr; s=kernel-20260913; h=from:subject:message-id;
 bh=AaQyUqH6VFPMs1/0x+Fd3W9TD7i8rMBiz5TU2m1yxnc=;
 b=IQurmeYA7DFWjdPRj7UfRJHg8TwEQJeTOEO1xUU+9bThz0nVwSi7KxOqUJzNwWxhb9H4P5PQi
 Wc04hm8+RtRBQmK/THGGcmYXqVBPDTHVPh0eO4DTVX4ecXJoxz2Vtj7
X-Developer-Key: i=5mghybrid@khu.ac.kr; a=ed25519;
 pk=1az/6lC8Tmd6BcvyarPc8FWoSxsV/WRr5NLs1v+kjlE=
X-Endpoint-Received: by B4 Relay for 5mghybrid@khu.ac.kr/kernel-20260913
 with auth_id=1028
X-Original-From: Kim Wooseok <5mghybrid@khu.ac.kr>
Reply-To: 5mghybrid@khu.ac.kr

From: Kim Wooseok <5mghybrid@khu.ac.kr>

Switching from HWTSTAMP_TX_ONESTEP_SYNC to HWTSTAMP_TX_OFF turns off
descriptor timestamping, but leaves NCR.OSSMODE set, so one-step mode
remains enabled.

Update OSSMODE for every accepted TX mode and set it only for
HWTSTAMP_TX_ONESTEP_SYNC. This also clears the previous one-step setting
when switching to OFF. Since the update mask now always includes
OSSMODE, drop the check for an empty mask.

Fixes: ab91f0a9b5f4 ("net: macb: Add hardware PTP support")
Assisted-by: GPT-6 Astra
Signed-off-by: Kim Wooseok <5mghybrid@khu.ac.kr>
---
 drivers/net/ethernet/cadence/macb_ptp.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index b6d17fef4..6376b6631 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -390,7 +390,7 @@ int gem_set_hwtst(struct net_device *netdev,
 		  struct kernel_hwtstamp_config *tstamp_config,
 		  struct netlink_ext_ack *extack)
 {
-	u32 ncr_mask = 0;
+	u32 ncr_mask = MACB_BIT(OSSMODE);
 	enum macb_bd_control tx_bd_control = TSTAMP_DISABLED;
 	enum macb_bd_control rx_bd_control = TSTAMP_DISABLED;
 	int rx_filter = tstamp_config->rx_filter;
@@ -409,7 +409,6 @@ int gem_set_hwtst(struct net_device *netdev,
 		ncr_bits |= MACB_BIT(OSSMODE);
 		fallthrough;
 	case HWTSTAMP_TX_ON:
-		ncr_mask |= MACB_BIT(OSSMODE);
 		tx_bd_control = TSTAMP_ALL_FRAMES;
 		break;
 	default:
@@ -445,11 +444,9 @@ int gem_set_hwtst(struct net_device *netdev,
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


