Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23E73E3141
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 10:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781778459; cv=none; b=JxxxFzLcHQp0mzsIzRyqo7FEQDWCLS7vYcCYsRrLm8vkxGQJplY4ihqi/8LhzXERNN4mWWjOrmHzDuGk5gNn3br9EN/69cItgj2HLLmY875mkMdxkK0nUZC1kjAdTMUNWoFu9M4yGE34y0X47tMXUkyCuHo0+iRtqEGgb3CudXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781778459; c=relaxed/simple;
	bh=4bLcebf8/cJoz0Im0FVWTu3FiTZSoJUAZTYQfbXrjuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOxlKdZJw10we6vCyXFbqUiQMZ7+60KkE8d0TjFIgYqQe3JXzhpfeBa0AwTlVRdfKvDFwj8Dp5iTHrHNBbxK9Cb2uHvgyRzJAMmks3Ip8AVwXcmTu+YeW7ZjUALy2etP8aCm0UlIj4fx1Yd2ToEozgVgmLp6CXb8WiWkyQQi5L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBKi7S2J; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBKi7S2J"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36d98c9b596so369600a91.3
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 03:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781778455; x=1782383255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YPROmYOJkFlruTcYwHv/tQODxhuQZzZiMpxK1bmtHI=;
        b=nBKi7S2JnHf9qWA2ogAf7bARxqe8vkZ9l05IpKpNTqbUfEbLDobNBJYVj18Fga5XUP
         CHUpHm0GmGvAw4/71tzqngVnl1jQdXHR3p2H5NDFfYDKujp6rS7MFa+7EgsBT0+Npo3L
         WrfxGSGo37C+e0OrCnfxYkARjLBsVL9fAbAwj7hcOf6rCm7s6x+ST10flzqBkMyMdzUQ
         D5rhrsnr4kVknUiTXwGHBG6XdqXe6rP+njGZYei5Cn70/JkFUchQDVzRQZHxoZhdLD23
         S0LRd5rskp/yTh9ZZSBYIw+vV7Qvi/LAXd4lvE/3HoLvBvXUlVpvdL+a+OXU7RHcl6xk
         ROog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781778455; x=1782383255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2YPROmYOJkFlruTcYwHv/tQODxhuQZzZiMpxK1bmtHI=;
        b=U6X8amP9C0rdkGUzmrLcFONCNKtzI3YBpE2r9WhLmdbPbcpuSYWB5GhZjytRq4fDUy
         hIqdexy69sqTvIwNtcAhnvAjTxezMGF5VL40JGC+sr95hIGyITYL9klm0uAr6vgZ9uiC
         P0+2qxSFKKriJqsbgHoB67CFDVvurSNhnXObc1Y3uhjG8KvMX5EsOzOwhdZ235dkKuq2
         VAtu1fmziG/7pQM+EC2aCh7+LjgMzzqLe7sZizd9Gs0eX446pHtO0+0JLqP1DVvumzv1
         KNuzuu+hSX53aMi/nyBkYEL1saGTVJIMOjczyda0f/wdoRnS6qAK52RNBvAZgjvzd4oC
         QKeg==
X-Forwarded-Encrypted: i=1; AFNElJ+K7Noru0+zT4msJdlpsWy7/z2eOm9oOcdzwWTlwb6jWd6JjppOZjBRKOHaBNbwnrijscmVY+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDPYwJ/vZ8vFR1K+jJ9Lkb8lEskAWL7W5m3za36V5bo8nkTaKr
	wmyepz29C5ZaE3Lzlzu4bQwCDtiPKgEJkF5bLrmzCw85e8pPwf72O2gA
X-Gm-Gg: AfdE7cnQcIAA/jHFANacw/6W6c3GSDkeh5s+CqhmfmgOrId/MowZoAU9MdfyIuvK9aZ
	UKvbyri3UHcBQWJq0yIJKw2NeMfny8iWGPaM4XQAoGTVToNppO/faYRerZyxVfBEwIYQ/v0l0hQ
	fViaCbj7r2VCuCIgkO3J/d15Nxl7gsHNk3hXz7iNOyYIz/wvIs6bGA4FPyu5rrnYUE4MuxmUfR7
	T9SMjJsNF871Olloo0JDdff6jpa/Ockblb1PuzipKK0i+ZTr7gjk/JurVMmwzoVB20uJiPJNbVP
	P0yiIuaYeR45zgZQV0zj4akbCvZxpnk4RgPj5Fmh1QPfXl//hERsLObBsvi2A+3KArZHbfr81Te
	W+5Vd2F5iA5XmdYuRlR9ty10S6IRO9NHuZLe1NiKLctd96aYyV3L2Cb25QGQhU/dYewRFXamu+M
	pePdwGJlwhdi7N9TTV6S9zrOrpwL8YG0imJ4KtgylAcB6QP1lzeso=
X-Received: by 2002:a17:90b:4acf:b0:368:5367:d679 with SMTP id 98e67ed59e1d1-37c930d593emr8144920a91.9.1781778455023;
        Thu, 18 Jun 2026 03:27:35 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521cac5bsm8997512a91.5.2026.06.18.03.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 03:27:34 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@gmail.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v3 1/2] bpf, sockmap: fix use-after-free when the stream parser resizes the skb
