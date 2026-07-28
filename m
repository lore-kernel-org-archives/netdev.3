Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220B5331A63
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254277; cv=none; b=DuDJ3fk9m+9T7jL30+PNBMmToVBs8pwKekRQ9W9+m4geu44H03hyEb5lA/TR+cIbcIuOKXsxlBIl1m4ks9skx5222dDHXUWztgHpLjprJbijiqKan635PRGMo1Af+ZIg/uHCEUXxT4uFO/86QuN9xMEjBygxltjC26sCia8QwuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254277; c=relaxed/simple;
	bh=QUvjfnQYs2xlkJPApgkbEtxxk6sY33cpH9PZ67RUmGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nU70Lz28puv7wXHaUyZpp9y0DpcEaVtFM/TanSM09tU004Uay9JNwO7lx+85QEpExP03jE8NLfW2LdqcI9SLUIBriN9QwrvqG0JpFv3I4CSAJ0W9QTAXq+K25t6KPwG9Cf0ByfWVaX9Ff4ZUIhQ7Jk3wynx3Awu0Ihh7B0Idv5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Hu9xi964; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Hu9xi964"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9CD454E40FB1;
	Tue, 28 Jul 2026 15:57:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 70953601BF;
	Tue, 28 Jul 2026 15:57:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC7BB11C142E5;
	Tue, 28 Jul 2026 17:57:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785254269; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=jyQcQVEYc4YcgbrTjUYsZd7Ll8XlgXUrnGVBuSQPQao=;
	b=Hu9xi964mhyQM3RUVCc6uZl+A+ASS5/KkYbL8xFs7PqJuzs6WCNbfiS72oaMnTUBDdgh1R
	exBLVJNF92OnVWvK37jeyQpR0bmRfDEutzJlLmkNRRw2QwnG5MVlYBRm649WR6hpzVBf/Z
	72k9BaafvbJKoL2VPPXKdt49y9KJ1HTBKPaPEFTbe0U0bn6jfvjCRnOnj1ps7WQfklH7/g
	Sd3dL67DTjte/jQUz2veH0Zzh3nhiuyg+O7mziJIeccJIh+m6BQjBQTMsScPKNcF4EY20G
	L85RLwyXHiWogUR2/22L9AjoWKdDDcjsQrtk213+eMRu/VJ8xddwx93C+BFJ0g==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Zxyan Zhu <zxyan0222@gmail.com>,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next 2/2] net: stmmac: Don't rely on the PHY for flow-control testing
Date: Tue, 28 Jul 2026 17:57:27 +0200
Message-ID: <20260728155728.1193169-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728155728.1193169-1-maxime.chevallier@bootlin.com>
References: <20260728155728.1193169-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

For flow-control testing in loopback mode, we don't need to ask what the
PHY is currently using as pause/asym settings. The PHY is no longer
involved in selftest, we rely strictly on MAC loopback. We therefore
only need to know if the MAC supports Symmetric pause for the test, as
we exercise both TX and RX pause support in the selftest.

Remove phydev requirement for flowcontrol selftest as well as the
AsymPause requirement.

With that, we can also drop the linux/phy.h include.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index c0e5dee86451..1df26c217f9a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -11,7 +11,6 @@
 #include <linux/crc32.h>
 #include <linux/ethtool.h>
 #include <linux/ip.h>
-#include <linux/phy.h>
 #include <linux/udp.h>
 #include <net/pkt_cls.h>
 #include <net/pkt_sched.h>
@@ -716,13 +715,13 @@ static int stmmac_test_flowctrl_validate(struct sk_buff *skb,
 static int stmmac_test_flowctrl(struct stmmac_priv *priv)
 {
 	unsigned char paddr[ETH_ALEN] = {0x01, 0x80, 0xC2, 0x00, 0x00, 0x01};
-	struct phy_device *phydev = priv->dev->phydev;
 	u32 rx_cnt = priv->plat->rx_queues_to_use;
+	struct mac_device_info *mac = priv->hw;
 	struct stmmac_test_priv *tpriv;
 	unsigned int pkt_count;
 	int i, ret = 0;
 
-	if (!phydev || (!phydev->pause && !phydev->asym_pause))
+	if (!(mac->link.caps & MAC_SYM_PAUSE))
 		return -EOPNOTSUPP;
 
 	tpriv = kzalloc_obj(*tpriv);
-- 
2.55.0

