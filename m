Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088A4370D47
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 13:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946083; cv=none; b=RmIXKZxTz7NSZk+isj7JQRfzJ2RvAM2Vm4MTNnfGBK3JoDQYJBqmLE4H9ualV4IjosFRuUi+IfxlSRnJmU9XarSqPs15Ye4HTaL26XSwn0i3FTIzKqVea29oBBmjWeAwKXDV7i9HZH0ZNlpg2g+r0vDQ3xTkiwvGVkrE6c6Baz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946083; c=relaxed/simple;
	bh=c6o52qQJs9QcOYJ0G8+o+ceydWkwkaK19RRs8ZrDRW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AxoMylULGfOl6iPkusAuRJHgi1LSQBEEwfayP+mIlf+5p7a/pR6tZH0X/B1gX3Gynv8raDLut2ChnnWX+ivMhQbp487cWetRvt+poVWAs/WmEiSOAnQHvn1ECJ+KX+bkqiRlTQv/0CDPXnId6eSqEvjEOzXMqDlnXw2ZjFmyXRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2GjsFExw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RmrppJjG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2GjsFExw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RmrppJjG"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790946079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gaolA8HyCxFnnwhWRTG00R+dZvmZnieOtCIRyueIrP0=;
	b=2GjsFExwDZS2myMZnRR5kgsubzGPzHP828qebH/Ja5Dw0FJawfVN77IhEmQ09/NL5lfrcP
	9rOsFDZwK/YvBxtoIHz/cvtU6F3XkDC3ga4vLca/K3FRrpZnEB6HHMmwlXd0eAj14aFlIQ
	qjvxlwBpq4I2uvXiMdNgIIHtDiJLvQC6OGnx4us7oXcZx3p4XVejVClr0Y+hzIkGICE84P
	NM0HXau9VIomUXw4iAeHbX71UEZ33h+JC3uKQnexULpoboza1IedPY6JzBvTXwOvzyrwb9
	hvUwmoBoK3hdiEtPM5DNLEPsNyeEv6m7dUnzMpyQRA0PytgiIvmOr1wid37CQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790946079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gaolA8HyCxFnnwhWRTG00R+dZvmZnieOtCIRyueIrP0=;
	b=RmrppJjGVD5k2zqgPtb2sj81Le4HDr41q8RhrPdsHVy8R56WEbiTMU0XIvuRV+OFSV7sXl
	gaD961nF/b8AgWBg==
To: netdev@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"(JC), Jayachandran" <j-rameshbabu@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>,
	Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next v8 1/8] hsr: Add header_ops::parse_protocol
Date: Fri,  2 Oct 2026 15:01:07 +0200
Message-ID: <20261002-hsr_ptp-v8-1-60dabc07e554@linutronix.de>
In-Reply-To: <20261002-hsr_ptp-v8-0-60dabc07e554@linutronix.de>
References: <20261002-hsr_ptp-v8-0-60dabc07e554@linutronix.de>
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

The header used by the hsr stack corresponds to the ethernet header for
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

