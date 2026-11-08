Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794124760;
	b=Fa7/dPXzOQMdw8+mxzYrqOU+QzipqhlxwOjdMWUv8xernNHmcyhpvjGseN/CICoVEVc8
	 lPBMAyIOjKKPpPcpw9aPw1+tNvXtGtfHyKkkqFtNkC3ajhTCbJGurgdzo6871XL9tWrHB
	 0swnS7pBGbBiMk1Bc/5H8W0LYW7zWN+FsjkmpMPSh+TrUCN4umewsmqnc3RiCnhvN78oC
	 D+7vWIPicbKGTeV5v1UVgFQdlYZha39J5vo+iUDgTr1mm1E0XDdBSbK+Xn4xdhrXpcgCN
	 zmYeSTKG0UzZLntjhyij/Cx/rclPTkOOqaoBuW61ipDKyJcm0BZu4kQyVAFaLqXoynA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794124760;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=bhaiyNTM7dQ4IZgQIlKlyFTkYaFmAwSf/S6pN/JTBFM=;
	b=tGJqJFDhVYGXL59GDiogqPCEcwgGpMzAx8aiFfEWsGDqnoy07A/54yPuDI7cvd8KsOIs
	 NqsZjRYuVfuMTtta9LjqzMz3T/A/f0Y7bKELiVvPtGWKm1ybfb+dk3mC8Sehl0727/IzB
	 HBEUUe1EiH2eQLv+dGds/87SuFC6bINln2s8R8p1JKAAehkMpF1MlmPf3rNnpNKK47z00
	 c5e8L6lbCN1mm+gE+RtH9yAxxpbo4YGbS6adphGyKyzeUCyrspCcj77Ep8H7HTkEKUFZo
	 63RfXsec78ZZuhzHeogtQQCsMjcpELSfbJCk7BzQY7YtWvolm9P0z8p8VywCDOiaMPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Kty0yNFS;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4DF606A320;
	Sun,  8 Nov 2026 07:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E4DF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Kty0yNFS
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A87eLl91494168;
	Sun, 8 Nov 2026 07:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=bhaiyNTM7dQ4IZgQIlKlyFTkYaFmAwSf/S6
	pN/JTBFM=; b=Kty0yNFSLq42z0Kv4tZGIb1jygGJVZf9qIoPMrgaErpKZuOn26b
	ewmX8arEa50goTBAL4UGwrtxxbRS3A8QXSAxLj9FVAEZV3zdQeLtbjLDm8US6nMM
	2+HH4z1oy4LVN8KKKb+zRMFJ/nvA4Ios6dWZkvCuIupy+uGNGP50WGbRaIV6SqGz
	t0wMRxwRCrw8+d/fVjvVJ/NqpmzQrzL+KwhVByGPkgMb6Cv3wZI/q4Pd4KWJxRQH
	lSu/G4DeEW5fSERJmWtZs+TYdsntDGfI/Bvm/0Xbd4fI6drf9rnGHFRkIfdCUzAJ
	VxQahCobgAS6ikeGP9UloxLWN1pUYxuL2FA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsu06tp0v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 08 Nov 2026 07:59:10 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A87xAlN3633019;
	Sun, 8 Nov 2026 07:59:10 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-subashab-lv.qualcomm.com [10.81.24.15])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 6A87x9pg3633010
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 08 Nov 2026 07:59:09 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 212624)
	id 6DD64AD3; Sat,  7 Nov 2026 23:59:09 -0800 (PST)
From: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
To: sean.tranchetti@oss.qualcomm.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
        pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
Subject: [PATCH net v4] net: qualcomm: rmnet: Update MTU handling during format changes
Date: Sat,  7 Nov 2026 23:57:27 -0800
Message-Id: <20261108075727.2031331-1-subash.a.kasiviswanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAzMSBTYWx0ZWRfXyfuMpGHqSQjA
 EG+BsSweGR8J0+Fm/9xW1sGandfRPFNahKJIVGmFks0pfRYjMwuNM8s4O1B2O4vOHm2peitSxww
 nx8YEJcJ6rufPWs44OcqazqB4lXphz5QoVaz3mrMbWyZdpTpuDXLorWEfMk/J+hK4XwBfvb5K7W
 53fKsJ3Es60DHlWyM0NDXGv+m1HPLwxVwd1mvvAaqE5252aJ4WqpVzxPgQa1XIpgdarFduTh/k1
 vSjhTTRKwIgngIZAgLTIg6GNqdUsR6FvUOyrNT9ejTluKusuaIgQZdqBl9IzcHiG/bX66HwsyBJ
 6wHa01o7R+1Ytqw8s/SI8YczuIaxw6bpXJI6Fe6260wp7uSlpLIsZcZhkIk7km41xJFDAmON6pM
 Sx/5fWTFnRNAlmr5nor3NxqylfZr/EfvddQ92jqlytOqg8G5GOXmz3I78SkHX/5m9xF3XoWkkz/
 B0QQtGZK5zb+mXt6EfQ==
