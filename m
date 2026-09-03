Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABE23FBB6B
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427511; cv=none; b=oxTshamDjUBYy5nmR6Wud9bNovO+hYsy3/lcdnq2PR4YYOgnEd9UMwu+ZK3XkFoDMtlgeePRtpNiLKqgYc2g+1ooFaViq/CQcCiWQiPcnUCPmaVv8fHWIJj5FrKz7GHlf+PFB2VZOkEqAfeUmlTvK/ZxjZ2ckC7ScnX+UOQ2DFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427511; c=relaxed/simple;
	bh=94yqjhsBr5rPIKFH2AgXcHWBJxd83fBZ4CFS7MZdBlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HQSiwz28uy9A5lCSo3ydm7E4dR2p2gGqbQp3/iLTnUTK+EHi3bgAPrd6SUeL/xpEJb+xDLPAlouMcAZVSUUJUqWkxf1AxtPtM7PbZKxFnfnwFqbkcP/tLJo35rGUk7gzm+O1ChbIsqL0w0ET5K2h7QDz915GRs+PFvOjnf6+348=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVvOk50o; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVvOk50o"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso2853513a12.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 02:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788427509; x=1789032309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fOIXCrUO/IV1dzZwAc5lm4gP31IHeNSIKWytFXngFg0=;
        b=ZVvOk50oaPxhQ8avb6EVuokYV+8HBhrI6x3FFNCoFU++O8M8rfFkT4KiUiVK6D6Klh
         suzVEzSLx/S5fDWfT8DLmg+0R5MXmxLxzldECN3Mqy7ntEOkt8jxCGH0TajG6TXxNxID
         RqIJbdq7ipB1UTQG0onERh+aHa/dJOYang54EiSkmivBmG8PkeUfEdrx7dZn2Q6PP9JQ
         FDTCdeWYozkAg9nrIXMMTp3NDESLvISZVUGEbL0uDlxoQgqiIKhX49zgIpf8TSRBrThp
         YcCjU46kdyXZaIakLf75OYb6yDBQa/FqXCVzJbJPSrDo55K7nv+4AmZMNe3qZDCi11vc
         ZoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788427509; x=1789032309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fOIXCrUO/IV1dzZwAc5lm4gP31IHeNSIKWytFXngFg0=;
        b=sa4beUjBF96DAshDohSzu8DXjh8luh27d0hD35HzbhNJWkkOGy8FIUpFp9NK9XmMLv
         PVsam62tYUtzF87OSoOL8gCc6pQaM7+KaPrERHpQcemmiqd4PtVspPtfsSUQSvVMMHkv
         2jk1vw4vyGbLWr+klRIVIRN9OKtMtsnP3nH3L9OaZZs4v4Rg3aN8fJxfiD5RFKo8TSFV
         FUjrX5X/q9ajlMBtw7XuYhuM7thwoAam2B4V99XitUPGQCFS/+41ZIlVXPYq0rD1RjVa
         tNiNHQAlb3zAeNik4xf4mqIkzN5ALTw4CpD+vCp++HG74yUTzhtodlf+YDoJ9MJr+8UZ
         aW4w==
X-Forwarded-Encrypted: i=1; AKwUvBwBamaG5YEMcbmNxIKTRNJqi3qZdJShIcR8aBcw2eLi7PthCMpXoHCnw2N3JhUxlghRaw4YPZ0=@vger.kernel.org
X-Gm-Message-State: AFuF++nKmjbNFrklsgH96i4j/nS8//uhf3H6yl4MwCS/ye9t2lWEX6Jm
	DMrPtbtePQfmHXLqf6T321xx9JEwE1W/d0ajBViQQWIHPuY2TA9h71vf
X-Gm-Gg: AYBFou2Jo05vqxlODe5OSxdjCN0iStM+Cki4R2BFAmvIUOCrZaqcwSH6CLK1mo4XRNP
	ajW/pQKkEhvNyEvyBuxMjiAImZpVCm0z3Qp2DpKgUnKfIy5FJhPXyt1XiFZvZOiF9502wSJWJut
	G4cf7zwGFYG7boxObynwuMEmrpJ6oSYf6IFQjp7IKYRBSSBF9a6lCPHEYzQrBuT4a/YFry8hoBu
	0vXLgDJQkbuncDbsn4tsNixBuEegbb0hf4BLYaHyPN5hzdS1NFrJ0mhaZG0oIhUHDwgDCa4gcRK
	lLI6Te5CUplFiX0iVXQqJUiu9TXx05jRM+bj7ZAv51VZMRrVZ8hUVIPuu6TdkqXX0fsaXVBAXUZ
	jDQ2KcondE9n66UiuKYqfULTB91g+ODARXCtn3hFRi7jQE88UOzyJKcAipLde7x9bAIcig1Y6iZ
	u67m6NSCLpMk7xdz8CiDnwxmkumdMJG4Rsn0ctytp+3L+Mn0GIyBweDjv9MwHTvH5jnjA8fpf8Y
	E17gE2f/ImW53gDrfl2bg/aA8hp7QZz9/0wQN7mRqR63mk9kjG23HIpKQs0vdlr3PEAoiq+OeYf
	gC2o