Date: Thu, 18 Jun 2026 10:27:07 +0000
Message-ID: <20260618102718.2331468-2-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618102718.2331468-1-rhkrqnwk98@gmail.com>
References: <20260618102718.2331468-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sk_psock_strp_parse() runs the BPF_PROG_TYPE_SK_SKB stream-parser program
to find the length of the next message. strparser assembles a message out
of several received skbs by chaining them onto the head's frag_list and
recording where to append the next one in strp->skb_nextp:

	*strp->skb_nextp = skb;
	strp->skb_nextp = &skb->next;

and then calls the parser on the head:

	len = (*strp->cb.parse_msg)(strp, head);

The parser is only meant to inspect the skb, but the program may call
bpf_skb_change_tail() -- or the sibling bpf_skb_pull_data(),
bpf_skb_change_head(), bpf_skb_adjust_room(), all allowed for SK_SKB.
Once the head carries a frag_list these go

	... -> skb_ensure_writable -> pskb_may_pull -> __pskb_pull_tail

and __pskb_pull_tail() frees the frag_list skbs that strparser still
tracks through skb_nextp:

	while ((list = skb_shinfo(skb)->frag_list) != insp) {
		skb_shinfo(skb)->frag_list = list->next;
		consume_skb(list);
	}

strp->skb_nextp now points into a freed sk_buff. The next segment of
the same message arrives in __strp_recv(), which links it with
*strp->skb_nextp = skb, an 8-byte write into the freed skb. The free
and the write happen in different __strp_recv() calls, so the message
has to span at least three segments before it triggers.

  BUG: KASAN: slab-use-after-free in __strp_recv+0x447/0xda0
  Write of size 8 at addr ffff88810db86140 by task repro/349

  Call Trace:
   <IRQ>
   __strp_recv+0x447/0xda0
   __tcp_read_sock+0x13d/0x590
   tcp_bpf_strp_read_sock+0x195/0x320
   strp_data_ready+0x267/0x340
   sk_psock_strp_data_ready+0x1ce/0x350
   tcp_data_queue+0x1364/0x2fd0
   tcp_rcv_established+0xe07/0x1640
   [...]

  Allocated by task 349:
   skb_clone+0x17b/0x210
   __strp_recv+0x2c3/0xda0
   __tcp_read_sock+0x13d/0x590
   [...]

  Freed by task 349:
   kmem_cache_free+0x150/0x570
   __pskb_pull_tail+0x57b/0xc20
   skb_ensure_writable+0x236/0x260
   __bpf_skb_change_tail+0x1d4/0x590
   sk_skb_change_tail+0x2a/0x40
   bpf_prog_1b285dcd6c41373e+0x27/0x30
   bpf_prog_run_pin_on_cpu+0xf3/0x260
   sk_psock_strp_parse+0x118/0x1e0
   __strp_recv+0x4f6/0xda0
   [...]

The same resize also leaves the head's length inconsistent with its
frags, so a later __pskb_pull_tail() can instead hit the
BUG_ON(skb_copy_bits(...)) in net/core/skbuff.c.

A stream parser is only meant to measure the next message, not to modify
the packet. Reject a parser whose program can change packet data
(prog->aux->changes_pkt_data) at attach time. The check is shared by
sock_map_prog_update() and sock_map_link_update_prog(), which between them
cover prog attach, link create and link update. Verdict programs are
unaffected and may still modify the skb.

Fixes: 8a31db561566 ("bpf: add access to sock fields and pkt data from sk_skb programs")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/core/sock_map.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 99e3789492a0..c60ba6d292f9 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1515,6 +1515,17 @@ static int sock_map_prog_link_lookup(struct bpf_map *map, struct bpf_prog ***ppr
 	return 0;
 }
 
+static int sock_map_prog_attach_check(enum bpf_attach_type attach_type,
+				      struct bpf_prog *prog)
+{
+	/* A stream parser must not modify the skb, only measure it. */
+	if (prog && attach_type == BPF_SK_SKB_STREAM_PARSER &&
+	    prog->aux->changes_pkt_data)
+		return -EINVAL;
+
+	return 0;
+}
+
 /* Handle the following four cases:
  * prog_attach: prog != NULL, old == NULL, link == NULL
  * prog_detach: prog == NULL, old != NULL, link == NULL
@@ -1533,6 +1544,10 @@ static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
 	if (ret)
 		return ret;
 
+	ret = sock_map_prog_attach_check(which, prog);
+	if (ret)
+		return ret;
+
 	/* for prog_attach/prog_detach/link_attach, return error if a bpf_link
 	 * exists for that prog.
 	 */
@@ -1776,6 +1791,11 @@ static int sock_map_link_update_prog(struct bpf_link *link,
 		ret = -EINVAL;
 		goto out;
 	}
+
+	ret = sock_map_prog_attach_check(link->attach_type, prog);
+	if (ret)
+		goto out;
+
 	if (!sockmap_link->map) {
 		ret = -ENOLINK;
 		goto out;
-- 
2.43.0

