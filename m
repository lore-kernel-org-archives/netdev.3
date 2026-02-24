Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE83A3A1A5D;
	Tue, 24 Feb 2026 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938990; cv=none; b=LxUNXwmSanCVPWM5B9ZQkiWn5cQD9SSrCfdf/vjSDU5Rwx0oL9TwZ6sRogWljx7LUVQQGExW533AfrhN/1zFQvLlLuSqB2Tdm20y0w/+2b265R9sFAnrd6NFX+gfqzkFsjM7wis6sgNRubPs1nCf5bYF78OZB3e43b61VYRxpsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938990; c=relaxed/simple;
	bh=4tK7AlCcUYAHSo9DJ6za+giSv/eJY23Y9yUW7P/6Y9k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aa3qSbO5q4nYKaSMAYgaCTQCBMjk8CxUj69TkUHvXJRJzhEZ9GCBKmeqnZ9hPJ0Dmm0pkApLYMLfvyfIfHi3RAVjD05eLAv5niWK6dHj6W3YN52tGvU+v6H+QyPA0yYo30DePvkH4jU4uRzzivhDEja0ikke98kmMwLr632lluc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=BDXb/Ndw; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="BDXb/Ndw"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lNpWRIb5NOnFFbs4LfS6pOxuRiA74/pcgurF0PmUllk=;
	b=BDXb/NdwizUL/1w85tyyKcv68hCwodbHH94vT4S60WpdxJuQlbBBdWMXOxt93HbnUfVO+qQv+
	9iH8GC2PGIocpq2BxqsoCk38BbBnTm1Vb3KldOIEZMp7hAsWhrh3tSFKip9+AFBJwcGygSk6ZKy
	ntitic9eFNRkGh5YvvXJ2sk=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fKymC2l27zKm50;
	Tue, 24 Feb 2026 21:11:39 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 513ED40567;
	Tue, 24 Feb 2026 21:16:26 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 24 Feb 2026 21:16:25 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>
Subject: [PATCH net-next v01 14/15] hinic3: Add MTU size validation
Date: Tue, 24 Feb 2026 21:15:51 +0800
Message-ID: <98b65fc9942972ba5fe1091bd58143ef7691f4cf.1771916043.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1771916043.git.zhuyikai1@h-partners.com>
References: <cover.1771916043.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
index a1a193201afd..521035b47932 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
@@ -246,6 +246,19 @@ int hinic3_set_port_mtu(struct net_device *netdev, u16 new_mtu)
 	struct l2nic_func_tbl_cfg func_tbl_cfg = {};
 	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
 
+	if (new_mtu < HINIC3_MIN_MTU_SIZE) {
+		dev_err(hwdev->dev,
+			"Invalid mtu size: %ubytes, mtu size < %ubytes\n",
+			new_mtu, HINIC3_MIN_MTU_SIZE);
+		return -EINVAL;
+	}
+
+	if (new_mtu > HINIC3_MAX_JUMBO_FRAME_SIZE) {
+		dev_err(hwdev->dev, "Invalid mtu size: %ubytes, mtu size > %ubytes\n",
+			new_mtu, HINIC3_MAX_JUMBO_FRAME_SIZE);
+		return -EINVAL;
+	}
+
 	func_tbl_cfg.mtu = new_mtu;
 
 	return hinic3_set_function_table(hwdev, BIT(L2NIC_FUNC_TBL_CFG_MTU),
-- 
2.43.0

