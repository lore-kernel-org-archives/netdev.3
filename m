Received: from relay.smtp-ext.broadcom.com (lpdvsmtp11.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20D73033F8;
	Fri, 18 Sep 2026 00:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789690577; cv=none; b=dYNI2NHSV2xVOG8wD9MCudDLHQnAfALDd+MznaBAVtk6wFz+qln/mO3JHlsRlIuHFdZTOnhfpDp7BRhEWMaW9TnrJ5R3P56LzURCCagBTYbnabNMGLIBF2ukedwBjRLqCUpwyWZXDlni0PpOkwc56hIPMwZHQYadiC2iAXY2yIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789690577; c=relaxed/simple;
	bh=GYEVI+ehrYqNt7UQM6z/nu5gGYKb1eYV2VPn0Ei3W8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NQFzp3D9IXvDXfyY7SqIr2i0FNzfGXtuSMcVyTscTa3BYWuo6xSItpBgKWey+Vw4IYgxiKwv4trj3DjU4PNl/4rS6klXCTN8eo9NM6JtyGNSB/KsfKRn+JTZNU+xVBO4P3fG3gCzVN2jqvAi4nfLS243gtyt968MjJnwwq7bAwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KzLpGpg5; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KzLpGpg5"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 4008AC0C3BC9;
	Thu, 17 Sep 2026 17:07:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 4008AC0C3BC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1789690061;
	bh=GYEVI+ehrYqNt7UQM6z/nu5gGYKb1eYV2VPn0Ei3W8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KzLpGpg5U3B59Fy+jisXxb6UZpbpOUCjSU/ZuotpUW9uskOqHD9kjllWOR2Bde72q
	 aj8qB1kVqodwV1QRKgykVYraObLT/19ibcHT/EHEeuqXFuuURUCyJyrFVcwT08pD6W
	 pdKWUiGhl48N1hu/G5Fo35EWSWwqFhO5aYiC/oiI=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 17B6AACC;
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
Subject: [PATCH net 4/8] net: bcmgenet: clean up RX NAPI on bcmgenet_init_rx_queues failure
Date: Thu, 17 Sep 2026 17:07:28 -0700
Message-Id: <20260918000732.276506-5-florian.fainelli@broadcom.com>
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

bcmgenet_init_rx_ring() registers a NAPI instance for each RX ring via
netif_napi_add(). If bcmgenet_init_rx_queues() fails while initializing
subsequent rings, bcmgenet_init_dma() frees the RX buffers and page pools
but fails to clean up already registered NAPI instances with
bcmgenet_fini_rx_napi(). This leaves stale NAPI structs on the net_device
napi_list.

Call bcmgenet_fini_rx_napi() in the error handling path of
bcmgenet_init_dma() when bcmgenet_init_rx_queues() fails.

Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
Assisted-by: LLM
Co-authored-by: Cursor <cursoragent@cursor.com>
Change-Id: I45982e0e198a44f3f56b1300f462870462b81108
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index bfb74dca55d6..ef155a170fa6 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3167,6 +3167,7 @@ static int bcmgenet_init_dma(struct bcmgenet_priv *priv, bool flush_rx)
 	ret = bcmgenet_init_rx_queues(priv->dev);
 	if (ret) {
 		netdev_err(priv->dev, "failed to initialize Rx queues\n");
+		bcmgenet_fini_rx_napi(priv);
 		bcmgenet_free_rx_buffers(priv);
 		bcmgenet_destroy_rx_page_pools(priv);
 		kfree(priv->rx_cbs);
-- 
2.34.1

