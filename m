Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F564BF95F
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790601918; cv=none; b=Dtcdr3XraHxVa8l8+2+0fGNe5xmO2EujJtaLab5cwMllkJTYyx67/0NtDNHKVym1Y2dpyQz9+pgPCxBR3921irRvqWpN+CP5n/GoSLGFrmHJQab2SzHzaG+XXdKREia81l2/BW2ydDF+Jv22Ta9t7EQZ0pZ01cjgiHv/GnPG/mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790601918; c=relaxed/simple;
	bh=omWUq2ylgri5HVuCo9P7BsNPWyA3Qdamo17UVw6wFGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D3I7/eLpUsF4FhfXIxeVwRdVfr9hYoUaYX7B8Ac5zCgcCft2TiOK1R0wqMe+ruwtrrhJK0Glqk/sR4P46V3rai9C09ITJ8WLdMJy6bFGHk43Q/GaD9pG92UuwfsZquEaKm6io/swmSHnqR3TuPegNWuqTkZZaeKTXJ6vpFMkPIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfAYq3xS; arc=none smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfAYq3xS"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8a87fe69060so19959867b3.3
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 06:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790601915; x=1791206715; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J+r/qb76YDeMxdfipeBCvFr6YaXG+gMr49LHmpmmJnA=;
        b=WfAYq3xSFi7kZ/2GXBjCbmZHxxCTKcuQX3tGUKuRSI+MiYulCzyQofksi4eyy4yG94
         mONbf4d7xsxWhnJRCoBz2hBrIeyI/mqvga15DCh0fRK06BvDVnvG70ku0A/9puUlQ482
         PMLN8gx+X8QctwVMQV04LDgRUdonb1xFo5mM9HlyPK2LcwLjT50MbdsIB8e91l845lr6
         +bWdu5BgeumSM4QrosYIup/dBcACpwgFrDv5/7NPJ31OMU9k0pvmEOfj4jMmrSP1wjx1
         3EDqRR3y6QEfO3BskSlMMXAXBOB/SYMBzO16azi34QJJUY0lNkhKjfKG9qWdMPmIlGMp
         gjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790601915; x=1791206715;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J+r/qb76YDeMxdfipeBCvFr6YaXG+gMr49LHmpmmJnA=;
        b=jbc5pF3A1uGt3pTRzkNWbQNelRgwmRDvTH43V0QmfAsBPCL7Biy8W9piYK+YHqID9P
         gW/8mcQvSJfmcwqeAPFAPKPvPG+H1Eo3pkI8f6xfmqWZrPLZm9S/MQfks5YSLOKFecY6
         IhBK8hBpYxbalq1s8ZVVwW9Rb/mrVY/BWbtT4L9bA1jqgSJKh1/XVSEbp3KlcqSxzIbV
         ugjP6jIayH+gZjXaP2Cr/jyGt9aqkpOfRgmlM3X9xxnfXJ/AiaS7tYqF6YZAUXYBYQlw
         lOKf3OqRNdN6UF0OmihzVMejbjoC7ow2Q3FeyGns7qZsq+0VmG17X5mVsQo4/R36VpYz
         2LNQ==
X-Forwarded-Encrypted: i=1; AKwUvBxBAO/+vr4dd3TJxBc380/6yS+PGbMVs8PcX2PvwmSnSvXkCtymu6CjYHNS4Vf1wAJWAm9su7c=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnBx1F8mCvrWz14CofhSBQXgZpiGVppl4MkkMVfL/CFwttLMZB
	PB4s8EXyguvfRdPxflGqNpBqOzSYAnEUp1lV6GY7FNHdas1s1UQCyO8+
X-Gm-Gg: AYBFou140IW4H4MD0uAVFtK7cB2xq0PRpuSbyL7qhqgToPuO9rasL5ayroKqcvQegUJ
	kx65JljebqBAHSFuiDCE7TFmzKgiz8SpLJYu/GKErA0pVgiHcuMfz1L9F7jAYHKKuAGFrHSxS3F
	+SyQG57eEM8RBGPMFZutkAXp10sky4xV9+9u1AwpuV97OSE3CQdJKOOJ/2Ku9wXXEum+CsmW+P2
	c7VwJSyBSu2mSjClr2QLdnoPHR9qHaSknz9nUhF68oDzNwe8hB+2eqpNxdR9xZ0r9D+6oziRDyv
	TF4MGQX//JJntsK3ZLygJh0kPaIJyHimfRcHlvHq9hqvEplYaxQgkpxOy4mrBr0VHplKh/mcnRO
	vafa4D9IIovsir/6s8zQadqj7A5LDGArl5EmGgDaqBcqdG5IUZz2l26gKX2EaovVchLV8XYluj/
	QL4i/ogAhqqUzeI4IYD7PBS5ADJHXvbqOVKM7StO+YJvEj7/8eneLJeUBRPTkliDEBD7jYAeNgb
	UHMrC1ptHgy8xUile3U0mhSs9z/2m/rkUZKWJJ4FYqKsj1OPQ==
X-Received: by 2002:a05:690c:348a:b0:8a8:722a:9a25 with SMTP id 00721157ae682-8a8722aa639mr37186547b3.63.1790601915083;
        Mon, 28 Sep 2026 06:25:15 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:94d6:8f64:6f66:fcd2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ab391acfb0sm298087b3.48.2026.09.28.06.25.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 06:25:14 -0700 (PDT)
