Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011027.outbound.protection.outlook.com [52.101.65.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB45325704;
	Wed, 12 Aug 2026 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786520853; cv=fail; b=WkpDKHoo83Yw5aFYNkexGpjMyCiTl006HqnhdPiqCFhyARlU0CaOGhZ9qmerM6pd56US8AIIP2EEwjnnruuUCRsqh8mYAVwr6U8mzU+q/nUV9w1el4skWKuZKHfibmDc33IjZuua256S+/Wz+1OFvXzQkY7CM2xEzN/0ySwoitk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786520853; c=relaxed/simple;
	bh=ic4SVwFFeQzpoYcz3Dse9Vd8ZNbEbpJDvV4tGDzATR4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T9SJ2ozkvbeibQs3LgXNZ9DtiYthzahQk58V7crF/04Lz9p7v9XPFZygEm28fXJdRN5TjG2dtQlPK2I9fXYFK2TGTQu8dexBfbVuQv/dV2hIGYtDEFkMObypXEauMscq+cttfWNQGFVgy9y6cCCFxY2Eu6xNz32RLRHazwWpPPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=IOeNUwCR; arc=fail smtp.client-ip=52.101.65.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="IOeNUwCR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SphRGGo6Z2AU5m/ldPJpUN0wWk7uS1ULLd1s2rxxOIHbbJIe5hpbdhqnQcmNrQ42sQwaQhX5zM9Svr+o4S98bso0SSr0cRwGRexbtPNHjjoNF/yqh3dMCH1QpmxQaMHzgzy5ThvW+lZz+uRPy+tBd5uPNheuN77NNZtbuWyifX7wW4Vsf+QzJJ5vuPD4LlfZ6jpVHMAn5rY4V7hZcF/xXz/je9kqKN9QI+oEyHYIReN0RWBlDIkO2+QXKHmrp7NVGf4LJWouSIjhWumk/tIro9FiQDan5uNVwCDogVzLWdTfkyyQRk+OLnMfDZKZ93uTouh5HprZJqAv3aC31ZiGkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06r9YtfX0+AGYcx7YpQkZ4MfpRtnzYxBtEkm4nbzhAA=;
 b=bTmIxs55sKo1a38QSU7VeAUSvK6VvQKjlglRTEtffnZ4FRPBSHR1CjEyKNK0EPYW6HQZQrNgH4CZQD8xbN15g3wQPVg3D96xDyxLaUN21Ac4KA/iw3gg7BzZ87IyF7eTGOEIn6VOhpqC7GqlXkppgkb23asqWYuilpGnhFsDssfEKwF/f4Nazul096psExjii0uuRhjzh5Zzny/eE23T26/IduBfmI8CgBHM+vai3wbh6h3yRfnihO81UD7YSzpUKJg2+hamMDCfFBSbEi0QR1PRq2ErTwD7HJ+lXrZZwsvKY/DUDeIb+aoGgzzEclx7AhTcGfNuuNgEAqVovWXPHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06r9YtfX0+AGYcx7YpQkZ4MfpRtnzYxBtEkm4nbzhAA=;
 b=IOeNUwCR6urZfhPeRw8GRDiOYmKAQlELQYxsVfb4tJAmTJU3zsUZgaIl9opa2EDr43edI+qan9gy8g11ThtcNC//RSzdR0LxEHZz7xeqXo+vt9nE6BCRKOy0FOb5Nc/eerXqbpTfIaKOXXlyzc1+/VjKMiL+mJlZ7xIioORtrJWoJqtLfVLAAIejKNb3C0cw2LAtN85WwxFQl09EO8pL02kbDdmqWuvOQe9Y2yxdZkTCqG4tMD01HI+GtmYP3Oe8EpcSYATbdQLRBkS1xWZwe2sS4Wi6I48fvefMWOoWTKpacYnyJOxP+OwFKiixW9TuYK9NY2SJtr/5L4oMydLH/g==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 AS2P189MB2608.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5f2::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.12; Wed, 12 Aug 2026 07:47:27 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0339.001; Wed, 12 Aug 2026
 07:47:27 +0000
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
Subject: RE: [PATCH] net: tipc: replace deprecated strcpy with strscpy
Thread-Topic: [PATCH] net: tipc: replace deprecated strcpy with strscpy
Thread-Index: AQHdKWCHVqNiLQFDykqMvZZ3fZrjlbaaCX0w
Date: Wed, 12 Aug 2026 07:47:26 +0000
Message-ID:
 <GV1P189MB1988E14B7ED2564A4D8D0FFBC6DC2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260811070306.59127-1-ajithpv.linux@gmail.com>
In-Reply-To: <20260811070306.59127-1-ajithpv.linux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|AS2P189MB2608:EE_
x-ms-office365-filtering-correlation-id: 072caf2b-428a-486c-a5dd-08def845f467
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|10067099003|38070700021|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 NGxQgSWvqY07DSTG04BkQIdcdq/p630J6PjEwL08jvTr9DFqUTW8c3ktrw/H9HjXDb2eRGFpM4ITMs8MF0zOe2Di7/WCJ5BjWtOASM0fWti9kBZ+sWho+qpyejCzdSGEbq/LYfipJmDmkd9TMPJIWYsVpttB4/iY5FVsBzJ3DTFfTCIHJ3RHUaZI1VmW8z8/bAJ0w9T1fVzPDQvY0cr6Hhd4yvKHG1H5o0q985sJkbGsk7JQXsrYirBmTzB5IFD2vzOY98pgancdRHR0Tw+0OBwy5EY8IeXz7ZAP9jSa6mZxTGLHRRRWo6vve/UoQ9RtNrdXm1MHTj8UDL+dSbsNnciH6KIRK2JweXaguZPV74GHJ8k11UoSD44adyHTgalzv5CBxTXINBwEe/7tJLLR9EFmynSuwAne5RibNqNKAe3ZXhJp2qVrnJDyIWHAlXmL6Phw+p1q6mQiWPmGikBVbd1kR4ZeLRaCDgS+SeSfUwD6SNBhvo2RpdDBN/pOnLr7yvRdcPzgA5gTwZ+s/RePnAITQTIVNxC361Odg0be8AwfJS06436++0JlQoWqX49D2ykmmibkn+UliY5v/biRCLHTgOnz70NpSnVSA4FBXBhm5EbYNhTinyfuOGhkr0aAvmXk9ywi+XHxCEivaQj5dxkyPm+I7nwjEY3WavHwMIe2XwJDtu1I88jnY7Wxk99d9Txo1cGggxyaFQ+/6In5vc23upr8UMYYsn24C2v7/v0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(10067099003)(38070700021)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Kgyz4TDoE8ZlkZoi8X9AmhfzY4W1bcGQhafR5l5yfaZX90CuYllLnG/ExZSO?=
 =?us-ascii?Q?ysMP4o7qoviAxoHZheqreZ5tp1RcvRH4OjUJjmm6oSny6A6qaZv/hBDWfBWS?=
 =?us-ascii?Q?bS8Vdx/0kkaGKtH7N1EZPF7irkZIKcUiMplm32AvGtNn9gKuZbIv6ZQC/8Er?=
 =?us-ascii?Q?niVjxovhSle0ok7E+VChtepfjCcmz8cj5eyXulxJf51QFFTPud/nEUCaj82I?=
 =?us-ascii?Q?Sr9O9aFPuZn3f2UmcsrO3WCVj5wfyFhItTPGbNI84nddYjTKuhqA4ValnCu3?=
 =?us-ascii?Q?IuuNDSgUPLVZFF82gqZrJOgooMcttmsyOtbguJqUi3w6AjRjyXgb4EokjdK9?=
 =?us-ascii?Q?NHCc1xjZFY5J323olBVekj+tVB5WivLzl4LvRVMnAIi0sD+gP9c0/lwgJCla?=
 =?us-ascii?Q?xMVDETN6AUCPCS5S4A/mZ8lVOfR9f3wCOAlcNc9qGHgiCUscoGWu6QT/mWl7?=
 =?us-ascii?Q?YcLOoEYsfQxw91wepX+I5AZLpz+uCpoA2jbBbRYZjhyk6TbNxX2FVA5w+rg9?=
 =?us-ascii?Q?4yc472nQU4brP5Fxh9BvsnHgvujgCEpNvO3rSUTtWZcFkMBoUtZrIDaHhRUk?=
 =?us-ascii?Q?MeJl5sva/1RJA6xJ+gkk/B5cw3M2eVxvK3JrW2hn22yQjBkImHZJaviWD7RJ?=
 =?us-ascii?Q?3EqMhPInfD9UX2mGmFyMPmDfrb5Y8x7D0bMq/Ui/sswPos5hcg+MCcXo1m1Z?=
 =?us-ascii?Q?gETCoKRPDx3raK52vZJtTDjq4kwckkax4vGBDxd2R05UGEYTHSy/K8/oBpQK?=
 =?us-ascii?Q?+DXLxsSN93PNpjK6AAd4aABWLUNSu0iRhMzij7+Jth+e4avdtvnj3TxQgvEm?=
 =?us-ascii?Q?hWgRykgrdhHWxaDnt1JGbnKS/O4KruaydXfwTMQErreKAuFnac3KZ3lFK9CF?=
 =?us-ascii?Q?RBDdJBQJDh682RZ7GdlLjvIcVgIb8r7gYqENx+8jGksY4mOpoLWKGMFIAlIV?=
 =?us-ascii?Q?qNTMSP0IculO7ZfBP+kvac1VK/KC4DEEMkSRNcF92zNUPbLqDF51RWIBFjcq?=
 =?us-ascii?Q?sIqQCys1dCDG0mM/BXyjNeijgSLERz7a7jRm4YQSkEcncXZqZMKz48wjWbTl?=
 =?us-ascii?Q?gRMDxLKAbWspvJ96f44AcjDPBUCEM/Juf8bCxMETxAvG0srcM3G1/Zv4nIqV?=
 =?us-ascii?Q?aRgMGAaAXyVrL4btE0cmD0K9cDmiUFhk1W2SHf1vty/QsRK4+IdjMLlqQjxK?=
 =?us-ascii?Q?3v/RUAnIAd2AFeq87+3v2Xt3rw7E/bFSTkF9neXnE9LiShvUMNh+mn411k37?=
 =?us-ascii?Q?xGHcPAcX1RDk52PffPV0YhNm/pex/w1iqv2M4Rw+2Zcy8XQTGYE2yABe/R59?=
 =?us-ascii?Q?NsKCKhhN3jv0BYco19oj7pZ4G0Qvk4QD1c52sq9V/1zEE/7BmojGaa4NrZK6?=
 =?us-ascii?Q?Z0TN1PaSEKqLDGIpX0cJtghK1RsITq5wtBueS3ISmmPf1LJ0gut4umXbJsPx?=
 =?us-ascii?Q?lw9/y3dubuLDAqZryicvwesGKh3qQqgrK8gNLBu2E0Ym803ssYjHGTsPnMuv?=
 =?us-ascii?Q?AdzMOHxn5kV0kPdRIZ7sggaVKcgVYQYciHGvLW1Nu6PdB7PNubb7vXHiv8FV?=
 =?us-ascii?Q?SZaM+3L3EB3rHPF7SUDJh+vA5aegC+rchqV6IcVr4M0shEkVeoMrnhXOOo62?=
 =?us-ascii?Q?y58u8fY9v8D3gno8xs9zlQFLMa2icdqi95PfJg6d3aDCE/6GMTPw3GBbyKQG?=
 =?us-ascii?Q?SyMF9imPFLt04RebTM0smTxIsM8QJMGweOkyDmERVodqYZ/5Px2S2n9ubU2V?=
 =?us-ascii?Q?qjrxP4Wubw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 072caf2b-428a-486c-a5dd-08def845f467
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 07:47:26.9483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FHA2Uk+QgJlOgrhZsvIset7SLyffxxkGE0xL0KBJqgTN7MHpcduN2x2XVOTXKsPx6WA8og5d3zGUx9e1e1RiZ9gZKhxF4DngaIh5hS9ym8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P189MB2608

>Subject: [PATCH] net: tipc: replace deprecated strcpy with strscpy

Please fix the target tree name.
Since this patch is just an improvement, the tree name should be "[PATCH ne=
t-next]".

