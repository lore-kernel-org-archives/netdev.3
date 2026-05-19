Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B1547D937
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183985; cv=none; b=JrZ86S1NV4Y+87z7bXzat5e3flvwxUfk/MWGLnfLhWdU2C0XblVH9bKDeWjJoawm+6eYutKzgLQ+Gug+uY3jtkZQYgA8pf1iwhVEKR+xuTsyZpxcWYOHqQTP+RDaejiy6aUatH0ohGq5ZkM17h9e2x53gFUuu2KrWL2EJIUqWQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183985; c=relaxed/simple;
	bh=0rElNsNA/eb6XNzrEbgNcvVO7tiSM7tXaYa/QPkVlvk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N6TNCHA1WW+A8jwP9ApCSJVjOPpXPALLsUHU7na4M4rty+vVj3FZ97+nLMEob4SaQB/jxfcOW5ZW2baazPp7lpLs/yhD8Ni9aUZhprjS4OpAm4SzAdys4dHi9bqM6lgJwwrSL5qRzSQ14nN++Qb0awLEvBA49a5bfIvRXg/I/14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bhgY3C06; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bhgY3C06"
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-90d175ae52bso561534085a.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 02:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779183983; x=1779788783; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zLjwFt87P26Pi9lC+LK+r7j2frt3V80s4pt3ySyUPd0=;
        b=bhgY3C06Sz5tEeHzYvG4ziXlKE5pOpAkkETfNLufDhaAU8f+nYDnWfFOQaiVA7c8Bm
         xsKZ1sUF1MaUR4seILA+yvlnH+UROF3rVE196d0I7cBT5fhsP8Nw3Vp6Vb/3OUQo5KYa
         7WvkOW6P8d/syAm/nVaymBChyocfcb+tPfHispA2wKBAAQqB2vkaUBrMnF21Xhy/DUND
         zcz0mWJQaoD7uCDKhWSpvAI7rW3DKFO7EjlfSN9+Bwqbu7URihuPrnhLf/XIBnsdrRKk
         g+pN1EK/qHDHCK9FGiIOApHRXTU0iz+hqcPMVr6/sd/lZcJZoP4StDUqhh6zApr3GFrn
         Tvag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779183983; x=1779788783;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zLjwFt87P26Pi9lC+LK+r7j2frt3V80s4pt3ySyUPd0=;
        b=pTJgfxN8tuS/Z13a3fZ1aypjA4Uz0YyN8WaMmWdAR6hUfZTmO+HaRdyRwN6B4U0pf0
         4WRH+k7rn4YICNf7Jjd1GUR5CUi4/JhaO0B2Dx5vYDME8e4nc4WUWSNueCQmljJ4dXNT
         y28gFCYecy0nSrxkNEGNujWilskLcvn7jXS/eAb32kxV2Y/SfxnRffpnm/c3WpJJSQKb
         EfrE4ofgbpvBAR23BUWfUrdY5KFNLwDNy6tqVmods+IeHquptNn7bOpU687iTyvWvMwA
         IMgQU/hLW07rz/coLGt7gWtFAV9TgPeibBQjxz/Tih0LBwJ5r7RDTti/2F3mWBK1iIQA
         x4qA==
X-Forwarded-Encrypted: i=1; AFNElJ8duTkQTog0Ndsunf8AnOhXfgc3Z+tIP9D03RZNW8fnIyQ8U9zQZrLrNvIK/OnOYB/QhnnZ28U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7YJ2dMllRk9mkoLvf/V9+bkEId/MCaT62j5qrKrk5EltwHYc6
	VLQVQ8W9xCulz15EdjB0XA8/cz0ira6KdWZ9a/h6/ldAIZ6lJuD9fNJBybc46fKxyFOre62iFQN
	GV/uT7F0ibd2BpQ==
X-Received: from qkah9.prod.google.com ([2002:a05:620a:21c9:b0:912:b6f:1e86])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:c47:b0:90f:e60e:d4a8 with SMTP id af79cd13be357-911cdc4382emr2609888985a.34.1779183982763;
 Tue, 19 May 2026 02:46:22 -0700 (PDT)
Date: Tue, 19 May 2026 09:46:18 +0000
In-Reply-To: <20260519094618.2632073-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519094618.2632073-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519094618.2632073-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] net/sched: sch_drr: make cl->quantum lockless
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

cl->quantum does not need to be protected by RTNL or qdisc spinlock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_drr.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 7da8c7c8421b7f2477c7c07d3b5920b375ce029e..020657f959b575667f7a4b4d6aacd05c03c654a0 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -97,10 +97,8 @@ static int drr_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 			}
 		}
 
-		sch_tree_lock(sch);
 		if (tb[TCA_DRR_QUANTUM])
-			cl->quantum = quantum;
-		sch_tree_unlock(sch);
+			WRITE_ONCE(cl->quantum, quantum);
 
 		return 0;
 	}
@@ -251,7 +249,7 @@ static int drr_dump_class(struct Qdisc *sch, unsigned long arg,
 	nest = nla_nest_start_noflag(skb, TCA_OPTIONS);
 	if (nest == NULL)
 		goto nla_put_failure;
-	if (nla_put_u32(skb, TCA_DRR_QUANTUM, cl->quantum))
+	if (nla_put_u32(skb, TCA_DRR_QUANTUM, READ_ONCE(cl->quantum)))
 		goto nla_put_failure;
 	return nla_nest_end(skb, nest);
 
@@ -362,7 +360,7 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 	if (!cl_is_active(cl)) {
 		list_add_tail(&cl->alist, &q->active);
-		WRITE_ONCE(cl->deficit, cl->quantum);
+		WRITE_ONCE(cl->deficit, READ_ONCE(cl->quantum));
 	}
 
 	qstats_backlog_add(sch, len);
@@ -403,7 +401,7 @@ static struct sk_buff *drr_dequeue(struct Qdisc *sch)
 			return skb;
 		}
 
-		WRITE_ONCE(cl->deficit, cl->deficit + cl->quantum);
+		WRITE_ONCE(cl->deficit, cl->deficit + READ_ONCE(cl->quantum));
 		list_move_tail(&cl->alist, &q->active);
 	}
 out:
-- 
2.54.0.563.g4f69b47b94-goog

