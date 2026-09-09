Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503B65293E5;
	Wed,  9 Sep 2026 10:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950172; cv=fail; b=R2HLe9sMUCbKhBZuJtPJqoXAliNUY8S+oVaY92iVCJPRujVccfZyG23O9eJsSLoqdAeoW2LVmsgCAKERlFYC9jYrAUszTG4qB5DZkZMxn4GyIcqnMEo3QkiAXOGjyssRgZlgqAkLrnDhfAHVNRZBurTGzIPV8ow1tsC6sejesl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950172; c=relaxed/simple;
	bh=7iHuAVpjM+dwN+n2zkdM+UiMrYeuX2f9m+gGdNMJ8Mo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wr8RNTS7ipBK5c2l4xtRyCA22Mc5I0GLmkOuSlmvoj+dTk19U+A12HdE44coh8RtE7Bzbw7UT4bl5a3LnZ9kV5t2FEUGMzPJlcjxveSVPyiVRdY1aHtzdags5ZaYWeiFMdmJqzh6uOoPpIoqY9xYRNHNxxQVge6ktXQMatciLqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=F5EacGNG; arc=fail smtp.client-ip=40.107.159.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="F5EacGNG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4KgZlHHtGKvzGF+3auDCrcDqiAO8SE0lby0kLdGfmr/Z8RG385+CFbfb5cXGDbMyGPRz3+ZMQ29cq0xT0CTuNf069/kJX4RT4HBbipWGqWF8rPlCbdNVAbvEQsSGkxLydUYGsanwKeL2f3I/QMwlf01km7ezJBvVgNMyahH4IkVBBYA1XaXqOUnxKitdgG6MrydS/7Qgd4qDjjOPijaKYyGV1pAhSvtUuGlwHAsyk0Fjfw2zGJdZv//cWC3Kt4tDF69+Q2HstkQmEriYIOsrvovk54PB/ppjyr3bG4D3m0slKBxtV8MZstaYLbDjG1/oLQwn07DUei6QHzld4XoEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roCublq3HnL0M0UL+dcBUEWjkvVLsBMDK0yXTH6Ca7g=;
 b=Okge37NT0nYAbmMZoaBaFb3bGnO3X5DHoyZZmOrPk3qW2IY5a3xzz6n5O91Vt7gMFCiLrxVm1hE4q8hyKKw5frdfvVp/nv6JlXnA5uhQfSKCM7zrTksIznVsZgu4YtdadCBmELrMuCFLAgBPctvUeJ/ARZ9kDd+IKQF9k0rSapqjGTMw+mvINQp2A8SVy3tK3evlgSqMGdcP75di5EyHYqpUmskhRi+nEu8dRv3dPo4/ItW1bxZSqtrhqtrpUvJPltMdfWC1hDXqccmx1rlUPsMFOZorgXHXr070/CJxDfXFlkElvS5DfebUuTkSiOCO3FGLUR+NpDz2Bu54Qx0bNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roCublq3HnL0M0UL+dcBUEWjkvVLsBMDK0yXTH6Ca7g=;
 b=F5EacGNGLTdpPHbvlbn1f/ho+XDDNIZAvjDYKFVvKTQZT1iZiHDYyz2C63+8pd7L4+Qa542nH4jgghNv2RJEn64mdoZHdf2V5tARz7zGPO0VlMFUGx/HBW+zrrPIm0shmz8TQ5+A1MSc9eQ7WwWkHVeglvwsD+b8cJzcv1ZWPk+O2FGDx74RbVTpk0gPdDAQoiM4dSlaPfcC4FKwZYxcD4J//V+0QEqQHe6VHrTShDdo5NmP5l3MKbr2QseifP5drR6SRXqyW79zn9Xr8IpclLEL7jsWgPceT3IEFxZMkDHoRzOJXJ4yQutkBI3fJIXzVvrKKLCLWuUWCp28dhLp/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DB8PR04MB7066.eurprd04.prod.outlook.com (2603:10a6:10:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 10:36:06 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 10:36:06 +0000
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
Subject: [PATCH v4 net-next 06/15] net: enetc: relocate enetc_pf_set_vf_mac() for common PF support
Date: Wed,  9 Sep 2026 18:07:24 +0800
Message-Id: <20260909100733.1139689-7-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
References: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::16) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DB8PR04MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b91304a-b395-4854-baad-08df0e5e27c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|1800799024|23010399003|366016|10067099003|11063799006|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	t+FR4Z3bQ/D3+IpUek7QWR1VRhqk7bwwqaHix9cWVdYlU6nmvv2w59mzMKUc49VcEcbQdPLD20cYCrSbXhITkK3xk+bcdo7zBBhQs01Zymy36TrDtfwfPXP1Tz+T7rqOx0zwcE8pKhdbZLaGnLnSigx6UjHQQojrgK02MwKW309tVyeaqpy/3+KwgM+NWpOj+5DqFYwXz5wAcbchKEzdnawMM9/C4LOjqFW1JvYhUhVDHGHuP+zY29xNNoy+fkgocQ9skDsBcFilTv21Dcd36/iiwJJ+2xW2TPvCZ382ZYBf0ELF2dTIBsBnAFcZcw9Zg7pBtx09s3Z56PxZQ1ouobCPw3SDh/edwyqdf1SKLiez+TZX8L8hLsY8zozd4fEXsi7IGD6AgC0yr6DZkzqgpo3OfRUU5kcPLrrkAMy8LnruZ0zJloMZ0rz2C6l8cZ3+EF0b8SyjzeSpIz+XTU3AOZHB25HVNXHhlLgQYNdWadKxNlwPxJMqs5UVRrbnTQKv8VBp/P+RJ3k9nlZiik8RBuURE5JlQxsBOdDOMv8bLGAzl4fDfhwvIl255JSI0zPLkB1I4qSFS+292Z/aLnNp0TIFVOhXWRk8iqeIMeF37yrcoSM9K29Q0LQgMIagrk2Be9/HqVVLVakmkOHbBYfFHJP8zJXP0eyNItIbWr7oDzAPGKuiLru3YSWg5RkA0HXAffZOG7MEVta4h+S8Q8bPDw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cD8v1sOE4vmePaJq5pV0X94mUZKtqItVbkVqQNkZQaMEvNXiGVLQGRFQOMhI?=
 =?us-ascii?Q?Tv22QCyc+xqkI/fxQdKtCIoU/XD3muPf95o9JqEb3Q1zuc2QA/9WQCdqlqES?=
 =?us-ascii?Q?iBTQ03uspWw9w7fpJO41V+Z0h7x6Fq8Ge9iqMirodH9RpXRvATEXTh9c5xmf?=
 =?us-ascii?Q?juXiZlz/cEIWFtEb9h/r6QvM1dEb8FQCBH+UYlwrAcRsLC8LE0KtmE2BekyC?=
 =?us-ascii?Q?In/MlAsGPYikwojgjn8xppWuJGmzsl3bW3BqW5tOcag8j0bO8eW8KyM740XK?=
 =?us-ascii?Q?gkCRgZ5wJL00sjGnMeV2i6g4ZcQCb/Smwjk8CHBXz1j4FAmZPM4hSCQNkFi9?=
 =?us-ascii?Q?RV/6SulN6p1esAcZTg99yQOf3Oxw3XOGtOACbiYrv52r2RJ8yTYuHrvK2fuD?=
 =?us-ascii?Q?yY8dU44oPbgNIdF0oxVRN/uWGD+mgMpxSH1H7VABWvxb58nXHvJhldlXw96T?=
 =?us-ascii?Q?UQtDS8rlN1ic8FCUlimGSfVAqAd8+0N2RZdUvApNCwDY50sh79a2DFC9e7Fv?=
 =?us-ascii?Q?cewm+fLIrj5YgqbZSMmQMYNLh70XWlj/u8jIp5fyXZ/9nr8q6VyoGORiljTK?=
 =?us-ascii?Q?3agYFPRLu4HaWyyf8NyGt6aEXTsJl2Gi50Ipnec0qR20jTkpIAjCoyiqjSk2?=
 =?us-ascii?Q?sLTaiswa0peF0/ZPyUiwx6Z8wikT38NIncZmpZX9OR5i0pXgyFm/4yaTi0v9?=
 =?us-ascii?Q?wIfr7QQ3WlnSLHJlg5jvKn9oEKIKmPPClXvuT8bY61WdZznRqJ/hhB6sSNz9?=
 =?us-ascii?Q?BiyBtq6ypURXAWKbV3E2iCmzz49IhWHIa41YgDcSmDijZQ2MlqjJDAU/qWE6?=
 =?us-ascii?Q?9Ec+TbEXJP0llMqMNCFq3eHa651cKl/Prfe8ViAd2znZhTiOogDkV0v5t5B3?=
 =?us-ascii?Q?WFE/5dz6NiAeD6Jfp5RAWRcbHe7amTN3trdziom/2MCxHV51DbyJ0ppLWO76?=
 =?us-ascii?Q?uBd1V6mY2Azm5xAQZOZ9qj4y8uqwOjhObYe2vgClB4tvh18tXSwrgzWzbxQW?=
 =?us-ascii?Q?yUewBvep7Uk8ZFJHy9A1Cf1vY21TsnuIc4Ou6ZedVyNtAOCCIqC8JxK9fp/Q?=
 =?us-ascii?Q?mr8K9fXPogAoKzZ2XTbeb7r9QEGsqyTpLxbqLF+2+cNRSG8QGlPLXe0AwaQy?=
 =?us-ascii?Q?wbIOlCId4RqatWV7PgBAl7p/GPQ0/PlYrdKym3sEgHoXS1cWr2OMwGA2vJA3?=
 =?us-ascii?Q?tHgBV20m+slygadn/QP2E514hBJ3t7StwMJNbjBlPirH1s81V6sDOLQ1p+Ks?=
 =?us-ascii?Q?xb+Mfz4ceRercCD754GBr/YfWXUUmMOpno/3u8mhpAofLL/zIgzDbtdceUM1?=
 =?us-ascii?Q?i2IaPVWjEmq0zDTqCyrIYUx4T81ezZZOinzb9pIgz4TFU9fjYTjsjxV99Teq?=
 =?us-ascii?Q?UsxRU/xNOykspVZwvNDJ6j3xA5EMeNjB5l7SDyHEq++wYsMBBecEmAgEUMhy?=
 =?us-ascii?Q?HzgHhAzSirmMat6Yw2766AAmVZ6DBr0KHNrZO6cc2Hxe+U/q5Y8VSHTbceTZ?=
 =?us-ascii?Q?2D9MjNXMvaaKvSWhr993T03z85mneFcX5JJwBDtoKhKgmLLGlV3E8dE2WAny?=
 =?us-ascii?Q?GCtQi3AY2l22V1cJX57cbZZkzdlOOf0LTTBIKriwwTjNAdPke0N46AjzNqN6?=
 =?us-ascii?Q?uG/1G3+8PQ0O+NiGrvxnLmSDl/D6uNp4qFF/W+QaIAhQ+ZPSkSe0pGoRBJQD?=
 =?us-ascii?Q?1K7FBE0zs2Xdkrz1WktYCxJNatRddHvdVYxoti/rrnKi3bmPNmcR4RvIEUYB?=
 =?us-ascii?Q?QpijjZGXqTalPFhv+60kfK6rM8dc1KynTLLKPQiTL2libzUwCrmE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b91304a-b395-4854-baad-08df0e5e27c2
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:36:06.7782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLY3YJJJOQ3vDpHVQikcjGJFWaP43XiDxTihgdXlrsZeO5cWBm7ZaqTKE5B/m2x+0VpBm7jA0AaPjcdxPDJi0U/cAWxHnWIswVX6I0BCm50WK5aDwFBDa8oeKn95Q5R9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7066

