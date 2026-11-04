Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793792926;
	b=BGRu8vJZyQ1rQrFXUocYfyDHCKiLUZrn56NQE4pNV2kYodTis27VdKWSI3TuzDICcltE
	 kccbs6h3o3+cAao33kA+HzcHw+XYZDbrkuCtwEnsnHdMPlWPO3lvEHgWkOXmpmjRHWNGI
	 KH4v74LKyMJ1JNTzQnhp6NAXHbD9ljmZ5gaaSEG15s9ZE9oeZx6bfmbQ5w5qKZzX0ZWRl
	 Dsu0FFjgzSRhnJ2cKRWw/Fzry65uShBNv0MDRbArEBILUsh1obbF9miB6TFdzcJ0EEgFR
	 nJ60m9wRFnhXFIQUOspLFkGc40/Qv+U2MGH0Y9YLNkbAIBqvc7HDPLjmQHlx2+xGmmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792926;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=3bGWlhAYviDwoR40GqMnNAhKLsxh99UIMeOoR0q6Ev4=;
	b=Yia9aYkL6bgc4wXdB0ccad+sAEF+KfyT8TtoAtxKPhY68/z4IsptWc62W2cjZCIBFQ8/
	 UJFJC3V80j5JKJk4Y081J1ZrD6wenNXuhitkeyZ+6vGTmo+dRIrehN/yAVSvk91lohxjp
	 R3Ux/SLBD9Koh1zS3xTodgfywUPyWb/bgPk+WLUAJNTRr6k8JCR6uOKdjqsklmVRccvr1
	 WskeI5LG6k37iTEH44CWByKCZmuUmu/Rf1JMWpqxr3Za5fG0V/NOo3oSiWmbvyS+dtqXs
	 HUpXsGdOxFPM8vTqBFY3zF22NIlpCxPkgZkrxp4UYj3b2Ky3/p09kvZ56RzhaXJlOQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=UX486yM6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C15C606A32D;
	Wed,  4 Nov 2026 11:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C15C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=UX486yM6
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 79322200FB6;
	Wed, 04 Nov 2026 12:48:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793792922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3bGWlhAYviDwoR40GqMnNAhKLsxh99UIMeOoR0q6Ev4=;
	b=UX486yM6TdwjU1NYbaUMthBlcqapV+yg/WPC3oniSHCjQm/4mRoBNaWzuqD8Bh/EJuFHgf
	kTeheWET13feOqJLx+0omf5yICrB0w18mc/XWrric/mgLR6A2FB/J52UoPdu1aVloMjTkK
	Dxtj5wOtldieJJlY8KlJAUKhjlvUZXTZ82TNCSXB2/miirFx/R5oyqs5DNjkcTDdzrxaJb
	7DvYPyQkE+YXfL7ffTHJZtn11OKTzkSfmI0NpltOHjBM54jMMv9q2QqVRoAfugWCqDBv6R
	AjGRAChgU0rdkIWqba6lZ2V9w995Ts/ZNonfov1hpg51Dpa60u8n7AG9C6vyBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793792922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3bGWlhAYviDwoR40GqMnNAhKLsxh99UIMeOoR0q6Ev4=;
	b=P/CqPzbOP662H/wi2fFQCOKmIHZoxu5ouGL5kBZaItmANNb931JveodIyytCYgZrz9vMjA
	M8vAoP6RbsYW94xK6GMPr6nAlIIOLFVlJG/5gOl+a2vvdGeyKh3sII+GYAZ6AiKvIPia2D
	V5qXKKJvqyrDxTLP7yEiFin643Ws/o4LEdSteDwv//xqeV9EVnINQAR8ckX7x7cdPDh97T
	d+D84ew7duyzUxdSMDPN8Na1Rq1GWwgbYiGA5Lip3bAao27RR7HNJor4looCBHALTvDqUl
	2AsMDiYGip5g8lk3A+T9zqU9K/K/SRoFFIhVFFnTiBpruQUObd3IlXCk2sE0ww==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793792922; a=rsa-sha256;
	cv=none;
	b=fH12q1G+0OhL1li+1KSCz7rHOAGPwnPdkvg9+fbIFvE7HmmCCxG8ackqJK4qmt1E5MGxv1
	1V4nHVU9Fe9+WEa0bOBZafaKtwgi++WF0UFs9bXp5KqGcVwAEaq+tiugGgNv0UTGHX7UPf
	4GW9U/xxpqj37br/6SFz6d1WyMJBR7e3PZEM38X3UD7A2si7EyTmKzjVlPIwjYL1X2vcdp
	NYRRNIDaYcQ75uhCUMwdoNU8vyTmLiLbEORBNsZzm6q/l3UeejdhcFGhAxG+2lkbmw50pl
	TUs3qYFbGZVW9jVAlbTkW//m0piamAcD9AtYijgh2A4TD516TE78wYbmmdVncQ==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 5F6A938041E; Wed, 04 Nov 2026 12:48:42 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Wed, 04 Nov 2026 12:48:28 +0100
