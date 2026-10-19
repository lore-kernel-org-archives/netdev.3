Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792422295;
	b=dDFsxifwZS4q2TMOXWLitvv+6zNGh5P0x2jhxlVprZV/yYwKsWtJjwafe0mm0WFfzyF4
	 LfFP+MfJeYfe1tHJEHSziKVx1KGvTaGxpLCqHlVgTuA7/7Ng+G55YFciPwQTG1DDZSbHx
	 uUFwEtVEAMpNq1Zhdi6lehqkv2itN7T38en1bEZ3zhf6wTbENykDiLwRvmWz1T05XbfZp
	 +scxQNuvOqT8iqkK4lNZzGRma5neiF63Y+SD4IXGs3DfoDEcRMTQ7Kzk7gwSf2q0zh/vQ
	 7xC70nAgjMApTHabgV24Pm1R/TsbncQOIltj5A5D1gYQudiC2MhjYjdlWOb5FW5JBEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422295;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=hjfWWiygq4BcOun1xAZcYKOZm9JHKP7th98H48+Op7Y=;
	b=R/pPvzY3syJcGTbwrL/uzDIxpmfkVPcAGrtPjBeLapFaPeZ95CaRU2e+I4wVd+SlGL07
	 ENpuNt5NeUESPrINgiK54sDTjg7OSaDDwqVq6qXoispiAiucC8ByhwRzAr0r2fOMIOTYE
	 t+AbFmDFVoD70687GEoySwJrMIibqLl+XAcZiH0tIPdWRcy6Y73kHS6hJZ3QC+AOu3a+p
	 tDTYZBt0DaKHDFBrBsJuFoaNdjWUmaXVgs8d2IuXJAt0AZ7fBVL3XLL94TmZvBmgXmBhj
	 g4vFpP+LlGNLEinMGh6T3fqmKzrSzVLedNYYzGRO38HmrXttG1cpXfvmIIbFAAvLM/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=c7YsW39+;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434FD607F4A5;
	Mon, 19 Oct 2026 15:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 434FD607F4A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=c7YsW39+
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 88DFAA1605;
	Mon, 19 Oct 2026 17:04:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792422283; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=hjfWWiygq4BcOun1xAZcYKOZm9JHKP7th98H48+Op7Y=;
	b=c7YsW39+2dwR9Y+MNW2EiZMRqKLN+oRhawDLOxPFWHG6hWtgbENBTh1E41D6fTTRZYptKI
	1Xwy1gez1j7e8KAJqzfWvOgf+Q+vzeNAJOY9ds/rp1uDC6W8ssRYRgsD5pKEcQD4BjJbjC
	9bXzcBwE9J8N2Hu2QbZvHmP2zYJ6mkKHCtFyts97kCrQ0FSfRdru8/xDFaZf1jldCPl5c9
	kVe14FZzc7cUYC506PgH3LlY5aI8I3XPbFEAR14oLTy6ejuEyM8EpQh7T2qC5WBQuJviNc
	7wWNF7gq1LkIC+NpR7burT4OTXf/NXdiaCYh2hrLDgzxxQLv76AJV0A7ILunFw==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Mon, 19 Oct 2026 17:04:33 +0200
Subject: [PATCH net] octeontx2-pf: fix skb use-after-free with ipsec crypto
 offload
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
Message-Id: <20261019-nb-otx2-xfrm-unshare-net-v1-1-ee9b24f9e673@tipi-net.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMAxFf2Xk2cBapFp/RXxot8xFMJOkk8LYv
 1v18VzuORsYKZPBpdtA6c3GizRwhw6GOcmdkMfG4HsfXO8iSsalVI910ieuYnNSQqGCIZ+OKYZ
 0HiNB019KE9df+grtALf/aGt+0FC+Udj3D8iXE/GBAAAA
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
pointer stays valid.

Fixes: 195c3d463181 ("octeontx2-pf: map skb data as device writeable")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
This was flagged in the clashiko review of my skb_unshare() rename patch [1].

Compile-tested only, I have no octeontx2 hardware.

[1] https://lore.kernel.org/all/20261015-nb-skb-unclone-full-v1-1-0dfbf01f60f2@tipi-net.de/
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 4 +---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c   | 7 +++++++
 2 files changed, 8 insertions(+), 3 deletions(-)

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
index 8d2d607bc92f9..4a20d73d27c06 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -1205,6 +1205,13 @@ bool otx2_sq_append_skb(void *dev, struct netdev_queue *txq,
 	if (free_desc < otx2_get_sqe_count(pfvf, skb))
 		return false;
 
+	/* Crypto hardware need write permission for ipsec crypto offload */
+	if (unlikely(xfrm_offload(skb)) && skb_cloned(skb) &&
+	    skb_ensure_writable(skb, skb->len)) {
+		dev_kfree_skb_any(skb);
+		return true;
+	}
+
 	num_segs = skb_shinfo(skb)->nr_frags + 1;
 
 	/* If SKB doesn't fit in a single SQE, linearize it.

---
base-commit: 78731b46967e3e7102b5cd5062bef185f3404b5c
change-id: 20261019-nb-otx2-xfrm-unshare-net-6b74a96a8d9e

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

