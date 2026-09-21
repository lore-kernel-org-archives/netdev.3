Received: from relay.smtp-ext.broadcom.com (lpdvsmtp12.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA4C425CD2;
	Mon, 21 Sep 2026 23:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032476; cv=none; b=H5JF+HTZ27vv0BJjd3gV+vtM899cbKgTJ+L/MAWCTJJ22Hpggbb6ZrZq+HjtUJ8jnnOn+3BuDvGAgBbwVo5GbRAt102rBNWoy1wkTH5xUisERrbris1RtQnypddDrjqAXfDjiNwW/4gznIJvDQFr7MYtKpJeTBIUHumEWnuhWE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032476; c=relaxed/simple;
	bh=d1baMmvN6EUkR/FHwY6K4p5Nu6ow44Fl2QIjowV6JqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YoyFLbUQVu/HHoW4g7r6VGVCdTjaSQNVjCKJBAxPoxbAkaH1pspaAKT8JGm1nNo8JSHtSiEDBlxoqZT0pd9NiDr7MnWbMK8VWajd5AW01NMq56YvXDBqHWw5gLOczX5dKGZdirsz6hxI8yqZBtGNgbaSQJvoXO8X32yGCkolkJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WigRtIQY; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WigRtIQY"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 175EEC0000EA;
	Mon, 21 Sep 2026 16:14:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 175EEC0000EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790032474;
	bh=d1baMmvN6EUkR/FHwY6K4p5Nu6ow44Fl2QIjowV6JqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WigRtIQYKSFirlHokq4qpw9mB5NTifQReoUwDOn2CKBSohVvdIlkl2M+zN7Qe17+Y
	 zCz6aSsQEvmWLM+xyGJTzm97I86gGMyim8XpC957XYvrmkYMg/qMkVqTMB8geYicGQ
	 DqYjXUGVpeaai08cplLR3jcIrWrduvOFwIE40+7M=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id AC15EACC;
	Mon, 21 Sep 2026 16:14:33 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
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
	linux-kernel@vger.kernel.org (open list),
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net 09/12] net: systemport: Fix inverted error messages in bcm_sysport_stop()
Date: Mon, 21 Sep 2026 16:13:02 -0700
Message-Id: <20260921231305.394773-10-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921231305.394773-1-florian.fainelli@broadcom.com>
References: <20260921231305.394773-1-florian.fainelli@broadcom.com>
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
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 130545cce045..384423b312ca 100644
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

