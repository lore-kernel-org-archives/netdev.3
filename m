Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334196;
	b=jUttX+jfHvZC7IwKM0On1O9X2uVjkttCsjl6LpsOP+xVmRyHs9ZRmKyyrijD+ip5KaQG
	 B1U5RSrv+qENMVjQha9w9mMIcHlQcQxxtKDnkiUSC9RQdfkF4FisDuXzkgoIk8MBoNat2
	 +S+PvvoPE6BwBg6sG65WWRkXDClHQXa0eiRMAU9/FV9OqoldoJ75VfC6mUQq1IH+d8yed
	 e0cmtwAQgDC3QyXhCTG/htsUlILv0gNjeXvIUs7lX/pFNmaDGcz4aYbdg2hUFz+HV+U59
	 EybtYkulUFJ1q+i5xk72QLbGxcVPRJueDkR4N/5DyXWOBPG65rZIOn0tb/ad+i+KsFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334196;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=k74rtqmStg38qqnyyU9KS/WFF7ITGPYf/taRwsmuKoU=;
	b=c3pvRgHBkXz5vhRddlbhHoN9D0J2j9QFfN0tblhVEIQQ/YAhnxa8x8jZAZNWfRkghMCG
	 usj+sm7714BuZrYkX5RNdUCWx3D61Ze1dUA6tIdMP0hpwdX8+S0cMjbAP13T8bDKOD1t3
	 MGW+ec8seoTOToTHEEtWDE60rDXodAi7AxbEUbypTj5ZqPHDUSkfiwXw/U+GgzRpqWr+5
	 bDUtdEX/ZFHGOD/MdhZtk54a8RTbEMw4ab82uXHVdFFcxX4SMIKlzx/7BrSzPRbFf1ZIf
	 4TgzGUzriUr8Fx0hOx0ihc9izakBrKREojD+G+TD/tt5tqWkIjid3GoR9TC86/tD5Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=LVCKgYcy;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42F7606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 04:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D42F7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=LVCKgYcy
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7f48c750afcso241571a34.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793334195; x=1793938995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k74rtqmStg38qqnyyU9KS/WFF7ITGPYf/taRwsmuKoU=;
        b=LVCKgYcyokkMhxVeJb2MI/Xsa/p8HwrQVBp2fMPOMyT0sJzlKMXp/KCeuTMtiScOCx
         otCIk9VAS+dAtwIvPzPJIsQFzmWtQzvEZkESJ0lX9f/ed9tz260zkEUSwy+lT5J0vHsg
         S/eMvI2LIyBvMvXoX09+vPXv0EDecTKbRYfVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334195; x=1793938995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k74rtqmStg38qqnyyU9KS/WFF7ITGPYf/taRwsmuKoU=;
        b=vVGCUoUq4OgyKgzzRt2sfZWGXhEL2rmjUOHu4MGb+yI/IKANuay/eWNwY5PWXgKfp/
         zmEQIGh7Ru1MKG+bfKgE7GtWIwv1poDaU7UZskDa4pminiL0ZLdqwt0hKKIvCgiuRaHt
         2UPOTGKaXR6y9FzYlCnLuYyOLO4m6jgkeeIow3LcKrVheRehlMdtydZaT24q3aRkDvOQ
         BIMxknBAW8uldB+0bZxCJ7Z7oViptFTlykBWtifYyC2ldQZJdsL3dDukncuqJFMtmV3m
         sMSDQEtj09rVfQG1Vh3X+9yM06MFo3IzNbNwiC9Rup2XlL08Y0w3qHHuzHxOrHqYKQi2
         SDvg==
X-Gm-Message-State: AFq9FYK7pMlcbbPwVcYzkupfH4rgkOl2gEEw3xbvfWx4N2vWzCOcCjGP
	mIZHEtNtN7uMY5bxSbdRgslyJ1gr0xBpq0Nm329QfVQy9oHSsUpmkwqqRMMil4GSRVvtMdfGqoT
	Wgb7l9XI=