From: Yuchao Zhang <ndaugoing@gmail.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	cake@lists.bufferbloat.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>
Subject: [PATCH net v4 2/2] net/sched: sch_cake: validate transport header offset in cake_overhead()
Date: Mon, 28 Sep 2026 21:24:52 +0800
Message-ID: <20260928132452.59996-3-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260928132452.59996-1-ndaugoing@gmail.com>
References: <20260928132452.59996-1-ndaugoing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In cake_overhead(), the header length up to the transport layer is
computed using logic borrowed from qdisc_pkt_len_segs_init():

	/* borrowed from qdisc_pkt_len_segs_init() */
	if (!skb->encapsulation)
		hdr_len = skb_transport_offset(skb);
	else
		hdr_len = skb_inner_transport_offset(skb);

However, cake_overhead() does not validate the computed offset:

1. When the transport header was never set, skb->transport_header holds
   the sentinel value ~0U. skb_transport_offset() returns ~65535.
   skb_header_pointer() subsequently fails, leaving hdr_len as ~65535,
   charging ~66 KB per segment to the shaper.
   Mirror qdisc_pkt_len_segs_init() by bailing out when
   unlikely(!skb_transport_header_was_set(skb)).

2. While qdisc_pkt_len_segs_init() runs at the start of __dev_queue_xmit(),
   packet headers may be adjusted before cake_overhead() is reached:
   - in sch_handle_egress() via tc/BPF egress filters;
   - inside cake_enqueue() via cake_classify() -> tcf_classify() (e.g.
     act_bpf, act_pedit, act_mpls, act_vlan).
   For example, bpf_skb_adjust_room(..., BPF_ADJ_ROOM_MAC) invokes
   bpf_skb_net_hdr_pop(), which pulls skb->data forward and re-syncs
   transport_header only when it aliased network_header, i.e. when no
   transport header had been parsed. If a transport header had been
   parsed, its offset is left where it was while skb->data moves forward,
   so skb_transport_offset() becomes old_offset - len and can turn
   negative. Since hdr_len was declared as unsigned int, a negative offset
   wraps around to near UINT_MAX, corrupting header length accounting.

Declare hdr_len as int and fall back to cake_calc_overhead(q, len, off) if
unlikely(hdr_len < 0). Consolidate all early fallback paths into a single
'err' label at the end of the function.

Fixes: a729b7f0bd5b ("sch_cake: Add overhead compensation support to the rate shaper")
Cc: stable@vger.kernel.org
Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
---
v4:
 - Consolidate the 3 duplicate calls to cake_calc_overhead() into a single
   'err' label at the end of the function, turning early returns into
   'goto err' statements per Toke Høiland-Jørgensen review.
 - Link to v3: https://lore.kernel.org/netdev/20260927131009.24250-1-ndaugoing@gmail.com/

v3:
 - Split from v2 into a standalone patch with its own Fixes: tag
   (a729b7f0bd5b) per Simon Horman and Sashiko review.
 - Clarify header mangling ordering (sch_handle_egress() and cake_classify()
   before cake_overhead()) rather than inaccurate "post-enqueue mangling"
   wording per Sashiko review.
 - Link to v2: https://lore.kernel.org/netdev/20260922084124.36858-1-ndaugoing@gmail.com/
 - Link to v1: https://lore.kernel.org/netdev/20260917122153.62722-1-ndaugoing@gmail.com/
 net/sched/sch_cake.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index b0d604a7052a..f8deb8083f16 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1413,21 +1413,28 @@ static u32 cake_calc_overhead(struct cake_sched_data *qd, u32 len, u32 off)
 static u32 cake_overhead(struct cake_sched_data *q, const struct sk_buff *skb)
 {
 	const struct skb_shared_info *shinfo = skb_shinfo(skb);
-	unsigned int hdr_len, last_len = 0;
+	unsigned int last_len = 0;
 	u32 off = skb_network_offset(skb);
 	u16 segs = qdisc_pkt_segs(skb);
 	u32 len = qdisc_pkt_len(skb);
+	int hdr_len;
 
 	WRITE_ONCE(q->avg_netoff, cake_ewma(q->avg_netoff, off << 16, 8));
 
 	if (segs <= 1)
-		return cake_calc_overhead(q, len, off);
+		goto err;
 
 	/* borrowed from qdisc_pkt_len_segs_init() */
-	if (!skb->encapsulation)
+	if (!skb->encapsulation) {
+		if (unlikely(!skb_transport_header_was_set(skb)))
+			goto err;
 		hdr_len = skb_transport_offset(skb);
-	else
+	} else {
 		hdr_len = skb_inner_transport_offset(skb);
+	}
+
+	if (unlikely(hdr_len < 0))
+		goto err;
 
 	/* + transport layer */
 	if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 |
@@ -1452,6 +1459,9 @@ static u32 cake_overhead(struct cake_sched_data *q, const struct sk_buff *skb)
 
 	return (cake_calc_overhead(q, len, off) * (segs - 1) +
 		cake_calc_overhead(q, last_len, off));
+
+err:
+	return cake_calc_overhead(q, len, off);
 }
 
 static void cake_heap_swap(struct cake_sched_data *q, u16 i, u16 j)
-- 
2.53.0

