Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012025.outbound.protection.outlook.com [52.101.66.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8159538F928;
	Tue, 25 Aug 2026 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652067; cv=fail; b=SldaVA0tO/eflv9jPadKLT8UlWP3lr9EebKbKYEW6wxszU/VLeC0PnbB1dAEkxncJ3HL8CnIM3/UDNCBly8EEOOlE4XngP5Suc6hG7edNeLj8lHfMiJML98anGAgXbIShUgkJbHyUUDhzmW/15OdQN33L7cDShADGovJwRtXrlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652067; c=relaxed/simple;
	bh=pV+BOs4clc+Cl/zk8WVjQAQDi5i/LiYYac893/vhf1I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aq6mgX7iUomdB3rGPBNjJ4Ayu8AwP1IsaxO6R9yxIgDQcwGyaFDozIuqmta6OsyuYM9uc8etQGBOh9z9a6dG1yKKEmdTUoS1SkLYAW/QpTfjr9x5gz/vCnp9qGgKASAWIECgJlaVTDgtuGYhgl0hNYUHSFIRyyVfnUabTTc0QH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GhX8Fjra; arc=fail smtp.client-ip=52.101.66.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GhX8Fjra"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XoxzPb7g4LKf3tVCp89qkQ7Z8+k+0Kgz9FnHsHk9smrsmJkQ9nD5W1C4YjpiXubmAxsA/JP1lprdcxGn0AW/AtBqX6xqTEQfXYifPsKIV3R7xpXxJbqqkkqs+SH5eFT5ihNDwn1JU7DvfYl9srF5qF+yLctxbT5fOoj+owII7iQyTE2hSLXcngn/A+gRrKVyz76qUaS3UfWpeBFcxkuaFLGIN73K1xS0JkrN8u0rpKqZTkF1NJtSnvBr3ky1HkJfxzuKO8SbP+0LBQVfuRDwHsjHPAq/W5p3Ay407Q4jZDEGG/0rOOxrU4UmmV+gVsNXLBWIlXieKCH37So3USOKSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pV+BOs4clc+Cl/zk8WVjQAQDi5i/LiYYac893/vhf1I=;
 b=yK4790u7mKNSr0bTouO2HLkWwj70/vIq/WCYUZSllniwi6gG4T9R8i7xWzPpkEsn0mLhJ0Oh92jENPe+1rXkPd180LkPNpn3JwafRQ8MOlwbJZ71lj77AE1TlU752fC09NkXHA2GYOL175cHJcbf/KGzT1FBlrKPembrl/mdbahOFRmGJB1QOK6ql1Xu5IFpw28oq8wkXoOQ6KpS9nLM+fOhRKIRhnnUQd7Sh06DOmgd6vSVmnx+w7VYw28k9AKkYP9i+jfMciYfSkBeAHq0nvjLLWSm+uMK0jUHIbMgFZQbmuAlM7ivAgH3hDkFh8NFXgorqdj0y5A47oUVMgXd1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pV+BOs4clc+Cl/zk8WVjQAQDi5i/LiYYac893/vhf1I=;
 b=GhX8FjraNUPhbR3UpFtjz1ygjWWZLx4MO/9SF064ZiD1YNCtd14mUXR7plgqSg3O+fA9CzfJ0RkTG+8jUvP1sWtIia32qTut0+4NDxdlWC3I95kaQ+PH9I+yEPG7t2u79424wa3CT7H3a+BkLBpfl42bxTBaRDMyY1u8TbCc/XxyBEKP3lgJ2LBrLu7dqagAA/zpAqdyj3tDDqg9pGEguTPXKfUlhmrJ0vqNzt80fjNUuARaAbQ7IJij+c/q/ObQkbYTRaPh6FdXKLuzOjrnmJcQS914VL88sBI7wvH1bCtWmUSMDXpB9PqRX63Dpr2gFxLEX5L2+UoM15Lj/DK/Kg==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by PA6PR04MB11952.eurprd04.prod.outlook.com
 (2603:10a6:102:51b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 10:01:02 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 10:01:01 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] net: fec: support RX flushing via an ethtool
 private flag
Thread-Topic: [PATCH net-next] net: fec: support RX flushing via an ethtool
 private flag
Thread-Index: AQHdNHLQr65GDBfT50mstM7NAMC4rLauiBAA
Date: Tue, 25 Aug 2026 10:01:01 +0000
Message-ID:
 <GV2PR04MB117392FB7BF503407CB115F1588AF2@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260825091908.1362677-1-alexander.sverdlin@siemens.com>
In-Reply-To: <20260825091908.1362677-1-alexander.sverdlin@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|PA6PR04MB11952:EE_
x-ms-office365-filtering-correlation-id: 8c839155-db65-4745-e918-08df028fc4cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|23010399003|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006|38070700021;
x-microsoft-antispam-message-info:
 LmTa80WF74fIMXZL634I0q5Lg3U/PvTYYv8JNpVbF+LkvkNZ5v6mEvautOG94CnZYvT1rtns9FQXVonF0FglEfA3Az5SsHEJkFi7bAU86RqLe2cBJfmeEQHeZYgEn85uh7KCo2K0bePrv6U98W/xpmLt6YWylByG0kuHA5aYI0u+M1zHBxRUPOr7VScSnWFZFc57duotxH+GjCxl+Fa3zL5nnBlIQNY8ORe4Bey/VD2Hl8fhufb5IwVi9WGkts3CdALMMAnor94k9T0p8bP4tXFbyjLZpbpcfIZ0SKICTIe4hZ5+UaNgvv26ThB11XHizRXp0alwXiZN5IPKN0cnFhflUPO5aw9ZHPZedIVMNxPQC77RMSkBrzSlv8Bnm+D/JPnMUy/J5CCKVQxqKbv/CyaWQGe7PEnVNIlSrAsG+Xx/yADD0dvaKDKbBDrs5o2dm+drXbGz3sAEmRjsB3AHn9UsuuoG1OX+P147QkC6RqTicGIvVN8Td2NUmVMG+XdzwbhlLDbrwFsmxq1/eXH0dALIhngj0F7xYqvTYrI+Epkw0gDW6bWv4fkd3DJ7UtiJkXMX8aQLVIwzJdm+B+Xq+DhLh1AABOp1Ncc23dCL8f7z7ISS8GCO3b/Skwd1q0hA0sRAAjoOl0ybdytz65l6Q0A/kP+dFKfLRwNKX9XsPCEAIPEM6xEeU3s6GVf2ywy5AsmVvjIg/9PAKBrPdn+WNLX3LCh60wS0Ksb19UGlKZo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pbTJBg6RXzO2cQGfp0YhRi6tbBOZAshOHL9j7tnpqIGk3CPA5C9zNEFiHnlH?=
 =?us-ascii?Q?xIMHxz82F/6hF6nS4wyujvJpW5pLaw1TEpMhVPjQBB5PS3VfvJUMz4NmQEH7?=
 =?us-ascii?Q?7DRLuiAvKg22srxcSMgMLE0kEjTp3WkIMTEewEjmotLp0UQrnYWmnroXWIOv?=
 =?us-ascii?Q?08FgzYe2fULL8VJGEGO5rzeg05kqQDqS/k8a2gzq/OnvjqfPKw/5Et2klMHV?=
 =?us-ascii?Q?qgCgQjdksvqP2c5rL+iGwMmdGMNnkK8lQgW+SKlku6ohyQLSy5gtTIYfTgSK?=
 =?us-ascii?Q?3L09HVHoeoyzE+R9sEfpM5/IqhAbltQn9FxqpggIYivYV4RZoIhBoocVNJAC?=
 =?us-ascii?Q?1NhmSdoKG3VP07EUMKzy9gzT4qdYajb/Ycu7AjUex4Wh/COQq1YJ9DwMMtM6?=
 =?us-ascii?Q?UbVzcxlgoVfkvrh6Dk6xSVM1U/3BpJ8+WUVuZbs/4oMWcr40vA2wxZHGTeIp?=
 =?us-ascii?Q?Jnb6IX/Z5VgqRTTmzRYdvwtZVYt0PLW1JTrsM5VZ6vKrS/IP+TgZwaD6g7sc?=
 =?us-ascii?Q?uEqLsNRkxMFUKJ22YbGIcIZePCCGX0J5c9+i7GgKrsFqaPGAm3ML+JnWiWew?=
 =?us-ascii?Q?57fBC97zrnlw0402+tWcv4TcVk09Ez58kaSY58pAvSbcSOcjG1fz0jm4catL?=
 =?us-ascii?Q?+gYK/GEzBxritYNSM5nlq4cuFCFwkaqTlVsDKkDrm+t8BeURUnlyr+4xBJdb?=
 =?us-ascii?Q?xO9ZWFTQ8LIRkt5DDbnBBSdJdfKikG9eu+ukQZkCqEIZZixsDrzQhwDzodIa?=
 =?us-ascii?Q?vCHJtrNSCNGhPgcStqdespqRMJAuRoLrC2ZVnJBZ1dxYiq0Tgv/29cVIhh1I?=
 =?us-ascii?Q?j2au5XUn4x3YBvYSKckBCjKtgcZr5aEcnZgNlcKYCjGvtmYw9NlZvohqOA6p?=
 =?us-ascii?Q?880urhRSujfgjBlfjXzkS0l5Q84idGFd6A2kdNi45z6hsrSGRoib8Tr8mjmV?=
 =?us-ascii?Q?S42iOIsQPUgbrZvSrnYpa/M0+Nptf+wwBrOJXn0a8UlFxw5glY/PKuBiG/Rc?=
 =?us-ascii?Q?XQTeQinQVk6ShtKDCJmFcOvhNoLT+2h5UsqNlT22Lqc7icuOSYXJ4IrCPJoc?=
 =?us-ascii?Q?y/o5BUU+MNOAZOQ2zrTF3WdiDlCPs0GV14f/rRIc8TdF2T5ATeTh8CTTfLzA?=
 =?us-ascii?Q?yczu3TY46NoZZCluXLOIY7XM78vaxT3LLCOTD7Sx/OBQunWgX1dmAZ8+WKyo?=
 =?us-ascii?Q?sjPjSmz1aOhzo8sKavDXoNjrc/HS4DeIAFo/wkGn6ymfPe5w/vQy4jhhnErI?=
 =?us-ascii?Q?93IsbOea9lNf+iJlFqGUnaDLFZTUXFbyMwgF0Gdt/obspYgJ71ijA5/Sol1C?=
 =?us-ascii?Q?FlwPf0nOppi0KtNMRc+CrZ0hiqWejM5qy0flc/z7W5I/pur+fxiczEMsgfCH?=
 =?us-ascii?Q?o+/advbUxsGf/SPBE84k3Iuh1VCM8E/Lg6RFqcEGLBt8z4NuFQdqi/TJKO7L?=
 =?us-ascii?Q?ez6ijEaS9LjxXUGWu0knx1OBy+dtcaIkweZ4vKQ0dUQ/SrYbwCKIhKx00cUt?=
 =?us-ascii?Q?7xWR1KUTZvJdOdkZNUvQotZT3aheJXrOtA2dO6Xe2s7AfS/gK22ndihCdTRv?=
 =?us-ascii?Q?j3uOzxzwpe6RhJuV7DjYN9/N1TvhV8srSwHaABJXyiQr/iZdWQYlRwBrGbBv?=
 =?us-ascii?Q?oNKJr/3Oe2HHXW7yv0Ll6I00UAWXt2/emip3hdSqfJeIdR2TGy4qrOkB/9RC?=
 =?us-ascii?Q?jHjNVYCE+1JCVwJYwy/1862KeNz9KwQ/bEttzzHeuJlkqB3r?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c839155-db65-4745-e918-08df028fc4cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 10:01:01.5011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XYOmT10JvVEEShWk/Wwh4IYynRBTI2Lxj5DrElW+DdyIa8lf2ID4eVjz8qk5lK1KOpnTEXHwWG+nhgo9FGMugw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11952

> The FEC controller can flush the RX FIFO of an individual receive queue
> through the RX_FLUSHn bits of the FEC_QOS_SCHEME (ENET_QOS) register.
>=20
> RX flushing prevents frames in the RX FIFO from being blocked. Blocking
> can occur when the frame at the head of the RX FIFO cannot be forwarded
> because the ring it is associated with cannot accept it, i.e. when the
> ring's RxBD[EMPTY] is not set or ENET_RDARn is not set. When RX flushing
> is enabled for a ring, such a blocking frame is flushed (discarded)
> instead of stalling the FIFO and holding up the other rings.
>=20
> Expose this per-queue capability as a runtime ethtool private flag
> ("rx-flush-qN").
>=20
> Due to erratum ERR050395 (observed e.g. on i.MX8QXP), enabling RX flushin=
g
> on more than one queue at a time can lock up the receive path, so only a
> single queue may have flushing enabled.
>=20
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

net-next is closed now. Please repost when net-next reopens after Aug 31st.

