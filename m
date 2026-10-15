Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD68D5172EF
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 10:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060378; cv=none; b=exdxdmnb7XkT8zXlYcYiS5AEWymQC+3I4d2jYO6dOvLwFu9ks7whrb9Np+8O46wyGvc7mfx/8j+4jLP21TNBkHozl/YMn4PRZ5qTPS5GFZ0lL8c0+W8eoS2EG3ppeoCkxqJXTu6/wus0lqcfeYxBoW0niQ+nEmKFgO3qxEXSqZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060378; c=relaxed/simple;
	bh=5Jz09q/VUw6mYp32daSl1xADdUjelZ16OLzcCEJDLtI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m3zxA+5aKYaqBsq5/l3bzyBXeNZBWMU4eXemxyYfkWLPY4OzNGqHiW1+pRGYaUrBPIBwryomj9TFsvUny1P3iLdN93RcVnvsBKrjjnrpbSwMW79tff7S6uvdPt9d7rUuSxZc2ruxyfYuT4nflbq4cIeQ7loaYsKTOYOAAIKM5tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=x0KOAnXq; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="x0KOAnXq"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91791ec1b83so11901756d6.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 03:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792060376; x=1792665176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=66piF5YkkVEBVNwq8Z5bqRw7oWnzwFidIdz5zrD4ZM8=;
        b=x0KOAnXqQIM8P97C+x0pieuEMykkS9BS0TobzmxEgCGvvDgfVUyrOs0qi4LvOCGULr
         Cw98Ml+XUg6OH28M0NG5gPIA2XQAkaWKKwoZPPc04wnf7lWr18PC3vpmFKeoObWk4Bso
         MAaSwTVonhSkXAH6qwQRHSUmSr8P4rgE1D284=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792060376; x=1792665176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=66piF5YkkVEBVNwq8Z5bqRw7oWnzwFidIdz5zrD4ZM8=;
        b=GZHZq7mHP9ifb12RjmHYOfxke1qxdN19vYmkQREwtjAjYCNYkwn9goGLzXJcR6D0uG
         7L0y0MdMah3YjqJ/TD+gCblu4muRb2Edh5CevE03s+oC48fttySkFpZARVwUmLuTLkET
         khbmR+ArOlCuu2A1P/2f/G4Iq0GYFbfPtIHXKNyGd1R2Wt8fgQAktqhe3wpZa8zr5Qjt
         3S/y/qjMZhN/D2zVEdxz4eGoXYLGj90Hr1WrVkIHJpai3/+gAwooiOyiE3/mXw2InD40
         Fx+NsLNUf1OrfDBg2K6g/KnwXZnR4U25IQ8Dp4NVVqx8fo9rnvwzLDch/vmTMFQonu3/
         3C0A==
X-Gm-Message-State: AFq9FYInGtH1m4Kru9moA8hN6wAQzMrN8pVoeXHWfPPn+8TBGkvt+ycP
	8Fng0EAxMTqBhI73OB2+vIc4g4+mR4itrKllOV1mcx9H94r6ZS7o8LuGHIyw+Qrp3o832y4M4d2
	ItNg=
X-Gm-Gg: AYBFou3AcPqXPxnuIAvsc6H0uwJaFxwwx/JiO1iA53PYtiLfyqfGjCD6Tm71OWTvGbu
	H9Hz82Vjjt4fsRIoSR40n6W2K5/W01f6c4AREmzRN6K2RF+zc2Hk0vCFRCNzIJVJ6k1WVCIBunv
	H+xR5d60CGr8Du641tSUgZHnZZBnWfoiQx7yjWfLDf0vSycymeqTE0vOwe0voE4L7sZKS/ZcjT6
	2v0xnDGIzMdVvxO1TviKAq43jlO5dshdMoK3ZMQ3zg3KIv3Rlmq1oRT4anHFRyM6CPvoRt0GxVM
	sTe1TUN63gAKqyzdo8ybgdt4R7tcz1DA0kdqKm/OOvIHXnk2FJN+XGznn+XwKltmjyn8LvnSqHD
	KrWhGTr5kzWIaCR+EbvWm5JxWZywjlggui0sVZWiuDk0rlx+vWnZl0sxhMSTLcKTKTc7fU+ytO0
	s/NXQyG9pZjU+Xxeu3o1552zL1eeB6DDCgbqpQuWcSv2zFXih6RgI7UbQJxl4PYz/IcrwtNfRWX
	mWhFLyR2M/+SNBei+rJ2leot1d9RFwk88DmnRyCG12M
