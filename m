Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013029.outbound.protection.outlook.com [52.101.72.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0369341754
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882271; cv=fail; b=rjxlIlC/hiNMmbGb1iWnuuaJ24eXFXWlDEE+2tYSqy3iy/eF7LnVwvC/dBHL0Opl18iEPPg0BA4YSQh0Zh3hCz96gpv9X7qWN/Wlsamcw7taAQ4icimJWPec5u/wllcekf/sLG9VPqlrs3ryeheQLxYgYGhwmFIw5crWpithGaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882271; c=relaxed/simple;
	bh=uaat0oHyXeYpcY/ofp+LRkuHAFl6Ydojwpkldw1Rouc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nTBXTmCz3PS/YhiGsH9yptpKyYVC4mz/yJS5BD+SpapC2d4n+l7Vpbx2ceOH5JTG9WuIwywZ73XbSOzmouqbW35V9wy9ztLyWBcYQi+IZ9ZyGAC1KNiWpL1Lv3gfWCjvx46XetCsJSJ4BIEZD2bPxR0XNU5+VD8pBE6gOMJaElI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=mTV50jWS; arc=fail smtp.client-ip=52.101.72.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="mTV50jWS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHAsZw7kCfgx/nJfsnMvweGpBl6eHVRq4nH0eXePsqT4PU57DzMILwJ4WV87HoICtGWmWwDngeYbuvxRT7k2rjtLgAmuYx/s2/nbItNu/kP6xFhO59HRGYXMr34xoAOgA5UpY2qxmdo81mZi8Ht61BAJJO/hJ4OLZxydqa9w9B2Ueo0cmkiUxKSustMHbfihvLVlEKoRuJrPqSI3oK479G1IOp/e8sVvyHYvYQVTb1H+MCkf8S70mEmjpnHtFC+q7n8IjLCuPlUslDwjeOqWVwuDIKfcx6vuDCbwa+WgVwa5KVkbU63hJxglksGihHgYWFErH0RP+vpwTOrBV1Q98A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaat0oHyXeYpcY/ofp+LRkuHAFl6Ydojwpkldw1Rouc=;
 b=ZmT4dtO1BtMtKS4nK2GPyMuosMtdvsMMStEcQ9SNdjCV/uY0Ym3PPmLuzgGp8T5BN5ETJJQzqVFdZUn84GbMJKSXFoHZj/PZ1M7M2mnwsChNIoz8ysFnkaeNmcgcmoY47vqCgUL6q/q7Lq00FI9s4+ez7l8HH7/+pcxpzuWF9TXbtddFVwzWhdrLYRtgxn7CnLcMq78p+i6KzxtFzqAuKnjFXDO62LQ1V3xkxeC3EqBmHYNrS6l+af3/n2XCypOyWW6hRrRLByssdZ7AVZ6EdK04bUz+uRGbrQv5HOLnnoXazrAdmrNAN0QfIHmFDnDsIP3xKJe2ZLWJcY0uFxMnXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaat0oHyXeYpcY/ofp+LRkuHAFl6Ydojwpkldw1Rouc=;
 b=mTV50jWS6s4M40yZNJl+CpB7SZRQbsG8vHgXAAM4H1dVM87DgSVKVk/Dbj9u+WO7+qXBw7RqKmErUZSpffRkGIn3+uBscRi15eiy6Itz/wql38ZijsJudzK5goRw+sMDwdPI+ovK3FL0JN6c1FtZdd7Tl7ti0hg0GphGkuYmXqGsLTeu8c7TtoZgjN/5zgehWGapP22iVWVMT6R+T6Uhs/rrR0Ma4VwwkW5WQFhdvTHQU/mMxYZdT+9vxNg4hSxQq8nMSIDLlgJAXTCLX9MZqHw5u5i3ej0n4yjATZ0cKY5dQ2vpTyWMO8YhEuwS73EPVEBkWmwRtMR+/W1RpNl2Qw==
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by GV1P189MB2645.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:1a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 09:04:22 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%4]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 09:04:18 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, Jon Maloy <jmaloy@redhat.com>
Subject: Re: [PATCH net] tipc: raise the minimum bearer MTU to fit tunnel and
 crypto overhead
Thread-Topic: [PATCH net] tipc: raise the minimum bearer MTU to fit tunnel and
 crypto overhead
Thread-Index: AQHdV+0taEaIrQWkG0iveC+sgNCicLb5zrfwgACH7QCAANwEZQ==
Date: Tue, 13 Oct 2026 09:04:18 +0000
Message-ID:
 <AM7P189MB113737F860568AAF3775CE05C69E2@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
