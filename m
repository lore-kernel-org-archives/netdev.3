Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DD842376B
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238603; cv=none; b=U7BkDkr+jIUR9jpL1vZctWcJPFj5Knkql7oIJztHDWwzd+nHobavqa+qh9rLZdIZfb6jWHDklPpsyKMlIluUEUJIDb/sYjowWdmjNUTDDqq6GyagOc8+XI+7y1upOiMjv9ecKfESx4l3gwGDj4rvzBEtzmsv8/juneZUn3bHUF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238603; c=relaxed/simple;
	bh=dpfNwPwxZC0xvhJLWR4PC6LyuNksAIOkREAPllmRB8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sho6lpr9v4D4kJUeFtQozAyl1dhckqGiVg3ROJ681JNjrqD6KiTAsC4ARDkajZ+dnFPxPX9hZE2kAe0HKcFrKPkp1LOHcDsolV3bqbWagmpJ6AbTHpCrzhdebLvdkjznUkYExkAeSc1UuBGnJHk5J7Ps8MsXVL0R1IWutzj6iDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aCcIiBzm; arc=none smtp.client-ip=209.85.160.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aCcIiBzm"
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-530d86d40acso31614081cf.3
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 01:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790238598; x=1790843398; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JaZqp9sCogpvj9WCtEXWvO4FfmOnRMiXK3W2MfQJ/B8=;
        b=aCcIiBzmRRtXqAn6CWc9cR8GqfDHZa7a4Qns5Br9XJzj166186UGtqYdaZyV8aWHm5
         qSVD5WCZj6tKHXBilbVxGTCkXpx1Yu/OTEJ5gTXCgZ/yddsg6Bjx7Bqp8TryJsMMWV81
         weLLAZ8Xwf0ZAGNAlIgxWLV9YoGZ53/53KP7/26ANQTAKfonDY1dfCrv4GfWWjkbw9YT
         kznoRvlXNTblcBaGNzssby8AAEgNkEBbQg+gaO8ObJeRtN6KoT7aoOCkJyB5bWXTEk/f
         K9wP/Xbvs/X7pRjcNN6VynY4XepVPHWkD4tIXclkXH/p9m19gGuuSkJX//zYTB3h8r4c
         XEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790238598; x=1790843398;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JaZqp9sCogpvj9WCtEXWvO4FfmOnRMiXK3W2MfQJ/B8=;
        b=0ilCl181kZt7dPLjvlUJVnsBFVIMze3H/L2E6M58x0l/wT6F5oBkpVHLnmCrDF4Ti6
         UwRqEpOXE9Quo2Z5sB3toWZVfSA0369zKXBVmHDt5zpHW3bt35lN575sWoMoSw1SGtJY
         0ndJf366TcKkrSvnsVUFYKazg22fXtTQoGFAteRORthPz7pCwu7l6bLZL2XHJNJPVaiD
         y+MtMWDpzdheQ1K1otjvDqn8ttLdycFaB4FPwIv3EleyoUh6HwGy3vzAZ8jvk5q//7Pj
         MDPZHgKtypcPrE1Y/zwDNlTecEmPuG5IT17Skg7UmK6aECDrWGyiMPBtDew6Ng83iAWL
         910A==
X-Forwarded-Encrypted: i=1; AKwUvBzZ3Kvb4ONqz6lAN+WCMf+hK7omEJq3nxrUxdxNUVdWz7nrLR/IqDW6aZRGvFrOUEgwAl/a6Ko=@vger.kernel.org
X-Gm-Message-State: AFuF++mZ0rHIjGEQIsJ+cAK2XsHEDbrpY6DYqzN2VO2vtjrzxJZroouX
	8Who+lJhT3XgeGc8OwAw43JCi+6XByGugNpuDsmYZSOiis7YDBWdESBUdhhws2eF2bOi+WVyJaz
	Ajdfs4Qc1d27OXQ==
X-Received: from qkr17.prod.google.com ([2002:a05:620a:491:b0:93c:348e:c518])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:bca:b0:93c:2946:5702 with SMTP id af79cd13be357-93c36396b7bmr187680185a.39.1790238597485;
 Thu, 24 Sep 2026 01:29:57 -0700 (PDT)
Date: Thu, 24 Sep 2026 08:29:50 +0000
In-Reply-To: <20260924082951.1599377-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924082951.1599377-1-edumazet@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924082951.1599377-4-edumazet@google.com>
Subject: [PATCH v2 net 3/4] net/sched: sch_teql: fix shadowed err in __teql_resolve()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, edumazet@kernel.org, 
	Eric Dumazet <edumazet@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"

__teql_resolve() declares an inner 'int err;' inside the
'if (neigh_event_send(n, skb_res) == 0)' block, shadowing the outer
'int err = 0;'. As a result, a negative return from dev_hard_header()
is written to the inner variable and __teql_resolve() still returns 0.

Remove the shadowed variable and set the outer err to -EINVAL when
dev_hard_header() returns a negative error.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Closes: https://lore.kernel.org/netdev/179022851638.2160803.1808206741379444999@kernel.org/
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_teql.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 9e52afc2d9808cba5a404dd9c1a6255fc7e5485d..409ce50cc0dbc7936582d5459c4c31c680177b3f 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -265,14 +265,11 @@ __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
 	}
 
 	if (neigh_event_send(n, skb_res) == 0) {
-		int err;
 		char haddr[MAX_ADDR_LEN];
 
 		neigh_ha_snapshot(haddr, n, dev);
-		err = dev_hard_header(skb, dev, ntohs(skb_protocol(skb, false)),
-				      haddr, NULL, skb->len);
-
-		if (err < 0)
+		if (dev_hard_header(skb, dev, ntohs(skb_protocol(skb, false)),
+				    haddr, NULL, skb->len) < 0)
 			err = -EINVAL;
 	} else {
 		err = (skb_res == NULL) ? -EAGAIN : 1;
-- 
2.56.0.rc1.310.g51773c2048-goog