X-Proofpoint-GUID: 8r6tlJ5OmbsF0r-oiT83IklxHkQWfATJ
X-Authority-Analysis: v=2.4 cv=IJGXmQvG c=1 sm=1 tr=0 ts=6af02bce cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=9sqiCGoxxatN-Bsj0I4A:9
X-Proofpoint-ORIG-GUID: 8r6tlJ5OmbsF0r-oiT83IklxHkQWfATJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDAzMSBTYWx0ZWRfXzW6vMt7It67o
 XhWp5qaE6mH81XBMfkHw6JGLthssuEO+0IIxwIeK/V2pFKY6Omt0VHU+liDSsrank/q5qO5INj4
 yC68XA9u0NbrN1COXo/isFC0/V4prGc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-08_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080031

rmnet derives the MTU of its devices from the real device MTU minus the
headroom needed by the egress data format. Several problems exist in
how this is handled when the data format is set or changed:

- The headroom only accounts for the V4 egress checksum header and
  ignores the V5 one, so devices using V5 checksum offload get an MTU
  that is too large for the real device.
- rmnet_newlink() sizes the first device from the port's data format
  before the requested IFLA_RMNET_FLAGS have been applied, so the MTU
  does not match the format that ends up being used.
- A real device MTU smaller than the headroom underflows the unsigned
  subtraction, and a real device with a jumbo MTU makes the creation of
  the first device fail while resizing an existing one clamps it.
- Existing endpoints are shrunk by writing dev->mtu directly. No MTU
  notifiers run and userspace gets no link notification. The helper
  also returns -1, and changelink flattens every failure into -EINVAL.
- rmnet_changelink() publishes the new data format before resizing the
  endpoints and reverts it on failure, so the datapath can observe a
  format whose headers do not fit the MTUs. A failed resize can also
  leave some endpoints shrunk, and a mux_id change requested in the
  same call is kept even though the call returned an error.

Fix these by calculating the headroom from the requested data format,
including the V5 checksum header, and passing that format through the
MTU helpers so that new and existing devices use the same calculation.
Apply IFLA_RMNET_FLAGS before sizing the first device, reject real
device MTUs below the headroom before doing any arithmetic, and clamp
the target to RMNET_MAX_PACKET_SIZE for both new and existing devices.

Resize existing endpoints with dev_set_mtu() so that the normal MTU
notifiers and userspace link notifications are delivered. If resizing
an endpoint fails, restore the endpoints which were already resized and
ignore any errors from the restore, and return the error to the caller
with a message that is not specific to the real device MTU.

Publish the new shared data format only after all MTUs have been
updated, and in rmnet_changelink() move the endpoint to a new mux_id
only after the checks and the MTU update have succeeded, so that a
failed request does not leave a partial change behind.

Fixes: b7f5eb6ba21b ("net: qualcomm: rmnet: Update rmnet device MTU based on real device")
Fixes: b6e5d27e32ef ("net: ethernet: rmnet: Add support for MAPv5 egress packets")
Assisted-by: LLM
Co-developed-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
---
v4: Separated patch from the coalescing series into a standalone fix for
mtu behavior. This addresses the comments raised by Sashiko to honor the
room required for MAPv5 format, better aritmetic handling and more
checks for cases where the real device MTU exceeds RMNET_MAX_PACKET_SIZE.
v3: https://lore.kernel.org/all/20261009084351.317632-2-subash.a.kasiviswanathan@oss.qualcomm.com/
v2: https://lore.kernel.org/all/20261008005543.2630828-2-subash.a.kasiviswanathan@oss.qualcomm.com/

 .../ethernet/qualcomm/rmnet/rmnet_config.c    |  77 +++++++-----
 .../ethernet/qualcomm/rmnet/rmnet_config.h    |   1 +
 .../net/ethernet/qualcomm/rmnet/rmnet_vnd.c   | 110 +++++++++++++-----
 .../net/ethernet/qualcomm/rmnet/rmnet_vnd.h   |   4 +-
 4 files changed, 133 insertions(+), 59 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index 61b04c6c0390..9e66f3804de4 100644
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
 
