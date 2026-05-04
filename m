Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E142390CB3
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 10:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889627; cv=none; b=ixo02JC+sf3dvXtXlCH0XgrXUsEgd90oiwJ2CQwoP28K80Oxx2y7y84FPV9FJyl0YW/ItIDEnTm9usUhLx61bNZVC41ZJTdVeiIyBprcSRcgOZgJx5rXiaSw6qAEfSmBd1O0zLpwUcNcN7xQu8bjt65TrbtLZ+PHTILLNVj0310=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889627; c=relaxed/simple;
	bh=GBdaPFRBndABu+g6xyTPCYH9U8koFL/3jkPmvZnpAtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQASrTYVryQ4s8naEyd22Qp108K0i+nZ4WTxE8J2azlLYFYGGlxJmB4I7LOvgwKNGcF/krXeINtaW+Z8sDNBsUOsBDbH3IevfcPUm7fcsiGZww9cAuYZz3wudBVRMC9WeOn2uSKzTmyRPYc5HBUBUyhLtvkn9pSSael2N2ZpIQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6lXpdNK; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6lXpdNK"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82fb2d0c5d1so3045173b3a.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 03:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777889626; x=1778494426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/HtMUR8y8tNvQTsqYRM6w8nnbZCwy6OiBJMOowLZxI=;
        b=J6lXpdNK4yWdKQmAyOEeuPSi4LIgc9NGVQL54dFtvBJPa4G0gyts/uxhGPwoLtCzSt
         qEu6LRgSeTCa42aF3mKWSkifz4I72mhvQ/rf/YMAO/kIi0Jk84wuApr1vWIpcfrVAcg/
         FQrY1c7UOwd6KtXZ3QD6E1ndu4s4xmjJqWx3PCI5J0917CApUmGCEtLq9AgRfy/bKQdM
         jTYNaQSWahlMTteQPu05nnw163/FQHQOGBEFJdR4HjNUf5QR1d6MSxfD7qHbiQyHcL5e
         +pZjsAB1ZIzZT2Oi5SpzUIGLGvsORCBA6ZG1r0mq5k6e1CbWfEJ2AQQHnfnUcLpblbUk
         vOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777889626; x=1778494426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h/HtMUR8y8tNvQTsqYRM6w8nnbZCwy6OiBJMOowLZxI=;
        b=CF+iJdSSfPiQy6UhR/KJZUg9mlsDNk3OJc732OAn3DGsVYw44RC8CxoqDZcF6HdpYQ
         na02C/omFVsA/Y6HjM8ODs8JoC9YT/PduuCw11jnb2ME5nGCeFuCGye3/kydtDKZNfDv
         YQ43VyFqC+rRS3jS1rA1mDUNO7r4LGjBI24HDF0qWofuuPjYdGRC2GqHNSxeQeE9cMJT
         klteenNgrM4tYqxyHCd7XWXCameXQwBCwF1Zmb/J8GyYdz9y+MnJrX1MAHXM3rdHOeO5
         R2v1h61oT3tJuXj+zg4R1whBfIFMS+GWPmUoFMSDh2B+EOcMhyEsqjJ9jJMI3/7QwA7u
         v7yQ==
X-Gm-Message-State: AOJu0Yx3gBVKpdIFhWAO3SuwuWgRZRHO1eugAi7tZTTBMc/VeOLJsUl5
	MIyRZThzmRp68tKvO3HbqQWzXTeDmUIxHkhHSDwcj7RyjqCxBu6OVOxVxdD5nrCU
X-Gm-Gg: AeBDieuRnZt+a+bF00rw964IHKfrqsUieF0rx/TQzgfuXNOtar1YlkOmy6lvt8tzpNr
	kDKfc/RgJR1si2wXWhRndLBHqY0rUgJBIuprm2V01PE4UBPKycL5rORJH+rVZPpo1fed+nAb7Xx
	gyMnHeUrTAu23ComY8S0/uoV/D6JmSx2jd5qIOAUsimqKqMwGi88FzuPa+D1kOxJ/1WSsOzHA/x
	t/i/5kcl39CsOufhXFYm2vvjx9dDeynuwExSPsgiDGA0hTbYniAo0qxGkqtc0NYVVpbZt5b3cD1
	fifa6012T804r9mVP4NOpTk806qMAQDAguZGqjcKQgwPEdfB1KVMLXLfpWJUgivDym6GVA9oZ4e
	kmHpvp88ThXPxHhdB8TTulk3n6IClgGypWtYG12mfusvjRUOpIs/faCzoG8huw6/8hzdFBqvIOg
	knJUd8ZyoMy+UkKC4ie09LIAJTz7s+K6+r3E/yzoRJgZgKpBZlkVF2VfskcGJhhMj7YAQZWE4=
X-Received: by 2002:a05:6a00:299a:b0:822:69b2:7ed0 with SMTP id d2e1a72fcca58-8352c3b0cc7mr7391366b3a.6.1777889625685;
        Mon, 04 May 2026 03:13:45 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6619:3046::4cf:90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-835158bd62fsm10813486b3a.24.2026.05.04.03.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:13:45 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/3] net: sched: tbf: pass all params to offload users
Date: Mon,  4 May 2026 18:12:54 +0800
Message-ID: <20260504101258.1608004-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504101258.1608004-1-mmyangfl@gmail.com>
References: <20260504101258.1608004-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drivers might have fine-grained control over queues. Pass all available
params so they can make use of them.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 include/net/pkt_cls.h | 6 +++++-
 net/sched/sch_tbf.c   | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index 3bd08d7f39c1..d73c04e3d919 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -1040,8 +1040,12 @@ enum tc_tbf_command {
 };
 
 struct tc_tbf_qopt_offload_replace_params {
+	u32		limit;
+	u32		max_size;
+	s64		buffer;
+	s64		mtu;
 	struct psched_ratecfg rate;
-	u32 max_size;
+	struct psched_ratecfg peak;
 	struct gnet_stats_queue *qstats;
 };
 
diff --git a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
index 4576111fe075..8a1110d59dec 100644
--- a/net/sched/sch_tbf.c
+++ b/net/sched/sch_tbf.c
@@ -153,8 +153,12 @@ static void tbf_offload_change(struct Qdisc *sch,
 	qopt.command = TC_TBF_REPLACE;
 	qopt.handle = sch->handle;
 	qopt.parent = sch->parent;
-	qopt.replace_params.rate = q->rate;
+	qopt.replace_params.limit = q->limit;
 	qopt.replace_params.max_size = q->max_size;
+	qopt.replace_params.buffer = q->buffer;
+	qopt.replace_params.mtu = q->mtu;
+	qopt.replace_params.rate = q->rate;
+	qopt.replace_params.peak = q->peak;
 	qopt.replace_params.qstats = &sch->qstats;
 
 	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_TBF, &qopt);
-- 
2.53.0

