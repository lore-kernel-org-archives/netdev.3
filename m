Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2D03546F9
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 06:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783922788; cv=none; b=nk8dUh4mUHNoyjSuzkjf8caUjt8Fq+5NpbHKuyYemibKcTf+okDT3GynUMZYSHhBtBHsUShhgDoUxEzUsS9uaerTR66CnyTVRAOVGcVDfm2bZ87vRLq2S51TANEJP9CsfVrl7AHPenhnH6YvaDIz03ZcAXmXhHoHm36oTpSh6zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783922788; c=relaxed/simple;
	bh=e5qZ4+Wlajgb1J0bwFb075tcbSzwvf2omA8U6fIppCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LxRXEe+Uv3pcdfWV3CiNI4fktyt9sJoyl0vySGMFSMdXgfH6fbr7nU25n2DG8ND0vnmXWcwYwf+Lr/Z6uW4OimvgrQ9CWrWF7zc1QpiMlXjntUKZ6zkslYqAqho6CtxEwLknSo++GbwLEoZSwbYzeqPvJ1fgygWd2ZocVkx33+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz11t1783922712t9e4a88f9
X-QQ-Originating-IP: 0O2L8YFXDsn/ebqyk79I3flUdYvXWavi88mbT2cqNjs=
Received: from w-MS-7E16.trustnetic.com ( [115.200.247.46])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 13 Jul 2026 14:05:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9343770031080650761
EX-QQ-RecipientCnt: 13
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Duanqiang Wen <duanqiangwen@net-swift.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2] net: libwx: disable TX VLAN offload for packets with >2 VLAN tags
Date: Mon, 13 Jul 2026 14:04:41 +0800
Message-ID: <069DF89AA8029189+20260713060441.276612-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NzSDQCFWCzVTXwRgF/InEXkkATSd3OYfEpZCOgGMxopRi6dtQpktDD9l
	+e5BgvyEFQuo2d1jeE9wo63p8oxkDTEajr//saWge7LqlkFDFNa6iwQmM8T+eS7XYOGku5F
	agwLVPZxsKcMwicAHIh/CQ4+4xUOtu+PrLpTlkexLhIc3wEMngNMbOwq72/ZFk1YwS0r/0F
	1ugqywBOvcBEDbxvdyEq7O+MwyysnVz/B+alE73UTx1QpfyNHGXvcHl+3Nt9upF/UpR/Bbl
	7CA5TOQrg/RXjOVhtlI/w/YufcV1QSOlxlkUnI8W6r3vMqhXb19M1DSLZZgABZun5XTopdt
	DaiV9vZhDxq7yZY/Vd4PUXUveAoqTI+dmcNaGl50Z4+bxN+CJDQpvzsjaz5OmdWmkP0nh7Q
	K6pOG43tLqy7U7igz+I01v6ohnhhKYuov2emvAhfTLnCa5hQ/Ppj8+YEVheG/S1IqDdzcWf
	fqEGd5ovtTR556W61c3akAqWHnqaDWX8nNHs+3S+F7lvmSM8ou2cNvh6U09F7zNQX63lq8K
	mBDo1SMZ4qtxOz8cG/ilJ/RGvpWJ0TbllwEJMrrkyoIzPUyKU5CBIqko1Y6itdV5nvCpN7S
	3UVo7bhJhcM3ppNwErp0NvR2qANb0cVF0TXWgFwlgFjXB2CM0QdDNV7dNcwWfqeR56mZmHF
	f+ArP0Kmx0SfZW0ZQMYoQtTvYktECWYZQKt/yzYILFpnseAki9MSCNv+JqlhlE4raGbOaWx
	ojCMBd1Nwvuew3Zh+j/X84ihGAlNpBi6JRYGcsLxKFSjXtjhc/ipxGEBg5CwKP2XoaXD6nz
	ctPhSFS4wAjy2R3X1vFIEg0RiEnwjk0eKCVKdks/h2WogR/7ArcbrLXuhbptWLHZ8OZD3t0
	kc9LOi9yYQrb3pYNAkgXXJvxjYrPR++8F4ANvfPd2y7VuCWFTM0qp1OBKUksmRS4UrDBbDc
	9xPUkDlOpE9LiEtaR8ELMD4O90uOXkbywxHu926UpKb8AEtlLCrKK1AVUDgXS/4GqecJXKt
	AucaEKt1UAoGsfOANB1krbpagkvzsRSODqiEbLslYCTergNFljLmCDsm+SQnI+BCy588/UA
	DDmczxan20KqtFUZmIU//M=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

The current hardware does not support TX VLAN offload for packets with
three or more VLAN tags. When such packets are transmitted with hardware
VLAN offload enabled, the hardware may malfunction or produce corrupted
frames.

Add a check in wx_features_check() to parse the VLAN depth of the
skb. If more than two VLAN tags are detected (including both the
hardware tag and in-band tags), strip NETIF_F_HW_VLAN_CTAG_TX and
NETIF_F_HW_VLAN_STAG_TX from the feature set. This forces the
kernel networking stack to handle VLAN insertion in software for
these specific packets, ensuring correct transmission.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
v2:
- Remove redundant 'parse_depth'.
- Optimize the loop.

v1: https://lore.kernel.org/all/C1BF77C0E073A40C+20260710071831.210196-1-jiawenwu@trustnetic.com
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c | 24 +++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 814d88d2aee4..34542b3dc884 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -3228,6 +3228,30 @@ netdev_features_t wx_features_check(struct sk_buff *skb,
 				    netdev_features_t features)
 {
 	struct wx *wx = netdev_priv(netdev);
+	__be16 type = skb->protocol;
+	u16 vlan_depth = ETH_HLEN;
+	u32 vlan_num = 0;
+
+	if (skb_vlan_tag_present(skb))
+		vlan_num++;
+
+	while (eth_type_vlan(type)) {
+		struct vlan_hdr vhdr, *vh;
+
+		vh = skb_header_pointer(skb, vlan_depth, sizeof(vhdr), &vhdr);
+		if (unlikely(!vh))
+			break;
+
+		type = vh->h_vlan_encapsulated_proto;
+		vlan_depth += VLAN_HLEN;
+		vlan_num++;
+
+		if (vlan_num > 2) {
+			features &= ~(NETIF_F_HW_VLAN_CTAG_TX |
+				      NETIF_F_HW_VLAN_STAG_TX);
+			break;
+		}
+	}
 
 	if (!skb->encapsulation)
 		return features;
-- 
2.51.0

