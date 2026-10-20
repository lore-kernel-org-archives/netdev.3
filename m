Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494020;
	b=Y3fOx1RDh3e37jEgzL2Bz69/plAIKQF/8v3NhxdoqgMRSWwIG3SPX/fOXV9KA564BOQO
	 +vFALIjf1JwGMgaCdErsRGrCwgFj9jvspkIMNvBZKX4XvEJDP/IJkZOMJsDCRcTmq8ko0
	 7cBqDT1Xo5PyBrErg20p0xnt4/WVc+OuY02rrmqpI8dGPDlS73YdqOcgEoxC7NlV/y9/u
	 jsxUXY1zgUufrCVtRhoUFiLCVl0Lst2mGhtVaeGUWzvR4PIxtxAN936KHhqR0mKPgChRs
	 BvNMeAHXJfGFHyeOUV/3OEVHOjWCAk8mBCz9BDuG60delLVqyW0sxfWlXHrk0aSJOFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HsYn9AECXvz2V1DoVEEFSn/lcwGhbIliO85Ik3oyuW8=;
	b=tAxcTBIkogdRj6UscnKNHVo3SnSve62lzaDqGtuU/P9cJIHW0+o+iFwoT9s4Z6DvmyxF
	 EUBK586QUJSaEIcWXQSUpW+dYk2cPXB6h9r5SM3ptYT8pTzGkH47HeX2hkwvbCIgpTf2I
	 9K5SwKQe9WZ0sWKnOsHyjy9aaGB0OfV7ESO04+02yGEx/Z8TPN2I/F6sMVx7mGk1kyyRR
	 wAo9DWxpb+w4iKfq+z/VwrqF4TZhsqAGxDx2n53dLa526dVRy4CbLVMnlugJfBk/YH73P
	 8jn2XCBVqHZcsGbRePKKn5zuW4rt86hHYDXHBlwNFHLeCvRZvvOFIldIiTJ6v01r7gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=XUZXbjjS;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FD160A2607
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 11:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10FD160A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=XUZXbjjS
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5351d76e1baso6776461cf.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 04:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792494019; x=1793098819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HsYn9AECXvz2V1DoVEEFSn/lcwGhbIliO85Ik3oyuW8=;
        b=XUZXbjjScKa9BJeLGkhUrsWyz1VJ2nbLcyTLF4jCjC1v5va5OQithbbYWhzDR5fkKc
         rfndowjWYuPuR9LDhNNwH0ZPgvLpvGg6f4664ljkbDfIS9W4t+pHheTUhlwEQR/VpYvw
         juUa5IwoDPOuXYlteF09xPnVQO3AWL+UrcJd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792494019; x=1793098819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HsYn9AECXvz2V1DoVEEFSn/lcwGhbIliO85Ik3oyuW8=;
        b=27rIS712P7SGmf2sWSMvdULsUTxMkY0Nui+c4iQVSK0bBJXdk1ccGDe5pN+9tDs3hB
         D4nIZzrXDn7twYVgaSb6AJKyKvYrw5yUY3ISDLgRxC14e9z99pYOBfFhIcwP3EGP4p7p
         xNuw8Pd2kFE46bqWfsLWzemPxrF7zBmdvptjYXZAZPlGOap95IEqjXh0FVU1Tzo8IJXO
         EIbaakzhjI64v4F3zyyLFkKheenzNjSH26qME4pRTfE2zKw6Na38vvJGDuSg2DKnW30k
         Sn15keH8F8GeLUDMx8Hsyw8duJXWRz5XmzPIcOYX3vaIj6SXLXYpuo0jdTalfRRgcVbF
         8FjQ==
X-Gm-Message-State: AFq9FYLBJJHq3tPq/1X7ESCGarXv7CsdXaQE/a7axTSr8Dbyzfj8Q9kM
	AhODcxiOReV3XapOC4oRzDbqDL+JE+E3FCeIXuxJMMGdOjCrKkMOnlRBO9RC8V1hqmPvY9T+Vf7
	U0/8=
