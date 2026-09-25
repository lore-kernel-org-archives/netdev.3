Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3D349C4A9
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 11:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336359; cv=none; b=eziqXeYNTtP9rUgIG3bFLVucMVs1e4OTZX/ZAEf8ICT+eDvkEUv8csg3QFrYHfwsJLBYy8CGwaJvk4LXNokJ+Cl6/QNymYlhmyeZF/spplaeKdbL1usHWCWBzdokocC6NpJIDW6W612afH8Ri1M0LleCYDJNaYWN+oSvliyO+MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336359; c=relaxed/simple;
	bh=o7ZL7xXPJyvegM3XYcjrbzQTGvd4nxVAeSyO4KTLVCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gMHVM3ftApbA/rlvqKnRCzSjP3quVYy9ZdYwYuZAmT2nOl9wXR8A/IIuFiot3tuW5XqSxFc+oHn7x18Teip4xRaMabf3C+FQ/n8n/l9milMp4g6IY06dvUjmCcRCZhE61/yNr1GYIUoOfIpNmUlyjb7uBa1t8yQohk1ElXXfnNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IgHK4CUZ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IgHK4CUZ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 43BCA4E41073;
	Fri, 25 Sep 2026 11:39:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 12CC86073B;
	Fri, 25 Sep 2026 11:39:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 886C0103295CF;
	Fri, 25 Sep 2026 13:39:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790336355; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Tg4/FUhHVtBzkdz++1ILakEEZ65MTLOg4su3TmKClnQ=;
	b=IgHK4CUZtZn/xwOF1JZm34jBeSDAs46JL4G5m2JWG+iY/MVCK6uUbtZRz7zVjYSk48PiRu
	qQXuYYAGkozSH9OQ/YeQan11eLcKFho5ei1AUxKZI8PZJdc6rd95vb7HQsK48Tdil75zcC
	JNw1uBuMllZp9xwkiTV8Hb+ebAn2RyD+2JdCanADElP59/g40j3FAtJQCdCi3ejtxr1JIJ
	/QaYIgcDbpU190BjfIZnUidkmnP6PA30YeRLpPve1J7FMlEG93Uh6ESPaDqAefrHHo82Cs
	rRKgVJPI2Q/95Rh5nkXkQafjve279Q5yL9IEr4sBnjwinLVcYbi/Z54RjPIwZA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Fri, 25 Sep 2026 13:38:56 +0200
Subject: [PATCH net-next v4 10/11] net: dsa: microchip: extract time
 adjustment
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-ksz-perout-v4-10-d675bd21ce49@bootlin.com>
References: <20260925-ksz-perout-v4-0-d675bd21ce49@bootlin.com>
In-Reply-To: <20260925-ksz-perout-v4-0-d675bd21ce49@bootlin.com>
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
index 1244ef44df34..c1c4c781bca7 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -954,18 +954,13 @@ static int ksz_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
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
@@ -973,15 +968,15 @@ static int ksz_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 
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
 
@@ -992,6 +987,22 @@ static int ksz_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
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

