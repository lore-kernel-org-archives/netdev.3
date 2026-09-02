Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24614A5EBB
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364390; cv=none; b=rsuy9xLDinmKd1VViuDT2MmcbluXhmZYDrg2JIg2Vu0dgREKgRER3Jig/ZSfjWXSZv9eqeQ/pY2kxJF6afNLCcdwnTlUwpEDba5NV3GLGuQDA+k7v4/uDQnX+rmyUYDCzJRSe9neUo7BazKCEDl/2XRMyItKYfI+84SaYYwGusg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364390; c=relaxed/simple;
	bh=niWMNYAoSSIPRDvcwTx/WASXtbc4shJCv6p3XnfHClk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISUutQp2W74qOvnm83bjAbxKIzz6KXQKCtT7zqSqaKcPPI5weeEnjiaUvrWXIR3GZsRffposPd9yg8QGePlEZEldWuzfAGbI5J4z/ofhI6Ffi9ctiqK0DhjLunagFcnf/W13eDC93uxdW0HxRzqa7JU0pMZaFmlNxv33CDlCI0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AB+4avu3; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AB+4avu3"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-39266382df6so1128832a91.3
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 08:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788364388; x=1788969188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W2B03qGyBn5GerSLqkqb+n8I5hTh+M7uQWiMJp/J/sk=;
        b=AB+4avu3ojciQkGP1jm4IPbiF7u7thpWV0iQT/io8WfIjmunrgMiusMMIvF4XPjQwt
         AeqTRG7W+FGAl5r+MQrV5T+VszN1u3/nn5B+PVQcVDgrJ0cPzDbXpZWIwqLCj0o6CV4t
         LJuZ6DS4OJhNveKYQv2Pzf2jQsqpnRS/yjJJHXPsKuO1XSYWat2z+ipK1lfXIFRB6eE3
         WM7FvxuLp5iIW4HcD5StErdYMA6ZRZfrdxgFamgi7613oP4e5YlXZht1OwQHKNS3vozr
         Jfwtc1Skeq4FXhXyuMs/7d2FFkZKOfV8PKpXNVZAjTMAhsFkIuz/CQt/k6wJcH48iH6o
         FdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788364388; x=1788969188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W2B03qGyBn5GerSLqkqb+n8I5hTh+M7uQWiMJp/J/sk=;
        b=j2vxtTdu2WY8IfmYk4p/DzVsNvx69NsPKmNQ7x+/jy/kz1FpM+TOTcOntIUNJ4Rr+N
         WY62rwIjOc2yPYL6xyl+Av17tt5aaFnWJvhejdCrKSxTiDxwsilYzq0aqe68uf9InrfU
         NR713DrZ2c0sEaCpquDz22HIlgvcQk4n0McOJTu9YhASE3mzYAP7dRFgY+fRjndM1fQ7
         f4BD4q7WvErBOgs2SBryWFde0oe5crbiMPftKEmvkUW0biUdYwokMiAMpCj4/8e4sPR5
         Ghi9NpiM1ns2tV2Wzr63lrvn7eFXWSgY9gY/WBBFRnyRkqZDdPLMRI3n9s7Z/aua6p8f
         ZHdA==
X-Gm-Message-State: AFuF++lO057QCPG18CVEnY7EJxc+NADStCNQI0rbl2dLfkcP6ixK7l6M
	u1c9ESFQVeUZaQT1F3i3LVxc6udlJG2KNAn9368wx6eIQNwBReQY2Ro1
X-Gm-Gg: AYBFou1Jy2KZee7ZyI0mOqRp81+wCgP1P9Q72vWg7X4NPRhSdm5J8NoDZ5hqm1ASSIC
	7B1CEc0jBfY7h1uAPIMskluMXu5NdWsefipOTTy72+4gcvf1l4as58hIc3Ex2e76cB4p1QP/dF7
	qjwWPU6g1Vl1ILOBm2jVB257ot6N4UTQXBeia6mFbKi25Dg/Ci+mhKDcCk0m3JPRAxwqhshwPwJ
	pvXFSFLLP1jJ9C+S4pvDd5Z4X1cPW2On7b+jb6KuGitW8PQbxpGZ7pEnufI52O7J8CMUwN3cSeA
	QHoVZn5GfNFGjvCE2zPq23AuS1Xl6B3lAn3iSM+b70mgX/EU7EnyqJqIaY6neithQxtlox9qvVr
	LX8NZa2mwzBn+lsyGWEuXYs79K+RdCZd+aB7d25uQo7GBXlhe4UIuDtAHpe3MdpH6F8GzzENLTU
	1U6HSfTDjJXhLepix6mFpzfBVK9tgi03EYsMUCCebEuZ+9ESaaypNzjH3SSf+PcUKjJDqlk1l4z
	IGTRnb+E3OEWFRL0RVh
