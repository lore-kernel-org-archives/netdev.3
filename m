Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3163EEAEB
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785925509; cv=none; b=K86Y82zTW/ORdFkCDiBSszNYOYAesEsM2T7v5EQRtR29niWcKYT7/t1vpACamXprfCkoHLbY0TgXc2msOp/nZrgVrwmiQAgLejVI+KlCJ/oOBUQwY3zvkJyAHDFdu2NTNzg2HM/FuaU/UZ/VcejPdZ2QOwP9yW5h3o1SCPiiCsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785925509; c=relaxed/simple;
	bh=/DkycLXhtAYSLcPCADl3aN8voAGjRD7zg7QeXoTeLQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LZKmKRTvXoercXA8OEX3vHtXvKTzc/lNnGahEpsvE1x8w0GKLR+i7pgeu660A86lsDM6EmN1sAk5a0co+ao9l5JPSix7yqdyjbsAAPwR5L2DEV03kizW2WQUQy+cjcJSaNucJdji/Cgk9+AH7+j25XteD5SouR1tpvOaZDKt/W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=RahIWsbd; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="RahIWsbd"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ee43b3e5abso5291586d6.3
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 03:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1785925507; x=1786530307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cOdPU1wN9xyoRGMNaaz9GwPfH06/XzqF6M+pG01RCzw=;
        b=RahIWsbdvFYYU/FeGVibTrgOelTmGL65+JAOp3+Rbgm73w/L9DHZIEWkMeYNFuws5U
         1n58aG2YFAwbsWxAqixVhTyWpvWQvu8KXi7DA8dWqAQ6JPAD6MKdUDefObE74nIAhAJE
         U+tKYcwC6XtLQIOGdiJw6CeW4VexQnHro6adolQbviyC3olwWVj+giMMpaseTGJs3Nb5
         9EvZguB1Z5T2Ei+hr8TVymnJqBi7r7mlbsynQTbzHbdVBlgPSfplfmOGlLdHSy0k1A6s
         lFeOk6ZC9PzE9S1gXWRm/gOLhMv9W6/rgfBCqXI4PzI8Kuz2wNZ3cjd2qF2tPiv7mP9t
         5C+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785925507; x=1786530307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cOdPU1wN9xyoRGMNaaz9GwPfH06/XzqF6M+pG01RCzw=;
        b=J1GMmnPybMsl/j+UNISDs8VFu0Utxviw2z/Y5OPx0cOuO8J056ohvdu25PhJKDT2Mb
         kiSxgr6LGbcFTVYOdxTmUZMUG+/NdHQiOOCFgSa8VdUSvX3g5SNlzNae/G49cvIzYFwS
         dykQhFdniagoZhRX03v01DWKTtMJyFe3YRBEIG0/KHQP7W1TZSXlg1gBS2+EryLDHe5r
         +R/HXj5Q88rQgS54irWsRChB0QV2gbcb0TouB6wezd2H8U0xVJADfWc5snio2qC1G1hl
         E7SQnWSfHBV4O9UxqjwEw4PK33ktus15h1KtYBsHNtx97MU0s0HNf/YqwZBP3VpRdyfr
         btLw==
X-Forwarded-Encrypted: i=1; AHgh+Rot+Gdk6ETCxUMTHJtW8RlBFRbO6Ox1ATyKeY44yQ80ITpjGbJZrKcrZJTbscEspD3veuRFTcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxXeeWd9w9YjekPsOhgfMyusj9XzxgF7SvAyw42NpkQnpH3Rwh
	mX3t2VDJXJDeYitciAIq6qV+cb1QrF3hjdHkBQt6NsAD7UXVR/CoMIHjbSqDyWQBuv0=
