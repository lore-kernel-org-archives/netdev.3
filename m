Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2793E411C
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791445395; cv=none; b=iKYakdECtMIcNPvgFP3eNAOnfV0LH4jbPpbAWW5uhixxVBVPeVtivy+aJrgEx2Pad7afuQchnEDTrkIdKzLMl8+6MINjIeKzVOJ2paACbTqp1vNa1/x4xNDC2Bq3c2EQDtwTVQ8Z4Uy+cTjZScCAW/Zx0FRYyi6MOMx8K/Vhf1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791445395; c=relaxed/simple;
	bh=IpgkZARQjc+zREphOgy2dgK4OVeN7RCgXEh4Q2RTg0I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nD3AdUQ3kro3Z/NIbfejPAWMXSRSVKDDInaRf9R+zMf4Lw7+osH1trb7wQU0UPz/V9VEteRh86MIIEgWiDmbhxghOmB+J0H3CTKpu9O5PMsiYsHRhja+rBWLm6Y0d+H9jeGGKtv9fNrJxxED5ssWLRwQUd4WpG5ZHcOFbw5BM5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=KuF1rXWR; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="KuF1rXWR"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-917a97b39e8so37785536d6.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 00:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791445390; x=1792050190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tC2oYR+jas9z9IN4cDGhisWld2oMkckUvsoycIlRals=;
        b=KuF1rXWRoldPglOmdGwaBBtviikSWSV2F8coajlyN8kmLoZGB+fD0iRR+PYRdz7uTv
         Vh3enulXSVX4aRPbYTFRIjntl/cUnVyr7i72zD28P9eYtl9GthcYw7pkoH0yrJbqiknS
         pmGsTnRlJb6/hITUo3pcODK2N841AkRxrNtNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791445390; x=1792050190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tC2oYR+jas9z9IN4cDGhisWld2oMkckUvsoycIlRals=;
        b=p+Dj/AZQxcsAVlLTJVHUHSKFXsQ32Agwf38hbHW+dw3JrUvCak6CXfqJ+7GSzHcvOe
         RBNkPqKXPYSga1sXGTYilimA7yYvjb4/YgtLWFvkl+5jeqI9VUJvpAoBhHQIyVw2F8Wl
         Cokc2txiZElLUMaTUtCz5scrTMjFdrj3o8JksMM2jLjzJ8Z0AUfQnWXO4bfBs79lEObT
         3yRzKu16eI3zY9n9NdjefJ3IkKmMJMUOr0dXEY0CxdBj+iGRVD8sdiHE2RGva1tQLiMm
         kZypyRAJ0fGOjxPYyrDVBKb3YUx83UpC0Y/SIXTISmKGGNLJ4w7ga3bzO9uPTIvp0mCw
         xGXQ==
X-Gm-Message-State: AFq9FYJJVgyrr/LDa/9kEzdn7VKiUjEbE1r11FBEukrdqXVdK3DNnTs1
	5HZrd8fmUCjBSXZ9f15h2FhY9aqgTg4NJas2H+LlZoCR2DTQv7qNj0C76LiHrLqfPNXyB/FkCDs
	BsgnREQ==
X-Gm-Gg: AYBFou2LdyRpexqT7mGnxfOl4I6WSPWB8jHGDDzGh04JExkzKa/bDnV0NCxh4Qk96PU
	dT5yQIf59jTeLo9SuXZmfVKoscPrDQp4bH+a6KPRfeJVWkQT2jWAxG8Saeb1FFsOR42dbx8g+gR
	PtzlZflmOlYywQmKZepxspekacTVonaNiiuWfY91TN7xwOa1VasYEfaxMqK4PLPAukWWANBcuQK
	75avPY/ihS8RuZrAna2WT8xgznqtP/xXGDTPAZM6B/O7Epye65I+m61nK3wxQvgOf6hwucON5xJ
	9Ywc5YtHHF/H10SaYiNzkzKIZ2s0TeCG8SGz1UrkhoTxBW5g85FtJPk9ZB00jRrs/0EIX27aORC
	OOPUCqX9F04BBo35I33HVpm9bdTWKa/zltMWtF2H8UvIxr1CXzH1vQqDBhSqrvmAp8KcoLeDPUs
	YfyN2UhDqbfX5asj7wh21QugDIeJJNhRPpfJDqLiVPuoPL6tSl/fgOxSLmE3RaTvoOoohZcjjsi
	SvgdHV9OvkZVqYxpFNfAd73Ybr3vRJWrnGZKatxOzx495sNSQ==
X-Received: by 2002:ad4:5dcd:0:b0:915:e9af:3144 with SMTP id 6a1803df08f44-91997831dbamr84841536d6.26.1791445389841;
        Thu, 08 Oct 2026 00:43:09 -0700 (PDT)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91997d66da0sm37823986d6.39.2026.10.08.00.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 00:43:09 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	moeller0@gmx.de,
	cake@lists.bufferbloat.net,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net-next v5] net/sched: cap the accounted backlog before it can wrap
