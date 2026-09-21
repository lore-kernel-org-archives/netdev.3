Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5EE517BC5;
	Mon, 21 Sep 2026 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790028037; cv=none; b=gB33gTYQiF9/psKeQvRLIYTyn2pqo+1UxH+fOe3yRa+TyVftdPJ+2SI0exhLq/JdbWc8V8TYeQCjqw+A7uMee7R6juH/vJowN6G6qG4z0u2+oFv8sv3aiszcnpgEzgRixetnt8ydNe8R9l0dI3raPpaGKsq2w+0q4zOL1eZsTps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790028037; c=relaxed/simple;
	bh=XweC/BmVghZObXd0oGdfwJcXunlAoagyj0XiejVWlmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MyvqTev98UwlQ49kfOf5ycgMFntATLZWDHzPPvaGrEHIMHwJtiy6N0lTnoCyYUOsfnpKoxP+4i3Uaho/tck7symUkw4+ezlb9mZe9PtW4y0IzeGrRqbPrYzM/1UQ1I8EalBOQTrVX7FFTtkc8hMm0bLHM3ZlTKtx+8Af7auL3Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=uEPc1U+R; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="uEPc1U+R"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 979E5C0087BC;
	Mon, 21 Sep 2026 15:00:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 979E5C0087BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790028029;
	bh=XweC/BmVghZObXd0oGdfwJcXunlAoagyj0XiejVWlmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uEPc1U+RRTkYJJCSepamm3PPceilbzVQY/IiOLwFA6kF9o46Om5WCFNEVOXy3SF60
	 OQT4ogxDj8gw8M/y7Df1x+uOlnAAraN17TrWkZp8FVzdJEeZ/gYuD+dKcNYfY5dbCv
	 wnwYwa2bGFctG+Eq8+/y4owh1MykkEGDht9+QjFs=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 734F9AE4;
	Mon, 21 Sep 2026 15:00:29 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
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
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 5/5] net: bcmgenet: mask DMA_TIMEOUT_MASK when reading DMA_RING0_TIMEOUT
Date: Mon, 21 Sep 2026 15:00:21 -0700
Message-Id: <20260921220021.281418-6-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921220021.281418-1-florian.fainelli@broadcom.com>
References: <20260921220021.281418-1-florian.fainelli@broadcom.com>
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
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index e9d9d3d7b636..ef3b750630d3 100644
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

