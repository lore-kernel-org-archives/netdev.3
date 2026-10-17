Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013058.outbound.protection.outlook.com [40.107.162.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A270B1E5B70;
	Sat, 17 Oct 2026 02:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792203084; cv=fail; b=i28mopnfA85JScpqJNpU0ZA0RRqmmgOQcFp++qfQJ5ULVFRnBhA1aP7x99PihAcuheAOA6RpVPaeLCOHcXwjVnutKSwRqKAsvnr2KbM/JxnydA+dAjwQwM+863vBP5DQR56GupanMFk8BCUuuCfqeEblTdgiNgKz2Y/AmI5FfWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792203084; c=relaxed/simple;
	bh=jrS+It7gXvnCYdXARgQ10SfAHHJgDkqEy3DdqswoEoI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kcb/xy6d45t6OwRHWUQHZg32sCqMR9f3hbXp+MXrlMHEgTpUhALRzgZ2ftGlXAJHniBaDZKZatwIVpUwX8rSbaAGAF/bJm3xW/zLNcLEJF5ObWo6S3mZnJpzAz6N7YlUspHp0lQorjp0TA/v+in9/pv5sDhgOc7zcPZsdAOQrsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SsD8DWuF; arc=fail smtp.client-ip=40.107.162.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SsD8DWuF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhmoLzEBYo0Se6UPRXv6PCXJofhAcOjuw7JMXPLLI7jYaFDKGHdOfMf1MyV8v3IQ3XHCsz40DMwkXkRZThdO1PdmfaynTYESVXAo06YxuPJEHjBX+Sg114QMIi6kVozX77fpf2wF9/pa+GFPf2YXugTi4cCLGjE7L7NUgji5Ss/I70/ENgNHexoOxWKErfmU2UrvL1Ycg3wi4/Pl26yIt7tvF8VdOjdlHGn53WYetWEElK11lajH98WuUWNsxVqt8EdYF97P+wMboEtksjIjr/T7BjW7Rgg7lkch3TJ46XkLdI7THEFC+4YaQus0jMxtvEBBc596gOFyytcsDwIA8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrS+It7gXvnCYdXARgQ10SfAHHJgDkqEy3DdqswoEoI=;
 b=SaFUO3G+lsPk3mdwnjljXVAgzb6jsA3ZGRYAjWs/G5I3Qk8zd4JxD0UVHE/CBwO2LO/rAEvvuN3ktkFLExzX1L4kiyMwtl7fukcFVwDCscYVaIfyfa2YO4gHP4tJ9eM0ybpLi0r2mhgaYNPze9f+1bYEoRPVKIM03TQzg0Le/Rxa/Jf3gHxUglJmxhq88gxNi88lmtQfVjFLOERHoankeVw/HJbk9H0rF1Ra2wsoJPwcrzgzNAZz1Y48AhCFCeczcAtHh4CEWP2QR1bwatYxM0gLchClTYOkhwxNhmyIxlzqlkWSpE4tGjjKK0Cc09JmSB+1IbbmrGrvS9kQCpwnRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrS+It7gXvnCYdXARgQ10SfAHHJgDkqEy3DdqswoEoI=;
 b=SsD8DWuF+86r0zjH4ljLZ02giuFoaMDBm1YMwRi1iqnhz3JJVX+ogazFv+8Wi6yAB8pi4zePehlVhtDNRl7RKyrKuoP9cxrJZeuTP3pjSfOdzracalovP1F7cH7GB5OpGPYb7xsvYbMp1HeCA1sEHcJYTLCUIsOMKNyI1Og6R535ncy06Nxq4tPEquz57X8pwq2Vv7b1nRrIdtjyBYg3w7+90nVJrUNcK11k0tdIqPE79CWlVwhFah60gy8DQhLCFPxihX02Q6k7dTSV9unq9MDjv/ZYCPelZqCj6QrLXIiUEWgnMrLcabP8cNRCowgCFQWKj6HSaQQ7nlKQuPCYqg==
Received: from DB9PR04MB9332.eurprd04.prod.outlook.com (2603:10a6:10:36c::6)
 by PA1PR04MB10603.eurprd04.prod.outlook.com (2603:10a6:102:484::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Sat, 17 Oct
 2026 02:11:19 +0000
Received: from DB9PR04MB9332.eurprd04.prod.outlook.com
 ([fe80::75d8:3bd9:28df:cfdb]) by DB9PR04MB9332.eurprd04.prod.outlook.com
 ([fe80::75d8:3bd9:28df:cfdb%2]) with mapi id 15.21.0522.013; Sat, 17 Oct 2026
 02:11:19 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Marek Vasut <marex@nabladev.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Clark Wang <xiaoning.wang@nxp.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [net,PATCH] Revert "enetc: Increase eMDIO MDC rate to 2.5 MHz"
Thread-Topic: [net,PATCH] Revert "enetc: Increase eMDIO MDC rate to 2.5 MHz"
Thread-Index: AQHdXaBWZf4irnwCUUSD95Gx+nyXWLcA/aaQ
Date: Sat, 17 Oct 2026 02:11:19 +0000
Message-ID:
 <DB9PR04MB9332E857CCD1CD6B4650F9DB889A2@DB9PR04MB9332.eurprd04.prod.outlook.com>
References: <20261016185817.54096-1-marex@nabladev.com>
In-Reply-To: <20261016185817.54096-1-marex@nabladev.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9332:EE_|PA1PR04MB10603:EE_
x-ms-office365-filtering-correlation-id: 14b1e32d-93d5-4b9b-54e1-08df2bf3eef4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|1800799024|23010399003|366016|10067099003|22082099003|18002099003|261009223027099003|11063799006|38070700021|56012099006;
x-microsoft-antispam-message-info:
 VgB45m8kvozJhJmsDlpXoxgVgZLpOCwOEoUauE0RwYyX1+0MTqHMI5fAY6PMlIkJqrZd3wJJk1moKse6d0j11T1clQKsa4hsdRV3D1tDJ21dHF7dLVqwNXCaYhNiwc0rk3zwZ4szgu+qy5sysXLdn7EVg9o0lgqml4voDH9fqZYqha3NxT0BYxJxh2uOfTh0IBTcy5bu+rBrQ5BcVbeDDWAtpDt1ksyHKMXrau0OAasfJ2904z3ffzNb9jSGlHf3hOcz7+ubFJCGF9bOIIjHCKjvltixFgmb8bxM/9whWqjmZxCFgr4+l1u4LeaJWC+XTxA0mShlYsdhtymy3i8kBsZhmMm2C/8Q4saluXtmW73tNyODYoH8USGHfCaPCiKsUFDOqOuphZEdr6gB9sV0Wtmlhy688loWkkpBzKnhF+it707q6TvJ/XwJr9ek5zjHfAfTaLP8XVTryjKm1WTdnX0oIr6GlC93ad3TJV8tID/Q/zZGfwpLa6C6hbFSIkELbLjdRRi8nPYN8LAMXSE/vmDZDtzSSLoA4puZE2H+FUPVsPuCeyqOWZuCrez7ol+EbNBGWvwIyuniO3GY3HKdtel4eMi3906ydoafYt7V3DiBBDs/aCAJ8jh+umKejBm6LaR2h4g14QFXi+JX0RCXdRU7/L7zLHw3gZgwkmtNDYkhqqApRAMNiztVdE+pyK2W+UNAHoIn7wgFcf5Z05E4bObpsGLCIJ4lRE/ABaFWW+o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9332.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(261009223027099003)(11063799006)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/wyF0IqviGL2rBhp4qzG+THGLH0UxaMiSsNhJPmVBLEL8qFEsf4OwIDfuMaf?=
 =?us-ascii?Q?tyCUehzm6N0DGj8d3660kOdocYo9hstZ3X3T88zhuT2mjG+1RVeXfnR5PGiE?=
 =?us-ascii?Q?+4VWqjL+o4VWqGIoG6LiOnKKl0F14u/KtUMbzdotHt2c0q9sbvO4pKqemr0f?=
 =?us-ascii?Q?G9eDPJO9/tiE9ANT7i+91sm+Lo0ZtBHB4mEehaatZKLxsk7rNcVqfElAAZFN?=
 =?us-ascii?Q?b5TjL0pl/+5ZLASvad4PSgFwxn+E1AXEQxHdaHE+yING9pgp23DrZg8tHXfR?=
 =?us-ascii?Q?hYc+Ge9g68axgOWQGRbcKVOtFOXaob0kXuH8q8gz/7kArsmGX3E5rnZKwijb?=
 =?us-ascii?Q?64q9fmFqS29RjwiV16aquiqEwt50dgkvrQy8ec9wNZSHKfzk/QfiXZd0rc4T?=
 =?us-ascii?Q?7wvhQdcmnE5gawN1BrQUj5u/NoQ3mLtyuDvR+VfKzDZOHW5qsWD7WkSEZ0T1?=
 =?us-ascii?Q?kZOfPhUVTks4nMMkB+GhUI64JWS7unbk5yEXfarnZs2mAJklzPEhc5uj0udS?=
 =?us-ascii?Q?bbAFBr6IHA92++sJLVtgv2kmv4n9Eg36r0nYp6uWDdm6GR2UgN2UbSzhGY1r?=
 =?us-ascii?Q?EgFwJNBxJRUgrBLafn6fjah/paLgSu8PR4e3ZnsV58jLsHS5MtCrXnvDZMoc?=
 =?us-ascii?Q?qULI+G7n5JnYdMOsaV3Q8Z/QVXg6FfK683ExNArvHWLkBV2SzU51KDjEpkhr?=
 =?us-ascii?Q?msY/RCwU3qv1oJdeBVBMkBuGlqMib5cIND3av1oFfqW95zTIK5T3y6AeAl2O?=
 =?us-ascii?Q?XXLzl7DYdcMW2jvnxDIYSVhmaiiMJ7qMaEuzupJhPbZGYNxJdVe3Ty5vrJhb?=
 =?us-ascii?Q?imrJWB/vD1f7JLHEgV9uOpb8R3gvDL0eine681gQkqrYPiZOGBI4tw4C6VDH?=
 =?us-ascii?Q?cFH4Lobla00ZbF/fVJyc3ct7JGgAOqT5IIH51vML5RXwAP4DlM94vr4zycCq?=
 =?us-ascii?Q?U2ueGPdaWowB0SjM7X6PlvyodZq8T8wsCcIURppuf2p4z7MpY0ul1kYk5m3e?=
 =?us-ascii?Q?qovqwx4e0QZ+PtpxZ8t0NecEew90vEODGXEZPJ31lkdUvfkK3qnj4NLKYbXc?=
 =?us-ascii?Q?9XCFxa1oMrmr52MPdaDqt+g/0W2+nOA8a7pLeoSdtDlsHABKZqlsd+KkeFhn?=
 =?us-ascii?Q?0AYGRHPHHbxv/enV12m7iwvF1vrFW6X2p/Lvd/IBwBPLiht6sRPOmQEVjMmO?=
 =?us-ascii?Q?iROT8WwnwKti3SbXZnwmpnNZwdgRBLVJ1WdYwys3YlLEtQDsY+8hlytPCmQn?=
 =?us-ascii?Q?SsuRaAG0XkWwj5qS2y3SWM06e8kj+Y7foBPdZQHhhjgbdfUpD1ovLmvpUXnF?=
 =?us-ascii?Q?ee0J54NIYsuW/y24UP/MUpvwqsH81LyVJ+AXZFXfpQQBUf6K5x4Q3etX6tsE?=
 =?us-ascii?Q?0b2S1AuA/Shn2XFnNHEs7Ru56CBS9yK9JSkx+GMUXKXfV9ILhpHfV48Y19yp?=
 =?us-ascii?Q?52zGi4muix7+QcBsprHE4UCmFwG9IPNKEGeSwWQSQAiW3kZfCOvWHNY1ydyj?=
 =?us-ascii?Q?9/0AlxG8jT6oJG5hc8PFIlnIA234WHzoCgmKn8N69mWCCPChm1bjYaNUuJJA?=
 =?us-ascii?Q?zugL6JJhlKsJN94TGNY5tRKQdfzi2n7MzcOqUpZ8/w6G8lLaQ6EllvwpH5c+?=
 =?us-ascii?Q?BhqjrQ6XPzJnrhPp/KcZyDB/mQ1QpUo+QeKa424yFmV5zuO2xFuraLbNlOHw?=
 =?us-ascii?Q?8RBxH/jiI+tzsF6vYJJO8KPj6C82MQTXvK54/q+Y5lfEA1hO?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9332.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b1e32d-93d5-4b9b-54e1-08df2bf3eef4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2026 02:11:19.5764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lENt+i7zAOodMx4FEOpXaVuJOC6IDP+yHJeTJtB/anqqC11QYrq4K2k8nE+4xTTMXS0D2kKJ6eNgVRawk05jBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10603

> This reverts commit 587acb86d6465efdc03f6d8524461e6e725597b7.
>=20
> While the i.MX95 MDIO MDC clock is improved by the commit
> 587acb86d646 ("enetc: Increase eMDIO MDC rate to 2.5 MHz"),
> other SoCs use different base clock for their MDIO and the
> MDC clock on those SoCs is set out of specification by the
> aforementioned commit. The fix for the i.MX95 MDIO MDC has
> to be done differently, and will be done so in a follow up
> change. Until that is done, revert the commit to fix the
> other SoCs.
>=20
> Fixes: 587acb86d646 ("enetc: Increase eMDIO MDC rate to 2.5 MHz")

This commit only exists in the net-next tree, so the target tree
should be net-next rather than net tree.

