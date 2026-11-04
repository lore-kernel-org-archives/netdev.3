Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793792925;
	b=QBdBbIKrl9z2KhQ2iiuQnfr1/OowOIljXfDk5NaFEzHCHCmXRWdT6seuvfr2el49+zrN
	 IKYc9aVBkWU8aFlDk4RJwtmTjyoRchK72beVfSiSfxCwp3EkSIHmvt3jCK5uDnRcl2L20
	 eTMIXizNLnQu9ONz0064szlHwAtdNgzSESug9pSPnAqSYjpPMgalprWKXdOqsTqVpeuLY
	 Zwem81NjZRVRtXI27QHv039SsQijZS8SixYYgt19ccI5YMyyGSQd/sRWaqMkDYEN2ACnM
	 jzDsVs9bBMSeFth+81fSlHVgbqPCE9Iv51CnKMzmP3pI9JKU2hbUKJBHDW3gLEkxG/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792925;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=e5Ch97kX/P1BvyP/wOOgUJMslmbVg22VYVvr+9XMWTo=;
	b=OXtMQgZPqrmRqPkryCd1jhwft8Ji6x6I8X1FWFRQIUoFECR9sXCQJsCB1418UpQwktoI
	 l5Wa0DhGcX9Z+epw2X9eRuBdCKz/q6YTA0Yk/bwkjfdfyTN948n92HzuHYxs9BPC+dZri
	 1+jCoysyuHW3RKO1l3+3dWhIscHKRr/QT/tY4Rzr11I2EHuNMYzqVBuzPASFyg5GZHFtg
	 QdHYdO6vmplRT6qPWvQwCiEqFxNwFQptkkfD+zb5ZjypW2EcKdZb8PatajpGraCf/6SHn
	 TTv2sgJY6SmPcW0s5N86Yk7nw6I4Xezxpq900E+uNJSQf6yiVvLCRs3+U6FatFik0XQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=bg83ae0o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0F2606A32C;
	Wed,  4 Nov 2026 11:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C0F2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=bg83ae0o
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8869C202101;
	Wed, 04 Nov 2026 12:48:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793792922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e5Ch97kX/P1BvyP/wOOgUJMslmbVg22VYVvr+9XMWTo=;
	b=bg83ae0oBmebPSB/nvMf7Bi5ZgONSRtHAfurQ0r7OfU4glk7tsEXMozBoa4niX63wHxY34
	7ZkyPMq+TDUArUCMLS8dXuC237otmWeCCxgEFa2zIhRIwD0Zx7EyV+7njNB3h2C56w2cyO
	w+jh/CbRjEw8ajEuk4PLGsKZVrHOilP4JV3Yrn5KFTSUdfvTQwnv7lLm4TohqIlL0yMNOI
	LbydZUNwMf3G0yrDtHXeir79TvJvqpTgnw/GBKUi+jOCdcn9AaWVE4loVbcJ3ckU34DAMK
	S/Dc7PyM5X1Wf96QEENLyR63JjwA3cx+7U5z8ByPQJYjIQFsw/M8muptqinSkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793792922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e5Ch97kX/P1BvyP/wOOgUJMslmbVg22VYVvr+9XMWTo=;
	b=XXV1f1TklJHJ0xd6roXiDmic8ApLIIqmZAjD2rdsHaGoLjQV0ql2ogD0yN0SkERm6qFX0A
	tAkCR8fVHRcqwuLO1yFFzUL65KGTk0iIDSa5vSfqpGh5XgLO/R3UFbFOJyCv2jd1flg6Mb
	4yP88dttDDFQ7cUYap06LURqcTWt2SFXZk1D8gfrhwZfZYQpEKFs/NrqX7XeDU47h8vCrV
	MyQb327Fn9A6tuyr9l/Jwi2qQWh+gorGrrlI2EWPGxr/ZeYPfXPuNsKkRNmWEJISvSERJJ
	x9h3D3WeA6k8eOK90ghej/0aMAoD8BBDb1Arl3Ty0lSw+9rl+n4oTNpfOFmQ9Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793792922; a=rsa-sha256;
	cv=none;
	b=HhF9oTME1wgJ7twVU2b1yAg56ZLqLlYYGyUalOqwMUIiKujtf6JBrVwX/TjgfhOG3IudyI
	BRhNhQmxqhtuuZI/ep0miBcRVAhGJdu8AHbkTR57QQYe0QLbaX6gdrlYYr3+XjRL6yRm9T
	kI8MF0EuxYiFuSle8QS/eBaMFOBugh6iSrsa45aC462FWf82SoqinEHZPIqBBNuTfMs/M2
	CfExprDzQxh1YPzdyiGVlK2Y677MucgtLbFL0FUxIWeWM7J5J0a8g4XTwhaYW9mwG1QYRA
	zJ17soqJ8wYvqbDVhJSVaexm6ZO30okn2rgXxWdfIxaf/hSrQdb9Q0skGauPzw==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 61EC0381511; Wed, 04 Nov 2026 12:48:42 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Wed, 04 Nov 2026 12:48:30 +0100
Subject: [PATCH net-next 3/3] net: dsa: forget the port ageing time when
 the port leaves the bridge
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
Message-Id: <20261104-ksz-stp-ageing-v1-3-2c2bc7217dea@pengutronix.de>
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

A port that leaves the bridge keeps its cached dp->ageing_time, and it
still counts for dsa_switch_fastest_ageing_time(). A port that leaves
during an STP topology change keeps the switch at the short value until
the port joins a bridge again.

Clear the cached value when the port leaves the bridge. The switch is
not reprogrammed on leave. If the leaving port held the shortest ageing
time, for example during a topology change, the switch keeps that value
until the next ageing time change or bridge join in the DSA tree.

Found by code inspection. On a KSZ9893 with lan1 and lan2 in a bridge,
setting the ageing time to 10 s, removing lan2 and setting 300 s left
the switch at 10 s without this patch and at 300 s with it.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/dsa/port.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/dsa/port.c b/net/dsa/port.c
index 3195d8b7c69c5e0fbc4007421218c2ff1db0ce47..21b237332cc77b9f99520e71dae01c2c9b49d496 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -414,7 +414,10 @@ static void dsa_port_switchdev_unsync_attrs(struct dsa_port *dp,
 
 	/* Ageing time may be global to the switch chip, so don't change it
 	 * here because we have no good reason (or value) to change it to.
+	 * But forget the port's value, so that the shortest ageing time of
+	 * the ports still in a bridge is the one programmed next time.
 	 */
+	dp->ageing_time = 0;
 }
 
 static int dsa_port_bridge_create(struct dsa_port *dp,

-- 
2.47.3

