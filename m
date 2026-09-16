Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E9744E043
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552927; cv=none; b=lTfgbQxCdBwjQHfmMmI93tujeQfkzLOTj7dsIIajEJf3FxD3CH1mt80WIilW/7OTyyKWsIFewMv/DUnpv5tMTpVfXq8Nw2aATBhCJj/NG1Cfn6udRvjecu9XEz3/b2n/jWjKo6ZkjY0AvbUFmkFCP4hxj8uHhjWLAVISjslmjU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552927; c=relaxed/simple;
	bh=kzoAQ0TIAKj3wpRhrI20iy1Mzu3Nxd+OqQz5wV3Q5bc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F91hoEtxQHJFgbWNZaChdrRBYpc2cEXrs8abxiejq+PKD/OhsO04NvL+yXVVIzMmuERuS/FjRsDe221QRYj9+Jy/XR0qrrhr26RUUWp49J9scTEt4lwXQE/6zkBrY0poUaqibWDB7TkilY4bqfzU1wBiE9BhrbPhuLZBC4oo10k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LDidU16b; arc=none smtp.client-ip=209.85.160.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LDidU16b"
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-530f5e827c6so82048331cf.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 03:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789552921; x=1790157721; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R6OFoafdrMMz53fDU3YWS2lKKje8yOybFQW+SwJ6hUc=;
        b=LDidU16bglBmNsq/XMQYPP0PEqOxe12+C5LPnblPo/PSVzCD89YbzRKNEK7VYrTX8x
         U6w/0Aw+WIGUbFBbU4HBEwC9SOTWH8G4U0ba3IZO/X6TmO6weX57qIMNGY/cvUBgmv8J
         cSBniG6169L4KiIncE8t9Cu2bfZdFXBBIZIKEJsXoH4kjqc+EDYeg0BswJaIWgKu8tJp
         Pyk5eT7I6daVXa1xy/Z/N3uB5VGaga0vItuuh/JpJin1VNGOKjKrCN7kn8Otfu/stheV
         RfjsSCmwnUlCPalykmtaFif5Wzbz1WlSBa5ogomanqO22KschQDst3iKJLH0cY9nbyGr
         1o7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789552921; x=1790157721;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R6OFoafdrMMz53fDU3YWS2lKKje8yOybFQW+SwJ6hUc=;
        b=K4ejjrqVO71/2CfOwCrCJk2R/3TGpg9OMGzYkQxeDkxzn5nrtkpYCcIPfHTwv6uljM
         L/DtAod2rtn8nxQTMkRaFzGNPNpc8G4SXRdw7V+U1BM8Q4oHpotSQK3fAjK6234YdcCo
         FYpBCCHB66RchShjMDpP1BK4eH9phjM1eQIOxZxyDmIbtTLE7ST97s19elP9tCXaSXP+
         P93ZM+TkmsezN77nj2HoWDFhLvUF+DQT0L7pth8xAI+RiJC0i7mRmxEKbLqJy6FYgad2
         9vFsbeUTjEkoqYINTEz1ue4SFa+ReMfd8YI89CizjuysIyfsOg/cb5FhuVCOHHw/JEne
         00Lw==
X-Forwarded-Encrypted: i=1; AKwUvBxYxV0dnIloxjmMuflwCRlV+do/JshSSp0KiDrhYCRNlPLjRojzboTmIrfX/WOGlFWC583y3Eo=@vger.kernel.org
X-Gm-Message-State: AFuF++mUilLCOEhxrEMDe3eRrhZdeOr3lIvtOkyKcIaeEDUhSsUnIVZy
	9GsyRQW5cnHcx4QECzFvko1X7po6ZP6Cg6pMl0aKGnsdr/3KDlwXlCw343q2EqHgfe+sYgDKNMe
	5RwiuvU4s66ZIUw==
X-Received: from qtbhx2.prod.google.com ([2002:a05:622a:6682:b0:531:113f:e4da])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:190a:b0:52d:92c1:b7b2 with SMTP id d75a77b69052e-5327ede31e1mr30502881cf.2.1789552920703;
 Wed, 16 Sep 2026 03:02:00 -0700 (PDT)
Date: Wed, 16 Sep 2026 10:01:55 +0000
In-Reply-To: <20260916100155.1398403-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260912150944.3470971-1-edumazet@google.com> <20260916100155.1398403-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916100155.1398403-6-edumazet@google.com>
Subject: [PATCH net v2 5/5] gre: fix out-of-bounds read of erspan metadata in
 collect_md mode
From: Eric Dumazet <edumazet@google.com>
To: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, dsahern@kernel.org, idosch@nvidia.com, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

erspan_rcv() and ip6erspan_rcv() copy the ERSPAN metadata out of the
packet for collect_md tunnels:

	pkt_md = (struct erspan_metadata *)(gh + gre_hdr_len +
					    sizeof(*ershdr));
	...
	memcpy(md2, pkt_md, ver == 1 ? ERSPAN_V1_MDSIZE :
				       ERSPAN_V2_MDSIZE);

