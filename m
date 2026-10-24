Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792833975;
	b=Mu6CcSpkBYaehBpJEjiE0aSRHtSbnUhB9JQk3CdqC3N3FFWjuZ9h7dSK1FeeQXF8l249
	 68243ceU6NJrBeXFkH2ZYJrsDZ6I1HYf/uM0narwpIA7NTrGw1AFwxJo8h+CTp8hj0CTN
	 d4qJpf5Xj8J8pbDG9QoWRDaM0gJ/SVnsBLXi8jxlhenHz6DOhK9kdQjOitwrIkKzhSoZq
	 BM/eB3DjrnMg2kNSCx3WEzbEInPs1Nn7Sffu88UyR+JjhargcvbSA2rIFviRMhHO45T/q
	 cPhai8saEEm6kYv7K7gH6SHQZGdO8eOfajMC4nTWrbyNl0gBS1HbbhigDfi0Kav9buw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792833975;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=P5pgjPuDWekL4PDuVC1dqeWj8mNBEfrz3m7ImGErQYg=;
	b=qyKyl5aNyMS3TVCmDqAJzhagACeqkaHTj9NCgJ+Rx6A3nun1MhwR1OdfbxyXT08z10KO
	 HN0bq5t3splfaKhwC2VuL1QUueU7i21HTWtJF+lbgkf0hSiC7aUFtN+fEHW/Zrm49FMjt
	 CfzdxIOTbGhWyZATLuW+AMc88GgVUej16iRGcPKKz7UUgG63gr4ahSYqN9vShyD2I/a/6
	 tm2Duie/ix0QaytvpzOhJjnxi+xnO5VIDm2Ns0HU0vsw4YDjqjYrYueRRquR4GlPP4SHU
	 GIjWZ3Q9YTrfzWbjC2CRgcNPOkpTkzJAKSgoAQq9aXmAKAAf7G8t4lKacb7X+o+Ib+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=adVAFdVs;
	arc=none smtp.remote-ip=195.10.208.46
Received: from mout-b-106.mailbox.org (mout-b-106.mailbox.org [195.10.208.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6242606A322;
	Sat, 24 Oct 2026 09:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6242606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=adVAFdVs
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4jBZJF1dPLzNm0l;
	Sat, 24 Oct 2026 11:26:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1792833965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P5pgjPuDWekL4PDuVC1dqeWj8mNBEfrz3m7ImGErQYg=;
	b=adVAFdVsXrMb19r0W25mSSPAcoO1iLzDfk0BkkYYoFlvV6iQu9EO80Ji3fz+cy3a/lLo9u
	I/f7F4zBoB2cFC0zhR4oelLvt+M66zE4C7DbOXhlUCrMED+ODWRuxkP+zI4iSyvlpEzRBB
	aMZrprgtDuNjtWqc/Y0HiLXKr4qwkdilrRtWrukqtiMBAAxX2Yd93OJoQwfxODereUNmf6
	9sjFyInjpijhHRylPeA+r2lBNmn3+LSZqHv6HgCKwvL5RyKTthbYSeAjWI5+62anh0w19t
	7lgS7g/wito0SCTGKgep3zceZzCkYIwhSCwcEzAVdORTxvo1PhyS7cbRE/QUbA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice.kernel@fastmail.im>,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next v2 03/18] ipv6: allow output fragmentation to reuse a Fragment Header
Date: Sat, 24 Oct 2026 11:25:13 +0200
Message-ID: <20261024092532.172005-4-ralf@mandelbit.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261024092532.172005-1-ralf@mandelbit.com>
References: <20261024092532.172005-1-ralf@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jBZJF1dPLzNm0l

IPv4-to-IPv6 translation constructs an IPv6 Fragment Header before the
target route is selected. If that route has a smaller MTU, IPv6 output
must split the translated fragment again. Adding another Fragment Header
would create a new fragment domain instead of subfragmenting the
original datagram representation.

Allow ip6_fragment to reuse a locally constructed Fragment Header,
preserving its identification, datagram-relative offset and More
Fragments state. This mirrors IPv4 refragmentation, whose fragment state
carries the original offset and whether more fragments follow the input
fragment.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
New patch in RFC v2 replacing ipxlat's v1 IPv4 pre-fragmentation
machinery.

 include/linux/ipv6.h  |  2 ++
 include/net/ipv6.h    |  1 +
 net/ipv6/ip6_output.c | 53 +++++++++++++++++++++++++++++++++++++++----
 3 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index a7421382a916..558260074842 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -177,6 +177,8 @@ struct inet6_skb_parm {
 #define IP6SKB_L3SLAVE         64
 #define IP6SKB_JUMBOGRAM      128
 #define IP6SKB_SEG6	      256
+/* the local stack owns fragmentation of this IPv6 representation */
+#define IP6SKB_FRAG_SOURCE    512
 #define IP6SKB_MULTIPATH      1024
 #define IP6SKB_MCROUTE        2048
 };
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index e3f245d640ac..a1cca04fd17a 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -189,6 +189,7 @@ struct ip6_frag_state {
 	int		hroom;
 	int		troom;
 	__be32		frag_id;
+	bool		not_last_frag;
 	u8		nexthdr;
 };
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 25fe0ba98b1a..73633483f1ab 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -204,7 +204,8 @@ static int __ip6_finish_output(struct net *net, struct sock *sk, struct sk_buff
 		return ip6_finish_output_gso(net, sk, skb, mtu);
 
 	if (unlikely(skb->len > mtu ||
-	    (IP6CB(skb)->frag_max_size && skb->len > IP6CB(skb)->frag_max_size)))
+		     (IP6CB(skb)->frag_max_size &&
+		      skb->len > IP6CB(skb)->frag_max_size)))
 		return ip6_fragment(net, sk, skb, ip6_finish_output2);
 
 	return ip6_finish_output2(net, sk, skb);
