Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D91F4BF941;
	Tue, 22 Sep 2026 23:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790119494; cv=none; b=E/Y55CFZW3j8KuswRUIEJMhEQZRwAeJayciUqMTuVs1/59SJHVf3mKJb0996/DPnZ3+IyvWIDIG5R1q3dzjl5oULxyRMtRXKAz0tVo+QEjkYkRHpO6D69ac5SohrZfBqoDbimxaFxl2DQYRMc3TdeuAdXE0BqT2rZsIBf52u2MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790119494; c=relaxed/simple;
	bh=Q9Uvwal5oeAw4P/DGhgTKnbhdEJzOdSgbIx8POc2X7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fLJh0VxkF9quf59SklwHyeKea8hLANOgmw+pDjYUKSiqn28E8Q1ZZFA9idYJLDUGFaX2C0c7p7z1z3yz0/0emQAKHogu9H8GfUhk+mtoRK+ve29E/57MX27ozMVE9tCn14iSXPTYBexK5Ww5d3Np0DXNq+4evEPWPvkV9q48Yxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cf7jBIBG; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cf7jBIBG"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id C8091C0000DE;
	Tue, 22 Sep 2026 16:24:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com C8091C0000DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790119485;
	bh=Q9Uvwal5oeAw4P/DGhgTKnbhdEJzOdSgbIx8POc2X7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cf7jBIBG611cCA5T79D6nMZRZd5W+k6nz9AjqUgn9E+w2Fs+nNi/K/GmJdVq/aBmw
	 9sVX9u3q028NAqCt+pHs4Fy9swXqAu8nFIKRWFbGEC0v9xnVPMxunU8+41YZSHSkt7
	 FELw8X41f2ba1GkCrjGJoyWuh4crU+PbcLSU94oA=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id A1978B06;
	Tue, 22 Sep 2026 16:24:45 -0700 (PDT)
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
Subject: [PATCH net v2 03/10] net: systemport: Fix NULL pointer dereference in bcm_sysport_fini_rx_ring()
Date: Tue, 22 Sep 2026 16:24:33 -0700
Message-Id: <20260922232440.598918-4-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922232440.598918-1-florian.fainelli@broadcom.com>
References: <20260922232440.598918-1-florian.fainelli@broadcom.com>
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
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
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

