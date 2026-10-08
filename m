Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E452C87F;
	Thu,  8 Oct 2026 00:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791421044; cv=none; b=iRzQHOJwa9nbqV6DZggWFbXroucaXPm7d4EtF2rM6098/O1HCRFuqon0FXwvXVICq4iZF75uO6k7ptOBcFnQ12Fogy9yGIpaIkNoEc/hhhIqK6iL+u82hntkRLrSicKvgyRFpT8YmhkIZNqfyJpoXGAmoRJjQVooAb2tQKMZ8WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791421044; c=relaxed/simple;
	bh=CbLZw7mgSYG1LHp4+ZAMtbCp6LtnebQdWXBDV/Te8kg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hfeigAJ1joguhFRfInLFHPqa/X75876FWAdOV8qMcuqUNeC+BXvkcRsGSnffkBrXVFNb8z8a8GiRPgdE/ASbvbp4vrdZzUGtVgwl/iPxXQFNtenLSdpXK4yaN5gPZDApn/3ppwaRgOcAUq4vxTFANrfnYMrOKepQ0QYtC8Yx4zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BsJt2WTS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BsJt2WTS"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697Ltdfl851370;
	Thu, 8 Oct 2026 00:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=XRXjFRphvPq
	TPRY0C0fOOhtTFbpB0pRbpoDRrrqQAXI=; b=BsJt2WTSQrFWmeVSCTx+/cECn9P
	2pbPyuIDHWPd4orGlV09MK8AwPhDXmZ9SH2me8GATQqO8WIKTKqkbm6cQ6l46iF9
	JwQfXySU87ljxXtrCc7nVipVvoXwzvdit1d6hgMYLU3WG+Blb3u5DoMizAm0O2Wn
	1UIOcLwAKv3r1TnxuLFJjhiZyWoI1eCu2FQu+cdkaWmgsv3+Z15o31MQucSSt9hr
	E1GA75yzvhiiw9Q1rM8uXoVGtKhPhNj2Y2dFcvNdj4C4ZqyYnagAAaqYc4YdZMh7
	NMNvBoTLPYCx+j+T5qRLhM4CiYx0Kw1mAqx17xKoSLdxW5f3oxKF18HTznQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe3gh1r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 00:56:58 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6980uvLw1477126;
	Thu, 8 Oct 2026 00:56:57 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-subashab-lv.qualcomm.com [10.81.24.15])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 6980uufo1477112
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 00:56:57 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 212624)
	id 9D956AC2; Wed,  7 Oct 2026 17:56:56 -0700 (PDT)
From: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net
Cc: horms@kernel.org, skhan@linuxfoundation.org, rdunlap@infradead.org,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
        Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Subject: [PATCH net-next v2 1/8] net: qualcomm: rmnet: Update MTU handling during format changes
Date: Wed,  7 Oct 2026 17:55:38 -0700
Message-Id: <20261008005543.2630828-2-subash.a.kasiviswanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008005543.2630828-1-subash.a.kasiviswanathan@oss.qualcomm.com>
References: <20261008005543.2630828-1-subash.a.kasiviswanathan@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=NchzRGD4 c=1 sm=1 tr=0 ts=6ac6ea5a cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=_JhEvHSw3KasBaqBxLkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAwMyBTYWx0ZWRfX321ntnA+ZhzK
 FLRoqFTX2ZZBZQHWaYNbCy1D8u42k/f9CqFH1Us2kzZ3QTTRwpX6HA+edKh54ScafewAKjT1hBL
 RPNXk7yEgcUTZ5yovZ59ZOJHTimk0AU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAwMyBTYWx0ZWRfX/o7bTOa6eEVx
 68uE/EjJcZW7lRWrMFQE1FMXxuv7wKoC82BXtIud/zCztEeaG7fWHDSVYWLhUHR3kfnQIA/2oGb
 vwEqYz4xigt83mbFsUyXfhu2pKBMJT74/YGj5+1NGQmt2HRk/R8uRTGuMq0CiJmkgERGCHLQfxE
 RBGeX7y4fu6umwydv9WJPVffRs26vhPe5BzlXwSdVelc6fIGpdrbPb9iasc3SPgWLblR8mbfI7u
 QMRoiL/4bFwU7Q51YnUzf49Kny9dA1Pr+BLwLic/OY4EpRYKUGyv6CSaX2kadlKPrRYGOVlgLZu
 sABIEWlag0+AwVNkvxaHYSfFs90FW1kcLq0ZPzj/ZtCVMmQw/Np4Ztk5kb13IxTR1FOmH2/b8QK
 wzYU6qcnMs1jkCLpYG7ha4VZ+EVuU8EBJ9brTLEIT52fvGgH5JrurLC3JA630OpicOfffisQaq9
 z5gY0V5EtyYIfRsuMrg==
