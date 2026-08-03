Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459D83264DD;
	Mon,  3 Aug 2026 03:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785728923; cv=none; b=SKHZdKe8o6S7q9/l5ovXTtxB3DcqapLZR8wy28HAJk7zY7VQvTZHwtth9nt7Pnk6sSaFN6F1pyNvwdvWM9rLV5fGkPT2R7/XV5scrYELPWsogizyfnp+JZpLZSYh/c5AzZNH38Pbc+D61fZhBAv6Famrk4fpHscTfNMMt9ogkao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785728923; c=relaxed/simple;
	bh=dVsjgrUwchBffeX3KlCenYqIkgGr7ByrO+79ODarF/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkYtsIMUVmEmZpUeyqV0MSN1XFy+4a/JoCWbz11CvDSNnQk0BdO5ik2y9di0XlxR+WXthz4hx+oPef9QVeVRirjLqG/lYV5vSx294nVKDWjE4koi1dU8wBbHbRl7MwZvtz11iqZHfzsSbKuthYfJVypPfZZ91R8Uro0K6mMWkNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=U/EwvLC0; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="U/EwvLC0"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Zz2d46lkBCrs3SFpxBGmLfu2XD6bDSKaK+OQ1YBMGo8=;
	b=U/EwvLC0QIt757Tqvm/urK5ltALybquLts6iwQLrgYkzYADtiDFfglPa1Eb6Ih4xTdgsq0kUN
	b5EveNYSdm7z9tsdUxhn3asoRascQcfL2/BILXASAarf2ZTIClWTsGat3oD1KKa0X5ljXgyITks
	ufv+1FPJDj1ylnw5ADHxv8M=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4hD2Tl5CJjz1cyVf;
	Mon,  3 Aug 2026 11:39:07 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 4427C40563;
	Mon,  3 Aug 2026 11:48:36 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 3 Aug 2026 11:48:35 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Teng Peisen <tengpeisen@huawei.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Larysa Zaremba <larysa.zaremba@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, Chen Anwen
	<chenanwen@huawei.com>, He Wei <august.hewei@huawei.com>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Wu Di <wudi234@huawei.com>
Subject: [PATCH net 2/2] hinic3: Fix partial RX buffer allocation check during queue setup
Date: Mon, 3 Aug 2026 11:48:25 +0800
Message-ID: <30b9c237a8a385bc949edf17693dae4f18803694.1785727595.git.tengpeisen@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <16ed10bb3470f17fe78b0803a8a550c2c720f3e6.1785727595.git.tengpeisen@huawei.com>
References: <16ed10bb3470f17fe78b0803a8a550c2c720f3e6.1785727595.git.tengpeisen@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100013.china.huawei.com (7.202.181.12)

From: Teng Peisen <tengpeisen@huawei.com>

From: Fan Gong <gongfan1@huawei.com>

In hinic3_configure_rxqs(), the check for hinic3_rx_fill_buffers() only
verifies that at least one buffer was allocated (!pkts).

If memory allocation partially fails during RX queue setup, the function
incorrectly treats a partially populated RX ring as successful, which
may cause RX queue instability or unexpected packet drops at runtime.

Fix this by tightening the condition to 'pkts < rxq->q_mask'. This ensures
that RX queue configuration fails with -ENOMEM unless the RX ring is
completely filled as expected.

Fixes: b83bb584bc97 ("hinic3: Tx & Rx configuration")
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