X-Received: by 2002:a05:6a20:d502:b0:3c4:1493:6822 with SMTP id adf61e73a8af0-3d9b1f5e8edmr19128499637.18.1788427509232;
        Thu, 03 Sep 2026 02:25:09 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc43d3a33a7sm675376a12.11.2026.09.03.02.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 02:25:08 -0700 (PDT)
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
	Fugang Duan <fugang.duan@nxp.com>,
	Anson Huang <Anson.Huang@nxp.com>,
	Stephen Boyd <swboyd@chromium.org>,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH net-next v2] net: fec: Propagate PTP initialization errors
Date: Thu,  3 Sep 2026 16:24:30 +0700
Message-ID: <20260903092430.354186-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Change fec_ptp_init() to return an error code instead of silently
ignoring failures during PTP initialization.

The PPS IRQ is not required for the FEC/PTP functionality, so its
absence should not make the probe fail. However, an unavailable
optional IRQ should be distinguished from an actual error returned
during the IRQ lookup.

If a platform does not support the PPS IRQ, it can omit the IRQ from
its device tree and the optional lookup will return -ENXIO. Propagate
other errors from the IRQ lookup instead of silently ignoring them.

Also propagate failures from devm_request_irq() and ptp_clock_register().

Update the function declaration in fec.h accordingly.

Found by manual code inspection.

Fixes: b86bcb299092 ("net: fec_ptp: Use platform_get_irq_xxx_optional() to avoid error message")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Link v1: 
https://lore.kernel.org/all/20260820111416.97917-1-phucduc.bui@gmail.com/
Changes in v2:
 - Squash the two patches into one.
 - Add error handling for platform_get_irq_byname_optional().
 - Fix error handling for ptp_clock_register().

 drivers/net/ethernet/freescale/fec.h      |  2 +-
 drivers/net/ethernet/freescale/fec_main.c |  7 +++++--
 drivers/net/ethernet/freescale/fec_ptp.c  | 22 ++++++++++++++--------
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 7176803146f3..8831da37326b 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -692,7 +692,7 @@ struct fec_enet_private {
 	u64 ethtool_stats[];
 };
 
-void fec_ptp_init(struct platform_device *pdev, int irq_idx);
+int fec_ptp_init(struct platform_device *pdev, int irq_idx);
 void fec_ptp_restore_state(struct fec_enet_private *fep);
 void fec_ptp_save_state(struct fec_enet_private *fep);
 void fec_ptp_stop(struct platform_device *pdev);
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 794ec427b0ee..c6e29b5c2abb 100644
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
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 56801c2009d5..557a76797eba 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -736,7 +736,7 @@ static irqreturn_t fec_pps_interrupt(int irq, void *dev_id)
  * cyclecounter init routine and exits.
  */
 
-void fec_ptp_init(struct platform_device *pdev, int irq_idx)
+int fec_ptp_init(struct platform_device *pdev, int irq_idx)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -779,26 +779,32 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
 		      HRTIMER_MODE_REL);
 
 	irq = platform_get_irq_byname_optional(pdev, "pps");
-	if (irq < 0)
+	if (irq < 0 && irq != -ENXIO)
+		return irq;
+	if (irq == -ENXIO) {
 		irq = platform_get_irq_optional(pdev, irq_idx);
-	/* Failure to get an irq is not fatal,
-	 * only the PTP_CLOCK_PPS clock events should stop
-	 */
-	if (irq >= 0) {
+		if (irq < 0 && irq != -ENXIO)
+			return irq;
+	}
+
+	if (irq > 0) {
 		ret = devm_request_irq(&pdev->dev, irq, fec_pps_interrupt,
 				       0, pdev->name, ndev);
 		if (ret < 0)
-			dev_warn(&pdev->dev, "request for pps irq failed(%d)\n",
-				 ret);
+			return ret;
 	}
 
 	fep->ptp_clock = ptp_clock_register(&fep->ptp_caps, &pdev->dev);
 	if (IS_ERR(fep->ptp_clock)) {
+		ret = PTR_ERR(fep->ptp_clock);
 		fep->ptp_clock = NULL;
 		dev_err(&pdev->dev, "ptp_clock_register failed\n");
+		return ret;
 	}
 
 	schedule_delayed_work(&fep->time_keep, HZ);
+
+	return 0;
 }
 
 void fec_ptp_save_state(struct fec_enet_private *fep)
-- 
2.43.0

