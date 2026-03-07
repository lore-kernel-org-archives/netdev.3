Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979C7378D68;
	Sat,  7 Mar 2026 06:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772865855; cv=none; b=cnm9pTI5CmmOf+1WRcrbDQ+Ocg39gO8dhxwiRcmKiBP+a6OZ5AM/yi/iVnsqDbDELWqy2ILhnPkjTWi3XR1XmjNTyr5LbFMs3OWwsxHZaPUvbM9XLBnPcJ033zTF0Ikd8mrS9AJWum5WXQE5WKw4QXXQ9AXJkNpw6VRH4pa66Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772865855; c=relaxed/simple;
	bh=t5A1ZYVRo1ibd6Jui54nqriIzyGimwQzrN1hpFd3A9w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RX99Khm1HbUBwD3hHBCJXauHWTmVhdJbXInldy4ZEuLTCW3TSH0n9uaFWp8frn1xqoIWXvQ/mFa+ZhE4mo+y9zVCXIX4Nt4l89ezmwwy4LNmboeAaZhO8S9DZ1Zo2fwVo5mKYX/Y0l8TYOkpdAXFeTfkcc4z65gpQO/BAhMwCys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=BlRiaOTW; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="BlRiaOTW"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=a1aNGSXdmBTHdkhrjeSVicxR6DHeNbVnsDvWs42CYxQ=;
	b=BlRiaOTWzzEfNtbmD/PQHNZ2dwxkcax+nPsZwjOcFDC5ZW2tTFCweZyVDTxxLZoSndsxgANnq
	nqt8fHCL1nnR4Ck+x0hGWbzVwmwJjxmlFPZ/+C4RIuBE17i8FEOlkKQoCEn2xrsrLnYuhUG6PI3
	hQNim0l1FyUu01+hy0i/85M=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fSYX273n9zpStv;
	Sat,  7 Mar 2026 14:38:58 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 67AA040363;
	Sat,  7 Mar 2026 14:44:03 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sat, 7 Mar 2026 14:44:02 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>
Subject: [PATCH net-next v02 4/9] hinic3: Add RX VLAN offload support
Date: Sat, 7 Mar 2026 14:43:43 +0800
Message-ID: <b3aa6b5dc8777900215b9ff1440994dcddda94ab.1772697509.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1772697509.git.zhuyikai1@h-partners.com>
References: <cover.1772697509.git.zhuyikai1@h-partners.com>
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

  Add vlan offload processing in RX process.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_rx.c | 15 +++++++++++++++
 drivers/net/ethernet/huawei/hinic3/hinic3_rx.h |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
index 1236ec233b7f..309ab5901379 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
@@ -328,6 +328,7 @@ static void hinic3_rx_csum(struct hinic3_rxq *rxq, u32 offload_type,
 	u32 ip_type = RQ_CQE_OFFOLAD_TYPE_GET(offload_type, IP_TYPE);
 	u32 csum_err = RQ_CQE_STATUS_GET(status, CSUM_ERR);
 	struct net_device *netdev = rxq->netdev;
+	bool l2_tunnel;
 
 	if (!(netdev->features & NETIF_F_RXCSUM))
 		return;
@@ -350,6 +351,12 @@ static void hinic3_rx_csum(struct hinic3_rxq *rxq, u32 offload_type,
 	case HINIC3_RX_UDP_PKT:
 	case HINIC3_RX_SCTP_PKT:
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		l2_tunnel = HINIC3_GET_RX_TUNNEL_PKT_FORMAT(offload_type) ==
+			    HINIC3_RX_PKT_FORMAT_VXLAN ? 1 : 0;
+		if (l2_tunnel) {
+			/* If we checked the outer header let the stack know */
+			skb->csum_level = 1;
+		}
 		break;
 	default:
 		skb->ip_summed = CHECKSUM_NONE;
@@ -390,6 +397,14 @@ static int recv_one_pkt(struct hinic3_rxq *rxq, struct hinic3_rq_cqe *rx_cqe,
 	offload_type = le32_to_cpu(rx_cqe->offload_type);
 	hinic3_rx_csum(rxq, offload_type, status, skb);
 
+	if ((netdev->features & NETIF_F_HW_VLAN_CTAG_RX) &&
+	    RQ_CQE_OFFOLAD_TYPE_GET(offload_type, VLAN_EN)) {
+		u16 vid = RQ_CQE_SGE_GET(vlan_len, VLAN);
+
+		/* if the packet is a vlan pkt, the vid may be 0 */
+		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
+	}
+
 	num_lro = RQ_CQE_STATUS_GET(status, NUM_LRO);
 	if (num_lro)
 		hinic3_lro_set_gso_params(skb, num_lro);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
index 31622e0a63d0..06d1b3299e7c 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
@@ -15,6 +15,9 @@
 #define RQ_CQE_OFFOLAD_TYPE_GET(val, member) \
 	FIELD_GET(RQ_CQE_OFFOLAD_TYPE_##member##_MASK, val)
 
+#define HINIC3_GET_RX_TUNNEL_PKT_FORMAT(offload_type) \
+	RQ_CQE_OFFOLAD_TYPE_GET(offload_type, TUNNEL_PKT_FORMAT)
+
 #define RQ_CQE_SGE_VLAN_MASK  GENMASK(15, 0)
 #define RQ_CQE_SGE_LEN_MASK   GENMASK(31, 16)
 #define RQ_CQE_SGE_GET(val, member) \
-- 
2.43.0

