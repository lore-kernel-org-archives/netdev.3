Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793784458;
	b=AaakThGoupoXE/4ixUOO6bjE9huBumVPjNITYCBdYIUwHE//yKGKIr0bHjG0CJdtthjQ
	 seVjCEzJnUwI6/NOin7+A6FCnnE0Kxnxbdb7J7MtYmGSYZTjRSc0Z8XI/A6HCe1qNllev
	 +wmRa/lEACKIBTz4b8FnEVPCEVZciiX5c15CDaMlRadzOfl/XiOfgIyjoFi4AFCUOYzjg
	 UkdtpbbY7hjIxo4bIHR6UbVpXeNW7FWhNJ4wZ5d1MviNiJR+6FAsuWkx76ICimM2zg8iz
	 OHx4GY7z36D2IcacLohXsqRCzbthRBNM9GvamdA+ASDn9vPhBuP4naOYNeA7akooQCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784458;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=n9KVR6E0wEE3Z1SX32MeaGZYTyg91eegU950Grgc2zM=;
	b=cH0bH5Ly+pounJPut4nS8LjtGXUgZWhWen96wV0RiEpCx8EaaGayTk+AmroimVrzabZn
	 DQqCEPfE2l9IMjf/S4h9gagEhaGD1AxtWzT+vUfBvQ/lt/epxfcGs1HiUv54t/pJs6zWT
	 669DMQxkGHtEm7siaOZB3+bT75ntDtq92vbn7omuURTBsNskmaHVMLS5j6nHxG0FzBLYC
	 VrDLiEDHL4KtSQVzZiomoPsB1mCvZePwFNW0COWJNmuxaVD49O8JrFRrAxpIGRDukL48R
	 /4wOfSKF/LzSSn0p5UD3+uI/g9lZ1AUikPEGHJ0dbLsr1eYLRHYfEeuBIRuSKDsX+tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="D/wlJX2F";
	arc=none smtp.remote-ip=91.218.175.200
Received: from mta0.migadu.com (out-200.mta0.migadu.com [91.218.175.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25370606A32D
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 09:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25370606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=D/wlJX2F
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=EfkSQXB6pzLCCxjVLJgFvVH/HoenBethMWU3Rt+A2wg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793784456; v=1; x=1794389256;
 b=D/wlJX2FYTRRD3j0lO+nolV4LuRpvs0Du8i9sSBkvNJxakDQc/kN+15aZ32aQ3obLajG2RQj
 O28czYu+yPRtP/Q7ODQ+Kfg3BXDPehKABKgMWGES30fg6UzySq+jZUK9lmx8O0iv4KK7W6Vne/W
 BLq4s5ZluGb8sjklgIt65GBc=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id f1cadc94103e3a01;
	Wed, 04 Nov 2026 09:27:36 +0000
X-Mizu-Trace-ID: f1cadc94103e3a01
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Wed, 04 Nov 2026 17:27:23 +0800
Subject: [PATCH net] ipv6: ioam6: do not modify shared tuninfo eh.nexthdr
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
Message-Id: <20261104-ipv6_ioam_lock-v1-1-4f24c41b261b@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QqCMBhGX0W+awfbymG+iois9Zd/5TY2k0B89
 1ZdngPnbMiUmDK6akOilTMHX0DVFdxk/Y0EXwpDS22UkgfBcTUjBzuPz+AewjRKameb40m2KFF
 MdOX3b9jD04LhL/PrfCe3fFfY9w+UmUlFdwAAAA==
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

Fixes: 3edede08ff37 ("ipv6: ioam: Support for IOAM injection with lwtunnels")
Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
Closes: https://lore.kernel.org/netdev/179336082844.3134.1265197633714491521@kernel.org
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
 net/ipv6/ioam6_iptunnel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index cfb2c41634a0..b23f8a0cbaa9 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
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
@@ -314,8 +314,8 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
 	skb_mac_header_rebuild(skb);
 	skb_set_transport_header(skb, sizeof(*hdr));
 
-	tuninfo->eh.nexthdr = NEXTHDR_IPV6;
 	memcpy(skb_transport_header(skb), (u8 *)tuninfo, hdrlen);
+	((struct ipv6_opt_hdr *)skb_transport_header(skb))->nexthdr = NEXTHDR_IPV6;
 
 	hdr = ipv6_hdr(skb);
 	memcpy(hdr, inner_hdr, sizeof(*hdr));

---
base-commit: c3e67bd82b9b9b1a5118f09a429ccefe2aab0741
change-id: 20261103-ipv6_ioam_lock-65102ca54908

Best regards,
--  
Hangbin Liu <liuhangbin@kylinos.cn>

