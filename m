Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805057;
	b=YyO84t2yHcLejNuyCtnMIetkYx34v6kjpg2LBtL6bh3c/6U99j8/TXiC0fgreWIonkHj
	 edtI7QXzmNmqGMdNyZkBfwdWiVUI/f5by7ciH1oLShwCyVIASun6v6PMC9RxDyOuiMOSc
	 gQdvcYv7htCF8MjuD8rkGAq1TF+hSwNudcvemh1pS7WbbnvNgu3k+HQghmkbQrui7pzlr
	 sL2LzQve8xZ4qBzlrKFc63Vng3WIgF2zjXrrozurY+VvJZ4gDjFwMyvYLIIzofUDFw/h4
	 Dez1NbNhGQq1ukGL+kQAQsjmBEEGutpKCKijz3EziPOEFA56Hb+TSoJK0dBF2DThCCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805057;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=VFA3zsJCkQHWwoRghVRj1TgM0YCyna4Tws/d1WMl45w=;
	b=Ugi6mjcCVVzeotUM3gFZ3Q2lwEGfgV0ID8mLOIyDXCLcT7hECXxFZBAaxYoc+W/8IleK
	 dJkrjWBwUwluFLioxOfSKBzivwC+rTyysudcTE/VndTRhS3BcR9A3ZYFfpRybBMZBol80
	 8D7BRkOilWld7IWuu4BL/TboVzG8NR7vdc5p/Hol/T7P5y4fWDReNPTvuLw9a7ZFLA750
	 LEcxkBNwyWhkMXQUatcx1yMh1hxr7bOvvUA5ijWT6B4ikXLgnLmt258JszPCNlqIVPK69
	 wChufMWdu9b0PjdG1+413AqT5HLvZEcRPiaSSmcHfjzz3gthlj9IAIyHy5wUBJ08pDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=GiMTwXOa;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=5SGlVfy6;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1905606A33B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1905606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=GiMTwXOa;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=5SGlVfy6
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793805055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFA3zsJCkQHWwoRghVRj1TgM0YCyna4Tws/d1WMl45w=;
	b=GiMTwXOaHaJ2wSLKCO+bikFmZwPcI8cviNzWYRHsUM82rfWQQ9T17kJZHzYafys/JSkqx7
	2lAIpXCwtahBz0rUustM1WmpisTpIgkY+gFqhNBc7A/Gp/9wX+jTfOgnRlymCPjplqxqKw
	p9gvIssMqyNcaIdm4ursDAdnA+fQ/ijAZcBRroh+/rQV2h9rcSa/KNM3oCGF0jUYI/6psU
	NLbQPUjYNBUl0fKtl9SweTgg95NowNNKHiVLfS4z5rVPKp08cZTN0Mnft3axRUGcLb1Xuz
	0rNDlmHuwNJ6qjLTg0D0eIZTM3HVynVzo6H90FrFk3+mVa8IR6ShkFGjYmPN9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793805055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFA3zsJCkQHWwoRghVRj1TgM0YCyna4Tws/d1WMl45w=;
	b=5SGlVfy6+CW9I65G5K3w9L7yIuTehLqcd2o14F/lK+2JfieubJo4kBD2QRKc9d6/v0gGz9
	T0ys8dsMZnznkkAw==
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
Subject: [PATCH net-next v10 7/8] hsr: Move struct hsr_ethhdr to a global header
Date: Wed,  4 Nov 2026 16:10:43 +0100
Message-ID: <20261104-hsr_ptp-v10-7-2c4a38ad973c@linutronix.de>
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

In the offloading case the network driver needs to inspect the HSR
header to find out if the encapsulated type is a PTP packet where it
needs to suppress offloading of the packet.

Move the header so it can be included by the driver.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/if_hsr.h | 6 ++++++
 net/hsr/hsr_main.h     | 5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/if_hsr.h b/include/linux/if_hsr.h
index 7b6b60ef592db..f81323f10eecc 100644
--- a/include/linux/if_hsr.h
+++ b/include/linux/if_hsr.h
@@ -3,6 +3,7 @@
 #define _LINUX_IF_HSR_H_
=20
 #include <linux/types.h>
+#include <linux/if_ether.h>
 #include <uapi/linux/hsr_ptp.h>
=20
 struct net_device;
@@ -39,6 +40,11 @@ struct hsr_tag {
=20
 #define HSR_HLEN	6
=20
+struct hsr_ethhdr {
+	struct ethhdr	ethhdr;
+	struct hsr_tag	hsr_tag;
+} __packed;
+
 #if IS_ENABLED(CONFIG_HSR)
 extern bool is_hsr_master(struct net_device *dev);
 extern int hsr_get_version(struct net_device *dev, enum hsr_version *ver);
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 53e95bae0ee27..36eb82774000c 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -72,11 +72,6 @@ static inline void set_hsr_tag_LSDU_size(struct hsr_tag =
*ht, u16 LSDU_size)
 				       0xF000) | (LSDU_size & 0x0FFF));
 }
=20
-struct hsr_ethhdr {
-	struct ethhdr	ethhdr;
-	struct hsr_tag	hsr_tag;
-} __packed;
-
 struct hsr_vlan_ethhdr {
 	struct vlan_ethhdr vlanhdr;
 	struct hsr_tag	hsr_tag;

--=20
2.55.0

