Received: from outbound-ip173b.ess.barracuda.com (outbound-ip173b.ess.barracuda.com [209.222.82.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146A93A9851;
	Fri,  7 Aug 2026 21:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786139483; cv=fail; b=V73WojBCbxkjU8lOS17RIOPUrVg8hnUqzt4qwCzyd5lnP5hsudK+pN1W6r78RJBYzrK4JGS4uy58Vjj/DKciAdhlZlADa1ixdcExc4jpMOy3GBjKz7JBgLPkPNvTkJS4P/wR2+vI2RTCEuP8tLfNx2zi31ts41E6zZzIjq/PDXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786139483; c=relaxed/simple;
	bh=6DwSuEUcc6D/epz9hpgBkmFQifwZfJP7DTbVcYohXH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h3YERkz8llggkXH1xsWaXlk6cc3/vNx2XWTmBn21MoNpre4qrpvSRyjgG0Uod2urKca9W15uU+7cOH8EKPP0lewVBfovKQA8A15KtTnBIV5J3I4WCg0kWQwcDW5PnOVI0jK+7VNGBccKDZejxtKEbw0P0uvqyeohTKQxPJKNmao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=Lx9e3S0j; arc=fail smtp.client-ip=209.222.82.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="Lx9e3S0j"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022127.outbound.protection.outlook.com [52.101.48.127]) by mx-outbound19-33.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 07 Aug 2026 21:51:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vP6Hf3U3oYp/mIGMNoMGYYnzhlQrxC0vH3MlMG7MfRRcQpH9ZRelO+UnYeHHyYfmZpEx1KYWUgEpTFWCZgELy2ggbVBD6ORtQL+GKZtzr645WjwpeZnh9c+M3i2nlTo1kL+o7PF1MpWjO4KO/3AjrQkzfAW4C8d6n+0E5R4T7JAaEOZVdNOggDo6BzXZCRLfztFK1NsP3cxUNqh5h596GN5zAOlla+F5cIIoY/xuoDtUYaZbVWGHGI45kkH1YrsyPK33rPydweBYKkz0lbrZNjBACIt1T5assDS8vsGaWl7JA+EBTGLUkEokHGLjjnuBtJHV5nXj1OZdv4MG2XIyaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlICyOGc4MInRat4xsn5W3hLBpGkdBnDqhnpxxhRKnY=;
 b=LYN4Y8Ezv9f6ABhRrksC7KS/9WCvBvVp+o1jLQ+JQ7QEYhVmIzgJHXN5nmRKnyVbAdGM5aH2IXATkwSSqHWv+9/0zJXeSG+2J34eJwlRcfNZwajavAXoiro7VKTdShWUa3qvJmUSfgvWykZU9RDaSCxjLDkhifNUqJmf1KQ0VbqOIN3yG8Yp9o7LG+mJicVs/y5TXrBGjhEgesx175kGUl42luu2OWCrl7CnQHyc19XPcYSzE3qFYGz/8nT2s1aaL5gG9c+LOLRkRThORyoZIAKflOB24LTdGAV6e1FLdQFrMSOWeK9Ie7/ChVGq6Lib44ELXj5x/Ji0GnxuvThznA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlICyOGc4MInRat4xsn5W3hLBpGkdBnDqhnpxxhRKnY=;
 b=Lx9e3S0j1wqSDSZ5f7dsbQ/o7ZhIsPfUCjsM7MlZZRwV5q2Wv3DE9F130U2PTF7cmxB+fPUdmWpTtuvyHsVTunZFlKBlRpnPpILmaXGQ+FADZD8wWnppFARntdWL6soSPUMjAccFpM1qccjfAyDVmzQ0VpMH5aybWY4EdR5M6LDPt3xesk+qlF+1Zqko7V7WEpPtcE9IS5zsTQ05CAZXe2x7yK3O4GGlHFc0yMDlz2OddMA5gxon55p/js105DZYTzsJQJo8MCHCw2cB52oeJTiTPjjrNV0QHMM4Mq/WvHRLsrCfNUBFFwagCTI+r0mgSfuDGhCkb4529dgfLgye3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from DM6PR10MB4139.namprd10.prod.outlook.com (2603:10b6:5:21d::24)
 by BLAPR10MB4899.namprd10.prod.outlook.com (2603:10b6:208:323::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Fri, 7 Aug
 2026 21:50:49 +0000
Received: from DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a]) by DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a%6]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 21:50:49 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	mani@kernel.org
Cc: johannes@sipsolutions.net,
	netdev@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Hunt <peter.hunt@opengear.com>
