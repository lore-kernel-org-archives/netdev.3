Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6BF3115BD
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 09:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790759316; cv=none; b=jDHwDEQXVAUyEo8LDaxQPQptpVIfCXepfqBmrHRpAMZrlgLbmT9Oe+OXxlDZvNmKsfT3y9IZfS1vu73aCxG+5nPHmMLGkP1dQSY2TeKBlsLQ8gA9xyrzgtOvGhFlIW0YCF7eUZbFmYoG5RvDof/nwqCdIbQMKnW9or49AuPVJBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790759316; c=relaxed/simple;
	bh=klHR3Nz1rOxOJcII8MzfQqNr3V+0jjXpVJhwXg0YAAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dqx8IpY/LtavOEcX0zm80hTtkhGukv90DfDa1ZHP1G72Wy9VFNjv5UGXaojt8J/wXIyodJBMKozz2Mi61dwXzyEWJ1XhoVv5C0rfB6qZT90OGaArtsZ55UVsTsUgua2rlduRcq98MtbNL2876XYd+v9afTRgewiDMgNnkvO6RxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLW+iix3; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLW+iix3"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc7661e6333so394436a12.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 02:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790759314; x=1791364114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RauAE0NRM4GJcc7YyYfV5rJWUGqNP6yplYq/ttNj4yI=;
        b=dLW+iix3OPMpUaNNChOOC7NqnjCA4eEndHm8Bhs3j7903UYNA4EwW8aC4cPeNMM/YS
         yLopxAhKln6dgbF5XyccvjhAEZJWyuVgv4N2t1Swhg5GjvU5MiIydWw9JNLj7o/LFRXW
         Inj/bWN+mu1YTt9VtRFhMUhVbp+wK+wZpe+zQF+3O1WYn/nepwuEXKyoQuc45GRdVBlg
         JrqxGHlgn+akidbDAgzER4cEcodmxQFPFRn5+14dzpEaDPY2w7HKi4FcX5AfCvZ7zrEb
         NiYptHgrq5dNqvrc67uKPXpBzCAq0emKWzTk2OQuyLswxkZtYPMztQT5QpxUxtxbGlkt
         A8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790759314; x=1791364114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RauAE0NRM4GJcc7YyYfV5rJWUGqNP6yplYq/ttNj4yI=;
        b=0lkfVcFnh15itZJp6WOz5IrScYYzWOuRFK2jYE8LxDArViHVr2BmrGKRt9aJaMIEWO
         48sv+ZOZgrXPJ/RDHvs4PeT1xuHRrcdGpXhHUJhLtLe8ArZ3jYPVB1foy0EshnWY7fZo
         n/J7v6jtoPsiQyDSswcW5adqWNrQHE1M33sh1K0NojT1FbKO1UM6iXq8QWJySBWp4kLj
         BKXqRhkFve4R3XFPOdh0ODaSYeteTIuz44fLup2NEj6YVO7urvkK0uwO60VimR/elOIh
         5H5r7h+03szRMT1aJ3bX7Rw9BxE587Pnn9CcONc9yzDEc/zMGJ6lK2B9HRhAxy2wrYII
         xJTg==
X-Gm-Message-State: AFq9FYI01WvLbueQXKS0I2X+OdTqHGqsYwM8tuUHjXh7iBXaV+XUrfGz
	Dcj+LNpGL+DSnOvakGfkqGGzSCIIsGdcdZW1GIjrRod71Ek/nvg+mrqMlUzJV292dEw=
X-Gm-Gg: AYBFou2fqEagliTgKnHhtNMuJJh43HykoNLOagXjAGmWNZ+ygkmc4IjBaBJIFCqmDgL
	OK2hzVO5nShPlJh3UyW9tfL/z7NWhbFU32ODrve/vwLKEgOPocYs220sZLL/TJjI4HXaNCVsBhZ
	LNqZyA883jS/OJD7lwhDmMttPlt5Cy334FByDcuWIOmeTP24dPVTpWxjp1wFYp3kq3q7SVc6fqx
	jDMbB6vBIvZ9BacFhhw58Yp8h9zNWZJ6x5FaJlH9Je8/jgXD6BZa2dwvsXRDWWIeFOm8B+lOgRm
	8hZpGQjI0iocSLCpdZqnq+KVCCs6nLCy6WCHlXXyH00s+R7ADWw+ko5pxfPCkJzSItSBo+4Xji/
	dbuiourBd9V2rBAECQOrQNXTzTTHbIW36BlPAvia566+Hyf8XvregaUlIBZ9kYSAkWWjkk/zwPT
	0rmJhRF3aRqjL1iLcOaFFVsBtYiJAmfKrT8QmV0h0h5g5cVqosZrmrbrB8TjlHCxYUOHkRdWVP3
	1PBvXbbweQDi5CPSUi5jLI1gDY2MqNmSxjKvnekPEUcJLk8dPtCTu0+p9Mnz+iGVIC5mjyw
X-Received: by 2002:a17:90b:3849:b0:398:bad2:c10 with SMTP id 98e67ed59e1d1-3a4d195e1b9mr1107369a91.6.1790759314478;
        Wed, 30 Sep 2026 02:08:34 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cac328c6sm2578059a91.12.2026.09.30.02.08.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 02:08:33 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au
Subject: [PATCH net 2/2] vti6: fix tunnel device use-after-free across async crypto resumption
Date: Wed, 30 Sep 2026 17:08:12 +0800
Message-ID: <20260930090813.73901-3-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260930090813.73901-1-q.h.hack.winter@gmail.com>
References: <20260930090813.73901-1-q.h.hack.winter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Same issue as on the IPv4 side: vti6_input_proto() caches the tunnel
pointer without taking a device reference, and vti6_rcv_cb() runs from
the async crypto completion, after a possible device teardown.

Take a device reference while the pointer is cached and drop it in
vti6_rcv_cb() after the last use, like the IPv4 side.

Fixes: fa9ad96d4905 ("vti6: Update the ipv6 side to use its own receive hook.")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 net/ipv6/ip6_vti.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index ab94b3a4ba9c..b53830d5cf54 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -322,6 +322,9 @@ static int vti6_input_proto(struct sk_buff *skb, int nexthdr, __be32 spi,
 		rcu_read_unlock();
 
 		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip6 = t;
+
+		dev_hold(t->dev);
+
 		XFRM_SPI_SKB_CB(skb)->family = AF_INET6;
 		XFRM_SPI_SKB_CB(skb)->daddroff = offsetof(struct ipv6hdr, daddr);
 		return xfrm_input(skb, nexthdr, spi, encap_type);
@@ -355,10 +358,14 @@ static int vti6_rcv_cb(struct sk_buff *skb, int err)
 
 	dev = t->dev;
 
+	/* Drop the reference taken in vti6_input_proto().  -EINVAL/-EPERM
+	 * make xfrm_input() re-invoke us with err = -1 and drop it then.
+	 */
 	if (err) {
 		DEV_STATS_INC(dev, rx_errors);
 		DEV_STATS_INC(dev, rx_dropped);
 
+		dev_put(dev);
 		return 0;
 	}
 
@@ -387,6 +394,7 @@ static int vti6_rcv_cb(struct sk_buff *skb, int err)
 	skb_scrub_packet(skb, !net_eq(t->net, dev_net(skb->dev)));
 	skb->dev = dev;
 	dev_sw_netstats_rx_add(dev, skb->len);
+	dev_put(dev);
 
 	return 0;
 }
-- 
2.54.0 (Apple Git-157)

