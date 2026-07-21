Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022111.outbound.protection.outlook.com [40.93.195.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4EB476CD6;
	Tue, 21 Jul 2026 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656411; cv=fail; b=EBwNtSryU2RE+GccWUW+ONtFtFTbkBDD+zc+w+NgXFsHGpOduIhTfJ1bj8USfjVXoRRaL6CYgk8tg1hXt0Z8ZRXRo/+JVhd8Rhz2u85DwtiJjDmY5YGc5GpYSFVx/cM3oXKgUHs0PTTB9Akl7o8z7mSaSGk515FM743oTH/95fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656411; c=relaxed/simple;
	bh=jvLoUgXzf4T5CnfPMxR1IExOgtI+4OHDUQwOg2jWI9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C1gNTCs/xS7Azp9RRfz+OT67IfoO2RdmlPG4CDwsiHIPP22E4vT/Tl3ONTvlgkFCodsKWfd9IgGx8fzNLX29PzipQxGsYie1mqMr3l3n6MGOWY37WWTF2LZz+MCFBCEQGyN17k/klR9vv+Z99Rf943UZCPeCAMzZth28NwtgC0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=hhJM5gVU; arc=fail smtp.client-ip=40.93.195.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="hhJM5gVU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gz1OG3dYL9z8F/aG+tVhMqLfBurQ3naO7nIXqkuVeffFXCfqKg2mj5W4Vwv7lzfSwPxIdaepibuLCgQmw0MaX1tzO5pWTHpFVQc7l5eGoMRNEq6omXomdoqWgG7yUqQwc0V9956YLQl4GVSEkRwJrV5SPbM9QLFa4qEf6yeOB8yGmDbZLBnsp9rAnu520+bRz6u29a8H3/hOoRgHxBxBH86lEOqS4GlQxoj/T/pAhWO6qJXgIfIO0eL1gxUhQaFJJ80TUmnXyN86ghZC2LEDK65d1WPMEOtx1yCD0OWTlzVetVUqJZ7eYUjzQyZlUDPoYpQDZVL9F6W5ilYtRPc+Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x50b2O+Un2OwzXoeWcjVY1JZTIFrGy5nIfA0YGnKxqk=;
 b=zG1PUpj6hn9oaP+fTmZlBp5ehiH8ckmIhRV6tZJM0/XeeFOshYJ6QfyIzvsHlD5Wex0CY0UhAoo2Au1oPYGb7yQY+bHazwhC1R6t2hOgcxj0MVu3dkHeIDtU1xfxRN/hOCOPcud5sF/lwPh/SVdsuP/s6/xylhG2mSWXscQOHjac4Kjs+4sXr6uceYDmGrpuyWJpHlUF67EI+BnnzANBwG4SnR9dlaPP0LFmI8MfKJ2NnGshd09I9aXAq7OkjE2T2Z/FtKRW/xHdKwlArS9QyaTuWdMxS8594D7Wn+fB+xdCM2F2kTT+qmsui7oA2bnQczkXZ/5RAGCt47462O8PdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x50b2O+Un2OwzXoeWcjVY1JZTIFrGy5nIfA0YGnKxqk=;
 b=hhJM5gVUzv4cnttEkDk+1wmlzmhGlHbrvC4R3QQlUTA3aQVbvTcAnVXBacyKW1pjjNPybG2+j7Rxhf4Gi5u6LXQ//ctAMKrDDHPzQXOPwF+2GVSUQV0Iaf8LoGDUd9Ea+UZ1ifQtyx7PGuPsLvPcjtLU4F+ul6PCsD13RRnJyxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 PH0PR01MB7425.prod.exchangelabs.com (2603:10b6:510:4b::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Tue, 21 Jul 2026 17:53:26 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 17:53:26 +0000
From: Adam Young <admiyo@os.amperecomputing.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v45 6/7] synchronize IRQ before releasing shared memory
Date: Tue, 21 Jul 2026 13:52:55 -0400
Message-ID: <20260721175258.87600-7-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721175258.87600-1-admiyo@os.amperecomputing.com>
References: <20260721175258.87600-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR18CA0033.namprd18.prod.outlook.com
 (2603:10b6:930:13::16) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|PH0PR01MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e597b3-4a70-464e-c838-08dee750f74f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|10070799003|22082099003|55112099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	hLuwSuQgGAZYaKcpjnVuSejpTplnaccXHu/xPpeAsbyJr0snb1JhiriDuM6U4pyeyTDhvRqPNOsAizwUXk5bW/C5wZdk/vwvtVgcZABFmrkZ+SxEXoP21WwagFocCSQa1jDvfnEjo+m0dX5B07/9Yf+eM25zRuFjcdEqOEBjRCSwMRyHwRgdeIaLXl6cCkAkXuCSRTporrixQDd5Mx+cp+/o5Vo3boQ45DZi4gDJFIH8p2+kn1iJ0I6BlYaoibSMCT8lRcaNaF0GPb/bOpeTQ0bdMeT4Ul1/8iTznPCXaJBp+dN9ar5k7R2018qOImOyDV08bBZBGljVU1+HLXaWY5kgJVlZKBdHL0B2EkjKgrcKkF3X7uCTGjresoW9koaUoThmeDOEaR+5qGkw2aQlRkhZIZ7XC7xcwnyxO/2Ui88f+tkBJISpqqeh2SFcC/6YoiJeUo3B52uv457B6IDsEOU2gctmIQZl4wwerTDhRHlWMhhsF+6ow3CKnywrWQu/ir2j/+Q8vSpvOEZh8Z1UpF2Qyy6DsyhdFOqEk7ibZqwYneppF8JuD1kGgGiNJj+rUXg3MTz1V2nXuQvgg7BmLs5bgDPf3/U1Ul+v+6Ng4gAP94Uuf1Nc6q8snQN137LlSGjnBWelx93GCVVJF36/ZgPKcNas6hYMpjuYuDozY3E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10070799003)(22082099003)(55112099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UOTmbJZk/pPGB60cGiXdD29al+AcdzUarG6IpuDITVeCdJVB6V2Z44rqb+kG?=
 =?us-ascii?Q?bvwLRx/T+xUnUiTtpLKXi95upm1lq4b+A7DRCPkrPR5AzH0uZZXrWX/B0cEm?=
 =?us-ascii?Q?BMe0bJcqQcIdbQU7TXj6m/1I00GU1HpkeqFyjA7QrpYMI5l8TCpybQpwIyA5?=
 =?us-ascii?Q?OGVYE1QMxKdspvD4hfSHrsqTh0NVNeWiaVX5XWBHW+FhtnNYcBA3oGPyojbz?=
 =?us-ascii?Q?DZCMUJH1/+eonXFUYM+UKkaPRsR8NpPQ3bveOrG9+V8Ml3gaUMRK7Nom5Q+s?=
 =?us-ascii?Q?bAEk3QH8JsprVGT5Z1jTTf6eimrNfaUvOEm4Lz6/bIe3gW9XmRZXOSpXvlA6?=
 =?us-ascii?Q?l17PL277/hGd7E16kT+xQRSD7gVurtNuZJtumzULUr0AohaSvA162qQ7BJYS?=
 =?us-ascii?Q?rD+FLyBUZyEdA+zpUKKHH4TTK5C35ml0mduhFU2CQW9+7w5Gg1uq+ccCnQUK?=
 =?us-ascii?Q?VsnKzdRNTPZAotAe3ExdKhI6xFMkVOa4cgdXW35mtklr+/wbwBktKQWOxnWE?=
 =?us-ascii?Q?O4fG3nTmA/kFtb8D3yEbBU82GtX3brerZwabW/Fx32goRp26nTRGwlXmPpQk?=
 =?us-ascii?Q?5DWtbORp76Um70FMkcUOgxYdjqkqQixlayAd3qANSRfKygWE3TXJOfs1Gp3X?=
 =?us-ascii?Q?F8ysgAG39vQZrlPNZ2Ocym6rLTB5oS06JJOswxn42hi9HM5dIfY9CcjLVX49?=
 =?us-ascii?Q?i9vhWfGmH2DlcWDdv683g/ntNFLr/madRRFLu2LHz3dUyJV+xwCbdybxIloE?=
 =?us-ascii?Q?JBEoxeJUOxhakOgZ8Uu2NvOLI8Nb5tSEN9GKd6ebDXQKtOBbJ35XdJqsvvIw?=
 =?us-ascii?Q?B9HVfVBMPuyE12tbDeqO87tZjNaV4W8MRxlof9LpHvxUP33pWpw9GV/3c/9D?=
 =?us-ascii?Q?yqhbFqEnnsHnUD8Da1z6ntQSlsq9KR1OFezT9mxKRsW45eIcz4ZtSqUc4MmI?=
 =?us-ascii?Q?6DJopIpQZIK8bKENbIcGXAOfTo/86i94lNt/cbJryIU+mMExiZ49Zh34y9mm?=
 =?us-ascii?Q?XgES111+8y6VVLtwNFgvHYHPFoP6yUYTLgo0aF6R++Z0DHOwo9hHZsc5cwx4?=
 =?us-ascii?Q?f/Czg6UmLXHH/LinjsfsVgSaR/0Knc/9WDt0zj7aq+Ok56oIC/a1/942XTat?=
 =?us-ascii?Q?p9ki8NeyRDRv67oCpml+vJlxRoWRiXvc4e3Kf4cejEDDlcI59K8rPhJXDptu?=
 =?us-ascii?Q?wZeaeEYz8RjYwEXLKRbqBbUYrKZvzosPARh4I+5sQ7ubUnFX5nfLL8hvKOlr?=
 =?us-ascii?Q?/zJPJZQcujTb41qp/u/yTiBiCtXI+LzeuFDZTjbjuJxIxNNPJX4tdSyy/XKu?=
 =?us-ascii?Q?O4e1zo5GhpYhaZ8wXFykCB3JvnJJRD7OOjv6zKOBJ2PvelwaInsuwzJSKsji?=
 =?us-ascii?Q?6hun0JUY+13L6fT99Xwz61x3pr0DfcQUgq6Iat2RJJkTKt32f18mUSUJLNm3?=
 =?us-ascii?Q?P3WeWa5NrXAazEP1rcRRk2Chkog9h7OWDpKnsILBLnR9FA5SYDSylS8N2kQM?=
 =?us-ascii?Q?hSFgW5Te3Q3Av3fBwmNYb3B38ItVyp1fHKTKTHlyqL8ab85ax3sBGRqdivz4?=
 =?us-ascii?Q?lZJe6dROz92ODSkqkx5bXTvjmrY7NM2Ot7QVg//BKha5TmilpbVgT67I5jpj?=
 =?us-ascii?Q?BCjByKCwCudJ0TpAkGZxvfByGICHq9sbwKxOVdGUvbR2Wey7PWejWReRKf6m?=
 =?us-ascii?Q?q63yj0ekUaZN6fejZ5jioNylndGxOmCunYITgQbPMuPUYoiRJ1uYhQK7wM5m?=
 =?us-ascii?Q?ItImo3cf4qDl4vmiiukOXWvj9nrnMEKCVzkEgxP5rYb+HocEK2BB2yeeNXrg?=
X-MS-Exchange-AntiSpam-MessageData-1:
	8/X2hbQLg+FmRrv7BbzYJ7QfIUjrHYA2AL3NO6JROAaVTgfnbRX4A/y8
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e597b3-4a70-464e-c838-08dee750f74f
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 17:53:26.7144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8FqhjNHLagaSVQuFperNaTSsApfc36qT0qNueCx5T3N7Si704eqQRYVFLnUH16vi1/mAGqz2HLdpe7fUK3fDz4hHqPE8FzFF2ZCfLh+U0KjblaYWKPXekGrpeyle+Mq9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7425

Make sure a final interrupt request does not
asccess the shared buffer after it has been release.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/mailbox/pcc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index b9a01bfdc95d..2ce2afd255f0 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -537,6 +537,7 @@ static void pcc_shutdown(struct mbox_chan *chan)
 
 	if (pchan->plat_irq > 0)
 		devm_free_irq(chan->mbox->dev, pchan->plat_irq, chan);
+	synchronize_irq(pchan->plat_irq);
 
 	pcc_mbox_chan = &pchan->chan;
 	if (pcc_mbox_chan->shmem) {
-- 
2.43.0

