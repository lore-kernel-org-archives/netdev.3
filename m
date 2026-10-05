Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F93A42F708;
	Mon,  5 Oct 2026 22:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791239110; cv=none; b=i5I7mM/nivPdT8HEkfHgriy6jhUcAUvOPrfTPke3PU5AxZG8AmUVCDCCeDnjo5TMgqR57/8Cw3gWdMSkQegZCp/EHI2czAbt5BVsYl1ngL50YHHNOb3IvKh5lQ51zqFXnKZQUjrzDTVdUbp8rRtK4DUikLOWLBBSf/pqWE+eej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791239110; c=relaxed/simple;
	bh=+GZcIPgeFYGm8PitFa7uwxYcGE8EgVFTTZ4LBAoLin0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cjc5JOiP/fPaRJX7ja+25VGmt1qbPlA79U5Gc8kNRjcfLbstTo9jKBswkgddeqvMwJWKvQgBkI7wr4BwR3PU9Ej7OW6y2NPiiAxlgTwPCF+rbXbmNxCCnLHbz29dvCsvCezkC7Fg82H2bYcQPkxWKeOS+7n/C2XnzKRU/FqZ/a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=c0rj1hN3; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="c0rj1hN3"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 14C64A0E36;
	Tue,  6 Oct 2026 00:24:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791239101; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fsiwvQPX5qj2JIWUeDLCmBbhThk9W7xVZ5WJWBzct3o=;
	b=c0rj1hN3/Ekw2mYkiu8dGEdpSCXZmQGITmIx3a1FXXxTVDi5/Zx/cDKdociyDglNmRp2dw
	nV020ENoXVRXWtYh6XA5WiBV62E8ftkEPxF5wGCJqQcsn+1vPNblaXaxEg13ggphokwB0Z
	5QLbEmKtSB+Kn/dqJ4RBw1hY4ESqLREdocZBH4vMcg/0lFHjZyI+aP4sR0Xen/9XcBYdto
	1D52o29ZIVi48g1peWHGLHGmGrV2p7VszFYYMEEXlysob2pUeMmYI1RdrZEtdKTrIzKwjf
	mCye93bgKxc3zsdrusGUbmhyf5YvyxvzwSHm708EgbOu2MReABmsVRNn9fT+MA==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 06 Oct 2026 00:24:41 +0200
Subject: [PATCH net-next v2 2/7] net: bcmgenet: allow a continuation
 descriptor without the alignment pad
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-nb-genet-mtu-nn-v2-v2-2-c4be21151912@tipi-net.de>
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

A frame longer than the packet ready threshold arrives in several
descriptors, each with its own status block. Only the first one also
carries the two alignment bytes. The length check assumes the pad is always
there, so a continuation holding a single byte looks a byte too short and
the whole frame is dropped.

Account for the pad on the first descriptor only.

The MTU cannot produce a frame past the threshold yet, so nothing hits this
today. It is preparation for the larger MTU.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
Tested-by: Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index a82579879f4b..c781dfbe3f60 100644
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
 
@@ -2329,6 +2330,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 		unsigned int rx_offset, rx_size;
 		struct status_64 *status;
 		struct page *rx_page;
+		unsigned int min_len;
 		void *hard_start;
 		__be16 rx_csum;
 
@@ -2365,8 +2367,12 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
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

