Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBD7437467
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 17:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171836; cv=none; b=hxpor+xhmlm2HpUu5MpogZ1fjEfZPOE/WNSv8CRo3aZcPLYq0WEu3l7jMsCA8JgkVUHhU2UY6z1RoeDxJgkgYWQLiv0Wsw4A9/gVemoQ9IxNlNhJ2V5DB8vrvqBJeJFs70Jwaer2947Npzb4QxK5/rMCXuEryS8G76W7nIvnCpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171836; c=relaxed/simple;
	bh=r2qwKg7j+cN4hDKNLUefgiCBELPhI/kHamWBrqFTKPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VeDwq8aM+bk4uqGHxo6+/GZ/xpXbTbsm12Hhlfi1d2Fnd5jvrPuLtKtmDZHgEAKxAj7FVllOvhnjUwHHO4broIroSPAB5xPLY/ju5LvP5N9p4m1nU+5eaPC5dbJpt1g6Z+xV1PQq8SCB7YTRgvqIvSe4Nm1w/BM/85nV1453nCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDUshk+6; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDUshk+6"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso3278491a91.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 10:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785171834; x=1785776634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1FQqBAZFhP/Xf7sj1hAmF9i/PIJNITF2uATGYHmJRQU=;
        b=UDUshk+6dk5bdsVzkNGgi9U3B4TfRSwHMqgVVOm340/d43VKblGXgW3vRWf5IzX36x
         EOb+L5VsEdDq5h3x3U6vpYkIsD4+Rnp5QqEFEenni4LXFuJLtn6QUmHjeBUgtQ8K/SFF
         UfbBPjm0UZX0+100SXylg/OZoRxKkWXndnx9WuW91P9CVolTEylVqRwC8drf8BmCpFTV
         0iOeeK9OJPjmrMt2KlR1G3lZBWM9+1v/7uad1ezZA0Xu4t/98PRu7ew40R4KgNAaLQzQ
         K/yHgQ3FjdLGfGomUbd981mB4YPM09uq9Wg6+zVAWiv3YCD3rolcM3l/sk4C7bySoQmh
         Hbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785171834; x=1785776634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1FQqBAZFhP/Xf7sj1hAmF9i/PIJNITF2uATGYHmJRQU=;
        b=RXCjla3EPsaeLj32oi9rtDL+2FYyq5aTyc4GezUz1kgO4Ez42KeeHYlFzJBm8gwO0b
         ibbVjodEqHZy2I+lLrkRamnscqxWR/QV5D9q6LoLzXu2IU4TtQU2cst8AYSdTcCjf8ir
         hOTJ4n+2b1dC+FzCyQEzRcITvhI9+Wh9i+5D/l2eqXwr7jUd8PhL/HZuLHG2as+O1nIc
         SJ3NGxIou74n/4VSuPp5uA2hroGanhOBQ8aqcrpytQ1OF6s0oAB2w3QUG4zzBee+XsR5
         K9YmCpTo4QTH8mBSuoQviE8d+0y3sCAKc9Ui2zZ/YFoNqq0nIJ3WiljVfai/kZLyN8LK
         SWtQ==
X-Forwarded-Encrypted: i=1; AHgh+RqlbziLOViTdkwtHLwY8LfcEQbwtXzaO0llKNnEd+gYmAfGuz43koBtjwWgnWsPE3CU0FXAhqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbQ8F7wZO95J7n0KnmNDzwqdbQC1dY5K1coI+l37icf6sp/CAv
	5Y/Mg2SLN9e0YgN/R2p9/7u1jTysWlyZhFfCj7dx5Awai0KMYvI5J+M8
