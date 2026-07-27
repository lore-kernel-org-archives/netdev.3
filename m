Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A289D3FE679
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 10:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147675; cv=none; b=Sjn9Ip/0Bi5jgIy/nn+f3UXqVu1zJUWzwT5y3mVrF3Re9CYYfjGFBwYWD4jvw3RI7lAg1I/GdRT8868bithuSeeNcGvVDrxphnf2eg2uMyyr2w6JqEW5h2V8fYsyep0q1lWGxB1lPor37D5mfBqdGu1/YiKLaS+TwJvBewY82nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147675; c=relaxed/simple;
	bh=NOGBFn5xSvZUkZglx6HzyV0jBUsnXjLoKAxNeSUaGnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UATewtQ50NIrYx01eX+lIWuxXjSKxX9M7TmEqWYLmDARUirPX1WeayXru9DpoHNTjy0btZl9TlbtScq1BZ2J3oscAKSlqmY0iQly6clD8PXguzZqDo7uyULqzgR9N12B1zOPpkXpd0A+Gpsi6pdOVKhTxEpynm6YdQblhxTpeHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=J7+P8EqT; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="J7+P8EqT"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5CC821A128C;
	Mon, 27 Jul 2026 10:21:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 30073601BE;
	Mon, 27 Jul 2026 10:21:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CF64111C131BA;
	Mon, 27 Jul 2026 12:21:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785147671; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CEA+gd9HgmN2Q92GsE+LDxBKpjS+zeD0NzQfZwQXakA=;
	b=J7+P8EqT7+6bQY18a1vS1maxawMZvXRXfX5fV6NLhYTa8h3SDbubhikPUrakAA9iJDkn/2
	cO3HOIkkoX9oIL5i28YMbjxWbymeXjwqaVqZC04bAt6TfJ6BIQh342WHYX0x1lxtwragYm
	3bHM+aBBhp0WWuh+rAaxiaL/b/REkYWjDF3Bb8fIEjWEuzgN1WL4ts235yRw39J0JmEwYv
	DIeY5ZECDESguRZQZ9ojJFOH99EVpXn4rNEnTtl3pGSL9k+y5LEYk/1JUMsl71IIv6vY4D
	M3q+Cw8h8+KfxY6DV/qFdZd3tGHl7FEMotj7+tIW76Rsky2mBeQM3yB8RV6i+Q==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 27 Jul 2026 12:20:51 +0200
Subject: [PATCH net-next v3 09/10] net: dsa: microchip: explicitly enable
 detection of L2 PTP frames
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-ksz-new-ptp-v3-9-caba39e680e3@bootlin.com>
References: <20260727-ksz-new-ptp-v3-0-caba39e680e3@bootlin.com>
In-Reply-To: <20260727-ksz-new-ptp-v3-0-caba39e680e3@bootlin.com>
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
index 89fbc1253f25..be6b8240ac03 100644
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
2.55.0

