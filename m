Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BF443801B;
	Wed,  7 Oct 2026 08:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363116; cv=none; b=gc3RN78o9UTE819mISwhz01w/rasYMgIVIBo7rPMoMsIta1nTLiSDVLGWNmHL1jNrTQTh5t19Bglt/zJLouYKvBYAZq81LQtYKb98Ppt4nhcqnD1fmSrLeih7/k/ifErTecQzJz/vf89tYRtUrFAUaNvR3kIZyDzsLB8Ca0Wu0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363116; c=relaxed/simple;
	bh=kSFbE886LLYkQQKUxesBO7Vdj+MZsvq9kXi8RJwqMAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B5101WnU3LaXItXFPcZLxr74ocw3Zw1x9wlGK9vzkcvzxC+eW8A56OVVUJLVF7brBCIQj1K4RFgAqFhX8PYtwldwZB6pOK3KUjr4AryMvIcBwF5rmeqRCYgs13VCaH4nNOjPIHjUYa2oK8R/iy8AaXMYsU7n+Vb6ycLIzmcSA9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=znXQduAs; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="znXQduAs"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5BCEEA154E;
	Wed,  7 Oct 2026 10:51:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791363112; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6k3bAS7WjUZeniznAWZCeIsGJeXDmb5GDkQg6jFBe+g=;
	b=znXQduAsmZN9k2lgVloSnBTkqWwZkYH6NYudZRJDTQGsr7JUU6XD/GSA3wr5rSrL6BccGK
	WWVwEDkK3ajbU09jNliSZTqGzZJbBIcS2pbE9CtaeHYYGoWShDIOtVNJLMn5pzQRHcsds6
	kXgtWPlmV7sPtJT4bzajWDsx/2T3iXRO/VOQlgpdAavPlCGUVsFqn4euYzxzDuFlFntosM
	1lRc7mw96nTrt8v0YFw4qhcNS813zXh3TD42WPtG0rODbERZlqNptEPGBGb7ksqS2hfUob
	LASVsxSohE7M49O2v/ut80YUbu/eHAG4zKoBab3t613iWYafV/3fdFFTlWuTEg==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Wed, 07 Oct 2026 10:51:27 +0200
Subject: [PATCH net-next v3 4/8] net: bcmgenet: rename ENET_MAX_MTU_SIZE to
 ENET_MAX_FRAME_LEN
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-nb-genet-mtu-nn-v2-v3-4-74a796c019ce@tipi-net.de>
References: <20261007-nb-genet-mtu-nn-v2-v3-0-74a796c019ce@tipi-net.de>
In-Reply-To: <20261007-nb-genet-mtu-nn-v2-v3-0-74a796c019ce@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Justin Chen <justin.chen@broadcom.com>, 
 Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>, Florian Fainelli <f.fainelli@gmail.com>
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
index 9f9c3fde8725..83ffc4a2a2a7 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2646,7 +2646,7 @@ static void init_umac(struct bcmgenet_priv *priv)
 			     UMAC_MIB_CTRL);
 	bcmgenet_umac_writel(priv, 0, UMAC_MIB_CTRL);
 
-	bcmgenet_umac_writel(priv, ENET_MAX_MTU_SIZE, UMAC_MAX_FRAME_LEN);
+	bcmgenet_umac_writel(priv, ENET_MAX_FRAME_LEN, UMAC_MAX_FRAME_LEN);
 
 	/* init tx registers, enable TSB */
 	reg = bcmgenet_tbuf_ctrl_get(priv);
@@ -2752,7 +2752,7 @@ static void bcmgenet_init_tx_ring(struct bcmgenet_priv *priv,
 
 	/* Set flow period for ring != 0 */
 	if (index)
-		flow_period_val = ENET_MAX_MTU_SIZE << 16;
+		flow_period_val = ENET_MAX_FRAME_LEN << 16;
 
 	bcmgenet_tdma_ring_writel(priv, index, 0, TDMA_PROD_INDEX);
 	bcmgenet_tdma_ring_writel(priv, index, 0, TDMA_CONS_INDEX);
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 86f2aed20dbe..501dd1256693 100644
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

