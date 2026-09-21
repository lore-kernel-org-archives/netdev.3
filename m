Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D15C3CDBA4;
	Mon, 21 Sep 2026 20:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.183
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023768; cv=fail; b=YyPQ3N0/eUpd6GvorJWsVAMu3sUQpX3D9MywDo7sbcOIPeSTAVDzY/I7LlzLQd9yzD5hdN6JdT+jV9fW4aoT741wJkwLGLfeG9nB2kI0ZBFM2KZeI3q94iWCm5fScUu0rYbqgVUdJHhAXYBjllNCQpFOa93zW/kMNq7yL50iI6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023768; c=relaxed/simple;
	bh=9bdKQT9wv02rCwQQhUeOxglnpc16ypaSLzAeEpI7+Lw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G46DB4r4omzQmqYacIhdkl+uepkYou348tiuBZHS4+8JNP7dg5F66LLPnA9814kBxf5fWGuu/J6Iqha+QkT1YSil7a5/4rwOqMiV+4k1DzjBoCPCP8bMpdTpmYC/o6Gf4S0R5i4QEebYCX9pTfnErepcYGvwB9t48s48JQMnJxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=FxXea1r4; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=a7fYjbhY; arc=fail smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="FxXea1r4";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="a7fYjbhY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=3VumK6ok5/cr9BfadalDJsV5cpCVlFG9Z/WYH795vW4=;
 b=FxXea1r4ro/VEeQ2zbYI/vXHN4BW4TIyZ6nsklx7aG7qbrtRpyhcwufYMdN3mGXV68oYWALFvCndBHur6H6cSgBxrO48MLzY4/Xv4836FTZw28a8haVncGRHFPqlgyLlo+y7Z36Pz0FVENDNCfg5MEMLFBOWASV5plBvehDIM7gDslYv0zVpaSFXtDTRNQ2DJnW4RYmwn3ADGL1Bnd1iJ9OuZnAxBr1JKDN3VqTsqn+Op7sPu4f7RrWD4xs6PpGvHHCBC/c2ZaEoPPfUmN+/ABNgrxEa0rsWKg8R26sW0COdDtCFwvZ/sHvDrZl54r7GNT6+fNLPqKgE4X3UDAAZYA==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022078.outbound.protection.outlook.com [40.107.209.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 9EDAE3C0082;
	Mon, 21 Sep 2026 20:49:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0DuMqmxBKflS355BBjjiNKxX0QlRjF/3sf3E2OLJKnoZn8BNfp4a7cJr6cs9UkcxO5kHLY5pyirv5l2W4gsBsa3HBT22f3yshyzIu/QLNA5iwwBZEU7Z05qIuwTmPgD+oP2+vdSjtzacLJTIiV6dOzrp+VSLrfvPoComgx9d44FZ2rYBGHcY+9iQcXN7riIU8f20k4ZGR4B9eX9l95ec6tRugbPlCcNVXF6u46kJiVUQwP2oaVOWzQ7v8838ALiMbahjv0OSyy1jcJaGhCbCHMtOOynE4BioUhTlGHng/WhvUue1kEqLmsW8eTOrI1fycFpogcXaBENzJbjEYau1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VumK6ok5/cr9BfadalDJsV5cpCVlFG9Z/WYH795vW4=;
 b=anUi+snmd4DEj97TU35AHeOJCwuipZLbin30GAXEWr4sx52PQDQaAydFb+rOOO0VcVFHXKifSr/2I3yCca973n+VyTEuOcVskAy75bq1+5Asar3DJ2oROR+J7TiEI+PRa/MgBEkW5sDshivyC41JHWCUR6k+tCKwYUuOY+CCCWaq2wS5OtH+9Ilp7fIQ3gSzOi9K9zrhhN0MvsbVJ1x9pCgQRo1TPCbmkMt8LxXJuQ9+r4asZpUPmPPCVTSvMKVIdQkKLXTXPLb57lAW7PHZT9tFVWjBaE8c2N8ouVkSsHH5wUCUUxHBr12/a+jTvg8wQ8u2cmOkHt+Rc6HPMcDWGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VumK6ok5/cr9BfadalDJsV5cpCVlFG9Z/WYH795vW4=;
 b=a7fYjbhYpxa7RtySfQXJ+wdny2ZxcKivYku212wBc/SlnkCUIWYXq0jUq/5r6fp/ePFrnNm6eenPgbMHk/LKSMPg5tWzD+PXEoV2aloZNoWKBHD8KAvjiZpTOwTRCwUdE0QudmT+Ta2i3k8KddgIbECsKSxHkRsoQyPqaYpiCfEgD6FMCmz6g1lYDpbNJXpI78vr/YH8vTNJy+YRJvXyX7LRKfogsb5ljZDNu+5UVaapqjRNZSlK4vKJgFbrOzM1m+eVjDjLKzBB6dsqIGdr5b4lp5wKazR+tYNKSnjtgEv6rvasGUvRYFj8WJmag+GIgHA++DcOriruuzznlE6c/Q==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS6PR20MB266123.namprd20.prod.outlook.com
 (2603:10b6:8:418::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Mon, 21 Sep
 2026 20:49:19 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 20:49:19 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "ivecera@redhat.com" <ivecera@redhat.com>
CC: "jiri@resnulli.us" <jiri@resnulli.us>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "arkadiusz.kubalewski@intel.com"
	<arkadiusz.kubalewski@intel.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "cjubran@nvidia.com" <cjubran@nvidia.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "Oleg.Zadorozhnyi@devoxsoftware.com"
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v9 03/15] dpll: add basic SiTime SiT9531x support
Thread-Topic: [PATCH net-next v9 03/15] dpll: add basic SiTime SiT9531x
 support
Thread-Index: AQHdRKUxgmlRKX+8FUemhwI5cng9KLbSd7yAgAcUTgA=
Date: Mon, 21 Sep 2026 20:49:19 +0000
Message-ID: <20260921204918.53170-1-arouhi@sitime.com>
References: <20260915000015.80480-1-arouhi@sitime.com>
 <20260915000015.80480-4-arouhi@sitime.com>
 <371bb5ad-ecdd-48ce-9288-8f9209b8ffdf@redhat.com>
In-Reply-To: <371bb5ad-ecdd-48ce-9288-8f9209b8ffdf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|DS6PR20MB266123:EE_
x-ms-office365-filtering-correlation-id: 3208a7ed-0a02-4e08-f176-08df1821cf1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|4143699003|10067099003|38070700021|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 Z4JNb1esIELMtQkdS6yULOq/Dga+yq3ki14qfTBch1dI2qzzmhyim9xGKiGufQXkaAWniYYM1zi/cyO1e9VwSZvf4cp1lOMCSKzd1HkTzmJnf5ZU56mpOg49chd5/Ls9EJ2zBVTkqxR3IbRsSmGfPUiAacoNTzNOx7dygyBrzdRwEbUh5zgveB2vAZvJXZ4xV16JxxwVbF6NqrvTzoYP54yDR+8OXSnROV3PhMoghE/XsmVibUnHN3z7D/Up3JVtaonrUdmqKIoFJbCY9Ds55NiVCuX1LErE6YAdfdc/yvmzhP6rxS4GuOcO9b6mbO4Y8pS4YnaDdoYf9VMEIUQc12wBrbj6QoORcj3tFp7AnGCiEOmME0c4zr4OBOS/2mGVY01YCin04iwVeD7RtPULBuZUKbsalnAmB+Vghb2FCWnflnZZXsD9OFq3AfJIAKXN+N6NVqTtO/yJa/93RlNEQFYvpS3rWdiSeejYLw3zkHXXEkwqt1f7rxQWcgAHcXFoJNMOjhpX6WXJu2PTpeHSWRpXnhbMdNLtzqrxdhURtTgAJprF7L2dMfcKpLZO+9k8438dBxl6iTylT4pSIhomPQBUqTZ8y9uUa+Y3SK8b77hc7Pc86PJWKSJMIzdhXa68TiPicJHPOPEzlTeLy9WNUJgeZqJFiV6cIRww/F1BlLcTc3gO/aJD7ZS3qaKMBhei
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(10067099003)(38070700021)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Wbpw7gndtnWhLDzRSMj44Bvg0wTTd9lYTlYWRohyneH7OX+zFqxPm+92Bs?=
 =?iso-8859-1?Q?WGUPbu4V8eBzKxJ6DzEW3m2Cl/pqs7QL8UDoLr5cIUl9U2gnhw/BZNelH4?=
 =?iso-8859-1?Q?E7PVxw2v8Ojd3P6ZeKMjdW1PoowucIvw0s9cbu9VtBRwWwx24A4omCNOaV?=
 =?iso-8859-1?Q?dKffyEvEwsMJCrPdiESp6qncT90z88VKdT8+GHdJoHgK2+nf76dONnYsXf?=
 =?iso-8859-1?Q?1SJLcLCRBP94nEMxNchEtKfFsUduxwc03DwinSHPFP3Mp71SYua+zOyMyn?=
 =?iso-8859-1?Q?0bg1HCOF7wo+ssLkgWm3yOaPu0uVFlzCTB5HQZAkbguksfQDtMaqMlyfW+?=
 =?iso-8859-1?Q?bPXjCE9Cg/2AtZ/n+sbJ2YalIQDIl98h10q+bGN898Ti11tHpA+TqT3ZJT?=
 =?iso-8859-1?Q?W8yR37YEUjgWGCYDrb8PBoV2+/3ZxAy02TMpwrWJk5Cyu5IbIAKys4AqxJ?=
 =?iso-8859-1?Q?Dcc4HzOT3YR4+iyyZapQUNkJ41cz/34mzpLyfoAf6IkRUuSNoTU+60UkOc?=
 =?iso-8859-1?Q?FvfwosrVnysWVfidYcxc5QhuzTXifSP2K+3JFwpqMa/k5Pvurapb3EY05E?=
 =?iso-8859-1?Q?8po0W4LqEkoZoxInlr0/cR3B1dzxTMEqGHE3on3s4gVgummDmNii4jl45z?=
 =?iso-8859-1?Q?uFq62uZXD6Ml8PEQzWW9lGvXV5QHHmxF0x0/evcr7dliKpK7vjRC88EAs3?=
 =?iso-8859-1?Q?eROe78Hmtbz9sLxFA8Y1mChTPW4Yl2Ji76+BlUP+pktCqx0OW2VVH0yPwO?=
 =?iso-8859-1?Q?q9/ATmLwk+j+vToF4VivZQ9oY7RMgqbudk8TSIF2vE9NGgUmU2Mf9XDxYX?=
 =?iso-8859-1?Q?dBlWvaQ2ozUMfTxCnH1V7fjqYdcDovhwxRpKlta561TbyMXI+yUa6ZjNxh?=
 =?iso-8859-1?Q?2PcyF7Obe8dRg0YO1oHO3S1XXbmMQIfuzxH3M+cpCIePLsrCsh074mQaUU?=
 =?iso-8859-1?Q?S8Sl712XdJDp6DgaAa0Aga7NKRD24muJ7fRjS2LZHvktN1wJVLZ4XzyxVK?=
 =?iso-8859-1?Q?2q+BAKURdAQ9HhrdEtHZjchzfoWwq7jkz/vDO5595hL5vijeY6xhE+0on3?=
 =?iso-8859-1?Q?eGcY9hnt7Lgo7Bzv1YXie/kWzhVXaBtBvdeHQiQhktPf6SwayPeiahViR7?=
 =?iso-8859-1?Q?qRtkOEip80Wmyp2xFm3wtWtc2sCJ2I18XYxkV/2fASdJVNm17x03aBwB77?=
 =?iso-8859-1?Q?cT8xdtFL5+wODlmQYceHqb1FI5ZJ8ixCYBrCw5TT0dxKMn580tpwHaiQVm?=
 =?iso-8859-1?Q?0oLyfyoxxc/uKTEzoEmULezfv5nHRGclpV32TUUS15KbBgmT4FcE1fxUaE?=
 =?iso-8859-1?Q?h7pWPsfxM/fDWD9cHn8dWsuNGtmDHZCQMXZzF9FLSVMqY+3tkYcEu5RslD?=
 =?iso-8859-1?Q?y5ykYJ0tVXQJXKfT4Li0kQl1QGMbzl1tLky4mbyqHPOb7sM53yY746H/xg?=
 =?iso-8859-1?Q?JVToE4oHYoYMxXWCV/QBRPb6K5MvSDcH0X1lhdwnisZbp9vmmi+NZBzELx?=
 =?iso-8859-1?Q?euVtnJlNPjnvrSd3TYy8lpKUdSx4rr5etU8mxC6P42UgdqjJJj0fnnAHX9?=
 =?iso-8859-1?Q?8edv0380+LP68dq2lI/QumuMSl5a17sQm0TNzA+eR/usdKJ/r3RfYs1vTy?=
 =?iso-8859-1?Q?myBM+weGZj9+QNRWWa83hIzMZRbiKKmO99e5MIVwlYSPxBvFllZl2se4j/?=
 =?iso-8859-1?Q?MOo03sw5AyfXcRXXPkvL1nzQfaRtFjv1SjN9njhbepTXQNjBSNC1lPrHlO?=
 =?iso-8859-1?Q?oag4ZkVGLNeQlpQjG9BnX9GbkgR5UespuR9cvQgatblrFi?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	zLTbL5LOlvxGuVCEY1FrHYnujhpGkPZsSyk0vVh8YmXg5QeOpY7CLX54qFUfSmDKB1A7sEsk3M4lhhLg2tVOYve7if1KmBd21ryB2OHRr/nKu6xgYOgZiWQBDK+h1nzGGgpBEa9MJ0rcXqUxoyWxAN2nQRC94EYayK5md3rnpURMOF5I4nGtjLKBVj2npcKRjvqpwNJ/IcSAsByMUgpu76EvLt+yLFAaEXdbPhYOWuWWJ5d1yqEqb12b5feXmZ3u0Msizg6Fk46MZFXTo3eDW3YRGcn0BDVReIxCPDrM1XAzJJly/jqtVReVC/BPRWs/LbFhNq9qBParFDkFbshEyA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3208a7ed-0a02-4e08-f176-08df1821cf1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 20:49:19.7651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hAEZ65dcR0WNiMruFUR77F1JFcEWJGb+aH5uB5tPSlGOJT4OSx/KWtGH/YLemNJKdCi7UnRbgk4n/SgxnLxpMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR20MB266123
X-MDID: 1790023766-tF7GPJYzZnFL
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1790023766;tF7GPJYzZnFL;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

On 9/17/26 10:42 AM, Ivan Vecera wrote:=0A=
>> +const struct regmap_config sit9531x_regmap_config =3D {=0A=
>> +	.reg_bits =3D 8,=0A=
>> +	.val_bits =3D 8,=0A=
>> +	.max_register =3D SIT9531X_RANGE_OFFSET +=0A=
>> +			(SIT9531X_NUM_PAGES * SIT9531X_PAGE_SIZE) - 1,=0A=
>> +	.ranges =3D &sit9531x_regmap_range,=0A=
>> +	.num_ranges =3D 1,=0A=
>> +	.cache_type =3D REGCACHE_NONE,=0A=
>> +};=0A=
> =0A=
> Couldn't it be useful to cache at least page selector register or is it =
=0A=
> volatile? I remember from zl3073x history that page selector caching =0A=
> helped a lot to reduce number of i2c transactions.=0A=
=0A=
It is not volatile, and caching it is worth doing. This is in v10.=0A=
=0A=
The regmap config now marks every register in the map volatile except=0A=
the page selector, so the selector is the only cached register and=0A=
regmap stops rewriting it when consecutive accesses stay on the same=0A=
page. Most of this driver's access patterns touch several registers=0A=
from one page in a row, so that removes the selector write that used to=0A=
precede each of them.=0A=
=0A=
Everything else has to stay volatile. The status bits, the TDC phase=0A=
measurement, the frequency-offset taps and the divider readbacks all=0A=
change underneath the driver, and a cached copy of any of them would=0A=
hand userspace a stale measurement.=0A=
=0A=
Thanks for the zl3073x pointer. Having the same decision already made=0A=
in-tree, for the same reason, is what made this easy to justify. Patch=0A=
3 in v10 carries=0A=
=0A=
  Suggested-by: Ivan Vecera <ivecera@redhat.com>=0A=
=0A=
v10 is posted:=0A=
https://lore.kernel.org/netdev/20260921201108.42676-1-arouhi@sitime.com/=0A=
=0A=
Thanks,=0A=
Ali=0A=
