Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.126.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743435;
	b=1fZohpkdvzVkt3kK92ZFJ1IY1ttz9ARXNVSr4AWrCsV2cjIQjcp9i9y97O/e/oKP7otY
	 5rhSLstOHOuDtPZ/9Ux1X02F2itu0VVFU7gwCn6rd7Br1coof+grcOJbxxpbeyfB/dTwd
	 gf1GOl9ffEEnwZwaqRNCq416AFch8LcAHLpggnOwIIrZajis73vKZhUXCTClhWhUNl2hV
	 l6v42NJQl0tY+36ZAzrYP++Iobo7usQDTql4b3eQ88rj2T16O72KHlO3nNWML8SyWaN3S
	 w7wyXZeBKrlEp87NHpc4HMfehf5MbcQ5r8nzmGcHPCNNydQhnItOSGJ7nlvtnPNeZ6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743435;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=MNs77XB1gO7MHnyVDh7EcyeKmZYXJ3x05ZADEeiZVj8=;
	b=heQtw14YZMifjGw2bpmttENRQAFJnQnK6NEmpYgtIF8yJ8OpfUwNp9tT/huItyKolCaq
	 pTfHkyHQzAVQHA2iz1ahhCD8y7t0+gvkG2a8yG6iJbleX4lfDsCGGfM0oM0ujU0TljNcl
	 zCrDwLOuGOFcO26WwB6iC4X8pUs6E/aXv26YSBnHJHq2Du3MiTr+pAt9IMI91B47SBikD
	 RW7oGOQHli3Yx39WcYVk6kTp/nam1wQ2vNamCfPLLq9MGN4/xWjS9hj/mOzwfhQ3ZoFj3
	 2OuZMfgSniqfC4Zgc26/c4I0a8XQ3dKuq2HD3HM/lXklvAYiVJo4aYw+1Hdjkeyj5aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jonasjelonek.de;
	spf=pass smtp.mailfrom=jonasjelonek.de;
	dkim=pass header.d=jonasjelonek.de header.i=jonas@jonasjelonek.de header.a=rsa-sha256 header.s=s1-ionos header.b=c1t1gR24;
	arc=none smtp.remote-ip=212.227.126.135
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0512F606EE85;
	Tue,  3 Nov 2026 22:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0512F606EE85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jonasjelonek.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonasjelonek.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jonasjelonek.de header.i=jonas@jonasjelonek.de header.a=rsa-sha256 header.s=s1-ionos header.b=c1t1gR24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jonasjelonek.de;
	s=s1-ionos; t=1793743406; x=1794348206; i=jonas@jonasjelonek.de;
	bh=MNs77XB1gO7MHnyVDh7EcyeKmZYXJ3x05ZADEeiZVj8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=c1t1gR24fra7fO4ZH16LzyU7AGIpTg+mYIUnVEUh7GWf4Vrwcxdg85HgsBIrcO8W
	 vu2vfVrCWWArC5jFksn2TbXHE34labHOfgSwjJ+PZBe3bEYegyge2maapCiBe7YYm
	 qV+6q9VGaUeqRiu1aK+3RruoWXtTs5x2ZrxCVfCJEb1k+WhFC7r9gPEsi2khrCSFU
	 7uh83AEay0ywAdOBEx0fsKrqfFCGbukzcj7qib0amfy01duivdqk9LsCJOS3Fh+gj
	 TcR+3KP+omAvKsEwUTzzqbIEevL/M7EvEbDvnwt8b8YeP/e+ZrV30Jn7mtgDwaE94
	 ZDVuGLBe9msykd9Y3A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue010
 [213.165.67.97]) with ESMTPSA (Nemesis) id 1MdvVu-1wpr7w065u-00kLqN; Tue, 03
 Nov 2026 23:03:26 +0100
From: Jonas Jelonek <jonas@jonasjelonek.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Sander Vanheule <sander@svanheule.net>,
	Russell Senior <russell@personaltelco.net>,
	Jonas Jelonek <jonas@jonasjelonek.de>
Subject: [PATCH net-next 4/4] net: pse-pd: realtek-pse-mcu: avoid global disable on teardown
Date: Tue,  3 Nov 2026 22:03:12 +0000
Message-ID: <20261103220312.860629-5-jonas@jonasjelonek.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103220312.860629-1-jonas@jonasjelonek.de>
References: <20261103220312.860629-1-jonas@jonasjelonek.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2Qaxf/N7A/9gAxneQmJW+WOZI1s5eF5+d4BM6K6Pxv2ok+280pF
 AJWAIWmUSW4EScr+V9LYG4PbZX+I58p3gpJFb61ebm/WIX2sQxXMzzyWR3Xuy0Nol6r3Pz/
 Hewc5H+mTlx3CZ/U0rHtlEtBueQxSLGjTO43x6NKK2m7Js5Dhmp8C6oqDdnnA6zaThynxJ+
 P+YVCVwgrYJenP5HVUxJg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C2C7kPxPW88=;JBdRaoGQvp+MuUaNssLKO57D1q+
 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
 QPb+boXAPoQF3u8P7m6jiJ6ef9Pyig==

The driver installs a global-disable cleanup action when it enables a
previously disabled MCU. Consequently, driver teardown stops all ports
only when the MCU was disabled at probe, making the behavior depend on
the initial firmware state.

Leave the MCU globally enabled on teardown so an independently powered
controller can continue autonomous delivery. This also allows persistent
supply constraints to keep the rail powered without an explicit global
disable command stopping the ports.
=2D--
 drivers/net/pse-pd/realtek-pse-mcu-core.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/net/pse-pd/realtek-pse-mcu-core.c b/drivers/net/pse-p=
d/realtek-pse-mcu-core.c
index a90e19fb90e0..ab57c348436c 100644
=2D-- a/drivers/net/pse-pd/realtek-pse-mcu-core.c
+++ b/drivers/net/pse-pd/realtek-pse-mcu-core.c
@@ -894,13 +894,6 @@ static void rtpse_mcu_cleanup_vmain(void *data)
 	regulator_disable(pse->vmain);
 }
=20
-static void rtpse_mcu_global_disable(void *data)
-{
-	struct rtpse_mcu_ctrl *pse =3D data;
-
-	rtpse_mcu_set_global_state(pse, false);
-}
-
 int rtpse_mcu_register(struct rtpse_mcu_ctrl *pse)
 {
 	const struct rtpse_mcu_match_data *match;
@@ -994,12 +987,6 @@ int rtpse_mcu_register(struct rtpse_mcu_ctrl *pse)
 		if (ret && ret !=3D -EOPNOTSUPP)
 			return dev_err_probe(pse->dev, ret,
 					     "failed to enable PSE system\n");
-		if (!ret) {
-			ret =3D devm_add_action_or_reset(pse->dev,
-						       rtpse_mcu_global_disable, pse);
-			if (ret)
-				return ret;
-		}
 	}
=20
 	/*
=2D-=20
2.53.0

