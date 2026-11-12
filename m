Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794462429;
	b=pd9ppoK7s5BuD+m8H9Wg5cYAG+z1v49z8R6hn61zi8bZL+BxlM33UFaAloQnzeR3wrFb
	 S1uBJB3vP+V7fpnyoMvTR2MLoIIxMuh1kc5WkvJ4ZaByDDwX2FqWqwWzIW2+HbE0G9mVx
	 oM+8T4umW+XKwTtCYHd7AVPEgfHCCDZAJ+4cDUlnriunT86CqWHYeFvCmd2HAd+ARqceu
	 nFtB71wgioJT3X2r7idH6Vhb60C7myCG3FcDXrXtgrbXP+FhCPrDJDMSXazGC3F6IhN1w
	 xsskCB7wtI16xkqY5hWB3qkwl9vaR6f4ppYq2pieBO19FtE+WEaO52pR6278791rS4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794462429;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=f5zZSofPOE7pOeadwcOvAoWM5g2nJttE3jMN5ZTD1KM=;
	b=k6iNTN37i1d/1O2TbQoDI9hwgy5wsj2VyH3AvGFHx1FUuiQKmSDG2TBn1WxGWcYcPfRm
	 T2invjMNyMbqt42skINV+DD0UJJNBrdP1T86czlAdDa8ueuZFA8BEd5hJ0gxgH7XKEVvo
	 eyq0EsiJvI2UgT42Fdj//abJ9s32XYO0Y29E2jTgeesS3Jwg6KnmAk01G7tadWAOdu8w8
	 kq1zsbvm2YbWNwf3ype3qyAz2TsqAO4zyoaOWt4fliBPEjG5qzDsChjWb3FJCfaMC2fnu
	 Mz/0e0Bxv25KZl8xj/SZf0QihRODGIvIs3QvCSnHPJ4CgVz7gqy91fJ3bCjftfbAR6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=goivygNS;
	arc=none smtp.remote-ip=95.215.58.224
Received: from mta1.migadu.com (out-224.mta1.migadu.com [95.215.58.224])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6814606A321
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 05:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6814606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=goivygNS
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Yc0v2vfQ0O7Xkps+Yu8K3w1Y6vmIMR7uOHhL3n0bXUY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794462426; v=1; x=1795067226;
 b=goivygNSyXEwoFusujkN+y4PjvFBczyVOWVYkNQ+cu4vcx5eR33089ezgBjje1JC/Wdv5KoX
 H8xYm5XRk0p2yOYEmxq0gpFtey0EbMZZSsOUygzEl6SoCO2nSyHvammUwPYmILaf21/TKCm9p+q
 dgtbQoJo+rf7tjT4WZNbf4uI=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 7497ed603e4f674f;
	Thu, 12 Nov 2026 05:47:06 +0000
X-Mizu-Trace-ID: 7497ed603e4f674f
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Thu, 12 Nov 2026 13:46:44 +0800
Subject: [PATCH net v4] ipv6: ioam6: do not modify shared tuninfo
 eh.nexthdr
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-ipv6_ioam_lock-v4-1-89e3381be525@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XNTQ7CIBAF4KsY1mIYCk3rynsYYygOOv5AUyrRm
 N5drC7ULmfyvvceLGJHGNly9mAdJooUfD7UfMbswfg9ctrlm0khSwBRcGpTuaVgLttzsCdeahD
 SGq1qUbGM2g4d3cbCNfPYs837Ga/NEW3/qnrFDhT70N3H2QRj+LOg/hcScODKSWUVNDnSrE73M
 /kQF9aP7Ul+ez3xMvvKCTSFsMo5M/HFt68nvsjeVCXUutL1DvDHD8PwBOYRwP9EAQAA
X-Change-ID: 20261103-ipv6_ioam_lock-65102ca54908
To: Justin Iurman <justin.iurman@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>, 
 Sashiko <netdev-bot+sashiko@kernel.org>
X-Mailer: b4 0.16.0

From: Hangbin Liu <liuhangbin@kylinos.cn>

ioam6_do_inline() and ioam6_do_encap() stored the next header into
the shared ilwt->tuninfo template and then memcpy()ed it into the
skb. The lwtstate is used from multiple CPUs without locking, so
another packet can overwrite eh.nexthdr between the store and the
memcpy.

The packet can then leave with an HBH nexthdr that does not match its
payload (e.g. TCP labelled as UDP, or a local packet labelled
IPPROTO_IPV6). Set nexthdr on the per-packet Hop-by-Hop copy after
memcpy instead, leave the shared template read-only.

Mark the tuninfo argument const now that the shared template is no
longer modified, and drop the unnecessary (u8 *) cast in memcpy.