Date: Thu,  8 Oct 2026 03:42:55 -0400
Message-Id: <QDISC-BA27.v5.20261007171509@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a follow-up to an issue found by Sashiko (nipa) during review of
commit d9ebd8f9aa8b ("net/sched: fq_codel: clamp default quantum and
mtu"), part of the quantum/mtu overflow series merged as a687f2ae995f.
Clamping the per-flow quantum and the CoDel mtu does not bound the
accounted backlog, so the per-flow backlog wrap the review flagged
remained.

fq_codel, cake, codel, pie, fq_pie and dualpi2 account every enqueued
packet's stab-adjusted length into a 32-bit sch->qstats.backlog.
fq_codel/codel use it to decide if they should drop a packet at dequeue;
cake uses it to prune the longest-flow heap from per-flow backlogs; pie
and fq_pie use it to make early drop decisions and dualpi2 decides
must_drop() on it. RED can decide on a child's backlog based on it.
A crafted tc size table (TC_STAB) inflates qdisc_pkt_len() up to
QDISC_PKT_LEN_MAX (1 MiB), so a few thousand packets wrap the counter
mod 2^32. The AQM then reads a small backlog and makes the wrong drop
decision, and the dequeue-side subtractions keep the counter corrupt.

In fq_codel the wrapped value is worse than a wrong drop: a wrapped
q->backlogs[idx] can leave fq_codel_drop()'s strict '>' scan selecting
idx 0 while flow 0 is empty, so dequeue_head() dereferences a NULL
flow->head. The wrap is what the reproducer below observes; the NULL
dereference is derived from code inspection (it needs flows >= 2, flow 0
empty, and another flow's counter back at exactly 0 mod 2^32 with the
qdisc at its drop trigger).

Fix:
Drop at enqueue once the stored backlog is within QDISC_MAX_BACKLOG
(U32_MAX - QDISC_PKT_LEN_MAX) of the wrap point, the largest backlog one
more stab-clamped packet cannot wrap. Test the stored backlog itself via
qdisc_backlog_at_max() rather than adding the incoming packet's length,
so there is no per-enqueue 64-bit add and the 1 MiB headroom already
reserved by QDISC_MAX_BACKLOG is not counted twice. The bound is exact for
every producer: a stab-clamped length is capped by QDISC_PKT_LEN_MAX, and
the stabless GSO producer is capped by qdisc_pkt_len_segs_init() (the
SPLIT_GSO path additionally re-checks its segment sum). This follows the
existing bfifo approach, which bounds bytes against the accounted
length; gred is a precedent only in WRED mode, where it bounds the
aggregate, while non-WRED gred bounds each virtual queue. The fixed
qdiscs' limits are packet counts or otherwise do not bound the aggregate
bytes. pfifo, reachable standalone or grafted as RED's or SFB's child,
is fixed too because RED reads a child's backlog into red_calc_qavg().
RED's guard bounds only the primary enqueue: a child that segments a GSO
skb (tbf, netem) still grows the parent aggregate through
qdisc_tree_reduce_backlog()'s unclamped byte delta, left to a separate
change.

fq_codel and cake both expose an optional external classifier whose
terminal TC actions (STOLEN/QUEUED/TRAP/SHOT) consume the packet without
enqueuing it. The ceiling check runs after that classifier and its
terminal result, but before flow-hash/shaper state, so a redirect, trap
or police action keeps working while the backlog sits at the ceiling,
and a packet about to be dropped still does not disturb the flow hash.
Only a packet admitted past the check mutates a flow: for fq_codel the
guard precedes fq_codel_hash(); for cake the guard precedes both the key
extraction and the split-GSO segmentation, so the flow/host keys
are taken from the packet as received rather than from a segment whose
encapsulated headers skb_gso_segment() may have rewritten. CAKE's
set-associative resolution, which writes q->tags[], the flow host
indices, the way counters and the host bulk-flow counts, runs only once
the packet is admitted. fq_codel's external filter selects a flow only
when the result's minor is nonzero and no larger than flows_cnt; a
matched filter that supplied no class ID (classid 0) is the no-flow
result and the packet is dropped, as before.

CAKE's SPLIT_GSO path accounts the sum of the segment lengths, which a
stab recomputes from skb->len and can exceed the pre-split
qdisc_pkt_len(). The list is summed before any segment is linked and
rejected as a whole before any flow state is resolved: the flow/host keys
are computed from the unsegmented packet, but the set-associative
resolution that commits q->tags[], the flow host indices, the way
counters and the host bulk-flow counts runs only after the whole
segment-sum admission test passes. A packet rejected by that test
therefore leaves no persistent state behind. The whole list is dropped
via to_free so the tail segment's sock_wfree() never runs under the qdisc
lock. A fraglist GSO is the exception: skb_segment_list() returns the
original skb as the list head carrying an extra reference, so segs ==
skb; dropping the caller's reference and queueing the list once avoids
self-linking *to_free, which would otherwise free the same skb repeatedly
in the deferred teardown.

Conditions to recreate the bug: CAP_NET_ADMIN in a user namespace;
CONFIG_NET_SCH_FQ_CODEL=y.

  ip tuntap add tun0 mode tun
  ip link set tun0 txqueuelen 32 up
  ip addr add 10.99.0.1/24 dev tun0
  tc qdisc add dev tun0 root handle 1: stab overhead 2000000000 \
      fq_codel flows 1 limit 20000 ecn
  # hold the tun fd open without reading (IFF_BACKPRESSURE) so the qdisc
  # backlog persists, then send 6000 packets. At 4096 resident 1 MiB
  # packets the counter wraps; the unfixed kernel then reports a wrapped
  # backlog for 5969 resident packets, the fixed one drops at the ceiling.

  # RED with a grafted packet-limited child reads the child's backlog the
  # same way; the default bfifo child is byte-limited and safe, pfifo is
  # packet-limited:
  tc qdisc add dev tun0 root handle 1: stab overhead 2000000000 \
      red limit 1000000000 min 5000 max 10000 avpkt 1000 burst 32 ecn
  tc qdisc add dev tun0 parent 1:1 handle 30: pfifo limit 100000

  # a terminal action at the ceiling: fill the queue as above, then
  #   tc filter add dev tun0 parent 1: protocol ip prio 1 matchall \
  #       action trap
  # and send more packets; the trap action's stats must advance.

Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/netdev/20260818101130.16203-1-jhs@mojatatu.com/
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101130.16203-1-jhs@mojatatu.com
Link: https://lore.kernel.org/netdev/CANn89iLfMJV7ancKH1Gjzzm7ZUG-gKcrczkJjJEWN5sCuWd-ug@mail.gmail.com/
Link: https://lore.kernel.org/netdev/CANn89i+GOFH_8g+vSV0jUj0aBqLYVWuFOrHuDggZu9kPC_m6tQ@mail.gmail.com/
Link: https://lore.kernel.org/netdev/CANn89i+99jPh7JjZf=G3Ouaom2tuOtAEiHUf2MEsRdVPd=nz4w@mail.gmail.com/
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-BA27.v3.20260929142417%40mojatatu.com
Link: https://lore.kernel.org/netdev/20261006153043.GM83879@horms.kernel.org/
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v5 Considered Comments from Simon (and nipa on v3):
  - cake: the cake_tcf_classify() block comment had an embedded "/*"
    ("else *flow/*host"), which trips a -Wcomment / W=1 build warning.
    Simon Horman reported it on v4 and noted it likely suppressed the
    Sashiko nipa review; reworded to drop the nested comment.
  - cake: reword the same comment so it no longer says the function
    returns true for "a matched no usable flow" result (Sashiko nipa v3
    Low): cake_tcf_classify() returns true only for a terminal TC action;
    a matched-but-unusable classid leaves the overrides at 0 and the
    packet is hashed as before (fq_codel_classify() differs).
  - commit log: soften the claim that the 1 MiB headroom always bounds a
    single packet (Sashiko nipa v3 High).

v4  fold the Sashiko nipa v3 review:
  - cake: compute the flow/host hash keys from the packet as received
    (before skb_gso_segment(), which can rewrite an encapsulated GSO
    packet's headers to the inner ones), but defer the set-associative
    resolution that writes q->tags[], the flow host indices, the way
    counters and the host bulk-flow counts until after the split-GSO
    segment-sum admission check, so a packet rejected by that check
    commits no flow state.
  - cake: in the split-GSO rejection, handle a fraglist GSO (whose
    skb_segment_list() returns the original skb as the list head with an
    extra reference, segs == skb) by dropping the caller's reference and
    queueing the list once, instead of calling __qdisc_drop_all() and
    qdisc_drop_reason() on the same skb, which self-linked *to_free.

v3  fold the v2 review (Eric Dumazet) and Sashiko gemini v2:
  - Test the stored backlog via qdisc_backlog_at_max() instead of
    (u64)backlog + qdisc_pkt_len() > QDISC_MAX_BACKLOG: no double-count
    of the reserved 1 MiB headroom, no per-enqueue 64-bit add.
  - cake: run the external classifier first, honor its terminal TC
    actions, then the ceiling check, then the hash and the shaper state;
    the SPLIT_GSO segment sum is checked before any flow/host state is
    committed and the list is deferred to to_free rather than freed
    under the qdisc lock.
  - fq_codel: run the external classifier (terminal actions honored)
    first, then the ceiling check before fq_codel_hash(); document the
    fq_codel_drop() NULL flow->head consequence.
  - pfifo: same ceiling guard, since RED reads a (graftable) child's
    backlog and SFB's default child is pfifo.

v2 approach rewrite per list discussion of v1:
  v1 approached the wrap by widening the per-flow backlog counters to
  u64. Eric Dumazet rejected the framing ("Storing 4GB in a qdisc is
  absolutely insane") and asked for a drop at enqueue once the backlog
  approaches the wrap point. Sebastian Moeller noted tc-stab is the
  generic overhead-accounting mechanism, so the fix must not penalize
  normal stab use.
  v2 replaces the u64 widening with an enqueue-side pre-check against
  QDISC_MAX_BACKLOG and drops with QDISC_DROP_OVERLIMIT. No counter is
  widened, so the 32-bit sch->qstats.backlog the AQM reads can no longer
  wrap. Same-pattern siblings fixed in one patch: fq_codel, cake, codel,
  pie, fq_pie, dualpi2, RED.
 include/net/pkt_sched.h   |   1 -
 include/net/sch_generic.h |  15 +++
 net/core/dev.c            |   8 ++
 net/sched/sch_cake.c      | 198 ++++++++++++++++++++++++++++----------
 net/sched/sch_codel.c     |  16 +--
 net/sched/sch_dualpi2.c   |   1 +
 net/sched/sch_fifo.c      |   6 ++
 net/sched/sch_fq_codel.c  |  57 ++++++++---
 net/sched/sch_fq_pie.c    |   3 +-
 net/sched/sch_pie.c       |   3 +-
 net/sched/sch_red.c       |   6 ++
 11 files changed, 241 insertions(+), 73 deletions(-)

diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 90d3e7943b19..18a419cd9d94 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -12,7 +12,6 @@
 
 #define DEFAULT_TX_QUEUE_LEN	1000
 #define STAB_SIZE_LOG_MAX	30
-#define QDISC_PKT_LEN_MAX	(1 << 20)	/* 1 MiB */
 
 struct qdisc_walker {
 	int	stop;
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 1acaadb3e2cf..43a3e1e9ee89 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -915,6 +915,21 @@ static inline unsigned int qdisc_pkt_len(const struct sk_buff *skb)
 	return qdisc_skb_cb(skb)->pkt_len;
 }
 
+#define QDISC_PKT_LEN_MAX	(1 << 20)	/* 1 MiB */
+
+/* Largest accounted backlog one more maximum-size packet cannot wrap
+ * the 32-bit sch->qstats.backlog past.
+ */
+#define QDISC_MAX_BACKLOG	(U32_MAX - QDISC_PKT_LEN_MAX)
+
+/* Backlog close enough to U32_MAX that one more packet could wrap it.
+ * A packet-limited qdisc must drop at enqueue when this holds.
+ */
+static inline bool qdisc_backlog_at_max(const struct Qdisc *sch)
+{
+	return READ_ONCE(sch->qstats.backlog) > QDISC_MAX_BACKLOG;
+}
+
 static inline unsigned int qdisc_pkt_segs(const struct sk_buff *skb)
 {
 	u32 pkt_segs = qdisc_skb_cb(skb)->pkt_segs;
diff --git a/net/core/dev.c b/net/core/dev.c
index f587645e930a..e6ac94c61ea0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4268,6 +4268,14 @@ static enum skb_drop_reason qdisc_pkt_len_segs_init(struct sk_buff *skb)
 		qdisc_skb_cb(skb)->pkt_segs = gso_segs;
 	}
 	qdisc_skb_cb(skb)->pkt_len += (gso_segs - 1) * hdr_len;
+	/* (gso_segs - 1) * hdr_len can exceed QDISC_PKT_LEN_MAX for a dodgy
+	 * GSO skb, so clamp the producer the same way a size table is
+	 * clamped (__qdisc_calculate_pkt_len()). The accounted backlog stays
+	 * within one stab-clamped packet of U32_MAX and cannot wrap.
+	 */
+	qdisc_skb_cb(skb)->pkt_len = min_t(unsigned int,
+					   qdisc_skb_cb(skb)->pkt_len,
+					   QDISC_PKT_LEN_MAX);
 	return SKB_NOT_DROPPED_YET;
 }
 
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index dc93267029e7..6484c4fa0ccc 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -706,19 +706,33 @@ static u16 cake_get_flow_quantum(struct cake_tin_data *q,
 		get_random_u16()) >> 16;
 }
 
-static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
-		     int flow_mode, u16 flow_override, u16 host_override)
+struct cake_hash_keys {
+	u32 srchost_hash;
+	u32 dsthost_hash;
+	u32 flow_hash;
+};
+
+/* Compute the flow/host hash keys from the packet as received. Must run
+ * before skb_gso_segment(), which rewrites an encapsulated GSO packet's
+ * headers to the inner ones and would change the keys. Reads only the skb
+ * and commits no qdisc state, so it may run before admission is known.
+ */
+static void cake_hash_keys(const struct sk_buff *skb, int flow_mode,
+			   u16 flow_override, u16 host_override,
+			   struct cake_hash_keys *out)
 {
 	bool hash_flows = (!flow_override && !!(flow_mode & CAKE_FLOW_FLOWS));
 	bool hash_hosts = (!host_override && !!(flow_mode & CAKE_FLOW_HOSTS));
 	bool nat_enabled = !!(flow_mode & CAKE_FLOW_NAT_FLAG);
-	u32 flow_hash = 0, srchost_hash = 0, dsthost_hash = 0;
-	u16 reduced_hash, srchost_idx, dsthost_idx;
 	struct flow_keys keys, host_keys;
 	bool use_skbhash = skb->l4_hash;
 
+	out->flow_hash = 0;
+	out->srchost_hash = 0;
+	out->dsthost_hash = 0;
+
 	if (unlikely(flow_mode == CAKE_FLOW_NONE))
-		return 0;
+		return;
 
 	/* If both overrides are set, or we can use the SKB hash and nat mode is
 	 * disabled, we can skip packet dissection entirely. If nat mode is
@@ -753,50 +767,70 @@ static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
 	switch (host_keys.control.addr_type) {
 	case FLOW_DISSECTOR_KEY_IPV4_ADDRS:
 		host_keys.addrs.v4addrs.src = 0;
-		dsthost_hash = flow_hash_from_keys(&host_keys);
+		out->dsthost_hash = flow_hash_from_keys(&host_keys);
 		host_keys.addrs.v4addrs.src = keys.addrs.v4addrs.src;
 		host_keys.addrs.v4addrs.dst = 0;
-		srchost_hash = flow_hash_from_keys(&host_keys);
+		out->srchost_hash = flow_hash_from_keys(&host_keys);
 		break;
 
 	case FLOW_DISSECTOR_KEY_IPV6_ADDRS:
 		memset(&host_keys.addrs.v6addrs.src, 0,
 		       sizeof(host_keys.addrs.v6addrs.src));
-		dsthost_hash = flow_hash_from_keys(&host_keys);
+		out->dsthost_hash = flow_hash_from_keys(&host_keys);
 		host_keys.addrs.v6addrs.src = keys.addrs.v6addrs.src;
 		memset(&host_keys.addrs.v6addrs.dst, 0,
 		       sizeof(host_keys.addrs.v6addrs.dst));
-		srchost_hash = flow_hash_from_keys(&host_keys);
+		out->srchost_hash = flow_hash_from_keys(&host_keys);
 		break;
 
 	default:
-		dsthost_hash = 0;
-		srchost_hash = 0;
+		out->dsthost_hash = 0;
+		out->srchost_hash = 0;
 	}
 
 	/* This *must* be after the above switch, since as a
 	 * side-effect it sorts the src and dst addresses.
 	 */
 	if (hash_flows && !use_skbhash)
-		flow_hash = flow_hash_from_keys(&keys);
+		out->flow_hash = flow_hash_from_keys(&keys);
 
 skip_hash:
 	if (flow_override)
-		flow_hash = flow_override - 1;
+		out->flow_hash = flow_override - 1;
 	else if (use_skbhash && (flow_mode & CAKE_FLOW_FLOWS))
-		flow_hash = skb->hash;
+		out->flow_hash = skb->hash;
 	if (host_override) {
-		dsthost_hash = host_override - 1;
-		srchost_hash = host_override - 1;
+		out->dsthost_hash = host_override - 1;
+		out->srchost_hash = host_override - 1;
 	}
 
 	if (!(flow_mode & CAKE_FLOW_FLOWS)) {
 		if (flow_mode & CAKE_FLOW_SRC_IP)
-			flow_hash ^= srchost_hash;
+			out->flow_hash ^= out->srchost_hash;
 
 		if (flow_mode & CAKE_FLOW_DST_IP)
-			flow_hash ^= dsthost_hash;
+			out->flow_hash ^= out->dsthost_hash;
 	}
+}
+
+/* Resolve the keys from cake_hash_keys() into the set-associative flow
+ * table. Mutates q->tags[], the flow host indices, the way counters and
+ * the host bulk-flow counts, so run only after admission.
+ */
+static u32 cake_hash_resolve(struct cake_tin_data *q,
+			     const struct cake_hash_keys *keys, int flow_mode)
+{
+	u32 flow_hash = keys->flow_hash, srchost_hash = keys->srchost_hash,
+	    dsthost_hash = keys->dsthost_hash;
+	u16 reduced_hash, srchost_idx, dsthost_idx;
+
+	/* Duplicate of the guard in cake_hash_keys(): the original single
+	 * cake_hash() returned 0 here, short-circuiting both halves. Without
+	 * it the flowblind path would commit set-associative state it never
+	 * touched before.
+	 */
+	if (unlikely(flow_mode == CAKE_FLOW_NONE))
+		return 0;
 
 	reduced_hash = flow_hash % CAKE_QUEUES;
 
@@ -1712,18 +1746,25 @@ static struct cake_tin_data *cake_select_tin(struct Qdisc *sch,
 	return &qd->tins[tin];
 }
 
-static u32 cake_classify(struct Qdisc *sch, struct cake_tin_data **t,
-			 struct sk_buff *skb, int flow_mode, int *qerr)
+/* Run the optional external classifier. Returns true when a terminal TC
+ * action consumed the packet (reason in *qerr); otherwise *flow and *host
+ * hold the filter's overrides (0 if none) and the packet is hashed as
+ * before.
+ */
+static bool cake_tcf_classify(struct Qdisc *sch, struct sk_buff *skb,
+			      u16 *flow, u16 *host, int *qerr)
 {
 	struct cake_sched_data *q = qdisc_priv(sch);
 	struct tcf_proto *filter;
 	struct tcf_result res;
-	u16 flow = 0, host = 0;
 	int result;
 
+	*flow = 0;
+	*host = 0;
+
 	filter = rcu_dereference_bh(q->filter_list);
 	if (!filter)
-		goto hash;
+		return false;
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	result = tcf_classify_qdisc(skb, filter, &res, false);
@@ -1737,17 +1778,15 @@ static u32 cake_classify(struct Qdisc *sch, struct cake_tin_data **t,
 			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
 			fallthrough;
 		case TC_ACT_SHOT:
-			return 0;
+			return true;
 		}
 #endif
 		if (TC_H_MIN(res.classid) <= CAKE_QUEUES)
-			flow = TC_H_MIN(res.classid);
+			*flow = TC_H_MIN(res.classid);
 		if (TC_H_MAJ(res.classid) <= (CAKE_QUEUES << 16))
-			host = TC_H_MAJ(res.classid) >> 16;
+			*host = TC_H_MAJ(res.classid) >> 16;
 	}
-hash:
-	*t = cake_select_tin(sch, skb);
-	return cake_hash(*t, skb, flow_mode, flow, host) + 1;
+	return false;
 }
 
 static void cake_reconfigure(struct Qdisc *sch);
