Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFAC38DC4C
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666727; cv=none; b=DAQJwritQSLfAzpa8iXkZtBtekSPfd1pd3HnSLy9mzj+6yyHuj2dli7dOP/QADn7fMmEbxuD4aE3MNMil7ANkAYBauUZRCbxZDvJW7MIlqmXBkBBDJ2zZ4mvwQF3B8MNjQBLwLA4a+vFnA25Sm7qO02DcxtbjAqgfScfygLnAI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666727; c=relaxed/simple;
	bh=vXiPYU0cSC0MhhcbWDuX8Ks0SSTK1cMIrJrwZV3hEkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5kYk1FLxPnnvF0Oxp66260NAmN6lwxVM8ZGjwQhEmTR42uv7dy0leM1ckeCynnjDJVTjGX3FrylioNWEKjZlNyao1rj7dRBBMkp8PhT4WUZDaeXmfG0dBMathSo87llQmnob0ieL6H+u6zASBov8D3PMaYyKFZKkLIxLXarXpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org; spf=pass smtp.mailfrom=openvz.org; dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.b=Q1tJov6s; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.b="Q1tJov6s"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffb83bf7aso22851845e9.2
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 00:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz.org; s=google; t=1790666724; x=1791271524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1LMlP+LKNpavKh20Ow5p/XPiL08oZ6Sei4hnViskqxo=;
        b=Q1tJov6sRlvjnDh0PA60RUbi/fj5qWjKNu0+CQ5Jny2JWGdx1gd82v+Kt6l++Am/ne
         2n2Wp6Nt49mJFDFVb2Uws9hlCg0Gs3etlCPqySVsubQ14E0ghplljOc+LneBiceQ5LED
         jswtB2lxDVdHqfc+6z6KjpLQZBMrGBFGtZINLlAQeCOmUBKdBBz9ivZtJ1xs7lpFEGoY
         fvqTmW4gxJoDlireAHVHZPKMMUHuz/eMedy2DcTV5fs4KSaQWvroyyCSw5VT96AB0W82
         /KytzMJjdlcf5P4QUue3X31k+1ka1XiRSWxr/cq2qDyEVUSeAmTNOXlCKgpzHbn+0UKD
         cxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790666724; x=1791271524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1LMlP+LKNpavKh20Ow5p/XPiL08oZ6Sei4hnViskqxo=;
        b=QA35AeAZ3gMJWoYOmmdTVpXeKoQfzSW7AJrOBSQlSfNNC16m1DdwyjF+BFJkXjSoZg
         e5MQFTz7rQHgskiSscPxQ3+JVdykfbLLsO7vXr45/R7q7eF/HlDUN5GR5DH0xjxYy19B
         2jpbsepuk4hDpH2P+W5nH/c0Rhvkq6P0fVQ4OmI0x6GPP5CCijzrW6qJA0PWQkwkE0Xb
         Yuvrg52kEgCJBqXh9qJG/GvEYh72pdy4fCSqseU394Mpj1a8s0YU3eZ60wzYnQfQr66d
         4/NK3Y1lrHVrQb43bo5SUFPPOR6/7QWotZrmv1+t5KYANlVjQ3fv61xDBwOgCnnLZhEu
         ka6g==
X-Gm-Message-State: AFuF++mWQ+zBbtFpoqi53lY2VHjpB3r1ufOeZp2V23QR0QTBtBnhc/UF
	/SeQJ8p/Gx/girUbD3gR3BheUxhefTlRy1GEXhvVLCIL9o+hpBKb8tYdzKjLkm+GWNJXOPqR/tF
	Gr/jA
X-Gm-Gg: AYBFou3jggS/qMcmbXhyufHtcefFQHYlFy6hYClEcs+KitxRQ2inoHicFJ9SyNEsa4v
	WRaUg9WDNw8ySjUC+b7XPIaePQOxrcFufjD8LiJr/KbYyJMEJ//aikmVM6E5+RjQbq/PUtykLWK
	vvvhQXxm1NQC6CzHuIhr8lU87aaUbGLx6Ck16pzdpW/cgVcBExfPwmT9rG6S7poN4wc+u/djJuf
	n77DKavaulCTGqBqSjuV8z6UtgfxpYkqhLdzCX2RC0XnoQ9SZnCWmxtmpDExHm9LX2ASJ4/KegA
	ReGxYFG2pnEF+evC0WPJl0jbpNJEJMPN0wI/aysJODURkTuqRFRIkqtUp5qosagVBE9Q73ypzPN
	lX9F2Z/b+fHultIhYqrkN6jPFXmWfShDmm8JEKuAkL3olvsbRMz/ta15JzfYHQLAiSag+ooFQD2
	KO1iinB6xumrtId0LtRFHyLEfrNolUJgybsmFiznOaArRq8mhbvd7C1VDOS1GSKLd5iq8=
