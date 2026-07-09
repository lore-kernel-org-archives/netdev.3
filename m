Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971CA3E1687;
	Thu,  9 Jul 2026 06:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579386; cv=none; b=Nj/ZRMiW8Ch1xsvnM+oR7QLVmCEsDjyVCTzGUtGS3JJ/7o63sx4mz9+mCEogrDDYuri/S9qr1YUyC/FKrpuB09ylgi5qAASd9u85mkvKaytXGdiJPgPY1mHE9HPIhz2ocB5TFg1g2KhffW7HBfhg38U0yIqfu/3h5nY3KkL+aW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579386; c=relaxed/simple;
	bh=q68ZtrQA8WvhW8KwWdrktX/dwDBAar6ja2bhdYeXlIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pKLVooLE9Y0a4C9uaIBwNuUDPuIVWHkJhMHQ79l9yZVqhybE8WX+7+HIi4HsJSbwF8rG7mFbJWJRzuxEzBpSnw6ReAXKUvIjivyQ09FZOd2wyjaOBajlNXr1X4XT0DiXZUHVYKE5ZiUHwuNItCjSCzo4vP2Z8XiV5AzwMb6+qL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pyJj7zJ/; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pyJj7zJ/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8E012C2F4C2;
	Thu,  9 Jul 2026 06:43:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4ACF55FF03;
	Thu,  9 Jul 2026 06:42:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D6E811BC2145;
	Thu,  9 Jul 2026 08:42:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783579373; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rcOoLxHuYodJKH1gWzA0Y9E0Hrxxrz4+nLUhLDakX3c=;
	b=pyJj7zJ/7chpqHptHELg7+VnLWFYlBggIaWQXFXNsDwezJJZKaXSkryOg6mLknYMRvPpEL
	fiSLkJGrtMzhWq943v9sfJjjBiMeYI+51HN7p5OCZi5wnxq+DVaeYRWs08mHLHTP4nZiMo
	hWdZkDDKrqKU5Tbcz/iITLhoKDjRAe6neseA9JRYDvwDnquag4bOsVDXqVINQKmU8mAJ89
	nzSrnI7CUCuTtvGUWqU50eTWRRgwPWRmvr2sSKqDnt+zpwptQS2U4aS3j7H9Ff9jRUNCh0
	yiT1H6PkGasIMOe6JWLF8HBozJA3e2oz5NBLE81fKKfCv2DECNZrx8BaUn1u9w==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 09 Jul 2026 08:42:35 +0200
Subject: [PATCH net-next 09/10] net: dsa: microchip: explicitly enable
 detection of L2 PTP frames
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-ksz-new-ptp-v1-9-344f02fe739e@bootlin.com>
References: <20260709-ksz-new-ptp-v1-0-344f02fe739e@bootlin.com>
In-Reply-To: <20260709-ksz-new-ptp-v1-0-344f02fe739e@bootlin.com>
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
index 7a74befda9ad..5323fdc8862e 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -953,8 +953,9 @@ int ksz_ptp_clock_register(struct dsa_switch *ds)
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
2.54.0

