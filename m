Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0789559CB2
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791925108; cv=none; b=CPzbZ0b1yIRKDGkMNmw1k4B0wn1Hzh/m4M33uWOw3pt+rYrz5NfJEWDqrMLkEf/ySskVIVpJB82hH0FF9MUJBKIXdroeryOSTIxczaG4BX9XbqSeuIJH9aiToU0W1gf5e06BIEGFrmcLTtCmH29hlnIxx9/qiVUSxtn1PFDJSI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791925108; c=relaxed/simple;
	bh=U5pTt0N13l4vVaGW+/Zu3DeKRDmTj5pIh2r61aQFqKg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DctNLfxq/wtyYsAQWq/MZdU1FzimdfViJP7ZckSWLp38AzV0zE0O8ndJCUhvC64bWeXBtHTWxZI3OhozECiiyxt1UOrKWhQfixIaMVMzELMwH/mSHzvVM0xaSU1Y+IdYMXLkrjGY+tgYrsSQ1wONtkTyWJcWJBTUQK1YXU5pxls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kXYbMwcz; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kXYbMwcz"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d5dbso4153771a91.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791925106; x=1792529906; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f+EeDAIv0aEfQrlKgoNr6zWr/sWrIpRpKyLa0c8+Ybg=;
        b=kXYbMwczquEoCrfmViJe2wWwhU73nWyXUXnKGLFMr9yRIJuakaGoSYHXF0VVZ6ZX3f
         vSj82cf63DZT9REh61wLgyZYhn1aY/OCkPfUILHcb7o+LgxE+XZnBWU0HZJLHiMnV1fq
         1W0LliYa9y2zhDfEidkqN/ejQUKeQrFAv9CMNflJmJwmLkw1IwmwDwQUr0SugmioLwza
         yqyar71hn1yTsKPXzhhiNRsT0+FEGJQ8AMLCbMoG3cPQPdgqLE0Yfo144FgyH4xbmh7Z
         A4yzCRB7nVA85ouvA4meumM+XGkvDJboh8YnHmqwondz1gt1sMCAqZV8BoHS/Z3NGCNS
         LoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791925106; x=1792529906;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f+EeDAIv0aEfQrlKgoNr6zWr/sWrIpRpKyLa0c8+Ybg=;
        b=YEEzjRfNW+u7bf7d9SG5I5Jisathn3LmoLFHXpp9VMJ/lx4pnvWoRuOiigMnaj8ZIY
         1o48T/JtZl56e3rdSDBuVq6f3h2m62pvOasdTU/H6goR+bn4lMFzmEnEDaYEn9YPfW/F
         sAccnCEAZubmcjuVZoj+c9ilG9zmFYlXA3Ge2nC3is5AZxHXocRz0BafCmK2iGQ3cbgP
         aii/A5yjTY3AOabgfgsdHXGpDRGoXktfK3ExxwqNKERnyjqBU/YF5lZOpqse7hD8VbcJ
         i+LRwh1CT21iJUSMLpQbxPwwWbFhpsskyHYbHaoMO8AOjeOH/OvX20NH/4dlvJxXF+rS
         SBmA==
X-Forwarded-Encrypted: i=1; AKwUvBxef9Yu9hT9/d0OJs1PCX9ObmrkA3zm79uIEOCqSvt9n8xrYLddclhEktm5PMCFs9apephQFAo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKHNxTuGbsL0OGHs5lEnmsL2x91lihBhI2mLtuJxBbXL8VPkHH5
	lh/VOkMnUf/HHfNiq4F70toSOdKRvpFxgpvKUcW4M29NKQpnI6/rFdIFpB8EuZXOsZqhhWTdIT7
	AeXIMhg==
X-Received: from pgcy1.prod.google.com ([2002:a63:7d01:0:b0:ccb:62e:3f01])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e49:b0:3ab:e588:c29a
 with SMTP id 98e67ed59e1d1-3abe588faf0mr6337672a91.6.1791925105719; Tue, 13
 Oct 2026 13:58:25 -0700 (PDT)
Date: Tue, 13 Oct 2026 20:57:32 +0000
In-Reply-To: <20261013205816.1642597-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013205816.1642597-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013205816.1642597-6-kuniyu@google.com>
Subject: [PATCH v2 net-next 5/5] neighbour: Floor neigh_periodic_work()
 interval at 1s.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

neigh_periodic_work() reschedules tbl->gc_work with a delay of
BASE_REACHABLE_TIME >> 1.

neigh_table is now per-netns, and a user could hog CPU by setting
BASE_REACHABLE_TIME to a small value.

Unlike INTERVAL_PROBE_TIME_MS, BASE_REACHABLE_TIME is also used to
compute reachable_time for NUD_REACHABLE entries.

Let's floor only the GC interval at 1 second.

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Link: https://lore.kernel.org/netdev/20260902143023.GA3966681@shredder/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index aa3da886eaab..d6e9c7c59a89 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1042,12 +1042,12 @@ static void neigh_periodic_work(struct work_struct *work)
 						lockdep_is_held(&tbl->lock));
 	}
 out:
-	/* Cycle through all hash buckets every BASE_REACHABLE_TIME/2 ticks.
+	/* Cycle through all hash buckets every max(HZ, BASE_REACHABLE_TIME/2) ticks.
 	 * ARP entry timeouts range from 1/2 BASE_REACHABLE_TIME to 3/2
 	 * BASE_REACHABLE_TIME.
 	 */
 	queue_delayed_work(system_power_efficient_wq, &tbl->gc_work,
-			      NEIGH_VAR(&tbl->parms, BASE_REACHABLE_TIME) >> 1);
+			   max(HZ, NEIGH_VAR(&tbl->parms, BASE_REACHABLE_TIME) >> 1));
 	spin_unlock_bh(&tbl->lock);
 }
 
-- 
2.56.0.385.gd3acb90ef8-goog