X-Received: by 2002:a05:600c:a16:b0:49f:eddb:bcb1 with SMTP id 5b1f17b1804b1-49feddbbe6dmr228957715e9.25.1790666723961;
        Tue, 29 Sep 2026 00:25:23 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:5dc9:ac15:6dc5:8646])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf4598esm58896465e9.0.2026.09.29.00.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 00:25:23 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Denis V. Lunev" <den@openvz.org>,
	stable@vger.kernel.org
Subject: [PATCH net v3] openvswitch: fix soft lockup in the netlink flow dump
Date: Tue, 29 Sep 2026 09:25:19 +0200
Message-ID: <20260929072519.2803304-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929072519.2803304-1-den@openvz.org>
References: <20260929072519.2803304-1-den@openvz.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Denis V. Lunev <den@openvz.org>

A production compute node carrying a few thousand datapath flows hit a
soft lockup inside a single netlink flow dump and panicked.

ovs_flow_cmd_dump() calls ovs_flow_stats_get() for every flow it
emits, and that releases stats->lock with spin_unlock_bh() once per
CPU that has touched the flow. Every release is a local_bh_enable(),
and each one runs the pending softirq backlog in the dumping thread's
own context.

The skb bounds the flows one callback emits, but not the softirq work
it absorbs. On a CPU that carries the box's packet load the backlog
refills as fast as it drains, so the dumping thread becomes that CPU's
softirq engine. It never sleeps and it has no reschedule point, so
under voluntary preemption nothing can take the CPU away from it:
neither the ksoftirqd the kernel woke to take the work over, nor the
stopper thread the softlockup detector dispatches to refresh its
timestamp.

Hold BH off across the whole callback instead, the way
ctnetlink_dump_table() does, so the nested spin_unlock_bh() stop
draining softirqs. The loop already runs under rcu_read_lock() and
cannot sleep. What it gives up is preemption under CONFIG_PREEMPT,
since a BH-off region is not preemptible outside PREEMPT_RT. The
region stays short: the skb caps the flows one callback emits, and
empty buckets cost no skb space but are each visited once per dump, as
the cursor only moves forward. The table grows on insert and shrinks
only on flush, so the walk is bounded by the largest flow count the
datapath has held. The softirq backlog the callback used to absorb has
no bound at all.

Fixes: 63e7959c4b9b ("openvswitch: Per NUMA node flow stats.")
Cc: stable@vger.kernel.org
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
v3:
- add the net prefix, Fixes tag and Cc stable
- explain why the BH-off walk stays bounded: the cursor visits each
  empty bucket once per dump and the table shrinks only on flush
- drop "here" from the comment, add blank lines around the
  local_bh_disable()/local_bh_enable() pair
v2: https://lore.kernel.org/netdev/20260915122401.3910188-1-den@openvz.org/
- leave ovs_vport_cmd_dump() alone: nsid_lock has not been BH-safe
  since commit aed4969f2bdf ("net: net->nsid_lock does not need BH
  safety"), so the vport dump never drained softirqs
- disable BH before the table dereference and say in a comment that
  the region is not there for safety
- drop the ovs_flow_stats_get() history, note the empty-bucket walk
  and the lost CONFIG_PREEMPT preemption in the message
- move the Cc list out of the commit message
v1: https://lore.kernel.org/netdev/20260909171920.1001074-1-den@openvz.org/

 net/openvswitch/datapath.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 631a03136fa1..4fc5d0bebd85 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -1532,6 +1532,12 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		return -ENODEV;
 	}
 
+	/*
+	 * Not needed for safety. Stops every spin_unlock_bh() in
+	 * ovs_flow_stats_get() from running the softirq backlog.
+	 */
+	local_bh_disable();
+
 	ti = rcu_dereference(dp->table.ti);
 	for (;;) {
 		struct sw_flow *flow;
@@ -1552,6 +1558,8 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		cb->args[0] = bucket;
 		cb->args[1] = obj;
 	}
+
+	local_bh_enable();
 	rcu_read_unlock();
 	return skb->len;
 }
-- 
2.53.0

