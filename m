Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.60.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793828781;
	b=hIporwLLrNvw/3/qgBAcLiT04CiDtoGXb1nO2oSk0fXmzHnjpdOilrJo3ane0QAJYtxB
	 ZNLgXMAPjfbW+vCeUzPnxEMWpRdbOHukNWmvHu/Ay0b8YQaVfZfOiOgTmjoJXb67myo1Z
	 1g4RlfQGvpCbQkQ30i/DItTndUSQG7VFjPrvbneqfLl9cmYw3JZ+OtJbAHJHq3Fxf4WCv
	 Iv0eCFwcG/22S4CHd0/lNGfcvYhm49lKateYwsTt7oy0l7/iIQkafzJOPacV+Cwg2vrHf
	 VgpCfNu/SInHqaVKbAN4godZ5ul37tYA97MZ1MHU/NWzg0Q/B8AYpTCYRIn9ZA/vH8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793828781;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RTziZNdTshu8mr9IgxCRzQVNRcfcIYFxAuEoFWGnD+0=;
	b=nDKoh77ErAzBf8cvkf5J5cg3+KeZSAzugtG6iRy0lcZJ5Z8SiBehHfUzExyVpATT9bK4
	 sBPV1QBlc9ocoVTL9x7bp2KebajvZQrlk0UmpbsR4CnH96uTeRW0Jy+O5CD59YvTZ+XdY
	 1yHSVYYd5NROF9eHRGx33QaRHquQdiBFok8//PW78ybKY5aPh0F2bLlQ5Mm3UsdfmDgu5
	 c/YYcwW/d+Y7tFbRw4+f39rMiqVUHVnKr+aUVJdnDPB8Q20v+vDdpPr3GOBauNoIKIDOF
	 MlePxM44lzw2dop7m6B0L065qd2WHQsUkCYeotAMbTe6qOGqsqnukrMEkCgxtHNNNAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=corp.free.fr;
	spf=pass smtp.mailfrom=corp.free.fr;
	dkim=pass header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=pkiIkJK2;
	arc=none smtp.remote-ip=212.27.60.169
