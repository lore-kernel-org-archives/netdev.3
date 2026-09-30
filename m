Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ADD51FCC2
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793570; cv=none; b=WI6AYB/t9SwLCcSXIHYcECv7L/joDneKzqIlkzXhyQYdXV9I9iywI8vWgrqPjVSAqUOK8J/KiyP9NOHsoUv2gbxOzYrC7w6JiCXOwLJxe9tb9+Zv6yvB66YLaWA9PSTm6RUf5mI8lzVz0BkoIq37DZxonfFcfe5JwgAsCdnu0Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793570; c=relaxed/simple;
	bh=Ur/M0jCxdw82LbKfmljxnZUKjjWiEMXUVa+Uz1fg4R8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oY3xxBEDgNlaVanHIiwYn7wTVgsDM2jwV99jSYceFuzgOeMFU1/DTUP5lUTTmlEMqXkBvYzdNHvtXpYF1pw4bucWfAGDsboG1YRiX9oy511xSbHGU1fJsk9JD/S7sWWYfwYN3hlCpbg6O6SeYqvmBZCqHUG8oeAVaA3igVn0THM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVs8u89Z; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVs8u89Z"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f15b78so5245510e87.2
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790793566; x=1791398366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kg2ooxvtl7HjiToOZd16N0F5A1ecI/kce9Eaiw5GIcY=;
        b=NVs8u89ZGiI6Ct1ypDX9Ff/yG3gWK6kv9O3RW8GABBVnCuDaBg8TZimNhXcajKrmKc
         FvCG1ZSH2ipZMdMsTrt4R/0dLVJq6dBfUtuHRVt2kpybei1T9F7gIUkXs6d94fGihmGF
         QrDf3bw/5XDdLeohc88ilPaKhhy8UE8+pq6avLmbNIPWZiuhUJ67i/Lb/FMFdkLVeMCv
         DTR6+Ug8aFxT8ApStMbiYZAzBFeyDSMxiXfxMQbtBi5C7Sm4GZH/FolELcWt00frH2Lq
         tn6Jitd8uoUN+3vDGcLY/dRR9khyaH9EGTbEYggH2VcP0DmucHsDnnQyoZvqaQ8W0iuZ
         a0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790793566; x=1791398366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kg2ooxvtl7HjiToOZd16N0F5A1ecI/kce9Eaiw5GIcY=;
        b=fPxK2D8ThP09/X9ru+fTqccrHN9Nt1YdEaWXooHZ7SEtBifFZdjB5iC5AVuioO8+Zc
         rKYWcVkvIQija2HMcjXxH7kcEDftIb5F657teAvCEwBYlHxgnATIIlIYXMmebyRRb3bM
         dfIvGeo6FVChd6T9wTkxALrwU32AO/6K12CK/DTwKEbSp5KITbilWLVERXehHBae9GgZ
         zQicX6XZp5rkmL0+9N/symAnb+uYF5XaVIyxsWZpE8o4a80EEsfsBjYw0apgYRDPFOtC
         KnIQ0S5RH5THUftkZE58VxWW0s0k04Vv/AXJtPlJTngCvKqMrWwYIizc7KVAUC8xsTGc
         30aw==
X-Gm-Message-State: AFq9FYJLJEGpEfehEje7D4X4SD2Wc0CVGmwwcRywu9qsuO2QxqPnD5sb
	irCC/MtMN3v7rkGAQ8jUUot3QrFHQCMTRlMzlkiwJAMdM7WgdI6B2TwyPPu68ZdA
X-Gm-Gg: AYBFou06uJAeBTGHlukHT8RpVT5ocRQmrgv2NSZ/rQcE8+w6+AEdL7XCG3S2xUeQC9U
	Z0bNlo3e22COzoJHAn+5W0fS3GCfaHvbIa1fsIvDNCqGIw3g1XT7TOQ+st2CvT+whRcyidX0fZm
	geX+p3djug99HQEFbLFasDYieJofAQ+NKMMe/TKKhgbZSH3Kl2dGLEKKJGxTRsPVaYWoUttUw7Z
	dxwmz8EEDOJxeLiy3Mw79ea/S6JP1tCy5+usPoDpiqXNQ1wJNw5cz/3F2hd5eMnoe7bZj2Cz6at
	RZC48Q2fU0pVKJAESZAOgPoYOZE6cYy/Yy5oFT5sw3cHTS2X1X/xwqiQNh/bzKeCf+VYTzxykeV
	QEOtCbI1wbmwW8A/NkUForHsfjG3n/LISYM7JrFJsPFN4R1hOXkLwJSlOnItgEgDeeRHglGmbHm
	C4ZE17Oclorn7KJtIhSxlOuUw0UgWOkzGA9yZ+DTl45rbPTIE/PB8jXWo7Fxg6zmwMTc/Z1C/+i
	YhLd4RKDzml0PEbBoZHNXh30rFjO0Rq26dst6Pe2FyL
X-Received: by 2002:a05:6512:6d6:b0:5ba:3109:4617 with SMTP id 2adb3069b0e04-5ba402cb5d4mr950699e87.1.1790793565641;
        Wed, 30 Sep 2026 11:39:25 -0700 (PDT)
