Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013046.outbound.protection.outlook.com [40.107.159.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23553876B3;
	Tue, 22 Sep 2026 02:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043660; cv=fail; b=I4GdnQa1CDCLlzDlBjS4AAXXkxIBJhNH22/nosmycscf0d2IFaY35iu84memT+yged/s3XVV/TBHF9sL1Gzc+gpXbu15eLyHyJIHH763BmsPJBoD2JQK94v2MHyHtwOdnWxstDZ47oiPyA59zJ6VAknygbZMnY0ay5yXAs7lWok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043660; c=relaxed/simple;
	bh=xVDczIzU6JgC4+81uaRKKDPYVhGoHpFH/91TpM6NBY4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NijUblbt06QEqLaUt7fW9ZL/j/ZIHAtUyECUtCTbG9nyixaXza4QrhBYI+RD8uje5sESGobsKbr07xigv8M/rgv01aNqyCKI3v3ikrmbWCqY7PlYhQ69SBMp/O2Z1UkhxHRhup1CB72Go/VTCPy/eZQfk2K4wQab2hJsY2lKwVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=0JjcrXoe; arc=fail smtp.client-ip=40.107.159.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="0JjcrXoe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FO2wKDR6HlA/cVx+/SguWIQOCeUsd+1lLlAwKa5xg1YEY+sZuEEuSw3JuvNLFfsw7G4EBwMmjJKNnEzqnj0/0LBM7MunymTLVXU3Cnm043U/ONmi/RYpl+DzNOonlvPwkluTQL4fgBZ4cote38IFDb0C8ldiPqXOCsUiWAx67h8qsVNuf5GNg5jJDC9ScyeNN/rB+U8PvVSE57wL9ZrggfphOHEjE+N09odFgVvUaaAFD30AmNuN91st0lGzTr3LTFrtXFih5/lguKy/4ajdZC7ToQXCRnD9ghUnd2D39BDhW5yrhCUvvEJQzQo+4Q03BW4iszUvIqgSOr/3ediGsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06MHhGIQNcXT1dT3Ag5L/EVwgHhIunOFkyhhakJy/TI=;
 b=mgODtMCS7jb7shKVNdWmI58L1B4xlExSBVLga61NRn8tEucT2rqbLWg+59UUCagR+HuC9joapyxOOjNsGK1r7qSuXuFYwjtysRq+y0epUoK2qx11G2LpVZiwDAbbBGE+Sl7btmdrV/K2MTzCkBPH80WCJyuSuJAQC03rdBKwj9RLWP6DGFnLl7XCsqM4xgyYuf5OKchF2+iTjtpJqnVIEqyp2VJL8pdAa3l3zbG3IPVYQD/USWjGXRx9GDGe/YAi1XW6x0uwNaYzlfvWh7imKei5pNg6Z2+hffZ3ophVgrrezkmD5kYDtim1v5RNijNN/j/PIXzwoSsLXpxFqeZrkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06MHhGIQNcXT1dT3Ag5L/EVwgHhIunOFkyhhakJy/TI=;
 b=0JjcrXoeh7Hbv7h41YCwwVIUgYsLRLVMyGbNGnXJIpNmiwFNcOBcTgDC9B65R37abheJon9j4jxZ4oChxxLsFncmoXhtpjP3TqTCd+JMsgyD6xP4EEDKZ2kNLN1Dm4A6R2CU1TS0B3GABcFS7nN7nz4I12+sQJqeDrmHuZqK3OjYFautBwzE7O2gGQ/iXY5DTgyhJO9fPlJgvyPymyzmHhJl9PJtnwG08tZMLHu70ebqDLdqbzHykt0Q5npenWqVJjQQSbRJYvUmLq0mBjUc1aECtzzyKwjjQ3xw+4FZBTLawuR0/le7u6spOme9SBzIdcaIsxw8aE85TJ8RuAKYug==
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:617::19)
 by PA1P189MB3444.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:4f8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 02:20:54 +0000
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3]) by DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3%3]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 02:20:53 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Hui Peng <benquike@gmail.com>
CC: "horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jmaloy@redhat.com" <jmaloy@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH] tipc: fix TLV out-of-bounds read in
 tipc_nl_compat_net_set() and depth mask
