Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CE03C13E3
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740527; cv=none; b=BWbguKyCAOlyHTzqom5oKmY4SYuc1ssbThgnPZOabhwzInqBW3FNln9hGuGzrepnf0dTrAK+lGt/ilf/aGlazR6ezNTSbXtjt5FIPYjTFS2H7sb2mTIeBzbTtFPMElmq4t/ynW58Vaw7ka2oOzCJdDgZEHJVbEjWtK1KhEUHrbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740527; c=relaxed/simple;
	bh=y/qxAQMIW2CMYc/bzkgwh68GybbVe61ppJSHYTFLsDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A6zrm5Qvt0T7wRdTemwRcfUy8DMAQ1hsFop5z6FQlwp2farchtrz6Xlot9Q0OSwtTUy9+VrCS2T5D0AHrzWOhcmNKGuppDqPRgE/A0NyJwPNMFUZSZs5DzhR6bEGP4W5K3COguAD0ffQeC3J8ibFPv0OvsvMnpdBT6yng/dOMig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtOsLMjx; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtOsLMjx"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc1cc97b84bso164916a12.1
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 03:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787740526; x=1788345326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5X3ww+aTNIQSQQs0nmBvcYcUDlxPlN9HB4Ktt9oSZxg=;
        b=HtOsLMjxStDwUD9d75FjNBEmCyBBYq8irE8OROfVcCUOHIuNZIAYJ+ccXaoLbiIilK
         3gi7ynORW8OpxVtaD1X5E/SynILXtBiTEbf15oEQdnYUyH2jNCsfbf8mtB26wQ0lIUpR
         xY+rLsRlHArwoF4U6TSqZDna10jQlsaTu8LB4HiDe+Est9a9qjEGHeO2OngfVGc10Gn5
         JRcVWIR23/8iBI2TP6slne3iqqsSOp4a3RkmVjZ/hsnKEnTHg39Lo8tCTYi/Te4omGhx
         BJHL7qP98N0bIRoYqwcSmeVQBs0aSzlAafK9aEW6PNvKy53P/pQBNgtcLBIr1GRg/RV1
         WVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787740526; x=1788345326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5X3ww+aTNIQSQQs0nmBvcYcUDlxPlN9HB4Ktt9oSZxg=;
        b=sXR5zNHqGJdWjdsHJ/ss8R4DaUkUopxAzxiRJsic1bZEWaq94tR0qfjwBv/vNrQsP2
         w4R67uzkZ0Tx+nnyC3nFMpvSnSG/9GM++T30Pt/jZGPBiQMKycFh/yrqBcMVuEpTX1yP
         BupdC0Uvehvg18lAwo08mf7gSCjacqZiDxg84vD1Q+f4cmXPouIoPrjIoatQgwTF7Aob
         LYIb01ifuQpdNJReNBV8JCBkgwDcaDyBytxMBOvaiLYzJoHNYs5GrM434PsMz9N2pu9c
         sI2MM2aaXFieLCeqvLMWrP63lpzHbwcqSWDeCTUJ5v+nU+0VNzylH6ucngUYUC7Hsiss
         5M/Q==
X-Forwarded-Encrypted: i=1; AHgh+RpPR9Ks0VNFUuk64q8f/clHeqU34vkLJs2INs57EN7kUqaVqrdcWd/QspeA3weVjk5/3wNjh6Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lLQIyaBWIEvLYTj+CmiU4Zm7zmpthnIBbCXt5FSyqJhN1LPzUY
	brp+OHiRLqZ41mYdd68gOOSChW2AoTOPMPWvuWyf3fqRARqz4bRGQOvw
X-Gm-Gg: AR+sD12szBev/k4FSePLAF/4rsxYFawFxmgLAq5pcAXfDRTNuzLCK1LRn0a/bJD9I6w
	dX9zDhgZYd2IgTm7+qpeIeVXjzf1A6v81bDElaz42EnCwh8hpYqwmIpb9IYroeLJ0xkuzvHYVbR
	E4JXmEYKCXsZuoAVxgxKXO0XLHN1cAJrJrQ1DZ6PfPcm9TgIYIadJGxNm0laeRt6jKkQAxrqH6M
	t7Id+013oZRbAC5DyrzrYjZSWAdq472fi1I+ouqy0wuXNH9fYmXssp7R4CHsNPjGc+y8pdGMUSU
	5xX6CCVDS0xsnQqPJGTcLrzj7ygdRl3I+6rzjM+ReLB9Bs+y6kuD1CwXURitmI5y82KvBz7+8G3
	RRMqr9wRbHOSiBtNpKRBDw/rtlhrVAZrPlNDdIv0y3re6uXc8aw17yCdSHGogjEtcO/YbL2eCJ1
	CkUBu4D9clRd/TRGEJz+KE1MQLnlm5JOA7XnBBra91k3XGnmqXH1xsp342ygjHJTM6kBhbO96g1
	HQhIhg2P+5yyS/rTFnlwAO4ljnyFQSQ2i0OSJglouNvtCTCzOK7P+hnD90yceM1yU2w7mmeHUPS
	84wrmA==
X-Received: by 2002:a17:90b:1649:b0:37f:fdc8:71b4 with SMTP id 98e67ed59e1d1-3966d3fe36bmr12075307a91.2.1787740525585;
        Wed, 26 Aug 2026 03:35:25 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3967591f49csm676654a91.3.2026.08.26.03.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 03:35:25 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Wei Fang <wei.fang@nxp.com>,
	Frank Li <frank.li@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH net v2] net: fec: only stop PTP if it was initialized
Date: Wed, 26 Aug 2026 17:34:28 +0700
Message-ID: <20260826103428.32807-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

fec_ptp_init() is only called when fep->bufdesc_ex is available.
However, fec_probe() unconditionally calls fec_ptp_stop() on the
failed_init path, and fec_drv_remove() unconditionally calls
fec_ptp_stop() during device removal.

Check fep->bufdesc_ex before calling fec_ptp_stop() in both paths
to avoid stopping PTP when it was not initialized.

Fixes: 32cba57ba74b ("net: fec: introduce fec_ptp_stop and use in probe fail path")
Reviewed-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Changes in v2:
 - Handle fec_drv_remove() as suggested in Sashiko's review.
 - Update the commit message.
 - Add the Reviewed-by tag.

 drivers/net/ethernet/freescale/fec_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index ced4dbf8cd90..794ec427b0ee 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -5457,7 +5457,8 @@ fec_probe(struct platform_device *pdev)
 failed_irq:
 	fec_enet_deinit(ndev);
 failed_init:
-	fec_ptp_stop(pdev);
+	if (fep->bufdesc_ex)
+		fec_ptp_stop(pdev);
 failed_reset:
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -5499,7 +5500,8 @@ fec_drv_remove(struct platform_device *pdev)
 			ERR_PTR(ret));
 
 	cancel_work_sync(&fep->tx_timeout_work);
-	fec_ptp_stop(pdev);
+	if (fep->bufdesc_ex)
+		fec_ptp_stop(pdev);
 	unregister_netdev(ndev);
 	fec_enet_mii_remove(fep);
 	if (fep->reg_phy)
-- 
2.43.0

