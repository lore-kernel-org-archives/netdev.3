Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0E951599A
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 10:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060376; cv=none; b=gnBOI/yBiJZSL6F1HgDrc3XeDjpcArIgThaLpxDzGeVYWXQmDq54IwPrlofCghZeOFMAXBbgfD+jKMtsKwwy01gBHIEgE5p8YNd+fEBsC9/Vp8tiGj+aTQOKfspq2Lz2owsp690NdjmH6pECwb1gN3NSN6AGaUVIjSiGhpDpzug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060376; c=relaxed/simple;
	bh=OZbxwBxho4GfAvxbfrN+rMAHBZAt+e5t5XFJxKarp4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zx8e2TPvV4njs0aiRbjpxIE19dgG9odgDdW+TAWhbM40CZ5Rw10SdcTDXJO8/Y5Eqw/xB7jWmO2EeOmRwVivyN6N25k1KGdlTgER2LDh+JCrYSf2SIvI6YChLwcu9ZjUMS4s8ugKAc1Rhot9VExZhut2/8xBsZnrO0bAnTeM9/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=jVn/6tfx; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="jVn/6tfx"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-917a20e9efeso72704196d6.2
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 03:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792060373; x=1792665173; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9DR84ZATlyuLvZzGt+FeMmZtU5PGVpmcWJxla2K50nA=;
        b=jVn/6tfxQrGEfiGRl6t4XoX4pLjLKzqPX5q93J4QWfXcwH2syAKsHfcCw9kXchMvKW
         KQ1Yz7oiNoMADIaMHpAgACHXYCCz8bP/VzMySBy9HnIklWPBy5R2BfhdYevekTYcLGRq
         l0bQ0j0xHWqJkvwu0RCm7Y6v4aBJUAZdhPkYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792060373; x=1792665173;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9DR84ZATlyuLvZzGt+FeMmZtU5PGVpmcWJxla2K50nA=;
        b=2lWQ7jmorhVYsNFw8tDiPOM3MX2VEkLdHhnVIh2amWtW5LEyR+JRDZ8mycAJXSS0jh
         GgCwy7XEQ3XL1QA2yEIwv/foJHWYSjb9J0PyA+PduMkXSa1fm2Dk/q6xl04dO5lTZQqn
         JPGhH9SvAySXWDtLCs+0fQaA9Luf0bxTb0ql7FT6WJpcVzkf8O4DcBgjWCcZpJbpKLD3
         pufjhp1pePetEmACyQaBXIjngVPpEbWWU2ZgyILmD+B2iheuOg4fwo4zRzyd9Yg50+YN
         1bkHkuntAAsojOAtsrYCjwbbvkhtZicCdXlNL4yCKyro84QsoQykeX9FB8tFpV/0U/oH
         E7wA==
X-Gm-Message-State: AFq9FYIal4u4BsY3FqZq4bJWOM7FFjUuVUfO/i9o7Pv72JhspJeiP86A
	W7+dezv9WdeYP83Smb+5vUsT42AKmM04tlQJFfK98KJ/lCLy7aCGQPj3TezqpH56un8BoBTzu3N
	0nnA=
X-Gm-Gg: AYBFou3dFTkxq6Pc1p5LTNsnbGRKKHozAktHksyAzHwDmSaRRWNpDWAaZt6oLMEZWqp
	7YpBp96a0MdU4CyhDX3DU87Rluvnl25O6ZjCVXdZlQj+OXKlbO0ocC1ot/EZZyVHvtF8OgCbO/s
	WR2QxRhjHjT1E0KqozTaJA37PYbSev0jpyLiHvBaHd/02YT8PY6cxc7/SZ4FFb9Y0RNKHvUHeEX
	jO+qyo6NFSkgCx1ZVgLOR+0qrod8fbZ2Beb5KuUsjoG/s3KBX68HWxtdWbBw1JIHh/NKS9Qt2Rc
	GfrxxoAlZNiAq199XtSy33XqTv7AmSlwsykrVZQt9+eXTBVGXp5CHquAQ3I/Ujdoz9XE6aX58BN
	iAqXBfq2oIs0gK7D6PjzcWxA+cFblore7ahyxAPwUvFTjBRNSxafZssr8iA0epyLhQ84OTU6Bf+
	TqPDohzjrrj2Gy8hyplW0+J5fbZlys8mV8EB3ZgtxRYYMErhNOrQp+ORfg7PY4mwo9dEXMiy/ya
	L9IZUowpS+XgWmua7BoEtZydQwdv7EjUG+I44uJzTrloIT+DQvTXwM=
