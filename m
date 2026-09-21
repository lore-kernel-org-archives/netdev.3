Received: from relay.smtp-ext.broadcom.com (lpdvsmtp12.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8423C0A0D;
	Mon, 21 Sep 2026 23:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032475; cv=none; b=heiQrM1lCQ8VQASsTHwxztje+PyhYPyjppW8BqBm3Shy8HEqEH3hEZZvexC3Lor9eogJsJj1nweIITiVVsly0aC41z41OjWx4CJSwX/lCms0/SwROYPW3oz5m9VXY7V052z/Y65vu/2sJ8PKvFRnbnrxQy71yf6D5Acr8ANFKWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032475; c=relaxed/simple;
	bh=UgYl0YhYKb1VNKwc8fIa8T3s/cHk5WBvHPIRzAH/X+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OUfdiOIzyBR45Xn0i0dpOb/7k+z6zmFry0esNXrFRlu0PTfOEWb8BAHecCTbuVlY+h42fzWLlyiwXo76pFAHQBYozUX0U5rVVMD1HfQ/mnioVvSUqr6qUnq9kdfKhEr5UFXISOmdKeTAITuPZ6+s94YhiohYEZlAYvFAwRqfZRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IPc86kmk; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IPc86kmk"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 0219FC0000E7;
	Mon, 21 Sep 2026 16:14:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 0219FC0000E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790032473;
	bh=UgYl0YhYKb1VNKwc8fIa8T3s/cHk5WBvHPIRzAH/X+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IPc86kmkq9kSO/cdT1u1m3f7Y84UePSbV9uf3L3PnfD/aSqexEe/WwVFv1hRgDwpI
	 xlrt9C08JXE3q22frGLX+QUiu/HdhGLr8soyt3SrW6YzlIKSG6MGKsjDuwybiU91HQ
	 8NntI7VCSckymwiVBZnRaHYjJguwATlbGWQeLOVY=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 9D6E8ACC;
	Mon, 21 Sep 2026 16:14:32 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
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
Subject: [PATCH net 03/12] net: systemport: Fix NULL pointer dereference in bcm_sysport_fini_rx_ring()
Date: Mon, 21 Sep 2026 16:12:56 -0700
Message-Id: <20260921231305.394773-4-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921231305.394773-1-florian.fainelli@broadcom.com>
References: <20260921231305.394773-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If allocation of priv->rx_cbs fails during bcm_sysport_init_rx_ring(),
error unwinding in bcm_sysport_open() calls bcm_sysport_fini_rx_ring().
Without checking if priv->rx_cbs is non-NULL, bcm_sysport_fini_rx_ring()
dereferences priv->rx_cbs, resulting in a NULL pointer dereference.

Add a check for !priv->rx_cbs at the beginning of
bcm_sysport_fini_rx_ring(), matching bcm_sysport_fini_tx_ring().

Fixes: 80105befdb4b ("net: systemport: add Broadcom SYSTEMPORT Ethernet MAC driver")
Assisted-by: LLM
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 8328fe824d15..b91a57540f55 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -1717,6 +1717,9 @@ static void bcm_sysport_fini_rx_ring(struct bcm_sysport_priv *priv)
 	if (!(reg & RDMA_DISABLED))
 		netdev_warn(priv->netdev, "RDMA not stopped!\n");
 
+	if (!priv->rx_cbs)
+		return;
+
 	for (i = 0; i < priv->num_rx_bds; i++) {
 		cb = &priv->rx_cbs[i];
 		if (dma_unmap_addr(cb, dma_addr))
-- 
2.34.1

