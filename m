Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.222.82.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793125278;
	b=uJ076quNWAOxYbqkBHnl8Gi7RKIpZdGXjXoC46dKac+NyDdpJjad9+DnOa3NDVHcgkyz
	 r2mLg5JYZBDBxJqdEpzhXUs6qoEy+jqfp0jcpubjQZEAy2YoKqW4elvtFSxnkX+jm7eU0
	 hzFUqyZZ1PDj2tOg5C7ldMuX2+EFlD+AK3Bsvkdpd3s9MEOJOuoGQj+QkplsTsK+U02qd
	 cnbO3PvLDVLksAGTPjvcf/Udfhtn5AwW0seyAvzqRuYPK1mbYnQ3DDysVfMfAW57LUEno
	 OG3yjk3wAJghs0BaI6HsQr53S2XYwTBdOo12PfqPHdkMX5L4PXwBiWNfkw47+cjFYQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125278;
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
	bh=hLmsdyWgpjCpN6J678CUegK0Bn+Wj5D765qISp10LIk=;
	b=5QAJmus+KYCriw5+TDlcF3G6oVtMyZjww6McY/p0cTqU0kAtdynhtsynoubhNF2gpyIg
	 CHd2zrlWQnuYLhp/IAZmGMvyW74+X9KroD+ehsVaS5L/MircuhwopRjcNIZyw7KyBRBJN
	 /XH32dtMPcKL9S/4Obg0meOvtqqsrgTk0JveTa8tbmeX5w4SsKBvsUHMeXaKCZDEVCiOR
	 R0UJcGg/MAWQ6Gqglnc6BzhgGnSHZIFS3E1MIk64e+Tc2pgRQl+cogDlnnLyLx/kWC6ut
	 EA04uAiKu+actUdcpcm5b5/ha6gVlvuOSjJaLCplaIw4hUg09rMRJJ29unhfS8HUXYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=opengear.com;
	spf=pass smtp.mailfrom=digi.com;
	dkim=pass header.d=opengear.com header.i=@opengear.com header.a=rsa-sha256 header.s=selector1 header.b=j8D45uTO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.222.82.65
Received: from outbound-ip199a.ess.barracuda.com (outbound-ip199a.ess.barracuda.com [209.222.82.65])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A1B606A31D;
	Tue, 27 Oct 2026 18:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9A1B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=opengear.com header.i=@opengear.com header.a=rsa-sha256 header.s=selector1 header.b=j8D45uTO
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020131.outbound.protection.outlook.com [52.101.201.131]) by mx-outbound47-116.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 27 Oct 2026 18:20:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWhGgfWIPD8Gw1LgRDWt38sM1iBhPVxwLHstq7ah4SYCStvLHI7110PUd2X2GwTdLzoOPjOxole3ITLiXPhCO6pw7fRbLPPYkTi3HWkhK8hc96sQZX+jpeHBTp+VvAllTBecDchfw/4IQxvAP+oLBzrHBDHelYDvtK2fkM/6IdAGWvf2zDir++1kzxBhQKctLeTTtdht4Oz1F1IzC1+S6Nvnjy8Gzf9OVt5Cq87KvxNx2THQ6zyDzaWOIm1EWAgiW/i2vnvUQKlcRoALRkbCqc4wNI+kDVXaRTFDO4go3yZrCpSQ4gDKgNxWHN+f27TqBNGsk0j+QMApiwCkn3d9LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLmsdyWgpjCpN6J678CUegK0Bn+Wj5D765qISp10LIk=;
 b=TWiYp1bmp4HaHCwUE4I+w6wL1ZRdognXch7LeA/r1ducAaPP4gq/sG7x89cQmDjDi8aNlTxSNGpg8jEn4eOgScuzKhDOL7HtaUcGRA2nhv06w4pwmAHI2z2LkWMxX+Wa9TsfSlsZW5cwbxeFEM8j8RP11X2y9+K04o1qEM34KE2UG6POukNM+F6cQBTzQOXBD/W5yy6JD9DxkO0mjl74SjJ+t9/725t0o5oP1UBQ9eDDRyr+060px+rpIfiRJSMnrFfL3lose1suKnoA6FRwZBFHpfbj5FAtFw+T4Y2MqUS461+StAcWVtXonYTUGHzbXuj/+A3qXnXdU75nEelP2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLmsdyWgpjCpN6J678CUegK0Bn+Wj5D765qISp10LIk=;
 b=j8D45uTOv6dxfRcwk5KkMWs2+8E6A3DZDQWb9OTlRZ8TRdincr1ZaKktejVgPiXLc0BNqw1mvuQmCMjIWp8R16ZlS2jmfsflDxJD0jjhHI+vuNavh1RtV+nKh6HTYyVgs9JMUT8GszFiEIER+NpnNS7TLX2zEJt+eb8q8llGYwnkUCyViYsTg90X0GiZHHxd6A4NEO+sEeaB6TD2qjjU3/xxGs3EQH5Q28Kp0ySxhXZa7IO+h93dqSgsrdULHA5k2CeOgRQvUuOe3SRnUUcUqYvwui7WsYqQObzvRGOMuKbwOVK3CPzPjgGrBOUQ+DYJYAayeZG9ZLJLgfpB+qSNcA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34) by CYYPR10MB7608.namprd10.prod.outlook.com
 (2603:10b6:930:bb::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Tue, 27 Oct
 2026 18:20:38 +0000
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017]) by MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017%7]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 18:20:38 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: netdev@vger.kernel.org
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Johannes Berg <johannes@sipsolutions.net>,
	Daniele Palmas <dnlplm@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: wwan: mhi_wwan_ctrl: keep DTR drops and resend state when IP_CTRL binds
