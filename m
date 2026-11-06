Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794003373;
	b=RHEsB+vzAP5mk0O5x3HN654FDa60+ITUpgeWY6mGjjBbtokkKl5DArudCBB8wfN3ZbPF
	 kC3BRNsysR7cEKfmUIaqNVDGA0POjer6IqzJc5QcdgiwkJtAI9ubh99k3eHT3roL0n8Rj
	 0OCedZqhU8rE46Peg+toppz8EmGAkeoJyaJUgSEXe7ZPOn8m01LqZakIJxkqIMdsO0l0m
	 igndU+Ai8z1+NAEJFEBMxZFHIh0f1BDruL9zEKTbfgNLy3zb4onGvbVAT9/SQssQo04AJ
	 qZMd2j+VPd+EWtqtNbtLF9gTQBJFSVjf/oNsRzww17qlwD0YbeR9j/F6CgpRZ2sNTxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794003373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=laRzMMYDJxkaw25Allc7O+S/jwUBfxfqJWPXHy4lzgc=;
	b=uB5Uh2tRlHm0Y7QXfeoR6EjJSOen1LWRW6cMtJGdTxQqt/JbWtCqp3kEmkrmlbcTdiDu
	 ROqbvejKvadjFMgSk67dDWtkq63Zzk9s+CvDj+rjlMVddp1rRXZ2Zup/5O4R7nn3HY45F
	 jHAA5hFhRzePlsUM6SoU044bJy+uLKSodQ34JRefc/YhEWdacr93BbnZpxUfwN6Nf6t48
	 z9NHkbatQ9y0Ny3wZwTRwb8WUVatAjIv7jCeHM7RC769xgcmD+SUOtO3ueWuB1w4ooCSx
	 1KP5PHl0FbnMbXWL3oJJZSD/UGruz1VS2y10+a+v8KNIVwrBWLJ6y1EO2GVNxZM6XGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gQvBDgbF;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A24606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 22:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6A24606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gQvBDgbF
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36ff9c9da34so1465215eec.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 14:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794003372; x=1794608172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=laRzMMYDJxkaw25Allc7O+S/jwUBfxfqJWPXHy4lzgc=;
        b=gQvBDgbFA/4j7YiasxpWEVpB7LYJeUQ/608Smr5g2DvH+4wlTZbamMoh/jom5eH60v
         7BUPKgySkmsEwxedP9Ln5xYvxRy9RA5ntDOuslgf+6PaV5oxmPqlkDmop6XQ+CmCjX9J
         w+M70TPMLFKiw85O6wmXSCoaCvINfkD6T/gjdRz24Naq2W+A3ib+9liMdZ17PfbFZQTu
         eZPbWOI6gxdKvLOlUWQJxTRYKwlJj8nnCcbUVcTsywbFwEtwodL783omRdr4HwM3TE1u
         DAKGmtbCjRtE4LGk5gYflfLh/OKzyabNe0XJx2vyd87u65ecHLu1fDD+U/3CeBEVu3QX
         tEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794003372; x=1794608172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=laRzMMYDJxkaw25Allc7O+S/jwUBfxfqJWPXHy4lzgc=;
        b=jf3AKMNqY32XBi+w/ni2veG9l9OCnIFFFCbAUMuW9ciTABaYLoxYplBW6SYY/fi5uI
         033ov3l+t3r5aEtTGV2y0ygzNB2zZYIs4j6Na3xgIO/u4jjeYc8FW3KwiEVMvFPX0vhs
         jsk1wvgMbsLxt1TtprI/uG05az8mCWDDl9VSx7IcD6iCT6DifbWwiJbY9Pf9mWVEwNqo
         fSpJP+0mgdKuH+V2bCd3ravys2fmHZu8QZRVVm7iz8dvfBxayfe8MH6jWwmsodqZ1Vf0
         /ivAxYWTZlGo/6WdUKuopmZXq93LamOxLfBk6F6wAXbsOYjdNl+CvpVVOUYtnSW+8VfH
         7TDg==
X-Gm-Message-State: APuU4Z+dxfEe0u1Cy5qx/HmuNklQ17PjyFGJ//+pJHXD4EWsRYyxQmmK
	43iaH1w11ORSZ60x0cX3bLLDoU2TCS/ZkaWGaHcJSTbbgYvh13NcuEZzRyE2XQ==
