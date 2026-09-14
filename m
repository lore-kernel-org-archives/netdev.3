Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF70439A07C;
	Mon, 14 Sep 2026 23:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426855; cv=fail; b=ky8888CSHqLRZa7SbIXpW2H5mvcYibjVetAfAW5M7LFUG44rjqbuBXrku2Z0h/uo8sukyKy9pJVN6MJVXqy36KLR3nHl74LdOsEP49ob3dKm+FJzE/0qM4JuYadV1rDqYeXNEWFug/KFhCyX8UaHpjiFbvzxnQ3bqIXKYLQ7qmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426855; c=relaxed/simple;
	bh=InzohLbHfbsT8HjtDlhTPhQ9SkUBqHVsRZXWVQAqIjk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GpDeXQj6ezNdNpvNViMPWFu0FcWou3aHikLBz65O+f+5TLYjjzM8dgMqfR6WqSARxYkxpX9D/VVM5VVGedQy41VI/iWr0vQo3J+ylSIuFCVgDtyHPwHOWpf6lI37JQo+gF/C0Nven3glwqLQYV71ZkFLT71cMzT9C6uRv9DEbrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=c52Y78Rk; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=GFCejfYA; arc=fail smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="c52Y78Rk";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="GFCejfYA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=kTR5P23KfYT6VoSiFniv8D5TsHvehWqAcuN1/numF/g=;
 b=c52Y78RkJy4BGJHmJvbk+YjDsTRtxr5UXUL2iRJ+6G+hnnaw9ZEhifcsGPMGgttXksirj0GjuMOjNNZ82/XfiJY95fEFV2+TP9Hbe/eaaZ+4sd6HTY7gHecX8Id4juTdTcpZanZNx3DMoR73GHhh1Uvtw0txP1Xb4nEs4kh8KbsKok5mBzgaDlg2rEnUtit8QpkSk0vkNpGFlt4jrM2xAnBB+IuxzYJzE6q8DymwxivmxvR56N63ybC/Cgey+44ZLwK5dQWHSww2DUbAj2yEH/yJI8U25XBBqAgUC2D7ouJTPBRyB85glQDCMy7skBOdxGWN/3fnsc5CD5mh1lQOKw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021110.outbound.protection.outlook.com [40.107.208.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 69591A80082;
	Mon, 14 Sep 2026 23:00:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/+DQVJg1QMtac09gx8erI7FybgL0mE5ohcHOBOR4Gy9Eyl1L4fPzb5OBoVJ+6ETHjnPitNzdg/CioMKTdhAxTzJYr77TmwI+XRXjybFu21yp+mRmMlzo7HR4Nr0gbChLpsKoC8JRAMqjMESS9d8A2yxdv9wrEXaFh4sou2cjetcji4X1Nc2pHVKXrcA1TGv/hpA1GVOtliQYAJsRe+uI4gkFkWt7bJMe3oClo0zrzzxIZLxJRHjh4fUVkW6Wc83bOtakMoEWLFNvnWviuw+LgZlzXIRqjnSR9dHpLLG9X4qeus3ev24o4WaQu7GgVhsMzAmy7HlQrV1drEYqh/RWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTR5P23KfYT6VoSiFniv8D5TsHvehWqAcuN1/numF/g=;
 b=KtSLJek8zWd6QElOdPKEbKmykJJmCd0P6BFFnxFIjfepIyl3ZY2mnjny2OVXkj2TYnHSjGhOOqxis6Ucev2PYG8DhikTRQHTzEVt7AZYeDZUJ7t46cKHz3fSB5a9Jmo/v3A+8Zj9/WUtW4DNUlzaTIPRPDwcoemtF8h3nomLkY+Be7TTLReH0HTBu1RCN8PX7XP6BTT/bTugsyejnPx7QwOlOXEJ5Ruu80oVDOS9DfSyfv0tVyGNA2f8YZO+pbRgsrAVYqxPtDCnK2W7sS0L5TxI1pL3r0sBNv9ax8hItt5VHgQmJMCmQ5gJbMuu0UC1VlHgVRYyKRA1Uwdzdi5HHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTR5P23KfYT6VoSiFniv8D5TsHvehWqAcuN1/numF/g=;
 b=GFCejfYA1QWe8QsUq3e2RyrIDlVkBM8NrAdCWe5rgYDtM9MOfPvOKK6KL7rFGAeQUPZxAhfG9LdqtjIN3jIG9tWgFHsdP1DP653A5CS8928E0hdKpFbtCnoz0x6iCIE0RdSJkwNLJmogxv3rj+x/1QjWKpN1/el9zsc5uPfYjIMAIXYc/Iy94CY3rDckvlKJ2YGDbPq/krqd6acafq2g7u4JP6kgVxOuv5WS8qewamtnwo+rXSpCJXiqcpr6JtteoMKBFZhCDujD289bc2B6pKMN4RKeuKmETgXEiKnkSiOM5HfrSWTUXakHo6J3JjSEPpXFV6BcDWQDsyFtTdnypA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by MW6PR20MB6839.namprd20.prod.outlook.com
 (2603:10b6:303:23e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Mon, 14 Sep
 2026 23:00:40 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 23:00:40 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Ali Rouhi <arouhi@sitime.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v8 07/15] dpll: sit9531x: add support to get and
 set priority on input pins
Thread-Topic: [PATCH net-next v8 07/15] dpll: sit9531x: add support to get and
 set priority on input pins
Thread-Index: AQHdOyOve1+fEKZOQ06z+rugORS3AbbEqYWAgAoZ24A=
Date: Mon, 14 Sep 2026 23:00:37 +0000
Message-ID: <20260914230034.63861-6-arouhi@sitime.com>
References: <178887151730.219967.5781480771166965281@kernel.org>
In-Reply-To: <178887151730.219967.5781480771166965281@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|MW6PR20MB6839:EE_
x-ms-office365-filtering-correlation-id: 857bc128-b8e5-431e-6be6-08df12b3ff5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|38070700021|6133799003|10067099003|56012099006|5023799004|18002099003|22082099003;
x-microsoft-antispam-message-info:
 2AGjRIZR9zDIBqQZbUySgwvDtXsomtacLJgmpj9WBkfjW88fQIe43nndWt82mVQHpgnITQwjfyLicSZ6kYr4oLUXXnHIgqSc+VxBbTyv047FC61pPoBlXgW/Ff3aQl0kwnB9x4p0FsPqFXF04sq0ThJlhq2ymnM2Jg66guQUYYlgBHXIpyrcQIDzT7xPvaNTf28K+QiqRP49F3zPDIjKy5jEXTmyy0GpQ0fTsrgeXTJKdYzaL4G/NFhAwjr5dcnBCs1Bzz1tS9IOgDUAAVgrs7uGW4FEsEdD21bn4dBLKRGM6oNA+hNW/ocFIwufZoS87fxQf749hM6ZMAzfy0VHmsNZY8nMLUNEP7yiA2KQNZm0OhpEOo5Hr3/sw2zNjw7tB34szsB6SvakPfWCipfxOVcFvVq//IHyHFN4uNcpCrDO89pNBBkA5Rzf/rBUekAIll4Xb26TEmEsjCaHi/1CVxjZcWxz6D0uMHJz/p3d5Hds5PnpzKpRJCEwu3t4OJ9CHzdE03NNdyvh9ZhffGRlkgdjodtX6eUEirZ7bk5RKXc8pacqn5KcWjbwiVuZDjOoEByyZ7S9a9Lec52ED68nCfvetIvW3kp042plpYAzCWR0uRnGw93i4Jz8EHjkC1Hm1NRwnbmjshOQ7Ts1TnEvxci3drOImQnSnV2cT6AmJeQxA4TG2gBwSMG5Kuyk/jjjFH6sdBNWzGsDLJfOXP5luusOPu3jq6A6hyPbA3MLspc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(6133799003)(10067099003)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5pBjt0veex8uo3B452pHoboFtJFlhqXfMzbxh4eLhm2cT/g3AxkZLj4Ucf?=
 =?iso-8859-1?Q?SROQQp9ohhlfg6/6tAal4wv3Vix85Rzrl9lw+4yrVepuo272i08a176SEF?=
 =?iso-8859-1?Q?u9/tKnBhBZI/hVgZuwRl8GiKcffQgm17jbiztCc8eVHTieVBZjdljhaU7g?=
 =?iso-8859-1?Q?hq590uPIrCPB3AD6NPobh6Z8IjiILLxBn92x6z2kxgnrxJwrx7ezShJ1J+?=
 =?iso-8859-1?Q?IDtCOLPmXUEQ6BSUEKBjB4fTNhR6RY4X6YA+6gQMAdlSYOL5HORKxBMM+n?=
 =?iso-8859-1?Q?+XfKKxDce9pl4FDha/S1zrF4Pma4QesflT+GxRA0zupI9QUli2m0YW4eGb?=
 =?iso-8859-1?Q?RkKh9odfA1fj+S+jAoWhLQjBXnvOe4NagwDENm3d/bN6/hJbfWu0XHXvHz?=
 =?iso-8859-1?Q?v0/sbbeMTMlRtSSV1eoLDlPv48AnGaEDc4xtBh7552v9yniw2xWQtVX+Le?=
 =?iso-8859-1?Q?3bS3uMln+YOPZizG7NzE3c350WgTxAssxOe4dsReur12D4k8tHT2tNRNq1?=
 =?iso-8859-1?Q?z30YS28gbp+migpFrg+i0ek/i+7xi2dran6IQVYlB5FzWr5y3pgmy4QD52?=
 =?iso-8859-1?Q?zJrdEB+X0zYqLJTDK2tHE08W7P7iPBL6Pg7cboYOxGEgSNw2c59MPG7nLG?=
 =?iso-8859-1?Q?wZhxZABgvj++5EMLg0OQ4EUh2cK1MUm28xVxtYd8Bd2sQcbhV7xOxD4hUt?=
 =?iso-8859-1?Q?3Q9vOu67yvL1XOLYrUEfFVELcl3KtCsMIRq4G8Z30oeikZhvJGUiHJEIBD?=
 =?iso-8859-1?Q?Ni+UVJLaAJ5eFp12Rcr7QkvjyRgxoQd3CwwxQSxAZLgGAblpNNKXeH/qwE?=
 =?iso-8859-1?Q?6flKw5tyaG43rn3/s1vPh/YoHC1xFpYkDJpAUkUJr7UrzYLF23rusncAHG?=
 =?iso-8859-1?Q?0S2kN70OSB7YN2/My0QEBRacc6BcBcmAwrXHYMyAZEey4MdYzDuVjcbRQj?=
 =?iso-8859-1?Q?Mz2H/kl8ig2vxHBAhZYC8Tl+jhHIEJB/UarFkfM1PppuA9qhutIvh0tnws?=
 =?iso-8859-1?Q?8nlR0LmotOEL4P1eXkUmu1rW849yi1NSBo+hBDjiO1RWNFFuXBAt4MAsCh?=
 =?iso-8859-1?Q?jNWZCVCLMNXgXYuUM6KOm5XoU5UbnsTNaIuwsCbUmW85IZ/iJwPgEeMg4E?=
 =?iso-8859-1?Q?KlnsoSMUMGW1Rx5/pYIpvIYYmVlG8LLBY3eB6+UNVv7GGEmEURL4FvLK0j?=
 =?iso-8859-1?Q?U2Wlk1D5WnJTg3EVyqi3G2L2zHCwCl2+mdj+vaZpIiy/7TcO+vbW9yX07C?=
 =?iso-8859-1?Q?o5vgAsh9baqWZNW7TkK7MfBvrNikT471DMwCZbjgrfBdDN+t66XbVVAnm4?=
 =?iso-8859-1?Q?HYKOF7vtA4RbeAiQz/NFVZTql8wWFKEdV7/XV2T4bGmOO5WBbu4kaDTTvq?=
 =?iso-8859-1?Q?L6QtO6mNqhZIpzjV5d7GyLSU5atF9Z+aHIRaoDFxVDEOvDb8eLHaMHsdOs?=
 =?iso-8859-1?Q?W0NV7Y2+dIc4FOkqxIy5lfCONewENB89npi+xW3xTtkZidHuVUmXnJbsb3?=
 =?iso-8859-1?Q?xsWcOni2hynZui7oHbs9NIPo7CRfZOng+yvIQXiaVDXYG18r2bUQn2EfUh?=
 =?iso-8859-1?Q?QEaDnBlfj3BZZt1BoZwyNcVr93TT6yWWdJwznf1zM01vDlxDf1KnPAIvop?=
 =?iso-8859-1?Q?ZpYwPskTRvfGMEujUuyWDEhIt0iEnmUOKBopeRRXR+Alv8u0s06yt5LyuL?=
 =?iso-8859-1?Q?opDvgIcpuqc4QI1Mpy8SSgOJBoECi5dNQXWlc28wrwYKoCLAcW63Xx7E/Z?=
 =?iso-8859-1?Q?G3OlcVcLwCbNGcqcW4KR/94a1rX9plofOK0cXWFjs8AnAJ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	kWFHIR5/L/k2ssCDq4Xts4mSYR/6YtsucFIpYOpd7PJ0jsd3LcbKCmcp1WHnDNASWtCiagHe2PymuTIhxHDtuzLuFB2uCsZxfdqQ5LfeXkmUPPMAAFFTMZQY9NwerRnX2ZVso4qB+ysJDHXrSVBmhcqqp6jFyWssrliwVN92NAjgwhsEDa8mNQ3YtALf9MJVcvsqvCcN89C1yKQ0G+ARdL1uAOqnG40y+hSA5roDq1nWXg9kCZr6rbUOGa1KCztdw6VoJ5MrmzfzSLB8lHhq5qgwWneqCBWWnGdIDEfjGEjjAamVnfV+EKsy3aKT0v7jsp4kmfUPfcjVlGNj7ctXsQ==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 857bc128-b8e5-431e-6be6-08df12b3ff5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 23:00:37.3983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Rnfo8XwXD77yWJIpGKGyHPXgZGas2eGW/vRif/JIzL58iTXZ3fj5cwwzG6BXoHH4XISR16XXm3C7fK9okkt6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR20MB6839
X-MDID: 1789426844-OGVoxNTIyv_y
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1789426844;OGVoxNTIyv_y;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

Replies inline.=0A=
=0A=
> This isn't a bug, but should this say 11-slot?=0A=
=0A=
Fixed in v9 -- the kernel-doc now says 11 slots, matching regs.h and=0A=
the block comment above sit9531x_prio_reg().=0A=
=0A=
> Could this loop read each register only once?=0A=
=0A=
Reworked further in v9: the getter no longer touches the bus at all.=0A=
It answers from a priority cache that is seeded from the table read at=0A=
startup and refreshed after every table write and every poll read-back, so=
=0A=
pin-get issues no synchronous I2C traffic.=0A=
=0A=
> Can a nibble that was never programmed be mistaken for IN0P here?=0A=
=0A=
The 4-bit encoding has no reserved "unused" value, so a 0 nibble is=0A=
IN0P by the hardware's own definition -- the device's automatic selection=
=0A=
treats it as IN0P too, so reporting it as such matches what the chip will=
=0A=
actually do.  The configurations we support always arrive with the priority=
=0A=
block fully programmed by the efuse/NVM blob; the driver takes the table as=
=0A=
authoritative because there is nothing else to qualify it against.=0A=
=0A=
> Is priority 11 a value userspace can be handed?=0A=
=0A=
No longer -- v9 reports the lowest valid priority slot for an input=0A=
absent from the table, an in-range value the setter accepts, so a=0A=
dump/modify/restore round trip works.  Whether the input is a reference of=
=0A=
the DPLL at all is the state attribute's job (it reports DISCONNECTED), not=
=0A=
the priority value's.=0A=
=0A=
> Is anything reading dpin->prio? [...] a configured priority does not surv=
ive=0A=
> a disconnect and reconnect.=0A=
=0A=
The reconnect-at-lowest-priority behaviour is intentional and=0A=
documented in the kernel-doc: a disconnect is an explicit statement that th=
e=0A=
input no longer participates, and re-adding it quietly at its old slot woul=
d=0A=
reorder other pins' priorities without a request naming them.  Userspace th=
at=0A=
wants a specific slot sets it after reconnecting, which the setter supports=
.=0A=
=0A=
> Can this branch ever be taken? [dir !=3D INPUT guard in prio_set]=0A=
=0A=
It cannot today; it is a cheap defensive guard against a future ops=0A=
rewiring, and the extack text documents the contract.  We kept it=0A=
deliberately.=0A=
=0A=
> Can a demotion request through this path end up a no-op that still report=
s=0A=
> success? [duplicated-tail table]=0A=
=0A=
The holdover excursion was unnecessary: v9 compares the rewritten table=0A=
against the current one and skips=0A=
the commit entirely when nothing changes.  The reported priority is the fir=
st=0A=
occurrence, which is the slot the hardware selects by, so get and set agree=
=0A=
on the effective value.=0A=
=0A=
> Should the other affected pins get a change notification here?=0A=
=0A=
Yes -- v9 walks the DPLL's input pins after a=0A=
successful priority set and emits dpll_pin_change_ntf() for every pin whose=
=0A=
slot shifted.=0A=
