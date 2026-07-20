Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC813DCDAD
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542167; cv=none; b=FFBg2d5Tm7ZrO2BOeiqC9ylV+MZkpPFy4va2jXY+6dIb02WeKyCQzLLo+OTW4IxPhfGYbTwzDSd2ZYanHvCBy0bDVtafanujJbS75pcx/Y78gLYQ5asrFd4ig/08Eph19Wbd010qd3oj6XsuwqcObvPe20R/1O/d0dtgolTP3p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542167; c=relaxed/simple;
	bh=lpEOlelEDdowQ29B0K+0uxtyLSj3QirYX9EDl3TuqDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQALLZZQN/zwaD+sr+vvPMVGVGJOL3C6ieev+QIj0i2zbRjoKyx8/ahfig/C07tazwdo9ElplHNvUCQWduMq3vOXq6mvZjXiUZ3WUbfhYRCR63WXrrrD4ql7TZubbfQGBEGBp1n+ik1TeQ3vC8s5EquqKQLYu+qTRMDlaXORzdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B3hgWBVM; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B3hgWBVM"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so8961805e9.0
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 03:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784542154; x=1785146954; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2toGQllSDboah8Z4uj+3S/HCH3zIDshmSqNuhS072dI=;
        b=B3hgWBVMsj5d5/RdcxR38adGPDqr0SMQ8CgN/UFro7Ea5xKEQ+j4+e3B9qrYEzJF6Z
         1j0PY6EE/hFK2if4/Tm1TLFr47TElTt2kYa86Hc/RGi+z2+H9RQMXjlnaf4xdBYCCdqq
         2ifRvjie5pZbqdtlvUc6Sbgyi23+lpwXStRtpI3XJN8uHI1RZzhCrAWavN8Z6ugAYOqe
         +IP3P32WuhVmfr8wA/0VUULXqpJEVryPjkrDqUlK37t7Ka+RUlpXnlDmIG08WDFLw7xW
         TZlhxXfFVJPWzme296fOIWyNWXIaNkorM3KhxCJ1R3m0YK71piGTyDfH2tDUM7tgq/ZZ
         T+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784542154; x=1785146954;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2toGQllSDboah8Z4uj+3S/HCH3zIDshmSqNuhS072dI=;
        b=aaJ2OOGVwZCTEGx6VZysiS/ij1DEpFLZoQhlUWlJ+wG4owKd2HbsMLPBnxyXNpV9zJ
         7wcg0y9CT/+t3t8bMdrSlMsl4fLGUrjek9L34jNSiEg8jD/CGA7PVbAQs7z2oBR07465
         c8eVDVtSf1AMl+R1bahLvQIGHUzuabDLJ0yAYyPAqgTD1Mm/pQHWArruZ7HurfvrwDOe
         FySJZAqc2zhHE8P9s3CXKs6XqbhcAOqcuKjF5fvYzqOZFJN2JVt9NYnmrDRE7GNM9U35
         5cf8H0dIYsAMBmx+EnRPvpbQVmlXYEc+sG97swak8MS+fqk5WTmd8DCMgjreFSAWpTrQ
         5ngw==
X-Forwarded-Encrypted: i=1; AHgh+RqAkTUNOCL+v7hWZppSYHuS3Jp9GcR3u0oe4SvtMMTfrGAz0u5SkcmWwaxENe34wX7AC2wWj/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIfc9HyseGBjs9KNe1aMxbkMWr+SBfJK8K9381obaZqIzK1jfg
	XyLRjrmz2JPvV/v3XRRELXquu59Q0Xze14CO0smqk2ljAET/cmQMxbyGAC5zEBlSoKw=
X-Gm-Gg: AfdE7cnJImiZ/rDe8oKOkxeIiFAnoLZtYPsHXBPsiOpSyXYcjCR9JFdNC4X89V3Ym9p
	gpvqrfBDZ8wQQcrD1Fz0x9oReWUHSEtxVgwMoj1gEDPZuaWsYr8y4XqSlLZC+NHvlRHJtAUNVRi
	GthFk3agtwpRyUNz4uy0un8EWF0PXxUwE40vDN1XDDlyC1idrTsZub9jyDKTGLhhJNILXMZF/oB
	YovP3cVESTvIXpKD1/BDsW69gUIDtuOasUztWHSQbDXyqQPanbzym8u4R9jDHXDwuFUhm3OSXh/
	8jN5yNP4Ic16GBmTBe5no7Q40A7M4lngCqY1iOuEESPRbnSdnThczd/XvMQ9flAmI2UluIcIjlY
	S1iz/j7FvcAXmPFP/Z9nnQ9sojAkc6s2LX6kWaCmMAYCXAGIx+TNp4JUXwaf7z/L4Oo64kAL+L6
	BhG1gtFT+508hLn+ZJr3+RlLaM2NWDRgzMhI2t
X-Received: by 2002:a05:600d:6447:10b0:495:63f5:7a4f with SMTP id 5b1f17b1804b1-49563f57a9amr3600385e9.33.1784542154242;
        Mon, 20 Jul 2026 03:09:14 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2a2504sm294792995e9.2.2026.07.20.03.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:09:13 -0700 (PDT)
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
Subject: [PATCH v3 net-next 3/6] net: ti: icssg-prueth: Move long delayed work on system_dfl_long_wq
Date: Mon, 20 Jul 2026 12:08:53 +0200
Message-ID: <20260720100902.155605-4-marco.crivellari@suse.com>
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
2.54.0

