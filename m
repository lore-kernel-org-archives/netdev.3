Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DC93DAACB;
	Mon, 27 Jul 2026 06:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785135319; cv=none; b=nfvf13qVLFlOHD6QpIzdigg55+K5F12mxBnYHbHHpDV+XHY8Uq1RS13b1Rsv84GyUHn6fVg9VsjQvDd5uASwxeHRwQEgYoiyCiSKrgOqVWfbrc1KVZ6gVTiEjOJB18Ua/KvTk+8s/UhBpcnSENX6tOFkKwr8JSHRT6mna4zr/ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785135319; c=relaxed/simple;
	bh=0XRpUHjizVEBgNHJt+ZXZNN3AjEQuVZB9GfE4yveiOs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pSQLNIqxZbLov/9SX05mUIswpRqXV0foSRStV1KbERhw/lP864AvRoKf9BVzlHWH+Laa7Bn3JhLCtSYp5BAFUSGJjeC4CHbX9b3OrbqrbKvRV85NTgd8+i4TVlOEUW8Isfm8i1sOQJSVkRhvp5wXVQf7pF52CI9JZs2WL8MaPNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ZqIIe4Ul; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ZqIIe4Ul"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=UJ/9kNHbZcxWz2l8M4wwZdzbX10GExefEl/I4ZEmMsg=;
	b=ZqIIe4UlKUV0+Plo0e6/TyampYyAuhZsllR/+45NPOaFlYtFoSLid49R5orEbty1o1Ont0p0g
	jA5FSfxicHNp9IrRE6AyzpV9fikFOiEtlsbjD2lxbyisEjvDEVjhK5dhCPNFI8ORD2RWHDBI0s2
	WkwXcZ1TyrzQrIiJ25Xl6r4=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4h7pyN3vgdzRhR1;
	Mon, 27 Jul 2026 14:45:48 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 0E4F140591;
	Mon, 27 Jul 2026 14:55:13 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 27 Jul 2026 14:55:11 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Wu Di <wudi234@huawei.com>, Teng Peisen
	<tengpeisen@huawei.com>, <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Mohsin Bashir <mohsin.bashr@gmail.com>, Dimitri
 Daskalakis <dimitri.daskalakis1@gmail.com>, Harshitha Ramamurthy
	<hramamurthy@google.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, Chen Anwen
	<chenanwen@huawei.com>, He Wei <august.hewei@huawei.com>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v12 2/8] hinic3: Fix loose success check in rx buffer filling
Date: Mon, 27 Jul 2026 14:54:53 +0800
Message-ID: <9463522667ee175211c12e8ecd7c81a0a55256b6.1785120952.git.root@localhost.localdomain>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <cover.1785120952.git.root@localhost.localdomain>
References: <cover.1785120952.git.root@localhost.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100013.china.huawei.com (7.202.181.12)

  Tightens the success criterion for hinic3_rx_fill_buffers() in
hinic3_configure_rxqs().

Co-developed-by: Wu Di <wudi234@huawei.com>
Signed-off-by: Wu Di <wudi234@huawei.com>
Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
index 309ab5901379..389b1c2158be 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
@@ -541,7 +541,7 @@ int hinic3_configure_rxqs(struct net_device *netdev, u16 num_rq,
 		rq_associate_cqes(rxq);
 
 		pkts = hinic3_rx_fill_buffers(rxq);
-		if (!pkts) {
+		if (pkts < rxq->q_mask) {
 			netdev_err(netdev, "Failed to fill Rx buffer\n");
 			return -ENOMEM;
 		}
-- 
2.54.0

