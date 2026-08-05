Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C16D38E8A7
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 04:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785905520; cv=none; b=QMtj3gc40Ww91z7EyFWzs5ISqiFuVH7owkYa8a2+VVI1xLwDCoXnilAyNWCU2oC+51cRaT+zmvJWOI+9UkkyBarfTt6fksjVgwTg5RLrMAPvvI+pdyxgMWG9xm33M6nMj0YybVABA148DrGQoOD0Zq6OWf3LwSE4yKsgeowEAuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785905520; c=relaxed/simple;
	bh=UPFXf5WrFFLLU4Z027AuolLpHfEPH4y5VDEoHGo+Ljs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NzgacKCzE2W7ckzu8DvfCwTGuQYaVbmYH3A9QwNfF85DrDRShhd//ouSGFghF7Ek98tCwfqvISPLXleqvKCBWfCUy0DO3UxjN5IqFEVsINb4rvm6T7/ivsbAdBVIB/xrjI+9O2IN9rQ2enDM/q5fma1qMSOo24VdLZ5CYiHB5aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=My9CESLX; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="My9CESLX"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3811f512167so611739a91.3
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 21:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785905518; x=1786510318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/h1/IrMiN98qECsNwHDDE3vKe1KsFXae7FcvYv9cB+k=;
        b=My9CESLXfh8QGRWo7yavMH4K8aIZ8HYHmTHHWdTQJ//4hqRhuQIB+2ARqOKF+9FSQO
         mpEQg8q5ovQGgMkD0PufIZnr32p1hJJcXJx7gNJClJdcE8NwU4unAWlqu9YISpcLF9n1
         +xOI1S6TwJYUNHODsceufoWFm191j48+1xZ2+eHnULO4LLGp1fkFKYcxDRQdma0Yv6it
         1aPHcJhwKsb5GNrNXlykKi/5rC97EM0JPbCNj1i0+A88W0ebMF+IXl3buPm56T4/K2IJ
         nutUEXrZmWSQr7QvdAlnPkPDJmF5Fa9K5jrAMBgjDh3bXvr+78KxXQkchY92AhC2nAUn
         W+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785905518; x=1786510318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/h1/IrMiN98qECsNwHDDE3vKe1KsFXae7FcvYv9cB+k=;
        b=FkffFXZl8kT2cPkD6I93sXUy1N+8NToAYpGqCIpBHmT6Wr4zKbslyT2zzSFPkFZ+BC
         skLEuzFYacp8FWjTUAFmkLnBj5YtU3i6oaHCOoVDK5DlwGhmZGjF0y4mkhnBN9fRs0gc
         8cZCeUwIkfZsjp9ozN8vPScbnynzCI40/4B0BVfIebHz+FneXkIbcCfczyOvpn7sjRyl
         iJDeuwpdHqwI2XF4EVQF8Mj8QE7O6XSTr7QSJKAUHudGl5AOQFvUg6cwnLARFb2bJQFo
         xlhfFbjNi9/Vuznu1rWZ69nbYnCaOmyfOOHQ4NtzalbTXt5VjHX5AxKjneikBTwcjGou
         IqJA==
X-Gm-Message-State: AOJu0YxZF2fk71wLzdVwWizpQAALhu6r9keCUk9C96AMGBizmvdR5nGu
	ymzX0sC8PA0sUqsGFQ8GOu8gwOOVKdP+7x67CZBRGMjGOuVurA6P4opDnY1aPsRi/CNe3O1wj8a
	qzdH6iiuG
