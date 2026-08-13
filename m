Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B590D36A03F;
	Thu, 13 Aug 2026 22:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786660015; cv=none; b=fExUTGnpwUK3JCv4epDx6o1NEsqR9B+i1ZUik6WvxSTpq2V9Z0xMYKhHab+jKzAJTAapj/MiO2gA/FyRYGP6dbgJ5j+cOpVfYsXtcpsjNEQ7mOj4C/2Y3IlPaaOZgpruKcv6UXEZsaHu0Kbeqh/IAbm5UGGENjl6ompfw2yxwSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786660015; c=relaxed/simple;
	bh=LW0Zxgaa68V9M1e5cGrqOikFIYxTdAKZ5XjigJkx0rM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZK+5e2J2OywFtx09SB/ynxuyhsJXUQc0Tc2SbRIeR6H9NZmJjB3PNaDFO7Y5bDmGbyQiF87sq5e5Pwultm8zUc/6xA72uiMEWzrBHPvxMiXJyG8v6rTL4GPozi0bcEI92agPvUsx3PHIyQ7HuMN6gp6o3ualsowpyuKNMHzKRcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Dj4rQWSQ; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Dj4rQWSQ"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DLbfjD2770044;
	Thu, 13 Aug 2026 15:26:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=aPbtxV9k8
	QHYoG/ws9KqDA3XKxY23j680+kzxXaQSqI=; b=Dj4rQWSQaR6l0LkbizcRgSbBm
	a8ewuxUwoJ1fPLqrqLTHx/Snf2QH3/ebnvl5wRCLsSPI38XTN3RYEEODPxtXkaZI
	1KDq7gS7my+/0lpgNlM03jYW+pk7rOn8cIQVxplahgZsUFNOKsxLX2PDB+t1Rfqm
	BFc9Ah0AxH1PeYidH18LbqqOPeK4FfFoE2/PHWCiik5GLwjiu60YIAXTj/lREqo5
	Z0rcvTO3wUtuWMLfp76UZK2b12i3FnW9+zEfY6RD4uf2o01vfLafAmThIR2X9DP2
	Y+QrzzyOlOCflymavpiXxI0xqCclqk1NFHVqic809u/ODIkykW1NOOss2QMkA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4g0a1nrmcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 13 Aug 2026 15:26:39 -0700 (PDT)
Received: from localhost (2620:10d:c085:208::f) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.45; Thu, 13 Aug
 2026 22:26:38 +0000
From: Glenn Judd <gmj@meta.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>,
        Richard Gobert
	<richardbgobert@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        Kuniyuki
 Iwashima <kuniyu@google.com>, Kees Cook <kees@kernel.org>,
        Jiayuan Chen
	<jiayuan.chen@linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick
 Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, <llvm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH net-next v2] net: gro: coalesce short IPv4 packets padded to the minimum frame size
Date: Thu, 13 Aug 2026 15:26:29 -0700
Message-ID: <20260813222629.492738-1-gmj@meta.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDE2NCBTYWx0ZWRfX/cmQNNY38i99
 l8IXTheUfGDjOPcQnqnUFFb0Hy+QsdB4OAo5p89tsUhNxFBJnQhzZe3v7YQwQsyCF/RGQr2+z8U
 bcCsSO01DXkOvxHiAKXBAs8aepD2/uI=
X-Proofpoint-ORIG-GUID: 9L9SdPmHkrf-_a9YJ968RCbqhS6N_xJX
X-Proofpoint-GUID: 9L9SdPmHkrf-_a9YJ968RCbqhS6N_xJX
X-Authority-Analysis: v=2.4 cv=aqiCzyZV c=1 sm=1 tr=0 ts=6a7e449f cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=crHB47gyY4rKiduisYu9:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=8wkc0TWQQCn0lXJpwycA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDE2NCBTYWx0ZWRfX4x1giF6V8bdM
 WwYyjtCsoPlP970JlSz9enpe7otnwG8lBlgDjW23tHXWd9Kg7+tjZed5o/I/r7TRFuZ+4Y1jR+T
 Pq+bCuoQ0S6U/AEhGN9f2wKwxTfgGIcMsB8I4zZ0I0Gi9w7PHDubSUO1ivAuv+ggKzli+FrPnGW
 sr5dB2Mb0h67ITk0u3fGlehs34LOIxBHxNpB34Fq8YZZmvTgri7kImyBVZuRKMCj2Jzar+mOjtb
 DsIQ3g2WTHlDgO44BelJhFQWv60M0dmEB/8hwaEUHaH/v+vdz16VJqwQOCzB+1zt4yVFDNcpAhW
 IDioAGf3wN0NTzfiaAomoGRcmILsvgYUOeSkaa3WgY40CyzzUoUsq3tJ0B53uuptmw7oBDzb92K
 xJwCgxZV6ZqU4Jg4+GjpmPt4o02BfsmatIl/5lOrVX5KICXuL9r9r54BzKKAdo8WLpemwdGxvXI
 XPUi1DSrQwQA+D4IQtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_07,2026-08-12_01,2025-10-01_01

