Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5031B3A9DBA;
	Wed,  2 Sep 2026 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788343080; cv=none; b=DPpuAA+RPMhPGVW2LGzPkpLQ741GNUFQQHv0hSyxumJGfA4xvKlfF3JOQGO3aikyzp+3o5tsJHqbhVYzHiAbt5k7X9owrQY6IGidVQyFJPfxsppyUY6n+jvCyowfOHkDcpt2mRkNo42CWUycIBBdJIlK81JWkXCvHdxzbiVas9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788343080; c=relaxed/simple;
	bh=elhEQoqrJU0Bva3r+jlfTvSY8EbxMP1ywSHdj8Kg318=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KJu6ExlyMTQC8FDDTS/HvY26YY+uoktkCxooLJCKCSk9GbZ0gzmgV2LGoeW4L9p8zIAvsdFV2mcfTFxrlWbVWE+p/6QTr7ALy9HHuppb8YBUZC9OT+aRD5cxVDhFbu0O05DQhfiqiAT4GP3TC/mVQk47pYzcT11qsVT3OZQKJWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mvCEQ4na; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mvCEQ4na"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 59F0A1A1948;
	Wed,  2 Sep 2026 09:57:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2D4316053C;
	Wed,  2 Sep 2026 09:57:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E712B11C7932C;
	Wed,  2 Sep 2026 11:57:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788343075; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UE3d8uBd3AkiHRdBNbCVNULk3X2F/j5sdXNN38PNd5o=;
	b=mvCEQ4naV4Xqm4XB4laOSQ2m9P39ksFyMj4fBqh/3iFI/ahUzbyjtgB/i6VNw2qTOGthp7
	Wr8L5w3UyGo+gdKSzDqhEnIZjEP4hKorHLd2jZ+NZGyYcTSOdtjOmlR3ryAvkzqF6+0gGU
	2AZhd82e2zHEG5k6vr24xMOcHaWKRWJHaKcF9xR4j/cN+VW+WiD10ttPnQy4APJwSbAvja
	w8yC3LHgg4K+gZItf4YyeeD2q1RIhQcAkYPb7rqnbm1FMk6zgP1xXWIKn/Y660CYzIHdGQ
	nqn26XVjG56tfYoaDu1zgmr5XECohLOSpU+s4OzpBOItPi7VdnkKX6U3iqsanw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Wed, 02 Sep 2026 11:57:38 +0200
Subject: [PATCH net-next v2 08/10] net: dsa: microchip: extract time update
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-ksz-perout-v2-8-6f277fcc9e68@bootlin.com>
References: <20260902-ksz-perout-v2-0-6f277fcc9e68@bootlin.com>
In-Reply-To: <20260902-ksz-perout-v2-0-6f277fcc9e68@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The KSZ8463 supports periodic outputs but doesn't handle them in the same
way as the other KSZ switches. To add proper support for the KSZ8463, a
dedicated ksz8463_ptp_settime() function needs to be created. This
function will access the same registers than the common
ksz_ptp_settime().

Extract the register accesses into a dedicated function so it can be
used later by the KSZ8463 support.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index e262bc7448f2..aa73ad1f05d8 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -845,30 +845,42 @@ static int ksz_ptp_restart_perout(struct ksz_device *dev)
 	return ksz_ptp_enable_perout(dev, &request, 1);
 }
 
-static int ksz_ptp_settime(struct ptp_clock_info *ptp,
-			   const struct timespec64 *ts)
+static int __ksz_ptp_settime(struct ksz_device *dev,
+			     const struct timespec64 *ts)
 {
-	struct ksz_ptp_data *ptp_data = ptp_caps_to_data(ptp);
-	struct ksz_device *dev = ptp_data_to_ksz_dev(ptp_data);
 	const u16 *regs = dev->info->regs;
 	int ret;
 
-	mutex_lock(&ptp_data->lock);
-
 	/* Write to shadow registers and Load PTP clock */
 	ret = ksz_write16(dev, regs[PTP_RTC_SUB_NANOSEC], PTP_RTC_0NS);
 	if (ret)
-		goto unlock;
+		return ret;
 
 	ret = ksz_write32(dev, regs[PTP_RTC_NANOSEC], ts->tv_nsec);
 	if (ret)
-		goto unlock;
+		return ret;
 
 	ret = ksz_write32(dev, regs[PTP_RTC_SEC], ts->tv_sec);
 	if (ret)
-		goto unlock;
+		return ret;
 
 	ret = ksz_rmw16(dev, regs[PTP_CLK_CTRL], PTP_LOAD_TIME, PTP_LOAD_TIME);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int ksz_ptp_settime(struct ptp_clock_info *ptp,
+			   const struct timespec64 *ts)
+{
+	struct ksz_ptp_data *ptp_data = ptp_caps_to_data(ptp);
+	struct ksz_device *dev = ptp_data_to_ksz_dev(ptp_data);
+	int ret;
+
+	mutex_lock(&ptp_data->lock);
+
+	ret = __ksz_ptp_settime(dev, ts);
 	if (ret)
 		goto unlock;
 

-- 
2.55.0

