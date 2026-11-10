Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794282639;
	b=WNcfTvx0nClC6W4Dwe0nigRJ8vXT6s45MN8xK5oJ1kZ0K20YJ1oTJ8c4w7a88ebQazXe
	 E7ObKnXtRImdszXMNP750GkWkbPLRWK6FDkJzeKMa6Rg9pXXr/0FIPcpSAqiDdDwG5m0e
	 Q7EEOhjD7hJ3h8dc2h5tTpN/nRsVLyD6KXepCioEkuzqUeYbkkZzynnfNx2QrnJqMWQhE
	 3nDQBqF2qbTPdpDWBdX9MDH/N5JUg59pkHp55JLEUB7/tqXMxVCjcgVwYGF/hr52hE1dU
	 FrzCFZeWMT3UjjD0f/Uk6PMfm2kA3vDGwuIGZaSSGJzFdvosiJikEAF6eTcl/wVANmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794282639;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=4vlXeE9enSxQAZM/AVNB/6k7VuHl6mXvqO/NCZEaN1w=;
	b=iCJXVs1jvWUyAeuTfQV1IW4W3rG6DHNGRR9EJ3RFzVKjBze98s3MnjARSs3PdCtrAAW8
	 wbAFX+Fm4MLBXPDXY7FBAgOYI/B+Hrmn2hJJEApB8c7Ue0KQ9I55lzFM3piMbwV6HwYqQ
	 AESbKU8JrPgoTit1c9lqos5l7CEIZUaR2An7CvJHnET5L7yuL4Pw1ZZbFTzHzNc2fJXIi
	 O5pVORdHbpSl2vcHX1DFLWpcrbbl8pcON8Coi/DNW6qvqwRvfkevIUONrEMaRebAceeZh
	 FgX1lF0bc+ufps2NLtOZyRWcyAe3CD+dXm/EIp680weh5Das28799Y5B9hFQ77LRMOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=azDNewJy;
	arc=none smtp.remote-ip=209.85.219.99
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C4960A2602
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 03:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87C4960A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=azDNewJy
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-91c6ce60697so19957106d6.3
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 19:50:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794282638; x=1794887438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4vlXeE9enSxQAZM/AVNB/6k7VuHl6mXvqO/NCZEaN1w=;
        b=U3vuotkV3gWPVmx3OEk4tcQ4PL7vboGewSjeZp33Q8O6HorUYEATIiqo6A9dZDDrI0
         myiIhUj0xl6uFQBwe0jO/VaPHuyeRephNRUDGRFe2Q51lUNVl+dAoR8wFrb4Qe335KEq
         YIWKZBqUmI1B/u1a8WbeKtcrEOCaGOkRGsPRuBFDW9jPZU3CmaI/y2rCbJgpCa7C/pii
         Zh1aurXelvTpzby0Ok4d0xJ+FbiLbX8GEo3pRQIb1qjhaKv4JdbNirpIbvnqEOrAIXmj
         tZlGvzFXKhwgEdBoFuU6pqeSFNJFpa1ZV7Yf0SrzcPHoR6qHjJurVQDs2BjF2RqjGi3k
         bKKw==
X-Gm-Message-State: APuU4Z84XpNbsEsrek6lsU/r9bSDHt5bCPLeiENlz+khbT1NN9Tpk0Ob
	q4lSC0+EKHispEWoGCzuvnyoLA/8UwU6IMaXhIJa8t4tnYcC76pPmEG3Ao/GYAlsvFecv4uh/FB
	ArdiqgzHKOsC1FJflYEyUOgitQLNf2wAFTB94VxsK/Yo+mqMWR8NJcqLL+RyDstTp6opUpy3e7D
	Q0rd9spkdSIBEeM8errb5fP8LIX/yxyb+iSkZDV2pwx5xSkQ4zD1ybIWTBg2EUEaFb+suvwUcx8
	3Cl8NZE+p+mzk4a
