Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8904D7D24
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790951313; cv=none; b=abX+RUmDyf+vJQYtjdzVmFH6wFANCo2gUvcXxcp82fRGlF606kD8ony0LW4AEE232g8xKenpUZt1qBfCmhDZdM19er+Q/5SbCxVRuOa6SR0k+6C/BiUL8Ng/J88Im6fFd0URwIz/IERR73ZP2U0QX0cHPh8olTEF6DwmRs275Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790951313; c=relaxed/simple;
	bh=seoW2wQkE/n9FWjrNs1CXg6dkQZuyCfg7ovOxgQwOyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vdyh4q4lnpuajnnCauq6vF70yEbp7fNlXNeJUAHAHqHGPNJl5lWzeC0fsxBAjUGpOSurH9qAeweR1VogliWHEuL+fh0irfLr2ZPB9oK9CbhLFg3+nJlQven4eJ/rcULjn7ONNNWnGwIRehd80gJcWfi/7T8zbhji+C6DioT3Q58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uhePkbQp; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uhePkbQp"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A0E8F4E4110E;
	Fri,  2 Oct 2026 14:28:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 75730603DC;
	Fri,  2 Oct 2026 14:28:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3EABC103281DB;
	Fri,  2 Oct 2026 16:28:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790951309; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=dP1eeIRdgAKrNInxQcJ7Mw+F+kiwB9f8L/y86StvccQ=;
	b=uhePkbQpdN5JkCW9kBo+watSBdXekjsklNW4QG0QPPUfyemg54kHCyI56uuSl3vcKzFXUq
	LMafXsTShZpKv0tCv1TGGY5H7dFZ1ylU7kZLbz170BUFWdbu42UBZ1uXFU5tBDgFPYEvsh
	j8SouckInuHxpI875eR1fb6t7Elt/vUN1vuEUedNVm/EEQkqO8VemFqi5Gbk7l8yZJcgSX
	qZ4jzQPSWTFS5tIWGRUwe4+tq2XoSQXQzR182Yqugl8dHkRl2tDBKWuy3v+38nqINQkxLl
	qY88wNUaf2RH94zn/6YG3PXx5OCl0fRInZ38qlunSDfC7Pg1/UE2Nnd9WmhiUg==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Peter Robinson <pbrobinson@gmail.com>,
	Joe Damato <joe@dama.to>
Subject: [PATCH net-next v3 3/3] net: stmmac: Don't set or get RSS parameters when not supported
Date: Fri,  2 Oct 2026 16:28:03 +0200
Message-ID: <20261002142806.1299041-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002142806.1299041-1-maxime.chevallier@bootlin.com>
References: <20261002142806.1299041-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The RSS kselftests fail on stmmac, and this is partly due to the driver
reporting bogus data for the RSS ops :

 - ethtool -x reports an indirection table and a key while the hardware
   doesn't have any of that
 - ethtool -X fails with -EINVAL.

Return a 0 indir size and key size when rss isn't supported, effectively
meaning we don't support RSS here.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 1cf0f8820b33..7f2a70575b83 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -927,6 +927,9 @@ static u32 stmmac_get_rxfh_key_size(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	if (!stmmac_rss_is_supported(priv))
+		return 0;
+
 	return sizeof(priv->rss.key);
 }
 
@@ -934,6 +937,9 @@ static u32 stmmac_get_rxfh_indir_size(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	if (!stmmac_rss_is_supported(priv))
+		return 0;
+
 	return ARRAY_SIZE(priv->rss.table);
 }
 
-- 
2.55.0

