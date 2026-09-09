Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39383563E1
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 04:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788929719; cv=none; b=AU/f8NQqoq21ZFLSjD3lY6DuPW2a2yr7Ae98PN8LiK7P1o9LI2L72OUzQpILpBa2nrN24RtcNg7elWtosrpHQHAfSrIp4TH59xF1Cv+SzpJCDJTyX0KjkifPptFXCSDrrLzVKoLspajsKdqf5Ni0lplmndIEc3M2p1mgpe7NI6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788929719; c=relaxed/simple;
	bh=9XQNM3dHn9B6ebcmsmXP5Kg8HA2I6Ns/3HUBA3vfo5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mru7fPS94TRxaXEcX7en4AodcDNiEbL1VfCK3kucYKToyTaeKvwGRZC/CjlDA1+nBX2wuSs3iYeTueEE29jrdkb1Y6NKcBT7eIoh6qP6+p3bU+j03KUsXr+dMpOUbjABN4Mz4eQLFOotqk+fqmhGqpZdkMwPtuQTBu7+FK5RN7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6kcDLnt; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6kcDLnt"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d032846c95so63355985ad.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 21:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788929717; x=1789534517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qiAYhnnhs61WtKZMJIh7R7XvaVkzgplipEpTD594EKI=;
        b=M6kcDLnt6lHDVasxDqZm9/IxYakPr0pHZB/5UNRYvE5YT9ka0+URz235GSBlTAqFZL
         23PSr8U2ppXLVVRnBt3Aps+eZzn3Qfq5tsFGFM5xFw85PbaFWc178y4xhv0n3KWIc223
         T3CZfXfw66QttQmBYie4sHG/Xjr1GWmZfsO5iUf8Hgi1INMoN94pLmm38RIGk+WUaBoM
         Xk0d442oI+Q2PPKWEv1hcXj+clh4OYXVAFaXR9D0n+yqHcdmmO+F8bD0qqiDD9f/5eO9
         Zi1dPK8AhhLiWJ0Uvg9l1eBMiuW+1NjVujBrHprUgQVzge4pRUaiDV/fjB3663HYEsyb
         upYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788929717; x=1789534517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qiAYhnnhs61WtKZMJIh7R7XvaVkzgplipEpTD594EKI=;
        b=ByZXYFjmiIiJACWVDwzA9Oy3r+fiD47oaN4ITmYtLm5IbJG2sqPOp/fx+P6oJ4gzoi
         Kocw5T9JZJJaXx6ubckY5rulxTjlIunYLEhWDsIM21HDDf3xkRJv23SJfmUGCZ/m2sqB
         VlziRGalRTWsf9Bxcu6alNAZXWukU/OYA2IXI0LgigzkqjTL6kfv7OIBLcgMniwFFV+R
         1nYU+UVjqSOhw2d58nMet5WGkPjMQ5MHz3kIH8IBsk0XOdqD83QQnjSajFxmJZnviskz
         gm5sf7gGX4ouliMx+RVHe9b2hCGB8B26eWtxtFK7pNIj62jzPp2dAWrHknGrYBl59qqE
         0H7g==
X-Gm-Message-State: AFuF++lcjSDgV3w9zIbEKDxfy1TrwLbAAd/dDS5+3uoaL+n6UKAid83V
	um2EV6Owkin3wuso5lw+YmeftLAVd2VBbFB7QphY0jbbjh42+7RxGKnq
X-Gm-Gg: AYBFou2hMaQ7EPoIuwRRT8UeziIQQ/Cz2KFqyc4TKndpz0H2thXHK+LpS3ccC0UOlbG
	RobrMkjBBL7u13idaGVQGUJyBu7e5GoQ1w+XeMxUDkaMOMLffXKla4cqL0aMn3WVyPsA3Q8C+RP
	Qr+TiTktwueLVpuxmCkrhTnNUPw7jaQTAtzGVw4RtXrWPtSv0fWNDMBTNkhkh6cSvCx+ufCzeSW
	n3kqRlL0wqLcMORxGKeDCc1+zE2aobSUimIUXqq9h53VWlQ2KYGVtsavZNtA4IkEdL+9NsCl4OX
	/lr84GDiL7RtVtIt2OHArdEw0c7YN7c5gIVCbJ3TnzcmrnnOBTh4MyHFEQR/AUxO5PKeJt+nJtY
	VEUFOw++g33bL45Of6SomUQyxt6CbNyi5zp7uSrxhA+WvKX6FxpVKN/5OZyj+29ddCy0jlL6KjD
	mA1URqL2FQ7hMek+HMQhsU6M9qTyhPl8hLR1upIjm/4/s9WTfWwno5gD3AcvxFGzYWba0kIwmUV
	nshvzZF25+8dShU/bNUShfurgbgsIAbgzIWKKUaUOVvFt46T6rBrkj6cux68YA53PiJtM2NoWKn
	kGjGsd+HSMdJ/PDk
X-Received: by 2002:a17:903:32cb:b0:2c9:bf82:dd11 with SMTP id d9443c01a7336-2db1248c3f4mr422794085ad.7.1788929716983;
        Tue, 08 Sep 2026 21:55:16 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1499e876sm66688505ad.56.2026.09.08.21.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 21:55:16 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH net-next v6 2/3] net: xilinx: axienet: Handle optional IRQ return value correctly
Date: Wed,  9 Sep 2026 11:54:49 +0700
Message-ID: <20260909045450.16176-3-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909045450.16176-1-phucduc.bui@gmail.com>
References: <20260909045450.16176-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

lp->eth_irq is assigned from platform_get_irq_optional(), which returns
a non-zero interrupt number on success or a negative error number on
failure. Errors other than -ENXIO are handled before this check,
so -ENXIO is the only error value that can reach this point.

Check for a negative value instead of treating 0 as an undefined IRQ.

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Changes in v6 : 
 - Add Simon's Reviewed-by: tag.
 - Drop the Fixes: tag as this patch is intended for net-next.

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 207aecb5f8b9..3927ababf833 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -3052,7 +3052,7 @@ static int axienet_probe(struct platform_device *pdev)
 		ndev->ethtool_ops = &axienet_ethtool_ops;
 	}
 	/* Check for Ethernet core IRQ (optional) */
-	if (lp->eth_irq <= 0)
+	if (lp->eth_irq < 0)
 		dev_info(&pdev->dev, "Ethernet core IRQ not defined\n");
 
 	/* Retrieve the MAC address */
-- 
2.43.0