Subject: [PATCH net-next v3 2/3] bus: mhi: host: pci_generic: enumerate IP_CTRL channel for Sierra EM919x/EM929x
Date: Fri,  7 Aug 2026 15:50:40 -0600
Message-ID: <20260807215042.2714442-3-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807215042.2714442-1-peter.hunt@opengear.com>
References: <20260807215042.2714442-1-peter.hunt@opengear.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS1PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:8:243::18) To DM6PR10MB4139.namprd10.prod.outlook.com
 (2603:10b6:5:21d::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4139:EE_|BLAPR10MB4899:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae7e24d-170a-4b8e-df47-08def4cdf1c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|10067099003|11063799006|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	uRhMBeEUkuZi0CmPHbIQdJuCT1dDQ5HsoUeC6ry3jYQDQ5vXba46OmXomq+vPl6eUWv96Yq0PDZ1SC41yTyMiMsV0EMK6qEjpDdx94JvcjeUYtDNm9+flz+ibPk/yKMWKOAmCQbUNo3tL/2OIadbdyECW7/j8vvAcZxcWM91sZ+gojRExAFWUIYiheQ+7B86KOkgDUYFmJhls57aDBfFl14kTnf2kB3H/wQT0kc61ZRjUkpHzUp0kNNPJI2xDnofwcJqxvRWXMk9ui5d0nOR/EBepiANeBjGA4kLaf0YQmL/x/Rfa9u4+B8e7dA9ExayV3KP2XO5qrNQZJyIPustNvb+3EIadmFumkCz+qsPW6tMMw2Xnh6kqA7cxRS2uaXFo9ZSC6/lGkUiVfgeV9VgyHI/jsR6LPrDrvK+z3iZp6dni6Db0HepYQ1Raz5zPfZ7ztqdUL2cmmkgbpQAhLbnUC3Tc2xxqK4cK6dfKSmuWJHQKra0XdHX61NlnhnhUh4ZqNrJiKKQs4geYDJNpjTz4MnJDTAyXiYk1vh0pxpOsCT/8NRhpMQbNzEVK18t5tp6BV3GpO5Znet0qihNRTRbIxmcgzfzuHYSl0ict7zzKbMH0y4JaY1TJVQxWHwkwXbcooPTVx/LivW0EB8V/fqTYJJLNM2ROThc53OfB53XREI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4139.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iAuEJzIBNlD5hlDMZeCzUvkMLJj1BCwheuAiFrcML3mfWgWs97JHjo7vID9T?=
 =?us-ascii?Q?ZPsKmsSF0LBw8rHM6Bog8aDwwsvdPbba0c61kRXCBKBlzU7ZDqhtXvb9IEhq?=
 =?us-ascii?Q?FiYwO8qiipC//fo1jglWoGUwsWGMSzkY/W1iqjdxF2OG2z4XxU1P0ScnMWDF?=
 =?us-ascii?Q?qcxYk0uii6oWzFhF/ql/htFYDEb/x2zaCKRjZyhegxPWIgkGbMC2qiid5yrH?=
 =?us-ascii?Q?B18y6uygwin+skSanxdMQSaFSK6X3hq9oC8HGCpziB4ua+uM7/9QVlO+1Frs?=
 =?us-ascii?Q?nHE2QqcKq+InFux6yZFW4OAACduVJ+XFrUoVdVAgJt+i59CCMFJj8zvCBSP7?=
 =?us-ascii?Q?gOKnxtao1cciHomIuhsQBLJ5aW3rqUTHPUmzI2ACI/1goDFlxPCEv3jVWMhp?=
 =?us-ascii?Q?KJ0r6bEzXIJrkBUCPfqDsKCai4ic4O+OjYaoC5nwp/Woz6lwcKwuTH5p/shh?=
 =?us-ascii?Q?V1WVj5LUpBgKW763rU0ZX2yK1yljddAuozEMf3erKKB7E1Cd+zGUiWu06kUk?=
 =?us-ascii?Q?I4p8K03E5wXmCHHHNXm2pREY1QNqBo1dMEiL7JA0pSYUsAq9DtK0AFouj8k3?=
 =?us-ascii?Q?g2V2d1WhitR0dU4iWgVYrQ6WHaIWfqhduhLmzFQj5zGTJo671AQhA6wKRfCr?=
 =?us-ascii?Q?0HImmMkkL8jxi0/Cj/duuhjSa9wS+MvTY65Z66ShxFVgNTvOLRQiVsXHNH+Y?=
 =?us-ascii?Q?GlXUIglIvJuBhT7W1k+VsCjM7XaaKIXGpJt6rV2EoB7hFehU6SKZI/sKjnu6?=
 =?us-ascii?Q?zcmRQy3zOl4MWND3EpKmZKUt5zeit7c0BomSButgo3zbiHHS5pOCl31TqV4h?=
 =?us-ascii?Q?Ohgv0WVPIJCVNWZSaWq6nWXchVz2DDsssRva48EF7XO19lnU041czoUbfPlh?=
 =?us-ascii?Q?NywkT8JmWPlzR83HhjPitKK3eBXDiGYqVeGhQ3G73JsEL64qvz0sWYTwgONg?=
 =?us-ascii?Q?w+POqIBTsuKZ+Flr+Z6ujPYdO2jqzXQqaxJF0heYMRq18qFY+vvjAC7QaZft?=
 =?us-ascii?Q?2TCc+HvRb7aNFK6wZqQvv8AvkoPHjUV8tCire+YiaWLkA4QG1dfDB+46imnW?=
 =?us-ascii?Q?ZfgMuZag9i5ursksZTtYYwCIMsByWOU0uiUXhUiyA4AXwsBrinD79jlSCE+H?=
 =?us-ascii?Q?Qw5Mm64z9wjMI2bc4G9WKh28rGmB9ovbT8reXhH8YOFVspxX/FDxefMPXkEc?=
 =?us-ascii?Q?6SnPLcsFFqvrTzbfRyBpWN9TEvPqOLxehPdbJg4Nxs1VoIWrsB2C15tJ+kTu?=
 =?us-ascii?Q?nnvudXrBU1Ex0pg5Usyx4P0Z7bZ+i32SkewstdS5/MUv41+ahEuUcnzoMEOV?=
 =?us-ascii?Q?griu8D0+KKg56L+F9eI3N2WqNwQXy13GdjnP35d+nb0B5rNeibPz9qhnP1lJ?=
 =?us-ascii?Q?W3QsSYbbH3g+czgTEn7b93OIwAKbS/jqNW/PfRjR0HsU14YR8wLGg2Povn0E?=
 =?us-ascii?Q?tExlb0QoFnqSZ0I2YgBeDyU30JByqx0WTmTM7eGqRiOGsqwuNAQirpMMugim?=
 =?us-ascii?Q?/kKcu0Oll4TvjvnN8B3P8ix2tXU3D/03eZkbrkd5DQjtcistot7Z/sS9JmN4?=
 =?us-ascii?Q?uLZuk4BKzs5utSQon+KmJAWUbZktozGpIyyXjFur/nBInKm8gu3RiBYnhZrH?=
 =?us-ascii?Q?0JN5f5+kunHQ8z+pHi14Ti8DzGSj9ou57LVgVZgsqQBeyETe94qXJt8SV9L0?=
 =?us-ascii?Q?LgKUr/DbXfSPTed74GFJHHgzDw+hFvjGTO64MHMyiDBPFg9q?=
X-Exchange-RoutingPolicyChecked:
	oFSaGUGdM5VUFoQu/W9bYEZNk/AO6lJ0TmC0NCPSdTxCc2Y7hEDSrb5KMXf3RFX8FubFGfwzPIfZgAnwAeEQTH7CgJ/G+e17XnpRM68luIM+HnnFYTeMFWJ7vKpFlwdK+EL2cxTsCzLEzKiJv4wijxyOiLUz3FBuXpqeD/ooiP9EiAiqufZuW95fb7JIFBNRmCKsZtsvMr2pvpv1VReFc2DCSke/19WGRanyqypJdiT2J99RxK+vBvFOppUr6n4nNYKOAM76e+2mSryiMtqUuAEdf7B8rTOOgbThPT/iQLALBKcMEPmmBqWMhXMCf9PVfkIfJ7C8ePLP7AICxmLMuw==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae7e24d-170a-4b8e-df47-08def4cdf1c1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4139.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 21:50:49.5951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DqmbRg1JtSCiYFXANDPA029uT1hY1gXUqb11m9cIuwz/rQuxW5DDPeOlZ6FWBT/P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4899
X-BESS-ID: 1786139447-104897-7739-10102-2
X-BESS-VER: 2019.1_20260804.2006
X-BESS-Apparent-Source-IP: 52.101.48.127
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmhmZAVgZQ0MTQ3CIpxTTJKD
	nZyCg1McXI2DIt0cjI1MDM2NAgJdlQqTYWAD8yPqZBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.275220 [from 
	cloudscan8-251.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

IP_CTRL is a standard Qualcomm MHI control channel (channels 18/19) that
carries the host serial control lines (DTR/RTS) to the modem; it is not
Sierra-specific. It was not enumerated for any device in pci_generic, so
the host had no way to drive those signals.

Enumerate it in the Sierra em919x channel config (shared by the EM919x
and EM929x) using the control event ring. This is the device the change
was tested against; other Qualcomm modem configs that expose IP_CTRL can
enable it the same way, since the mhi_wwan_ctrl DTR support that consumes
it is device-agnostic and binds purely by channel name.

Signed-off-by: Peter Hunt <peter.hunt@opengear.com>
---
 drivers/bus/mhi/host/pci_generic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 0d0d9c7ffa4b..ba47dd153837 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -728,6 +728,8 @@ static const struct mhi_channel_config mhi_sierra_em919x_channels[] = {
 	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 128, 0),
 	MHI_CHANNEL_CONFIG_UL(14, "QMI", 32, 0),
 	MHI_CHANNEL_CONFIG_DL(15, "QMI", 32, 0),
+	MHI_CHANNEL_CONFIG_UL(18, "IP_CTRL", 32, 0),
+	MHI_CHANNEL_CONFIG_DL(19, "IP_CTRL", 32, 0),
 	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
 	MHI_CHANNEL_CONFIG_DL(33, "DUN", 32, 0),
 	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0", 512, 1),
-- 
2.43.0

