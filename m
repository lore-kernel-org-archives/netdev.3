Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3093FB060
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147668; cv=none; b=luaqr+Kq6bYGZETT9+iKzz3JJjaNe2RE9jGa5JEcnEieLDtGFMu0Z1c+Q8CzvBtUJjXbnaIuIdjiyuLTEBNP8Rvyxlqa4SXpkwZrv9Pc2Y4T1s2y3Kylat0dGd1CGramxJIrCAPGk5q61QwRBCG7jm1mzXNZgyLoPwE2Uy2hSgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147668; c=relaxed/simple;
	bh=71frPa5vo+c1+kn5UAQq7n0o4JrqcV/M9g0Ol6QsP8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bAq1GZjcSUlE6+hrQ0fHIp6WSEAiRllN4+ZWKh1u37zz1hmZjSCxb96L5YOwBNJrpkEmNKypgYrGE7/c5+77bmBu0R+Fq8dtYui9yOxK6eiYqtJDu7HC62NZIS7gzcuF/UiMjfXooQ1EEZJ7Slt1ijzmJpz/wstCLXgYrRbULGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bzJCaIjh; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bzJCaIjh"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 29C454E40F96;
	Mon, 27 Jul 2026 10:21:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EB9CD601BE;
	Mon, 27 Jul 2026 10:21:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8210111C131B3;
	Mon, 27 Jul 2026 12:21:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785147663; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lWkqPQTqr7Q76aoNlV5VoQCTuOeI+VEKF/VU32rgTmY=;
	b=bzJCaIjhW2d1AIPRNPM27HcuwxiHjJsH8crccv7r+kq8nXshjWWv1JFUYFQVOX45qZ6bBL
	3XVuvoARKyA5qiq2342QUfNpDc81H3kPNpVAgJh13+xE7OIhEOSpkQV66XlVAJq7OIJ2Db
	xIOLToU2vbIdoTL7eMMWPqblMgl0/A09IaOQ8trBcLGEOKWe8joPrV1vnwUvB0uRvdbogX
	GevWQrzD0jh2neCk3V9VHDKrXeG3v3hEMak4HJpwOgKxtwGpLhiDK3UEjMMsYIp0gXEfyV
	a7dfmik4Kb8dt450zQ71s5J09BCDrJ0goLYyu0BLOVLiRa0vdWQMmpsjXOQBZw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 27 Jul 2026 12:20:47 +0200
Subject: [PATCH net-next v3 05/10] net: dsa: microchip: adapt port offset
 for KSZ8463's PTP register
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-ksz-new-ptp-v3-5-caba39e680e3@bootlin.com>
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
2.55.0

