Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BFE3BAD9A
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791445654; cv=none; b=nq0PjaI8MF907Hnkct+ZRo1zfd7tCStYmBIacvMoXNZv08Tt0q+ZC1zCN3EVc9ZeyE/C0hwxWzz9oJJaHepj6qWn87hQJuB6i/IjMGzzl4ezLQfV/vmcd3FTA1S+xT8XQDz2lpWpi69mmHtKi9a0AHj+2vqNtYIfLaDOEc1uykQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791445654; c=relaxed/simple;
	bh=5Ut5Mz2uvBRzsYpiM4SgtgGV/fAn9TsJsWneCAnTvVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XFpLr9teiaL6KteXrYUr8jgkGQJDhn7Bf8WCcxbELOzOW4Xh4qKgWL7a+NKkfh208trbrHRdBRfYhUc734Df70IFE0W9RWZpgB+1LxcjpHKgSyBfIbatoS59ppNOpgE5ktTSmq4fsPUCHdDqvF/R+pVWjUhNK40SkbuTWhXenqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=MKxFPyk8; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="MKxFPyk8"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5356b6a7fe5so27763001cf.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 00:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791445651; x=1792050451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=17lNCcyUrXS3jCmNwr/tkmkS1CRv+uhmVrNVbaSV7Vg=;
        b=MKxFPyk8lhow3oOTsaTjDHdkgc6qj0Ybq9pO82ReL2QVuqRvtStNDVPlaDTWwporvk
         263nKnq2oLt4j3AMfuCMJUQD4O2LPQ4ZgZXVZC0gyKVvRqndhQJRT916oWa09zT1OiaQ
         vLONGGsPl7ESYyO8o8s2bOW7yXwCzjmYWklb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791445651; x=1792050451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=17lNCcyUrXS3jCmNwr/tkmkS1CRv+uhmVrNVbaSV7Vg=;
        b=TBC1dw0Jfy4FPPbySBqZufImN0r8HDko6cRkUhc+1xG4IHi02j24sRy9XZNouPs/Jr
         h0FKhvPI6j3xiyfxFRzyz2qdsV6gUe4k7w86gy7fOcRj7xtYTg/Rv6jmc0oWkFIGp6f6
         KOJ4DHJuVtKo3G31GmvXrmIHXwaWHqWhC0TmWLM8sktshl44RK2akzRaBh8V0avrxuI+
         fgSJYOJmMBie1ar9nm6CtAf1ZkR1zr8QVB3RweRVk+RmFSQ1WiRlrrjA+tOfJna/8GHV
         6kzdYR7NdXuk/UWQFCyj1gWGOBA2PyqNHpLYIYc/j4Q25NWZNCJWLF1zQMlfIcQx+zZw
         CQQA==
X-Gm-Message-State: AFuF++lIOaxnjEkrUZcUxGapW6l6i6eXkFS1ZwtLkpk1BeV6QvOUt2Om
	BIpJoMGUSwKJr5P/+yCaAhTEqghFYqa0H7b9md8Mq8VZGMEkySXhKnn/ie+Fe1kAF8AOjL7psnQ
	nW/hFgw==
X-Gm-Gg: AYBFou0KL46NiniOgvOVe33M16NprAVJaPtJfjWp8uAKAtMqmhemFX3XbGrMjDosK/R
	1ERpZXTAvayr0JIzyGU4nw41IJSYTvT5jYQGvS2IyALoVJNLY2oPXUGKzszvtxhcZxkbt0nFPz1
	mE545UYQlJDU8fBsquWo3sJ1vlButAo33pCFP7AOxj4SmPJv8cZJslNk/nx46rGCOAb5jFGB1bi
	/XxANjCnij/hXP6XZIOdhLL4RWCfVYEDJ6WjUfhYzhsIdGQzCf4dh9Fd0SxOfd93WJA2cRsCLCt
	THCSLWBBujoYE1I2n+SEuj2TUcYO4lcbtuY0vAEXN3iiZuZuU6Vr5rqNbuA+N4ZnTlBTIkGNtJ+
	EKz1Sz2qK+BA1DoblTQK8FrmibokLEYHqmwd0gx50d5wMrLS5Dm1VNFq/W6xF1Qvu+hV3fdozJz
	IYKv/trSZlNiN4DjEj8ZswNKaihkPtkOEP9AYUxaupprWyHK1RUVk8pwzoIaN8TmKdpiJ8Io7nr
	XK0PbpMW3euO//4M4pRC5luQcJ9/yjlEaq8DUO7YhHB04hMxQ==
X-Received: by 2002:a05:622a:8c7:b0:535:521:75aa with SMTP id d75a77b69052e-535755c13d8mr80487401cf.48.1791445650909;
        Thu, 08 Oct 2026 00:47:30 -0700 (PDT)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5357213f3dcsm38253961cf.17.2026.10.08.00.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 00:47:30 -0700 (PDT)
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
Subject: [PATCH net-next 2/4] net/sched/sch_cake: reduce parent backlog when clearing a tin
Date: Thu,  8 Oct 2026 03:47:10 -0400
Message-Id: <QDISC-5RTM.v1.20261007130704-3@mojatatu.com>
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

Tins are cleared from cake_reset() and, on reconfigure, from
cake_configure_rates(). The qdisc core already owns the parent delta for
the reset path: qdisc_purge_queue() snapshots qlen/backlog, runs
qdisc_reset(), then reduces the tree, so propagating the reduction from
cake_clear_tin() itself would subtract the same backlog twice. Snapshot
CAKE's qlen/backlog around only the reconfiguration purge in
cake_configure_rates() and reduce the parent once afterwards, matching
the delta pattern already used by cake_enqueue().

Conditions to recreate the bug: put CAKE (diffserv8) under an HTB class,
flood DSCP-classified traffic into a high tin so it backlogs, then change
CAKE to diffserv3. The HTB parent keeps the purged packets in its qlen
and backlog; a kernel with the fix shows the parent at the leaf's backlog
(426b/5p) instead of retaining the purged packets.

Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260816012109.2865223-1-ooonea@gmail.com
Link: https://lore.kernel.org/netdev/20260816012109.2865223-1-ooonea@gmail.com/
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
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

