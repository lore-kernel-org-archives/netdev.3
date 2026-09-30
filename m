Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DA24ACC78;
	Wed, 30 Sep 2026 23:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811708; cv=fail; b=BWedaIO+frOq1i8ooseSRcmWxpwt54a87GoCSw/nqso4wxg0v7176h1GT6vwTtfkz8ZXjoOt6BsRcUMyfIpCVwo2Nb9ndacbBwk5lOLE1x49JO35ZeW59vS9R4GIBJKg9g7TW3rBD4QgZn9GYWA8ye6oDMUdZXSPfemzBit6ghc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811708; c=relaxed/simple;
	bh=US3xjaKMXBU7CRFL6NQHdMdfgTv6dWupEaBPA+OyzyU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CJ6cUPuM5N1spGjXcaauiHgZc2t3y2vpZYz3T/4YDNfx4vLM4eAaDCRa6COrpIc5GFJdAOnEDVfa+NXCvKEiKJOeVMgMwWvOJtbU1fNfnIsRSwGzQkFhoCw/s331Le5Cww3zCMsCBtaW667j2Oohnr2fpkXSs0TBczs5lKxaC+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=VSLcc/RK; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=IoH2CtyI; arc=fail smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="VSLcc/RK";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="IoH2CtyI"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9C93E4498AB;
	Wed, 30 Sep 2026 23:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=338NXdcBYMwbTvMSGXPOHhGvv8CevrR7Ck51UvNh558=;
 b=VSLcc/RKO845+5clcIO7XIUZJy+SoLCEUJtX9UW5QJly5jYbJr0n5ipKJYZ/SjzAbp+zeGuItbMKfll7WHjdj2TwyDqmRsgyEAACNoIgevIWifBOpX4Ix0RhNQ92FUEx9fy2A/spx3aN2aobGzbWeQQ8IOaQtiq8Vf/hcVhKjYAVkgKXd7gb490Wy2KIv0lXUGod7u8Fy8RMJeK05xhptBAmm/yunpYad1zehjrlFDPfGhc8KWfMKDHVDS6ukJD6wKSM2dJRR1QdOP1amNVxQybFK+rl8o3tiBN6fDJkfD+U3ECrLHJR/hCNT9OaBaPLiyBh8eznGZg7+krjC9/E4g==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021098.outbound.protection.outlook.com [40.107.208.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 592C6A80079;
	Wed, 30 Sep 2026 23:33:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1SwPXftPWV+mrnqBQbQ2EXLw7B17Wkxn1nBbZjoKlzuUzeOYHKH54RkQlKPzEExpEpHu2WzJXiB+D9/fd8wLSQ9AUk3EqPZ3XQFcq2JmOeCabyHM9iLJEhK9fd/zm/zFSEWZIrH24q0hnj3XAUIaSgPz2au13t4XGuI1swvJwQCKQ4LgNTC0rN4OnmS6FrM/oS72zgf1SooZzW/VInJNSjjbgFxd8yIdUIyJNt9Z6thhSPnB9Xh/cLQVKnRg8ZpyOYfSNy3FLDtRl6SBApH3jTJpy399mpkqlN3IzpfddF76Nf1yqdxH0ZBxSrVNixUzhGUqNVutz3OG581EvMoEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=338NXdcBYMwbTvMSGXPOHhGvv8CevrR7Ck51UvNh558=;
 b=dZTo4iKc+hyWuSdU7PsHv/0PiKk3uzoUdJuCTW5m+P13jh0Q6+LautC0jHT0497sQp+Va7u0DEVKjISk2OY4OICk5TiWwZZnuMBho+0Q63IVY7OvABYnowRtWowqseMsGeUFJsutGDL4tT+0YVSCxGCVAnI64rk4txxkyS61Rv4PUfyeRX98RdZyy4r19dSMPfQskcssX1TO/nQFqPJvX2eJ66qsr1yDh5Gjb3wf0z4dL6rNcQrjG91byf2rFrJU08MOL75ohGTkr1j0TTior/ahAlINR0e0bJKIyNyWiD0DXkGpv+gy/sbeHgZ63aC3Kp6ju2swsllFyHrPZhegsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=338NXdcBYMwbTvMSGXPOHhGvv8CevrR7Ck51UvNh558=;
 b=IoH2CtyIW1Kb1oeNGoy5vXneKRMbidp2Ih8Li/f3qLa7l/2xNI6P9p1sqHH7qmHEP0L04Ze/7nm2aPG4GDX0gcDVefbg/JXYJsIGm2CC01EUgamZJUvu5NuB4qWvqIGGE12ct2J+CJl+H6f38zg5qB235qqUMFDDPQuHwXi3iM1X/SjFGpIXkqs54Vgdy6E6/fb2+bQyTj7I4+BnHAN2EHJXJVgsoasekwSuKtQnUF27dP5VGfoAAPySEQpsbOkEAFXnAudSm68jH2e4RTn0K/bM4UlgWRwAAq6LgVENlJKf+bINKYDN4kpTULAPVNhI6J5mYQlf89HtjlKsdUm3Dg==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by BL3PR20MB6748.namprd20.prod.outlook.com
 (2603:10b6:208:3bf::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 23:33:14 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 23:33:14 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Oleg
 Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>, Paolo Abeni
	<pabeni@redhat.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 02/14] dt-bindings: dpll: add SiTime SiT95316 clock
 generator
Thread-Topic: [PATCH v10 02/14] dt-bindings: dpll: add SiTime SiT95316 clock
 generator
Thread-Index: AQHdSgVXLQ3HaWA+C0iXh/gobXHQUrbgKxsAgAeo7gA=
Date: Wed, 30 Sep 2026 23:33:14 +0000
Message-ID: <20260930233306.81858-1-arouhi@sitime.com>
References: <20260926023438.1567469-1-kuba@kernel.org>
In-Reply-To: <20260926023438.1567469-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|BL3PR20MB6748:EE_
x-ms-office365-filtering-correlation-id: 9fab4a33-6ac7-40bc-2471-08df1f4b32a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|38070700021|3023799007|6133799003|10067099003|56012099006|5023799004;
x-microsoft-antispam-message-info:
 jpIoPHIvALhhdqZWMvJTvhDrpmUupd2Ibrp5ejgixxg4QIsXU6etwJSgy4Q+yHMLElQBQutgBUhzRwA/KaYJEFTaq7Cv8VnKIGe5a4rsXUVb3EgTmF5nuQ7umulJAMuQO+4qsViYZqjxMa2SZKvPR9EIXrKeQ8TZVbic2Vy5Vm3Otivt5DQsbf6cFa/UaH5vVnrfFbkoK0lVhwsqlDMv05EMnXDrlnPui11jQijlCbvqyXoS9iX/1P3f8BcruMu4L174mAltNnZhAKNvofoIesQ1lX1MPChyzUhfp6Sm01SH2U8T2iYWOJ2RbbZ9Cems76113kjIQV+WIsDWrsEWEu6HQwViREp8UCLL2YsVTm/4Vn4jl5CFSKzlikwso7YOsSvX5cdG6UKaTUvxjJQ9qyyQN9vyDUfPSFi7+udHA38PA4wvbKW6Wmc5Negf1HidrG3Q5MtXYl/3WO6QvxkJXlQWFoM2wCDNGU1jc/u81CLX5+ske2u0Kej0GxqvWYuDYhpPuoBvAquUnrdl61qy1XGi6jNX8jx3b8WZB8M/5zuUgpDYoubEsV98z8P/NzsNjC0I8f31bKNZ+g/5COdqcDoYMwR62dypyhvVJSSu57mnrbIq09uU1wuZCXKWp10lE4Oz8gwVD3eoPsrMkrX7ZvKAuiBTouN7rZwv/qFnv7mm+6Qc3rmADYJxE6VWWLPvlyCCOB2Xngi3ATfTbSY7gtXrssIrT7MaC7z7yXPHhCE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(3023799007)(6133799003)(10067099003)(56012099006)(5023799004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?RrRD5MmfZORDaukyqwglNiGQaVo+AodPUhaOT57lSxrateMLLijHP4gW/U?=
 =?iso-8859-1?Q?a+dHo/Q0Voyjl9DVKk3nD2SI/or2/qX4h+TAxBMJSMxZ2gYPU3vulPdDDu?=
 =?iso-8859-1?Q?is4JSRI/SyOQofb5u88Mq9Vjc4gCCaT5GeiYF8C57H1+CiJ0z1RpJB0ClT?=
 =?iso-8859-1?Q?zVM1ZEti315pWz8InA8OfpgMwchznDaCAw+e20RCkQUqBGCPzAL4XUbaM4?=
 =?iso-8859-1?Q?vgqfkz6L0nIaeA8gJSNENfGcKDjsN2UK4kHe8iu/A8wqcVSvVVBasGDpVI?=
 =?iso-8859-1?Q?spETn4mztFVbtRND8NnLQV7LdXdZS/jr/7Gd7MPxokct6teKAS/1iGz/AW?=
 =?iso-8859-1?Q?ASYMjPIFbOj6qVgLrpBY1oKzxqj88WkXYds4ui6cIcOcIGNkUkipK5nAja?=
 =?iso-8859-1?Q?AN/YXldearsYvfl0eenBqMWCNr7y8j4Iadwj/ddMYCjtWr2pitYIDgSXOl?=
 =?iso-8859-1?Q?+yJoz3jv4OIW7zNHwLx2/TkNNOpYs0JUv8CT1cPUsNn+mbas5eHnsDzY2q?=
 =?iso-8859-1?Q?TvW0Br+eGTzppkvRzvmpogEkNRUdWRJG1lLL4bufnVaPT0dmNvmjmLRFya?=
 =?iso-8859-1?Q?Pq70Zs5PsbXCXCO0Y9/U/iJDKEEswlok6WHgJ3Y2D8q0bzwB2yi9HmFkde?=
 =?iso-8859-1?Q?iDj9TWo3QV2nd9LFxt1C/KSysxFPJdoGG3YTobrPeBVMpYY89T7XuN3poZ?=
 =?iso-8859-1?Q?mW64R82tAIhCLNVyX+dJMR/btWaNL60GT2hSYjY91pui+ANJ1uoMTffWMf?=
 =?iso-8859-1?Q?EkLgxqkWDuSPD9Q4IWhvtA/DoMe2rzh+6qETsWtIYi7l9rXTCIsoacNTrD?=
 =?iso-8859-1?Q?IG9Sus6SLoGVUaoEzfTHyUtj8Va77mM4kzOoPau3b7Z14fgf4ZaPnVYA2u?=
 =?iso-8859-1?Q?XjTya3p187pkqVZeA+uvSemJ+bku5t/yOGU4iPX+KrcJOmeIsMa2PP5/dN?=
 =?iso-8859-1?Q?0IHqXNTQiAOFv7cBc8XPIjLbb6LJC2f5O6xDRDdAzHAiGZgrjGgirOaA8r?=
 =?iso-8859-1?Q?YHrypMF+rTt9qKcrpq82vA+VyzRRnImwQovz/klYyynXtzaR4xPHzZEh1F?=
 =?iso-8859-1?Q?IQ5EACrgPg5LtqC5+BHfErAjbJb0xygvW8EJ7S+1oDveKAkcDcBmTgExBO?=
 =?iso-8859-1?Q?ZW5uQEfnqrtee2zcB9Wyvxl0DPZ17lgWM05F6Y8oEfKrrsJjbSHIhEvgR+?=
 =?iso-8859-1?Q?SE2JQZGcVpB6ywxMdoUPYXjT0IlafVchvMskLDrm7VHJjdMVYHY+YUUb9y?=
 =?iso-8859-1?Q?Oe/StD9vTUyvM1yOAC1w1hDfMHA1kZ/fH/er9loj+NlOGbaCHi27I3c7ZO?=
 =?iso-8859-1?Q?NXTOFbXzI9naFjmCkiSLNFnojV+jCf7TSYHrTca2wSwY7yf3F3g6p8L8YA?=
 =?iso-8859-1?Q?/WtVyUczeqSx/av+pCAwCQVEyKTKEAv/ogrm3pLE8YROu7oyqI8Ji7uPOA?=
 =?iso-8859-1?Q?iF604VRvuxHgy2iMjyzO09ukp75Anboeyp6/8XkJiv+fl0FW4awUDCKx5K?=
 =?iso-8859-1?Q?k0/9NrMdwBBYAAl5aGeur7BAPI6vLdYSmiEvzwQ6o8uz9vYy9SFOst5Ia9?=
 =?iso-8859-1?Q?0USPQVPetivXERK/vlLLRxWwNE+ti5wtqCHuDy2KQEqDQlPhq3hfcWGwd4?=
 =?iso-8859-1?Q?loobMHDPENV8RSDY+RRSGw1w/2NYiUukBSqcSAgp8woOeVyL1eljIzrlic?=
 =?iso-8859-1?Q?D5y8ztcGZCbVuoP/Nz4tQ8Q2HE2QDyEusqn2+1TvCxTlWoIQkuJa3l3feN?=
 =?iso-8859-1?Q?AGD4/yTmfgep92IWYBJXrTc+pgrnbtHO5UM0JjxfjRocKq?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	iQPWL9idcpCVQv/COYXAcHFRfZRwv07B1pVoKv7lcsQ4iiwz2pZtsHi93nE+RJlYR/hyl6rMcIjAh2A0G981hBybEHoQVELYNeRnEbFQZL96FWK6CikiX0i+7Ds1F+3cNiivREl4HoikqN3S5DzXeEynTLE4JI3/TQ9ZmMp21AKQ6ciiHFbEXKeugAw0UXVgRPbBvW8cz4ppXjulYE49PzUNEoN0E23XmCUBhm4qqlTjjQh0DX2rgLptwWHt47ZUCiCjExUG2EDUGl4IcqVn/NZnOpPwLW32tjEN1QawosWKdmchf0W2Xh+8FauXUx1qHxuzx+vCm2pQvVk1hORLzA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fab4a33-6ac7-40bc-2471-08df1f4b32a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 23:33:14.2137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yOofATbG5+vefo27nQyGXdkhKnJFb/vptloORKtLrIp7JgJawqyetS8kE7icnqTa4mCYdiECCbIZtopsyi/AFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR20MB6748
X-MDID: 1790811200-Q7OmOvqHy9kR
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1790811200;Q7OmOvqHy9kR;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

On Fri, 25 Sep 2026, Jakub Kicinski wrote:=0A=
> [Severity: Medium]=0A=
> Do clock-frequency, sitime,pll-fvco and sitime,output-pll-map describe=0A=
> the hardware, or what the Linux driver and clock framework do today?=0A=
>=0A=
> Documentation/devicetree/bindings/writing-bindings.rst says:=0A=
>=0A=
>   DON'T refer to Linux or "device driver" in bindings. Bindings should be=
=0A=
>   based on what the hardware has, not what an OS and driver currently=0A=
>   support.=0A=
>=0A=
> Both vendor properties copy state that the chip already holds in its=0A=
> programmed configuration, and they would become permanent DT ABI.=0A=
=0A=
Both properties are gone in v11, along with the patch that added=0A=
them. That is part of why the series is 13 patches rather than 14.=0A=
=0A=
sitime,output-pll-map described routing the device can be asked for.=0A=
Each PLL page holds OUT_MAP_LO/OUT_MAP_HI naming the slots that PLL=0A=
drives, the driver already reads them, and it never writes them, so the=0A=
routing is fixed by the configuration loaded from NVM at boot and no=0A=
DPLL call changes it. The property was kept on the strength of a claim=0A=
that those bitmaps can be ambiguous; they are not, and device tree is=0A=
for what firmware cannot discover.=0A=
=0A=
sitime,pll-fvco is gone for the same reason. The driver derives the VCO=0A=
frequency from the registers, and that derivation reproduces every rate=0A=
these parts are configured for. Keeping a property to override a value=0A=
the device already answers for is the same mistake in a different=0A=
place.=0A=
=0A=
Dropping the map exposed a bug it had been masking, since the register=0A=
scan is now the only path to the association: on PLLC and PLLD the=0A=
OUT_MAP_LO/OUT_MAP_HI bit order is reversed relative to PLLA and PLLB.=0A=
That is fixed in v11 and described in the cover letter.=0A=
=0A=
clock-frequency stays, and the description no longer refers to Linux or=0A=
to the driver. It is not an alternative to the clock framework but to=0A=
firmware that has no clock provider to describe the oscillator with,=0A=
which is the ACPI case; there is no fixed-clock node to point at.=0A=
=0A=
> Can a static sitime,pll-fvco value stay correct at runtime? Later in the=
=0A=
> series, "dpll: sit9531x: model the inter-PLL sync net as a pair of pins"=
=0A=
> lets userspace switch INTSYNC through netlink.=0A=
=0A=
Moot with the property gone, but the answer was no.=0A=
=0A=
> The reasons given also don't match. This binding cites INTSYNC mode. The=
=0A=
> later commit "dpll: sit9531x: allow the device tree to override two board=
=0A=
> facts" cites "free-run with a divider the configuration never programmed"=
.=0A=
> Which case is the override meant for?=0A=
=0A=
Neither, in the end. That the two justifications disagreed was the=0A=
clearest sign the property was describing our uncertainty rather than=0A=
the hardware.=0A=
=0A=
> [Severity: Low]=0A=
> Is a node that has both clocks and clock-frequency supposed to pass this=
=0A=
> oneOf?=0A=
=0A=
No, and it did. v11 adds:=0A=
=0A=
    dependencies:=0A=
      clocks: [clock-names]=0A=
=0A=
so clock-names is required whenever clocks is present. A node carrying=0A=
both clocks and clock-frequency then matches both oneOf branches and=0A=
fails validation, which makes the two mutually exclusive as intended.=0A=
=0A=
> [Severity: Low]=0A=
> This isn't a bug introduced by this patch, but the new binding inherits a=
=0A=
> limitation from the shared schema. In dpll-device.yaml, input-pins=0A=
> children match:=0A=
>=0A=
>     "^pin@[0-9a-f]+$":=0A=
>=0A=
> output-pins children match:=0A=
>=0A=
>     "^pin@[0-9]+$":=0A=
>=0A=
> Can outputs 10 and 11 be described with the usual hex unit-address names?=
=0A=
> The only way to pass validation seems to be pin@10 with reg =3D <10>, whi=
ch=0A=
> breaks the hex convention. microchip,zl30731.yaml (20 single-ended output=
s)=0A=
> has the same gap. Should the output-pins pattern in dpll-device.yaml be=
=0A=
> changed to match the input-pins one?=0A=
=0A=
Yes. That is patch 1 of v11, "dt-bindings: dpll: allow hex unit=0A=
addresses on output pins", carrying=0A=
=0A=
Fixes: 0afcee10dda1 ("dt-bindings: dpll: Add DPLL device and pin")=0A=
=0A=
It comes first so that no commit in the series leaves a binding that=0A=
cannot validate. The example in this patch now includes pin@a, so the=0A=
series exercises the pattern it changes rather than only depending on=0A=
it.=0A=
=0A=
> [Severity: Medium]=0A=
> What do the reg values of input-pins and output-pins children mean on=0A=
> these parts, and which values are valid for each variant?=0A=
>=0A=
> Could the binding document the reg numbering and add reg limits for each=
=0A=
> variant?=0A=
=0A=
Both are in v11.=0A=
=0A=
The numbering is stated in the description. An input pin's reg is its=0A=
lane: 2k is CLKINkP and 2k+1 is CLKINkN. An output pin's reg is its=0A=
physical OUTn, and the SiT95317 bonds out a subset of the slots rather=0A=
than renumbering them, which is the mismatch you found between the pin=0A=
reg space and the dense logical index the dropped map used.=0A=
=0A=
reg is now bounded per compatible, so dt_binding_check rejects the=0A=
cases you listed at review time instead of the driver discarding the=0A=
node silently:=0A=
=0A=
    input-pins   reg maximum 7, the same on both parts=0A=
    output-pins  reg maximum 11 on the SiT95316=0A=
                 reg enum [0, 3, 4, 5, 7, 8, 9, 11] on the SiT95317=0A=
=0A=
pin@1, pin@2, pin@6 and pin@a no longer validate on a SiT95317.=0A=
=0A=
This patch is patch 3 of v11.=0A=
=0A=
Ali=0A=
