Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E377F38B15E;
	Wed, 22 Jul 2026 02:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784687188; cv=fail; b=aIscwLPSMiJOIM0LFGekz6V44DMGA9hbZX/3B+SroHWYu355ru3+RFDd80p4q6mKdkgJ8/Tp84rj1PHXX11yJsxurGCawBuFxS/8hOqVNrlIlk4/PIVacXx/bD5Nb0gNJy22Ecm0xwTvNrXTLmBFdRrE2Kogt2rv3REQjlsrJ0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784687188; c=relaxed/simple;
	bh=lzR+g02s3yOzQc72speJ7sA3iX3SqFcOFqcva6zLYM0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KzWudmlGvu1Kt3YySNUdkJxDynHSaNBlJMoLiiatREZAW6uSN5o1/EAZXMwv6SRH6QKZJLrWJ01xlbEqKaeUVKiR3PRkiMMIDuuZxOYtfrVBVoyoFsYC7Bxa7EFI6Xf+Va0H/JKoHjeONjHHKtIqcYFycMbLuz78BHlbv6DE8JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=Udvg0SZB; arc=fail smtp.client-ip=52.101.69.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="Udvg0SZB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxoJbfnmnL2J0akUN1h2b3cDo9L0p4t1UgYE4RYYLVkdN4y08UkdndzvLPj8TssbKhtDDGmU2Yps6cQ2oxTkmYP88U0tun2n3+Fu9PU6AfhUmdAdIpqxw4R4JCArmZwLak9PbCg7gH3rXSGipW7W4+j3McN+b22Tf7Fsq5brExXy5aYsUEDV+sCGv8FdyUREBI6zIrYUewwHeo+NIHGXULwNkGguiiqRl+tnV/RmYdXoniOTQXRAZoa/H8p5itKBzL9/EnTJy8nILksm9gXJEoS4a8wzh4jjOl8LrgZkCpgEMBExziEtC/sJCc0W7Fg2d8thd+OrvQqgXqyi/7wlNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dj3JYNz4aBTQnFo9CThzIAYhU3l4MHFof1sKMNE/1to=;
 b=VY5sMpjXIKGWphEZ6G/DlgO+r8KN/HKmobMnD6Fl42H9v15pRDzsU01sW4zNFq7HpvTK7aiXdzL/3n8iughJ7x/48phRLQv/4dkTodxSBhwxtEbvFbvyuYCNM5/aRLPTH2nGNlXvHMD1bScxKW1dsdGLCUnrgHVIFssRDAf6TwkLJXgwbDvFjASk6IY3kilWgJmj6jSWiGOE8nmpzQiXHx0NBgbys1yDiE7PAqO7nEO/Zf03+EckB4jo/pSSpCHM+hc5WK06nySW3YwtnMcGxEWNmwdeZF9+Ra/Br9xy8Y9kV+skdnXhaCU+c8nizv79nPCaiGFxnTgybEFmVAMR+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dj3JYNz4aBTQnFo9CThzIAYhU3l4MHFof1sKMNE/1to=;
 b=Udvg0SZBDWRzhl9qPYC6A58vLSBaSSWh/+obXsCsSOXaKB7vOmVLlQTpBwVbfmXIr1gjK0CtZs0AH/X3/nXkWMGEGF6b6xTu/5QZ1hj9p0CGNN05SdwDBxKghmi7FOc2sT5o7DQXXD4cp+ANOm15L3MEnlZ6vY4X3sZjq8UQnrM3D6GbjBxVSxvyJllPVlcjIXXHX2UdXCp65xl1gLpLV6wOW29co0w/EF+/qIOUB4IWIs+6o9TMhbN9MexK5b5qfR+GZdPIYO89qt4HoA6DVE7EfSogLoF86SIHNXDNMdFV+1aLCferRYsrUz64ZrZBldQ3QpWWnGTCC42wzsjJaQ==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 DU4P189MB2720.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:55b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Wed, 22 Jul 2026 02:26:23 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 02:26:23 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "AutonomousCodeSecurity@microsoft.com"
	<AutonomousCodeSecurity@microsoft.com>, "tgopinath@linux.microsoft.com"
	<tgopinath@linux.microsoft.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"jmaloy@redhat.com" <jmaloy@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>
Subject: RE: [PATCH net] tipc: fix integer overflow in tipc_recvmsg() and
 tipc_recvstream()
Thread-Topic: [PATCH net] tipc: fix integer overflow in tipc_recvmsg() and
 tipc_recvstream()
Thread-Index: AQHdGJB+wdXOt9mQ7Em/MtQL3mmIpbZ40Tzg
Date: Wed, 22 Jul 2026 02:26:23 +0000
Message-ID:
 <GV1P189MB19881E48AFD85D1A729ACF13C6C12@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260720214103.47732-1-blbllhy@gmail.com>