X-Gm-Gg: AR+sD100dHN9+PXzhIEphCclckIJRxTmDMXI06Nt2ZdbjuRCOyBYSE/GQH5zEJyEqmQ
	hEXEBIpQ4HQ6WVT3zUba3r2AB+Rgfahr+KRH5/LLu9GxuSXQfOm/sMoIWLART0GkbTPN5PWI6lU
	DIWa8qkc0S4VP9bPjQyWaBUKRH3WiOe8vT87HrK0WlNPSK9TMJikwIuDrSEmoAX3r3bBeoTZMBw
	Gz2vG9KcG0CkNH8PR76NnDti7RECbwDKqdMB7dSCQDW8OAHfzspGtG06NdbMrKnrASue663ee5o
	CRmZvcjgfv1oLJMx374Hj1RNqkmaFlkJsnV+6qeMlefjn7Vho5fhPUfri8Ewb7spOl/fTwtYcF2
	hD6lJGybqIKFDJ6AhSEWq9MhIu+yOq9K7M5krTxMSEAHc7JhScvEV8ThWyCpt3+tIJC7SU9umWn
	UmLwCKr6GmqQ5CB4h4Lwh1+AiUffuR4XjaFYDBwiWRLhL9b6t8xTxB9zdtNs6KIJ5QBk1Qdg==
X-Received: by 2002:a17:90b:28c3:b0:38e:2e16:859b with SMTP id 98e67ed59e1d1-3903c68096emr4265312a91.20.1785905518297;
        Tue, 04 Aug 2026 21:51:58 -0700 (PDT)
Received: from localhost.localdomain ([115.192.251.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38feda512f3sm3160666a91.11.2026.08.04.21.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 21:51:57 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	eyal.birger@gmail.com,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net v2 1/1] xfrm: avoid lock inversion in nat keepalive work
Date: Wed,  5 Aug 2026 04:51:25 +0000
Message-ID: <fa79c742acdfc25678e6807d4cad766edaaf1d59.1785861392.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1785861392.git.zihanx@nebusec.ai>
References: <cover.1785861392.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nat_keepalive_work() walks the state table while xfrm_state_walk()
holds net->xfrm.xfrm_state_lock. Its callback then acquires x->lock,
which conflicts with the delete path taking the same locks in reverse
order via xfrm_state_delete() and __xfrm_state_delete(). This creates
an AB-BA deadlock that is reported by lockdep when a NAT keepalive
worker races with SA deletion.

Fix this by splitting keepalive handling into two phases without
reversing the lock ordering. Walk the state table only to collect a
bounded batch of candidate states while holding xfrm_state_lock and
taking references on them. Then, after the walk drops xfrm_state_lock,
process each referenced state and take x->lock in phase two.

Use a small fixed-size batch and the xfrm_state_walk() cursor to resume
the scan when the batch fills up. This avoids per-state GFP_ATOMIC
allocations, avoids aborting a full round on -ENOMEM, and keeps
nat_keepalive_send() in BH-disabled context by wrapping the phase-two
drain with local_bh_disable()/local_bh_enable().

Fixes: f531d13bdfe3 ("xfrm: support sending NAT keepalives in ESP in UDP states")
Cc: stable@vger.kernel.org
Cc: Eyal Birger <eyal.birger@gmail.com>
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v2:
  - reroll on top of net cf6f8b29befb so the patch applies after the
    nat_keepalive_send() default-case change
  - replace the unbounded GFP_ATOMIC state list with a bounded batch
  - keep phase-two processing in BH-disabled context with
    local_bh_disable()/local_bh_enable()
  - clarify the validation permission model and reproducer scope in
    the cover letter
  - refresh the cover letter with cf6f8b29 incremental build and PoC
    validation results
  - rerun decode_stacktrace.sh on an LF-normalized crash log and
    document the decoder truncation in the cover letter
  - add source locations for the key lockdep offsets from the same
    unfixed vmlinux
  - add Eyal Birger to Cc for the v2 reroll
  - v1 Link: https://lore.kernel.org/all/cover.1784645321.git.xizh2024@lzu.edu.cn/

 net/xfrm/xfrm_nat_keepalive.c | 51 +++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/net/xfrm/xfrm_nat_keepalive.c b/net/xfrm/xfrm_nat_keepalive.c
index eb1b6f677..bcc351625 100644
--- a/net/xfrm/xfrm_nat_keepalive.c
+++ b/net/xfrm/xfrm_nat_keepalive.c
@@ -155,25 +155,50 @@ static void nat_keepalive_send(struct nat_keepalive *ka)
 	}
 }
 
