Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013047.outbound.protection.outlook.com [40.107.159.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD87535E930;
	Fri, 14 Aug 2026 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698046; cv=fail; b=aBYWqZpA+dCl/szBBrMHqogfeDFhPqk2YQjxzg5xvneZuq/Ko2GjacjRKQVoio5lPepwmZP/reiC1rW6sx6+A4axXtkjAw132JKx7Tkoex1oAJtWSVFSGM2Hy3gtDAz2jTQzVMGmHxd1wR7Vff0RS80rTqHruLf4ScAR1p5uALY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698046; c=relaxed/simple;
	bh=L/7bfOwcS7wFzYQyBZshEq+p0iOE/cApOOUH4xsezvQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BDxM+w1LndiMqg5TDJWoX+9f2HgykwOhVMdIw9Uj8kDS+tADAEWOqYK7pydZ6Ieh82ZGgMjrZ2okOi234xZioy8+w+PMSyXfhl6yUWqfSGBuRobWJa6ZePqCX0VCxDRzH8iK5BrLQyG6pxH1FDaA8gJjaL2QMhYZMvMialTYKpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=BWTtPVRs; arc=fail smtp.client-ip=40.107.159.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="BWTtPVRs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrpAwIYt2ah5DtBX4AmqjtWJfIwe/oSCICMoVp0XhMZZdGNTtlcEH8kABlpJ4i6fyZ/mGFmYZgHvZ2inHHIKZgn88KXxF6OxDVsrARzmOQnlXEFzc8hVHLQZZWkpjkc7lnAZgHXFKtbgSkROiCwGd5Q4GTI6r/SplilrL47R13pyFG6+dK/AEm936F7Y4ReTMF/2MkTCmG/8yffzSPUryKkPO3DCtdM6kVFaxhAlgaOcvtZ+I4TT/O7ueJwPAKNy/iL+LABjXXgg/tiawIz2C8Xb8hcXqcrAc7/IMpsbpsc05Mj9Zpc92COQgkor8yC1v0Td6x6SoUDxgxtVsyJrgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/7bfOwcS7wFzYQyBZshEq+p0iOE/cApOOUH4xsezvQ=;
 b=oOSus9E7s7x/7yODkpE44cdknYQLWmHKfu8rLx6lTvTlImlL2a2HacJk67VlHe/0qyO7Bv+oAzmzijWm6zZ1huj+rqgzvhtUvWUFwMvVN7hx9f0st7ueakCBNKJPSHoVxPJfw4WJ8fR23wsWRRvXhgn0oP308muCIruAK4cvhv3wlH9/CA1F5UsowZyJXPXG7TxGS7B0olrrlVWSCJ0iTh12SWWcTCZyI0sHSeo0uoqBt1V5Q/WTneKVK257p0MYz4bT8OpwnInYbfZsWSYqVP3LahvHcD9q8nFnDTZioAZB/DD1+oN4riQDwuLbd3aeV8e9FVmtFpZLUlEGbRpTpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/7bfOwcS7wFzYQyBZshEq+p0iOE/cApOOUH4xsezvQ=;
 b=BWTtPVRsN9SxYpw17S8eyJwSLydfoySigd0hNYEwQ0GCZcwCFsVt1F8gTzMEx9fSlfo0YRySWprfp/kB+fEN+NNzglVVra53rAnnrzlMoj5BlE61P3ZdU2mhmoP6u7gAT9Zm+AYyI3F8pblSddOMgxh9vzVen3VbbXXrGo2SjQhKFatr+5A5OuLZoyeNuyBBH+WfPNVYN0h31Ay58Fqu3QI4QpGLQDFUiiWekuyMThhC3B5rgT9u+GCzJzOh0BUIWuuK9cWiVROIzVchGfI+aGqfejUQB0i0M9ikbLR9p6mTNul5V/zx7C7a5eMw57R+A5hJdCCrAbXW1TRg/gxE/Q==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 PA3P189MB3329.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:4da::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.5; Fri, 14 Aug 2026 09:00:41 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0339.001; Fri, 14 Aug 2026
 09:00:41 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Ajith P V <ajithpv.linux@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jmaloy@redhat.com" <jmaloy@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>
Subject: Re: [PATCH net-next v3] tipc: replace deprecated strcpy with strscpy
 in tipc_bearer_get_name()
Thread-Topic: [PATCH net-next v3] tipc: replace deprecated strcpy with strscpy
 in tipc_bearer_get_name()
Thread-Index: AQHdKw27UrEd0upBxk2KDIwhW6eFmradP1FJ
Date: Fri, 14 Aug 2026 09:00:40 +0000
Message-ID:
 <GV1P189MB198852836DD6CF9922258C7AC6DA2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260813102250.246781-1-ajithpv.linux@gmail.com>
In-Reply-To: <20260813102250.246781-1-ajithpv.linux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|PA3P189MB3329:EE_
x-ms-office365-filtering-correlation-id: 1749ff87-0767-4de0-f6bc-08def9e28441
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|38070700021|11063799006|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 XW9pJ5zam7VZT4k3CYZuqKi42SrJpV6kn4oCq1l2WoVMNrs2hFdpoKK8H/vARzunZu/g/vQBqUuNVxQrKk24qp5SFumuCp6B/kxVxGUlpRF8ZLXdbO/oEx0PUdNGzHlDSz6LrSWKuLhiYs3Xc8fs+PMSoFXlNZesHuuuUFr3Yu2SZk+Jghnvv+7RLH1WUu/1SRVna8ZIO83dhuXflfdsI+P8H+qI84J9dc9F+HZL9XE6/D91A7j1o8TTYDTh51lJdF5Ex+IUOG7R25/sDYdwC6WjZv1wcNq/S+U11FVOHFNLfEs7bpHJhJrRUUouF1KakzA3cm22mlWoA3K+gDurUNjYg2HJmGdayCmdLL8mbDI8MZQlw3dcnmMQ6vgHSraKR43enK1qxsaEn2e+C74n+HZ9JiI0O3xU+Q+y+mDdSuhE/t89tPGOluXfakNIwgAgdi1z9GGwaHR7dQ0K9bpdRn/3h14XD4go16fDvx+TqmTCojpGblea5ueIrOdfgw76iPhkdhOj7l1uh8LOiKz4XuB5H/SkfuSZlP226byrFomGqiFAQOGVjvthFbYzdFEdQqxqBpnmkxaeK9v89/V9evY5iutBBb5IGGPSpXx3AICWmT6pTtrHD1KFlt1dXKWpPkryIoZZ5rhu6coCm50wl7f81FEKQBRwuDEwCYYM7W9ptWCIt5eqXAPJ0gUyRRjZ3+i9VoKLPnnGAPDl0O1374PNvHFletObN1TPEYTOYvs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(38070700021)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ENj+G+B2CGB4AlgL0etXLHMPpAqeM3lYFOrLeoYJD4c5LuTPdbHDIJ10NXwI?=
 =?us-ascii?Q?OV1kcMNGmcEtqdy5iuQ2jBW5Z7x1DIhzVfbyuewNgw0gjEaTSetqcje3e47Q?=
 =?us-ascii?Q?Xf3QY8hdgAtC5FXLeH/zhyx/y3TGblrV8TdkOTIaGmkATafqaWh+BlgZ9GD5?=
 =?us-ascii?Q?VFk1WcwNhHBZzPUilQeFowL6Q6y1Fbm6ubGV5xyoZv4k/JM+/fjSNmKMY9wu?=
 =?us-ascii?Q?Hc2S0OzU0lTBmzw1hF1cT8r7QsZM1NJ+URXwNIT1F/J2bt5ezxRbCfF9VZ79?=
 =?us-ascii?Q?prXTHTp1bcJ9E5ccuf1nXWfxaXCYo9oWq77Hw3tQ6HEuoiEJKqrVwcnUbjB9?=
 =?us-ascii?Q?q6JW1FeDE1mV0oXxhACkVRscn2w2TZs8OCupIDxVwMzTabc5IYYfc+n4RjYU?=
 =?us-ascii?Q?W3C4zFF8tGYadE/+rcikFQEGxbS70xE/BrxqWy93swNPfD8arXYoqKtPTflM?=
 =?us-ascii?Q?B5aGHbRa0/8Z7AU2WLhzn4B05XOgBMD7KmLD0ntiJWo2zai6kVKmaYdTu9lV?=
 =?us-ascii?Q?bFuDE0MtNIbbXT6nU+FCdKbzzDyc8L+0fuZGi6pWKoAgeRgw0wB76azfnPty?=
 =?us-ascii?Q?OrKYhSQP7oVi4azn56uIBTT0Je8Rw41Nn3gJCk80FrgqtR+xcXjJe4QYYKUi?=
 =?us-ascii?Q?faqQgbGAA1MlXtiPJ4jVU2r0FLylvQzf9Z9KFrt+ptP8jhBCZu2s3KRoNlT2?=
 =?us-ascii?Q?jQMsPr3Xqd+bbssGDgo18DBHruh+FQ/cBvhYZ4Cva44AwpwiuX08sO+Z1DJ+?=
 =?us-ascii?Q?j/y+Jj59ffhtaU/2uITr5Ty3FqbqFkECpJ0ShXFHD3IIYEBX0anXj930ccQA?=
 =?us-ascii?Q?nsygY1m/9pwH68iT9nOz4ds2g9Q+khMIEo+SVECOk7RrEchXttXfjUI/lcf+?=
 =?us-ascii?Q?kaW8cOgaezeVR9pCCfG+mXEbVkUc827cmpdizSDfUGIEVv/xxi0R2/86GgbR?=
 =?us-ascii?Q?w44Er6P3ImxCWxvLG1Ou/qRttCqksncUlSV/hbPucum3I7CtHi3MMB34e8ph?=
 =?us-ascii?Q?zoLLHnxYfpHHM0gGZqrl0LnDq7ZLB7WwoEqPYtSB6+8dbSnudvDPg6gNY+f+?=
 =?us-ascii?Q?sLju0Ni3z24rYAUWVdfdSpvBacbCNGHKjWycUzcJDuMUPYEVy995eHwyJPLf?=
 =?us-ascii?Q?QveALIEW4TRQ2nYwfjxwpye16o/mzHWaY4m1+wNIqX4wQWIyA7xFqJ1HjqN/?=
 =?us-ascii?Q?ZwISKaW98B/EYEOUmSGdTnOjyL2+8tOdA4BasYDjaaR0VNvbcqVdyXuhMHxS?=
 =?us-ascii?Q?zcuBseUL6zTCnazAFuepWeiEZIPPJLmpfoHJdTE9OursIIkDsmX7dko44mMt?=
 =?us-ascii?Q?kTr/9LMMvdYHwWcj6zLvMK6YvQYcm429unq5tYtdRDt4WDnqqs/6PJIDUZGf?=
 =?us-ascii?Q?IjzpiqM0rzXCxu5Z2EHzjXs+fXd1Rv+k1EXi1b9jIskYGPYvxKR95FxII6+y?=
 =?us-ascii?Q?jWe9cDIz9u6oh5O5FvjG6Ygq9Kzez4IXaLhwhQOO7hN8Duk2vLZ6b7KLcTvB?=
 =?us-ascii?Q?54AVa3imtk/9iUNetZjGOKngZdeNmJOIQYUEJs+0J3yXnpG2YdI/tpY4q3hi?=
 =?us-ascii?Q?669vXyXPC/Ejy+hiAN3nc8mkvIByMQysKXrwamxDjF0oZE2zpS+86LZfgXYO?=
 =?us-ascii?Q?Fitv3w9HN8rzLMoo6u25fd7h+dOlprTi45Ny6mBahQP45dotJJwXlun5QZ9F?=
 =?us-ascii?Q?WOHXt79aOGqVbhRPsOrvPdBqv/CO8FVHe+KiF8c0vdpI9nbm4dI7JYpmMBLE?=
 =?us-ascii?Q?Fz2OX1OOjA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1749ff87-0767-4de0-f6bc-08def9e28441
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 09:00:40.9799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: icPPsOJhvQ0iznHpFelm1lZOm4qq/cY5RvQBYJUASc0vTR3VQtOIZtldhrxKEquYOghd67z4ZFDnzGxVLMlrMPuRtN4udd+DfLyg+8Y6bJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3P189MB3329

> Subject: [PATCH net-next v3] tipc: replace deprecated strcpy with strscpy=
 in tipc_bearer_get_name()
It seems your patch is not based on net-next tree:
"Conflicts with pending/net patches (net-next-2026-08-13--12-00): error: pa=
tch failed: net/tipc/bearer.c:209 error: net/tipc/bearer.c: patch does not =
apply"

Could you please apply your patch to net-next tree and resubmit ?