Software GRO fails to coalesce a small IPv4 segment that was
padded up to the 60-byte minimum Ethernet frame.

The selftest tools/testing/selftests/drivers/net/gro.py subtest
sw_ipv4_data_lrg_1byte sends {100, 1} expecting to receive {101}.
In current code, it receives {100, 1} (no coalescing) instead.

Cause: inet_gro_receive() computes its flush term from
tot_len ^ skb_gro_len() before skb_gro_pull(), while skb_gro_len()
still includes trailing Ethernet padding. A small IPv4 segment
padded up to the 60-byte minimum frame has tot_len != skb_gro_len(),
so flush is set and the runt never coalesces.

v1 detected the padding with an added iph->tot_len read and
skb_gro_len() comparison on every IPv4 GRO packet. Instead, split
inet_gro_receive() so that everything after the header validation
takes the flush term as a parameter, and pass a literal 0 on the
common path. That folds away both flush updates and lets the
transport dispatch become a tail call, leaving the common path
shorter than before this patch rather than merely unchanged.

Assisted-by: Claude:claude-opus-5
Assisted-by: Codex:gpt-5.6
Assisted-by: Meta:internal-AI-tooling
Signed-off-by: Glenn Judd <gmj@meta.com>
---

v1: https://lore.kernel.org/netdev/20260731185431.2777685-1-gmj@meta.com/

v2:
 - reworked so the fix costs nothing on the common path: the
   flush term is computed before the branch and passed to a split-out
   inet_gro_receive_finish() as a literal 0, rather than adding an
   iph->tot_len read and an skb_gro_len() comparison to every packet
 - the common path is now shorter than before the patch
 - retitled: the change is not TCP specific, it covers all IPv4 GRO
 - do not trim inner encapsulated headers, or under NETIF_F_RXFCS
 - spell the padding bound ETH_ZLEN - ETH_HLEN + ETH_FCS_LEN (unchanged
   at 50); tag depth cancels, the ETH_FCS_LEN is deliberate slack
 - use mem_is_zero() to verify the pad rather than an open-coded scan

Overview

After a bit more work, I think that it's also worth considering another
approach. By decomposing the logic in inet_gro_receive() into helpers, we
can allow the compiler to remove code -- making the common path
shorter/faster than the current code. The key motivation for this
improvement is that coalescing padded runts can then be handled "for free"
(no overhead on the common path).

(As with the original RFC, the behavior that this addresses occurs under
software gro for IPv4 with no timestamps.)

The table below shows the non-blank, non-comment code, instruction count,
and memory access differences relative to base unmodified code.
(a is the original RFC. b is the new approach.)

Instruction and memory access counts are for the common path only (function
entry to the transport dispatch), measured with clang 22.1.3 x86_64.

+--------+----------+----------+----------+
|        | LoC      | insns    | mem      |
+--------+----------+----------+----------+
| base   |        - |        - |        - |
| a      |      +17 |      +14 |       +3 |
| b      |      +33 |       -9 |       -2 |
+--------+----------+----------+----------+

Note that the majority of the code change in b is decomposition of existing
code. The new logic comprises 10 lines.

Where the padding cannot be safely stripped (a tunnel, a retained FCS, a
nonlinear skb, or a pad that is not zero), b does not trim, and the
segment is simply not coalesced, exactly as base behaves today.


Testing

I have run a number of performance tests to analyze the bulk throughput
performance of each approach, as well as the performance impact of
coalescing the runt packet vs. not coalescing.

In all cases I pinned both irq handling and the test application to 1 CPU.
I turned off frequency scaling and restricted power states.
Throughput below is CPU-bound rather than link-bound.


