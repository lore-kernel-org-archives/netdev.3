Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480329;
	b=yDRAzsQXO6RDSkAaqXPwKR7t8xB6RoGGpUY0KAkgd9pIybRr4NPCayhq6CIsjjQoNS30
	 T8AjmLutkwfdPfJe4e6b0jotS+ggYonf2lTwU0XXhOdU9C9YDDgA9UdC1KvgbxLSJTDv8
	 lCeg671aFC1qFGx3yuLh3qmw0KecfA4wK/MyaaqX3Xl/ikVYoCfSx9Gg2YfVDAREnJdhw
	 nDJypfSvlJO/mpRuFzlrvZgDR9Ne2tBSMcA1VT86sRJY9SSJ4i/Lzxi/V2JDeRZjiHshD
	 FqQFoz7/63/YHk62brOx/HldHl41EZJ+ZUnPOSo+9SvLW2mwVySE0Ddr6OjR6gGn6qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480329;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=IFMeZbLIaegiXj/zfONdiWfOWMlEVj7LkVrGQYZjHPg=;
	b=aMJgZhlxA8v3fOVN9ZexEpFBcZNEZDK21QZ1+63aKwaUQwOPx0YtNbrU5mDwECT7gpgh
	 AdGUwHngCUdQOI/UwMIIy3y623UJ3gqVnhoQcIWqWnweZSbBPJXNXBvLp5ecfnpyswboH
	 wKuc6NmNJ6S6g3fH+WKfN8V6yx937HkkuyR1OwFv+x1qFW2KENJFcR7ZvxDa+q/QMqjsJ
	 q2xEWyv31tkERBnolFv6lNOORu/CpW7BSYrJfiNbzVg8SWXYpRPNO/dqkLqSNxV5RCqcd
	 LBudiVvICFprPuLsKQvlXCfFD/gpPcqaR8OErTztmF/lmEEP9O9w1fduTqUMQw8J81w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=yQtAWMRm;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C950606A891;
	Thu, 12 Nov 2026 10:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C950606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=yQtAWMRm
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 63431A50BD;
	Thu, 12 Nov 2026 11:45:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794480326; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IFMeZbLIaegiXj/zfONdiWfOWMlEVj7LkVrGQYZjHPg=;
	b=yQtAWMRmUD2W7RApt6ZOHZ8lNuZFaU+6mSI/rbv4R8Rt51MDKGZHgLi06+B8yWDqJ+2LI/
	A7xBR0Uafj0dAAWykU9jP5GHOVin/aZnmlH/SPHqKJTUUzWwAMaBy5bBeaTFQcZC3rlWQF
	HtPg6mpOcxKQVF+NafHkNFiXKCWa6r36kSxGXKYF3kJomMHt0JtHe0aIbH6Xz8Gh76M7xZ
	Amm5DgpgBpGFa/gosoz03syIyQ/Nz0nOr00apv7V/tyIz3LmlmFMHSe9atGzCioNnj1DPI
	ZSXlbLKVugH/nKi2Zbx/Fny2HwWsAzkDeSm1TCw5q6iUgX1nNPtoi37Knaaw8Q==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Thu, 12 Nov 2026 11:45:17 +0100
Subject: [PATCH net-next v7 3/9] net: bcmgenet: allow a continuation
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
Message-Id: <20261112-nb-genet-mtu-nn-v2-v7-3-43a5d90b3256@tipi-net.de>
References: <20261112-nb-genet-mtu-nn-v2-v7-0-43a5d90b3256@tipi-net.de>
In-Reply-To: <20261112-nb-genet-mtu-nn-v2-v7-0-43a5d90b3256@tipi-net.de>
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
index 4c2a38eaab108..d4eac993368fe 100644
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
 
@@ -2363,6 +2364,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 		unsigned int rx_offset, rx_size;
 		struct status_64 *status;
 		struct page *rx_page;
+		unsigned int min_len;
 		void *hard_start;
 		__be16 rx_csum;
 
@@ -2399,8 +2401,12 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
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

