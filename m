Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F5E4C955A
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784647559; cv=none; b=I1nS5EvjF3bRnQWnOpKPxQFLRe4999ngUEYR8qLK9oAX9J5JmKH3jX1Fe/3sI7cR4wqvmqE2+nNAme4DyYGswl50QBrPZzrE/Fu8WeF/15BShnadg/wPPX830ewioUwj0SLjLxutWqGvDvru1mBk0SLvJIQ+Dj+A0DwhO4aLeuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784647559; c=relaxed/simple;
	bh=8lJJf0Kbqo/eNK1ZuIT+SMkQvQ9k5dHN/hr7iS/NVrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtgE+9l3uFqBcAzR/sTHDc17HfSgIYXl80lb4fKehql7gCd96nZ/1YtzcxGNi9dXsSfHnRuhOuV8l6wC11H5lJdhSYZFPOXo82LyMQUuctne5qb3XC57yjJas62C4lF/BpwLi98jrLcXw0+IcxPJ+Z2BmXPkeEPb7J0pGsmLV8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/edIsAH; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/edIsAH"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso7562983a91.3
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 08:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784647557; x=1785252357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bde6hetITKSyBdr9UZfcMYOFUfhDrF+Xc7cHZ4JUfWk=;
        b=m/edIsAHe9H70zPCQEpAmdUPwKXk24dGd8105tJ+Vb26ErxLqt5WxsPzUcv5Qe699f
         xmL2uuvR3gm192y4F1HD9MpeRqJMb1E2eJRiv0pn0Ic1TbE55oJiNAd85Vc+yAKdKloy
         pNrpeMjGdFSzHWVyEYLv78iH6pdNsAlGuXqcK7YStEN/FXr5a/UwioWDhN/R+wtnGcdP
         zCj1EbNcmvqBZsTHJT3rvynM6hrOABOJqhwUlQv+qDJRT1vyfFR77cB9zWXnHGC5xRFG
         BbmRETqxX7HJRjTUliC9WWjFkGRUNsNsMyvNQCBCIcdvydE/+Oa0AZA6FPC+KUpzFY9e
         RHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784647557; x=1785252357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bde6hetITKSyBdr9UZfcMYOFUfhDrF+Xc7cHZ4JUfWk=;
        b=BbsSGBYDIpMp4AYxTurxm10riO7EKVffFLBhqwa5FvQEx3EbILXlnosbC+PkQe6t58
         vLTXmSjW+ExWHMOpECj56PKYqFSDPC+z6KBy9XeJOMtHFB9LjKxCHHH0xOZo0Q4F2Cui
         ipKi238JVLH+JUsMO2UlMg3zidAyishyLMMOVNTJHuUqLLPQdxkPO/TCZ4zjlPW0olHh
         7OZbmGL7s0D/Oudf0C/wA/8FleEcx7qtcQqa6Yw5+arCh+cqeAGgOMr/vlktt9PKGHBk
         INVKUbcYrKtGwPaLo32pfiBu7Uitd3boD6DRqBxq6YFTG+L2S7FdHiMnPEbyUaOTqTiU
         lZ9g==
X-Gm-Message-State: AOJu0YyXXam+5jbtJsHjyDFDPjvfp633GTSL31ii00bkaD2XOdseDMxB
	YxYzuukx6qGDUQ5L6XsOTU41cBBlPmodofwQUaJki3qyrlNpStL0rCrlxwwk3Q==
X-Gm-Gg: AR+sD13X/yYZ6LGsQ94y4IzYe64ZgEIXnfgsvlDX6Am0ye2XDVh85gADhVt3uz8VoKD
	WyVhZ1N2ETiRPKMJk/tQunjL75gEVywXLb1fZzC2+alTYsdCxsFVqTaqDvE8MTuwNaNxIk43weI
	07oAfe+aHCSPoBzJwlhireXOC4yWjplaAS//ASGJ5V72sLyblNAIvwrMN9TNRUPwhEuhPJB4dcx
	k4sCpe6mI+Y6VEOrjiLimsk8FYA+SVDfVPM1ia231UxhwAQshaOjx7GG/YZhegPplTsdS9Fjzb1
	28FQ10Q5kmk+Cx7PxQWFakzq9TSbpc9EvmFIS9RuTECMqmybDG0CxUPVB7+KkG9fuyQWFshUYzN
	cbDJ3r18zcPTuJ0YSQQVPB/hwC3wbGc9/V4Bd+KBUL7W1gDvFNg2ejyM/1Yfa0outAFLWncfH0k
	orKCDnG7T0QR+AdsznPw==
