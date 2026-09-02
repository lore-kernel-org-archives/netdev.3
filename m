Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE514334A9
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788343070; cv=none; b=IFLVWlxXYc65C3F77bZC+nX4/lKayy/tNPw9vn1o3rZPwAvP81mXYhzI6p2okunlw0PF/4cPXN1iGj2b5ICYE6vgzToYtbHujiOokNSj9VGG8znMCd16ElJsF9gJ0cnaAb4ovnpCKkx2cAvLo6WzTb0II97b2dbKxwx+GTqQ5JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788343070; c=relaxed/simple;
	bh=HkXxTB72wQCMpzYwUnwAJU9KwsD3ZJwAbFrv0fPqNd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d0ZwyHEgoR4mhhu6li9D0Ip1KiWIAYxqJNvq4qjrBA909DeCkx1znZjCKvEw0VJrOVPvY+dA4NYpWjxhrki6XZkcq1KyCNQICaCpStuF8bKcBAWCB4plaYkwOtImks7Vfjdas+YCOwMOLzt/MP7MeCrdHXb51Gww1fnWaYhDR/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GZJeXJ8i; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GZJeXJ8i"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 30C391A1948;
	Wed,  2 Sep 2026 09:57:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F28646053C;
	Wed,  2 Sep 2026 09:57:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 866D811C7930A;
	Wed,  2 Sep 2026 11:57:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788343066; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=OUS3SdUwNSk48tuvVvsVFTUNr9za3nsJwxnsYhhP2sM=;
	b=GZJeXJ8iMiUM3Th6SL5077DMfUa3ixshGVSaGbC34rgRPTrGQ0ddgOLwleBEiIY3kdFCQh
	Ai12CFB512rF2A/OoKFRACE1iRYX+5BvvQIxx5Xg2JhMTTKVUyLxnPSG+5nD9+w6z41VC0
	zer/fR5TY0LnB60XiPY6tw04YXLT8q57XHsfoMTEGtXS+lNJcTUhpI7mVQiACUwJULsQh4
	2kJNMeU/e7r1Vx5U839u6tS5mPf++HquOyAHkhEVYDh5sGnOqJtC7j+M/DQRiEY0mo56ZK
	YDxk68jnP61aP+d5MNjemRNEryCUnibFAjWPnaTtYvnoKnDw4fi5YjAy9PnwZg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Wed, 02 Sep 2026 11:57:33 +0200
Subject: [PATCH net-next v2 03/10] net: dsa: microchip: use dynamic mask to
 check pulse width validity
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-ksz-perout-v2-3-6f277fcc9e68@bootlin.com>
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