X-Gm-Gg: AYBFou1KglPwMHGTCGAenJd4AOtwpgxD4rQOYbHYAETR7JWRW8F6+AgeM1tjbOHDW6+
	guOQ/VNkk6irO2F/1lTQLa6ruc67becNpra75GaN9JUbHjqxnwKG1SBS+3Qx2JMWz4hJy8BTJsq
	E9+lB/wihCabzKoW2sayQzmKVBExeDKN06i3ajIO8jYn758Fh4KMtDRWkHvAvrwypbqgyh1QPOu
	ApE41VrA4Cs8Ptl2IHYqh+nviZDzxPQYXtnjAWmFP8wIq/YYnRGYAEzI9qGEgKahOOyNs04VMfc
	pKHtmJYW+Ikwii2AS7f4vG47A/ZwDyi0Ud4DaRkRtyCO1TAzNp8SCg0QDZoCp/bfjo13XtgkD6s
	NvDL34OgCyONsZZ+U5ug6KRRPMF9ydQOKGrj6mERCaMCCgu4XCtmXY/B6KOr0sZSAGKJoXKv4xJ
	fVXGgAzZKbhvn/VtUqhZHPcWjfX/7K/eBjKkNiKTqj
X-Received: by 2002:a05:620a:4049:b0:93f:11ee:ba5f with SMTP id af79cd13be357-9479f3f7537mr252351285a.79.1794282638443;
        Mon, 09 Nov 2026 19:50:38 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-9479efb239csm17460085a.10.2026.11.09.19.50.38
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2026 19:50:38 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-535252004e9so27340691cf.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 19:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794282638; x=1794887438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4vlXeE9enSxQAZM/AVNB/6k7VuHl6mXvqO/NCZEaN1w=;
        b=azDNewJylkRUjxeooK7T1bYjeweLbDfPPsbnIQRMJ3ewgm3JrVKIIlGAzLsr0oeXZJ
         uErGrNxwSA7AowqNzePwtsRVAowFAQpQUIwn5uY921tQysf6favt8SkpAsf0ilWAMPEF
         d+D5ZDDEaZV+G3lC3Hy4ijPPbidswteVqnTIA=
X-Received: by 2002:a05:622a:1f95:b0:536:645f:c901 with SMTP id d75a77b69052e-55528ec3f5bmr20311651cf.67.1794282637698;
        Mon, 09 Nov 2026 19:50:37 -0800 (PST)
X-Received: by 2002:a05:622a:1f95:b0:536:645f:c901 with SMTP id d75a77b69052e-55528ec3f5bmr20311401cf.67.1794282637209;
        Mon, 09 Nov 2026 19:50:37 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550af612dfsm13740951cf.8.2026.11.09.19.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:50:35 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v4 5/8] net: dsa: b53: use the correct override register 2 Gbps bit
Date: Mon,  9 Nov 2026 19:50:15 -0800
Message-ID: <20261110035018.2169370-6-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110035018.2169370-1-florian.fainelli@broadcom.com>
References: <20261110035018.2169370-1-florian.fainelli@broadcom.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The IMP and per-port GMII override registers swap the override-enable and 2
Gbps speed bits. Using the IMP speed bit on a GMII port clears its override
enable and leaves any previous 2 Gbps selection intact. Select the speed
bit alongside the register and enable bit so lower speeds clear the correct
bit and 2 Gbps sets it.

Fixes: b6a8a5477fe9 ("net: dsa: b53: fix resetting speed and pause on forced link")
Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 715a0969eacb..6b4a94a97d66 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1427,17 +1427,19 @@ static void b53_force_port_config(struct b53_device *dev, int port,
 				  int speed, int duplex,
 				  bool tx_pause, bool rx_pause)
 {
-	u8 reg, val, off;
+	u8 reg, val, off, speed2000;
 
 	/* Override the port settings */
 	if (port == dev->imp_port) {
 		off = B53_PORT_OVERRIDE_CTRL;
 		val = PORT_OVERRIDE_EN;
+		speed2000 = PORT_OVERRIDE_SPEED_2000M;
 	} else if (is5325(dev)) {
 		return;
 	} else {
 		off = B53_GMII_PORT_OVERRIDE_CTRL(port);
 		val = GMII_PO_EN;
+		speed2000 = GMII_PO_SPEED_2000M;
 	}
 
 	b53_read8(dev, B53_CTRL_PAGE, off, &reg);
@@ -1449,11 +1451,12 @@ static void b53_force_port_config(struct b53_device *dev, int port,
 
 	reg &= ~(0x3 << GMII_PO_SPEED_S);
 	if (is5301x(dev) || is58xx(dev))
-		reg &= ~PORT_OVERRIDE_SPEED_2000M;
+		reg &= ~speed2000;
 
 	switch (speed) {
 	case 2000:
-		reg |= PORT_OVERRIDE_SPEED_2000M;
+		if (is5301x(dev) || is58xx(dev))
+			reg |= speed2000;
 		fallthrough;
 	case SPEED_1000:
 		reg |= PORT_OVERRIDE_SPEED_1000M;
-- 
2.53.0

