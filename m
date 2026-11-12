Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.222.82.137
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794503989;
	b=kAWrlgdIY4R3f42kMHphBcc7bCf5jGb3tsVvedToyAsP2MJlyB+01/Mb2rJEltfzeqcF
	 sQvrzXV4Cf25RHeSHMbErQcDxPt6QkmJ+/pGog6NQgdWFPmAfUstGr2gbUSXu2SMS9agY
	 5xhw0Qo54YSGOiR9ApdFvFqDIuIFqlJXe7y6ntQUr1ads5xiZbotgRwKOmx3IKkjIu9Hb
	 JugDHZthjFGML8tYbYiumX3x8idmuhJjarfwKW/Un1XCcTkg+IPnd9KbO9ul9fM+WCZb+
	 ImoUfDFpCOGfkB6sP7eYFVhUmRSQqfrMKwALUtpWOJVeuWCYYkjY4v9dCq1dfbEk4Cw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503989;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BESS-ID:
	 X-BESS-VER:X-BESS-Apparent-Source-IP:X-BESS-Parts:
	 X-BESS-Outbound-Spam-Score:X-BESS-Outbound-Spam-Report:
	 X-BESS-Outbound-Spam-Status:X-BESS-BRTS-Status;
	bh=pbXRyp1qHK9+oGfseSUB4Nq6NHygeU+Aj24dS4pU288=;
	b=YhQkDLxEsAVeZHwVW5LiI/qOJdqIGBPlKljVl5lIbXzUlQJclHqQcF0uUocBuweBL+aK
	 XtDFjbGNqg4uixPKzM4L+n6KSFgOqVXF3oy0DAIss5ks/gSVOS7OunmcOi9UUsE4dAPHy
	 KlzSUuK4OmrxxY+f5QK6vINsjo7lu6+05NGK5my1TLqzzpRYnJUnG7chmk4UmFHh9gwkT
	 bAKRoVQzG+b88+N0vT62XRFV/pBOG+c8FnZP4BaqorLq6Q8gtIM6udXmPmW9U2LaHAjyO
	 rBqThl9SDYEZlrE/bTRz7zWEVJPUwapFK96077CgiQ6aQ0UiGRTwwMC9lNeBIQwUk8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=opengear.com;
	spf=pass smtp.mailfrom=digi.com;
	dkim=pass header.d=opengear.com header.i=@opengear.com header.a=rsa-sha256 header.s=selector1 header.b=gIf8pKva;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.222.82.137
