Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F823AFD16;
	Wed, 30 Sep 2026 05:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790745289; cv=none; b=WwH2kkzgJg9Q+BhNb2gN5xJlcsqZn6N6jVjATrnwskl+wQ5gkHzfRlhwdUM7aQ2gCpV3zT+1Ahxa+mgbOOOsXhXws5Pm5H30Hn34E31pK6dkg0rV1XWrbk/aFe1xuOAVTJf6tDyqfIijaXg7i33wQhTeiYcEOmbCVKwp1huFA54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790745289; c=relaxed/simple;
	bh=0eMSZlLXPJw8GI+iH1OKKlPr3AZB7Tno1FXnXHdcHJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gsoo6+y/w1sCNE529lRGhNsJRN6O2qBHrlbfFCf3oidUQae39xu8tCDU7mPMWGiDGDPYPlMNnHgR/8kjAmNVQRWMzz0Ll/je+jryp9ZSn1EUj7V5oipr1Od9acl4KIg2UellW3grbb1zjLbD6tmGggmtRCINHVWnpTPtOoZFeTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LWOTMJGN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LWOTMJGN"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U3VYor1887239;
	Wed, 30 Sep 2026 05:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=CHRWgL1qT3M
	ZPcXrsQzwNtQXSXb8+qSxmOuIdF/yeJI=; b=LWOTMJGNNJKbKeUXUUeD6T/wkkc
	L0LAzWFPsooLZ9SARuBWX9pxda4Y2jRoSv93W/JZp8R3MPBf1mysN8ZcT2OpU8sj
	X1WyoyfWPXqLvBH8o8oMYvgGkeJhcDaVD5/QBZPGketnFzaFkkTGT+3z8IjnEZBX
	BGfx/PAf0RJc3gZBDXkNWRFJOnn9Tx65vu/SZl/lxekCvI3tVs4eTeTPJ272MxZT
	bHuTFrbxa/IZYeg2lSa6Yukm+7bSdqjfpwpVrYME4AcZj06MdYnN3uxLGBpwFeOZ
	xTONBES4ZPbQ7DXYkED8BnHCIj5Dih6Uo9/BW0O3WjRzldXy0UnyIe6Oz1g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0tkn0by0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 05:14:32 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68U5EW3d1552832;
	Wed, 30 Sep 2026 05:14:32 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-subashab-lv.qualcomm.com [10.81.24.15])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 68U5EVpI1552824
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 05:14:32 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 212624)
	id 81BEFAC1; Tue, 29 Sep 2026 22:14:31 -0700 (PDT)
From: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net
Cc: horms@kernel.org, skhan@linuxfoundation.org, rdunlap@infradead.org,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
        Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Subject: [PATCH net-next 3/7] net: qualcomm: rmnet: Restrict supported MAP checksum configurations
Date: Tue, 29 Sep 2026 22:13:41 -0700
Message-Id: <20260930051345.857443-4-subash.a.kasiviswanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930051345.857443-1-subash.a.kasiviswanathan@oss.qualcomm.com>
References: <20260930051345.857443-1-subash.a.kasiviswanathan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=CKy/zhrD c=1 sm=1 tr=0 ts=6abc9ab8 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=c88VizKmvljSRnk9K5QA:9
X-Proofpoint-ORIG-GUID: KqvgidHjv-bWOlwKOTF1TmEu3ZuJOzQt
X-Proofpoint-GUID: KqvgidHjv-bWOlwKOTF1TmEu3ZuJOzQt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyMCBTYWx0ZWRfX3Pi0uZ+4lncT
 Z5sznh4NkXKtfuiOrhxmLi4rjWb20ScF/v/l8xQtnS0ro1mc1gFdYjM1fhaONDPWid1INTtlwpn
 TERtlAHbd+TxAirrMswzZgrWsU2DfLmqjHi5KIAcSmJ5sHk2EsI9CwMTzbW7urPxFNLtuu3OhcY
 P6oqgqhjD0wQNZPD2WS/8lwKO5iVp2E4nLwD+SBs3YODCTECz3roI/ohwPW4P0HVLDcn9v376+C
 zlNN2Tfv2BOgIsoM/erBRERCqa1eD/+vE75zE4nuBG4Un+h/8M6Vmxb4ncWMkXPNkMuvU6TqSIv
 daA5MAgyr/Qo1eQxJmgOl/GVdbgzmApMoaKvggVElNn83QhMnV5oYpoMiKNi/7wRB5krM01XKJp
 TvKbgNBVuMp9xe1vorRYbpZWxM50iXwLMh0e9mPkwT77dgbSg9G9QoP3qgR32FScnmKVqVPRjYd
 GvRtQgazAeCLc1VKSSg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyMCBTYWx0ZWRfX8PA+axDU+haR
 9y44jMzNXM/kDkXEEPUAjLOwOUpoXmuFrOvnfFOdix60rJKY1cLL9h6YLz2dO9ELd2hOFf3Uihm
 J5V78hY+LAvYEVLw69doRh2H8KogSH8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300020

