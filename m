Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5DC3254BD
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394017; cv=none; b=oS7/CI5BxFTkSESIR6X0N9Uh0VqqQA153vuI7lSU6WE+WJIrXPFstqaQK2K5QrOVKOc9WnkCOQUiLSzF3jbQ9jrFcuZrcr7qLOUZqNVsOBlEv9fQriHs/qQ2AaD9YJ785fPQGBcqP45Ncg5VXfIiu3EOs29YWp52lBW4BaiBQrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394017; c=relaxed/simple;
	bh=M/fO4066R9QBn0wuWeOwifRMZmhtbV9/kRBeDvKY7fE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mNJBSzbdw6jOX/7SWvj+U4qLbj0e9MK8yFjUoMbCXRfa9AGLRTKO/Zeq8hlvItwEMSuJr9Kz0DeOCseywno0Z1hLZeRhdXPdgFDPmKPfYk6MOBf6L+Bj/PkdtiZBAhdukmEa5A60/7kkPNrN0SCoqG9P+AYZ1ZvJKq4lobVtd38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k0/aCrcX; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k0/aCrcX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B35594E42B60;
	Tue, 28 Apr 2026 16:33:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 804E9601D0;
	Tue, 28 Apr 2026 16:33:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2EFEB10728EC7;
	Tue, 28 Apr 2026 18:33:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777394013; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KysA7h9zhISCGBCF1f+mzV/3bsFT/VxDM5MEU5kyFBI=;
	b=k0/aCrcXQQrSD0Xxlp/t3xhzZXmFUHJ157lAGjkuBJfFBpW0e6Qt/0N7pcheFeR9Ux7br+
	44YXx4HRHdVriSLy0lhvzv7H2oeAR7HfVZ2IsQHCw3lmBclTjNL886jN+NEF/T/QOK0KOw
	De5XfGCqCXVJJ5DnCP43y1VZo5h1tyPJBCmmQt4GB1McjoRjGPecCvvJpJ9hJoxSNfDU2A
	wmR3gaow8wZSZp/YWjnrWaGoAwlusZNAMR3pwjBhDk5oXbmTFZ2ILfBB6VVA98IN1XDStg
	rpNGjmEPulRzf/LrjXxzfPVb6odEWGLJy/oRvJng0HA2uw1ryoGW4R+Jb/WEkQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 28 Apr 2026 18:32:59 +0200
Subject: [PATCH net v2 3/4] net: macb: increment stats.tx_dropped on tx
 error
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260428-macb-drop-tx-v2-3-647f5199d8df@bootlin.com>
References: <20260428-macb-drop-tx-v2-0-647f5199d8df@bootlin.com>
In-Reply-To: <20260428-macb-drop-tx-v2-0-647f5199d8df@bootlin.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Haavard Skinnemoen <hskinnemoen@atmel.com>, Jeff Garzik <jeff@garzik.org>
Cc: Paolo Valerio <pvalerio@redhat.com>, Conor Dooley <conor@kernel.org>, 
 Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

macb_tx_error_task() is the workqueue callback on Tx errors interrupts
(MACB_TX_ERR_FLAGS). Count number of errored SKBs and increment the Tx
dropped stat by that amount.

Two types of dropped (not consumed) packets:
 - Those that have been TX_USED but with an error.
 - Those that have not been TX_USED but that'll we drop to reset.

Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
Cc: stable@vger.kernel.org
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 5a2500bd59a6..ba7cbb10dc2c 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1261,6 +1261,7 @@ static void macb_tx_error_task(struct work_struct *work)
 	struct macb		*bp = queue->bp;
 	u32			queue_index;
 	u32			packets = 0;
+	unsigned int		dropped = 0;
 	u32			bytes = 0;
 	struct macb_tx_skb	*tx_skb;
 	struct macb_dma_desc	*desc;
@@ -1332,6 +1333,8 @@ static void macb_tx_error_task(struct work_struct *work)
 				queue->stats.tx_bytes += skb->len;
 				bytes += skb->len;
 				reason = SKB_CONSUMED;
+			} else {
+				dropped++;
 			}
 		} else {
 			/* "Buffers exhausted mid-frame" errors may only happen
@@ -1343,11 +1346,17 @@ static void macb_tx_error_task(struct work_struct *work)
 					   "BUG: TX buffers exhausted mid-frame\n");
 
 			desc->ctrl = ctrl | MACB_BIT(TX_USED);
+
+			if (skb)
+				dropped++;
 		}
 
 		macb_tx_unmap(bp, tx_skb, 0, reason);
 	}
 
+	queue->stats.tx_dropped += dropped;
+	bp->dev->stats.tx_dropped += dropped;
+
 	netdev_tx_completed_queue(netdev_get_tx_queue(bp->dev, queue_index),
 				  packets, bytes);
 

-- 
2.54.0

