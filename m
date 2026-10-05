Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013071.outbound.protection.outlook.com [52.101.83.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9857E2E975E;
	Mon,  5 Oct 2026 10:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195183; cv=fail; b=uNEp62Pw8nrgmjfnq5lcQrQuPt2a8upoXLiwVeTE5jruJafP4MGJuh7jrwZwqKtW+EJ3LgF9Ri65fR9mPad/5Ly9MfyNMTuF5Jed0eDFRUEerxc4/3+8DtW5jbplpX3mibtNOJe6JsxOMYN4CjhUCNJGvNYM3BWXH+NyGEhaKt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195183; c=relaxed/simple;
	bh=5dEKbjySb5wVrF8jmoxq7LVkMqQVzIzmsXQ/visz5Kg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AxFa/LfFhdfeCas6FU8F8Mc8HYs1rb+xWEbZfgEp2ik58jYUWQ3VBOO5woJmtbUvVE0HEvzUqPxu68E/Da1DF7UZ0QbSvrvA6F3phsggs99TNVmhgOwqxl/EE5R5CH+Aydqc9yt6xGwotWQf8Wos8kZ5DCuAd4fuxJ4r8fgdCFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=Q/EjWtZC; arc=fail smtp.client-ip=52.101.83.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="Q/EjWtZC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7f3xnXY4/l0abf3CbFYFyfo07kiq7HSrP+S2hmtjShfhoaN66llwGkAXjJnwIwYMOkqMghapxrGTSG4VedSqZscN2Hx7ElZ0mfpNaF8nvX6h+VA2lay2fwK/GwMBa1XEQjyPJZTj4Tfq5JBRZFU1uJr3qTvEQCfkTZy6RomrzpqD+LQ+cQjXEvleW93gqG4huV9t0cec+K1tLPuHVrRnZMSxt4eDu7facV10mitPHPrEJn3as4jcTYRv94ApQD13/EjuB3ILEK6ZFvU1pu0x0pnos5eaQI1Bk1kFov9twTlAXVtsIqpsWCrYo8c4ggkl/uFMvodK9bpsp5T8ouXhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFyhc/I7JWJY1D6xRs0ud7ZFMIWLHZEpClna3UugJE0=;
 b=q1fNZOXN6EKO4aErkbTFEGiUeCD/UaPM/9KjF4Qbh+ahxLxg12xnejxhtzxl88R1UuaUgokvn29cVkWx36mJNfrdmxYvfSUdYVdoRqJkRwSrrgx99nhLdST9LQFocXh4Rz5WcRSpqVohdNFi7fTYGtjPeyry7Ej3C2fOzmcK32wCZBdgQWbPbxVie0JvVFm/rYzQirQNggzhRbFTt9LsYiBzX3ieqQUwu/7Ff6AclLtEzIE7RUpIy7Ro/vEozmzFn9QcXbt7MzzMioMWw/GIl+xWB9jYLrnB73jAODj0mJhlbuo3MbAbDSGLm+ecn8wHa+34b+rhs/Nf6eHRc9rsQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFyhc/I7JWJY1D6xRs0ud7ZFMIWLHZEpClna3UugJE0=;
 b=Q/EjWtZCarI/xAzjOhsi5G9r2j/3g3RTp/6nAzXYdruSse4RgSchvUL6i4V+V+/GYMFJFX95xfjl0JVSZ+hfG+wdRMqVZ5fvB9RzcH7AgJXXOkJGy5gqxmQzzImioQj5hCHC1XTmHCDmaOi0ihlgmliSEPSYHxqiL4Ji9enfs4aP8EPU4S8R7fuEtuGktPuXMe56KxO7DZWO9gnPdDKDnGxjlp6yuRkrZLLpQ3pvZTA/Ck/RmbQuQj9j9Ck+FsudOSe+PEfB2kZYyIqvLtfoVXrmfLS7AvHsFgwNaWhpvo7V3eX1haznKhpJbVvM0lbMDqsNGDJVpwE0qIw8Ag7+bA==
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:617::19)
 by PAXP189MB1950.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:281::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 5 Oct
 2026 10:12:55 +0000
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3]) by DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3%3]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 10:12:55 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Yunpeng Tian <shionthanatos@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "gmwgg05@gmail.com" <gmwgg05@gmail.com>,
	"npczmd@qq.com" <npczmd@qq.com>, "xiao-yu.zhou@connect.polyu.hk"
	<xiao-yu.zhou@connect.polyu.hk>, "jupmouse@gmail.com" <jupmouse@gmail.com>,
	"jmaloy@redhat.com" <jmaloy@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>
