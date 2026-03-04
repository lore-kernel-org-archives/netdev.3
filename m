Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D333A257E
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 10:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772619570; cv=none; b=hjW4r2KzFnTSA+NWy7/OWnXV36MeEl2aby/j2kysX1bqNtx5BCbKd1kDRp0ci7HvfAdQS5G9A0BFugBv3ocDqOdqecXYu2gIkkUgAXzhOVfJX240ruhjg/OtBzAL4D1OGfEGuyfUzN8avpJ07T4xl8P+IkdvdjFS1/fXFjIOPXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772619570; c=relaxed/simple;
	bh=hlNmX8QTYbudhIP0ciMy+y3TsWJoFdhR3w6eV7zimz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DsBxPPxkGiSoTP9C9jrhIrW19h2JoE7iUW6gDbtBB18M0OETcYtR9juRH8lWQygxkKOUWSmU0Q/LXRiuwPlF63fpUBScS5MX5flQOXWgIWhYTt7fQkOKKk9GIgthb5oH7NZ5Fm1EtfPT80EJQ0SKZSOWmpnrkG7IFTvwpDKJ3Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aCzF1j2l; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aCzF1j2l"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E88764E4253A;
	Wed,  4 Mar 2026 10:19:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B7D765FF5C;
	Wed,  4 Mar 2026 10:19:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2EE6910369791;
	Wed,  4 Mar 2026 11:19:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772619555; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RT79xI7c4HyPB3ciXHZP+9zR0KZk+cQOgHzcyMyuvrY=;
	b=aCzF1j2luPALUZrF+am8IoIPUzKt3BjTOIHt/8qfxYixh3pTvMmyu3oCTqMoRhuop4qFZs
	LW8Bkw4G7I+v/0p2z29UWxTpN4UOzNIZ376HuE3oTPi28Txigj1qoVf/bIe892eEbxZBIJ
	edbT87zW5lrdgLpw3EIpxqx2sFhoypnLXetgBKucLXMKK4Oof7Nh7GpocLIhh87/5uUt+N
	ewqJ7bG1BeWvzqdOlcug8ePSchL7lYCRuBdjjg4s+hr7c7X8pYBV2sIeR0XN2qI05xfHLd
	C+9BlmBZxui7k/G95nlhzRmGmZ2S/fIhHvxzS4T07AJMjN1yVLhP15CJZhmcpg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Wed, 04 Mar 2026 11:18:59 +0100
Subject: [PATCH net-next v6 8/9] net: dsa: microchip: Adapt port offset for
 KSZ8463's PTP register
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-ksz8463-ptp-v6-8-3f4c47954c71@bootlin.com>
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
index c354abdafc1b542a32c276ef939a90db30c67f55..a05527899b8bab6d53509ba38c58101b79e98ee5 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -2020,6 +2020,9 @@ u32 ksz8_get_port_addr(int port, int offset)
 
 u32 ksz8463_get_port_addr(int port, int offset)
 {
+	if (offset >= KSZ8463_PTP_CLK_CTRL)
+		return offset + 0x20 * port;
+
 	return offset + 0x18 * port;
 }
 

-- 
2.53.0

