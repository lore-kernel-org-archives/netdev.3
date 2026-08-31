Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013060.outbound.protection.outlook.com [40.107.162.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CDB3AEF56;
	Mon, 31 Aug 2026 03:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788146550; cv=fail; b=GifPvncDkEK2mdS4GXTjzzmVn3AZ/2Q4pXIU3wfis2iB+1/+FSH6Kqm4fmVGuA6tke/GFdnckccynDl+4m3+AeVpj5mi37h56meSJCRRLZi+ekImw6pdfira6F5yajrIzNvOgcxoPjEAH/U6wrLVQyTcr6S4hMOHdbWWiTaRvmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788146550; c=relaxed/simple;
	bh=nsr/PMyuxnzeH4hPWXdjomrzNcQIk7qZyWtRKB2a/aE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oc7kUC/d9q1wWZQcXZhySkpjXKpWWF5Ul/V1DVag5piRmT3qXW7aZDknH8s9xs8VlwDlGHrECi8CBIyFxL1Q4FFQE46kOv5ThrPdCkYCkAzEr8z8S0yt8fWSuSmpA+xQA0Gxnty633KKYPOko4OA5RBTj4cE76ss3cUgCjGJTio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YaAbGE/c; arc=fail smtp.client-ip=40.107.162.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YaAbGE/c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGl5VtxjpMsHVvEB9wIXVf28bZ/gyCmzY1G1onFCxH0t79hk0FU6KShHO57ZVdscWlS5iZh1d6Dz6Y9kaXC8UY296iGJcsEfPB2RBGzpHGJDxQHjGauOZL5wj5GzxnF6qvvFFgwIgDlXlIb7ZgFXWnZcUqardbUrfHRLG3Vm4cxnJu2wiLKfnrt/DMp6Oql4EF713dECE/0dG5eweT+Kg3yPf6HYFEAu4DPYD0IsSS/7viHidE82Khz0jSdfM/GL14NHE5hV5gPgnPPa9tPoJt2ML4GrjmtWmbi/gnW4gjzIfQDfeCbTPrjU7tUPwo1IcCkoYaxr6VZ8e37uEtzkWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrNy7jSNS0K+Fo1N5evBA0PAVCroRDP022I5qTm9PsA=;
 b=xA7xCl9da4Nv0PHLFmY91sqONhCpecLeDp48JbvJ7V/KoxQTttHRGjyTaT8CqBUteUvUeLkmS5zfyQJNtsGdJpZlh/wqzVM3MXlmb6Twr2vGZRnQwJJOXiy81o4lzV4Gf28sm5Z6jNMjFKbxhQzEku3PoxZHc6hETZyGii/r9E9Xw5mKgwnTVLVgoNEhMvSz6dVoQgLdkJrj9Ggj+volMGVodzhskuND5DVGLtx0cBqJbgEt5DX/ynlLu0r0bpNZi2cLSyuWkWPnhRxRRiH+VmAGKO4joJffNB4mtmpjH2lO6WBUpy4Qonc+FOw5c0zyvn9ghDaY4J9KNCuecCKFkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrNy7jSNS0K+Fo1N5evBA0PAVCroRDP022I5qTm9PsA=;
 b=YaAbGE/cquD+sGrYwCvmZs/RB72EhyYErt0oucgyrHXo3cjh7CxACk7yWwjPBM7w0t3OL0VKN1TYIeXWMw/VGoBcTHxk+YJsJpEZCF5P7aRY6hc5sWHGDbkirBG0JE04n4xXPNIQ2GhJvYMc5wMxujY+6vvEVQLbpOZ3dk5g3fMCbb7XkgxNttxRknmbuLEjHlVF6HNcESUtqWYm0p3TDScMUkQ5g/v+ZJTvD9Yb4SOMbnnyBA6msvsM4JChnowedBfX0zzQjwrtQ5inkV5PHNOT7dW61ZDlYNK/H7fOabWm8mbSyV1Q4dzmldg9DYjjQ3ZzrD9QMxgnXc7qUK5qeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DB9PR04MB9234.eurprd04.prod.outlook.com (2603:10a6:10:372::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 03:22:26 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 03:22:26 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 01/15] net: enetc: add trusted VF support
Date: Mon, 31 Aug 2026 10:54:27 +0800
Message-Id: <20260831025441.635045-2-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831025441.635045-1-wei.fang@oss.nxp.com>
References: <20260831025441.635045-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DB9PR04MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: 77c3b940-7f60-4ae7-c662-08df070f1485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|23010399003|1800799024|7416014|376014|10067099003|6133799003|3023799007|18002099003|22082099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	ECjtoASk6qEIvN1ua8fGfRHmJmc8SFc0DXewEnOyy7yAP7iJa7Hd2UbEV3JEqA1E+D2Rie+6Wd6DxIiIaNIWS50bGWNqjUqtO81vEYbWoyT8d0nU0CiGFLV2D2PewE0V+19BgB5DP18zgj7tIvYaf/P4LR2g6gC6K+/UA7G9jS0BtDwXYLhHoslLMBC9iXnF5KHm0Tx9jPoE9cuwqkY4/zWBnxLXx6BfqnzNNz+oWVps9TPJhZ4qIsWUZHV8UU6uMMrua/7UaA0ZYOxsrVS8TUm6dP4dWv0lBXBQna6T1pzApp71mUBjGTtDqvy0hgvuAsMmhwYh+9X42mxvUpVXRaw7T763bQiP44wx9Co+O4ohGSFGTVxpWHTNhTBV1WeM/oxPSbWfC+DbSBNxYYIURTrTMQjF2KQqhIW0nIZTBz6dXhBsdSKx78dKRz8xojFLX795rzp3MoCIL14dqxqCwLgVfJbXOu3gNb16NLYHKLVk43lhvakaXFZuEniDOOK7BKDzIKfwFRuNlouunAw5gyOt/XG9grA4oOVD5M6lhgvkZmLbkyTFO9O86c5kx5K00TRToNV3YwwDmYe9dxbMx5QCzz+23Ky1rxhIhaIzdhQDwcxNtG7SmaaZt8u2cpbxUbelQLtiHGlyiFOBKoHBAaqBqqGtBAfnRhlDGx89Z1DUytg1XD0Lr/UPSPlVLnh7p8Qqskpf1sY2HeUq4ZLRKw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(23010399003)(1800799024)(7416014)(376014)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JHEMdK/tUlMHXOormRlGQmTup1KvrJxTkZH/uFEDPWTvYc8wEYLTyB4duElM?=
 =?us-ascii?Q?b3eBldcjcDGM88ZfpuYY/yNZAd0jk5AXHIjnFiuLM02lLvQZ2uGTGG/DoCik?=
 =?us-ascii?Q?EpPNSkBS0gt4ZcOtbPZd1xl8y0WEB1RWXSPtXqw8cHPEZKx1xYwDoViexOMc?=
 =?us-ascii?Q?4PRSXSOM6u6HtacZLlh/AoRl6MRgLuDoIk+UpyYsUKbPL6nhckYNc5uHEFBR?=
 =?us-ascii?Q?gM83px17NhsVaIVGQBAhAncnoNtBqsWX75qBAm7p5eaTKPTQp53BvKMRjyx+?=
 =?us-ascii?Q?tviLAgw2gqy+wDYSPaJefZlxdToZNzVgN9S6q4dE74ybLNXnhlTrC/zvqiGW?=
 =?us-ascii?Q?Vew/O5i7CYz1HRqRmradCbxAEczJsXNZmAVAlyM8LEaG+OrBWI+s1lyWSwGh?=
 =?us-ascii?Q?sYS954zA7GcnuuNhqT/rC02x19epUO6UIA4iTfwGKiSKe9oK+hIJIbuMna4j?=
 =?us-ascii?Q?BcZts7MqfenHmOH85iqqXpcCk22e2IR+gtrozb7AN38XTmoVUDMpCjQ70RPQ?=
 =?us-ascii?Q?iDY6ze9gqMYPFCgbnscQe9xjA+/vyCYBpHPUuxbbvXCUH6IS/b8YWN59lt1X?=
 =?us-ascii?Q?u+jxqIXwyYY0FaqWsj9gSE3lSPquR92wxjnq3jd4xPtAeYHD1smjYF3cwEa4?=
 =?us-ascii?Q?lVUg0o3WrRrOGlknQBkqI2CJ8h2RgD5/kQomSwj3qa0fjk+Rm6eziNCZt9Pv?=
 =?us-ascii?Q?Eh33fu3c/p6UllwkYoSM8FXSqc56vP6OjU5ugS831w3ncysmZkKf+cziRoc2?=
 =?us-ascii?Q?N7463bf78UWSZWkhnWuvAt9ncdrr6LicvKsyl1X2gR5wAeT92t1GGSDf41d4?=
 =?us-ascii?Q?1k2B3kBCcI1duvGRVu/DyydFzHMUTVnEEpf07oiNsJdKS8mTykyNbBDMu6v9?=
 =?us-ascii?Q?X850pMEiw1pIk5EshyoYtDuxigTUH0oct/GUYVyWsbWIfhZWRoaQsjG8nuBD?=
 =?us-ascii?Q?mZbpzHxWrwxL/NQelIS/iZs84a3/uViftwvqOmdpM8mCRP5EVygg2OLB7mrN?=
 =?us-ascii?Q?7qJLBqjWDiEMjGpjmmzMOMu8R+Ipean4VrgIBjfAfh6LTja8NHD8SfvjbJPt?=
 =?us-ascii?Q?2vvbdWi6pMdYeknJBjvlpTTUJEEBj/dSAcUZND1IASkJ9pz1bvrYxkTslDb3?=
 =?us-ascii?Q?wKp28vezBjGV2gCp81PPQGBWnuTWqyiL8HCn2glVd39KWflddM24dBP2uYpQ?=
 =?us-ascii?Q?ZtgC60Km9mtyAZt2YcN6EQk3QowWvPX8GuPT7F4pvO1my8LHlrZ8agtX6r+e?=
 =?us-ascii?Q?uiKd/Vf74SgIcb0IikBoRDcnhC7YBcsezj0yMSVV0pyPkpAgDUkFqEQk0NFZ?=
 =?us-ascii?Q?aW1dGpzdbu5L80pEnpxQu0T0x4ABm3o6HhXdcbrpaSN+ioULhiIGd+PoZZh6?=
 =?us-ascii?Q?oqWwqrmCVQb5CSeiT9DOVVsgPXBrQAzh+a4D5TSQGIYweUBL6Z9XS3lCa4lS?=
 =?us-ascii?Q?qMFMvfl6Qgjcr+JUvjn8JZNXa2PMZHc0h2+NUTTPH21KvPjaECW/EZK31axX?=
 =?us-ascii?Q?SYj8ks72YTjPLxmEWEqJw037/eMlL4LJSNPzmwqFqH268DwXtkaFxLssNkxT?=
 =?us-ascii?Q?vJMyTf+qkWHZpASrHdfzK0BfQmFaoVboNOwdvFJk+oQ9J+6MmTP227CuTrbO?=
 =?us-ascii?Q?qagTew9Mg+Kawl3T6V11Tm/e2tIYPuFW+yDUVEktvUk7sxai3RzEWmhYe8/c?=
 =?us-ascii?Q?lwx3ebKkC7YeImbI3SpL480MkEwrkd8OFWaVIq78xBdJ5xME+ZZHdNstmqf9?=
 =?us-ascii?Q?juAL06cclEwXJQKclgseVNvz+U2SbCXPC/GJX1yiBxe6+7NrpTS+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c3b940-7f60-4ae7-c662-08df070f1485
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 03:22:26.1919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LRtGz6ms6cJLnp3GXMI84W0gj32FZ1uqpHLI8s5A7ce6QvJDDZmxJL7qRM3huwq5zEpsTe+2/OajN1tgf2FldDTcphTtwEVdSExaK+wH4WCZXDjKeq45KEWPFVd1+GHU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9234

From: Claudiu Manoil <claudiu.manoil@nxp.com>

Some mailbox messages require a higher privilege level to be executed
on behalf of the requesting VF. Introduce a trusted VF flag
(ENETC_VF_FLAG_TRUSTED) and wire up the ndo_set_vf_trust callback via
enetc_pf_set_vf_trust(), which is shared between the enetc and enetc4
PF drivers.

The first message gated on trust is the VF primary MAC address change.
An untrusted VF that attempts to set its own MAC address will receive a
ENETC_MSG_CLASS_ID_PERMISSION_DENY response and the hardware will not
be programmed. To prevent a malicious VM from setting the VF address to
the MAC address of other VFs or PF, thereby eavesdropping on the traffic
of other SIs. Furthermore, a malicious VM that arbitrarily changes the
VF's MAC address can achieve MAC address spoofing and bypass security
policies.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  7 +++-
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 38 ++++++++++++++-----
 .../net/ethernet/freescale/enetc/enetc_pf.c   |  1 +
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  1 +
 .../freescale/enetc/enetc_pf_common.c         | 23 +++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  1 +
 6 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 9bb1004548ab..935a6a03b14f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -225,11 +225,15 @@ static const struct enetc_pf_ops enetc4_pf_ops = {
 static int enetc4_pf_struct_init(struct enetc_si *si)
 {
 	struct enetc_pf *pf = enetc_si_priv(si);
+	int err;
 
 	pf->si = si;
-	pf->total_vfs = pci_sriov_get_totalvfs(si->pdev);
 	pf->ops = &enetc4_pf_ops;
 
+	err = enetc_init_sriov_resources(pf);
+	if (err)
+		return err;
+
 	enetc4_get_port_caps(pf);
 	enetc4_get_psi_hw_features(si);
 
@@ -574,6 +578,7 @@ static const struct net_device_ops enetc4_ndev_ops = {
 	.ndo_eth_ioctl		= enetc_ioctl,
 	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
 	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
+	.ndo_set_vf_trust	= enetc_pf_set_vf_trust,
 };
 
 static struct phylink_pcs *
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index edc1277bb586..78114ab3e482 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -7,6 +7,8 @@
 					   ENETC_MSG_CLASS_ID_CMD_SUCCESS)
 #define ENETC_PF_MSG_NOTSUPP	FIELD_PREP(ENETC_PF_MSG_CLASS_ID, \
 					   ENETC_MSG_CLASS_ID_CMD_NOT_SUPPORT)
+#define ENETC_PF_MSG_PERM_DENY	FIELD_PREP(ENETC_PF_MSG_CLASS_ID, \
+					   ENETC_MSG_CLASS_ID_PERMISSION_DENY)
 
 static void enetc_msg_disable_mr_int(struct enetc_pf *pf)
 {
@@ -61,31 +63,49 @@ static u16 enetc_msg_set_vf_primary_mac_addr(struct enetc_pf *pf, int vf_id,
 	struct enetc_vf_state *vf_state = &pf->vf_state[vf_id];
 	struct enetc_msg_mac_exact_filter *msg = vf_msg;
 	struct device *dev = &pf->si->pdev->dev;
+	u16 pf_msg = ENETC_PF_MSG_SUCCESS;
 	char *addr = msg->mac[0].addr;
 
+	mutex_lock(&vf_state->lock);
+
+	/* Untrusted VFs cannot set their MAC addresses by the mailbox
+	 * messages.
+	 */
+	if (!(vf_state->flags & ENETC_VF_FLAG_TRUSTED)) {
+		pf_msg = ENETC_PF_MSG_PERM_DENY;
+		goto vf_state_unlock;
+	}
+
 	if (!is_valid_ether_addr(addr)) {
 		dev_err_ratelimited(dev, "VF%d attempted to set invalid MAC\n",
 				    vf_id);
-		return (FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
-				   ENETC_MSG_CLASS_ID_MAC_FILTER) |
-			FIELD_PREP(ENETC_PF_MSG_CLASS_CODE,
-				   ENETC_MF_CLASS_CODE_INVALID_MAC));
+		pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
+				    ENETC_MSG_CLASS_ID_MAC_FILTER) |
+			 FIELD_PREP(ENETC_PF_MSG_CLASS_CODE,
+				    ENETC_MF_CLASS_CODE_INVALID_MAC);
+		goto vf_state_unlock;
 	}
 
