Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013039.outbound.protection.outlook.com [52.101.72.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9F34B04B1
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 02:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786069955; cv=fail; b=iVunaVWbZ6+/t3vNuaTCb/UpfkO7tFhlwXG//ZePjNI9HFbKqKPnCNrwKpE/FhR0LF34nT5atAtD5QeciyOMN2wyzxFqv1oSGdTKhkkB81UHaIls+rWkr8xXPTk+NtjczDUg8HjWqHL30gaYWyXumnUr8PIzdlxEOaoI6MWkEp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786069955; c=relaxed/simple;
	bh=ghDGzzfpTVyhDKkCg6pAJe8O2Zh7fZZA2/6PefwzKUo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bAQGE2b7zHbl0J1qBnsTBZsVKYqvQUMFiBFI83Mr6GXuIhD+6lEuaKVv/Y3KXBqqDyK6rk3FV+G4209D/bXo6Esj3p6OIsobyEV2bqESBmgdX+Ba1dmq8LlVvmp/4juRUyn4eVdpK9t6sJIMxy1XcaYhep4dZ8ym6JxilIvCMLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=SXTI1InU; arc=fail smtp.client-ip=52.101.72.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="SXTI1InU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIBMa/MbrdPn5wacTGF7vofWnfIrtVAjTQMhIBbBFB9lCwsKhYylqm473zSWwLJlKoClh8SOqChdzDrglPYiaF76u1a7rz9PuRLRMHJVDGNssEqVPJ5DwxGOTcMtWqj3Wyc7OHZsj4Ry+W3BKobT9HWR9dsdPk0qRm3bdbCObhohk5Wb7RwGIuBkx8zxRujyxgFVvCtPGqwaFk2hdJHPE/wIeeH58LevWXPMQObUIkhxc1xDn0vhnBT20tehak6kNZw+HsEOzzNtqpSemSbZTiliZ01cChoQbOev7Xr9BQQUHyrZ7/M/2fZQmwZpd1sytP5ReHndBjEnQxYBGZ/4Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpvbHXl5did+/6STlc+lzqD1DPgvtEBnFUgfQ601PeY=;
 b=Ilvs4m1rUsg5eWi+Wa4Nze2tLwR1xG66TCaYOmAby1C5Iy/pxoDC/Phr6wc3rf11mzo4Rlh+SeCnQq62kQsDpV1k90MTZ71S3WANPz9R7xtQVAquVAVZ3Wdltpk1awGEsXj98NP5wDsYV6G+kkFwxaKnE8JyCPkibENRwASF//jpLwm90yZLl3bqWKBqy2vgR+sgD78Vv1KHUQoCWQ16EWBOYqwL1ckj040z28xQxyI/We+sKQLPpd9xGTdW0wz6tRvirkUP0VVxefyuqPEx9sjt+3woTpDK8BOep1za2/xUjlJKEkUs1WsrA6sReuWvZGK6E4IFe1OnLegRJ5GBCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpvbHXl5did+/6STlc+lzqD1DPgvtEBnFUgfQ601PeY=;
 b=SXTI1InUJNZqn+P4iJJfrb8Vsn1hKplJ1D+Lrbs5ilPt8kGPnGj2w502PaqAet3SKn7AokWj3gCYR803p5lk1yoRb9YtVS6kOSQ7Zl9lZ/j8sfhQHaIUthX9SW9ehenvAQTQUd8SS0Y3wezkmPizyQYy38jRpyoj17c7W4lUj4PzkpyC/zOKnSAFcO0CUfCssSe/fI6Z5wlry0fdm25v+JBuRu+L1QwiQe8m+MMBb2eoL1gISO8s11VB39zM3MtRSOooX+VJ6VGK3XuMWoY5a443m6WkmYUW49sp7zEcoNVjGnq8zndqXYJmipPMG+Mo7LkBA3a0QGQHEXpJhNih3g==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 VI0P189MB3174.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:2c6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6; Fri, 7 Aug 2026 02:32:26 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0315.008; Fri, 7 Aug 2026
 02:32:26 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "jmaloy@redhat.com"
	<jmaloy@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, Xiang Mei <xmei5@asu.edu>, Weiming
 Shi <bestswngs@gmail.com>
Subject: RE: [PATCH net v11] tipc: fix NULL deref in tipc_named_node_up() on
 empty publication list
Thread-Topic: [PATCH net v11] tipc: fix NULL deref in tipc_named_node_up() on
 empty publication list
Thread-Index: AQHdJPVxU2iy4kpsx0iyGvzWdnF+ULaRc6IAgABr2IA=
Date: Fri, 7 Aug 2026 02:32:26 +0000
Message-ID:
 <GV1P189MB19883E37232698C679E7CF5CC6D12@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260805161356.193230-1-tung.quang.nguyen@est.tech>
 <20260806130424.62a59734@kernel.org>
In-Reply-To: <20260806130424.62a59734@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|VI0P189MB3174:EE_
x-ms-office365-filtering-correlation-id: 5d4e4014-8d85-479b-ea92-08def42c1eaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|38070700021|11063799006|56012099006|10067099003|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 cVhyo3ZkiGepkmGDV5DA9RA+hghrcwbkIb8c/NR6GJjdGa+fCqJ92xdUR6+ASgvdP6kmCELhVQ30qnRegjqPm6uRKSWR+xunOcIM7KjJERMjTJK8d3IdI/Moz9bVjxlm8Hzmw7hVrMljmA+wB/SQDWL/0Ojrw5h4TRZrxCF5vrcsm6TXm39iaLxcmMzGXQjUpEUEsEAKcvtdNUD7StAwZwFKWsSf32yQFY4Qs8lrUt8A595LRZN54DN1qjQu2qjR3zGQb9Ed3yMkfNy73/kkOcRVsL53nM1W88cqVIgG8AmUOD+v+mw7xdhtXyTMdFlVTJU/64FuMZPHfyjt2V2v0KGeUnQ99uLWRXxbdb6wQoreLem1MFNjtNfDYigQ99e6Ru5jLvHlQk7OSsBeUuoaeyJ7DbHQTN7R1TCR7kERAEHCym8h/cfoIrpuhegX1vNolWarQzCnlfGTMGdSxcbE1YKEfVSAZ28g6Q9T5ztLNZKCu5LWm7cGKGLrgSN7HYiOWYMLE8AYY907b4gfZJUiMKtgg4Evylt5Vel5lz7U/GOkjU8+icHj9WOtzr1hfnp2e6/1qsxb58rYQlvwNY3uXDAWlev6uIz21dDtUXpnnv+B8FJj+Q9aZFlty4IiIyrBFhQv6cFdVN4s5O8Tloya25M9jC4m6T/bw0R5R7WXr1mGVVMFFcC59hhkizZlErBnfTSFM0JYvk3l1ic1rELN7lC8vErYTFiT6Wf5fhA4Hm8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(38070700021)(11063799006)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?p0eJXyqPD42cq2EnxHR+im6vIC2vKAUL7GbXF6aaVmNk509Keu/YZhR4jqoL?=
 =?us-ascii?Q?44uytcPIvLfYAMixdi06es9Mw+G7hu3q7rYEfpcwezlSnLORU9VHpVsNgBDr?=
 =?us-ascii?Q?BKVyt2jlF63mm6btdC2ZVSCJbN4o9FUl4ImkvV0bwnn8y7OWCRpRFK47yXZm?=
 =?us-ascii?Q?JMPdctjE/dPwAQN3dDOG2Syq72GlqxcTW9vhGBssK6vewcsahrsrBKohl0uC?=
 =?us-ascii?Q?uO4RpBwhC9ZQ63p+7+i386AAOSAsglqkiZV5e+PI2W6nwOqXWQFXH9jW742j?=
 =?us-ascii?Q?vD9csg8HxWG9Qdx2W39Eip29K+LG3JfryfTL2GhTf3pS3I2Q6yKsXgDsQUTa?=
 =?us-ascii?Q?AWD7nY17Ce7G2AYsd5SvqIvaqtxuBvVcO9bRvlmgesqzPNYdYz6T36Zvr+wy?=
 =?us-ascii?Q?j7t5q3wIXW+LJiBUXH1y4hXQVllP4YakShWkF1wvMnVTksE1JcqXhKW+AJiV?=
 =?us-ascii?Q?qf9MYIsqqWOUXcpcXL1eluH83dV3OuHh/8z4/VwM49T1k5L/qEKvmDehAmLP?=
 =?us-ascii?Q?LgL/k2r6kpmv9MesMQ4RcUSDlyFbZgvrp8gUnZ8fOFfOlU2PCL6y//fhqMOo?=
 =?us-ascii?Q?pw2yf5g/DzTr//lCSxx9b9adgyM1A/2Uz/0LDRVo310r3iSukmI7cLSZFe1M?=
 =?us-ascii?Q?5IchGONJ0INGSXcIow2ecM9YrtS5YRU/xMMOqspWvsA91kGR4/a1HiNUXXUR?=
 =?us-ascii?Q?xfm+Isttyby6wSHD5WVM+TnW62TSlvGoVj5n0vHSjhgnWghKiqQr72F4hcHT?=
 =?us-ascii?Q?sJq1/hQB05EYG55o0R/+2bAO4VQCxvoghGAu7ZS7hscer+fMeTeswHBNTlCx?=
 =?us-ascii?Q?qQ51RGX4Ye8Zi+o5x2AxqFd77sfXHRfpZR/8RinMhbHmlLq/CouGDaMPd7/2?=
 =?us-ascii?Q?4nTLiu1Djg8ukbz/C0/R1mpoM7b7p3bnQtPv51VKxvpJzaTASvIuKvigdMr+?=
 =?us-ascii?Q?HWYQ+s4uvl9cEHgpXknSAF4jhpdUFzNfpVQsBUnEhISBVglZqlxuYFnhQ7BO?=
 =?us-ascii?Q?v5zwoFPtw2UvdhO87u2kkRXHxtip2/c8KeBeDUGrVzcegbTF3nIaKFCaMxvW?=
 =?us-ascii?Q?q6IIt+BsEkCE61+iEWUiiyVlNkiZOasb1q2A3I+xSVq3cdkNpzVaqkAe1b9b?=
 =?us-ascii?Q?04qXuGG3UDugecHeMx3ChvjPxH4yz75SPLya8xd/3O3uzjkqhqnA2d0j/u8d?=
 =?us-ascii?Q?6z1t3hUKK0PCZdkxVsrirbfGbN/FYFLffV6YgBmqKymmj7XGhFEghik1KqSy?=
 =?us-ascii?Q?SJhqPQkeDwJzQBiLiG+SApyhlfFRSfnI900qFSZG5mP0/Q9VBQE5wrHst64T?=
 =?us-ascii?Q?hwd5ItZ0AFFmnaSVdj6OhG2Q1Rt4UxolchoG/oYZwkpubtBq/k2RcvR4rIxp?=
 =?us-ascii?Q?VpRKuuX+mHeZ9hpRq2beHlExjNpl+GVc99waXfkkKPY5ileKbSQE3C9/1PKe?=
 =?us-ascii?Q?Uj8nBHdveikhNu0bbNF6TZMGp8U1mJf2SNhT+Xf5U1scg8330i85cENpCvAO?=
 =?us-ascii?Q?v2Mw6wd/lDyUhzI7PIC+qrfEBc4CXWcRS/xeI3FGq9KDp4OhYiPF53+bw/tr?=
 =?us-ascii?Q?R6c30VJY31eM+G8SB9IbBbgN3LmBU6qJ8fsqlGb6gjE6Et0R8KtBVxwP0aPp?=
 =?us-ascii?Q?ssaH+HWnxEwkPpePeMpDrDXSD/YSy60mj9vS/tpoEnJLc1Bv7pF4+EEyT5f1?=
 =?us-ascii?Q?JdYG4uUPKU436AqDPLx73Zgh5WR0iZpzudBM0GqviVf6dBaVdGoBf6Y2//KQ?=
 =?us-ascii?Q?W/mKHm2VpA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4e4014-8d85-479b-ea92-08def42c1eaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 02:32:26.3011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7QNo5tS7SYc+Og1NK6QH0JxbXINSwyCe46l2vKoDRWSzSDq57gUScZRv7nsGVfKZ3kRVdur2AMevWP5MFysYG+c0cckWaYFWbC0JEwJAG2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P189MB3174

>make htmldoc on the testing branch flagged:
>
>Documentation/networking/tipc:184: ./net/tipc/name_distr.c:261: ERROR:
>Unexpected indentation. [docutils]
>Documentation/networking/tipc:184: ./net/tipc/name_distr.c:262: WARNING:
>Block quote ends without a blank line; unexpected unindent. [docutils]
>
>+/**
>+ * tipc_named_dist_cluster_scope - distribute all publications to
>+specified node
>+ * @net: the associated network namespace
>+ * @dnode: destination node
>+ *
>+ * Return:
>+ * 0 on success
>+ * -EINVAL on failure, insert duplicate publication or reach the max
>+number of
>+ *  supported publications
>
>is it this line ?
Yes, it is.
I will address this together with sashiko's valid findings.
