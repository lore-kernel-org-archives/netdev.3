Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D1D3932CE
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 08:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787991172; cv=none; b=AkEOE1+jpndwdIJ/J6YLrzk/waDgQHBk3A9ILsnOVfkdIP0uow5sOX2gdEXC0IcIT3wwbrZLIWIqRNBhXlatm8MRChdGvCfEuJHaKzk0S3xGie6jOHmEl06z4/LqAn0RvIROR+DEZ3WLMtYjUT2jcZSsHQkSANlbiOLBy7SqmSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787991172; c=relaxed/simple;
	bh=8uDIkkzVKcJJcGm8vz8sajeR8G60JBz5XXY98NmCRk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nsuzHNiKKyF6LFLDxFIDDeJvg8M38P4E5lk1iwztWb1zt/35G+TbqNluZ9bSlHeq90KJ8OzmZKraBvBQyEZEMdeET1A9m0jmASAURZPe4oAb24C+aTaYBZPJC7CnFllkDNsf2EkFJi2fGpdVF3OLEHWQ+2D/1uJnI9XQXUiSAF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=otmQJice; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="otmQJice"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92ea24a2dbfso173126685a.0
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 01:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787991169; x=1788595969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7oz77OMrkgFB1w0C3emSz4sp5+lLJW/M03ziQF+FrN8=;
        b=otmQJiceUi0NjrJ17nWy8ea8NtiGkhWCIs3Bgit/AhnuVIyKquQX9Nlfkphc2Ea3QC
         5jV6QGVJEeum2huKKPtdgrnvaHp99slti+j6TO7vC8eqd2NkZAprvb2fu48o6YejZuum
         9M9r9VwKLr3hpxIc6VHy1FYcSmIHpXnJMfT64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787991169; x=1788595969;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7oz77OMrkgFB1w0C3emSz4sp5+lLJW/M03ziQF+FrN8=;
        b=cbwM6ZFiQ7trPUMFtoOyNNPrMvTalAAUoFvD3Q0ifAcVECItuEVbQE5uxXRopmRG7g
         rfh+sWv2ECKLSf09kNY3rtk1+gFXAgYxn5NKo/d9KdZCYZVS+oLz8PqIM/xokoOZl1cn
         77oazseW1AcBHnE2tEW90TYCI6N1aCEubR/acx3pVudXzw3c0TDlL3lUbVLu63x1gABD
         JqvNq0qDHLhUgTIRFZsPsehVw708nf5WKrAQfQg0DMeHpUIdI7nw+5kYzYIrfkJN2Win
         f9hWAeCaucDl9hIdAlgJZ8z3yJ1P8SGQFosU9M77HNm1cYsOiQJliquvNN7NST7gB/Og
         JF0g==
X-Gm-Message-State: AFuF++l6ukfKDeJ26q5sDUGOs3ucYMEkC/hv18Ifb8gFB7t4yVQ+gt/t
	ErxondOFZN4nTuqJuAC9VDCfKXOIP+IGmyjK8G5IuiqNYVxJM0ov80Olxv1Npm2p0OP3sZCZBMC
	7HLONxg==
X-Gm-Gg: AR+sD131jB9ckZYvnXTqB3qEFWuDHlJJieYoQZUsJAhD8wGMdpygELrX+0n+/NV1/Kx
	Ku60q15pRncFDQYx2mnc6CrajLWbP4VkYs2CBHjVVrQNKXmK1vUt+YEj3KLsyTNP/rehlY8L+x6
	X0iPkXvefXyGImhJbj5xjL4Srunroeff57DchBKPv9yszSq+uY/i/70jlXzA84X/zrh6Izhvjw4
	UuJKUCY+QQJNvTwFOUovgIN4CRuj5wGDcM4par7Tujh+WiYZcfusNEOXeypWSa9sHbKpres7ZOx
	75xNDwALBMwk6bK1vDM5Puj7Vf2JiFNWmwEXgjN4Orwn0N+fftCZcgcSj45DILpUPLeCGo2D9Ko
	QWtiIxXgzomXxozLoWvJ3a3lKA9KfYILydHpZfV1yzamMiQk3w/f3DrPCEb/7vY4cJXyf5QKAxp
	f+AWfEePV5f3b/Ai3OWkwdzgSq2lvPtHSznxzrqgmZ7clAfYkzQMetPHttzuB5VZIbfsyfzp7tU
	UmwfoRMZBqFx7stJVlF4pLYTjVyCz0vaXbhs7Xy+xjX9eD2WbJi6PI2do0x2rS284h6wV0g0BM5
	vMIBmWIreW3h2DUirDTdf+1cmjDZeCzdNMZ2Hg==
