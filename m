Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB11C396D25
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 07:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788852494; cv=none; b=SxHs1g5fuFtOB692cQinz3BlSCWacfu1CdHtN/mePFojLmbkIxC1JpPjJzSraU0UErRcHA1C2b16DlwFsRVvRPLjgSLXONGSAXMQSsZAPKRiO6fVEnAG84GZWOsc1mefsA/YhULsC+oFybGwNBAPy5T/fr/0XWPGXLH7ufMsitw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788852494; c=relaxed/simple;
	bh=8G7v58vm4MsYglvYir8IarLbnRs5ks3dw3PAJnTs2gU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K/6WMoKlKnI5sR8QsmT0V27PEtEIgLl5P0MnfATSrOWhql9Rm0GzMmpjlPtbrG/OdLwbSwU1RlX9rGrHWviHhT6Wx+JIfBjmqpayyrQg3VA1TqsvhYfdjOVfAbsi09xWA7jv2kRJ8EYWiWOHg0IbKNht+OQJSyxd+ANrf1XZ34w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=di+hG1RE; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="di+hG1RE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1D7E91A1A51;
	Tue,  8 Sep 2026 07:28:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DF0FD603C4;
	Tue,  8 Sep 2026 07:28:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F368911C7AF39;
	Tue,  8 Sep 2026 09:28:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788852485; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=o9jL6igQLJRDua5JaF1IyEJ/zeHLPSI/dmv7m8kdRo8=;
	b=di+hG1REoZ0SOfDBUeQNSP01IoIGaIS6OWY7lG0zDHqdzP8VFQE81cjE4pjg/S0d8jcjY+
	nvVji34f23clMaF19o9Kyq/jg9UOtixeYviMey+axn6vXEepi3jRVwfqbInwCYCCaGWnWx
	HxUzRqeVsz0kZBVVXcJMo8PXh3tpbg4jeyDnfWZm6xodGB+v0/BWDgp9LBiSYJompJeqzv
	kvKug34CWOrodUju0She/yCfbrNx5/KRg8C7uKHcUjtrx8RE+uQZ2AVx5LSECI8vLR86Zg
	Z4HfzC0NLz8ezPK+pv3Jyu+GVd6DWu5k1jf8VdhqsNAmUNe8mQ1t/LMkTq1kRQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Tue, 08 Sep 2026 09:27:45 +0200
Subject: [PATCH net-next v3 05/10] net: dsa: microchip: extract ptp_get_pin
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-ksz-perout-v3-5-6722a3f1ca75@bootlin.com>
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

