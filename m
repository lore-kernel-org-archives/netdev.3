Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435BF32B10A
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787428533; cv=none; b=d4GonFU5o18eJWRmSKoTZmlYotq93Yn8nPWQEznqHxPjJcZXtGScodBrQcItym6P38HY9Zo+f3GHU/fFbzF3pEyicrGRHYTEwMDJNPsNuHm0QQdge9/CqSJxXwgXfln3pKqPaGv7MjF6VL/JcbH/uhxbNloj3lmBTFAwd0uH/IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787428533; c=relaxed/simple;
	bh=XULh9vnOQQxofPHcp+wpiYKwoZPe7LEJcJEC1nn4dhk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y9TCZXiVLjD99BQ8wzI5XwNAtyE0rV0gmP+p97LlyRbxgm3l1N6YSnT2H2n12LbBVO9k3aGqjj04zB9/xIMUHZ+qhj/HA5OJnbMu8/aYb7KhZly+PIK5P7wu1cTFmz5rJA3XSKLY/MbKNS8+sMfRK8hvqpDNBNJW0TKjqj2OpAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=cwEASL8R; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="cwEASL8R"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e6c4a867cso129210185a.0
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 12:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787428530; x=1788033330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0AyFrhapJd40MP1pWAYBkgGThK8NBGiFdWJpr4BC+80=;
        b=cwEASL8RQAPesmB1usjzdHmy+e+93OTExNfLPCI1qDNjjjGjushSOmFhVczGpvQdgT
         LXcgjD80wCdkXoNZ58E5Ma5sMpNg75VLPgK85scczvC8QmphsUXLpze5vTJ5xDDBFnMU
         314/CYz6EHDnusAt8l6lZwwNOldf9JkCJPEFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787428530; x=1788033330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0AyFrhapJd40MP1pWAYBkgGThK8NBGiFdWJpr4BC+80=;
        b=MzLqHAZEhwsxe5k/14RYaEHNtkNctIigQFfN54ZcOHgsESx7xhvV2xozmGGfIGGJ5g
         TUcpan/YlyEXixVAfoEgg2FBgymGRkY51rsqVZqEOEQkXnAuSSCnJtYl3BqhY2qYH76q
         dG6efvt6oENba+xsfzqjyqSZLCqYIWLfvkKhRy9+xR3lmQylBC8MRjiO/LTbhKaw9vIt
         0PYJGVzij6AEcUR1uqRyrBc0sOdKs3OnKxm6AvxjtM/g0V/Pj2Nd4A5Wfz0SGge/ApmU
         WgzBm7qLy+VnSWm3brxPgoCI16Tdy+Jq1SEwCDpgAIdhsNaQNjym6hdo+uHrfbqovSZd
         9ldQ==
X-Gm-Message-State: AFuF++mX1cvBOU6LTZH86vqBySoo5QXGiL1ufTKrWkt03UWjCeXTI6XW
	3zYxsCGIHeKIIkK8DNMDW325veKtr6GGVevyLpWN7KPO+jHdgfs9tkno2IuNTKP3d9jx+EZkgD+
	A/Jz/YA==
X-Gm-Gg: AR+sD13wEZxGA+sqKne7wYRnTO935metydaK21ZKYPtM8zRHDXzIG22osy24OEzmIuf
	DmHd27FlsDNDXVJra6kljahxOlyVj2pQ1oeevbet9jBHUg5WhCGFcybbvmVZ8CwnwT1D2fPvrHq
	/WPSv5lHxGvs+8Jjz7aerYOCoZyXRJtyhurSVxSnUKRD6JGDYDjofQjf/dSB7lTRwY8RHGWeTua
	SfPHw2ziOibnutQbYBkVBjBRjSmJw7AtanI3RTRJg779T0PiDSCFU/FppH3mxLcwMDK3p7RtMev
	kDXi1ohBE/9Jw2uSVzhUGtIoF42ESHhmhxY0gqodfEmi9O0E5ol63o5/x/DblDsruHKJ2CvTZOK
	AAYOyu9rBH4X4Kaxvy/WxxRNHQMTXpvYkmopdMQN5w3v7REeB2f5ckvaJRzh4w8riB/g7UaAFfB
	3t6OM4TUdlUEgDn3U0Fn4ISP2wlZuRm6FEEu8xU5qF0WsDre/m7f2Y
X-Received: by 2002:a05:620a:2546:b0:92f:279:5953 with SMTP id af79cd13be357-93739531fa0mr1331078785a.27.1787428530185;
        Sat, 22 Aug 2026 12:55:30 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749adef4csm172997385a.11.2026.08.22.12.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 12:55:28 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v3 2/6] net/sched: fq_codel: clamp default quantum and mtu
Date: Sat, 22 Aug 2026 15:55:05 -0400
Message-Id: <20260822195509.112717-3-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260822195509.112717-1-jhs@mojatatu.com>
References: <20260822195509.112717-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fq_codel_init() sets q->quantum = psched_mtu(qdisc_dev(sch)) without
clamping. A device with a huge MTU (e.g. dummy with max_mtu == 0
accepting MTU 2147483634) makes psched_mtu() return 0x80000000, which
overflows the signed flow->deficit to INT_MIN in fq_codel_dequeue(),
causing an infinite loop and soft lockup. Emulate fq_codel_change()
and constrain to [256, FQ_CODEL_QUANTUM_MAX].

The same unclamped psched_mtu() is assigned to q->cparams.mtu a bit
below, and fq_codel_change() never updates it. codel_should_drop()
tests "*backlog <= params->mtu"; with mtu == 0x80000000 (~2 GiB) and
the default 32 MiB memory_limit, the test is always true, so CoDel is
silently and completely disabled (no drops, no ECN). Declare a single
clamped mtu and assign both q->quantum and q->cparams.mtu from it,
which also removes the double psched_mtu() call.

Conditions to recreate the bug: a device whose MTU (plus
hard_header_len) wraps psched_mtu() into the sign bit (e.g. a dummy
device with max_mtu == 0 accepting MTU 2147483634). Requires
CAP_NET_ADMIN in a user namespace.

Fixes: 4b549a2ef4be ("fq_codel: Fair Queue Codel AQM")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_fq_codel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 6cce86ba383c..969b2510b0b8 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -509,6 +509,7 @@ static int fq_codel_init(struct Qdisc *sch, struct nlattr *opt,
 			 struct netlink_ext_ack *extack)
 {
 	struct fq_codel_sched_data *q = qdisc_priv(sch);
+	u32 mtu;
 	int i;
 	int err;
 
@@ -516,13 +517,14 @@ static int fq_codel_init(struct Qdisc *sch, struct nlattr *opt,
 	q->flows_cnt = 1024;
 	q->memory_limit = 32 << 20; /* 32 MBytes */
 	q->drop_batch_size = 64;
-	q->quantum = psched_mtu(qdisc_dev(sch));
+	mtu = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 256, FQ_CODEL_QUANTUM_MAX);
+	q->quantum = mtu;
 	INIT_LIST_HEAD(&q->new_flows);
 	INIT_LIST_HEAD(&q->old_flows);
 	codel_params_init(&q->cparams);
 	codel_stats_init(&q->cstats);
 	q->cparams.ecn = true;
-	q->cparams.mtu = psched_mtu(qdisc_dev(sch));
+	q->cparams.mtu = mtu;
 
 	if (opt) {
 		err = fq_codel_change(sch, opt, extack);
-- 
2.43.0

