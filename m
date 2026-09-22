Received: from relay.smtp-ext.broadcom.com (lpdvsmtp12.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6D155C317;
	Tue, 22 Sep 2026 22:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790115441; cv=none; b=LaWjXWlHdcRBBunZ6I3AmR9JVMaiBqqG9teE9PqGVfZDNC2P2EPV+DEiP5SEKykWDQJWA1hl+mA60lSxTnDa+HSQ9HikYAjsfF7bJBUClP33Gw9wbipwn6EelICRsomJGOC4cc0vBmNuX+XSq7zSDlgcyHkma2pV1mbVzleZBsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790115441; c=relaxed/simple;
	bh=X6uhqZzRl13IiMTwrMERqP27MbFj0vKF0qTTgO945wI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KyqA7LjzykG+gKJJYFej/gw8L2nTdHPLWCQo3YYshIqEg9iEMR1dbTHY5DCbcikNfChMbBEHv31M/16+Rr7jwy5Lv774JMUAp7/+ay8lpoGqwoQgyzZ6dWSWjftto/gt+YKScy4Ga5LtvdWFWsrLs5ttlTwROrGgK5VujKm3NDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=g8lx9M8a; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g8lx9M8a"
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id D0998C0003CB;
	Tue, 22 Sep 2026 15:17:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com D0998C0003CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790115428;
	bh=X6uhqZzRl13IiMTwrMERqP27MbFj0vKF0qTTgO945wI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g8lx9M8amlgSH1kOSUe3cEh4woxN4kXQJCDu1fkis51gi0e2u9eZbC/QiKTu0y8Ik
	 5yjgcGf9OBD6X7g7RMGULCQJEDatGTD4pxKU6IdMxX+9NIboiBCypckjh1DpABKFyt
	 xUnPwhJSha9xcw+e2XBoE0uM/YrGbMNsRRBLoIpA=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id C0C10AEA2;
	Tue, 22 Sep 2026 18:17:07 -0400 (EDT)
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
Subject: [PATCH net 2/6] net: bcmasp: unmap previous DMA mappings on TX map failure
Date: Tue, 22 Sep 2026 15:16:26 -0700
Message-Id: <20260922221630.3864427-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922221630.3864427-1-florian.fainelli@broadcom.com>
References: <20260922221630.3864427-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When mapping an skb with fragments for transmission in bcmasp_xmit(),
if mapping fails on fragment i > 0, the error handler calls
bcmasp_clean_txcb() for previous iterations j < i. However,
bcmasp_clean_txcb() only zeroes the control block fields without
unmapping the DMA buffers, leaking the DMA mappings allocated for the
head and earlier fragments.

Call dma_unmap_single() before calling bcmasp_clean_txcb() in the error
cleanup loop.

Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
Assisted-by: LLM
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index f2176ef3a127..9ad5a982542f 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -285,6 +285,11 @@ static netdev_tx_t bcmasp_xmit(struct sk_buff *skb, struct net_device *dev)
 			intf->mib.tx_dma_failed++;
 			spb_index = intf->tx_spb_index;
 			for (j = 0; j < i; j++) {
+				txcb = &intf->tx_cbs[spb_index];
+				dma_unmap_single(kdev,
+						 dma_unmap_addr(txcb, dma_addr),
+						 dma_unmap_len(txcb, dma_len),
+						 DMA_TO_DEVICE);
 				bcmasp_clean_txcb(intf, spb_index);
 				spb_index = incr_ring(spb_index,
 						      DESC_RING_COUNT);
-- 
2.34.1

