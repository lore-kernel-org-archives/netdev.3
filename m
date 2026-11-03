Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700330;
	b=TdOi4qTQblbTzOkcAyrTP8h4jafjVh1nkWLQMRkJiYD3/An0iA/JRgbx+2o2W9D+kFEZ
	 WRn8hqTeruBHg8J7sfpuWeot6Gbji4hfjo3ZDr1PCJGq9z5cyWjAhPaQ54U+mkzaENla8
	 w4R0Eq1WzzmnSHrOh9FLnWq5cLv3zch+3IXY8hDIwf38/B+cxUE+9q2GdXU7ENhbpQufh
	 ZiP5WGk2L34K5pamx+sSwbww7RNut4i9fUQCFTOXttdGHQps73+poB/879ye6WtvyZPKW
	 0zYyTKDyb3V8gwedE8j6d18q0C8saduaeBYcE8XMeL+LDstAJoAPHGgErJtNHUmEQxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700330;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=9C/X2YQ+/o0IqEAQQc4J0LZ9Oq8K1zfo4He9kP/ME9c=;
	b=TtGGvkEyPyl9Ye2R4S7WAn58K2ih/GhTf3Vm9HAMpCuODsdHy6EDDEdij9MVHGwHHb1l
	 yE5+OMQi8wqniKo1eejH9K6+H9fYYxkhgLG3WnLonf/OqOp4rYLZCQqcaZNqh7IeGmSzz
	 gzZIk+K7dQhb4F4s7lVqeVjXpJ4Llv0oocd5V5rPwxDlCCNBLPESZ8oASKK1QNphItvzF
	 sQBEkHqZjWeHQA5tnji9mgrGUvsLonyEKI0N2Ph+aGpkTRLeAabKcKwcC8J1kPxGUVo2Y
	 U5wu4R+xqt0AlizrNsMn1hWtNSUwyhHhWrZ/YoJMQgc9QMWhaLgUU4P6IRMS5qWjjEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=dEQ9j6d4;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9128B606EE9F;
	Tue,  3 Nov 2026 10:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9128B606EE9F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=dEQ9j6d4
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5F816A164D;
	Tue, 03 Nov 2026 11:05:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1793700327; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9C/X2YQ+/o0IqEAQQc4J0LZ9Oq8K1zfo4He9kP/ME9c=;
	b=dEQ9j6d4WuVrwbjs1jp7QALQiQ8fSOfh/BfTHhSTLggv9oQSOBFXa4Of/UMrhBRVDuByEa
	rT3hi6KZ3B4CQBg7GfGlvZEbE+TWbk+BpXkgTWaJgozCB9CI8oTsF31+5+ZeqWU71qnLGH
	e5a3hpz3wFBM5jNn/ydIpARiYAu+NDFqj/MM/ov/sRr9iDIbx6aOU2xGBp+aUs02evLJP/
	Z5QVLOOufW2T6eSf7c7CzxETFnHs7DrubIRAhrEBk01O2ndGAmSVnsPmdnHYDGMNaU3YMv
	ttUVJnlUTFxcdtlexWnZUujPjJ0jHMr/avpGRs5mLLiVvEw+LaJ3Bb0AqWoZsg==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 03 Nov 2026 11:04:58 +0100
Subject: [PATCH net-next v6 4/9] net: bcmgenet: rename ENET_MAX_MTU_SIZE to
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
Message-Id: <20261103-nb-genet-mtu-nn-v2-v6-4-61d5631676e5@tipi-net.de>
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
index 9cb0cd7a9a216..a0f170bf35ef5 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2659,7 +2659,7 @@ static void init_umac(struct bcmgenet_priv *priv)
 			     UMAC_MIB_CTRL);
 	bcmgenet_umac_writel(priv, 0, UMAC_MIB_CTRL);
 
-	bcmgenet_umac_writel(priv, ENET_MAX_MTU_SIZE, UMAC_MAX_FRAME_LEN);
+	bcmgenet_umac_writel(priv, ENET_MAX_FRAME_LEN, UMAC_MAX_FRAME_LEN);
 
 	/* init tx registers, enable TSB */
 	reg = bcmgenet_tbuf_ctrl_get(priv);
@@ -2765,7 +2765,7 @@ static void bcmgenet_init_tx_ring(struct bcmgenet_priv *priv,
 
 	/* Set flow period for ring != 0 */
 	if (index)
-		flow_period_val = ENET_MAX_MTU_SIZE << 16;
+		flow_period_val = ENET_MAX_FRAME_LEN << 16;
 
 	bcmgenet_tdma_ring_writel(priv, index, 0, TDMA_PROD_INDEX);
 	bcmgenet_tdma_ring_writel(priv, index, 0, TDMA_CONS_INDEX);
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index e48ce39d3e7c8..6f40be5445e0b 100644
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

