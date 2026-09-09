Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8EA3B993F
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 07:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940093; cv=none; b=qPqyf/vUa5MSupsQESv7PLerh9VQSZN1wgjHGIKKIZYHP87BMOXH7lbPqEBgkk2ToxmSTzWBqj5JQxQ5VPJ44V2xK+LAbaGucdE4B7vjb0X08r8nY5jshVXZtprqctT+XynZqD+BxV/qse5m3uoKlAuwNDrOLwXd3/IYShJoAm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940093; c=relaxed/simple;
	bh=BZSPIrfpYBvDJa/81myfB8Q/UIYojiYT1h8F3rQo6ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FG5HUiTEhTDGNrpcdpBSuLhmfGL9Jy4j9OGqWbGDBB7odLkxJ6oJ3v7cVpTfAxKZbUc/+NCzPMZKtsGHwXsJLI3/+F8+ud16CLLI8yDHrTCfe7RAAEhUYHsEy2ec8ytWXNEKbdot62ZoxrdoYpB+v5UvjhG47QAwzTluQS2hTq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ktAQLDdU; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ktAQLDdU"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6CFDD4E415AD;
	Wed,  9 Sep 2026 07:48:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3FA7D60448;
	Wed,  9 Sep 2026 07:48:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D0CAC11C7AF4A;
	Wed,  9 Sep 2026 09:48:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788940087; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=c6kUTHk78nbNRfrPLKr56xuntYhc0yFu2mYMyjJtdrY=;
	b=ktAQLDdUwzbrjOIpXUOQwuriy/NtC+yEE03WivjPpzvzpne5SLLZhC2TqRDPMY/3CbwgKw
	ZpLtW0xzzqqJLoH8gDNlPReIyfSjQUIRo952yCs+ZYaVOoq4Ra8tnN6oJKpFKTK83n1GYc
	TtfS1Sd3IrbkekQ8G6V2wJ5WRuVOW4akkQBp1sBumCHr0QyoCyjShprwnJsI8+2Ngsjc2i
	GYoSON0PgyBXIOndmAnyPUrXfNkjMWHr2Dw9y2FtrZzMqpw1m4Nn6CfOcpr1yhnF9bypWN
	LgnQ2wJuN8Lh1BeGXFHMFHz/M9crXBg6vIrkg9BBy9UVV5X0X7u8rBknxpBjsA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Minda Chen <minda.chen@starfivetech.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Jose.Abreu@synopsys.com
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	PKneuper@dspace.de,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net 4/6] net: stmmac: selftests: Capture all packets for vlan checks
Date: Wed,  9 Sep 2026 09:47:37 +0200
Message-ID: <20260909074740.1247762-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909074740.1247762-1-maxime.chevallier@bootlin.com>
References: <20260909074740.1247762-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

While we use vlan_vid_add to trigger the tag filtering machinery
in the driver, there's no netdev associated to the VLAN. This causes the
skb to arrive with empty skb->vlan_tci fields, as the packet is marked
OTHERHOST in __netif_receive_skb_core(), and we fail our validation.

Let's use the proxy mechanism introduced for DSA, that registers a
ETH_P_ALL packet handler that runs earlier, before the vlan netdev
lookup, then filters for the correct ethertype before passing an skb
clone to our validation function.

Fixes: 091810dbded9 ("net: stmmac: Introduce selftests support")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index af480cdf2172..2fc0badb65a7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -241,6 +241,7 @@ struct stmmac_test_priv {
 	__be16 packet_type;
 	int (*func)(struct sk_buff *skb, struct net_device *ndev,
 		    struct packet_type *pt, struct net_device *orig_ndev);
+	bool capture_all;
 	int double_vlan;
 	int vlan_id;
 	int ok;
@@ -343,7 +344,7 @@ static void stmmac_sft_add_pack(struct packet_type *pt)
 {
 	struct stmmac_test_priv *tpriv = pt->af_packet_priv;
 
-	if (netdev_uses_dsa(tpriv->pt.dev)) {
+	if (netdev_uses_dsa(tpriv->pt.dev) || tpriv->capture_all) {
 		tpriv->packet_type = tpriv->pt.type;
 		tpriv->func = tpriv->pt.func;
 
@@ -986,6 +987,7 @@ static int __stmmac_test_vlanfilt(struct stmmac_priv *priv)
 	tpriv->pt.dev = priv->dev;
 	tpriv->pt.af_packet_priv = tpriv;
 	tpriv->packet = &attr;
+	tpriv->capture_all = true;
 
 	/*
 	 * As we use HASH filtering, false positives may appear. This is a
@@ -1080,6 +1082,7 @@ static int __stmmac_test_dvlanfilt(struct stmmac_priv *priv)
 	tpriv->pt.dev = priv->dev;
 	tpriv->pt.af_packet_priv = tpriv;
 	tpriv->packet = &attr;
+	tpriv->capture_all = true;
 
 	/*
 	 * As we use HASH filtering, false positives may appear. This is a
@@ -1358,6 +1361,7 @@ static int stmmac_test_vlanoff_common(struct stmmac_priv *priv, bool svlan)
 	tpriv->pt.af_packet_priv = tpriv;
 	tpriv->packet = &attr;
 	tpriv->vlan_id = 0x123;
+	tpriv->capture_all = true;
 	stmmac_sft_add_pack(&tpriv->pt);
 
 	ret = vlan_vid_add(priv->dev, htons(proto), tpriv->vlan_id);
-- 
2.55.0