Received: from outbound-ip199b.ess.barracuda.com (outbound-ip199b.ess.barracuda.com [209.222.82.137])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C02D606A8A0;
	Thu, 12 Nov 2026 17:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C02D606A8A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=opengear.com header.i=@opengear.com header.a=rsa-sha256 header.s=selector1 header.b=gIf8pKva
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023091.outbound.protection.outlook.com [40.93.196.91]) by mx-outbound43-247.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 12 Nov 2026 17:19:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FaiFTInl94BaxGOx8dndsQ9kdDb4OqnYJrXzKfmns2BXSlQww+K6QXvCrd0O0W9DJXs2WqQBsNzjzdnIGFZb5R0SV+JhcgYBviv7Me+mwPaiKSlF4ueOnO1CiUjOfXftudLXW/uYemTzHc91+lWgOE+p/eqC7rmXEfeIE3gKKcvpSv1/iB+kbNjcC4G/GYLSM7cB36ErCgqbQLwXgV/iJwEJC3L6/I60H7t2449gT3gIjt6T/XFsjE/NKSFLQiRb9buwjV4Cp5UH/1TAp1n0iK+4p0sc4XQC89e6oignsgC4YzaNvjYssVRrzrONK2rjQdbrfYAhHaGn+8ilDgzlYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbXRyp1qHK9+oGfseSUB4Nq6NHygeU+Aj24dS4pU288=;
 b=DJf52k29pKzMMKPvZIUrJjhBh8ygpuI5lhawhaszIs+Qbw+x7Qowzw2vxSOuydy/qqKlokVwVZHUd9QqzcfqjVMhP05EhG+Ur763OhxGcjWUscGMtEqMxUC2caJKMA0BI6iuJivI0/QHZ2K7Qu4zwhE4fqma+aDknas3hk/2lRXrURNZXE0ymcpeI9Nc9rH2mkU+F+kO5Jk/K6ZJH36WsnBXuaR5QGlCAjie29BktnSClG8rvTIMQx3T4FfQ4HBffLBIu2BLVA4QmUt83wX5RGLIBPvkPJ8v8hz2cZGHz704oZIpbxUYBSCjbmUzKq9sUXc91ALSC/a5B7g+3ZOmWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbXRyp1qHK9+oGfseSUB4Nq6NHygeU+Aj24dS4pU288=;
 b=gIf8pKvaUDo9r9OiBd3YmpFdeCx5n6ZIgXf+H1u9LqH6LBzR8A8mRjNcLF33d0Ph1jSl4eQG3Xm6ElVIbDhpvVoRNfEnIUw3H8TlidwRmkdm46C+KG2zdQ4ENoX18pMnhyOBYKF6ZqhBBpREcdUBKDIcEMabcmn2hEjYx3KhFyudeio/Uo1+686vejHrd4Q5FZqgYgEy0b3bb4UzLi+gBsP9h+ouXdpdkFq4rIk5XJZeI/jyKX/Cq6fjbTlZGc+aQqqxJy+asmkrVTT1BMciV50Tm0DkdAzQ4sjr2TkngH6tTsJCSc1InucUNcJ/iBlYIo6ZXYR1/WE0KKnxDTCVpQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from DS4PPF6C5A39D55.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d26) by IA4PR10MB8422.namprd10.prod.outlook.com
 (2603:10b6:208:561::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 17:19:12 +0000
Received: from DS4PPF6C5A39D55.namprd10.prod.outlook.com
 ([fe80::975d:9714:9193:440a]) by DS4PPF6C5A39D55.namprd10.prod.outlook.com
 ([fe80::975d:9714:9193:440a%4]) with mapi id 15.21.0569.011; Thu, 12 Nov 2026
 17:19:11 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	dnlplm@gmail.com
Subject: Re: [PATCH net-next] net: wwan: mhi_wwan_ctrl: say the DTR drop flush is best effort
Date: Thu, 12 Nov 2026 10:19:07 -0700
Message-ID: <20261112171907.30297-1-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112014152.3352925-1-kuba@kernel.org>
References: <20261109185731.182990-1-peter.hunt@opengear.com> <20261112014152.3352925-1-kuba@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0317.namprd03.prod.outlook.com
 (2603:10b6:8:2b::20) To DS4PPF6C5A39D55.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d26)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF6C5A39D55:EE_|IA4PR10MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: de1ec77f-c764-42d2-de54-08df40e1111e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|10067099003|261021123027099003|261026121527099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bZjSMvWdlNyPrbDv+SGMdqtlSUCm7EUxdHoDZp9tDsVTBNnwlek/0jSoTnqJLvgd5uA5/IEkb4Pb0mS8hQ4NamyQH8kCLe/i8E8K5ZC0Mjf9AkPTb91pn276nJqojgg3DgSXAFILzAqvRxouIveRQ2J3i2vYIut4DPGlbLzzNCHbzFZM2YQSqwDIzhotWFYU9fpzQOiLJ2QOwpHbt4ThtNNVWWx1RXZPYdJaf+Id5fusSbabKpOPaHfs0wBySmMrhnXY1zdlJFjnFLFLA3+plpLFfyeWsGYDuuLEzUcHziuDV5CNNCXxjjhCdzcaa+lZQdTbYmhogfB/e9KABT6AFFObh/e4g5W/X4WjnZEFCSSulsjVqihJmRi2fAtayuLUclu5Q6j/x4NM53zodlzQHqKcqXRGUovxcO5AWT/k/YVQzHI4kXPOsSOljAiA+If7F+YdvK2wFX/ELHTHX1wDqi+nsK//X8Fj9kkhjBOw7bR4UV/Aov/VjA1aqFRFl1F2rFOH7y2dPdtoRtwi91+/lZrVsxv+uPuANw/K3FD5YFC8tHL1xvIcX0yd7ds4l+T2uaYgegbTbJFv4/KFnhraieSDfpGDOWdEQhgnXB2lMw5uqe7VA62Ey0eiAL/nKQ7pqRcObBtYQyOmHxwwXOur0br21jahrqCu767K7WFoKvY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF6C5A39D55.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(10067099003)(261021123027099003)(261026121527099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yUJGVnl715Ani3b0eeX/lQbjZ90chN4qYKbtLJX4SSWWw95bS6eBI+yEN8YA?=
 =?us-ascii?Q?3krIQ8uBKlSw4k5DZjD6F7PfYGMGuCqZZJxl47VC969jdzhzGYRPnDIjiEaS?=
 =?us-ascii?Q?WmhisPY1m6c1PreaFTZJr8mcU4VJ8Ini53iC7RM6L8nzhJIxcoaYuvSmJpF5?=
 =?us-ascii?Q?VESe3X9CFW4z+xxMWVz+p8FU3eO8/deyopMaV/jZmgM7LGCVH3yAjyRchSXR?=
 =?us-ascii?Q?zJLTFvTbdq7RRHlqQIWmwnO8qJDqCTfkd+nfhAnVqS8i9ouyFQyYmE+mpayz?=
 =?us-ascii?Q?KNPDjiMUEGoU8EgqmzKMciT6iHxsDYtEDS4K527gw4JlSPNVHezrIPHZStCM?=
 =?us-ascii?Q?Hg4+BvYxdb5o1xjhIv8atebx80xuW/nDqTRqtGwYYaVCCA+KdNnXuAm/769d?=
 =?us-ascii?Q?tutHxN3RvXxnkp0akfcf6fSqFjmx0AmjVwmHkea1wn0tuNjQ8AN35vNbH5dU?=
 =?us-ascii?Q?eDHiRHTxT8aVg3Q5lRLUGnOsPQMrYA6KwINEfIoLtFD39ZgetR/N/CcgyjD5?=
 =?us-ascii?Q?JED2fPgplhPKcazpQK5C9u2cDzkyjnMOi0e7z7PK/DKbt9lTdRhNbl/jsinN?=
 =?us-ascii?Q?MShOvdoFQey6buOgvM+YdQe6vY/zOJnOksrWWW28/ZKXu26l33B/L7a/HhYr?=
 =?us-ascii?Q?XWs1QZCBt+IdAadzfME3+Y07BZfm3e9ozOK4Wmu8JQVZCpCXeUIV/ieagj0b?=
 =?us-ascii?Q?WGuaTvLVIPoFdriD7yjNRnyhbyKM6H+OL7GJtFyXMqgGFFFLIcNKoEF/lxES?=
 =?us-ascii?Q?X1RXV33L2t0BOT4QhB+m0U0BilbcLiIcQ13q03mdQ6CcTOdLPUKCF20Caagp?=
 =?us-ascii?Q?wzohXKbvh72zBVfvrr2dKOQqIfQWM+9kuJxPEK842bryXIdqVLvG5uyX8MOT?=
 =?us-ascii?Q?e5r7ZeMhFkXQ6/TnTY563hNYxhqRGfdZTKG9eIHOFFLqt/SK0lJ1MIwhisQm?=
 =?us-ascii?Q?nxq7PJX6mcB4RG1iUIoISK5ONtmjCCRNHHLJBZzECd7evIneLKSjye6SZwhi?=
 =?us-ascii?Q?RdfVf9oFaaoL9prDVtHwVTImue3q3j6eaAoEmF6roWZxlBgQn2ub+skjx5mK?=
 =?us-ascii?Q?DI8KDR4zhhRnnTsEv4Jbz2+DW+cH/vglANVREmu5Bf5u7DHZPxZmVsN1fImJ?=
 =?us-ascii?Q?Hhg+gcRsYWKF2CUEpSDmmpsRh0U8YZRvBnFLjDakj9xBLB+RFsNTo8CvVUSQ?=
 =?us-ascii?Q?1R1zmsxrtMAikiOg2YH5oIBo4qMA5D5dgNT4wfssTObopsUY+7F9//r4yHw6?=
 =?us-ascii?Q?KBI8XbAGbfUBd3gojttj55yYUjBDwSx8kAtQ2xb3H+xUIkB4n+0TJbrRzbmH?=
 =?us-ascii?Q?aJmLENQsHbAgozeTdkCcFkdUTiEaVK7n9nkWJYGCZ2ce3oikyIcFcejNB2zB?=
 =?us-ascii?Q?9wOIzFq/zDEmxuBhwtbs7ieG7KouzqPKQQRZZvfbYV7wi5rqiqCpt76celyB?=
 =?us-ascii?Q?KCBH4kxl4JbC5DvdPVzCtS/WW3dQxvvY6ZtB5iEk+ugQO/xG6x6WZrQq273V?=
 =?us-ascii?Q?3CTyCRtzrgb4mvGmon82TA6qZm0sSLiGpfTWaEJlkF059da7vetnUyaPW/Ik?=
 =?us-ascii?Q?EYnN8B2uwqIxjgYP8Mzv7WgYSFBvw27BsHIayt3kEGboDXiqCAI7Bqj2KneQ?=
 =?us-ascii?Q?YnbMRBZSQ+jdvR9SsHegQl24kwSdsgR42rMgfrl9drTyNuvfKDJRMVpfqSch?=
 =?us-ascii?Q?DI7M/I8nrJJCiYsU463dR7tDEbrfiVrDNufH7KwdAatIfpzx?=
