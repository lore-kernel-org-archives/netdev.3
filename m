Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011056.outbound.protection.outlook.com [52.101.70.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2E73126A0
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 01:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785546880; cv=fail; b=KEUzPNOLWYA6+Sytpt7gXIdyhnt1x8vmaluB8xBDBC68LghKsJK5kkz1pUo4iVBAYs/WSluHbfqKjfy374IQZgjU3NonzWAC/GQJ3sa3fHVr9o6N+42wZMk0M6VlsY2UXwA6R8UQVmuTbozZXRBQNRVd1fRKYrCKPZr9l4Ryu50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785546880; c=relaxed/simple;
	bh=kdE46RsZwiWi6ferhuIJckje4G/KzNUBw8lJM0t49ZU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A0eELuiDvdSscQcFJf9KGwAB4hpgMIHUBfuqwfAHLctG/Ty5Kz79dF1bdvjzM3FhxAG7hDuAmqGTjyZzWHAXs95liBT9z+InS4KGMmwL9BeIPz0UkHF0HdewnCSe+YabkQdYSj52U51cSteqa7QT34hCBX/dEXj47pX4R1Rkj8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=0PMFzTKd; arc=fail smtp.client-ip=52.101.70.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="0PMFzTKd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQnjGTpdc6+Nx4XzFW/Ot4qLcwi70ibOJqiK2Kj4GpVi6Jlf5P1JRNfXFoY6iIyHnGmqq0vMnYr5XTrD4FNIXZW3bWIpq2PxZqA8GNi3PQLSo++OFTb+NN6fXJUTd0PTLqJ6Nryf/VEGH3mGFZZbZce9+5sJLt9ScFy+XaOu++9VgDQ3jWmwExatT4azTrproTcSQOW5++YN+KTixdYtTHUm27EcgaiEzd4PPtw8axABWdIa9F2wh7Kt2+SPGFX3mugF6NGLcCQ4JTsFFCfdoNiERFRcynFIxzBRTAulLM2lkq43ZrSLSGA8PBQ1AwHjr+46rTOLyNkk5ifUiNF89w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdE46RsZwiWi6ferhuIJckje4G/KzNUBw8lJM0t49ZU=;
 b=wgXyQYZoZ5yp3TVUAkwDcB6xnDB3uUOlxlxa3uzAebvzwHxEY6kraJBm21AgQKdkudKhnrhGzyb0vetzI3l51M6rBNPufg14LeiwePlwfO8mo7TVglP5Jzn+2dQKUkWqaxjShsAJqo3xOFrBdhU72C7JiVe2uI3miZ1/YpI8a5xHAtUrNg3qq85RcRlkaTnY4OQb+UiXhnzovkFqLhng3A1CeBPpzXmlC0taDpsWAssKOFGTUmt+EyhzHb4QFZzcGx4umZ7qQD9Y6utFMK/ZD5aQtABPKwNTz4EdD8l8tdSuRgs3Gk98iL/ArPewXGe0/nuAHsN9Ix/nd5Z/Wf4uOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdE46RsZwiWi6ferhuIJckje4G/KzNUBw8lJM0t49ZU=;
 b=0PMFzTKdsQ6OWT/SVdN1/YFVz6k8QERlpwk0VwhmUMoqiiV3qtdDxJqmx6qK5urdm7A5Nmzl85FpC9ZjOFdcuw89A0ry+P4im/pUrII9LvZfagNRJdH3rl/xAAkpyLZyWFjzmXyTjtzIYF9jhoZ3QdNSWh1fviGnCHRP1cMtl7PHGX7JdJFoV1Cl3zd82aljamShyzNBac9Ang3TjcaVqn4rZuF6DH3mNsaVSdFpxQ/9Tw5rIdeBNUMxMoH1WkRpwPkcpZK7Ni/z7zhuHA/s5+RM2QqnyCBgQ+zx7N79A3ySLjMwuKlL3Uuv3S3G8oOf0XtIJId1bCL7Vw4vjSLiCg==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 DU0P189MB2153.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:3c8::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.11; Sat, 1 Aug 2026 01:14:33 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0292.010; Sat, 1 Aug 2026
 01:14:33 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "jmaloy@redhat.com"
	<jmaloy@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, Xiang Mei <xmei5@asu.edu>, Weiming
 Shi <bestswngs@gmail.com>
Subject: Re: [PATCH net v9] tipc: fix NULL deref in tipc_named_node_up() on
 empty publication list
Thread-Topic: [PATCH net v9] tipc: fix NULL deref in tipc_named_node_up() on
 empty publication list
Thread-Index: AQHdH/4zBKQ93iAg8ki4mbPGxuvo+baIYUgAgAADwyY=
Date: Sat, 1 Aug 2026 01:14:33 +0000
Message-ID:
 <GV1P189MB19886F1063E73EFA1675DF99C6D72@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260730083407.14915-1-tung.quang.nguyen@est.tech>
 <20260731175650.0ed418f6@kernel.org>
In-Reply-To: <20260731175650.0ed418f6@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|DU0P189MB2153:EE_
x-ms-office365-filtering-correlation-id: dc237c9f-83f3-4f6c-424b-08deef6a3eec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|10070799003|366016|1800799024|18002099003|22082099003|38070700021|56012099006|10067099003|4143699003|11063799006;
x-microsoft-antispam-message-info:
 LKQz3PErNWHaNjOrDjhZ7OQiFOH/cgXFaELd3eXYZAeqiNR9kKGKTSYRvVhckjMUX57w3JI9QuwUNOAW2z+DhGyqv4cb8Fxc7d+2CyjhK3pvzE4jyW29IV02cDTedIVep/zpOQfXqekA+9BREmiRkHlGNxd2572TXlKvce2pVsWClODDRIMRP+HNSOhFZwMMSrZTSdi11ZCfQErSGQPhLWEWZYqqC/bWaR7RsLXY0bHm+Y38D8ywiAz7J+cSzHXpqc5fSBnWtcBLqp5TcqF5HYQLlHO0I0gIlPgIzG56S5KOE5FYhTTG+sHtoWWaCHGe5i5KPOud9w94b4RN9/HU1rksLH0dEqPF9EQEZmgH/vdqyPkwKYG6ThCrDmetJukYvHPDeGsF0Giy55fgQTor3xoWQaORlhKtjDfn77N9uxJcGC2pHG7x8SA1xXgrKqIFHjqeqju87PpO/kgaTv5fPlJHQvOKtcydm4osymj8Q+Cdwfe9lgHdCalqU3KntUXLswmzoR4TJBrBF1ga+SMgGrqUrPZteQyLxklQXq/CbYB6YF77AZoLPgtZJv0PUl6ve0vmNDUX+x3gtLZZXnzW7iEBw7Q0SP4vWU832tJhKnNA9bZppyl8B0mrBgFRDWO6PlW3C68rdeDUHXzmLlFIhq2UrbaMRD+X70ypSyK525E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(366016)(1800799024)(18002099003)(22082099003)(38070700021)(56012099006)(10067099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?M9Kvhab4FnF7gl34jkeSeTFM32xyKyc1besewmUrq2yL/Q6Rh+gSrch4P0?=
 =?iso-8859-1?Q?i/0TZkutlLjOcPmTEJBmHK5WPhalJKXxSmi8FMuqKqjPMIQsS7HI4gUcga?=
 =?iso-8859-1?Q?+yFhSNlwKA/2QKEJigdSvxc1jKvHtX/n4jDVAkw+GxudHJrM+bgnamfeNp?=
 =?iso-8859-1?Q?L/P1MMCBVSQiVigf/BYYlZATE7FFjqxVDur+s9dkC8lWhUwQwpl9XXA97Z?=
 =?iso-8859-1?Q?/W1Z72LoJXD0Uj77ktM3xlT3A/Xjt4HSpp4xWOiYSaVJB6I5mQGwlBHhZg?=
 =?iso-8859-1?Q?R4Ks7zb7cxnBtZS9sHYSiSJfZtK/3EIOYMK+0pMSo1U/ILIMVXG56TY8O/?=
 =?iso-8859-1?Q?C7MKSdJkXbKat7wYip9pgiUAL4P3lbkCYtuXO2h16ApXGjTkQfS6pJ6vj8?=
 =?iso-8859-1?Q?qbcai5wyAsCSPnU7klzxgObokn0os2mlqmHRQZ9G9OcKWT6p+q7iEcsZbe?=
 =?iso-8859-1?Q?yHXcU8l/ziq4e02/+okSaIlXx71N5/3VmwsBHsxfjOyR4saAFv2pUbana7?=
 =?iso-8859-1?Q?4jfEP7JXANpKuSXYJ1jTvNcnRr6qf+XibqeQpI4E3ypmURGU954727BwKb?=
 =?iso-8859-1?Q?nL8h2Uzh4aTXqS2vfi5vOrEi9OrmY8JU8+fhyaQ6eIzvuGSWVbPjT6nKzu?=
 =?iso-8859-1?Q?hV39GnSdvKjePIhPOuVx/+EyvvGwiPEOQvjxuVzClDuMUJAJyWzDBtTzIA?=
 =?iso-8859-1?Q?RLDdstw61QGoJ9JVb2C2vnsL7fcu2Ue3otPfE1R2YGtgtao4VfaemfwA+C?=
 =?iso-8859-1?Q?SqnJfxpx8Jfwewxe/zAu1VY6sSSsPeWK52NC1jUdNNt/qCsMHrve6LoiQ6?=
 =?iso-8859-1?Q?DYMi0c85yepcD82FyKv/dM9nZwTJI22/+XHFltEqTeCKWfzk1oRuAPSPqp?=
 =?iso-8859-1?Q?nAurPQYWxXyUX1RwadASHouyqOc/7ZXxQpGk94N/VeipXNvLLS+Lp/2OE9?=
 =?iso-8859-1?Q?z1IiOGMJ3PhMYdjUTwPesjuir8OAlcLJTRdHWSS+yJCUv2YoZHPiXOHpEU?=
 =?iso-8859-1?Q?8Q/e/BAgJRJeMW/Cayko6vwx7KO3K2LpVRMk9rhmSkd/b18p3mHgA2rrjC?=
 =?iso-8859-1?Q?mV9fuYPXUK5Jqs9xS99YG2IhHmE66tiShKg9QPivDVTZ5zI9eyiz69u7uv?=
 =?iso-8859-1?Q?+vGhk1SD9cRgb1bEeFMcnXbIYgTPFbwxPxf6zVpwTA/9n04287HEN7kY6C?=
 =?iso-8859-1?Q?3jJxi/mO7BXAnZSnh5kguZXfopq1y/NU/rhEuGAjsDxfXy10franVzHqi1?=
 =?iso-8859-1?Q?jqQ0HM70e3mvTmdHmXyOtzKvu1/G74cwfSh3auAiec/NbH8OYy9xFdd9g0?=
 =?iso-8859-1?Q?mRkJMJ95/RsfL9ivwucc/lc2uV91XL2LYM+5pfsqIDA7HIxlqGXq7m5pon?=
 =?iso-8859-1?Q?b5PIxT18iHa9OrHZqkamM7jpxf4Gc/qzJPjSbRZCP4jI0JGQsGJQj0kuVV?=
 =?iso-8859-1?Q?fU4qHC/3Fr0h4JvblEYfLs+cNJrEcMtH49AsPq4VQCrRlSJc6u6cl7fSJ9?=
 =?iso-8859-1?Q?A2LBVxwCLPrjFyoajZlMaJhWvFEvQLbLizvtRvFr+0fmEjDat+CmrQSYJA?=
 =?iso-8859-1?Q?HLKY4son6XEqAlplQysmJ3p7///bQCYLUa+vI1hKJRUpbBFzKT0/GwQ7bP?=
 =?iso-8859-1?Q?6WGnYTZqLnxBdwbgcqoe8fiaxI8Q7ehdkY6xmvxzTtfd+COoAFQHwxkAhW?=
 =?iso-8859-1?Q?0g7baLPSPg3groLzdmu+ULLqItnzGpRPAJRi08Qlu1tL4BtTqERLMvFMwn?=
 =?iso-8859-1?Q?dkUjWY7CKawWUfRfUy4T/sofnFfJwOuGBhljY45zRBhKLJmSM5R8JwyHaL?=
 =?iso-8859-1?Q?27Hm5YDsDXR66bzIItg5Z+YT+83tC+iHRmje0LaJjkxAod81DWK2A8ZNUp?=
 =?iso-8859-1?Q?mj?=
x-ms-exchange-antispam-messagedata-1: LXK0qtBeP4CTUQ==
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dc237c9f-83f3-4f6c-424b-08deef6a3eec
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2026 01:14:33.4041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7tqJ9qA2O4Afr3CLEEpPQG+UDLN4UxM6K9cd7ybCyrUCfdKO6DgbbFTCA9bsBx1W/EcqJqHWu0eOaKmUCqV51k2qrBTqEcbQuBGIpGnFyL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P189MB2153

>Sorry to nit pick but for new code we ask that kdoc -Wall is clean=0A=
>which requires Return: statements:=0A=
=0A=
>Warning: net/tipc/name_distr.c:151 No description found for return value o=
f 'named_distribute'=0A=
>Warning: net/tipc/name_distr.c:208 No description found for return value o=
f 'tipc_named_distribute'=0A=
>Warning: net/tipc/name_distr.c:237 No description found for return value o=
f 'tipc_named_node_up'=0A=
>Warning: net/tipc/name_distr.c:270 No description found for return value o=
f 'tipc_named_dist_cluster_scope'=0A=
>Warning: net/tipc/name_distr.c:151 No description found for return value o=
f 'named_distribute'=0A=
>Warning: net/tipc/name_distr.c:208 No description found for return value o=
f 'tipc_named_distribute'=0A=
>Warning: net/tipc/name_distr.c:237 No description found for return value o=
f 'tipc_named_node_up'=0A=
>Warning: net/tipc/name_distr.c:270 No description found for return value o=
f 'tipc_named_dist_cluster_scope'=0A=
Thanks. I will address it together with sashiko's valid comments:=0A=
https://sashiko.dev/#/patchset/20260730083407.14915-1-tung.quang.nguyen%40e=
st.tech=0A=
