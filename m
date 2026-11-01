Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793551358;
	b=jYIqrLR3G1CCyzu2YplX8siv9tROfZ8nMQVeiyXNPB0ts5j0naoP/Q7OL5xm5xCSvYbz
	 M7jQ8GUSFom+Mb7WUfnqevRYIvV8DuDa7ZfCBhRgLCuCq1WR1i8ye5a7RNdvZgaQ0MrQ6
	 FUgdkmj8024bjeuxM+bJlBOvIyHNMRhDIKJamlM0R4G6Ko6KVS6ju6xq0yLplLy5Z9b9O
	 B5kVvAdTn/S+dhHXy33jbPvgVFhq3P49or/wN24/aokzQlKPJ3Nj/tGfLSgEhSrvSR0zs
	 jz7NpC2aDtFPcI7iRBlpWL4ZMQSyQ2dWbBR0xJIwoUf+2F74pjzXuwyty4C5MeF6S3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793551358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TlraSu9AjY+wAsB7GZqoG24SclQpPomTr5qFhEYxo8U=;
	b=HwaWFwujkkCVp+Aa3eYV+wUZHC6oiEd3+T8JIENg0IXZVAv8R3X7FgOBBomJBTMHaNob
	 qRWA8HpF3If4Np9yBcli5lyYYHCfvLk/AymQvVO3HJ9CnxJq+LugNgTtY15YRqvNP4kX1
	 RMgptGa7bYvQKQoIrgDb9VkR/u6p7VqPscz4tOFXUj0hnHaxow+XKPDYXkIFQYO7xQo0q
	 IF/kMArvxTlPkoRG8Um6avZbWxW+/VONXLYxHYvg5BaXAsi03kyYOL+eXyh/AJwPG66iV
	 HVt8ZMWOT0OPSJpz44x4Ftl69OD3pANYRdetdSpVT3nPDqLu0ZH4UTg378neZNYdxtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=t+WLQy0B;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEDB60A261B
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 16:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BEDB60A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=t+WLQy0B
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c37b612635bso314234566b.3
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 08:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1793551357; x=1794156157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TlraSu9AjY+wAsB7GZqoG24SclQpPomTr5qFhEYxo8U=;
        b=t+WLQy0BSuGtr5MwiFW+b4clPwk3wSTjU+5yXt6LJzMFRj3AbwtXZNjZ5yqwM+6/5U
         r6RcbLa9SB0RIU/FmeukHD7Qsh/SPhmC04PJX9Be898pt4rhAqumfA/NKiDz/sp42awz
         7umJQaQBwZgek5PWiM73Jq5fCjyM7Vja9ncJVOgbR97aDYVe/3tpQ2qfX3vRZ+BIahAo
         sWJlShjct0wAwCegAVO9OXOq7MCCSMrq10k7M+pTL712SEvwNLV/i6zh3FiXe1feCDU9
         MHsrD81qz252LKeme69QIcEv6mqWoDmcdXqGrEcoCR74fiZRK53WULOdT1Co588B6Dii
         eNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793551357; x=1794156157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TlraSu9AjY+wAsB7GZqoG24SclQpPomTr5qFhEYxo8U=;
        b=DkKbXeV/Cbyz4hl9fnRYJzaqc1h3jgROb0zfrEGmrniwrBfHPbuDA1DbP3EozlFWFP
         zBSfBDeIOwq1VR1KLVGhvTB7VYcl79bnpOOm2w6fG0iluf6jj1cqaHeb0+2uDeoDbCSy
         XENWQmjw3M2obPyt3eEK3GwnTBG4uZDNwCXaRt1Wm6iD1xVf+Gr9EAr9zw6+OWCtnPP0
         Kj1YLUTZdPfvP20jmoaIE9FyIrg352Nz386SZS+4Ywu9d6sppYMcWUIkkYWXhOQYIbLI
         uofM7RZJVkKJ1XQV2wN8Wcs//Kut1aPhXcRVf6Y6bacNWLqLzMi/0t6KGfsMr+j9X/RG
         AGIA==
X-Gm-Message-State: AFq9FYIbtYxJL609INZpmRk2/V4F0/kl5o6N6SCpVGugGwdNhdtYkyrw
	3n2WjQ5DKhD6CqKVPqmmgnGScEcfSzp5SmKXJIKyAScbt3wvCc2rGYKQ3uyLr+xrelniuZwSqrg
	fORWVzzRG