X-Gm-Gg: AYBFou1mcW4Ey06C9zRLeJ2wllxFELffBgjI2cle/n9GVSTSwacBTCM6JpfQana4fvZ
	DXOpNmIqSXpFgSLjVwOWfMtXdHQ0UubPhVxQiTUCwAxTeUq0R5ZSvuUh7ua0OtJpCo3nxLxCkOT
	WPJRsd+EK3Hfy/hr6P/asyK6wypEbfAz189BZabTbPDlwAHLODCpKzBBm8Bfi8GJW8cILtcEZWw
	WVsEcji/G262GuXCUkgPqjdKkbVWXH/YcBCgfDdiJQHxVaxWt6AvBV5QjDBrRZGefYFPZQ9GK3v
	7jqdHITlMrvXluBjvl/5+edf9C7y7HNbZZ6sqNvsXxO4IPuVvHoE24nWUVJj+jPx1WP3jf7u9Jl
	+kzj/pcjQwz986fym5ZUQzjMpA06MMy+oq6jFOvgScy/uGh2DPmJqPxLo4Ht5q6OX3G7xsinFxT
	Ba47hoORuUyuuGQTqJQAPwv6ofC1rKM7kx7v9021u8qgUYk04VPcyv/7OEBOGsy5j0TsA5+XPwU
	gLAx6sdJEyrXtXiNskMJWjW4zUo8Q==
X-Received: by 2002:a05:622a:2512:b0:536:7f96:915c with SMTP id d75a77b69052e-536869c34abmr22511931cf.5.1792494018046;
        Tue, 20 Oct 2026 04:00:18 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c040e6667sm23382356d6.39.2026.10.20.04.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 04:00:17 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	cake@lists.bufferbloat.net,
	Victor Nogueira <victor@mojatatu.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net-next v3 3/4] net/sched/sch_cake: widen buffer_used to u64
Date: Tue, 20 Oct 2026 07:00:07 -0400
Message-Id: <QDISC-5RTM.v3.r0.20261020053711-3@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-5RTM.v3.r0.20261020053711-2@mojatatu.com>
References: <QDISC-5RTM.v3.r0.20261020053711@mojatatu.com> <QDISC-5RTM.v3.r0.20261020053711-1@mojatatu.com> <QDISC-5RTM.v3.r0.20261020053711-2@mojatatu.com>
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

