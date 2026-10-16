Received: from outbound-ip199a.ess.barracuda.com (outbound-ip199a.ess.barracuda.com [209.222.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6EF40B360;
	Fri, 16 Oct 2026 20:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792184361; cv=fail; b=eYILIuZPq8BQQkUydtEpkP3WDI14hn0Al329j6BZ7A+PWX+i4TTLJDRchxH0/7L4P2i6Sh9b+N3k28vnYJKDcKge2Tpk3P1TlLvxrZmEJW+jVRXsanjTDCH6hgMhc/1J9KYRd1RQ2qGxBHRRnT9L/cQPNjvlJz+j1vjaTSa7mZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792184361; c=relaxed/simple;
	bh=MeZh8XEeSQmRLGf+rNqtZw6nlerv2acqX40Q6h2WBPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rQdWBp2VekSXlJK9vRcL5csGHe/1vtbmcCXaob+CRWCfHFGVBp4mYRSxnuyKBTQQdSDiDwJBLK0d4SODU4N4PjpnOJY148laJmGsjls2rIRGWj9rPsfsdpISjtdzt8ma8mvMzcfxFmUVyorTjSYmj7MoZM9wUZgF6rIvLOor638=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=euoSE6Gy; arc=fail smtp.client-ip=209.222.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="euoSE6Gy"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022137.outbound.protection.outlook.com [52.101.48.137]) by mx-outbound9-255.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 16 Oct 2026 20:58:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLxa2cR0E7c0h5t96AG8XwuWvHu0B6q1rL36o6fYwYK/jr697t4KtXjQA/rnigynUHYs1sBr32bxjQ+fo+Ll6b9O66bx4IpK8g6M3fY7ACdMISsVCRVqLscPIqzgoXzVhkY7/J2FoxVMYNB3qmsuLXq7315hMySn87IXnec79dVgnvk4NxK0z3spju1Fjsv6/67Eygj09RSnggTenw13VmKyi9dXOiBurP+roDFP8PR7d0dSqVUQVWH8Hcn39xudxdF3oWNOlPP77jgULWVPRYMjCqavrrqGKqP1emRt1pyL2w3m9y3weAyb9mkoziY0Mys2iP2MhuEWJOvpYEawvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MeZh8XEeSQmRLGf+rNqtZw6nlerv2acqX40Q6h2WBPs=;
 b=VAk1R2u62Zvff8enpr93PBpdC6tI2fteDKSsJHiuThHIZFQ6qKD/F6BNFLT7lJtB+hNQd/upoooGMEOkF1s1PBervgSX4sCVA+5O+G9e+Tus4KnsJ/jTy+g1dBZqRjGE2w+gbyMT9pQrQguOuqSABz+RcWG7BYQ5cJOonwigIi9OAC/3UQPs/wdHNWlpBTus4O8Yl3xgUo+8oKOS2csQd3vstRsDck8BQBjrE/N4xhbDHlo4ViPxxjocVDFz20twl4XjBSFBO4HLVq++6+00zjy8I1eI15vGw/QyaJy4a5MBb8SK8mgVbaXwnTIGt9Wmb8He+NPt0sCNNyGfnWaTeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeZh8XEeSQmRLGf+rNqtZw6nlerv2acqX40Q6h2WBPs=;
 b=euoSE6GyrkLfC0PkIb8MUvdEyqOg8IZhcFj7n/nlA6a3YbfLJ+snthbCjaEW0gszUMI/v4wR6hipJ/JuPCZa8EuOC26n2kZRJ4WNX6JDUxVs11/gKc9HEJ+MjPclmal52E9dwZqopffpmc7h3F1Zjj4N0MgDBFvRYwXlioGAV/TiTtvNRPZ8AYky09PbCfDxiy8+iG6VBeGgAx36/h1Uv7vJY6U8ZGnoscr/OnXhXw+1jAaMEVUOX/9coxvhjI8fQnTA1MH/b36MFNOGhSQl21lxWFrUGkE9mUZrzskwLSyLxPwGJAqZMDpj1h91rTN8wYS5LeaOSuF6tiafNoLU5A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34) by SJ0PR10MB4541.namprd10.prod.outlook.com
 (2603:10b6:a03:2db::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.12; Fri, 16 Oct
 2026 20:58:47 +0000
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017]) by MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017%7]) with mapi id 15.21.0546.006; Fri, 16 Oct 2026
 20:58:47 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: netdev-bot+sashiko@kernel.org
