Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19B649BD8D
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 11:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336350; cv=none; b=LnpZcBC+C9osbkdxJWDrSZPNoH39h3l+5SKdsBg0i0wVZhkhJXw9dHWTE9ZTPenzny3wVd9QKFwT190fKT+7eOqaowzt3R8K7glIR9omW13NmzNRIypKA0b1OZ4hHLYTajiFBV7xAW7+EnvFfsxsrVXoHH7+sEY3tZ/pQO/5pkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336350; c=relaxed/simple;
	bh=1Np3IuCVpVqOJRzPZ8gWYaqPWYBNcVe3bkFVnYYTqwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JggXKzg1s4VgaEGNo2LbuIP4xK51woYAVBPCsfII790amRtRguEgCMbMLp8qqmxu0pmvA4k3kxCbupqkCOyedOP/DKZMBsKYgIFeDSUPno2eUAdDXaNSQIgi0eZVXRbKLErB2vo4Rt1hBlHyWgG6pnw53r2zuPZoHWeUdA5YX8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xDoA/J85; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xDoA/J85"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1565EC13994;
	Fri, 25 Sep 2026 11:39:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3FBA86073B;
	Fri, 25 Sep 2026 11:39:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0D9D010329514;
	Fri, 25 Sep 2026 13:39:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790336342; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nRETuw8JsXEchs489Ud2eN1dEe38gGQ0nW0Z6hsxDl8=;
	b=xDoA/J85KSmiaAzghIGTC1VmRUK8eoGiullhVstUnkSvSP6mdjSAg39+UhCHzPFuof2CuE
	2txUrgfjTvZCtahuA2Hdfe6Hf/PSqYHV6z2MfiF8gZn3gLbF9LeOJLcqweVw7ppmNWP9q5
	p0uuT6jo8SNWEIUpBE66c1YV7syli33+Y6T7TGHkzvmUfT5yycdaPcUaT71dHPotfzSFDK
	1v6nn/t5W7FbsbLIy40RnGJDQKp60gMIS9cQL4Ejh5N3f+gy8PADSw8TLgNJVDcKLz1AEn
	pNW2XvZrVKW5wlTCdR0uclDs3Oj2BiTgEK1MzMbVYUZ1I2ebfWYkVldYjlYxbg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Fri, 25 Sep 2026 13:38:50 +0200
Subject: [PATCH net-next v4 04/11] net: dsa: microchip: use dynamic mask to
 check pulse width validity
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-ksz-perout-v4-4-d675bd21ce49@bootlin.com>
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
index 84c799959aaa..1889698691e9 100644
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
@@ -242,7 +242,7 @@ static int ksz_ptp_enable_perout(struct ksz_device *dev,
 				       KSZ_MAX_PULSE_WIDTH);
 	}
 
-	ret = ksz_ptp_tou_pulse_verify(pulse_width_ns);
+	ret = ksz_ptp_tou_pulse_verify(pulse_width_ns, TRIG_PULSE_WIDTH_M);
 	if (ret)
 		return ret;
 

-- 
2.55.0

