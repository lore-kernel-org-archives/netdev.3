Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA465208B8;
	Tue, 22 Sep 2026 23:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790119496; cv=none; b=aR0GlxxbEE8QOMKBdj8vjq3784XR5NnfUTrciRloBMqqN90yCi6azHmOw1s+BRpxt79TtncXwff6GaEBv/u0xngJHZB5WJ/om1MvmLIbWkaGJ31vjygrzs9qzF3lPCDxwOthajh+6GBwY2pfUd/P4Si32oxdtanRovT1McXG1jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790119496; c=relaxed/simple;
	bh=I9DnMq4KXhMFBvyFhpkMPTrKDNbKAXhlEmUo595ax54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QSlJ2bjubHJCOgWiLFfn4p4V3f0QuAzw++9NZQjlAH0Bp3hRWE/AtgtAkGHwZoqKavR6g9oncr02coOfQU6MrglBczKLS1MGHjci0mPKa584oogDQNIAANgdkFjLRxIFDSX2kisGG33byCxX3bZOJpFa/JbxyasofbyPZ3WhKQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bj4E8hae; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bj4E8hae"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id F2D1CC0000E6;
	Tue, 22 Sep 2026 16:24:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com F2D1CC0000E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790119486;
	bh=I9DnMq4KXhMFBvyFhpkMPTrKDNbKAXhlEmUo595ax54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bj4E8haeAA/VOiy6uAJbeqqbNWKKbZevs0ZOAyuIUDwgkqk3sYEmvWC1j3aGfbbhn
	 n5qdbyN5m0KSN3xZ0Qst3pbJAZfFKxW/+sP90Go+CpdnGEh2LY/VFYezCXStm674l5
	 90Dqj+H417xLWoBu5gSIpuAp44RCFXQ7K8cO2hu4=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id CCEBFB04;
	Tue, 22 Sep 2026 16:24:45 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zak Kemble <zakkemble@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Ryo Takakura <ryotkkr98@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 04/10] net: systemport: Fix Wake-on-LAN RXCHK filter enable loop
Date: Tue, 22 Sep 2026 16:24:34 -0700
Message-Id: <20260922232440.598918-5-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922232440.598918-1-florian.fainelli@broadcom.com>
References: <20260922232440.598918-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In bcm_sysport_suspend_to_wol(), the loop enabling programmed RXCHK
filters in RXCHK_CONTROL used an auxiliary counter 'i' instead of the
actual set filter index 'index'.

When non-contiguous filters were configured (for example, if filter 0
was deleted and filter 1 remained), the code would enable bit
(RXCHK_BRCM_TAG_MATCH_SHIFT + 0) corresponding to filter 0 rather than
filter 1, causing Wake-on-LAN filter matching to fail.

Fix this by using the filter 'index' to set the appropriate match bit
in RXCHK_CONTROL.

Fixes: bb9051a2b230 ("net: systemport: Add support for WAKE_FILTER")
Assisted-by: LLM
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index b91a57540f55..ec43aab11790 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2648,7 +2648,7 @@ static int bcm_sysport_suspend_to_wol(struct bcm_sysport_priv *priv)
 {
 	struct net_device *ndev = priv->netdev;
 	unsigned int timeout = 1000;
-	unsigned int index, i = 0;
+	unsigned int index;
 	u32 reg;
 
 	reg = umac_readl(priv, UMAC_MPD_CTRL);
@@ -2678,10 +2678,8 @@ static int bcm_sysport_suspend_to_wol(struct bcm_sysport_priv *priv)
 		reg = rxchk_readl(priv, RXCHK_CONTROL);
 		reg &= ~(RXCHK_BRCM_TAG_MATCH_MASK <<
 			 RXCHK_BRCM_TAG_MATCH_SHIFT);
-		for_each_set_bit(index, priv->filters, RXCHK_BRCM_TAG_MAX) {
-			reg |= BIT(RXCHK_BRCM_TAG_MATCH_SHIFT + i);
-			i++;
-		}
+		for_each_set_bit(index, priv->filters, RXCHK_BRCM_TAG_MAX)
+			reg |= BIT(RXCHK_BRCM_TAG_MATCH_SHIFT + index);
 		reg |= RXCHK_EN | RXCHK_BRCM_TAG_EN;
 		rxchk_writel(priv, reg, RXCHK_CONTROL);
 	}
-- 
2.34.1

