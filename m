Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3603361DDA
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 19:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786993807; cv=none; b=VjPwXwNLeSiicD6JUD3awgQ/qaNFS67kOPzw6GeMYHEEk/lcwiITGPwUtJhVbpY+9jiqRMEy8H/qxfr5B0uAaaUmist5ZpTHTX979QsCGvD2zSP2NX7kcQ86llZUg68UJ7iGdyaOVI0vwRM1etALFcxnjtI9J/ZkH+aVQ4IlajU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786993807; c=relaxed/simple;
	bh=MmTOyUrolNwdXixWEA61+iSEN1nJRaq75qaAf+1wVcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wh/kUSmkouKovpqFFKuI1E9zPMAjd23zGfIpSeaQhzxMocKhlksE5IVyD/DVvGVB1HZLGDFv80gLTIW5mhH8rWjman7y2tt+AgjC8DlbS4xFvSpeWO88ztr7RZfpoaZry3xt9A/2ZqTTxDBahzLam0p/l0rNMm2+jA8dqNig2uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=djoDY2FS; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="djoDY2FS"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so210049a91.0
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 12:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786993805; x=1787598605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c/2C+RYvjKIOLmlpG91ZI2qQFAEpzRihy5VcIrSXsdU=;
        b=djoDY2FSvFK7RnkZS5fyF5m4iaFcAqWvNOr02/AJLDNs0WzlvagJluBrwJ+5JZ6jKQ
         LWbw9KOvO63JslTr75enZib7ZwGuq3YOgIPhO2jT7qrQvF85Wxj8R7vb8fidE+Ddt80X
         peDzfqCaU3qFwhx+sPQWJA0yH1g18/XWz/8yAyYiiYMq81IFYAqTnsUdTrdRPvHbUj3K
         k9lYVx9aF3VsET7nW3zytnfvITDdzihg4QXHPBr2+DjBkm9WPq5grGQuNdMSDejKy/+C
         +YEM8eCH4NeQu7FpBi9mwmqGFB3JIlt7ukQaBmSHCYWrmptxRp/vzUi9hmwEwZedabK+
         SPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786993805; x=1787598605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c/2C+RYvjKIOLmlpG91ZI2qQFAEpzRihy5VcIrSXsdU=;
        b=oRz7Kl/y+dse9rCDcmG5E6FvEya8JQShbbV/Qygfi/4PKe7wQ/wCjRkNGSmqhtebo2
         UraiIajSddB4+zCOQXYwevy2g8g6AkjgOn7a+3bVtGl20+i/acdzAfgm764Meian7WVt
         4ESrchvfuXQ+oJ4q3tINRPxSmrhDGZn+R1Wf99dlV0LIeRQzWnAFL4inQ1AypiRyvuo+
         FIAyGwsBYZtT4nZVqJ7LJu0E91jdQEZc6jCvhdIGvXMvVkFcie89zWQYGstvgQrRkFh+
         IiL9e1BAMLXbJ3WysI5XBb+QEuBsVMko+Jdl2onH+uqOCUY+JP3t8HFgeXHctp2pEo4/
         Z0qA==
X-Gm-Message-State: AOJu0YxeVx7NoDRhFAYzfducnurZsMpWwefgs62q8pQTARtFRQMawR9W
	blPNDmpO4LH57+dWav0OubDBlcaWTmqhLSCZ73tr8hQtVrtjOZo5XgkFMx6HGACN9upEV7OH+Ku
	+p58/8Q==