From: Wei Fang <wei.fang@nxp.com>

Move enetc_pf_set_vf_mac() into enetc-pf-common driver as a generic
interface for both ENETC v1 and v4 PF driver to use.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 22 ------------------
 .../freescale/enetc/enetc_pf_common.c         | 23 +++++++++++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  1 +
 3 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index b74d965e403e..c467dc05510e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -191,28 +191,6 @@ static void enetc_set_loopback(struct net_device *ndev, bool en)
 	}
 }
 
-static int enetc_pf_set_vf_mac(struct net_device *ndev, int vf, u8 *mac)
-{
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_pf *pf = enetc_si_priv(priv->si);
-	struct enetc_vf_state *vf_state;
-
-	if (vf >= pf->total_vfs)
-		return -EINVAL;
-
-	if (!is_valid_ether_addr(mac))
-		return -EADDRNOTAVAIL;
-
-	vf_state = &pf->vf_state[vf];
-
-	mutex_lock(&vf_state->lock);
-	vf_state->flags |= ENETC_VF_FLAG_PF_SET_MAC;
-	enetc_set_si_hw_addr(pf, vf + 1, mac);
-	mutex_unlock(&vf_state->lock);
-
-	return 0;
-}
-
 static int enetc_pf_set_vf_vlan(struct net_device *ndev, int vf, u16 vlan,
 				u8 qos, __be16 proto)
 {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 519fc90d2647..1b2ca2b31a80 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -609,5 +609,28 @@ int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting)
 }
 EXPORT_SYMBOL_GPL(enetc_pf_set_vf_trust);
 
