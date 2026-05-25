Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3E6146588
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 20:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779740021; cv=none; b=WgmOz45Hnq21643qbwQ60S34U+yBDHvNYKjqvuYXt65vQ+072XBetlcjd8WViveIB0vR07uCxJfRUGzgnDX0S2BuokjoRSHqxjL6Rp/KGzrGuplSyUq2hh1/bFiBPDafTXYciswiMHe6xs6t7ewai+v+Do4CehDy2KItjEhhqiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779740021; c=relaxed/simple;
	bh=rBCJgnc41Lv3Ti8AMVY4yRemB4ZIvOrQtscp4kF7lUI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EgHst4a7q3IHSLrZEDXXlO5dUBr/FScKtYf3ZLM0KUD1AIzp7G6n7/4NLWLWw3qWFaa7bCSN7xeQuArpTXcdH+bUezxNlx/67DF1upr1vDlhhQ4pQqQafYPzh/uSx/7M5II0Lx2SYGWMvXcQvrVulHEidPbZrxc10EZIaRbnU1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TxUbvFPR; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TxUbvFPR"
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-51494d74d4bso14576491cf.1
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 13:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779740019; x=1780344819; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nyWEKC3Jh/d+rB43CvXisaRI7jcsqj9JQK4cLOM8Ohg=;
        b=TxUbvFPR8gzdLZdHLzi7ZJ+RfXbVtklPJOWoNuNBvmIOo4gEkpnNlx+g0LMm2nk7G1
         e7kV5/UQkDFa14Ky9W0yYoulsJGct3mDxNkwVaaQ/21ljnhCzCwkYj5kcpAt+7rfXqWQ
         klQgcjcKakqppK28pw6SpawUBzm/JZBjmIrreliqBhsEBoPKlk9CL9LydESGd3znm1tw
         Tsq3KPjrpAbhX7ppCZ/PSHvNz0VkKkc34If/VzoNcKc8aWb32asTTWGVQ8AoUHdlgWV3
         IDyHs1ThYyQSIrL/DnbS+FWZFmjEuObi4IjZA7KBoH9jp12KecvEsgp05VmULxZ7dGmZ
         kdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779740019; x=1780344819;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nyWEKC3Jh/d+rB43CvXisaRI7jcsqj9JQK4cLOM8Ohg=;
        b=WucrI76tEI8OJz1MNa3TmmXBD2nnUzlsJfHYl1afpYOZMSQHBBASMiMML+64+2UcGo
         ogt3p5Cn9Qd974buBwBZgqjjKcrAU1nr6+jybSRu4vQPsPe3WfF9pmb8X2Ks+jps+OSn
         FaEPRzJ5SstUHYzGq8N6Oop+U85gMBOywTPVgMVIhDyb+h+tJR2gDXTU+ltKIBXxV2eN
         CRvKBzEpB3eq5YCAfJ9trnqECX+CJoY+IfOPZOp3HzWk1FWAfI1YQ0yxFG1PkIpTkHJy
         77TM4nSuLpssW8zS2jgGLW8V+c58iU19A3I5P+QpGxzS0zDKcHoaP3TMIcRhor4WZCdK
         MEzA==
X-Forwarded-Encrypted: i=1; AFNElJ+E922GRIKfcvcSWvMcIa82MkYm8c1vuHpstztKRehBd8OvRkwB+3yQ6uCmRRfQCnGgpUDMC1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxtM7aRoLY6AoBrehIOvLVY3OZz6F2Gm4LcdZkEsmA7rR3ksrZ
	l4151cUCdVT/jeulVnaUE6xjsnLIkm6YrpBaHQrs+ott17A+56dmrHBbb+nnXPxDRvgyguyox7A
	72PCl6nQRgBuPMA==
X-Received: from qtbfp42.prod.google.com ([2002:a05:622a:50aa:b0:516:dc27:e8f9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5f4c:0:b0:516:df09:b1ec with SMTP id d75a77b69052e-516df09b57cmr164908451cf.37.1779740018599;
 Mon, 25 May 2026 13:13:38 -0700 (PDT)
Date: Mon, 25 May 2026 20:13:35 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260525201335.2361845-1-edumazet@google.com>
Subject: [PATCH net] tunnels: load network headers after skb_cow() in iptunnel_pmtud_build_icmp[v6]()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Stefano Brivio <sbrivio@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Sashiko found that iptunnel_pmtud_build_icmp() and
iptunnel_pmtud_build_icmpv6() were caching ip_hdr() and ipv6_hdr()
before an skb_cow() call which can reallocate skb->head.

Fix this possible UAF by initializing the local variables
after the skb_cow() call.

Remove skb_reset_network_header() calls which were not needed.

Fixes: 4cb47a8644cc ("tunnels: PMTU discovery support for directly bridged IP packets")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Stefano Brivio <sbrivio@redhat.com>
---
 net/ipv4/ip_tunnel_core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index 2667f53482bdaf1e693907fc527063d0ddd45580..c77a4c3fbe753ad6d86bf52e9cbdad89a4ae6f85 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -212,7 +212,7 @@ EXPORT_SYMBOL_GPL(iptunnel_handle_offloads);
  */
 static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
 {
-	const struct iphdr *iph = ip_hdr(skb);
+	const struct iphdr *iph;
 	struct icmphdr *icmph;
 	struct iphdr *niph;
 	struct ethhdr eh;
@@ -226,7 +226,6 @@ static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
 
 	skb_copy_bits(skb, skb_mac_offset(skb), &eh, ETH_HLEN);
 	pskb_pull(skb, ETH_HLEN);
-	skb_reset_network_header(skb);
 
 	err = pskb_trim(skb, 576 - sizeof(*niph) - sizeof(*icmph));
 	if (err)
@@ -236,7 +235,7 @@ static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
 	err = skb_cow(skb, sizeof(*niph) + sizeof(*icmph) + ETH_HLEN);
 	if (err)
 		return err;
-
+	iph = ip_hdr(skb);
 	icmph = skb_push(skb, sizeof(*icmph));
 	*icmph = (struct icmphdr) {
 		.type			= ICMP_DEST_UNREACH,
@@ -308,7 +307,7 @@ static int iptunnel_pmtud_check_icmp(struct sk_buff *skb, int mtu)
  */
 static int iptunnel_pmtud_build_icmpv6(struct sk_buff *skb, int mtu)
 {
-	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
+	const struct ipv6hdr *ip6h;
 	struct icmp6hdr *icmp6h;
 	struct ipv6hdr *nip6h;
 	struct ethhdr eh;
@@ -323,7 +322,6 @@ static int iptunnel_pmtud_build_icmpv6(struct sk_buff *skb, int mtu)
 
 	skb_copy_bits(skb, skb_mac_offset(skb), &eh, ETH_HLEN);
 	pskb_pull(skb, ETH_HLEN);
-	skb_reset_network_header(skb);
 
 	err = pskb_trim(skb, IPV6_MIN_MTU - sizeof(*nip6h) - sizeof(*icmp6h));
 	if (err)
@@ -334,6 +332,7 @@ static int iptunnel_pmtud_build_icmpv6(struct sk_buff *skb, int mtu)
 	if (err)
 		return err;
 
+	ip6h = ipv6_hdr(skb);
 	icmp6h = skb_push(skb, sizeof(*icmp6h));
 	*icmp6h = (struct icmp6hdr) {
 		.icmp6_type		= ICMPV6_PKT_TOOBIG,
-- 
2.54.0.746.g67dd491aae-goog