X-Gm-Gg: AR+sD12GshxlxtMcoXyKZkMcOJwtRXSP+P/JCjzPh3CyYqXhHA6WhLn2U/A6DVPoCYY
	UIcxqRaj/RoyMm0Z4yDfKmdQX3ADPAHsWrq/Z0OYJqVo4oH/dOx08xkhDY98lx9WQjJdahqDa8X
	Ji5xlmfJUCN4rk6/v6S2MlXUi2oYTIDz86jRaYcMGdWmtjt/WPgUtm9CFYIcMPnNRhL7p+FOhWg
	cWwI9F+THqPKaOB/1PvbYO03RmO3692VqSfqENZ5xTcBz7v54UfR/eDadOot0PQdJEMxskO07Z5
	phx+Ir7Vu/GMgGYGcD5w1PvX7Ws/WCwWo3ubt09lPCoWw13O6E/zHcNl4Pw4sguRn3eM72offiq
	vNxeD0u6hl00Q520ZhxWnYnGoeRCkMvbmfsmfWBOmcze5xWEX0DB4nvVNLwa3W76pWK0ErPPq3f
	h7vmBvBz1ferwYJ3wmgh9EKPOsTZOLGFoplrs8+yVMljj5WCajmJwa5Q==
X-Received: by 2002:a17:90b:390c:b0:38f:1a29:7a82 with SMTP id 98e67ed59e1d1-395638840ccmr52847a91.6.1786993804800;
        Mon, 17 Aug 2026 12:10:04 -0700 (PDT)
Received: from gmail.com ([115.196.71.116])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e8904dsm6145831a91.8.2026.08.17.12.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:10:04 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Zihan Xi <zihanx@nebusec.ai>,
	stable@vger.kernel.org,
	Eyal Birger <eyal.birger@gmail.com>,
	Vega <vega@nebusec.ai>
Subject: [PATCH ipsec v3 1/1] xfrm: bound nat keepalive state collection
Date: Mon, 17 Aug 2026 19:09:56 +0000
Message-ID: <4fadde7d28791a4e1196664cec692fdebce99bb5.1786987905.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1786987905.git.zihanx@nebusec.ai>
References: <cover.1786987905.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The v1 nat keepalive fix allocates a GFP_ATOMIC object for every state
while collecting references for phase two. This makes the worker's
temporary memory use depend on the number of states and lets -ENOMEM abort
the scan.

Replace the allocated list with a fixed-size batch. When the batch is full,
return a private walk status so xfrm_state_walk() leaves a cursor; drain
the references after the walk releases xfrm_state_lock and resume from
the cursor. This bounds temporary memory use and avoids the allocation
failure path.

The v1 fix also moved nat_keepalive_send() out of the walk callback. Keep
the phase-two drain BH-disabled, as required by local_lock_nested_bh()
used by the keepalive sockets.

Fixes: 763fe700b7c5 ("xfrm: avoid lock inversion in nat keepalive work")
Cc: stable@vger.kernel.org
Cc: Eyal Birger <eyal.birger@gmail.com>
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
Changes in v3:
  - send an incremental fix on top of ipsec/master as requested by
    Steffen Klassert instead of replacing the queued v1
  - replace v1's unbounded GFP_ATOMIC list with a bounded batch and
    xfrm_state_walk() cursor resume
  - keep the phase-two drain BH-disabled for local_lock_nested_bh()
  - distinguish the template-only userspace command from the actual
    in-kernel validation integration, configuration, build, and boot steps
  - validate 17 concurrent states so the v3 worker fills its 16-entry
    batch and resumes from its cursor
  - recapture the complete original lockdep report and add its full
    batch addr2line mapping from the matching unstripped vmlinux
  - record the validation-kernel user-namespace limitation and the
    separate NETLINK_XFRM EINVAL result instead of implying that the
    template userspace command reproduced the bug
  - identify the crash log as evidence from a separate earlier root-cause
    reproducer revision, not output from the 17-state v3 batch PoC
  - v2 Link: https://lore.kernel.org/all/cover.1785861392.git.zihanx@nebusec.ai/