X-Gm-Gg: AYBFou39fR/NNNZR48owGM8TVctqoDOOyoDJgQt7ol8rLzv6KUw4Sq/Jn4YbOmcTi+r
	TuwaH2Y3kcWGnj/AZapPfjA2D6yIN9lAfVIIz5qM6ViIoLn/sKjd5+GWLiJ84/rEDBg9ceg8UVr
	rFmeBjMxP/IEyj5mE8JBDh40pWEodlZ+yGRRXs052bzB3q+eQkB+on28/JoW3IiASVluVBBOsOK
	H6k0QzyLAbWDVFUDlR5GBEad2VyfN76cixlmcyo56fUOAftD9T7CGVfloi3fzeiCvEUKAFRYWNr
	Ri8I2mdlO83J7Ykpl1nBgSpA//uAa9OhTeMcxxD7+oBJ5WMdMD97cvq7tymCGUUA9kxunPLJsW+
	ti/Vmti4eI5LeCuPFVwtgPeqnG0ILOgwGAp1JzUPcRD/ruWm1YHJ+ZhhRxp95BcDIETxVvtdI5E
	knbEZxBd2cJRYcqNckDGWeKt5ArkVCErIZgyNxWv1jT5UwWeldm2xC8G/JwodJHXKhCCC1MPL1s
	xwIpPRF17UVfy/014p/TCAR1CEIwtUoMeKUo2PXcrs0JO6ecRVh9l+V+qGReG06PV9SiEc92rOg
	qit9GPbv5/uJWmmSKSPoWoHSVRisQ1jYA8szKCr/h81x5+dcXifQB2XW2y9KAfppBCGYEmOAOFH
	uBnA78Sl40lM2vGeKLuRID+KhTCIfWQ==
X-Received: by 2002:a05:6830:3e03:b0:821:cee2:489e with SMTP id 46e09a7af769-85d3616574amr999969a34.2.1793334194805;
        Thu, 29 Oct 2026 21:23:14 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d351e77c8sm1161952a34.2.2026.10.29.21.23.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 21:23:14 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	linux-kernel@vger.kernel.org,
	outbounddisclosures@openai.com
Subject: [PATCH] net/sched: revalidate the sleeping-root lock in timers
Date: Thu, 29 Oct 2026 21:23:12 -0700
Message-ID: <20261030042312.74363-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
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

Autonomous qdisc timers select their lock through qdisc_sleeping.
dev_graft_qdisc() changes that pointer while holding the previous root's
lock, but a timer may have read the old pointer before the graft and only
acquire its lock afterwards. RCU keeps the old qdisc alive; it does not
make that lock protect the replacement hierarchy.

For example, a backlogged MQ child retained by an outstanding filter
request can be detached and regrafted at the same parent. An SFQ timer
that selected the interim root can then rehash its queues under that
obsolete lock while tbf_graft() resets the SFQ under the current root's
lock. This corrupts skb lists and SFQ slot state.

Add an RCU-side helper which acquires the sleeping-root lock, checks
that the root is still current, and retries if it changed. Once the
check succeeds, dev_graft_qdisc() cannot replace the root until the
callback releases its lock. Use it in the SFQ, RED, PIE, FQ-PIE and
DualPI2 timers.

Route default-qdisc attachment and scheduler shutdown through
dev_graft_qdisc() as well, so live sleeping-root publications follow
the same locking protocol.

Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
I have a reproducer for this issue and can share via DM

 include/net/sch_generic.h | 20 ++++++++++++++++++++
 net/sched/sch_dualpi2.c   |  3 +--
 net/sched/sch_fq_pie.c    |  3 +--
 net/sched/sch_generic.c   |  5 +++--
 net/sched/sch_pie.c       |  3 +--
 net/sched/sch_red.c       |  3 +--
 net/sched/sch_sfq.c       |  3 +--
 7 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 1acaadb3e2cf..e234256e6ae8 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -608,6 +608,26 @@ static inline spinlock_t *qdisc_root_sleeping_lock(const struct Qdisc *qdisc)
 	return qdisc_lock(root);
 }
 
