Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E764756BB;
	Mon, 21 Sep 2026 23:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032483; cv=none; b=Q7fnKK/lMXWGsKN59pzGyBqJ5/3nWFASu2+U5NzIfaVK9fagMRMvmG3lwyZIpkqF59uivtFHvVZ5FH3sKPltsxdg18DRyvHxPssW+pEq8a5uoPvPjhQDkW5cEaV8Es7KFtznWmEXlr6d73Y1la2mvzkYlMswShlW8gb7SMvVnro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032483; c=relaxed/simple;
	bh=4KHTSHt2fx+tQth8nGkiLtxWijpx7L69RbtnLLBuXtY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tpeMSCJKCdvjgcFQmanzV6bUGcnr22U6IpkzIc9xJo5OPJ/vJRc/9o93cbEgdZWPxnRZutw38fuu/n4tvHikb4NZuWcNH6ab/sNzD+i1XRkH+jCv4kvfh9MbIEEONecF8I4ZqCBY0BjITZr751rDsmGIJsbuA0DN0vUg8OYl6vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GvTFIYO9; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GvTFIYO9"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 79505C000D85;
	Mon, 21 Sep 2026 16:14:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 79505C000D85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790032473;
	bh=4KHTSHt2fx+tQth8nGkiLtxWijpx7L69RbtnLLBuXtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GvTFIYO9fJJU2kNdEBAfhMj1XC2nD8Jyvad51d9vAqfllje61OTjku7vJkG081kEn
	 2WhwKy9sqdjpQm+AzRvrIVgBrDneBqhIo3DNpomoPuTzuAWNoi6029Mv723RLNBdTA
	 TZjHznix8mmpbi5aHygO6zvhml9yaSou9Dxvrkx4=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 564E1AD9;
	Mon, 21 Sep 2026 16:14:33 -0700 (PDT)
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
Subject: [PATCH net 07/12] net: systemport: Fix potential packet length underflow in bcm_sysport_desc_rx()
Date: Mon, 21 Sep 2026 16:13:00 -0700
Message-Id: <20260921231305.394773-8-florian.fainelli@broadcom.com>
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

In bcm_sysport_desc_rx(), the packet length 'len' extracted from the RSB
is only validated against RX_BUF_LENGTH. If a malformed or corrupted
frame is received with 'len' smaller than the prepended Receive Status
Block (sizeof(*rsb)) plus 2 padding bytes (and optional FCS), calling
skb_pull() will trigger a BUG() in __skb_pull() when pulling beyond
skb->len. Furthermore, subtracting (sizeof(*rsb) + 2) from 'len' (u16)
will underflow, resulting in corrupted packet stats and potential
out-of-bounds operations.

Fix this by ensuring 'len' is at least sizeof(*rsb) + 2 (plus
ETH_FCS_LEN if CRC forward is enabled) before proceeding.

Fixes: 80105befdb4b ("net: systemport: add Broadcom SYSTEMPORT Ethernet MAC driver")
Assisted-by: LLM
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index b69833d34bd5..95cead1df160 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -781,8 +781,9 @@ static unsigned int bcm_sysport_desc_rx(struct bcm_sysport_priv *priv,
 			  p_index, priv->rx_c_index, priv->rx_read_ptr,
 			  len, status);
 
-		if (unlikely(len > RX_BUF_LENGTH)) {
-			netif_err(priv, rx_status, ndev, "oversized packet\n");
+		if (unlikely(len > RX_BUF_LENGTH ||
+			     len < sizeof(*rsb) + 2 + (priv->crc_fwd ? ETH_FCS_LEN : 0))) {
+			netif_err(priv, rx_status, ndev, "invalid packet size: %d\n", len);
 			ndev->stats.rx_length_errors++;
 			ndev->stats.rx_errors++;
 			dev_kfree_skb_any(skb);
-- 
2.34.1