Cc: loic.poulain@oss.qualcomm.com,
	Daniele Palmas <dnlplm@gmail.com>,
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
Subject: Re: [PATCH net-next v10 2/2] net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel
Date: Fri, 16 Oct 2026 14:58:45 -0600
Message-ID: <20261016205845.503392-1-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179214346368.434549.12561882856700666394@kernel.org>
References: <20261013183500.261229-3-peter.hunt@opengear.com> <179214346368.434549.12561882856700666394@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0071.namprd05.prod.outlook.com
 (2603:10b6:8:57::14) To MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2095:EE_|SJ0PR10MB4541:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ac1c9fe-fc64-4983-8804-08df2bc84600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|56012099006|11063799006|4143699003|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Dnr9Ccc061z23jWJzcfkZmJ0JHmLKK0azT8HLsU9p752srY9MrPYHWMVhFXRZ5quFOVMse7pPVkK2xbo5bvTb7Iy0m8lMGxP7UXOyHVLhsWwTqf4WhIXScOwF3SS+9qDCpED0E5gw4xmNvQCfbtraDL0XZNLuSrrBzkqg56aMqp61OezT+rAuWK4zrSYMOD7uwqHmLn+tMVZ56kpH2pWU8gd3DHuhJdmbdral6O2zy93kuM/jSDF43Z01iWVBwSxVp1WuU2YPxYNlimQHfjqCNmw7N+NFKO+mAk4O8ZHwafeA8iiWW2AL4lemN1jVDg9a47je+0kOX7xZXkqysul8uSi7tUfLmCCYP3/hyEGpsAVpsVPA7KI2P5svc2bgf9CWjfkd1gFvNPYhiqGr0xPatXFRBKVoHLIiHhVUKwXas0AsTyKwqiZdtgGIRUH46rnSvWYvaq8kP+vvSN68GaJ3UAqtx+JS5BxXc+lfcfkLuEn9zeDyliV1mbe2OOqN30DJd6gy156DdhmfDcHabPgkMWqlrA9pqIMPjxsDxtMO/mqbgXhV4TVDAenvjG5P7KKiImWIjf5cnxX6eyRvrITf42qegjLMbbaABKtMvjl20UKT5VbpURzxKjVCnqTN0TESYoN/gSTAww57tdRMDhvy9xxjP5+CTzRUFc2IEMohXQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2095.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(18002099003)(10067099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UpJ55Z+ACrv+SHPtPBQMNTYkEffc6FbFY1OAZ27p/A8Yr1zxi2sB/YlTakIl?=
 =?us-ascii?Q?H62n7RKcVx89EAi/qkvkQ1G4n+8xZxDC3dftp0gq+vyXK23xKL/p6eRleni2?=
 =?us-ascii?Q?/19wGHZeqA8Mw3oYM7uBQmySpBx/iaW068Rtde/wWYiwENEOXWsX8H2ptyzC?=
 =?us-ascii?Q?QEWdzahgykC7dRalt2EvxCpvr4hBufnt5HWqP4Zho1JrGOXaLs+VR/j0vdG5?=
 =?us-ascii?Q?Ucobsg+8PQ/ITbKM3bXa0At9LmX4UZh2mr6axroFsoWQgCVVrnrcw3coAOSD?=
 =?us-ascii?Q?5ShvqheYJAx5r9ebFRc+JoNM/ATLYlAsFmmGWLuq/L1xiC0klI7jY10D5Evq?=
 =?us-ascii?Q?70xLQ79zUO85a4HYYoKtd6AbGQNZeZr3h+5l0abouG8PG6HPstCIsA5wPsFd?=
 =?us-ascii?Q?Ldftti5bqYRdcji4pzB+g4GOS+tmLptolu0eMaejYXuELf3HcwecCdZPuI3i?=
 =?us-ascii?Q?+HzuFofAif9HVOe6QEcfwBuG5FA4M92kJsazRSkiDAlnyfGyuEM2A6mcmw9N?=
 =?us-ascii?Q?Ug6Z0aPHKZtHstvL2phslt49uEgx8BdhPCozhQZFPVNrrhukOs1DEkjpz+Cz?=
 =?us-ascii?Q?QSf32op4J1z22a2NDpanQosJh09VpOghxyvWkzBxgQRJeVEPozZBMLrPs8yB?=
 =?us-ascii?Q?A0SuhdIWEwpL9FXCXd++ypVXkXw1DRfoeAB+8t1Fw5io3VInQVgkP5OS8q2V?=
 =?us-ascii?Q?aad5Ok0F3AvRSO+frSyT1sNAKdiIGJ4jZeDzVQWapNJ78l+5TBTwVqXFOjeW?=
 =?us-ascii?Q?jzbB9nZ+AhhtxWDM/V8hlZmjL+pf80XW4Y+JLH39dqUgR6hxO+9E2YQEO0eP?=
 =?us-ascii?Q?1rGu2PNhqMVr6w0Zrqp/ejSdwMbSSmkV3YnineqdNPkty/8kxkfb4NSXDFNX?=
 =?us-ascii?Q?oU9OFq6+T1kITyx72vshBF3/QIRMGlDzZ8/66Kbou7MifO0a9Y405/Lp5kAa?=
 =?us-ascii?Q?bh1J8ewWwD2i0zC20dbIamcssmn7WAoeMBAIAZqrKcQsxPRn4o/+q9FibGag?=
 =?us-ascii?Q?vU9hFeK+st7rpsLtjhQzMB0JmEwzij7BGlf2sB0hNv8QVuHDO9r4Q0eg3qsb?=
 =?us-ascii?Q?sVeesXSkJzCqtr0fhr/LbGZ9imPPLqssJc0g3IMSISGL3OcRCXth1NlffJp+?=
 =?us-ascii?Q?wdcixeUWcr59u5+rBDJF0z8lc9XLizA/33OZqFNyJeaheJlKQZ6QnMrMqvmD?=
 =?us-ascii?Q?qJCP1YiPPsQQdg+HgF22XhMxzYh3U3c23kK1xyEptNyVTe6dujD5Z5wVIYC4?=
 =?us-ascii?Q?ftIk6bo6rsqLDLM7P7hpC65poeGZA8lstcSPIBv9Jo1pVdAJ4+RQ5oiecJGx?=
 =?us-ascii?Q?1BBzf+OA2VlhWewq8x6ODKJW95V/EKOEI10BCe+X6/2QYs1fhVGdNILqcR2c?=
 =?us-ascii?Q?pg1stZJZPjvJJ6Y/w1vET2O4COOFmfYJ1ien2mzCtCSaky7Gv6g+slU6ikq6?=
 =?us-ascii?Q?54AJOBTm727t2VHGEsxSM6KmIgVPrUl8u557KiiBa/P0UMHgvnHQLG6DcE4t?=
 =?us-ascii?Q?iP/V65rb3akG7Sisd8KBANhMrwvcHvZm87fahORf8tMlBVmV1oAoca9D+gnW?=
 =?us-ascii?Q?PAbt1T63VseHQP89Tl8rej6rhdD3t9SVuBLPBZy7or3xOlKqS8okMXsZ2l3S?=
 =?us-ascii?Q?61GVZ5rnc24XM9y/247KxyJ4KJDnW36CEHS+qY6gCvHkwrgcBF4jNhZeVwhv?=
 =?us-ascii?Q?oypoOzdHKZv7ArmoteacP8sZiVjzphrCOjAy3g4FYveczAgU?=
X-Exchange-RoutingPolicyChecked:
	z4suXCdCdufPYbQ515Bd0M4n+Zo1BjxA5W80wzWWmJoCSlgfvmeL/f7bOsBbEVR2TLglT6sYv/ZVUseWSB8YjLNngDTbOrLLgFH3F6neEAHbAP4oFv9pc/OtnTncQgdox1EZjAuGLzPhDS2r7vE8D6qEHOCOE12sm9enENNebMQHPMmGih6vxID2bfwW0CtLyiP3puJ0hS3HoAWO3HHHrqpCUoBT41LdAvxj0uyt/aACdljJGE28WNQF4LB/T8FSMji+oGaBo01pVm6jkldLB1zPTmXkDUU/+NYC7stOZjo5HtvwErRgHLd3PVYl4oFQpuKmHSscIAUuBTK4LJJbIg==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac1c9fe-fc64-4983-8804-08df2bc84600
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2095.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 20:58:47.8676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2Qify2teHGr6ec6lMXleNFX7oI27L5pLvxQ1yG9g6csVEZ5/ckztgnzppYlLtR8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4541
X-BESS-ID: 1792184333-102559-7716-1078-1
X-BESS-VER: 2019.1_20260924.1519
X-BESS-Apparent-Source-IP: 52.101.48.137
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpZmRkBGBlDM1Mwk2TAlyczQ2C
	LZPM3U1Mg4Nc0sLSnVyCTRyDAtxVCpNhYAhwU9OkAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.276892 [from 
	cloudscan19-199.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Thanks for the review.

[Medium] a DTR/RTS request made while IP_CTRL is not bound is lost:
agreed. It needs IP_CTRL to bind after the AT port has been opened. On
the EM919x/EM929x, IP_CTRL (channels 18/19) is probed before DUN
(32/33), so outside async probing this only happens after a sysfs
unbind/rebind of mhi_wwan_dtr or a failed IP_CTRL probe. The fix is for
mhi_wwan_dtr_probe() to resend the current state of the AT ports on its
controller.

[Low] coalescing can swallow a DTR drop on a quick close and reopen:
agreed, a drop matters on its own for a modem set to AT&D2. The fix is
to never coalesce away a pending drop, and send it before the latest
state.

Both are corner cases outside normal operation, which I've tested on an
EM9291, including bursts of 10,000 DTR changes ending in either state.
I'd propose to address them in a small follow-up patch on top of this
series, but I'm happy to fold them into a v11 instead if the
maintainers prefer.
