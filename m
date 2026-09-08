Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A473A8740
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 07:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788852500; cv=none; b=snKQOOJsFoMHKYFv7OKFyHTIg4lRhaJGbF73mimWopxMzK3NIxLUp/cM6t8QbhSsZDGg5v8e1BemwShmdmzBsh6o1pMvVM42ejNgt3Yt9W6apmI0UlqTcMqrCPyQfODH2qITBGUdDVHXN2oL63HYP3msu8JwelLUEWGzonILiAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788852500; c=relaxed/simple;
	bh=elhEQoqrJU0Bva3r+jlfTvSY8EbxMP1ywSHdj8Kg318=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VHELN8eVFxTmKcwATdRnd5AbYIzz1ac8UrhdJpg3WgRYu9cTqBCwlupGOy7bxaH3EmFbqofA+I8TRq5AWY+TS8OrpjZxjePvIZTI4+P1xDqS6NvlZTK2D1yACi7sPb7HqaYyfBurKzb+4PiBxg9qnvPd5G4POvqLuFj9xTkFCTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Cj8KCh1r; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Cj8KCh1r"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 697521A1A52;
	Tue,  8 Sep 2026 07:28:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3DDC260439;
	Tue,  8 Sep 2026 07:28:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D81D211C7AF2B;
	Tue,  8 Sep 2026 09:28:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788852496; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UE3d8uBd3AkiHRdBNbCVNULk3X2F/j5sdXNN38PNd5o=;
	b=Cj8KCh1rheUyELSFALgunt2W321XZNafFo4umzi4Ei09IF/vT/P0Ichqba2RLiVbCCMoFu
	B1Cb/tZdO1GpRddi4u++sl2dq0JXY1KkHtm8FIfrP17OlUm4KXYA0+3y32iWBU7Ef7sCLY
	ptKIzBS3yD6Hbfqo32oDtUabaScBcFlo8LujudwUDINvwo1G7KgFS/vQh0NcrSIqdi2Zil
	la7UhONKY/nyzxqMIu1Ekyp6pct5GX8dc4G7PNu9xSol8Iza7T5EOA3xqOSgaQsX6a4moJ
	ScGV3iuGb6hyvdYlRe6nnHfWmqLLnvv/Cfh5UflprMwLBkIDIi4Zl52p7XOZhQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Tue, 08 Sep 2026 09:27:48 +0200
Subject: [PATCH net-next v3 08/10] net: dsa: microchip: extract time update
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-ksz-perout-v3-8-6722a3f1ca75@bootlin.com>
References: <20260908-ksz-perout-v3-0-6722a3f1ca75@bootlin.com>
In-Reply-To: <20260908-ksz-perout-v3-0-6722a3f1ca75@bootlin.com>
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

