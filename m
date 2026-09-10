Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9472A3DB64B;
	Thu, 10 Sep 2026 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053284; cv=none; b=dLDNMfGOacSuKwldVKujwiAg4u/xuPHUZKyeXH9MVcKc32u1vdT0IIgCsoG0cEm4nDZoV4ESD9kDsDC9thVuayKAstQbUXvMeJo2ws07JnELWkcL948qKZvt2J1gt4L9W1IKADhCtVmn0c74NVHdXHKZVJ1qfYexwaRKCXezI9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053284; c=relaxed/simple;
	bh=7irgMhQW8nbeyXZU6usCEDkPlfO/injFYuJXGlD5y5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPR3j2VB+lwhS27ivtv5j4P/l12aSN5tA7uTAUfb/AWOFXvN+5s7QWU5s71DfUoat58L3pDnRKhxaiLVWjSwxh5ed/cj74c4H6kmn2B7+gVp+HLX7+lIyaddU9L7Vl3UuFmSgDSZcbM9M1HT/WVUIRvJpgI0qLBjp4oYWspeAUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wdmkJ7TA; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wdmkJ7TA"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D4D65C653E5;
	Thu, 10 Sep 2026 15:15:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7780F5FA2F;
	Thu, 10 Sep 2026 15:14:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CCF1911C7A1A1;
	Thu, 10 Sep 2026 17:14:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789053269; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=RJfocTlOORaTvso6KmauJUuwxsbukatHXvhE99wz6ZY=;
	b=wdmkJ7TABqdAPMZvI3gElyweW7LxwfsN66SDIEA2qqXYxSWISPi9gqcSIYSnXTU9rxPQWw
	Ggrr0eNbZ7nL5X3Umpmz2x3lHQx4Zo03Q0oZYj4BAGomF78MCR6LZ4B83jXDlOlGsU1UsV
	8qx3SwKjXZYaeDgrPC1CA9tePAVPK0NBQe1ZkpH9TT1gCMFutVFyHo6V4H9rjugzlogsCv
	kBov8hIMzCByaqtURR0cQ9IyUHD6cdnQNljxHI7InCbSl0MPfiD7cmFFY0rH2zl3jype0V
	DvDRYOQaAYTGE2w0brMqntIdvVnk/Pz5T5o8xNlwnT9KgsrGi2qe6ASjb4cwWQ==
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
Subject: [PATCH net v2 3/6] net: stmmac: selftests: Check the dev->features for S-TAG offload testing
Date: Thu, 10 Sep 2026 17:14:00 +0200
Message-ID: <20260910151404.976753-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910151404.976753-1-maxime.chevallier@bootlin.com>
References: <20260910151404.976753-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The S-TAG offload insertion incorrectly checks the dvlan (double vlan)
DMA cap, which is different than S-TAG support. Use
NETIF_F_HW_VLAN_STAG_TX to check if the feature is supported instead.

Note that this flag isn't set in stmmac yet, but contrary to ARP
offload, this is a feature that has a chance to get there eventually so
let's leave the selftest here for now. It'll report -EOPNOTSUPP in the
meantime.

Fixes: 091810dbded9 ("net: stmmac: Introduce selftests support")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index a8280834185c..f3a533bc6bb6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -1405,7 +1405,7 @@ static int stmmac_test_vlanoff(struct stmmac_priv *priv)
 
 static int stmmac_test_svlanoff(struct stmmac_priv *priv)
 {
-	if (!priv->dma_cap.dvlan)
+	if (!(priv->dev->features & NETIF_F_HW_VLAN_STAG_TX))
 		return -EOPNOTSUPP;
 	return stmmac_test_vlanoff_common(priv, true);
 }
-- 
2.55.0