X-Received: by 2002:a05:6214:268e:b0:917:a8ae:26d6 with SMTP id 6a1803df08f44-91b5557f525mr318815846d6.34.1792060375737;
        Thu, 15 Oct 2026 03:32:55 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ba684f404sm55261936d6.31.2026.10.15.03.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 03:32:54 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/4] net/sched/sch_cake: widen buffer_used to u64
Date: Thu, 15 Oct 2026 06:32:44 -0400
Message-Id: <QDISC-5RTM.v2.r0.20261015051735-3@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-5RTM.v2.r0.20261015051735@mojatatu.com>
References: <QDISC-5RTM.v2.r0.20261015051735@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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

Conditions to recreate the bug: CAP_NET_ADMIN (root or a user namespace,
the qdisc attach is gated by netlink_net_capable(CAP_NET_ADMIN)).

  # hold a tun device's tx ring so the root qdisc parks packets
  ip tuntap add tun0 mode tun
  ip link set tun0 txqueuelen 32 up
  ip addr add 10.99.0.1/24 dev tun0
  tc qdisc add dev tun0 root handle 1: cake memlimit 4294967295

  # drive >4 GiB of resident truesize through the qdisc (e.g. several UDP
  # sockets with SO_SNDBUFFORCE). On the unfixed kernel buffer_used wraps,
  # the drop loop is bypassed and the guest OOMs; with the fix the counter
  # passes the limit without wrapping and drops the excess.

  # the ACK-filter over-count is reached with ack-filter enabled and a
  # queued pure ACK whose truesize is larger than the replacement ACK:
  tc qdisc add dev tun0 root handle 1: cake ack-filter

Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260818095927.15901-1-jhs@mojatatu.com
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818095927.15901-1-jhs@mojatatu.com
Link: https://lore.kernel.org/netdev/20260818095927.15901-1-jhs@mojatatu.com/
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_cake.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index dc93267029e7..79a07fa80b35 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -234,8 +234,9 @@ struct cake_sched_data {
 	u16		tin_cnt;
 
 	/* resource tracking */
-	u32		buffer_used;
-	u32		buffer_max_used;
+
+	u64		buffer_max_used;
+	u64		buffer_used;
 	u32		buffer_limit;
 
 	/* indices for dequeue */
@@ -1850,7 +1851,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			qdisc_qstats_drop(sch);
 			ack_pkt_len = qdisc_pkt_len(ack);
 			WRITE_ONCE(b->bytes, b->bytes + ack_pkt_len);
-			q->buffer_used += skb->truesize - ack->truesize;
+			q->buffer_used += skb->truesize;
+			q->buffer_used -= ack->truesize;
 			if (q->config->rate_flags & CAKE_FLAG_INGRESS)
 				cake_advance_shaper(q, b, ack, now, true);
 
@@ -3012,7 +3014,8 @@ static int cake_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 
 	PUT_STAT_U64(CAPACITY_ESTIMATE64, READ_ONCE(q->avg_peak_bandwidth));
 	PUT_STAT_U32(MEMORY_LIMIT, READ_ONCE(q->buffer_limit));
-	PUT_STAT_U32(MEMORY_USED, READ_ONCE(q->buffer_max_used));
+	PUT_STAT_U32(MEMORY_USED,
+		     min_t(u64, READ_ONCE(q->buffer_max_used), U32_MAX));
 	PUT_STAT_U32(AVG_NETOFF, ((READ_ONCE(q->avg_netoff) + 0x8000) >> 16));
 	PUT_STAT_U32(MAX_NETLEN, READ_ONCE(q->max_netlen));
 	PUT_STAT_U32(MAX_ADJLEN, READ_ONCE(q->max_adjlen));