@@ -1758,22 +1797,87 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	u32 idx, tin, prev_qlen, prev_backlog, drop_id;
 	struct cake_sched_data *q = qdisc_priv(sch);
 	int len = qdisc_pkt_len(skb), ret;
+	u16 flow_override, host_override;
+	struct sk_buff *segs = NULL;
+	struct cake_hash_keys keys;
 	struct sk_buff *ack = NULL;
 	ktime_t now = ktime_get();
 	struct cake_tin_data *b;
 	struct cake_flow *flow;
 	bool same_flow = false;
+	u64 slen = 0;
 
-	/* choose flow to insert into */
-	idx = cake_classify(sch, &b, skb, q->config->flow_mode, &ret);
-	if (idx == 0) {
+	/* Classify first so terminal TC actions (STOLEN/QUEUED/TRAP/SHOT)
+	 * keep working at the ceiling; carry the overrides to
+	 * cake_hash_keys().
+	 */
+	if (cake_tcf_classify(sch, skb, &flow_override, &host_override, &ret)) {
 		if (ret & __NET_XMIT_BYPASS)
 			qdisc_qstats_drop(sch);
 		__qdisc_drop(skb, to_free);
 		return ret;
 	}
+
+	/* Drop before hash/shaper state so a rejected packet disturbs
+	 * neither; the QDISC_MAX_BACKLOG margin leaves room for one more
+	 * stab-clamped packet (SPLIT_GSO re-checks its segment sum below).
+	 */
+	if (unlikely(qdisc_backlog_at_max(sch))) {
+		qdisc_qstats_overlimit(sch);
+		return qdisc_drop_reason(skb, sch, to_free,
+					 QDISC_DROP_OVERLIMIT);
+	}
+
+	/* Tin selection and key extraction must run on the unsegmented skb:
+	 * skb_gso_segment() rewrites an encapsulated GSO packet's headers to
+	 * the inner ones, changing the keys. Neither commits state.
+	 */
+	b = cake_select_tin(sch, skb);
+	cake_hash_keys(skb, q->config->flow_mode, flow_override,
+		       host_override, &keys);
+
+	if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_SPLIT_GSO) {
+		struct sk_buff *nskb, *seg;
+		netdev_features_t features = netif_skb_features(skb);
+
+		segs = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
+		if (IS_ERR_OR_NULL(segs))
+			return qdisc_drop(skb, sch, to_free);
+
+		/* The split path accounts the segment sum, not the
+		 * stab-adjusted qdisc_pkt_len(), so the top check does not
+		 * bound it. Sum the list and reject it whole.
+		 */
+		skb_list_walk_safe(segs, seg, nskb)
+			slen += seg->len;
+
+		if (unlikely((u64)sch->qstats.backlog + slen > QDISC_MAX_BACKLOG)) {
+			qdisc_qstats_overlimit(sch);
+			/* skb_gso_segment() moved the sock_wfree destructor
+			 * to the tail segment; defer the whole list to
+			 * to_free, never free it under the qdisc lock.
+			 *
+			 * Fraglist GSO is the exception: skb_segment_list()
+			 * returns the original skb as the head with an extra
+			 * ref (segs == skb), so drop the caller's ref and
+			 * queue the list once, or the two drops self-link it.
+			 */
+			if (unlikely(segs == skb)) {
+				tcf_set_qdisc_drop_reason(skb,
+							  QDISC_DROP_OVERLIMIT);
+				consume_skb(skb);
+				return qdisc_drop_all(segs, sch, to_free);
+			}
+			__qdisc_drop_all(segs, to_free);
+			return qdisc_drop_reason(skb, sch, to_free,
+						 QDISC_DROP_OVERLIMIT);
+		}
+	}
+
+	/* Admitted: resolve the keys and commit flow/shaper state. */
+
+	idx = cake_hash_resolve(b, &keys, q->config->flow_mode);
 	tin = (u32)(b - q->tins);
