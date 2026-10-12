Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013045.outbound.protection.outlook.com [52.101.83.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918033176EE;
	Mon, 12 Oct 2026 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791790658; cv=fail; b=DD3d0l5gV2153InBl1m868KWt7QTgb/ACdb9/utb3DzX79RQFE74l0xPNb7hOjpBWv6dBiDvuOOeObGlKhaMyVRfsSgwV1NCDqdzLE7l+CFLMUIIMp04aYVP6edrN1Hc3w1PdNjvLTRbkX72/x0glJULtnjnWOhdySMoWYAfLXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791790658; c=relaxed/simple;
	bh=Z0zyVUdMwFJobvR1w69QktWnW7y0qM4Gsw0b2x2hBfI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FhsnRl3CIz1f24JMu7nWzdtPY9BnAHMuu2dL0zAMRoVJCwa8S5/skAsMpSuzKEcE3lEVHMBlJcrrVWFZUPerbHaF5djAG8nYk4xBy3b6/8rZkRgwsZCje5YmDvwLyucZ2j3LS8Fwq7XDOVQKJcDutAMAzOZi28caxiE24Q1nX6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lRweaopl; arc=fail smtp.client-ip=52.101.83.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lRweaopl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVU7ToKEARdoPgg074NdIIr1d1YJC8/Fg68olJCYV23CG/VanRyWI06MOJXl3H2GAA1xKlhGnRrIQ+eAs/EnkZwzw8DN38zhitCP1ElagedOYPzkM1DH9lqEQvFW9qx7u22+VIyeI7HaFlpACPqZDSvOz1heV3wPFsX3fGBBpR2BvqgtiR7usokRouvpvwwRloy/2TMFEHXv/i9vd9NjLyK3YYx2f3W9KXGTcXBpNrAiqIfVE8uw4sQ7gSIoYn++p2tAeOKpQpy9oO1grJmtA3J/3B+7ZWDpZE9QKswjQxQNdmAV+duQQe6K7G3dkmQZXWyGBVLkeQHCudxmziESeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jUj0hQER0KObHXE6AnoRoaJF/hq49EWT47on8zTLO8=;
 b=ExoMMySNzdLC40whMQZpcOE2gFQk/ASznbjU16/tmciH2smMFbyEpLY8yHm5smuYn0CsV+iHM7YyDJUSWW9isdVlMda6FSjqevOsrKFG2ZioNa734G553rdJ8zHX5fAdhE1rS1U5use4ShCIMrxoKiopK1AqqOMf9opTJYIeClOWZz1mcLhrlTpidk7tHqIJfvMP1vJwpa6e1+SF9BOeMjHnoGiuTCogJJbV2eGDvpgNi1su0wTIxVI5MwmfC3H4m+W3lkzIk3S5rMFlD3onzEPyP1D8qlAvjMjR41uFamsv1R9NhFix267rinsyZzqXJHAwbl99kCG+r+ZzZBthHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jUj0hQER0KObHXE6AnoRoaJF/hq49EWT47on8zTLO8=;
 b=lRweaoplKI1MFg8Y8wsUdRL7NSGb9bYZhH/xQdZQZBayl1GQRcHVeoasR1r5MjfWpCvazil3UaH4MJ5Je9whx4cj7j4uxr96Wijpz2tde56OfA5XnIyT0n2uRtlMdIbfEk6c4O5s5YDHCoSA+TB/cZW+kKOGyDAMOCn6Sx1loMdwKYZjtn65Vi64M+SMXhyogVOp2T8H5ANiwXK46YOIXNg2Vm+j/iw7HNhCE7R3hcQKFJpeqer0ZrHZwUhKHDeabrhkQRBGU7TtxRoPHOlbevpAjeiqruaqL10Lzyk6gmjGP8UOnMH8KAD4pdQBPMSyS+UWm+8sX1OrAibtyjnleg==
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 (2603:10a6:150:2cd::13) by AS8PR04MB8882.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 07:37:30 +0000
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490]) by GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 07:37:30 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: "Frank Li (OSS)" <frank.li@oss.nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-S32 <S32@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, Russell King
	<linux@armlinux.org.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH net-next v1 1/5] net: enetc: Add pseudo-MAC support for
 ENETCv4 Ports via a DT overlay
Thread-Topic: [PATCH net-next v1 1/5] net: enetc: Add pseudo-MAC support for
 ENETCv4 Ports via a DT overlay
Thread-Index: AQHdV+tnwtMEiTT12UKNwq9yC/blArb2DZSAgAN3nVA=
Date: Mon, 12 Oct 2026 07:37:30 +0000
Message-ID:
 <GV2PR04MB117404685DA7A4291E5D41AF2969F2@GV2PR04MB11740.eurprd04.prod.outlook.com>
