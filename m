Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF65738D3E6
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 21:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788298789; cv=none; b=Vksm6UmEC5xGMeA8Mc4DBMnRPe2UIlbL9JqhDRZ3HTIFQAHc4p3bpYFuHaqVGEbIm887LluOLFQJow8cEEG/0nPTTpI5VCggV7o8GGhF8ojFC3RQVooV1nuLEjzBPinP75iRWxPMvqKzJshjOmMdH7hnUlezZqv5hrgZwhkzBw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788298789; c=relaxed/simple;
	bh=2ddqiTEDH4Ta1MooLBoc1WUptDiklqVuz8HBikj+VvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZzmIRNTM5BcZtQOOi1bPltTrziyPdFhrLZEhMClVBDjdRpGn8ags/Qaqgm8qhaq0f5tyAjnxEq/aLo+s3vmqMfhnFgeMjKjtfcFETwCIEG07SnXHsOsqxwMJPVHY8DqY4Gxl0mOagiAySDUMK7v9aikxYLVdshu7fA7VXrnfxzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=hqRm4edU; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="hqRm4edU"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-90cdffe8e3eso3467876d6.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 14:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788298786; x=1788903586; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7201ng31aKZQYzOiUDKw0qHurnoMGdllcWS6SyTHPr0=;
        b=hqRm4edUFhuEe/0kq6tDwa0VRtVDrshhsrzfBu6nug+C0aHWRgQzTL9UxJxnpG9iUn
         iij9T56BVHPJbpyXk1agKppfPGSkVO9ID6hlMpuQm7E849WFA3UTn3yhKRQGrCRMuftK
         x+rxG8+U/iP2XKdWf/eM0YoV2xMX6hVeRCEG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788298786; x=1788903586;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7201ng31aKZQYzOiUDKw0qHurnoMGdllcWS6SyTHPr0=;
        b=ombRTuzQWfQWnLkmiCqVgmnUanulsufso2Q8P6oGJRIf/KuJwk3ZdQzVjSs48uWJFI
         /7/rfB5Sko8TK8gsBhcJVI+KJqXrXsXNdAtoyEmKJY8LdyBjUFozJJExQXeXrAJ8ZN2m
         YepyofwKKQqtVjxAzMRevZuaO0QCBQxp1Efa0zcv+8DD00gt/A80i6y6XF5lOvJIbS/L
         ddMYT1Wxf5MWKpb+0yPS3xCZIBftuJmBQc6Uk5+NnC39SQdDXRJcpH9YMF8xctgLw5I7
         C4BgFl4dPE/ca2EjP5r5Y2WtH8qYNPIYPvt5EJocJPtBYsZi+IKjuUFxpgt3X7u1Y7u/
         cVBw==
X-Gm-Message-State: AFuF++k6EAjaomfUjxSFfa0kWK1iDZ2nk85o77aTJP/aeN2XqGoQO9cx
	nbK9YeCoD1Nlmfb2NKnfC8qt14WCtTKGtA9+FgUKpK4vLOnOdsKB7x5wJk85aKsWfp9pXUzt2T9
	ZD6aUWQ==
X-Gm-Gg: AYBFou1MpEA1INeOK6H3ld25nMTUJTUPK9GEn7bHLQ2GCGd4bBeR01hSh8fEFUwH0jF
	TK8pM6pKE9xWQO7qDeUUisx+5ZWVz3rCGXvax/q7UKeezMNDOQ8JXAhZSJeJIcoUmyiMtQoY4IF
	Krkps/7gj8+VEwSmS01OTwPxtq6iLq83zRNs1dI/nJaAs9IpU7sj/c0XKXas3FQxefjboA29x99
	maontmERJhov+4HeZE3cgvnAUEqxATEGl2gmkQV6Jc/TpcswtAG1QmAna7VCB6IpkSpl5plxe8M
	frMljjmrL6syFaPZ9HPiYbninFrkPKuZWUurig53Uk+FQEzp3LttByb9mA6S+7HDnEp+/pSGezv
	ZnCyxcYxnELU8ou+pAjltmw2uYLmTRD5HXdd9j0DLqq5H95o92IwgRAwoMWcilDXcJSpY6eEiLx
	nUvpDJIa2E9+wyitwebgt3LQfqr4YQpfLLhyCNF2AHQExJpwodQgbSwzFukcagP2rGca8KI4Izz
	nuZb2TptLvIXq19ewf8IHVpP3bdXaNN7DDcjQ==
