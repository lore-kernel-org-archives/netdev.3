Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C184736AB54
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 07:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926701; cv=none; b=aGlfMQ9BzG1h1Nt5/l4lDTF3MK1X7QZ5pTIktHAYDmPJlROl4QE0175/D5U66V3Z0srBzY0xBAIO7TgowDTwpyKHCuSpeFwXO7IymRCGUNzFm01Zp/5ZSUuFW1/6LwwiGhBBEtvlHG0b/itRpbFgGJl4bm8qyKbIGRJT3Hi6pXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926701; c=relaxed/simple;
	bh=zdvdHrDhFsiioZd4xYI/niYPtEbX5wxU1RXufUxhCpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tlwHZnFMWbymEXsse5ttVcrbKCtC2sy0bpXboCoqE/M76jxWPMJiOCUEmgE8A8F9e4/Z/gbBvbMk+u+oo0s4UldFt6quWWr83tNyfRxfmONCfC2cPkVzlZhbjasJfFlw7Pel9q8R4MuykPqWTNPBosL+no/T8qHISU80fQ3l5Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=C5LY4/BS; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="C5LY4/BS"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 303D71A0F8F;
	Mon, 13 Jul 2026 07:11:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0530860341;
	Mon, 13 Jul 2026 07:11:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 128F911BD39F4;
	Mon, 13 Jul 2026 09:11:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783926696; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fkkEtUFwnD/scngtxS+aRb1iK4Va5shp4fS189Y6VRE=;
	b=C5LY4/BSRdonJHES2v0gCd3QKLdactXElkJNwuCnc7piVexqjxG+ImHeAnX5u1VCKmz6DW
	98x2Kx3sZl0ouU9CsBEjDB6J2hHTSIwIgddpjyPpkkRSre+9eevn5eoIi4ORVHZgPmP7Zi
	FlyiFrGotS3Ckx+bgq2mYctK3tuOg94RYs51gQuHFGXhTIwLeUUFEpDVxICy0PiZGpn5SW
	8O5SuLOgEgJkD2R8Wc6T0OyrEFtukalN5qe9SMqTaLZyPR9BDCFLkF69orjILYP+U4YLrk
	trGRKYCfOjdPba5CV3hsHhJv5gkYD330Cnudl3tXaiXwjfdsgTN/GmLqoI+SBw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 13 Jul 2026 09:11:24 +0200
Subject: [PATCH net-next v2 05/10] net: dsa: microchip: adapt port offset
 for KSZ8463's PTP register
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-ksz-new-ptp-v2-5-7209c05058ef@bootlin.com>
References: <20260713-ksz-new-ptp-v2-0-7209c05058ef@bootlin.com>
In-Reply-To: <20260713-ksz-new-ptp-v2-0-7209c05058ef@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

In KSZ8463 register's layout, the offset between port 1 and port 2
registers isn't the same in the generic control register area than in
the PTP register area. The get_port_addr() always uses the same offset
so it doesn't work when it's used to access PTP registers.

Adapt the port offset in get_port_addr() when the accessed register is
in the PTP area.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index c099a7005808..5e5bfc5cae2d 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -2831,6 +2831,9 @@ static u32 ksz8_get_port_addr(int port, int offset)
 
 static u32 ksz8463_get_port_addr(int port, int offset)
 {
+	if (offset >= KSZ8463_PTP_CLK_CTRL)
+		return offset + 0x20 * port;
+
 	return offset + 0x18 * port;
 }
 

-- 
2.54.0

