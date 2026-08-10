Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EB23BBA0E;
	Mon, 10 Aug 2026 23:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786403100; cv=fail; b=Ee+Jen1qmBPFF7+bLoYUBQiby6i3T7zqw7U/Y9aNQ5bjRHJWde+yCKSHNLe8xq4RiKlIpEmHD0jTFXM1ENhfsQ9X0l56GJQT2TsRL4AFDENS6Xz6YAppTnab5EX4wQ2oMjywiYpcrEGIvG2I6hdtduJ22HE+K5k0jkyjgs4jScI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786403100; c=relaxed/simple;
	bh=LRJTHBK5MRsQiU1Rds53NcVSVuJz4QO9kkBVMeRGAeg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pNyTpW2LGO5oazADTh7iXAfjOsjIwovfobefFN0HvFpLKru+dLK76FbzzLQ0uFxSsDQPgOwhzogBAhTLSMKUjI1wAMGXJt2lldAq4dtXJOfUefa+fJ8EWMN84f2ZHN1+rXr4nxm/utSVZW/iQOq2ZGcvHlEhisA9yDeeLO7y59A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=fU5EjLP4; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=NFrReK7b; arc=fail smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="fU5EjLP4";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="NFrReK7b"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8E90A445534;
	Mon, 10 Aug 2026 23:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:message-id:message-id:mime-version:mime-version:subject:subject:to:to;
 s=mail; bh=i+rirupMa7rs9xCh9CwFf+6dVTvQHW8aPyGK4OecI3k=;
 b=fU5EjLP4Q92KMoymDszLPvPnqyvgptgC/px0svis2qG5gypMbwVgK+Lxrh7gQwbMgg1oxDBMmykTWctYxW9ikekm3SSmu4ou6W8BGlVOwHuRvRabehNvpZU6+4RAOLD9rGMaiXU4zqlNBWStwioQ9GVqCGjVr3rcJ1mh7KAS/3jTXTwPVPYdrl9U+xLqXDCrrdRF3RAqIYf0/mI/PDhdPf2pn+PCtgpXeRo78Q4p4rxyxAzJGi1WS2Vr/WbYxC46t5Wnm2Jfx489aZcTocg//2qgAQy3kx0jbzevq8HTappKnB1oRlGKlKNdMxkGqB7Gw/jmjGZhsHqddx+j9IlKvA==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022098.outbound.protection.outlook.com [40.107.209.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 4BE91AC007E;
	Mon, 10 Aug 2026 23:04:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4gQL0q/FDbu8QjqzR3Anz39qq4scHdF4lSWcOWy1oxgieDqUhbedmOpQc/eWJSu65fAiQORJenFgpnSL4GUa/YLIm7mH5nTO61qGNqSXaF1thrxk5h5J8+yGQjtMxZ5Zd3ZHckuul+Cm8gFgb7T2y1dKbE/MklelTXhjyFHxhQ1OIMjinZiXowgQoj5tLMO2w71p/8nONx8/FDob+5dbnqvEuotTS8O0QWgFzDkvE4nIXPWlvjqUl4QbOOYMN/8r24IM7kzCHPis1HkhfZQOYGDCd5wxgzj7dTyrwj9XHfTb3lPy5Ngj8CCx785lXlwWrGSTXWalJ9NhxfxEk/cNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+rirupMa7rs9xCh9CwFf+6dVTvQHW8aPyGK4OecI3k=;
 b=OS1bD5/BtI6NThETBN2ML6L9/oR7bq8hNps0LtR6cxMHe8eGM2bS+xqMk17iz+4uXY5LzEVL1SjVolAS7XXGdaPU9E78Fo4ycoY1jquk7F4DexMwI8junVsvMpp3AvQ1kMAUfRFPsywMe/M+9U1Z7ZPtDdFs/G6REYSb3l9t5Dk4LnFaUIf4yl8mAs15OqiGyFjPDzkF+91shNZ0Zje2jaBGyOHOCo1Cw2Qc7zMeQyx/ccA2INladfM3vsDSk6p64kg3IqPgf6lFo7n600EvXPiCqNDUl9E3aNaDB3uoQjKYVkXbna1mEMtN084+KuR+sBWYWSMwk9UECoVPVap6gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+rirupMa7rs9xCh9CwFf+6dVTvQHW8aPyGK4OecI3k=;
 b=NFrReK7bi3bywlYK/xp+qZIvscIxOsPOeV/j5QFpwRxcWtgalMgyDczC879euQt+LVoXbOmYlDMhCJuCGI/nn6NjKc3Y9N5VFb9EWF0lC/yAqWw1S+fPP43UGpuDSz2AWp6BsOb+VloT5+W1Jcvcz7l4pyN2RBT6T1qmTHTxP9NC+ee2BUILePJok9bg3MS7ziH9B2J77m9137OT5FbU3UIP40uo5v5hJ4QhGBfvTVF7lkZgKsigbS8PqhJ34AYAx6Bu01QgmzvHHPDbN1bpPp4zX+YZbgkLvTeMmBbBr7zBVLfguBXnPgJ/xEyhCv/tfsxaWH9mX6rOaTt74YA5ug==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by SA1PR20MB4516.namprd20.prod.outlook.com
 (2603:10b6:806:23d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 23:04:40 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 23:04:40 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"cjubran@nvidia.com" <cjubran@nvidia.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ali Rouhi
	<arouhi@sitime.com>
Subject: [PATCH net-next v5 0/3] dpll: add SiTime SiT9531x DPLL clock driver
Thread-Topic: [PATCH net-next v5 0/3] dpll: add SiTime SiT9531x DPLL clock
 driver
Thread-Index: AQHdKRyfQ2fK6CQ8EUyOQJshRDrm8g==
Date: Mon, 10 Aug 2026 23:04:40 +0000
Message-ID: <20260810230439.22866-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|SA1PR20MB4516:EE_
x-ms-office365-filtering-correlation-id: 2e0652e2-8996-4673-220e-08def733c23b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|56012099006|10067099003|5023799004|38070700021|6133799003|3023799007;
x-microsoft-antispam-message-info:
 72IdwJ30XYORdoWXXrJBGPXXkfkKnGqR1gDzZsxCoGGFfjTMEMKABSl5tQfBEEF4UQq3jBm02gMyEraE6d9xRT0NYUNCnFFnb2H8AvWjaAXYSRGiedrXwpDXHl6Lo+Z77nGYpa87CLGHBNQORGFhexPBPVfWQB5D8pgxsRnjiXNiJdu2DBuvwHK9YsCM9+WrJqXyBuZ/xkF+9eW3nLiljPpxhjQ0LNDet7x43Xf3JleCmBFp4IDcHvwRh1m9IgDVcCZPrEd3Dxph48gpxmOwVUZMAqCWQEZSgec5P6aD2lMYug46pduh6yzhcIt1K3f8veCK7YBiKL6qCsYOXHe9zg1Tl8Bd3NPC2nsCz4JawTXQvm7GN0SP6RRNr6nLG2spLu1ms8DYLcVjwYwp8t76qLrO7JiohUa+5x9VrZTDmBPBUljb1JJV9eIUEr+vyZeHPcoWwY+mIdREC6jGgWoqXfXG9Xq+cAoMIvF0F4BGN3JoBROoBSTDAVOGB3G5Yxz9VmqJnQlCbZT5Ey/KShUXxQXWc1o6ufICBGYFueSFH7vPPGMLkj5rDhfQMZxwGDU5KvO5SQZjoVGWZ8ibO2dTrhqAjiMn+ak4std6X6xd4eNJiDezT5oGUBHVCQERtd6Z4Ajzjuynm/0psFU/UtxCjHgnrmO+htdYxYRgxJcZgQlyhpMKMO8nDvpJvH4A7HyqVCkRtY4aGn5YzM0ORgCvLv0VdqHonyQDAPTU0BYi/Qk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(56012099006)(10067099003)(5023799004)(38070700021)(6133799003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?mC2BNXVXg7EErwRt5zHWM2UTspfyssEcvoKVeKuD50puioqBx0wIBJ5ifW?=
 =?iso-8859-1?Q?ygF8akOqT1GkSkr5qr6Q4nWZrJW4HEp8W1htJswV1oZlc/w3+YFCJOcwsZ?=
 =?iso-8859-1?Q?Od/ja30ZD6e312qLgWx8cs3gycUTaFXsb49QOMXfS8OrhEIvxJNouYs5pN?=
 =?iso-8859-1?Q?Qig27JpOqD6zYIc8ZCR11e1gCcISXtXdqpnprTS59U6oolHvYQ4K/TNc94?=
 =?iso-8859-1?Q?gHU6ybULXS+E6SSRLTMi5jMG5gzioxC1fZqPLjBZcQ6Ev9K6rCsQoA1dJe?=
 =?iso-8859-1?Q?K/ErURa7iai/59RuZRqNtUWTwSnR1/yoygfy4VBCUJNHb2ecNe6V/V7h9Y?=
 =?iso-8859-1?Q?bmla2JxVSqKHnhFbIdL5neMowYJ/qJeO1nDaNAaFYrFtSJu1Jo7znNW/Nu?=
 =?iso-8859-1?Q?ZTts6J3GJfy/VYBtOtdHd7YnSgmz+QaD1DKezWgOePy9DwS47jB8II6Ns7?=
 =?iso-8859-1?Q?ocfu+2/7YLzPxpLHReO5+VD8+kaD8aoP1GiAuZUt9tUi3L+UqqieM6tNzi?=
 =?iso-8859-1?Q?d2kBR0t4w9QMXh/15IWBBimLng9539DqXrt5Maul3J2ikRbzx/nd8NtJ4F?=
 =?iso-8859-1?Q?YEww945gQ9n5Pus08Vs0hoIfLoYAWiHkphUQXXcZy8zUBbcKASlfeLsuiM?=
 =?iso-8859-1?Q?BRjKxymyiUKiSpAuC/e32e++wKyT317/y26TtM8+2ONbTqSGynz9S4RkFM?=
 =?iso-8859-1?Q?RTYmayzlKfsR/CDkJEzzE1ZLtwEDJ7NHy3D1aDBXQV7UyJBY93MR6/AmNa?=
 =?iso-8859-1?Q?grVucRP5MKCT+PnaFs/w4NF1099v2naqt+4zoOj4Ybpp29P+JF4b5iBmjc?=
 =?iso-8859-1?Q?1iu3kHxTGlji+2Jo/c6bXwsTyffHwgSXRoz1DQ9FJhNPNvX+5OXjcIvcUy?=
 =?iso-8859-1?Q?P7IIUoMLt+2SfrcDOyj/yjoVytM/GPn4VYF0zu4VSnUB6J9alv6qCqg95Y?=
 =?iso-8859-1?Q?4x6MHBkjToxZ5RVi2B6rHt0abzc710fA6u30ACqCUSUOjadDzkO54D2JuQ?=
 =?iso-8859-1?Q?v50JIsKwF/p6W4KNEp2jmLHOUnzk0yt4nxe4djTNqiCR5FkBFgZ+GW0LeE?=
 =?iso-8859-1?Q?Q/x2tfv6mI3Ir5bme0BMiw7VYNZ+TfP4FQOgPRU7od3zvSAPDLiYzM6BHL?=
 =?iso-8859-1?Q?Dt0a5lbFY3PUKF8juZqOOX4e4QoKSuFIErIFUV+RrCvrGxEOjckJg3Dz2y?=
 =?iso-8859-1?Q?iZ9p6BLKwbD478iLele0K1bE0fEPMiMJ8ukxQJaht+ewZeiWV49C2wkZhQ?=
 =?iso-8859-1?Q?dgvVofQw/82MKf7WktZL9Rz0WNSzOApnaOop3VraHA3gQGuovRd3nJAljH?=
 =?iso-8859-1?Q?YaFdWkCg0najmoBXImxSYLYkBSO+/WowtBH3oUpxPAQDdYpMTqZvdH4Nxo?=
 =?iso-8859-1?Q?a3VTPB9NzkO8AiNMD5vB5TGMzETN9cRDhnfjTcrVDGGzLQMhQLnnBEXi11?=
 =?iso-8859-1?Q?ziuvFZhX1bJrOM8/xZ4ALKgHRuJzVC/VdyNgUVQAtKq7DNIG0YGgVHcBw7?=
 =?iso-8859-1?Q?rWk+nO9o5t84s6yGWIlC1ZV+myTgFJTzVvhj3RofeE9irtFsIzbHC6LcG5?=
 =?iso-8859-1?Q?TgDlN2zzkl7C5H5y66TGE4jxvlnLu9FpusFnu+JMMCWwDnpbIB7up+l2/V?=
 =?iso-8859-1?Q?Dl6U7lHtSI+OxP3bZfCS7Vm3HaQRNDte6U6xcZiwj62+0AV2vFqy15LKq0?=
 =?iso-8859-1?Q?5AT1Gf9gRhAtqKTjtad8C5pVUmZs4OfUelwdNvmdVsJCUD1x+kOnifMkPC?=
 =?iso-8859-1?Q?fRgmRmbHxhMnlQ1khfZcZJ95YCBqd80hhak+/AIvTz+cHJ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	N41OKcaeTFYUrgvnDPzgRD92EyZQXzGjaOiDTcVixvFTI8ny+CLSu+6KzQc9HXoGfjwdc6ygZCc0M93F9n5yA1A6Xsaj9yX+BrtEvAj4u2WejVNSB8fWti4iUy1rOM22tElLei/J4NOrZDj3fFyk9O6WBMa+jgGHqiJ6ZhpqiS7AUGtC08GEuXl5qFLzwEm/zu/cJn23c+3bKXzNDWSpghFEgLBDNBQViQOkSeb2+UDe6A8LiFVp20O5Qaw1Wu4/yFXqVsA3IJB9c1GDZRz1Unx2HAj88RgGTG1/a6SCMOgbup7eX2gx7US1OQinzQl8sZ6q7Yq60lBefVaNIwfnlw==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0652e2-8996-4673-220e-08def733c23b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 23:04:40.7148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IXWPaelH307BQDKr68tRX4KtwK5hEwfM1TTQAeo+xGv/XENRwBLEW1jhgQf1ZzFbbyYjLHOjtZWQgEw5VfcPCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB4516
X-MDID: 1786403091-Ei1tr7uEUun6
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1786403091;Ei1tr7uEUun6;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

This series adds a DPLL subsystem driver for the SiTime SiT95316 and=0A=
SiT95317 I2C clock generators. Each device integrates four PLLs with=0A=
automatic/manual reference selection and on-chip TDC phase-offset=0A=
measurement, and is used for synchronization in telecom, networking,=0A=
and data-center timing.=0A=
=0A=
The series contains the device-tree binding, the driver under=0A=
drivers/dpll/sit9531x/, and the MAINTAINERS entry.=0A=
=0A=
v1: https://lore.kernel.org/netdev/20260511211143.19792-1-arouhi@sitime.com=
/=0A=
v2: https://lore.kernel.org/netdev/20260520191943.73938-1-arouhi@sitime.com=
/=0A=
v3: https://lore.kernel.org/netdev/20260731180951.65725-1-arouhi@sitime.com=
/=0A=
v4: https://lore.kernel.org/netdev/20260806232439.27551-1-arouhi@sitime.com=
/=0A=
=0A=
Changes since v4 (address Krzysztof Kozlowski's review):=0A=
=0A=
  Binding:=0A=
  - Rename sitime,sit9531x.yaml to sitime,sit95316.yaml, naming the file=0A=
    after the first compatible rather than a wildcard the parts do not=0A=
    carry, and drop "SiT9531x" from the title for the same reason.=0A=
  - Correct the input count: both parts expose eight selectable=0A=
    references (four differential pairs whose lanes can also be driven=0A=
    separately as single-ended inputs).=0A=
  - Drop the clock-frequency fallback and the schema branch that allowed=0A=
    it; the oscillator is always described through the clock framework, so=
=0A=
    clocks/clock-names are now required.=0A=
  - Explain why sitime,pll-fvco carries no unit suffix (the values exceed=
=0A=
    the 32 bits "-hz" allows and are not whole megahertz), and add it,=0A=
    together with sitime,output-pll-map, to the example.=0A=
  - Keep a single example.=0A=
=0A=
  Driver:=0A=
  - Drop the debugfs interface and the orphaned DCO steering backend that=
=0A=
    only fed it.=0A=
  - Rework the DPLL init/teardown so the error path unwinds explicitly=0A=
    instead of probing internal state, registering the managed cleanup=0A=
    action only after every field it touches is initialized.=0A=
  - Drop the clock-frequency fallback for the XO rate; the clock is=0A=
    required, so devm_clk_get_enabled() replaces the _optional_ variant.=0A=
  - Drop the i2c_device_id table; the OF table alone suffices.=0A=
  - Take dev_err_probe()'s return value directly.=0A=
  - Say nothing on success; an unknown dpll-types string becomes a=0A=
    warning rather than an info log.=0A=
  - Move DPLL registration next to probe, drop the kernel-doc formalism=0A=
    from internal helpers, and cut the narration out of the comments.=0A=
  - Name the page-0 status registers after what they hold (register 0x06=0A=
    is outer loss-of-lock, not holdover) and remove the register defines=0A=
    left with nothing to define after the DCO/SYSREF removals.=0A=
  - Rebased onto current net-next; base-commit recorded below.=0A=
=0A=
=0A=
Ali Rouhi (3):=0A=
  dt-bindings: vendor-prefixes: add SiTime Corporation=0A=
  dt-bindings: dpll: add SiTime SiT95316 clock generator=0A=
  dpll: add SiTime SiT9531x DPLL clock driver=0A=
=0A=
 .../bindings/dpll/sitime,sit95316.yaml        |  171 +=0A=
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +=0A=
 MAINTAINERS                                   |    7 +=0A=
 drivers/dpll/Kconfig                          |    1 +=0A=
 drivers/dpll/Makefile                         |    1 +=0A=
 drivers/dpll/sit9531x/Kconfig                 |   17 +=0A=
 drivers/dpll/sit9531x/Makefile                |    4 +=0A=
 drivers/dpll/sit9531x/core.c                  | 2939 +++++++++++++++++=0A=
 drivers/dpll/sit9531x/core.h                  |  367 ++=0A=
 drivers/dpll/sit9531x/dpll.c                  | 1151 +++++++=0A=
 drivers/dpll/sit9531x/dpll.h                  |   69 +=0A=
 drivers/dpll/sit9531x/prop.c                  |  397 +++=0A=
 drivers/dpll/sit9531x/prop.h                  |   39 +=0A=
 drivers/dpll/sit9531x/regs.h                  |  318 ++=0A=
 14 files changed, 5483 insertions(+)=0A=
 create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit95316.=
yaml=0A=
 create mode 100644 drivers/dpll/sit9531x/Kconfig=0A=
 create mode 100644 drivers/dpll/sit9531x/Makefile=0A=
 create mode 100644 drivers/dpll/sit9531x/core.c=0A=
 create mode 100644 drivers/dpll/sit9531x/core.h=0A=
 create mode 100644 drivers/dpll/sit9531x/dpll.c=0A=
 create mode 100644 drivers/dpll/sit9531x/dpll.h=0A=
 create mode 100644 drivers/dpll/sit9531x/prop.c=0A=
 create mode 100644 drivers/dpll/sit9531x/prop.h=0A=
 create mode 100644 drivers/dpll/sit9531x/regs.h=0A=
=0A=
=0A=
base-commit: 001b5d347d8ba39b2dccaefcc57967b18caec8fe=0A=
-- =0A=
2.43.0=0A=
=0A=