X-Received: by 2002:a05:620a:880f:b0:92e:bd39:9993 with SMTP id af79cd13be357-93913952c79mr1475368585a.31.1787991169629;
        Sat, 29 Aug 2026 01:12:49 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93917014c56sm325358385a.10.2026.08.29.01.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 01:12:48 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	vega@nebusec.ai,
	stable@vger.kernel.org,
	toke@redhat.com,
	chia-yu.chang@nokia-bell-labs.com,
	subramanian.vijay@gmail.com,
	petrm@nvidia.com
Subject: [PATCH net v2 4/8] net/sched: hhf: clamp quantum in change and init paths
Date: Sat, 29 Aug 2026 04:12:25 -0400
Message-Id: <20260829081229.81708-5-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260829081229.81708-1-jhs@mojatatu.com>
References: <all>
 <20260829081229.81708-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hhf_change() accepts any quantum from userspace, including 1. With a
crafted size table qdisc_pkt_len reaches ~2 GiB, so quantum=1 makes
the deficit-refill loop spin ~2^31 times under the qdisc lock
(a soft lockup / denial of service).

Add max(256U, ...) in hhf_change() matching fq_codel_change(). Clamp
hhf_init() to [256, 1<<20] matching the siblings, and remove the old
fallback that only set quantum=256 on overflow.

Conditions to recreate the bug:
  CONFIG_NET_SCH_HHF=y. Requires CAP_NET_ADMIN (namespace-local via
  unshare -Urn suffices).

  tc qdisc add dev dummy0 root hhf
  tc qdisc change dev dummy0 root hhf quantum 1 stab data 32768 size_log 15 cell_log 0

Fixes: 10239edf86f1 ("net-qdisc-hhf: Heavy-Hitter Filter (HHF) qdisc")
Reported-by: vega@nebusec.ai
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: stable@vger.kernel.org
---
 net/sched/sch_hhf.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index 96acab6a8da0..fc72f825fbd9 100644
--- a/net/sched/sch_hhf.c
+++ b/net/sched/sch_hhf.c
@@ -551,7 +551,7 @@ static int hhf_change(struct Qdisc *sch, struct nlattr *opt,
 		return err;
 
 	if (tb[TCA_HHF_QUANTUM])
-		new_quantum = nla_get_u32(tb[TCA_HHF_QUANTUM]);
+		new_quantum = max(256U, nla_get_u32(tb[TCA_HHF_QUANTUM]));
 
 	if (tb[TCA_HHF_NON_HH_WEIGHT])
 		new_hhf_non_hh_weight = nla_get_u32(tb[TCA_HHF_NON_HH_WEIGHT]);
@@ -613,7 +613,7 @@ static int hhf_init(struct Qdisc *sch, struct nlattr *opt,
 	int i;
 
 	sch->limit = 1000;
-	q->quantum = psched_mtu(qdisc_dev(sch));
+	q->quantum = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 256, 1 << 20);
 	get_random_bytes(&q->perturbation, sizeof(q->perturbation));
 	INIT_LIST_HEAD(&q->new_buckets);
 	INIT_LIST_HEAD(&q->old_buckets);
@@ -624,10 +624,6 @@ static int hhf_init(struct Qdisc *sch, struct nlattr *opt,
 	q->hhf_evict_timeout = HZ;      /* 1  sec */
 	q->hhf_non_hh_weight = 2;
 
-	if ((int)q->quantum <= 0 ||
-	    (u64)q->quantum * q->hhf_non_hh_weight > INT_MAX)
-		q->quantum = 256;
-
 	if (opt) {
 		int err = hhf_change(sch, opt, extack);
 
-- 
2.43.0

