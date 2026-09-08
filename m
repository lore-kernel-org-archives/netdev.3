Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C91399CED
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 07:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788852480; cv=none; b=g3AxaFivf8/tt7DqZ76gOyfhP1n7d3fKG7rlr/r5XTinAezUbzIlMzRtNZb1he5phOQnbife7ziVphCn7oj0ktxh5R7reVpDbZMaMt7Rb98h1pHu+UafT2vLCUsVZ2JL5+3COQiSnGCzNbvx9WD85qyBxejWehCDbVSR7aPPtMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788852480; c=relaxed/simple;
	bh=HkXxTB72wQCMpzYwUnwAJU9KwsD3ZJwAbFrv0fPqNd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GspCauEDeowG9bNRPvIgyMBnr3+v4G+ZXNU5UpY8bSXCKrK1tixN4hno4mqLNFpn9pOcRyMCkXJFZ2/WaF3s7wyLZUDCcFoELiQGMNlmdsSPWwXPYq8+ky7QGs5fZTMWxzvq6El0xhKVu3SS2jnqng4CXs8hTYm5Y8ubnU+P/Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i4fVGBDb; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i4fVGBDb"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8F4B61A1A52;
	Tue,  8 Sep 2026 07:27:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 62EF3603C4;
	Tue,  8 Sep 2026 07:27:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EED5D11C7AF32;
	Tue,  8 Sep 2026 09:27:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788852472; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=OUS3SdUwNSk48tuvVvsVFTUNr9za3nsJwxnsYhhP2sM=;
	b=i4fVGBDb2ywDT6LanBlERODEcmDBsg65jkS8iWoRKBLYfyO/JnozCwwcxVLXvFtTsPe4VY
	JXVJy/sjIGSbynrds8tRlCuWRuu5znRHWU6q/iIkz+1CuW0iARuOxMEJfkwR0pv8QZDGYr
	OEXrW+hFrKEVT+0Ci7r55cfPGFDWEcgzdzVBETYSEGJMDgCZRBH7gsAaRiCngCkTlpilHs
	DGVFQeIgbQleqEt5w/3fD+VzGrCWeY5VutO5VU3dgXReg+R7+CnBq65abyk/cIo9aJQBRR
	kZvXZIOcPgKJ4v7R6brjf977YuUNbcGdMUpSh0BSFhl1RtXKQ/SZqvlqzMXeOw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Tue, 08 Sep 2026 09:27:43 +0200
Subject: [PATCH net-next v3 03/10] net: dsa: microchip: use dynamic mask to
 check pulse width validity
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-ksz-perout-v3-3-6722a3f1ca75@bootlin.com>
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

