Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54117477999;
	Wed, 23 Sep 2026 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154807; cv=none; b=Xz6nKe1rR8jXYptLeRpTdj9FAjacJh1gnMtjUKh5jI7HDdKy/qcbsLq04J+BSUl+8o7UGW9F9SDZj519fuFLcYiSha5VAWmPjkgkXZI5JoVO2N2iQc96TwyB4dR8QAeBseYpnj1YOzGfqUytQ/+x1FUJ5HLRQpbplmW6agDqpXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154807; c=relaxed/simple;
	bh=qZY2QgNR0DDCBmL7/agNFQ+cU8n1KDmdfs730MvyFjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FHBoTlZRGUGzO53AZY58HyvhcV9pEb/p1roLsO3v9VsDR9IpIe4oLX0fZsbceI+YW74HwsYZkmIvzN7P+w5A9tnhdy20vd8rmO7mZZQSLvTyjgfJ7heRc9VV6KuIIMiE1PjOAhZyIrB8Nq5he2LeGppcGX654ZUTFKB6p0l668o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxsEG+1J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxsEG+1J"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19A88C2BCFC;
	Wed, 23 Sep 2026 09:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790154807;
	bh=qZY2QgNR0DDCBmL7/agNFQ+cU8n1KDmdfs730MvyFjw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bxsEG+1J9vHN0d+csNbr0GPTQpIMMvWU8WpG0mrU0BALplg5wm+feSoBrJGdtUVh6
	 3d696PKClsZpZU2XqZRsx6tGjVRYx548Dbzs01PeVk08VVSaVyaMy6eBSfy3gsIi64
	 GwBLPLV/bq5eIG5/dCiRBX8OXhaioh/UBF7BPerqhT+7R7GnDqKSALJIivxr+/O0nB
	 iEpuTnpOqqrezXY4tVMu/UejqqLEmui0MyP5bMMRawZkiXuuzLTKVYSLH921iQUTYb
	 oPjlKIuQ0uAbn0mixUvZDNe/dsvbc/sLBM1XmWQMi+LhqZPa+oFhmdw1SooVjcuJ+R
	 JETNt67nO7WhA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3255C98309;
	Wed, 23 Sep 2026 09:13:26 +0000 (UTC)
From: Kim Wooseok via B4 Relay <devnull+5mghybrid.khu.ac.kr@kernel.org>
Date: Wed, 23 Sep 2026 18:13:26 +0900
Subject: [PATCH net-next v2 2/3] net: macb: Enable RX timestamping for
 specific PTPv1 filters
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-macb-hwtstamp-rework-v2-2-75c909b2676d@khu.ac.kr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790154804; l=1851;
 i=5mghybrid@khu.ac.kr; s=kernel-20260913; h=from:subject:message-id;
 bh=6FGYgmpXIFqBwfciSCD9Dq6gBdcnn4TCfNguIzs3JV0=;
 b=oL/mBViDgcttRMU7A2keEjBUTtZ0Qizg4L59MbiZILPop9TKSS/n9jMQnA7s46+g9OV1uxKgZ
 KZHydXlHXtAB28YV1HayygLMbA9NSepjkpOUM0qIfre0BRQ50lOF3m3
X-Developer-Key: i=5mghybrid@khu.ac.kr; a=ed25519;
 pk=1az/6lC8Tmd6BcvyarPc8FWoSxsV/WRr5NLs1v+kjlE=
X-Endpoint-Received: by B4 Relay for 5mghybrid@khu.ac.kr/kernel-20260913
 with auth_id=1028
X-Original-From: Kim Wooseok <5mghybrid@khu.ac.kr>
Reply-To: 5mghybrid@khu.ac.kr

From: Kim Wooseok <5mghybrid@khu.ac.kr>

Selecting a PTPv1 Sync or Delay_Req filter in gem_set_hwtst() returns
success, but leaves rx_bd_control at its initial value of
TSTAMP_DISABLED. The requested filter therefore appears to have been
applied, even though received packets have no hardware timestamps.

The PTPv1 event case already enables timestamping for all frames, so
use that path for Sync and Delay_Req as well. This enables timestamping
for both requests and returns HWTSTAMP_FILTER_ALL to tell the caller
which filter was actually applied.

Fixes: ab91f0a9b5f4 ("net: macb: Add hardware PTP support")
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
Tested-by: Nicolai Buchwitz <nb@tipi-net.de>
Assisted-by: GPT-6 Astra
Signed-off-by: Kim Wooseok <5mghybrid@khu.ac.kr>
---
 drivers/net/ethernet/cadence/macb_ptp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index 02face93a..af2e36f81 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -421,10 +421,6 @@ int gem_set_hwtst(struct net_device *netdev,
 	switch (rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		break;
-	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
-		break;
-	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
-		break;
 	case HWTSTAMP_FILTER_PTP_V2_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
@@ -439,6 +435,8 @@ int gem_set_hwtst(struct net_device *netdev,
 		ncr_mask |= MACB_BIT(SRTSM);
 		ncr_bits |= MACB_BIT(SRTSM);
 		break;
+	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
 	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
 	case HWTSTAMP_FILTER_ALL:
 		rx_bd_control = TSTAMP_ALL_FRAMES;

-- 
2.53.0


