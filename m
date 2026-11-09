Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.245
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794192763;
	b=i1u0QcFJzkmcU6GFvnvb8pKrq+fNl8dwxKH+pfny8fWCVgg4D+6aHz+tbkMz93Fc5yYh
	 GF3AMJlyF/a6SGWE6QFBEw+YO2qC1b7+kC9mvN6I0HQMl7cXechrwmEeXWkHTlEtMBy14
	 jPtKxsBUemq8aKWJRBWLp+akZPKryr7XEChjGSxC+5MkSmAxia6oy6djNATbEI2W7Tguv
	 VUKOhNTrKf3atFRcgYBG5t8pbeyvhMBH7ZYdsTPXSBfs2vCutg5ZJuTZ6Kix+W6j6LTlh
	 zfkKIDkaEeuBpIQprftOrPjuPhvy9dbVijSNHWJJ8Kr7rmS/84BzeE8SXnb/Py/5nRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794192763;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=qB2X3p6Fnij6aDtj4F1N9a2CNtZpESRoicBIwPmoEc0=;
	b=XIbDuWyKU14FufwuGNMOQSRJE9WacQQFwbMbgtqC/nbz4Jc18jARRm2Zb/SXCElXAlWu
	 e2iboHTeRoaWj5IsqhMeqRc2LCIViAtheL4tHON/c2RhjGjzaVotezLs8FwYUvQSrXU5A
	 WaBVCmK/Ecs5fpimTVPkpprLcyEraAVXa2OhvmwAbZuZJDs4pIFJ5uIqY+u5ydC5PiC3W
	 kV86np1777tkSmbQxA6mI0NrML+l/QCg3pej+QFcEln0Uor7l9oQ98c+TWlMWlfQKZcp+
	 AYP11W2fX/pnYCUqmhEhg0qYogr3OJwGxwzhLb4hYcK9UZrBURyR2Lj269jpSeXfl/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eC7adzfA;
	arc=none smtp.remote-ip=91.218.175.245
Received: from mta0.migadu.com (out-245.mta0.migadu.com [91.218.175.245])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FA2606A320
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 02:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54FA2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eC7adzfA
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KgVWWAxyr8iPCwiWN8wYMPXLomCb+GIGzWKMLYf37Ts=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794192760; v=1; x=1794797560;
 b=eC7adzfALQ0L4SM+y+ZdJC3Q5i5q9u43x0RsBuKad2n46bMdwo3ZCSREJmKrjaMErch/haL1
 BoOt+34GR7eIf7biomoRsJyV6Ao43W3E12J2oque0TezGsDMeDoNmXAec7pBPUv0NtmKHRGOUyc
 C7Barj8w+Ln8WBELoC6TkfiY=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id b67e6ef6822d9ad3;
	Mon, 09 Nov 2026 02:52:40 +0000
X-Mizu-Trace-ID: b67e6ef6822d9ad3
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Mon, 09 Nov 2026 10:52:25 +0800
Subject: [PATCH net v3] ipv6: ioam6: do not modify shared tuninfo
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
Message-Id: <20261109-ipv6_ioam_lock-v3-1-a86195859d1e@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WN3w6CIByFX8VxHQ0QnXXVe7TmkCB/aeDAWM757
 iF10Z/Lc3a+883IKwfKo302I6cCeLAmhnyTIdkKc1EYzjEjRlhJKckxDKGswYpb3VvZ4bKghEl
 R8B2pUIQGpzQ80uERGTWi06v09+aq5LherbMW/GjdlLSBpvHbwH8NgWKKuWZcctrESXPoph6M9
 Vtp0ntgn3zxx7PIV5ookRPJtRZf/LIsTzoIe2kEAQAA
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

Making tuninfo as const now since it's not modified anymore.

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
Changes in v3:
- make tuninfo as const (Justin Iurman)
- Link to v2: https://patch.msgid.link/20261105-ipv6_ioam_lock-v2-1-8f0ea30c4ffa@kylinos.cn

Changes in v2:
- Add one missed Fixes tag. No code change.
- Link to v1: https://patch.msgid.link/20261104-ipv6_ioam_lock-v1-1-4f24c41b261b@kylinos.cn
---
 net/ipv6/ioam6_iptunnel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index cfb2c41634a0..a1f954dd7c2a 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -254,7 +254,7 @@ static int ioam6_do_fill(struct net *net, struct sk_buff *skb)
 }
 
 static int ioam6_do_inline(struct net *net, struct sk_buff *skb,
-			   struct ioam6_lwt_encap *tuninfo,
+			   const struct ioam6_lwt_encap *tuninfo,
 			   struct dst_entry *cache_dst)
 {
 	struct ipv6hdr *oldhdr, *hdr;
@@ -276,12 +276,12 @@ static int ioam6_do_inline(struct net *net, struct sk_buff *skb,
 
 	hdr = ipv6_hdr(skb);
 	memmove(hdr, oldhdr, sizeof(*oldhdr));
-	tuninfo->eh.nexthdr = hdr->nexthdr;
 
 	skb_set_transport_header(skb, sizeof(*hdr));
 	skb_postpush_rcsum(skb, hdr, sizeof(*hdr) + hdrlen);
 
 	memcpy(skb_transport_header(skb), (u8 *)tuninfo, hdrlen);
+	((struct ipv6_opt_hdr *)skb_transport_header(skb))->nexthdr = hdr->nexthdr;
 
 	hdr->nexthdr = NEXTHDR_HOP;
 	hdr->payload_len = cpu_to_be16(skb->len - sizeof(*hdr));
@@ -290,7 +290,7 @@ static int ioam6_do_inline(struct net *net, struct sk_buff *skb,
 }
 
 static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
-			  struct ioam6_lwt_encap *tuninfo,
+			  const struct ioam6_lwt_encap *tuninfo,
 			  bool has_tunsrc,
 			  struct in6_addr *tunsrc,
 			  struct in6_addr *tundst,
@@ -314,8 +314,8 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
 	skb_mac_header_rebuild(skb);
 	skb_set_transport_header(skb, sizeof(*hdr));
 
-	tuninfo->eh.nexthdr = NEXTHDR_IPV6;
 	memcpy(skb_transport_header(skb), (u8 *)tuninfo, hdrlen);
+	((struct ipv6_opt_hdr *)skb_transport_header(skb))->nexthdr = NEXTHDR_IPV6;
 
 	hdr = ipv6_hdr(skb);
 	memcpy(hdr, inner_hdr, sizeof(*hdr));

---
base-commit: fafbc4051123d5459ea6950899cec08ed946e278
change-id: 20261103-ipv6_ioam_lock-65102ca54908

Best regards,
--  
Hangbin Liu <liuhangbin@kylinos.cn>

