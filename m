Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6CB3D47A0
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870199; cv=none; b=uT50DXP9k/HNsGmhehvagO+/+lDb75rAGzcb9IRfiEGv8gEr5YRQHG+L9Lvijf0pwYhePig9RFXiByYGLzK4FqAxLbo3LnyKOWLHcEewHPE+MW/ZTzPGiMQ9MelghcjZANnmZXbblztcGyiXFiQAqNPyX5856/45Kt9gZJ3nixk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870199; c=relaxed/simple;
	bh=EhMwwQEh9DXK01RIpBhwFHpbh+UrKQIef+dItVtXoeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ilw2Q5i0izEfoRMOolPd3ZpYVIQntvZ+v746G9TCHwrAV1yAZt5Ss8r7jEivYwJCHhKF296iUW582q+HtDk/pUXEhsAZEJmH+f6fI0+8xsHdl6R/Rhg2BhwnYc2JlJcl2LqV2PdaUFfo1ow/qOjjrj693bHlnqz1X3V97pIzfP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlBUsg29; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlBUsg29"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BB71F000FF;
	Thu,  1 Oct 2026 15:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790870197;
	bh=AzXv+N/Apmx7RYCombhbWAds85T3mAZIs6hb8nHTwQk=;
	h=From:To:Cc:Subject:Date;
	b=YlBUsg29875zTzfj1sZqTfliqe3wjijDvAUqIgm63qikPVohxr2cmVju5y6dpHGOC
	 4cQne8Qk/kcCLwQC/mSwQdEYYa7LsEG+6DBz3KMtLMKIrQzWSKfm9X5ItoH6OvH6TW
	 ETJpoLzy4DuoKBOSUbfBIMd0aW0L18eEYcl9EfaIFhIJns57QJk5W5+Uwh6iOyZEM2
	 gKVTZ+sRK5saXB5aBp6vHjnoEkawsypk2+G3y1XaRhKLUNF1RN/KqVsBqvW5rei6Bc
	 t15uNZO0meA2UjDmVEQE/gBanmdOnFGG6g0x2gHbGRESEs4hCVodOXlxmUKpustgCs
	 0sDd+Sbg24VLQ==
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
Subject: [PATCH v2 net-next] ipv4: use zero IPID for atomic datagrams on connected sockets
Date: Thu,  1 Oct 2026 15:56:33 +0000
Message-ID: <20261001155633.2562504-1-edumazet@kernel.org>
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

For GSO packets, segments get IP IDs 0, 1, ..., n-1 from GSO/TSO.
This does not hurt GRO on receivers, because TCP already forces
a PSH flag on every TSO packet since commit 051ba67447de
("tcp: force a PSH flag on TSO packets"), so GRO already flushes
at TSO packet boundaries.

Connected sockets still use their private generator for packets
without IP_DF, or with skb->ignore_df set. Update the inet_id
kernel-doc accordingly.

This avoids an atomic operation on a shared cache line for
connected UDP sockets using IP_PMTUDISC_DO/IP_PMTUDISC_PROBE,
and TCP no longer touches inet->inet_id in the fast path.

Minor side effects: IP IDs can no longer be used to distinguish
network duplicates from TCP retransmits, or to correlate packet
captures taken at different points. OS fingerprints will also change.

Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: update inet_id kernel-doc in include/net/inet_sock.h (Sashiko)
    mention GSO/GRO behavior in the changelog.
v1: https://lore.kernel.org/netdev/20260929153834.566551-1-edumazet@kernel.org/
---
 include/net/inet_sock.h |  2 +-
 include/net/ip.h        | 15 +++++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 7cdcbed3e5cbfd1a13698942da05b9ceabf72950..24cbabc2458231d0b0a449d30194508a58f2e415 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -207,7 +207,7 @@ struct rtable;
  * @inet_saddr - Sending source
  * @uc_ttl - Unicast TTL
  * @inet_sport - Source port
- * @inet_id - ID counter for DF pkts
+ * @inet_id - ID counter for non atomic pkts
  * @tos - TOS
  * @mc_ttl - Multicasting TTL
  * @uc_index - Unicast outgoing device index
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

