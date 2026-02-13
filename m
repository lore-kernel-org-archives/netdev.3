Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1FA239E80
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771001901; cv=none; b=oksL9E3HeVSjoEJs1vZdhE0Z45q/sEDTXztvo3O2l70HXd2mw2fFq+3elzGmohmSDoWtewERfNHSKclUfvrrgJZVnZxF4s1MRraJYr35dmGn4O4akqfFZDyc/StQXsOLtzhE9pYza/hdeIp/NcyZNLrAzFmVejyH575knx7wb/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771001901; c=relaxed/simple;
	bh=ozaspxNU63QpZ+qLugEcyaubGB+n8rVT4yWazLyr9OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2cP4qk2KkWSFuowc1uycTq+Z/aVoVG5He3gEYbmFxRCmswqCe7+/ybEVjbzNUN671sKE04AxPRaT+8eXzgCtC0FZh1CEincnNXEf46RoMKpt625PRMgnZ4fVSawjB4ecKM6AcW/r44RbcwIZ2g7pb5sJU99EtqaYudlb4hYu8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ktyycfw/; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ktyycfw/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 51AA64E40D3D;
	Fri, 13 Feb 2026 16:58:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 225CF606BE;
	Fri, 13 Feb 2026 16:58:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8A08F10368EB1;
	Fri, 13 Feb 2026 17:58:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771001897; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MtpEqQlI+m3C60kkbpA1LfSZWugP19J4XphbjEvvvMs=;
	b=ktyycfw/brQQjLyoN5HhQb+7RtsUe3j+XtMAg+hnKNB+4RLUMfc40OXk2h9M8bX3KAvUxX
	ldm3fPAQPyc2hBsQao5sIRWukD+SS6ReHH6dUnFIZHdm1mJKJ4b3auStVq8lXSuo4pWf8N
	CVnng3TJeTshsqzRXWLUh+cVIGtE+XpMNMKHgrpgx1C8JlJ6h2UxyUD8V2SQ5cwUJpt15H
	R6FCbC15luvFTw1vtJpBWBew9bw8vFzIoVfLNJZwtpw0Z3F51+PdK8kIKgAL8iA3dxjGAk
	5srMCV2XfbNNXwPDcqoFCARKq5Fn1AGDRsAAU+Z9SoCwa7dflmCmG4g4FXQj3g==
From: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
To: theo.lebrun@bootlin.com
Cc: andrew+netdev@lunn.ch,
	claudiu.beznea@tuxon.dev,
	davem@davemloft.net,
	edumazet@google.com,
	gregory.clement@bootlin.com,
	kuba@kernel.org,
	lorenzo@kernel.org,
	netdev@vger.kernel.org,
	nicolas.ferre@microchip.com,
	pabeni@redhat.com,
	pvalerio@redhat.com,
	thomas.petazzoni@bootlin.com
Subject: [PATCH 1/6] net: macb: rename release_buff() -> macb_tx_release_buff()
Date: Fri, 13 Feb 2026 17:57:54 +0100
Message-ID: <20260213165759.225449-1-theo.lebrun@bootlin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <DG4MBFXG7GGG.3GFLWBUKH087T@bootlin.com>
References: <DG4MBFXG7GGG.3GFLWBUKH087T@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

release_buff() as a function name is ambiguous:
 - it misses the driver prefix and,
 - it does not mention whether it is a Tx or Rx buffer.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index d155f4571c74..70f5dc9c6529 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -969,7 +969,7 @@ static int macb_halt_tx(struct macb *bp)
 					bp, TSR);
 }
 
-static void release_buff(void *buff, enum macb_tx_buff_type type, int budget)
+static void macb_tx_release_buff(void *buff, enum macb_tx_buff_type type, int budget)
 {
 	if (type == MACB_TYPE_SKB) {
 		napi_consume_skb(buff, budget);
@@ -994,7 +994,7 @@ static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff,
 	}
 
 	if (tx_buff->ptr) {
-		release_buff(tx_buff->ptr, tx_buff->type, budget);
+		macb_tx_release_buff(tx_buff->ptr, tx_buff->type, budget);
 		tx_buff->ptr = NULL;
 	}
 }
@@ -1461,7 +1461,7 @@ static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
 	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 
 	if (err)
-		release_buff(xdpf, buff_type, 0);
+		macb_tx_release_buff(xdpf, buff_type, 0);
 
 	return err;
 }
-- 
2.53.0