X-Gm-Gg: AYBFou1F9nZzTN3Npaai9K0y83RUiMpTEkGKuiemeZCcYCBMeBqvIzPfI//HWyCfVBc
	8YmeD10gbsOBqTOIYRD8SSFCgDYiFBs34ETwvlDrScwwyfEZX8enAeq0OiMoPAhLhwKQRfPEq9y
	tVMBXWZZTaDjYHNV2GmbMRfX+nyb+Se4J1CZibk+n7iOOqpQ5GaglrG9hrtl8h6zpnAa9H3SIdJ
	rBAQ6crc62AiFwGpp9RsucvxXn2yPlDkH7kfFV0WLJWsgRAYHPLdsoujuLeFtvC2FPJJD35wDRN
	wKEZdzkmT/fn1wofTegcULTsYmg52+5wWr9oKlBMLwvj3/vvtPa0q5pVxTktLf3wP6d7++Lhz0T
	qIxSQSmveN9ubOXsR8qGeO/GVb7wxxWIocXgt1kcgWaho21mRMMKJjFLYv1e3RjhIB7be1E7DAE
	xhY1s3Q4ojGx3Iwn0tzMFv7sNLVtl8WcHQCy5+8xj8832HphL7NSZv4A6bQoE+MCHAzvKRW3P94
	T+Jj4XaTIP8Jq403/0f7Nb45a3Jxyn1UioCbtlE7JtzEkPsnKRbCOGmguadPegPnAks/BBb1VP6
	FyF1R4q8mnflKpWf1QMRmvPYMCd30tBF0K6oTwPN6FSXD8KxyttpStzRqGkEyQI1KzQ6ck5H/pP
	MqPPcIWujjDn8R8FjtzjnQHTaPZIt48STTVi4zKPDWxRKVHY419J7dv78w5PkfrMW4zi1A07uMc
	6g6Q==
X-Received: by 2002:a05:7300:ce92:b0:36f:14ef:ad08 with SMTP id 5a478bee46e88-36f75253a9dmr4860666eec.9.1794003370707;
        Fri, 06 Nov 2026 14:16:10 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faa5afffasm11333663eec.25.2026.11.06.14.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 14:16:09 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: ag71xx: let both QCA9550 MACs use MII, RGMII and SGMII
Date: Fri,  6 Nov 2026 14:16:07 -0800
Message-ID: <20261106221607.16215-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
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

The GE0_SGMII bit of the QCA955x ETH_CFG register selects which GMAC
gets the SerDes (QCA9558 datasheet, 10.8.1): when it is clear, GMAC0
connects as RGMII/MII and GMAC1 as SGMII, and when it is set, the other
way around. The driver only allows the second layout, with SGMII on
GMAC0 and RGMII/MII on GMAC1, but boards like the TP-Link Archer C7
use the first one, with GMAC0 on RGMII.

Allow MII, RGMII and SGMII on both MACs.

Tested on Archer C7 v2. RGMII on port 0 of the switch works.

Fixes: 0767ec042897 ("net: ag71xx: extend link validation to support other SoCs")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 16434a7139bc..b2d78819a0a2 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1079,7 +1079,7 @@ static int ag71xx_phylink_setup(struct ag71xx *ag)
 	if ((ag71xx_is(ag, AR9330) && ag->mac_idx == 0) ||
 	    ag71xx_is(ag, AR9340) ||
 	    ag71xx_is(ag, QCA9530) ||
-	    (ag71xx_is(ag, QCA9550) && ag->mac_idx == 1))
+	    ag71xx_is(ag, QCA9550))
 		__set_bit(PHY_INTERFACE_MODE_MII,
 			  ag->phylink_config.supported_interfaces);
 
@@ -1089,7 +1089,7 @@ static int ag71xx_phylink_setup(struct ag71xx *ag)
 		__set_bit(PHY_INTERFACE_MODE_GMII,
 			  ag->phylink_config.supported_interfaces);
 
-	if (ag71xx_is(ag, QCA9550) && ag->mac_idx == 0)
+	if (ag71xx_is(ag, QCA9550))
 		__set_bit(PHY_INTERFACE_MODE_SGMII,
 			  ag->phylink_config.supported_interfaces);
 
@@ -1098,7 +1098,7 @@ static int ag71xx_phylink_setup(struct ag71xx *ag)
 			  ag->phylink_config.supported_interfaces);
 
 	if ((ag71xx_is(ag, AR9340) && ag->mac_idx == 0) ||
-	    (ag71xx_is(ag, QCA9550) && ag->mac_idx == 1))
+	    ag71xx_is(ag, QCA9550))
 		__set_bit(PHY_INTERFACE_MODE_RGMII,
 			  ag->phylink_config.supported_interfaces);
 
-- 
2.56.0