Date: Tue, 27 Oct 2026 12:20:32 -0600
Message-ID: <20261027182032.1825477-1-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179312370280.3134.15800465525418472440@kernel.org>
References: <20261023174113.2388353-1-peter.hunt@opengear.com> <179312370280.3134.15800465525418472440@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::10) To MWHPR1001MB2095.namprd10.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2095:EE_|CYYPR10MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c84d8f-6a6c-4b9a-4bdd-08df34570061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|7416014|1800799024|261022105027099003|261026121527099003|56012099006|261021123027099003|261022075727099003|11063799006|4143699003|10067099003|22082099003|18002099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	HRUWEU+vOn7d/LJ7GX9VArHGSmnYQuKsjtc6w93uJ08CR717EtelqqwjYrO4Fv7/ky4MlLB1DjNUz445iglHmOjmTkg4mxwmqPuEcS2UShCgPcTU1iRBgiWx+pmdE4sSvYbunvgtgfudW/9adjBTwTDyRXzpSMs0xHLc1tEeSxdIvv3EDHLEqpFWsHu0SRho7Ynw4LsCc2YLe95S6pZl1k2Gtgl90qFQezSSKp7kKheGZDiPU+/XnT8bWu/N1/KKKMcCmGSRWBCPLD/SBQejULIDUmvnp64Oth4M/7jguXZVHRh5HC/NgUtt/qhITp+6jJavq7DlRUt3zJqBr9LA63rWd2J3OVKpt1aopYE3at3kKykA8HA+2sQwcpI3rzM5rxjPLfCA1OdSBuY3p0BqLQUHO66WCnI93ZxgekmN8gtsOAFodQ0noTIuHuVTl+tUc7UfeDO6bjE0NUvu1WDNxoVX9MNLtI8+yp8yYI28yuak1v5ObC90Pyjk3XNRnhbJp9TO/F7zumxOjHkVOSj6w98n9dwyHCM6m/i10MQFP9p0qfRXkm+6nIvV4kRIB91zTpCKsweMZmPFzkbC07R7fJ2mEQsIbogo33LRa5m4Tv4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2095.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(7416014)(1800799024)(261022105027099003)(261026121527099003)(56012099006)(261021123027099003)(261022075727099003)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(261026140227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pn3LHDQKKBUDZfKkjRsmtejgyNyLCrUESV2oX0hYNMr+TDGMvap9X7iXub7b?=
 =?us-ascii?Q?/Zc5OPZDYQPv9RxbTL8CpAlhD7pYfNYT23ivPQCBKiIYt3Gsidj2T+R0E5c7?=
 =?us-ascii?Q?fX3G+Ieg8bNsPVjqbaS3AxcazxS0Lf9AWePzrHM/5JOwFrz4YGF5FEEtpQaQ?=
 =?us-ascii?Q?95XmLe1FLFVADWXAVkfTNRTpTUMfRveOsgHyS/kMHpDUDt33MKoEcxxFteZC?=
 =?us-ascii?Q?B4y8IwzJbqIsKfm/nGknSBa2B95R1HBm7ZB1sUwqPzQBgcQ+BL21Cke1JIk+?=
 =?us-ascii?Q?CLeNSP0OUMFod9qC/eaVQCK2dWTl5Hxuu9Qgai0N3UsG+rnBapCTsMdjrXnR?=
 =?us-ascii?Q?sgFj3c+/vOiyb7Ui/JSNxKbaoR0dRKCqKAoEFrkbfam4Myua1ZI0vBT7QsQh?=
 =?us-ascii?Q?EtVJGLYHI1K0U38gPBiLCCzXXU5URYOi34pxK/9k0bKHCv4QgIO1NhYYKseT?=
 =?us-ascii?Q?B2nj32RmZ0hnhlsWNJQ+m6IhGxlRbERPOSVai0KGOYlBGV3TQ9ZfExFZ2QX/?=
 =?us-ascii?Q?PvJFhXdGtsxV4lc/QbTfbv6zobQYSRlZ7Au1mmzbhU3k1ooVywyML/UjflyS?=
 =?us-ascii?Q?8N+DSNvbC7MxHDL4WRMWFTfmY00YgVj8rJ6van9E7QVCSglJj7gyZEVsFLcW?=
 =?us-ascii?Q?Ku66+Uy0mx/kYNBlLfa2Yaw595BEo+4JHzZ9KcqAqPvu2MwXml7OsJY8a8Ve?=
 =?us-ascii?Q?8WwuJam6dDAQ+MtSLVX5vIereFfsKdOgy37z64Wz+5gqszwWCUL1Hjx+irPC?=
 =?us-ascii?Q?LEtOlI8QXef7G9akgALX8en3gDnKtyOFBkP1o6jWjkk7UmniNfKUugQCgstj?=
 =?us-ascii?Q?yRzcPsfbJCktbo+xHqQ7QVvlMAl+9C82jc3+DzIU23afaB7j2OGBXYs6+9iq?=
 =?us-ascii?Q?DMTPGuy+C0boc2LpcthuJ9T3TakjVKNAf0w9kCKEZl1ppYp74aGSAxMZJtYY?=
 =?us-ascii?Q?ceZpPE9AQZztaIpTUHpLReyu2hmDPXZzrcC7jenj+O1PDpsQ0b37uzKe4C4Y?=
 =?us-ascii?Q?INHDZ9qos61N4qmahCzCyM4GNN7r6hpwiKNGOFmP28Fnso2pi1+QQxIQz962?=
 =?us-ascii?Q?lMTpJCQq+/Pb7yGsR6kBSddbcoe+ebb+dof+3FpDWOE5yAGuz2V61Tip0Kuv?=
 =?us-ascii?Q?jabpUKNLnSNNkvsQe5rWd7GB7UMeVrZN2QQIaAcQGfwd6Wd/+TnL6R+pgfX2?=
 =?us-ascii?Q?xE7GHHrcnzKMOTBoKSO4SFyy1I+0cbVGdmpfMMvk1s8sY/lSUxpgjIsqj0PT?=
 =?us-ascii?Q?KRm77nKpPVpx9NtiPKo8+DBOLMWqSOb+RWkTzoSVCaoJ277HiklP6DEiF7c1?=
 =?us-ascii?Q?VUaL7iG3lyzorYyCgt/ar/2PWdGlzYCmK7wnTvwTfpczVQXqQjpgWcbdbrj/?=
 =?us-ascii?Q?avSk2fwC3c+Zp8qREaxpq2cobMsSkOw6IwikO7qfKPcYowC1PEkaAVQYa043?=
 =?us-ascii?Q?8mpy7GbpFmsj6L5ykQSAl3KVPIcO9VWHdoMJtXy7GjREh12eGfi2ksrGPT7r?=
 =?us-ascii?Q?VGWFv0Z+Jucukma9zSAwYUYyMnIZOmVDQ38DBszn7YBF5sjIgtGBl+ZBdbKt?=
 =?us-ascii?Q?62rgebqHYNOX/xK0FZuWADJ/LxNrC5nhzjIHz9dAt04y4a6Yuz8cP3/ds8VV?=
 =?us-ascii?Q?c5+IurGL87jPhCH6Xlo96HhR2V7nC/JDEENKhp7QE3eLZY8i9g3sdL4PufDR?=
 =?us-ascii?Q?rpZw/GtOQbkMi2dPn4+uASzkDne/FQmHlaV6Fx0nJsfsTsPv?=
X-Exchange-RoutingPolicyChecked:
	NsMU4uhcO+T5eoHU3JlX4QpvHytehiCJXKzWkBkLJzOXKmZQ3jLdGga7EurbmxmkkGBzB26zcr0V08z3SFOgp458syUAzh/BHXBmajW18c7T0xFRUyBsu6xwsjuLlougX0KB382mm7vZM1qzLd66bpe+z8627vGUE8Q/EcExJ609zBJuDUa4pYYRCZl4rtADzV9NK+KMCXyZ95K6diDSXFhnitATGe1jMSpS8Tq0shI4ZOmi6Z1nGxYIVKNQA2CEjKXywprqui/cR9jzAcmPvS42r2w9Iydl/WknRqLRzD3LGhGzx1AS120+PGa9PPdu699in8chZuuPnrLBd/lHiw==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c84d8f-6a6c-4b9a-4bdd-08df34570061
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2095.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 18:20:38.4682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KST0mFk5aFHEPga23LeOAk027+WsTMtn3ngfJSezy7GyR2t64V4VytxPfrk34d/T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7608
X-BESS-ID: 1793125248-112148-7682-1514-1
X-BESS-VER: 2019.1_20260924.1519
X-BESS-Apparent-Source-IP: 52.101.201.131
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobGluZAVgZQ0MQwJdky0TLRIC
	Ut2cA4DchKNE80MTIwSU40NUsxMFOqjQUANKLuD0EAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.277153 [from 
	cloudscan20-75.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Thanks for the review. This version is superseded by v2:
https://lore.kernel.org/all/20261027171055.1796482-1-peter.hunt@opengear.com/

After Loic's review, v2 only flushes dtr_work when DTR goes low and in
stop(). It drops the port list, the drop flag and field, and the late
bind resend. Going through the findings against v2:

[High] Two reads of dtr_mdmbits in the work: gone, v2 leaves the work as
it was in v10, so it reads dtr_mdmbits once.

[High] Drop lost when the low state hits -EAGAIN/-ENOMEM and a raise
follows within the retry delay: this can still happen in v2. The flush
makes the drop go out before ->dtr_rts() returns in the normal case,
but a drop that hits a full UL ring is still retried with whatever
state is latest by then. The v2 commit message says so.

[High] system_wq vs system_percpu_wq: agreed, that was a real problem
in v1. v2 has no mod_delayed_work() calls, it only queues the work with
schedule_delayed_work() as v10 does, and adds flush_delayed_work().

[Medium] Port added to the list after wwan_create_port(), and [Medium]
drop lost while IP_CTRL is unbound: both are in the late bind resend,
which v2 drops. Loic agreed that case, only reachable by unbinding and
rebinding mhi_wwan_dtr through sysfs, can be ignored.

[Low] Stale comments: the comments describe v10's latest-state work,
which v2 keeps, and the drop flush has its own comment.

pw-bot: cr
