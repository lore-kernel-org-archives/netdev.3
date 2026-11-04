Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793792926;
	b=NzkV2l/A0VHwFuB2HDZJ5mEIetRQdfX6qn397EfEiM8nQqN8etkHFBPEaWn0RDiYSNDQ
	 d8p1d81wZ4a1HR8rW6VpvkuqiGuXksrbNw3WaTZnu/oit/Xkv2c03REWNRplfmoix5E5F
	 KdbWS6mFZq3XV+29qpaiyFbo9q6fhDrjbjyWTxW833kCZCPbY5szU2KxoOEr9Tad1ORtD
	 8qbDk4keNgx/4D/5AK9H8GIguTfkyvwcGy+60R6wlVhaMlFsJA3+OjIQ5Sb/8ZKLwukCS
	 f5cWnc0afmYFwftBloTisPacQNksuyHqXM1evMeOJRC3RmdyngFo72AymH1coktROpg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792926;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=yK4khsS2ba65Eeulo4Vcf+S64wQVrE4OGyCa1KBxEG4=;
	b=V4SQnIpIOgcHZc0rU2raAqrDAd6+y8EH28R5Q2T20AJCEgsMT22VHjodaDeoFVcAqdXe
	 xK6Iqc6gmqgW3E8RmVDfUbtvgkymXASHJ8XhnbP/ETrnJ8wGHIMdYMxuVC1YO5XuD94fD
	 vloiyef625HlAMfyWHPg6cjUKSyRDjh/BCSjSIeMClu8NCTYUpYZzxrJFJqKClQltDSzl
	 6NPT9OVWjoiJlppMy2b3lalVz5My0xhPhwtFPLObYk4AVsantMpcHHeAqoO1Sv3+sWodE
	 N3kTp7smBTntbHB0mRBLZGVFQFAr+GsQwIGf0rEDtNRFMjAluRtEkwtk5dljatN6egQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=L78rvXvn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C221606A32E;
	Wed,  4 Nov 2026 11:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C221606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=L78rvXvn
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 85904202013;
	Wed, 04 Nov 2026 12:48:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793792922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yK4khsS2ba65Eeulo4Vcf+S64wQVrE4OGyCa1KBxEG4=;
	b=L78rvXvnm5GPF+6OTZ+u7+iQT7sFmjB05D1CU8N6usrlw644a8N8aper7OWGSEmJvju4Wy
	EWujslRGTQZalbZiNP6fopkaTY04lvkPrsHpnWxPvpz/ucz5PQfumVb4SaLTY4OvzA4iQF
	56wEnYDNGJZrhX1O7hSsd98k6cXW8dxOLxQoSQpLm4QPMbfZCaDdc4DxschYk81xaSMRxQ
	JLPyRNUNfj1r7g0ih85DXJuymcKauSyJX2zMc09g2l+LbbIwBIHpBiUeX1IgS+NRKyKA02
	C30oGzZpnRETq0EuvMp1S66oA0372hwc36Z9nuy6tZ1G+fZM7eQnxevsjk4vKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793792922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yK4khsS2ba65Eeulo4Vcf+S64wQVrE4OGyCa1KBxEG4=;
	b=ElMJP4b1PH6jBALJ02KIlbZhp7XRQPzdrt9N/1LFYEknS5WjJ+Tlycs5ZTSAkSmqEN1S6b
	jwn5+VlC2p+HegRQ3R35VthAA7A18TbOWf5CRXFl9wDDxobfA/jzpwDXCn9ga8Zq26gTka
	lfVa/KDyNZs+CspuFywyipzEK8A0eB/jOvsjKpe32ysh8diViNrS32luPEQ9PROk6UIDbY
	/QG+18hv6aWNAHOoVNuNBqVatOi3QZOtGbR2TnHaFpcOUJ2M6CFjeUh8HUhGPKInsR58WU
	eCLD2Kem4yemv0pI6hrwMIKFsfZ3gJ2OwgvEzbIn6k7QE2J+rVfjc+X/fjLBxA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793792922; a=rsa-sha256;
	cv=none;
	b=G2VjOQXF7ZMblA+viA02j/bnT/TavF5wGhdli3pPyHBRPpYLHmAD+cu0bjQfn4roGEIlF/
	MV1wnR04BZZwN5LPGim6/Jpo/0zfm1By79JNLKoHbyj8VdwwmJWy3siiVozpkVIDlKay8H
	wCGkY9qoHxWCi2DiAQ6t8szZoH7MIdqqcldH1u5nieinD8A2KH7JPMn5XJgXKHHw9Udloy
	pZ0bW2/2K5jq4gSV5O0C67GhgYappoK/AoH073uTSrOR388sgpuAx5txVwcZnDEmhnaHv2
	LL+08HLFQFLplQz2eaO7Pes19fGGTSAslDPh26TOgy64f5lz9rydSakUNh9tMw==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 6031F380AE9; Wed, 04 Nov 2026 12:48:42 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Wed, 04 Nov 2026 12:48:29 +0100
Subject: [PATCH net-next 2/3] net: dsa: store the port ageing time before
 programming it
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-ksz-stp-ageing-v1-2-2c2bc7217dea@pengutronix.de>
References: <20261104-ksz-stp-ageing-v1-0-2c2bc7217dea@pengutronix.de>
In-Reply-To: <20261104-ksz-stp-ageing-v1-0-2c2bc7217dea@pengutronix.de>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, 
 =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?= <jensemil.schulzostergaard@microchip.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
X-Mailer: b4 0.14.2

dsa_switch_fastest_ageing_time() takes the minimum of the cached
dp->ageing_time of all ports, but dsa_port_ageing_time() updates the
cached value only after the notifier. Raising the ageing time programs
the old, shorter value again, so after an STP topology change the switch
stays at 2 x forward_delay.

Store the new value before the notifier and restore it on error. This
affects all DSA drivers with .set_ageing_time: sja1105, which reloads
its static config on a change, will reload again when the bridge
restores the ageing time.

Reported in an automated review of the lan9645x bridge series (Link:
below).

Tested on a KSZ9893.

Link: https://lore.kernel.org/netdev/179180428624.434549.14425623884223795761@kernel.org/
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/dsa/port.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/dsa/port.c b/net/dsa/port.c
index 1f5536c0dffc2311db24015697e0c8f5c014ac74..3195d8b7c69c5e0fbc4007421218c2ff1db0ce47 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -876,18 +876,22 @@ int dsa_port_ageing_time(struct dsa_port *dp, clock_t ageing_clock)
 {
 	unsigned long ageing_jiffies = clock_t_to_jiffies(ageing_clock);
 	unsigned int ageing_time = jiffies_to_msecs(ageing_jiffies);
+	unsigned int old_ageing_time = dp->ageing_time;
 	struct dsa_notifier_ageing_time_info info;
 	int err;
 
 	info.ageing_time = ageing_time;
 
+	/* dsa_switch_fastest_ageing_time() takes the minimum over the cached
+	 * values of all ports, so update this port's value first.
+	 */
+	dp->ageing_time = ageing_time;
+
 	err = dsa_port_notify(dp, DSA_NOTIFIER_AGEING_TIME, &info);
 	if (err)
-		return err;
+		dp->ageing_time = old_ageing_time;
 
-	dp->ageing_time = ageing_time;
-
-	return 0;
+	return err;
 }
 
 int dsa_port_mst_enable(struct dsa_port *dp, bool on,

-- 
2.47.3

