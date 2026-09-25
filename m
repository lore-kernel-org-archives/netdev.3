Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1739747884D;
	Fri, 25 Sep 2026 11:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336342; cv=none; b=I06STLJxbhVf3L4YTrL/Zo2HS9DIGfIbbkJWRKFePTG61Zsjdj36/FsLC0P/unn3hg6Sm9pPVnDPHvf3ydRQQj4avogM8KvmCjeZQ+yoPAKDw8zkE4HlzK12dHk1mMwr/zLNJwrqbFC5taOe1o9pYEo57ofQf4eGS0LQJQHpdNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336342; c=relaxed/simple;
	bh=TRcjOVHscf7xvfG4sSHkIYPsycXdjpAkuuK5YxGhq5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O02ndsEam7zTn6hNrSXQKSqyrv04hpW4ddivkgpe3s5y2IVrrvku4aNQlMc3XeXwa+KuX1LkUFUaO9QbAz87QH62hPVvMs9ggHoQCJgqawEOBMfsRekB8tPMMYq50aHN27/JzAWZmfAyIKJcBIurMd9Gs0qAJgnJPLe2AqOJWDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vFHoJNmD; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vFHoJNmD"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7880F1A101D;
	Fri, 25 Sep 2026 11:38:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4CA4D6073B;
	Fri, 25 Sep 2026 11:38:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3F4FD10329514;
	Fri, 25 Sep 2026 13:38:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790336336; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pIkmxVq8uDg12AO1nulSarilG8XMK+I4DUXbKRGn0nM=;
	b=vFHoJNmD33FmH0AxT/5zh0Yl+KtmSUItfl/eIh10AmyNv+cmi8GuUF4C4Ob/vGgvLbBzBk
	rsRkgoDfTnRrDzQxiZsVQt02ugLQkexjv2qkj13smR9Nql1yjpfhHO7gqujYNai7ct8da1
	Pvy4YN9pshYP2fMnzleKJC4o0Gi5DCzOMeCUCkRYEG+vAjGHDp60iDsnOAUhVmS5U+NZ1i
	IWJSxnnJ7rAuQRtYxlJRzhl1CmTENVcTM0o5henaZovAxHn3nta9ikc0CG7n390hP64zTW
	rMu4vOgaCsHyd6DT1MiGbqONgoK6HIlvm/lECn9Mu8Vy7wcOuBXOhRtCBkm5HA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Fri, 25 Sep 2026 13:38:47 +0200
Subject: [PATCH net-next v4 01/11] net: dsa: microchip: fully save the
 periodic output request
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-ksz-perout-v4-1-d675bd21ce49@bootlin.com>
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

When a periodic output is initialized, its period and start time are
stored to initialize it back in case of restart. These information
aren't enough if the request contains flags or targets a pin that isn't
the first output of the switch. At restarts, these two arguments are
always set to 0.

The 'flag issue' isn't concrete so far because the driver doesn't
advertise any .supported_perout_flags so any flag request gets rejected
by the upper layer.
I don't know if other switches use non-zero indexes but the KSZ8463 has
twelve periodic outputs, so this index has to also be saved from now on.