X-Exchange-RoutingPolicyChecked:
	zjqR3eh4MBpwTHGGUdxs93Da3uIyADtIlCAvy6C07wZ+VJI+CV1TVU/A0Y0dpl+LMi+y6hiqadoEJ2W0OB9d1eFaaTEIp4d1Xj5EdfmiK/YZMW/JGHdCk+tPrjo1UpqTWxyL5Bmy72vAERK9jqKxqKRTSv7k/5wyhEuk5dd0p8xC3HntOpmfdPD6txERLTQc5BP3lZoJLCfa6IcXF2KSQWwTISFkpkDpMiNWTTrcX7c6yIFCSWSkjgOEdZAvHIL4cFaj583qigfrjScQ8Zrkxi5DtZd5vwzMCvxs/wugLNE++iJ0+hRXvzT4wUBXSL/Dfcos2CjV9AX1hEWgA1VtYQ==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1ec77f-c764-42d2-de54-08df40e1111e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF6C5A39D55.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 17:19:11.0067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fmbvzVoQl1ExWWksDt+BjDuYAQDyfeeEE0TrBwO+lPbd3zAgK+MYsLB5TZirNENj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8422
X-BESS-ID: 1794503957-111255-7668-11394-1
X-BESS-VER: 2019.1_20261104.2126
X-BESS-Apparent-Source-IP: 40.93.196.91
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmYWFkBGBlDMMMUo2TzVJDHNwj
	zJ3DzVMCUpKdHAyDjFIDXV3MzE2FCpNhYArLSU1kAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.277535 [from 
	cloudscan13-66.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

On Wed, 11 Nov 2026 17:41:52 -0800, Jakub Kicinski wrote:
> Should the comment in mhi_wwan_ctrl_stop() get the same treatment? The
> patch leaves it as is, and it uses the same flush_delayed_work() pattern:

Yes, I missed that one. The flush in stop() makes one attempt like the
one in ->dtr_rts(), and a retry goes out from dtr_work after the channel
has stopped. v2 says so.

> A smaller point: the new comment here gives only a full UL ring as the
> retry cause. -ENOMEM from kzalloc_obj() in mhi_wwan_ctrl_send_dtr() is
> retried the same way. Would it help to mention both, as the comment above
> mhi_wwan_ctrl_dtr_work() already does?

Agreed, v2 names both.

Thanks, v2 to follow.
