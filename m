Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010045.outbound.protection.outlook.com [52.101.69.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFAC437856;
	Mon, 20 Jul 2026 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562335; cv=fail; b=Tbaqzct44UBnfblpxWTFAumP59wWre4OQec24SVAPDg9CbqDmdqnk7qU9/RxY+oMOQEiN9KwD9CyTIjiYOCxo1x8x2khf0yJay7XXb7W9KmFiXprgLqE0VruhWxtlOamsRrqhp+Bafj/tP2XpswKY8ao1GIyg4shl++m+1Tdies=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562335; c=relaxed/simple;
	bh=V3P2PPhbkm0/FA1UAy55b4ZXfDx9Ro9gAoXUk4CuzmI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F6r+hVWGhKVwJGKVY7vgD1IXCnajcy6R8w78uoeGKre8/AtBrTTGoVqS9EPAemYHH5uhZ7vl1GxaTFcn6HxjLPywbypYBjRfEhrJp8C+dUk/xRpPSreI6ZrEHLw9e7qEV+XJDAUju0kVGhfnJzdR5Q2GujFAX35ou5EOEK5Zyp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=q9JEBEtS; arc=fail smtp.client-ip=52.101.69.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="q9JEBEtS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqML3HvuNWa0/kH3uLK9vXWkwMZRXqUNoQg3YY14mC+2Oe0NjPNH4hWYZh5vBauyg4bO5KmtjXaRE81l3VBC3HXl4Tsskzk3G9kxHN2nu5deHL2dXPZPmMun96tAY+jFt9fuyobulhKCAsqR/nU2hkQKyBgMbziefF7AfBPfaVD8Lvv0Pmkozqq1UUfLxaiJ36sHYa385DBrcEVUPNPeCh8WITbsd4hkByvxPAi6lMI+GUMGUiLOy64cnteW+vfo22v4+l2F1ATVT6oIf0q07I0WLEPsvFhFrEyVpMKM5cCRUrgLJsH350/5XA4UDwi4ZSmsIfuq2O9WszquWnSucA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3P2PPhbkm0/FA1UAy55b4ZXfDx9Ro9gAoXUk4CuzmI=;
 b=uEGMl2HeWV1eIJmSmfV2X7ruSm/Thg9bZI6UN5pLFhCMmmJsIw3reYEZzta1OJlxMqwtAIrUB155yN3CHJJ7XvJ/4zpQhgEwg3+dTXkzpmpS64+f+sUmoFZOG2i4AZh+U7mRIni4lODvweorCKHFvfak+bV80ctZwtkxTRYMSWqzn/nX/nFkAhFsN5qqx0jFc3QPGOK6LcvK1TTJcXH8D6/1H3eKNz0WnIzSR0X0fKGObGBlUP7D2xB2qbkWEULeGkjYKML65/Mf2vJ0BvIDfMo4ci83R6dK1lWcjlRMO1Suj+bIQ/ua9SHuS+O332LmRCMtmkjTgbcratmp7+3x0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3P2PPhbkm0/FA1UAy55b4ZXfDx9Ro9gAoXUk4CuzmI=;
 b=q9JEBEtS+MS+Hnyc7lGitRMhk0CxYIbAARrpls6txlWSB9Xcr0U6D1v7tWVlhyqZPHZL+KWUCuBAvtmPQnE59wUDIUdaO+zT8suxCAUumWAOcc2O+WM+GMXMIffN5/tt1g6P1Lbfb3zNQ2XIEQZTzxvhHb6ffxELOqgV8ZMCvpgbzwspOw0tLPN0SdoPafFV87oCxFOKPkkhXGBJIvN+ShdOFN1voaFMaoY3wI4yDdDuvpJBMo1bfkSqQPbDPDaD4ooODFL8TGAx+hYe76OtHhumnteY6vdLMUX8DgE2EEAnyE9esL1Lztf98rp47M+cGMnIgQCgjyLA8rThZ4XXdw==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 PA3P189MB3332.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:4af::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Mon, 20 Jul 2026 15:45:31 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0245.009; Mon, 20 Jul 2026
 15:45:31 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Weiming Shi <bestswngs@gmail.com>
CC: Xiang Mei <xmei5@asu.edu>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jon Maloy
	<jmaloy@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>
Subject: RE: [PATCH net v8 3/3] tipc: fix node reference leak when defer work
 is already pending
Thread-Topic: [PATCH net v8 3/3] tipc: fix node reference leak when defer work
 is already pending
Thread-Index: AQHdFpd4Iu98YIGCLUaOzhReQUGSTbZ2kBfw
Date: Mon, 20 Jul 2026 15:45:30 +0000
Message-ID:
 <GV1P189MB19884D45C3C2EABF26BE83B9C6C32@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260718092544.785289-1-bestswngs@gmail.com>
 <20260718092544.785289-4-bestswngs@gmail.com>
In-Reply-To: <20260718092544.785289-4-bestswngs@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|PA3P189MB3332:EE_
x-ms-office365-filtering-correlation-id: e46a5185-5d11-4e2a-23e0-08dee675edec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 Ra++yERhudvlqqkuKE/Mf0jkSeJJXWeAx4LJ5StNF9N1TGbEWgMPazNdf1bH8dbl2YEsisfEKBxAeVceeo0wv6Jy/7ipom/OuFweALUyhC6NZSdhgQ0o7zk0q+eYlfB+snyxp9FfNw54MZvvk+kvAiG0L36fr18YWYY1dn4BE3nmegAYVfp3+oqa9IMdzbvi2/UL2UIhiUEGFzbeogYFjaP+usXN1vQRlVoRfRgWRISVxc6w35Z24UzY/NfnpO7Dl+fhDFVnS+NGp/l7F1ENqUmgrd+goJSqieo9ZrDja8EH7T1a+DzRIGIrSGnkz8NIZnNqCwgPmwUj2UOlVRF1A33MD6bPDlXPEI0pm+It4UNnNNYspzL5ftUwHBYB7I+gPEfwuCgFJt8+U7iTdFmfcufyChDcDLDDmfSDOIFk13kiivgV1pEsGRVzw13uDOIJ7gQrSFJcx8c+pUg4chWZs8QcjFHpS8znkxrAxM4VYUIKd78KfR3psgcWWfNNqvLYTPRhw+5UnybZQ1yYa2MKHUPPGC/4CxgTehUFJEF/qYAdZ7ExhA4Mm25Ampuyn1jUE/GdBNAvjp7a0f9chUGIRtIKcKZEFCVli5nOJ4/Jshf/lJdmZcFKo7zcqUGqy5r9MIPrFMGT+wJVySeNMMyzaigF6m4gxOoPA3kBnktKJ0E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6qd9JSMHfeIm79kmFRkGOdmelJ7hoNn59yRJDxEJ/bwVF8HVRDvUSzDDuP3t?=
 =?us-ascii?Q?ZTH1jPVqcRWSWlXht8yHsPu+i/tU0YqvFA5K94THObE7uwBhBCTP93XOTHM8?=
 =?us-ascii?Q?218Dyl8RaNRIjLQgzoqX3190NVqr9TTgKJDqCzAJ7Wdh2KxuKEs/yb6Wk/0T?=
 =?us-ascii?Q?443inU/ntoDe+M0mE1GNwGgDTd8W9TnmsOuPlGRNMy9vXHgcHjGRBm8vEP/v?=
 =?us-ascii?Q?ixj40r6j2uSavXy+OiBulU5ncgrWIdPZTw48S3Kjn5eVQHumJEjGekDa2tNb?=
 =?us-ascii?Q?nMS/0YtHqXBpsm7cbmOCwSMXcXojH8qyiU3oTN9rtRyU/agB8ZgXYAJxXIV0?=
 =?us-ascii?Q?/jylFLw+dkq/Dd2SLnViduUR7OJJR6dHed3p4toK3Vt22PpqvXsQRGOYHBPF?=
 =?us-ascii?Q?VNkNlFdWfBYoa+KJA7MCWx9py5VnZDoRMY0ooh4cG9iHmPZLJGiTR8L580lW?=
 =?us-ascii?Q?SJDYDx6GF4O/KnaY9Tjdb2bZ3BnulMTTMCCLVbEZzLFT+HSl1G+Io5Pumtrw?=
 =?us-ascii?Q?tHUaJjKpMiZYxf3QXN/3sDaee5MmAz15NScblRk53X+oGvvokasJ0pcrsfed?=
 =?us-ascii?Q?p6TO8zcXZRzhZlOPCxR8oqEV/lq6amVMCDoP2muoW3f/lWwK+1OkAiAuINjd?=
 =?us-ascii?Q?k3rY6NDZ/bHQsIVm5W4FHmGhZiQJABkVgYcJ76MuvdAzx3qTcCl82Xrk8gDJ?=
 =?us-ascii?Q?Vh0X87KdkkN779QvPDEPmVBKU6dSoruPTNrKNK7oq3v0iwpVJVvpz85UHTAk?=
 =?us-ascii?Q?UNfkEnspzENE9g3hRjyke5K78e2wO7NZfKxBdq6s6BB65IFiZiepGz0jaLqt?=
 =?us-ascii?Q?MnS+hZ0jpbMhXSpAmQU5g+KMvECGpoIhmbHE+GHzgehGVNBqKLDRys0Vb+hR?=
 =?us-ascii?Q?lG8cfFeD8Avy14vHhTbutZdEtWSaEvjQW5EAUmFz7y7sdI45pSX2xhG9Dz5E?=
 =?us-ascii?Q?7cwSCjjE8Z2JvOLL43lhvyApomSQb/cpWL7m8TQ7ewuCRPe/KygF0uP54hhv?=
 =?us-ascii?Q?AmFRHc/LZrxPHmvVmDreUKuqoba1lTe/KGm4DVc1VnZuU8kaj2CZejDFemvY?=
 =?us-ascii?Q?1OSPJsEtlLRoKYahSATALlctrrpQtU7HYiQq3861YFZMdmQrPmruO8/NokLz?=
 =?us-ascii?Q?7KuLG9VpJ1BStNNEFPNb2lGv4G51ittSva0My+FCkdEmnrsmgb0p+r0ybAXW?=
 =?us-ascii?Q?ZhbvCRlx25CpRlgq2iyDRo34D6mUqCZwLwxqaZFboTCYrOngT+8I44Lx8bAa?=
 =?us-ascii?Q?9aOCeLaZwo+mWXeDjFN8ETmFuO6l7oEjznnmJLTO5Xq6PK1BS4bEoePIC/zs?=
 =?us-ascii?Q?jMBvIjcV2X4Osu1g7bELDktMdB/bjiEWrAefeR/m2/+o8sKwDmAvOWMDa8uB?=
 =?us-ascii?Q?1l2aDv6RxpgQyHiweNDs1GoXVf7ynt7pQf0zAcuJ+KN6Uzl+1u7iowcu2QmB?=
 =?us-ascii?Q?R3GmOxCKw15OuLDaWQXn+2rk2LYVwsD8cMf+M0n0lAYiwY/bfSlyRzHGytaN?=
 =?us-ascii?Q?qFd8qnJL4SuYJMdc8lQuGxjFISj/HQMF2itT3oU1scybXxr1mzX0Vx2XtBDH?=
 =?us-ascii?Q?MKwi1iBOS+IVlTKRs4hEBHkW9NvIyy5hmywfxzo4Hhcw2zF93dWDVUvId1Fa?=
 =?us-ascii?Q?2tgZsCFzs1TbrNxX8FGKcPdVZovRSVlN8+ZbdEw9Egxg1ZjjSc4CnEDTwi6U?=
 =?us-ascii?Q?WGalfkhiJkalDx/URsrPfeZrrK58AA6WFZ4wDdhQWRsHrTZFFe6LYBrMCykR?=
 =?us-ascii?Q?XzvzpZU78A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e46a5185-5d11-4e2a-23e0-08dee675edec
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 15:45:30.9938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eeZ5a1DqnHkkELEWYsU6P8XQnHIDlRHO8p2adh3asZSAr/0Jqksz2X+xHOrcgXQQj6pbC+IS9j7ZZPnHtMILLpx1O3szTmbYUSJCBSFQYgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3P189MB3332

>Subject: [PATCH net v8 3/3] tipc: fix node reference leak when defer work =
is
>already pending
>
>In tipc_node_write_unlock(), TIPC_NOTIFY_NODE_UP with an empty
>cluster_scope takes a node reference and schedules n->work. If the link fl=
aps
>down and up while that work is still pending, the next NODE_UP takes anoth=
er
>reference, but schedule_work() returns false and the extra reference is ne=
ver
>dropped. The tipc_node structure leaks.
>
>Verified by flapping the bearer while the work is pending: one reference i=
s
>leaked per repeated NODE_UP, while the work is put only once when it final=
ly
>runs.
>
>Drop the reference when the work was already queued.
>
>Reported-by: Xiang Mei <xmei5@asu.edu>
>Assisted-by: Claude:claude-opus-4-8
>Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Please drop this patch because sashiko reports the same issue for patch 1/3=
: https://sashiko.dev/#/patchset/20260718092544.785289-1-bestswngs%40gmail.=
com
