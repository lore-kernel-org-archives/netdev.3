Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F89642EEC4;
	Mon,  5 Oct 2026 22:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791239107; cv=none; b=kmL/tSxWrZ5pMBP32XTlxRuR0uvt9OBvPhrNf8WzwgtYnmC5O4mM9oOf/wch0SAkfs3F8yGY65srZudnYJORtIdIx9su9Z73dOZQyjVgPdlUI6bYGeXrpsCXkbl5EP2EXJrXKaLEyt0PNlEyttKveJ2UoTEbGDoFD/3blEReqs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791239107; c=relaxed/simple;
	bh=CAy2BMnQYmLM2QvSTAL3JiKwiXaZ69SiJGXAtuuoXzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k2KemFrgfavqzlj9ciWO5HjJmy1sYUMyvYPYls9G4MEXggET7wbPTy19opc5W6rP85VGOY+X+G9EWSTyLAenmBRIHMFJMDFsqMB29dJ3rflkvu6qaJmDNcX25h3D7vB9TTWP8LwdovmWRdh7JPviR0oRirEhMpboOxscNIszH28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=4RMpADBa; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="4RMpADBa"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A4AEFA0EC1;
	Tue,  6 Oct 2026 00:25:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791239102; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=05bPu1MwgKPeVbSky+Xn7yS48dG5gQuLG0JmiejcTFg=;
	b=4RMpADBachOBE12WXjOTx9jqsRfEhzujEX8uLz3zJ19pyxZ0a4wsR2//e5+NC+F9NZA36F
	MHQ9ONaHWg7BgFFsKvG4rVYszfvZox3HtOX4J4hU4X57zhBNk+R2J112WLh3AA4VSQvnXQ
	hpGHlEs6fi3deBtZtYufD81UaQcSPG7Xte2IVwOePryxLxfLxIJYEYqXTdoQrTK5+TVqf7
	5tGtHgzOLLXQYJalebmapp+FN3xlIdcz4IEaQcyH8CB5s4j5eQqCRBqHNpSHQTzTWkbuZ4
	xfTJRZfJPbEWVyVkvTRRx08OXdR14NbJv8FDTmAkjtW6XyprwptTZV1LrJ9mLQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 06 Oct 2026 00:24:42 +0200
Subject: [PATCH net-next v2 3/7] net: bcmgenet: rename ENET_MAX_MTU_SIZE to
 ENET_MAX_FRAME_LEN
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-nb-genet-mtu-nn-v2-v2-3-c4be21151912@tipi-net.de>
References: <20261006-nb-genet-mtu-nn-v2-v2-0-c4be21151912@tipi-net.de>
In-Reply-To: <20261006-nb-genet-mtu-nn-v2-v2-0-c4be21151912@tipi-net.de>
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
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

ENET_MAX_MTU_SIZE holds a frame length, not an MTU. Both users program it
into hardware that expects a frame length. The name is wrong once the MTU
is no longer fixed at ETH_DATA_LEN.

No functional change.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 4 ++--
 drivers/net/ethernet/broadcom/genet/bcmgenet.h | 7 +++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index c781dfbe3f60..641d918577d4 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2639,7 +2639,7 @@ static void init_umac(struct bcmgenet_priv *priv)
 			     UMAC_MIB_CTRL);
 	bcmgenet_umac_writel(priv, 0, UMAC_MIB_CTRL);
 
-	bcmgenet_umac_writel(priv, ENET_MAX_MTU_SIZE, UMAC_MAX_FRAME_LEN);
+	bcmgenet_umac_writel(priv, ENET_MAX_FRAME_LEN, UMAC_MAX_FRAME_LEN);
 
 	/* init tx registers, enable TSB */
 	reg = bcmgenet_tbuf_ctrl_get(priv);
@@ -2745,7 +2745,7 @@ static void bcmgenet_init_tx_ring(struct bcmgenet_priv *priv,
 
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

