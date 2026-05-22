Received: from mail-vs1-f74.google.com (mail-vs1-f74.google.com [209.85.217.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97671395AE9
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779447840; cv=none; b=cDV8imSRLm2lcR4lX4HinB788y9bUHy0sV2qab7QrsdGCb8nSyTXABp70yUdAu3+GViO9xa8OS1S9ObN/G5vvjnZThdavM/LU8GoPahpV+5xOP6FdTbt7RBGZO0gJnNaSKaZlL/fBXGnHOXZyhaGXymdRXuKUeYKQ+DihJqo8vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779447840; c=relaxed/simple;
	bh=mTOA8zAj211HeoZy88MinqxeoFnlsEEBhZjSp+cSTO8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gDx6WzOm4I6EKYG+tl2YjskOpDiC+vETD8o+rS031gpHmnIww8E8ogEbvpD3QkSjw4ZJ3u5fm6Eun+yiRO7ImoiPv7Hx+SFnhKeKi/6SNV9uvywUvn8KbufRhjXF8snCzLQ1vz9ejsZOiuRY8el5M+Lb2oslVM4W7KSX4kPqxno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gcBkcNbr; arc=none smtp.client-ip=209.85.217.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gcBkcNbr"
Received: by mail-vs1-f74.google.com with SMTP id ada2fe7eead31-6326fc1256aso12345725137.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 04:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779447837; x=1780052637; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lke+m6r3rYhdtXVr/6W/lt27OACsrV/DCNYNkgz/T7s=;
        b=gcBkcNbrfJamtPKaFdoLBq3iBrAvxXMNT/Zf2MSptugNO0OTB71b7RIV1JBFOsETHr
         jPvj2XMki0jZN1KNtElN8ORHIjZcDBzGCxJlNC3sVBmfVAF3RAONYPAm3pgzdYkvcpTZ
         aHtb2ZS1Int3hX7ieDRqbtpptDYRhZJMEQNhBVZ5MaJDWqLFtpLmK88nUP+xhMQkUCPp
         gLCK66B3gONKK340QhSeNWHaXAw5eANZs4TSg2B3gxXmMVw3+niqsdNdT5O69t8xqoZx
         K9A1vkvSwsD84/mtBu1ob/GX3K7HlSpif3lSF29CqT6yJ6WKJz2DHz+P3u8p1PNPi5kh
         zqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779447837; x=1780052637;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lke+m6r3rYhdtXVr/6W/lt27OACsrV/DCNYNkgz/T7s=;
        b=po6UXrqJ+P3ujRfDih877l9HzrBE6kXaT0eD2TDbtQZL6CTqKwjYHjZK8XTdahXzNO
         d3seLEEwyz6+cuNqNdCIb4DMxYjWVfsjWeSvvmfccbeirN3WbgMcetfsf8fjBUKDUMZ7
         QIYr2BD66/lDpASwTFULLs8u2RdqvQXSs4AkWZ2eTwBNIpspFUwxkTKLjAgnWz3NQg8K
         QIunt47GD5HpQl6P28Ev69R6YctCjiyWCrvIjRNGaekPZEhb+sBY4boTUkAKDohLOGrC
         9bhMD8GmWVSegA8eBho74iOLHyEuHxnnVameI/EGbhx0mh8sFIQBgdCtztxwDwuR4N8i
         zSSg==
X-Forwarded-Encrypted: i=1; AFNElJ/uBD5dvkfduPz2/XFITMDvDmuhoPwKq5JsKybXbaP4XRJ9S0xEDsHPPfQc+BRnI2x52uhdaP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJPs19j4jqnUDQoGAI0uscpks1M6hS01Fuv/GkC3ZjSFVqvU0L
	KHC9vdiy2dXljpmb3R/MjTFXfGM6MUN4BUY8f0YqQp/isUdBojbH8jw8ENL0AyEhoznERnZj0Qy
	gR0UVetkdCjlFjg==
X-Received: from qvqs12.prod.google.com ([2002:ad4:524c:0:b0:8cb:2fb7:897a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:2b90:b0:610:db51:6f3d with SMTP id ada2fe7eead31-67c73e722cemr1388168137.12.1779447837426;
 Fri, 22 May 2026 04:03:57 -0700 (PDT)
Date: Fri, 22 May 2026 11:03:56 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522110356.1403343-1-edumazet@google.com>
Subject: [PATCH net-next] net/sched: sch_ets: make cl->quantum lockless
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
 net/sched/sch_ets.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index 1cc559634ed27ce5a6630186a51a8ac8180dad96..cb8cf437ce87086c9eedf777dc7610137d5e09a5 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -247,9 +247,7 @@ static int ets_class_change(struct Qdisc *sch, u32 classid, u32 parentid,
 	if (err)
 		return err;
 
-	sch_tree_lock(sch);
-	cl->quantum = quantum;
-	sch_tree_unlock(sch);
+	WRITE_ONCE(cl->quantum, quantum);
 
 	ets_offload_change(sch);
 	return 0;
@@ -320,7 +318,7 @@ static int ets_class_dump(struct Qdisc *sch, unsigned long arg,
 	if (!nest)
 		goto nla_put_failure;
 	if (!ets_class_is_strict(q, cl)) {
-		if (nla_put_u32(skb, TCA_ETS_QUANTA_BAND, cl->quantum))
+		if (nla_put_u32(skb, TCA_ETS_QUANTA_BAND, READ_ONCE(cl->quantum)))
 			goto nla_put_failure;
 	}
 	return nla_nest_end(skb, nest);
@@ -445,7 +443,7 @@ static int ets_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 	if (!cl_is_active(cl) && !ets_class_is_strict(q, cl)) {
 		list_add_tail(&cl->alist, &q->active);
-		cl->deficit = cl->quantum;
+		cl->deficit = READ_ONCE(cl->quantum);
 	}
 
 	qstats_backlog_add(sch, len);
@@ -499,7 +497,7 @@ static struct sk_buff *ets_qdisc_dequeue(struct Qdisc *sch)
 			return ets_qdisc_dequeue_skb(sch, skb);
 		}
 
-		cl->deficit += cl->quantum;
+		cl->deficit += READ_ONCE(cl->quantum);
 		list_move_tail(&cl->alist, &q->active);
 	}
 out:
-- 
2.54.0.746.g67dd491aae-goog

