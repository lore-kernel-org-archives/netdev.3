Received: from relay.smtp-ext.broadcom.com (lpdvsmtp12.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D4F4D9F7E;
	Tue, 22 Sep 2026 22:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790115444; cv=none; b=PENhIQGShhcQxDn9N0a4I6nmp9pLf4RWW43AzDhxwOsRBc3FF85gUJSicD+02/MM3r76NC21zJa4B/izqt6O6VmT36v2K4Ew0EOOqBeiyQHMcE3t4tX4Wy2dgqqzOueVD4pcCO7KgdZO5OkAjlnH4yQ+GBWH07/eBUDtZzqAQzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790115444; c=relaxed/simple;
	bh=DEd0waVIprXhh5yorRxRzU10ExFfSwXWNXxHuHIukcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qk1znXu86wYOohmBLQUuPsUMyYur1/2WnIkLXDDWkyxCB6mvleWCJvJSCfcHOQ7bktVEc4hAia2yTg4Auh6FRYQCZY/UMlpNehRO9Z4AkEq192YxXuF/yiz4Il4AMAV8e5xN7rSCxGV1K63HiA9ANwQH+ET+MXJX0oQJt5WFTVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eiF+iDAn; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eiF+iDAn"
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 763D8C0003CC;
	Tue, 22 Sep 2026 15:17:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 763D8C0003CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790115432;
	bh=DEd0waVIprXhh5yorRxRzU10ExFfSwXWNXxHuHIukcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eiF+iDAnSiyVA3V28NVeJKQxOG+1QzYqiDU+Tefy/wSOc+eNoGC1l/+epAkUPhKk2
	 weMIxwiAi+majb/brPxyN17g7/JmL/WDbfB6XUx8p/+iUPlnD9qND/xhk8AolJXDKo
	 NnBIKR6a4GBrbSQhWORnA+Ruis/oGEPRnDa8hnpI=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 659C7AEA3;
	Tue, 22 Sep 2026 18:17:11 -0400 (EDT)
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
Subject: [PATCH net 5/6] net: bcmasp: account for offload header in TX short packet padding
Date: Tue, 22 Sep 2026 15:16:29 -0700
Message-Id: <20260922221630.3864427-6-florian.fainelli@broadcom.com>
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

When hardware checksum offload is enabled for an skb,
bcmasp_csum_offload() prepends a struct bcmasp_pkt_offload header
(20 bytes) to the skb via skb_push(). This increases skb->len and
skb_headlen(skb) by sizeof(struct bcmasp_pkt_offload).

Because the hardware descriptor processor strips this offload header
before transmitting the packet on the wire, the wire packet length is
smaller by sizeof(struct bcmasp_pkt_offload). The padding calculation
did not account for this extra header, causing short frames to skip
padding and be sent on the wire smaller than the minimum Ethernet frame
size (ETH_ZLEN + ETH_FCS_LEN).

Add sizeof(struct bcmasp_pkt_offload) to the minimum padding threshold
when hardware checksum offload is enabled.

Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
Assisted-by: LLM
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index 7a63a592f158..3370cbf1b395 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -236,7 +236,7 @@ static struct sk_buff *bcmasp_csum_offload(struct net_device *dev,
 static netdev_tx_t bcmasp_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct bcmasp_intf *intf = netdev_priv(dev);
-	unsigned int total_bytes, size;
+	unsigned int total_bytes, size, min_size;
 	int spb_index, nr_frags, i, j;
 	struct bcmasp_tx_cb *txcb;
 	dma_addr_t mapping, valid;
@@ -267,8 +267,12 @@ static netdev_tx_t bcmasp_xmit(struct sk_buff *skb, struct net_device *dev)
 	for (i = 0; i <= nr_frags; i++) {
 		if (!i) {
 			size = skb_headlen(skb);
-			if (!nr_frags && size < (ETH_ZLEN + ETH_FCS_LEN)) {
-				if (skb_put_padto(skb, ETH_ZLEN + ETH_FCS_LEN))
+			min_size = ETH_ZLEN + ETH_FCS_LEN;
+			if (csum_hw)
+				min_size += sizeof(struct bcmasp_pkt_offload);
+
+			if (!nr_frags && size < min_size) {
+				if (skb_put_padto(skb, min_size))
 					return NETDEV_TX_OK;
 				size = skb->len;
 			}
-- 
2.34.1

