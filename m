Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233892E7375
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 22:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781129781; cv=none; b=Qg/mNkSz+lvl24rH3oLFRKv5jXOczdYHg+iCYNeHpF1xuBydIePFl1OuSh6MXfNwBK503bpqk/wJkHNQ9l2znOM73K97P2MwlJvLYM/E8BwBJmUz83AFCzq9M8j8MKqfZLw6IoHYb4/trEf6IWeFTxGL0Xcmt8ccDtEBePEXLRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781129781; c=relaxed/simple;
	bh=sA5wDrFp+CIULT1bCPxy5eyB03Jyi7VOtlavmBqnXaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SfiwLzKVuGmB5O/8QVTjYJtJT9yD0zreMwnLFxqjMRTe1yQ9p7EOBKlOFhl4uSDFbbYf37ETrH/ru4y6mbRaY9TIE20fFeFC7n3c3oRhFKncjgaGDOhtBD0nFYA0A+Lx6aItCB3PRmlfhNGKtHr5w9nQN/EqypN0CBiIvK6dS1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=maoqxLO0; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="maoqxLO0"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36baeec21dcso4763146a91.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 15:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781129778; x=1781734578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AnoVRF6dvwmy9F0C12un1rCKf6ehebtbYfYrWq+XNsU=;
        b=maoqxLO0+siIgAsGky2xHKpnv/2zus5g0orwzvYOzBksAPuaY3+KC5A8L0xB+qrSK5
         U9UQ/sVPLG1s7IqzD0AMyRfdi4eGhFAHKGN6/uxYvujjzoCR93Gntn7Yde4VAXR9sKtv
         6tXhgP5gUkRxLiohviaky0kBb86CAQZ0vohVg+XciqQYquW1BU710EApMlfypH+Ussf6
         Lvh30Lp9fT2ZxwBeR4hXrpTVhUBCJk48vwXnot2rbLvqk2ugDi3B5UI02iw5B4VEO9wO
         UKc5H0OulDGo23N3qxk2uDL+JarPd5qiqrfOVOFhvid7VetAs7KuvXmUIZ8d2H3VJKZT
         ulrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781129778; x=1781734578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnoVRF6dvwmy9F0C12un1rCKf6ehebtbYfYrWq+XNsU=;
        b=ZCiYRhBdje54Tu42t7FGPsFSBy7O5vKIckOYcL6dLJCsWzc/ywfxPvt8rmOkznOOfE
         /uvzVTF4A4OORAp1ssWarMrOS3Jx0AimS33kp8r0z70US4rnOtxBhivwHLCiDAoqGkML
         M8+eaqzOu5oon56VZlrCmjPadai+/YZbFFziVim8IISISoaYcIMoQTwgsqaEWbF7hEqS
         9WdBH8XwdhMhgsCle54gKiqFNBsrVGvLidPkr2Gz+4/uYxBGAvdYJNhLxKDCJq1qTfxS
         ija2hj44gpG/NzyaocMp8XE18S1CrUD7L+S/C6Q3IlNNf0/2IFKo36HnvNvF9kKSRLXh
         6Z+g==
X-Forwarded-Encrypted: i=1; AFNElJ/5b7jdQSsyF6vVkKgrpggWDV90d21QTMIT3JLEN37yHlvRna/0nAexwIpW+78Vb5UUPrqdmNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2M/U9TCeViNN/8GM5s1VRG8CH7vqIlaHbZ5DxotiSVdetySRq
	Kifxl0BqbhmdNP88yIATwPi0DbdBZWG8uXvbkO9FbPZLUdpvLsUSCb2UFsojz+EwGg==
X-Gm-Gg: Acq92OFKqloPdnV+yisLyFLtmXG5sMRI0RSUeQpmreS8algOMIB8HhU9kij4cMD4qxN
	EeG62SceDY71yckZJYfl10VnGI357RD2IueZQ110ZXoIbByBc5p4deOoD1v9ZHlSk+/moFf9dQN
	HWtavxr0mjpMLjHiTTT8vjZtDn7dN1x+rH2Bd83ZroTEp2q17szdfygC5ej7/1a5kIMilb6LMJV
	zRvi+QiCtoJLIEeZ9ildgW3KIuzpRSp2Bc9ysdtgwFRktN8a5BcsvJ4IicDI2lHc0xE0FWwA54L
	sh33SuKg4HtYwlJBdZ3rTPF0A6mI6qhR4busO7gVlXKet08lcOsFRjDyeNdX2X6UHwpJd6jfghj
	Q2fsDnrwFiScGliCkjKlXODfehtWsnrkSJMZ9Zi1n9yb29rz0aIWpWclzP148dsTwwPvgLdC1Nj
	fHx3L7f28wqaEWIQXJftU=
X-Received: by 2002:a17:90b:57f0:b0:36b:71e6:3e01 with SMTP id 98e67ed59e1d1-377a4d95a42mr152613a91.16.1781129778354;
        Wed, 10 Jun 2026 15:16:18 -0700 (PDT)
Received: from p1.. ([2607:fb91:1582:d2f1:7bbf:a7c4:749b:120a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3775549af53sm356019a91.11.2026.06.10.15.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 15:16:18 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	minhquangbui99@gmail.com,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] virtio-net: fix len check in receive_big()
Date: Wed, 10 Jun 2026 15:16:06 -0700
Message-ID: <20260610221606.1091465-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

receive_big() bounds the device-announced length by
(big_packets_num_skbfrags + 1) * PAGE_SIZE.  That is still too loose:
add_recvbuf_big() sets sg[1] to start at offset
sizeof(struct padded_vnet_hdr) into the first page, so the chain
actually carries hdr_len + (PAGE_SIZE - sizeof(padded_vnet_hdr)) +
big_packets_num_skbfrags * PAGE_SIZE bytes -- 20 bytes less than the
check allows for the common hdr_len == 12 case.

A malicious virtio backend can announce a len in that gap.  page_to_skb()
then walks one frag past the page chain, storing a NULL page->private
into skb_shinfo()->frags[MAX_SKB_FRAGS], which is both an out-of-bounds
write past the static frag array and a NULL frag handed up the rx path.

Bound len by the size add_recvbuf_big() actually advertised.

Fixes: 0c716703965f ("virtio-net: fix received length check in big packets")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 drivers/net/virtio_net.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f4adcfee7a80..afe73eda1491 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1999,15 +1999,17 @@ static struct sk_buff *receive_big(struct net_device *dev,
 				   struct virtnet_rq_stats *stats)
 {
 	struct page *page = buf;
+	unsigned long max_len;
 	struct sk_buff *skb;
 
 	/* Make sure that len does not exceed the size allocated in
 	 * add_recvbuf_big.
 	 */
-	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
+	max_len = vi->hdr_len + (PAGE_SIZE - sizeof(struct padded_vnet_hdr)) +
+		  vi->big_packets_num_skbfrags * PAGE_SIZE;
+	if (unlikely(len > max_len)) {
 		pr_debug("%s: rx error: len %u exceeds allocated size %lu\n",
-			 dev->name, len,
-			 (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
+			 dev->name, len, max_len);
 		goto err;
 	}
 
-- 
2.43.0

