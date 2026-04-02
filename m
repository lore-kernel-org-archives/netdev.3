Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE4C38F927
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161276; cv=none; b=lesfIuH9panwnjWDaBsmTPmy6YBNZfnjjP1gFlhNfxu5XHDN9W76scrGjL1HVcpgzd+LHixXRUBW49Wk3LY1yXJjZD22dVRWTpCK0BPv5IXXlZZDltU3Owj4fjUob1P8ZufGwVcUJDljw9cQ42D9kPJg/oUxdsw3QUbUoYczLPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161276; c=relaxed/simple;
	bh=hnchutNSKdERytZ29SHtkBya1y8wz+y2yuNMQGv+P3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6RRExD2KCzpkUcmnT0POfrkWfPDE4RTdHWmS2bNt82DPqx8hmT/MLN5ohh6hXj6BVXh01r7BM2SvGYV33mIhzyUXRySW8T6XcSupBB2LpbPYY73MTiJ3VIpx2qHBCLvCAAalxVo7Apv/i0V3IkneXaWbVekorbE7jy26s7JSDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=Nsft7Q+D; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="Nsft7Q+D"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82c70e4654eso600127b3a.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 13:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775161275; x=1775766075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jygRO2y1k21YPmAFcC26ldU2Kb9JdwnlpXm+3nNMbLU=;
        b=Nsft7Q+Dc3otstlFIV2ctsZKd4VmRxNE2xpcu1l4KcjFQxk28N5ibvGYGjTeMerKuj
         hj+SjG5CtPxcby/pAizCoN4CGJ2SqSdqDHWsKS3xofdC7z/vlKCU8O5L1536IjTe16v8
         WuLa9lofcbIR9QNlRj3a9/IGsKm8ylYtVmvE2zZ1vtFPpPyJVRR7RfQJghWF21WtTL2G
         6KQf2JBaj07yKuqGHMZRCOBgj7fdU5vT7krrJb6YP5i29nFrOD0Z17x+GcijyvMjpJeT
         iqlZchWQsSa+OHf5AdTylkGT4xMXTeWU0wjlAJ6bdl2SPlmtbPzKjjJnnwlyFNB71PkE
         G71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775161275; x=1775766075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jygRO2y1k21YPmAFcC26ldU2Kb9JdwnlpXm+3nNMbLU=;
        b=WFEnh1BP3T1tzax2UWWCIH+WemRJtX7adsHm3kZ4UR98evEssfgo3L/bKpVNtZtJf/
         I/KpbvJ62Wkv9DjlGC9G4DC+zrL+ae+kOlZ9CwuUbo0eO62SLNeHssO4syfDDE6IwPFZ
         iFGBVbasmYSwGP40h5NS4zmuNNFK3WnL7y2W0myuYDnSPCMztEC8cTdXee+tpK/Xb8yw
         9fCNU7s/mOi5lQLH1qcW8AU3t/GLC5iwQTRST2cPS8qiyVE8eFYouaKrcvetuu8p3okN
         8lVy+aGd1EfriX7Hf0yeKc4pXvvJyZwF6eQMozuykeCJde/rK/dH6wQNBAV6hRHu5JR6
         EFug==
X-Gm-Message-State: AOJu0YzXlwVWPBxe24TnttScPxGr2NYXZlvVbLCCAo+nt4rzNYrNQPDD
	rFB2CRMpYhr1RpGVie4D8KoBuUiTqptvqzbY2+EOPIoCvMKKQMtGALqSa83K4sWjdCDv7ynBSl8
	6Q8rn
X-Gm-Gg: ATEYQzzzdRP1Ag6Zo9kbIbsDpzEKcb4csMcAL3J89uMdJ4j4JixxOfI/UQmAFkeMef/
	p/MqemO5UMPPBtvlO/OXTtInwyyvitTg247MGWVesWUbpWt/5xPoQswRFQSg0F9wHuDsjfXbmiO
	CgVhM25/a1Hw5RAzoQUfQMppRP/9d4saibKaX8bBc/Wu/77NqmgpKU7l454kjK8LQ/Nw19omWJn
	wGYVixLbXqR/rFbKjmCYTO5GthqKRUhy0TdtfZzC2AsOm4mufV4Sw0bXPix/j2Pt3Ka4+7FJsPj
	DP8JVCkH7HMCqkyhEA9rzNN0jCLWWEVwq31eKDk9m1Lx9o55WZxJI0a+Y651rkf8yQEFAxd4ogN
	51gFjLZzB1qXdgeHq57b+TKsDV5DNEhdLwEiSxWreZUWBFdtcROMTuS8Pn40nHjcsJUBl3FdTZf
	2+kL+ax6cQKhmefvkBwYKhzF6me4qE+A4Y
X-Received: by 2002:a05:6a20:7d8a:b0:398:9c94:2033 with SMTP id adf61e73a8af0-39f2ef837acmr266911637.11.1775161275181;
        Thu, 02 Apr 2026 13:21:15 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c657dfb7sm3345621a12.24.2026.04.02.13.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 13:21:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Peter Oskolkov <posk@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3 5/7] net/sched: netem: null-terminate tfifo linear queue tail
Date: Thu,  2 Apr 2026 13:19:33 -0700
Message-ID: <20260402202037.176299-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402202037.176299-1-stephen@networkplumber.org>
References: <20260402202037.176299-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tfifo_enqueue() appends a packet to the linear queue tail,
nskb->next is never set to NULL. The list terminates correctly
only by accident if the skb arrived with next already NULL.

Explicitly null-terminate the tail to prevent list corruption.

Fixes: d66280b12bd7 ("net: netem: use a list in addition to rbtree")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index b93f0e886a2b..e405bf862163 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -398,6 +398,7 @@ static void tfifo_enqueue(struct sk_buff *nskb, struct Qdisc *sch)
 			q->t_tail->next = nskb;
 		else
 			q->t_head = nskb;
+		nskb->next = NULL;
 		q->t_tail = nskb;
 	} else {
 		struct rb_node **p = &q->t_root.rb_node, *parent = NULL;
-- 
2.53.0

