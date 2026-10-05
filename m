Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF21A1A9F90
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 01:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791164957; cv=fail; b=H8OI3EyhL6l9AhKCfMIFnXbczP34tFQVxat7zoFFgLBaOOIH9IlGYAASQD5Jap7y7EK7/rHLoN4dXSDpEvjGu9wY8eA4QHBZ/dWMYNvbNiFBojI61ydZEorMCV3IxV4U4BHmB3lTeWpYQ1ZDsbHRb2QVmWHlX80wegwwiGMkAiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791164957; c=relaxed/simple;
	bh=K+jE7JH8desH+xdTEnPUSepW9eGJYv1+sG83qgDrUBg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h7bg3mpZNxjQgGpuJKjKmBC4jC5J4nIrJ3os8HHLmG/yysv2uhTE6rEyTW7tSbN4XXhLoohOVHsalxTF8Ra2e+jGWfg/1f9LNQAHZN5NevDqdUHuA0/TxyKPp5lEVOQIMFOADLd6008qI+W9oO/aQ5t7TT/eK5tn8Yf72oRdq3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=ezCSXReX; arc=fail smtp.client-ip=52.101.66.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="ezCSXReX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TtP7f9cRhQ+RiPyMLZzTq5o3ocekJlg10vvdmmIW9Kp7akWZQuTM8ccpTSB7KJw+MvJ6fanMa2lzKMdxvlRmS0fdwNrZcIo6QjcR6fpQvwyBqNf71GKz6EQTTxhYHK3LadkakZbTpGoJUx0BomH+C/u8zQkngGY23FpzrBnhniOZGzvLdk2jhdJpifEpSZ9GOomy63NqEcuT9PQ1ksBG542Larl5thy7E44iMaRoPMmXaaDfQtWpESFnSGsDRldOaSZp+V+ATwydNpuaytmmsDhrVmWd24QZMV2QZfQIO13djV40kug4RefeP6E8CvT/N3klflSaaSdC2SU7IOOMNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=savEB86jSITAzd2n0a+3j+28MxoSbse/MBKYYM3WO+c=;
 b=OvTRD4zZPojWPYZETI77e0iF3cLXtSX3TWpXY9ZhT1Tz8M3yIpv/8m58UYpbxJUu7068xmpb0YFSUHcT2kgKN69r5EYm3ey13DAC/fcB4+prRR9L0MIvNdfdlLU4XHIM/PlaZvsO3Lu6TzWnolyBC/zMa574ZEFoSxTADVKiPktvQ/WzDQoX39BhTT4vi6I4OysbCxNMVqX6m/8So+l/paBAIzCVN3QTYaioBgmJ5vRccmuEHixsMPtJngDzusEOe2ADtTTMMSXzlmFLtt5bOIOGyWh45frUqtaeNT1/760axzW1ujZzNTL5nTwZlCm31vfjRD0rPQKme0sFHakA9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=savEB86jSITAzd2n0a+3j+28MxoSbse/MBKYYM3WO+c=;
 b=ezCSXReX4Z+JHNxtdIlAM4V/Aoe3fenHQhEXlVu91CA9iGfkGyRN7M8PVnBymc8aJSh2WjusYxPecUnioEG7qx/TEgWJM4u4FsxE47Rw4wZEOcdkj1yZgdOUyqHc7l1bVXjvcIfdNlYYFQwTN6/XaT0wDjH8Dx4kKJpYf19Endu3EdAsCbKhH/3r449e6KZLt0pH04oqNWcQSEhWulO+9Wgxey+Jeh2aURFWwG+1CiEl08KfFL8DPwrqsB2d95jqfTzX/IJFS8KNMPLoPmpxJcUSf90DNTS6dLhyX/ny6XjJxeLO8H146APjVrGjpsgHgajJdjDNwn0HxvrKV4KWUA==
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:617::19)
 by VI0P189MB2687.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:217::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 01:49:13 +0000
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3]) by DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3%3]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 01:49:13 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: "xiaoshoukui@gmail.com" <xiaoshoukui@gmail.com>
CC: "jmaloy@redhat.com" <jmaloy@redhat.com>, "w@1wt.eu" <w@1wt.eu>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net v2] tipc: fix memory leaks in bundle and fragment
 paths
Thread-Topic: [PATCH net v2] tipc: fix memory leaks in bundle and fragment
 paths
Thread-Index: AQHdU0HwZ7LxGX3AEUadjqvtkmyOIbbuMBcQ
Date: Mon, 5 Oct 2026 01:49:13 +0000
Message-ID:
 <DU4P189MB3750FD6F099BF5A2FFF92F05C6962@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References: <20261003141635.33711-1-xiaoshoukui@gmail.com>