X-Received: by 2002:a17:90b:4d09:b0:38e:2fa0:491b with SMTP id 98e67ed59e1d1-38e4b594eb3mr19700812a91.31.1784647557018;
        Tue, 21 Jul 2026 08:25:57 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([144.48.80.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e9232c388sm1779394a91.6.2026.07.21.08.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 08:25:56 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	eyal.birger@gmail.com,
	vega@nebusec.ai,
	xizh2024@lzu.edu.cn,
	enjou1224z@gmail.com
Subject: [PATCH 1/1] xfrm: avoid lock inversion in nat keepalive work
Date: Tue, 21 Jul 2026 23:25:42 +0800
Message-ID: <b196f448f8f7e452e0f6d1d3d72ba57b5f25eba7.1784645321.git.xizh2024@lzu.edu.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784645321.git.xizh2024@lzu.edu.cn>
References: <cover.1784645321.git.xizh2024@lzu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <xizh2024@lzu.edu.cn>

nat_keepalive_work() walks the state table while xfrm_state_walk()
holds net->xfrm.xfrm_state_lock. Its callback then acquires x->lock,
which conflicts with the delete path taking the same locks in reverse
order via xfrm_state_delete() and __xfrm_state_delete(). This creates
an AB-BA deadlock that is reported by lockdep when a NAT keepalive
worker races with SA deletion.

Fix this by splitting the keepalive walk into two phases. First,
collect the candidate states while the walk holds xfrm_state_lock and
take a reference on each state. Then, after the walk completes, process
each collected state and acquire x->lock without nesting it under
xfrm_state_lock.

Fixes: f531d13bdfe3 ("xfrm: support sending NAT keepalives in ESP in UDP states")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 net/xfrm/xfrm_nat_keepalive.c | 57 +++++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 9 deletions(-)

diff --git a/net/xfrm/xfrm_nat_keepalive.c b/net/xfrm/xfrm_nat_keepalive.c
index 458931062a04..132de23e64c2 100644
--- a/net/xfrm/xfrm_nat_keepalive.c
+++ b/net/xfrm/xfrm_nat_keepalive.c
@@ -153,24 +153,51 @@ static void nat_keepalive_send(struct nat_keepalive *ka)
 }
 
 struct nat_keepalive_work_ctx {
+	struct list_head states;
 	time64_t next_run;
 	time64_t now;
 };
 
-static int nat_keepalive_work_single(struct xfrm_state *x, int count, void *ptr)
+struct nat_keepalive_state {
+	struct list_head list;
+	struct xfrm_state *x;
+};
+
+static int nat_keepalive_work_collect(struct xfrm_state *x, int count, void *ptr)
 {
 	struct nat_keepalive_work_ctx *ctx = ptr;
+	struct nat_keepalive_state *state;
+
+	if (!READ_ONCE(x->nat_keepalive_interval))
+		return 0;
+
+	state = kmalloc_obj(*state, GFP_ATOMIC);
+	if (!state)
+		return -ENOMEM;
+
+	xfrm_state_hold(x);
+	state->x = x;
+	list_add_tail(&state->list, &ctx->states);
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
 
+	spin_lock_bh(&x->lock);
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
@@ -184,29 +211,41 @@ static int nat_keepalive_work_single(struct xfrm_state *x, int count, void *ptr)
 		send_keepalive = true;
 	}
 
-	spin_unlock(&x->lock);
+out:
+	spin_unlock_bh(&x->lock);
 
 	if (send_keepalive)
 		nat_keepalive_send(&ka);
 
-	if (!ctx->next_run || next_run < ctx->next_run)
+	if (next_run && (!ctx->next_run || next_run < ctx->next_run))
 		ctx->next_run = next_run;
-	return 0;
 }
 
 static void nat_keepalive_work(struct work_struct *work)
 {
+	struct nat_keepalive_state *state, *tmp;
 	struct nat_keepalive_work_ctx ctx;
 	struct xfrm_state_walk walk;
 	struct net *net;
+	int err;
 
+	INIT_LIST_HEAD(&ctx.states);
 	ctx.next_run = 0;
 	ctx.now = ktime_get_real_seconds();
 
 	net = container_of(work, struct net, xfrm.nat_keepalive_work.work);
 	xfrm_state_walk_init(&walk, IPPROTO_ESP, NULL);
-	xfrm_state_walk(net, &walk, nat_keepalive_work_single, &ctx);
+	err = xfrm_state_walk(net, &walk, nat_keepalive_work_collect, &ctx);
 	xfrm_state_walk_done(&walk, net);
+	list_for_each_entry_safe(state, tmp, &ctx.states, list) {
+		nat_keepalive_work_single(state->x, &ctx);
+		xfrm_state_put(state->x);
+		kfree(state);
+	}
+	if (err == -ENOMEM) {
+		schedule_delayed_work(&net->xfrm.nat_keepalive_work, 0);
+		return;
+	}
 	if (ctx.next_run)
 		schedule_delayed_work(&net->xfrm.nat_keepalive_work,
 				      (ctx.next_run - ctx.now) * HZ);
-- 
2.43.0
