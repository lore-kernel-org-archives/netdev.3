Received: from outbound-ip199b.ess.barracuda.com (outbound-ip199b.ess.barracuda.com [209.222.82.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FA548EBC5;
	Mon, 12 Oct 2026 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791825648; cv=fail; b=cxkREcEJ8UnkZVA6q1Daee2n3e/YgrmVd4pifbLTJkPXgKkHS1ksZM2YtUT4pDmYgBCImH1ZFIL9fecC8nKaZXJwGCVYeLGx4jBHnDkBJBAz0veQqetPva3+XJKSMGbrGu7SYLghkGTO4rib1tfe6M4jYpXbgU1uVEh05R5iVv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791825648; c=relaxed/simple;
	bh=lpnF55VLP3MlV34/2gv2UpAUryamyp6QIsDtVXe/eLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IbQ4PSC7+jFKP0dObM0ZZm5E6nNV3n4cCB5supM7e3yls54w05qUvpwqRQDwaNPe2GsPm406gvdsorlI8iAc9zx2DgYlNQMZohKkPnbBiXL/QBmL7P6deKPSAKDJzcdeicU0KSrxSCGsfHuv4GBazbExj8bZKJ7VKicizu5LFMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=KW/Wxwwd; arc=fail smtp.client-ip=209.222.82.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="KW/Wxwwd"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020088.outbound.protection.outlook.com [52.101.85.88]) by mx-outbound42-29.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 12 Oct 2026 17:20:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NeTTaq8UQEONbUieWl235BQeEOJl48veyP4w55KUwFDtxS6wH2RcF1/cURS3XO2u/y8FITGSsTmt8vrCdkdbARu6L3E08jN3HSi6wCOhAN3AQ8f4nAVKUumsulVvEcrw66pxBmJGIMQMspsqrNEBim1icrsXA6WAbqfkbhqPDVMNap45Va1iYWBMF1r3A0fEeVSpNt+HIuepnG8NaeqREu1SjGT9LHdbnQltdpPjNEKxjYyResqo3a/UU5YI1M2TG7XOn3nnjpKsSHaKDcjZovynyM4XT3yvNyQ2qnOi7q7Qas2TGy6+ISTl5wkSZkzBYF5/5duoZlgli1bEVBIq+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpnF55VLP3MlV34/2gv2UpAUryamyp6QIsDtVXe/eLk=;
 b=S7U4QHzSSPrFAZSebQjMWYF7ka6DUO+X92vFATII9tMPl2MbyV85cvdk/4p54oY23dyXEwXZxSGz8+SsRasUwVty0TdiNTCjzZC2aiE4un5KhOheRB5dTbgl9wjDrWFmw2U9LDMs8NyHhMyn2sh9/JGgIAiJCaboVsTsftjwEDdrdMflobHyGU+Pg0VCK473wXKIAL5a6HEPFPa0R1SlawJILdETxMeW4v5Cnn0w07RmlV54ZOiY+/L/7X7dacput3A0XaMIH/g/kgIeLjoxIck/ksP7X6H0PLRO+FgsUfblyiNOlxdGvr6Sv7PRE9/z1SFAbZz1fTIYLCsrvJwesg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpnF55VLP3MlV34/2gv2UpAUryamyp6QIsDtVXe/eLk=;
 b=KW/Wxwwd4wYiSMJihmkTGpfQVcq4BEewF4jyJx587G6dFmOJks1vyyM6o36WS6UoSg57tEQX5SNbw1ryzOAAXjizED5SoV40e1nYAINOm2OAKvdIkVmqlayrw5gQ+zfXLQ+ChCmyrDVYuY7yCFSDbeLVT93XBr8ZaBJqzJPQejZdbdeUPdPYGJXuijuqzFxdC1hvih/lUqiW7vNbhQXMvLf7Pk5kRbmIE64jZ3VgXtbf72lQJto0+7Zc0RPiuk3MBUgUUJ+996PZhrhnITebPU5XfDo+c8GgLrgkcZXQalKn/fYVqZiXh4keCpyWEKW18tkcJ5A2Tq5zAgXx3FGUwA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34) by IA0PR10MB7301.namprd10.prod.outlook.com
 (2603:10b6:208:404::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.8; Mon, 12 Oct
 2026 17:20:13 +0000
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017]) by MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017%7]) with mapi id 15.21.0522.006; Mon, 12 Oct 2026
 17:20:13 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: netdev-bot+sashiko@kernel.org
