Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700330;
	b=glpv0MQoYV0stFqHjIHDJNtLU6HzV4ikjjEVcdHIJKoMn+UnvjAEbeyYWoPDznziI3mF
	 Tckt20YDBgCztJISII2hLIp7B0A0toLAWGs1Uf9tV7PjAtRiGOD+h8bwaOvoCDwI5DXDM
	 ic2Wm8K1g7O2Z9qg2cB8PF2reZ6zwCpUdmfWLllo1/GJoWEkTppErod7z7dS/op4L19jh
	 Yq2rCOmG+Di8YWyZNFbvRZzJwJzLBZZQDbn2fFC7Zah0jIQ+1HfANiLFBJ4OHzCu4smC5
	 /rSVYvGsIkrd9qjeYmIKyprnfWmZKn4eBOzlSUiigogukEYZTBR59NPzAXsc86qg1iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700330;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=H+2BP087lEieKM2AjDiKXYcZb/aS702FUpveBjRyJh0=;
	b=XqjxAhSsxUiXV2p7lFFqdwaIUx1KlwJYnn81Yw1eWa2rf7knCbfc8SZUDi/TBHMMBHxx
	 BsmtQZHlyH01418Yttgn18PaERX4clnpHXnWyLMykQURInyILQF+gmC0B0LRHAcBnRhyE
	 uzmWi3NdDAcfirvyTb+unMr+QEhfhzZo/6kWotlj7TODbPBh9N4a055tBwTW+YgIzDu+8
	 MwpP7BNR5H7tzMBXmsfQl3/v06g2AuT5VlHwJFJYDZAtFSlNcuDJ24D+qf6IHgTzksU5j
	 Bz5Q3DR+jRnlGtTUO+nuvzp4Sj+HlV0YCykzo7lG97cQWeU4jTAdOnWfDhnxRNYOFMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b="2f/JvA6a";
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30B9606EE97;
	Tue,  3 Nov 2026 10:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F30B9606EE97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=2f/JvA6a
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B850CA164C;
	Tue, 03 Nov 2026 11:05:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1793700327; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=H+2BP087lEieKM2AjDiKXYcZb/aS702FUpveBjRyJh0=;
	b=2f/JvA6aMTqaeKqjoCOHts+CmXu2qeDnEhy+JFTlx2hA7LlEHuLKK1In5XBI8Z+djFAeOO
	+iCg9gr62dLE/OoCWh6DGjR+6piKuAVXDW/ffl7Jxr/bl84OBLaroQ2nrU1TlbuUKvdnDz
	80yXNw/wfiU1dONOehgxOZ6Aw8peJKnkn9QG85yaYmyo2z3Cdc51UqdJQZj8adZpoc/tT1
	KOTFZ3i9ZyU4YQ3EeUYUjIMw/OhmCfCbPHCj8csuTY+T2mH4N+ESqO+I/krPV42hCrP2uc
	5gYCqDEZwJGiHBZqLcz8RZ7dUT0wVMso4FtCHjkRbp94C7zf4/JCqYuVrK2YJA==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 03 Nov 2026 11:04:57 +0100
Subject: [PATCH net-next v6 3/9] net: bcmgenet: allow a continuation
 descriptor without the alignment pad
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-nb-genet-mtu-nn-v2-v6-3-61d5631676e5@tipi-net.de>
References: <20261103-nb-genet-mtu-nn-v2-v6-0-61d5631676e5@tipi-net.de>
In-Reply-To: <20261103-nb-genet-mtu-nn-v2-v6-0-61d5631676e5@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

A frame longer than the packet ready threshold arrives in several
descriptors, each with its own status block. Only the first one also
carries the two alignment bytes. The length check assumes the pad is always
there, so a continuation holding a single byte looks a byte too short and
the whole frame is dropped.

Account for the pad on the first descriptor only.

The MTU cannot produce a frame past the threshold yet, so nothing hits this
today. It is preparation for the larger MTU.

Tested-by: Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index bed94f9a79450..9cb0cd7a9a216 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -53,7 +53,8 @@
 
 /* Page pool RX buffer layout:
  * RSB(64) + pad(2) | frame data | skb_shared_info
- * The HW writes the 64B RSB + 2B alignment padding before the frame.
+ * The HW writes the 64B RSB before every descriptor of a frame. Only the
+ * first one also gets the 2B alignment padding.
  */
 #define GENET_RSB_PAD		(sizeof(struct status_64) + 2)
 
@@ -2349,6 +2350,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 		unsigned int rx_offset, rx_size;
 		struct status_64 *status;
 		struct page *rx_page;
+		unsigned int min_len;
 		void *hard_start;
 		__be16 rx_csum;
 
@@ -2385,8 +2387,12 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 			  __func__, p_index, ring->c_index,
 			  ring->read_ptr, dma_length_status);
 
+		/* Only the first descriptor carries the alignment pad */
+		min_len = dma_flag & DMA_SOP ? GENET_RSB_PAD
+					     : sizeof(struct status_64);
+
 		/* Reject lengths that would underflow the SKB build path. */
-		if (unlikely(len > RX_BUF_LENGTH || len < GENET_RSB_PAD)) {
+		if (unlikely(len > RX_BUF_LENGTH || len < min_len)) {
 			netif_err(priv, rx_status, dev,
 				  "invalid packet length %d\n", len);
 			BCMGENET_STATS64_INC(stats, length_errors);

-- 
2.53.0