Received: from rcs.proxad.net (rcs.proxad.net [212.27.60.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E7E606F282
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 21:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23E7E606F282
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=pkiIkJK2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=corp.free.fr; s=rcs;
	t=1793828777; bh=kdxP7VYI9vMJcEC+R5fDK9cpA1cV+nrarMTELy30Vco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pkiIkJK2gXofnVLyoXPXtYEx62n+q/S//ibFT6yjIv6J0pOQaIB5nbnWTGmQtNuZV
	 8GRq1Vk5nLQb+/3YeWMkf0Syp7HWji+qoDAFa3zWg7z/Hw4LWurnslqO/QfANyL4OO
	 jH9Kqu08+2vG82wXvf1hwYs7nlpXvCJpUexYCDcUYyFTNHTLjh/DKyS/3Wf3L/N6BM
	 bs5hw1NpfJIck2bNPhFvDD+FEmv3Hk2Shl7+U+T1Mkvsadu/k8bxQajxXe3VJxJelj
	 1B70SmTF6bIqOfFBmrCGzCkn6T8t7hXoC2Sj4kuTARoV6NrYkcdGROg5j2ZCtBWzT5
	 6ymU+bWr7BS4w==
Received: from lnxos-dev.home (82-66-150-212.subs.proxad.net [82.66.150.212])
	by rcs.proxad.net (Postfix) with ESMTPSA id 3D84A44C0479;
	Wed,  4 Nov 2026 22:46:17 +0100 (CET)
From: Alexandre Cassen <acassen@corp.free.fr>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 1/3] net/sched: honor TCA_ACT_FLAGS_NO_PERCPU_STATS in more actions
Date: Wed,  4 Nov 2026 22:45:55 +0100
Message-ID: <20261104214607.556269-2-acassen@corp.free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104214607.556269-1-acassen@corp.free.fr>
References: <20261104214607.556269-1-acassen@corp.free.fr>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skbedit, police, mpls and sample store and dump
TCA_ACT_FLAGS_NO_PERCPU_STATS since commit 40bd094d65fc ("flow_offload:
fill flags to action structure"), but still allocate per CPU stats.
These take about 6.5 KB per action on a 128 CPU host.

Honor the flag as the other offloadable actions already do. For example,
a per subscriber policer offloaded to hardware:

  tc filter add dev $DEV ingress protocol ip flower skip_sw \
     dst_ip 10.0.0.1/32 \
     action police index 1 rate 1mbit burst 10k \
     conform-exceed drop/pipe no_percpu

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Alexandre Cassen <acassen@corp.free.fr>
---
 net/sched/act_mpls.c    |  8 ++++----
 net/sched/act_police.c  | 10 +++++-----
 net/sched/act_sample.c  |  6 +++---
 net/sched/act_skbedit.c |  9 +++++----
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
index aa56521b7179..a870386386d9 100644
--- a/net/sched/act_mpls.c
+++ b/net/sched/act_mpls.c
@@ -60,7 +60,7 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct sk_buff *skb,
 	int mac_len;
 
 	tcf_lastuse_update(&m->tcf_tm);
-	bstats_update(this_cpu_ptr(m->common.cpu_bstats), skb);
+	tcf_action_update_bstats(&m->common, skb);
 
 	/* Ensure 'data' points at mac_header prior calling mpls manipulating
 	 * functions.
@@ -123,7 +123,7 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct sk_buff *skb,
 	return p->action;
 
 drop:
-	qstats_cpu_drop_inc(m->common.cpu_qstats);
+	tcf_action_inc_drop_qstats(&m->common);
 	return TC_ACT_SHOT;
 }
 
@@ -196,8 +196,8 @@ static int tcf_mpls_init(struct net *net, struct nlattr *nla,
 		return ACT_P_BOUND;
 
 	if (!exists) {
-		ret = tcf_idr_create(tn, index, est, a, &act_mpls_ops, bind,
-				     true, flags);
+		ret = tcf_idr_create_from_flags(tn, index, est, a,
+						&act_mpls_ops, bind, flags);
 		if (ret) {
 			tcf_idr_cleanup(tn, index);
 			return ret;
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index 3f8147f37549..0b0c09e3dfd9 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -80,8 +80,8 @@ static int tcf_police_init(struct net *net, struct nlattr *nla,
 		return ACT_P_BOUND;
 
 	if (!exists) {
-		ret = tcf_idr_create(tn, index, NULL, a,
-				     &act_police_ops, bind, true, flags);
+		ret = tcf_idr_create_from_flags(tn, index, NULL, a,
+						&act_police_ops, bind, flags);
 		if (ret) {
 			tcf_idr_cleanup(tn, index);
 			return ret;
@@ -259,7 +259,7 @@ TC_INDIRECT_SCOPE int tcf_police_act(struct sk_buff *skb,
 	int ret;
 
 	tcf_lastuse_update(&police->tcf_tm);
-	bstats_update(this_cpu_ptr(police->common.cpu_bstats), skb);
+	tcf_action_update_bstats(&police->common, skb);
 
 	p = rcu_dereference_bh(police->params);
 	ret = p->action;
@@ -313,10 +313,10 @@ TC_INDIRECT_SCOPE int tcf_police_act(struct sk_buff *skb,
 	}
 
 inc_overlimits:
-	qstats_cpu_overlimit_inc(police->common.cpu_qstats);
+	tcf_action_inc_overlimit_qstats(&police->common);
 inc_drops:
 	if (ret == TC_ACT_SHOT)
-		qstats_cpu_drop_inc(police->common.cpu_qstats);
+		tcf_action_inc_drop_qstats(&police->common);
 end:
 	return ret;
 }
diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
index 44319a159b55..3029e93c4dea 100644
--- a/net/sched/act_sample.c
+++ b/net/sched/act_sample.c
@@ -69,8 +69,8 @@ static int tcf_sample_init(struct net *net, struct nlattr *nla,
 		return ACT_P_BOUND;
 
 	if (!exists) {
-		ret = tcf_idr_create(tn, index, est, a,
-				     &act_sample_ops, bind, true, flags);
+		ret = tcf_idr_create_from_flags(tn, index, est, a,
+						&act_sample_ops, bind, flags);
 		if (ret) {
 			tcf_idr_cleanup(tn, index);
 			return ret;
@@ -173,7 +173,7 @@ TC_INDIRECT_SCOPE int tcf_sample_act(struct sk_buff *skb,
 	int retval;
 
 	tcf_lastuse_update(&s->tcf_tm);
-	bstats_update(this_cpu_ptr(s->common.cpu_bstats), skb);
+	tcf_action_update_bstats(&s->common, skb);
 	retval = READ_ONCE(s->tcf_action);
 
 	psample_group = rcu_dereference_bh(s->psample_group);
diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
index 26258b353cde..1f958b7d2a60 100644
--- a/net/sched/act_skbedit.c
+++ b/net/sched/act_skbedit.c
@@ -45,7 +45,7 @@ TC_INDIRECT_SCOPE int tcf_skbedit_act(struct sk_buff *skb,
 	struct tcf_skbedit_params *params;
 
 	tcf_lastuse_update(&d->tcf_tm);
-	bstats_update(this_cpu_ptr(d->common.cpu_bstats), skb);
+	tcf_action_update_bstats(&d->common, skb);
 
 	params = rcu_dereference_bh(d->params);
 
@@ -85,7 +85,7 @@ TC_INDIRECT_SCOPE int tcf_skbedit_act(struct sk_buff *skb,
 	return params->action;
 
 err:
-	qstats_cpu_drop_inc(d->common.cpu_qstats);
+	tcf_action_inc_drop_qstats(&d->common);
 	return TC_ACT_SHOT;
 }
 
@@ -221,8 +221,9 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
 	}
 
 	if (!exists) {
-		ret = tcf_idr_create(tn, index, est, a,
-				     &act_skbedit_ops, bind, true, act_flags);
+		ret = tcf_idr_create_from_flags(tn, index, est, a,
+						&act_skbedit_ops, bind,
+						act_flags);
 		if (ret) {
 			tcf_idr_cleanup(tn, index);
 			return ret;
-- 
2.43.0

