Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40663220698
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 00:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309239; cv=none; b=jGN6K1R2wOgTPKx2rnn/56+j+APA1iUGrFOo7VIjIk5Dy5XJmJCoj3H2Bbld3wU05VQcT3qq8XFeFcY7JAfPoCLqpEWwaIIvRQlmgj+iWBB7z/fY/pWGv39eW+FpZped/glK+Hw9Bic9Vl+/SZzgABc4wr2xi1trnMgq8GS9NBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309239; c=relaxed/simple;
	bh=jvk0tuhP8pOsYu8HEosKaxxVLoLxepaw7AP23syalCA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PWkZ1I2WU/SKuBp6ARU7MU3Fwa8jJ/6OP8LdRCoqdtt/MNxIcMxc5Hq3v3+TTBkbSEJYhLDiitPFrs/BuF3ItQU2+kTF9zmgE5Ey5P/+R7sObDIYkF4oNRxMfKxg9gJqaMNST7vfw0a6EdCsvlRYQUHVrz1PiD717jpDsf2WxK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qk6MoX+f; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qk6MoX+f"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-930b571432fso87429785a.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 17:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788309237; x=1788914037; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AKRDHPn2dcMjZgfxzFhIk1cFF7pvajmCXZrSLf7DlCo=;
        b=qk6MoX+fzK99BQixgNxXhyep89R6/hNQulQs4yHv8fqLyGzwBymoQfpZ/XWFUziEJU
         +5CZJAcDqz3nZyvuYVPnLA1fLcZgx8a5C4Y2Phtfm0iRly+mYnUxW6euiP13uBv9uJP1
         VZx7gJfG3KlrZjRAui1KdCD0M2tBnCqOPLglYGEyqZO5vL5a0HSlRn/Z23QICmDz4qZ7
         5NkdbCQNjICYuFtfyw5hHT8mlCPUxEtY41H7naY/x/6xqwFQ/BNOYy6YfpTkYPrkaJgT
         cmywNIub9qhewF5QQmwfHvPXEJ2tIxAoMsq/Ka/j8JS9801dBN2KcT7i54rcHiJ3BIyn
         3H7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788309237; x=1788914037;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AKRDHPn2dcMjZgfxzFhIk1cFF7pvajmCXZrSLf7DlCo=;
        b=HKu0ySVXQDFO8GupF1J98Sp71AeycYWg4vwhkOje1Hpf+4xDZoc9CcgLPMqKEV27+x
         iCrr54OyNopWlSb8n9kSCSa9VJ+EM1f1aZBj1gz+T3IFns3r2W5aIpgt9skMPNbIyZnN
         9Sdrzn7ops9Cp/bnqfzTCEJnvpmCEWAeXBitI5VNuUF8qRR9Xov+r3bOT5MJ9hPQjTpk
         32XzFtBWTz9zzDgZcpt5yCgTpkiWswl2mDiEPRKD1cF07yTzhDJI8kuWdZaExH0kO4xq
         F94v+jam98iHOArvr8BWXgvvR7atAmtpYWgAVPv3RTn0pX5YaCT8b9qDHMyuJGbaNDWc
         1nlw==
X-Forwarded-Encrypted: i=1; AHgh+Rqh/bgser6kltcrT2XR9gWbh1Ip/WlNbOUB/22qfacHARsy6AamOpvz7cT9PX5UeJ4DyGONu3U=@vger.kernel.org
X-Gm-Message-State: AFuF++lY5HUEghxntVbAmyA2AIrxUb4689GiP6xS8yw99N6bLSf/PJw2
	x7/NqIL40KTCup3z1L/QKnPisdNHyYPriHqXduvJbIs/OI0bEauHBL42AZ3w2KbtDw5V8KABE4m
	4hNKVEYG/NXusjw==
X-Received: from qkpi16.prod.google.com ([2002:a05:620a:27d0:b0:92e:6cd6:d114])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2286:b0:939:a45:8c96 with SMTP id af79cd13be357-9394bdf428fmr1020710385a.19.1788309236781;
 Tue, 01 Sep 2026 17:33:56 -0700 (PDT)
Date: Wed,  2 Sep 2026 00:33:41 +0000
In-Reply-To: <20260902003344.1931843-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902003344.1931843-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260902003344.1931843-8-edumazet@google.com>
Subject: [PATCH net-next 07/10] macvlan: do not assume mac header is set in macvlan_broadcast()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We should not assume mac header is set in output path.

Use skb_eth_hdr() instead of eth_hdr() to fix the issue,
and remove now redundant skb_reset_mac_header() call in macvlan_queue_xmit().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/macvlan.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index afad90b9222a287214418e93221d569d4d83a1a6..62cf0f6922168984249af647338102f1a8afcb25 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -266,7 +266,7 @@ static void macvlan_broadcast(struct sk_buff *skb,
 			      struct net_device *src,
 			      enum macvlan_mode mode)
 {
-	const struct ethhdr *eth = eth_hdr(skb);
+	const struct ethhdr *eth = skb_eth_hdr(skb);
 	const struct macvlan_dev *vlan;
 	struct sk_buff *nskb;
 	unsigned int i;
@@ -424,7 +424,7 @@ static void macvlan_forward_source_one(struct sk_buff *skb,
 	len = nskb->len + ETH_HLEN;
 	nskb->dev = dev;
 
-	if (ether_addr_equal_64bits(eth_hdr(skb)->h_dest, dev->dev_addr))
+	if (ether_addr_equal_64bits(skb_eth_hdr(skb)->h_dest, dev->dev_addr))
 		nskb->pkt_type = PACKET_HOST;
 
 	ret = __netif_rx(nskb);
@@ -557,7 +557,6 @@ static int macvlan_queue_xmit(struct sk_buff *skb, struct net_device *dev)
 
 		/* send to other bridge ports directly */
 		if (is_multicast_ether_addr(eth->h_dest)) {
-			skb_reset_mac_header(skb);
 			macvlan_broadcast(skb, port, dev, MACVLAN_MODE_BRIDGE);
 			goto xmit_world;
 		}
-- 
2.55.0.966.g6673acef38-goog