Cc: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	mani@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 2/2] net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel
Date: Mon, 12 Oct 2026 11:20:11 -0600
Message-ID: <20261012172011.3668250-1-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179174581889.434549.17109268914009115980@kernel.org>
References: <20261007182238.1154851-3-peter.hunt@opengear.com> <179174581889.434549.17109268914009115980@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::29) To MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2095:EE_|IA0PR10MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: fc26f2a7-2807-48bb-5705-08df288513a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|261009223027099003|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZfvpAzMwDNJdZfdZXbK7VrVgguC//WaT+EPwCFvN1ulm+MVHSQUvd6OLRvGd1Ps0054lB0knam3IsH4lhEtiQXjwGLhCM8s+GUxVqcqdTbAA7xE0tfjb+IXVoXgEl7GxhgN+kWuEL/XSezOEDhaG2ln9w0La8assDNl8vV6uEKjla1x5ltYDm9UBdgZZ+GJgXjJ3yux0ErwSsoKDqrxPvOlLaT2RFd81cFM+SUxTaAm7y3P0gxkB+uV5ndRM7IFKR/oUsVUTlQ3ak+aC04+aTX4t9e54vk48f4pV1SsQX45xLB19cGa1q3UVRnsxVUpzj6Y8BDBJsnA1gT5NLDzNrvRhM6SY6QTBZdXV6/PvXzYMIgb8srBU17UjGH2I/G6nlz7z8ho/vEdA0T1KTs/hBS25kDplykxdxxEKjNMMpo/nn3gRsn1KL8RmaauXrzNP4sM/Nj9NwO6RONz5m+4D6pHIQB9vOib7KobvcLIH7QdYvtZ2H3/q3yxihZXyVu8cNJoXM0GJY3v6Su+WLhuWKu81ZogVPmavW0DOTFMj+Y2+tTJ21H1aQzAryqZ65EzAyhNE9u5ym7cjBJNeoFwSYJZRpOf12bFPzivdm9U4baRaPqimgiRyUwwBuZXNuqEK/MvTE6hTW8TdIspk/wlFGeCnbHX5EmoZbWx9lIZRmhw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2095.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(261009223027099003)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6cv/mCRASef1m+CYkwSuyYun/6lWWukcFRoOWLfG/Y7irge3Iiws8wuLXSXo?=
 =?us-ascii?Q?6khQDttOWf++G3OgzJKzYZG91iONkxuEy2iuuM5p0rG6EQvG/VtcjsXTJ5ql?=
 =?us-ascii?Q?V3Z47AjrDY7DhLVJ7343v6wxk3Z+lJN1n/BM8FsNP0CyCpAxWgcUfWEF42t5?=
 =?us-ascii?Q?b3aHC9lG45dj/vLwdr2CnoQ4ayBklXDX0DDH0eRhfbZLtRTIlhMdPB6s5u50?=
 =?us-ascii?Q?aTIFq7n/EQziAVVEY7xYvVsuqXBVl574Q+Dzd+ogAB2Qh6ovk2lX8uMCYcB1?=
 =?us-ascii?Q?a39FVBo/imddsl/P/aBF7ZfTZn1GoS8PKUVcasAj2v/UmLsYW8hofgD4+WOU?=
 =?us-ascii?Q?Nok5jaP7R++s73gUn6GOXIK3KhF0uEafv1VHGuvHFXazrm4sExlxGzRFX1ea?=
 =?us-ascii?Q?14z0whgl/Hbqn9nPgXpRt0GsGBc5IyT52YeaIKv6ppD3oiimfAXALg2Mu6+a?=
 =?us-ascii?Q?0/gi9GgqCL5iFGVHhS45/BYpyCBxM+fufT6ExNM1aBuGkCAY1MYaOUP4bEW6?=
 =?us-ascii?Q?LwSK8jgVwdwAJbKsWBTakgRFga8INTrGiqNfeJZwQ3MaTc+4VYW0NfX8WXxi?=
 =?us-ascii?Q?pXSMN50HcDZTfbV1Jsct2xzc7CUUBnQS8MG9MhGvB615hc4EgFUWtO8M89Xk?=
 =?us-ascii?Q?DCp8CSWoTODwCVztbN07hgEqFlga54Uz0abmmLSqm+LAM2APYe2xua700TUN?=
 =?us-ascii?Q?S6en+vZjc6KvJfPy5TqnQHxMCTbWJEPybM9+AqKcHrdooamFbV/tmdWd21Qd?=
 =?us-ascii?Q?mgbSa8Agsnm4eOLKP9UnZDcX899PN6zafYkI6IzmOonO/AXpP7M7VbEbl3kc?=
 =?us-ascii?Q?apnr3rM2McLrzssd0oQ+wn8qJu+SQJWJGFt4FnF9EC77OP0QApxLZhOtQcwy?=
 =?us-ascii?Q?L/LV7WqUCIlVOjk5ET3miB9zMAiq1eGX8p3XsEQPJn+vJuYjIucFMmatj/JN?=
 =?us-ascii?Q?r8URq+Xjftz8lit2CqG1y1BJo3wF71L3vxyfwSddZQgOr1gfeOdAYusd1cJt?=
 =?us-ascii?Q?XhFUMeFWC2ZYmKvVUk9X/BuNPfdYEsAKrMXTEne+6n97wHP39afLxH81iwL6?=
 =?us-ascii?Q?mC5KGx4PDujxfW7Y94A6kapP6/IWHLar3np3dEQN1ZbziJd+AdxQ0dGaA5Gc?=
 =?us-ascii?Q?0J37V7uyAGqC9Gb01NaSLi1aRI59sO1VvYu8Ij/MHTwbua5jPm6KqLltVPeN?=
 =?us-ascii?Q?ZMTDa8jijFgomkpoSmZKUTk/dEm7+9GXbzfRt+mIAHtRNRKxY5RGq4FRwEzo?=
 =?us-ascii?Q?01DWRviiy40C7qrQfluxb8RydHo/Cj1AlsqydDOOeWWzyLPXCxfLFL2VpIJe?=
 =?us-ascii?Q?uO8pNN/M29SoTjCxNib8LsLC3MRSiWlTmmj4t/p8uI5GnT2Qy/qJB1mRENSU?=
 =?us-ascii?Q?99Dl+TeHB3ZU8Zky7+8Q6IoK6gHD2Agl391QEesojR+1BBmCx1GSSFrS1M8y?=
 =?us-ascii?Q?GtNMkUxASAqfyn6m6VPPRRy6DERQ6PbmPabKV7KcTfqK+ylw0bAR1iBXvjHh?=
 =?us-ascii?Q?1te6JhtWFEpdNeNsLPgEDrWsqnYMTVVRfbwI/SnHV2UAMHCHExWH0sgB9EdD?=
 =?us-ascii?Q?qiUvoG+FNeGcjeZIspVsHmqcdDVSJUwlPK6M9ivd9CY6C8ZhHbajyjw4XXA4?=
 =?us-ascii?Q?j1IuK09qfaq/Y6LkXlcd/2ioJArKwXkvLVm3DKPXZZgv5Em3O5c0hWT1xOCA?=
 =?us-ascii?Q?kRZn0bFagGP/kUiqTDL+GhE6svE/cvWJVg8zQSgi1N9hSC4z?=
