Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB74448CE4
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 09:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045381; cv=none; b=ri9hx3dl88uCGNPp7X5N83cShH2rSAbXhYRZZHmG0ARsnGM1cKgXmq5dZuqHX3Rxd33LdwlWqC2OvILrQnH83dmtp2Wn1nK7xPLlunRa2ZuJxMCHRHPlucpDNBzEfg7HOcZLnWtiL7LdlCJuYfytb0VvCz8PunXujkat8naNud0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045381; c=relaxed/simple;
	bh=K4cF+Ze9/ENrN0cyjlIoItdHHsW7pXdTphwSycmx2go=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SiWNsyU5ZM004G0YnXpSkkCAUL500OMUUsoxHmxRkNmWHsTl3NXHD58xekRKzU+a5HlxdJRpqpsUXD1riUc/YXI8LU0TbfvMYRKiGV+dYxeM8InJOY9RCYLcXfA6eeIQ4uXUKXEf2nvEMHIx+raJ9+sHC6Y/NgELPQPrQyZQByU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=zP7RuoTc; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="zP7RuoTc"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 4361E20728;
	Tue, 18 Aug 2026 11:29:37 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nj4SzJ0pBr0c; Tue, 18 Aug 2026 11:29:36 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 8D740201D3;
	Tue, 18 Aug 2026 11:29:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 8D740201D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1787045376;
	bh=8occ4Cbc5vqEhKnpMqwdgfXCD6BV5xbHB/Ugc2egV4c=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=zP7RuoTcQGQTEqdrqY+niH3qRehPjFQMSmy6Cqhu0j2f9+/b94Et+Q8ZcQuUSUxyc
	 RxVbyLIOif4yXiLB6ClMYRG1xng4NS6Ku9WFJSqFcyO+ukKSypEstrxIEyPPS0G4ce
	 xqvGVqvIXV9CewFd0SOsFOZsirZRhavfcaGP1FDQFcC89nkRmwKTyI5B6O9wuxd0ip
	 Sa6d8OvmF75zHNsAEGfpZ1UkNaNNLtcj9VaJiXiqbgJ5k7XELSc7jKlvx5UqFTdj37
	 2xz5m0SU0PetasZTLt6gv8IvqnOBdHA73mkfI6eglJ4XZNMtikMSzHUl9ZCYYqEFcY
	 0J9+g76Sv/vgQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 18 Aug
 2026 11:29:34 +0200
Received: (nullmailer pid 657509 invoked by uid 1000);
	Tue, 18 Aug 2026 09:29:27 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 10/10] xfrm: bound nat keepalive state collection
Date: Tue, 18 Aug 2026 11:28:41 +0200
Message-ID: <20260818092920.653034-11-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818092920.653034-1-steffen.klassert@secunet.com>
References: <20260818092920.653034-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

From: Zihan Xi <zihanx@nebusec.ai>

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
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
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

