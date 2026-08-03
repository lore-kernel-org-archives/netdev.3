Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679A62BDC2A;
	Mon,  3 Aug 2026 03:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785728926; cv=none; b=MN+cVIcRCfB53ul2xZsb3e98CJqtuNMHM1wNx4NY3Fj/0KNuwP7FuEYR60Ku79bkQjh2gErBEtxfApGyw6NG8BympCDn3QuU6qdt1eW239EPedCCijbafrjxEngwB8BKj5bQQXUPOpr8uIz/L/JNBIfzyHLbgI7pmPXt4Wf0sd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785728926; c=relaxed/simple;
	bh=GBICTxO68ctK0qxSO4rbiJHbBfVH/xHObtghTcDnGfo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eKKxyFy15G0ooayOpEjkB0NC+W07Y8S9wR9INV6zxs48s6XZgr+vvFKFHlKbEpyRQW3Hn7V3oEZPxVt5VTZeWo+4V5cE6HocGmkt2bxfW8GHeptvHmWFonetELZeFlF1RoFALpKEJBLs/pyD7wHycGMIXwdkWHjnmDSR/VXwmM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FkBlm2r9; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FkBlm2r9"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8yAzjnPdaYmvNGhyrQI0M30tMEwws2uNkWvAevHQykk=;
	b=FkBlm2r9HPvasXYhYKeCVQavydmcnQ0Gw8oy6LX+bZjLatDjzaTapSdQz1pUkdiGWhkwCg+q7
	cnGP4rH7B9Hy+GI916QYaE3AjdXziMttfmCI2QRD8MruiC8XbE5atpzaC03vbe7BEkSH/BbltGL
	p7MZ6bOBCEqa8EkxMAcSI88=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hD2Tj3nCnzRhR0;
	Mon,  3 Aug 2026 11:39:05 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 2EE8D4056D;
	Mon,  3 Aug 2026 11:48:34 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 3 Aug 2026 11:48:33 +0800
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
Subject: [PATCH net 1/2] hinic3: Fix skb_checksum_help() failure handling in Tx path
Date: Mon, 3 Aug 2026 11:48:24 +0800
Message-ID: <16ed10bb3470f17fe78b0803a8a550c2c720f3e6.1785727595.git.tengpeisen@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
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

hinic3_tx_csum() falls back to skb_checksum_help() for unsupported VXLAN
packets, but ignores its return value. On failure, this can cause packets
with uncalculated or corrupted checksums to be transmitted.

Fix this by returning the error status of skb_checksum_help() and marking
the offload as HINIC3_TX_OFFLOAD_INVALID in hinic3_tx_offload() so that the
packet is properly dropped.

Fixes: 17fcb3dc12bb ("hinic3: module initialization and tx/rx logic")
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

base-commit: 2195424c3da2ef1829a63b807e3a900a90e57d85
-- 
2.54.0

