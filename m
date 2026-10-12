Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380434779B1
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791798917; cv=none; b=LaK009FKULJrxgDEUA6UyMsO7Mzy1Q56KcApTVR2lXY4fiv0w3NLW2awY+5QrkVCL3ZswvHdec9HB5TqO+m/ZjSYFK8aqTZ5UiBAff3PCj3yGLUjdKc2jMnqMXSpkM7M4VSiKXRw/b55AmpRpBOFwt3S4qhkNT30fT7rlb2XEbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791798917; c=relaxed/simple;
	bh=4YHiet3WJomPE2v26NzpBGjI/jedOlYKrNCQC8kfQY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ugg1lUMtdL5CK5G7fo8RFCpfyWgVMD37UxLEF4UujZ4mwmwaWw+RHaSmRkw/2xCpN+w+hG/KdbK/26+QJaozhILWtFg7GV8GbFOxjUNE0qZGh31wv2LBBhFY8WMKI4yRCPIghVFVGC+JB7u2oPYMz9aw9ckwk8a3b0MZ9GzVX2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U3jg9ID8; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U3jg9ID8"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48af27fe287so1435970f8f.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 02:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791798910; x=1792403710; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wvY8pxckv87pPYHiPwsm0hl8WKWmZCkoV9NdQknppn8=;
        b=U3jg9ID8yPFqEhcnXfUQpOfjfKF+QPO3ce35bQgRWDMJsAqB4Tj04Jni+s7rzj1IZe
         jcweuNi5QL0CB99c1+pBSa9Th/JUl3+Ti89eskfS/HbFVVS98RhKTS4c6vTEjc73fHa5
         xO6ctjgqGb7Sw/ls0NNR91p5HI9QML8nGIJr/x4BpGZWf9QvTLPbVMXHorNep1MyMQRh
         54HMJ7YJBgHr6bY3WDKUyYJBdDkXCpbxgEIigaXxbvqITTDqoCI08mKnI6RS0xjmgM+r
         uStEafhl44ZF8OY1GW1maLIdtGyWnWQKZ8yMev5Kt1gt3pU70xoxWciwBOFJt0tabNZS
         lpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791798910; x=1792403710;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wvY8pxckv87pPYHiPwsm0hl8WKWmZCkoV9NdQknppn8=;
        b=LxZAojXYG+lptOLKNjLWIzZqrxa3wfhOY5D00E2a53C9eUo83AVgJnCQG1oLxd2nsQ
         HczVdAAfyVSh5xjMbgPIUrcpJ3k8kcsusJf79+cQeDclJRylgzAwIYVu9HKahuDUBSsJ
         OutiQMz3dS2f3FjjPz2Q2+Sr8UqKkKXQ6J0YsKzaMNiQzodxm33YWiaKuih/qwqpZyvi
         z/beXeU8kzNG0+/CNMRSE2NpPb0HyIURxq16g40nMFc/IC03T8ZDEw3hKJRRPcPOhyLE
         BgbaPFjvfsOMyd0rMmT89RLOj1feNngVFRz9IseIj3lxrls1vyHBQfulS30QUJMikxsY
         tRGg==
X-Forwarded-Encrypted: i=1; AKwUvByujETyHQim/VgSVFLk+m096nvKZWKgH4QU1A1oBxQs3mXtl46jEMsyAdrg8ZWAjmi2pI526+c=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPRBkI042tzOtpYg0Ws901sRyFfZQ/hP+i5L+lpXbCuRF8pFn0
	wEcY/vut5fJn0H387eRGsWjEF86nRoazanyURbqY+xK+/nduySjxo4JBuU6JDihAjJAeUFgyQIm
	BFc+c3P8=
X-Gm-Gg: AYBFou0MaqlPce5SR8YhapBzuut5lXiSm3wTaFkoQXnbiin3grB7wq41HuK62Bn+UCv
	9JUfi7u6jn9EHrEBpWkjRXsulLXRoyJLZSImzomDzmSNHrpFGw8uKh10ISC9bR1o/MzLjX56xpO
	qV9c+jESGR3trxGQkTwnmVNDJUCeX0GfNAAgZW5KEfoLz4wOTmxxpilcj4gR3HPyvciMBaAhsnn
	zwLVq017kvg2p8rGsP/eXlF5ka7XnbbToCQcTIkdcWAkAHqmzw6LDlKGGYehr2bDmVFdR6AjiyE
	6wfLyiqRfSbRLkKiO9xVFsXb9kXTfqfgONT+W/IfXUMvlE9UHkGpdbKf+DKi5wAQFA4kBLIgQLC
	ysDe/59P+NJ8MlyJ/qKjjkgR+P3UViXhsq3UPK4oSv2dG162DYqDwfLheyTHbokGf4D+UrMbL+B
	PkHtCgBWll2LvCgaqeRRKC9XLpNN3OTyLNNo3YISSnNh71a+mEup1LlHe8IGWlEMWodgVRvWiYX
	2zJkfr5ejx3sghuytdD1g==
X-Received: by 2002:a05:6000:4550:b0:48c:4d74:d7d2 with SMTP id ffacd0b85a97d-48dba9db092mr10670448f8f.12.1791798909689;
        Mon, 12 Oct 2026 02:55:09 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db98c2800sm18539103f8f.26.2026.10.12.02.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 02:55:08 -0700 (PDT)
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
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH net-next v4 3/6] net: ti: icssg-prueth: Move long delayed work on system_dfl_long_wq
Date: Mon, 12 Oct 2026 11:54:42 +0200
Message-ID: <20261012095452.135828-4-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012095452.135828-1-marco.crivellari@suse.com>
References: <20261012095452.135828-1-marco.crivellari@suse.com>
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
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 591be5c8056b..0fba22c1046e 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1100,7 +1100,7 @@ static int emac_ndo_open(struct net_device *ndev)
 
 	prueth->emacs_initialized++;
 
-	queue_work(system_long_wq, &emac->stats_work.work);
+	queue_work(system_dfl_long_wq, &emac->stats_work.work);
 
 	return 0;
 
-- 
2.55.0