X-Received: by 2002:a17:90b:35c8:b0:393:194d:5366 with SMTP id 98e67ed59e1d1-39aedf43130mr8854636a91.10.1788364387970;
        Wed, 02 Sep 2026 08:53:07 -0700 (PDT)
Received: from 192.168.50.3 ([183.193.115.0])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-39ae8f1448esm1683187a91.4.2026.09.02.08.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:53:07 -0700 (PDT)
Sender: Weiming Shi <thebestswings@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Ahern <dsahern@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v2 1/1] net/sched: defer qdisc freeing after failed creation
Date: Wed,  2 Sep 2026 23:52:31 +0800
Message-ID: <20260902155231.2149915-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902155231.2149915-1-bestswngs@gmail.com>
References: <20260902155231.2149915-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An RTM_NEWQDISC request can make clsact bind a populated shared ingress
block during ->init(), publishing an embedded mini_Qdisc to lockless
readers.  If the same request has an invalid TCA_RATE, estimator setup
fails after ->init(); the unwind removes the pointer but synchronously
frees its containing qdisc while tc_run() may still hold it.

Retire failed qdiscs through the same RCU helper as normal destruction.
Inline the synchronous free into the callback now that no direct callers
remain.

Fixes: 51ab2994c387 ("net: sched: allow ingress and clsact qdiscs to share filter blocks")
Reported-by: Xiang Mei <xmei5@asu.edu>
Link: https://lore.kernel.org/netdev/20260805102505.740806-1-david.lee@trailofbits.com/
Assisted-by: OpenAI-Codex:gpt-5.6
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
Changes in v2:
- inline qdisc_free() into qdisc_free_cb()
- use qdisc_free_rcu() for normal and failed-construction teardown
- use the precise 51ab2994c387 Fixes tag requested on the v1 thread
- credit the earlier security-list reporter and link the public v1

 include/net/sch_generic.h |  2 +-
 net/sched/sch_api.c       |  2 +-
 net/sched/sch_generic.c   | 20 ++++++++++----------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index cbc248776511..f35bd06a6bad 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -793,7 +793,7 @@ void qdisc_offload_query_caps(struct net_device *dev,
 struct Qdisc *qdisc_alloc(struct netdev_queue *dev_queue,
 			  const struct Qdisc_ops *ops,
 			  struct netlink_ext_ack *extack);
-void qdisc_free(struct Qdisc *qdisc);
+void qdisc_free_rcu(struct Qdisc *qdisc);
 struct Qdisc *qdisc_create_dflt(struct netdev_queue *dev_queue,
 				const struct Qdisc_ops *ops, u32 parentid,
 				struct netlink_ext_ack *extack);
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 65b35528d125..795accd1bb33 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1382,7 +1382,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 err_out3:
 	qdisc_lock_uninit(sch, ops);
 	netdev_put(dev, &sch->dev_tracker);
-	qdisc_free(sch);
+	qdisc_free_rcu(sch);
 err_out2:
 	bpf_module_put(ops, ops->owner);
 err_out:
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index ef2b4bf51564..71630b795f9d 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1086,21 +1086,21 @@ void qdisc_reset(struct Qdisc *qdisc)
 }
 EXPORT_SYMBOL(qdisc_reset);
 
-void qdisc_free(struct Qdisc *qdisc)
+static void qdisc_free_cb(struct rcu_head *head)
 {
-	if (qdisc_is_percpu_stats(qdisc)) {
-		free_percpu(qdisc->cpu_bstats);
-		free_percpu(qdisc->cpu_qstats);
+	struct Qdisc *q = container_of(head, struct Qdisc, rcu);
+
+	if (qdisc_is_percpu_stats(q)) {
+		free_percpu(q->cpu_bstats);
+		free_percpu(q->cpu_qstats);
 	}
 
-	kfree(qdisc);
+	kfree(q);
 }
 
-static void qdisc_free_cb(struct rcu_head *head)
+void qdisc_free_rcu(struct Qdisc *qdisc)
 {
-	struct Qdisc *q = container_of(head, struct Qdisc, rcu);
-
-	qdisc_free(q);
+	call_rcu(&qdisc->rcu, qdisc_free_cb);
 }
 
 static void __qdisc_destroy(struct Qdisc *qdisc)
@@ -1127,7 +1127,7 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
 
 	trace_qdisc_destroy(qdisc);
 
-	call_rcu(&qdisc->rcu, qdisc_free_cb);
+	qdisc_free_rcu(qdisc);
 }
 
 void qdisc_destroy(struct Qdisc *qdisc)
-- 
2.55.0