-	mutex_lock(&vf_state->lock);
+	/* PF has higher privileges. If PF has already modified the MAC
+	 * address for VF through .ndo_set_vf_mac() interface, VF is not
+	 * allowed to set its MAC address via mailbox messages, even if
+	 * it is trusted.
+	 */
 	if (vf_state->flags & ENETC_VF_FLAG_PF_SET_MAC) {
-		mutex_unlock(&vf_state->lock);
 		dev_err_ratelimited(dev,
 				    "VF%d attempted to override PF set MAC\n",
 				    vf_id);
-		return FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
-				  ENETC_MSG_CLASS_ID_CMD_NOT_PERMITTED);
+		pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
+				    ENETC_MSG_CLASS_ID_CMD_NOT_PERMITTED);
+		goto vf_state_unlock;
 	}
 
 	enetc_set_si_hw_addr(pf, vf_id + 1, addr);
+
+vf_state_unlock:
 	mutex_unlock(&vf_state->lock);
 
-	return ENETC_PF_MSG_SUCCESS;
+	return pf_msg;
 }
 
 static u16 enetc_msg_handle_mac_filter(struct enetc_pf *pf, int vf_id,
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 55c07c528f22..a7bf4bfc25b7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -488,6 +488,7 @@ static const struct net_device_ops enetc_ndev_ops = {
 	.ndo_set_rx_mode	= enetc_pf_set_rx_mode,
 	.ndo_vlan_rx_add_vid	= enetc_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= enetc_vlan_rx_del_vid,
+	.ndo_set_vf_trust	= enetc_pf_set_vf_trust,
 	.ndo_set_vf_mac		= enetc_pf_set_vf_mac,
 	.ndo_set_vf_vlan	= enetc_pf_set_vf_vlan,
 	.ndo_set_vf_spoofchk	= enetc_pf_set_vf_spoofchk,
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 56d23a8a11a0..6789f92d005e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -9,6 +9,7 @@
 
 enum enetc_vf_flags {
 	ENETC_VF_FLAG_PF_SET_MAC	= BIT(0),
+	ENETC_VF_FLAG_TRUSTED		= BIT(1),
 };
 
 struct enetc_vf_state {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index d32a195a04c9..519fc90d2647 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -586,5 +586,28 @@ int enetc_init_sriov_resources(struct enetc_pf *pf)
 }
 EXPORT_SYMBOL_GPL(enetc_init_sriov_resources);
 
+int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct enetc_vf_state *vf_state;
+
+	if (vf >= pf->total_vfs)
+		return -EINVAL;
+
+	vf_state = &pf->vf_state[vf];
+	mutex_lock(&vf_state->lock);
+
+	if (setting)
+		vf_state->flags |= ENETC_VF_FLAG_TRUSTED;
+	else
+		vf_state->flags &= ~ENETC_VF_FLAG_TRUSTED;
+
+	mutex_unlock(&vf_state->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(enetc_pf_set_vf_trust);
+
 MODULE_DESCRIPTION("NXP ENETC PF common functionality driver");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index 8243ce0de57f..96a4dc63da57 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -22,6 +22,7 @@ void enetc_set_si_mc_promisc(struct enetc_si *si, int si_id, bool promisc);
 void enetc_set_si_uc_hash_filter(struct enetc_si *si, int si_id, u64 hash);
 void enetc_set_si_mc_hash_filter(struct enetc_si *si, int si_id, u64 hash);
 void enetc_set_si_vlan_promisc(struct enetc_si *si, int si_id, bool promisc);
+int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting);
 
 static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
-- 
2.34.1

