Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DE94B2055;
	Mon, 12 Oct 2026 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824294; cv=none; b=grUorCQRPUGPoxgOyiNnbwq3qiPC1zsDczn4XA/NCPvEaA1+FnzIYq7bEwxrpUwpAHb2RHtxsrY96E5kzlRiEou90YUIkLpWUvA/esqYyDjT62GAV4d7p9v4xY8MDrxHs3AiB+NzgpmDiB2chElU3xvl87ZVqLbTeyRYjtINz5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824294; c=relaxed/simple;
	bh=RbKEQ9Ao6sfM8uo8Xav6MW10A4+TnfLMYt6FY1stsN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ECxxF9YIyUTIaZCsUtmRm7wh47oqtGB0qKrvy9LJ3M2qt0Gt0Or37B7Atzd0CtJb27wWU/2QalWQXFvKoo6A5LdWhdI5q2I31vbwUQ3atHMQuF1dsE5IKeu3vAdjQv80yTbnaGHDZfAIwS1axidS3wsdDoo+J6dl4aFU966RQdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ljTh4B2z; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ljTh4B2z"
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id E28F4C0000E2;
	Mon, 12 Oct 2026 09:58:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com E28F4C0000E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1791824281;
	bh=RbKEQ9Ao6sfM8uo8Xav6MW10A4+TnfLMYt6FY1stsN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ljTh4B2z1rdjJRbLBSvxvosP7gSxtvi0gfOCulJMoFJSIvJCF5hrZCGfkaMyhih9p
	 KycwRFcw3KzQ5/+Hr29LVUY3A2z5EF4qtIfof7YnLDpCBhVSpJVCqvZWqfXn7ZBPw2
	 j3u1DUZfobhjjGkiE3lK+igDm5+FsA175tyEtvv4=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 9A54EAEA2;
	Mon, 12 Oct 2026 12:57:59 -0400 (EDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Justin Chen <justin.chen@broadcom.com>,
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
Subject: [PATCH net v3 2/6] net: bcmasp: unmap previous DMA mappings on TX map failure
Date: Mon, 12 Oct 2026 09:56:50 -0700
Message-Id: <20261012165654.3480668-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012165654.3480668-1-florian.fainelli@broadcom.com>
References: <20261012165654.3480668-1-florian.fainelli@broadcom.com>
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
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Reviewed-by: Justin Chen <justin.chen@broadcom.com>
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

