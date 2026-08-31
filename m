Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7B942E40F
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182738; cv=none; b=SKnh9zv6M8GMN8rCBO4OuRyO6qnAzbDI2ArxDWXsV7yfxkTH/1QTqg+2s/cB4j+RDcEwNqP3XYSWMOxVuU/09UZfOaPZqimePag7/h4Ym3iYD9TrBpmGkUv8bH9oEmUFFScaYlJSNgbAjlqaXZL0m5Bqqvxj2OuGuA/38l6uE1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182738; c=relaxed/simple;
	bh=HkXxTB72wQCMpzYwUnwAJU9KwsD3ZJwAbFrv0fPqNd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u8vOUJJ53KgRyI59v9GvN/S8ZXWw1JWJgfUVpcymqS6jU/JaWDi58oCoXvrNF5N6OK4T9XGCfW2VmgJaUGwMiY0FGLQAW4HZ69cvYEVV5drYyR1Ug/HF3AOXgsQS5EQln9rmKHHya86VovJ4u1vvLpzg2yXy1FAtAufKFQ9Thww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xR8yMutY; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xR8yMutY"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D68684E4147F;
	Mon, 31 Aug 2026 13:25:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AB32360231;
	Mon, 31 Aug 2026 13:25:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B310811C78B96;
	Mon, 31 Aug 2026 15:25:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788182733; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=OUS3SdUwNSk48tuvVvsVFTUNr9za3nsJwxnsYhhP2sM=;
	b=xR8yMutYsque89ValjlL01hm9mGxgQh39pYSb7xs968dGYukL8omyZztecG6HL9pWRqQC7
	fdxSomoDlX3JWgAPziZ9npXESsAm+dsY19kKBV5T//I2y8iaeEq/vNOiuXZ0hf5QKkaYGV
	8ZOQwkg2J50w5vI2HPgJhx5340/WnDlSNAGG0PqnzUi/GaL6svC8UEc6Huibmi+Pndk9Vo
	uRIvlOHm1PJ3AYZmzOwso7EMCGbpZWB+Zo0Pr6J4o2Vmqc/GPOqDWVK5+ayVE8svRL5o2h
	37ZuVjA3vKmPHom5N6x0GFcBTnwrOdJ2zC289mTiwttwfNEvTNzF0/rKPuxP2Q==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 31 Aug 2026 15:25:25 +0200
Subject: [PATCH net-next 03/10] net: dsa: microchip: use dynamic mask to
 check pulse width validity
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-ksz-perout-v1-3-14202db763b3@bootlin.com>
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

The pulse width validity is checked against an hardcoded mask. KSZ8463
uses a smaller register than other switches so this check won't work for
it.

Move the mask as a ksz_ptp_tou_pulse_verify()'s input to allow changing
it for KSZ8463 case.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index f80015250e5a..7bf83e0b5918 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -86,7 +86,7 @@ static int ksz_ptp_tou_reset(struct ksz_device *dev, u8 unit)
 			 0);
 }
 
-static int ksz_ptp_tou_pulse_verify(u64 pulse_ns)
+static int ksz_ptp_tou_pulse_verify(u64 pulse_ns, u32 mask)
 {
 	u32 data;
 
@@ -94,7 +94,7 @@ static int ksz_ptp_tou_pulse_verify(u64 pulse_ns)
 		return -EINVAL;
 
 	data = (pulse_ns / 8);
-	if (!FIELD_FIT(TRIG_PULSE_WIDTH_M, data))
+	if ((mask & data) != data)
 		return -ERANGE;
 
 	return 0;
@@ -245,7 +245,7 @@ static int ksz_ptp_enable_perout(struct ksz_device *dev,
 				       KSZ_MAX_PULSE_WIDTH);
 	}
 
-	ret = ksz_ptp_tou_pulse_verify(pulse_width_ns);
+	ret = ksz_ptp_tou_pulse_verify(pulse_width_ns, TRIG_PULSE_WIDTH_M);
 	if (ret)
 		return ret;
 

-- 
2.55.0