-	idx--;
 	flow = &b->flows[idx];
 
 	/* ensure shaper state isn't stale */
@@ -1800,28 +1904,22 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	if (unlikely(len > b->max_skblen))
 		WRITE_ONCE(b->max_skblen, len);
 
-	if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_SPLIT_GSO) {
-		struct sk_buff *segs, *nskb;
-		netdev_features_t features = netif_skb_features(skb);
-		unsigned int slen = 0, numsegs = 0;
-
-		segs = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
-		if (IS_ERR_OR_NULL(segs))
-			return qdisc_drop(skb, sch, to_free);
+	if (segs) {
+		struct sk_buff *nskb, *seg;
+		unsigned int numsegs = 0;
 
-		skb_list_walk_safe(segs, segs, nskb) {
-			skb_mark_not_on_list(segs);
-			qdisc_skb_cb(segs)->pkt_len = segs->len;
-			qdisc_skb_cb(segs)->pkt_segs = 1;
-			cobalt_set_enqueue_time(segs, now);
-			get_cobalt_cb(segs)->adjusted_len = cake_overhead(q,
-									  segs);
-			flow_queue_add(flow, segs);
+		skb_list_walk_safe(segs, seg, nskb) {
+			skb_mark_not_on_list(seg);
+			qdisc_skb_cb(seg)->pkt_len = seg->len;
+			qdisc_skb_cb(seg)->pkt_segs = 1;
+			cobalt_set_enqueue_time(seg, now);
+			get_cobalt_cb(seg)->adjusted_len = cake_overhead(q,
+									 seg);
+			flow_queue_add(flow, seg);
 
 			qdisc_qlen_inc(sch);
 			numsegs++;
-			slen += segs->len;
-			q->buffer_used += segs->truesize;
+			q->buffer_used += seg->truesize;
 			WRITE_ONCE(b->packets, b->packets + 1);
 		}
 
diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index a1ba2e355f2d..ff7e72989dfc 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -116,15 +116,17 @@ static struct sk_buff *codel_peek(struct Qdisc *sch)
 static int codel_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			       struct sk_buff **to_free)
 {
-	struct codel_sched_data *q;
+	struct codel_sched_data *q = qdisc_priv(sch);
 
-	if (likely(qdisc_qlen(sch) < sch->limit)) {
-		codel_set_enqueue_time(skb);
-		return qdisc_enqueue_tail(skb, sch);
+	if (unlikely(qdisc_qlen(sch) >= sch->limit) ||
+	    unlikely(qdisc_backlog_at_max(sch))) {
+		WRITE_ONCE(q->drop_overlimit, q->drop_overlimit + 1);
+		return qdisc_drop_reason(skb, sch, to_free,
+					 QDISC_DROP_OVERLIMIT);
 	}
-	q = qdisc_priv(sch);
-	WRITE_ONCE(q->drop_overlimit, q->drop_overlimit + 1);
-	return qdisc_drop_reason(skb, sch, to_free, QDISC_DROP_OVERLIMIT);
+
+	codel_set_enqueue_time(skb);
+	return qdisc_enqueue_tail(skb, sch);
 }
 
 static const struct nla_policy codel_policy[TCA_CODEL_MAX + 1] = {
diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 4947def7c49e..5c746e9b60cd 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -392,6 +392,7 @@ static int dualpi2_enqueue_skb(struct sk_buff *skb, struct Qdisc *sch,
 	struct dualpi2_skb_cb *cb;
 
 	if (unlikely(qdisc_qlen(sch) >= sch->limit) ||
+	    unlikely(qdisc_backlog_at_max(sch)) ||
 	    unlikely((u64)q->memory_used + skb->truesize > q->memory_limit)) {
 		qdisc_qstats_overlimit(sch);
 		if (skb_in_l_queue(skb))
diff --git a/net/sched/sch_fifo.c b/net/sched/sch_fifo.c
index 1b6388d50967..d5e5cd49377d 100644
--- a/net/sched/sch_fifo.c
+++ b/net/sched/sch_fifo.c
@@ -29,6 +29,9 @@ static int bfifo_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 static int pfifo_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			 struct sk_buff **to_free)
 {
+	if (unlikely(qdisc_backlog_at_max(sch)))
+		return qdisc_drop(skb, sch, to_free);
+
 	if (likely(sch->q.qlen < READ_ONCE(sch->limit)))
 		return qdisc_enqueue_tail(skb, sch);
 
@@ -43,6 +46,9 @@ static int pfifo_tail_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	if (unlikely(READ_ONCE(sch->limit) == 0))
 		return qdisc_drop(skb, sch, to_free);
 
+	if (unlikely(qdisc_backlog_at_max(sch)))
+		return qdisc_drop(skb, sch, to_free);
+
 	if (likely(sch->q.qlen < READ_ONCE(sch->limit)))
 		return qdisc_enqueue_tail(skb, sch);
 
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index e6c87a32950f..7c52acf201c6 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -73,22 +73,34 @@ static unsigned int fq_codel_hash(const struct fq_codel_sched_data *q,
 	return reciprocal_scale(skb_get_hash(skb), q->flows_cnt);
 }
 
-static unsigned int fq_codel_classify(struct sk_buff *skb, struct Qdisc *sch,
-				      int *qerr)
+/* Run the optional external classifier. Returns true when the caller must
+ * drop (a terminal TC action consumed the packet, or the result carried no
+ * class ID); the reason is then in *qerr. Else *idx is the 1-based flow
+ * index, or *do_hash asks the caller to use fq_codel_hash().
+ */
+static bool fq_codel_classify(struct sk_buff *skb, struct Qdisc *sch,
+			      unsigned int *idx, bool *do_hash, int *qerr)
 {
 	struct fq_codel_sched_data *q = qdisc_priv(sch);
 	struct tcf_proto *filter;
 	struct tcf_result res;
 	int result;
 
+	*idx = 0;
+	*do_hash = false;
+
 	if (TC_H_MAJ(skb->priority) == sch->handle &&
 	    TC_H_MIN(skb->priority) > 0 &&
-	    TC_H_MIN(skb->priority) <= q->flows_cnt)
-		return TC_H_MIN(skb->priority);
+	    TC_H_MIN(skb->priority) <= q->flows_cnt) {
+		*idx = TC_H_MIN(skb->priority);
+		return false;
+	}
 
 	filter = rcu_dereference_bh(q->filter_list);
-	if (!filter)
-		return fq_codel_hash(q, skb) + 1;
+	if (!filter) {
+		*do_hash = true;
+		return false;
+	}
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	result = tcf_classify_qdisc(skb, filter, &res, false);
@@ -101,13 +113,16 @@ static unsigned int fq_codel_classify(struct sk_buff *skb, struct Qdisc *sch,
 			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
 			fallthrough;
 		case TC_ACT_SHOT:
-			return 0;
+			return true;
 		}
 #endif
-		if (TC_H_MIN(res.classid) <= q->flows_cnt)
-			return TC_H_MIN(res.classid);
+		if (TC_H_MIN(res.classid) > 0 &&
+		    TC_H_MIN(res.classid) <= q->flows_cnt) {
+			*idx = TC_H_MIN(res.classid);
+			return false;
+		}
 	}
-	return 0;
+	return true;
 }
 
 /* helper functions : might be changed when/if skb use a standard list_head */
@@ -188,17 +203,33 @@ static int fq_codel_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct fq_codel_sched_data *q = qdisc_priv(sch);
 	unsigned int idx, prev_backlog, prev_qlen;
 	struct fq_codel_flow *flow;
-	int ret;
+	bool do_hash = false;
 	unsigned int pkt_len;
 	bool memory_limited;
+	int ret;
 
-	idx = fq_codel_classify(skb, sch, &ret);
-	if (idx == 0) {
+	/* Classify first so terminal TC actions (STOLEN/QUEUED/TRAP/SHOT)
+	 * keep working at the ceiling; only hashing is deferred below.
+	 */
+	if (fq_codel_classify(skb, sch, &idx, &do_hash, &ret)) {
 		if (ret & __NET_XMIT_BYPASS)
 			qdisc_qstats_drop(sch);
 		__qdisc_drop(skb, to_free);
 		return ret;
 	}
+
+	/* Drop before hashing so a rejected packet disturbs no flow hash;
+	 * the QDISC_MAX_BACKLOG margin leaves room for one more stab-clamped
+	 * packet.
+	 */
+	if (unlikely(qdisc_backlog_at_max(sch))) {
+		q->drop_overlimit++;
+		return qdisc_drop_reason(skb, sch, to_free,
+					 QDISC_DROP_OVERLIMIT);
+	}
+
+	if (do_hash)
+		idx = fq_codel_hash(q, skb) + 1;
 	idx--;
 
 	codel_set_enqueue_time(skb);
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 5982847df8f8..394f015cec36 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -155,7 +155,8 @@ static int fq_pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	memory_limited = q->memory_usage > q->memory_limit + skb->truesize;
 
 	/* Checks if the qdisc is full */
-	if (unlikely(qdisc_qlen(sch) >= sch->limit)) {
+	if (unlikely(qdisc_qlen(sch) >= sch->limit) ||
+	    unlikely(qdisc_backlog_at_max(sch))) {
 		q->stats.overlimit++;
 		goto out;
 	} else if (unlikely(memory_limited)) {
diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index 3b7863ffd284..9e38f38ce923 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -89,7 +89,8 @@ static int pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct pie_sched_data *q = qdisc_priv(sch);
 	bool enqueue = false;
 
-	if (unlikely(qdisc_qlen(sch) >= sch->limit)) {
+	if (unlikely(qdisc_qlen(sch) >= sch->limit) ||
+	    unlikely(qdisc_backlog_at_max(sch))) {
 		WRITE_ONCE(q->stats.overlimit, q->stats.overlimit + 1);
 		goto out;
 	}
diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index d7598214270b..e3a254f9dbdf 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -76,6 +76,12 @@ static int red_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	unsigned int len;
 	int ret;
 
+	if (unlikely(qdisc_backlog_at_max(sch))) {
+		qdisc_qstats_overlimit(sch);
+		return qdisc_drop_reason(skb, sch, to_free,
+					 QDISC_DROP_OVERLIMIT);
+	}
+
 	q->vars.qavg = red_calc_qavg(&q->parms,
 				     &q->vars,
 				     child->qstats.backlog);
-- 
2.43.0

