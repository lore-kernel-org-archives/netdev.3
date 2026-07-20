Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCD03E16A0
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542166; cv=none; b=N/QSyxnRMtVIkoIpcbag/gWvtOajEh9B00IOCjrtSsFbpJT0ObVmdUE8soxRQUuEQObZx4WDCv8zok/kxocwTclaWKqOoF7UonS9YGtj6ojxup8i6dRDWUN6Rjrchlq/zU43jr00whNKmBG0Y3EnpyFLBjdx/mpCmpw9lYBVWp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542166; c=relaxed/simple;
	bh=Rv9DeY3sVQADSDinNUAIAVGb1zyRUZLjDXTC9l8OOCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H9D/5+R9CxAtU+xdOzRY4vR2ir9QUHGVnJ6XAxIQwATrTvNaWCVxiO/m60d7VS+LgKmmZ1kQa79YToDT2FozcNPDuHYNbl/Ht50YigBbmXK24aoLsK/GD8vWneioYMl4FM0SO6ZPT5YWT6/DTy0YPmrGDTGNpERL5W5zpH4ujUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RgePxscT; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RgePxscT"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-495590dde14so12525275e9.0
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 03:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784542153; x=1785146953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m6RbzNK+eNCezcWvhoJEyPH0JtE0jxe26kaL9SwOJjI=;
        b=RgePxscTc3tyndwLWY8C9OJ6+UN0KcLZPpq7+QSabsOIJ3oa2vNEwOkCIih8+6GCqw
         BaQOAV2rNxgn6t9kwHP2hHC1lr3EbRWFsWxIbNtprJqH4wBaJsXzObkZDNVSdMy3Urt5
         TXCTpH4EBGIIKA0/SMyjSV71kerqYKzBmsohX4KF6/qg8LQO6kmkz6YxokShStUpstRi
         5EuxmbBoCPeIVVbv1OQjiG8rRZf0DgEOVDuqGDe6o7i54gE8nvH0UIKcjXV6+sqgSS5W
         7eC3MD4aG99JOlA4Nm2S/4pOmjC7kJVs9pDJEhQltrPMnF3KvfXCoh370PwFSqCZ/IwE
         OYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784542153; x=1785146953;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m6RbzNK+eNCezcWvhoJEyPH0JtE0jxe26kaL9SwOJjI=;
        b=G6uKTI5yfpdzzERbg9P5S/62rm35y6sU17KJjT9IDa6R/YdvT58nzgS8LugakCckPK
         VuxxJZ+JmDopJlmGg76TyKERYWqXi0zj2WOv9kXYbldW/1MsyiSaERmMyhBUW9pR2LB5
         WST1dkaIxMYLiqFSXlJsueln69RXbIBpzq8oc+2nP7m9YcnfEBCxmCpZqyAxVPQXenFu
         fIWcJ21wSf105mvCVvk94Q7Vtr7th4fKFdndmYEwcaRwxoaZxCZZoZ9maDcpssE4GqG3
         DTNWiIz+Yw0x1mzZzUzZHwh2OZ1dLhJVVHt3GatagYqFZeLXmtofeoH8He10s3KAC7js
         +Gkg==
X-Forwarded-Encrypted: i=1; AHgh+RpFD4GPJtLNMbP8o0aP9g5WcDz9oxmawAEyTf1eRs3/3tYA+7e+Jn8W46ff4UhFR7wQHQvpeg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxydYlYM/toi1Wt/w0IJIbl2QavnjSeCdEV3dN/oiINZ9QtTKh7
	SvhevZ2npJUJXD4tMQ/cllBEDjAP2oUvGZ0H0Q27NVbwinlt0cIvdVgAUDhs3Zo/MiA=
X-Gm-Gg: AfdE7cnk98GNm0n4PHUapTk1oJEvBkXjDxXK6xH9jpnvpb0h1sER0QOUXXykYIWAS7w
	9HhGXRX5W9iUTZKjYC7bqjpS1jxxBFepgJJjpg2q93PTLuSFywWSpZlNVHrB2IiUKVFsUD2Lvad
	TpSf2ABs6ebSaYK4rjNHpDwXSY5qU+e/Rkeih1aXE31+UvU5LamgfKudk6OnsdswiTLKAs1GmMr
	KbKKrRA8tFupkSEXy/tqqWgNvPJTdd2pzmLJh6Is4PGLitfHb0KAKCLRY3vGkIhFQjuM5S07DY+
	rnR0V35WihrHj+cyVv2Qe/UG1qTE922BqUw+eM1hftAi3xHHPM0Yr2vgD+KvQ5NKT0gDzeC5NQs
	rbIZEB4JmpZ83n/9hCBpmMpDm7S1eKzdE9kECisCsFUA3WJA6vvmm7X+8J2ZOWF0C2dgy9tvc6N
	WYe+FewMXjG5E55hQZqe+u1QSzBQ==
X-Received: by 2002:a05:600c:1554:b0:493:c10c:22f0 with SMTP id 5b1f17b1804b1-4954a50d963mr170983735e9.20.1784542153212;
        Mon, 20 Jul 2026 03:09:13 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2a2504sm294792995e9.2.2026.07.20.03.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:09:12 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v3 net-next 2/6] net: ti: icssg-stats: Move long delayed work on system_dfl_long_wq
Date: Mon, 20 Jul 2026 12:08:52 +0200
Message-ID: <20260720100902.155605-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720100902.155605-1-marco.crivellari@suse.com>
References: <20260720100902.155605-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently the code enqueue work items using {queue|mod}_delayed_work(),
using system_long_wq. This workqueue should be used when long works are
expected and it is a per-cpu workqueue.

The function(s) end up calling __queue_delayed_work(), which set a global
timer that could fire anywhere, enqueuing the work where the timer fired.

Unbound works could benefit from scheduler task placement, to optimize
performance and power consumption. Long work shouldn't stick to a single
CPU.

Recently, a new unbound workqueue specific for long running work has
been added:

    c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")

Since the workqueue work doesn't rely on per-cpu variables, there is no
obvious reason that justify the use of a per-cpu workqueue. So change
system_long_wq with system_dfl_long_wq so that the work may benefit from
scheduler task placement.

Cc: MD Danish Anwar <danishanwar@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/net/ethernet/ti/icssg/icssg_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
index 7159baa0155c..7d6d6692d819 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
@@ -69,7 +69,7 @@ void icssg_stats_work_handler(struct work_struct *work)
 						stats_work.work);
 	emac_update_hardware_stats(emac);
 
-	queue_delayed_work(system_long_wq, &emac->stats_work,
+	queue_delayed_work(system_dfl_long_wq, &emac->stats_work,
 			   msecs_to_jiffies((STATS_TIME_LIMIT_1G_MS * 1000) / emac->speed));
 }
 EXPORT_SYMBOL_GPL(icssg_stats_work_handler);
-- 
2.54.0

