Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793795379;
	b=T3RgneyqTNTRO7rtckDLQEMrRJDM9yU7CROhCs7rX5UbpuD6jmT8O0mZwl4PPUwuzTu7
	 E0cNFicPJglKpD9g2UIYRUbxPbNvhYGN0onteQHrbWac9KwcKDQKoayRsPzeRb63eZPbB
	 wMu7rVo2z994cvZ6CobOTgHp+CWyuTNC4n6SjDGiROByNW0j7oyHBMzf4vfJomtcFIQkE
	 fFphFzF870GrtsSeJRUhvX8F54NELZIxblKYGSsI8WfhQ5BoVVGkgHelVTZYfbn8eJb4D
	 hJ1E+Xg/FaFoLssMRmXgZ40LpABmdhOMiwpD5OJW1TC9OmNOKWQahV61kxi9178lWtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793795379;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qXCTJhJI3/79HSvBTGd8yiSUrhQoGBOGkEtjCUXCtXg=;
	b=P+o/w5PZBUG+4G36b0ZMizpBWMi8dJVzU/RxFvXJaZjiXfU4Rr272CvKQq3fhS9qJHuJ
	 hXR+9v3qHYvvg3y9sET65xUCp0R+bqBM1BgyH2LbR2wh7Bxv1aCfXgaOJ83/ua1J7R/WL
	 IcaQAh063YN1Q86kzZqTDzENiDnD2qzmu1FTvOGEOm7gvmH1piD+OIh2Ixwf2YGU4IkAs
	 gHGcAgM9AqmaUUvDr1RBUGd/M40JPk48En4XgHcLTUvE7eDtvCMZmGCmvYoDQmjHt7LZ5
	 DzMJedEZrSs40XJ6pK7nZTmOrlr+WexaV21IzkOicLkfAddij1NpcCD2Gq3OWuLW9mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aKXOGIAV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98AD606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 12:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aKXOGIAV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA971F000C1;
	Wed,  4 Nov 2026 12:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793795378;
	bh=qXCTJhJI3/79HSvBTGd8yiSUrhQoGBOGkEtjCUXCtXg=;
	h=From:To:Cc:Subject:Date;
	b=aKXOGIAV4b+iikbbvXDfkKxPfrG4XVw0XYNj2mBxWlkgidDnVnI/hfv0k5TVYlYX1
	 heJX2rV75Qn2w0TGTptrdYEYIZbYZfZhAJu/922fZ4yNbh6tyB7vbs7cu0534LJQrc
	 i7bttbQ5wxWh/vynSAm3MHYb1U4oPJzAwvMRZOSkCdNFzKJv0L47QMv+pZvNTsdVPN
	 z7h1SPkPTe/SlcaoXAc6fQGwby8fu8MGdW/pNfxQwxfrYi1arltzTFJQ3/DXLqoWQc
	 DBZDjZ/FbdtOgxOi989QN3hegpM6lP/ABxeCQuUoL0/5CkyfFSce4qxcX7+nNGjlaZ
	 5VSXdboEiQwnQ==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Phil Sutter <phil@nwl.cc>
Subject: [PATCH v2 net] inet: frags: bound the wmem charge of the socket completing a reassembly
Date: Wed,  4 Nov 2026 13:29:27 +0100
Message-ID: <20261104122927.1033747-1-edumazet@kernel.org>
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
fragments inflated by a refragmentation with a small MTU, and never
above INT_MAX / 2. The cap matters for tun sockets, which use
sk_sndbuf = INT_MAX, and whose skbs are still owned when act_ct or
openvswitch reassemble them at ingress.

Several queues can complete at the same time on different cpus for
the same socket, so the charge is reserved with a cmpxchg() loop in
inet_frag_reasm_prepare(), before it modifies the queue, and settled
in inet_frag_reasm_finish(). Move the size checks of ip_frag_reasm(),
ip6_frag_reasm() and nf_ct_frag6_reasm() before
inet_frag_reasm_prepare(), using the first fragment which becomes the
head, so that a successful inet_frag_reasm_prepare() is always followed
by inet_frag_reasm_finish(). All callers already kill the queue when
inet_frag_reasm_prepare() returns NULL.

Found by code inspection (AI review), not reproduced.

Fixes: 18685451fc4e ("inet: inet_defrag: prevent sk release while still in use")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://lore.kernel.org/netdev/24feda7d-ae49-45af-9596-2cc5f149f28e@redhat.com/
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
Cc: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Phil Sutter <phil@nwl.cc>
---
v2: Reserve the charge with a cmpxchg() loop in inet_frag_reasm_prepare(),
    and settle it in inet_frag_reasm_finish() (Sashiko).
    Move the size checks of ip_frag_reasm(), ip6_frag_reasm() and
    nf_ct_frag6_reasm() before inet_frag_reasm_prepare(), so that the
    reservation can not be leaked.
    Mention tun sockets (sk_sndbuf = INT_MAX) in the changelog.
    Tested with a tun + act_ct reassembly test (IPv4/IPv6), and the
    fragmentation related selftests.
