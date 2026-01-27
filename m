Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB83333420
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769504829; cv=none; b=dGVg+rMj7PBrneGedLtoUKNxE02FBtKYtKukSdaoi9Pt+b/IG2CabWCUpTSyXX1etXVkpNGkBGE7G+tvlYZRj9beqZnaCofdFpiywY+sRpdGsl29ZgaV7Kicq/lrhhs3SrA8zSipfoRcfb5GU9u9W1w/HIBmmGq6gJC5MQmT+Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769504829; c=relaxed/simple;
	bh=F3x7ujt23LH7Hzb/IBaAvxfIn3ywNtT91s3EJRLMZe8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AYelksvFmovy060OgfkQXfDto/q1cNtQjav36hvXt+sWPEWOXXceY+2JCVX73swEZYetATijN0QgDFS/uFR7xzRIQuiHqzmUEesxSmG3ueCKqFffDbMVptdVswkgGtj4xy78qOEv4SWrU7QWDm9aAgDj6K3VNQa7mcEfsjFTnEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hsoERJOD; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hsoERJOD"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AC6A51A2A6C;
	Tue, 27 Jan 2026 09:07:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7B614606F5;
	Tue, 27 Jan 2026 09:07:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D6080119A8683;
	Tue, 27 Jan 2026 10:07:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769504825; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5JUfVn7/HeLWZy5Qd02a6wIWBDQq2NcAA2klS+MsO1s=;
	b=hsoERJODB2UrEXkOw9tThTL0ZGHmlSRobhe6AIBh7Eh2WOyixZx6Gj5DM01c5GU8tU02F3
	6NWaYCD5DU4778iwlzWE6iLZLNesqF2bdW9FOzhPyh2uqOl80lDhNZRo8nicE3pE66sSb7
	XEozy3q+Eb+gFBhABUP8CZnS99zvRwg03Qmi2Mpwf4Pd9ZKyI1MeVa3HtyNPrnDdT60Xag
	6qQYNZC3EqUudJ2UKxRJaFhQswkio85rauEV7j/vh6h73IIVoBQpcoMAZ9udMCC027D4Kf
	MRTcjukS1xuYVtYGcSx5DYQu/L9en/qkbbrT68brL1ofg9hxpfYKV0wjvKf3pw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Tue, 27 Jan 2026 10:06:49 +0100
Subject: [PATCH net-next v4 7/8] net: dsa: microchip: Adapt port offset for
 KSZ8463's PTP register
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-ksz8463-ptp-v4-7-652e021aae86@bootlin.com>
References: <20260127-ksz8463-ptp-v4-0-652e021aae86@bootlin.com>
In-Reply-To: <20260127-ksz8463-ptp-v4-0-652e021aae86@bootlin.com>
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
2.52.0