Received: from dau-home-pc.. ([212.35.169.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba42fbb999sm156593e87.62.2026.09.30.11.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:39:24 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 02/14] ip_tunnel: make __iptunnel_pull_header() return a drop reason
Date: Wed, 30 Sep 2026 21:38:58 +0300
Message-ID: <20260930183910.3151873-3-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930183910.3151873-1-littlesmilingcloud@gmail.com>
References: <20260930183910.3151873-1-littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__iptunnel_pull_header() returns -ENOMEM whenever it fails. It can
fail in two pskb_may_pull() calls, one for the tunnel header and one
for the inner Ethernet header of ETH_P_TEB, and in the skb_unclone()
done for GSO packets. pskb_may_pull() fails when the packet is shorter
than the requested length as well as when pulling from the frags cannot
allocate, so a truncated packet and an allocation failure look the same
to the callers. The ones that report a drop reason can only pick
SKB_DROP_REASON_NOMEM, as vxlan_rcv() does, and so would the GRE
receive paths converted by the following patches. In ip6_gre,
gre_rcv() pulls the header before the tunnel lookup, so a packet from
any sender whose ETH_P_TEB inner Ethernet header or WCCPv2 extra word
is cut short would be reported as an out of memory condition.

Make __iptunnel_pull_header() and iptunnel_pull_header() return the
reason pskb_may_pull_reason() already computes, SKB_DROP_REASON_NOMEM
when skb_unclone() fails, and SKB_NOT_DROPPED_YET on success. A failure
is still non-zero, so the callers that only test the result keep
working. Three callers, in ip_gre and ip6_gre, test it with "< 0"
instead; the enum has no negative values, so that test would always be
false, and the compiler does not warn about it. Make them test for a
non-zero value.

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Assisted-by: LLM
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 include/net/ip_tunnels.h  | 10 ++++++----
 net/ipv4/ip_gre.c         |  4 ++--
 net/ipv4/ip_tunnel_core.c | 22 +++++++++++++++-------
 net/ipv6/ip6_gre.c        |  2 +-
 4 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 7102aa11fae2..5cccf4c0e691 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -614,11 +614,13 @@ static inline u8 ip_tunnel_ecn_encap(u8 tos, const struct iphdr *iph,
 	return INET_ECN_encapsulate(tos, inner);
 }
 
-int __iptunnel_pull_header(struct sk_buff *skb, int hdr_len,
-			   __be16 inner_proto, bool raw_proto, bool xnet);
+enum skb_drop_reason
+__iptunnel_pull_header(struct sk_buff *skb, int hdr_len,
+		       __be16 inner_proto, bool raw_proto, bool xnet);
 
-static inline int iptunnel_pull_header(struct sk_buff *skb, int hdr_len,
-				       __be16 inner_proto, bool xnet)
+static inline enum skb_drop_reason
+iptunnel_pull_header(struct sk_buff *skb, int hdr_len,
+		     __be16 inner_proto, bool xnet)
 {
 	return __iptunnel_pull_header(skb, hdr_len, inner_proto, false, xnet);
 }
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 51fcd603939c..3ee437fa3eae 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -312,7 +312,7 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 		if (__iptunnel_pull_header(skb,
 					   len,
 					   htons(ETH_P_TEB),
-					   false, false) < 0)
+					   false, false))
 			goto drop;
 
 		if (tunnel->collect_md) {
@@ -378,7 +378,7 @@ static int __ipgre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi,
 		const struct iphdr *tnl_params;
 
 		if (__iptunnel_pull_header(skb, hdr_len, tpi->proto,
-					   raw_proto, false) < 0)
+					   raw_proto, false))
 			goto drop;
 
 		/* Special case for ipgre_header_parse(), which expects the
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index bab42b9e277f..6c2855adff28 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -106,19 +106,24 @@ void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(iptunnel_xmit);
 
-int __iptunnel_pull_header(struct sk_buff *skb, int hdr_len,
-			   __be16 inner_proto, bool raw_proto, bool xnet)
+enum skb_drop_reason
+__iptunnel_pull_header(struct sk_buff *skb, int hdr_len,
+		       __be16 inner_proto, bool raw_proto, bool xnet)
 {
-	if (unlikely(!pskb_may_pull(skb, hdr_len)))
-		return -ENOMEM;
+	enum skb_drop_reason reason;
+
+	reason = pskb_may_pull_reason(skb, hdr_len);
+	if (unlikely(reason))
+		return reason;
 
 	skb_pull_rcsum(skb, hdr_len);
 
 	if (!raw_proto && inner_proto == htons(ETH_P_TEB)) {
 		struct ethhdr *eh;
 
-		if (unlikely(!pskb_may_pull(skb, ETH_HLEN)))
-			return -ENOMEM;
+		reason = pskb_may_pull_reason(skb, ETH_HLEN);
+		if (unlikely(reason))
+			return reason;
 
 		eh = (struct ethhdr *)skb->data;
 		if (likely(eth_proto_is_802_3(eh->h_proto)))
@@ -135,7 +140,10 @@ int __iptunnel_pull_header(struct sk_buff *skb, int hdr_len,
 	skb_set_queue_mapping(skb, 0);
 	skb_scrub_packet(skb, xnet);
 
-	return iptunnel_pull_offloads(skb);
+	if (unlikely(iptunnel_pull_offloads(skb)))
+		return SKB_DROP_REASON_NOMEM;
+
+	return SKB_NOT_DROPPED_YET;
 }
 EXPORT_SYMBOL_GPL(__iptunnel_pull_header);
 
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 258239a7c53b..0392f6ba862b 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -512,7 +512,7 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 
 		if (__iptunnel_pull_header(skb, len,
 					   htons(ETH_P_TEB),
-					   false, false) < 0)
+					   false, false))
 			return PACKET_REJECT;
 
 		if (tunnel->parms.collect_md) {
-- 
2.47.3

