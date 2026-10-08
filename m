Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833943AE1AD
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 07:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791445657; cv=none; b=QmjnZRZy++7yMvdO9L2aJakuiWjYrmR/La/0Tn/uvh6ITv3sBN+Su7uZUpoqE1n7HkgfZL1POFIiaKr60Y/hH6F+jjGQSWZTPGFPY8KtGIaIh33udRMMgXksAL2Fltt+rlJdpwMfbWCc0ew3dpXkBc/TuZEzg6wGOsoavNjRwVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791445657; c=relaxed/simple;
	bh=aETf28eoyrEO4u646knwOYJ/FPLyW/d0K739RN8zUBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iUhgzN4fPvGsc24FxhNnZDofY86cHlrr3wq0LJr7vTP9447CF2eSZT9XOHulAgZPcXKRuUxA3JSRWVnuN2KdkxGQhWttz0O6VqNEJlXmNWlsQHIZYLFMfxFqQHpz98ljrLwPPDh9kK61WlMePWGL2DM65fnW7vI8utdYvvHvy58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=WbbUbHwt; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="WbbUbHwt"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-533930955a4so25595301cf.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 00:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791445654; x=1792050454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sopkCnIQW7vZq31gYzSsRjKwH3otxOOz8nPSRwXJ2s0=;
        b=WbbUbHwtyKLrqrdwnlH/XtS4Cu29XZsjVt8na/3J9LuanX2R+GoU/jxhfYnmR97FKK
         vC+hUHSLheNGBk/q1d2Oayk8PIiVKKJd8XBpFZgzy0f61dUqE3SMr+bF6XHoTD2SkYOO
         R40aooIfMA5AwmbsYeo8K6Q+ssqJMZX1J/JeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791445654; x=1792050454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sopkCnIQW7vZq31gYzSsRjKwH3otxOOz8nPSRwXJ2s0=;
        b=pF/HeSm0t92gNte974qDA5h1mmViPqX0C9fxDIEim8uDRT2xgvyPgBXcCEg3oh2kaL
         WtKmYejbMNuhNQ11ULSlG41tSxX8gifaO/AEe7Z6Icv2UYoQoWtZqylmSJrDNIbjO4pU
         P9zkwnlU5F8XEvvL9Lqs9Fhky0faP8KoLdJvigkGQ3KuO7kwQMmsWFVFt15Xqm6BEWZ7
         mL+N6GL4Z4mIJebFUsdTDPQ0IofwCeKx8n61KCu9PrciJtHFWZ2KkKlhVyClszNrSBYu
         eI+YT6esdqbcDSvP7vh/uDDp/fpBgH949awiLfX6YlnESwbuEP1Bknfv1lnN60CbYpt5
         m1Zg==
X-Gm-Message-State: AFuF++n9WMFXiHmvTEwh6utODSbi8ypzf/RMMiXOhQKNiRLYxwG2Cb8l
	uKdLhV0B4mTP7Z7YNAzr/ZJtYnHvLZwIfUrAAv7fj5qxFpgR5kQ3QG5cZIc/gdoi+vdiybzOlph
	16nwIoQ==
X-Gm-Gg: AYBFou0wx+o0UBf2rxLxnYOlqvDabcBwicyKCINYZijzmnVwzWJla6abCs2CA7z44uf
	50m0WrBYFF0VopeSaYjz1VMPS7dKN3Qml+n5S3K/tiMgHnX8NJNQDzriELBLOhIx+cUhNQH7pXg
	OmW+PaNpUdpf6DlDAHOfTFv/WnCUDNxb4t/OEiGzgzXhWxAtevaOteFClv6mTXeBm5OEEi7FhII
	4h1CRbXC1lptRNRL8h2wwzTIEzhKzQtyDO/09pW/5j6UTDtvi9UDNyxVlns9lyJLBaA9MP6SPKG
	ONdxfQw588EL6KKD6X3YXGMMpOd6wgzJNxj85RgD7Pec8RA9ipAWVlaie/31xb5txOiSrt8m6F+
	/2TSnyj/lnpRXCucNP9mix/DrGxRMX6S6dTAgWal5dUfLH6zTMZ44Pg4PMKhhlJl0vmi+lW7TNH
	34o0Hh+ew1I5hCzV9OmoLB7NMne2BFVpChulGIMFFYgr/WWj+CvnWebIi2xmnuKUJxdFMWO4zTy
	+kten63XmCcupwVITDQwHJLvIrhSUaomgI9NFtif/JM71DKYg==
X-Received: by 2002:a05:622a:4808:b0:535:70c5:d45 with SMTP id d75a77b69052e-535756d6d7cmr81633911cf.74.1791445654276;
        Thu, 08 Oct 2026 00:47:34 -0700 (PDT)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5357213f3dcsm38253961cf.17.2026.10.08.00.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 00:47:33 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	cake@lists.bufferbloat.net,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net-next 3/4] net/sched/sch_cake: widen buffer_used to u64
Date: Thu,  8 Oct 2026 03:47:11 -0400
Message-Id: <QDISC-5RTM.v1.20261007130704-4@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-5RTM.v1.20261007130704@mojatatu.com>
References: <QDISC-5RTM.v1.20261007130704@mojatatu.com>
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

Widen buffer_used and buffer_max_used to u64, the same shape as the
gred/bfifo/plug fix.  buffer_limit stays u32; the comparison promotes it
to u64, so the bounded queue stops at the configured limit below 2^32 and
the counter can no longer wrap.  buffer_used is subtracted on dequeue and
drop, so the widened type flows through unchanged.

The ACK-filter replacement applied the net delta as one expression,
q->buffer_used += skb->truesize - ack->truesize.  Both operands are
unsigned int, so the subtraction is evaluated at u32 and a larger removed
ACK wraps the delta; the old u32 accumulator folded that back to the
correct net value, but the widened u64 accumulator would persist it as a
roughly 4 GiB over-count.  Apply the replacement as two exact operations
on the widened counter instead; the queue already accounts ack->truesize,
so the subtraction cannot underflow.

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
 net/sched/sch_cake.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 2bad0b6eb13f..4caf9718c9bd 100644
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
 
-- 
2.43.0

