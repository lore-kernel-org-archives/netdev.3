Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C6B3DD50F
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506737; cv=none; b=VouIKyXInP/Vvgzxtv59dwnd9nTdY3zjvmwM2ISXcSER/ZcACF6YHtK003Yvqa0zmTZexc4S0s3ySSUZiBNPobjyK8CHRWl4FK8VCAJSQCCnTVomTnJVvvlqOj8nfKObgl2kzykxfwSvRPcjoq0RW3kd0JS2f3Dt2VzYZpNMb5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506737; c=relaxed/simple;
	bh=WFThtS01zuWi9Z/ZY42l8xKEAvRkhPojWTIq0tlSJtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oxygFjYSxKMGWRcIB9XnbPTsO3O+CDS7CbitUzh03W22rlkdyxw5jopfOoK9OofJlROkMHxvIVr/O4npFvtqZiegunqcP1hpCJD5LNdWKll8XOVIoxeEBl91tIFkkT3UiyTcUT260yW5q1TSalzwKguDPX0SpKC4Jj9Q1uhwctg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=TX6n7CEZ; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="TX6n7CEZ"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e6391b114so74965885a.3
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 07:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1785506735; x=1786111535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=76hei+yKv+rozwlkxCZSaL8AFRKjftE/3gkCFmdDrGk=;
        b=TX6n7CEZy+PioxHxRxOtkeX4I9pT8UOtYDTX9DP2ReV4WPwWtqQmvvDuSycbvKfS8o
         2JvRvbrpmiz+Go83gdSQEZ58TsV5t1QL9k5eY2YJkBFiNaomvesgOh/as5MXiv0UxeSv
         ZCJSMCo9zVsUOKV5oJVVoGtSIWk6QV5/n17/kOd9oqkltupK50T0ND8AO3GoFVQjQtLb
         MtAHP0DpU6yRuax9+lUx01xrPIIDf0GhQjZojXz79gqr576PmUx445FqXlV5EVWRFYJA
         C0lwb5+Kb4mnqMn4W15c9OyKoHAc+h+5Zl7ibcXidm671K16TzxgJB23PtJIYLI2sLhh
         xOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785506735; x=1786111535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=76hei+yKv+rozwlkxCZSaL8AFRKjftE/3gkCFmdDrGk=;
        b=KCAe+gGBHEZHebq7KV8LTKf+mvtcy5xJavUk2ZYxopgDhdnBRxaQXH+5dHWUtYZu8A
         46sW+sAMBIx7q4Xsz7CBs/xQlTcpaeklLVq3WLuFthNi63TzDBvkjufCpFR00xLEUaDZ
         /AVxr3Y8bhGqkjJFBRWmn2DDJ2Y4fsitN9+2a5HUZc7IRgBOnCr5e9dmRZtFBKSOZ/6G
         HMF6OupUhhqXHkV0kA824z6ddY7hypbYQ03jy8ogqRogTGNWjUhzz1qYrOLQozFVeqSP
         3MFoUi1h3O+9wAruIZDYcr4WpCOK3AFn48essvYDEe94777SVZ0fYsn7Q6GkM+9atzBA
         4wbA==
X-Forwarded-Encrypted: i=1; AHgh+Rp0FZNZYTXW8azmkLsls449WWWWvdSdjFKePI8q9uCuzXBDZNdDVb3/HgbRO5sal8cFKTaXCf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKQSrnlFnn3gvh2voGbpjY9UCavxpNTNY+gOB+DgedSDx3JnUC
	OpHgTyfcicyieIhwqObD8hWuzXivOopdKWJyGKbgSwOq/k0Supasn2TsXofxMWtsirE=
X-Gm-Gg: AR+sD10Pwt/DRMGbiYzoZIdoB+Y9UCj3waFjmvIxPI5fEZcMVZCA/ZkwtDxuws+T56p
	uwd/b7tUNZsU3nEiMgoVRDIlFIZfoTFuy9UPW7HqiEdqirpo2MmbTYwElWaQgF700nwrkkKEPvg
	kD+feWM+KQ8Ce/RJj691pB0102PsHrxt/dltFbRP5TrIa+GFz02Ya/60uN32a8SxbpocWPTvV3y
	f+yMELKPx25NQqqfh2x3bYWKS2sg3tNJCxwBwgkeLrnwp6NgdpbdSWbCUZyfCGTSoeUoHPvofVE
	nM9lPk7nVGMUo88+9Zcv896FC/LP3qjufky7MrSUyQwWwODeNFIkSJRzyf3wta+klkAOQ7JkdUT
	lC9BSwziEU4bhu+v/nCeOjkGJV1F48MxXqE73cNXKD6JdJRneBWuucA/bQ8Xc7evvXT22Xvff8Z
	NZiP3Gns6FwS2YnV+fOmlHX+Ndl2HMQvC+utEzEy0WCXte8923CIYsCAzg81XoNoueXA==
X-Received: by 2002:a05:620a:4154:b0:92b:641f:ea5e with SMTP id af79cd13be357-934a0581ac2mr21594885a.0.1785506734705;
        Fri, 31 Jul 2026 07:05:34 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9349bc2653asm62043085a.4.2026.07.31.07.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 07:05:34 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: David Lee <david.lee@trailofbits.com>,
	Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/sched: sch_qfq: prevent aggregate self-replacement
Date: Fri, 31 Jul 2026 14:05:32 +0000
Message-ID: <20260731140533.566493-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qfq_change_class() snapshots the current aggregate settings while
holding the qdisc tree lock, but drops the lock before selecting the
destination aggregate. During that gap, qfq_enqueue() can move the
class to an aggregate matching the requested settings.

When qfq_change_class() resumes, qfq_find_agg() then returns cl->agg.
If it is a singleton, qfq_deact_rm_from_agg() frees the aggregate
before qfq_add_to_agg() immediately accesses the same pointer, causing
a use-after-free.

While holding the tree lock, skip the replacement when the destination
is already the current aggregate. Any estimator replacement has already
completed, so the class change can finish normally.

Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
Bug found and triaged by OpenAI Security Research and 
validated by Trail of Bits.

Assisted-by: Codex:gpt-5.6-sol gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
Trail of Bits has a reproducer for this bug that triggers a
KASAN use-after-free and can share if needed.

 net/sched/sch_qfq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 6f3b7273c..e900890e9 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -517,11 +517,14 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 		sch_tree_lock(sch);
 		qfq_init_agg(q, new_agg, lmax, weight);
 	}
+	if (existing && new_agg == cl->agg)
+		goto unlock;
 	if (existing)
 		qfq_deact_rm_from_agg(q, cl);
 	else
 		qdisc_class_hash_insert(&q->clhash, &cl->common);
 	qfq_add_to_agg(q, new_agg, cl);
+unlock:
 	sch_tree_unlock(sch);
 	qdisc_class_hash_grow(sch, &q->clhash);
 
-- 
2.53.0
