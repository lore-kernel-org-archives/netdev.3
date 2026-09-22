Received: from relay.smtp-ext.broadcom.com (lpdvsmtp10.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEDE530DE5;
	Tue, 22 Sep 2026 23:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790119496; cv=none; b=RQo8jeutcLIFAlia5lhWCFm4bKLs/O4sFA2DaAbyvgaT7BEzeSpThAi2i6F5IgUNqEEO32kcdXp93VSiUJLNslgTipdv2SuH5ezsTPocqwvp5Kr4mmUcFCIBozss7jkPWoM/9wyR4TbV3QnRVh7LZnZHpSZNhXSSIpcKgIAdfbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790119496; c=relaxed/simple;
	bh=bm/1Aco6j6KmpyDyBLhfXutg8/2FgYUIjwXbzNyGLTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hN2rLHdsbpRcC//9j3F915vPMh6tyV+PNq5Qf8oX4ZQYjtI7z2f5xSn9Q4WEa3DZqJN8NFHqVvvOQI8o5EWXmcbgMtWXzKXLZlAYWvPJMshiI80OZkN4Fe14y8wuWn17azYC06o5sRgkKRdx+IpW0NY5qYEODdgZa7sNyMjv1rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YO68lDUb; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YO68lDUb"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id DE009C0003C8;
	Tue, 22 Sep 2026 16:24:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com DE009C0003C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790119486;
	bh=bm/1Aco6j6KmpyDyBLhfXutg8/2FgYUIjwXbzNyGLTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YO68lDUbZulhdG0x0oCzUkDsYRoRbQW1yfjN9uR2a/1PhpICR/92/i1a9BLcROOhb
	 l/jElm2UY+4wEzYeyZJ8Dvwjjvp+4IBxt96HTbzSPCCjfteJymc0PFpk8WXXzTSRFB
	 f5a/vhODsuwRqRdqipd0KfpP/TFOhUrcO9NegoQ0=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 86824ACC;
	Tue, 22 Sep 2026 16:24:46 -0700 (PDT)
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
Subject: [PATCH net v2 08/10] net: systemport: Fix inverted error messages in bcm_sysport_stop()
Date: Tue, 22 Sep 2026 16:24:38 -0700
Message-Id: <20260922232440.598918-9-florian.fainelli@broadcom.com>
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

In bcm_sysport_stop(), the error messages printed when tdma_enable_set()
and rdma_enable_set() time out were inverted: the failure of
tdma_enable_set() logged 'timeout disabling RDMA' and the failure of
rdma_enable_set() logged 'timeout disabling TDMA'.

Swap the error messages so they correctly describe the failing engine.

Fixes: 80105befdb4b ("net: systemport: add Broadcom SYSTEMPORT Ethernet MAC driver")
Assisted-by: LLM
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 4efcefd33b78..11b2cb4cc792 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2089,7 +2089,7 @@ static int bcm_sysport_stop(struct net_device *dev)
 
 	ret = tdma_enable_set(priv, 0);
 	if (ret) {
-		netdev_err(dev, "timeout disabling RDMA\n");
+		netdev_err(dev, "timeout disabling TDMA\n");
 		return ret;
 	}
 
@@ -2098,7 +2098,7 @@ static int bcm_sysport_stop(struct net_device *dev)
 
 	ret = rdma_enable_set(priv, 0);
 	if (ret) {
-		netdev_err(dev, "timeout disabling TDMA\n");
+		netdev_err(dev, "timeout disabling RDMA\n");
 		return ret;
 	}
 
-- 
2.34.1