X-Received: by 2002:a05:6214:2e47:b0:90c:e762:1f86 with SMTP id 6a1803df08f44-90ebabba9bamr10387966d6.30.1788298786590;
        Tue, 01 Sep 2026 14:39:46 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee08710sm3458426d6.2.2026.09.01.14.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 14:39:45 -0700 (PDT)
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
	Vega <vega@nebusec.ai>,
	stable@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Vijay Subramanian <subramanian.vijay@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net v3 1/9] net/sched: fq: clamp quantum and initial_quantum in change path
Date: Tue,  1 Sep 2026 17:39:22 -0400
Message-Id: <QDISC-0CFC.v3.20260901204856@mojatatu.com.2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-0CFC.v3.20260901204856@mojatatu.com>
References: <QDISC-0CFC.v3.20260901204856@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The fq change path accepts TCA_FQ_QUANTUM in [1, INT_MAX] and
TCA_FQ_INITIAL_QUANTUM up to INT_MAX, while fq_init() already clamps to
[1, 1<<20]. A user can override the init clamp via tc qdisc change,
restoring the small-quantum deficit spin that the init clamp prevents.

Narrow iq_range.max to 1<<20 so TCA_FQ_INITIAL_QUANTUM is rejected at
parse time. Clamp TCA_FQ_QUANTUM to [256, 1<<20] in fq_change() and
fq_init() quantum to [256, 1<<20] for tiny-MTU devices.

Conditions to recreate the bug:
  CONFIG_NET_SCH_FQ=y. Requires CAP_NET_ADMIN (namespace-local via
  unshare -Urn suffices).

  tc qdisc add dev dummy0 root fq
  tc qdisc change dev dummy0 root fq quantum 1 stab data 32768 size_log 15 cell_log 0

Fixes: 709f34f7c28d ("net/sched: fq: add overflow bounds to quantum and initial quantum")
Reported-by: Vega <vega@nebusec.ai>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_fq.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 6144b5686f13..35f940b2205d 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -980,7 +980,7 @@ static int fq_resize(struct Qdisc *sch, u32 log)
 }
 
 static const struct netlink_range_validation iq_range = {
-	.max = INT_MAX,
+	.max = 1 << 20,
 };
 
 static const struct nla_policy fq_policy[TCA_FQ_MAX + 1] = {
@@ -1106,14 +1106,10 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
 			   nla_get_u32(tb[TCA_FQ_FLOW_PLIMIT]));
 
 	if (tb[TCA_FQ_QUANTUM]) {
-		u32 quantum = nla_get_u32(tb[TCA_FQ_QUANTUM]);
+		u32 quantum = clamp_t(u32, nla_get_u32(tb[TCA_FQ_QUANTUM]),
+				     256, 1 << 20);
 
-		if (quantum > 0 && quantum <= (1 << 20)) {
-			WRITE_ONCE(q->quantum, quantum);
-		} else {
-			NL_SET_ERR_MSG_MOD(extack, "invalid quantum");
-			err = -EINVAL;
-		}
+		WRITE_ONCE(q->quantum, quantum);
 	}
 
 	if (tb[TCA_FQ_INITIAL_QUANTUM])
@@ -1232,7 +1228,7 @@ static int fq_init(struct Qdisc *sch, struct nlattr *opt,
 	sch->limit		= 10000;
 	q->flow_plimit		= 100;
 	mtu = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
-	q->quantum		= min_t(u32, 2 * mtu, 1 << 20);
+	q->quantum		= clamp_t(u32, 2 * mtu, 256, 1 << 20);
 	q->initial_quantum	= min_t(u32, 10 * mtu, 1 << 20);
 	q->flow_refill_delay	= msecs_to_jiffies(40);
 	q->flow_max_rate	= ~0UL;
-- 
2.43.0

