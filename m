Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3971A3A1E66
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 10:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772619559; cv=none; b=CH985JMo0GmgxXN1urDurl8IBoTJj5WjgFgNs7MUTB+kNBW5tPQI/V/uhbLVRkGaeozcUgaFyAskqjith6/a2XojPTIVquRKMqY9Xe5mO4xg5xp9pug9VKCtXspp1CBy6xoA/zgd8nFzhPaA+nc/jgwHgrmtN4WqmciKjWtk+ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772619559; c=relaxed/simple;
	bh=flBgMZFPZY708TYhKPRkshuBuBUgHdu2eO+sX4F3AD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ui/plN+SpFCWySUUjiBPpLuEVfMzBqNBcQIzN31Bd/s2hhEEhGH/od3YJAa8wMXPJf/77EzycdCjp0M65CLRk2bzxbU1SdQ2V7B/hf4TWa56uu78MfmX3FNJN/uYYYtJL6SGobfL3DY83BvGxmlyC+tuk1LVr8FaPHRPZ8AB548=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eUayZTNM; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eUayZTNM"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EA664C40683;
	Wed,  4 Mar 2026 10:19:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DB1F25FF5C;
	Wed,  4 Mar 2026 10:19:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 303911036977D;
	Wed,  4 Mar 2026 11:19:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772619553; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=J83UoEJhAGh9Q63fdG3raIWycuxXozVbR1Mhr+9V1Ho=;
	b=eUayZTNMEYypmmJKfqJouOhaRT7HhuVvYplzHC+jZfLGaHyvf09g40vllYYYrYtC1PRQvx
	KXFfmOmBGc9mzRnRRSJQQ2Wr/lAogagHIizX9W1ytC45gajMzpaZ2qqxsrAFj1FYpiyg1Z
	Xxj1p20Pmb1QoZpDxoUPsg5usZxfaJq7tueP41G0nz2FTJx8okGyRewCMOKggnbYaTLiFt
	TmPYry+4BY8+0xVDYIzqf58e9aRmLJCbieOmMW8FXivLmtxUUVS205DC1CnC0fd9S0qGrA
	5l6aAxCzhQJxzyN3mvmGn/jsJjQUL6qJh+9adzgdcCTokoUvA9IIkpczxDLgwA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Wed, 04 Mar 2026 11:18:58 +0100
Subject: [PATCH net-next v6 7/9] net: dsa: microchip: Explicitly enable
 detection of L2 PTP frames
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-ksz8463-ptp-v6-7-3f4c47954c71@bootlin.com>
References: <20260304-ksz8463-ptp-v6-0-3f4c47954c71@bootlin.com>
In-Reply-To: <20260304-ksz8463-ptp-v6-0-3f4c47954c71@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Detection of L2 PTP frames needs to be enabled for PTP to work at the L2
layer. The bit enabling this detection is set by default on the switches
currently supported by the driver, but it is unset by default on the
KSZ8463 for which support will be added in upcoming patches.

Explicitly enable the detection of L2 PTP frames for all switches when
PTP is enabled.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index dab7016c6f38a37ed6e2dc60a1f1251aea6a7cbc..7bb5191e780f151fe74ff0163ea1fa8b0f3ebee9 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -947,8 +947,9 @@ int ksz_ptp_clock_register(struct dsa_switch *ds)
 	/* Currently only P2P mode is supported. When 802_1AS bit is set, it
 	 * forwards all PTP packets to host port and none to other ports.
 	 */
-	ret = ksz_rmw16(dev, regs[PTP_MSG_CONF1], PTP_TC_P2P | PTP_802_1AS,
-			PTP_TC_P2P | PTP_802_1AS);
+	ret = ksz_rmw16(dev, regs[PTP_MSG_CONF1],
+			PTP_TC_P2P | PTP_802_1AS | PTP_ETH_ENABLE,
+			PTP_TC_P2P | PTP_802_1AS | PTP_ETH_ENABLE);
 	if (ret)
 		return ret;
 

-- 
2.53.0