Subject: [PATCH net-next 1/3] net: dsa: microchip: ksz9477: apply a shorter
 ageing time at once
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
Message-Id: <20261104-ksz-stp-ageing-v1-1-2c2bc7217dea@pengutronix.de>
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

On a KSZ9893 a new Age Period applies only after the running one has
ended, and an entry keeps the Age Count it was stored with. When the
bridge shortens the ageing time for an STP topology change, stale
entries outlive the topology change: 61 to 79 s were measured at
forward_delay 4 s, where the bridge asks for 8 s.

Pulse Fast Aging when the programmed ageing time gets shorter or the Age
Count smaller. On a KSZ9893 it removed the dynamic entries of the user
ports and started the new period at once; 2 ms was enough, the datasheet
gives no pulse length.

Tested on a KSZ9893 with kernel STP. Other chips using this function
were not tested.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz9477.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 72528a53b67d2d269d9a0505b0cc0c2348f06fad..b54f388b227f19c58c35ce3642935387c11e9356 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1289,13 +1289,16 @@ static void ksz9477_phylink_get_caps(struct dsa_switch *ds, int port,
 	ksz_phylink_get_caps(ds, port, config);
 }
 
+/* No pulse length in the datasheet; this one worked on a KSZ9893. */
+#define KSZ9477_FAST_AGE_PULSE_US	(2 * USEC_PER_MSEC)
+
 static int ksz9477_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
 {
 	struct ksz_device *dev = ds->priv;
+	u8 data, mult, value, old_period;
+	u32 old_secs, new_secs, max_val;
 	u32 secs = msecs / 1000;
-	u8 data, mult, value;
-	u32 max_val;
-	int ret;
+	int ret, err;
 
 #define MAX_TIMER_VAL	((1 << 8) - 1)
 
@@ -1314,8 +1317,13 @@ static int ksz9477_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
 	if (ret < 0)
 		return ret;
 
+	ret = ksz_read8(dev, REG_SW_LUE_CTRL_3, &old_period);
+	if (ret < 0)
+		return ret;
+
 	/* Check whether there is need to update the multiplier. */
 	mult = FIELD_GET(SW_AGE_CNT_M, value);
+	old_secs = mult * old_period;
 	max_val = MAX_TIMER_VAL;
 	if (mult > 0) {
 		/* Try to use the same multiplier already in the register as
@@ -1337,7 +1345,27 @@ static int ksz9477_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
 	}
 
 	value = DIV_ROUND_UP(secs, data);
-	return ksz_write8(dev, REG_SW_LUE_CTRL_3, value);
+	ret = ksz_write8(dev, REG_SW_LUE_CTRL_3, value);
+	if (ret < 0)
+		return ret;
+
+	/* On a KSZ9893 a new period applies only when the running one ends,
+	 * and entries keep the Age Count they were stored with. If the total
+	 * time or the Age Count got smaller, pulse Fast Aging; on a KSZ9893
+	 * that removed the dynamic entries and started the new period.
+	 */
+	new_secs = data * value;
+	if (new_secs >= old_secs && data >= mult)
+		return 0;
+
+	ret = ksz_rmw8(dev, REG_SW_LUE_CTRL_1, SW_FAST_AGING, SW_FAST_AGING);
+	if (!ret)
+		fsleep(KSZ9477_FAST_AGE_PULSE_US);
+
+	/* Clear the bit even after an error. */
+	err = ksz_rmw8(dev, REG_SW_LUE_CTRL_1, SW_FAST_AGING, 0);
+
+	return ret ?: err;
 }
 
 void ksz9477_port_queue_split(struct ksz_device *dev, int port)

-- 
2.47.3

