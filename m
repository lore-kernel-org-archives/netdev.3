Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF233E832B
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 08:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791621589; cv=none; b=V7z03qK+yd9MbkDNOiCO4mCS2DnKh7twzlnlKsWcbKD8Y4/62Wtmr1TipLex9b99RxrPyoBLbWRc3OKao2n/EXpiDXpUVgyz0hn5gMkBXKbFWKRr5VNc8EwSRRZZ9+0/MZA8YTN9N3OjO2Fydr18my/ABmhJUKfKaVF1rq4MS8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791621589; c=relaxed/simple;
	bh=XSN8hnZDdEF8E7qEmVyNQTNlDKZ5mQTQiUCfNpNTAbM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S30C3qmyrGQ3kzxc1veGyN+scNkdZeATLmtIXYq/tHOhCorrgfe79V2j41z5qeQNq7p7b6sYZc3WJUAaUXw1xiUgJeaet1q3NqrT5I7nmX9S3UJhCF4k0oTX+sT6w+ML2zaOjfZ7RTfq5sylC6S/oSdeT1y4ZXdcRZomzEaWN3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gTlKnWyz; arc=none smtp.client-ip=74.125.82.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gTlKnWyz"
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-139b62317d0so2328870c88.0
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 01:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791621582; x=1792226382; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7wl16BeDJDT/ZGI/NUaqDwRoHBVe8EzXOdli6uHqLZw=;
        b=gTlKnWyzZvKqKqyeSAXXpCToduzK4uqUjwKTtXwZ4ROqA+VKZSHb3eHbvHUy/u43LI
         dzxXm7NGk9qKVOf8toPc/rQXmZbZB3iY2TRAuJf9zyt0wQRpBVrZWFuutagOcvoLyRTg
         IM0WEqZ7efcoRoMvrSt1oy/1LzyxFD1AS09GUp3v0e4FwfUvrItA4EANdQlnnPbUhpRe
         TF7CCBIr9Ar6BOS6JNZQE0qnEi7mBsYwO4jaEjQyCTdlv2atO6AWH+6a+oHCDNNgsB0L
         QIhOaz75YG59JmWxjRnhio8HKo5Lc1Gs01wtQ+KyrbWi17s06VdOfFAO51V8MjCozC7K
         hy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791621582; x=1792226382;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7wl16BeDJDT/ZGI/NUaqDwRoHBVe8EzXOdli6uHqLZw=;
        b=U4q+qW/T+au9dn5IPZ1O3aIE8VSOVu4uCx8QgqDv2y1BvvAlhR0oDRuiow2AINMwZi
         rYTpmAVQVDavC3iwyaCPVYNKaeGVGE7vzYz4ljPJRKpZT6ImCNBHpSayq1+fc4jGyqWw
         Xg5WyIrH48jvkykqnQSMWilWu5YDNUALUqCQqdbefSgXTu6zi1/Q0heV0kSne+YSXVQE
         Xx6SBT1fXsITPbUv6dPOJqUtObpZPYRX3mfHnFhbFKbVwvjWnYo+eXqUEV4nM1XUBvLi
         f1lBrNpad4da8kqiovJI9c/VGW9HebPixd437zDVSv3I1MWnh9hEd5T+NjN4GFevE3jV
         JbbQ==
X-Gm-Message-State: AFq9FYIZ90fC76SwXAgoQk2Ycwl5VgdPaQPf7yvq0luxLWm8vUcUHIUt
	x1I7U+4SsNMp9Be6FdTXeWVbGKoi2HUOJndSH6+AzQnlxEfqKKh/6AYqOSdzxKETm0jOm3+idRq
	mDBmtBfB33VbwbUcCtbka5b4ULX57cDx0qsDZCeE0uAP6Bbz1pkKkO4R7Sf0wmrj8QIlkVSUuOl
	sbjHIV3Bd0IEGSiMqEY8porJaxqiViOdv8FWkqjJa5ksjY2fVzewdTCxuoequynAM=
X-Received: from dleg5.prod.google.com ([2002:a05:701b:4305:b0:164:3999:d7c8])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:e805:b0:148:2f17:3e75 with SMTP id a92af1059eb24-16a61695579mr6045623c88.12.1791621581028;
 Sat, 10 Oct 2026 01:39:41 -0700 (PDT)
Date: Sat, 10 Oct 2026 08:38:46 +0000
In-Reply-To: <20261010083935.3274178-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261010083935.3274178-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261010083935.3274178-6-almasrymina@google.com>
Subject: [PATCH net-next v1 5/6] net: skbuff: use skb_frag_ref() in skb_try_coalesce()
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Eric Biggers <ebiggers@kernel.org>, Kees Cook <kees@kernel.org>, 
	Michael Grzeschik <mgr@kernel.org>, 
	"=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=" <u.kleine-koenig@baylibre.com>, Petr Machata <petrm@nvidia.com>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, Jakub Raczynski <j.raczynski@samsung.com>
Content-Type: text/plain; charset="UTF-8"

skb_pp_frag_ref() was introduced solely to work around skb_frag_ref()
ignoring skb->pp_recycle and incrementing the non-pp backing refcount.
Now that skb_frag_ref() handles both pp_recycle=1 and pp_recycle=0
symmetrically, call skb_frag_ref() directly in skb_try_coalesce() and
remove skb_pp_frag_ref().

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 net/core/skbuff.c | 37 ++-----------------------------------
 1 file changed, 2 insertions(+), 35 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index f03ce8d5ae585..554af794bd7cd 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1078,37 +1078,6 @@ static bool skb_pp_recycle(struct sk_buff *skb, void *data)
 	return napi_pp_put_page(page_to_netmem(virt_to_page(data)));
 }
 
-/**
- * skb_pp_frag_ref() - Increase fragment references of a page pool aware skb
- * @skb:	page pool aware skb
- *
- * Increase the fragment reference count (pp_ref_count) of a skb. This is
- * intended to gain fragment references only for page pool aware skbs,
- * i.e. when skb->pp_recycle is true, and not for fragments in a
- * non-pp-recycling skb. It has a fallback to increase references on normal
- * pages, as page pool aware skbs may also have normal page fragments.
- */
-static int skb_pp_frag_ref(struct sk_buff *skb)
-{
-	struct skb_shared_info *shinfo;
-	netmem_ref head_netmem;
-	int i;
-
-	if (!skb->pp_recycle)
-		return -EINVAL;
-
-	shinfo = skb_shinfo(skb);
-
-	for (i = 0; i < shinfo->nr_frags; i++) {
-		head_netmem = netmem_compound_head(shinfo->frags[i].netmem);
-		if (likely(netmem_is_pp(head_netmem)))
-			page_pool_ref_netmem(head_netmem);
-		else
-			page_ref_inc(netmem_to_page(head_netmem));
-	}
-	return 0;
-}
-
 static void skb_kfree_head(void *head)
 {
 	kfree(head);
@@ -6295,10 +6264,8 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 	/* if the skb is not cloned this does nothing
 	 * since we set nr_frags to 0.
 	 */
-	if (skb_pp_frag_ref(from)) {
-		for (i = 0; i < from_shinfo->nr_frags; i++)
-			get_netmem(skb_frag_netmem(&from_shinfo->frags[i]));
-	}
+	for (i = 0; i < from_shinfo->nr_frags; i++)
+		skb_frag_ref(from, i);
 
 	to->truesize += delta;
 	to->len += len;
-- 
2.56.0.385.gd3acb90ef8-goog

