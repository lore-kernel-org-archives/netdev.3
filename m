Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9657B49B5B4
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336353; cv=none; b=HIVOFtWPOf2jX4qEtNl3Obpm7LX6lm9NcnzfHh91ZLjn/1ZYtKXLH/CzZxWqtyi9z17UfL9llqdOgmMXpwHbTvxUWgiBAaMD5bWgxgwTz2q7nsFfNZK3Im0TeO3FhK0OHIdESh8ueaa6q3vBSokwJbif0MzYI7uhTuxZII8rQ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336353; c=relaxed/simple;
	bh=Rz4INXqd4v5twKEbEnPVX5cCqwIoKaPgcpJSFhNIKpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OyQIrrWui+TzcrbNc/FTqTtQ1XHSAnJP7FBxLrgkZPlhwUqkBeF4XQ8CrzRL/ATmxpaGCcZBYHfipclitYU5QyJxn8InGuGcOIxP3tfz/czbKogXjTUvL61KjFWXYsI+KIoH4noHFmwmzearqZuXiQlu8LUtHSDmhQiZH38Ez1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wSFudx0B; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wSFudx0B"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EFC7FC13992;
	Fri, 25 Sep 2026 11:39:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 269BC6073B;
	Fri, 25 Sep 2026 11:39:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 008FA103295CD;
	Fri, 25 Sep 2026 13:39:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790336348; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9j17LiLeNdM6FE4Z9sFbSSpg7oi9U3LNLVCr07BrKYg=;
	b=wSFudx0BcbDr3PegoqsGK0KUhEtB8gBIGr8gf/IkAod9rZBbtO8v5lTrNIhe1T2qh1SRpN
	3wDLnvzP/PcAdjOgXzT1MvYnVG7WoayzKGOKooKwx0upCT70C19WddEIZpKw3JKrZhhEoD
	3WwxF2JdyeakjGUNaj3VngqEtyP0D3nl1f6Jdat/PQQINNRLWYxJUL84Vx9KjplsoZHTGS
	y16POazpc10W4WNeFBfaSVXmaeDwG5aZhoElgC0mP4HPb0AKXFiwQqW4r5xaGbqiWlHKpX
	y5MlPZ8X7Dzwy22EZZyo89ddKF70CKthV/mUONiNjUdAR3KYLaVsuvsAGHtMKg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Fri, 25 Sep 2026 13:38:53 +0200
Subject: [PATCH net-next v4 07/11] net: dsa: microchip: extract
 compute_width
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-ksz-perout-v4-7-d675bd21ce49@bootlin.com>
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
dedicated ksz8463_ptp_enable_perout() function needs to be created. This
function will use the same algorithm to compute the periodic cycles as
the common ksz_ptp_enable_perout() function.

Extract these algorithms into a dedicated function so they can be used
later by the KSZ8463 support.
Add some checks on the period to ensure the request is valid and will
not cause divide by zero issues if the periodic output is restarted.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 62 +++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 19 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 79520d345efc..4b57cf076bb4 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -203,12 +203,50 @@ static int ksz_ptp_get_pin(struct ksz_device *dev,
 	return pin;
 }
 
+static int ksz_ptp_compute_perout_cycle(struct ksz_device *dev,
+					struct ptp_perout_request const *request,
+					u64 max_pulse_width,
+					u64 *cycle_width_ns,
+					u64 *pulse_width_ns)
+{
+	struct timespec64 tmp;
+
+	if (request->period.sec < 0)
+		return -EINVAL;
+
+	if (!request->period.sec && !request->period.nsec)
+		return -EINVAL;
+
+	tmp.tv_sec = request->period.sec;
+	tmp.tv_nsec = request->period.nsec;
+	*cycle_width_ns = timespec64_to_ns(&tmp);
+	if ((*cycle_width_ns & TRIG_CYCLE_WIDTH_M) != *cycle_width_ns) {
+		*cycle_width_ns = 0;
+		*pulse_width_ns = 0;
+		return -EINVAL;
+	}
+
+	if (request->flags & PTP_PEROUT_DUTY_CYCLE) {
+		*pulse_width_ns = request->on.sec * NSEC_PER_SEC
+				  + request->on.nsec;
+		return 0;
+	}
+
+	/* Use a duty cycle of 50%. Maximum pulse width supported by the
+	 * hardware is a little bit more than 125 ms.
+	 */
+	*pulse_width_ns = (request->period.sec * NSEC_PER_SEC +
+			   request->period.nsec) / 2;
+	*pulse_width_ns = min_t(u64, *pulse_width_ns, max_pulse_width);
+
+	return 0;
+}
+
 static int ksz_ptp_enable_perout(struct ksz_device *dev,
 				 struct ptp_perout_request const *request,
 				 int on)
 {
 	struct ksz_ptp_data *ptp_data = &dev->ptp_data;
-	u64 req_pulse_width_ns;
 	struct timespec64 tmp;
 	u64 cycle_width_ns;
 	u64 pulse_width_ns;
@@ -236,24 +274,10 @@ static int ksz_ptp_enable_perout(struct ksz_device *dev,
 		return 0;
 	}
 
-	tmp.tv_sec = request->period.sec;
-	tmp.tv_nsec = request->period.nsec;
-	cycle_width_ns = timespec64_to_ns(&tmp);
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
+	ret = ksz_ptp_compute_perout_cycle(dev, request,  KSZ_MAX_PULSE_WIDTH,
+					   &cycle_width_ns, &pulse_width_ns);
+	if (ret)
+		return ret;
 
 	ret = ksz_ptp_tou_pulse_verify(pulse_width_ns, TRIG_PULSE_WIDTH_M);
 	if (ret)

-- 
2.55.0

