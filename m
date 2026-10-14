Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0219952E07C
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989054; cv=none; b=DwAJ/4f7y3pEjGS/1To6hEcJxyW6c7ElQFE9VFxyipelZCXbf0jpa6Lo8TdA1zaYRr+373AuLS3TlZTi61ieVFjpj79op05rKVgHWAzs7UkD51NeGxBBM8t3a7/AVNgSXo0l9wytQ8b1kaFVgVJsrimJz8URdJkMkTYgtbkDwRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989054; c=relaxed/simple;
	bh=KzcN5rwx5RMJ+o9ZB9mV+GzxHnWPysPb8AoimoERr6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HxS/lhuZWN6G8wi3fUoUYR4au1UMtZQLzGpI+zXMPK8yl7PF3ITgkWnEwl1ysN8VuSpmexYvHMjrtAno+/l2P8lwYX8kc5Y08oG/9ef7ZzM1D8Nddx+hETJwhr8qj+/3qoTBhULPGKIQ7jgFQvc2AbVIrpdx4/PR8BWn2L+Ros0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dfryfchX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pth8dRSO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dfryfchX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pth8dRSO"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791989046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FRzmRg0wO+u+IJGf1NJ7IPR0CEjN6p4+2Mg8KTPK8iY=;
	b=dfryfchXoBcBLdH+9CZVuYD07kOPHKcwRpSW2DLen3i8TzsQs2i+uCFGG/88enypKsW652
	XE37cVeQ3TkZ2eLES2xKodNXwIN79LQhdPOK+HkLdwCvp++ne67jYxwZCGI1Kk5a5wn7d9
	SwN1b7R2OtgLiiMw5E9xAEZ0NVkxmOytQfrrx8IuIlWTup13t3FN+/LgRjufsPzFh/3QZE
	H6HuQxiVHiAlhPDIRdhzwH8597aN4i6hxQQCQRftcAGpDlANq7Ma5fpLRFs8BIlI7+Z1IF
	7ymy+jfTgVxjBFSBpdm3SL06g9k3xhibEQ2BixHmJaLnTsiRvhYvajee6NuCdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791989046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FRzmRg0wO+u+IJGf1NJ7IPR0CEjN6p4+2Mg8KTPK8iY=;
	b=Pth8dRSOZ2TvY9RSWQ17XQVP4iL8WWGRDEUI1hHWX4We0AYGc4NrBVsotF97ACSU8q8XtM
	Nly/DWQBVpwDD7Ag==
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
Subject: [PATCH net-next v9 1/8] hsr: Add header_ops::parse_protocol
Date: Wed, 14 Oct 2026 16:43:55 +0200
Message-ID: <20261014-hsr_ptp-v9-1-2d20a2a0f816@linutronix.de>
In-Reply-To: <20261014-hsr_ptp-v9-0-2d20a2a0f816@linutronix.de>
References: <20261014-hsr_ptp-v9-0-2d20a2a0f816@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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
index d14de44e14b7a..6d96bc4a12446 100644
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

