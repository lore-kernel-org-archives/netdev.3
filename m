Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013060.outbound.protection.outlook.com [40.107.159.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463724A8A39
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820567; cv=fail; b=Xqri5BFG+ktxe8A3PdBuHpRNaesTRrkJ5kSPp8sQADMHt7/wsIDupJGqR3vHFmD6Mv+2pux02kboQLBt46Z3Wk+VGrbU+O15VS6w3wJ9s6aYWNTnNm7qidykGQmH8bZ6HaAtlTAdIyZGUE6MXBJyEpLOcVhV+zfAmEmM73biL7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820567; c=relaxed/simple;
	bh=A1evB6yqikpHFZXYwNFwuSthR0EynmYaR/XtkKA3c/I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QZek5IjN84CB2uHYQ5VONGt75JwPGCGeB4k551Ir9D5ODwTNay6lBElEm0lFvCbgMf/l05Ur9Ke5R/67ARoFBwsvPXtg5LRyCfZ4TEHK72VcrDJQT2JA2l4UNc73OYeU2X+9M9CWUufn5M19+0+wLLVGFLWRGRHBx9yBNySAWPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=E+H//2zC; arc=fail smtp.client-ip=40.107.159.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="E+H//2zC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9MYIm8NIPQnO4E30qC5FpK6XPrXg2j71ZCHPcG/Ra90zeZWUa5LjqbI3K9/dbKStiUJ4A81RUeZdzgWoXHmKM6QvFmkMytO671FRk5Yff3Mx2PTabaqZelP9jMQca9N+/rQAw2uqvBihkIa3JFH4gX1sE1FJfBM2tsXJVYXndfmZCu8Dbn/96G6KqZlqCu5gl1OrDDzbRW1FSbKIJqaDePHBtg5LijpAlsbwXNO+tPH4KuN5fMt7EsC0ZSBAzXFuM5xjg05w2okvHbb9WQGS8qDtN+Q8QjQsgH/uAf3hpEW8pBi6unh8GYHQYi1THCIDC+cY1+Ly97NmW4ROwv1CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhbFb3qpPFGZDU+R7zglyqT0wwcJtyJAsIBPaeqCQ1w=;
 b=M6LnqzCrpqV2Q5hPr4OEZ4SVwORM5fvEONZFAJvtiIpZme22O65LPkWlutkpekHWoNEPrvQn3eKq2J61T4Uxep352BO8p9nYjUwNPF8bi9jbO1kvzsjhawwS56c8ZzkSRvHIiRh49vTGHwdGwKXoxu9EASrTfew2CZ8dKEgvE4sR1+DLfhW8+7+lpJRNB1g8MZ4vhRYd14TvHcKzRAknLDi4tt+Ajosp/Uv9egGKS0YWX8Qxx5+pavnJpTzRde+/QFeZLkNVSpXgsdHOLniFXbIO/KUIvod3Gy2qaKTC74mdhsyv+j9iwiJg9tiYp0kxMoCVAvgXtviDp5vd3Wr69A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhbFb3qpPFGZDU+R7zglyqT0wwcJtyJAsIBPaeqCQ1w=;
 b=E+H//2zCL9aknLaLGqv8nIjN+/CAZ8nRrUbdLPtwN4WmrxzQJqlF6h8xGObS5WHQqEuW20WJNJVpGTgFUGzH9sJ6OR324aO5mbDxDpqU11BiOIzQDBGdBsBDs0PN8CjxSJ+5bOJo9VmwiUetVCsFyk4CfyRaYtTIDNW5kkBEUDWgt/eTm+rqOATPt+UWdiaBf7iFsfMnSGl7Fd/nHXpUhFFrw1GuC36hOQuW7cjHzqwAUlqbyQA5WK+wDq/VKd+KLY/T2D0ChUckZZUSHJkKGcFDa57df9dPg3B3+K6K0IGaCKRmi1STPVPJZpY0jbgtu30wQvdLDY3WmVtF6XDQ9A==
Received: from DB8P189MB1144.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:167::9) by
 AS8P189MB1256.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:288::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.23; Mon, 12 Oct 2026 15:56:01 +0000
