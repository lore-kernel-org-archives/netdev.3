Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793766324;
	b=wxyVzwJfecUStgGELs8Ud7mQKkArYW/lgCdvk++Ri7HlBuF3K3BbL9cUHirCA4/CPSUi
	 J96ba7wkH2WKPjtP4K2BacAIPqg7PwH8ZIqE1EJiFJQzaY54XQJGdyT+7r59l+ZQ9GTQD
	 BI+SqlKksJpDIynjpsoYSOalF1fp8qA0yfZg+pf4bvcGGOswXs5SqpLZFGtE4IUCnMS2z
	 xNgJiXQkOlsF/kC4ahLZ/5ZQpfCTsq5VqcvQDZFDqNl4+i7VapgAboX9rwUf0kll57Ihu
	 jKfQFHZuEhH8IvMc2zOUuGaxdRoL5XqJgMYpITtrnFTaVpb3lniCUliP7ZaM+g15OPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793766324;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ZoEuAGkvqExLcZMAKy8ADX/1SzWBYfFUlFv8u3+K4kY=;
	b=yU1hdSLIpaTxySMh0FWa1FeKl6DajrJj3UmuuiWEYK6ltTpG8C90mDqNxZpbqOHykx9K
	 N1VXkFrgZEj4eNvlzHNpqTOx/+EEfmrEMjzlKIS/EjYqkzX87DG6RVPAq8pHUZtdS3gSK
	 Yg0h6+27BFa8qnBYmjGfbvLokWJ7p/y2lUdFvJyZgK5i/sRz3INd+SHRzKSEnKsTzJNFT
	 0SyAc+kqMyt8RjhJZd3W0g79BsOx04e4LGwwJUcxTgq171ipw/vxz9ALD9xoKyk8gZzKz
	 6GoWqM+7IQDpRuZUitGJsB8TslX9s5twQqrxW46wetU8pPGIwvonR4n92oityzc14bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dzn+c+qU;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5380C606A32F
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 04:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5380C606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dzn+c+qU
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bcb065bfdso571625eec.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 20:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793766323; x=1794371123; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZoEuAGkvqExLcZMAKy8ADX/1SzWBYfFUlFv8u3+K4kY=;
        b=dzn+c+qUuWQNK1Bi1A0tvng17UH3CjiBprejRo7pENaRH1q+Jwi0/JvUpmQNiEO/jk
         tHRmRGrQkJIXQaqS5aBD2JoF8vClCSNR2sWe50oPqz1wQkviyZavadDZCwX/+s8rrSqr
         balzK0DUKzDJghkggdXCMeZiWNeWqfAbe83NnC6ZdrsDs5E2oabSqCXQJuHz1ZzV0tpt
         berrs6fPvpCcXtHBDZEDu5BjHJRTT1fsDd/o0wmL/CCSCKHVs/K9Maqubbd8ud/zYkpw
         WyUtSxZm5x1BwhAzS17uoa/mD9LG32K2oc0ZLLqC3KKwkZQ8e9l9XA9zIUwlPdN+sywe
         sYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793766323; x=1794371123;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZoEuAGkvqExLcZMAKy8ADX/1SzWBYfFUlFv8u3+K4kY=;
        b=FacGWF7mFbvuCPXsFjwHjjP8jOmgCJ2GB4oUvybRuzaLbKpsbT7x5ftuKlhxUoaPhP
         tSW4J4v9HzSQ8H4zVYtoZGfH9Z1nXvq/jXl9txMWxIgO37WbB08+yqYlKZ5CZ0rwMUYK
         dDuTBq3kYpQpwS0FAMnyPzEx2a8jtzUXxV9JNVHyVA6eA7PgjT8sY76xzyh4uiSIatxY
         qgHtLiCtWzRbhqK8+UDxJxGt/DYREWNyeNr5iCeP2C7f9XlDVhzuJkjyoxxlJNu+iurU
         C9C0DbryPKOYgC0TS8CUltCFWD4tXQlbc3vDfL8jb1jkiKkbgE2mlEy7Y72vvDibVI6/
         GZvg==