References: <179155039490.29136.3966310214361645960@gmail.com>
 <AM7P189MB11375A32648F33B53BA95A4AC69F2@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
 <179183476436.33769.3426656354326870760@gmail.com>
In-Reply-To: <179183476436.33769.3426656354326870760@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB1137:EE_|GV1P189MB2645:EE_
x-ms-office365-filtering-correlation-id: 2aee4848-e866-4341-4314-08df2908f687
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|10070799003|18002099003|22082099003|10067099003|38070700021|11063799006|4143699003|261009223027099003|56012099006;
x-microsoft-antispam-message-info:
 fhI9SMZ3FFHrZZsJqatg9xYw4ae04gdbx+1gfVSlFrpdX7a9sNOmk3dp4Qdbvy+siKaecmDtjllQq1gURCBtmIYKrgg5iXzBhPlRXeiNE5LtmoHtQh5mit3a1SPNfqiAIMpYdVd5OMAEBvOmAXsBWQ0bCd4z2YI4nH40xjuvv27kXQ9i8vmOdsZbQSt3ZcoKTw1pWVfGBh6blvW3u1UcVvKUnNMsuPmuO9bFkQYH3FVhja+gZKPcgEdkh2EM/LcjAcRG6SJ3nBE90FBZbS8Y3l2bVk7dhWlaO6MXI+13hSlsYg+33DI9+dNg1Oqt/RfJ5NWAz3kE+3RnRCiR8VYrDmHDkC1+2Fg+yZLstvs6ef3jXOuJdbEy+TXndeQ7Jkm5FeYei/hDM5im7bwipOWVfgXWWShvwDitMv5CDJduL1of+xL4jqSP2Y1ZVV1n2xZTnkkSW37xhehv9sQ+NWXrsn/ET/X8C/dcEje/bSUwyhYVac7uEjngL9ilsHqVs+pWNnmQUd6KHOiVq6dKQrxCNCx7M5RQrl9/0Ezt/iJvl6x+afEKwjXeu17/4JK/cvovcyimQJZAC6zeXRIyGMefU97aUSUozmFkRlAJQfQ/KbWKmAIceS4Vkff3QJRbAN2YXu+E6J/0eCBdvKWVV3KTTYaoUuxoUkUIbaR28S1cllusKMZfIlGHtJ22mgMWodJUq93KsKZ/l6C3zQSJsGG43mTl6ohR+0aoiDCbcwRBH4E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10070799003)(18002099003)(22082099003)(10067099003)(38070700021)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?pI4jLtOX28UP5v/DfIvfmJmHHp5pPrXPkdF0P6xqdFbmmPp2qafvjzCrBF?=
 =?iso-8859-1?Q?BL02oeEQ9xBX7jrRRxaI4fvZ3zuNs4R9W+5S6STfkjdJebr0k6y8+3ebi7?=
 =?iso-8859-1?Q?ZPZAk7j/XZu55M6fJkbsPHEtFKRUkAO7jNT31quIMk/QGi/bYiP+CQYmFD?=
 =?iso-8859-1?Q?jMykVxEcxdUp8kF+5SDiL2F+Kz6+6FOxu+FQ38yPAtLZ1jSmO7G3MAMZGQ?=
 =?iso-8859-1?Q?FqnJNfsho9oPhV/WCUEb37hExjBEPbOho12N5NX3g5H6ym4V84SEd6MyY2?=
 =?iso-8859-1?Q?LimVycfHzNeOCqq8rxEwrh+lQvj5Cryy20r7HdZH2ycLDdJJMtLjHD+Dr6?=
 =?iso-8859-1?Q?vrsCAws6EcyfCQju+19Ink3CtHhStNTpvsnlpLWIW3IUckrljtEz+Hvblq?=
 =?iso-8859-1?Q?v92uk45dRfCRnLonOdL/PN513R5scPh+6hQNObQEjh4S4WY+8UHSAJiLW4?=
 =?iso-8859-1?Q?1t2BE3u1x5R3kk4xmojJCJTthvLnclesHESt9/C6F7MhcSm1sto/49KRRM?=
 =?iso-8859-1?Q?Gl7kX1pmQTN1Rvp/jNPYim21tyFpx4QL10UxQ4tRFLAWYt8XkWO6TPjRhH?=
 =?iso-8859-1?Q?9x3zSrW33egWQ3MC+RTfuUwJ7ssTtbELSobAbIOOmM92zSPqpO+gIwI+9X?=
 =?iso-8859-1?Q?AxwJB6UiGA84jU+sdAz4P5LmYzYOXNBXsgCO94Yt34Kojw5eVk49V52kDf?=
 =?iso-8859-1?Q?ZsZdtRDc99O63ykTrTk7tLPW2By/2vIuudIHwoQaUrki2LVNO5Q0Lx7025?=
 =?iso-8859-1?Q?WPpoPZuETCNvMCssiZYcv+ARo3Hmq9efHNteWi/hWPkCgMsyKTseHbx0w+?=
 =?iso-8859-1?Q?VykJ5Y6mIWuIUWCNc1/+v8EyYVIzUTIruoGjVFUbBvi82z6tw3Bw74RcZk?=
 =?iso-8859-1?Q?5R/hT5t2sDJrX++zYXve7N9S8Jcc5qsFsuVvA20iL6yrIrvlaQPelFK3zs?=
 =?iso-8859-1?Q?r6H6iQZa8whYHO8XhwRtSzfYrSx+i1NZ/C3BF3udTzkj9NbaRAttoX0twg?=
 =?iso-8859-1?Q?kR7AYntimmwAUfqDY1sYsz0p5OUwwsL1WzvTAdHfmp66KKCb52SD0kBn2L?=
 =?iso-8859-1?Q?noSNtGCibRd+P+SEXl+r7rRsHFA0KCXGxwRJuDcs/N0UnH3KvRmU/6zEWl?=
 =?iso-8859-1?Q?NYYW7IZuQlSTqoOAK3yLRO03d84nuVNwcDY1w8EFcqLpFyDWEZ8AYYAwIp?=
 =?iso-8859-1?Q?Kr7DkcpiEYKenpBUMheqv/5bFklKi8UDTuWf5gNVecpiVzNXvvcNtDaC63?=
 =?iso-8859-1?Q?G5oiuNL2SRJuxQO+W+1tVFGJtFv4mdPHEJeFeSdN3CWipCi+lPaL2t08d/?=
 =?iso-8859-1?Q?lzByDz9eeu+gDlux/iyNxB7PA5bj0/WXdGqLiSjcvvupxhU+gqAk654msO?=
 =?iso-8859-1?Q?+KBEd3wpUFPmERqpDOXH89AB/MQkWd3i8nmplgB7BrfxGnFc3saapI6c+c?=
 =?iso-8859-1?Q?8ZPnJkzLrgW8HNUCbgvdjEMWraMJF9ICcAnYLdMMvT47I5nul6NCi3dkIZ?=
 =?iso-8859-1?Q?kCgZp4JXJ3oT8qiCVcQqcSXWg1DI9NHz174FooOfjb5G0vE8P44sG9kxNi?=
 =?iso-8859-1?Q?sczViWHttsSJ9/5BN8jShFdzzkC0mOK4DT4jn1KnpY30vinBjHhp2NiYAj?=
 =?iso-8859-1?Q?BW9a9p41P2fzYeIUw6vStLl+GAO7JCBeMx4r7r5vvjZ82CVtiZQfdSjnet?=
 =?iso-8859-1?Q?1pQQcnHp8Mq3//0iwmcl8zacLFKtEKlNFkPfvpcNagS635m0RQfHFHAQT0?=
 =?iso-8859-1?Q?KLCF+aJ/8vC/JPSgV7myhpSJtwzvBqswQSe+PG+KRjnuxIOZBkPoC6+Hs0?=
 =?iso-8859-1?Q?vN9xnB+LU6zRZElAAJXhx5T8YtUrTcJwD7y8zkzpODrmAphqUh+NcbE9yf?=
 =?iso-8859-1?Q?Xh?=
x-ms-exchange-antispam-messagedata-1: WqsraXjJsWSzCA==
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
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aee4848-e866-4341-4314-08df2908f687
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 09:04:18.1835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZKLqhOHyYzGKnzS8aif7TL8YJVdyV2ejVDcQJTlBnMbYp+yGREZe4+spTfBxrBM82/LpHk6JWZwQGBsqvq051EGH2oOb/X8CXZL9G0RKSkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P189MB2645

> Would you like me to send a v2 based on your approach (with your=0A=
> Co-developed-by/Signed-off-by), or do you prefer to post it yourself=0A=
> with a Reported-by/Tested-by from me?=0A=
=0A=
Please send v2 with this tag: Suggested-by: Tung Nguyen <tung.quang.nguyen@=
est.tech>=0A=
