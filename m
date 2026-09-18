Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C252D838E;
	Fri, 18 Sep 2026 00:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789690460; cv=none; b=Z3PnCxB3mBu9gIvZd1fTGY1w0JQ4uN7PZFITsgMwlcoGRrJtA1hFtV/c+yAeLoa4dLPsGAJ2mUr0uw83/hicwXJ2JnoM3rOnHsVxyMzNt2aMPMcYjjjT9JQZ2bmbOVwNbrJLXdDv6QdItsdhcYSFHmk+XC1jxrNkszgaHkJxOmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789690460; c=relaxed/simple;
	bh=83IJ8uN/nSOv6r7n2z2yUoVNcx23uvnf9jKFDRwgObI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OQK+xZbcU5Y5b/JhI7tAuvOahIi/lDYD1GvguU0uSwO6MwVNWvOSDdQt/EjX/J9DKe6/VjAGCCwR34x825i2m0n3MidYyo6YLsDf1HDf1OiHus+KQCSnhuotumSl30u0WG9w2EV0zf/2313OHBaoGJpTwEbg2PYvyxUNS5sP4DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eb56561R; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eb56561R"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 40877C0000F9;
	Thu, 17 Sep 2026 17:07:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 40877C0000F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1789690062;
	bh=83IJ8uN/nSOv6r7n2z2yUoVNcx23uvnf9jKFDRwgObI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eb56561ROYvrPrZldUvgRPZd4OKcmhVaajS5T/ihr1kWdbUW972M9IgXZH0t2Tssb
	 CoDBw5yyvwMCj/KvnAClXxWo3gBJvSUvD/uEJ3vTT8rs2qL7a6HVpaRuGZ/x56hQEe
	 4bhBiu1mrmU/CqgF5wfKdtOsvlNkDH+6J1AKQpGA=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id D5929AD9;
	Thu, 17 Sep 2026 17:07:41 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Cursor <cursoragent@cursor.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zak Kemble <zakkemble@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Ryo Takakura <ryotkkr98@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net 8/8] net: bcmgenet: mask DMA_TIMEOUT_MASK when reading DMA_RING0_TIMEOUT
Date: Thu, 17 Sep 2026 17:07:32 -0700
Message-Id: <20260918000732.276506-9-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918000732.276506-1-florian.fainelli@broadcom.com>
References: <20260918000732.276506-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bcmgenet_get_coalesce() reads DMA_RING0_TIMEOUT to calculate
rx_coalesce_usecs without masking out bits outside DMA_TIMEOUT_MASK
(16 bits). If upper bits are non-zero or contain status/flags, the
computed value of rx_coalesce_usecs returned to userspace via ethtool
becomes corrupted.

Mask the register read with DMA_TIMEOUT_MASK before computing the
timeout in microseconds.

Fixes: 4a29645bfe6c ("net: bcmgenet: Implement RX coalescing control knobs")
Assisted-by: LLM
Co-authored-by: Cursor <cursoragent@cursor.com>
Change-Id: I4c5b5019e764dbd0c7e51bd8c7365939a4736e44
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 3a6a2f075959..b15e64a484b4 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -852,7 +852,8 @@ static int bcmgenet_get_coalesce(struct net_device *dev,
 	ec->rx_max_coalesced_frames =
 		bcmgenet_rdma_ring_readl(priv, 0, DMA_MBUF_DONE_THRESH);
 	ec->rx_coalesce_usecs =
-		bcmgenet_rdma_readl(priv, DMA_RING0_TIMEOUT) * 8192 / 1000;
+		(bcmgenet_rdma_readl(priv, DMA_RING0_TIMEOUT) &
+		 DMA_TIMEOUT_MASK) * 8192 / 1000;
 
 	for (i = 0; i <= priv->hw_params->rx_queues; i++) {
 		ring = &priv->rx_rings[i];
-- 
2.34.1

