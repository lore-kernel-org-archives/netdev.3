Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480329;
	b=Ba6hrYfd9dyIdRPc+AGwqtAGC0ypljzH4fBlMDNAWpfrbiBqVUS2esvjtJ8L6ln97Zbp
	 bXXsSX7W2CoPiUKoxH2BvhUWhvCCJsvoQHa9v96wZD6Ih2gxHnOwltORsKN+JSIgSbL5h
	 Z7Frji8peZQLlk7cqgtYiuK9zp4+Qm9yhiG9ofXAMqAhgfCgEIFkP8Yi8kbniFrdlh6Ue
	 kkJ0l/ynZFAlI4Dt6P0jycOQd+YDmVFv9lVwf+1zNe/EvisGtDAz1rHgxfjEy4iS092J1
	 RMGiQNI9/eVLe64npmwcDpDD53kWf/i96rn9cUf5SJMjaSb9zIT4CfmldINDjFGsH/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480329;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=Xg+KYajz7Z1q6LDz3Lm1nAnAFjWCVa0syzQx7o7Tgdc=;
	b=V2A8dRII2vcC9JlY1IVNy1Hs6FFGZAPziCrNh2iL3I+n7Ix32qainpi5PtzZLUqwEXHt
	 SDedAH7bVN4EJuHpbjhd77qt2ZgHKF9BfxiJCB+IMnlt26gaOYsU8ZQKhWU0fG7EJxptK
	 BaDRKq9ZCllLJGy5D3M1PtbSgrNgnY2yL/YaRuA7K3EpAach6vJiO4D2Xxnz/EtRxByz1
	 EaAuLkQzWuVraAEXf5s/RMG+OIsa7j0OZsYuhv6xFzZVv4GeXQ6FxeNZWqb09akCzFEAW
	 kua4oyjSEekQv+vlArau52F7kdNMD0b1ID7hA+jlhlT1/DZuErXg8XpDtmCgdjcg0ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=l1o2zFav;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27712606A89C;
	Thu, 12 Nov 2026 10:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27712606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=l1o2zFav
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 13D21A50C9;
	Thu, 12 Nov 2026 11:45:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794480327; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Xg+KYajz7Z1q6LDz3Lm1nAnAFjWCVa0syzQx7o7Tgdc=;
	b=l1o2zFavhOfZ5s09lspCqxjwPY3f3svFQtiJ3R3eBTZVsMpTgAavJG31ToQb642X8FSe1w
	17hs1nYrtg1rsSpVuMLTHlLJOHiNn5fHf7xnU3d2UWyep7qiIfhqYOEp22YWtau7/2HiMI
	0RZydr/t/d0zHiXgo1VOl5NyzzB67B/Zjhi0qEW3ps949crCuw/DtM1rTreZz4dQspQHqU
	96crpp9LodZwzV4VtEfkEdweUwxB51d+ICUEAaIjooJFmqjraDKgL4Pt2nX47v2B/xKZv3
	q35zQsGhLcXJA10CRu8LYS2pSpBdzrLuTl9nS208wAG1pmQ6PVAtaCDqqVGuGg==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Thu, 12 Nov 2026 11:45:18 +0100
Subject: [PATCH net-next v7 4/9] net: bcmgenet: rename ENET_MAX_MTU_SIZE to
 ENET_MAX_FRAME_LEN
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
Message-Id: <20261112-nb-genet-mtu-nn-v2-v7-4-43a5d90b3256@tipi-net.de>
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
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

ENET_MAX_MTU_SIZE holds a frame length, not an MTU. Both users program it
into hardware that expects a frame length. The name is wrong once the MTU
is no longer fixed at ETH_DATA_LEN.

No functional change.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 4 ++--
 drivers/net/ethernet/broadcom/genet/bcmgenet.h | 7 +++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index d4eac993368fe..b0b0d9b423482 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2673,7 +2673,7 @@ static void init_umac(struct bcmgenet_priv *priv)
 			     UMAC_MIB_CTRL);
 	bcmgenet_umac_writel(priv, 0, UMAC_MIB_CTRL);
 
-	bcmgenet_umac_writel(priv, ENET_MAX_MTU_SIZE, UMAC_MAX_FRAME_LEN);
+	bcmgenet_umac_writel(priv, ENET_MAX_FRAME_LEN, UMAC_MAX_FRAME_LEN);
 
 	/* init tx registers, enable TSB */
 	reg = bcmgenet_tbuf_ctrl_get(priv);
@@ -2781,7 +2781,7 @@ static void bcmgenet_init_tx_ring(struct bcmgenet_priv *priv,
 
 	/* Set flow period for ring != 0 */
 	if (index)
-		flow_period_val = ENET_MAX_MTU_SIZE << 16;
+		flow_period_val = ENET_MAX_FRAME_LEN << 16;
 
 	bcmgenet_tdma_ring_writel(priv, index, 0, TDMA_PROD_INDEX);
 	bcmgenet_tdma_ring_writel(priv, index, 0, TDMA_CONS_INDEX);
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 6ab3f73475550..afaccb7699336 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -28,12 +28,11 @@
 /* which ring is descriptor based */
 #define DESC_INDEX				16
 
-/* Body(1500) + EH_SIZE(14) + VLANTAG(4) + BRCMTAG(6) + FCS(4) = 1528.
- * 1536 is multiple of 256 bytes
- */
 #define ENET_BRCM_TAG_LEN	6
 #define ENET_PAD		8
-#define ENET_MAX_MTU_SIZE	(ETH_DATA_LEN + ETH_HLEN + VLAN_HLEN + \
+
+/* Longest frame the MAC must accept for the default MTU */
+#define ENET_MAX_FRAME_LEN	(ETH_DATA_LEN + ETH_HLEN + VLAN_HLEN + \
 				 ENET_BRCM_TAG_LEN + ETH_FCS_LEN + ENET_PAD)
 #define DMA_MAX_BURST_LENGTH    0x10
 

-- 
2.53.0