v1: https://lore.kernel.org/netdev/20261103092957.4164530-1-edumazet@kernel.org/

Notes, and planned net-next follow-ups:

- inet_frag_wmem_reserve() open-codes a cmpxchg() loop on
  sk_wmem_alloc.refs, used as a byte counter here. The closest existing
  helper, __refcount_add_not_zero_limited_acquire(), was added for mm
  vm_refcnt: it has acquire and not-zero semantics we do not need, and
  would WARN again if the counter is already saturated. I plan to propose
  a bounded add helper in include/linux/refcount.h for net-next.

- A reassembly refused by this check is reported like an allocation
  failure in inet_frag_reasm_prepare() callers (debug message, REASMFAILS).
  This should be rare, and I prefer to keep this fix small. I plan to add
  a dedicated drop reason in net-next.

LLM was used to review the code, write the fix, and test it.

 net/ipv4/inet_fragment.c                | 61 ++++++++++++++++++++++---
 net/ipv4/ip_fragment.c                  | 13 ++++--
 net/ipv6/netfilter/nf_conntrack_reasm.c | 13 ++++--
 net/ipv6/reassembly.c                   | 13 ++++--
 4 files changed, 78 insertions(+), 22 deletions(-)

diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 0b8d22ffafca69b2bccd98eca3d4bda93ebb816a..f330d0a3982339703e3bedd217fd185cf06857c6 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -17,6 +17,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/slab.h>
 #include <linux/rhashtable.h>
+#include <linux/sizes.h>
 
 #include <net/sock.h>
 #include <net/inet_frag.h>
@@ -519,6 +520,43 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
 }
 EXPORT_SYMBOL(inet_frag_queue_insert);
 
