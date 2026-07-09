Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E373D79F1
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 06:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579379; cv=none; b=liHG1ziqGx4Ce1OqNPYlnzZJxVjV17+I14lKccuRGa1/6ejCNQuG48cGwiEZ6iMmMmJ4KjS1B2wFSFe7swIVA7Z34yUp+LVdToIAze5QWBHOOM0trUQucdvki6SumZP1P5ZvBU4Hbc+bzd7GnpB4uXSUIfhtgCQ0ElixgkBsOwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579379; c=relaxed/simple;
	bh=zdvdHrDhFsiioZd4xYI/niYPtEbX5wxU1RXufUxhCpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nYDaeWFRB2YdrE1zqbrwJZeszuDV5dLthuPRf+MTwkQMwONWaO+ohXAzDqYhUXC8ICo8Yz/OYLEgi5XYqMyXORUxHJY0UeoMeUKoVmwIjshPU/H62oXWHzZSh06J6bpdtPxOUQJoslbYlR6dg02zDn4868i2TQsGXuTkH5FDFm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=n3UnhRxV; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="n3UnhRxV"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 05B614E40D12;
	Thu,  9 Jul 2026 06:42:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CF5C45FF03;
	Thu,  9 Jul 2026 06:42:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A818A11BC2146;
	Thu,  9 Jul 2026 08:42:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783579364; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fkkEtUFwnD/scngtxS+aRb1iK4Va5shp4fS189Y6VRE=;
	b=n3UnhRxVigWv3zeuKYwuBDMk6Hq3LfTWigGX5MthZDeVs39BtHXjjSFrEMAP1l+sawJIHI
	43XbVDRtp8xW3vwBVbDYXx0kIXVnKzUvggCXwjTqeWrS+OvaRCdYw7uIn53Buwqj1im8vC
	H6O1HSmceo4vmcs88NCirSsfdSRxKY6gBmUuFpO90uLk9nQEekbYTQvUNtrf7OIeGl/Sue
	ai4nJEPyB1yKRatK5afhFCsfJ9D6mlKp2yrX9+UyM3lZ+pu1fnV9Ig71SThHrOHdH+aADr
	dN3XdF8F8vpAHKZXB1ofRvLG9M35RYyjspGazQPJe0ki9K5NdTYoAk/55G3ReA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 09 Jul 2026 08:42:31 +0200
Subject: [PATCH net-next 05/10] net: dsa: microchip: adapt port offset for
 KSZ8463's PTP register
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-ksz-new-ptp-v1-5-344f02fe739e@bootlin.com>
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

