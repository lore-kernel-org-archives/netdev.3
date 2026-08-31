Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013044.outbound.protection.outlook.com [40.107.159.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77BA3AEF2E;
	Mon, 31 Aug 2026 03:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788146581; cv=fail; b=VsI1Aic4klxLl5S1gQcXN3H2/UqY9/8pqNg5qTjfj6rLYRqLB7xwR22oypVHJ6W5tJUruoOIFWsL/qtsf9yAhy3apDcxhzpe5oU0FxVvVyr2i3xLC2f3YN2iftnzCy8k+Ed+cOr1enDCobdM+aA7JWOAW+Ic9T+kwqWPhkntxhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788146581; c=relaxed/simple;
	bh=WeZ0FddJj2Dww/t2dscRZiH4yhLx9Qavn+e7iFOOAgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ly6Lnr9CDJYyzzQadm3NyiM5fex7MOv+4VFEphUhd6sx1PBzl1KVhHfXfJGb5sCAVrfd5h9q73OCjXnZvIyzBLN4FsWPcs+JD7/kare2IRK0ncYxaSBJ8RMbQReiYIfeHpCR7e0ycOhn+O9nJJ9gAFelesG9S30encpDCjfbqic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=wM3ek2cS; arc=fail smtp.client-ip=40.107.159.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wM3ek2cS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Au1xj2uvsP64ZLBfWN315xX7tats/waHnxbpetdg0N27qvWuLewsH4RSABHyjPYCQEM99YY3Lmk2w0O0/uMj7imO2xjSiN568CjFKQSqlJ7yt03jHz2rn2RzUNN9nPVuhQ4DxBM1/PMl0LJ+MFd+0sFtwQIuytzhD3dk51UG5klUeqR1qCEA7tN3vAROxPjSVFoU7lYE3mppgGR52IyeRgUrp95kaS+Zx5MAX6nOtzvXeCcqO38VdUAY8rS5z6s2lngpNeFBUcUGs46yDHWhs/PSzyzlzQ2ktdmZpU37IoPYrbFbS5cxy1dS0bzRvQyYfkBfwRtzr7fTHx7E5gxStw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPiticf9ELlVSGQ7fhawWZ/5BSdoxJ+NjH6H72ZGdo0=;
 b=RpDTxmAVlVK9dOeg5+jV3I5yQYzdWNswyCcXV8NzaxLM3maBCXrWcHocw4vBHf1wz4m6P2jmCIsVZg122z7hQF6EopxdrCsw8dmkDnCk8XQvV0VjAKzUs/XiJceIAuO+sDwQJDmnPfL/V6npQPhvtKaGC6mJd6NQo6Jbs3o9OxsFVgpVm48JHYOsKLXyIfSUFHXFw99KQ9yFWmR0CUCKYY6CkIrs2j51N8gxIY7aiS8XDPnUqH07SFwm/6BJ2RwiK2e5draRYDIdsT4BNRpSRoldSxUPIRl9SIu1U2BfA0JLs75/Ff84Aby+mswKFjZE5QOPrI2ZVQCGN+2fDDl4ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPiticf9ELlVSGQ7fhawWZ/5BSdoxJ+NjH6H72ZGdo0=;
 b=wM3ek2cSEMnHtwHWmyJqmFThFH5yS10vTwRp/Iu0KhHaYVhDozaARI+Fn1Sw/5tfjayoDGyAUbTC8XRBX0LGcrwBibB3jDEDMLCxKpdFKuZbNy2CIBBbLV/RXvZLFhgQ3oB5EMRXGJb9rkBj+RlwbGRwm7wmjXXipWMMAu5BrhyeesemJcd4+tG1i6BhMeHcFyh8aTrmZQLDu5gM4pBSeTq3PHWNlLmWngftRKvn1kZAkzvt5MNF3sX/Aclpd2UlJax+9s1CMlE43rVHN/nh0lt6eSsy7U9KL30OEij94Vr7B36XzAjFWFGHPeDxE5CIWKtNE6kY1XRRkXjylnH4jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DB9PR04MB9234.eurprd04.prod.outlook.com (2603:10a6:10:372::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 03:22:54 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 03:22:54 +0000
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
Subject: [PATCH v3 net-next 06/15] net: enetc: relocate enetc_pf_set_vf_mac() for common PF support
Date: Mon, 31 Aug 2026 10:54:32 +0800
Message-Id: <20260831025441.635045-7-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831025441.635045-1-wei.fang@oss.nxp.com>
References: <20260831025441.635045-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DB9PR04MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: 122c52af-7097-4af5-5fe0-08df070f2594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|23010399003|1800799024|7416014|376014|10067099003|18002099003|22082099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	VwSoap69Of5AYEQKaHy6V2uvn00Ifnt0SjOLYDl7D7jjjMMgBT7wo8B3o4KJl9rXQtJZPK5hu3k5IfGsJs+YrZaY/oerhxzRuWqWAiM+7U9PXT3KQ74wQoejmSwRHB+K4oHs6FpngVdk538tdLi6MlvrONJN/W478ITqiARZoZ/JgCCKgPwfhjMkOvCj0GkONjlD/PcYFrhzBYXL1WuymCoiB+3HhcBhIbl/VdBJmTZwXAOTMqXKgqr1sss4Y6he/ufte4TNQ3OmgIV3ggCNGecEjrlLO/pmBr7rIPkaRDTsB+gL7bDEVG3o/aBKt+C12E+YDrogehPaDdb35BtzEZtiMPZg2f2Re3jmKb8uZwNPMWR4r1FffrfImGYH7fgU/TyOL6BA2z67jRZXeSOBkO5CGLVoOaIEHECEUAbgs2nmSNXHROmOsC/XSVu/OuvwfJHcJG1mcB2JazXAWYKyozkg5gTUAQu0ehBBfsxjqDQnPSzpebda5LuBBJuUEuJ6p4C0gTKP6b5sB52BNL1DxWKcrBL3cVNC2BzumtA4oNqYQ3A+9EjrcK6igX0IngaQc+yOkA0w0+oZQ/d1ozh7JZKR8gAXDjZmqImvklLQqiF5xKJFWy/6/snX6aECpy0eXVQjJyGcSsB6kVmtHpFzO2bzCvb+3sPIPnBpjlx6Ru3ws+I3Ca/e9+QdZnqLQ2Nb5ukAtqmxbenjsPJHyRIUCw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(23010399003)(1800799024)(7416014)(376014)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MDu4rL9gYKmuwoMrV5z4t4NYnabvdzM+Q/SnGUkt0vyjqY/w5tqmxlSQhStH?=
 =?us-ascii?Q?okPNCpHVI6V8mtSywpS8MuBn0QCM5CzAVWz8+FxwzJcyiA5+nt7eJM+w5s+V?=
 =?us-ascii?Q?uxHvvIIyxqgtKax2P++LBTjDK6l+kMfKhxbDA5oUq2xRz2DT4hCqu37jq4BL?=
 =?us-ascii?Q?NQSIZZ6GQgefgT9pxr8oXr/Sv5bWRC8xC1+hN2yQZCDSsyyYheV2WjT3olRl?=
 =?us-ascii?Q?gPoJ0nj/KLJV+Nap5rWfsbpO34Yws+J/0ez4cu/eR3HRFWXhUYDA8XB2J/Zc?=
 =?us-ascii?Q?eTidyQVmXzfZQao7g05HkbbY001CqkVI7lu/X1fJBlAEiOU0Qyd9WOcAAxJg?=
 =?us-ascii?Q?BobFz8K2+QWKn53itbsNfnW4w+4gHqoKe+9JMF7m2IFFG59RB+wy6lppKP8l?=
 =?us-ascii?Q?oFap9YokGqdoKLj0OKdbsuSGLbvyxJtVc5VwOXg5rf06Vr0tOYVKZypcl/xx?=
 =?us-ascii?Q?1xW+otA6EjOddJvBRJ4oWil1CiCUWVcp0ObUVJps0sT2DJf3b4A/KW2/b1/x?=
 =?us-ascii?Q?75frEZ4n0bxY1VPP4A6CuSMSf+eJBxeFXPtQrmhHehmpNFM9f/fTEFXnQ386?=
 =?us-ascii?Q?eTy8gJJjjEb4mewN11eLx2PzLpYAMeyA4fhpBB79BIFZRCKK6DnWmJgSoQMN?=
 =?us-ascii?Q?HBYKnCGrocCij6uxdidw30T+ELO7dbMMBSbtzfTyKmrC+jkMdFnD8s71NMYh?=
 =?us-ascii?Q?5omVCU5ya5TOM79ouSCY6qep32/g9Edp4GW+lXE5YGx4qQ+Koj7k7NeVV2QF?=
 =?us-ascii?Q?jQcKdAPb5/R7TmKcY3x2w8ZWMPqJtze7lpfQWIfcMW3ndmTk1k2mNDri+OOx?=
 =?us-ascii?Q?H1lIJg/5ard6GhItopGi/6lcrzj7SPkEAD6wis5imw4MlbGwW0M5AdFwyCN+?=
 =?us-ascii?Q?yxm8j2t5rMsijIzLGYIr9zXzxw1Dq8lGrJfJC8eekExf9cql8hs6xTAMdCo4?=
 =?us-ascii?Q?p8zlv1VxuCYAv0gL0KxGDxdMOS9LtJ//xYp1RyqnkrSGcR6+R0ONmPnOg1xq?=
 =?us-ascii?Q?VkfFTcKkI+Nt6el2cb4KpayaGv68SpCLuH2Ma1MY3kCyTl9cUCxQut4O6D4u?=
 =?us-ascii?Q?SncvUZNCXVELGca/GbPSLZGZ27WSJsqtF+hDqWfowP6SZfkmIRvljUUi5RCM?=
 =?us-ascii?Q?a7GkynM7wjlNpUWQGMt2PRhTWoDKw8kTgObuOcj30RB/MnfeErzF9agLF0lg?=
 =?us-ascii?Q?mBjcAwfj90xRh+y7RHnT3T+Hzsy2emSTUCjM0Xd5qraEYNROBxJMfnQxb0s7?=
 =?us-ascii?Q?BycbhwJ0CIJJW4ixhIYIXLYGujigz7nnEfLQRjMp1tWwcM7ci9xbTwL07T4K?=
 =?us-ascii?Q?j54S7DwnxRs5AnSZFRzJdj2wGMNTqOEZ0c0sU4U3Ii2RmbxJy0byzAiwRQMV?=
 =?us-ascii?Q?noJdVrTNQrZsJxnxOMQWASd4CMNK8egzoX5f7LpAyZcFa3f0nt8E4TxMO30k?=
 =?us-ascii?Q?rHbpwgX6pEQhij8lKrmeZOGDuL5slyW0epOXqHWd4dkytJBYssQCz3fNYmPY?=
 =?us-ascii?Q?AtGcEKB/dO9fU3n4izU989efDW/AYlFhim3KFn+SNoIJCjOOwkN55l7XBi6n?=
 =?us-ascii?Q?3PlTJbxKEHrElx6ajMicGv5FlY5tqaS1gB9UTqtC9boTihhsosF3FOvovVTi?=
 =?us-ascii?Q?kccCQHcZtHM9hOpJGJZyvfJcrrfr0Vglncm9unonha9MF4leRhHHI2VdBzIX?=
 =?us-ascii?Q?GGOuZNRjlvhzqsnkaI+w+lUvt/CUauk+8I0zYsZZWFWLVhN1jrcATHnjUlnV?=
 =?us-ascii?Q?N3LIYiOf9NySOXi29asPJ9GOmobRExupmcT5PtyzkwgcZLC4UaJs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 122c52af-7097-4af5-5fe0-08df070f2594
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 03:22:54.7439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MwRIcZrD3FKUxtA1l51JjiB3pAoaP71PmjudxhI6M436Hieitg8W3sj49oy2yS/09OPoe5BPau7sEAgjriFNb5N29PmwJwk/26pUqQ7JULXQjKltAAp1dv6QeuStu+7n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9234

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
index 345cb940aaa3..7a11370d2b8e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -611,5 +611,28 @@ int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting)
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
index 693aee3c64b8..1d35e906fc3a 100644
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