In-Reply-To: <20261003141635.33711-1-xiaoshoukui@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4P189MB3750:EE_|VI0P189MB2687:EE_
x-ms-office365-filtering-correlation-id: bae86122-7db2-425d-2d9e-08df2282db54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|11063799006|56012099006|10067099003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info:
 rCDKv4hfoDWKZmn9VMRVDva0npW7ZE4WVbF0A+tRc1odSs64eVWooQKuq8VablGgsr9I/vvNDjTowB2pcOiXhV7GP82pJrQGbA4UTJY5NPHEzTa9SplHVsb3w3gjhdIjkjK6qyHiFhOKq9OAeBAD5fjSROmUe4YDmtBFAs7m//Wx1UYVKOulJilRCKjtEaVBJIxEsxc9wKoMnX1Gir/LAYfLvZS+QOyWcP5aj1WwzA7+o/CMhHJkfMHywk5O770iuL1rhWJHkpDzQRPgHliAM8SHM5FLxFXN1mHCau23M0uujqgc/ycFwQlaq5+jbD62yINjB5YSfOWnqM2bNdHpv4W4JRwkaeyUb3kyls0ibkAUEGZHJ85jomJcSL3LuiHhBxWHKxCK0qYU8nIkRZLz1WauIS4dLDw+8lJqA/KM1BRS0izZuidgXzNv4kWBX3tMUFXPsdwCrUErk0A4bGedTcUz/JCQM6/mp+wr93mS/0MJNn58U8HqWpxmXs3JBZ4LPhsSiF595Zx+z7FMVCxfMUlgOS8APkdY7X9MRJlYdmMMGQA/9Rgj1XxLSWNuQets5FWRr3JD+RTIf14uTULbjTHselj9V9P6g9O55zRr136tBXTcIAsGktKYJPx3b9cZ6L6AL3PkPagw6t6sj86VlfaPOs2/7HVptzsvl2YrZshuQDFrr2WiNexwlI68KgelWDnGEP2tlD/X1aMVbvL2l667l1Qftrrxn3sOM3EUNsA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4P189MB3750.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?N4TPo2/EQ1jxu6xPFWeinl3N+V5RVJNOHf/izrd++dmTJjYVJG2mo9WB3z0T?=
 =?us-ascii?Q?vZE465WxbpygxJX5Au5EhIFj+MkHGW4bpW4KFgXgmeduZkPrdmSaHqk27t35?=
 =?us-ascii?Q?CgkoRgCRdmsemxyMUPUeu7f9YGpRm1xcBhPSdIVumA9h2LkWHZGw2k53Kvx6?=
 =?us-ascii?Q?bkEqr1KZuht2AkyX+hRk+SO45XoC18M39oan4jcwzsyq3A494BNt6mtSFB9b?=
 =?us-ascii?Q?z8NOKFlhQQkSGvtAvKmDVxjDZ39IfHk934wdAXHYIsC6tHSc94uWqd1jOfdv?=
 =?us-ascii?Q?DtoA+Ec6AtFN0WMi3/9qPI1I79sNOYZAhHzLC3+80GMDP773iEUvvA7AaqsD?=
 =?us-ascii?Q?EKVyln/te0GKPiT5y0p1CpvPLLCO648u99b7RA1v4nmv5h1qypPSqvOsjANC?=
 =?us-ascii?Q?ogGcjNYzRne8ctNWPX96wFH/VkcvF4o24URYt35vZhtawMdLIvnxo4iBJdoq?=
 =?us-ascii?Q?gHRf820gnStcSbqpT96x+0nyLHDcB5sotfCQ2RKaCM4Yya03bAh8tLPZjGr5?=
 =?us-ascii?Q?fESqJVWHa8GWHByekO5hA8+1bkGRuKRS8r3FLdmuvhvDrNhyFmx18rv3pi06?=
 =?us-ascii?Q?DbY+6RsT0jaZAoXYeFNlxmrHCy4IIlklJqYRbmRA5Br9XVC/kdITFLTSO0Sy?=
 =?us-ascii?Q?Go349XXQQsu2dVM7YhFwA/o/TjKOXR/2SLa42PvBIr26jW+Q5kfZVDwPV4k8?=
 =?us-ascii?Q?LFnx4fTSjg6Ro1sU7NnGvIBd5LG98P62PGtxEqdfZOKoyTR02EBQEllfjwMd?=
 =?us-ascii?Q?2d5tVO7LUgUsHU0aEd5H6dRKjwR2M55SFbv1berRyVu7l8ZpCLoTaw2vgyPF?=
 =?us-ascii?Q?6Y703Z0ZKAixWarr+ZOvkypMfFSKZwzfH9TSveRub6Rb/f8+EYiuychM4AqO?=
 =?us-ascii?Q?oL79Tzp81o3RC5Qj42g23/5ODv4bBFdYjUyQ83I87koU3V7Qt+DLj4HecjCB?=
 =?us-ascii?Q?ytDpSpK4eZ/AEbgZIHpcB3ft1+sQ4oENwrIefx5+cGkKY22pz+ODvuO+lS5Q?=
 =?us-ascii?Q?VfapPulJFB+jnal2oFK+4s6NhBHysYq2eJpBWPMmBdwJuowCIbyjOkax/opX?=
 =?us-ascii?Q?Ecw/+7JqEyNGZEC1LcJLiJ5S8gsO5flpQil6S10V2RhLwzgqota/VLASXhRV?=
 =?us-ascii?Q?IckdIkcXpFuAJTgdPM9urMcIi+Mdq8C7tkp+q5iAJjnpSE9F/4GWXEmczT28?=
 =?us-ascii?Q?gh/6xgIpcGxtnCNCFUX2WP1Q4xoGJ5iHlONHcC8Ch94zbFDMqTaGBrQ1uJTS?=
 =?us-ascii?Q?kI9jMSwDoY3m8U02vPpTkHYXjPDeKrVn6ai1N8VwqlU1tqcD9pjZ+91juzBk?=
 =?us-ascii?Q?hscihaDmIILTN0rqbw7WW5Ar3qdik1/StFXTl7nE9isEi7YpE7bmpZSgUc0T?=
 =?us-ascii?Q?a+cGb8hPZStB+oXOrsXmkPv6YswSMDFvpc/2J19/EV3bCXShcZpr3zx92BEI?=
 =?us-ascii?Q?KXE/hGQH30QoQl/hY0oGWSCJ//GifMGAZ2wKEMeegZGrJw30QC8QSTkrDZYK?=
 =?us-ascii?Q?rjHPvsvcdSPX3r/Txlz0513AA8LnxKa/7jXbbA+7d+pbpW6fL8et0WZK1G8s?=
 =?us-ascii?Q?iC/8trWW2nJBPf2T4WQhNSmme2LWrRPWHGvV/ck4TAp94GndbdCSHbqsrXNQ?=
 =?us-ascii?Q?fABBGmrRpKRbudsJyf8DP/MyD+D3B4Jwyi+s0P2/CSeyN9bjSjRb3NZ5uYOg?=
 =?us-ascii?Q?k34tf+w+IpL0abOMiOE+r0n9mvW74WVpnbiHJhnDN9j3k64inOwv3dZzu1BO?=
 =?us-ascii?Q?TrBrlcoM6Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bae86122-7db2-425d-2d9e-08df2282db54
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 01:49:13.0534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: an1xnVfZLkEWKLaJ2841RfXoPQMXKCA5VXgszOBRM54wEgVYF2N6z38Xier270Snavhp2M1AvqVlkorm7uxmSgFOdmNpp9irDNK0UV8zLUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P189MB2687

