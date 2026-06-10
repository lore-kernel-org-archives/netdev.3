Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011016.outbound.protection.outlook.com [52.101.70.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953AD3E3D89;
	Wed, 10 Jun 2026 09:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084794; cv=fail; b=UGNSNEFqpdvfLcqC0HV+W2ACdEqSKpJm6eKXCPrvhcXGb68lWXpIkQavSj8oFRPV+KCoS0mBP0nnH0xdGxd15INA9CwP/+zIsa70YnvTTU/lYDY4KHZ/4SUNPgwhZ525ba+41DPY597nildPfcGosYPD0axrKhi3eQX6KvKwC2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084794; c=relaxed/simple;
	bh=dIIxd9Jy2Rm8U/n7EnZT5c2SpYqBBow0Y14aSQ+7FpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mM+zfFXvAKzqhzytSiJ4zQ1ef1pIJdlm1e7QfZfbbGUUwr4/WeFmBQbCLw/WU6ikuO8rJKZpYzL+JVfmrOfFswz1+SlryKEkSY+z5s98Vw7qRBTUKem3H5+AjzRO+xaEtJQ/OtF1kBD2K1OV76zG0pykL1ZhQr6xnU3WF1UFULc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=X4B71aCC; arc=fail smtp.client-ip=52.101.70.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="X4B71aCC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZQa9L2GhxLpLc7Y1YIhE15alTysStgDx5r1hjYb3zWQwMK8MmiyJmXPqGHfDXhdIU5tutKpn3rB8kvViSzoA04EcmQhWQCidzyvBZoYLf3CKU9cAEz9n0E7QeMg/oarSVG0K97k5pv+ajM4ylKUDDSHM93dYMyWttIcQkOvrCxVAPUqkKlzJ6+coNC6aktGqY4k980NGlcpe4Gpa640ZAqEujmjANcce26ZorCKM7LyOb0RjHgKzG5rOv1l7k8egZsoOHKqXfKOyP6mwzb2zWUEzZno4S0LLQTwp/El0aL4XC6Z3+5LpGt5+WGwg1RsCgLRQFABdwjIx7TAwMKH5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRh9Ic1cPesdVKoUks623xlWgPT96E1rH1ZYLsw6/WM=;
 b=NNf9zh2xcuBqVTDeMlRVY6YmngCQKeZXPH7ELuQ1rBjv3ybgZlOK1Dra5iYO/LAsOyN/ngfqn11ekwX722MaPuT93v/lQlmZqYLxYJPdXUVvX6P+4S0ohdac9RXTQNhcBR9UAF1cWgwwH57+LbJgPX1tZgmKO3fqrD0WfiJnIy/pO+V5nfFGqi3DvtSKDr/AExfFlJVT6ccj/zmv8mYBhat1OXObRe9lLI+bX+zf7P7tgq6OZ9QFaghxg54f5x7OWc7Mv4X1tN0OrHIjZwvjryYY51a3OmlVMfAJRNMVJsRN7XxxdIn3BUggV7wl68+sCb8sq8AdRyXtaa1S017WVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRh9Ic1cPesdVKoUks623xlWgPT96E1rH1ZYLsw6/WM=;
 b=X4B71aCCBLBznpnsLFy+yPJfBl86g/rzWhsVRZsGOBb35WKvwbHgbgs4wHxUH3GZBM10kaP7PQMR9SRo7O30l+MNttv1rvFEu+tImk6AgO558xt3nsBpg3sjasE4QZRLVwC8Yzpu6HFC+SYoL9ttKxKAFepx5dcvimsx0fa8q2khyC9sCT5yGGYRIevHRGpdz0bPkircw+X0Vd8tCkqb7bkTPul5ufSA+cGhirRJrQIGfBEtFxWBtuKyV84W3ma7Gr5P4nFj8boAM2CxSJBek+UyxGx2D9Pfr/9VzfByuE9BNFOCJKf1L++cnEHwqF89mV5ExDRc6CCf+xt0HVZNRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
 by GV1PR04MB10991.eurprd04.prod.outlook.com (2603:10a6:150:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 09:46:29 +0000
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14]) by DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 09:46:29 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 05/15] net: enetc: use enetc_set_si_hw_addr() to set VF MAC address
Date: Wed, 10 Jun 2026 17:18:34 +0800
Message-Id: <20260610091844.3423693-6-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610091844.3423693-1-wei.fang@oss.nxp.com>
References: <20260610091844.3423693-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0027.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::22) To DBAPR04MB7207.eurprd04.prod.outlook.com
 (2603:10a6:10:1b2::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAPR04MB7207:EE_|GV1PR04MB10991:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c1b11aa-46f8-4743-96cf-08dec6d5256e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|23010399003|921020|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	6blThXKnkTIe+IQM0Ac70clA667sOd5FPLV6oo3uEgysTAZHe10MU3IgNqsc8Q0bSCuNoxeGjd7CAXt+BBREEN1MXI9BWxIN+BJdbQ0OR1CSFWd/H0UNh0Idsm2kuDn1c/TNOEmH1jog5jjhJpQIcRibgmxvuJ6XF/C2R4AfFys4WdU/cL7ZH3SzpP/A9l1q5Ajn46AZvP6Dk7zLws5X72QcagelU1uu0o4QyBCNhjNSCWr1eIwSxGoZBmuDAdRxtZtp2i1JWWhclN3YT+DJW+BpE1kluMgrRnP5VEJKijP1a938lOa79AuSQl8vySdgRMpgMc9s2IXmTJx+mihHw8irtQfkLz6oGuy1M1EI4TNPWmfKqwLjEBixHsQTVg+olnVxzPbhVck5jZcW13K9BaXtv/m8Cc/3qidpNkDGeKdmCYFxvsKX/0DB8MzJ5THjK3KB3gZm17OCTtnIJLsQ/kTWwTQi1AI8gnSXKxtMTScj+p2NQg7ZwRBRf+nzlL5BJ8AVdAytgKFZ8QxXOSG8dNsszdq6OFLn6rXGf7nVIjwXTd6ELYEUg/WIc6PDxRnYYwdErqKLEs3xG97ja7/WdgVfO43c3LSIAxDGOmWBsT6BQRMyxgCCWlAxm6w36wFerlGM8tD2QM5vsErRQbsVu73KintZV0Ratjm6EKQb9F469wmlM3KmtGdgxPP6lDMWtXNxLTj7e3+Y5iJAQwu9foTvyhpNy/JaVhF0p1pu99k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7207.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(23010399003)(921020)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z9OmmMnjrES9LBFBbE/NQzukgnNxNhJDVPpcvo7509NhOh3Ix5Sv/OKuXrE0?=
 =?us-ascii?Q?uqO7QK221+pUK4L5dBodtslczQ3PW795REgra31F/ieTkKrg3FhYgeEdDV9O?=
 =?us-ascii?Q?dG3+mkd8+s39zyccXbH5ieEfL33v4SVzjzifeTqII6/rrrmGMcRwDDKxfC/B?=
 =?us-ascii?Q?g2Q65kzNjkeww/G03rU8uGnxjd8ki9KUx5H2stJS/ukoH46ZQ4vaLyJtmrbx?=
 =?us-ascii?Q?+/QqHzgmVzWuapiPjrt3CVHbJkl86Rq2xy0riHeNA30uvaZLiQYwVUyttPJf?=
 =?us-ascii?Q?jgHOSUphU0IoUTw7sA+QIPuzvVD4uZ5kffcFz1MyoNuvE/KaFHeTwJGpvPBE?=
 =?us-ascii?Q?mREjxvmV2VvMhV9jC4slhPZwg35n/4ccANJKzfpVLCscw8PMjrmIQ18EDYQ0?=
 =?us-ascii?Q?kOIMy50EcmHjCkhBhSyqI+vFGc/yGjTY9aUzJ+fsLtwqqWH67PnH7BM1v/kS?=
 =?us-ascii?Q?+32/9cFiprG6e2iLsGSlwRzCr8InFXXnZ9dl7w9Gt3w5HmxamxweI1rvTEDH?=
 =?us-ascii?Q?0PuSP8kJ0V2Ji0K+p7wZPsjbd0yQFzQVxekgJiTmEE1Y97EqgrE9gq8OCUye?=
 =?us-ascii?Q?PCw36SHSGrpgIUft08jTVAQN7Ld+as5ScJgzreHv0hFkm8kDoGvW7mEB/DnF?=
 =?us-ascii?Q?g0j3miGxUrnH5Q5XaG7j0pdu4PfAIZuJyyxNty6flDTx4F4w1OsS6tjhD3OP?=
 =?us-ascii?Q?MLC3/Tt9BXwat4pDFnm+sEGI60ZbTRRQrS37QD/z26REclYsuzebcuCK0XLR?=
 =?us-ascii?Q?kC6Zu4SVvJTZLsj376UJP38itn44vlpzTd0ORrRz0QLnR0StbZWLeGsTBcE0?=
 =?us-ascii?Q?iRxWX32hObfmUC8RE5gBFAeL0NHC2YAoM+pUORD1SUR6q8LN2pO6BWZbp0kV?=
 =?us-ascii?Q?k29BjArSP40gaE/LhB7J9K9pnv22aHQg5S3ySOZHsB1+3UW9gs7E8DP+8qMz?=
 =?us-ascii?Q?Bxbd4yyrTn0xalONCUZVKG35H6IN5cyqt1R/Sdf+ehnGfjBgJkczPB7QoQTx?=
 =?us-ascii?Q?+cuPwzIFH5ER716x9Q1H98K6QnHCzVL52Ez+UgHEGx/I1fy70hlYm3xcWuPE?=
 =?us-ascii?Q?DUkElK1yREeliqvcTkrpkfK0KdoqJj/3qhFb4r6clDmgxp9yUwdHrYSahr/P?=
 =?us-ascii?Q?/ASoVMnUfjcCjvSl2TulO83arrT0EN32uEKNZvgceln26j44n/OacIpk/1Ec?=
 =?us-ascii?Q?ZEi7iuN3qBRZUbBGxW8IgMWDZjwWfFKVmIj3BWRSPmmcyBHMwejXkxorn5H/?=
 =?us-ascii?Q?FvI1wudgJQI6IxswZipm+Hc80FadN72MRanZ5T86aagRB5A4Lf+AZEk4Nj/1?=
 =?us-ascii?Q?viBV6jeUtW06gN2bbUEAps27a3ZMeEz+wA4G1z3e13cY8vmFrIJWfb9Uxpgk?=
 =?us-ascii?Q?UyI39Cy4l8EoCfCsq2UKUmDHIsRo5BHGGHNZCp2uAVAn7IlVf74IqOnO1p3z?=
 =?us-ascii?Q?+hSpJ9DqgNOB9cv4qexolcmVWmE6J7L1RgHSqik6yq9Ppf96/8COqNNiZSR5?=
 =?us-ascii?Q?s2GAazg+ULHwrME9AK5AH6LRzeqr4vjTz1PQVYWsYvoF5yvIEnCINEflpuEF?=
 =?us-ascii?Q?9n1AG6B1t10hflQxkGnqvKl9hLSq1kyPSlv6y+2U7EZA110y9IoAeFckjshH?=
 =?us-ascii?Q?P34MQg8V1oa4zc5NjNk1xRJFub7RryKjmKyrzoBBaXNlNauRzQ/V2G+5eH+Y?=
 =?us-ascii?Q?Et5COQyCBOcoU4puqNNobblZK6shY0pzHWnhbPcwq+rty7DTuvZG/F520LEi?=
 =?us-ascii?Q?jA568k+F79Y/tw262sdDvj+SEmkULSISuDBSem8Qltq5jY3Qo24h?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1b11aa-46f8-4743-96cf-08dec6d5256e
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7207.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:46:29.2748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8oR3nV7AG7Vm4XTkJH44uEa0FaeziU1RmWD08XRTylRJV+iU79AOqC+OBGmMTG+TNxrFlvZKTMclvn8/O92JS3zQkeT9Top2fLErYeHaPBXwqXeXd7NNaeo6nOj8rZ9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10991

From: Wei Fang <wei.fang@nxp.com>

Prepare for moving enetc_pf_set_vf_mac() into the enetc-pf-common driver
by replacing enetc_pf_set_primary_mac_addr() with enetc_set_si_hw_addr().

This makes the VF primary MAC configuration path generic and allows
future enetc v4 PF driver to reuse the same interface.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 8957e74314d1..4a16bc49312b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -255,7 +255,7 @@ static int enetc_pf_set_vf_mac(struct net_device *ndev, int vf, u8 *mac)
 
 	mutex_lock(&vf_state->lock);
 	vf_state->flags |= ENETC_VF_FLAG_PF_SET_MAC;
-	enetc_pf_set_primary_mac_addr(&priv->si->hw, vf + 1, mac);
+	enetc_set_si_hw_addr(pf, vf + 1, mac);
 	mutex_unlock(&vf_state->lock);
 
 	return 0;
-- 
2.34.1

