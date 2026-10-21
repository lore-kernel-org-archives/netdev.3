Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583262;
	b=OLzMEfVG/Rejr6iPuTqgwZDXfQwkJ7NJ5S63nI3uVTJslC6Gqfeg4lpwH4hkWyrYS//t
	 s296o15bgsqLs6n2Bc6o0xeif8CcyE8/5wmz559tyG+Vrat9q6wa1LuNWiCH63c0eOGWF
	 lEbfKqSQJYAivwQ/2E1O4gJva7FhBrKR+W6EIIrBsJir9QBOLWm3UjKAEAbXq9mEPkSgi
	 NSyUzMBhNmuNwyI14RJcoGLUEndPKQnU+8NouM6vYJ9/IOkf2VdIIY0TLmjMLWrMLILbO
	 zQFFGsaJn4Id1lFtBEq4qRZ/+g9+iJ1/b/2yGxHqjhtXS7bzlYPsdHxZLKI0MPVacKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583262;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=ko/uOWW9MmVDlyLdxGJWgtr/ksS4XAjHrpz+xNjK37M=;
	b=0ShZMM8blsMrh4HdbmAgiToE1u29Hn1dkKl+UHVV9YZS1QRWcYb2HSm8GtdkVNK8MFXl
	 i3WM9MKaeknoSrGddldmtEEc2wL918DT6uje/pIu+yPRyr1fYNFV0PCQoqpKAj8u5pNKe
	 EZ57fQry2c6SXl165no9t0GoRHGTAp9AgDOghJ6zv3yYsHGsLv3ZwLgvli1PHDCuNcI7W
	 pwHulU6iPXlWuwMnxFJKuKd8r6LC7Mv6ksdYT4Nqxb3wLt3sMgsVsjH2xXJYNvVOoRmzx
	 voVoBOXQq0EjqkGiUpiUxgxzXZBR9GNiuRRomrsmgI8J6WmUs7RYPkODraP4jRGXMaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ER9CSkf+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED22D60A2611;
	Wed, 21 Oct 2026 11:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ER9CSkf+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E051F000C6;
	Wed, 21 Oct 2026 11:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583261;
	bh=ko/uOWW9MmVDlyLdxGJWgtr/ksS4XAjHrpz+xNjK37M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ER9CSkf+A5Vu8PQAVZYvXDfMfptAvyV2alH2rkS0jPl0vXqowyTHG01tf/DX1Zo+V
	 RAKWvHyE8bi0yWDTE2/+wB9lWEHhYwd3DypUKdNADqC8PX6TRpaxLAMJS7R2VofTud
	 G01klTdk3Yxe0aiws3DBE97AIR6LeNpoeY+5tfr20hxJ3nzZIOBdewXHTMXNOX7wfp
	 Z+BwSD40lJ891nYzcdORZl47QWDeaPN2cmxJTuWI5Q3l6NodgV8Z7VGpusEHEEHtF7
	 37ZQ4ONsmkm0o8paXV25QXRVmMgMcWHHcsqDB+U6oR5dobE7ZzAxFmXQxfa0tfKnNw
	 Xq1vtwpJAaAMA==
From: "Harry Yoo (Meta)" <harry@kernel.org>
Date: Wed, 21 Oct 2026 12:46:46 +0100
Subject: [PATCH slab/for-next 05/14] net: skbuff: specify SLAB_MAY_ACCOUNT
 for skbuff_head_cache
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-5-096800aa3330@kernel.org>
References: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-0-096800aa3330@kernel.org>
In-Reply-To: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-0-096800aa3330@kernel.org>
To: Vlastimil Babka <vbabka@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
 David Rientjes <rientjes@google.com>, Muchun Song <muchun.song@linux.dev>, 
 Hao Ge <hao.ge@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 "Harry Yoo (Meta)" <harry@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Mina Almasry <almasrymina@google.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
X-Mailer: b4 0.16.0

AF_UNIX sets sk->sk_allocation to GFP_KERNEL_ACCOUNT, so skbs can be
allocated from skbuff_head_cache with __GFP_ACCOUNT. Specify
SLAB_MAY_ACCOUNT when the object may be charged to a memcg.
__GFP_ACCOUNT without SLAB_MAY_ACCOUNT will not be allowed.

Path: unix_dgram_sendmsg() -> sock_alloc_send_pskb(sk->sk_allocation)
  -> alloc_skb_with_frags() -> __alloc_skb()
  -> kmem_cache_alloc_node(skbuff_head_cache)

Assisted-by: LLM
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Jason Xing <kerneljasonxing@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Mina Almasry <almasrymina@google.com>
Cc: "Björn Töpel" <bjorn@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org
Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 966af3beed94..34ebbaf04fc7 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5213,7 +5213,7 @@ void __init skb_init(void)
 					      sizeof(struct sk_buff),
 					      0,
 					      SLAB_HWCACHE_ALIGN|SLAB_PANIC|
-						FLAG_SKB_NO_MERGE,
+						SLAB_MAY_ACCOUNT|FLAG_SKB_NO_MERGE,
 					      offsetof(struct sk_buff, cb),
 					      sizeof_field(struct sk_buff, cb),
 					      NULL);

-- 
2.54.0