Subject: RE: [PATCH net] tipc: bound the device MTU accepted for L2 bearers
Thread-Topic: [PATCH net] tipc: bound the device MTU accepted for L2 bearers
Thread-Index: AQHdUupSH2uO9sM2rkqNoZEt+nyyNLbuvNjw
Date: Mon, 5 Oct 2026 10:12:55 +0000
Message-ID:
 <DU4P189MB375083D2754F0268C13F4027C6962@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References: <20261003035018.397-1-shionthanatos@gmail.com>
In-Reply-To: <20261003035018.397-1-shionthanatos@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4P189MB3750:EE_|PAXP189MB1950:EE_
x-ms-office365-filtering-correlation-id: f07cdd73-d4dc-45b5-1d3e-08df22c93924
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|10067099003|56012099006|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 ilPRN143mpTQ38azUuBRMRSCEJo+RDy/mnQLGUmipC0MHJhr8+Z13aDRrkPGFQQFvIWnYH2HLsGief+6+PaiWeRxQBmoJW7njrE4i1rvJBTFedjd803smYKZCdzOfIeWrzmT/HdMMDErUrNcbRfuiLMQICqIbZ0iEx6zkfj9GYBXUmZJvL+K1CkzoTtKDNeXkKrc+kLWnyFkgKWsO6RwJj7g2w//AT7Vooy7F0jc01ORW+vxzGA/LQn/LiPVx+hVY94WKwD1ExP5qXD5xAoSNOesjGY8WJuF+bsCUxuG0qRPTjcC0hjCH/y+JLA094MwCD0QjlgIl/PsmTy8Fgcfm1INVErZYcgCKenNDwHbnEV87YQLgeB8P5rOWPjyJusi6K+S5dmj66QHM7QcFduagEbYh2CtXImr2BQtIR07Y3utrZ53R1+P54PcoZrzXxlLdmXJdP1n+u1fZzyMdl/6BIiAT0tNraEUy7LP7y73Nhz5n82oVFnyBxak1cv5FXG7w6uO4S3RMA24JtXTsQcqeaQIjgFe3DwbE7am3yp6tPDedWpdHLD472KyFw2JQsyiIPTwt2hy0YHKdIH3jWJ4+nRpSh9pgjN8Ixf35cfDGD0C+yfEfBPWzw0OFyfUS8EysK1jAlLLgMB+op5HGyCji2NBKzWTT5CEPpEL3tSfNjEK0WV3DOJfmyBpNe+3Zu1MnzxwpnUO/pbqlWcVTX+DWwqUxVqv5U97qmdcUPHkhtk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4P189MB3750.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8VDLwcRHaBrxKQTuLEYvfFKQLIFvu5AuJBjsac9rg3pntLvlVQgwUqpZhuI/?=
 =?us-ascii?Q?2R0JF4boh5wQXKZI2ViZRQtRWH21/FeTDFIfqB2ZSSRK6k++ajo+lELVSa7Q?=
 =?us-ascii?Q?2gUK8sp3BWRziHwZ2S5gxJnf6Zd4lpgcq9oopJaHOBi/ZMkZ9tFOc5qfUHm4?=
 =?us-ascii?Q?CtdZkAmmLLFalKStlWabP/w/YWpjjg0GPkmNAXRsEKeCYuljqIuNxrOJaSr4?=
 =?us-ascii?Q?M7d+B855FFzTSVKTxqzaYY95KAuwZmyNKHTfd7m+N/wHl+1B98jZDDZ6J++d?=
 =?us-ascii?Q?CkJQORwj/A4TtHe4qFpjCzVp3vN7fMo+cIBZzKJpuDrGFuHQq0q0vzLAiA3V?=
 =?us-ascii?Q?oi4ND9ypeBtOBNraZKe0rB3guY5DwutM8h6qEojSC22CTfyLvDQXPYNV9DbY?=
 =?us-ascii?Q?tMv/wRkAPUO4nb19GBlXogXY/nbjzlgBZASHvfnKkaQGLT+OaEcGVYa7Vhja?=
 =?us-ascii?Q?2e+cHo6wcid9/LDLpRkFk2rNA1Sawtc46rH0MbUZC0fcZnNmGCwz8aB1vNcl?=
 =?us-ascii?Q?APR/k4x8MPRemzCOQZ/dM9bhUL8RJQVS5oS/rsjmcMDzVCHERynBAhbqvRYq?=
 =?us-ascii?Q?XjEfgCTTmXjzqdcpbJtBWA6gcDPmvNrdDhKRvzmS+3VJPEhMpR9A3Xica20o?=
 =?us-ascii?Q?TYHm831yM/qkPAk4eHwGXItllrSYxFDD1rXagilDxqAo3rvYILO7gkmVX4R+?=
 =?us-ascii?Q?MqeJ1C347g/Bes3s9MtnJxXhuSnwfHqfVD269ryIYkccnTRXRRIKRq7NELoL?=
 =?us-ascii?Q?+Jd16VJ3xOEt6HXrURammzPlZyh5lJry2TJSM6vLCWZFuaY8OXMJIJ+Sg8kM?=
 =?us-ascii?Q?fDG+IKCm8lFHo3r0WDrr/ALa2vl3FmQh74V4AipzOc+KJG2A4rEgRsxteJjv?=
 =?us-ascii?Q?NFDDCzH206mI2IwR046VolM9aqwGCJ27emzEiJH3cDAg/hiNffnWKbl2ymYr?=
 =?us-ascii?Q?O0NOgEvZfiN1En2pSySao7pYDh5G9HZVW/g7zxN/t768fWXUc4jbHqM5Y/Pr?=
 =?us-ascii?Q?HAayPZsb+r1d6ezybRTNM+mlY1204GoiN9LC4XEcSewLSF16KqsSXZSZF18i?=
 =?us-ascii?Q?p2CVgBE2vHJ2XaE6bR2VwVAm3RyDrHx4scy+XO1QKx7bmDIkJnBMOBZz9TTv?=
 =?us-ascii?Q?J3jYHC271AnSBkDdCQY8G7BJ51NPoXa8/lkfs9sjDgYZD2nISEfkYks9JgDO?=
 =?us-ascii?Q?PSUVPMo3U3lcIqvbbfdddwKr0l/itm2f4LPhVH0U9AJvNEFc5ST/yGAsQUA+?=
 =?us-ascii?Q?znblG+PsM54+OtsLwyh4gyPI/WqQZ6Yj6DDmwU7kZzFid9h9PalpCgZfYUgK?=
 =?us-ascii?Q?h1rvAdd542hr0IJUcW6w4HuU+DUzrCmy60X+9ui8d3fAaBDyjJzKa4e6BExe?=
 =?us-ascii?Q?Cmg6/Jd9cJvzz4GF2ABaRKtj+1HgUL5168OY9dv2C+2o4qksXmIfchJ3kp3e?=
 =?us-ascii?Q?TDKItYBJE8UyQVvCZj8ytapQD6bBBb2+sBNUogsYaz+e8RWZexDW1xIXOZL/?=
 =?us-ascii?Q?QUx/2lVKU0dHNOvrayRMfMr3QND9iDfJmjh9lZDRg7E+3mW7CBjx3F8+W9LS?=
 =?us-ascii?Q?FNXs2B2nrVWDkU8BuHwWcdizDLZIp+nYgIcnvTcfMVhr4G+5c8IGivxmeBP4?=
 =?us-ascii?Q?J2jWTFeWZm0f/ZMGaSOY5Af+u6W51M/adGCvPWHyEGlhZJzfSRPv9mHx2vVR?=
 =?us-ascii?Q?gFgsli9HqmX2urAPzHjU1mYJhKWENo+hK3rIUaAZHsy49kD3hu+n9IFoaKLu?=
 =?us-ascii?Q?VhCLElEyDQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f07cdd73-d4dc-45b5-1d3e-08df22c93924
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 10:12:55.2119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vqf/P4u5RKFWOsJqyCojZl9iEg5b+HLQgG3ChnnTki/VRp1CAxHPzPl3Z9cWtqysb4hKY7yMcLvi1Or5ezahpfeiQ5ucyakw2d5PhAKj2+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP189MB1950

