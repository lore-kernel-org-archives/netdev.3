Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A402B28DB54
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790599190; cv=none; b=I4YZRaaOt/63cqfjd4FCeJbubl19zFtfn8sWKgK0pIgO7/3RteQ9vvjteeE74Hq5oEJ+rotoWKzGHRgTQy77cYqn13fcAq4XThsxtmAWSPs4maf8v0q7u+fnpJOqqveB7RrgeOsybFhjc9QIe4te78zdXk1yg+cPMYABYnoI0ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790599190; c=relaxed/simple;
	bh=c6o52qQJs9QcOYJ0G8+o+ceydWkwkaK19RRs8ZrDRW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CV9rvJyu2ukMJqpYavKW/DmVUq8RdkdaQdIudXRO3A8E4XtGYw/O1fDX1RkmKUWQBfM0YhlNZdjJgEC1D7q3/BhGxPHh+UXsEfe0QWOlFHWtb1ZOwSsaaE7vAm+FsobN2UlPOeZxRh+UmQmbakx8XcrHmzHAClIVtDePBWKnWpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ykc0Sl6Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LuK5rqv3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ykc0Sl6Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LuK5rqv3"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790599186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gaolA8HyCxFnnwhWRTG00R+dZvmZnieOtCIRyueIrP0=;
	b=ykc0Sl6Yi3nZriP8kqZShT9MFqw9f3tmTd9JCoRUoOT2j4V8+BXheEmaFw4ev+uziHSWzc
	3sMGdNYj/XBDyB3BzTc1jsQsdS7LyhgRROs34OONySTLkEqCMfjX/mDcyghEVOL7zaXebO
	Flk8ZweX6KiC84RBGVHEx+H4EI4pa/DxW00llcNBL2i6UxxszG/alumnrTt+E/4L5uFi+O
	BcghJ0z5C+DTG/RR/9ZDRchVnM80uYslZMcW2Agtqa6jhq6wQVbGxsqMpxq7AFr7G7aoPv
	frPEaNP38VNd5co1oxLLMxOW5NeluZJ7lng/3dgHZ186lGfjhvjbtQzvtd++sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790599186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gaolA8HyCxFnnwhWRTG00R+dZvmZnieOtCIRyueIrP0=;
	b=LuK5rqv3rs/VR2D7vIK/Zc2qTmF+bMCUxfeb2ZFihCiWFN3EDOC3IfriX65ab7hHRWwCLK
	0Fc/DqBoSk6vjFBA==
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
Subject: [PATCH net-next v7 1/8] hsr: Add header_ops::parse_protocol
Date: Mon, 28 Sep 2026 14:39:35 +0200
Message-ID: <20260928-hsr_ptp-v7-1-d55d304d9a7e@linutronix.de>
In-Reply-To: <20260928-hsr_ptp-v7-0-d55d304d9a7e@linutronix.de>
References: <20260928-hsr_ptp-v7-0-d55d304d9a7e@linutronix.de>
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

