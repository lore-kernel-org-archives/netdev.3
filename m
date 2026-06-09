Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9AB246783
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 00:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965682; cv=none; b=WErClMUBbC7FzHeivM38d/GzTncy9VmT3vRMAUVhci1EEaC3mpp9Yqh2114sW45W9knVQ2DOOUL30uJWKb4UaWPf32V3aV6IPWIjgSvzG6/tXpZu/QVGB/8CIdb1cHgo6EaAgZzTrX5YfuSZoI8Ud+xxj2ZQ4mEGlNEvJrGel2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965682; c=relaxed/simple;
	bh=yMdhseqWo90O722IHDMJjBQLlryLdKcFA01iK/bwCVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YKx6JfNaBs5dB1Nb69ik6gJNb1+NFJjogqosSRioocrUHs6wocc2HOw+6pyGEx7eBokIyX679V3N39OOtsbutkNbPZ7QWuTW/aMnj/MAokyUznQ9XMMhbdNyXDME3u8AEwtSz7AiVKH1MzNZJLDwDkAIy1M8qjrh/WVBCtrkegc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=WtOZkssl; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="WtOZkssl"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-915bf8800a2so280991185a.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 17:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780965680; x=1781570480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zkV204jEuhHHv8VYaNEYsfOOb10+5uAkAOmYlY3It30=;
        b=WtOZkssllymybYVhX6DZbIeQAebBIEXGXAIzr0DIogLBvefxsUiW10/7eS/UKvnXdf
         fdTS4Ua04yDjTlcTtsWkv7MDLBhQYxI844lG2WU0dbbxwmc+ha2GOxA9QOlk1UTwtdu+
         ryB+eLIaNYLYzOHcaQRWIvOuvsgYnpPE2tcP3xls8RmJe5WfdqXaE2ykj3OQk1A3cBQ2
         JZNwEciJaX72jaafE9YK31PsNks4HR2p+3a9XcRIt3nLce8tnWRsxh+K4divjymK4us6
         vQtWOSz0K9jWJ3NGF+ELmiAvMVSQUUUXY1aZlP1wzruGT+tvso0Aqngn6l02IcIsLQSX
         u4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780965680; x=1781570480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkV204jEuhHHv8VYaNEYsfOOb10+5uAkAOmYlY3It30=;
        b=e0e8I7y5DTcgQ/qDzwvDVz9/weB4kph/zY67aDDeNsor+QsoXp0eyKH8u7JQ4n/9e/
         uoFLGSIhOr+1NJCjsPNJAfZPWeb8HxrW82/dJP4OgCz1wJVg0xDN+090vXJ6Vy6xo3hF
         IogPNvfB6S1jzxoC4FTACFwfVJAfiCSpruIkruaNoQcngzJhUApWVT2emyQS3R54CReG
         ec0/h9au7lfSnSwkGwi+n+ZMXwlCbgGMQZ9XiGsPuriLw6iN68P8pl+AjkSrxF0F3NHz
         /EenuLOIMUbxA9eDT3xwFgV0VT0zejbkKi64zynDzLsNGUfSQKg2HjUP5Bgd6pdSf1De
         quUA==
X-Forwarded-Encrypted: i=1; AFNElJ+EmRYsbEe8LQN/HIUyWy7q9h6guFTFkFF9RaaWItbRgTJHy9ScEw0gG8RJyOsVg5c8rgTMkcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDxPsHVDGfW+Z/wfm09Gh32LV21h21WjeKkhq3igJ9aa1b1bPR
	qedaqiYKhC4bGweBmPksIdRPbW4cDZQEBNgoVHYhdfSAX3os9RsoxcfFahsGvRiVIfc=
X-Gm-Gg: Acq92OHfxXqLa8bhbo2E/L0iFPdGiOZBANC8RiyqR2RyKRziCNsttMX9UNurkEJiV5h
	JxzurfG2J4o7CFZ/3MEmTvuWofyplhw6ou8H8sD5JAWmbPx9rodd/v/l0O7K3+kqbaL7leYWF1E
	Lbka+k5rtwejlju/+7jW2L6YaECDfF1TtaDe/nw+7SxQTkyrpXlJgtvXiVTKCffI2poj27d5Y6k
	7W57a1ecog8EiDIueZEtDWtNIwNbdOkZ/esJCRmN7dUIQmvbjFQTib5tWE/eeFWsAIWWB8/BT+e
	G6eI4q0hP3EVAd8yflQTY1q2On8f3ypy7SeBL691bng0/LZZou8GO6AXJ+kOr1JJtIyzSOktbOx
	l4ei+ZkvIKdNy9V3vty2dfU+BmmW/GAaSVD6jimcejiC8RZfvhQwLxN/am8r+ZLhJ2pl/PorfCl
	yjqkKvXSbNeX5n9txIS8EOGwIayG6webqr7npsvA==
X-Received: by 2002:a05:620a:1a1e:b0:915:e932:9f2c with SMTP id af79cd13be357-915e9332007mr22533285a.52.1780965680062;
        Mon, 08 Jun 2026 17:41:20 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9158a381febsm1869394085a.23.2026.06.08.17.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 17:41:18 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org (open list:TC subsystem),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net/sched: fq_pie: enforce memory_limit without wrapped accounting
Date: Tue,  9 Jun 2026 00:40:26 +0000
Message-ID: <20260609004026.1238860.be23a168aecb.fq-pie-memory-limit@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fq_pie checks memory usage by adding the next packet size to the current
usage before comparing against memory_limit.  That addition can wrap and
make an over-limit enqueue look acceptable.

The scheduler can also fail to enforce memory_limit consistently across
enqueue paths.

Use overflow-safe accounting and reject packets that would exceed
memory_limit.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 net/sched/sch_fq_pie.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 7becbf5362b3..752c1c32913a 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -152,7 +152,8 @@ static int fq_pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	sel_flow = &q->flows[idx];
 	/* Checks whether adding a new packet would exceed memory limit */
 	get_pie_cb(skb)->mem_usage = skb->truesize;
-	memory_limited = q->memory_usage > q->memory_limit + skb->truesize;
+	memory_limited = (u64)q->memory_usage + skb->truesize >
+			 q->memory_limit;
 
 	/* Checks if the qdisc is full */
 	if (unlikely(qdisc_qlen(sch) >= sch->limit)) {
@@ -160,6 +161,7 @@ static int fq_pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		goto out;
 	} else if (unlikely(memory_limited)) {
 		q->overmemory++;
+		goto out;
 	}
 
 	reason = QDISC_DROP_CONGESTED;
-- 
2.43.0

