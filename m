Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.222.82.137
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793121104;
	b=wb8yrDTI5OhMioClDKS5BxjkZ8Z3ec2US1DjkvHtt1qPeMKsBIyc5l3GQM8SXDMDjBZV
	 FLYNMMbSQjfVjrNIOFqNgthq4iqULGQfggx+gjt7MMfSIr/KwYqu3Q8rbmPkQmefvErgg
	 2pLI+mPn5XhiXNbJX+zGSW91+f0ROQ3evFB/nIxSWvPQ5lkZdJZbYPgJ1t9uwlVCARxDC
	 J9SB55RB9Wqx+0B3WyodATdpIFQT5LTdU7coxkeNqGq3NZSn3FUl4ymx+kkCqE3JVGZdY
	 AuCM+gpFoDQBimlNHtGdcWsrezO25Tkh02x/fs7/9Hbv3+GuhXIko9NkduR3KEJgyGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793121104;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=cjKXH4087K4SHB01speMtySKB1IOgyNR+EwaYeFG200=;
	b=xjagq2X94b0GK5dJ9I7Jkpchna/QJPXIhDLXvjD2vlLUb0fkuJ9R9UR2v5Sg5EClJXEI
	 jW7Fy+4IZib2ZLKf0KUHsOTuODXuZGrRqA6SD2UBYuLbO8bKcJGX28FKe6hoJKK8jrTFk
	 1YeRXX6R7uuG6ZEI3G8oPXnMsMJbQoMGb+sXaCZ8h4HHhRxH4+sCiPiZAqLC4LqU1+5Lp
	 jUVBGjIVj0tu+Bzr6TE0svFwM4c70XyYZIRmGu6gt4qrYdodz0cn1ZYlrIedfsdaMWYSr
	 Lvgd7B30rX4RPFt7/u3NsIuxeZ+5BpOvmXBV7lCdsLYHp1XuzvqbFpz70BI107a4rGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=opengear.com;
	spf=pass smtp.mailfrom=digi.com;
	dkim=pass header.d=opengear.com header.i=@opengear.com header.a=rsa-sha256 header.s=selector1 header.b=YMqB1TWI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.222.82.137
Received: from outbound-ip199b.ess.barracuda.com (outbound-ip199b.ess.barracuda.com [209.222.82.137])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791E7606A31A;
	Tue, 27 Oct 2026 17:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 791E7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=opengear.com header.i=@opengear.com header.a=rsa-sha256 header.s=selector1 header.b=YMqB1TWI
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020123.outbound.protection.outlook.com [40.93.198.123]) by mx-outbound23-160.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 27 Oct 2026 17:11:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUD4BAY52LRRRRXTxNMskbYNCKqHjJkYdcXVPWIT1CGByZ+TTXIp99A6Ks7OPFu5p8GxhKeQfHm0i23Wav9GYpXrQHS2qnVHEpVv8wVFfpeIycX2kCuqEe1k4xSoBxIApai1NtHQKwOViWMgazWMwBj/AyrVNAqtImXR29PJzae9kFJJb0Kw2qLp3KxkGZ8NL4n/NFe7Z9UzGW7ArG3APd7ohktE4TcDkf4XKFvEXHe3tXFwL4Rw/3J+wBzjpfLv/leTa793HoP14nF4LZFCk2tMLARZ2ejXCUhFuFl48U6e/t/xh+E8+XtUuDIyo2hhUuJM+BmE/hkepGMBwWZiUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjKXH4087K4SHB01speMtySKB1IOgyNR+EwaYeFG200=;
 b=B4gaS2wmysjfEWj+nMb3wpLui7Hr4u34Wnf7PxokFc/9Wp+OiW3VX7OPihxvR68PwRk7p6NavhXEY0r9CmYnEnKYTp0g/aCX+iKAL2aKoXO3/h9Zk8cF+RgCZnB/18CQ/HhtEhu+ArgNjcGR5rX3502OPc/FOYkkqxed8revyg85B+ChIxstopehkTCDzdO26i5MImuEpvIYQFoLmuKMgADxuMF2b9YdFhiZaiwRx/OH4TcTAz/3WeJ4TnOXWNaAlfvlEZJsBSQD0CAf7Bmser2AyRxSUemr0iYhBSXhX8LAIMqUCEPUIUSyvKoIUw9+Q7U9X0vRCYq94i7Ai8Bzug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjKXH4087K4SHB01speMtySKB1IOgyNR+EwaYeFG200=;
 b=YMqB1TWIZJhLxWJdTquDScuGReXLMfbTAq5jNN2odDTiBXDq10UuWmT0RoQVKibbpYr0QtsFteL3v7BJwL2v9v5bwbbej4HpmGqddKjQfK/yXmPhbOpseUi+1uIYQZe99gK2AKnVkePoiYx0k5fLmd3LCQ5JlM2rdleuab5M/tSXuTz5RrGa/h6Mp377qkOiunWGqJXKnD79DM0oD7c/6h92YmH4dKJYfVLVfpx6rzjawM4kheekeP+U9S/j7GPoFR9N2oAhkmVbhHA4TprH6wem42tC9EnQSbhxIqAD0uJGRPprYcRTJXhWD1dtgn7f98oaV2ZOPVYL11id7YzXxQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34) by BLAPR10MB5057.namprd10.prod.outlook.com
 (2603:10b6:208:30e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 17:10:59 +0000
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017]) by MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017%7]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 17:10:59 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: netdev@vger.kernel.org,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniele Palmas <dnlplm@gmail.com>,
	linux-kernel@vger.kernel.org,
	Peter Hunt <peter.hunt@opengear.com>