+/* When a socket owned fragment completes a queue, the truesize of all
+ * other fragments is charged to its sk_wmem_alloc, although they were
+ * orphaned when queued and possibly sent by someone else.
+ * Bound this like ip_append_data() bounds the memory a socket can
+ * allocate (2 * sk_sndbuf), plus slack for fragments inflated by a
+ * refragmentation using a small MTU. Otherwise, several reassembled skbs
+ * alive at the same time can saturate sk_wmem_alloc, and leak the socket.
+ *
+ * Several queues can complete at the same time for the same socket,
+ * and some sockets (tun) use sk_sndbuf = INT_MAX. The charge is reserved
+ * with a cmpxchg() loop, a refcount_t has no helper for this.
+ */
+#define INET_FRAG_WMEM_SLACK	SZ_4M
+
+static bool inet_frag_wmem_reserve(struct sock *sk, unsigned int charge)
+{
+	u64 limit = 2ULL * READ_ONCE(sk->sk_sndbuf) + INET_FRAG_WMEM_SLACK;
+	int old = refcount_read(&sk->sk_wmem_alloc);
+
+	limit = min_t(u64, limit, INET_FRAG_MAX_TRUESIZE);
+	do {
+		if (old <= 0 || (u64)old + charge > limit)
+			return false;
+	} while (!atomic_try_cmpxchg(&sk->sk_wmem_alloc.refs, &old,
+				     old + charge));
+
+	return true;
+}
+
+static void inet_frag_wmem_adjust(struct sock *sk, int delta)
+{
+	if (delta >= 0)
+		refcount_add(delta, &sk->sk_wmem_alloc);
+	else
+		WARN_ON_ONCE(refcount_sub_and_test(-delta, &sk->sk_wmem_alloc));
+}
+
 void *inet_frag_reasm_prepare(struct inet_frag_queue *q, struct sk_buff *skb,
 			      struct sk_buff *parent)
 {
@@ -530,6 +568,11 @@ void *inet_frag_reasm_prepare(struct inet_frag_queue *q, struct sk_buff *skb,
 	int delta;
 
 	if (sk && is_skb_wmem(skb)) {
+		/* skb->truesize is already charged to sk, and is part of
+		 * q->truesize. inet_frag_reasm_finish() settles the charge.
+		 */
+		if (!inet_frag_wmem_reserve(sk, q->truesize - skb->truesize))
+			return NULL;
 		/* TX: skb->sk might have been passed as argument to
 		 * dst->output and must remain valid until tx completes.
 		 *
@@ -605,17 +648,18 @@ void *inet_frag_reasm_prepare(struct inet_frag_queue *q, struct sk_buff *skb,
 
 out_restore_sk:
 	if (orig_truesize) {
-		int ts_delta = head->truesize - orig_truesize;
-
 		/* if this reassembled skb is fragmented later,
 		 * fraglist skbs will get skb->sk assigned from head->sk,
 		 * and each frag skb will be released via sock_wfree.
-		 *
-		 * Update sk_wmem_alloc.
 		 */
 		head->sk = sk;
 		head->destructor = destructor;
-		refcount_add(ts_delta, &sk->sk_wmem_alloc);
+		/* On failure, head stays in the queue and will be freed
+		 * with the queue: only charge its truesize.
+		 */
+		if (!nextp)
+			inet_frag_wmem_adjust(sk, (int)head->truesize -
+						  (int)q->truesize);
 	}
 
 	return nextp;
@@ -626,7 +670,6 @@ void inet_frag_reasm_finish(struct inet_frag_queue *q, struct sk_buff *head,
 			    void *reasm_data, bool try_coalesce)
 {
 	struct sock *sk = is_skb_wmem(head) ? head->sk : NULL;
-	const unsigned int head_truesize = head->truesize;
 	struct sk_buff **nextp = reasm_data;
 	struct rb_node *rbn;
 	struct sk_buff *fp;
@@ -691,8 +734,12 @@ void inet_frag_reasm_finish(struct inet_frag_queue *q, struct sk_buff *head,
 	head->tstamp = q->stamp;
 	head->tstamp_type = q->tstamp_type;
 
+	/* After inet_frag_reasm_prepare(), q->truesize is charged to sk.
+	 * sum_truesize also includes what it added (skb_unclone() and
+	 * frag_list clone).
+	 */
 	if (sk)
-		refcount_add(sum_truesize - head_truesize, &sk->sk_wmem_alloc);
+		inet_frag_wmem_adjust(sk, sum_truesize - (int)q->truesize);
 }
 EXPORT_SYMBOL(inet_frag_reasm_finish);
 
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 36105dd192823e745123971412b978f0573d10eb..ef7fd61284a3fa86ba5464abd8c277e3753da6ac 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -413,16 +413,19 @@ static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
 		goto out_fail;
 	}
 
+	/* Check the size on the first fragment, which will become the head:
+	 * inet_frag_reasm_finish() must follow inet_frag_reasm_prepare().
+	 */
+	len = ip_hdrlen(skb_rb_first(&qp->q.rb_fragments)) + qp->q.len;
+	err = -E2BIG;
+	if (len > 65535)
+		goto out_oversize;
+
 	/* Make the one we just received the head. */
 	reasm_data = inet_frag_reasm_prepare(&qp->q, skb, prev_tail);
 	if (!reasm_data)
 		goto out_nomem;
 
-	len = ip_hdrlen(skb) + qp->q.len;
-	err = -E2BIG;
-	if (len > 65535)
-		goto out_oversize;
-
 	inet_frag_reasm_finish(&qp->q, skb, reasm_data,
 			       ip_frag_coalesce_ok(qp));
 
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index be72c4346f8b7196a1f9fa823680200258114233..f25ff2a12a824aaa24e6788e38461a9e22d61fea 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -330,11 +330,10 @@ static int nf_ct_frag6_reasm(struct frag_queue *fq, struct sk_buff *skb,
 	if (unlikely(ecn == 0xff))
 		goto err;
 
-	reasm_data = inet_frag_reasm_prepare(&fq->q, skb, prev_tail);
-	if (!reasm_data)
-		goto err;
-
-	payload_len = -skb_network_offset(skb) -
+	/* Check the size on the first fragment, which will become the head:
+	 * inet_frag_reasm_finish() must follow inet_frag_reasm_prepare().
+	 */
+	payload_len = -skb_network_offset(skb_rb_first(&fq->q.rb_fragments)) -
 		       sizeof(struct ipv6hdr) + fq->q.len -
 		       sizeof(struct frag_hdr);
 	if (payload_len > IPV6_MAXPLEN) {
@@ -343,6 +342,10 @@ static int nf_ct_frag6_reasm(struct frag_queue *fq, struct sk_buff *skb,
 		goto err;
 	}
 
+	reasm_data = inet_frag_reasm_prepare(&fq->q, skb, prev_tail);
+	if (!reasm_data)
+		goto err;
+
 	/* We have to remove fragment header from datagram and to relocate
 	 * header in order to calculate ICV correctly. */
 	skb_network_header(skb)[fq->nhoffset] = skb_transport_header(skb)[0];
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 8418ed9423f4bb923d4d06a07aae704d91f94774..91a65fe6735003aec73f53f66f6fecc8846533c3 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -275,16 +275,19 @@ static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff *skb,
 	if (unlikely(ecn == 0xff))
 		goto out_fail;
 
-	reasm_data = inet_frag_reasm_prepare(&fq->q, skb, prev_tail);
-	if (!reasm_data)
-		goto out_oom;
-
-	payload_len = -skb_network_offset(skb) -
+	/* Check the size on the first fragment, which will become the head:
+	 * inet_frag_reasm_finish() must follow inet_frag_reasm_prepare().
+	 */
+	payload_len = -skb_network_offset(skb_rb_first(&fq->q.rb_fragments)) -
 		       sizeof(struct ipv6hdr) + fq->q.len -
 		       sizeof(struct frag_hdr);
 	if (payload_len > IPV6_MAXPLEN)
 		goto out_oversize;
 
+	reasm_data = inet_frag_reasm_prepare(&fq->q, skb, prev_tail);
+	if (!reasm_data)
+		goto out_oom;
+
 	/* We have to remove fragment header from datagram and to relocate
 	 * header in order to calculate ICV correctly. */
 	nhoff = fq->nhoffset;
-- 
2.53.0

