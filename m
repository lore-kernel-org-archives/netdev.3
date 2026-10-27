Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793126659;
	b=YvUg9y1SKb9NkKbod8eblEg0X3E0UkWEMNvP4UnmASbKzfhmx0ASUZMX3mOmNw7fWjrO
	 HO62UFCPLBsfnUj0cXuGq5dWNz63Oin8qdCsmjztdzWgG59wSWTu1Hg1jXYJzNq98pQME
	 WLh0xgAt2LBHYzqbHnmaz+N9P01IMU1dSxFuoDnCXtktBoIdZNJzeuEaN7DERwNXbwDcl
	 wBo+iSPHyjVLFGlDj9rsWu7odPpOSG+1QzykTRNUKFXImaYdKcDJr/iQnCt7Vea1l2Ovw
	 +e89zpzjXRyW71N5m8xT61Prqwgtyy1oFOQr8+ofS3Q4iht7OSgyAgDYxPwsCjjQCKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793126659;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=2FcWg1V/3aBTP3KwZYU/FI1oXS/QXKtS31y8wgVo5lM=;
	b=YvqxAbc/GVdJPVkrycXrK4tv3dQjVEOtELCJAbN8YKJqJm6kvwML6FvpcF5koFjOUiJD
	 bhmpiUBMwuVAsCTtDqF2tnuCkl3+OAqZEJVfvgyN/6Dw+J7qI0+3Om6UKTmtRuDpxaXUZ
	 KokGm6tdd/7vkAlCNDkI/gCxbcOnKswljnR/IFZ3QFmopgPVQDMdMj44ZKVjbdMMgt45j
	 wEx470TeqVbxzdWj1UKVQZ2hbgHe2ujBlOFRVvAjmsqfkR4079oMBs+0PDxaCtVUWTR/s
	 ouLeU8g+0OkbIkvGfHrRZUhSEqiXaktwiJ2Al0DdptTmBzfQzWvhTM5M1fHb1FNvvYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=KX+TpbtE;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BB8606A31A;
	Tue, 27 Oct 2026 18:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3BB8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=KX+TpbtE
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DCE36A50C8;
	Tue, 27 Oct 2026 19:44:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1793126654; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=2FcWg1V/3aBTP3KwZYU/FI1oXS/QXKtS31y8wgVo5lM=;
	b=KX+TpbtELSQM0CG8heszhVDiIrQ7Sq2zR2SosWBHXg4On0jjcUZ3eA77V56vs15sXPp99R
	eN/5HpRu/o9+o5DSPTQcQ7U3zZABkme71lIC9e7Mw/3X2WmYHQFrmRYYrydI0641nBHfE+
	aul/cUeVrjO2+tHCRIvR/iBk8AOzvyCk3P8lJ/qzKYE6MWNPBvraZM36fs28bHOfwPUs4k
	8ZjJUI/JREdRYqMEAvv8/Ly8MYSB1lr1cnZN2FABf4Wcc2ZDhfooijMvXVF/1l+bTRJ4px
	edIfo1/O+48Zz9dsoQR8FQPbBT1BwVgFVTRNm745UAK2JoDAlEzZB0+Y8cCcQw==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 27 Oct 2026 19:44:09 +0100
Subject: [PATCH net v3] octeontx2-pf: fix skb use-after-free with ipsec
 crypto offload
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
Message-Id: <20261027-nb-otx2-xfrm-unshare-net-v3-1-31dc9d79d11d@tipi-net.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOQQ6CMBBFr2K6dgwdoFhX3sO4oO0gNbGQthAM4
 e4W3OhGl3/mzfszs0DeUmCn3cw8jTbYzqWQ73dMt7W7EViTMsMMBc+4BKegixPC1PgHDC60tSd
 wFEGoqqilqI9GEkvnvafGTpv6whLAru9hGNSddFylK9baEDv/3B4Y+Qb/7xo5cCCSCotGkqjyc
 7S9XVcHQ1vRiB8qxB8qTKqylJmWOZZKm2/VsiwvhJqGXCQBAAA=
X-Change-ID: 20261019-nb-otx2-xfrm-unshare-net-6b74a96a8d9e
To: Sunil Goutham <sgoutham@marvell.com>, 
 Geetha sowjanya <gakula@marvell.com>, 
 Ratheesh Kannoth <rkannoth@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

otx2_dma_map_skb_frag() calls skb_unclone_full() on its own copy of the
skb pointer. For a cloned skb, for example with tcpdump running on the
interface, this frees the skb and the new copy is lost on return. The
transmit path then uses the freed skb and the copy leaks.

Make the skb writable in place in otx2_sq_append_skb() instead, so the
pointer stays valid. Also do this for nonlinear skbs, as the hardware
writes the encrypted data back into the frags, which may be shared,
for example with the TCP retransmit queue.

Fixes: 195c3d463181 ("octeontx2-pf: map skb data as device writeable")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
This was flagged in the clashiko review of my skb_unshare() rename patch [1].

Compile-tested only, I have no octeontx2 hardware.

[1] https://lore.kernel.org/all/20261015-nb-skb-unclone-full-v1-1-0dfbf01f60f2@tipi-net.de/
---
Changes in v3:
- Also copy nonlinear skbs, GSO segments share frag pages with TCP
  (sashiko, Paolo)
- Count the drop in tx_discards
- The other pre-existing issues flagged on v2 will follow separately
- Link to v2: https://patch.msgid.link/20261022-nb-otx2-xfrm-unshare-net-v2-1-5590c9325bcd@tipi-net.de

Changes in v2:
- Also handle skbs with shared frags (Jakub)
- Note: conflicts with "net: rename skb_unshare() to skb_unclone_full()"
  in net-next, the resolution is to drop the skb_unclone_full() line
- Link to v1: https://patch.msgid.link/20261019-nb-otx2-xfrm-unshare-net-v1-1-ee9b24f9e673@tipi-net.de

To: Sunil Goutham <sgoutham@marvell.com>
To: Geetha sowjanya <gakula@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
To: Bharat Bhushan <bbhushan2@marvell.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 4 +---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c   | 9 +++++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 4e418c7456b7e..c441c0161dbf4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -2115,10 +2115,8 @@ dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
 	int offset;
 
 	/* Crypto hardware need write permission for ipsec crypto offload */
-	if (unlikely(xfrm_offload(skb))) {
+	if (unlikely(xfrm_offload(skb)))
 		dir = DMA_BIDIRECTIONAL;
-		skb = skb_unclone_full(skb, GFP_ATOMIC);
-	}
 
 	/* First segment is always skb->data */
 	if (!seg) {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 8d2d607bc92f9..3d38ca2402e38 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -1205,6 +1205,15 @@ bool otx2_sq_append_skb(void *dev, struct netdev_queue *txq,
 	if (free_desc < otx2_get_sqe_count(pfvf, skb))
 		return false;
 
+	/* Crypto hardware need write permission for ipsec crypto offload */
+	if (unlikely(xfrm_offload(skb)) &&
+	    (skb_cloned(skb) || skb_is_nonlinear(skb)) &&
+	    skb_ensure_writable(skb, skb->len)) {
+		atomic_long_inc(&pfvf->hw.dev_stats.tx_discards);
+		dev_kfree_skb_any(skb);
+		return true;
+	}
+
 	num_segs = skb_shinfo(skb)->nr_frags + 1;
 
 	/* If SKB doesn't fit in a single SQE, linearize it.

---
base-commit: 2cffcf1aeabb187e4f08fe4f5363128a3c45d786
change-id: 20261019-nb-otx2-xfrm-unshare-net-6b74a96a8d9e

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