X-Received: by 2002:a05:6214:4a06:b0:91b:8aad:79da with SMTP id 6a1803df08f44-91b8aad7bd4mr180472026d6.28.1792060373467;
        Thu, 15 Oct 2026 03:32:53 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ba684f404sm55261936d6.31.2026.10.15.03.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 03:32:53 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/4] net/sched/sch_cake: reduce parent backlog when clearing a tin
Date: Thu, 15 Oct 2026 06:32:43 -0400
Message-Id: <QDISC-5RTM.v2.r0.20261015051735-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-5RTM.v2.r0.20261015051735@mojatatu.com>
References: <QDISC-5RTM.v2.r0.20261015051735@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The issue:
CAKE has purged unused tins on DiffServ reconfiguration since commit
83f8fd69af4f ("sch_cake: Add DiffServ handling") without propagating the
resulting backlog reduction to classful parents. The issue was noticed
while reviewing 7cbfb180945c, but predates that change.

cake_clear_tin() drops every packet from a tin with
kfree_skb_reason() but never calls qdisc_tree_reduce_backlog(), so a
CAKE qdisc under a classful parent (e.g. HTB) leaves the dropped packets
in the parent qdisc's and class's qlen/backlog accounting forever. The
normal dequeue path does reduce the parent; only the live reconfigure
purge misses it.

The fix:
Tins are cleared from cake_reset() and, on reconfigure, from
cake_configure_rates(). The qdisc core already owns the parent delta for
the reset path: qdisc_purge_queue() snapshots qlen/backlog, runs
qdisc_reset(), then reduces the tree, so propagating the reduction from
cake_clear_tin() itself would subtract the same backlog twice. Snapshot
CAKE's qlen/backlog around only the reconfiguration purge in
cake_configure_rates() and reduce the parent once afterwards, matching
the delta pattern already used by cake_enqueue().

Conditions to recreate the bug:
put CAKE (diffserv8) under an HTB class, flood DSCP-classified traffic
into a high tin so it backlogs, then change CAKE to diffserv3. The HTB
parent keeps the purged packets in its qlen and backlog; a kernel with
the fix shows the parent at the leaf's backlog (426b/5p) instead of
retaining the purged packets.

Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260816012109.2865223-1-ooonea@gmail.com
Link: https://lore.kernel.org/netdev/20260816012109.2865223-1-ooonea@gmail.com/
Link: https://lore.kernel.org/netdev/8733ugtry8.fsf@toke.dk/
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v1 -> v2:
- No changes to this patch. Resent as part of the
  series_cake_clear_tin_backlog_underflow v2, which revises patches 1/4
  and 3/4. It is unchanged and carries Toke Høiland-Jørgensen's Acked-by
  from the v1 posting.

 net/sched/sch_cake.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 1c29695dc928..2bad0b6eb13f 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -2611,10 +2611,17 @@ static void cake_configure_rates(struct Qdisc *sch, u64 rate, bool rate_adjust)
 	}
 
 	if (!rate_adjust) {
+		u32 backlog = sch->qstats.backlog, qlen = sch->q.qlen;
+
 		for (c = qd->tin_cnt; c < CAKE_MAX_TINS; c++) {
 			cake_clear_tin(sch, c);
 			qd->tins[c].cparams.mtu_time = qd->tins[ft].cparams.mtu_time;
 		}
+
+		backlog -= sch->qstats.backlog;
+		qlen -= sch->q.qlen;
+		if (qlen)
+			qdisc_tree_reduce_backlog(sch, qlen, backlog);
 	}
 
 	qd->rate_ns   = qd->tins[ft].tin_rate_ns;
-- 
2.43.0

