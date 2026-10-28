Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793158689;
	b=cWCgPeAT/F1Fdx82ruTatQnWVcPpaABtq82RENnWcpUVgwKgxZRARIyhSZmSdvd+AJOs
	 8xfLPteE+W6tYW4+HE9b3f1fW4QlWSAeVAs5UulI9dA8gam1b1hQi5b34XvvwtED/ENBQ
	 ZOTodOM8ZgW7p73RPkiGAqOV4HX2C7Ru68vXx92onVNS59I29VHrJwKLNQ2Pum7LjA/zz
	 xdf/apOyoHpPkFOBFBt/HLUvDnh700PI2hbqV02DDDBIm/LFQ74dxGFvhnvEv85U/JgQy
	 9eNsIFCC0LRkEDzlJAkiGTET86jtlNPwPP4OsRlyXP/Cl/+Fo8zuz2Li8hx0Y3Q6MYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158689;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=KFf+YsgwVoUiQtl5a4wI9bQq9+m1sK0OaT45PDZcFFc=;
	b=bz7rVSaGww0eUedpqbMlk/Ak1IpnFt/eJP6OMPLKf+zz/qI6Mrq+n8VxKIPEkbDd+pCb
	 iRfTA8RdCSE/tbliFULr6hGl+BnHIhP0McJ/JbxkXc/gG3C7cA9j8V/ZdccxaA5LLbjcL
	 WFQgeMZJKnECkTAayKTw8I0ljUyJghySK/abHJ11WbLFF1b94R9ib7uibR/MFKhOQ7VPi
	 eSusNsv47EYEMfgr+LBZx3rnsvdDgcXKKc2moe0xu+tkYb+SuTB20uFZcVZjys0S/g4nO
	 VjtKZyo31xSgP4inhIEKRXGU/VsduWhzjZULd6AfUxMvo6sxxJkrfnEL8rzNG7hzgIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=est.tech;
	spf=pass smtp.mailfrom=est.tech;
	dkim=pass header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=wg5MdUSO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.35
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013035.outbound.protection.outlook.com [52.101.83.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6746606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 03:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6746606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=wg5MdUSO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wG0fFTpOGQ7zdYiZuDIUSYHoMRl6S51UkGe1xtKldrqAtxBOyC/duxPjxuCCdDzu3DDKSX08TrhNi9OlZ/H4eJOIL43LIxzl+aAAMCBEHCNn+lSdbD5lGRrRPHoyiD3Jxdf38mmax5x7uyYKUsP6mOBnTM7rDZWYAqnpxKDlRoWsmsVTpw4kDLYBs6dbROD5XnNyFW5X/Snzwwu78bGz7lrDOoOIEqkRBc+WeEJN8gonuZ/xcK8MxAm2Cy0oHNsAD+WSiUEoyJf1lvUnX/5Iohb9uK5ZS+aiw84sBAkU2OhEHQ/Pks37ipECmi/cH6uInSlEmAYKqzowkZDZxdyMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFf+YsgwVoUiQtl5a4wI9bQq9+m1sK0OaT45PDZcFFc=;
 b=yxljZXPeAKeGLLoLpnRvGz3i2tM0gdUna91bXGFJrnjsG3LU/h07DCGI1YOHUe51CvDo+X03f6M8rYQyb6ZqNFteF3sVpXrr8Zixe/2RPK91hJKCZLkToynOnOt0vZaLlvYJYjIhFMsck35ehGIc2SF0f3GG7OGy8dQDjiLX8aNnCo6XQNUvEhkqIL8chCJSbBU29UPtTtSNIBKihqQrVu5t/8ee/AX4N2NNFxvumHC2HasxF5/z3bIgDfq6FmfmvFnLauqHXJZBFnwnXROuIatbcvbXmb/VnqimcLfXKqlkb+af4/CZJLE73rjEb9MzhY5B/PSgV4LH2MvfJHYyGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFf+YsgwVoUiQtl5a4wI9bQq9+m1sK0OaT45PDZcFFc=;
 b=wg5MdUSOXTmoJUVIZWSS4m7biD3Jz57n9djUV2nSdl05VfqojTBTSmv6pGGLA73rGRwicdqJJYvyD9bFIQhyDUwllouFXij/OqBc02fimq4oCBuhuY222SsfMtiUjRdrO/hmR8kBWljJaohJKvm31k5dt6Hzm4mkstBd0nqnE2nKHm6pYvVUNpfoCqtSAsrSjV4zlSEUthtuw2K0BEB6z9ZlaAaU0X6QHxqIS/vBWN/IKd7gLWIQKSd3BbWBzCpuMPYrq9LqRHTPbuKW+kU6vP1WGg54IlaEQ3jDHgYCpmCg4kXIjaJsjMkEyZiI1rRq7q9jp0kLJncvyDT8Awc+1Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by PR3P189MB0972.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:4e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 03:38:03 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%4]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 03:38:03 +0000
