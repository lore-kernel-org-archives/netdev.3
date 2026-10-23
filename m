Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792733372;
	b=JBH9jE+8Y+zDgNZ1AES3IoG+eLhu5GeNniwYgxXP0vx65uka20mtD7urqyTAsO0WOQVA
	 wbMkGe7d8j6PpZdCVzGwG5Q0qNjZyKmu0a45RNUeOYhhn61ozuyOjPMQRQ1gKW/hDLQUa
	 EY5O0ydnsrCVUrnzamOE0m0sIDZmXgesZXwwgLN4t0PeGcDN5LoSyUeHVKoOiaDevojKi
	 n3DdTKX9Q/AXINSIubHerCE03L6Em9qwOwdqKOAk/F1tBraadISwYIVwUfIfWc++GudLX
	 2lmJ9xro6UWUtzUQZhnAATOBgTlw7B+spprZG+1480THyJXWmxElYIQVQC/B3H/9FoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792733372;
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
	bh=ydldt1wZNsJBLie7B7tbLhzw2WR0htcWllQVPNX4oMI=;
	b=GUiWNdFFBJ1gsUBwRiv4NynmaHu1KLcvJPT0XoLNo9W1ka7zEnAEqlnWRdWIJTJyvrBl
	 AVZnA5FCVztJ8INbhdtKOxDWRXf/hHxPVk+wB+1xU+GcBbZuAKJx+gJ70fEa8GNGJzyrJ
	 vpL938W9xkYvRupefmbLDGTDekUaP2hpiNVEmonrUJLSO9A0U8USZ+U403vM2kGCq+kvK
	 fHnAV/XROZafZ0UMGIWNpQLukNHSrKRtra9533AIh+sdhvr/0vXZrh20G40uOy61dvG63
	 ProYYpoR5olfKfZgi0IGrpisoZZxKyPWEIXPEP4L3EtiptsZaGKsj9PbIMooctygpxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=est.tech;
	spf=pass smtp.mailfrom=est.tech;
	dkim=pass header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=fVOghxnv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.39
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011039.outbound.protection.outlook.com [52.101.65.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12835606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 05:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12835606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=fVOghxnv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIGvwoWzK5Q40+zySar1HP9LJo2+7xPb0mboHd6DANomms0YxdmVMrr+w9UEPvhsZc+LDJa7IiOUsZG3H19b6VbjmwNzhFnlngQn7Ti48LBhGNysQA7/GVI3WT7vJ6XDFidnsM5QaSm3eEgDnjRooL6kkSTGY5at37/yJbBrCYeF9+tHNunNSC7wqRne17x/VchwUx2M31qTdnCO450SIsj0Ec0waoPzI+oj4LHebjgFds/cpmtq89h9yEXZs6eXDfeHqmuCkV+2UEjuoHV39+vbyvLOeotNfO0SYHN7LiufCOxCtobt6/tBxnouT7sLngt6/eK7e6zrVdxNB6rXDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydldt1wZNsJBLie7B7tbLhzw2WR0htcWllQVPNX4oMI=;
 b=HbOI68tKyl/X/n3aOoGcnBn4TUaVjVD1vNVQWr/ImcruWErgJaiUJDeFC381OVs1vcUzHTa7fWAQ+hImdzPcdq4Gxg6/UD4XrAMGwKu8Xyx3vbC/GNLq1GUsBo6kT0vF9kCG8ybJlFu/NFYz/drjEMAGcJR2S3TJpFjokM9TPd0xYZmBBYyFkZKXH9k2T1IUOe3LKX5NzZu9UHozZx1wrajIIYt6EBD/gOJ3GxV5Q9cwDozAnloYjAmfdPKipS1Sm+TDAnssD5JSO1UqR6pV8Pk/6bTlmrrxwRhx4SJLNhljsPQGs3QMAIpsXhUIbv4fsd/bcR2sF+lsOCl4IbYSbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydldt1wZNsJBLie7B7tbLhzw2WR0htcWllQVPNX4oMI=;
 b=fVOghxnvuAS+Ehq/k78q5FImvIX/ASya+SPrvvVCBf8+kDfcqrHyjTJpOXL8wtbODjDzau19FkL8kL6Bsd0pwizWexeRXhp1oBgzNSS8o0Exze+V4kdZyPBJmAznhVWOcvZs4gggPerrhefiqCU03tdCa2JZ6sOeTU3jrksexuxqqWH4Uem2lqCRCRU64tFdNl6WFXrByTErzTbiIaoMMWp6kx5VVMQOR/JrUiwJkBGYNJd5Eiok0YeBl+GL/AFX64yhFIpxnCaFDi0jcNvx7DHWe7u3w6OHkWr37DZGqAAo8fatzr76W5QGnRhrgXQo5RdA7c1k/GMyQcTuylhUAQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by FRWP189MB3199.EURP189.PROD.OUTLOOK.COM (2603:10a6:d10:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 05:29:28 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%4]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 05:29:28 +0000
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
Subject: [PATCH net v4] tipc: fix refcount panic in tipc_rcv() when receiving shared skb
Date: Fri, 23 Oct 2026 12:28:18 +0700
Message-ID: <20261023052921.54220-1-tung.quang.nguyen@est.tech>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AM7P189MB1137:EE_|FRWP189MB3199:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ebbd8b-8896-4b82-ce28-08df30c69bd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|10070799003|366016|11063799006|56012099006|261021123027099003|261022105027099003|261021121427099003|261009223027099003|260925021911599003|260925021311599003|10067099003|260925022911599003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	0yAZyqzOhhDoSSOeQQtGRmYpeVtKWyH8hWd24CgJoicvlrqoGGWSnNVnCrfxIvi3vnLjKN68wD2Rzz1m4kUCicJTqRkk0ioCT8qqAT4ux5Kxxq9N4fqWIfC5CKq4vzPuh6wZjW61vdeZyh+GhQvOcWJW23t/Z+y3BoSoc+D8H7WkZANIlBEpS02tMPRDX6284Qlk1WV/thu+oEt6VH+O3DUTMSWFJTKpb3vlnO+MAf5wpZuVB6mXCiCUX7Y4yvsyYKSw9DuoKL/IFnsttzE8l2CaHQS1B2f8bx0bqNMnKcIHiZ5tKYPzIGjnEQYbhM1lADtwAPwymoT+Y6Z+r9/vbHaqMREh34CILZ8PwMkkxlDOUqfaG+SFvVfCiKVCv/lzJttadVx+fBVr54u3XiBPE0fB4lr9FNfXlAp1axvCcKk91Zq5cnWM1TUCPfwKZSNnaISQ+orqQgIAvAVFg/o310wjynNSyvQ/CPSGuaiBV2ctt1JdEZz6V3TFruAqavx+y767gVMPPO0Ig7KXXfnzBhF/4SHnvgXHVAAaBxUChcpXyOBWUoBcWwtoX3Dx3HwIvX0YrDfNO8aNM9gplB9f0M8CJUK9PayxB8GQpGdfa4+TLcMGV7XsyR1Q442p6Ww9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(10070799003)(366016)(11063799006)(56012099006)(261021123027099003)(261022105027099003)(261021121427099003)(261009223027099003)(260925021911599003)(260925021311599003)(10067099003)(260925022911599003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pvk+fWNuC/QXCf8+kshKsnEQ4+8Zdnmy5Bdx26oz4kI0B5q/Ga4wwngNRXpE?=
 =?us-ascii?Q?jEzlx5sR6Txizz24vd8o0YVpxS3+KdhlapOHADp/7Uq5cqvqJAgsrDA0btWv?=
 =?us-ascii?Q?vrAz8wl3GvkkaVazzL31GkxnnH4PKPcjsV2JGW8yGk2pdKZHS+aRvqAlqJPx?=
 =?us-ascii?Q?wArX08M6HeyqKx8XPuauUKi3mi+H+78o6lKpa93d6rxJaGb6d11DzbpqKjIY?=
 =?us-ascii?Q?hrwv7c2vY0mGpG/jI+vGecxeolpgNBQDtVVFvnXrYi+kWz5SD3XdV6+M5N04?=
 =?us-ascii?Q?/GIFTOYaYd5QWASgeefTCA6OC/TdoZaxe6qPbJB3JwQdzwVSJ1rdp0M/naLp?=
 =?us-ascii?Q?091mMl+m59/geQEpYw23pVszdVEm27DKdEPV9yNeAgahOtS3miEz89lE+aEg?=
 =?us-ascii?Q?bIvepU8pcnGD/1neIIT61QjlX9ypQueWrzd8HL8D4u4lxAMYfKOojbDWkNXG?=
 =?us-ascii?Q?89DjviONfde40/zJ5V10Bc/TjInKSmOWX20cZcQ+SPgFhKjbxvBPuc4FrO9c?=
 =?us-ascii?Q?W+HSNGeU3rFmIzhzH/1cMMDu4YMDHaQlPGWeg8DKnGJpOp5KGIyJHaQg8bcO?=
 =?us-ascii?Q?CoG/V7SOvvbVjpUSfAXdnRuk+BvJ+HdGfoeAfThX4faDReMyBdeZe57fqQS7?=
 =?us-ascii?Q?AjvM5LQlT1Q8zo34IZLngaSiwBlt1N7cqAWf2ssucVa76fNnms6T2XtHYi1J?=
 =?us-ascii?Q?mkk8Od1JSp0ExrbX2syVbpDDr7Qipc61cf0JNu1xgaQomW7F4nGL6e0mQCNi?=
 =?us-ascii?Q?dda7NV0Jev+ae5s0Gx4SA6oPsik40z5FlPpJFs02e2QziEiz9TRZGhQ63Xyt?=
 =?us-ascii?Q?W6w+2R6j6mcS4SmZjnLN6Z8xqwLbVVNq89ajO5OhknCOx0kBgut6vGNQ+VDS?=
 =?us-ascii?Q?hv9YzA8PeX01M+ocYaJ64Tid04riLU6xnR4O6Tsphnlq96IYXamZVakncZas?=
 =?us-ascii?Q?sxF+2l7eFwQiCC5mtswoE67/0nx8CAlFoasJGduBbIz3ebAS7WLmpbUsf1t9?=
 =?us-ascii?Q?Zjy7SK3DCr9cN4Jg7grYSli0N7JvCbPv3/xih7QN3sAfq8YIU2uwmjjdnNvV?=
 =?us-ascii?Q?W6Y1CQV4gnqDmIzzwPk7gHBhKQvhdiQ1so2afrFLm/hrYvokVI4PXg2jx1pQ?=
 =?us-ascii?Q?MR/NP4uXtW5L005KFc0WAA75kt3nNiTXUaiSlKF7d/Z147tOTLRp2Ag9gQcK?=
 =?us-ascii?Q?qk8X9oMAmQGhdSwb6tTWFiqyN8fY853TAFAe9zB+w/Q0+SdswWueZKVcJgz4?=
 =?us-ascii?Q?EiWKXIwbUNxqxSyp1yjKM2tgYxXNH0p/TuGnNLQSkWrtA2OMpli74pQrTcwo?=
 =?us-ascii?Q?Pbokn7l+YCYEMNAvoBfV9Ls1cF99DQmxM+to2/AtI1Cbb+wk4OFceD+uQKDF?=
 =?us-ascii?Q?KSLgTIdtbxDP21O8u6yTCKFyoXvahAywgbTEloYXAMkxuqjRyoIzTzdG6ZIF?=
 =?us-ascii?Q?T5UXDjG8xHgifP7FyWbtF5tH0cnm94+xQSduv8y21GUcfAB40pMrVQGGSone?=
 =?us-ascii?Q?FH4GcvIl7Mb6yju7mNIX2OAjcnmIDsp4W3gWcFAXVD6V8NMDiAplRAC4F+Rr?=
 =?us-ascii?Q?qeTxWfK+716rVD89YR6Rod2p1TSGo0eH+BBBoefT31lraZ7uecl7FZ3T9nlO?=
 =?us-ascii?Q?qwd14QAkzUTNpYT4oNUIQVLFA3Dr1+TdfAkqTvh4s3Bv78VQjhqKpBv38zVr?=
 =?us-ascii?Q?mmSAft69hBD4SNe8jkHuLIlAKJZkec4Osv5+IaO4a/0u/4bm9kfAOV6g/L+5?=
 =?us-ascii?Q?2jAPpQbk8loFkj/dw5R6AWJqeYlTIHdMTDDaZaae6Z1RcLHD3gYZOSnTwWLj?=
X-MS-Exchange-AntiSpam-MessageData-1: 2RO0msXQ8MhVgfXqwG21DN47HE9H9c4b1oU=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ebbd8b-8896-4b82-ce28-08df30c69bd6
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 05:29:28.7047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7nmvgfNmvbElQv84aFwSs5qGd1sB+7BQzYc39Z3/fSliwQsBV9lW0f1TEbT1sHLZtm9W/ei7UXr13m6jhHjj63/HfDBZOJ0RucZxOI1PxkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWP189MB3199

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
data, the cloned skb needs to be uncloned when needed. This can be
addressed in separate patch.

Reported-by: syzbot+0017742620a9d06f06ef@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0017742620a9d06f06ef
Closes: https://lore.kernel.org/all/20261018145928.58317-1-ngocthang2710.1999@gmail.com/T/
Fixes: b97bf3fd8f6a ("[TIPC] Initial merge")
Co-developed-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
---
v4: Calling skb_share_check() only. Uncloning the cloned skb will be addressed
    via separate patch
v3: https://lore.kernel.org/all/20261022011539.6882-1-tung.quang.nguyen@est.tech/
v2: https://lore.kernel.org/all/20261020104852.90350-1-tung.quang.nguyen@est.tech/
v1: https://lore.kernel.org/all/20261019050648.287309-1-tung.quang.nguyen@est.tech/

 net/tipc/bearer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 65fa18928fe3..774f68d1a2b3 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -661,6 +661,10 @@ static int tipc_l2_rcv_msg(struct sk_buff *skb, struct net_device *dev,
 {
 	struct tipc_bearer *b;
 
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (!skb)
+		return NET_RX_DROP;
+
 	rcu_read_lock();
 	b = rcu_dereference(dev->tipc_ptr) ?:
 		rcu_dereference(orig_dev->tipc_ptr);
-- 
2.53.0