Changes in v2:
  - reroll on top of net cf6f8b29befb
  - replace the unbounded GFP_ATOMIC state list with a bounded batch
  - keep phase-two processing in BH-disabled context
  - clarify the validation permission model and reproducer scope
  - v1 Link: https://lore.kernel.org/all/cover.1784645321.git.xizh2024@lzu.edu.cn/

 net/xfrm/xfrm_nat_keepalive.c | 46 ++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/net/xfrm/xfrm_nat_keepalive.c b/net/xfrm/xfrm_nat_keepalive.c
index 8679c68c10a1..5cd6d43164db 100644
--- a/net/xfrm/xfrm_nat_keepalive.c
+++ b/net/xfrm/xfrm_nat_keepalive.c
@@ -155,32 +155,30 @@ static void nat_keepalive_send(struct nat_keepalive *ka)
 	}
 }
 
+enum {
+	NAT_KEEPALIVE_BATCH_SIZE = 16,
+	NAT_KEEPALIVE_BATCH_FULL = 1,
+};
+
 struct nat_keepalive_work_ctx {
-	struct list_head states;
+	struct xfrm_state *batch[NAT_KEEPALIVE_BATCH_SIZE];
+	unsigned int nr;
 	time64_t next_run;
 	time64_t now;
 };
 
-struct nat_keepalive_state {
-	struct list_head list;
-	struct xfrm_state *x;
-};
-
 static int nat_keepalive_work_collect(struct xfrm_state *x, int count, void *ptr)
 {
 	struct nat_keepalive_work_ctx *ctx = ptr;
-	struct nat_keepalive_state *state;
 
 	if (!READ_ONCE(x->nat_keepalive_interval))
 		return 0;
 
-	state = kmalloc_obj(*state, GFP_ATOMIC);
-	if (!state)
-		return -ENOMEM;
+	if (ctx->nr == ARRAY_SIZE(ctx->batch))
+		return NAT_KEEPALIVE_BATCH_FULL;
 
 	xfrm_state_hold(x);
-	state->x = x;
-	list_add_tail(&state->list, &ctx->states);
+	ctx->batch[ctx->nr++] = x;
 	return 0;
 }
 
@@ -226,29 +224,27 @@ static void nat_keepalive_work_single(struct xfrm_state *x,
 
 static void nat_keepalive_work(struct work_struct *work)
 {
-	struct nat_keepalive_state *state, *tmp;
 	struct nat_keepalive_work_ctx ctx;
 	struct xfrm_state_walk walk;
 	struct net *net;
-	int err;
+	int err, i;
 
-	INIT_LIST_HEAD(&ctx.states);
 	ctx.next_run = 0;
 	ctx.now = ktime_get_real_seconds();
 
 	net = container_of(work, struct net, xfrm.nat_keepalive_work.work);
 	xfrm_state_walk_init(&walk, IPPROTO_ESP, NULL);
-	err = xfrm_state_walk(net, &walk, nat_keepalive_work_collect, &ctx);
+	do {
+		ctx.nr = 0;
+		err = xfrm_state_walk(net, &walk, nat_keepalive_work_collect, &ctx);
+		local_bh_disable();
+		for (i = 0; i < ctx.nr; i++) {
+			nat_keepalive_work_single(ctx.batch[i], &ctx);
+			xfrm_state_put(ctx.batch[i]);
+		}
+		local_bh_enable();
+	} while (err == NAT_KEEPALIVE_BATCH_FULL);
 	xfrm_state_walk_done(&walk, net);
-	list_for_each_entry_safe(state, tmp, &ctx.states, list) {
-		nat_keepalive_work_single(state->x, &ctx);
-		xfrm_state_put(state->x);
-		kfree(state);
-	}
-	if (err == -ENOMEM) {
-		schedule_delayed_work(&net->xfrm.nat_keepalive_work, 0);
-		return;
-	}
 	if (ctx.next_run)
 		schedule_delayed_work(&net->xfrm.nat_keepalive_work,
 				      (ctx.next_run - ctx.now) * HZ);
-- 
2.43.0

