Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793196816;
	b=tq1fjGEr2aM2wdAG6F+DlfmiIuQ92K9tXf4sXTzxpamXWK7C49LjL0Dk0Dgpc1NJjXyG
	 f0FPJwWU4eauELv6Mz6c4oufni0nu+pO4CtRmPzrBTu3AcrvLHBH4tX1HeR1ddAiD74LF
	 eNMr/TRTWii6q1pGd9YQtwSd2mP6jf8Xsx+czQgUmz9A/o1pvwD9mEaMx7staxIAcLCGl
	 CkpBa6w2Rke9mKBRIBfItqmKu0DcncB58liPkCKWV6Og0St6r7REw/DqimI645yxAD9am
	 ORfT6VuIxjGH6/1111byOpZ2ZcwahDiFevZ5ABXFt+3EhC0ozGi5XWx5VX9m7QkmWXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196816;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zNOu23pPkSLsPSYAnjezDkgSp7K2iY9iiY8Ri1TVYUE=;
	b=s+3jvcCJQuY1scPk84nQp13xlLwc5+JICsDZCnO6zLtEaLjoX7GyxmAQEJul12kVuXU4
	 9VOx1gpb4EgIcUbg5vTEUZ4nhUVe3p1avKSroOm/ZbMXJC9j7UtCR32b+V05I571TleN8
	 2wrV6kHs4Utv5hI+kDtxEXbWqfnMGz5Q3RBWpaHBWjZWYXSdCVcF5QTDqEWONrLX0aB4E
	 KLytGtBQ/ZqCPsASs7BWeo/pigMSM9+zQ/wWkhiDkhSczTXWOG2UuRjd3gpjOpBdADTq5
	 scDXQaKCutHoALRKQ/rltn26qk4cBZH5LB6QCa3AP3scEChQ/ex0WFxUweXzp8RSWKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FKYmCsq5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCC4606A31F
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FKYmCsq5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0568D1F01828;
	Wed, 28 Oct 2026 14:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793196816;
	bh=zNOu23pPkSLsPSYAnjezDkgSp7K2iY9iiY8Ri1TVYUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FKYmCsq5SBjT+R8nYeKzv+fegmMVeTnXJ7khcnH0h3h9ZkyjCspq8yDvl4HxNMvn2
	 pE9qz6LhIs6EuQsMSBofXxgY71vGgA/dUCRl73xQG8Kaf3Z889mkosq/LKkvzoAUQH
	 mDLyCCENeWM5MEfbbeIXjuCEaR1azadSzikP0WaRfb96wS2B9iM88snl71Z/tKLP8j
	 r860m2MIDG3ABHn4aCXcXXWQ8g5l1GrW9/cWwUxJsSIOaI4ukESTDIeOjZ9aAK6QrF
	 qGucj45byr9JmgJMGuGeSaahPsb7LlqR9/SjCMBOWlJ6z9VtWL6+hMiMUmTk1qUQ1M
	 2EUTjIaPb7vgw==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	AutonomousCodeSecurity@microsoft.com,
	netdev@vger.kernel.org,
	edumazet@kernel.org,
	Taesoo Kim <tsgatesv@gmail.com>,
	Cen Zhang <cenzhang@linux.microsoft.com>
Subject: [PATCH net 2/2] net: gro: invalidate frag0 after a pull
Date: Wed, 28 Oct 2026 15:13:25 +0100
Message-ID: <20261028141325.2103814-3-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141325.2103814-1-edumazet@kernel.org>
References: <20261028141325.2103814-1-edumazet@kernel.org>
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

Since commit bd56a29c7a4e ("net: gro: change skb_gro_network_header()"),
skb_gro_header_slow() no longer invalidates NAPI_GRO_CB(skb)->frag0
after pskb_may_pull(). skb_gro_may_pull() keeps comparing against the
frag0_len value set in skb_gro_reset_offset(), assuming that after a
slow pull, all later accesses are beyond frag0_len.

This is not true:

- udp4_gro_receive() and udp6_gro_receive() read the network header
  with skb_gro_network_header() after udp_gro_udphdr() pulled the
  UDP header.

- vxlan_gro_receive() calls skb_gro_remcsum_cleanup() at a lower
  offset after the inner handlers pulled their headers.

- skb_gro_remcsum_process() can pull beyond the inner Ethernet header
  before eth_gro_receive() reads it.

- napi_frags_skb() calls __skb_pull(skb, ETH_HLEN) after a slow pull,
  so frag0 still points to the Ethernet header.

