Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974652;
	b=PcuYomvT6hu/Q70sZ8uJcJ7XA/rmT2NAbtBlIOlZb+P7Sdlq1+sTro1+YLF4pLOepFqE
	 FOH2qN0njJmcVIcRGqRx8Z0hAkSmKqxT9qt9k4tUAHG1EbcEkDvKEsOU8TiLapyqKG54y
	 8NzEroq1lomP8uobwAQ18Q40/7MNz+zZE0dl6HwXZg40Dhd8pw5pU2tdyTSfwc94NBeQL
	 amLgL28pzj0zoDfoEvB1Zl0wYFVFxw2vD7WiGMmZojGqs19APUwFObHV1VO7A5Qqmv7xV
	 oMJPdnHmV00FdY0kjVtk2nZDVFii3wAeDRB37vsAHFUwGHUJHviG+DrlILMTapijTOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974652;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dgU4K6jypQRq1j+ccJv6VGA6lIRv41Ji69kDadDpuPo=;
	b=jLrzlWujySUHhITTyYLtLaa/aUwcPt+lDJ1RvMXAC/Vx349sIZ0sYFA3x8ZQdxdX8KM9
	 9l2rol4rj5t5FyNrLhLudGG5afaQsau2BhihKAeYWT2OcMMCzK6gZgscFkwzBSufOoLDb
	 KzShGJDebSQwlZekibXO5VQJsvhmiadHA0dkYclpLRpxzEMLSw11CWUaMT14GhD79T7Al
	 p04NRa5p2zz+Fvm3UTEGbJohcWE+DVCFKR/56lQgI4jXK2oFachHxX6W18vz45jfdSn1W
	 yLhGlnvJ7f1RsYWs7jL9YEEN3t5EThPsvNpYSq4VOukVA2a1uoOeny6zRJ14xseZErg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=crkkAHmX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1419D606A329
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=crkkAHmX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031E81F008A1;
	Fri,  6 Nov 2026 14:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793974651;
	bh=dgU4K6jypQRq1j+ccJv6VGA6lIRv41Ji69kDadDpuPo=;
	h=From:To:Cc:Subject:Date;
	b=crkkAHmXuYFacvKzL9mhWCffs5WnubNXiTwhe0v9aTpvUhs7sDJfQyKrG2cyZyvcv
	 T+81N6e7ND+Ar1ieq5BLym/0ySLo9kxDq9d87HplM/hhdQXMjw1B67QkhD9Sv+ZaCZ
	 Mz89g++i+fwJWH3RKnOLA3ounpXvAzT4maA+lsMoAvSiAvX+7kr/UpywL7DZt61k00
	 2f9Rsv/tLWvNTYV3PgblEKtnn/w5/R8lazwG+14POhmjxhvqX1BK7uS+Ugxjpt5e+i
	 u4SoBPI9sVdDa6GggSZiRaxzEZvaEoD838S40iLeoZkhWUvzUESMo3UfPzsgykD9n9
	 NfVHYZLTcBCWQ==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net] udp: check frag_list IP family before using skb_segment_list()
Date: Fri,  6 Nov 2026 15:17:27 +0100
Message-ID: <20261106141727.2303218-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
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

From: Kyle Zeng <kylebot@openai.com>

UDP fraglist GRO uses SKB_GSO_UDP_L4 for both IPv4 and IPv6.

__udp_gso_segment() reuses the frag_list skbs when the geometry of
the head skb was not modified. skb_segment_list() keeps the network
header of each frag_list skb as it was at GRO time and only adjusts
the transport header offset.

Nothing guarantees that the head skb still has the IP family of the
frag_list skbs: helpers like skb_mpls_pop() let the caller choose
the new protocol. In that case __udpv6_gso_segment_list_csum()
handles the 20 byte IPv4 header of each frag_list skb as a struct
ipv6hdr, and can write IPv6 addresses beyond its linear part.

Check the IP version of the first frag_list skb. All skbs in the
list belong to the same flow, so they share the same IP family.
Use the skb_segment() fallback on a mismatch. Regular fraglist GRO
traffic keeps the fast path.

Fixes: b936a9b8d4a5 ("net: ipv6: fix UDPv6 GSO segmentation with NAT")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
[edumazet: simplified the fix, rewrote the comment and the changelog]
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
This was found by an AI code review agent.
The issue was not triggered, no reproducer was provided.
The fix was tested with tools/testing/selftests/net/udpgro_fwd.sh.

 net/ipv4/udp_offload.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index cf07c3c6611a22c29b57a72420f2f940609f5e9a..802365b4780fdf7dc19ea7374d51d713e4eb736a 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -514,9 +514,14 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	}
 
 	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST) {
-		 /* Detect modified geometry and pass those to skb_segment. */
+		/* Detect modified geometry and pass those to skb_segment.
+		 * SKB_GSO_UDP_L4 is used by both IPv4 and IPv6: also make sure
+		 * the frag_list skbs still have the IP family we segment for,
+		 * as their network headers are not rebuilt.
+		 */
 		if ((skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size) &&
-		    !(skb_shinfo(gso_skb)->gso_type & SKB_GSO_DODGY))
+		    !(skb_shinfo(gso_skb)->gso_type & SKB_GSO_DODGY) &&
+		    ip_hdr(skb_shinfo(gso_skb)->frag_list)->version == (is_ipv6 ? 6 : 4))
 			return __udp_gso_segment_list(gso_skb, features, is_ipv6);
 
 		ret = __skb_linearize(gso_skb);
-- 
2.53.0