Thread-Topic: [PATCH] tipc: fix TLV out-of-bounds read in
 tipc_nl_compat_net_set() and depth mask
Thread-Index: AQHdSH3leO462zoEXkGK3HvZ8Se617bZ3jxQ
Date: Tue, 22 Sep 2026 02:20:53 +0000
Message-ID:
 <DU4P189MB375095D0EF3A2FBE9626DE94C6832@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References: <20260919212857.3241483-1-benquike@gmail.com>
In-Reply-To: <20260919212857.3241483-1-benquike@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4P189MB3750:EE_|PA1P189MB3444:EE_
x-ms-office365-filtering-correlation-id: 32744fa4-1d45-44c3-fba4-08df185020f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|6133799003|22082099003|18002099003|38070700021|56012099006|11063799006|10067099003;
x-microsoft-antispam-message-info:
 VVShK/r2dr7IRDAbCE8Sy8/nOVRD1U450Z+jDIFDU+o/0D6PixQDDSsTK7JSC9KXRmizsGCrALZiSwFPUt/cMZm6Xn/p3MNbi5O5EbH5WQ1gcBKUflPx3KA+PhduEmoRASylD8JBygtJrUgwQbfw2eRX1AYFieC4fR426i1fOrFL4wP/xgnowdrPoCHYitG/KmRdCLsvC7RzW5bhkmNEZTw9SknGWTKUBf+E1kn34kaeWQmIiy8H4HajgyuuYPP5KNdesBpfcK9Vrp9p9yahfCilvpA+d1FH3E7gMnle22qe1GuIbZAf4ywfYlshOsq/B9hvfpf3b/HhEZ3I++7Wa3envbmWlj80w6ZRqhx2/0UeFxH0rNHtpL3Se8ZJLEwHBbxId/kNJIkp2dbm4QaP8GHHHPn+KBXflsBu/vy0BUuTLpBznDrxPXnoIr17u0sr0FYV+bAL4QsJPOZgg05p7JK14U2BEofX8GRl1rNxZ5mU/otw6IOBkKybRBcJTR8LgZ8htL4E91B6gMuPP5yTZDniIPzwOJ62Bz7jE23MCQnlwyaKgYo/1viECFSjbf26kMB9juceQT470azpELSw6aTkUtIww+av+jiU5NGH6wFoQluDumU2VxGNqfSZhxDL23mQrR4M0/SNcDRNU5TFH/Jj0gcS+fjbRDQPmOLtKRp/Ol8wb/lSE5Z4Hs7LHyTE4hU3EmL5BqiygXioU9hmw5Ulz4gCcrJA6HhPUD4KN/A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4P189MB3750.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TId3BkLXu0eDED7VJINWrUbRNXZHSzgsstDQhqmxUMZvzzQRA8rGLmyeLAGW?=
 =?us-ascii?Q?u4pUri+TteiTUOhARFWqA1cpIGdO80olpyQLKWKg0AfMMl3Ke9T+o2k4Sp0y?=
 =?us-ascii?Q?HMXlMegJNeGfuPew5xo26tuHl8lwW6RaoQ+lSf6cShYjKisFwdzu5rmT4Lv5?=
 =?us-ascii?Q?ih47IlMCcQYpn5akzHMOK8dyRdfG0Lo8D1SI52Fg70klx6ib+4cz8kNStx9T?=
 =?us-ascii?Q?Ywb8FBuP7gXKMSGh6cVQuot/Q+HedAjm7CU010B6E/dgsQBVWD/s94JXC1mW?=
 =?us-ascii?Q?3dXiIL7C0LdRhmCEAnX2577xFSAcJBW0W4Ml2lLFA01bsFSN6PkVAlr7MkGt?=
 =?us-ascii?Q?/3KisozD5FwGRASbQhCAsFMXnUwXHnEe2MbdHRDd5AFAsZssqLx8PMfoqcuT?=
 =?us-ascii?Q?4w9CcCnssa4uj/+DyuMC4WwKmEgIZv6PD/WwFOkVGL7jHZ54tmUpDCsvm11Q?=
 =?us-ascii?Q?AEwpMrnCfjav/d8wk0Ugz9txXuIQ9nz16m7Fm2y3+5XBHt5vGUyJfHbx9WeO?=
 =?us-ascii?Q?5MrIPA/gntzwIi0xIWo15UHUMEAOWFTq4Ox1RRvfOI5uVGZP13AV+kNKCopm?=
 =?us-ascii?Q?4HdrSg6kTuF6V0OunFAj8K+iRJa1xfGzC9Es2BhwaQepBgPc4yKstIYx158l?=
 =?us-ascii?Q?1jwgLRH1X0zQbi85O3heEVI4AXpp/Ik7L8qV6GpFEQoftL2UMOIXt8lLSSrt?=
 =?us-ascii?Q?/YpOg3utpp3dTsukbTopc555sWiVjUYDKjNl6h2k+NK4WoRYL73HbBY0nDGR?=
 =?us-ascii?Q?IRhY7SZ/3UZJPIc5tLgLJrvycdvpMk2cFv69ie6/2/+OdEKvSM964bDmjMHq?=
 =?us-ascii?Q?MfDUYA+S/Vz7lUjc/1rp6+DMv68CsdJHzIAISovV+K74cFTCT1c7nn4Hg48y?=
 =?us-ascii?Q?+nLBxU8VIB8WQ+9LqVaaMewQ80y3eDKoLgPPSamzkQBOBVKlXFTc6F88iCj4?=
 =?us-ascii?Q?V6zIwHoD6QlPs+KxrBWlyhqy26mPFMLxA9ICPC0m/aeLBbB7NxB7U3KvZa0m?=
 =?us-ascii?Q?cBjyvNwjACisF8OS+/fCMgfYNKExjEjzai3huUnhhfS1Bg9RpzoQAUITCoyU?=
 =?us-ascii?Q?+T+accEk88r8+zTddanrwey+bYn8jWevfMxabCU7lncRMO5r9oPx7XxDbOaI?=
 =?us-ascii?Q?8sHySVjqsLMVV6K0nz5LSaSmlP3UJhCu++vko8ONF/Uxo6FUZ0H9mMNzBF9v?=
 =?us-ascii?Q?v3qSX28fAe+DtLSZCjbBxBowmSBWSw03Wm1gdUYlA7iDpnkjC/FgjH/Y+MtH?=
 =?us-ascii?Q?irtllHGicYENhtXYY3WweMnJFvBRl6tLRaeP98XCMX/MB1L6JgkVFif3+khE?=
 =?us-ascii?Q?189XzYQ+1C9pDIkJazHKBwMQVToqR6w1MuCxCdbtQ1YASY6UnQ/Q++g2iSJg?=
 =?us-ascii?Q?FjbMHRX+3mm7759kv23XF6Whmb+N0rRbIylejh4xpzBmVn01z1Q8OLj9ekYt?=
 =?us-ascii?Q?iq+Hay1MzX+GyXb0G7HfJ84SFAkhcAy/Yi1rsM3LhTJuJsIj1xVJQCAeMRPC?=
 =?us-ascii?Q?+XxZsW9zuuc3lxzP1olpqleEyLEZIZKLl1uQ8E/A6r901RKgzFDZ4mSfCKds?=
 =?us-ascii?Q?O1T38DkJCsKtrIQ6SWpsckFFhV1hniRJN/IyraZbk+YJWp8rkXe0FXY+Kf5p?=
 =?us-ascii?Q?Mm4pMldOvYIOeoqpR9xkx6ahcgownEahRQHyycz16k25Hntm2mB0rK1WN7DW?=
 =?us-ascii?Q?yoygcNwh6LQOxq9Q/mlbrtpJOht/aAGdpPd6cCrNIFYSqOmfOHf6J/L8S8DB?=
 =?us-ascii?Q?eNpxJbbhDw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 32744fa4-1d45-44c3-fba4-08df185020f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 02:20:53.8889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6n9AkRMrODLQRtB/X0WGAVZ//8MwR9uH6eeCxn0Da5maFCPbq33RN0HdLbTPSkhUZsm/WaSlFzzmyIIq8bmc4Y0LrbDr98hdeuHQ3Li1M4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P189MB3444

