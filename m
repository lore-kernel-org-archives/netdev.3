Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793617044;
	b=mvF/DibBjSJKcNJmqVBXbg5KdET1avpRpP5Mbp792r1aUqIMbU6I0EHL58Yjpi/eibGq
	 L/OkL8L6gy9tt8MdAcivgozzO4vAoXkGl5fEYCk0e3CeES/YP4CFzpb8nSwcHA0H5Nht7
	 I0+r7GWDFnzv8nvLrH0VlXs6bqjbB2dcuqddTwOv+Wt8WDleEwK9OfM/IEbOO6KmMFyJ4
	 vtM1x85+wdchlNNvEliLiMQEO726waIcpbDAlG6tBpWnjuTYeZF1p2p2J1elCA27mwRpD
	 fWPwzXV9bSVZJgKPBq4a1PPWdPLcxzk4YHdDbmXKM8Il5HtCAu1cjHfzdgTE7YGQBJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617044;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9/IoYRffQKx8mihWgrVfNglvfRURCF4HcTZULBh6CJs=;
	b=Erc0shZ25iEUK+zwbdjesFYq1sEOw2Hh8+sq01WmVMbXMQ1TbCGheTAOMReGnFaE9KqC
	 a8Ghe2RAJf8TkXixm1Tg91SKHZk8t31qpS7BQQEmzQw1V2Rubi5BXLR5XQStE6NtYgZHv
	 blcOI8Ozv4TU87klSmlNnZRUCT1U4R7P6X/fdi/011hEjdqZpOJ6gqWnrPCQq5+zgXz6p
	 CXUUgy4Iy9MkEmIXunvAjLsADrhnFuAnMfG8lcxUf7P0g2VrnFoGt0hyynmhiHGssJqif
	 21+FEwjXonLPqJzFEZv3WdT746XeuXzCbjsHf70AL9b/PX1viuJGab9Aue6Xhln1z5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=f3nethiZ;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B66760A2609
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 10:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B66760A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=f3nethiZ
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a218c463d1so18667745e9.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 02:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793617043; x=1794221843; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9/IoYRffQKx8mihWgrVfNglvfRURCF4HcTZULBh6CJs=;
        b=f3nethiZ4/IR7pLM1LbwTibEHGLrGoDoK1HodS2yFwL0vWCFTUVUfXAsagEk9Oap//
         iKn9sle/cwvDW8I3uCETAIT+hATmrEqd42+Z+sBcSzJWUOzfDQ+7uFp7ghMwKTM0g39X
         P7TEWrSBjwbb/7OqgtjfGpylnBnAvabLYbVgEF3UKZIo+gOW0ColThdUOwpdROWdUcPZ
         2g8AK5u4MTMxGnuPegngtQnTTA/v6T7H366xfjJIh2c80dOQgOuFc2UVKpIXxadhSqf7
         dszNaJUk0D+sG+Vhi15bNQZIaf5SMn1jmRwImUydEl0/tRTICQGi6fFyDMsfBw/OOxM0
         6bDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793617043; x=1794221843;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9/IoYRffQKx8mihWgrVfNglvfRURCF4HcTZULBh6CJs=;
        b=1WGuiLRJqfdMutNfGDIVArdTMckDwWx9ox+XdL9v4K+gFvMZLw1gf8X7Sr7pQVBXcT
         VsAIAbpBGVzXqa7AT64dleu4YlNBs0/T1TwlHdFEHloSIvZAedbwgXrNhF6gVAxfzNAz
         ShqLrF7+utp8j+mg43sRXwxQPEW6KSYt9s+tbBs/jATYzfi89/vrHeBW8QB1dagXiW69
         b++gKB7wHoAdmYSxeEeDDk+lWdcvcTsXs58rffavR7AHWUuXdy7/BihjyJYLyc3V3e+K
         Wnzrc740r3gvrRDA5zSvNCELOQ7wexXs8ZHWtzvwKU9bB3kYNGV5ZdMge0RgoVicsv/r
         tKrA==
X-Forwarded-Encrypted: i=1; AKwUvBxuHQMGcFhnuJQ9Gk6Qydo/uQRZFs0zxj+fftMRsWTDiudvK1sSRJP2o86WQk06wv50iH8fans=@vger.kernel.org
X-Gm-Message-State: AFq9FYICzbVSStvtlHk/wrdHCFKkJ2KIfrl029BztPRVOdidj5Swihk8
	5rNRWoXGfPy7RgVlPtlqB+DFYNXwI5bGmpYeUj8L8T3B2rZXtaEqkJgFxl8jR2RagNo=
X-Gm-Gg: AYBFou0CT/cnZya+GZMkFQ0Ny2mGaImMLfJKAXxJsSXXOmkj3t+4e4RTEbcCKSJbARp
	ZW5fAanBAUTCEusqo8Cdz/+WyBMVtQpaRjWdt4MjgLcElpSfQPovGSLiN40F7oE70iNt5FWLRm6
	d7DIAxnzrSS9zKdKRl2dgd5CbZS9su8JVV60Cz0terhpawRhREOYYT6UdwhDxHahT67qgZ8Hig9
	Sxgfp5kya4vAmfwtkpc0BLuDGfhS55gzuOj53zo7rtfQDUNa6VM7GB1wCyqpAmz8Y9qTVfXqwtQ
	SggksAWwPJPQPkqINMyrJDRKpLgFvoIPoyJ9khbGTL2n66eYdxV2bB944+wGBuEul3g/0NchlaC
	AK8NDR6qkeYeXfgK3TehE8dAlSbgLomyWNFXe2RDY2HsJp8GKrDlASsPz8haiGDOoUIZpFKJ63Y
	0vSd/oQr9TnIJK2+aHsdAJWw6D1nV7EPsbL1l3USC4ddVZv1nvDyxJdCp+ut/i+g/HerVQti5ub
	VV7DDILvAQwnCGzzH91+hLF8UZYTU5nyuuYZN3dvX2mPnWgCaF5kQWcGat6mPoQBPo4rcY4Gom9
	PHi++33lFJXW+IYg23K1sp5oGqak5fbjVojR6DHSG1Ch4FHFqVPU
X-Received: by 2002:a05:600c:e41a:b0:4b2:406b:f3bd with SMTP id 5b1f17b1804b1-4b2406bf3d2mr3653145e9.23.1793617042662;
        Mon, 02 Nov 2026 02:57:22 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abeb77af8csm363171175e9.1.2026.11.02.02.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 02:57:22 -0800 (PST)
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
Subject: [PATCH net-next v5 2/6] net: ti: icssg-stats: Move long delayed work on system_dfl_long_wq
Date: Mon,  2 Nov 2026 11:56:52 +0100
Message-ID: <20261102105703.111844-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102105703.111844-1-marco.crivellari@suse.com>
References: <20261102105703.111844-1-marco.crivellari@suse.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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
2.56.0