+/* The caller must hold rcu_read_lock().  dev_graft_qdisc() changes the
+ * sleeping root under the old root's lock, so retry if it changed while
+ * we were waiting for that lock.
+ */
+static inline spinlock_t *qdisc_lock_root_sleeping(const struct Qdisc *qdisc)
+{
+	struct Qdisc *root;
+	/* Lock of the sleeping root observed under RCU. */
+	spinlock_t *lock;
+
+	for (;;) {
+		root = qdisc_root_sleeping(qdisc);
+		lock = qdisc_lock(root);
+		spin_lock(lock);
+		if (root == qdisc_root_sleeping(qdisc))
+			return lock;
+		spin_unlock(lock);
+	}
+}
+
 static inline struct net_device *qdisc_dev(const struct Qdisc *qdisc)
 {
 	return qdisc->dev_queue->dev;
diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 4947def7c49e..8a74ceaab29d 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -750,8 +750,7 @@ static enum hrtimer_restart dualpi2_timer(struct hrtimer *timer)
 	spinlock_t *root_lock; /* to lock qdisc for probability calculations */
 
 	rcu_read_lock();
-	root_lock = qdisc_lock(qdisc_root_sleeping(sch));
-	spin_lock(root_lock);
+	root_lock = qdisc_lock_root_sleeping(sch);
 
 	WRITE_ONCE(q->pi2_prob, calculate_probability(sch));
 	hrtimer_set_expires(&q->pi2_timer, next_pi2_timeout(q));
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 5982847df8f8..a1b5126db640 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -394,8 +394,7 @@ static void fq_pie_timer(struct timer_list *t)
 	int max_cnt, i;
 
 	rcu_read_lock();
-	root_lock = qdisc_lock(qdisc_root_sleeping(sch));
-	spin_lock(root_lock);
+	root_lock = qdisc_lock_root_sleeping(sch);
 
 	/* Limit this expensive loop to 2048 flows per round. */
 	max_cnt = min_t(int, q->flows_cnt - q->flows_cursor, 2048);
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 3e8ee4a691c3..f4ec712be18b 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1182,6 +1182,7 @@ struct Qdisc *dev_graft_qdisc(struct netdev_queue *dev_queue,
 	struct Qdisc *oqdisc = rtnl_dereference(dev_queue->qdisc_sleeping);
 	spinlock_t *root_lock;
 
+	/* Pairs with qdisc_lock_root_sleeping() in asynchronous callbacks. */
 	root_lock = qdisc_lock(oqdisc);
 	spin_lock_bh(root_lock);
 
@@ -1205,8 +1206,8 @@ static void shutdown_scheduler_queue(struct net_device *dev,
 	struct Qdisc *qdisc_default = _qdisc_default;
 
 	if (qdisc) {
+		qdisc = dev_graft_qdisc(dev_queue, qdisc_default);
 		rcu_assign_pointer(dev_queue->qdisc, qdisc_default);
-		rcu_assign_pointer(dev_queue->qdisc_sleeping, qdisc_default);
 
 		qdisc_put(qdisc);
 	}
@@ -1230,7 +1231,7 @@ static void attach_one_default_qdisc(struct net_device *dev,
 
 	if (!netif_is_multiqueue(dev))
 		qdisc->flags |= TCQ_F_ONETXQUEUE | TCQ_F_NOPARENT;
-	rcu_assign_pointer(dev_queue->qdisc_sleeping, qdisc);
+	dev_graft_qdisc(dev_queue, qdisc);
 }
 
 static void attach_default_qdiscs(struct net_device *dev)
diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index 3b7863ffd284..9367065db4b1 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -429,8 +429,7 @@ static void pie_timer(struct timer_list *t)
 	spinlock_t *root_lock;
 
 	rcu_read_lock();
-	root_lock = qdisc_lock(qdisc_root_sleeping(sch));
-	spin_lock(root_lock);
+	root_lock = qdisc_lock_root_sleeping(sch);
 	pie_calculate_probability(&q->params, &q->vars, sch->qstats.backlog);
 
 	/* reset the timer to fire after 'tupdate'. tupdate is in jiffies. */
diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index d7598214270b..a7601b879092 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -333,8 +333,7 @@ static inline void red_adaptative_timer(struct timer_list *t)
 	spinlock_t *root_lock;
 
 	rcu_read_lock();
-	root_lock = qdisc_lock(qdisc_root_sleeping(sch));
-	spin_lock(root_lock);
+	root_lock = qdisc_lock_root_sleeping(sch);
 	red_adaptative_algo(&q->parms, &q->vars);
 	mod_timer(&q->adapt_timer, jiffies + HZ/2);
 	spin_unlock(root_lock);
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 8bbcfc9e85d9..2bd3fc65053a 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -611,8 +611,7 @@ static void sfq_perturbation(struct timer_list *t)
 
 	get_random_bytes(&nkey, sizeof(nkey));
 	rcu_read_lock();
-	root_lock = qdisc_lock(qdisc_root_sleeping(sch));
-	spin_lock(root_lock);
+	root_lock = qdisc_lock_root_sleeping(sch);
 	q->perturbation = nkey;
 	if (!q->filter_list && q->tail)
 		sfq_rehash(sch);

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.56.0