>Subject: [PATCH] tipc: fix TLV out-of-bounds read in tipc_nl_compat_net_se=
t()
>and depth mask

This patch targets net tree, please add 'net' to the patch title: [PATCH ne=
t]

>
>Fix two validation flaws in `net/tipc/netlink_compat.c`:

Two different bugs require 2 separates patches. Please pay attention to thi=
s next time.

>
>1. `tipc_nl_compat_net_set()` (`TIPC_CMD_SET_NETID` /
>   `TIPC_CMD_SET_NODE_ADDR`) unconditionally dereferences `*(__be32
>   *)TLV_DATA(msg->req)` without verifying that
>   `TLV_GET_DATA_LEN(msg->req) >=3D sizeof(__be32)` (4 bytes), reading 4
>   bytes past the end of a 0-byte TLV payload (`tlv_len =3D=3D 4`).
>2. In `tipc_nl_compat_name_table_dump_header()` and
>   `tipc_nl_compat_name_table_dump()`, `ntq->depth` can contain the high
>   flag bit `TIPC_NTQ_ALLTYPES` (`0x80000000`).
>   `tipc_nl_compat_name_table_dump_header()` compares `depth > 4`
>   without masking off `TIPC_NTQ_ALLTYPES` first (always clamping
>   `depth` to 4 whenever `TIPC_NTQ_ALLTYPES` is set, even if the low
>   depth bits are `1`), and `tipc_nl_compat_name_table_dump()` checks
>   `depth > 1` and `depth > 2` with `TIPC_NTQ_ALLTYPES` still set in
>   `depth`. Mask off `TIPC_NTQ_ALLTYPES` after testing it.
>
>Fixes: d7cc75d3cb6b ("tipc: convert legacy nl node addr set to nl compat")
>Fixes: 44a8ae94fd55 ("tipc: convert legacy nl name table dump to nl compat=
")
>Assisted-by: LLM
>Signed-off-by: Hui Peng <benquike@gmail.com>
>
>---
> net/tipc/netlink_compat.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>
>diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c index
>d9a4f94ea2d4..9b2d93704e23 100644
>--- a/net/tipc/netlink_compat.c
>+++ b/net/tipc/netlink_compat.c
>@@ -881,7 +881,7 @@ static int
>tipc_nl_compat_name_table_dump_header(struct tipc_nl_compat_msg *msg)
> 	if (TLV_GET_DATA_LEN(msg->req) < (int)sizeof(struct
>tipc_name_table_query))
> 		return -EINVAL;
>
>-	depth =3D ntohl(ntq->depth);
>+	depth =3D ntohl(ntq->depth) & ~TIPC_NTQ_ALLTYPES;
>
> 	if (depth > 4)
> 		depth =3D 4;
>@@ -932,6 +932,7 @@ static int tipc_nl_compat_name_table_dump(struct
>tipc_nl_compat_msg *msg,
> 	if (!(depth & TIPC_NTQ_ALLTYPES) &&
> 	    (type !=3D nla_get_u32(publ[TIPC_NLA_PUBL_TYPE])))
> 		return 0;
>+	depth &=3D ~TIPC_NTQ_ALLTYPES;

After you mask off ' depth', the subsequent code does a bitwise operation u=
sing TIPC_NTQ_ALLTYPES:
" if (!(depth & TIPC_NTQ_ALLTYPES) &&
            (type !=3D nla_get_u32(publ[TIPC_NLA_PUBL_TYPE])))
"
Does your change break above code ?

> 	if (lowbound && (lowbound >
>nla_get_u32(publ[TIPC_NLA_PUBL_UPPER])))
> 		return 0;
> 	if (upbound && (upbound <
>nla_get_u32(publ[TIPC_NLA_PUBL_LOWER])))
>@@ -1139,6 +1140,9 @@ static int tipc_nl_compat_net_set(struct
>tipc_nl_compat_cmd_doit *cmd,
> 	u32 val;
> 	struct nlattr *net;
>
>+	if (TLV_GET_DATA_LEN(msg->req) < (int)sizeof(__be32))
>+		return -EINVAL;
>+
> 	val =3D ntohl(*(__be32 *)TLV_DATA(msg->req));
>
> 	net =3D nla_nest_start_noflag(skb, TIPC_NLA_NET);
>--
>2.55.0.1082.g2b9226bbc0-goog