@@ -162,24 +171,25 @@ static int rmnet_newlink(struct net_device *dev,
 	if (err < 0)
 		goto err2;
 
+	/* Update existing MTUs before publishing the shared data format. */
+	err = rmnet_vnd_update_dev_mtu(port, real_dev, data_format);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to update MTU of rmnet devices");
+		goto err3;
+	}
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
@@ -301,9 +311,14 @@ static int rmnet_changelink(struct net_device *dev, struct nlattr *tb[],
 			    struct netlink_ext_ack *extack)
 {
 	struct rmnet_priv *priv = netdev_priv(dev);
+	struct rmnet_endpoint *ep = NULL;
+	struct ifla_rmnet_flags *flags;
 	struct net_device *real_dev;
 	struct rmnet_port *port;
+	u32 old_data_format;
+	u32 data_format;
 	u16 mux_id;
+	int err;
 
 	if (!dev)
 		return -ENODEV;
@@ -320,12 +335,17 @@ static int rmnet_changelink(struct net_device *dev, struct nlattr *tb[],
 
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
 
 		if (mux_id != priv->mux_id) {
-			struct rmnet_endpoint *ep;
-
 			ep = rmnet_get_endpoint(port, priv->mux_id);
 			if (!ep)
 				return -ENODEV;
@@ -335,32 +355,29 @@ static int rmnet_changelink(struct net_device *dev, struct nlattr *tb[],
 						   "MUX ID already exists");
 				return -EINVAL;
 			}
-
-			hlist_del_init_rcu(&ep->hlnode);
-			WRITE_ONCE(ep->mux_id, mux_id);
-			hlist_add_head_rcu(&ep->hlnode,
-					   &port->muxed_ep[mux_id]);
-
-			WRITE_ONCE(priv->mux_id, mux_id);
 		}
 	}
 
 	if (data[IFLA_RMNET_FLAGS]) {
-		struct ifla_rmnet_flags *flags;
-		u32 old_data_format;
-		u32 data_format;
+		err = rmnet_vnd_update_dev_mtu(port, real_dev, data_format);
+		if (err) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Failed to update MTU of rmnet devices");
+			return err;
+		}
 
-		old_data_format = port->data_format;
-		flags = nla_data(data[IFLA_RMNET_FLAGS]);
-		data_format = old_data_format & ~flags->mask;
-		data_format |= flags->flags & flags->mask;
 		WRITE_ONCE(port->data_format, data_format);
+	}
 
