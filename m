Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CE1439014
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788343077; cv=none; b=fMkrHHUjNABmXfVN7Ao/vKY4uSemT+wEld2FK3sCPgYxUh24TinB+WxVrO+4uN85+JGlMAfKL/IPgYAWpFlMReF2BOdRE9b7KFoOPTTRJTgHQBeLLo7kxkY4HSCrdfdl3jMyZ2CDB0FPCCltulMU4BR05cl3agahsDbii/R+OA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788343077; c=relaxed/simple;
	bh=vXKUgJKXsx7Kv49NZnrrFQ+yzUjOQ+zLrt/7kLCcoPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qm8jnwRU0p4cAuUzLvIctdZ3xn3HNyW76APv9elFZEZ5wwOHkAfbmLHbESF/yBnu9dolH09ZQuYLyaN7598P/2IxvAJoAkVvMmKh8YLsoK2CQL3hY9Bc9YiWi5+eHzSfFW90+xfoMG8WUiYA9msA5LfsExOQ8TnmH92N+vJgyG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wWfPjg2W; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wWfPjg2W"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 000764E41428;
	Wed,  2 Sep 2026 09:57:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C77CC6053C;
	Wed,  2 Sep 2026 09:57:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 90E5C11C79326;
	Wed,  2 Sep 2026 11:57:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788343072; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mpkRRBCGYrpAM2XmasON5pHjjfU5MVVzSv16ATHoLl8=;
	b=wWfPjg2WLXf9EBljftJ+UFEZLitGjldBNYNJryABde+O0q4iUwBs69qzaW05HDGDzdBskH
	SlMA+VuKk/bJ9EgLl+MyJKK2hwRan2MZBp4ZLs9u0e0HLgoNfrrNrIxs3twAWH61ayEWwv
	5gJTw75cSSEZOhvgOpBRoMI58O0g4jlvOdr7yp9dR4o4vHCNRaTUMnehtIOsy167mRJzlU
	h2nRoOQNZmSCQaSeuXOGKgdcp4QXdnWPBVyrtnK3M6OiYTRd0yhhSFxcMw4zLmYsMJe07k
	cF1Y5LV7HCZIIDoL3Max1ytQ6Vyhub1N/F0kXM5RNzZS9ZHwbUUqy/ulD8QNEA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Wed, 02 Sep 2026 11:57:36 +0200
Subject: [PATCH net-next v2 06/10] net: dsa: microchip: extract
 compute_width
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-ksz-perout-v2-6-6f277fcc9e68@bootlin.com>
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
dedicated ksz8463_ptp_enable_perout() function needs to be created. This
function will use the same algorithm to compute the periodic cycles as
the common ksz_ptp_enable_perout() function.

Extract these algorithms into dedicated functions so they can be used
later by the KSZ8463 support.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 67 ++++++++++++++++++++++++-------------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index f97ea9d69ebc..2f141df65eb0 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -203,12 +203,49 @@ static int ksz_ptp_get_pin(struct ksz_device *dev,
 	return pin;
 }
 
+static int ksz_ptp_compute_perout_cycle(struct ksz_device *dev,
+					struct ptp_perout_request const *request,
+					u64 *cycle_width_ns)
+{
+	struct ksz_ptp_data *ptp_data = &dev->ptp_data;
+
+	ptp_data->perout_target_time_first.tv_sec  = request->start.sec;
+	ptp_data->perout_target_time_first.tv_nsec = request->start.nsec;
+
+	ptp_data->perout_period.tv_sec = request->period.sec;
+	ptp_data->perout_period.tv_nsec = request->period.nsec;
+
+	*cycle_width_ns = timespec64_to_ns(&ptp_data->perout_period);
+	if ((*cycle_width_ns & TRIG_CYCLE_WIDTH_M) != *cycle_width_ns) {
+		*cycle_width_ns = 0;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static u64 ksz_ptp_compute_perout_pulse(struct ksz_device *dev,
+					struct ptp_perout_request const *request,
+					u64 max_pulse_width)
+{
+	u64 req_pulse_width_ns;
+
+	if (request->flags & PTP_PEROUT_DUTY_CYCLE)
+		return request->on.sec * NSEC_PER_SEC +	request->on.nsec;
+
+	/* Use a duty cycle of 50%. Maximum pulse width supported by the
+	 * hardware is a little bit more than 125 ms.
+	 */
+	req_pulse_width_ns = (request->period.sec * NSEC_PER_SEC +
+			      request->period.nsec) / 2;
+	return min_t(u64, req_pulse_width_ns, max_pulse_width);
+}
+
 static int ksz_ptp_enable_perout(struct ksz_device *dev,
 				 struct ptp_perout_request const *request,
 				 int on)
 {
 	struct ksz_ptp_data *ptp_data = &dev->ptp_data;
-	u64 req_pulse_width_ns;
 	u64 cycle_width_ns;
 	u64 pulse_width_ns;
 	int pin = 0;
@@ -234,29 +271,11 @@ static int ksz_ptp_enable_perout(struct ksz_device *dev,
 		ptp_data->tou_mode = KSZ_PTP_TOU_IDLE;
 		return 0;
 	}
-
-	ptp_data->perout_target_time_first.tv_sec  = request->start.sec;
-	ptp_data->perout_target_time_first.tv_nsec = request->start.nsec;
-
-	ptp_data->perout_period.tv_sec = request->period.sec;
-	ptp_data->perout_period.tv_nsec = request->period.nsec;
-
-	cycle_width_ns = timespec64_to_ns(&ptp_data->perout_period);
-	if ((cycle_width_ns & TRIG_CYCLE_WIDTH_M) != cycle_width_ns)
-		return -EINVAL;
-
-	if (request->flags & PTP_PEROUT_DUTY_CYCLE) {
-		pulse_width_ns = request->on.sec * NSEC_PER_SEC +
-			request->on.nsec;
-	} else {
-		/* Use a duty cycle of 50%. Maximum pulse width supported by the
-		 * hardware is a little bit more than 125 ms.
-		 */
-		req_pulse_width_ns = (request->period.sec * NSEC_PER_SEC +
-				      request->period.nsec) / 2;
-		pulse_width_ns = min_t(u64, req_pulse_width_ns,
-				       KSZ_MAX_PULSE_WIDTH);
-	}
+	ret = ksz_ptp_compute_perout_cycle(dev, request, &cycle_width_ns);
+	if (ret)
+		return ret;
+	pulse_width_ns = ksz_ptp_compute_perout_pulse(dev, request,
+						      KSZ_MAX_PULSE_WIDTH);
 
 	ret = ksz_ptp_tou_pulse_verify(pulse_width_ns, TRIG_PULSE_WIDTH_M);
 	if (ret)

-- 
2.55.0