X-Forwarded-Encrypted: i=1; AKwUvBzzd6KSL3PEaDdtSWBH1N5InNWEmkvQr0Alr6ySmR8CFXp0i0ENkda9rx0rurYaqmStO5wm3UY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9TBVOCp79dwOFy3CkVMUdKTuQNpvDjXINpvYQQrFOHQEp5GhUX
	/vsyiJUS71BvYxC0BBr9J3P4Vllx7epCTJj9J98OdPXgEFWdAVCGAQZlW43HFizyO7ezVP76/Ty
	SeSQTrgKVcFCK51kC7pYdKujbNA==
X-Received: from dlbut12.prod.google.com ([2002:a05:7022:7e0c:b0:158:5d29:90be])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2511:b0:1b2:471f:c4c with SMTP id a92af1059eb24-1b2471f0fadmr1428341c88.19.1793766323123;
 Tue, 03 Nov 2026 20:25:23 -0800 (PST)
Date: Wed,  4 Nov 2026 04:25:20 +0000
In-Reply-To: <20261104042521.3979880-1-almasrymina@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104042521.3979880-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261104042521.3979880-2-almasrymina@google.com>
Subject: [PATCH net-next v3 1/2] net: fix skb->unreadable propagation in
 skb_split() and skb_shift()
From: Mina Almasry <almasrymina@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Eric Dumazet <edumazet@kernel.org>, Mina Almasry <almasrymina@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Stanislav Fomichev <sdf@fomichev.me>
Cc: "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"

skb_split() and skb_shift() do not accurately maintain skb->unreadable
when moving fragments between skbs:

- skb_split_inside_header() moves all fragments out of skb into skb1
  (leaving skb with nr_frags == 0 and only host-readable linear memory),
  but leaves skb->unreadable set on skb.
- skb_split_no_header() unconditionally copies skb->unreadable to skb1
  even if 0 fragments were moved to skb1 (k == 0), and leaves
  skb->unreadable set on skb when splitting at skb_headlen(skb) moves
  all fragments into skb1 (!skb_shinfo(skb)->nr_frags).
- skb_shift() neither propagates skb->unreadable to target skb when
  shifting unreadable fragments into an empty skb, nor clears
  skb->unreadable after all fragments are shifted out of skb.

Fix all three cases so skb->unreadable accurately tracks whether the
remaining fragments in each skb are unreadable.

This issue is theoretical and was found by manual code inspection and
LLM review; it was not triggered in production. Verified with the
net_core KUnit test suite; not tested on real hardware.

Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 net/core/skbuff.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 48f6764117243..dc761ceb4d204 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4225,6 +4225,7 @@ static inline void skb_split_inside_header(struct sk_buff *skb,
 
 	skb_shinfo(skb1)->nr_frags = skb_shinfo(skb)->nr_frags;
 	skb1->unreadable	   = skb->unreadable;
+	skb->unreadable		   = 0;
 	skb_shinfo(skb)->nr_frags  = 0;
 	skb1->data_len		   = skb->data_len;
 	skb1->len		   += skb1->data_len;
@@ -4273,7 +4274,10 @@ static inline void skb_split_no_header(struct sk_buff *skb,
 	}
 	skb_shinfo(skb1)->nr_frags = k;
 
-	skb1->unreadable = skb->unreadable;
+	if (k)
+		skb1->unreadable = skb->unreadable;
+	if (!skb_shinfo(skb)->nr_frags)
+		skb->unreadable = 0;
 }
 
 /**
@@ -4447,6 +4451,9 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
 	skb->ip_summed = CHECKSUM_PARTIAL;
 
 	skb_shinfo(tgt)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
+	tgt->unreadable |= skb->unreadable;
+	if (!skb_shinfo(skb)->nr_frags && !skb_has_frag_list(skb))
+		skb->unreadable = 0;
 
 	skb_len_add(skb, -shiftlen);
 	skb_len_add(tgt, shiftlen);
-- 
2.56.0.385.gac671c819a-goog