+int enetc_pf_set_vf_mac(struct net_device *ndev, int vf, u8 *mac)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct enetc_vf_state *vf_state;
+
+	if (vf >= pf->total_vfs)
+		return -EINVAL;
+
+	if (!is_valid_ether_addr(mac))
+		return -EADDRNOTAVAIL;
+
+	vf_state = &pf->vf_state[vf];
+
+	mutex_lock(&vf_state->lock);
+	vf_state->flags |= ENETC_VF_FLAG_PF_SET_MAC;
+	enetc_set_si_hw_addr(pf, vf + 1, mac);
+	mutex_unlock(&vf_state->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(enetc_pf_set_vf_mac);
+
 MODULE_DESCRIPTION("NXP ENETC PF common functionality driver");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index bcf113efc2ef..7d7e67a12278 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -23,6 +23,7 @@ void enetc_set_si_uc_hash_filter(struct enetc_si *si, int si_id, u64 hash);
 void enetc_set_si_mc_hash_filter(struct enetc_si *si, int si_id, u64 hash);
 void enetc_set_si_vlan_promisc(struct enetc_si *si, int si_id, bool promisc);
 int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting);
+int enetc_pf_set_vf_mac(struct net_device *ndev, int vf, u8 *mac);
 
 static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
-- 
2.34.1

