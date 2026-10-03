Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E579535E952
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791036580; cv=none; b=bR0fx2LWD/YgjXFTH2gneGpG1gSV5YudjPe7hRW6LNNHFjoDt2jNOp0MavD4nOmZhW8nXZmAGibzMaCwaU5aCURQ8dNF2wXuaM5Pmvgj9HHKDbOm3JyuMZcmhpb70B3avgR9sNXy5PTqT6FX35AZPlwfIBqkiLL7BOEpH7ZIkEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791036580; c=relaxed/simple;
	bh=xdIPzQswUBuO7nIbi11zIqOM1B0LfdavrLeqJbs0KKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mGrYyM+MMzdT264aLdB1WkSpnYLs60NDxFQW65jGASbnkvtZXTWjR9Ybq+VvrjVOmU3F7hm13HmPH002C3OvHVN87YrFRi9iarCFM6PVrfEI3wutRZEJmeWU/4Wzm6pRcO7UKNEElkhyncImsv5McECeiVCAk4JdlMtymFH+3rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JD5hBlJw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JD5hBlJw"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a0286c981dso5417465e9.2
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 07:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791036574; x=1791641374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hVdmfx66Gvub33TevMdmKNS+KKX8lYKVFWSjk8vfkvM=;
        b=JD5hBlJwd/ze8Y8edMzHjAuiuSrnhHMI0HNaL6ZLZOAxOOWOuar8gnuGDU6YPrd2zT
         HjbcLtmDiwRGh1QrmV84lzmz6HWsGaYbbufp0N0xqfyBRRuZ0VWhMj/83dALIYnNRJA+
         COJWtM4UFmZLtXa4hZ71b+Mke90iO0WfRb8PwktxS6WLfSJXkhViFaWR22u4plLdtWzw
         oy6YAM2B30qrQFr3Nq4/VAW+4vyA9NpLxujwEq1sOvxdSL4jI0mAsnT4+2UsH+oCVIUU
         itiHm0Me21/u57uOdJrngI9qh25qbG8CJSCKVtpmoE1KhtFV9ew/6vVL3oyDY5NiR/Ub
         NdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791036574; x=1791641374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hVdmfx66Gvub33TevMdmKNS+KKX8lYKVFWSjk8vfkvM=;
        b=kLv5sNHhuIJIJjsjYKJtrCzzRxMSImHY1bKih/QwGQnP28STadxt1Kgm/aD2Mu+pAv
         xSBFsKfuypldOZ3LrvCPN4cUb7X7+lxQx9jxFwYTi91DyEaSt7cPaAlM992OAXmwZIr/
         0sR2S0fe3Wikdq0pUbhwRwjfcb/JSU6x5xx07gBJukDuCDR4Rh7jrPSYtCSi+x8YbLrR
         4RGnD9nBYlBChrKJyHxL0yybs0Tgo/VM4TSmo1D3c8dxHnLrawyKoGQLS2VKgzGsgB/M
         ssndBmMZ2YDvj/84SzjFUWl5xf8zaYaAn/apw2jXWjcf9xTCZECg4UPSaj1fBKKzfjrm
         6mog==
X-Gm-Message-State: AFuF++lMqP+HJE+XukOrlrOF0gJpi4Xe0PCrZ2CQXLixIh4f1iRzO3j0
	KDrDe6v3p5ZlklkTd8JKa+58Xga0UenqRZ8ZRg2peqBGfiC79AMXB72dqnPeCxh+
