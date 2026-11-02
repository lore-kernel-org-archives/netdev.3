Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661510;
	b=ZXy/chp8lqJKuFmC+bJKcx1p24WRNckGFanIWwJRDnjJTw7J6Es/eHftBxpsNfv3OMxU
	 Y3ymNk82UiKDAjhS8joPhKPxe62XfS0GTeX92TV2KlAgVfEgOqB/1IKMiaI3ndzHQyQs0
	 NMh3THd98Mss0gtqSMJ+1G+RTygzMnHiYRmJHxXwbjr4YhMTt6n+S+yYEG2NocPsjNeUy
	 7exD6A8Hn1QaXZkgv8tQ8BiO4d2Zew2YrGbxnZ1e1Rj0ixEiG4x7+/hQxVPcwLheCDkjN
	 HhLMtvHIgYBE9XMNCbvbairu9CPCo9aka1IIDwjhudoAnmByxF+FzLU2cBkwGvvTE0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=fdn28Y1abRWwiiybnob+FFic6b5c6iPaoksPj551sIg=;
	b=L0jtkpNih3S9WFgKlYl27urFE3Rugmh8Ud9fpCSOB9yIdfWGiBBzqkP8a/KYqovGrnCK
	 X/STCnTBGr+Kos2PPHRSTl59tqOrAEnAWa/lAW3KkoDXaOIFMgIX4WV0Q53PbbdVWA5Lj
	 898nx55EYmWfnw3D+TN50RXqmiF3bK9E4bEr6Z4dysKbhA07o61PcN7CRxhKM+Hb8Ajk+
	 QbAtKDclmV87lFEiQVyIObWB8mTrZ5bg85Y1ABgf89OfyyczGF876zVX+H8MzzJAhCIgF
	 fRPRyAnkwrNqnYB+KN/y9TeQU9YNJw76kywkOP5h9W/P637NbrPwAnKt5lVH/PBek/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Q/Z7oFy8";
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76320606A337
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 23:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76320606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Q/Z7oFy8
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-139b62317d0so7494892c88.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 15:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793661510; x=1794266310; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fdn28Y1abRWwiiybnob+FFic6b5c6iPaoksPj551sIg=;
        b=Q/Z7oFy8P1wDPs1o1rGn6C7pTiQdPMLYmfjfcsO/1KB+DuI6LNgjmlt3gzvl4+CJ72
         NduqVxY/SFEk0DVhBtTzKTyyT3yzL/rND55t+PDwYaJd/vH4+gVVmDXIod/9DopiyKpE
         88Wm+xV4bRcVADfuNpcCF28JTFMsgt6hjK8ZsCuAPxLTSRp+DwmZkTOuTTJAfqXLlDeK
         LZ3aRDvvbKIsY8IZcDhdmk8Xo/BzdX2u7t9Q35QfknkAoiPW0DUhzmRb2qnwzl5Skok4
         vycptMWmui/ebxEjGvYqAfBi1i73ZdQdWpWiPGOvuUIdFoPs1oel8a4poPBkGCYiTReG
         qXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793661510; x=1794266310;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fdn28Y1abRWwiiybnob+FFic6b5c6iPaoksPj551sIg=;
        b=B3TB5Fn6AjJDjoRMJYjNdt2I/tbJ+rOt6SsTX0BoSD2y6DEbX3AOGQ5iOA3JUqKbSm
         InA4XTxtHZki6IElkZLePNXzkkBt8SyAFmhkplIowt4ZaUH6aeRsn/5GSHGl2U/fRrsD
         hEniDQwaAX0fD/faff3AHNmcKIGyhXSPqrnTUr+ynwpjBA6+JqIJPOF7m4ldDfk8EzIq
         jGM54e5UebJC51Fsjd/AQGcqZcPT9xx5LG1+cUrKjoChQRAK5ZZCew2MJAaO9AufPC1W
         2ewMWRQwudiS6dRPcrh2pBG7U+rJQsxFBu/oE2Elia82NMZxyE8cTamHDMyEbOsbG5yc
         6ArA==
X-Gm-Message-State: AFq9FYJdaS5gs63AGxDsIE4fP0Cpixb6k0DWyf8pcewAAcRyPpC18App
	hypztqgd8kW3bWXmx38Rtv7LD6WhTAexndPOWO36gCecUJ1atQJUQwHX/RHcdnVgrRulb4Sxx6A
	5VgyZs0UbBuBVK2+m8R2qYfq636BYWYPj3O2SaxwJrVI385EaCo1UxI/yswvQrt4B035jbAmEv+
	IFGmRDnmeuQl1yW+m9i4GoAn5AHXI5ByFUg1WbbpNB8skSJ6iVs6iy+vrtWcKVbfw=
X-Received: from dlbtx1.prod.google.com ([2002:a05:7022:fc01:b0:19a:484d:c761])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:418d:10b0:192:e5a8:6bae with SMTP id a92af1059eb24-1ac5e6f5eaemr17575373c88.40.1793661509182;
 Mon, 02 Nov 2026 15:18:29 -0800 (PST)
Date: Mon,  2 Nov 2026 23:18:24 +0000
In-Reply-To: <20261102231827.4088254-1-almasrymina@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261102231827.4088254-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261102231827.4088254-2-almasrymina@google.com>
Subject: [PATCH net-next v2 1/4] net: fix skb->unreadable propagation in
 skb_split() and skb_shift()
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, Eric Dumazet <edumazet@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, io-uring@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Stanislav Fomichev <sdf.kernel@gmail.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
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