>
>The `strcpy()` function is deprecated and moving towards code-tree
>elimination. Replacing it with `strscpy()` fixes potential buffer overflow=
 vectors
>by ensuring safe NULL-termination based on the destination buffer size lim=
it
>[1][2].
>
>In `tipc_bearer_get_name()`, the 'name' parameter decays into a pointer,
>meaning `sizeof()` cannot capture the underlying array bounds directly.
>However, all parent callers allocate this buffer using the
>TIPC_MAX_BEARER_NAME macro.
>
>Replace strcpy() with strscpy() using TIPC_MAX_BEARER_NAME as the explicit
>destination bound length.
>
>Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcp=
y
>[1]
>Link: https://github.com/KSPP/linux/issues/88 [2]
>
>Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
>---
> net/tipc/bearer.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c index
>05dcd2f9e887..951bb474c7d4 100644
>--- a/net/tipc/bearer.c
>+++ b/net/tipc/bearer.c
>@@ -209,7 +209,7 @@ int tipc_bearer_get_name(struct net *net, char *name,
>u32 bearer_id)
> 	if (!b)
> 		return -EINVAL;
>
>-	strcpy(name, b->name);
>+	strscpy(name, b->name, TIPC_MAX_BEARER_NAME);
> 	return 0;
> }
>
>--
>2.43.0
>

