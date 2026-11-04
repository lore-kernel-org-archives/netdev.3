Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805053;
	b=Swcd0VYgIuVTyUtva/ZKQqnuyIf1ehl0Y+2S5SHggY4xmW2i72EfuUACQhE61bwuQtDn
	 Qa3NQSgBRfnRX+m/j7a+QE3h7qpCkQyz7pKk6YTUY+byCd++ij5DHWlKU2FtNgKLvx0ml
	 U9U1/aa+UNz+rbMShw8lJfpLFrggrWWxSbAuslg2VBPoNVrilf88hlcsOoRa79HPr/wg4
	 pxBR3qtkNWfItJ4ig+afOZHzIqSwVMJpkL2WwFReKCuF4exeK2ZKXoA4ncoR2SvSKYgzI
	 J0wbCRg7SQNJMkIiZsH5uX/yxVtVjBXBXN2jP/gYJ0LfcF6fdB1vHbh5Xykqy3MtugA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805053;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jvjNz2XqwJuSY4izjvEkknUfW9JWC88MajzwfFFh+SU=;
	b=XyyiZe/At59b6Rf0/k9t0POlkt2Krv/V/h/ww01ZIzj4jfoxuOMh8r33HlT98RqIfz3b
	 OZo1+XM45tOfxFyMgS2MjY4bMS7Ee2vnyQruakLXMfh1di80ua6NefkRgIePUtFp3nuQW
	 hSz1EyGRojh6oxUyjGU9nhDG3leZw28Ea6Y/p+5lfvuLPXrkSzd7EEPjdqynQZqG6bw38
	 6vMZpx6U2VXirr9AJX/p/xhtCd7BdO29sPen1dsVolAOhrXK7tPfQS3m3vcLPX+/MhIsH
	 nd0Zm1IA8ZcbNV5r0c3X94xKzTWpQZtt7fiz/cTGxWWGhlKkTXrwDhuyWrS7wlf1qsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=GIEySveD;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=rql4AOJ3;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A59A606A326
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A59A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=GIEySveD;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=rql4AOJ3
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793805050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jvjNz2XqwJuSY4izjvEkknUfW9JWC88MajzwfFFh+SU=;
	b=GIEySveDCXzzCfnFV6Le7BlUSHHHfCF6okb8iUJAzegvTgHLY7BmyfPZ9tWuL4Zug9YOGL
	k22DPrKSX7nwY7n3Z9N+CpnW5x6lnvAB/Ox4MKh4Ho7ejCGtimTTVwgaOgWM5NTl5ANfYu
	ELYnrU0VoukXAwqY3ZE0btQ5sdUzBfCnenSLrsL+5SP9jSDiT/A939enNOgEf3Vhahj1eD
	CquKrCkLLyXKUtp8KPd/V8VR9JnHMQY3oJCUFldFBbxp3W1FP4NuByHkiwa7VUbmBdXyu6
	h6CPL5uMc6pSPzwgEHXkWPaoIsGCCNGGSVkkvL8bxzzkad5WRkdCrQh6Tkh7EQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793805050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jvjNz2XqwJuSY4izjvEkknUfW9JWC88MajzwfFFh+SU=;
	b=rql4AOJ3mQabD0KmJ1BIctd9a+kpfhWiNGQaWJ5xy56yu6lpKMqUUmFcaQbbNIbsk+ujlb
	QA6aWUZCH4R9Y2AA==
To: netdev@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"(JC), Jayachandran" <j-rameshbabu@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>,
	Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Felix Maurer <fmaurer@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net-next v10 1/8] hsr: Add header_ops::parse_protocol
Date: Wed,  4 Nov 2026 16:10:37 +0100
Message-ID: <20261104-hsr_ptp-v10-1-2c4a38ad973c@linutronix.de>
In-Reply-To: <20261104-hsr_ptp-v10-0-2c4a38ad973c@linutronix.de>
References: <20261104-hsr_ptp-v10-0-2c4a38ad973c@linutronix.de>
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
Content-Transfer-Encoding: quoted-printable

af_packet uses dev_parse_header_protocol() to assign skb::protocol.
The hsr stack does not assign a callback so the field is assigned to 0.

There is nothing known to be broken because this is missing. Having a
callback assigned makes it possible to use the protocol field later in
the series by packets which originate from the AF_PACKET interface.

The header used by the HSR stack corresponds to the ethernet header for
the "first" part so the protocol member is at the same position.

Use eth_header_parse_protocol() for the hsr_header_ops's parse_protocol
callback.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/hsr/hsr_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index fc512204600cd..59df647d2fd45 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -247,6 +247,7 @@ static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, st=
ruct net_device *dev)
 static const struct header_ops hsr_header_ops =3D {
 	.create	 =3D eth_header,
 	.parse	 =3D eth_header_parse,
+	.parse_protocol =3D eth_header_parse_protocol,
 };
=20
 static struct sk_buff *hsr_init_skb(struct hsr_port *master, int extra)

--=20
2.55.0

