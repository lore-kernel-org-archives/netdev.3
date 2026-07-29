Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA7638657E
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 06:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785307845; cv=none; b=g78ugXw/Fe9NvSHgbXWn2Ag4IOcltRe0T67EOMzpaLoA6Pf4NnvfCjRWnaTN7vYFgY2E1LZwV8FlFOJVSYK4NM+s7VU+pH6NW0+1MDYHj4MjT/vBZXzcKIVtx6oyRJqAD1uIdpgLtJujwoz8ZJ8BnQeY5CO4BD70fHkYmH1DFjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785307845; c=relaxed/simple;
	bh=Waz4e7ZItdJTTjUegubMoesRZ6/zp2pT98Thd5h6Itg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4dPEq0KdWRRP1wp4+ev3RqXVLBzb6GHafb8wwXYXaNiWZkykTFIMgmJY5O4c2ZsufuqNwKe+Q7EmzVhii8bnf178PVO5eeU/IYmsNPbyNL+53MJWIgEJ9Mi2Fl4WW/34a0nDVOL88yvb9sidX+mVGXM01ytvopJVLWPZsWb3uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Z5hLEkRG; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Z5hLEkRG"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 3A84A206BC;
	Wed, 29 Jul 2026 08:50:41 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8UWYtXrU7o7D; Wed, 29 Jul 2026 08:50:39 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 9AB5D20754;
	Wed, 29 Jul 2026 08:50:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 9AB5D20754
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1785307839;
	bh=uUMCJOXDDd16NVkcYgRNiPSoirDigJjvSsY/1+xO13U=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=Z5hLEkRGFQrYXbFrGgLtiX40KF+9nxJ433JstCAFhBVyaBQaa81Xy3909L8Bt4pJA
	 OsVpsFCvqtMUFF5PrUF1tVXTl4C3tiSqk0r41LeYTrca6peIoezr+V9WH5rhgs2TsM
	 s8vXeCSK031Sp7aI3IzphUxh+iKS2aVy2rEiaWeAsNZy9Ysm5y2qFV/Ohnpy/BAFxk
	 DUruwMH1vNaJ23sASq5Jof2nP6inKly2u/itWNHXE3DnXwdwvwGHLofDt0rLeuVjVv
	 PXa1EkAisUScQ3ic4SDjNQAdhrosVcwuAoR968HlAAycU9inHabqDZu8cjmn1BPVLq
	 15LLH1jvyfUkQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 08:50:39 +0200
Received: (nullmailer pid 1592289 invoked by uid 1000);
	Wed, 29 Jul 2026 06:50:38 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 5/8] xfrm: avoid lock inversion in nat keepalive work
Date: Wed, 29 Jul 2026 08:50:15 +0200
Message-ID: <20260729065035.1591985-6-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729065035.1591985-1-steffen.klassert@secunet.com>
References: <20260729065035.1591985-1-steffen.klassert@secunet.com>
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
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_nat_keepalive.c | 57 +++++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 9 deletions(-)

diff --git a/net/xfrm/xfrm_nat_keepalive.c b/net/xfrm/xfrm_nat_keepalive.c
index eb1b6f67739e..8679c68c10a1 100644
--- a/net/xfrm/xfrm_nat_keepalive.c
+++ b/net/xfrm/xfrm_nat_keepalive.c
@@ -156,24 +156,51 @@ static void nat_keepalive_send(struct nat_keepalive *ka)
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
@@ -187,29 +214,41 @@ static int nat_keepalive_work_single(struct xfrm_state *x, int count, void *ptr)
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