-		if (rmnet_vnd_update_dev_mtu(port, real_dev)) {
-			WRITE_ONCE(port->data_format, old_data_format);
-			NL_SET_ERR_MSG_MOD(extack, "Invalid MTU on real dev");
-			return -EINVAL;
-		}
+	/* Nothing below can fail, so move the endpoint only after all the
+	 * checks and the MTU update have succeeded.
+	 */
+	if (ep) {
+		hlist_del_init_rcu(&ep->hlnode);
+		WRITE_ONCE(ep->mux_id, mux_id);
+		hlist_add_head_rcu(&ep->hlnode, &port->muxed_ep[mux_id]);
+
+		WRITE_ONCE(priv->mux_id, mux_id);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
index 5adda0323dda..47b8db3206b9 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
@@ -19,6 +19,7 @@ struct rmnet_endpoint {
 	struct net_device *egress_dev;
 	struct hlist_node hlnode;
 	struct rcu_head rcu;
+	int saved_mtu;
 };
 
 struct rmnet_egress_agg_params {
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
index 5f921cddf82b..dce436e4c630 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
@@ -66,29 +66,44 @@ static netdev_tx_t rmnet_vnd_start_xmit(struct sk_buff *skb,
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
+	else if (data_format & RMNET_FLAGS_EGRESS_MAP_CKSUMV5)
+		headroom += sizeof(struct rmnet_map_v5_csum_header);
 
 	return headroom;
 }
 
-static int rmnet_vnd_change_mtu(struct net_device *rmnet_dev, int new_mtu)
+/* Largest MTU an rmnet device can use on top of real_dev for the given data
+ * format, or -EINVAL if real_dev cannot even fit the headers.
+ */
+static int rmnet_vnd_target_mtu(struct net_device *real_dev, u32 data_format)
 {
-	struct rmnet_priv *priv = netdev_priv(rmnet_dev);
-	struct rmnet_port *port;
 	u32 headroom;
 
-	port = rmnet_get_port_rtnl(priv->real_dev);
+	headroom = rmnet_vnd_headroom(data_format);
+	if (real_dev->mtu < headroom)
+		return -EINVAL;
+
+	return min_t(int, real_dev->mtu - headroom, RMNET_MAX_PACKET_SIZE);
+}
+
+static int rmnet_vnd_change_mtu_with_format(struct net_device *rmnet_dev,
+					    int new_mtu, u32 data_format)
+{
+	struct rmnet_priv *priv = netdev_priv(rmnet_dev);
+	u32 headroom;
 
-	headroom = rmnet_vnd_headroom(port);
+	headroom = rmnet_vnd_headroom(data_format);
 
-	if (new_mtu < 0 || new_mtu > RMNET_MAX_PACKET_SIZE ||
+	if (priv->real_dev->mtu < headroom ||
+	    new_mtu < 0 || new_mtu > RMNET_MAX_PACKET_SIZE ||
 	    new_mtu > (priv->real_dev->mtu - headroom))
 		return -EINVAL;
 
@@ -96,6 +111,17 @@ static int rmnet_vnd_change_mtu(struct net_device *rmnet_dev, int new_mtu)
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
@@ -308,11 +334,10 @@ int rmnet_vnd_newlink(u8 id, struct net_device *rmnet_dev,
 		      struct rmnet_port *port,
 		      struct net_device *real_dev,
 		      struct rmnet_endpoint *ep,
-		      struct netlink_ext_ack *extack)
-
+		      struct netlink_ext_ack *extack, u32 data_format)
 {
 	struct rmnet_priv *priv = netdev_priv(rmnet_dev);
-	u32 headroom;
+	int new_mtu;
 	int rc;
 
 	if (rmnet_get_endpoint(port, id)) {
@@ -326,9 +351,9 @@ int rmnet_vnd_newlink(u8 id, struct net_device *rmnet_dev,
 
 	priv->real_dev = real_dev;
 
-	headroom = rmnet_vnd_headroom(port);
-
-	if (rmnet_vnd_change_mtu(rmnet_dev, real_dev->mtu - headroom)) {
+	new_mtu = rmnet_vnd_target_mtu(real_dev, data_format);
+	if (new_mtu < 0 ||
+	    rmnet_vnd_change_mtu_with_format(rmnet_dev, new_mtu, data_format)) {
 		NL_SET_ERR_MSG_MOD(extack, "Invalid MTU on real dev");
 		return -EINVAL;
 	}
@@ -375,17 +400,17 @@ int rmnet_vnd_do_flow_control(struct net_device *rmnet_dev, int enable)
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
+	if (real_dev->mtu < headroom)
+		return -EINVAL;
 
 	hash_for_each_safe(port->muxed_ep, bkt_ep, tmp_ep, ep, hlnode) {
 		if (ep->egress_dev->mtu > (real_dev->mtu - headroom))
@@ -395,24 +420,55 @@ int rmnet_vnd_validate_real_dev_mtu(struct net_device *real_dev)
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
+	struct rmnet_endpoint *fail_ep = NULL;
 	struct hlist_node *tmp_ep;
 	struct rmnet_endpoint *ep;
 	unsigned long bkt_ep;
-	u32 headroom;
+	int new_mtu;
+	int err = 0;
 
-	headroom = rmnet_vnd_headroom(port);
+	new_mtu = rmnet_vnd_target_mtu(real_dev, data_format);
+	if (new_mtu < 0)
+		return new_mtu;
 
 	hash_for_each_safe(port->muxed_ep, bkt_ep, tmp_ep, ep, hlnode) {
-		if (ep->egress_dev->mtu <= (real_dev->mtu - headroom))
+		ep->saved_mtu = ep->egress_dev->mtu;
+		if (ep->saved_mtu <= new_mtu)
 			continue;
 
-		if (rmnet_vnd_change_mtu(ep->egress_dev,
-					 real_dev->mtu - headroom))
-			return -1;
+		err = dev_set_mtu(ep->egress_dev, new_mtu);
+		if (err) {
+			fail_ep = ep;
+			break;
+		}
 	}
 
-	return 0;
+	if (!err)
+		return 0;
+
+	/* Restore the endpoints which were already resized. Failures here
+	 * are ignored since the original error is the one to report.
+	 */
+	hash_for_each_safe(port->muxed_ep, bkt_ep, tmp_ep, ep, hlnode) {
+		if (ep == fail_ep)
+			break;
+
+		if (ep->egress_dev->mtu != ep->saved_mtu)
+			dev_set_mtu(ep->egress_dev, ep->saved_mtu);
+	}
+
+	return err;
 }
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

