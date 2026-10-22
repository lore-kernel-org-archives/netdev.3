Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660371;
	b=TzdhDLjS+fyVfTNBQtvVrLhQIbNE9seTWf0uxppIFuLxGpSDEL2azAJ8ZSL3cRjwPMdn
	 dOgWD+aqTzJO/8kEhZWF/PqipWeVGcCodETbTzp2IlUMreu4O3jx8IH+Ci13QIj7QxQb7
	 Q5pQYPPy9tVT16nCFyanCBljT9hGF9r9nfO3WiuZtB62DSIloe0Oek4Cid71q7HmpMV7+
	 T/O4fEeg/9Qw4RwZseqapBSGKlKHGVwruwc704SI20Kd3H9zQI89fDi3+vbjwBiL1kyzs
	 9FOHuODQfsn7+Td1XDZ8tPk6pVoZNUKkWinbLBPf7BBOMH7N/aDRigPBWjk4Rs/6vZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660371;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=QxIVZi956bm1gCgqK2NJrL5eCNIcMpvqgqerM8iP2DE=;
	b=pQaz9UdzZBTvaIf8MsdZvvZPkJOw0fH5Mech82fdQiHkxA6J/dO+XnfprkNSX6tRZx2q
	 z/uKoTj5sC+Ex270cMDqRDSaMkdwTOagrMM+8dSEat6XJ0uIqD5fpaNyvpZHoAjX4TsKF
	 vBAzkAwAvcF0lNKRmYyGn1YzVF2/X+q8vXf5KbW/tSsDSVo70QsQhOtQETZKFKKY3L1dU
	 QWlRrb291lRriOKy+BKSrO5yFGXgm77ttkBM93M0pO7jlARibVYlR14NSO2ATbZrqd9tk
	 9LbWaTYCIYC7uzVebzuml0R0PYFZ4YJSwurtvxeo5IdpKQ1Tk4qvE4nF2FGFtmGiqkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=F0fS+8SR;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29BA606A319;
	Thu, 22 Oct 2026 09:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A29BA606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=F0fS+8SR
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BE64BA0190;
	Thu, 22 Oct 2026 11:12:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792660367; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=QxIVZi956bm1gCgqK2NJrL5eCNIcMpvqgqerM8iP2DE=;
	b=F0fS+8SR7/eyPrVn4eviPfx+XSgCvWKP/MqEzlXKqK2yW1/fN7G+H6Pa2rQzp0ouP1Nk+q
	e3FhtUwhfzE7qwV/0bVT3fqvptQVC3GJQ/DdKksWQ0j1+ZNYhhMJ0jMnKQMUHYIyrZKXTw
	4oGNRPxOuHXNfX3CBbhxqGGYeSpO8a8anmGr9eKYSgPsR+pGLyltVNaOOUWXRjRA8qqEJs
	HzmMEssf6LgtkF/o1wT3GR2u8EjgIl3KGULH4aTF2ROkUpg86odwbD80ds7zYcSgHKb2n/
	cBpGXETJe0A4dDvZpRfoS3eZ1FpT8Og0DDYaeq4lwH3blbHeQxj+Ujmj17zKvg==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Thu, 22 Oct 2026 11:12:41 +0200
Subject: [PATCH net v2] octeontx2-pf: fix skb use-after-free with ipsec
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
Message-Id: <20261022-nb-otx2-xfrm-unshare-net-v2-1-5590c9325bcd@tipi-net.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOwQ6CMBBEf4Xs2TW0kmI9+R+GQwuLrImFtIVgC
 P9uix/gcWbfzM4GgTxTgFuxgaeFA48uCXkqoB2MexJylzTIUipRCo3O4hhXiWvv3zi7MBhP6Ci
 isnVltDLXThOk+OSp5/WofkACoPmZYbYvamMuzdjAIY7+cwxYxAH//7UIFEikrax6Taq+3CNPn
 E/njqDZ9/0Lw/6QytkAAAA=
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

otx2_dma_map_skb_frag() calls skb_unshare() on its own copy of the skb
pointer. For a cloned skb, for example with tcpdump running on the
interface, this frees the skb and the new copy is lost on return. The
transmit path then uses the freed skb and the copy leaks.

Make the skb writable in place in otx2_sq_append_skb() instead, so the
pointer stays valid. Also do this for skbs with shared frags, as the
hardware writes the encrypted data back into them.

Fixes: 195c3d463181 ("octeontx2-pf: map skb data as device writeable")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
This was flagged in the clashiko review of my skb_unshare() rename patch [1].

Compile-tested only, I have no octeontx2 hardware.

[1] https://lore.kernel.org/all/20261015-nb-skb-unclone-full-v1-1-0dfbf01f60f2@tipi-net.de/
---
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
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c   | 8 ++++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index b11389a841d15..91ebf247f5f90 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -2121,10 +2121,8 @@ dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
 	int offset;
 
 	/* Crypto hardware need write permission for ipsec crypto offload */
-	if (unlikely(xfrm_offload(skb))) {
+	if (unlikely(xfrm_offload(skb)))
 		dir = DMA_BIDIRECTIONAL;
-		skb = skb_unshare(skb, GFP_ATOMIC);
-	}
 
 	/* First segment is always skb->data */
 	if (!seg) {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 8d2d607bc92f9..b98842c7e40e0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -1205,6 +1205,14 @@ bool otx2_sq_append_skb(void *dev, struct netdev_queue *txq,
 	if (free_desc < otx2_get_sqe_count(pfvf, skb))
 		return false;
 
+	/* Crypto hardware need write permission for ipsec crypto offload */
+	if (unlikely(xfrm_offload(skb)) &&
+	    (skb_cloned(skb) || skb_has_shared_frag(skb)) &&
+	    skb_ensure_writable(skb, skb->len)) {
+		dev_kfree_skb_any(skb);
+		return true;
+	}
+
 	num_segs = skb_shinfo(skb)->nr_frags + 1;
 
 	/* If SKB doesn't fit in a single SQE, linearize it.

---
base-commit: 82e31923c0553fdbfcddcd910ca07952880ca9b9
change-id: 20261019-nb-otx2-xfrm-unshare-net-6b74a96a8d9e

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

