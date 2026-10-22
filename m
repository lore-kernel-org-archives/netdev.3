Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792631749;
	b=DYZbvidSVFrmxTVyqPD7nCJ52BW2OkHK0ffDu2ZDQiEK2zNMRHgzP+0bI502Kakis/lk
	 3jz8JHx/C8WjQMbJ9U/wwF4Uv9yiO9WMK8j7ZCIGfD+5f68w7uH4SdA5N0yK4ZUo+7NIr
	 l8qB9QaGwWPJuJ94pRzUflpnKpmoc55GzFA3yknrfjBqtpr9sSbZa7tWOJIzT8rurbIOb
	 KxQI2zgKStHXQBoBUKYaEmlBmtBfkShsvrtQutWdwgT2+pjfxVeEngA8J/R/DvRHenOUj
	 9ASu2fzWRbKmeGPD74z2ixyNGPCWFTFAkPrDOQRCFSrwkuQJyxX66d56RjR12k3VOsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792631749;
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
	bh=OZDM2xvpnpXeFxVriiLYTzgd4ROl1cDomLW9DqEpM7k=;
	b=BAEO17+QTlzY+mqQOS1J22IU067a56Lmpi/mf3pIvTPs4U0rvHwzMF+BpFLDUlr46r7D
	 8bAR0kilX1aEUqIwGE3oyJFVRIqWK/k7eT1gaSzzbpZQr1Cj3r0IiuGNgXa6WlLjpNs6E
	 cGKTmgnzCRvEZ0xU7i1Agzk/OVQLq9bGeRwaSlmDfPDLTbIRNN8kZre4+gF8CmdaDa8cQ
	 dEGreCxGU4gaz8P1+b1mToeIRqECoFa05KgSdH7664XhhPGJi05MUWdkcQ+rdJGqSFXQ+
	 V380r8hRThbx10LimN/WD85/SKNur7dPhh/6bsd80ogWjfJbg8wpv6F9+/3pmiUB1eg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=est.tech;
	spf=pass smtp.mailfrom=est.tech;
	dkim=pass header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=scc2Y8Ie;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.19
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013019.outbound.protection.outlook.com [52.101.83.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25452606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 01:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25452606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=scc2Y8Ie
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xms767X+JziKZRZenusW/9HouTMmMnL88AZL8F2rkJ4oj7iqXo0WEm+A9qEH1PE+2BzyPZirrgtt6oLW0DVLawPrbSXyGQgjalvrhLCGe1612wDmh8bGg+zWDYnT6PovobHOGJex51/Ch/ACxP/H2A80rSBrYf4WYFGTPAkpA2itH28d23Tpwl6/BsP1QKMypMm2gnFWp8TSRgZL68uj8oujldw572GLN5uA94kVJQKjm6LPe1L2mv7hoTbsLBGU1q1lN0eYPdR8Rg/GODa2DpTrnNcWlxSLUBf3BasmHk7M4+IuCB+oXaFC/dhGLpVLmeleejI5mBXsex4wA7GgZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZDM2xvpnpXeFxVriiLYTzgd4ROl1cDomLW9DqEpM7k=;
 b=MXohXL8dhNck90Yu9B1TjdckzOxwCxOZ0ioErr9XlqKssr5YcdkPNd53I/xYPfASN+C6L1NSng3ngr/iJK4KMAtCKJKhZ2BOafN21+VLYXmZy2L+GhcXxKhoNCFr+5sJ2UcZ459JMcA0BHvLSRjZoJx1IVKDS0U72vuCTwWaNCuPQ0olUF2MYII9/mH7rFBoAx8tv0sBUkgzY7DE6Pd/3Up+/CqfI+bB3wnSbcRu9pvcEJFtU5Z3hJ1XITAILLMeaUIqsFUISgJWDR18MpgWZv9JZSgRLcmWdD8R6HOvjWF/9CibFgCoUjN1LPzpqBBg+JCpPqzaNz9FcGoNKlG2jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZDM2xvpnpXeFxVriiLYTzgd4ROl1cDomLW9DqEpM7k=;
 b=scc2Y8IeRMmLwxU+Oc+cHYSJYwRCtx6Pd/XhL4sCzkGIg6r1xmC+yvn+xhygj6R0FNGhOjeQscWv8loJ7FE6w7HLqv/23TllNpk5DePgIzKGbgDfNk67WjYQGPHFFTlUQghxUpRzWEn4Q6Byi3HElZwpX9SKXvIQJyXF974jbl2vXZQOoB21hELejw5OOtRqlzeWpFtv4GQ1ZptBC02+4zWxvxuf2gBamXnvG984taCBhtAUgYuklHt4r994IFeOamgI3TqY/paRa3G82Y3mENJwjd36JxzXFi/TbPV9TPwQc5RVEv7tDtO4eBaLCQKK/xn5RB30Bnfn1Ff2urplpw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by AM7PPFABCC8967D.EURP189.PROD.OUTLOOK.COM (2603:10a6:20f:fff1::6a1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 01:15:45 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%4]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 01:15:44 +0000
From: Tung Nguyen <tung.quang.nguyen@est.tech>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@kernel.org,
	pabeni@redhat.com,
	jmaloy@redhat.com,
	horms@kernel.org,
	tipc-discussion@lists.sourceforge.net,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	syzbot+0017742620a9d06f06ef@syzkaller.appspotmail.com,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: [PATCH net v3] tipc: fix refcount panic in tipc_rcv() when receiving shared skb
Date: Thu, 22 Oct 2026 08:15:11 +0700
Message-ID: <20261022011539.6882-1-tung.quang.nguyen@est.tech>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AM7P189MB1137:EE_|AM7PPFABCC8967D:EE_
X-MS-Office365-Filtering-Correlation-Id: e25da99c-e732-4b70-21d7-08df2fd9ff3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014|23010399003|260925022911599003|260925021311599003|260925021911599003|11063799006|56012099006|261021123027099003|6133799003|18002099003|10067099003|261009223027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	97yL9/Y5+5m9YFus3YGjeSZJTUE9bwr/M4bM2wvOElIfe7ddkWbOc+/UTPJbrdWESumYy8AnCefWm9KEoX2oyz/oFPAqjZ7KEzKdHhK09yTDhgQNAc7KR8ZGpWK3kWeavRyUvsOV9FC5ZJ4p/lA/QxBSUlU+LiUgkLSKu4EPLvHcWIjsARJSMmN3NDufrkJrMCkODbQcoCVk3jojjbspf2waOAVDbNj5sFptRS5wO2xEv23wWT1qPmC3xLXftOzUmrkEGJis0EkdyWH+xNG8hw5ualIYFtGuRL6ZD5CjW3Vjj9iNlhSmQN3Vi70L/i1owpWICjHVAK3k4kAVzyd3PDJa15Fi8qSmSJRiijlMjnfTgowAQEDRh8OFoQlnEsvVtND6g124ucEJHM7s3yVthLCa4tvMNUifn8WBvjZ0oYWF5X0nyOHGzt7xFobXnNR3U9BwFG8SUwsEJ4DoQtdJ4pcg2qrm7ocZPojAcVrsiZP8X1ITcmXYHe5qt/PC666X06PYKYtXk2O+YP2FXZv2ce45Iw09jCjrifntSK6bX3mr/ZRbzXdd0VgZrw7C01ck8OC1fypWNWVR2sNpQ6S+0eQQMTcm4YPkAJzVa+tkbi9tx83oXnPdJFyofXTXhVGO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(23010399003)(260925022911599003)(260925021311599003)(260925021911599003)(11063799006)(56012099006)(261021123027099003)(6133799003)(18002099003)(10067099003)(261009223027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dzb1fFRZ576PjrsKSywMu06ImIRwzw9tuF2CeUicE99s3kMGYmYQfdxHWqQj?=
 =?us-ascii?Q?L20hDlBESKmYgqjJyKwg91ECsDc/cwT2hQxAnVf0BAWyANdioGHs1PF0em2b?=
 =?us-ascii?Q?m+FWloQWDsTHHHUegwdLq+89XtGNZs7fdV/3XJewGLuH4QnvLWMtlzOOgay9?=
 =?us-ascii?Q?C3dw8i3Aiqf/hEBjaugnYjTujmMFPigu21plVOjKqyb4rAtYyh3GnmC3bxGp?=
 =?us-ascii?Q?el3cI+cFOj5E6i6TATBODG/TIXuOoHsRyWgxlxHkmGU9N/zO93Iv308K+uLT?=
 =?us-ascii?Q?f/W4XcOUtY2vtDY53vnl8DVWPS/7VWDjSJc1HTADv/fkqmvDDQVkI3VnUPrc?=
 =?us-ascii?Q?IDVk0GQRCj8W1Y+LeXULcjjF/Fe5fXPBGBoAW+dkI+0wPXLaoXEuaSpKQekO?=
 =?us-ascii?Q?SRGgDDBBIAAltGQ9uFyo5/GV5o8fQkLritMc3L4U+d+GJnwZXmD3MllfOusH?=
 =?us-ascii?Q?6F1/6eywEIvOXNtgRGCUv3pGjBpSSdRCUyqeikmsnt+duZFdxX+Zs7a686ae?=
 =?us-ascii?Q?v7GlNXK9OXlMtFL0z9nLFvSn7NuTgabfErmH4og36WGyJmBngi0a3y9QvIKw?=
 =?us-ascii?Q?zT+xVwl4YrL1omrP8CoGxvjnyjTL/BIdi5L/fpqsqQM9t4VfaLGy2ikywGCx?=
 =?us-ascii?Q?XfqSUpuvtO67M5F0p0KpyiUNooZtsc2SuWT8CsmZnnosmyPIkxHKDBxBLzs/?=
 =?us-ascii?Q?hY1gHLzTLhR7ODicfss2vOzSrd3yJVpkLHWxuZimtYhfJmr/62ndEv4BnNUI?=
 =?us-ascii?Q?O1KMmrM1PXRpFV0Gd7zo2hhBWr+Jl63kD7V1kZ1clcbPpeJcsxJi6WsnI8RL?=
 =?us-ascii?Q?GTLrUMU+8Puz13b2DEGBbhVHrSkwlmeOTCSR+6Wd39jd/Fj+3msmNPlP7HIn?=
 =?us-ascii?Q?Mfj8+sla5cA1+ZIRQT1IfctkgmNPjXENKmFVq35UCHTeYSotJshn61F6P0zv?=
 =?us-ascii?Q?UyRaIETBRg2Qplxui2eBa7VnrgTikWCp5y2Y464n2TKuPnCLTSaSPElaP6ZA?=
 =?us-ascii?Q?wA66GgArOP8yjST3bXYXDNvK8kP+Q007KnDwO4kb/d1usXa0Z4n2t63W+Sta?=
 =?us-ascii?Q?ZCvR34fUa8Ulnai82/Net5dscXiIRutkRGzJapUas0+Kx+gs0590EEeK+VCk?=
 =?us-ascii?Q?MtwCnozhY7ifCdH1UQ4Ek2FyXTzPrkIBJshYqboUXuSuMDoN56hAaNRR2Mp1?=
 =?us-ascii?Q?oK0v3CdavsIH9uP1n6HDJXnASWZFOnQbB4bD9nart8dlK5EenKIm/SU9m+aw?=
 =?us-ascii?Q?nommgPP3oAR1PEreVBZCsWHto8L+u83ryCMM1wEhvz0wAe11VmakOUxf8oVy?=
 =?us-ascii?Q?1MDQmbMZTYGmPF9vhm6K7Rf6ijvt5YGTR6VkylKVZNvdEGuzL+A9XfQhz8ca?=
 =?us-ascii?Q?syntsBDpDgfZcX8HNTpHMayLirJXLpajz8WvwMbS6YQSbrCJOH8TNLDPnqkQ?=
 =?us-ascii?Q?MbbS/tuB0O0XRmjUhIJf6pAB3M15n5WQX1O09LrMAXp2K+C2fsr72D4/PqLm?=
 =?us-ascii?Q?48iZOqzBNvVxy1aCFN62YZQ2IX3dj3kayXETNuVVpEvgYzYVq09XiZe+zm4Z?=
 =?us-ascii?Q?NahhRgKrtDG03TvEL2dd2PnBdwPgDvFhrJk371DNqTsEIQxfNe+8wl2pHwze?=
 =?us-ascii?Q?4PyECTmugMoQw4dW/JzRdJxqKsBByzHDVc1CxqM7GCmGN53T0Uws3Bmnkh+q?=
 =?us-ascii?Q?hO2AuZ8HmweibtZ3iprDJmfI+P52YVWICq0h+fv9ZGZ036kctJblMKCJuf3r?=
 =?us-ascii?Q?7PJltD+uBkb5LOIYxjzLafGdGE8qHkSa0i2/4GBjH1ZNnmsVkX5xQNqNRb9G?=
X-MS-Exchange-AntiSpam-MessageData-1: DQ3Jss4tagxzDKvgD4+2OBZjKZ63znEn19o=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: e25da99c-e732-4b70-21d7-08df2fd9ff3c
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 01:15:44.8753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GkUgPVMsEtGgQO/J18AaF0bFR1jqXJNiqUOGdHNjES8ww0Um7QjmlRzMxSSwrhiYuWX6mxbQfFxj92kZInI9ju7uuUT2DFd6JOf/KPXZLEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PPFABCC8967D

TIPC assumes that the received skb is not shared with other users.
However, syzbot reports a bug triggered by receiving a shared skb:

...
RIP: 0010:pskb_expand_head+0x135a/0x13a0 net/core/skbuff.c:2308
__pskb_pull_tail+0x111/0x1870 net/core/skbuff.c:2890
skb_cow_data+0x2ed/0xc50 net/core/skbuff.c:5398
tipc_aead_decrypt net/tipc/crypto.c:892 [inline]
tipc_crypto_rcv+0x346/0x23d0 net/tipc/crypto.c:1843
tipc_rcv+0x4b7/0x1040 net/tipc/node.c:2119
tipc_l2_rcv_msg+0x2d9/0x470 net/tipc/bearer.c:669
deliver_ptype_list_skb net/core/dev.c:2533 [inline]
...

The root cause is that local delivery hooks in the kernel (e.g.,
deliver_skb()) may increment the skb's reference count (`users`) before
TIPC processes it on ingress.

Fix this by calling skb_share_check() to ensure exclusive ownership
before passing the skb to tipc_rcv(). As TIPC needs to modify the skb's
data, the cloned skb needs to be uncloned in tipc_sk_conn_proto_rcv(),
tipc_sk_filter_connect(), tipc_msg_lookup_dest() and tipc_link_tnl_rcv().

Reported-by: syzbot+0017742620a9d06f06ef@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0017742620a9d06f06ef
Closes: https://lore.kernel.org/all/20261018145928.58317-1-ngocthang2710.1999@gmail.com/T/
Fixes: 6e967adf798a ("tipc: relocate common functions from media to bearer")
Co-developed-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
---
v3: Use skb_share_check() to unshare the skb and unclone that skb
    when needed.
v2: https://lore.kernel.org/all/20261020104852.90350-1-tung.quang.nguyen@est.tech/
v1: https://lore.kernel.org/all/20261019050648.287309-1-tung.quang.nguyen@est.tech/

 net/tipc/bearer.c |  4 ++++
 net/tipc/link.c   |  7 +++++++
 net/tipc/msg.c    |  3 +++
 net/tipc/socket.c | 10 ++++++++++
 4 files changed, 24 insertions(+)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 05dcd2f9e887..5e7e220fa7f5 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -659,6 +659,10 @@ static int tipc_l2_rcv_msg(struct sk_buff *skb, struct net_device *dev,
 {
 	struct tipc_bearer *b;
 
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (!skb)
+		return NET_RX_DROP;
+
 	rcu_read_lock();
 	b = rcu_dereference(dev->tipc_ptr) ?:
 		rcu_dereference(orig_dev->tipc_ptr);
diff --git a/net/tipc/link.c b/net/tipc/link.c
index 6427c69f8929..d7ce384d3b89 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1363,6 +1363,13 @@ static int tipc_link_tnl_rcv(struct tipc_link *l, struct sk_buff *skb,
 		}
 		kfree_skb(skb);
 	} else {
+		if (skb_unclone(skb, GFP_ATOMIC) == -ENOMEM) {
+			kfree_skb(skb);
+			return tipc_link_fsm_evt(l, LINK_FAILURE_EVT);
+		}
+
+		hdr = buf_msg(skb);
+
 		/* Set fragment type for buf_append */
 		if (msg_fragm_no(hdr) == 1)
 			msg_set_type(hdr, FIRST_FRAGMENT);
diff --git a/net/tipc/msg.c b/net/tipc/msg.c
index b0bba0feef56..9a222e15ed31 100644
--- a/net/tipc/msg.c
+++ b/net/tipc/msg.c
@@ -736,6 +736,9 @@ bool tipc_msg_lookup_dest(struct net *net, struct sk_buff *skb, int *err)
 	sk.node = tipc_scope2node(net, scope);
 	if (!tipc_nametbl_lookup_anycast(net, &ua, &sk))
 		return false;
+	if (skb_unclone(skb, GFP_ATOMIC) == -ENOMEM)
+		return false;
+	msg = buf_msg(skb);
 	msg_incr_reroute_cnt(msg);
 	if (sk.node != self)
 		msg_set_prevnode(msg, self);
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index d5d70eb230b5..9789d1ce6bd4 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -1345,6 +1345,10 @@ static void tipc_sk_conn_proto_rcv(struct tipc_sock *tsk, struct sk_buff *skb,
 				      tsk_peer_port(tsk));
 		sk->sk_state_change(sk);
 
+		if (skb_unclone(skb, GFP_ATOMIC) == -ENOMEM)
+			goto exit;
+		hdr = buf_msg(skb);
+
 		/* State change is ignored if socket already awake,
 		 * - convert msg to abort msg and add to inqueue
 		 */
@@ -1359,6 +1363,9 @@ static void tipc_sk_conn_proto_rcv(struct tipc_sock *tsk, struct sk_buff *skb,
 	tsk->probe_unacked = false;
 
 	if (mtyp == CONN_PROBE) {
+		if (skb_unclone(skb, GFP_ATOMIC) == -ENOMEM)
+			goto exit;
+		hdr = buf_msg(skb);
 		msg_set_type(hdr, CONN_PROBE_REPLY);
 		if (tipc_msg_reverse(onode, &skb, TIPC_OK))
 			__skb_queue_tail(xmitq, skb);
@@ -2223,6 +2230,9 @@ static bool tipc_sk_filter_connect(struct tipc_sock *tsk, struct sk_buff *skb,
 				return true;
 			/* Empty ACK-, - wake up sleeping connect() and drop */
 			sk->sk_state_change(sk);
+			if (skb_unclone(skb, GFP_ATOMIC) == -ENOMEM)
+				break;
+			hdr = buf_msg(skb);
 			msg_set_dest_droppable(hdr, 1);
 			return false;
 		}
-- 
2.53.0

