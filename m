Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0352F3CDBB7
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 06:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321118; cv=none; b=OnkS8mAsnKTnspyEuApJkTH3DoXzDGSXy1jsg9V8GWvRB4tXm0MijomX5t1Q+YxZ1gOxIzcNK8LP3clbwKyUK3Sh6zUZNA0YcWWzR5QyBBvJe4Bj2d/93G798Rb1+3W1J8np7yqZqC7GyJoF3GHEUpulfuNPj8S+ycoqFhUP/bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321118; c=relaxed/simple;
	bh=iCjgSGQCi67vL1LaBuP2HdNCkqVFVhkj7q73pW71RHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hTgm/ETu0TOMbIZYr3rMjF9ZF9VDB3XFXJUaXzXCxXez8ZwPOjwBR0O/GkTzOVa9ZwuPAFOQsYQpO6uBhFjquzIkQWG1koIiCIxn7Cvgz6PZiIieo06uQx+DgjpsjAtvtSOwUtSCsDMvC9w1H1kp/v7+BlJl+UdHIfJraQbC+f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYPPMdnQ; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYPPMdnQ"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c2808dbc3so15703971cf.1
        for <netdev@vger.kernel.org>; Sun, 05 Jul 2026 23:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783321108; x=1783925908; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O5jnTX3kdFX6DLX1g0YbhO1YUgSDKweiNLlx3lePZcg=;
        b=UYPPMdnQFLT+IPmwZYSWK8e/fbWp4cbegWAGoY21ybUP84pWljPiZkHTsRckcrls1U
         sPxLehhdxRLNm59NL52fejwoyXmFW36ymk8h/cZFvbk4MVbDGP3sZOHFf28hpJRp3EDH
         bndzbsvgBVcdCag9Lu3ymjlcj4dEczEIK3RJIlyCYQyPdgqMZmdTs3hfwtQVEWmzFvnP
         ljfK8Jqu+pcFGSS4N+qDf3HvO2psyu6JvgXV21z70m5xQuJ14kvzmHyZohfIDeezJBIU
         X3312JzPeOLqwki+OYTUnngW30EjG+Y7jc89KLL4nE7X8KbNkSHHbDjVqriJStmNk7Ze
         U8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783321108; x=1783925908;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O5jnTX3kdFX6DLX1g0YbhO1YUgSDKweiNLlx3lePZcg=;
        b=Evv3D6tcrX5hf9L0RFGWlzvsMMgkgeFK8ugn7dTl3XtoADONKo/MPHUnn3fnGVLTVq
         PkQwyXabS7GNCxw6+aFcDaAqcBA9n2e8TR2RUNwt8W/A1mBWh2mb0TBrjU8jVdqK1nNP
         otletsJQcIGRqjzQdYCKVM5kozTRlcdW9Gs+tEBYFleI8psfFVJ8ZSb9yT733jIJC6vY
         Zu4Renjemkgyf9ScVKI6sdSqF0IIzA64V+1QUGDMJQbR5uFtwew1RE349xJ9y2gvqejj
         zCg2KkUtSELbl69/CbM0vOftC1ZP6Zqu8uZ2oJ/ZmY+KEKf2iSmk9msmGkN27KRy5QjM
         P3fw==
X-Gm-Message-State: AOJu0YxLbeefTmhSf3bD2zW5NU2Hz1aIsonIqd97UIqC1+n6HqBWkd69
	8XUn3pojgOQL4S41pCaWvYgWgiprFxBYNPJ1pvw439rv4QbODvfP2ciqzw8MyNIjtMQ=
X-Gm-Gg: AfdE7cnIANKNWww1x1Crx5YjeAf481e5GewSIVblBcg9j7R7h3K+ih+wl571lf1ACv4
	3sGowWS5DfT1GKRfNjqxY1ufgNo74eoedERMvpvcsHwsoliooUPrToq/eTkIFFmXbZr05bXBxBm
	vX5EtXkrGQKBO3Zt6WWeuREwOGswcsxvbnsGpw6dWH6MCVY8W7cXrU0EgzCneUlfspWb6zZLeeJ
	ApCbQKjiVCPN+q/6hdwgmklsf8rHSv6zI8OqEhMoXnf75h2TDa4YgDHoSSSXmydWwY7Wd/uvZfU
	EQ4SG4DRHkfk2bSCs71Zs8qjm7iGMjPxPpAj5XVko+Y+HzwyX0MafpGT3b+05U8DzOi95aozb5S
	3PnO8nqAhzDMxAcu23ajU0LmrNj2UWYUDyb301fg/k9hHM3L4otrudcoit0AU5EH3LnBbubsOE/
	QcCr/HEvqHRdBJB9nEWx5RuvhOuLopXD/1pzy/QQzFXz+03hOwGjrKubKrG/juOw==
X-Received: by 2002:a05:622a:d5:b0:51c:1a17:eba0 with SMTP id d75a77b69052e-51c4c1f64aemr127337941cf.2.1783321107889;
        Sun, 05 Jul 2026 23:58:27 -0700 (PDT)
Received: from localhost.localdomain ([66.198.16.131])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41b55495sm87921101cf.11.2026.07.05.23.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 23:58:27 -0700 (PDT)
From: Vimal Agrawal <avimalin@gmail.com>
X-Google-Original-From: Vimal Agrawal <vimal.agrawal@sophos.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	kuniyu@google.com,
	edumazet@google.com,
	vimal.agrawal@sophos.com,
	avimalin@gmail.com
Subject: [PATCH v2 net-next] net: neigh: avoid calling neigh_forced_gc on every alloc when table is full
Date: Mon,  6 Jul 2026 06:58:13 +0000
Message-Id: <20260706065813.66116-1-vimal.agrawal@sophos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260625084213.4e0b70c4@kernel.org>
References: <20260625084213.4e0b70c4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Once the neighbour table exceeds gc_thresh3, neigh_forced_gc() is called
on every allocation attempt with no rate limiting. In workloads with mostly
active/reachable entries, the GC walk traverses a large portion of the
neighbour table without reclaiming entries, holding tbl->lock for an
extended period. This causes severe lock contention and allocation
latencies exceeding 16ms under sustained neighbour creation.

Add a pre-lock check in neigh_forced_gc() to skip the GC run if one was
performed within the last 50 ms, avoiding repeated full table scans and
lock acquisitions on the hot allocation path.

Profiling of neigh_create() shows ~3 orders of magnitude latency
improvement with this change.

Link: https://lore.kernel.org/netdev/CALkUMdSCpx_ywYCx_ePLdm6yioO1nQWx7sSM=AEgsq0kywHxTw@mail.gmail.com/
Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>
---
v2: Changed threshold from 1s (HZ) to 50ms (msecs_to_jiffies(50))
    based on profiling data showing 44% -> 2.56% CPU reduction

 net/core/neighbour.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 1349c0eedb64..a83535d32da3 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -260,6 +260,9 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 	int shrunk = 0;
 	int loop = 0;
 
+	if (!time_after(jiffies, READ_ONCE(tbl->last_flush) + msecs_to_jiffies(50)))
+		return 0;
+
 	NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
 
 	spin_lock_bh(&tbl->lock);
-- 
2.17.1