If the pull consumed the first page fragment, __skb_pull_tail() released
it. If the head had to grow, pskb_expand_head() freed the old one.
These reads, and the 2-byte write in skb_gro_remcsum_cleanup(), then
access memory the skb no longer holds a reference on.

esp4_gro_receive(), esp6_gro_receive(), skb_gro_receive_list() and
udp_gro_receive_segment() also pull directly and never invalidated
frag0.

Add skb_gro_frag0_invalidate(), which only clears frag0_len, and call
it after each of these pulls. This is a single store in the slow path,
and frag0 stays non NULL, so skb_gro_network_header() does not need
a NULL test.

Fixes: bd56a29c7a4e ("net: gro: change skb_gro_network_header()")
Reported-by: Taesoo Kim <tsgatesv@gmail.com>
Reported-by: Cen Zhang <cenzhang@linux.microsoft.com>
Tested-by: Cen Zhang <cenzhang@linux.microsoft.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 include/net/gro.h       | 10 ++++++++++
 net/core/gro.c          |  1 +
 net/ipv4/esp4_offload.c |  1 +
 net/ipv4/udp_offload.c  |  1 +
 net/ipv6/esp6_offload.c |  1 +
 5 files changed, 14 insertions(+)

diff --git a/include/net/gro.h b/include/net/gro.h
index b560e866683b03314b3e80a887ac4467d1a5acb9..78373e9caf68b6acefcd976ed7192ec5e44db2b9 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -160,12 +160,22 @@ static inline bool skb_gro_may_pull(const struct sk_buff *skb,
 	return likely(hlen <= NAPI_GRO_CB(skb)->frag0_len);
 }
 
+/* A pull can release the page fragment frag0 points to, or reallocate
+ * skb->head. Make sure later skb_gro_header() and skb_gro_network_header()
+ * calls no longer use frag0.
+ */
+static inline void skb_gro_frag0_invalidate(struct sk_buff *skb)
+{
+	NAPI_GRO_CB(skb)->frag0_len = 0;
+}
+
 static inline void *skb_gro_header_slow(struct sk_buff *skb, unsigned int hlen,
 					unsigned int offset)
 {
 	if (!pskb_may_pull(skb, hlen))
 		return NULL;
 
+	skb_gro_frag0_invalidate(skb);
 	return skb->data + offset;
 }
 
diff --git a/net/core/gro.c b/net/core/gro.c
index ff828a3dce3ca649e149a840bd6e3dfd9ddaf0c4..2fe1bbe49a082873a700d36f7a10570f0954526e 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -242,6 +242,7 @@ int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 		NAPI_GRO_CB(skb)->flush = 1;
 		return -ENOMEM;
 	}
+	skb_gro_frag0_invalidate(skb);
 
 	if (NAPI_GRO_CB(p)->last == p)
 		skb_shinfo(p)->frag_list = skb;
diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index abd77162f5e75ec01d5e66693f20a80a78af9e50..dea34411e77f6cf1302315e665df003e4d1130a6 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -39,6 +39,7 @@ static struct sk_buff *esp4_gro_receive(struct list_head *head,
 
 	if (!pskb_pull(skb, offset))
 		return NULL;
+	skb_gro_frag0_invalidate(skb);
 
 	if (xfrm_parse_spi(skb, IPPROTO_ESP, &spi, &seq) != 0)
 		goto out;
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index cf07c3c6611a22c29b57a72420f2f940609f5e9a..62c44c450d78c9c2b9ea38d953376026fd2aa4e7 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -747,6 +747,7 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 					NAPI_GRO_CB(skb)->flush = 1;
 					return NULL;
 				}
+				skb_gro_frag0_invalidate(skb);
 				if ((skb->ip_summed != p->ip_summed) ||
 				    (skb->csum_level != p->csum_level)) {
 					NAPI_GRO_CB(skb)->flush = 1;
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index 22895521a57d09acfe091927f20188764f33f91b..674e66541d9f914bf788a148bceea51c1067f541 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -66,6 +66,7 @@ static struct sk_buff *esp6_gro_receive(struct list_head *head,
 
 	if (!pskb_pull(skb, offset))
 		return NULL;
+	skb_gro_frag0_invalidate(skb);
 
 	if (xfrm_parse_spi(skb, IPPROTO_ESP, &spi, &seq) != 0)
 		goto out;
-- 
2.53.0

