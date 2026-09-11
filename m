Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ED84A4EE7
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 21:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161685; cv=none; b=NZrtsGMFVwlE+LG47N5hgaXZWXp7LazIGjgtI50fqHFe7Uahefs+VCGUOvKBN7P1rEQbv1Edl1V47a80PIaW8y0UJ1FS4FHpAUg8mmNaPdZD+u6YqReSUJAyjCOpNj57OwRjxPBgTem5A1sVm+wf3PFdPvzwTn1/D+Ekb0PGDRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161685; c=relaxed/simple;
	bh=BbZqd0Qnr74HmN1tX6QWLPCZq5rjnQo6pnfDmQMB6xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJ7UzXkukQwEdlGp4hqzHHo1miWKOmSG7o2uCbb0o+wWelm8LLSdXymw4kovcWE4GSJDcrkP5nVnsX1zN1z+SWk4BcAsh+a3ZW64VeaC5wvQhqdzDb3Tsdc7A+Ogn1Kp7VZHR3Sso9lkcXKVJnex3OOq1cvBsvilbvsNrMzE1p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ePWEwFFT; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ePWEwFFT"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 229894E4026D;
	Fri, 11 Sep 2026 21:21:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E8C9C601A3;
	Fri, 11 Sep 2026 21:21:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F3B7411C7AFAD;
	Fri, 11 Sep 2026 23:21:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789161676; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=cMhOLV8x7K+5uAmBeY6FYmcfS4Vx9S3mVbL6AGPu8ls=;
	b=ePWEwFFTNii0zDNob4nHk76iDASYPFvtKkt+ZgZiftVd+bKyTsl+Lt+m5j3JL7niqoDNwO
	rdacsgH2yQ1T/TY7c6x2ygFV/HcsDGHlJh58Ps/yr0YHk+y2KEGPytokYMMSw4z33eFF8K
	HJthTHf+jPI59I/egmv5KTAvv/kBblOQSgsQhvPEDzpJQFNCA9WztE3wdTjh9DN1Rx6/LV
	/nZ8wMEn+qdtVHzllWFHgH1EgiwouFG0LfMULv4mNQ0DvVYs0b1SCSUVrzCm4TCLxHYCbU
	haLbUrpUoIyWJ2mVzm8GN/y+CI3ORZE6osiVyHNoeivX5W0ABNJMjgEE9jErXw==
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
	Jose.Abreu@synopsys.com,
	Nicolai Buchwitz <nb@tipi-net.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	PKneuper@dspace.de,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net v3 4/6] net: stmmac: selftests: Capture all packets for vlan checks
Date: Fri, 11 Sep 2026 23:20:24 +0200
Message-ID: <20260911212028.1497613-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911212028.1497613-1-maxime.chevallier@bootlin.com>
References: <20260911212028.1497613-1-maxime.chevallier@bootlin.com>
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
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index 7f5837d1fed9..315c3cf82230 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -242,6 +242,7 @@ struct stmmac_test_priv {
 	__be16 packet_type;
 	int (*func)(struct sk_buff *skb, struct net_device *ndev,
 		    struct packet_type *pt, struct net_device *orig_ndev);
+	bool capture_all;
 	int double_vlan;
 	int vlan_id;
 	int ok;
@@ -344,7 +345,7 @@ static void stmmac_sft_add_pack(struct packet_type *pt)
 {
 	struct stmmac_test_priv *tpriv = pt->af_packet_priv;
 
-	if (netdev_uses_dsa(tpriv->pt.dev)) {
+	if (netdev_uses_dsa(tpriv->pt.dev) || tpriv->capture_all) {
 		tpriv->packet_type = tpriv->pt.type;
 		tpriv->func = tpriv->pt.func;
 
@@ -999,6 +1000,7 @@ static int __stmmac_test_vlanfilt(struct stmmac_priv *priv)
 	tpriv->pt.dev = priv->dev;
 	tpriv->pt.af_packet_priv = tpriv;
 	tpriv->packet = &attr;
+	tpriv->capture_all = true;
 
 	/*
 	 * As we use HASH filtering, false positives may appear. This is a
@@ -1093,6 +1095,7 @@ static int __stmmac_test_dvlanfilt(struct stmmac_priv *priv)
 	tpriv->pt.dev = priv->dev;
 	tpriv->pt.af_packet_priv = tpriv;
 	tpriv->packet = &attr;
+	tpriv->capture_all = true;
 
 	/*
 	 * As we use HASH filtering, false positives may appear. This is a
@@ -1371,6 +1374,7 @@ static int stmmac_test_vlanoff_common(struct stmmac_priv *priv, bool svlan)
 	tpriv->pt.af_packet_priv = tpriv;
 	tpriv->packet = &attr;
 	tpriv->vlan_id = 0x123;
+	tpriv->capture_all = true;
 	stmmac_sft_add_pack(&tpriv->pt);
 
 	ret = vlan_vid_add(priv->dev, htons(proto), tpriv->vlan_id);
-- 
2.55.0