RmNet only supports three MAP data format configurations: MAPv1
(no checksum offload), MAPv4 (v4 checksum offload) and MAPv5 (v5
checksum offload). QMAP command support is orthogonal and may be
combined with any of the three. Mixing the v4 and v5 checksum
offload flags together is not a valid configuration.

Validate the requested data format in both rmnet_newlink() and
rmnet_changelink() and reject any combination that sets both the
v4 and v5 checksum offload flags at the same time. This is in
preparation for the next patch where coalescing support needs to be
allowed with MAPv5 format only.

Co-developed-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
---
 .../ethernet/qualcomm/rmnet/rmnet_config.c    | 62 ++++++++++++++-----
 1 file changed, 46 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index 61b04c6c0390..8051aef01ae3 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -26,6 +26,22 @@ static int rmnet_is_real_dev_registered(const struct net_device *real_dev)
 	return rcu_access_pointer(real_dev->rx_handler) == rmnet_rx_handler;
 }
 
+/* Only three MAP configurations are supported: MAPv1 (no checksum
+ * offload), MAPv4 (v4 checksum offload) and MAPv5 (v5 checksum
+ * offload). QMAP command support is orthogonal and permitted with
+ * any of the three. Mixing v4 and v5 checksum offload flags together
+ * is not a supported configuration.
+ */
+static bool rmnet_config_data_format_valid(u32 data_format)
+{
+	u32 v4_mask = RMNET_FLAGS_INGRESS_MAP_CKSUMV4 |
+		      RMNET_FLAGS_EGRESS_MAP_CKSUMV4;
+	u32 v5_mask = RMNET_FLAGS_INGRESS_MAP_CKSUMV5 |
+		      RMNET_FLAGS_EGRESS_MAP_CKSUMV5;
+
+	return !(data_format & v4_mask) || !(data_format & v5_mask);
+}
+
 /* Needs rtnl lock */
 struct rmnet_port*
 rmnet_get_port_rtnl(const struct net_device *real_dev)
@@ -143,6 +159,20 @@ static int rmnet_newlink(struct net_device *dev,
 		return -ENODEV;
 	}
 
+	if (data[IFLA_RMNET_FLAGS]) {
+		struct ifla_rmnet_flags *flags;
+
+		flags = nla_data(data[IFLA_RMNET_FLAGS]);
+		data_format &= ~flags->mask;
+		data_format |= flags->flags & flags->mask;
+	}
+
+	if (!rmnet_config_data_format_valid(data_format)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "unsupported MAP checksum flag combination");
+		return -EINVAL;
+	}
+
 	ep = kzalloc_obj(*ep);
 	if (!ep)
 		return -ENOMEM;
@@ -167,14 +197,6 @@ static int rmnet_newlink(struct net_device *dev,
 
 	hlist_add_head_rcu(&ep->hlnode, &port->muxed_ep[mux_id]);
 
-	if (data[IFLA_RMNET_FLAGS]) {
-		struct ifla_rmnet_flags *flags;
-
-		flags = nla_data(data[IFLA_RMNET_FLAGS]);
-		data_format &= ~flags->mask;
-		data_format |= flags->flags & flags->mask;
-	}
-
 	netdev_dbg(dev, "data format [0x%08X]\n", data_format);
 	WRITE_ONCE(port->data_format, data_format);
 
@@ -301,8 +323,11 @@ static int rmnet_changelink(struct net_device *dev, struct nlattr *tb[],
 			    struct netlink_ext_ack *extack)
 {
 	struct rmnet_priv *priv = netdev_priv(dev);
+	struct ifla_rmnet_flags *flags;
 	struct net_device *real_dev;
 	struct rmnet_port *port;
+	u32 old_data_format;
+	u32 data_format;
 	u16 mux_id;
 
 	if (!dev)
@@ -320,6 +345,19 @@ static int rmnet_changelink(struct net_device *dev, struct nlattr *tb[],
 
 	port = rmnet_get_port_rtnl(real_dev);
 
+	if (data[IFLA_RMNET_FLAGS]) {
+		old_data_format = READ_ONCE(port->data_format);
+		flags = nla_data(data[IFLA_RMNET_FLAGS]);
+		data_format = old_data_format & ~flags->mask;
+		data_format |= flags->flags & flags->mask;
+
+		if (!rmnet_config_data_format_valid(data_format)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "unsupported MAP checksum flag combination");
+			return -EINVAL;
+		}
+	}
+
 	if (data[IFLA_RMNET_MUX_ID]) {
 		mux_id = nla_get_u16(data[IFLA_RMNET_MUX_ID]);
 
@@ -346,14 +384,6 @@ static int rmnet_changelink(struct net_device *dev, struct nlattr *tb[],
 	}
 
 	if (data[IFLA_RMNET_FLAGS]) {
-		struct ifla_rmnet_flags *flags;
-		u32 old_data_format;
-		u32 data_format;
-
-		old_data_format = port->data_format;
-		flags = nla_data(data[IFLA_RMNET_FLAGS]);
-		data_format = old_data_format & ~flags->mask;
-		data_format |= flags->flags & flags->mask;
 		WRITE_ONCE(port->data_format, data_format);
 
 		if (rmnet_vnd_update_dev_mtu(port, real_dev)) {
-- 
2.34.1

