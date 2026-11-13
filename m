Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585577;
	b=qabKfht6FYdjtPeZbBk+OlR1JoxGbnObQLzNzRiySigAso7ZT9iD+5v0KAidaRVvs0V+
	 xrfXuduXzF0DmcsBuKpoLL7XXiCET1xBVHHSVvpNnu1pwlt7XfgjtEI/gkiiOYPQJxd8+
	 KCM/XM0M9Xf2Ex6vGej1u21jBE2LWL80HMRMO3Ipr3vktepph8QPFzR3C2vK1eNjWF2Sk
	 B3yxGrL1EzC6YFVnDHBetBnT6KKIVSZJypD8OJ4sczftHbTgKFC5j81ZjlV1w/zilOSPm
	 HziLOXWosM70/w+oDtTcZuTIwKvaePnp4qDIUCwoew+xUhTBqvXBC5knfeuEgHsDkhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585577;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=ko2w64Iabd9NOrJunU4TEJsddpmWmioIYqPeLW/KqyI=;
	b=B8qMDFBVHWjJuAmHXA2fGtTX2A1jRXeGjAd5tuamXWN1DkJfRqh+fIMfiDeOjdXrTsD1
	 1modORh7TR9+zCh0iWLztKIEj650BHjGwHGcphTn4Re8Zmsx/5icjU6CsvpBVkP3O1Nzu
	 JwbHEJSOMWDHz3jSzBBo2g9ssk/wpg2Q6yPdKTd+0CJGj4eGM2cztlkm+f1XSRaIoOcd8
	 0yY5Mn0gU3bQXDbpRzdf2jDpVhrb9Y1FpImJHS/dWGkO86QkgI2ItRRzPY9tSewjgD6EB
	 nxyWZtBOKH+5lg3XPEqMKJ5DI9EOzz7/3ftGyXFnrZfgGTw8oX1//ZvFb9MCy8Dua+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TcvAYBoS;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2848A606D2F4
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 15:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2848A606D2F4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TcvAYBoS
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1B5FF1A164F;
	Fri, 13 Nov 2026 15:59:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DB3F960015;
	Fri, 13 Nov 2026 15:59:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4871111BC04E3;
	Fri, 13 Nov 2026 16:59:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794585573; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ko2w64Iabd9NOrJunU4TEJsddpmWmioIYqPeLW/KqyI=;
	b=TcvAYBoSwWFzFZgfTG8U5hY6+OxEBZfeZZNHlZlI+pnb+XD5kVyKyAjiPlF02jLVgyQWyd
	exUeMAA07QEOjRwS+Dhw1UHrqhrzuHozNfBDKNwU+38wiVohXyr82kCnJ+42E9Fg2K5KBt
	hCvTCaXzIvCpkkNk3SAH4CnzzN0H5jAkXf2nlNkrxFWUNRYsclCcwKvLDIRk1GMyZYrRDD
	QanpHRC7f+QHhho5xid9qXgvnceir9NL3OCwkBlX2BPAgQcys6UVeb818mfHZwk4ckIYa5
	W50Xq4nNXThi9lDeB0LWXT1DcifwLar0eRlG28qKZhNolVC5ra7rUN0oBck4YQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net-next 0/2] net: macb: add some missing caps
Date: Fri, 13 Nov 2026 16:59:27 +0100
Message-Id: <20261113-macb-caps-v1-0-42e0984b2f09@bootlin.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQrCMBAFf6Xs2QU3BYv+inhItq+6grFkoxRK/
 92ox2GGWclRDE6nbqWCt7k9cwPZdaS3mK9gGxtT2IeDiPT8iJpY4+ycMIQpDgqRI7V+Lphs+b3
 OlFE5Y6l0+Rt/pTu0fle0bR+OWd7hdwAAAA==
X-Change-ID: 20261113-macb-caps-be72fa7ce119
To: Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>, Paolo Valerio <pvalerio@redhat.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Out of all the compatibles modified, I only could test on Mobileye
EyeQ5. The rest is information pulled from public datasheets.

 - QUEUE_DISABLE is important for suspend WoL (avoiding tieoff
   descriptors) and will allow ethtool -L support for those platforms.

   The QUEUE_DISABLE patch was sent once as part of the set_channels
   series [0]. Comments from Nicolai were addressed. Split to keep the
   series small.

 - QBV is important, well, if you need QBV features.

Thanks,
Have a nice day,
Théo

[0]: https://lore.kernel.org/netdev/20261016-macb-set-channels-v5-1-90ce0c0b8e75@bootlin.com/

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Théo Lebrun (2):
      net: macb: add QUEUE_DISABLE capability to 3 compatibles
      net: macb: add QBV capability to 4 compatibles

 drivers/net/ethernet/cadence/macb_main.c | 34 ++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)
---
base-commit: 573af801552999954caa8347e4490b04cf4763f0
change-id: 20261113-macb-caps-be72fa7ce119

Best regards,
--  
Théo Lebrun <theo.lebrun@bootlin.com>