X-Gm-Gg: AR+sD11IQoKyrnOohgZqWYD7wLO5NGYat4sLaSmTU4J0HgSyIGsWqgvZkjdp6tgkLIV
	h10OuPNVnoZDRa38mnmfVNqOv/brtb27XU8BK9sR1RDm1juoKd/WQq/jMdn8B0G0X4L7DZXtozV
	Iu8jma2Bcfp0QnGD5EOy9lcwTKPweTN6RsIv/xdCqWbA3J1ALFaVgnQhVLWfvNI03U+HLlqgKRp
	R97cFmYv0wc/+BD1pQK5nIU05RVj7O0eJo0sx0/bXNws8msQHkJddRyT+W0jaiCeUFu3sMxIbS3
	2XzHqyWB9CvU8srvfEAlVqM8DhSlJBda94foe0zDYBHHebVHPlRHJnBz8pJPi+FoJxgVEW2CJrD
	i115/TcOnwdPon+dEdpz8T8fPCUlw9bMsKk3V+6Rb+i237I/DJATeYROYq2LFJkwufIVX2qBqai
	wGuvVf0/3QHjNA4RvqR3hFEbJtlbY7su4nmQFDbm5CJtY/4Hues4fxen+szbqoktipjQ==
X-Received: by 2002:a05:6214:428d:b0:8dc:1f0:9f2f with SMTP id 6a1803df08f44-9088125bb0dmr63723366d6.17.1785925507079;
        Wed, 05 Aug 2026 03:25:07 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-908846e6155sm12522396d6.43.2026.08.05.03.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 03:25:06 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Lee <david.lee@trailofbits.com>
Subject: [PATCH net] net/sched: defer qdisc freeing after failed creation
Date: Wed,  5 Aug 2026 10:25:05 +0000
Message-ID: <20260805102505.740806-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

A qdisc's init callback can publish state to RCU readers before
qdisc_create() completes. In particular, clsact_init() binds a populated
shared ingress block and installs an embedded mini_Qdisc in
dev->tcx_ingress. If subsequent rate estimator setup fails, the unwind
removes that pointer but qdisc_free() immediately releases the qdisc and
its per-CPU statistics. A reader that obtained the miniq before removal
can then access freed memory.

Add qdisc_free_rcu() and use it for the creation error path, matching
normal qdisc destruction. This keeps the embedded miniq and the per-CPU
statistics alive until pre-existing readers complete.

Fixes: 51ab2994c387 ("net: sched: allow ingress and clsact qdiscs to share filter blocks")
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
Bug found and triaged by OpenAI Security Research and
validated by Trail of Bits.

Trail of Bits has a reproducer for this bug that triggers a
KASAN use-after-free and can share if needed.

 include/net/sch_generic.h | 1 +
 net/sched/sch_api.c       | 2 +-
 net/sched/sch_generic.c   | 7 ++++++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 45a1e8c782..d45442c926 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -793,6 +793,7 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_queue,
 			  const struct Qdisc_ops *ops,
 			  struct netlink_ext_ack *extack);
 void qdisc_free(struct Qdisc *qdisc);
+void qdisc_free_rcu(struct Qdisc *qdisc);
 struct Qdisc *qdisc_create_dflt(struct netdev_queue *dev_queue,
 				const struct Qdisc_ops *ops, u32 parentid,
 				struct netlink_ext_ack *extack);
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 668bcd60d1..041bd60072 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1373,7 +1373,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 err_out3:
 	qdisc_lock_uninit(sch, ops);
 	netdev_put(dev, &sch->dev_tracker);
-	qdisc_free(sch);
+	qdisc_free_rcu(sch);
 err_out2:
 	bpf_module_put(ops, ops->owner);
 err_out:
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index ef2b4bf515..86d551fbab 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1103,6 +1103,11 @@ static void qdisc_free_cb(struct rcu_head *head)
 	qdisc_free(q);
 }
 
+void qdisc_free_rcu(struct Qdisc *qdisc)
+{
+	call_rcu(&qdisc->rcu, qdisc_free_cb);
+}
+
 static void __qdisc_destroy(struct Qdisc *qdisc)
 {
 	const struct Qdisc_ops  *ops = qdisc->ops;
@@ -1127,7 +1132,7 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
 
 	trace_qdisc_destroy(qdisc);
 
-	call_rcu(&qdisc->rcu, qdisc_free_cb);
+	qdisc_free_rcu(qdisc);
 }
 
 void qdisc_destroy(struct Qdisc *qdisc)
-- 
2.53.0
