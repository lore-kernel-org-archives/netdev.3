Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494018;
	b=ZerLDA99O1t5nrXjbnlNCMSEJA5X/lb21V4gk05UKh9lETa7YiQgIuqJ5ZV+itYwT9RL
	 2kpu/hCAk/jjd/wKqZOPRYaw3kTT/nmK7oC15VjVb+uQznBoLzwipZggqBPDNCR1kE7Zx
	 rYojYAJTi1nfCEayJjOrnKLhbwm5uxHBTHMNFqF1dmohlsIDsXyldMsv46QVf/YEMwLxk
	 i6mg8BpHrGYrnCWapYabth5BM9pnuFBRvraM2VjQ17mco9n/s/iPTZeCSBge5yqet+GNV
	 ntqCatZZqUNEYV3N8pU6v+CTGe2T12ldOyZbs1bufZ3dgdAsEi7mCv68TbunGuE04wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=83fPznlNOuh3F7fGP4M0LAF1CJ6L2NfTeqTFTy/2B9g=;
	b=ZpuXS4v09rV08Eski79deoRqAmm6SqYrYlB0i05NjYREKDcEC6BKuKEMDMVq9lYgMrRE
	 ctAbh8FNehQ4URtS9IHZrVHP2QqKC+YJRoF8v2t+ZMjS5q3sgz5XvGMdg2yT+fIeiOPRc
	 hKr5MpGtx5HnWXm76gfCqkrdkFmSA3AdpwlDfEbz2N827WETn1vvduN+GO4liCxQm/zal
	 R2PLlaeNbb8+1u5vVIT5RQltU8XDLlhMTFbgeyBd1S/WJi9YbAZ7ywJPn/S7iquA8z1V5
	 BYIEWIuwKvtEdSf9LQVpi1BbMQIwk8JiZ14A462TG5eqnVG4jpwknmU+lzKtOUcJI/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=R21sLXI1;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C246E606A338
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 11:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C246E606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=R21sLXI1
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91b54d1e9cdso27710456d6.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 04:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792494017; x=1793098817; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=83fPznlNOuh3F7fGP4M0LAF1CJ6L2NfTeqTFTy/2B9g=;
        b=R21sLXI1XWezzhOXE6asAfJsNjESM/RmDgOVRhIXWAV0mrhAIT9S6TEE0ioHvFMhqY
         GPwfgNBQLY9ABqGxNn5A2BpSIWmoYstrEyybeaVBd2v9JolxfUzqQtgb+uXKy/48Ek0I
         WYVRQFb6T+e1kFKL5q/LYivt+P9xG3USkeK1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792494017; x=1793098817;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=83fPznlNOuh3F7fGP4M0LAF1CJ6L2NfTeqTFTy/2B9g=;
        b=e4EHpRESaKAwKqiaCU/u4uYe7DV8A6ZY9l9lckwbJJWFCscix73YH9Hx45DgPu4wVS
         TnPunM9vQ6a3IMYyuttumpVvUUMmpGT60mNxnxOhNGCZH5bo92RPiP14iGY/Kp1NZRNL
         c71iroEIKp4UKUVJA4VP5I7u5IWDOZQf5LZoHjCw6dzeECGG2i35/dGV5ucaRhrgSX4O
         sFT7Ga/Bw1OksU75zn4rX91GUGNSbtM/2Y31R1GJAu+J7pz7uwyshTE5sfgBOts1qie2
         wlBGyHBPsSchmQJ2PGwx2N/sBigOuZjWUG9C4YzODL0qkAQpvorZLPhfpbN+2C0FKFqT
         j3tg==
X-Gm-Message-State: AFq9FYL1xgGGwtktjMOhphr5vPkGTmEvg14EmpTfbJrkl9w7ZELSI+k5
	KDgxTvjdGyuy2AZqSJYiu3DrN4E8LcdhFWp0eRA5YnfVYof/HB6FRjvMzj6ajRoBuivBPhyhgwU
	9SKA=
X-Gm-Gg: AYBFou2Z9HcMaB6TV3p+n/QVjcTpCtt3bWaxZyT3wD4ydXvtsQ509MECsTL3fIyBo0r
	mX+mmzbBtvQ9LDFGVk+yRN4bm9XJR6hOs8FEAZtGYDeSWjH/wnvT8yYxpoDeRaf2SDsRus1QYv0
	k3NQQmuhKO4NHRbWkcbZiXOg0lo9EOda0HstgQLSJq2iT8Sjr3CBw3gLaWvUaJZPdk+3S6wruzT
	P0waadcXwwmrMba4bVxtWDq8rEpDNLbPIQx4wzBEax4W5sqlju+P8z58K4ttwI0mcmnshMcE5T+
	ivS34koURIa6uALNhyNtIxcp20qbL72lJ8bv9OF9zk3kSlBP33p7T9bwSceCzPJ3t/4funRHFbG
	afU8DY++a+hygltRNL7sPYwU8ARtkAc/P5K300Hhe5YpWaWyjmQxAL89WqBZlPH3bYv5DSS8yCp
	aHo40WOcoS90qobZD0BeRoSoMyMOtra92zPC3T6BerXHsu41rxBPpj+vbrmrgK3qD3i4Qdh2TyC
	Y/fNk+iMt5PNH/Yp1E3DbfvXnWDAA==
X-Received: by 2002:a05:6214:2346:b0:917:aad3:32ae with SMTP id 6a1803df08f44-91bdf2c1a47mr174374126d6.45.1792494016263;
        Tue, 20 Oct 2026 04:00:16 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c040e6667sm23382356d6.39.2026.10.20.04.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 04:00:15 -0700 (PDT)
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
Subject: [PATCH net-next v3 2/4] net/sched/sch_cake: reduce parent backlog when clearing a tin
Date: Tue, 20 Oct 2026 07:00:06 -0400
Message-Id: <QDISC-5RTM.v3.r0.20261020053711-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-5RTM.v3.r0.20261020053711-1@mojatatu.com>
References: <QDISC-5RTM.v3.r0.20261020053711@mojatatu.com> <QDISC-5RTM.v3.r0.20261020053711-1@mojatatu.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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
v2 -> v3:
- No changes to this patch. Resent as part of the series v3; keeps its v1 Reviewed-by and Acked-by tags.

v1 -> v2:
- No changes to this patch. Resent as part of the series v2.
  It is unchanged and carries Toke Høiland-Jørgensen's Acked-by from the v1 posting.

 net/sched/sch_cake.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 5223efae5a28..f97240b1ee9c 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -2704,10 +2704,17 @@ static void cake_configure_rates(struct Qdisc *sch, u64 rate, bool rate_adjust)
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