X-Proofpoint-ORIG-GUID: L0RAqxboo8-1Lqb2HgIkBXDmYaeAt5ON
X-Proofpoint-GUID: L0RAqxboo8-1Lqb2HgIkBXDmYaeAt5ON
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080003

Calculate the MTU headroom from the requested data format when creating
an rmnet device. Resize existing endpoint MTUs when a newlink or changelink
requests a format that requires a smaller MTU.

Pass the requested format through the MTU helpers so the first device and
existing devices use the same headroom calculation. Validate the target MTU
before resizing existing endpoints and publish the new shared data format
only after all MTUs have been updated.

Co-developed-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
---
v2:
  - newly added patch in v2
  - fixes the pre-existing issue about MTU handling with data format
    updates as reported by Sashiko

 .../ethernet/qualcomm/rmnet/rmnet_config.c    | 55 +++++++++------
 .../net/ethernet/qualcomm/rmnet/rmnet_vnd.c   | 68 +++++++++++++------
 .../net/ethernet/qualcomm/rmnet/rmnet_vnd.h   |  4 +-
 3 files changed, 81 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index 61b04c6c0390..e5a6289b018a 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -143,6 +143,14 @@ static int rmnet_newlink(struct net_device *dev,
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
 	ep = kzalloc_obj(*ep);
 	if (!ep)
 		return -ENOMEM;
@@ -154,7 +162,8 @@ static int rmnet_newlink(struct net_device *dev,
 		goto err0;
 
 	port = rmnet_get_port_rtnl(real_dev);
-	err = rmnet_vnd_newlink(mux_id, dev, port, real_dev, ep, extack);
+	err = rmnet_vnd_newlink(mux_id, dev, port, real_dev, ep, extack,
+				data_format);
 	if (err)
 		goto err1;
 
@@ -162,24 +171,23 @@ static int rmnet_newlink(struct net_device *dev,
 	if (err < 0)
 		goto err2;
 
+	/* Update existing MTUs before publishing the shared data format. */
+	err = rmnet_vnd_update_dev_mtu(port, real_dev, data_format);
+	if (err)
+		goto err3;
+
 	port->rmnet_mode = mode;
 	port->rmnet_dev = dev;
 
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
 
 	return 0;
 
+err3:
+	netdev_upper_dev_unlink(real_dev, dev);
 err2:
 	unregister_netdevice(dev);
 	rmnet_vnd_dellink(mux_id, port, ep);
@@ -301,9 +309,13 @@ static int rmnet_changelink(struct net_device *dev, struct nlattr *tb[],
 			    struct netlink_ext_ack *extack)
 {
 	struct rmnet_priv *priv = netdev_priv(dev);
+	struct ifla_rmnet_flags *flags;
 	struct net_device *real_dev;
 	struct rmnet_port *port;
+	u32 old_data_format;
+	u32 data_format;
 	u16 mux_id;
+	int err;
 
 	if (!dev)
 		return -ENODEV;
@@ -320,6 +332,13 @@ static int rmnet_changelink(struct net_device *dev, struct nlattr *tb[],
 
 	port = rmnet_get_port_rtnl(real_dev);
 
+	if (data[IFLA_RMNET_FLAGS]) {
+		old_data_format = READ_ONCE(port->data_format);
+		flags = nla_data(data[IFLA_RMNET_FLAGS]);
+		data_format = old_data_format & ~flags->mask;
+		data_format |= flags->flags & flags->mask;
+	}
+
 	if (data[IFLA_RMNET_MUX_ID]) {
 		mux_id = nla_get_u16(data[IFLA_RMNET_MUX_ID]);
 
@@ -346,21 +365,13 @@ static int rmnet_changelink(struct net_device *dev, struct nlattr *tb[],
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
-		WRITE_ONCE(port->data_format, data_format);
-
-		if (rmnet_vnd_update_dev_mtu(port, real_dev)) {
-			WRITE_ONCE(port->data_format, old_data_format);
+		err = rmnet_vnd_update_dev_mtu(port, real_dev, data_format);
+		if (err) {
 			NL_SET_ERR_MSG_MOD(extack, "Invalid MTU on real dev");
-			return -EINVAL;
+			return err;
 		}
+
+		WRITE_ONCE(port->data_format, data_format);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
index 5f921cddf82b..d23f74b0aa47 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
@@ -66,27 +66,25 @@ static netdev_tx_t rmnet_vnd_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
-static int rmnet_vnd_headroom(struct rmnet_port *port)
+static int rmnet_vnd_headroom(u32 data_format)
 {
 	u32 headroom;
 
 	headroom = sizeof(struct rmnet_map_header);
 
-	if (port->data_format & RMNET_FLAGS_EGRESS_MAP_CKSUMV4)
+	if (data_format & RMNET_FLAGS_EGRESS_MAP_CKSUMV4)
 		headroom += sizeof(struct rmnet_map_ul_csum_header);
 
 	return headroom;
 }
 
-static int rmnet_vnd_change_mtu(struct net_device *rmnet_dev, int new_mtu)
+static int rmnet_vnd_change_mtu_with_format(struct net_device *rmnet_dev,
+					    int new_mtu, u32 data_format)
 {
 	struct rmnet_priv *priv = netdev_priv(rmnet_dev);
-	struct rmnet_port *port;
 	u32 headroom;
 
-	port = rmnet_get_port_rtnl(priv->real_dev);
-
-	headroom = rmnet_vnd_headroom(port);
+	headroom = rmnet_vnd_headroom(data_format);
 
 	if (new_mtu < 0 || new_mtu > RMNET_MAX_PACKET_SIZE ||
 	    new_mtu > (priv->real_dev->mtu - headroom))
@@ -96,6 +94,17 @@ static int rmnet_vnd_change_mtu(struct net_device *rmnet_dev, int new_mtu)
 	return 0;
 }
 
+static int rmnet_vnd_change_mtu(struct net_device *rmnet_dev, int new_mtu)
+{
+	struct rmnet_priv *priv = netdev_priv(rmnet_dev);
+	struct rmnet_port *port;
+
+	port = rmnet_get_port_rtnl(priv->real_dev);
+
+	return rmnet_vnd_change_mtu_with_format(rmnet_dev, new_mtu,
+						READ_ONCE(port->data_format));
+}
+
 static int rmnet_vnd_get_iflink(const struct net_device *dev)
 {
 	struct rmnet_priv *priv = netdev_priv(dev);
@@ -308,8 +317,7 @@ int rmnet_vnd_newlink(u8 id, struct net_device *rmnet_dev,
 		      struct rmnet_port *port,
 		      struct net_device *real_dev,
 		      struct rmnet_endpoint *ep,
-		      struct netlink_ext_ack *extack)
-
+		      struct netlink_ext_ack *extack, u32 data_format)
 {
 	struct rmnet_priv *priv = netdev_priv(rmnet_dev);
 	u32 headroom;
@@ -326,9 +334,11 @@ int rmnet_vnd_newlink(u8 id, struct net_device *rmnet_dev,
 
 	priv->real_dev = real_dev;
 
-	headroom = rmnet_vnd_headroom(port);
+	headroom = rmnet_vnd_headroom(data_format);
 
-	if (rmnet_vnd_change_mtu(rmnet_dev, real_dev->mtu - headroom)) {
+	if (rmnet_vnd_change_mtu_with_format(rmnet_dev,
+					     real_dev->mtu - headroom,
+					     data_format)) {
 		NL_SET_ERR_MSG_MOD(extack, "Invalid MTU on real dev");
 		return -EINVAL;
 	}
@@ -375,17 +385,15 @@ int rmnet_vnd_do_flow_control(struct net_device *rmnet_dev, int enable)
 	return 0;
 }
 
-int rmnet_vnd_validate_real_dev_mtu(struct net_device *real_dev)
+static int rmnet_vnd_validate_mtu(struct rmnet_port *port,
+				  struct net_device *real_dev, u32 data_format)
 {
 	struct hlist_node *tmp_ep;
 	struct rmnet_endpoint *ep;
-	struct rmnet_port *port;
 	unsigned long bkt_ep;
 	u32 headroom;
 
-	port = rmnet_get_port_rtnl(real_dev);
-
-	headroom = rmnet_vnd_headroom(port);
+	headroom = rmnet_vnd_headroom(data_format);
 
 	hash_for_each_safe(port->muxed_ep, bkt_ep, tmp_ep, ep, hlnode) {
 		if (ep->egress_dev->mtu > (real_dev->mtu - headroom))
@@ -395,23 +403,39 @@ int rmnet_vnd_validate_real_dev_mtu(struct net_device *real_dev)
 	return 0;
 }
 
+int rmnet_vnd_validate_real_dev_mtu(struct net_device *real_dev)
+{
+	struct rmnet_port *port;
+
+	port = rmnet_get_port_rtnl(real_dev);
+
+	return rmnet_vnd_validate_mtu(port, real_dev,
+				      READ_ONCE(port->data_format));
+}
+
 int rmnet_vnd_update_dev_mtu(struct rmnet_port *port,
-			     struct net_device *real_dev)
+			     struct net_device *real_dev, u32 data_format)
 {
 	struct hlist_node *tmp_ep;
 	struct rmnet_endpoint *ep;
 	unsigned long bkt_ep;
 	u32 headroom;
+	int new_mtu;
 
-	headroom = rmnet_vnd_headroom(port);
+	headroom = rmnet_vnd_headroom(data_format);
+	if (real_dev->mtu < headroom)
+		return -EINVAL;
+
+	new_mtu = real_dev->mtu - headroom;
+	if (new_mtu > RMNET_MAX_PACKET_SIZE)
+		return -EINVAL;
 
 	hash_for_each_safe(port->muxed_ep, bkt_ep, tmp_ep, ep, hlnode) {
-		if (ep->egress_dev->mtu <= (real_dev->mtu - headroom))
+		if (ep->egress_dev->mtu <= new_mtu)
 			continue;
 
-		if (rmnet_vnd_change_mtu(ep->egress_dev,
-					 real_dev->mtu - headroom))
-			return -1;
+		/* The target MTU was validated before updating any endpoint. */
+		WRITE_ONCE(ep->egress_dev->mtu, new_mtu);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.h b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.h
index c2b2baf86894..901ef36900ac 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.h
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.h
@@ -12,7 +12,7 @@ int rmnet_vnd_newlink(u8 id, struct net_device *rmnet_dev,
 		      struct rmnet_port *port,
 		      struct net_device *real_dev,
 		      struct rmnet_endpoint *ep,
-		      struct netlink_ext_ack *extack);
+		      struct netlink_ext_ack *extack, u32 data_format);
 int rmnet_vnd_dellink(u8 id, struct rmnet_port *port,
 		      struct rmnet_endpoint *ep);
 void rmnet_vnd_rx_fixup(struct sk_buff *skb, struct net_device *dev);
@@ -21,5 +21,5 @@ void rmnet_vnd_tx_fixup(struct sk_buff *skb, struct net_device *dev);
 void rmnet_vnd_setup(struct net_device *dev);
 int rmnet_vnd_validate_real_dev_mtu(struct net_device *real_dev);
 int rmnet_vnd_update_dev_mtu(struct rmnet_port *port,
-			     struct net_device *real_dev);
+			     struct net_device *real_dev, u32 data_format);
 #endif /* _RMNET_VND_H_ */
-- 
2.34.1

