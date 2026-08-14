Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010021.outbound.protection.outlook.com [52.101.84.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8F7470116;
	Fri, 14 Aug 2026 13:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786712635; cv=fail; b=jIQAQ/5yKNHD2Ax4CdDGmJbpSer28UV13ePsikALH/ik0CXGC9KrTyMcpGTD5pzBnitTDZqXRpFff5VR7e7VBqtQW/BZPgAQcamnDohzd8U+uHZMjroAwUjq+ZPCK5y761+hu8T0VsOAByJ4jrZyRjhWlfEkgOXWTQXmCpbuA7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786712635; c=relaxed/simple;
	bh=YHqqLFA0rqtC9isHFjGjiuTKwuqnrGWJFq3PrPS7u2k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N0NJFDbfCVOTiiHDy9oLPNZxBhHk1BB9YKAx4bna4ZPJ6XShCCqHrz1IOd+EA6zlFwxnSAqHFK2Pmrx/uQReAr6g0ot4wP6UkpXFA8dAPNrzs0gdeAbYdWxxZyj0SlsPX+VNGMilICgtblJHq42kXm6VRg7dS5z6YHv8BHlhExM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=Y4PX14ey; arc=fail smtp.client-ip=52.101.84.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="Y4PX14ey"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CnX83cWVayq6VIU5nsu+fKkCVBpB3YKZKiBXYD8tE4YJ7iojdNpnoOYz16EOuWl64NDMUCvXrJSQAKT9b8BglBSM49pWX/oOaBXgLkionN29jyKw4z5g+iDIvbFyJ0Zif5sGov2O+TO5vajFR52IVaV2ZXu4bOue/pKrBa4DtlXBhmtQWZ2F54WlbeCpEQRnKEQQB3z5YDsMqjs1fJ5n8yE4He9uY+1sNmbP9vh3NGoPh3IHdMLz4wCQWzophlQ/4QdOdpGdGzdhcN6mruAet24kicM+P/kHObGxr1rgchxa1thi6PNvSJ+QepG3QxmuAqHPopv510JEgBENg1LDSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHqqLFA0rqtC9isHFjGjiuTKwuqnrGWJFq3PrPS7u2k=;
 b=bgDylYTzx1RdKtvHzt4BADmqTBj1sUOZgFXmMnQklGdGul1oF1hfRzPzjue3uwfwBlt2z8EOWhjcR+U2a1zA/Laur0vilKi1JHYqIt8Eggmqt63RcBUDbTQfOcGPonrxkkyA6wVFjwIEJevS+QtVF6CaGcwbxSsNMTJ5CuINs/dscbqGtEkvy+fgxxkKMRzwRkESUsIRlYdpaeeVP/H9cTUpsH38HYQ75+qdymnljUc5bghTO2FMfUwK2RmYy3VIUQE3gLe3Ie/Qw0cCk5QDTDpM8N0RdowTvNND4JbTjXd87g6Bk5ygDUBSWX2/pl2sWeElZtejFhEtoP+ezv6oYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHqqLFA0rqtC9isHFjGjiuTKwuqnrGWJFq3PrPS7u2k=;
 b=Y4PX14eyCmiKOV+PWUQnhLRJs58swcMtH5uXyjN7dtxKtsrsvSPd/0GhG+ycsCZwG4PfyrKWDk0OSPaEh3eVjIYO69MhVEsPl/g1yYUYeH5OKd4Fv8u6dTI1xmG7hMd155z9fwflM/UkMhGuLtXKRGDIvVK+hVfYjMkcRtGiFk64aw+VsNWJBKlSE8ek1YGbOHSttWB8MkzrCbwBXxewKUVN7XWRFyOQrFpKl/gSQLBFsY2mL+xTu6hXq4B021jxLLsFXGznsSB2WsAnyYsdyOV6gmM22m4DWo8Uebv0CYPOCy4Iaxnt77qexHHJBx7GKEhMIF4mkfm9woweKExzew==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 VI0P189MB2649.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:23b::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.6; Fri, 14 Aug 2026 13:03:48 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0339.001; Fri, 14 Aug 2026
 13:03:48 +0000
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
Thread-Index: AQHdKw27UrEd0upBxk2KDIwhW6eFmradP1FJgABDBoCAAAGxUQ==
Date: Fri, 14 Aug 2026 13:03:48 +0000
Message-ID:
 <GV1P189MB1988CAF7D299010DB0C80031C6DA2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References:
 <GV1P189MB198852836DD6CF9922258C7AC6DA2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <20260814125547.325298-1-ajithpv.linux@gmail.com>
In-Reply-To: <20260814125547.325298-1-ajithpv.linux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|VI0P189MB2649:EE_
x-ms-office365-filtering-correlation-id: fc14ec3c-8668-416f-1544-08defa047b17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014|23010399003|22082099003|18002099003|38070700021|56012099006|4143699003|10067099003|11063799006;
x-microsoft-antispam-message-info:
 xs7XPFmfYabnJjDfIlf8Et+PzED/lXVrz9UlnS+bgzuC1y0fjso/6og9tnlam36tFeDtcOMn4uMsvBRbyLJrd+yHO9Y7jop8swWnPolXGIHHeVavxLp7tcrLH1pFeFKkCmmazU3NrsTr3qHHv6hqs3qUigihXwLGOTwk6iixp9LF1kKor6IiXCC6ebepdqowAeqNcMRGcKKxvA08JGEzVR5nqhSQetHMvtq7n/yuX4pYzbxMcawr1JGDZ5vTsi6SqJIehf9LHzEXCc69Bq0kCgznRxlKbpYZBpWfgW9eyl/GkCNHncac6GzCAy1r7EflECSqLLL3ciJUzdO25SoZZxS0gaRtOZk5yt3Q2dcXVONAQM/Zen5Rz2J5rv9HOosxK4kCNyJMbio1t3VyOHK17iLkumL7rpW3xPm5SWkWnrc18kUwewMRwHdgTaO3G9h2I2Q/PmNz3JHuM6YSESjXk2pxvv+rnXSo/VqoE/r/BTT3vpWRs8daphX3DroRJyeLryGxpj2TG5VPPylRGVMMAITMpa+HJE5IvyzvGrDCqmbUqMrI+g34sEw/h8Wdf86OhMv9niATFuTul8n8L7+r31527I/dqLb4sdntqgF6dTNd2OBIh2N4V17arxrlJ8QqFmNxWmLCSa2XMni5TUHR/j+25wUljgwOUqSUprtcXm+2CLlcwM8n88UsFhAHnxMfa4BKJB92+e7LpUxaVs+nbqnu+qS4NZb3k+uacrjGhMI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(23010399003)(22082099003)(18002099003)(38070700021)(56012099006)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?KzXDuKmkWSB8gfWybHzy2omuGSThiEvarx6dcIbAeiIhYT5qv590UOsEFJ?=
 =?iso-8859-1?Q?xjPiZJGMqUap+BVIgpor0qoYJU+fibkgJv+yRpPJFngkzJdNgubB4+PjlP?=
 =?iso-8859-1?Q?oZeOc0bQltqWgxBum0s4QLH2iqqNq/U7VYtOxiTM0b4XKmw1MKMDITuOrs?=
 =?iso-8859-1?Q?paoMb224i7OWHnkai4HYT+kTUC43KLNuPXLAus3EIZI1vigcX2tyBA2pUO?=
 =?iso-8859-1?Q?SCkD5sdxAfoWDOdmBFelfNwnBPYeiXSKSSvMQ7ZAWorOrvfvkVLfmwz5qn?=
 =?iso-8859-1?Q?gSY6uylZpJtltUubSDD9SKXHZuPIHK4zCA90VR1w3KuZVylTJT5enph6zS?=
 =?iso-8859-1?Q?fn8QMwN+J9bNECgPD+fj43ItPd9VndMHQf82InA+GTgn5DIRiV72RvS60n?=
 =?iso-8859-1?Q?Yv7AM0kr66QP5wusOgueSRZArLwZiY7jFcKB8vchXss1DUGTTsKyv6q1jo?=
 =?iso-8859-1?Q?kjVi/0JrNtHykNzB1JxBFMKbcKTApfz89bjOtVAnc3d4O95eJe2uDZ3b+R?=
 =?iso-8859-1?Q?2lN3QXm7imiKqQ46wrRGcRZuSHeTiHKIksROg6OR2Nhc4ng3GZyG67y/p7?=
 =?iso-8859-1?Q?1nNU+cB4aBViaT3V0timfsZT3oIdJge3w6V5oSwQtzS1asTtptrKUsu9kz?=
 =?iso-8859-1?Q?0BJOERCxdRLSEuaygOlasEaTKQyL+w7cyd5KGiMo7wObKkIqh75W22Mtls?=
 =?iso-8859-1?Q?/6d/oHhw+JbopggCnuWhCrc5nabUwI1+4AyQFVDlAohA1GPQflYkEOjCDJ?=
 =?iso-8859-1?Q?E1Jn4JnD0h6dC4dOcOOSXtTdY3CJUnsNL3k3HPdH0ysHwJ00dwwe2xexqU?=
 =?iso-8859-1?Q?uMEZT5jbl8923I7GXVS4oOB4KfEFxHHcGqYzp5JrvknvWZdm6XwSGCy1xu?=
 =?iso-8859-1?Q?o/ugx6joeiX1Oafynfb0u/nR+t4FUK25jrzEfWDhp3fepIb3G1kzrVU3YK?=
 =?iso-8859-1?Q?7A8cFnZaqNSDk4HObpgwjYDkVd7IPCFZbSsv1qlEqKa5U61W59V47P0va/?=
 =?iso-8859-1?Q?xPAmuJ+D4HdCpRzMKXyvs29s4RU8dzegMkYe3QI+bW+gTW7t6ijQtIOP4l?=
 =?iso-8859-1?Q?pdIZxpBHdLoTggmY7lcDC5+NK08VT1U/1v5PnBeQe6dNkgFgPFhVehPcGR?=
 =?iso-8859-1?Q?BHO0aBOn3du41NYMNTp6ap+fmY7h3fINxcC1qA5BB93ZyCHaWGR2Cn9lqA?=
 =?iso-8859-1?Q?NSoxXnEPXEg5k72eWXu3quaMpu3Lg5BClWP0/f83/zZd0fhSjCozRvNhrQ?=
 =?iso-8859-1?Q?oFT4T34f0xG/4IZfWRtGjjX3AMSNan+mI9M6J6GMghZVHtkjzFcTMDj9Td?=
 =?iso-8859-1?Q?8WGWpda1wn7V7Kj2G3UBZjD4YnaFZTtV6XIxWPONwO3tyg+6zJWSwUxVDu?=
 =?iso-8859-1?Q?9ZHeJZzgAR5xvXjXymQJv3IVtRXHFYmLpv8HyAwz69ySwsskkRkuWA25U8?=
 =?iso-8859-1?Q?qHBxf26Cf4rm0htI12KkH+r1C051hSO4GYalZEkGR2o198Uf9rf1nEaisr?=
 =?iso-8859-1?Q?BlndspO8Jfh1QuMfi82Uc++so8kYnSpBeJUkIC1zyq40i2IRH1YhVE/XoV?=
 =?iso-8859-1?Q?5OuztfgK7ol1VFcGKjfJk7ldR9GcCWJXpk0xhPkcu20FKKppekxFcBTfXx?=
 =?iso-8859-1?Q?v+Rk1KKiqPm6dCrR7npbdzOYwd4GyTqj33H6jo7a4O9PFt+D9vtZEamLDM?=
 =?iso-8859-1?Q?Vr8F+Han4b+uAHg3EF4NtaAxiGheeyt66+Cu38U5wxtoHbWnH4NR45gxE9?=
 =?iso-8859-1?Q?jf66J/B3jc2CqkWK672BtFWh/BQ39qWXIzvJf2AJWAZS78L/8574pDrDSm?=
 =?iso-8859-1?Q?JlB6PobaCeO34tz9DWC/Shn4CEhhYTUPPuQNM/3Sjnk4Xa/eYBqxqRwT7e?=
 =?iso-8859-1?Q?WQ?=
x-ms-exchange-antispam-messagedata-1: Y+smydO0QXBdDw==
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fc14ec3c-8668-416f-1544-08defa047b17
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 13:03:48.4944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HosZanxNbWdt7kuXD+mZIfcdNpvSwnmhkV4HYXjNN61WudO5wzOr62UznjPyaAg5g6b4Fgh+wnVwICtJCFKKYMmjqi7mXZOGTIzyOa2XXLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P189MB2649

> May I know the correct way of getting the latest net-next so that I can r=
eproduce the same error and patch on top of it?=0A=
net tree: https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git=0A=
net-next tree: https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-ne=
xt.git=0A=