Both read 8 bytes at 12 bytes from the start of the GRE header, but only
ask pskb_may_pull() for erspan_hdr_len(ver) bytes beyond it, which type I
support made 0 for version 0. Two ways to get there:

- An ERSPAN type I packet has a 4 byte GRE header and no ERSPAN header
  at all, so erspan_rcv() sets ver = 0 and only pulls the GRE header. It
  still falls back to a collect_md tunnel through itn->collect_md_tun,
  and there the ternary above picks ERSPAN_V2_MDSIZE.

- A packet with an 8 byte GRE header and ershdr->ver == 0 is malformed,
  yet neither erspan_rcv() nor ip6erspan_rcv() validates the version
  before using it, so erspan_hdr_len(0) pulls nothing either. A version
  above 2 is not an out-of-bounds read, but it does store a version that
  the transmit side (erspan_fb_xmit(), ip6erspan_tunnel_xmit()) rejects.

Reject a base header whose version is neither 1 nor 2, and skip the
metadata extraction for type I, which has none: ip_tun_rx_dst() hands
out a zeroed option area, so md->version = 0 alone describes it.

Fixes: f989d546a2d5 ("erspan: Add type I version 0 support.")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ip_gre.c  | 34 ++++++++++++++++++++++------------
 net/ipv6/ip6_gre.c |  2 ++
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 696884f53cdcc65fe87cf04f357f1cc45a7e0736..92f3a52d20d38186c3ce87824a8e15c9e00a925f 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -274,7 +274,6 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 	struct ip_tunnel_net *itn;
 	struct ip_tunnel *tunnel;
 	const struct iphdr *iph;
-	struct erspan_md2 *md2;
 	int ver;
 	int len;
 
@@ -294,6 +293,9 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 
 		ershdr = (struct erspan_base_hdr *)(skb->data + gre_hdr_len);
 		ver = ershdr->ver;
+		if (unlikely(ver != 1 && ver != 2))
+			return PACKET_REJECT;
+
 		iph = ip_hdr(skb);
 		__set_bit(IP_TUNNEL_KEY_BIT, flags);
 		tunnel = ip_tunnel_lookup(itn, skb->dev->ifindex, flags,
@@ -318,6 +320,7 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 		if (tunnel->collect_md) {
 			struct erspan_metadata *pkt_md, *md;
 			struct ip_tunnel_info *info;
+			struct erspan_md2 *md2;
 			unsigned char *gh;
 			__be64 tun_id;
 
@@ -334,19 +337,26 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 			info = &tun_dst->u.tun_info;
 			info->options_len = sizeof(*md);
 
-			/* skb can be uncloned in __iptunnel_pull_header, so
-			 * old pkt_md is no longer valid and we need to reset
-			 * it
-			 */
-			gh = skb_network_header(skb) +
-			     skb_network_header_len(skb);
-			pkt_md = (struct erspan_metadata *)(gh + gre_hdr_len +
-							    sizeof(*ershdr));
 			md = ip_tunnel_info_opts(&tun_dst->u.tun_info);
 			md->version = ver;
-			md2 = &md->u.md2;
-			memcpy(md2, pkt_md, ver == 1 ? ERSPAN_V1_MDSIZE :
-						       ERSPAN_V2_MDSIZE);
+
+			/* Type I has no ERSPAN header, thus no metadata to
+			 * extract: reading it would go past the @len bytes
+			 * pulled above. ip_tun_rx_dst() zeroed @md for us.
+			 */
+			if (!is_erspan_type1(gre_hdr_len)) {
+				/* skb can be uncloned in __iptunnel_pull_header, so
+				 * old pkt_md is no longer valid and we need to reset
+				 * it
+				 */
+				gh = skb_network_header(skb) +
+				     skb_network_header_len(skb);
+				pkt_md = (struct erspan_metadata *)(gh + gre_hdr_len +
+								    sizeof(*ershdr));
+				md2 = &md->u.md2;
+				memcpy(md2, pkt_md, ver == 1 ? ERSPAN_V1_MDSIZE :
+							       ERSPAN_V2_MDSIZE);
+			}
 
 			__set_bit(IP_TUNNEL_ERSPAN_OPT_BIT,
 				  info->key.tun_flags);
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 8ebda0b6a78b2236b439f5499d84f34f652fcbe2..a59fb82c74dad7f0c1d1128338e7bed1e3c7116f 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -503,6 +503,8 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 	ipv6h = ipv6_hdr(skb);
 	ershdr = (struct erspan_base_hdr *)skb->data;
 	ver = ershdr->ver;
+	if (unlikely(ver != 1 && ver != 2))
+		return PACKET_REJECT;
 
 	tunnel = ip6gre_tunnel_lookup(skb->dev,
 				      &ipv6h->saddr, &ipv6h->daddr, tpi->key,
-- 
2.55.0.1032.g73a4cd73de-goog