This is a follow-up to commit 4c660ee8c809 ("net: sched: fix 32-bit
backlog wrap in gred, bfifo and plug enqueue"), which promoted the
backlog + length admission sums in gred, bfifo and plug to u64.  CAKE's
own memory accounting has the same 32-bit wrap.

The issue:
cake_sched_data.buffer_used accumulates skb->truesize and is compared
against memory_limit:

	q->buffer_used += skb->truesize;
	if (q->buffer_used <= q->buffer_limit)
		return NET_XMIT_SUCCESS;
	while (q->buffer_used > q->buffer_limit)
		drop...

buffer_used is u32, so once the resident truesize passes 2^32 it wraps to
a small value, the <= test passes and the drop loop is skipped even
though far more than the configured limit is queued.  memory_limit is a
u32 attribute (TCA_CAKE_MEMORY), so buffer_limit can be as large as
U32_MAX and never caps buffer_used below the wrap point; with a large
memory_limit the queue then grows until the machine is out of memory.

The fix:
Widen buffer_used and buffer_max_used to u64, the same shape as the
gred/bfifo/plug fix.  buffer_limit stays u32; the comparison promotes it
to u64, so the bounded queue stops at the configured limit below 2^32 and
the counter can no longer wrap.  buffer_used is subtracted on dequeue and
drop, so the widened type flows through unchanged.  The ACK-filter
replacement applied the net delta as one expression,
q->buffer_used += skb->truesize - ack->truesize.  Both operands are
unsigned int, so the subtraction is evaluated at u32 and a larger removed
ACK wraps the delta; the old u32 accumulator folded that back to the
correct net value, but the widened u64 accumulator would persist it as a
roughly 4 GiB over-count.  Apply the replacement as two exact operations
on the widened counter instead; the queue already accounts ack->truesize,
so the subtraction cannot underflow.

Widening the counters alone is incomplete because cake_dump_stats() still
exports buffer_max_used through PUT_STAT_U32(MEMORY_USED, ...), and
tc.yaml declares memory-used as u32.  buffer_max_used only ever rises, so
once the widened counter passes 2^32 the export reports peak - 2^32 for
the rest of the qdisc's life.  Clamp the exported value to U32_MAX; the
counter itself is unaffected.

The dump path runs without the qdisc lock: tc_fill_qdisc() passes NULL to
gnet_stats_start_copy_compat(), so the reader races with the enqueue-side
update.  READ_ONCE() is not an atomic 64-bit load on 32-bit CPUs, so a
reader can observe a torn high-water mark and report a bogus MEMORY_USED.
Publish the counter as u64_stats_t under the qdisc lock, which the enqueue
path already holds, and take a seqcount-protected snapshot in the dump.
The counter stays u64; only the exported value is bounded.

Conditions to recreate the bug:
CAP_NET_ADMIN (root or a user namespace, the qdisc attach is gated by
netlink_net_capable(CAP_NET_ADMIN)).

A TUN device is needed so the root qdisc can park packets instead of
dropping them.  Open /dev/net/tun, request TUNSETIFF with
IFF_TUN | IFF_NO_PI | IFF_BACKPRESSURE and keep the fd open without
reading it (run it in the background and stop it at teardown): with
IFF_BACKPRESSURE the full tx ring calls netif_tx_stop_queue() rather than
dropping, so the queue behind the qdisc can grow past 4 GiB of resident
truesize.  A plain 'ip tuntap add' attaches no fd and does not request
IFF_BACKPRESSURE, so it cannot park the queue this way.

  ip link set tun0 txqueuelen 32 up
  ip addr add 10.99.0.1/24 dev tun0
  tc qdisc add dev tun0 root handle 1: cake memlimit 4294967295

  # Then push more than 4 GiB of resident truesize through the qdisc: six
  # UDP senders using large SO_SNDBUFFORCE buffers send 1400-byte
  # datagrams (the reported OOM witness used 6 workers for 100 s on a
  # 12 GiB guest).  On the unfixed kernel buffer_used wraps, the admission
  # test passes, the drop loop is bypassed and the guest runs out of
  # memory; with the fix the counter passes the limit without wrapping and
  # the excess is dropped.

  # The ACK-filter over-count is a separate corner: it needs ack-filter
  # enabled and a queued pure ACK whose truesize is larger than the
  # replacement ACK.  Use a fresh interface (or 'tc qdisc change') rather
  # than a second root 'tc qdisc add' on an interface that already has a
  # qdisc:
  tc qdisc change dev tun0 root cake ack-filter

CONFIG_NET_SCH_CAKE=y and CONFIG_TUN=y are required, and the
memory-residency recipe needs a root-run sender envelope with enough
guest RAM to hold the queued data.

Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260818095927.15901-1-jhs@mojatatu.com
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818095927.15901-1-jhs@mojatatu.com
Link: https://lore.kernel.org/netdev/20260818095927.15901-1-jhs@mojatatu.com/
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---

v2 -> v3:
- Make the widened buffer_max_used reader coherent on 32-bit: publish the
  high-water mark as u64_stats_t under the qdisc lock (the enqueue path
  already holds it) and snapshot it in cake_dump_stats() with
  u64_stats_fetch_begin()/u64_stats_fetch_retry().  cake_dump_stats() runs
  without the qdisc lock: tc_fill_qdisc() passes NULL to
  gnet_stats_start_copy_compat(), so the former lockless READ_ONCE() of the
  u64 raced with the enqueue-side update.  READ_ONCE() is not an atomic
  64-bit load on 32-bit CPUs, so MEMORY_USED could report a torn high-water
  mark (Sashiko gemini + nipa v2 review, Low).  No behavioural change on
  64-bit; the U32_MAX clamp of the exported stat is retained.

v1 -> v2:
- Clamp the MEMORY_USED export to U32_MAX: cake_dump_stats() still exported
  the widened buffer_max_used through PUT_STAT_U32(), so once the monotonic
  counter passed 2^32 the u32 stat truncated to peak - 2^32 (Sashiko nipa
  Medium "buffer_max_used export truncation").  The counter itself is
  unaffected; only the reported value is bounded.

 net/sched/sch_cake.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index dc93267029e7..290bbc77df16 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -63,6 +63,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/reciprocal_div.h>
+#include <linux/u64_stats_sync.h>
 #include <net/netlink.h>
 #include <linux/if_vlan.h>
 #include <net/gso.h>
@@ -234,8 +235,10 @@ struct cake_sched_data {
 	u16		tin_cnt;
 
 	/* resource tracking */
-	u32		buffer_used;
-	u32		buffer_max_used;
+
+	struct u64_stats_sync buffer_max_used_sync;
+	u64_stats_t	buffer_max_used;
+	u64		buffer_used;
 	u32		buffer_limit;
 
 	/* indices for dequeue */
@@ -1850,7 +1853,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			qdisc_qstats_drop(sch);
 			ack_pkt_len = qdisc_pkt_len(ack);
 			WRITE_ONCE(b->bytes, b->bytes + ack_pkt_len);
-			q->buffer_used += skb->truesize - ack->truesize;
+			q->buffer_used += skb->truesize;
+			q->buffer_used -= ack->truesize;
 			if (q->config->rate_flags & CAKE_FLAG_INGRESS)
 				cake_advance_shaper(q, b, ack, now, true);
 
@@ -1940,8 +1944,11 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		cake_inc_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
 	}
 
-	if (q->buffer_used > q->buffer_max_used)
-		WRITE_ONCE(q->buffer_max_used, q->buffer_used);
+	if (q->buffer_used > u64_stats_read(&q->buffer_max_used)) {
+		u64_stats_update_begin(&q->buffer_max_used_sync);
+		u64_stats_set(&q->buffer_max_used, q->buffer_used);
+		u64_stats_update_end(&q->buffer_max_used_sync);
+	}
 
 	if (q->buffer_used <= q->buffer_limit)
 		return NET_XMIT_SUCCESS;
@@ -2845,6 +2852,7 @@ static int cake_init(struct Qdisc *sch, struct nlattr *opt,
 	qd->cur_flow  = 0;
 	qd->config = q;
 
+	u64_stats_init(&qd->buffer_max_used_sync);
 	qdisc_watchdog_init(&qd->watchdog, sch);
 
 	if (opt) {
@@ -2995,6 +3003,8 @@ static int cake_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 	struct nlattr *stats = nla_nest_start_noflag(d->skb, TCA_STATS_APP);
 	struct cake_sched_data *q = qdisc_priv(sch);
 	struct nlattr *tstats, *ts;
+	u64 buffer_max_used;
+	unsigned int start;
 	int i;
 
 	if (!stats)
@@ -3010,9 +3020,14 @@ static int cake_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 			goto nla_put_failure;			       \
 	} while (0)
 
+	do {
+		start = u64_stats_fetch_begin(&q->buffer_max_used_sync);
+		buffer_max_used = u64_stats_read(&q->buffer_max_used);
+	} while (u64_stats_fetch_retry(&q->buffer_max_used_sync, start));
+
 	PUT_STAT_U64(CAPACITY_ESTIMATE64, READ_ONCE(q->avg_peak_bandwidth));
 	PUT_STAT_U32(MEMORY_LIMIT, READ_ONCE(q->buffer_limit));
-	PUT_STAT_U32(MEMORY_USED, READ_ONCE(q->buffer_max_used));
+	PUT_STAT_U32(MEMORY_USED, min_t(u64, buffer_max_used, U32_MAX));
 	PUT_STAT_U32(AVG_NETOFF, ((READ_ONCE(q->avg_netoff) + 0x8000) >> 16));
 	PUT_STAT_U32(MAX_NETLEN, READ_ONCE(q->max_netlen));
 	PUT_STAT_U32(MAX_ADJLEN, READ_ONCE(q->max_adjlen));
-- 
2.43.0