X-Gm-Gg: AYBFou3lzdv64X/kNJU9R1Uk9BIvHUsiciE52zAgKkPFwAlPutLxNoe6GGgBR9NqwQZ
	S0ZQeD2gC3QBiUDGTjKgFxD25eYBF/kZY0bgZopsybKlwPRJiVVrXMuJyzD93VaV+IOV+EbR3Ru
	mR5P3xJPq0Avky8nBU0hgSgZQMGsL5mNVQqYdybee1xv8Ieslh3jCgQtyZUvxfHxdefpZielzjP
	oSTtbjRYoQu0ZFy179BarQ1YtS8nbN2fsgbag/R8rO/b3Bv00SQ9yHF6SSZpibPDn6LOTqNalZd
	GuoDuU8VXqpm6UCA7mt0dzCNQbny98P+TPqk4nGKKBTmPxXXjqhPc+VLJpxwYhb5Sn/U6eJ67Py
	0EzSQXwivkTOJySLcZ39gFNGRBCE07nMH23LaM7paMtvWSjHmHa2jMqn0sMlApv3HO6afen75fu
	/sJoEG59g1WNpYDBtA/0R3ko91NNE/zedIrcMXLu/Xuacabp9BMchwfyTUXcedNB/eDZQ/H0tNp
	aGRrmif9FHERyi/26TCGqP8d5Y/oleaX2TkBSuue0XQh73PNNYYZ9TKqro+u9U/v1mT7NMRIAR0
	UOk+08nTErGbVQMU34mnNchxxxEkyN/h+LVDNNON7QW8//8Y9RQQJGDGVgURjcwNqLAsAAsKclx
	vCOnLvUhj71Pn//7Ii8sqsncK2WP6Ll+MbmiOKpjKnbvjQREkyhnB/8M+8RoBVv9RxVTC3UA9WH
	3pKTm9W98XQlcR4KHCJdGAH3SilZDX73Bh6VsRu5SXBdzbsf0QpLeR2EKomBzeoUpAa2WS+45Zm
	j6Z7kraeOxk3d6LfNGF4UYio5rX0G9gx5NvcqLcvtZa/4iMukHwtPtunESPQjLO1sbIBXJYQm2j
	kNYLtHb55Xhla8thB6I=
X-Received: by 2002:a17:907:2d8e:b0:c42:102f:15df with SMTP id a640c23a62f3a-c4ca7a0dc8cmr673791066b.8.1793551356711;
        Sun, 01 Nov 2026 08:42:36 -0800 (PST)
Received: from Desktop (p54aff88b.dip0.t-ipconnect.de. [84.175.248.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabe0f37esm296622966b.33.2026.11.01.08.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:42:36 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	willemb@google.com,
	jiayuan.chen@linux.dev,
	mfleming@cloudflare.com,
	almasrymina@google.com,
	bigeasy@linutronix.de,
	richardbgobert@gmail.com,
	ecree.xilinx@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 3/4] ipmr: set up GSO state for tunnel vifs
Date: Sun,  1 Nov 2026 17:42:31 +0100
Message-ID: <529dd7ba1395f17c0b328ab2a597769809cbe720.1792838740.git.julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1792838740.git.julius@bairaktaris.de>
References: <cover.1792838740.git.julius@bairaktaris.de>
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

ip_encap() pushes the outer IPv4 header but does not set SKB_GSO_IPXIP4,
skb->encapsulation or the inner headers. A GSO packet forwarded to a
VIFF_TUNNEL vif is then rejected by ipip_gso_segment() and dropped in
validate_xmit_skb(), after being counted as sent. A device with UDP
segmentation offload is handed a GSO packet whose transport header
points at the inner IP header.

Call iptunnel_handle_offloads() and skb_set_inner_ipproto() as
ipip_tunnel_xmit() does, reserve one outer IP ID per segment as
iptunnel_xmit() does, and set the outer length with iph_set_totlen(),
since a GSO packet plus the outer header can exceed 64 KB. A GSO packet
that GRE or UDP tunnel GRO marked as encapsulated already uses the inner
headers for its own tunnel; drop it, as segmentation did before.

Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
 net/ipv4/ipmr.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index acacaae05cc49..98e38839f8ccb 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1849,12 +1849,21 @@ static struct notifier_block ip_mr_notifier = {
  * This avoids tunnel drivers and other mess and gives us the speed so
  * important for multicast video.
  */
-static void ip_encap(struct net *net, struct sk_buff *skb,
-		     __be32 saddr, __be32 daddr)
+static int ip_encap(struct net *net, struct sk_buff *skb,
+		    __be32 saddr, __be32 daddr)
 {
+	const struct iphdr *old_iph;
 	struct iphdr *iph;
-	const struct iphdr *old_iph = ip_hdr(skb);
 
+	/* The inner headers can describe one tunnel only */
+	if (skb_is_gso(skb) && skb->encapsulation)
+		return -1;
+
+	if (iptunnel_handle_offloads(skb, SKB_GSO_IPXIP4))
+		return -1;
+	skb_set_inner_ipproto(skb, IPPROTO_IPIP);
+
+	old_iph = ip_hdr(skb);
 	skb_push(skb, sizeof(struct iphdr));
 	skb->transport_header = skb->network_header;
 	skb_reset_network_header(skb);
@@ -1868,12 +1877,13 @@ static void ip_encap(struct net *net, struct sk_buff *skb,
 	iph->saddr	=	saddr;
 	iph->protocol	=	IPPROTO_IPIP;
 	iph->ihl	=	5;
-	iph->tot_len	=	htons(skb->len);
-	ip_select_ident(net, skb, NULL);
+	iph_set_totlen(iph, skb->len);
+	ip_select_ident_segs(net, skb, NULL, skb_shinfo(skb)->gso_segs ?: 1);
 	ip_send_check(iph);
 
 	memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
 	nf_reset_ct(skb);
+	return 0;
 }
 
 static inline int ipmr_forward_finish(struct net *net, struct sock *sk,
@@ -1982,7 +1992,8 @@ static int ipmr_prepare_xmit(struct net *net, struct mr_table *mrt,
 	 * What do we do with netfilter? -- RR
 	 */
 	if (vif->flags & VIFF_TUNNEL) {
-		ip_encap(net, skb, vif->local, vif->remote);
+		if (ip_encap(net, skb, vif->local, vif->remote))
+			return -1;
 		/* FIXME: extra output firewall step used to be here. --RR */
 		DEV_STATS_INC(vif_dev, tx_packets);
 		DEV_STATS_ADD(vif_dev, tx_bytes, skb->len);
-- 
2.53.0