Received: from DB8P189MB1144.EURP189.PROD.OUTLOOK.COM
 ([fe80::fc41:e57d:d1f6:46d4]) by DB8P189MB1144.EURP189.PROD.OUTLOOK.COM
 ([fe80::fc41:e57d:d1f6:46d4%6]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 15:56:01 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
CC: "David S.Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, Jon Maloy <jmaloy@redhat.com>
Subject: RE: [PATCH net] tipc: raise the minimum bearer MTU to fit tunnel and
 crypto overhead
Thread-Topic: [PATCH net] tipc: raise the minimum bearer MTU to fit tunnel and
 crypto overhead
Thread-Index: AQHdV+0taEaIrQWkG0iveC+sgNCicLb5zrfw
Date: Mon, 12 Oct 2026 15:56:01 +0000
Message-ID:
 <AM7P189MB11375A32648F33B53BA95A4AC69F2@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
References: <179155039490.29136.3966310214361645960@gmail.com>
In-Reply-To: <179155039490.29136.3966310214361645960@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8P189MB1144:EE_|AS8P189MB1256:EE_
x-ms-office365-filtering-correlation-id: 8716bdd2-4f9f-4761-e8e3-08df28795081
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|10070799003|366016|376014|6133799003|18002099003|22082099003|10067099003|11063799006|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info:
 3WMax2hkrms6ByfOZZAghzQDq/6hVfQe7txJzCxbGlNTx5bQu4c77l432+ptXT8q0b4COMpAblB+tnU7clYeKcupV8emAU9iDXn6emeYNdUMtj3Vjr5hKuDj6Ua1xd3iEUfPsdIW5jqERaXj2+KnyJGJTIEXtytoWv1vEvacD5Tq81aEwwzsmDaVkW7Q2/Jw8xyFwcvX1FDExtDBbizOKluI9vV2UpRvlsO4iCEIOyRF0Hf28DLzsqZFWyfEaVafsdXLH53bz2gp8Z2PM8ZdiGwHlhLJrKpf/u7LecgLmnTAbMaFQaJaYxSePLYk+j/BXW4Rw5vLBaHF1M5Kkhzm7EYofQFNC+YGWwgDzwJ7lV2RGsasps7WNXGwDPOTfYca8ZG41bAjOOhCj836q9fr2KSKrPPjSkLLexDJlyTae4XQtNoGclUvwHUJGVmt2iCLkUuW8wHGrGB9XKJuQaJ5JfEv8mMXabgY/B7vdq3icxiJFKXVE222MPsqufnJJ1zCcXvjsJ9PI6mt46mJ68bwpsDKv6Qw41nRKhQGsuZDVwqj/0uzrZSx41znElsrEk8fGJyR7Rw3pXuT71ltJjf9F0kM+Gt4k/utCKiS4MFZAH4eVvrXXaYSNitEfyUYHTl/yacwxIV714TKAiEF0Nyi5A7NQ6Czg4iiLolO7nI+OWFlwtGsjxUbJ1WE/1wDG4FWMG8igATWxB57eN1KALZaD1y/dJ3f4ScmWAA6RJ3O59w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P189MB1144.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(376014)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(261009223027099003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?O3tsTA/vXrJCTitm7nfX2x0UI1v4KwpQoXbHhmrLAVRh6iKBj7hWYX3oAO?=
 =?iso-8859-1?Q?IV/KlGueQJiuzPA2kNp4y2Kft1Xr+FmrGZREpRK9kHVUztNl+LJeuS0akA?=
 =?iso-8859-1?Q?iU7rH+hwNPxVge9V6zlbNL7VI27j+Llxpawnl16soXnz9qSxrpGVdADYx/?=
 =?iso-8859-1?Q?zvMfj3rhnA1lUWDBDTaCmci3xrfhSrRf/RvE4Fs0BbToem7p0p4uVKI30D?=
 =?iso-8859-1?Q?TbAXxp7VVehlKr+jt2dsfiwCjxYa0zqZ+XK4H5CcbSax3P/LxVmI5bzCux?=
 =?iso-8859-1?Q?0kQGZi3Ja13Mu9KE/ctfAY0sup3/f/W6iWcNzyM1OZyXyfZSfYB47Hj7zP?=
 =?iso-8859-1?Q?tWag3/y4SylDE23pSAznmkolpPd4KWTgTHdIkg84Jk4JIbJcxzaBHtpDcH?=
 =?iso-8859-1?Q?jyIf/4s/lMxBX+2huzbgiaa1cORecfmV9Qr2Vu93L0iCWMSBsVVmxuHkVa?=
 =?iso-8859-1?Q?SW4XFmm3wVMx4REP9FdTvg1b5VNjCXME4Q3cI9jmBJM8UpP5J6jkZCft/o?=
 =?iso-8859-1?Q?HmrKYg0Xj//R5b/AyFW7psGqR+Q+K/mleyaBC+h0pUv7m2CoCo3Mk4EGwz?=
 =?iso-8859-1?Q?HRfleLneUVS8fngAC9APrvGNOYLnp3N9jxrD/CFuWs5Jq4KcYHDsJ8RRL6?=
 =?iso-8859-1?Q?a74fHN3zdXI6ToTO/ShlpzeZPeDSyUxgCLv9xu4y0g1/5jkAkzanYCaiBQ?=
 =?iso-8859-1?Q?Mz+9HhMzD/pQOruLrLOxvHxsqtq8G79uY2UMkKySAZlId4p6TFPJYsPlnn?=
 =?iso-8859-1?Q?LbXcS++UeoX9fieRD0vRKGXdMP2H02nFiB4nHoyZTaONlgGWVr9W9Ahw8c?=
 =?iso-8859-1?Q?5NwGBYHz+dOHWVSnzJNC0lcHbbYWpA6Y8wYr0Ch9EjYurLrlDu1mFZ8ZJE?=
 =?iso-8859-1?Q?RW/VME+BzR/W8c+xMjdx6j2sMtfPFC1fX+7YLdxbfEWry+kYc5tQ4ehKCj?=
 =?iso-8859-1?Q?Mfn6WdTP6d/BwCAhdDe8RXow6qLaoYBlvUgc1ZZ3lf+K8+LNZ1q+TmGh/E?=
 =?iso-8859-1?Q?ngGEYuOswgCHCtkGPYMI7prke/EIwy1segfizY5YeM2LsZpCu6SIQQkSDQ?=
 =?iso-8859-1?Q?l/wfEqKRlSOU9J+lsVyDFYkdjKTxzu0iZRMHFqGgkrK5xDsJClwJuaGwpj?=
 =?iso-8859-1?Q?18hxOEPXuxllcPVktGBq5hfKNWVxjrUdzsy69s8vLLBK4FVmpq4xYk2z/v?=
 =?iso-8859-1?Q?0To01mj9N7PZZ8Aaiihxm4BI0QcET+AhW/FDrNCouQLsF9g9SLq5JuCIRa?=
 =?iso-8859-1?Q?t3QSszwUHQaDN/3J4EcKvB2JFYn1uFfFT9perwNVEn7x2NTSewwBozm+R5?=
 =?iso-8859-1?Q?fpJUwqgAE5Fo/WTAaqNNrLS1lAu9Httm8zsyWCS4VRX8EWnCPfKGYCsCUh?=
 =?iso-8859-1?Q?cc+ryZdK/SMLNLh+UlMUTSlwWm0N/8g/Vf9ol5kgmO9MC5fjCZe4QyFCZz?=
 =?iso-8859-1?Q?sGXBgFmOBPo0ToTDGMdJc1ofHjd2Lts0J7Cr34YkiiSIVPU4KffN9BjrQf?=
 =?iso-8859-1?Q?YSseoQ0NjuSE1WHzBtJy/H7Twsihy1EDJFAaCvX1tfYSEvD1beBDKbxW5M?=
 =?iso-8859-1?Q?n3w3ab7gcOCwXOOgu5I0cITF1XgfIvSyXu1cMlYzM5hamZEvKrD6qKqSgc?=
 =?iso-8859-1?Q?AVCOkaZ3GWjcGtKBhKUqI2cS50MPWVRKCP0WpcFn17BvWruPqF6HMQFVim?=
 =?iso-8859-1?Q?FnEEiHTL2DapBs93scqNgunnL+h+4O4mi15mj4tEOcawsOERXVnf/PLQLI?=
 =?iso-8859-1?Q?q8WMdLeIQjNahSS/R4AJMvYGz5HycGP15LM+ReuDV5sgtkjoxFrKsoNp/6?=
 =?iso-8859-1?Q?uAE64gep98dQJf20TxzpNsNKPeP2CqcDfLD2y1XrGh0s3inXV+wObrtc5q?=
 =?iso-8859-1?Q?GW?=
x-ms-exchange-antispam-messagedata-1: VfigLx+3VcwLPQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P189MB1144.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8716bdd2-4f9f-4761-e8e3-08df28795081
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 15:56:01.6163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hU1BxTB/AJIWOeR0Cp+1cTssRN5X1pZLg6etlKt7tMjo4hvb0f//ZpKYCp8JIirfaVPdo+7ZxN8jE+Gf0DxDMQ7Y9ahHsV8ZjKnu1oJFBmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB1256

>Subject: [PATCH net] tipc: raise the minimum bearer MTU to fit tunnel and=
=0A=
>crypto overhead=0A=
>=0A=
>A peer can lower the link MTU to TIPC_MIN_BEARER_MTU (100 bytes, plus the=
=0A=
>UDP encapsulation header) with the max_pkt field of a RESET or ACTIVATE=0A=
>message; tipc_link_proto_rcv() only checks the lower bound returned by=0A=
>tipc_bearer_min_mtu().  The same bound is applied to the device MTU when a=
=0A=
>bearer is enabled.=0A=
>=0A=
>That bound predates two later reductions of the link MSS:=0A=
>=0A=
>  tipc_link_mss() =3D mtu - INT_H_SIZE                    (tunnel header)=
=0A=
>                         - EMSG_OVERHEAD               (CONFIG_TIPC_CRYPTO=
)=0A=
>=0A=
>With CONFIG_TIPC_CRYPTO=3Dy, which is the default, an MTU of 100 gives an=
=0A=
>MSS of 28.  Once the link comes up, tipc_named_node_up() calls=0A=
>named_distribute(), which computes=0A=
>=0A=
>  msg_dsz =3D ((tipc_node_get_mtu() - INT_H_SIZE) / ITEM_SIZE) * ITEM_SIZE=
;=0A=
>=0A=
>For an MSS of 28 the subtraction is negative and the result truncates to=
=0A=
>0xfffffff0; for an MSS between 40 and 59 it is 0.  named_prepare_buf() the=
n=0A=
>allocates a buffer with no room for any item (the u32 size wraps), and=0A=
>msg_rem never reaches zero, so every cluster-scope publication on the node=
 is=0A=
>written with publ_to_item() past the end of that one skb, over=0A=
>skb_shared_info and into adjacent memory.=0A=
>=0A=
>Without crypto the MSS is at least 60, which still does not hold the first=
=0A=
>fragment built by tipc_msg_build(): INT_H_SIZE fragment header plus a=0A=
>message header of up to MAX_H_SIZE.  With pktmax below that, the header=0A=
>copies run past the pktmax bytes allocated for the fragment.=0A=
>=0A=
>Raise the minimum so the MSS can always hold INT_H_SIZE + MAX_H_SIZE,=0A=
>which also leaves room for name table items: MAX_H_SIZE + 2 * INT_H_SIZE,=
=0A=
>plus EMSG_OVERHEAD when crypto is enabled.  EMSG_OVERHEAD is defined=0A=
>in crypto.h, which bearer.h cannot include, so the value is spelled out an=
d=0A=
>checked with BUILD_BUG_ON() in tipc_bearer_min_mtu().=0A=
>=0A=
>Found by manual code review, assisted by an LLM, and reproduced with KASAN=
=0A=
>using two network namespaces joined by a veth pair (see below).=0A=
>=0A=
>Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")=
=0A=
>Fixes: 2320bcdae628 ("tipc: fix changeover issues due to large packet")=0A=
>Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>=0A=
>Assisted-by: Claude:claude-opus-5-5=0A=
>---=0A=
>Reproduced on 602042bf29f6 (arm64, QEMU, KASAN,=0A=
>CONFIG_TIPC_CRYPTO=3Dy) with two network namespaces joined by a veth pair.=
=0A=
>Node A binds 40 cluster-scope services, node B enables its bearer on a vet=
h=0A=
>with MTU 100, so A negotiates a link MTU of 100 (a remote peer can do the=
=0A=
>same with=0A=
>max_pkt=3D100 in RESET/ACTIVATE).  As soon as the link comes up:=0A=
>=0A=
>  BUG: KASAN: slab-out-of-bounds in publ_to_item+0x23c/0x288=0A=
>  Write of size 4 at addr fff000001036ad00 by task ksoftirqd/1/22=0A=
>   publ_to_item+0x23c/0x288=0A=
>   tipc_named_node_up+0x2b0/0x714=0A=
>   tipc_node_write_unlock+0x330/0x44c=0A=
>   tipc_rcv+0x94c/0x2188=0A=
>   tipc_l2_rcv_msg+0x118/0x1f4=0A=
>  Allocated by task 22:=0A=
>   ...=0A=
>   tipc_buf_acquire+0x24/0xd4=0A=
>   named_prepare_buf+0x3c/0x1dc=0A=
>   tipc_named_node_up+0x528/0x714=0A=
>  The buggy address is located 0 bytes to the right of=0A=
>   allocated 704-byte region [fff000001036aa40, fff000001036ad00)=0A=
>  tipc: Too large msg, purging xmit list 1 11 0 860 100!=0A=
>  Unable to handle kernel paging request at virtual address 001fe000022e18=
a9=0A=
>  pc : kfree_skb_list_reason+0xa4/0x32c=0A=
>=0A=
>The final oops is the purge freeing the frag_list pointer that the overflo=
w wrote=0A=
>into skb_shared_info.=0A=
>=0A=
>With the patch: MTU 100 is refused at bearer enable ("MTU too low for tipc=
=0A=
>bearer"); MTU 172 and 1500 bring the link up with no KASAN report.=0A=
>Builds cleanly with W=3D1 with and without CONFIG_TIPC_CRYPTO.=0A=
>This was first reported to security@kernel.org; Tung Nguyen reproduced it =
with=0A=
>the reproducer below and asked for the patch to go to netdev.=0A=
>=0A=
>Reproducer (as root, CONFIG_TIPC=3Dy, CONFIG_TIPC_CRYPTO=3Dy; build with "=
gcc=0A=
>-Wall -O2 -o pub pub.c", run "sh tipc_repro.sh"):=0A=
>=0A=
>pub.c:=0A=
>=0A=
>  /* Bind N TIPC services with cluster scope, then sleep. */=0A=
>  #include <linux/tipc.h>=0A=
>  #include <stdio.h>=0A=
>  #include <stdlib.h>=0A=
>  #include <sys/socket.h>=0A=
>  #include <unistd.h>=0A=
>=0A=
>  int main(int argc, char **argv)=0A=
>  {=0A=
>  	int n =3D argc > 1 ? atoi(argv[1]) : 40;=0A=
>  	for (int i =3D 0; i < n; i++) {=0A=
>  		struct sockaddr_tipc a =3D {=0A=
>  			.family =3D AF_TIPC,=0A=
>  			.addrtype =3D TIPC_SERVICE_RANGE,=0A=
>  			.scope =3D TIPC_CLUSTER_SCOPE,=0A=
>  			.addr.nameseq =3D { .type =3D 1000 + i, .lower =3D 0, .upper =3D=0A=
>0 },=0A=
>  		};=0A=
>  		int s =3D socket(AF_TIPC, SOCK_RDM, 0);=0A=
>  		if (s < 0 || bind(s, (struct sockaddr *)&a, sizeof(a))) {=0A=
>  			perror("tipc bind");=0A=
>  			return 1;=0A=
>  		}=0A=
>  	}=0A=
>  	printf("pub: bound %d cluster-scope services\n", n);=0A=
>  	fflush(stdout);=0A=
>  	pause();=0A=
>  	return 0;=0A=
>  }=0A=
>=0A=
>tipc_repro.sh:=0A=
>=0A=
>  #!/bin/sh=0A=
>  # TIPC named_distribute() overflow reproducer.=0A=
>  # Needs root, CONFIG_TIPC=3Dy, CONFIG_TIPC_CRYPTO=3Dy (default), KASAN=
=0A=
>recommended.=0A=
>  # Usage: ./tipc_repro.sh [peer_mtu]   (default 100; 100..131 trigger it)=
=0A=
>  PEER_MTU=3D${1:-100}=0A=
>=0A=
>  ip netns add A=0A=
>  ip netns add B=0A=
>  ip link add va type veth peer name vb=0A=
>  ip link set va netns A=0A=
>  ip link set vb netns B=0A=
>  ip -n A link set lo up=0A=
>  ip -n B link set lo up=0A=
>  ip -n A link set va mtu 1500 up=0A=
>  ip -n B link set vb mtu "$PEER_MTU" up=0A=
>=0A=
>  # node A: 40 cluster-scope publications (any number >=3D 1 overflows;=0A=
>  # more publications write further past the buffer)=0A=
>  ip netns exec A ./pub 40 &=0A=
>  sleep 2=0A=
>=0A=
>  # node A uses MTU 1500, node B uses PEER_MTU; the link MTU is=0A=
>  # negotiated down to PEER_MTU, the link MSS becomes PEER_MTU - 72=0A=
>  ip netns exec A tipc bearer enable media eth dev va=0A=
>  ip netns exec B tipc bearer enable media eth dev vb=0A=
>=0A=
>  # the overflow happens in tipc_named_node_up() as soon as the link=0A=
>  # comes up (a few seconds)=0A=
>  sleep 20=0A=
>  dmesg | grep -A30 -E "KASAN|BUG:|Oops"=0A=
>=0A=
>This edits the lines next to the ones touched by Yunpeng Tian's=0A=
>"tipc: bound the device MTU accepted ..." (upper bound, posted 2026-10-03)=
.=0A=
>The two are independent; I can rebase on top of it if that one is applied =
first.=0A=
>=0A=
>tipc_msg_build() / named_distribute() could also get local sanity checks; =
I kept=0A=
>this to the MTU floor so there is one fix point.=0A=
>=0A=
> net/tipc/bearer.c |  4 ++++=0A=
> net/tipc/bearer.h | 16 ++++++++++++++--=0A=
> 2 files changed, 18 insertions(+), 2 deletions(-)=0A=
>=0A=
>diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c index 05dcd2f9e..bcf031=
fdd=0A=
>100644=0A=
>--- a/net/tipc/bearer.c=0A=
>+++ b/net/tipc/bearer.c=0A=
>@@ -549,6 +549,10 @@ int tipc_bearer_min_mtu(struct net *net, u32=0A=
>bearer_id)=0A=
> 	int mtu =3D TIPC_MIN_BEARER_MTU;=0A=
> 	struct tipc_bearer *b;=0A=
>=0A=
>+#ifdef CONFIG_TIPC_CRYPTO=0A=
>+	BUILD_BUG_ON(TIPC_MIN_BEARER_MTU !=3D=0A=
>+		     MAX_H_SIZE + 2 * INT_H_SIZE + EMSG_OVERHEAD); #endif=0A=
> 	rcu_read_lock();=0A=
> 	b =3D bearer_get(net, bearer_id);=0A=
> 	if (b)=0A=
>diff --git a/net/tipc/bearer.h b/net/tipc/bearer.h index 41eac1ee0..b99dcd=
23c=0A=
>100644=0A=
>--- a/net/tipc/bearer.h=0A=
>+++ b/net/tipc/bearer.h=0A=
>@@ -60,8 +60,20 @@=0A=
> #define TIPC_MEDIA_TYPE_IB	2=0A=
> #define TIPC_MEDIA_TYPE_UDP	3=0A=
>=0A=
>-/* Minimum bearer MTU */=0A=
>-#define TIPC_MIN_BEARER_MTU	(MAX_H_SIZE + INT_H_SIZE)=0A=
>+/* Minimum bearer MTU=0A=
>+ *=0A=
>+ * The link MSS (see tipc_link_mss()) is the MTU minus a tunnel header=0A=
>+ * (INT_H_SIZE) and, with encryption, minus EMSG_OVERHEAD (32 bytes,=0A=
>+checked=0A=
>+ * in tipc_bearer_min_mtu()).  The MSS must still hold a fragment=0A=
>+header=0A=
>+ * (INT_H_SIZE) followed by the largest message header (MAX_H_SIZE),=0A=
>+which is=0A=
>+ * what tipc_msg_build() puts in the first fragment, and leaves room=0A=
>+for at=0A=
>+ * least one name table item in named_distribute().=0A=
>+ */=0A=
>+#ifdef CONFIG_TIPC_CRYPTO=0A=
>+#define TIPC_MIN_BEARER_MTU	(MAX_H_SIZE + 2 * INT_H_SIZE + 32)=0A=
=0A=
This approach is not good because  it uses hard-coded size of TIPC crypto h=
eader (32).=0A=
The size should be calculated based on tipc_ehdr.=0A=
Could you please test below general approach ?=0A=
=0A=
---=0A=
 net/tipc/bearer.c    | 16 ++++++++++++++++=0A=
 net/tipc/bearer.h    |  2 +-=0A=
 net/tipc/crypto.h    | 19 +++++++++++++++++++=0A=
 net/tipc/udp_media.h | 10 ++++++++--=0A=
 4 files changed, 44 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c=0A=
index 05dcd2f9e887..02b2e9f56cc5 100644=0A=
--- a/net/tipc/bearer.c=0A=
+++ b/net/tipc/bearer.c=0A=
@@ -433,7 +433,11 @@ int tipc_enable_l2_media(struct net *net, struct tipc_=
bearer *b,=0A=
        dev =3D dev_get_by_name(net, dev_name);=0A=
        if (!dev)=0A=
                return -ENODEV;=0A=
+#ifdef CONFIG_TIPC_CRYPTO=0A=
+       if (tipc_mtu_bad_crypto(dev)) {=0A=
+#else=0A=
        if (tipc_mtu_bad(dev)) {=0A=
+#endif=0A=
                dev_put(dev);=0A=
                return -EINVAL;=0A=
        }=0A=
@@ -546,7 +550,11 @@ int tipc_bearer_mtu(struct net *net, u32 bearer_id)=0A=
=0A=
 int tipc_bearer_min_mtu(struct net *net, u32 bearer_id)=0A=
 {=0A=
+#ifdef CONFIG_TIPC_CRYPTO=0A=
+       int mtu =3D TIPC_MIN_BEARER_MTU_CRYPTO;=0A=
+#else=0A=
        int mtu =3D TIPC_MIN_BEARER_MTU;=0A=
+#endif=0A=
        struct tipc_bearer *b;=0A=
=0A=
        rcu_read_lock();=0A=
@@ -711,7 +719,11 @@ static int tipc_l2_device_event(struct notifier_block =
*nb, unsigned long evt,=0A=
                test_and_set_bit_lock(0, &b->up);=0A=
                break;=0A=
        case NETDEV_CHANGEMTU:=0A=
+#ifdef CONFIG_TIPC_CRYPTO=0A=
+               if (tipc_mtu_bad_crypto(dev)) {=0A=
+#else=0A=
                if (tipc_mtu_bad(dev)) {=0A=
+#endif=0A=
                        bearer_disable(net, b);=0A=
                        break;=0A=
                }=0A=
@@ -1158,7 +1170,11 @@ int __tipc_nl_bearer_set(struct sk_buff *skb, struct=
 genl_info *info)=0A=
                        }=0A=
 #ifdef CONFIG_TIPC_MEDIA_UDP=0A=
                        if (nla_get_u32(props[TIPC_NLA_PROP_MTU]) <=0A=
+#ifdef CONFIG_TIPC_CRYPTO=0A=
+                           b->encap_hlen + TIPC_MIN_BEARER_MTU_CRYPTO) {=
=0A=
+#else=0A=
                            b->encap_hlen + TIPC_MIN_BEARER_MTU) {=0A=
+#endif=0A=
                                NL_SET_ERR_MSG(info->extack,=0A=
                                               "MTU value is out-of-range")=
;=0A=
                                return -EINVAL;=0A=
diff --git a/net/tipc/bearer.h b/net/tipc/bearer.h=0A=
index 41eac1ee0c09..1bf629f2e626 100644=0A=
--- a/net/tipc/bearer.h=0A=
+++ b/net/tipc/bearer.h=0A=
@@ -61,7 +61,7 @@=0A=
 #define TIPC_MEDIA_TYPE_UDP    3=0A=
=0A=
 /* Minimum bearer MTU */=0A=
-#define TIPC_MIN_BEARER_MTU    (MAX_H_SIZE + INT_H_SIZE)=0A=
+#define TIPC_MIN_BEARER_MTU    (MAX_H_SIZE + 2 * INT_H_SIZE)=0A=
=0A=
 /* Identifiers for distinguishing between broadcast/multicast and replicas=
t=0A=
  */=0A=
diff --git a/net/tipc/crypto.h b/net/tipc/crypto.h=0A=
index ce7d4cc8a9e0..1d5a4839d639 100644=0A=
--- a/net/tipc/crypto.h=0A=
+++ b/net/tipc/crypto.h=0A=
@@ -156,6 +156,8 @@ struct tipc_ehdr {=0A=
 #define EMSG_OVERHEAD  (EHDR_SIZE + TIPC_AES_GCM_TAG_SIZE)=0A=
 } __packed;=0A=
=0A=
+#define TIPC_MIN_BEARER_MTU_CRYPTO     (TIPC_MIN_BEARER_MTU + EMSG_OVERHEA=
D)=0A=
+=0A=
 int tipc_crypto_start(struct tipc_crypto **crypto, struct net *net,=0A=
                      struct tipc_node *node);=0A=
 void tipc_crypto_stop(struct tipc_crypto **crypto);=0A=
@@ -196,5 +198,22 @@ static inline void msg_set_key_mode(struct tipc_msg *m=
, u32 mode)=0A=
        msg_set_bits(m, 4, 0, 0xf, mode);=0A=
 }=0A=
=0A=
+/**=0A=
+ * tipc_mtu_bad_crypto - check if device MTU is too low for encrypted head=
ers=0A=
+ * @dev: the net device that its MTU needs to be checked=0A=
+ *=0A=
+ * Return:=0A=
+ * * false - valid MTU=0A=
+ * * true  - invalid MTU=0A=
+ *=0A=
+ */=0A=
+static inline bool tipc_mtu_bad_crypto(struct net_device *dev)=0A=
+{=0A=
+       if (dev->mtu >=3D TIPC_MIN_BEARER_MTU_CRYPTO)=0A=
+               return false;=0A=
+       netdev_warn(dev, "MTU too low for tipc bearer\n");=0A=
+       return true;=0A=
+}=0A=
+=0A=
 #endif /* _TIPC_CRYPTO_H */=0A=
 #endif=0A=
diff --git a/net/tipc/udp_media.h b/net/tipc/udp_media.h=0A=
index e7455cc73e16..43f895bec039 100644=0A=
--- a/net/tipc/udp_media.h=0A=
+++ b/net/tipc/udp_media.h=0A=
@@ -40,6 +40,7 @@=0A=
=0A=
 #include <linux/ip.h>=0A=
 #include <linux/udp.h>=0A=
+#include "crypto.h"=0A=
=0A=
 int tipc_udp_nl_bearer_add(struct tipc_bearer *b, struct nlattr *attr);=0A=
 int tipc_udp_nl_add_bearer_data(struct tipc_nl_msg *msg, struct tipc_beare=
r *b);=0A=
@@ -48,8 +49,13 @@ int tipc_udp_nl_dump_remoteip(struct sk_buff *skb, struc=
t netlink_callback *cb);=0A=
 /* check if configured MTU is too low for tipc headers */=0A=
 static inline bool tipc_udp_mtu_bad(u32 mtu)=0A=
 {=0A=
-       if (mtu >=3D (TIPC_MIN_BEARER_MTU + sizeof(struct iphdr) +=0A=
-           sizeof(struct udphdr)))=0A=
+#ifdef CONFIG_TIPC_CRYPTO=0A=
+       int mtu_min =3D TIPC_MIN_BEARER_MTU_CRYPTO;=0A=
+#else=0A=
+       int mtu_min =3D TIPC_MIN_BEARER_MTU;=0A=
+#endif=0A=
+=0A=
+       if (mtu >=3D (mtu_min + sizeof(struct iphdr) + sizeof(struct udphdr=
)))=0A=
                return false;=0A=
=0A=
        pr_warn("MTU too low for tipc bearer\n");=0A=
