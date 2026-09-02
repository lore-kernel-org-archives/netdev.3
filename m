Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCCC43801F;
	Wed,  2 Sep 2026 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788343075; cv=none; b=oBghfSh0gQmHB4ePpY4fAdkByBIBwYqYgrqI7DWV6qIWXthmFDdWFmaiS6SvGKMwMXtd3xHCKBVWbSCkr+F8XucQAyuAhr7PFP+WU38G3B5wuox8ZC1+GMU9zLjOoapwPfLivjdpB1tLOzofDvOeMiIJ/ajLJP2fhf6ADoWIJyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788343075; c=relaxed/simple;
	bh=8G7v58vm4MsYglvYir8IarLbnRs5ks3dw3PAJnTs2gU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=txzyP2C5wYgQ3KNQI05hNUIznzkXYADnlSzQlQ3aPPJHgurKgjtwzZGYik4NhiQWHYZK3V4nW5WpRreoOzysT/M8o/gmgYAgWIHIArK7ptMr4FoJDwzkepg2fltlbitkpBGz6HbLE8EMy4eJ+NeMtSleQYq2PgCtLuluTY/VZlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tD7rn33C; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tD7rn33C"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3F9741A1948;
	Wed,  2 Sep 2026 09:57:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 13E4F6053C;
	Wed,  2 Sep 2026 09:57:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9A53311C79321;
	Wed,  2 Sep 2026 11:57:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788343070; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=o9jL6igQLJRDua5JaF1IyEJ/zeHLPSI/dmv7m8kdRo8=;
	b=tD7rn33CWs64nV0nzLDUaHc7WhqOlgCZIzpFTdW5rgkj+VSEZS5uFFlWvongGvKHFoWrOr
	scq+4YuOMtzpoDA5EeRej10/ko1zOxWtaXUjMP2rFUKWpufH0VGDGwvsBn9fAWNY9bv0Qo
	bwc85OovAq3U26vddB1DeAwO5grc9ibSEFR9tDuIzIXsm33tMstGQRrxdrtlQzA2lsODxM
	DF8HsPHtjMIMHY6FGhgT7zpWIxYM1iXm8vfFhwMy2S6amxbuwfJUCLexmOIYAZhFZqDwSf
	/FSQRiLrIDbkAC6SIYaUrmxycqu9gQPP7wa5BNY7RBs1dauaZIEflAYTXLyScQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Wed, 02 Sep 2026 11:57:35 +0200
Subject: [PATCH net-next v2 05/10] net: dsa: microchip: extract ptp_get_pin
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-ksz-perout-v2-5-6f277fcc9e68@bootlin.com>
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
function will use the same algorithm to select the output pin as the
common ksz_ptp_enable_perout() function.

Extract the pin selection algorithm into a dedicated function so it can
be used later by the KSZ8463 support.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index ea22601f6b26..f97ea9d69ebc 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -183,17 +183,11 @@ static int ksz_ptp_configure_perout(struct ksz_device *dev,
 	return 0;
 }
 
-static int ksz_ptp_enable_perout(struct ksz_device *dev,
-				 struct ptp_perout_request const *request,
-				 int on)
+static int ksz_ptp_get_pin(struct ksz_device *dev,
+			   struct ptp_perout_request const *request)
 {
 	struct ksz_ptp_data *ptp_data = &dev->ptp_data;
-	u64 req_pulse_width_ns;
-	u64 cycle_width_ns;
-	u64 pulse_width_ns;
-	int pin = 0;
-	u32 data32;
-	int ret;
+	int pin;
 
 	if (request->flags & ~PTP_PEROUT_DUTY_CYCLE)
 		return -EOPNOTSUPP;
@@ -206,6 +200,25 @@ static int ksz_ptp_enable_perout(struct ksz_device *dev,
 	if (pin < 0)
 		return -EINVAL;
 
+	return pin;
+}
+
+static int ksz_ptp_enable_perout(struct ksz_device *dev,
+				 struct ptp_perout_request const *request,
+				 int on)
+{
+	struct ksz_ptp_data *ptp_data = &dev->ptp_data;
+	u64 req_pulse_width_ns;
+	u64 cycle_width_ns;
+	u64 pulse_width_ns;
+	int pin = 0;
+	u32 data32;
+	int ret;
+
+	pin = ksz_ptp_get_pin(dev, request);
+	if (pin < 0)
+		return pin;
+
 	data32 = FIELD_PREP(PTP_GPIO_INDEX, pin) |
 		 FIELD_PREP(PTP_TOU_INDEX, request->index);
 	ret = ksz_rmw32(dev, REG_PTP_UNIT_INDEX__4,

-- 
2.55.0