Subject: [PATCH net v2] net: wwan: mhi_wwan_ctrl: send a DTR drop before it can be coalesced
Date: Tue, 27 Oct 2026 11:10:55 -0600
Message-ID: <20261027171055.1796482-1-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:a03:338::26) To MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34)
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
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2095:EE_|BLAPR10MB5057:EE_
X-MS-Office365-Filtering-Correlation-Id: 917434d6-92ca-4558-e5ee-08df344d4535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|261026121527099003|18002099003|11063799006|261021121427099003|56012099006|10067099003|261021123027099003|261009223027099003|261022075727099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	izd2/SYAr8Z2AtP6lGZvgqVKGWrLIfCR6US4HXBfqifPo3vIVGexN1ilZ8rOFx4fYsERw9KFfDOK4M0/LGIzP1s+v39vx6MiHzlaGcVj17fVWeHHYCt6NNb/0DvtSgxNvJqn6gbwjrHBwjri5RW+M1VXw/dU3UqrdiN846O6Riwre9UV/LujQLQHiVQhBjtDSIBvvRBcaxyGr4lum6ySR8NEg8DX2OXF5edZa0xcY1i5WEEHSqHNApCvKjRAi1C/zmNORvuuXhl0PZnrdyPSoniCFyELMq6/JWPHspMaLXfdqjadQxBIIRoDTFChGrX5+yXjB7GJKTklryeUqkqK2rHhwf1S2iVsTwzPwzC0lcRCYP25/ZCxS6n4XinCESsutkPbYKbBryPnACRo6c2NXBexqnYDZtQ47XmMsVQgGy/l4P/KVDcDWtrqIDUbXlhwwV1g8zx18h94wp8nVvo60FL1Ns9xPOWQYuoVThWv746ornfjuDW2Nd3Dblg7BovIosDX6Pfiat8ty+0JQaeuPelNoRRHut0UDg5jzbmDki2PozNb51nJHlzvJByNftRhIrGPeiYQXLtyUNyywh+3Uhj7td4+ZvEozKw5xwmBI7g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2095.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(261026121527099003)(18002099003)(11063799006)(261021121427099003)(56012099006)(10067099003)(261021123027099003)(261009223027099003)(261022075727099003)(261022105027099003)(261026140227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?74AWX12AI2/k2mMlu3X0KKztpixMTgrA/vsRRoQ6/YRNyeZ9t7MIZYXGPzDx?=
 =?us-ascii?Q?nr2JHjbLK45mJfYdq2C/9tpu7zHIxfl847tNlePAa1DbprWA+uyUM22fORt5?=
 =?us-ascii?Q?7dBXYzpMpf1NnGey36W/fFsHhvGTVNjURjwgBXAcZId4x+dFulSie2amLYg4?=
 =?us-ascii?Q?/f2wh08zd21f9mTBtytmUgxdWz2FxFhuGFAj7b4Cq85oc5V6z08jmKPV8wEx?=
 =?us-ascii?Q?hjo5KuvrRKKV1hOD6yLLWYROU/I2LHxQXHjTGUbXJZQGSYgK33sx94jzciHg?=
 =?us-ascii?Q?xSNslvrS/A/9+hnEZhyWloRsPuN4zBIYXSRSXpzslmVnc3MXAmiLUd/BmU4u?=
 =?us-ascii?Q?JZFgkArRAYQKxEs+DioQMX2j/i7+m4jeu4ToZMCFbTms1wgTvoK9u116rKe1?=
 =?us-ascii?Q?2WzBXjC50Qfi2/JzYtB2ezLA0rJYkxj5AZf4kAD/YnsGgXpFSYqdDrpEN7ml?=
 =?us-ascii?Q?odEP+LoSK3lvEbxV+Bx4equGKthhx9ZxleARKkDejL7XKhBE+1ZEJkzvMJuk?=
 =?us-ascii?Q?O63Nndp4iF9tfhFq730IMSY4ByzYG9FVEoDuSgBVjZpOf6QjXQoe8Hms3AX1?=
 =?us-ascii?Q?jvYsfwnTQ9Qw7Ow6/hBGj0rXF7yax2XK/Md2sfjLsp8DyjhZThEEBiyEnNf3?=
 =?us-ascii?Q?+FyT6HWrAIwv/dbojpIqHyoldsL6pw/Jn/vjLQGxAzQw8Y0Zm1l9YJ2trBhe?=
 =?us-ascii?Q?gztpmvWkdQTfKRUSYLohWHp9kc4SlV1CmZdRegfLRbS2ehmZ9P016dazoOZh?=
 =?us-ascii?Q?0ynDnnuTsddyQySXYKypyMCeTEutTSfiBgQykFeCXhfT5B/ZbrLhGER6XxMJ?=
 =?us-ascii?Q?0hTE6m/21YTs3eAXIdrqxvg7xRSwqFfty4YB7XlZsq7FNBoGdEoUol7/Ur9X?=
 =?us-ascii?Q?dFDSqb5s6YLTlZDBpjb+JUeaDwA2P3AYRIzoCHvYl+h8Wk5Q2d+SeH/1fYah?=
 =?us-ascii?Q?8EW3CEXS25+4DexuYdJxsohr3IUCG9ShGNXXCLP23ZRnNmPmxsu4yGDxyZYY?=
 =?us-ascii?Q?hnHMUDtodzfWVFuTydqt1mg3n0dhvJzgqC/nCfiTTmC34VTN0v6tOV2hDpoT?=
 =?us-ascii?Q?uDiNXSsaLUs+7WJucP1J7X53uQ/CsmRBHPEDkHjBs0u6FUJGBLH3nPbrlmwn?=
 =?us-ascii?Q?M/KqPdV12ID28jP/wJn/htc7E7XJIuCQW6+4UE/oBrEI6IR1cBx5YvihfSQu?=
 =?us-ascii?Q?av1iLnIwQPojIbqSBS8oJXIVBdyySwZx7y0jbNIDxktzn3d2RtQdCdu1Yhvc?=
 =?us-ascii?Q?HQjyQuWncrUnQjT2slyHeAxUxemeKH2ZNEfpqvrd/dplb0JiUxwEbmQvtqxq?=
 =?us-ascii?Q?CZKcj/NQkcwByxXtLnshxnVTxRayNP5f4ZKEiRHXlb+YqJ9V6K2q/Gux4M7L?=
 =?us-ascii?Q?6HDkyR4k+lgrhx5ffdlKw1ZER+VRMKybrcSJmvhYrSHLgcw7tkfg4P0pCgIT?=
 =?us-ascii?Q?fpo4PBlti/aq4xRpTWiENZU785qSYrotNfA96jg9KS0mtNWZOd2A+wxo8O1G?=
 =?us-ascii?Q?d/gk8Rk+I2xku3hjcFRJSo96j+UU7/qwrhmOBQL7iLYrQwWSiJmWJuCVhVqP?=
 =?us-ascii?Q?Ts67IaLHptw2PPATzpGv3xF1/UK4o2Mq+oLnYgYVUH/G9b3E7X9KNxIuaHbK?=
 =?us-ascii?Q?CHeXmCA4DyXZhHzz6kEYjqT3utwtgHZjmHRc0kUk+yoMtRKR8fdUW0Zo38Bo?=
 =?us-ascii?Q?ZNpW+ptvBe82A9coK4VUruK+7H7F2ODAdv/J/ox9di6A4sO9?=
X-Exchange-RoutingPolicyChecked:
	GLccxNfV2tBWJJA0a7eGruOF6FzUvNFUPDIIT3hJ34b7gAuXrNbdU2L96sIJUfoYnK6Avvn3O6Xf2+wPEsXDoIdCLwWQiB1d017YB2nJXYVbkDHeCrZUhiqkDzKxqMhEik4Hr9liI6ccs+X18OzsQgxnkRCAmbaRU7rpPI7B+qx4SOqZq2+XFzN4LFQu3LyBzz8mVicN0Dq4RLvbHtNWIO+F3dDGCxEntDBdSiUTGENbPuTAJ2mXVyz+mnXB1kRyESu8/FYAnWHComYt46BK7rIPDVVVQo8LeBksAhWKT8NWaJE2BKzT+OIJQgfStvl7ovhs7/FklMxuReyw6Ua7sw==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 917434d6-92ca-4558-e5ee-08df344d4535
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2095.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 17:10:58.9240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQqOJ2jPRiZCnk6HIks6ktjNLhGEhcV+B+BvpubBzhTS36CS8644i3PJACdfVwKi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5057
X-BESS-ID: 1793121064-106048-27997-7587-1
X-BESS-VER: 2019.1_20260924.1519
X-BESS-Apparent-Source-IP: 40.93.198.123
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkamRmZAVgZQMCnV0iwtzdIkyd
	DAwtjMItXYOM0wzSw5LdEg2dTc1NxYqTYWAGzb76tBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.277152 [from 
	cloudscan21-16.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

DTR/RTS changes are sent from a work item that only sends the latest
state, so a drop followed quickly by a raise, for example TIOCMBIC then
TIOCMBIS or a quick close and reopen, can reach the modem as just the
raise. A drop matters on its own, a modem set to AT&D2 hangs up on it.

Flush the work when DTR goes low so the drop is sent before ->dtr_rts()
returns, and flush it in stop() so any pending state is sent before the
channel is stopped. A drop that hits a full UL ring is still retried
with whatever state is latest by then.

Fixes: d509edf90bc6 ("net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel")
Suggested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Peter Hunt <peter.hunt@opengear.com>
---
v2: Only handle the DTR drop, by flushing the work when DTR goes low,
    and flush it in stop() as well (Loic Poulain). Drop the port list
    and resend on a late IP_CTRL bind, which is only reachable by
    unbinding and rebinding mhi_wwan_dtr through sysfs.
v1: https://lore.kernel.org/all/20261023174113.2388353-1-peter.hunt@opengear.com/

Tested on a Sierra EM9291 (CM8100): back-to-back DTR drop+raise and
close+reopen now always send the drop, bursts of 10,000 DTR changes,
HUPCL, teardown and lock stress tests.

 drivers/net/wwan/mhi_wwan_ctrl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
index e3c207588956..772319927867 100644
--- a/drivers/net/wwan/mhi_wwan_ctrl.c
+++ b/drivers/net/wwan/mhi_wwan_ctrl.c
@@ -209,9 +209,17 @@ static void mhi_wwan_ctrl_dtr_work(struct work_struct *work)
 static void mhi_wwan_ctrl_dtr_rts(struct wwan_port *port, unsigned int mdmbits)
 {
 	struct mhi_wwan_dev *mhiwwan = wwan_port_get_drvdata(port);
+	bool drop = (READ_ONCE(mhiwwan->dtr_mdmbits) & TIOCM_DTR) &&
+		    !(mdmbits & TIOCM_DTR);
 
 	WRITE_ONCE(mhiwwan->dtr_mdmbits, mdmbits);
 	schedule_delayed_work(&mhiwwan->dtr_work, 0);
+
+	/* A DTR drop matters on its own, e.g. to hang up a modem set to AT&D2,
+	 * so send it now rather than let a following raise coalesce it away
+	 */
+	if (drop)
+		flush_delayed_work(&mhiwwan->dtr_work);
 }
 
 static int mhi_wwan_ctrl_start(struct wwan_port *port)
@@ -246,6 +254,9 @@ static void mhi_wwan_ctrl_stop(struct wwan_port *port)
 
 	cancel_work_sync(&mhiwwan->rx_refill);
 
+	/* Send any pending DTR/RTS state before the channel stops */
+	flush_delayed_work(&mhiwwan->dtr_work);
+
 	mhi_unprepare_from_transfer(mhiwwan->mhi_dev);
 }
 
-- 
2.43.0

