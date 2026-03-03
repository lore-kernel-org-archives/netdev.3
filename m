Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B9B373C1E;
	Tue,  3 Mar 2026 01:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772502775; cv=none; b=soSEKiMHBfuOhl7MK9YeGo1KOq0J+ppn0bj5N/1SPGrrsbX12L5ANnbvQfYhwWKp9AiFKobhM9YZN5K5Wecw8qdJx/t+YPaVNmwSEZR3DUtak8wkcfLRt6hiJICY+V5LYWAzqSkDw2PD5zPZowQoQ4svgJ5Vgcwr/8ACIUg4tYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772502775; c=relaxed/simple;
	bh=JZvMyrY5V3kzs/3jcRLWkNDy/3HjAklixRnfXAdFXyw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pgzAzblKG7fcTnm38C3avm2ELtxxD+cVEsU/J0MC9mcGz6eukkiIENkxq1P+bY+FBIHoh27//d024c/SMLGNwpVYrSVBHbsfOH+IwthIZxqaElb6xr0buCuVRpyWcfYlnszNH/NaA2fjeflUnWcPdmQOKmTUfzAcaSV8KgpeCeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HOgQ5imi; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HOgQ5imi"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2YhXVcXFOvl4RE+GcFTcGZzoQ+UcaaWJmcXg81gKeR0=;
	b=HOgQ5imigO06MUzgcGo2v2RJaPNLmyZ6bvZB/rglUU5bh7ersziWGtvol14QgM/ycT0Hw7AJF
	cSa6K2k1QfDpbKSWfFH18IUTJ2tBGyXPviJHZc0tmCAyuaIjPUQRkbBRmXITVvG12sKErWpwt8F
	KPJSJP+JJDD2FBL7YspYpBw=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fPzGM4FJZz12LCl;
	Tue,  3 Mar 2026 09:48:11 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id D40A82025F;
	Tue,  3 Mar 2026 09:52:48 +0800 (CST)
Received: from kwepemq200017.china.huawei.com (7.202.195.228) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Mar 2026 09:52:48 +0800
Received: from hulk-vt.huawei.com (10.67.174.72) by
 kwepemq200017.china.huawei.com (7.202.195.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Mar 2026 09:52:48 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <ioana.ciornei@nxp.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<caixinchen1@huawei.com>
Subject: [PATCH -next] dpaa2-switch: Add depend on FSL_DPAA2_ETH to FSL_DPAA2_SWITCH
Date: Tue, 3 Mar 2026 01:38:14 +0000
Message-ID: <20260303013814.338989-1-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq200017.china.huawei.com (7.202.195.228)

When CONFIG_FSL_DPAA2_ETH=n, dpaa2 cannot be compiled. Thus Add
depend on FSL_DPAA2_ETH to FSL_DPAA2_SWITCH in Kconfig

Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 drivers/net/ethernet/freescale/dpaa2/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/dpaa2/Kconfig b/drivers/net/ethernet/freescale/dpaa2/Kconfig
index d029b69c3f18..b303af155a86 100644
--- a/drivers/net/ethernet/freescale/dpaa2/Kconfig
+++ b/drivers/net/ethernet/freescale/dpaa2/Kconfig
@@ -34,6 +34,7 @@ config FSL_DPAA2_SWITCH
 	tristate "Freescale DPAA2 Ethernet Switch"
 	depends on BRIDGE || BRIDGE=n
 	depends on NET_SWITCHDEV
+	depends on FSL_DPAA2_ETH
 	help
 	  Driver for Freescale DPAA2 Ethernet Switch. This driver manages
 	  switch objects discovered on the Freeescale MC bus.
-- 
2.34.1

