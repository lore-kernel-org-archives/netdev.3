Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352A63DB630;
	Mon, 27 Jul 2026 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785135320; cv=none; b=KT93MFHgfI/k61CEGy+5INe9Pl9lnJ5yvu/0UzUdsD1pW+Bl66h0VxH29QobxxnqzBdJ6QB0EyESKYUJHz2rTjMr9Nx+zUE6JH6uc1T3wVTBJN806/p7D3b5NQX/kiQzThCbJwPnmA5fJ8IPC5ltSg4mpDBil1TOrXCfsKAMg0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785135320; c=relaxed/simple;
	bh=oDB3mGL2zVFXxY4TbCVRbTxuAXUtNoB6FBbi2F7pDdo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCTqCEQQHlubb6KvY66G+/UicqE+X4ATjUXNfWBA0fhzF0PLvBLNHTkzLJ4mZ+UpIinA4lWJ6JjMbvSsphg1TV1+qn/cDfTR5iAnMXqU2RtbZzMr7pxcf6znLolsWd39pwDDNsZmFuOibSADq6/2lpTJc53dgdjlVijgrtUlevg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=c/gQ4L1+; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="c/gQ4L1+"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Hs18Fx6htjSXuQfVkR9qshSlzWyyVYijVzxumlWdBDU=;
	b=c/gQ4L1+FaaxSxjA0X337YZ6C+J0GWQ72LnUWlgMuWOWnGw3/4yY3+IBG8V4cM5XGilyXzYfo
	6P0QjCjlJWo5etXTteLGKRT5kmfwTT6bMu2m5hpFylelSE9ktHXFNDZ94v3Uf1ERbf2cwSo1nNf
	ihqkbxmYYj+Ai5WLFcbAbZs=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4h7pyD0ysRz12LG0;
	Mon, 27 Jul 2026 14:45:40 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C89B40575;
	Mon, 27 Jul 2026 14:55:11 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 27 Jul 2026 14:55:09 +0800
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
Subject: [PATCH net-next v12 1/8] hinic3: Fix drop skb when skb_checksum_help() fails
Date: Mon, 27 Jul 2026 14:54:52 +0800
Message-ID: <d8091108ba3034f99c08cd8ad620406e7e9395bc.1785120952.git.root@localhost.localdomain>
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

  Changes hinic3_tx_csum()/hinic3_tx_offload() to propagate
skb_checksum_help() failures into a TX drop.

Co-developed-by: Wu Di <wudi234@huawei.com>
Signed-off-by: Wu Di <wudi234@huawei.com>
Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
index 9306bf0020ca..53c065194136 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
@@ -261,8 +261,7 @@ static int hinic3_tx_csum(struct hinic3_txq *txq, struct hinic3_sq_task *task,
 		    ((struct udphdr *)skb_transport_header(skb))->dest !=
 		    VXLAN_OFFLOAD_PORT_LE) {
 			/* Unsupported tunnel packet, disable csum offload */
-			skb_checksum_help(skb);
-			return 0;
+			return skb_checksum_help(skb);
 		}
 	}
 
@@ -412,6 +411,10 @@ static u32 hinic3_tx_offload(struct sk_buff *skb, struct hinic3_sq_task *task,
 		offload |= HINIC3_TX_OFFLOAD_TSO;
 	} else {
 		tso_cs_en = hinic3_tx_csum(txq, task, skb);
+		if (tso_cs_en < 0) {
+			offload = HINIC3_TX_OFFLOAD_INVALID;
+			return offload;
+		}
 		if (tso_cs_en)
 			offload |= HINIC3_TX_OFFLOAD_CSUM;
 	}
-- 
2.54.0