X-Exchange-RoutingPolicyChecked:
	zc8WOGijn7OsH8kiPWlXBTHo9JziBSKg2NZNMoFq7j4zTVP8OYY1mXbInQdPZdl30V4hjebJgr4VPhyY+sGlJj0SLACvpEZdVO4ms+yvGTaJKc13ljnZ7OSFnqFGDmf2joDbmhXO7F8hlCzPrbnnCf0u/6Dvl98OA+wVc+gpAUaOqYG+ZZSH6SDH6yIO3kfMABdmMEcpszxiyp9WO0asz7OYERnqa5e/H2jPuUE+KUBokG9QPpG9wYUAlICtBcz5A1x0B5VGlKTS2wyyuSQaACB0jhcChbuFt/UKAnY0rE4KLyOz/iMfFHpFOxItymvSljGmUuPP9v6G4uuqWYp6wg==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc26f2a7-2807-48bb-5705-08df288513a6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2095.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 17:20:13.6239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UxMLMGdVGJWXtEJ+HzQoORcjbkcNM7s7jDq4w49ZkjUJVqp+d9tzPWNZD5JTo4N3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7301
X-BESS-ID: 1791825617-110781-9469-1348-1
X-BESS-VER: 2019.1_20260924.1519
X-BESS-Apparent-Source-IP: 52.101.85.88
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobGlkZAVgZQ0CTJItU0KcUg2c
	DQMNki2SLR0tLA3MjIzNTUxNwYyFWqjQUALeFtXkEAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.276792 [from 
	cloudscan21-208.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Thanks for the review.

[High] refill work racing mhi_unprepare_from_transfer() in remove():
agreed, and Loic raised the same point. In v9 the DL sink buffer is
only requeued from the refill work (the DL callback just schedules it),
and remove() calls disable_delayed_work_sync() before
mhi_unprepare_from_transfer(), the same order mhi_wwan_ctrl_stop()
uses for the data ports.

[Medium] a DL callback still running after remove() frees dtr: v9's
change stops a late callback from re-arming the work, but if a
callback could still be running after mhi_unprepare_from_transfer()
returns, it would also touch freed memory. That is the same guarantee
the existing data-port code in this driver relies on, as
mhi_wwan_ctrl_remove() frees mhiwwan after the channel is unprepared
while mhi_dl_xfer_cb() dereferences it. So if the window you describe
can happen, I think it belongs in the MHI core rather than in each
client driver, and I've left this driver consistent with the rest.

[Medium] DTR/RTS updates that don't reach the modem are not retried
or replayed: this is intended and described in the commit message.
Each TIOCMSET/TIOCMBIS/TIOCMBIC resends the full state, open and close
send it again, and cdc-acm treats a failed control request the same
way. The replay case needs the IP_CTRL device to be unbound and rebound
by hand while an AT port is open.

v9 follows with these changes.