X-Gm-Gg: AR+sD10kZqidLj9sLTmDiefvDBI48vpLiBxJEqQ7t4GgqUa6tfDH42wIgE3ZkqNLUtC
	U6IoUIEPqr/QCtABO6lCuuxjfkHpOKJFVZe6sjswy/nELuJ8yKHpSlKZqBDliAgkZgT5J37s5i7
	1z2N3P5+ItqIUzgM+SBkXSxuXiUxfFbZxSRMCBWAHPa8wrCw4TKUinP9RaFwir5fuB5dRc+bN2G
	8kXUiAkVQaYKZShEQJt3/VnE3NNUZxmecMpaFnteQdPNjzA9cpDGWxwfK18yvVXKg/4JXk+Jq6d
	h36lB8+glA1b1FQ2sYKjdZ81iUaHG/FYCfe/qguk753Yw853Xk2ueQBr9oJmi9Vz181XjemqKkj
	GjfsNkgMlBkJ96UMjylCdsqZdE2ID2sz+gkmTPeEgMPcwwAor4cL9+NyqctijHhe/1L/T6kEGmf
	0KTp6WU+hgPPLImD2dZl8ukwNIlOfrXTU=
X-Received: by 2002:a05:6a20:b598:b0:3b1:cce5:9140 with SMTP id adf61e73a8af0-3c67dab6bafmr9142111637.33.1785171833721;
        Mon, 27 Jul 2026 10:03:53 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([219.141.235.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb66e0ccdsm3546131a12.32.2026.07.27.10.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 10:03:53 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: cake@lists.bufferbloat.net,
	netdev@vger.kernel.org
Cc: toke@toke.dk,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH net 1/1] net/sched: sch_cake: validate 6in4 inner headers
Date: Tue, 28 Jul 2026 01:03:41 +0800
Message-ID: <502a543e7f04d14a15a0f6cecab30dbdf77033d1.1784855599.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784855599.git.zhilinz@nebusec.ai>
References: <cover.1784855599.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

CAKE's ACK filter special-cases IPv4 packets carrying IPv6 to find TCP
ACKs inside 6in4 tunnels. The parser checks the outer IPv4 protocol and
the inner next-header field, but it does not verify that the inner
header is actually IPv6.

A malformed packet can therefore use an inner header with a non-IPv6
version while still setting the byte used as nexthdr to TCP. When two
packets from the same queued flow reach cake_ack_filter(), the version
dispatch can fall through to WARN_ON(1), which becomes a denial of
service on kernels with panic_on_warn enabled.

Reject 6in4 packets unless the encapsulated header has IPv6 version 6
in both IP and TCP header parsing helpers.

Fixes: 8b7138814f29 ("sch_cake: Add optional ACK filter")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 net/sched/sch_cake.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 505f63fecf640..7c4d92cdf514f 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -950,16 +950,19 @@ static struct iphdr *cake_get_iphdr(const struct sk_buff *skb,
 	if (!iph)
 		return NULL;
 
-	if (iph->version == 4 && iph->protocol == IPPROTO_IPV6)
-		return skb_header_pointer(skb, offset + iph->ihl * 4,
-					  sizeof(struct ipv6hdr), buf);
+	if (iph->version == 4 && iph->protocol == IPPROTO_IPV6) {
+		iph = skb_header_pointer(skb, offset + iph->ihl * 4,
+					 sizeof(struct ipv6hdr), buf);
+		if (!iph || iph->version != 6)
+			return NULL;
 
-	else if (iph->version == 4)
 		return iph;
-
-	else if (iph->version == 6)
+	} else if (iph->version == 4) {
+		return iph;
+	} else if (iph->version == 6) {
 		return skb_header_pointer(skb, offset, sizeof(struct ipv6hdr),
 					  buf);
+	}
 
 	return NULL;
 }
@@ -990,7 +993,8 @@ static struct tcphdr *cake_get_tcphdr(const struct sk_buff *skb,
 			ipv6h = skb_header_pointer(skb, offset,
 						   sizeof(_ipv6h), &_ipv6h);
 
-			if (!ipv6h || ipv6h->nexthdr != IPPROTO_TCP)
+			if (!ipv6h || ipv6h->version != 6 ||
+			    ipv6h->nexthdr != IPPROTO_TCP)
 				return NULL;
 
 			offset += sizeof(struct ipv6hdr);
-- 
2.43.0
