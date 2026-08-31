Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F40743F091
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182748; cv=none; b=TuowMtdKmzh6jegf05llLBhsUCH1+bLjvLneK37vQMPz2d/EKGKvoKN4Ih3T/Z+mFalv38xZlnK8vfPQh2cjnweWBUkImjR3cRB81H7rKXhitsqSi/pRrXz6CzeSJub9tdMzDFO8iWm7t6mcBVVDRcImd8Y0y7ZUIPcL7b+ALFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182748; c=relaxed/simple;
	bh=TsIhuHzuFTywoVrgOlVnMNKYyPqvRsXdnxoJalehQEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bzdHaT7xuTlx/P1YGPh9cSuVVd2kOIxgbp6zfGF1dbAyLHm4aJcHznuU71JIBoh+1NbSjqWxrjcDhnzLgc4DfcQu6mfZzj4EaZqoTQ8Y2QLeDYhptu/Gn5wRVr1VBY/Erbz0yzIe0z1sdkL0HW7NN+b2YFjxBva3HEDE6+Uen44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NlLYDX36; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NlLYDX36"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 111EA1A191A;
	Mon, 31 Aug 2026 13:25:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DA11B60231;
	Mon, 31 Aug 2026 13:25:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B418411C783F8;
	Mon, 31 Aug 2026 15:25:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788182744; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8domjthatR7Oi/LI1vxQUg/eTcs+Epax+tMV1ZAjQ64=;
	b=NlLYDX36F/psIWz9sm6Ym4xtUsNT7+yk7j2CHtNQIUTOed9pLYz4lKRGEY2n1H+fBfZoBC
	UikogtryYBsMg9Ddzp0NhXms66svRD0UC3dafnh3wak6Ex+8zK/n+doCLAIbw7bBg543Rv
	BEm+LEMYpaR/h/p0ejfRSVEBsG5MMgCf5eT6SxiOs3KEzNMX4xC3Dx4r+gskYcL+ihe7Nk
	c296tzobrzaqIbY6Osx7Ci9spA1P4HH2uIltH78L0yZcZnzoQ8TFPPts0lHbgPo5oonw3I
	fF7OwuZqTK9dCCrWJg3ap3HOhOz6mcLPiyz0TO4pPVIA6VY/KpDXgCRORaVFeg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 31 Aug 2026 15:25:31 +0200
Subject: [PATCH net-next 09/10] net: dsa: microchip: extract time
 adjustment
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-ksz-perout-v1-9-14202db763b3@bootlin.com>
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
dedicated ksz8463_ptp_adjtime() function needs to be created. This
function will access the same registers as the common ksz_ptp_adjtime()
function.

Extract the register accesses into a dedicated function so it can be
used later by the KSZ8463 support.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index aa73ad1f05d8..0a77b46cfad2 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -946,18 +946,13 @@ static int ksz_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 	return ret;
 }
 
-static int ksz_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
+static int __ksz_ptp_adjtime(struct ksz_device *dev, s64 delta)
 {
-	struct ksz_ptp_data *ptp_data = ptp_caps_to_data(ptp);
-	struct ksz_device *dev = ptp_data_to_ksz_dev(ptp_data);
-	struct timespec64 delta64 = ns_to_timespec64(delta);
 	const u16 *regs = dev->info->regs;
 	s32 sec, nsec;
 	u16 data16;
 	int ret;
 
-	mutex_lock(&ptp_data->lock);
-
 	/* do not use ns_to_timespec64(),
 	 * both sec and nsec are subtracted by hw
 	 */
@@ -965,15 +960,15 @@ static int ksz_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 
 	ret = ksz_write32(dev, regs[PTP_RTC_NANOSEC], abs(nsec));
 	if (ret)
-		goto unlock;
+		return ret;
 
 	ret = ksz_write32(dev, regs[PTP_RTC_SEC], abs(sec));
 	if (ret)
-		goto unlock;
+		return ret;
 
 	ret = ksz_read16(dev, regs[PTP_CLK_CTRL], &data16);
 	if (ret)
-		goto unlock;
+		return ret;
 
 	data16 |= PTP_STEP_ADJ;
 
@@ -984,6 +979,22 @@ static int ksz_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 		data16 |= PTP_STEP_DIR;
 
 	ret = ksz_write16(dev, regs[PTP_CLK_CTRL], data16);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int ksz_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+	struct ksz_ptp_data *ptp_data = ptp_caps_to_data(ptp);
+	struct ksz_device *dev = ptp_data_to_ksz_dev(ptp_data);
+	struct timespec64 delta64 = ns_to_timespec64(delta);
+	int ret;
+
+	mutex_lock(&ptp_data->lock);
+
+	ret = __ksz_ptp_adjtime(dev, delta);
 	if (ret)
 		goto unlock;
 

-- 
2.55.0

