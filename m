Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6957D481AA6
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240725; cv=none; b=SjE5oU8dpMdvVow+DE1ywnSs8zpXIIyIfHu3bU13D3MTIPRIfCo21kW8RxAQ8uqvGh7Mn4FDdnZ7fcmu2omCoM1aTUVwHcP8lLRFvfPO2bYg2MmXuAghx5Spx73oOLPQapAq5fDxErOXqS3gd2Z6WNj+Li/rtSt2m/BiILxvNhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240725; c=relaxed/simple;
	bh=tEbIqJ9ScsXQrpZQUUwhzSLwBjcVgFFowcmVtrPMKkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R92QBKEuT8II7mvsw3LyVBflDyS58+vB2TKnadLp+Pi7azfev794KviyzbCum4rr2HKr/4kqV6KBegkicFO2P6fuV6bMyLmaQWwTbDudzCIVtwoN6aE0wWHe++HxXFeqWJ5MOes99H06TUJLJKxPIuC4adDlQ35HfZNWEOXf3bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9p/61RK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9p/61RK"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-495590dde14so28280975e9.0
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 08:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787240714; x=1787845514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a1eX4DFVYT+BZd7oT7NYu1d4HaTZbGISixdfKYs3hNE=;
        b=b9p/61RKieSGCxstUo2u1RYhbYAgI7JKIbKqtF6X6sxt4EYLAdM04YGsZ81jvnkexK
         0mObEVDgz5CfS1WQ6pNc2e4Ing63seVdsKUW0U7cTs5BGCZWgz5xqrzFldcfRecQWM6X
         eCF8dJ/dqniqQ0Dn5DFgmposO7VzdKi3q0263+berpHi8go1Q11oeIPFLN04EZGshyfd
         7ghV66/tSr5snUdDiWrHa7oviqJRV+81zruwtfsfkXXajfWBwiRwwKPbByJ+f18XS82m
         yXeokb9KmqlYfy+AxgEWE4tNlxbJFEFBKPbfMCx3/amDTPDjzdjM2UzYJGsJdPwN3nl5
         2T7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787240714; x=1787845514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a1eX4DFVYT+BZd7oT7NYu1d4HaTZbGISixdfKYs3hNE=;
        b=qolQDWknEY+AbfF8O0JaBOz0gsYWREGKtuu8SoBp0fsIKldJJzM5snHxgiuB3pOUZN
         CluXxMIwVR52zOQopOr8NZYlI0p/e0TrptuA14VcdusgEoqiUjLd7qBEOYiXP3DxTdUg
         Dbsx27G65qvzMvQKsRkII3sqa6lzRA4hd39eSX1ttFzG3GiVvizxA+yccQHsCrgPQ7RX
         oy2W5vPuX5vSWH7OfSRPOQbFUwpwy3UMBBIzH3YLKFPrSKxFakAbD0t2V+qzqqitem6V
         yKtRKf2k9xNcJJYoYfl0dwsZNdcN69OIBf1zxaTFSQf9biO18+IjsNbBr6TRz4lJmkd+
         qDwQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr+Gea5vjkPbhQr6gQY8a/w3CEUUo3kmvGaL3vBeRuhxq1wukoeiwzD0W9BiepkCMjllyBnY98=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHp1eBLcmfx1bX5bmSQQGp1qIb24g4WXADK4ReXOmHqNDUXoy4
	qAWrdondkZSvz9Y7Va1NoS8R3HFEvwomHK2uI43hlh3+KEvHBUa13EhD
X-Gm-Gg: AR+sD10FLZm3N8cu83AtEgv5AzNVoSwoF+gexUiVGgIDl5owHIcAlOAnMZuTFN6f3K9
	kSZM2lLZSvbnHpDOZkhzL1GHEiCN+dMrhakGe2Lv5XlMOov3UARQ9KOUWz4/8xeL98VyQQQWwni
	dpO3qbgp8xnWTS8qIJr3mX/4l0ZgSOEhFTR9VkcXqCIvvb2n+tjPShK6pYvb2t4lXW9hZIxKLft
	f219MJj8YiW4wjdpaXHsXyD7wBnUlDmfPzGEt+RJMheeEjpX/nNE6445AgUJcj8zUoNRgl1D7sm
	2z2BJcWaWHmS4BFIOksj49HsyBuGo/jlTTe6Jt1CFnzpVCQLOlLPZOgVdIOQLM/kp+WcjVKb/Fs
	EX35sFw89YfNCC+XJglLzjOX5j0yxqbTxYvXhRCYwLBumZg+3OdktzEej0Ywj0bPVhmml/Y4tBz
	Y3GeXOe3zYrwos0EdbyNdr7Wx8+gDroiKasI/2DxIm6xrkj89IeMwEfViB2hZ8Eon5EXzxUpy0
X-Received: by 2002:a05:600c:8a1a:10b0:499:b001:b8d4 with SMTP id 5b1f17b1804b1-499b001b8e1mr129153565e9.5.1787240713825;
        Thu, 20 Aug 2026 08:45:13 -0700 (PDT)
Received: from unicorn.lan.internal ([2a0d:3341:b894:4600:ea33:29d5:6d76:8b36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b1450fb9sm13444652f8f.14.2026.08.20.08.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 08:45:13 -0700 (PDT)
From: Giuseppe Piscitelli <ooonea@gmail.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	cake@lists.bufferbloat.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] net/sched: sch_cake: fix autorate reconfiguration throttling
Date: Thu, 20 Aug 2026 17:45:03 +0200
Message-ID: <20260820154503.892214-1-ooonea@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CAKE's autorate-ingress path intends to limit shaper reconfiguration to
once per 250 ms, but last_reconfig_time is only checked and never updated.
Since the field stays zero, every qualifying capacity-estimate window can
call cake_reconfigure(), causing avoidable rate churn and scheduler work
under bursty traffic.

Store the current timestamp when autorate actually reconfigures the qdisc
so the guard enforces the intended interval.

Fixes: 7298de9cd725 ("sch_cake: Add ingress mode")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Giuseppe Piscitelli <ooonea@gmail.com>
---
v3: resend via git send-email; v2 went out through a mail client that
    mangled whitespace and does not apply
v2: spell out my full name in From/Signed-off-by (Paolo Abeni)

 net/sched/sch_cake.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index f25f60978..dc9326702 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1907,6 +1907,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 					ktime_add_ms(q->last_reconfig_time,
 						     250))) {
 				q->config->rate_bps = (q->avg_peak_bandwidth * 15) >> 4;
+				q->last_reconfig_time = now;
 				cake_reconfigure(sch);
 			}
 		}

base-commit: 24ef02f934eeb48830cff6b739abc3c62b1d107b
-- 
2.54.0
