Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698202;
	b=1QzNrhgiRB6bmMjZywt3Zn+IY+hz8tyXHcI1o+Zhojl/YoP5hSSHfqYAI6JqUGeuYvHx
	 MLtN+NlXVt+vhJDphMPjtYsmF63X3tITOOx3DN0SDPDS+0X9OnDB27H2cQEPqvtEpliNk
	 9NkSzRVcNNWn6vvcawIuZFlEAznGLBk+78U8RhREnnsYZixj92xjEG97qQGVEPMg0qt4S
	 74LoV7E+D4xdTnNJSV5JEN4NeHk+T+ZnjU0jgNpRBGJGh//NibFKPAiNXgkiZg/tcnH9r
	 05obPw74HgIypXawvYDfphXZYQ2W+EyqVXNmnqqYWbSnDNSbHyo239nqtO7ZIUHqbRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698202;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=08S49YPFv5p4OLhTFfMBGQJCK2T2CgAjwlfY5smsfTI=;
	b=jRhieZiPub4o9zLZ008+YlHRUwsLxGD9xOtixOxDWh3ch0dDHQzjTYwosuo0ucuGtoTw
	 ihQX3nUH3PkiKYiYeEVEjA7pKmIiyMaE56ByU2V1RLEfCzRtq9pC4hvYrPUtdiWAZtUF/
	 zBlqCb6nkq5nXMfD19VwneDB51sQXJUVxreGJPP9Fs2REhuCoiOoKElXXlw00juhNQe/K
	 bOWh0KZCnGLUbTFqC9NH0D1ZFl7xCmhkLQNVuY7lIfnM2U8dBRPAqdxRtcr8ttiE8F+a/
	 qEeK5ogZvSfP+56CxLDJPYt3Zyp5NgQ+oVtF0Mio/T5LEQij37wEAWL9ttPDSPeK7tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BSeacpsA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B4C606A332
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BSeacpsA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E681F00A15;
	Tue,  3 Nov 2026 09:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793698201;
	bh=08S49YPFv5p4OLhTFfMBGQJCK2T2CgAjwlfY5smsfTI=;
	h=From:To:Cc:Subject:Date;
	b=BSeacpsAsqY/mQjN/gnPiyI1It1CKXb2MmOwLXtev3KQ8RTg5uaSR06yz3HCG55Du
	 gBsfDC8E1yQA9xhbRxM2z18cHDSBUf1w1dUREjP6xQoat/SGpdmqAsxD7GMl09fBfO
	 0ADO1QYfQJ8BMnsff3weA/UOS4B3h1HD3z2mo9IXoIwZMsyXyu1AoiPvbnTTr+v9ml
	 ahfiQ27TKheK5vvDLlzy0LJ84EJY97xfGWLwKbk8N5nbREpnvdlg7ppVico9wWEqKj
	 aczHSw7tYc9+ziTAsUY/WDeP297S8sWCCt56jVa3dWhb6UCDCeI3vd0YWBBeKy1RmZ
	 esOzR7jebAxEQ==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net] inet: frags: bound the wmem charge of the socket completing a reassembly
Date: Tue,  3 Nov 2026 10:29:57 +0100
Message-ID: <20261103092957.4164530-1-edumazet@kernel.org>
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

When a socket owned fragment completes a reassembly queue,
inet_frag_reasm_prepare() and inet_frag_reasm_finish() charge the
truesize of all other fragments to its sk_wmem_alloc. These fragments
were orphaned when queued, and might have been sent by someone else,
for instance padded TUN packets.

Commit 3ae20e4697eb ("inet: frags: limit the truesize of a reassembly
queue") bounds this charge to INT_MAX / 2 per queue, but a socket can
complete several queues while the reassembled skbs are still alive,
for instance held in a qdisc. sk_wmem_alloc can then go past INT_MAX,
refcount_add() saturates it with a WARN, and the socket is leaked.

This is reachable from an unprivileged user/network namespace, by
raising ipfrag_high_thresh.

Refuse the reassembly if the charge would push sk_wmem_alloc above
2 * sk_sndbuf, the bound ip_append_data() uses, plus 4MB of slack for
fragments inflated by a refragmentation with a small MTU.
SO_SNDBUFFORCE requires CAP_NET_ADMIN in the init user namespace,
so an unprivileged user can not raise sk_sndbuf above 2 * wmem_max.

The check is done before inet_frag_reasm_prepare() modifies the queue.
All callers already kill the queue when it returns NULL.

Fixes: 18685451fc4e ("inet: inet_defrag: prevent sk release while still in use")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://lore.kernel.org/netdev/24feda7d-ae49-45af-9596-2cc5f149f28e@redhat.com/
Cc: Florian Westphal <fw@strlen.de>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 net/ipv4/inet_fragment.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 0b8d22ffafca69b2bccd98eca3d4bda93ebb816a..c11d7e976dfa534b773f99f33f47fcc562ed569b 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -17,6 +17,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/slab.h>
 #include <linux/rhashtable.h>
+#include <linux/sizes.h>
 
 #include <net/sock.h>
 #include <net/inet_frag.h>
@@ -519,6 +520,25 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
 }
 EXPORT_SYMBOL(inet_frag_queue_insert);
 
+/* When a socket owned fragment completes a queue, the truesize of all
+ * other fragments is charged to its sk_wmem_alloc, although they were
+ * orphaned when queued and possibly sent by someone else.
+ * Bound this like ip_append_data() bounds the memory a socket can
+ * allocate (2 * sk_sndbuf), plus slack for fragments inflated by a
+ * refragmentation using a small MTU. Otherwise, several reassembled skbs
+ * alive at the same time can saturate sk_wmem_alloc, and leak the socket.
+ */
+#define INET_FRAG_WMEM_SLACK	SZ_4M
+
+static bool inet_frag_wmem_ok(const struct inet_frag_queue *q,
+			      const struct sock *sk)
+{
+	u64 limit = 2ULL * READ_ONCE(sk->sk_sndbuf) + INET_FRAG_WMEM_SLACK;
+	u64 wmem = (u64)refcount_read(&sk->sk_wmem_alloc) + q->truesize;
+
+	return wmem <= min_t(u64, limit, INET_FRAG_MAX_TRUESIZE);
+}
+
 void *inet_frag_reasm_prepare(struct inet_frag_queue *q, struct sk_buff *skb,
 			      struct sk_buff *parent)
 {
@@ -530,6 +550,8 @@ void *inet_frag_reasm_prepare(struct inet_frag_queue *q, struct sk_buff *skb,
 	int delta;
 
 	if (sk && is_skb_wmem(skb)) {
+		if (!inet_frag_wmem_ok(q, sk))
+			return NULL;
 		/* TX: skb->sk might have been passed as argument to
 		 * dst->output and must remain valid until tx completes.
 		 *
-- 
2.53.0

