Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470463D1A81
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696320; cv=none; b=gFC6kGv2OlGD3sWjEXV/pycTC5RzoyDegn98u+Vvnji2DIhqUxCQ1djZqzkXXOs6wqT8C4lTjF4qIk7jp3NYixi6F55fUaMKssa+hSLfVPsGYfpat2CUANzubOG5P2r/BzAt2YuKyAOMxF1IJKbysW8AotYLT9R8DJQSgOIR69c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696320; c=relaxed/simple;
	bh=z7hwjjye3vJ8DoOnYkiJcvihXpII4s4D47WOcI50pko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gKZZbZSs/0uFIEDqwlf3ugbTrTBnc+qzwfKeypvSXN1fJ8AwXrmuHET1mTZIhWmdMcOB4jnpJ8lZYp6hHvIH0QuEiBbMk5Vf0rEu8ZQncuNx0HgYy3oLbbATps54qK3osNksdqBaloZ4L0TsDz6znnmhHm/pLJHgUatm/kFVcnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yz/3FhcY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yz/3FhcY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4D71F00893;
	Tue, 29 Sep 2026 15:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790696318;
	bh=86rq5TU51DoaI2jIXkkSAiBcVEb4RthylmFNNVAurHg=;
	h=From:To:Cc:Subject:Date;
	b=Yz/3FhcYy//6yrQffprCFRspt0ezVmeScFnDcxslRMl6mVw0Pl1GXz6pRjjjSZVwu
	 E2gUW4Hp8KOIWG8ux7uoBHJU2LCMZK2t2ll20sp+YSO3lVNX0ntjo2OO1wHIAp0ZeV
	 DtpYcf9ccX7sMUwxsXVaueWEtP+oEd0TL94wAK/ZtWJTLkQ+fVRPxxyO1MMpwOXAvo
	 CWdd9SGopF1Av+SVY5skljahQzFB8yaMr+SC9BUXZwHBOL+zABfg/r5P7OQQj+9RmE
	 jsOARzBylulh5iycYOhtFcpoGRb/i4UADrRbR6V52l5sWJbBnJ96f/NcbeeaZMoSmK
	 JsfFPDH9gDgBQ==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	edumazet@google.com,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net-next] ipv4: use zero IPID for atomic datagrams on connected sockets
Date: Tue, 29 Sep 2026 15:38:34 +0000
Message-ID: <20260929153834.566551-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip_select_ident_segs() uses the per-socket private generator
for connected sockets, even for packets with IP_DF set.

This was historically done to work around buggy Windows95/2000
VJ header compression implementations, dropping every other
packet in a TCP stream when the IP ID field did not change.

RFC 6864 section 4.2 states that "Originating sources MAY set the
IPv4 ID field of atomic datagrams to any value".

Packets with IP_DF set and skb->ignore_df cleared can not be
fragmented, neither locally (ip_fragment() refuses to do so)
nor by routers on the path.

Set their IPID to zero, like we already do for unconnected sockets
and in ip_build_and_send_pkt(). FreeBSD also does the same by
default (net.inet.ip.rfc6864 = 1).

Connected sockets still use their private generator for packets
without IP_DF, or with skb->ignore_df set.

This avoids an atomic operation on a shared cache line for
connected UDP sockets using IP_PMTUDISC_DO/IP_PMTUDISC_PROBE,
and TCP no longer touches inet->inet_id in the fast path.

Minor side effects: IP IDs can no longer be used to distinguish
network duplicates from TCP retransmits, or to correlate packet
captures taken at different points. OS fingerprints will also change.

Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 include/net/ip.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 6f602df72ee621ee4ee45e70beef0a1b5145367f..ffa4ba0b571fc42ba9855e2f3bbcb1c6d12a1e1d 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -584,6 +584,13 @@ static inline void ip_select_ident_segs(struct net *net, struct sk_buff *skb,
 {
 	struct iphdr *iph = ip_hdr(skb);
 
+	/* RFC 6864: the IPv4 ID of atomic datagrams has no meaning.
+	 * DF packets without ignore_df can not be fragmented.
+	 */
+	if ((iph->frag_off & htons(IP_DF)) && !skb->ignore_df) {
+		iph->id = 0;
+		return;
+	}
 	/* We had many attacks based on IPID, use the private
 	 * generator as much as we can.
 	 */
@@ -603,12 +610,8 @@ static inline void ip_select_ident_segs(struct net *net, struct sk_buff *skb,
 		iph->id = htons(val);
 		return;
 	}
-	if ((iph->frag_off & htons(IP_DF)) && !skb->ignore_df) {
-		iph->id = 0;
-	} else {
-		/* Unfortunately we need the big hammer to get a suitable IPID */
-		__ip_select_ident(net, iph, segs);
-	}
+	/* Unfortunately we need the big hammer to get a suitable IPID */
+	__ip_select_ident(net, iph, segs);
 }
 
 static inline void ip_select_ident(struct net *net, struct sk_buff *skb,
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

