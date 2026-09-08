Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D303A8FEA
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 07:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788852502; cv=none; b=AvNQ7pZyEr8yilZFE8H88p/CEBZE3xKrS56BjTjMkIpkV5ZP+xoY+v9FF0OJ/dEuMSEwGKykD4Zb2ZmZDnKSj4tbRXQN1WzCCZIy+rhMPLeQD/NjFRrcbyCzawuMCHhRickckJ34yLHGwFc/gOwl8zEfv6GIn+5NtAwvg6y/lHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788852502; c=relaxed/simple;
	bh=TsIhuHzuFTywoVrgOlVnMNKYyPqvRsXdnxoJalehQEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iIFmBacXvvFI0RRi0/H/H0LeLQjq3j6g9YiheDTffuYywa5G1seo+bX9TpMOPIV0uBknrY+uIocTXZqRzT4KjVjH6sta5Y0LzOAQrH3MlSg49WFdmgR6VFuDEqxY+11ChiyDoPx7pF15Pu7E5IQHMeWakaYAn8ijaAKLcJN6/FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lKtEyN2h; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lKtEyN2h"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3A7C84E4158C;
	Tue,  8 Sep 2026 07:28:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0FFA1603C4;
	Tue,  8 Sep 2026 07:28:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9F41B11C7AF32;
	Tue,  8 Sep 2026 09:28:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788852498; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8domjthatR7Oi/LI1vxQUg/eTcs+Epax+tMV1ZAjQ64=;
	b=lKtEyN2hMhOxB8rJX7Y07mbstO86p9rIcUuwLL4TOGf8aIiQhP5RFE/eAxouGO1spNsS7o
	exMFu1Occ8nYjgyRz3vW4W3TNdloFnkvbGADSBYmI18+jFfkIO5FQe0E98MX9m8TW63Ccc
	MjRdie6qpQZXgf3qPym11Yu7ja8BKQgBgmBAQFV9gmlpI5Qud8tZnsOhyZtSWLrn53A6Wk
	sP+3uDcqevrwsGhwGmqN/q57/QAlIGEdWEftqnu0oCSjeaixVYqanhzFBH6kmKEK3twIJU
	CFJhSFsm5QDtqKxNt37+bRxcdMbFVR4Hse7OQ1J9YIqN3AtfQc0OkekaPTB7eA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Tue, 08 Sep 2026 09:27:49 +0200
Subject: [PATCH net-next v3 09/10] net: dsa: microchip: extract time
 adjustment
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-ksz-perout-v3-9-6722a3f1ca75@bootlin.com>
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