Save the full request when a periodic output is successfully started.
Use the saved request when the periodic output is restarted.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 33 ++++++++++++++++++---------------
 drivers/net/dsa/microchip/ksz_ptp.h |  3 +--
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 39cc70d65900..47cf397481d5 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -189,6 +189,7 @@ static int ksz_ptp_enable_perout(struct ksz_device *dev,
 {
 	struct ksz_ptp_data *ptp_data = &dev->ptp_data;
 	u64 req_pulse_width_ns;
+	struct timespec64 tmp;
 	u64 cycle_width_ns;
 	u64 pulse_width_ns;
 	int pin = 0;
@@ -222,13 +223,9 @@ static int ksz_ptp_enable_perout(struct ksz_device *dev,
 		return 0;
 	}
 
-	ptp_data->perout_target_time_first.tv_sec  = request->start.sec;
-	ptp_data->perout_target_time_first.tv_nsec = request->start.nsec;
-
-	ptp_data->perout_period.tv_sec = request->period.sec;
-	ptp_data->perout_period.tv_nsec = request->period.nsec;
-
-	cycle_width_ns = timespec64_to_ns(&ptp_data->perout_period);
+	tmp.tv_sec = request->period.sec;
+	tmp.tv_nsec = request->period.nsec;
+	cycle_width_ns = timespec64_to_ns(&tmp);
 	if ((cycle_width_ns & TRIG_CYCLE_WIDTH_M) != cycle_width_ns)
 		return -EINVAL;
 
@@ -249,9 +246,10 @@ static int ksz_ptp_enable_perout(struct ksz_device *dev,
 	if (ret)
 		return ret;
 
+	tmp.tv_sec = request->start.sec;
+	tmp.tv_nsec = request->start.nsec;
 	ret = ksz_ptp_configure_perout(dev, cycle_width_ns, pulse_width_ns,
-				       &ptp_data->perout_target_time_first,
-				       pin);
+				       &tmp, pin);
 	if (ret)
 		return ret;
 
@@ -263,6 +261,8 @@ static int ksz_ptp_enable_perout(struct ksz_device *dev,
 	if (ret)
 		return ret;
 
+	memcpy(&ptp_data->perout_request, request,
+	       sizeof(struct ptp_perout_request));
 	ptp_data->tou_mode = KSZ_PTP_TOU_PEROUT;
 
 	return 0;
@@ -763,6 +763,7 @@ static int ksz_ptp_restart_perout(struct ksz_device *dev)
 	struct ptp_perout_request request;
 	struct timespec64 next;
 	struct timespec64 now;
+	struct timespec64 tmp;
 	unsigned int count;
 	int ret;
 
@@ -773,10 +774,14 @@ static int ksz_ptp_restart_perout(struct ksz_device *dev)
 		return ret;
 
 	now_ns = timespec64_to_ns(&now);
-	first_ns = timespec64_to_ns(&ptp_data->perout_target_time_first);
+	tmp.tv_sec = ptp_data->perout_request.start.sec;
+	tmp.tv_nsec = ptp_data->perout_request.start.nsec;
+	first_ns = timespec64_to_ns(&tmp);
 
 	/* Calculate next perout event based on start time and period */
-	period_ns = timespec64_to_ns(&ptp_data->perout_period);
+	tmp.tv_sec = ptp_data->perout_request.period.sec;
+	tmp.tv_nsec = ptp_data->perout_request.period.nsec;
+	period_ns = timespec64_to_ns(&tmp);
 
 	if (first_ns < now_ns) {
 		count = div_u64(now_ns - first_ns, period_ns);
@@ -791,12 +796,10 @@ static int ksz_ptp_restart_perout(struct ksz_device *dev)
 
 	/* Restart periodic output signal */
 	next = ns_to_timespec64(next_ns);
+	memcpy(&request, &ptp_data->perout_request,
+	       sizeof(struct ptp_perout_request));
 	request.start.sec  = next.tv_sec;
 	request.start.nsec = next.tv_nsec;
-	request.period.sec  = ptp_data->perout_period.tv_sec;
-	request.period.nsec = ptp_data->perout_period.tv_nsec;
-	request.index = 0;
-	request.flags = 0;
 
 	return ksz_ptp_enable_perout(dev, &request, 1);
 }
diff --git a/drivers/net/dsa/microchip/ksz_ptp.h b/drivers/net/dsa/microchip/ksz_ptp.h
index 7067ec9bd1e6..eb3827203b96 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.h
+++ b/drivers/net/dsa/microchip/ksz_ptp.h
@@ -29,8 +29,7 @@ struct ksz_ptp_data {
 	spinlock_t clock_lock;
 	struct timespec64 clock_time;
 	enum ksz_ptp_tou_mode tou_mode;
-	struct timespec64 perout_target_time_first;  /* start of first pulse */
-	struct timespec64 perout_period;
+	struct ptp_perout_request perout_request;
 };
 
 int ksz_ptp_clock_register(struct dsa_switch *ds);

-- 
2.55.0