From: Tung Nguyen <tung.quang.nguyen@est.tech>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@kernel.org,
	pabeni@redhat.com,
	jmaloy@redhat.com,
	horms@kernel.org,
	tipc-discussion@lists.sourceforge.net,
	Tung Nguyen <tung.quang.nguyen@est.tech>
Subject: [PATCH net 0/2] tipc: fix deadlock and NUll pointer dereference in tipc_named_node_up()
Date: Wed, 28 Oct 2026 10:36:44 +0700
Message-ID: <20261028033722.125477-1-tung.quang.nguyen@est.tech>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR03CA0005.apcprd03.prod.outlook.com
 (2603:1096:4:297::10) To AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:17e::23)
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
X-MS-TrafficTypeDiagnostic: AM7P189MB1137:EE_|PR3P189MB0972:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b2800a-d247-4065-0cad-08df34a4df2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|10070799003|376014|1800799024|18002099003|261021121427099003|56012099006|10067099003|11063799006|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	aWUbN1PKDNJm2ZDSZw1xhlpy+rOO0HVU51jd2xPayZdWelddvQGUoTYKISz0AyP6P9s61jRQ9pbUEtHZFz8W8g1U3S2PVHkWrGRFBySV1mOVgDjPIhdSoj+yyuy5333rxsttGeVNwBcpEsZw/QkCHhBAZpSJhoNQfC8stX1xUMV5p5LzoPjDVtF4bFuk0BXNTQHTxnyy1XQyenI3Rxg2O9+2gq1lHc/8u+2ZbFuEb7kB+gGCNNIxoCB8g18cuavaEXpqovngogbKbv1AZUlvHteLKZlmc5yZVoV8ocARKmSDf3murLDrADue9b+xLAGpyr4QKqLZ0JjTQ7oU3A3HmFzKGB/QHv2Ngx1AAVZ211s55sGan5cMdF1NEC4xVmEv9GUDgul0kjZNmgUkQalHy9E23+Fk8emCg0h8f8IETAYeuTlE7Dab3F6qtWlo86UGr0Z+uzHugXrrzwX2JnB2mAt6skxs6OlOnUvUzjfQQWhPGwPAfjt06erJvHaoXksU74VbdAS8UHsLmMwGE/0QM6gXJEjvZcWH3AHMo/73XmzpQRDL+pCfVnXf9Yv7sBV73o5FKtW/BcG4NiMAXD3z6SLJqdoXV0lf6kunmM7t6ycc7LA0mSrcH04vXqownSh6JLZ9/myIF7tTKRORm4PWwMy+0xcRGpnmJEX25I7Lgjg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(10070799003)(376014)(1800799024)(18002099003)(261021121427099003)(56012099006)(10067099003)(11063799006)(261021123027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6pSg/6/gg8781x7U4TpZn2sGhN7Cv9iDCcBAA8Ze7qI0nHMDCM3LY8brjwae?=
 =?us-ascii?Q?ZpumXwrt3t7MAb1e+7SgJ+ke/RaOy748iVGbpeZeTISJbuFlffhSnXBAIA89?=
 =?us-ascii?Q?3kPrm7xAzpzZNmVRXvqq6Vn3q0H6JHML5Ge4XpsTb2ZbaT1SaDa5bRGViGY/?=
 =?us-ascii?Q?eM/eOprPie0g/zfx9DwtoObXglcisSnZQS/OdwCS8UwPZ3dJZXtMLysuaDRD?=
 =?us-ascii?Q?yoJr7Fo6LdyLOVS8brjBJZ9SuCtEp92wPkA7wsnkszcGidkQgCJ9SfinHoDX?=
 =?us-ascii?Q?u0XoChDlXF5DToV/I4qb7s2V/Zg64lf1wT2nsxqMFX+DgxJj+yJ8GP1gegXf?=
 =?us-ascii?Q?UV/ZwNTqBXHTDr0BRBkalvJ0QU4EGQ6Y7H+tWJKcRVghyw9/dG3Au5j3FSOD?=
 =?us-ascii?Q?0Yj+sl69oIpQTMrrvJPzW8Q/+Schl+X35qxwZ2W6Nm/YN6HIl/iui/oUoN9n?=
 =?us-ascii?Q?Y7/8Fu1BW5SyqLA39IR8nqPlhMvVTbzUtQDNavCZKUhJESO43sU1IjOGAD6Z?=
 =?us-ascii?Q?Lqp9KPikj0YfhY4KzOqLXhWofIRaeFs5SsuY8nsS0/N/O4FFEVplJccT97is?=
 =?us-ascii?Q?IwiXeJsbTxGm4oK4VWvpyYPWgFByWrTTVZVe0XQGKX3eErhRr6vrb0IyDKGw?=
 =?us-ascii?Q?F8cqh0KEL6RqgNW8H1Q+on7wfLpDfXmP6TqQSvWpkfc7cXg7nwcfZpF5+zPG?=
 =?us-ascii?Q?WIvn3pnuMmAffMom5jkKJ0eDrqZnNz8w2WcruOK17rIXRR3+7icejHTwC1jU?=
 =?us-ascii?Q?YumQH2ZcOvOM6mlIXrZssVU93Gb2lIXRS8wR61Ct7iOyvntn2S5CxCt1+KF8?=
 =?us-ascii?Q?TtIASb7WquXtd1QN0WBon6i61AAC046gSoBtBwYi2exDu+Vu3tUSIE35GKsz?=
 =?us-ascii?Q?igKLDI9tCnNV6xEUIlWGryz19YQdWUftqmgjQCnjWpNCkifax3su5WmCM7Vy?=
 =?us-ascii?Q?JKOrawaRg91pQhhYVqHK00ZXG/N2IPAkQVM2Fq5DzfFicbP3VJlC1Qoq1dQs?=
 =?us-ascii?Q?JQdyVtwGvrMtwzd+mDn6TV0x1DQyICjnOXRd8ZUDNJ2LEKfhoOrn2b71m7Bz?=
 =?us-ascii?Q?d4WOSnaicgOAfIiT8HgGMZSDVt8DC2kIof9/+EoS/HrKORaI7uWnC7IXdv+L?=
 =?us-ascii?Q?w/v/DvbL+b+dIs83yfx5XDfVHPBkGtN4p/eOiVP9vlySFqyhL1kQ0Cr2kbHY?=
 =?us-ascii?Q?N2XInCAHw4ssRbIk6DEBSs3M2BbVRkKpqONy0hiWun5XcIQ0lEyKkmFSIzXf?=
 =?us-ascii?Q?4b3koxoywW396VYdXd9Xe83E3BsrpLxntQQiUr3U0iKTwdNTTgSQcWulh8vz?=
 =?us-ascii?Q?sPETBd2lJMpZQgJwGnWyrTID7l+pWAj8puDCGvRXOBiTFBF44H4GgoK0dFJL?=
 =?us-ascii?Q?DnPgX0imj7w7tbWDLGtvwmN+oH+ymrnr3ZJuN9YHbYc2OSZYjDxipMBpKsu0?=
 =?us-ascii?Q?A80qfsYVYuhLwTBv/5wwnulbDDY5y4TR8kS6B6/E7iD8e5ZeYdY/i7Bypam3?=
 =?us-ascii?Q?hZ9Rt67KWiGibdUYcNN6AC6OCR/u5W9v2dmpyvE8pyjEDwv6jZ0JL2hI9KhD?=
 =?us-ascii?Q?e5gMobn8prAyEA8RPT0Pt/TAydE4Mys50FpLsKliPevwrCbuoHB6C0W2n4NJ?=
 =?us-ascii?Q?NneaDQzehJMf7tfaIFCvpd7QJAmEHdadie5f8jydk5QR0mBamtzA8DtRbOzI?=
 =?us-ascii?Q?rZ2MlRIpv3qtq8EZc2lN13Swr74MmzRUj53OUztai59TblFpiubBRohZei8i?=
 =?us-ascii?Q?fnBLz885YlCS0H61gJFVZ2waQjn4bry16jIJm73K+O+VeUbvg9wTjgT73e91?=
X-MS-Exchange-AntiSpam-MessageData-1: 5Fnt3jCyJpxZ/hffzRTRe6mbIfWVbrmrWPU=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b2800a-d247-4065-0cad-08df34a4df2e
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 03:38:03.4384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8LNooLjAHa8pnVZ6lVyRAgf62KLtz19mrr2PVwu/BcuyDD9VxHWMqsNOWiynMCjLLd2ACGItbRMPEoBm2qH5LqZqrQugflL8AE5UKhk8fHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P189MB0972

Patch 1 fixes a self-deadlock when inspecting `tipc_named_node_up()`.

Patch 2 fixes a NULL pointer dereference caused by a race between the
`tipc_net_finalize` work and `tipc_named_node_up()`. This issue was
also reported by syzbot.

Tung Nguyen (2):
  tipc: fix self-deadlock in tipc_named_node_up
  tipc: fix NULL pointer dereference in named_distribute()

 net/tipc/core.c       |   3 +
 net/tipc/core.h       |   6 ++
 net/tipc/name_distr.c | 148 +++++++++++++++++++++++++++----
 net/tipc/name_distr.h |   3 +-
 net/tipc/name_table.c | 135 +++++++++++++++++++++++++---
 net/tipc/name_table.h |   8 +-
 net/tipc/net.c        |   9 +-
 net/tipc/node.c       | 199 +++++++++++++++++++++++++++++++++---------
 net/tipc/node.h       |   3 +
 net/tipc/socket.c     |   2 +-
 10 files changed, 441 insertions(+), 75 deletions(-)

-- 
2.53.0