@@ -805,6 +806,7 @@ void ip6_frag_init(struct sk_buff *skb, unsigned int hlen, unsigned int mtu,
 	state->troom = needed_tailroom;
 
 	state->offset = 0;
+	state->not_last_frag = false;
 }
 EXPORT_SYMBOL(ip6_frag_init);
 
@@ -873,7 +875,7 @@ struct sk_buff *ip6_frag_next(struct sk_buff *skb, struct ip6_frag_state *state)
 	state->left -= len;
 
 	fh->frag_off = htons(state->offset);
-	if (state->left > 0)
+	if (state->left > 0 || state->not_last_frag)
 		fh->frag_off |= htons(IP6_MF);
 	ipv6_hdr(frag)->payload_len = htons(frag->len - sizeof(struct ipv6hdr));
 
@@ -891,10 +893,13 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	struct rt6_info *rt = dst_rt6_info(skb_dst(skb));
 	struct ipv6_pinfo *np = skb->sk && !dev_recursion_level() ?
 				inet6_sk(skb->sk) : NULL;
+	struct frag_hdr old_fh;
 	u8 tstamp_type = skb->tstamp_type;
 	struct ip6_frag_state state;
 	unsigned int mtu, hlen, nexthdr_offset;
+	unsigned int old_data_len, old_offset, unfrag_len;
 	ktime_t tstamp = skb->tstamp;
+	bool frag_source, refrag;
 	int hroom, err = 0;
 	__be32 frag_id;
 	u8 *prevhdr, nexthdr = 0;
@@ -910,6 +915,31 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	hlen = err;
 	nexthdr = *prevhdr;
 	nexthdr_offset = prevhdr - skb_network_header(skb);
+	frag_source = IP6CB(skb)->flags & IP6SKB_FRAG_SOURCE;
+	refrag = frag_source && nexthdr == NEXTHDR_FRAGMENT;
+	if (unlikely(refrag)) {
+		/* The current fragment header describes this locally built
+		 * IPv6 representation. We need to replace it with smaller
+		 * fragments rather than nesting another frag hdr around it.
+		 */
+		if (unlikely(skb->len < hlen + sizeof(old_fh) ||
+			     skb_copy_bits(skb, skb_network_offset(skb) + hlen,
+					   &old_fh, sizeof(old_fh)))) {
+			err = -EINVAL;
+			goto fail;
+		}
+
+		old_data_len = skb->len - hlen - sizeof(old_fh);
+		old_offset = ntohs(old_fh.frag_off) & IP6_OFFSET;
+		unfrag_len = hlen - sizeof(struct ipv6hdr);
+		if (unlikely(old_offset + unfrag_len > IPV6_MAXPLEN ||
+			     old_data_len >
+				     IPV6_MAXPLEN - old_offset - unfrag_len)) {
+			err = -EINVAL;
+			goto fail;
+		}
+		nexthdr = old_fh.nexthdr;
+	}
 
 	mtu = ip6_skb_dst_mtu(skb);
 
@@ -939,8 +969,11 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		goto fail_toobig;
 	mtu -= hlen + sizeof(struct frag_hdr);
 
-	frag_id = ipv6_select_ident(net, &ipv6_hdr(skb)->daddr,
-				    &ipv6_hdr(skb)->saddr);
+	if (refrag)
+		frag_id = old_fh.identification;
+	else
+		frag_id = ipv6_select_ident(net, &ipv6_hdr(skb)->daddr,
+					    &ipv6_hdr(skb)->saddr);
 
 	if (skb->ip_summed == CHECKSUM_PARTIAL &&
 	    (err = skb_checksum_help(skb)))
@@ -953,7 +986,8 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		struct ip6_fraglist_iter iter;
 		struct sk_buff *frag2;
 
-		if (first_len - hlen > mtu ||
+		if (refrag ||
+		    first_len - hlen > mtu ||
 		    ((first_len - hlen) & 7) ||
 		    skb_cloned(skb) ||
 		    skb_headroom(skb) < (hroom + sizeof(struct frag_hdr)))
@@ -1038,6 +1072,15 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	ip6_frag_init(skb, hlen, mtu, rt->dst.dev->needed_tailroom,
 		      LL_RESERVED_SPACE(rt->dst.dev), prevhdr, nexthdr, frag_id,
 		      &state);
+	if (refrag) {
+		/* Mirror IPv4 refragmentation: start at the old datagram
+		 * offset and retain its MF value on the final new fragment.
+		 */
+		state.left -= sizeof(old_fh);
+		state.ptr += sizeof(old_fh);
+		state.offset = old_offset;
+		state.not_last_frag = old_fh.frag_off & htons(IP6_MF);
+	}
 
 	/*
 	 *	Keep copying data until we run out.
-- 
2.55.0

