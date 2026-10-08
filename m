Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AD239B4A5
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 02:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791426527; cv=none; b=CwC0TnyEOK5bNRg9hYBLXFNi1cKFwXq0ip4sjRU2+QJ3yybt1chDY6IWk9aXzy99JQ9VG9rLyn8Ox1yetwRTA55HJ1GU6xOPoBMDtvzO6a2Y6IO5HiDYMAaBv6Jtq16k8LHsykK3IHUNZ07fTxV71I9odpw4JDyWRUwd+iJE++A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791426527; c=relaxed/simple;
	bh=+qqYMONCE9zfOaSUDVMRLMJoba1FPx7keJ8McEB6vg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLNvdT7sWgPQU3nFgMsSXlD8qvbeis8Qr+TEbuvfHPz0ODfZahMqVB43ZX8C37fZu2eHPdWd/LKSL5KFIzqZYKdPAvsSVt1DQfdDTkLY+xWwviuuk8FLu2USnVw/2MkjXIlooeIXZ+LLriFgDA0v3eDwgE3dLzrUWS2mUYL6i2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bf4LQfwi; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bf4LQfwi"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e4c080a472so22394445ad.3
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 19:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791426525; x=1792031325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fG18jr14L6KnLKy695S6jSOcJe/N8x7hOQ//xht6kkk=;
        b=bf4LQfwidkS1+pTLIX5gKW+zRTPfvbcyL3bj5gZhxOQkqRF0/NFTWN15xf2SqT4m3G
         ZHzjM1p9nbbV0gXk2E05dQyVsDHoJFZJy+JDMCs+FsZjD6o8k1PRV5w2IcmAtRBHd8jy
         K26ll00fDUFS0bQwKSegVcZKlZrTSZTNIi0wiyWHfkkXYti27S5Mo0yLqEywDupfI/qw
         RWdeB22NIUmZBlJTgLkebavJASu1Dz1nLSQP2cIONBG9Y77VoTGgmKRdpxPXkJnIjYSF
         Fgf26y8xYdBF8XF6cuc0d92LrlJrGk3HFGcptSXYfqe/K+jP4/g1O+/v+SJWpDDXBtw1
         Wu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791426525; x=1792031325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fG18jr14L6KnLKy695S6jSOcJe/N8x7hOQ//xht6kkk=;
        b=VJ0rqg2C6456++OwVwbc2Gtfu4xCs+ck6HIUt47sTkVUqmMLWIB6KnubQqVOYgopkb
         XohzeFaBwfqIyiI/B76g/VYsHv3tqdyqtEhg8WuniDoZ6x+VOb+hyJ0Kr5fiYLJzcC+A
         Z+pEX4hvPfE6WhKGLhymaTWX3dAB2JOLnAsWXSrfO8kFN2cd+hA8TWn6BeqjDkedfmtg
         IDl3i7EDpUc5jsesOV8qDw2beoi8dQ4XeO+A33JSiz62YK9unKdoWhNNQJ6MIOhHLv7D
         JtNF9gmY5eKJ6U9EnEGlE7D5yyRd/n59PxnP3qpx1HnuCXXw1GBZyul/n19ED7v7CNqx
         svyA==
X-Gm-Message-State: AFq9FYL/kaOHmxqeIWM7gZABKl1j2FlDH9YLpGmK6b6OdKeYDWIhOzei
	+y7QCkg2qyN5jn5Cm9vbFP4au5sks0V02NN4F6rNJSKnVoxZuhlbx74No8eTghiU
X-Gm-Gg: AYBFou1d59Tc3yWTjkRmReRydZZnl1WUukgiT6e0t9sMseJueJIc4TgyCQhg9y7vVQB
	pQJrkDOC87yp78lg2MP0EdI4fmxlXEGvU6TX2oihQDEEnTudgjyvkDIo2zc2L+KAEoRMQQLRZfD
	hO4R2puHcpNllMDZJcncEFYNyEE3LA+JiI/5zqVF0ELlwluB/OM6WwLlD4MVOiICYz6tpRJ5poh
	vk4Ml5zjY6+l9Dgf3QSz8tJKkKoq7hFg1THTOXNU3uJltHC0/R9XkkpWOQud/XEs8bUkkpDzVPM
	9FTjVQ4uqaj9fpHN43+fhN22r2z8IEZsnvoUyaHnIqy7R5LBbyJXPUTBGcVibNRC4XSlJkUYXuM
	dBql+NQBY46Vev+TD30FII88025wwZxlPaAbc6uCfzx3XWzZTUcvB1s215yMWHiOkgnJwkeLsGr
	zgLB9iQJ3/+AqlbHONAMGpnezR8ck+PEfsN7R5iVEHoHjR72xcx8n9/tV3XOlcMpHZHhZeAkpKa
	vNzwE/Tdp8par2UEMS2OJoTQx8=
X-Received: by 2002:a17:903:2b0b:b0:2dd:ad73:c93e with SMTP id d9443c01a7336-2e6003c0633mr35463525ad.31.1791426524768;
        Wed, 07 Oct 2026 19:28:44 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661c:1246::1d2:d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e60482cab0sm18045865ad.50.2026.10.07.19.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 19:28:44 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 01/10] net: hisilicon: hisi_femac: Move setting of netops to fix crash
Date: Thu,  8 Oct 2026 10:26:43 +0800
Message-ID: <20261008022656.3592191-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008022656.3592191-1-mmyangfl@gmail.com>
References: <20261008022656.3592191-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hisi_femac_drv_probe() connects the PHY before dev->netdev_ops is
assigned. phy_attach_direct() -> phy_link_topo_add_phy() reads
dev->netdev_ops through netdev_need_ops_lock() since the commit in
question, so probing crashes with a NULL pointer dereference when
CONFIG_NET_SHAPER is enabled.

  phy_link_topo_add_phy from phy_attach_direct+0xec/0x37c
  of_phy_get_and_connect from hisi_femac_drv_probe+0x1f4/0x558
  Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Assign netdev_ops before the PHY attach, as was done for emac in commit
7c9f391ec89c ("net: emac: move setting of netops to fix crash").

Fixes: ded86da4bbb7 ("net: ethtool: relax ethnl_req_get_phydev() locking assertion")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/ethernet/hisilicon/hisi_femac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
index d244a40df430..016605e86f0b 100644
--- a/drivers/net/ethernet/hisilicon/hisi_femac.c
+++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
@@ -830,6 +830,8 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
 		hisi_femac_phy_reset(priv);
 	}
 
+	ndev->netdev_ops = &hisi_femac_netdev_ops;
+
 	phy = of_phy_get_and_connect(ndev, node, hisi_femac_adjust_link);
 	if (!phy) {
 		dev_err(dev, "connect to PHY failed!\n");
@@ -850,7 +852,6 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
 
 	ndev->watchdog_timeo = 6 * HZ;
 	ndev->priv_flags |= IFF_UNICAST_FLT;
-	ndev->netdev_ops = &hisi_femac_netdev_ops;
 	ndev->ethtool_ops = &hisi_femac_ethtools_ops;
 	netif_napi_add_weight(ndev, &priv->napi, hisi_femac_poll,
 			      FEMAC_POLL_WEIGHT);
-- 
2.53.0

