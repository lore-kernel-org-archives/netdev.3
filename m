Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0D55111AF
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 12:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790165662; cv=none; b=sohOq2ZyKVvmuwbSoNI9DGL3xrF/E9oh+UtByCGxKNKokWqSrxOKa2k4lsyuz2/ZmmUMYS8EeNVFFeEc5L2eRBT6vtS3WvFOF3mAK4wM3Di4cmnVy6Jae76dOjvM37fzfZSYA055dArJ33/nFeHZAZ6bzyMPPE8nvjJfkV2FATo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790165662; c=relaxed/simple;
	bh=c6o52qQJs9QcOYJ0G8+o+ceydWkwkaK19RRs8ZrDRW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2OrkW+F9twhAYY5Afos9mF9wF+ObFrTpwAk7lnCU2E1/Q8pEOH28JUeYhhXeTWpAirTrhl/iBe8AnQfezc68tlhjpdS/3yJsCb8+94srG93syI0+LOqZRD+XUGniO/yiF24Eta0CYnnuZyW25VLgcUnCvI3HeDU+9WGdT3Hb8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K5vKsAn3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cxTWkyyG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K5vKsAn3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cxTWkyyG"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790165653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gaolA8HyCxFnnwhWRTG00R+dZvmZnieOtCIRyueIrP0=;
	b=K5vKsAn3ZnqEYcIfjxqOTe/gIqyCz7oAYRIZQxRZ9HDHGwqTK4q+LQMFFlCUjWFfzlNTwp
	1RJHx05ppNFcMADrTXZpTbn79F1KW+a/ZM0jG15tnPRN947JK3c3SuQ/f5v1I9fnsZC5u5
	8uyZIcvi1/vRik+hDGMJfMdOapCvQ4Hk5z/NKQaAU83hI4SetCG2xR6ZRlT8/t9sXhQgR1
	emQnQz5Y7UkJAr3yBROTXVZ6S2725lILnyx0Yo0Joz4fUDkE7FF9WCL59wM6oDkVdtlaLe
	DZDScVAC0Tw2t58Wm7Lx6OhnP3klwTZBvtFacygBo0FavjfOekZ4bXfs/crPPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790165653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gaolA8HyCxFnnwhWRTG00R+dZvmZnieOtCIRyueIrP0=;
	b=cxTWkyyG/ARPIqU/eBIR6Mv7cGCdQBgMHqKPTxYrjiAjRjfvXkLG6hLCbfN4cYsJ8RAFdd
	/uuttIm79W6LqXDw==
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
Subject: [PATCH net-next v6 1/8] hsr: Add header_ops::parse_protocol
Date: Wed, 23 Sep 2026 14:14:02 +0200
Message-ID: <20260923-hsr_ptp-v6-1-6ea07b3fb8a8@linutronix.de>
In-Reply-To: <20260923-hsr_ptp-v6-0-6ea07b3fb8a8@linutronix.de>
References: <20260923-hsr_ptp-v6-0-6ea07b3fb8a8@linutronix.de>
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

