Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800104D17A0;
	Mon, 21 Sep 2026 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790028036; cv=none; b=ZQkHOVfAhKA6R+j7H53dh6J75YCLktoqNLLZB+psHGGhqmY/s+Hwre7ozTYPlvabSHKG7KKBRTGsMhofEBTdbAu52DNqQdH3UWMSsfzGVbfTjYdu6uI8l/VMdZAGKs2eXm/FGWma5QGz6IXKoJpKW8pkMrzjdJv0vsCBuYJ0M9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790028036; c=relaxed/simple;
	bh=r48EioDs19eebRcriYekwzaNA1SAs1pTGEiMHxnRjHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jdH3VxDv3XZzhgh54IhmULgOy5RF0CgVtQpltY69r2wjjjGOdwr3WJnLUGhfTEyrjgDfG6GviD0PTgngLphQ69jvRrTHH0rXZfBgPa8pQ/ZjBoDva+rUYNmEHq0wkXe+Bx8TxjkIQ1y4cl5cOP/ShA+FcpoBkeVIXccX763yo8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=s+P+vgeu; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="s+P+vgeu"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 17DC2C0087BA;
	Mon, 21 Sep 2026 15:00:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 17DC2C0087BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790028029;
	bh=r48EioDs19eebRcriYekwzaNA1SAs1pTGEiMHxnRjHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s+P+vgeu1BhDy5vkcjin3Osd/3Rswf+sjqbTqpkM+0Sq/DcJnM9hZDwNh5ufzUlSv
	 slP/6uzsEx9sxNP2G15Uafom2m0ijYPCDHFhJVUr8BTnNZGimtlhFYbZ/OBAjSuPhY
	 W+yjobBFHbNuQJ9MvU8IL0NfpDgkKKrbMhD1/pO8=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id E49F0AE4;
	Mon, 21 Sep 2026 15:00:28 -0700 (PDT)
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
Subject: [PATCH net v2 2/5] net: bcmgenet: initialize u64 stats seq counter for all queues
Date: Mon, 21 Sep 2026 15:00:18 -0700
Message-Id: <20260921220021.281418-3-florian.fainelli@broadcom.com>
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

bcmgenet_gstrings_stats statically defines ethtool statistics for queues
0 through GENET_MAX_MQ_CNT (4). However, bcmgenet_probe() only initialized
the u64_stats_sync seq counter up to priv->hw_params->rx_queues and
priv->hw_params->tx_queues.

Since priv->hw_params->rx_queues is 0 across all hardware versions (and
priv->hw_params->tx_queues is 0 on GENET V1), rings 1..4 have uninitialized
u64_stats_sync structures. When ethtool -S is run on 32-bit kernels,
bcmgenet_get_ethtool_stats() reads stats from rx_rings[1..4], causing
lockdep warnings due to the uninitialized sequence counters.

Initialize the sequence counters for all GENET_MAX_MQ_CNT + 1 queues.

Fixes: ffc2c8c4a714 ("net: bcmgenet: Initialize u64 stats seq counter")
Assisted-by: LLM
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 7b089de9484e..055e1362173b 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -4134,10 +4134,10 @@ static int bcmgenet_probe(struct platform_device *pdev)
 		priv->rx_rings[i].rx_max_coalesced_frames = 1;
 
 	/* Initialize u64 stats seq counter for 32bit machines */
-	for (i = 0; i <= priv->hw_params->rx_queues; i++)
+	for (i = 0; i <= GENET_MAX_MQ_CNT; i++) {
 		u64_stats_init(&priv->rx_rings[i].stats64.syncp);
-	for (i = 0; i <= priv->hw_params->tx_queues; i++)
 		u64_stats_init(&priv->tx_rings[i].stats64.syncp);
+	}
 
 	/* libphy will determine the link state */
 	netif_carrier_off(dev);
-- 
2.34.1

