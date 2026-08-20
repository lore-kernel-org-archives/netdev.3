Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7FF41A571
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224481; cv=none; b=J6oH0x1xhKwU3EuUh844KF0OlvmdfjxTck+30egv0gIStIYAP1kiyaGbbaWuNnB5WyqzNRqeD2eGClWnL+DQ+7FMxyCCPu/LlsZ1s1P59El77vnMq1pPQqDWWLPyGxXPrqAXu0hY9Csncz/8EIGMTyARbqiCCKJnKcbwu6bw9rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224481; c=relaxed/simple;
	bh=ZdtX8xsbh4lQi/ck9/fe2r/hcaarQC4xCPivdR8GLbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBalFMWAoFIivOiCgNBhzujTKilCgDJcEKSD45DNyyu8fJNel0kIgsrgEIm76CCkMR01+pLagrmqRuk8rlC6tD3knlTTxC/OKsv+zVowwTjk7H/7phkDSDrDgzt63V01BIz0UPro6XpmUrCuOadTf49+FlpueRpa9yLYdh+hjNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAtCVG3D; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAtCVG3D"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-381b831d535so3175250a91.0
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 04:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787224480; x=1787829280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aa8JvoP4ttlAqARvv1+FX+80Og3e2TOWzjjuAVcvE4k=;
        b=dAtCVG3D3DxF951n4lxmzQk8RQi4gC3qu1IdSCONOqssA65WifAL9DSY7hcwASJ94K
         ss4gfrzGe1Rgqg4ofLzkmn0nBBibDX3HbcC2hnpJrmxryGWyUCwYBQzvbeY9Yo8f9qIb
         GUOl4YyfjOnYFjK3zYQ46NO8F73DEZXLNrhGeQ3ZAgFMqDp0yn8RUlL1FL7+yUZ0qZnI
         us/f3N9j41/m81y6/PPdP5QyGO5orkFYuJYVWKh6NsJu2xUKab0bAAe25oxE7hCY998D
         0yvbd5z1bN6tbcJcWA+QxB3wriNBgfw3QMaXSjhp9RaCXpqgnX8nTwUMKDhlKa8sZ4bO
         4m5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787224480; x=1787829280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aa8JvoP4ttlAqARvv1+FX+80Og3e2TOWzjjuAVcvE4k=;
        b=dmgAdaMZP1z+5XLZDNvRTML9RUsiRWGCfAgX/OngtDE48me6T5PMXcNdoYTS+R1HOs
         yi/98ORe+7WoqXD6yF8J2eSvoIWo6FD3sGjNQNekTwGF2XTArEFUA4zJnKQNHn0MqF88
         iz25IyIwjPp0dO/gorApK4S7S2boPgUuRRFWeFePpmPHOY1kSY6VhaR9/xUsbMtH6bre
         ZZ117nSfiNpPC4plsc/FEUawOtlqcj/vOp/nUQGkGV7dPKjUTn12/ydCrtXtG57L959X
         Zr7HAMG0m2RdZ2MLfQxQ/JLeJjIaPTBY3hMTHkflyvJRfTh1QnYi/L0tNNR1lOIuqOf9
         F8Xw==
X-Forwarded-Encrypted: i=1; AHgh+RpAaT0H3DhtWKhH28VYn1ml6JHTdMmauyAgDohfXgjR2D875Dyjuk+qWTu9UwFxSiXjrGNr3AA=@vger.kernel.org
X-Gm-Message-State: AFuF++myNvwXf2CBVLg8SyjxLRUIopGTkN9MGXQy5w12wTLXFno3HArT
	or1FDNamQmfi7OQFNpTiL3vTOT6EYDnOK9NtHtDoJUT2qrtDJVVfzTjv
X-Gm-Gg: AR+sD11/V33L06kNnMYVtAZjKFPs2SWtdIgfZ6HAc2XBOic6YGqqdjEs0ue3Nll3fGV
	wjl0kdtfygeZdda/NGovw7OHNq79AFGj5ARjTHiL9Pni9VB9woKyKz2CJW5gyvmYeNsquS75xC6
	WStAXl5QD2UP5SbTi6oTYKhKS2mFcZPpNqYPW7YAEVmIl9hnmHMgUOY6/XhLLouKKTgYV2q8iSm
	7UT+HHz7fUHrHRDhwqjn4jY9jFlJ7tcJHZ3noyZsmCT/t4wIBU0Qxw2uD27YoEn/+LucouENv6Q
	Mae3LxNiRVGbggoUTnunxE2hAWo2a6OEoLp0cZCOeluO9THSsG69YPKz7XekE04lnHWLx4zOegz
	A17tc6d+HpBK+/2r3wum4eYWktGgko2ydogQmjbsrN153sBuEP/m1pH+tLKK1cqVM3fUEgg4TA2
	yRbz/oIjJSGpq5PzRDr/KW5qpx7NAkSdQqP2INPu6QsvwSPdpwK9nwDo4a7sq7mVvj5zDd0SI4z
	5+Z2o10Ym3yzw6Y8rN+GXFEECPd0MEwXMLgJkxSrwGvtzrXYXm7Zu6oS24l9GhafCYhkor+Ngc3
	PvGx
X-Received: by 2002:a17:90b:2e42:b0:380:fead:448d with SMTP id 98e67ed59e1d1-3958109a525mr23538513a91.13.1787224479729;
        Thu, 20 Aug 2026 04:14:39 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395ada57c39sm719965a91.3.2026.08.20.04.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 04:14:39 -0700 (PDT)
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
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 2/2] net: fec: Handle PTP initialization errors in probe
Date: Thu, 20 Aug 2026 18:14:16 +0700
Message-ID: <20260820111416.97917-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820111416.97917-1-phucduc.bui@gmail.com>
References: <20260820111416.97917-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Check the return value of fec_ptp_init() and abort the probe if PTP
initialization fails.

Only call fec_ptp_stop() when PTP support was initialized to avoid
stopping an uninitialized PTP instance during error handling.

Found by manual code inspection.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index ced4dbf8cd90..b6c22d6c1e69 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -5384,8 +5384,11 @@ fec_probe(struct platform_device *pdev)
 		goto failed_reset;
 
 	irq_cnt = fec_enet_get_irq_cnt(pdev);
-	if (fep->bufdesc_ex)
-		fec_ptp_init(pdev, irq_cnt);
+	if (fep->bufdesc_ex) {
+		ret = fec_ptp_init(pdev, irq_cnt);
+		if (ret)
+			goto failed_reset;
+	}
 
 	ret = fec_enet_init(ndev);
 	if (ret)
@@ -5457,7 +5460,8 @@ fec_probe(struct platform_device *pdev)
 failed_irq:
 	fec_enet_deinit(ndev);
 failed_init:
-	fec_ptp_stop(pdev);
+	if (fep->bufdesc_ex)
+		fec_ptp_stop(pdev);
 failed_reset:
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.43.0

