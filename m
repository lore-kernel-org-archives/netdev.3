Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013015.outbound.protection.outlook.com [52.101.83.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642BC3655E9;
	Thu,  3 Sep 2026 03:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788405871; cv=fail; b=fbYl6WjO+dlJz3ZcqpvgwwBFU/YnpHWVy8Gaga048CveyrBQNPlr1y6q8dHsm+JpfOeKd+icHt+ebm3TimWQZCxU3gWT0R71L7ICPUdjVzpDcg87mxmR1OZ5SIHZL56MLS4u2RDaaF8FhItm41KYaN4SNCBotxGdp5Sy4hQa240=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788405871; c=relaxed/simple;
	bh=Nz3xfbMUaV7OFqqpVcGS1WItZZvfqPI0FYzg8//66dU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rZPHY4uFO1QHaaJs73345sdgAqhpNQmOr9dzenEkWOPP/nQWLehVw98HExCAZnxr6ca80YKQEIggvhHTBQOvwy0VmuJQK1+PDwZiq+UEGupo/oxNnCDm4QXc8CXkw9IbZTBpUwVpID1X693c7IvULVy9XIXsXp2V5r69FNhr0gI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OISkjT7S; arc=fail smtp.client-ip=52.101.83.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OISkjT7S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8U+hK/L3hqDKqTzT4Ai6vdTlewKXDaPDmU9b8aZ/WsUqP6wn+NB4CEdm+sCrvy4Ke5jRQvK8w2EX+XoYdmHedRKWNpwdu4JOvpWezwNxq4hlV4CaHQ4ByYOxe6yztkbnnMO0YEK49PKq8Im/DxPj2gWTqvT9QV+DwQse5jd5TGtrUop7jpWqUOAphTDIZpgYPkp9zxpO/CDxAEMdhtvkMNUS3ul6bT7wSBoJ4k+TC/FRCpjd8HVx2LiFKIbx+ONXjDRN6CpThJINNc54KC3j8/kD0dMUQtFuPEq2e/0t7HER4dwD4xBto7y417ZckAi5qbgxfq8yfMTRCpgUaik3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nz3xfbMUaV7OFqqpVcGS1WItZZvfqPI0FYzg8//66dU=;
 b=R4Lab1hBz2QuHNQoc6asymRhrb5w13Lnh8V7bcHEGmx2JEG950Jd+l6vaued/M0EB9VZgwG15JdotpZD8gNwMKgugY7wu0k6lPHlK7nesAh4L+XNY0w/qWVU8bu86pcGzd1WHLckkQLZmj01qjll7QFG3bOMfwGQF6q53A9clh7PDXKNBTucZo2Km6PaRAS+34XHRwtYadBduhA3nVsidgbVKefYZkQ6tW26ekauxe2pcIM+bSCTZTY4V88zEMUJceGNWdPlfJR+oADJzjPad2L7Gewn3md+HEPlPAwSYgI2j2pDOZSKq/DYNjeKx/LHfg5muLPW4RuoI9m+0jucnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nz3xfbMUaV7OFqqpVcGS1WItZZvfqPI0FYzg8//66dU=;
 b=OISkjT7SyVtFFMlqJi+bDnEG1AJ8Wtcr4qrKr2h2wzXZ00SdpFJfZDz5TEUkCAVcwZzvGWK1eEHlUfY+VAHb4TxS6t+OHef7inU/xTMoZ/eonYc4+wwJ88Z40qWb5dWwzKuqClEZmE55Xp2/6jRF31M4tXNvCX3SM9fTQvWQbvDShg1LzD4m3P4IpCE95JBtTyAPOGnkMmcvU4KzH9BNBvpHcYBnc0S3rrDUELkFraVEXFB+/Yw1j3zSFMxdxVmruM2OYtShCHwSnt769L+/t4tNYnE8xFHf6V+5MhJcmiP+ypC8F2RbYyu/QvhdgAAWcTa/HHnTIVTZ/AODysOCVQ==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by GV4PR04MB11776.eurprd04.prod.outlook.com
 (2603:10a6:150:2d7::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 03:24:25 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 03:24:25 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: Jakub Kicinski <kuba@kernel.org>, "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com" <olteanv@gmail.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, Wei Fang <wei.fang@nxp.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 00/15] net: enetc: SR-IOV improvements and
 ENETC v4 VF support
Thread-Topic: [PATCH v3 net-next 00/15] net: enetc: SR-IOV improvements and
 ENETC v4 VF support
Thread-Index: AQHdOPfweXM7sOZf+ke0Lrbimycunra8LZ+AgAAH3UA=
Date: Thu, 3 Sep 2026 03:24:24 +0000
Message-ID:
 <GV2PR04MB11739E1618294F313E989A7ED88B62@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260831025441.635045-1-wei.fang@oss.nxp.com>
 <20260902195613.1e18b44c@kernel.org>
In-Reply-To: <20260902195613.1e18b44c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|GV4PR04MB11776:EE_
x-ms-office365-filtering-correlation-id: c2cbbdef-9b28-47aa-42ba-08df096adaa6
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|1800799024|366016|19092799006|376014|22082099003|18002099003|56012099006|38070700021|6133799003|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info:
 9pFzJa7vgMX6mtGzMsf0y9gK8FoXMvm0pfGeoKNytRUrn6Ko1raZDXSi6frnVDwAUs1RRKPuSbcJmVc2PBJJWuQMkExsHrllwvdN6QR/KgcPJU5K2LAVixB4y+QFtF8AehdyC6vYdY5Nb1QHztn1IuZrFYUAnITmfE8l524MzYQ5hqZTnRWUDWMd0oe9ZvSYYvnGeElM1rZORJRCkPH30MuM6+xtxAHEwvc19Pu9sDQOVy/FlfU0ECnQ3InKO11ZPlhTLSAEtBjb+E17iB3S/T0xL5QatomtwVyhGRHfe7jqCcHgWi1L8Htjp0kmRQmDFptGMY0xOCSnGNsf2Tf7xNGPs6LofkngAkUM6VRJHtLljQAoqywbsoTSdSU92pA0wjB61lE63SnNYvg2HY84KLVRspviSP3xt4W/lqa2lcia+tQpEKtSsW7q0QgG1c7GQ6j6rybdcTrpmDm7lY9Y9H+zFYCa+psM36tducoQgWn2IL4xu/AGQPwbJRQjhkh731E73yRaNRUuYjmJjCd2Sq7axldf5nbF71mXFblyXoJboAUN4RJkAY+JCzWEmbOxzv30NO5I4scyMFjn0m4Bll8Wm2Ei9hIWbMnaahKSyCb1V1JCPdCAe/pZoJKLJA8IK12NppRoEGrWMm9Ldy5Z1CLobaC4xsV6dq2IssQyyeo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(19092799006)(376014)(22082099003)(18002099003)(56012099006)(38070700021)(6133799003)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?s6k9wxKnDfsodghKDJ0emqPkSTrF7b3QCTlPCMIasu23p6kunU5fNA07izFe?=
 =?us-ascii?Q?jTbkMF55cQgc4+gfKjFOyWPCfK4t06OgxTUPJ/hX53WbF0eX8irnVs/+/ql4?=
 =?us-ascii?Q?be927GhzoZu5F2z3tryPQ2l5xu5P9E+IdULGTrDxSuHySTeGYU9LI7HkKyux?=
 =?us-ascii?Q?o2tLyYjqvn9bNDRY2pppA1UgsjcHBsTB84UHqICJcMzczhNn9ElHIhBkfLEy?=
 =?us-ascii?Q?ZWNgSbxgRfkqv+MxUckBCehp/dR9xuPoWArUTftUdK5aGhLDXHlMcJGdPTUD?=
 =?us-ascii?Q?6K98XLmNWCAgtmfTy42gvASOhM7xYiPVCYaU56h25ItFr+JZ5hDDTWtBUelS?=
 =?us-ascii?Q?fsl3kQ2mLywT1pxZ34ZxtE5125exKUAdEVKvUmryAT6x5LME+SaRkGoOE2rK?=
 =?us-ascii?Q?qJYNXtg8y1MNAHmY+ivow28ij5u/7IGTnp01IVHwG/50wDBd9Zikm83Xwtdn?=
 =?us-ascii?Q?kkc0AI/nrl7GQngLvpLKPl1KTDfF0inoTSdc5jsWWc8JSQPTrmFgL7HPve8O?=
 =?us-ascii?Q?rs1Wq0YvXvJ95SrA4qUIJv5GQYdhb0nr53R1pkzAV1pK3dKkeTTFeqYqlpPq?=
 =?us-ascii?Q?4HT8egakv0Q8OTY0CJUl/TLYm6FIVQnbspZNGX0W6O0m9iOz4ihNzUhqZSB/?=
 =?us-ascii?Q?Y4udGMl6SQihl6dZVDwjk5sCTbKw8PWENHqAgnGQiRWSFGLyz3QXQpmBjiAL?=
 =?us-ascii?Q?MhvLv1i9zk+1BH32lhEx0KT5WJ+szdoMTtwVJFsHHcoCCO/IvtW4PsxfwrNg?=
 =?us-ascii?Q?8LBHUns6I2y99QkeOxlAdxzYRWVTfr38nx4i75K3sO7ekRxB0hxZjIUPmM+U?=
 =?us-ascii?Q?Ya6rb1eWunU7hQ/XMaL7EeaCLCXojtp7apJ9uYrWBcPHZfamI3eNRzKk5NmN?=
 =?us-ascii?Q?cdybfvhCU5739M7P+69EsrgG1VXOxq5iHiVr5JyeN1luHuihxYVoM652X5YU?=
 =?us-ascii?Q?gQRmskQiKKyKW2bmvxr5gMY+a6wqdwl9MSpYkprNUf/QS4zDdGrOj596+Snv?=
 =?us-ascii?Q?VubFvcV9l6ezwXDmbJLFjWTH4kGMZDWdesFYUxVe8zgNEYXhrnUqKOL47fkV?=
 =?us-ascii?Q?eIlUchBJ4673bYKkDGBuXu8VCcSUNCixiWa3nJPpQGcw/csnyEbZMWCkvulK?=
 =?us-ascii?Q?3pgdmvTQAzOsIoPkZ7+tc17j2sLpmw5iBKJGeEtUtkMOOCxufFceCQ60HcZB?=
 =?us-ascii?Q?GzodDBmFUQrJXkccRoyh8k9pY2eyHKoGu9b7elblETVwpqW3DK5V1J/lFBNV?=
 =?us-ascii?Q?DKZwG+512s2KMJCClv//qdmdx70SCPjKpYd+tRyvn+PN1KfhKatc5pj8n+oX?=
 =?us-ascii?Q?WMjfXbhH9bwKRZPSJX3GaL1ivQ2Lx8W0L8QCiiYzNy1cMtOjzZsKROOB6xEO?=
 =?us-ascii?Q?D1AtnuT8K1ZlxWxp9HkJmKW2HjxjTJCAvh456tSTEvv2sYCFim422g1B19nc?=
 =?us-ascii?Q?8GyRj6MMHlnwQ27Bxxxj8kuDbTs2uMkQQhOx7NjUEhBe7x7K2FK9Q5AS6I/E?=
 =?us-ascii?Q?EbOunnOuEyGmnzhSnFcS75Wblsbe3T6vwjogU8xQlDOP3e2ibWZW/raaa/HY?=
 =?us-ascii?Q?O6UEkTmUuqtBHsRE+KFp+lTdZwgG2lHAEolNR5Uz//sEoI/qT91g9pAHl7p/?=
 =?us-ascii?Q?ZNaSLU0PLrDzLVzlRDmuHxBRzBmPUxy0q3InWZcDwNLtnQdkYy8zRVpBXTQQ?=
 =?us-ascii?Q?fNOvT9+Wl8i7LJjOacQQ/U0T0jADpc4dtTrFmauWLOBjIj/3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2cbbdef-9b28-47aa-42ba-08df096adaa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 03:24:24.9260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b2p699OFe9DrA8Z0qPNyGezuLNAlqGJe9H/xw3ob81eHhEUGKoHGCrfEKO6ZG0SWAwaupbBb5Q7oN4I7zN38zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11776

> On Mon, 31 Aug 2026 10:54:26 +0800 wei.fang@oss.nxp.com wrote:
> > This series enhances SR-IOV support for ENETC v1 and adds VF support
> > for ENETC v4. For ENETC v1, the trusted VF management and per-VF
> > configuration query via ndo_get_vf_config() are added. For ENETC v4,
> > preliminary VF support is introduced for i.MX94 and i.MX95 platforms.
>=20
> You only replied to some of the AI feedback, should we assume that
> feedback on patches 12/13/14 is legit and expect v4?

I have not seen any other feedback on patches 12/13/14. Except for a
pre-existing issue on patch 14, but I do not think the issue needs to be
addressed.

Sashiko review link: https://sashiko.dev/#/patchset/20260831025441.635045-1=
-wei.fang%40oss.nxp.com