+enum {
+	NAT_KEEPALIVE_BATCH_SIZE = 16,
+	NAT_KEEPALIVE_BATCH_FULL = 1,
+};
+
 struct nat_keepalive_work_ctx {
+	struct xfrm_state *batch[NAT_KEEPALIVE_BATCH_SIZE];
+	unsigned int nr;
 	time64_t next_run;
 	time64_t now;
 };
 
-static int nat_keepalive_work_single(struct xfrm_state *x, int count, void *ptr)
+static int nat_keepalive_work_collect(struct xfrm_state *x, int count, void *ptr)
 {
 	struct nat_keepalive_work_ctx *ctx = ptr;
+
+	if (!READ_ONCE(x->nat_keepalive_interval))
+		return 0;
+
+	if (ctx->nr == ARRAY_SIZE(ctx->batch))
+		return NAT_KEEPALIVE_BATCH_FULL;
+
+	xfrm_state_hold(x);
+	ctx->batch[ctx->nr++] = x;
+	return 0;
+}
+
+static void nat_keepalive_work_single(struct xfrm_state *x,
+				      struct nat_keepalive_work_ctx *ctx)
+{
 	bool send_keepalive = false;
 	struct nat_keepalive ka;
-	time64_t next_run;
+	time64_t next_run = 0;
 	u32 interval;
 	int delta;
 
+	spin_lock(&x->lock);
+
+	if (x->km.state == XFRM_STATE_DEAD)
+		goto out;
+
 	interval = x->nat_keepalive_interval;
 	if (!interval)
-		return 0;
-
-	spin_lock(&x->lock);
+		goto out;
 
 	delta = (int)(ctx->now - x->lastused);
 	if (delta < interval) {
@@ -187,14 +212,14 @@ static int nat_keepalive_work_single(struct xfrm_state *x, int count, void *ptr)
 		send_keepalive = true;
 	}
 
+out:
 	spin_unlock(&x->lock);
 
 	if (send_keepalive)
 		nat_keepalive_send(&ka);
 
-	if (!ctx->next_run || next_run < ctx->next_run)
+	if (next_run && (!ctx->next_run || next_run < ctx->next_run))
 		ctx->next_run = next_run;
-	return 0;
 }
 
 static void nat_keepalive_work(struct work_struct *work)
@@ -202,13 +227,23 @@ static void nat_keepalive_work(struct work_struct *work)
 	struct nat_keepalive_work_ctx ctx;
 	struct xfrm_state_walk walk;
 	struct net *net;
+	int err, i;
 
 	ctx.next_run = 0;
 	ctx.now = ktime_get_real_seconds();
 
 	net = container_of(work, struct net, xfrm.nat_keepalive_work.work);
 	xfrm_state_walk_init(&walk, IPPROTO_ESP, NULL);
-	xfrm_state_walk(net, &walk, nat_keepalive_work_single, &ctx);
+	do {
+		ctx.nr = 0;
+		err = xfrm_state_walk(net, &walk, nat_keepalive_work_collect, &ctx);
+		for (i = 0; i < ctx.nr; i++) {
+			local_bh_disable();
+			nat_keepalive_work_single(ctx.batch[i], &ctx);
+			local_bh_enable();
+			xfrm_state_put(ctx.batch[i]);
+		}
+	} while (err == NAT_KEEPALIVE_BATCH_FULL);
 	xfrm_state_walk_done(&walk, net);
 	if (ctx.next_run)
 		schedule_delayed_work(&net->xfrm.nat_keepalive_work,
-- 
2.43.0