In-Reply-To: <20260720214103.47732-1-blbllhy@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|DU4P189MB2720:EE_
x-ms-office365-filtering-correlation-id: 5caf0824-f67a-4bf4-afef-08dee7989fb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|22082099003|18002099003|38070700021|10067099003|11063799006|56012099006|6133799003;
x-microsoft-antispam-message-info:
 TJTTrvlPIhw7ztJ0vU+65rYT8uEcd2EU9SjJV7aWUvtymi8qyIJDKzNqVdbrO5jfMwnq/fVeAobsOHqRprmFg1/5s80eboX8RLlqkFTG/iev6gsn7o6LDGFy78d5AQRvd+KZhG9PLbmCDyD145S46LARufgpnYSvTFlnoQf8uGKHbDEQsuFzB/oL4LucwXBtU5x8l6VdG1oWiBolKpNKLspcOt0NghV3d/Lk/cdhY7z/tX3YpxYhNAxZlZnyaz0LY3cIRfAy6aYitrDPayooixYDV8nJDbltY1I3t92iv9M2YlDhQTdQleuIirvYGUXFYjblLueSbqBRLq7a3jy1g/J0SBWW+6scttMdNaucEFfFalXyobLG3HkhKI2hYKDw3KgFWHzIqaMRFKEsckGl24uDv/LVU1+6HD46J9Ib4MbgQV6LZ9snmts5gPvkc3cxcKWwzH3BwoBRCN7OCMXOCvX3DPD+7yGcUTD14B7r7SHTiALtKZVHjszwyd8SPxVCLJOWD+g+S4Cea3TAixTcWfOP5oTD0AoF2AkRBxsyHdq10bTFyGaOE8L1cGlMN6i8ZG8nBKTVVZMUwAB7jk8Cu3FvOzEDGzdmfHG8RuU+4Vqhaxh52xmSK+xqatpoRJmwDdyNhNQZz/5Yo3r6SE5JvERp6IuUB+NWlKlZlE3YVS7aWG8i3g8GprHOkdSGy9HvzRDpdYftufy+S1Jnj7TYMpmL/atEHtuAHOLDCwwITWg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(22082099003)(18002099003)(38070700021)(10067099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pw7ekm7Ai7mt+bA82jxCKX25uoT8tEgki66Sfs3gGUbTRRbvLMl9OQ6GXlJz?=
 =?us-ascii?Q?8DnqlFs2cN4hTRF1D0wY/gr6t8xu/dQr5bKWxAjK0hqJ/9iwmw2msuXnVwAe?=
 =?us-ascii?Q?rYIYoaE/uOx6vyFaznOYeCUhKlU6QX6UsQBVwZGwW0GkAXxNBdBz/yO64cG1?=
 =?us-ascii?Q?qjUqNCeTrggvRGOkLAV+x32XerNe4ckA5ICSix0z8c9YtwdF3ff448BnVsjM?=
 =?us-ascii?Q?ETjPaJ28aptwWC4sqysM99AigfNdVkILfFRF/6FxhA7+0FVDXxH60y6Yn5T6?=
 =?us-ascii?Q?RhP2svhT9a5Ql8tDnPE9SSkPq3sKZ43Buu/k+/2dYxR8ch1nzyKDPEw/PYgN?=
 =?us-ascii?Q?4woV5kK3z08dRZBCCPHal4bRAAuwXPNRpdu9YprDXijbewmnUlRj2rckfxTv?=
 =?us-ascii?Q?mUiv9hNTXiokx0bhAs6EMxifz3tzNIU2yQUeIV9QRk+LOvl2m7OdfbIc7KJ4?=
 =?us-ascii?Q?nsLST1tV4jS9Fbe6HunEj9FwxH3Hj8VReAKdKI2OFCVHgLjGPiX64hfZUm3Q?=
 =?us-ascii?Q?MK0mtKInPWjmoMaO0G92gNfHesK9ILOmdVLhqD8UeD1BbiDslWyf9Xpy+fdE?=
 =?us-ascii?Q?Gf5RqFscGJocyh5DnO5ZNuoUAfs7u36NcXTPuNIcBOMD41zohB8RL9gRFJFw?=
 =?us-ascii?Q?jqj2NUc0ognypWNZJiF3fMnkcCRSHeFQqRbrNAmfXJUaJED1h3UyhWoJ70FR?=
 =?us-ascii?Q?sEuMFaizkEq6/icS6EJL/us8vk81m0qHnDrVu+RYILfCC9UCMlbGd1RA8eGr?=
 =?us-ascii?Q?hBumBrrLk4h5xtf0sbvIwGl7T0hQC+nFp6eM8ZUGAmvtkf8CJs1wizcG5cBQ?=
 =?us-ascii?Q?1XFWZH2wNzz0OZ0xgRcQM3we/pDKsElkVf4m2lIl+cvk4N199j1T+SwmNhuA?=
 =?us-ascii?Q?tbYohXcR/kh79OHWOHcwHmrO/Dm+lmM/q8iUbF3sPbWeQ4/nv2Ygk/7e+DzE?=
 =?us-ascii?Q?W4cXp7Y+prO1AoCgmRe+rXezGAUkR+c7zwS2pTeBb1AN3bmos2rfeK6krEkK?=
 =?us-ascii?Q?wg/X6FKEC6ocOlZmzsRG9AKpGLLGaF0EeUeF22aBXSRXki8jsQ3Nk/DiuP41?=
 =?us-ascii?Q?tENJmYAeiZF9WIn6tRnyQQpr/QC4oSdY396qnbVafCpW2nwq/3pOb1zBX+qB?=
 =?us-ascii?Q?NPeC/1g5OqdIOqp7NRXdFL6xlZwb03flnE3KBz0qoOay++mta8ftmEkdp1L8?=
 =?us-ascii?Q?XoxudFNlbFi2FfqgbtbCktvjblBPxhkNkNsVpnr18L3pl16zFOjl3vubbeiR?=
 =?us-ascii?Q?1o/PBJDdV2/tpxBoOhId42Bmu/7C5PXK8u9nedDTkOp+2kjitGi1DNYurFax?=
 =?us-ascii?Q?poY7XARfeV1ix4uSzjFHcCFdStqm1UwRaoirI9qkBfgRqcKrVQQESitg2xjg?=
 =?us-ascii?Q?G9tqESJfmbna/LbSrD+Ak4MmbAjThtY9q5RTehBcRJfJYxhPsZCOrZwf1pfE?=
 =?us-ascii?Q?QQ0wOEtwtmlVl+8tALKLTzdk0Vo9qI8kbnijL7ZwA4KvVWrMsxZPoBgLM7Ek?=
 =?us-ascii?Q?PUVbC4d8qhIjop22JM20TAwKD/pH1lBZAWO8f+El4TnvPhvbpmNew8JhcZch?=
 =?us-ascii?Q?VTzc+LqE9R15PegsJtPoQ81OoybKvs0Q+UOVWaAqqvZXsSX30jExFuQqUhOS?=
 =?us-ascii?Q?fQR/L8uqDLkWV9zonrPqbjvqdcO7O0rCJQiqd87Le8Vpakw0/nV18fbu8neI?=
 =?us-ascii?Q?B7rygtc9IyWfPfWvl3V9k3++Alt3QRa1MgmSZcK5oZeernv7i/AJq8t1mQOe?=
 =?us-ascii?Q?B6g18ZqU3Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5caf0824-f67a-4bf4-afef-08dee7989fb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 02:26:23.2908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f8F+2P+njN2GwZjnhQAC2UpAUTvRaJjciBdvHGJDhlwNiGK4twleynCuirIkH0acVrc6N/ae8TkIC3zYTiLCZR/3Lx8WafnPR9BJeGDpXtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P189MB2720

>Subject: [PATCH net] tipc: fix integer overflow in tipc_recvmsg() and
>tipc_recvstream()
>
>In tipc_recvmsg(), the copy length is computed as:
>
>  copy =3D min_t(int, dlen - offset, buflen);
>
>buflen is size_t but min_t(int, ...) casts it to int. When buflen exceeds =
INT_MAX
>(e.g. 0xFFFFFFFF via io_uring provided buffers), it wraps negative, wins t=
he
>comparison, and the negative copy length propagates to simple_copy_to_iter=
()
>where int-to-size_t promotion makes it SIZE_MAX, triggering a WARN_ON.
>tipc_recvstream() has the same pattern.
>
>  Kernel panic - not syncing: kernel: panic_on_warn set ...
>  RIP: 0010:simple_copy_to_iter+0x9e/0xd0 (net/core/datagram.c:521)
>  Call Trace:
>   __skb_datagram_iter+0x123/0x8b0 (net/core/datagram.c:402)
>   skb_copy_datagram_iter+0x77/0x1a0 (net/core/datagram.c:534)
>   tipc_recvmsg+0x3d7/0xe80 (net/tipc/socket.c:1934)
>   io_recvmsg+0x47e/0xda0
>
>Fix by changing min_t(int, ...) to min_t(size_t, ...) in both functions. T=
he result is
>always <=3D (dlen - offset), which is bounded by TIPC maximum message size
>(0x1ffff bytes), so the implicit narrowing on assignment to int copy is al=
ways
>safe.
>
>Fixes: e9f8b10101c6 ("tipc: refactor function tipc_sk_recvmsg()")
>Fixes: ec8a09fbbeff ("tipc: refactor function tipc_sk_recv_stream()")
>Reported-by: AutonomousCodeSecurity@microsoft.com
>Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
>---

Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>


