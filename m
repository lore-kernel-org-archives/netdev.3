Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324B443D50E;
	Mon, 31 Aug 2026 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182746; cv=none; b=ta4rlwXfdHYbw1zFM++Xz1Pkc2UoBfK0M1KgEy74Bk8Ws0pGqxxZg7ceZqL4ulZiWMryMe7z4Apnldq3hWTfM5HyQYalrbxxTIFfhVuizOjaWGUiKThlgwCsfqOoh9zOY3y46dnQYD1sSSevRTbcAiARlwVTRtu5Flm5TnTn9Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182746; c=relaxed/simple;
	bh=elhEQoqrJU0Bva3r+jlfTvSY8EbxMP1ywSHdj8Kg318=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rjiSi+MmjzCuT5VTjgqKI7guGFR30RMHVPARJ+yRl+kXjZCaZhFi8d4gp41pCfjC5WDyxTk3Akkcil0YDKrdfeWQeTo8ylKZtMONvrHT9wprHP/p+RGYVvtDDs+AmiWdx1Rsd6DNvoFrdpAC8lZ90v9vo07+6D9llZuZtZ5D/h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nQV6rkFs; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nQV6rkFs"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 64B144E4147F;
	Mon, 31 Aug 2026 13:25:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 38F8660231;
	Mon, 31 Aug 2026 13:25:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 010BF11C78C5F;
	Mon, 31 Aug 2026 15:25:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788182742; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UE3d8uBd3AkiHRdBNbCVNULk3X2F/j5sdXNN38PNd5o=;
	b=nQV6rkFs7zcRLCAa+U/agvUmj9T0Mhg9/3rQApUJOqja/ECpyKQbV1kDRAIB/BGKVH/3ns
	ZPgJxuKyiWw+KgGdI3tzqaIWYOP4fjlhhcvFKSTqU6yR1ueo0ed8QRxYV0OJcmrCFVSd0s
	bijIshKGa8MDtNA2eJPwAMIzAAY3E4cZNspQ08m4C1pmiw/riAexOM60w5vvISJ2mbynbu
	e6yn7i1MsaNaYLqICGAkBW3R1w4gMm8/fECrHY5ycSDkIw6bxub3H6R6r3fSq0N98Pywzn
	hZzr9NHgHnjdmqmLtJs48EhQTFd/J+ZnjsgNYeyx+2WKeXOdnOR7HesUhSFXvQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 31 Aug 2026 15:25:30 +0200
Subject: [PATCH net-next 08/10] net: dsa: microchip: extract time update
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-ksz-perout-v1-8-14202db763b3@bootlin.com>
References: <20260831-ksz-perout-v1-0-14202db763b3@bootlin.com>
In-Reply-To: <20260831-ksz-perout-v1-0-14202db763b3@bootlin.com>
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

