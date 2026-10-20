Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792466478;
	b=uw4H8Dbtc/Tn+MnlYkUqE+/Cj4UjaImhN1rQZ1QjDOtUiT563BRyHurpvio0WXlvFYOD
	 bIUFIhsK7oHKbW/oWAMAl6nuRGpJZflqD7t2eR5CSE0XqoRB8e/1QATGyR2kKd6oeDQhR
	 7G9Yyk1yC+CwneCRYb9AQ0z2YnjkCsdHN+oPuqMTmY0q39di+77Ny78qatllsprWu93mC
	 Vi1K3j1zCygN7r7QtkHUoNcXKTXGbVnB6p+vqFOoLN4Fvh+SIHJLA17/DjgtG8upKeol0
	 Z6jG3pijkw0p/ex2ieYI3d4KrgduiKSrTHQdwwbrrNqA+jGjAbw3Re/FPt+iYobDPPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792466478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=4tZxpp+089oOWZ/j1pBNYKk2bhLi0zT2CtLcIYuxpeY=;
	b=u0CUXCvzeefXZmzx5B3FW8fe0MDP0Nt3+lAcJc5fN0FIow9I1RZ3kjJJOKKf4PF4g4YZ
	 7yt9OiHn+zVk+AIy6Zu/tyiUiAVwzBc4ADstxYrqdiegnmjzeB35Iikb485s41nEAGp4Y
	 21teugFvthRcbO1ptno++/5Atlx9x5NaW5HjgAWua39kRejau/sJAf4MFk3wJGFRc0+37
	 1mFTcYQeFt+ssMr2YdYGyJYwyYPdNZFvvhDZjF1MxYM3s/wn8munZnyOd7lxWtDlBnHqo
	 43Uhbo4cnHcKNVVs8F0+GuimL174TVZJSgh7gUpK7JGOc7NspD4KZW+2EGuSkATcFHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BRtSoaKO;
	arc=none smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F634606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 03:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F634606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BRtSoaKO
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7cb6dc850c7so676860137.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 20:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792466477; x=1793071277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4tZxpp+089oOWZ/j1pBNYKk2bhLi0zT2CtLcIYuxpeY=;
        b=BRtSoaKOydHwfJyCkmFj5T2kYVZl7JK8/TS1jWP9uU+XD8EcFbPEwzlsKZSeUsKh7O
         UoVjhnNX+f3wlpE76P2FrvHneA8t8yeRtUiL1lDxxuvmHyyjVRdk6BFaoogAPpPeRR0L
         rVcbon2LHtUUiiE9LpWG/3vF6lmkNzNYAmkmWkQETJcVow2ytZTbtKJpONH3T/tfaHC1
         7NtSFJQcCKTdXH158CKnS4V1WN/UsHJ8FFLUinqINbo9MLyQC+bSeS/A85GCwBaYyaCc
         qkveW+hlKg192GpqnvDYEHq/z76LU+6Z25/zP2hPrRp9VvY+yOLSSY8jzxC0B8ImQCNP
         37/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792466477; x=1793071277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4tZxpp+089oOWZ/j1pBNYKk2bhLi0zT2CtLcIYuxpeY=;
        b=t3+pqmrG+yVzz4DFfDFESrU62Wc+PRLu3yEnDBEBboxN49P+aT38HBcB6nrbZcNO5h
         8+3QLl4VR+6ia91SSIYyji2KIsJHS8uBpFMAnPdkhgxXDNo2cAxe0rDK01lBPJJ1LiHN
         Jj5GQBePU6MnzPiS/G+DUZRGU0U8B5bE41WJ4Pz4I+BqlC9V4z4rOUngoy6jKkv9NbOT
         +QgGAv1JWlg8U6ZjrdDEB7/vHIYumAjr/+WMt7KzLP9130ilqVkubip4VD+0VUUU8ut4
         u1qf9vRBKji7d89iOVd69/Wiw9gvukhh5GqpGa93kpsk+Fjqc5TPiVt0n8TiPSARV3Ci
         b/6A==
X-Gm-Message-State: AFq9FYLyi1PCqdNqIekRXtYqDmfhYmCZz5y0goaShVWtHawqHWxsNjJr
	XpWuRgPIargxfIBYfDs7MA8yjjkBVQ7kUF63kpuhJ7fv23o5+mNxJApccFLDHw==