Bulk Throughput

I first measured bulk throughput for 8 independent TCP flows between a
single sender and receiver. As shown below, the performance in this test
matches the code analysis above. b's reduced common path results in better
throughput.

+---------+-----------+-----------+-----------+
|         |      Gbps |   delta % |    95% CI |
+---------+-----------+-----------+-----------+
| base    |    12.222 |         - |         - |
| a       |    12.173 |    -0.404 |   +-0.162 |
| b       |    12.289 |    +0.543 |   +-0.147 |
+---------+-----------+-----------+-----------+


Padding Fix Performance Impact

I then measured the performance impact of coalescing runts vs. not
coalescing. I did this by sending 8 concurrent flows where each flow sent
a pair of packets sized [1460], [l (length)]. The second packet shows up
as a "runt", and triggers the packet coalescing behavior for lengths >= 6
for all cases, and triggers the padding removal/coalescing for lengths
< 6 for approaches a and b.

The results below show the average time to process a single packet pair
for the given scenarios. As stated above, packets with l=6 coalesce for
all implementations (no padding is present). l=5 requires new logic to
coalesce the padded runt. The last two columns show the average number
of packets coalesced for each test (a sanity check to indicate when
coalescing is happening [~2] vs. not happening [~1]).

Computing l5-l6, we can measure the penalty (if any) of not coalescing
packets for the base case, or the cost of handling the padded packet for
cases a and b.

This test shows a ~0.76 us penalty per failed coalesce for the base case,
and ~0 us cost for coalescing with approach b.

+-------+----------+----------+----------+-----------+---------+---------+
|       |   l=5 us |   l=6 us | l5-l6 us |    95% CI |  gro l5 |  gro l6 |
+-------+----------+----------+----------+-----------+---------+---------+
| base  |   14.311 |   13.547 |   +0.764 |   +-0.130 |   0.993 |   1.974 |
| a     |   13.470 |   13.359 |   +0.111 |   +-0.056 |   1.965 |   1.974 |
| b     |   13.361 |   13.351 |   +0.010 |   +-0.040 |   1.964 |   1.974 |
+-------+----------+----------+----------+-----------+---------+---------+


Summary

In short, improving the sw gro common path (9 fewer instructions, 0.54%
more throughput) allows us to fix the failure to coalesce padded runts
with zero additional overhead. The penalty for not coalescing a padded
runt is ~0.76 us. Approach b recovers all of that.

 net/ipv4/af_inet.c | 136 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 103 insertions(+), 33 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 32d006c1a8ee..6ac2089385dc 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1465,40 +1465,26 @@ static struct sk_buff *ipip_gso_segment(struct sk_buff *skb,
 	return inet_gso_segment(skb, features);
 }
 
-struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
+/* Non-zero means tot_len != gro_len OR IP_CE is set: ip_is_fragment() tests
+ * only IP_MF and IP_OFFSET, and IP_DF is masked here, but IP_CE is not.
+ * Recompute after trimming; never assume a trimmed packet has a zero term.
+ */
+static int inet_gro_flush_term(const struct iphdr *iph,
+			       unsigned int gro_len)
 {
-	const struct net_offload *ops;
-	struct sk_buff *pp = NULL;
-	const struct iphdr *iph;
-	struct sk_buff *p;
-	unsigned int hlen;
-	unsigned int off;
-	int flush = 1;
-	int proto;
-
-	off = skb_gro_offset(skb);
-	hlen = off + sizeof(*iph);
-	iph = skb_gro_header(skb, hlen, off);
-	if (unlikely(!iph))
-		goto out;
-
-	proto = iph->protocol;
-
-	ops = rcu_dereference(inet_offloads[proto]);
-	if (!ops || !ops->callbacks.gro_receive)
-		goto out;
-
-	if (*(u8 *)iph != 0x45)
-		goto out;
-
-	if (ip_is_fragment(iph))
-		goto out;
-
-	if (unlikely(ip_fast_csum((u8 *)iph, 5)))
-		goto out;
+	return (u16)((ntohl(*(__be32 *)iph) ^ gro_len) |
+		     (ntohl(*(__be32 *)&iph->id) & ~IP_DF));
+}
 