References: <cover.1791548316.git.claudiu.manoil@nxp.com>
 <5c38f45b9ff1d73c6942d42e23940ecd9ab7b71f.1791548316.git.claudiu.manoil@nxp.com>
 <asmiQded6KfagAcZ@SMW015318>
In-Reply-To: <asmiQded6KfagAcZ@SMW015318>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11740:EE_|AS8PR04MB8882:EE_
x-ms-office365-filtering-correlation-id: 8068cd78-8cec-4601-65cc-08df2833ac44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|19092799006|366016|23010399003|1800799024|10067099003|18002099003|22082099003|38070700021|11063799006|4143699003|261009223027099003|56012099006;
x-microsoft-antispam-message-info:
 UoRNUY0DyqPx2jgKXAHYsh/2AeQGKTWetgIjwiM1hl0jjM6lhlICFJFRHda4nhdyYelbsyA7FZc85RdNyVy3j3lz0RL7Jb/5/VlS+jqcgX5gPQZSmSWVTgg8BRWNP3S87r1rb+faiFTUBQd+wuO2fvUuaawc72wz6ll1XtrBjOFSUlHyGj5W9ugq1bPoZ498WVVhTeAtTWZg+KzUiFi+5KC5vIur7z5x9pVwvfbYukg9bw20WfDQEMEsJZ5h7Em8jEI/CTm5yUGi2VOYRzHAKu7upYMOXTMupNb9juftgzoHIX/sK0LRwGeb1a6/g7SC6+QSR9H6GXgVdYnUa1m+ZW7mIqpa/5Tm+QP5oxT2gNxmDzt+7qWLlrQZ7fi0OmBVNsYbiO9c68ZawAd3Psw6jtk4IhAsyqBs/DFQCWrIvChwEAalPi52mHWfLbSCzziqyAYA3UT4PkMMJNHr4uVVctx7/CMxkept94k4XbjbJLmckkzGDXnOVqyFOKDD0vOmnkLeBy9rVNeu75S+tMmFWxk0oLyKiOxciTY2w0conHmpyXCMyuLK4otwx0pIxdYUT6GtT2LMbSk1zdrormEjCfo/EVx/tMTGkNMnqdRmpv2h00OvDP7V5hf17PUfdZFtHtL55Deb/mSxv870zh+G2+Ij3D8YntBFAzpyEh++OjiZ01M+K0OtxdhLl9Kz+84gTtIMBvN07EeAz8KiMhB4IbSLIPOmlP9e0Fte56XfxU8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(38070700021)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2JBUYaKFwZ9eJgN/XH3/zvZjLwirEgLtZ6HYvwFcr2yALdZY6ynKJzLviigd?=
 =?us-ascii?Q?HdpByirPE9TGlUD4pySiJikVOhL2oaL1n5Yhjni9DlqUKc+6Efz3UAnTzE0k?=
 =?us-ascii?Q?SApwbKnQ3sACxokfvmXjHNElbXTOqLSBjVzSzOacALHcw7TWQFSXsg6or1iZ?=
 =?us-ascii?Q?oaQ4je+/56w4IKbqFYkkpyjIaSFXLvxNWAJ+2bKHdl0VWtQAhBjLbbZVKT1d?=
 =?us-ascii?Q?bK4rsjkRkApugJp++yDb2JPrkFUnjSSoZ9NOpiD2WGQ/cdCIs2cjimZ3UEY1?=
 =?us-ascii?Q?Yt2tLviuR8C9Q1xz2msa+2PClhQ5bK0/dVhQTCo2MObNq7VuVTezTnUW+D/z?=
 =?us-ascii?Q?GusRGlkZc2+maymb9oQuBHzqkCb8HWoqLOwA2tXRQPdjrGwwQbm/qqKH6RTo?=
 =?us-ascii?Q?4yujUWfm2VSB3X318V7CQY1UkboEdDih8f2YDOYR1Oslti/Trb+veR1OIytd?=
 =?us-ascii?Q?cZS3t7DadezSmnpe2NG9V87MvLckTXU8koPYlgYtwJ1DUsZyGDM8oCV17y4c?=
 =?us-ascii?Q?oaDzM6t9n6y42cashP3F8ldkmI2v7KB/vNAfdr6YFnCloUBtRwsOfiBE4Afz?=
 =?us-ascii?Q?yxufbdXZloSub/sEQp4Xxykh2QlPgbjgQmc01reTVTHR4AemRgKa40J5toRO?=
 =?us-ascii?Q?7UBcjmHBhp1+TWpi/tDvz+4HQWgDopvdquiFRL1Y95jkhDVWKuWVLqpDBka9?=
 =?us-ascii?Q?JQIwhFsoF4rNCvOIhSFhN/s255q6yBkoLYceRw4/3syBobHMfsBp9DubbLbM?=
 =?us-ascii?Q?axzSWwab+0/5p2d9pwDtN87imnYmiFbZ6CoyeZkbhzGf8noqYHFfFUQb+eG6?=
 =?us-ascii?Q?GLdgkB/Lki2O553vp6rinVoUl8os7kt6FctH+zAL14d8JKZi/iPIQmSHlGbR?=
 =?us-ascii?Q?Egh3cjyHLJa1rUsfY90DJy4jX4AX7oGCtSn9xDb66xjDl/KrGfcznCSUMdIh?=
 =?us-ascii?Q?B6siczGNg7umeEEux0IDlKgWl1LVSecEuMiPyuSW2FFZuwlS/zmVQYEiYgLm?=
 =?us-ascii?Q?dnoBPCixB1q2l6B2IYrdFv5AWn058rilOTKpbDESPqY600VmXtH0TY2Tz+Gj?=
 =?us-ascii?Q?jMh4srxs9KbDzQSnY+3pmBVyywo0JTj4meKXBvKXNW7XWrNqvGq/ZPk4qK0b?=
 =?us-ascii?Q?rSeZ52URQNP1Py6rLoDoD6pE+cRoqwsVmWCb7jTLALvGnKBBqjE3X00z5zfG?=
 =?us-ascii?Q?XZ0FfiQ9bU0yUCMHlZ4z6ngXMgFUMhVtJL/hfPr++J6j+Sq2DXDA4T0Bh1pM?=
 =?us-ascii?Q?E7odIjws662359y6a+Ar5Q3AylKyj/FblwO33g1eiY3DMNF0zb04+CcXIW0W?=
 =?us-ascii?Q?HgYb9Ra8eY8uP1odac2GdZ7SLxwYqy/6cGXh2ynrR2mslS6kE/4KG5HEZmka?=
 =?us-ascii?Q?TMoXjIbb78ccXJ4Q1Pe0SJiiDMAoY9UHODFijwUDUJ8JjfAyiHJdbQ26qfWs?=
 =?us-ascii?Q?at93fG/YzgbpZERUN62JZfsWVCYr7Bjilu8VvNnBVPhNtY7fPL8xkjiQV2BX?=
 =?us-ascii?Q?knmN+Sl1DOVI3/Ism/KF0tXDrigLgOa3oNP/wI76/Wz8ZXH3XOQHsAaJ4pYx?=
 =?us-ascii?Q?gVshVMYelPTQl6wa0vv2qCuDoxO28HxxkAzOEld85s52p88ByiSPBtbyE48G?=
 =?us-ascii?Q?Ds38VAb74Oc2SmQdveVI3Yt1qKwUbFSxOCD2iuntE1f7WDFLLJGgk4cHxT84?=
 =?us-ascii?Q?w6kfm9AkBuetqM/xI/mbzfW7Ar79ZYgOJigh0T14hPjtMWJ0vhEvi4nJ6zM3?=
 =?us-ascii?Q?PA/clRcP2g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8068cd78-8cec-4601-65cc-08df2833ac44
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 07:37:30.8459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R7ilS0e8o9tSJAT2tanPc+ISUVBHPn2+t7Lf6gUp2apiFakXD0e1RqL0P2p1H1ZTQ7O4JS6fljg43Lk3OVhGzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8882

> From: Frank Li (OSS) <frank.li@oss.nxp.com>
> Sent: Saturday, October 10, 2026 5:26 AM
[...]
> Subject: Re: [PATCH net-next v1 1/5] net: enetc: Add pseudo-MAC support f=
or
> ENETCv4 Ports via a DT overlay
>=20
> On Fri, Oct 09, 2026 at 03:40:30PM +0300, Claudiu Manoil wrote:
> >
[...]
> >  .../freescale/enetc/enetc4_pseudo_mac.dtso    | 32 ++++++
>=20
> Not sure why need dt overlay here, there are already dymatic update dts b=
y
> of_changeset_* API, like of_changeset_create_node().
>=20

Ok, of_changeset_create_node() looks better to me too. Probably I missed th=
is
option because only one driver to date uses this function and I was focused=
 on
the lan966x approach.

The of_changeset_create_node() approach would also address the limitation
regarding the advertised/supported speed displayed by phylink (I was aware =
of)
that also Sashiko found as medium severity issue. Likely this approach will
address the other Med severity issues found on this patch too.

Thanks.