X-Gm-Gg: AYBFou3j+jHczWC9o9UcxhMvejmKO6CPBcRBrQC/yVk2o2C7OPOyGOei5een1TJgXS/
	a7RZMDnh6Wm5BcTOS5+H3+hvuq8/mX4vTsDqAIbgnjIpWf1YEm52QWK37pufxdIyLpZkGaa2xid
	rqUrDPtruMH5S93k+IJq3MkvK+QeoxpwBsryAAm3xryLnRgsSjch3g0yI0F/+uBN9rcTKnHnVC/
	B+wWTGOxSWxBlX/vYBALeHWsDhdtlvC8uGWlNCb5WrdGXuRJ00uKuMCx7viLIYlbCHlnFwFDM7B
	BZD2ekGRrlCIVOzraP1/+1rxuhsNwljbNDkqHnVaIHYY7+OTl6hobZa5Hl0JywCYK88HCCHrVMi
	2jKX5T2g9aPiKEpdUbJ4DxrimzK3HdBz6NfhezxHJpcT0k2Ax4aUsxYJ9GRntSff7/h0s+HPLzT
	mRyeliESlcmPv/lQR2ICMRuh+P9FnZOtQdz/Q3mudrncVIgt9vjWTY/U3RgeWU4F7OQaHadE2Nt
	F3cfrs6pe7JCsp+zCdtTFnXqPc/lrpDnl1HCGI/5/+axTsAqyYve9B1fblJvPaJbC36zWi6wdcF
	qpErKY1lB3RPs7/LQepZl3TIo3H8TGcw5Udyam2oZXVBmycuOvkj6rwaH/cr
X-Received: by 2002:a05:6102:4191:b0:7b1:6028:5475 with SMTP id ada2fe7eead31-7cc368fe63cmr2530388137.12.1792466477208;
        Mon, 19 Oct 2026 20:21:17 -0700 (PDT)
Received: from willemb.c.googlers.com.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cc77264634sm1792210137.9.2026.10.19.20.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 20:21:15 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net] virtio-net: fix frag overflow in big packets receive
Date: Mon, 19 Oct 2026 23:15:50 -0400
Message-ID: <20261020032108.81879-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

In big packets mode with guest GSO, add_recvbuf_big() posts a chain of
MAX_SKB_FRAGS + 1 pages. page_to_skb() copies only ETH_HLEN of the
first page into the linear area and adds the rest of that page as a
frag, then one frag per remaining page. A device that fills the entire
buffer therefore causes MAX_SKB_FRAGS + 1 frags, writing one
skb_frag_t past the end of skb_shinfo(skb)->frags[].

Post one page less. The buffer still fits a maximal GSO packet. A well
behaved device does not trigger this, as GSO packets are at most 64KB.

Also check the frag count in page_to_skb() before adding any frag as
defense in depth.

Fixes: 9ab86bbcf8be ("virtio_net: Defer skb allocation in receive path Date: Wed, 13 Jan 2010 12:53:38 -0800")
Signed-off-by: Willem de Bruijn <willemb@google.com>
---

The "Date: ..." in the Fixes tag is literally part of the subject
line of commit 9ab86bbcf8be in git history.

Reported by an offline AI review of a related virtio-net patch.
---
 drivers/net/virtio_net.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index daab43ac92ce..cb7ed53fd55e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -906,6 +906,15 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 	}
 
 	BUG_ON(offset >= PAGE_SIZE);
+
+	/* The first frag starts at offset, each next frag is a full page. */
+	if (unlikely(DIV_ROUND_UP(offset + len, PAGE_SIZE) > MAX_SKB_FRAGS)) {
+		pr_debug("%s: rx error: len %u needs more than %d frags\n",
+			 vi->dev->name, len, MAX_SKB_FRAGS);
+		kfree_skb(skb);
+		return NULL;
+	}
+
 	while (len) {
 		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
@@ -6717,7 +6726,8 @@ static void virtnet_set_big_packets(struct virtnet_info *vi, const int mtu)
 	 */
 	if (mtu > ETH_DATA_LEN || guest_gso) {
 		vi->big_packets = true;
-		vi->big_packets_num_skbfrags = guest_gso ? MAX_SKB_FRAGS : DIV_ROUND_UP(mtu, PAGE_SIZE);
+		vi->big_packets_num_skbfrags = guest_gso ? MAX_SKB_FRAGS - 1 :
+							   DIV_ROUND_UP(mtu, PAGE_SIZE);
 	}
 }
 
-- 
2.56.0.212.g129ede20d9-goog