>Subject: [PATCH net v2] tipc: fix memory leaks in bundle and fragment path=
s
>
>From: xiaoshoukui <xiaoshoukui@gmail.com>
>
>In tipc_data_input(), recognized internal control message users (such as
>MSG_BUNDLER, TUNNEL_PROTOCOL, MSG_FRAGMENTER, and
>BCAST_PROTOCOL) return false WITHOUT releasing the skb via kfree_skb().
>
>However, callers in the bundle extraction and fragment reassembly receive
>paths currently ignore the return value of tipc_data_input().
>This leads to memory leaks in the following scenarios:
>
>1. Nested Bundle Path:
>   When an outer MSG_BUNDLER message contains a structurally valid
>   inner MSG_BUNDLER payload, tipc_msg_extract() allocates and
>   extracts the inner skb. tipc_data_input() inspects the inner
>   header, sees MSG_BUNDLER, and returns false without consuming or
>   freeing the skb. Because the extraction loop ignores the return
>   value, the inner skb is leaked.
>
>2. Fragment Reassembly Path:
>   When reassembly completes in tipc_buf_append(), the reassembled
>   skb may carry msg_user =3D=3D MSG_FRAGMENTER. tipc_data_input()
>   inspects the reassembled skb, sees MSG_FRAGMENTER, and returns
>   false without consuming or freeing it. The fragment completion path
>   ignores the return value, leaking the reassembled skb.
>

This cannot happen as I explained.
We do not accept a bogus fix that causes regression.
Please drop your patch.

--
pw-bot: rejected
