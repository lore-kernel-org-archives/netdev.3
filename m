Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4090C2FD1B3;
	Fri, 16 Oct 2026 00:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792112147; cv=fail; b=k6DTlREsK4c0XRulxzQwUTwM1TBQNfbduptgeA4LjkexlwwUaDni7yAJOgYMBzezvEFvC2N9ZfV9oNj3PHGb0kO8mf+kFp4I9KzhNNcuEuk58JvxcKZWnkRrEzXqYKJm1zm2fLFSJSI/WLs/CLoq4wqTKmMhMt4QaOc2Te23IqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792112147; c=relaxed/simple;
	bh=3/++bdVN090GU6ugg3ujosOjA/gNI+0ClxU93KaV1/w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pjpqo/U0p9QdtHwR5ED+EYmQWNpxrg73pZUtHWou+TLHoHpqYs/LyB8t0a07jVhO842FDlBXoB7NJGdHcrVUYzJrgd3/sLiJ+zxTg8TYn/4JjmYrn++dSpT0tUH9xQqGY0NEMMwTt3R5dRTKKb0i6KtNE9cmfBb5gu6ok/Sk5Rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=abX75KNn; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=dYOR0Eqv; arc=fail smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="abX75KNn";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="dYOR0Eqv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=3/++bdVN090GU6ugg3ujosOjA/gNI+0ClxU93KaV1/w=;
 b=abX75KNnBujfFmd7vOm1Bwe578dELGAzV4Sl6mtdpf/82SKGbvLiPnkbGfzVbLVqs+vb3zvqROCMCP1pOXWy7rn0vHQqwrmu/aPGLBPk3Hw7AW/05ZrXCefM6torMKNojWGv39lJuXPi0idUpYi+u6SCvRwGIRM375ZlcSrj5vJG2jhig1E+sAvYwYh00YiLifoxA+ILYDp86d6C1qwgBPcLn9hcAHwm/wtceUgN198KTZs2PGb+hBSF+fBYAmvG/ghp0n/PL9WUj7mpPvMu2Eu1o4s9ONoxdclyCUGcqFrFA3VsBBlQlqAvESslXb+RWPjnomfraqnpx2JgT0WSug==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020125.outbound.protection.outlook.com [40.93.198.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 26423C0076;
	Fri, 16 Oct 2026 00:55:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xcwn4OYpoUHBDJie3MZYlX8wXfVazf70PYMlg8vaH1yNgyAqfmVlZXkDGLTb9Lik2yL3JCb3+Edbbi4ArgGdz4voHp3T39jCEKbUkyufFOUkLzIXqyt2NzBSSea1em9Lmz4aCHwtz+E73gaen/kCWJ2zgLsodQyk0GEAnOYmNykWdDDypHLTQ4TxDHjMz1ZtaRJ5xx7ViZs4tlhhv01lYVucGA3ay/PvD2DTDJZX8Zn+Ub6qGKQPmN04Rc34PAZl7nCdxA3XjiZMeZuyH3NhmjQ0IRa4Q4lyq07zl+OVuRyPTCaAnokIsW7ZnV49D0zKshDBCSUeJmAYIEGFDzGBJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/++bdVN090GU6ugg3ujosOjA/gNI+0ClxU93KaV1/w=;
 b=dK9ZRhRD1qrwge6ziCCqST3Uv0MyTsdWYqMne/8FuQqlh16BfJ3y9dJfZbkBDqBOW/B1rURglTv7+v2ZLXNBBF0M3B9JBH84FICTnEg0wKsPASIZvtTdz1WeoXbo/Ov40jCd1Oq/w4Qw9iyCRns0DMYzpGk8ULZgvEZ7m8XNtod1spvO8dTgMENfHpbGmWIxaaW4lMBEpSDCjvykn3Kt+RyTmW7sgeBIOkMdOBQwVMRwNNN01f0bXFzGMoAribFxaQt12yt0PGs6vjqV6BxUSAhvD0rYstgbGaUZiuqr+udFcyC55NBIXdj4KgL4zx1snHiptqAyrTSBmEg2cLDScA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/++bdVN090GU6ugg3ujosOjA/gNI+0ClxU93KaV1/w=;
 b=dYOR0Eqv0BNrbsxZN5LCPjy1pCHZPEN3439OcdDSojaCZKv7bcgoxkqh7brq7YklSzMGfFOzrzgzIGcdkvCE53LZXvdtnpgHuJ1eHeYyeDCS7yF9FYdDx18LXd54axBazlIFtVoqIh9GMgHp32KDmfs3gWilU8Newjh1XwNGexm10hlvAphRlL/HjE4ZUixc3x7CeCaQRWf3enrPTT1cH5QM896WFILE7J1raSkfL59vlLGXrvJ0Weu+H63skBb0rJWxqwMB63cA5gg0L8aZowERS5uLmv9Jui0XsRGw5MRqqPz2owkULbzYpZcKc1xL3H7VIKPA+To22hVg1XSeLA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by MN0PR20MB4789.namprd20.prod.outlook.com
 (2603:10b6:208:3c7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 00:55:42 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 00:55:42 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Carolina Jubran
	<cjubran@nvidia.com>, Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v13 02/12] dt-bindings: dpll: add SiTime SiT95316
 clock generator
Thread-Topic: [PATCH net-next v13 02/12] dt-bindings: dpll: add SiTime
 SiT95316 clock generator
Thread-Index: AQHdW2P/9ZE6kK9KDUy1mF8AMssy67b9o5uAgAG3uAA=
Date: Fri, 16 Oct 2026 00:55:42 +0000
Message-ID: <20261016005541.11374-1-arouhi@sitime.com>
References: <20261013224131.27149-1-arouhi@sitime.com>
 <20261013224131.27149-3-arouhi@sitime.com> <sashiko-outbox-171992@kernel.org>
In-Reply-To: <sashiko-outbox-171992@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|MN0PR20MB4789:EE_
x-ms-office365-filtering-correlation-id: cbe35ef2-2661-4e09-32f3-08df2b20346a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|261009223327099003|56012099006|261009223027099003|261009221727099003|4143699003|261009220027099003|261009221227099003|18002099003|10067099003|22082099003|3023799007;
x-microsoft-antispam-message-info:
 gpB1ttxbrB3Pwqh0nseN1WLvSvhj2E6QPr4vzCTZLhZNjC/aBEGEr/wxGw6xHI/cV0jq4HvK0JjpdfrxAZ4aL50POLNX6nee7+UPXbb9VuY2gjPGeYyk+4c9yNR0iabePPl5UI9m9naPViCAQgFiDiKYvIcU98qLkrTu+Ws35BQTVkG2y/vfU2S9UXQ0NrEeeqXzCBszfHuavxAvBrFDyMYOe99pjDkD3GvY+kPVZBU+/VTSU3BKg8sTX4v5f3eKhnploJgSRx2T5O5YWZ/Os14un3NUPNIax2s1Wcnp5w2GJIvpzLQNBK9PSJrCZ5m5+CJL8GGhfv53Z6zaaWGruM4tR+E1QJAFmRTt+RyPKs5R8VylnsjQ9Y4wQGJNS5V7L8Q2N6mQK5UUUCD9uS3h5BGMhPz7gpV8PBU5po0K5ovv6+n0Ry7z1g9D75LBfZOTs+JcNZNOmFp/6TnVVBO61Pn4VZOmO6jfb4hCeHyWF1VYlWHZHccCiJppucBoCBteWXdSxOGJ8ANbSqFRbHf9aFcvp3WdezZOenbPKG87Z+CHYQ0Ev44bapYD02qw360vDWh30z+Psv2Klf878fc12flETcmUkWvk+JNhsqutL6KesnxKyYvK9JV9u1OH0fpDWuevxc0ohIaUAta3q9TDJ2Pby08sfa1I1SRg9Ro1DY5WNDIQl8H+i51X+QX3ghzDbrKtr9Yd9JDanvRRppeAzQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(261009223327099003)(56012099006)(261009223027099003)(261009221727099003)(4143699003)(261009220027099003)(261009221227099003)(18002099003)(10067099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a2p2NWxiR3FaRnZYbk1tYUtsMXFYRGdXcTg0SU9Bd0ZTbDFvSVRsb25NYjNW?=
 =?utf-8?B?YkQrL3RIQ1JqdVlHVjJQei9PbmNyRkNObUsxK1ZSbE5HWElPSVloZ2RrSndY?=
 =?utf-8?B?NmVCelVGaUxhZGNzV28wTUc5MDllUDR3eVU2Z21vdW1aN0dGY1JjMmxsLzQ3?=
 =?utf-8?B?SnY1MENxSkhUS05MUU94bWY2N1NQam9VanJ0VGZMdnlyWnJmZC9IK2hnbXBn?=
 =?utf-8?B?V1JnWXJ6L2tUdjdNRDArRnkzNGNNTHhMSlVHK250VTRtMGRwMXlVS3l4UENY?=
 =?utf-8?B?c0xTNUlnbTFIQnZnejd2Ry8yVnhjSGtsYXFWK0ZKbzAvSlBDVzBGZjBHNElw?=
 =?utf-8?B?UTJRR05hRTlLVzlkM1hlbnU4dWcxTGZqVGEzdDNLaFRad0xyS0wvcEhoMGFH?=
 =?utf-8?B?ZEtYQTllVndVSE9PdmhVUEMzTWpTLzNDbkduS3p4OVdDSERqYUUzM2V1cVlq?=
 =?utf-8?B?Q0ljeEtsQll5UzE5VU93cG93bXpiV0ZaNGI0aTdBb3dIMzk4WmZ2OVQzcktI?=
 =?utf-8?B?cG5KUG4xQkpRVm9PNnZSSDROdWpDc3ZNWU5rNkhVRzA2SEpLVWJYemNaUXVI?=
 =?utf-8?B?NVVTKzh0cnp6SkVNcEFzUFRGZ1I5NVhkd21XdHZWeXVNd2FkYlV3RUVGSzRQ?=
 =?utf-8?B?UUV3TGxxMzdNZ0RMVHZMdjRzTmY1ZUVLbHl2cS9ZZEIvK1BwVjlwT2xLbnRp?=
 =?utf-8?B?ZEE2OGtvQ20ySTZzV1RPT2Q0dHJBbjl5elhCUzlsajBWK3JwWmxVS29VOHVC?=
 =?utf-8?B?OU1wTEZoN09yYXFTMzNmb0R3K2d2czBvSmhSVUovVS9aOEI2WkN0T0U1NXBl?=
 =?utf-8?B?K0YzNG9rN01hWmZYWW5xZGNYOHBZL2ZmaDV3THdjS2RiWWFzZVd2cnlCYTRP?=
 =?utf-8?B?azJZVUhDNEFUaTI1c3J2UnFXVTBNWElTYWRMUGgxaVJIdHE0UFhVRi9yZUtB?=
 =?utf-8?B?VnoxQUhYTDVQSmFqUUc2VGNsTmNEdzA1UmlEd1g2dUsybnlvNndBY3cyZ2Zk?=
 =?utf-8?B?aDYza3RlbVMvY0hFK1J0U2cvUnlDRkJPbjdSK3NVNkgxS05xdVZyd1lHanRh?=
 =?utf-8?B?K3FFU1hzUXoyemR0V1I1MGdmWlphbVo2VC9yM3p1KzYxN0ZsODliZkRwKzJw?=
 =?utf-8?B?VHRDK1Q3d0NndWNyOWhjemlqNGVrZzhnVXVNaGRFcEptWUFoZ2RVMWdNbHZu?=
 =?utf-8?B?Rk94VGFmbVNKSktiNjdvU3pnVWFkb3duRmJCamFyYTU1cWhRdDQzWlFrVVMy?=
 =?utf-8?B?TGgrMndyNmF2Snc4KzdsbE0zWThkbWNLNEtaVGZlQ3lmUmFTcUVxaGYyZWo0?=
 =?utf-8?B?bFNEdENZVzcrRGRVOGhtcWI0WVZSNkhhbFJicnU5ejZIRDRkRHJXRmJ6eHNy?=
 =?utf-8?B?VUJOdS8wTzRNUS8yVnlvV3BBZEc1dWZQYUpPL2IveHp6THorUDZsaDVIZitp?=
 =?utf-8?B?TTJzaElFVzVJK29YanVSYzRkY1ROVmRFc0RIb1dNbkE4MjVoZk02U21hT3JI?=
 =?utf-8?B?U2IyblNacGhWbGlSNUZUY0UyRFFXK3JrUzh4cFRWZXljcXF3RDhjZ010Sm03?=
 =?utf-8?B?aDdFVVRPV1k1UmYyeGlwYjMzRUl3SWlDMkU2MmhZajNRUTJaL0kwVTZIdkc2?=
 =?utf-8?B?bElXWDFhRkFlL1pHL2F1MzRFc0VkT0tPSnUxcmRpVXkwNmNobXBVaGJhaGpy?=
 =?utf-8?B?NmVRZXJKeWpEYkJFQWtoYnFqay9kUXNzNFZNUFo4dytsOFhVeEkzWmVXVEQ1?=
 =?utf-8?B?SGhyWlVlL0JoN1RlNmRMeWRlTVVuQTNhMWdWS0h3cFpUVWtXeGR5T2pvWHFT?=
 =?utf-8?B?YlYzVmF1UzJGbGFpUlIzUHluU3c3NHFuWWY1YnBHelVJQW1DeUxxbkxNWkhl?=
 =?utf-8?B?MHJYVUNlVmIyMFIwempNYno4YU15TnRsVkpRRFlxN2xWRncvZlhFNnZKakN3?=
 =?utf-8?B?VExQWlBqbG1CVkFTcmZFMkxrU2JFYTR2YnU5d2xZYWU0bTBDSk5ZcjhKSW92?=
 =?utf-8?B?ekNDU2FDL2s3RTVwTkdjK0wwUVBIb1M5VWpYT2Y2Rng1TnFROXdraHZ3cFUv?=
 =?utf-8?B?YkJBOVZJUXplaVdrMUN0WmlyYnRTTGtzWk5TcGZ0UUs2VnpjRTl6TjBYMEhX?=
 =?utf-8?B?NVhxZ1MxMVZNcmdTNnR5bno1aHA5dGNBdUZ2TXpmZyt5UTNxbFYzb2doYStY?=
 =?utf-8?B?SWRPZFhidU11MHllZGwxaCtGbi8xcWZWMGI2dW1PNWdQZ0xDNTNFQVRVQlNu?=
 =?utf-8?B?ejQyTE9PQktOanBYMndHVFNXOFdGQ0MycjNXNDRXSlZhOHlwME1JSzFubGZW?=
 =?utf-8?Q?jzauMDB3vjxCaF9i1x?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	C0HIDSzOE3jN9tDiyOA93sp2ZKncyoobY6FAzKxdJ37j/LEbsfM4F9tugUccgAqoJYOObjQWAroxO2VgDroOrSQTwdD0PWU059CgM5TopKO5+d8m/v7hp1r1fbUqDr9rWMYBn734W0JJKQpPGvTNWngddcD2y6Mam5BfF6elmduFVsrz1pVVUJQF3bD21ahBCjfvlNAK919Pv1a4oFFFeqnXXn68t2N6D5NOctYDf4JyBuHWJPeR3PVhQu8kHOdcS/voSQGoG3BpEIyOhIrkrUboloNyg0PyBEDBLo/rCMbbsOt1YRZGFGit4dNvilcRGmJkKX4A82EssnGHq3zhQg==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe35ef2-2661-4e09-32f3-08df2b20346a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 00:55:42.6991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nXz8e859dK4KTIz7316nDA9c4joD/CPHYAO2MzkdtaRu0HXocGErBadf3JA05du9M6I2qMKJ8JQTT8rqliqWJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR20MB4789
X-MDID: 1792112144-miRVlmdM6NDb
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1792112144;miRVlmdM6NDb;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

T24gV2VkLCAxNCBPY3QgMjAyNiwgc2FzaGlrby1ib3RAa2VybmVsLm9yZyB3cm90ZToKClJlcGx5
IGlubGluZS4KCj4gW1NldmVyaXR5OiBMb3ddIFRoZSBkZXNjcmlwdGlvbiBzdGF0ZXMgdGhpcyBt
dXN0IGJlIGEgc2luZ2xlIGVudHJ5LAo+IGJ1dCBzaG91bGQgdGhlcmUgYmUgYSBtYXhJdGVtczog
MSBjb25zdHJhaW50IHRvIHN0cnVjdHVyYWxseSBlbmZvcmNlCj4gdGhpcz8gV2l0aG91dCBpdCwg
YSBkZXZpY2UgdHJlZSBub2RlIHByb3ZpZGluZyBhbiBhcnJheSBvZiBtdWx0aXBsZQo+IDY0LWJp
dCBmcmVxdWVuY2llcyBmb3IgYW4gaW5wdXQgcGluIHdpbGwgc2lsZW50bHkgcGFzcyBzY2hlbWEK
PiB2YWxpZGF0aW9uLgoKQWdyZWVkLCBhbmQgdjE0IGFkZHMgaXQuCgpUaGUgZXhhbXBsZSB3YXMg
dGhlIHByb2JsZW0sIG5vdCB0aGUgc2NoZW1hLiAgVGhlIHJhdGVzIHdlcmUgd3JpdHRlbgovYml0
cy8gNjQsIGFuZCBzdXBwb3J0ZWQtZnJlcXVlbmNpZXMtaHogaXMgYSAzMi1iaXQgdHlwZSwgc28g
ZWFjaCByYXRlCmRlY29kZWQgYXMgdHdvIGNlbGxzIGFuZCBtYXhJdGVtczogMSBmYWlsZWQgb24g
dGhlIGV4YW1wbGUgaXRzZWxmOgoKICBpbnB1dC1waW5zOnBpbkAwOnN1cHBvcnRlZC1mcmVxdWVu
Y2llcy1oejogW1swXSwgWzEwMDAwMDAwXV0gaXMgdG9vIGxvbmcKClJvYiBIZXJyaW5nIGFza2Vk
IGZvciB0aGUgMzItYml0IHdpZHRoIG9uIHRoaXMgcGF0Y2ggaW5kZXBlbmRlbnRseS4KV2l0aCB0
aGUgZXhhbXBsZXMgY29ycmVjdGVkIHRoZSBjb25zdHJhaW50IGhvbGRzLCBhbmQgaXQgaXMgaW4g
djE0IG9uCnRoZSBpbnB1dCBwaW4gbGlzdC4gIFRoZSBvdXRwdXQgcGlucyBrZWVwIGFuIHVuYm91
bmRlZCBsaXN0LCBzaW5jZSBhbgpvdXRwdXQgY2FuIGJlIHNldCB0byBhbnkgb2Ygc2V2ZXJhbCBy
YXRlcy4K
