Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDAB52BE3C;
	Tue, 22 Sep 2026 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068250; cv=none; b=UhSFC6lEWtlIR43nwsW06OHsunraZWdTX9phGN2wgHFsw2MRlJZIWGXBX8XhQJAcBY9J95oO5WexfDCSdoC3zH7lr/ZfItT12yuFwx6QfbSM9I++PaKAhqB/ywNtXehgISv+/W+8iH5K8EjX8jZlBiMrKZ+q4nSQLM/6xAFuALE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068250; c=relaxed/simple;
	bh=wLd8oKJlv9vdf2+LjYIuX7r8V3Y/r1AbjHb2Ogw/+Lw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DEsKerVWNZcKtm6Srh8mLvCE2WQ82W9xhhx4J2/+KwgB1FygsyDoZgIRcosjOdiFFcyxsYO4SPS2nmcoR2jH77Xn+LGCcKpbbwgShgJ1P08rkSbj06QA13Wz4WRoxFsDSE53XcsD60JCWfBjIUQLJC4gpDlc5zOe609/mwLbTYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5s9xA3+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5s9xA3+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70C9EC2BCFF;
	Tue, 22 Sep 2026 09:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790068250;
	bh=wLd8oKJlv9vdf2+LjYIuX7r8V3Y/r1AbjHb2Ogw/+Lw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=A5s9xA3+HiK7qjRBRi+ptToZc0viqZ2Yb8img7ZY0h7cGIFhTzpaL7oHXtnKUkFI6
	 7fijYACLtqadg3zWdcnsjHOcbPTkSO+QUQAEqGZJk1uue+8Ck8YgsdIKP7zbt+njfV
	 SDb3h5F7jBukojY2ADFAl7z4Rx4ehjeMG7k1eV3p5B/31ODoHNticJmbxyAwiGngTe
	 /X7xA0qVa0tlBzyfmwheI+boO0lnAKvQs+mHm2pFsPEirrJ7OCFYjfa2PBz3P79Jzt
	 wGat3sCce/g9VUVjQuKlPgl8FGHOVi1ZnrffJRFfeN2/xUkZJkxMbC1bj1BlZVhfR/
	 BOIfPL/oQiEDA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D7DC98302;
	Tue, 22 Sep 2026 09:10:50 +0000 (UTC)
From: Kim Wooseok via B4 Relay <devnull+5mghybrid.khu.ac.kr@kernel.org>
Date: Tue, 22 Sep 2026 18:10:52 +0900
Subject: [PATCH net-next 4/4] net: macb: Clear SRTSM outside PTPv2 receive
 filters
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-codex-macb-hwtstamp-submit-v1-4-9d1abaa53296@khu.ac.kr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790068248; l=1561;
 i=5mghybrid@khu.ac.kr; s=kernel-20260913; h=from:subject:message-id;
 bh=JVParaFvYlI5ctrTvZ9cMHt5duuXvX87rDYRzFSFD6M=;
 b=yDHkKLNMdhwfr3PA1TyM75Ir9TcFgbgFsB/o4BCDOc8MqWYVha0PilBgnXwLJns4E73h94EX3
 +fjSqn/T49bCh9oXBIX5oEgOWeyZ0FngClcGGVDyamGc+VRMngrpppe
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

Assisted-by: GPT-6 Astra
Signed-off-by: Kim Wooseok <5mghybrid@khu.ac.kr>
---
 drivers/net/ethernet/cadence/macb_ptp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index 6376b6631..637d0da32 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -390,7 +390,7 @@ int gem_set_hwtst(struct net_device *netdev,
 		  struct kernel_hwtstamp_config *tstamp_config,
 		  struct netlink_ext_ack *extack)
 {
-	u32 ncr_mask = MACB_BIT(OSSMODE);
+	u32 ncr_mask = MACB_BIT(OSSMODE) | MACB_BIT(SRTSM);
 	enum macb_bd_control tx_bd_control = TSTAMP_DISABLED;
 	enum macb_bd_control rx_bd_control = TSTAMP_DISABLED;
 	int rx_filter = tstamp_config->rx_filter;
@@ -429,7 +429,6 @@ int gem_set_hwtst(struct net_device *netdev,
 	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
 		rx_bd_control = TSTAMP_ALL_PTP_FRAMES;
 		rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
-		ncr_mask |= MACB_BIT(SRTSM);
 		ncr_bits |= MACB_BIT(SRTSM);
 		break;
 	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:

-- 
2.53.0


