Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3730449E157;
	Fri, 25 Sep 2026 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336357; cv=none; b=Ry6Qavy8B7qhwGUFKw2xz71xmXi8ytDcBzR/QSfpEDpcYxXN4hLKLzLVQoaWEoCgOGJYAIgkA8M5GDZbBkjuKmXGoBYLj78B13yz5GdiadzkigNvw9OUulIEE8g1MNImMvXsN3c3WoNJdlUe3F8CrXuqcMt/o0dn5qqpK/fXGME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336357; c=relaxed/simple;
	bh=3xPvNTXShOzWk/CMQmqUrDuGxTwI7Gt07tVd8bYzBrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X70u+Ly9XdST46O1antd7se4V/UfD+3i4SbN7oEZnH2gdQVfV9a+1XkPBg1JEb6Xyji6gz8WVjVl93dzuZyQY3xg/tV7VLac+RurjhVWQxSP3Ldl/JdZrlIZq1nlOXBgdQJLmlg69eirzq5FHXjSdT9dVvHi1J5ZylMJH6lkjVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xP0CFsPb; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xP0CFsPb"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9A6E31A101C;
	Fri, 25 Sep 2026 11:39:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6EA016073B;
	Fri, 25 Sep 2026 11:39:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 79C15103295CC;
	Fri, 25 Sep 2026 13:39:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790336353; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5o7+Vko1YvoYgDU31XxXswp7SAGFgEhem0RYmkzFflg=;
	b=xP0CFsPbXZTyTWLfU9vHc8V9Zzxs725bmXJxesJ2CzQtiUq+IrEK6WluMk+yFEr8jdf1xK
	Rzy8mT/nmVty0eKswrmWX3nEaGna7v9XI4JwxiEaSzm2+PacbGrv88i3Ws5WPJLfB40/Je
	3416k58qOnEV/pGqTzk30cMWOOBhh1f44QRXMSp3Y5E/IYwh28HYWl6vso8cDrm+zV4uQE
	cSvGqpgo2l+3GngJC0ZGxAKGF8IXWLZYGi+CWsacLATfdz4L203AJZqHOXrehISZTvXRtR
	66Crjn7ybsNZ7nBRzleLpWw5FZ3DArBnjtCmw1kmKb//Ma3eL82slxlUNM22/g==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Fri, 25 Sep 2026 13:38:55 +0200
Subject: [PATCH net-next v4 09/11] net: dsa: microchip: extract time update
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-ksz-perout-v4-9-d675bd21ce49@bootlin.com>
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
index b627062dbaad..1244ef44df34 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -853,30 +853,42 @@ static int ksz_ptp_restart_perout(struct ksz_device *dev)
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