X-Gm-Gg: AYBFou2YYrbsyD8OCehnSXbJMQNa0swZFViHBMexnY+omvvx3TmY0gAqr6ZJER4Oqhk
	aQWS/J8RytxnRI1s7WewUNJlccL+4wnIY8SBn6NSNl6asdhKMciZDItwysEK+xkJ6U6NJ19I0hO
	jAgU93fQY8nliOQ+ps5jNX5bNxxmvnLQjLGaAfIUYNizL2a1jNCvWbv455T1bnlWQsyG5Gz4nDP
	Pc24c01sFepL0a5gNOjCR999Yp1zplZeDCSdfjRls33X7c9BRDEKx3Zw3Wg62twjiL8faqIHLJd
	TlHcboj/PfKZWHkgpcrUJmz04rKf3aXfopQuJf/sEfYgu9bCo2RVkn6jANkIyEt4TvgTDREsi2x
	9A+WVGDEhXzfEv7/C70wznV+DOAQE3Qp4sv4yuzkAcuWudrEErxv1HWgqBpXiCw24odiz/QDeZt
	tj/ZRVksskls4/Or8mIU/4AGm6WAgvuZ0LxRN5Kz7nEB4N1KJhCTakg0MFHB3ubQhoZls7QqFsC
	I4INF6+4WZRrel5Gv5ea/Kh2Dkc7iYiSRxKDkAfsAwz8A2efELK41VI1689GNW943ReAYc9TuX4
	ctxK3fobrbQSzoDK1JmjYESO4lQh7gDRXYSickR0AGVPQ3v0LUncDODHk7FQPUaomAMFNI1H3dU
	1cQ==
X-Received: by 2002:a05:600c:c091:b0:4a0:1f90:594b with SMTP id 5b1f17b1804b1-4a1680fd78fmr28665235e9.22.1791036573949;
        Sat, 03 Oct 2026 07:09:33 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b2e2-2001-c47f-5a89-3d9a-cd2d.310.pool.telefonica.de. [2a02:3100:b2e2:2001:c47f:5a89:3d9a:cd2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bfafasm184098025e9.8.2026.10.03.07.09.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 03 Oct 2026 07:09:33 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: netdev@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Keerthy <j-keerthy@ti.com>,
	Kevin Hao <haokexin@gmail.com>,
	Alexander Sverdlin <alex@sverdlin.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] net: cpsw: cancel RX mode work on probe failure
Date: Sat,  3 Oct 2026 16:09:15 +0200
Message-Id: <b8146e89e0a17e6ee8d2924f64b9568402afd62d.1791035789.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1791035789.git.kmehltretter@gmail.com>
References: <cover.1791035789.git.kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The legacy CPSW driver registers its netdevs before requesting their IRQs.
Once registered, an interface can be opened and dev_set_rx_mode() can queue
its rx_mode_work. If a later IRQ request fails, the probe error path
unregisters the interfaces but does not drain their work before returning.
Driver core then releases the devm-allocated netdevs and private data,
allowing a worker to dereference freed memory.

Call disable_work_sync() after unregistering each registered netdev. This
matches cpsw_remove(). It drains the work before the error path releases
the remaining resources.

Without this change, a QEMU stub test reproduced a use-after-free
after an IRQ request failure with rx_mode_work pending. KASAN reported:

  BUG: KASAN: slab-use-after-free in cpsw_ndo_set_rx_mode_work+0x28/0x174
  Workqueue: events cpsw_ndo_set_rx_mode_work
  Call trace:
   kasan_report from cpsw_ndo_set_rx_mode_work+0x28/0x174
   cpsw_ndo_set_rx_mode_work from process_scheduled_works+0x4ac/0x790
   process_scheduled_works from worker_thread+0x49c/0x5b0

Real hardware was not tested.

Fixes: 0b8c878d1173 ("net: cpsw: Execute ndo_set_rx_mode callback in a work queue")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/net/ethernet/ti/cpsw.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 4fc59f9f23fc..d93d94eaac2d 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1766,9 +1766,15 @@ static int cpsw_probe(struct platform_device *pdev)
 	return 0;
 
 clean_unregister_netdev_ret:
-	if (secondary_registered)
+	if (secondary_registered) {
+		struct cpsw_priv *priv_sl2;
+
+		priv_sl2 = netdev_priv(cpsw->slaves[1].ndev);
 		unregister_netdev(cpsw->slaves[1].ndev);
+		disable_work_sync(&priv_sl2->rx_mode_work);
+	}
 	unregister_netdev(ndev);
+	disable_work_sync(&priv->rx_mode_work);
 clean_cpts:
 	cpts_release(cpsw->cpts);
 	cpdma_ctlr_destroy(cpsw->dma);
-- 
2.53.0