>Subject: [PATCH net] tipc: bound the device MTU accepted for L2 bearers
>
>struct tipc_bearer keeps the bearer MTU in a u32 while struct tipc_link ke=
eps
>the link MTU in a u16.  tipc_enable_l2_media() and the NETDEV_CHANGEMTU
>notifier both do b->mtu =3D dev->mtu, tipc_link_create() assigns that into=
 l->mtu,
>and tipc_link_set_queue_limits() divides by it:
>
>	int max_bulk =3D TIPC_MAX_PUBL / (l->mtu / ITEM_SIZE);
>
>ITEM_SIZE is 20, so a device MTU of 65536 truncates to 0 and the division
>faults.
>
>tipc_mtu_bad() is the only check on either assignment and tests a lower bo=
und
>only.  The truncation defeats even that: a device MTU of 65556 passes it, =
yet
>the link comes out with l->mtu =3D 20, below the TIPC_MIN_BEARER_MTU the
>check exists to enforce, and tipc_link_mss() then evaluates 20 - INT_H_SIZ=
E -
>EMSG_OVERHEAD as an int and stores it in the u32 tipc_link_entry::mtu.  Re=
ad
>back over TIPC_NL_LINK_GET, every device MTU above 65535 leaves the link
>with a wrong MTU: 20 at 65556,
>464 at 66000, 32768 at 98304.
>
>The bound added in commit 9f29cd8a8e79 ("tipc: fix u16 MTU truncation in
>media and bearer MTU validation") applies to TIPC_NLA_PROP_MTU in
>tipc_nl_prop_policy, which covers TIPC_NL_MEDIA_SET and
>TIPC_NL_BEARER_SET.  A device MTU never passes through that policy.
>
>dummy sets max_mtu to 0, and dev_validate_mtu() applies its ceiling only
>when max_mtu is non-zero, so the device accepts 65536; a macvlan inherits
>max_mtu from its lower device, and two macvlans in bridge mode on one
>dummy carry each other's TIPC discovery frames, so the bearer reaches
>tipc_node_check_dest() and
>tipc_link_create() with b->mtu =3D 65536.  TIPC_NL_BEARER_ENABLE is
>GENL_UNS_ADMIN_PERM, so an unprivileged user can do this in a user
>namespace of their own, on a kernel that has TIPC loaded.
>
>  Oops: divide error: 0000 [#1] SMP KASAN NOPTI
>  RIP: 0010:tipc_link_create (net/tipc/link.c:2531 net/tipc/link.c:520)
>  Call Trace:
>   <IRQ>
>   tipc_node_check_dest (net/tipc/node.c:1284)
>   tipc_disc_rcv (net/tipc/discover.c:252)
>   tipc_rcv (net/tipc/node.c:2134)
>   tipc_l2_rcv_msg (net/tipc/bearer.c:669)
>   __netif_receive_skb_one_core (net/core/dev.c:6216)
>   process_backlog (net/core/dev.c:6680)
>   __napi_poll (net/core/dev.c:7739)
>   net_rx_action (net/core/dev.c:7802)
>   handle_softirqs (kernel/softirq.c:622)
>   </IRQ>
>  Kernel panic - not syncing: Fatal exception in interrupt
>
>Give tipc_mtu_bad() the matching upper bound, so the limit sits next to th=
e
>existing minimum and one check covers both assignments.  A device MTU of
>65535 is still accepted and the link still comes up, with the
>65532 that TIPC rounds it to.
>
>The u32 max_pkt fields became u16 mtu and advertised_mtu in commit
>ed193ece2649 ("tipc: simplify link mtu negotiation"), which also removed
>link_init_max_pkt(); that had clamped the bearer MTU to MAX_MSG_SIZE
>before it could reach this division.
>
>Fixes: ed193ece2649 ("tipc: simplify link mtu negotiation")
>Reported-by: Yunpeng Tian <shionthanatos@gmail.com>
>Reported-by: Gongming Wang <gmwgg05@gmail.com>
>Reported-by: Mingda Zhang <npczmd@qq.com>
>Reported-by: Xiaoyu Zhou <xiao-yu.zhou@connect.polyu.hk>
>Reported-by: Qinrun Dai <jupmouse@gmail.com>
>Cc: stable@vger.kernel.org # v4.1
>Signed-off-by: Yunpeng Tian <shionthanatos@gmail.com>

Next time:
1. Please use correct "Reported-by". Five reporters for a small issue looks=
 weird.
2. Person in Signed-off-by should not be in Reported-by.

Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>
