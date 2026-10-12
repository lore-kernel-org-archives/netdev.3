Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013043.outbound.protection.outlook.com [40.107.159.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28446471D04;
	Mon, 12 Oct 2026 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791798912; cv=fail; b=nIbyWoNnzLv1WXeb56Rdz0lJS/4ROHyuyJGh8/Nk6xjgxR9RO6I41bIVcv4xMFRPe2Da5KjPQSm4vyyO98sxPeygRcuFPhrPDB39AhqL0iJpuIBqppFwtwQUbLgUUowgx0PBxs3uJr5cvf0F6hxoZ3t5EAz73J3KeU0kCRig8fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791798912; c=relaxed/simple;
	bh=HQCHzP02xIn1oF6lXjkMbX8tdW7i4EG+c1Sd1H/OeCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BdTGh13l/wS4TLB7UukIJmrTM/Q3rJRwtDyOihSn4xqBlC4PO9/rwnEz16V2hHN4fWPZ+0fnWkVWBqdNvthyws0Lz/gQpYXlAxR3LX5wR/n+DVyfvy3+elzxQHURG8kVQe05MC3PsUd5DYN9cH7tQ/cfoZHI1Sw5GuofSrcnjmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bLib4s/R; arc=fail smtp.client-ip=40.107.159.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bLib4s/R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEQN0xsGbX2a1iebaqYDPHi5BBSffiltssSKMOuKS67Hg0DYkmaMX3bCpMS+Wf0UM7KXJzoz+g/u5ooiReHYC1+/7BHxUu0CMJyJqQOyicQmZVVp6ayPs3MjuFkPiaD2Rtx0oVj/+SdT+/n/K94VDF5LSHXij8dyPhNROKvb8TEyHY/oQ22YMXoSNBUYvaLzMo704dJ0f9oMmzL9SkPmxpMEz5KO0H3QYj3CcRnXp28K3m51VCrSrCv4mB2kqHDpEd42j4oFW1hkLkfFaHOpcAVBVBHyvbnUXXkWmKD5KtWGSQ3MTvS9V3QcoHU7K2xYsA6Qd1k3oF5NHiae5ojSxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+s8BkOyNSHuRie2fC01Wy19tDVhaca9HVahGR1s/5k=;
 b=tYJudsy8wOzL1UHG3vzFXRtRarkMG73u9Tre3EMiKIu71vmnmnX5jvgGXMPXO9cEivUo1YJZF7EKeiNGJ/xkLBthQxH1cI8VXOkviXXgqmxUOtJpWNJFO9QF37llT6Cr6yn7W8HS5xy1uaZorR40QnZLM57iTcgX6dSzwr5f/efzIdhn2q79j2oTXwQZbIQj8EdC4NEP34p3+GLCCkuuxsXzTbSc+3knOMI0FYCDTuZSwA/P0BtsBAxDtQKe/K/Vfc8gB1jZOHFLTkqnwpji3wrNHSRBn0mCckSsJ7eaYhQ10X1lQA333R4jkfz+GZLggqHeXGEBVEY6+RizAEpefA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+s8BkOyNSHuRie2fC01Wy19tDVhaca9HVahGR1s/5k=;
 b=bLib4s/R8yM6c5dIzoIeX87kv2Da7EU8mvZ0ZqykytQ1UBzp9OKVMqsAifOHDgYp3U29gyaq0wJNuEZt8GtuZMPtHUi0pFyJQUBxbr3KbcplACQO8UyIx138GGapgpin93DiaX3ZZIgu9TXxw5EaQCQ1uGU6mO6R4mSN2NKPk86aSeTmZmqSvnD+6EI2/Epnha8RTnuQpZ0hRgO0zB7dPol0lTaXnAW57I1i3hycBJoYhOwbepSB95oW7DuPmXwmOdmm55zlc+8FeQVLYZT0KGOs4Jy5M+WEP2qAJ7LoQs4584WkMN21Ml+BCG8uMR+sbNWFUSywfExxgXD4bAVdpQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DBAPR04MB7480.eurprd04.prod.outlook.com (2603:10a6:10:1a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Mon, 12 Oct
 2026 09:55:05 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0496.018; Mon, 12 Oct 2026
 09:55:05 +0000
From: wei.fang@oss.nxp.com
To: xiaoning.wang@nxp.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	richardcochran@gmail.com,
	linusw@kernel.org
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 net-next 2/9] ptp: netc: remove unnecessary pcie_flr() call in probe
Date: Mon, 12 Oct 2026 17:59:17 +0800
Message-Id: <20261012095924.1129312-3-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012095924.1129312-1-wei.fang@oss.nxp.com>
References: <20261012095924.1129312-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a9::14) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DBAPR04MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ec66b1-254f-477c-8170-08df2846e44d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|19092799006|1800799024|11063799006|921020|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	EDATSsWGGC4gYRovMXwE5YwTneBCklFd3oWGBKBIy07Z0xVcXUqZJREBzoxZu20ePlWMTfg2l2HmhJeOaL05PmzlKNWiguCLCIsRfRWGwEx2w3PCTz7m9cCVb3/GXtaH8vZ0QzFEif98tIUf5trnFPKawgQVv0SU9hnT2x9tE5jPD3pBsGqAhzt/oK1S525W7CCSLNjggUKIpljs0u75h9jD8YGHRbasdFIPULfAHRLPxb7XfdvXYk7sNXscRZLQbK0xZgb1s3UXVMW/y402Yjg3Kr99w0plQ4pVyAsvvs6QDxIaNE5dhC2UmrZblzo3GL/TW9OzfIVm+Ogwo1on5pC577x3ALtDC0JFIWJlX5UAdHB6tjhMjSv5TZ6OWc6MARBbJm0hJap5r97uFMVWr7LBDluk4sVC9LrVx3nLWj+i6zeS/rKGyp+W7wk7K80coZKaTr0VIshsLn6JirIMCodqLsmksRgfdCQomvM5vopUNe2fePEAym+xuAh76SWFIU3g6NpM14Fbx0J/BVTGhA2adypNsy9nlj5bn7tU7qaL6fkBktptVUeNL2PQKRy56kVoWtedvyMFwc0ETWFgkx9r7yoHCL5p0/0QRVAEOkLl1BEzTJKl1BJDddbwyH4HY/yda8d7omSJwH0c1v3gteslj1Oj8NaEh/NROMdFNUfGa7JBHG6LvkMtbzkOqhBfmTNUKC6CRH2PjHKXufh9QQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(19092799006)(1800799024)(11063799006)(921020)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7kkLjgsrZE4P2iKHJ7+o/ri6GTtm9kXbe+ogIxjOj82WhwFNpXwAWYoQiVpe?=
 =?us-ascii?Q?BHQLDdQf3eUxkyB9+NXjxi5fOidU9kBseiN8587KDaCyYCZinJCV2LDzb+VM?=
 =?us-ascii?Q?4hliXjMTGXlK2pMgxxNCScXx0LXc8bDXRRrgiL/JwziUxNDANDxIiq47pMvI?=
 =?us-ascii?Q?P9W0D5DFyZqZKNDeuvzO1QeZZBSMHVHK2/Le0nZuvEvOy+DTUIyzOrfxI3G0?=
 =?us-ascii?Q?VVqIRJNYVKWCr581OomiBbslP5fiG89YEA4+Ns6D3rKuM2ViW0MxexDEkzlv?=
 =?us-ascii?Q?5g12KpglvViwjWa1ywDAjsoHHeouS3qb64EoSxfj2zHayoDSJ4TuvBDtGjSh?=
 =?us-ascii?Q?4lqo4i7N/LOz3yTQKJ2Ak4TO+cJ1b/U5xSxkbED1RyRX88iyIwvgQGplv/Ax?=
 =?us-ascii?Q?kygVO0FoHzamnM6YBxJbACq3mKny2yGI1UbXXNj4C/jSJUdl+oCPSdyUV8uR?=
 =?us-ascii?Q?D8i5cGZG9pby6+cCYVCJKAHTFajw8dzq2MbgzyvhiPMWjMA0MrKNVi7DnOnw?=
 =?us-ascii?Q?S83QElTzndb0RCH0tm1jbgGb3UqBdSJuHHWhxHaW45k6PkvlTAQ/gDPWVU5u?=
 =?us-ascii?Q?bVtilt7BCe3k/qkHdMjt5r1Rw0OmUgvXVbcHRo54or/Zg94czvH7HwMr5DS9?=
 =?us-ascii?Q?tpieML7B18imzNQP1Ex3UU06n8KyDZ/qJE40XaAqGRfGbd7IVXupiiiuUnDY?=
 =?us-ascii?Q?G9N57Vmst/u2w5aqvcjTPuQ/HcXtUyco21YYEhniB2Kmel6ZlGg5ntjPVwLB?=
 =?us-ascii?Q?mLrVNkjkAyOrN76PIzIyENyhDTHtNByRj6x3YurMbx5SfhLejkAaULpmXm7w?=
 =?us-ascii?Q?/dM1feoPfeeOu/FYE0f4sTrYcmXzhLLa9qmkIyrnRCNZE7nTjvPP5ocLCgqx?=
 =?us-ascii?Q?GZEc5cGHxubzqKFRf7LyCLv+kJqlo7bPc3m8IrcZiDN3yty4MASmUZ1eQHXK?=
 =?us-ascii?Q?HfllUxpGicGUEE172nKcKB0UJ3o+sZ3kXXc3W20hyr5r5nwx14CGir0oaReB?=
 =?us-ascii?Q?gr7tdDZmbBM1SkGUe+uN4iconLBhTlaCyyGVlRoBq9PVjfBMOHJZmKPcHS4m?=
 =?us-ascii?Q?Gr21CKh8EG1YRqSxO3fLyCMwY2r/tUUhBmcid1x4tcLkHwDpN7CassBROFWp?=
 =?us-ascii?Q?noG/G8GZfZEhUjkKrBNp/0BAyRV05s1uBIevMigCkGcGa/YD2vwvV3QHIw3K?=
 =?us-ascii?Q?HcXg5X3ZKYN3y6FW0DJ6GkKSjHjF5oKNSXzhXzLzMXxzK55QGkJ180a3+dFV?=
 =?us-ascii?Q?CHx+pBbmZS59KnnnwTPhAu41+g83Eo3se6+eAr55jCDjonXZVUwAPNTAB0+v?=
 =?us-ascii?Q?vqS7/zJGB9XylpwRGTMZIYJK/EVn9ClFatphozPDzVl1W6JgxMQK+PnIiw5K?=
 =?us-ascii?Q?mGlUpkPwVyVJe6kWqvybj5tW/+LnRuHrYc12YNKfrLbRP1k3ZeAd6qYjuac/?=
 =?us-ascii?Q?PnyZoDInMoCy3oTRCM1eyC13bbJt/Z8tB+3UOJ2wIJKNiKjhEUfaHZhXPIhv?=
 =?us-ascii?Q?RowuE2mgQG73oR4nT31lHGSSUPJcLtHGTkeq2NjmaXDumqJ4lKnkrqKiDooM?=
 =?us-ascii?Q?akSLHgg0OdCcON0jrHV+SDGL22fLKhrBJCjFZbUUF50vfn5KQ4DTp5XaFpsW?=
 =?us-ascii?Q?QoHuQhvDjeOX21xH0q1UGF0RIPd62RxifVT05phYrbSG/Xic3OqhsonjXQks?=
 =?us-ascii?Q?PdULmUH8Rnpkp7lBuFJLibO8thRz75mupEbVj3+et2IqO4Yc3oOQCL4IwUBq?=
 =?us-ascii?Q?idv3arBkBYlHJqrBkOp8NBLTivP8vDmaDee5llaDGkFFWV5iEdKB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ec66b1-254f-477c-8170-08df2846e44d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 09:55:05.5835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxfZ6H58uDDmq56CEx5Pz65PgYrJbtVXjl0MpAH8QjRrEFvMa51Ma8NvF9FGAlAIO0xu/Mf676Rt4yvD7wNGNNtOiaawVBHyaGLPJu1Vuy14ye/iQvvQxtCFge3d5hWE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7480

From: Wei Fang <wei.fang@nxp.com>

According to the NETC reference manual, function level reset is not
applicable to the timer as a supporting function. Remove the pcie_flr()
call from netc_timer_pci_probe() as it has no effect.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/ptp/ptp_netc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 376b3b0d1a38..aa9be8e2a630 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -777,7 +777,6 @@ static int netc_timer_pci_probe(struct pci_dev *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	pcie_flr(pdev);
 	err = pci_enable_device_mem(pdev);
 	if (err)
 		return dev_err_probe(dev, err, "Failed to enable device\n");
-- 
2.34.1