Fixes: 3edede08ff37 ("ipv6: ioam: Support for IOAM injection with lwtunnels")
Fixes: 8cb3bf8bff3c ("ipv6: ioam: Add support for the ip6ip6 encapsulation")
Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
Closes: https://lore.kernel.org/netdev/179336082844.3134.1265197633714491521@kernel.org
Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
The issue is reported by Sashiko. It was confirmed with concurrent TCP
and UDP traffic through a shared ioam6 inline route on a multi-CPU host.

Without the fix, a packet can leave with an HBH nexthdr that does not
match its payload (e.g. hbh->nexthdr=17 with a TCP segment after the HBH,
or hbh->nexthdr=6 with a UDP segment). With the fix, the same load reports
no HBH/L4 mismatch: nexthdr is written only on the per-packet Hop-by-Hop
header after memcpy, never on the shared tuninfo template.
---
Changes in v4:
- Use a temp variable for the ipv6_opt_hdr setting (Jakub Kicinski)
- Link to v3: https://patch.msgid.link/20261109-ipv6_ioam_lock-v3-1-a86195859d1e@kylinos.cn

Changes in v3:
- make tuninfo as const (Justin Iurman)
- Link to v2: https://patch.msgid.link/20261105-ipv6_ioam_lock-v2-1-8f0ea30c4ffa@kylinos.cn

Changes in v2:
- Add one missed Fixes tag. No code change.
- Link to v1: https://patch.msgid.link/20261104-ipv6_ioam_lock-v1-1-4f24c41b261b@kylinos.cn
---
 net/ipv6/ioam6_iptunnel.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index cfb2c41634a0..e8be0d922f74 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -254,10 +254,11 @@ static int ioam6_do_fill(struct net *net, struct sk_buff *skb)
 }
 
 static int ioam6_do_inline(struct net *net, struct sk_buff *skb,
-			   struct ioam6_lwt_encap *tuninfo,
+			   const struct ioam6_lwt_encap *tuninfo,
 			   struct dst_entry *cache_dst)
 {
 	struct ipv6hdr *oldhdr, *hdr;
+	struct ipv6_opt_hdr *opt_hdr;
 	int hdrlen, err;
 
 	hdrlen = (tuninfo->eh.hdrlen + 1) << 3;
@@ -276,12 +277,13 @@ static int ioam6_do_inline(struct net *net, struct sk_buff *skb,
 
 	hdr = ipv6_hdr(skb);
 	memmove(hdr, oldhdr, sizeof(*oldhdr));
-	tuninfo->eh.nexthdr = hdr->nexthdr;
 
 	skb_set_transport_header(skb, sizeof(*hdr));
 	skb_postpush_rcsum(skb, hdr, sizeof(*hdr) + hdrlen);
 
-	memcpy(skb_transport_header(skb), (u8 *)tuninfo, hdrlen);
+	opt_hdr = (struct ipv6_opt_hdr *)skb_transport_header(skb);
+	memcpy(opt_hdr, tuninfo, hdrlen);
+	opt_hdr->nexthdr = hdr->nexthdr;
 
 	hdr->nexthdr = NEXTHDR_HOP;
 	hdr->payload_len = cpu_to_be16(skb->len - sizeof(*hdr));
@@ -290,7 +292,7 @@ static int ioam6_do_inline(struct net *net, struct sk_buff *skb,
 }
 
 static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
-			  struct ioam6_lwt_encap *tuninfo,
+			  const struct ioam6_lwt_encap *tuninfo,
 			  bool has_tunsrc,
 			  struct in6_addr *tunsrc,
 			  struct in6_addr *tundst,
@@ -298,6 +300,7 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
 {
 	struct dst_entry *dst = skb_dst(skb);
 	struct ipv6hdr *hdr, *inner_hdr;
+	struct ipv6_opt_hdr *opt_hdr;
 	int hdrlen, len, err;
 
 	hdrlen = (tuninfo->eh.hdrlen + 1) << 3;
@@ -314,8 +317,9 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
 	skb_mac_header_rebuild(skb);
 	skb_set_transport_header(skb, sizeof(*hdr));
 
-	tuninfo->eh.nexthdr = NEXTHDR_IPV6;
-	memcpy(skb_transport_header(skb), (u8 *)tuninfo, hdrlen);
+	opt_hdr = (struct ipv6_opt_hdr *)skb_transport_header(skb);
+	memcpy(opt_hdr, tuninfo, hdrlen);
+	opt_hdr->nexthdr = NEXTHDR_IPV6;
 
 	hdr = ipv6_hdr(skb);
 	memcpy(hdr, inner_hdr, sizeof(*hdr));

---
base-commit: 145480b28ca82e9fae789427cc4569e596515a32
change-id: 20261103-ipv6_ioam_lock-65102ca54908

Best regards,
--  
Hangbin Liu <liuhangbin@kylinos.cn>