-	NAPI_GRO_CB(skb)->proto = proto;
-	flush = (u16)((ntohl(*(__be32 *)iph) ^ skb_gro_len(skb)) | (ntohl(*(__be32 *)&iph->id) & ~IP_DF));
+/* The common caller passes a literal 0 for flush, which (with
+ * __always_inline) folds away both updates where it is used below.
+ */
+static __always_inline struct sk_buff *
+inet_gro_receive_finish(struct list_head *head, struct sk_buff *skb,
+			const struct net_offload *ops, const struct iphdr *iph,
+			unsigned int off, int flush)
+{
+	struct sk_buff *pp, *p;
 
 	list_for_each_entry(p, head, list) {
 		struct iphdr *iph2;
@@ -1532,11 +1518,95 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 	pp = indirect_call_gro_receive(tcp4_gro_receive, udp4_gro_receive,
 				       ops->callbacks.gro_receive, head, skb);
 
-out:
 	skb_gro_flush_final(skb, pp, flush);
 
 	return pp;
 }
+
+/* Superset gate: a VLAN tag lengthens both the padded frame and the L2 header
+ * so tag depth cancels; gro_len > tot_len and the all-zero scan decide.
+ */
+static noinline struct sk_buff *
+inet_gro_receive_slow(struct list_head *head, struct sk_buff *skb,
+		      const struct net_offload *ops, const struct iphdr *iph,
+		      unsigned int off)
+{
+	unsigned int tot_len = ntohs(iph->tot_len);
+	unsigned int gro_len = skb->len - off;
+
+	if (NAPI_GRO_CB(skb)->encap_mark ||
+	    (skb->dev->features & NETIF_F_RXFCS) ||
+	    gro_len > ETH_ZLEN - ETH_HLEN + ETH_FCS_LEN || gro_len <= tot_len ||
+	    tot_len < sizeof(*iph))
+		goto no_trim;
+
+	/* A linear skb is contiguous through skb->len, so the scan below ends
+	 * at skb->data + skb->len. Keep this test ahead of it.
+	 */
+	if (skb_is_nonlinear(skb))
+		goto no_trim;
+
+	if (!mem_is_zero(skb->data + off + tot_len, gro_len - tot_len))
+		goto no_trim;
+
+	/* Trailing zeros leave a one's-complement sum unchanged, so the
+	 * NAPI_GRO_CB(skb)->csum cached before this call stays valid;
+	 * __skb_trim() cannot reallocate, so iph stays valid.
+	 */
+	__skb_trim(skb, off + tot_len);
+	NAPI_GRO_CB(skb)->frag0_len = skb->len;
+	gro_len = tot_len;
+
+no_trim:
+	return inet_gro_receive_finish(head, skb, ops, iph, off,
+				       inet_gro_flush_term(iph, gro_len));
+}
+
+struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
+{
+	const struct net_offload *ops;
+	const struct iphdr *iph;
+	unsigned int gro_len;
+	unsigned int off;
+	int proto;
+
+	off = skb_gro_offset(skb);
+	iph = skb_gro_header(skb, off + sizeof(*iph), off);
+	if (unlikely(!iph))
+		goto out;
+
+	proto = iph->protocol;
+
+	ops = rcu_dereference(inet_offloads[proto]);
+	if (!ops || !ops->callbacks.gro_receive)
+		goto out;
+
+	if (*(u8 *)iph != 0x45)
+		goto out;
+
+	if (ip_is_fragment(iph))
+		goto out;
+
+	if (unlikely(ip_fast_csum((u8 *)iph, 5)))
+		goto out;
+
+	NAPI_GRO_CB(skb)->proto = proto;
+
+	/* skb_gro_len(skb) without re-reading data_offset; the skb_gro_pull()
+	 * in finish() must stay below this.
+	 */
+	gro_len = skb->len - off;
+
+	if (unlikely(inet_gro_flush_term(iph, gro_len)))
+		return inet_gro_receive_slow(head, skb, ops, iph, off);
+
+	return inet_gro_receive_finish(head, skb, ops, iph, off, 0);
+
+out:
+	skb_gro_flush_final(skb, NULL, 1);
+
+	return NULL;
+}
 EXPORT_INDIRECT_CALLABLE(inet_gro_receive);
 
 static struct sk_buff *ipip_gro_receive(struct list_head *head,
base-commit: 2fbade66245059c78daeaccfce13ecf499fffb51

-- 
2.53.0-Meta

