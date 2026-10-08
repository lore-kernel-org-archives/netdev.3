Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6441722A4F1
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 02:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791426531; cv=none; b=IDZDRrKPzJtGBTn91cunpYKG3G/KegSU6wZy6xEo/v68FDRmCkdJ1GmtbFW+UWOKr39BKtun2GznMb95KiMgDsQzcgs+pQA6qvkSR+G4h7xm4LjlAfjPbIGYAOaCWfmb1ytXQgGak9GwS55WQtL+eNfcpQBPTAsqH4XYRudQGgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791426531; c=relaxed/simple;
	bh=QYkHG9dkoU5pZlnkpLQ1PMrqT2VPenrzpLOqtah5yes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njcySq/IvVod6GXoxT4BrpjubEIxJqqNfv4YVggywjXENVEX+rH8NA5H858YgVBOBdmKDw3bS6fNy5XwDDino45R0yvjqnPzdJaT+SXG+dpg9r1QIgxrYZjTJlybNy1Xvhe0FS36pLcG+qYTZBR3J7QSCJQLOvsKz8J+u3nk8CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuBcZESv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuBcZESv"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2df8c28a0b1so15923425ad.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 19:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791426530; x=1792031330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sgbvJkFB0HqBTzA3hsSyDK8m6vIymZThQTGkU/au7RE=;
        b=iuBcZESvR0nIsgtPCRqg3fFVM3U5/nsCyiagEwCMD/AvHWWlWVzn45owwj7vUAEKsm
         c0+3T+WnAKxxtTjjkxQcCRPBM3qCsR2fLMB9YPHQugqaNPcXTPNk+vfCtdLYX7j4Ew5B
         dCizbgbhaf9sChQDTL0dSlr6Iz74s3EDBa3v7tVVvJ6+qasQNhMlS351WdtA1o8Zemt/
         UaOqYVlfq6wKsImmohN3PxuqnlaRpW0c2rb0ztX5ALMio8S6VlXI+BZQeXbwyOcIPjLf
         1ax30L0njiQcYOHckiIs+kQ5LtY99tmenLuOe3/lFu7+E546R5kqmkSQi8GpTbrku5ja
         b2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791426530; x=1792031330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sgbvJkFB0HqBTzA3hsSyDK8m6vIymZThQTGkU/au7RE=;
        b=fFe9M3TU5c6hK87R5xrhn9SSa1U7yNTmMIqq2KrD0HQObgikeZLa9ZEElILFYKhNzL
         NWXcRo31maciyx/0Uc5vFAfk/fvqOMMSIG03yoTwv0Jze1p7VQSAxsfXY3Lv3TVax+aG
         CQfG4hunDQb6FQZzP7FVTKaWPS6j7teOKHq+kMRqXLezSuxx/P+8qVpvmLiC+YBI1LDn
         /mNeTQfEmFyMeyq6/yrHKP5YcsBkxkJJjtnBk6v1k27TbpUHZUD0RdrgVJ6LCBNm5Ilg
         QBKH3uqZNmH0q3qTFfmtww6B+joTC1jgE0F2WhR68Vc9FIGixRNGoA8hgghjx3Y5U8/c
         K0Gw==
X-Gm-Message-State: AFq9FYL7C8q6StFnbRbmo32OR6JI7CJkIQCWC1xypaIkdS1v3bmkysn2
	RlKMBF19H03rsBcN3k0W7fYX2oBenuktncRC5V5yl6GQ16BMvN0ojX3ZK+CeA3I+A6o=
X-Gm-Gg: AYBFou3btqpbtfGWkDmzWbGIcH+NpPC1NFwEqpUQuzcB5BexocYxJUtfpA2SktLFbuq
	QBt+cVr0wT8cSH44Lh5v6xy45R+l2ZbcBa0IUysh/IMfEqNJHHo58qjrJb13IhL6Uo+A1zg+/zr
	nmOx7gmTtCxym2HXs6Rab0Y82TITEbsKXLONw82LYgGU31UKjJghQGhFVT9R3NdImhLXr1jCdNr
	rtXPCoYLaKxGNYHuKp+ibotFR5Ps+4b/Jlt8b2pQjYHTnM0N+eHbhJNASsI22l2hfaKhqfkZXv/
	XX7KMF/VbE3bRUnq/dcoT1kDb65ngjcOb9aBC2NXe2i3NZ0kfm1E1fnUAYHciS6P4sEUwVV2Yj5
	mvGcO503rSdv8gw+Ooe3lXH+w6gWMK1KDwoZw0YDRiIlNXgxAX0ewdnKVny0COIkA5CDeoGRDz+
	wQPX1Zm64p1K5OLr/p6TIG5ArQmnDcnCG0TWcYrFoYgWMl8olBaU9iV6mCGV8rddrkAM8VVVFo8
	flg/AO0WPFTWu0vS4A4vMBQxZB//jrTztS4Ug==
X-Received: by 2002:a17:903:46c8:b0:2df:7e40:6f6c with SMTP id d9443c01a7336-2e6004d67d8mr36969815ad.46.1791426529645;
        Wed, 07 Oct 2026 19:28:49 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661c:1246::1d2:d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e60482cab0sm18045865ad.50.2026.10.07.19.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 19:28:48 -0700 (PDT)
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
	Jacob Keller <jacob.e.keller@intel.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 02/10] net: hisilicon: hip04_eth: Move setting of netops to fix crash
Date: Thu,  8 Oct 2026 10:26:44 +0800
Message-ID: <20261008022656.3592191-3-mmyangfl@gmail.com>
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

hip04_mac_probe() calls of_phy_connect() before ndev->netdev_ops is
assigned. phy_attach_direct() -> phy_link_topo_add_phy() reads
dev->netdev_ops through netdev_need_ops_lock() since the commit in
question, so probing crashes with a NULL pointer dereference when
CONFIG_NET_SHAPER is enabled.

Assign netdev_ops before the PHY attach, as was done for emac in commit
7c9f391ec89c ("net: emac: move setting of netops to fix crash").

Fixes: ded86da4bbb7 ("net: ethtool: relax ethnl_req_get_phydev() locking assertion")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/ethernet/hisilicon/hip04_eth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
index fc2c47dcfaab..d0409de5c553 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -976,6 +976,8 @@ static int hip04_mac_probe(struct platform_device *pdev)
 		goto init_fail;
 	}
 
+	ndev->netdev_ops = &hip04_netdev_ops;
+
 	priv->phy_node = of_parse_phandle(node, "phy-handle", 0);
 	if (priv->phy_node) {
 		priv->phy = of_phy_connect(ndev, priv->phy_node,
@@ -989,7 +991,6 @@ static int hip04_mac_probe(struct platform_device *pdev)
 
 	INIT_WORK(&priv->tx_timeout_task, hip04_tx_timeout_task);
 
-	ndev->netdev_ops = &hip04_netdev_ops;
 	ndev->ethtool_ops = &hip04_ethtool_ops;
 	ndev->watchdog_timeo = TX_TIMEOUT;
 	ndev->priv_flags |= IFF_UNICAST_FLT;
-- 
2.53.0

