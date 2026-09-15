Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2FF306B08;
	Tue, 15 Sep 2026 00:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430436; cv=fail; b=IexFltcSYJer0sCZWhQ9sQJaEW4veb1bHRBPqW62kQZ0bv4kw4l8/V2vy+lODEfCJhvoJ+ZTfgAFmXrBV3lDtuHzbZbmSXcYur7FSlDuP757cx6OyBc+42k3eXNTyxZUADG0dilVUJR/+ETfyaKQ6Bnt/KfGNCN1mwlzl081Ijk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430436; c=relaxed/simple;
	bh=6O8bLdYA/mpcoq5v5WicwKRNVbkA2kwQO04sn5HO6QM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DkZKT96wyHmSl0zG0+SuOIra2nBB+51SdshE5U660UIPLFKKSboCGecYvtoyfZEkX7Gjcx8l6z1GLqJSg7yH2PWTsu4B4Ygks+ne1wgxm8qz4p1JY8DDRVQCWQ21NpK7+a21iir/dx/jMRGFkT/lDaA5XPasFmSsQXupzUqDfVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=oWMJ2VYY; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=WQdPuOEI; arc=fail smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="oWMJ2VYY";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="WQdPuOEI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=O/XFFYa4xNr0wzOyU4f159879FAed/wshaF4ba10oPY=;
 b=oWMJ2VYYrl+pdtIEyvBrgjFrD4OkEHSe3v9qzIGHP6bq+H2rCVr2THPNuNGn5lwoMR9OW1bim66yG5whSIAaGpma8pjq00xHdwwG1NqSI/yLNPVXMVkDH8Tc+skYPnWcMZ/cyO9OKU8tEDT4bLgFRGWldeJMguBd5IdUS7UHMRe9nyV/FZ/RLDPjNOImFBJtjiK2U/ev9XPJtXBHorE6Jv3mEWilwOyv91P5ig2bRd2HIpvFv/qDVqUjdU4MdTEqvByUv9Yi1mkwC/PwFAzuLpr9mS5B42IVojKhi9l9Pk+E2Tw+oALCEAi/FT3jEStE8W+uxiNnvRdcKyP6jh7a0A==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021080.outbound.protection.outlook.com [52.101.62.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 8338E1C0075;
	Tue, 15 Sep 2026 00:00:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YmKVXnbuB8R/Jp++IFITGne8n12xbzsJKluH4ONxh/dvWkft/dRTkRSFhjS6BTWH6ilTJ6EHZbqPJzmWu/sb/C5DxysaYwQigPzMQszxmN61etO5pnLAbdzTfLp6CSkYQP3EuK01JUHDcHHgmHhRKOAQU5fOFihYP786koLR1dj7tLcFZrAKMjmnNX2VKwXYEKWYhgm0dtUU0DOEoIP0kKeIrrPTMVfHzV6H0fknoVhH4nQv1nS4amqxd9Wz0l5QN4nX5xMMAchI9BIVjvvvdeHI+XHdUypbMwLXbYEWG+nkMHoPHMRwNnf9XKvrvZAqVNReJ1cnBB0tdL8RAGRRnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/XFFYa4xNr0wzOyU4f159879FAed/wshaF4ba10oPY=;
 b=ZRk3QstdL8LcK2yvLNa620ztUH1sGsdvbWI+5G0fzBtH0ip/Su8k8iPbK2K6Phw5uDjt7xkW4rkc0nRk2W3eA+O3JfiDbs2JWWKlOMZ5HPKmcae37/SyNxC/FcRDCOPmzEvyXN+GAxnf0RUWV4TkfxMQDBggSs0CW6/hA5PWJ3y5czTNJWJgZr7s/BVm25R6hY1n6jyKzLcDe+R0UgAOpYHZaGzOBwAH285aL/kKFB0q4ZcNFNF5/kpvMYZCAEOmTWkMDBQkBnrc9JvqKjYXTbBsUVYaRMoZDp77wgDyc4SWQsvrXebHuo07WpsPUFNA7STJ8Q061KGgICiuVHzM9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/XFFYa4xNr0wzOyU4f159879FAed/wshaF4ba10oPY=;
 b=WQdPuOEIZOKtmfIcZnejlnnAYqOFiL+uZ5kSdIswVXzUkfLjZURI38WPBhjPruifFzcVv2x4N0l2WG1v/fZaPWR+ys8vR6pbxTB1uVVG1dC69k9Na/156Tg5rxi52N/nGT8PfEoVUwtTtKAa74OwLHulbIS/xdIiDWdeMaERwzVC/d1/7t4cieyzlFXWXWzruvilrYCGVEQV4QBxPkMgl/uLmG++LrIwgL6E5+9DupSloUWIpetiIA/QTLVC55+4VlhLylDazKfHjPXzzpNtzNYO5X4dW/QV+WjLtLvXmsBXjsRqK4KMM/M1lV9TtCocf8VFDsHQOL3JjcpN1ScG7Q==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by PH0PR20MB4277.namprd20.prod.outlook.com
 (2603:10b6:510:12b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 00:00:27 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 00:00:27 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ali Rouhi
	<arouhi@sitime.com>
Subject: [PATCH net-next v9 10/15] dpll: sit9531x: add support to adjust
 output phase
Thread-Topic: [PATCH net-next v9 10/15] dpll: sit9531x: add support to adjust
 output phase
Thread-Index: AQHdRKUzk56rBFH9tUGsh9oPnlXYqg==
Date: Tue, 15 Sep 2026 00:00:21 +0000
Message-ID: <20260915000015.80480-11-arouhi@sitime.com>
References: <20260915000015.80480-1-arouhi@sitime.com>
In-Reply-To: <20260915000015.80480-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|PH0PR20MB4277:EE_
x-ms-office365-filtering-correlation-id: 97799379-3c02-47ce-77ac-08df12bc596c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|5023799004|56012099006|3023799007|6133799003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 WbXwzAf5rIwtimCA9hYxSlIU/nK8VTZaJqEmHoyReoDMJpk3dyuqGzJmtybH3gd0GzWm9+JfNSOxq7XHfN+J1rbgnPvfiVNKVdC7Eb8wu8Y2ZWHjiz83cP1CglpQTDR3Xi0u3jdCzRvcHNIXxp7x9CTdZYrH6xWyYylgAHOoae+Mwmcg6FCOI5oZAwbROBj0K8mdgW595ku+IMX/j7Jw6B0bRZnCyp8Wj3sVhLk9aLyxonf1rycp009cmy8MhQSriPzYkIfuL+jUCKKWJKgkZe2rBzlY7EW13MqCsuea9Ii+Sg2ldoko0n9yheUXAN/nN82SMgDHYfW1Vm3np7Zn2XCcvGWY4XzIluoLoiHSHzP0LJT4DKDvqGAlymUKjNg9bms7BaQ409CkQ7093lQa0m6m25/mgrrmuz6fXKpg/3fLN875Mo756qMUuGSTdwopk4WFou6s6BnEL+43xfpMFoZVhOCpnBQswzmIFq8wWtznW1qeWY95Ed8fqukZzkJXkGp95D8bKeETpF1Vl+6VvxFWbZxQqw/9mgXQCoU4PyTPmJ2YLHdDZvmUf49eDlYNnirQKX5Sr1WVj9SiCbww5pU3v6C2RVK3JcLlYtUAKFpvY9ZTe1ejJpQHaVdPMBhnRKYL7+/M0CEkOHiRfmsVXLx+/3FcW8h8LzYxr77faewRyqrBBcekb8siN48G6IAbXZPik7SNIkDAsVEoFvBsLr8G3A4DlBudT0zsbGIwPEw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(5023799004)(56012099006)(3023799007)(6133799003)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?qhvXyWemaNyagPO0uc+gYqYh9F1LetfebrIk9VBDH4tI3DHRIeMEm65QNt?=
 =?iso-8859-1?Q?vjMLpDgd0tabzMNuK7OVS6b6KfM1tWlINjOqca+LrCe25ZunzuEyTQJ1ho?=
 =?iso-8859-1?Q?NDNxpW8fOuZzP8uom7xclaIhy76PBTAvj+8+mmpnzyYl+mmX3M+6rOUxm1?=
 =?iso-8859-1?Q?FtnhVBEXSnbieAu8DrvnlxGbIMdoAtMKEw4ZKlmfttQQOISJqh63jHqf2k?=
 =?iso-8859-1?Q?la6k2nOkPhXP30GCcTg0s0RRg0r3ETFNrkQhG+sUvtgsyfLt3B7olrJqF4?=
 =?iso-8859-1?Q?Sq4jpfCzeZv+5iAJBhXwgDlz71evyXrrT/X+dnGVCgToRRNJrXOlZ4eGEb?=
 =?iso-8859-1?Q?0NAgGHUDj4AC8TfccphoioK+bTXkdpZRZv3bsgD1ZZGNstTjslFS+vIihX?=
 =?iso-8859-1?Q?L11TK1v+AdYGcpMTIIN7LvYNG60IeD3ydfbbAsuF/dpxDwdTo7WnUtYAns?=
 =?iso-8859-1?Q?BesMEozRNfqzR7y0fQ47ieYtya6uowefeL7QVO4tyQUzShJyMRjwQmAdpJ?=
 =?iso-8859-1?Q?5+dIESEcqZcZnNI9CWhLFYKWjoBFTNKbTu3I2ODqs7lfrxD9Be+n3GkPOL?=
 =?iso-8859-1?Q?IJN1UCtZlKfagQwHPPX1qGdjT0r2boI+3xRF+dBGLJLvbo34QNydFHeQLt?=
 =?iso-8859-1?Q?SvxQze4tkT2m8DpFxp77hHAzuVYlXzFaavh1Z8s4Rx7bXDVWCqYVG9xOIn?=
 =?iso-8859-1?Q?UZhzL14Md4BzwJaWCBeNyWvJMo0zxAKhMFCleSvXJO1f07rxTmIIjh7T+X?=
 =?iso-8859-1?Q?dKuCfm5O4hPa1emn2C4RHpi+CYTcCdLJstW0SYWPaRDDWiLEee1Y2fl9Io?=
 =?iso-8859-1?Q?JfCCgqUV/TSbZn7jiFbW2FpAuKjkJBNczWUDHPu+ocM34prRIp+I/BnD8w?=
 =?iso-8859-1?Q?2rOWzd9smmc0aUVsgLfxck4LTEKQ7GXtdOM4riTHkOe0R8ZOey3GB1MIYm?=
 =?iso-8859-1?Q?bfodbSkuyiplHmCj9S1lzlEIfGzlLd85pI46Bs5YNsl6P7rMdDlUH6yIZO?=
 =?iso-8859-1?Q?MiS0y+bgmlgJVyDl/vllU7FH6fzqge6S/b4LzjHejHfR1HL55iM/fynhAR?=
 =?iso-8859-1?Q?YZlDUxSOOuMjw27z+c3gAd86Zb4+VEsANJqAtU8wMDVc0ulo4k58SAXNjz?=
 =?iso-8859-1?Q?eLuoLfQWIDjDJZmp0Vh7LmT1Qk44C5MUzXEHwIn4/9nAGsYMaXuUKs2E0G?=
 =?iso-8859-1?Q?ACZnsUgxARCPaxeLkjClEiaO/K3wsx88PxBQM2psv1jqqG6Mu1WU/iV+V5?=
 =?iso-8859-1?Q?vKmWINDtVcZhCphkTwnWoDMTqZ6AEtwpS4188ZgtAKmjVwq0DX6dHvzMUB?=
 =?iso-8859-1?Q?8ML/0CyFOn4S+MksjsTbv/JW7hYhpOvzfwYPpyU6+UUHPy+nQYRJdEaisF?=
 =?iso-8859-1?Q?dczDG8h4ib5efVKWZxcgS6y26FWWRaxJNjK7x2jtdrYmgmJ5vcvZgzTIZ0?=
 =?iso-8859-1?Q?XF2FPqkYFiVUI9freXdwfS+ef0ktr4xeoHMpFx8s1DrIaCAQ5uDUoIFTMa?=
 =?iso-8859-1?Q?HN7MgOLOJNZVxlunpHg0LzB1B0ruLAoRc+hSJ/N456VC6u76xKUZk54FqM?=
 =?iso-8859-1?Q?TIvpfTAiuRtOAANigBWGdVQmKVA4FUWZl4cB2iKkZ88TJpwx0lsRv8eDRX?=
 =?iso-8859-1?Q?VfulECt29ErsMLKq/520lxKkI4opJGJ0Rz94A2U+yYwKjbWtr6X6BWJUAK?=
 =?iso-8859-1?Q?za7O1lStCGm6AAkDth56uw0ykxu+5LfD+L2cDxAhAOxBReUPVrSogg4Hr6?=
 =?iso-8859-1?Q?nO2j2bTKNyXWrEqY5g9L4pCYJNfCcr8ZXVHme0uoMWdvZY?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	pNodNudv3+qHKsMY5J07vnupIm/JhLwHnZ3kLkPUxdhIT28BBnOF/cE/1y/dmS268ay3OEgmkH5wFTef/wrFyTU9nlNbisGpeO1iT5KDsD9lZ4Y/3mzNgt8aN3TE7JATGy8Oru4FJQY9lbF849S8NUpox0sEChnNdYcAwtLJmaAkE6wY0Qh/mo6h+xvKE5OgeixHoZGM8OUip1nEYz+WNzaQV2Ok3RjNIbP+v3W17/MWou6QgUYwI6KyMBJhQ5G8xwquBYtuk364PO0Liabo9uKZTfs5iEG7s0b2q/45D21EiqpsJ3Eks/oB2Ive1ohPjfQ2PBk97BnXky7+EFk9OA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97799379-3c02-47ce-77ac-08df12bc596c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 00:00:21.5090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kPcgMyi5xlNDTyVwYLqbd+csKGpLLVFnodF1pepUBmYQZ31VLA3eVAaFzcVew4nDTXmDKDS734SBoWzNCr0NDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB4277
X-MDID: 1789430432-WgOze8Rv75Sz
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1789430432;WgOze8Rv75Sz;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Shift an output in time against the others driven by the same PLL.  The=0A=
device has a coarse delay counted in VCO cycles and a three-bit fine field=
=0A=
in fixed thirty-picosecond steps, so a requested offset is split between=0A=
the two and what the core reads back is what the registers hold rather=0A=
than what was asked for.=0A=
=0A=
Delay only ever advances, so an offset larger than one output period is=0A=
folded back into a single period -- for a periodic signal that is the same=
=0A=
phase.  The write takes effect in the programming state, which is left=0A=
with the loops re-locked even when a write inside it failed.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 212 ++++++++++++++++++++++++++++++++++-=0A=
 drivers/dpll/sit9531x/core.h |   4 +=0A=
 drivers/dpll/sit9531x/dpll.c |  56 +++++++++=0A=
 drivers/dpll/sit9531x/regs.h |  27 +++++=0A=
 4 files changed, 298 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index bba42fe302a3..8d857f1a0c89 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -1641,7 +1641,17 @@ int sit9531x_output_freq_set(struct sit9531x_dev *si=
tdev, u8 out_idx,=0A=
 =0A=
 	sitdev->out[out_idx].freq =3D div64_u64(fvco, divo);=0A=
 =0A=
-	return 0;=0A=
+	/*=0A=
+	 * The programmed reset delay counts VCO cycles against the output=0A=
+	 * period in force when it was written, so a rate change silently=0A=
+	 * re-times a previously requested phase adjust.  Re-encode the=0A=
+	 * cached picosecond request against the new rate.=0A=
+	 */=0A=
+	if (sitdev->out[out_idx].phase_adj)=0A=
+		rc =3D sit9531x_output_phase_adjust_set(sitdev, out_idx,=0A=
+						      sitdev->out[out_idx].phase_adj);=0A=
+=0A=
+	return rc;=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -1731,6 +1741,206 @@ int sit9531x_output_freq_get(struct sit9531x_dev *s=
itdev, u8 out_idx,=0A=
  * output period, which is identical for a periodic signal.=0A=
  */=0A=
 =0A=
+int sit9531x_output_phase_adjust_set(struct sit9531x_dev *sitdev,=0A=
+				     u8 out_idx, s32 phase_ps)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u64 abs_ps, fvco, coarse, coarse_ps, rem_ps, t_out_ps;=0A=
+	s64 phase_norm_ps =3D 0;=0A=
+	u8 page, base, prog6_val, fine =3D 0;=0A=
+	u8 old_bytes[5], new_bytes[5], i;=0A=
+	u8 pll_idx, slot;=0A=
+	u64 freq;=0A=
+	int rc, ret, rb_rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (out_idx >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	pll_idx =3D sitdev->out[out_idx].pll_idx;=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	freq =3D sitdev->out[out_idx].freq;=0A=
+	if (!freq) {=0A=
+		/*=0A=
+		 * The cache is only seeded by a DT frequency list or an=0A=
+		 * earlier get/set; a board without supported-frequencies-hz=0A=
+		 * would otherwise get -EINVAL on every phase request forever.=0A=
+		 * Read the effective rate back from the divider chain.=0A=
+		 */=0A=
+		rc =3D sit9531x_output_freq_get(sitdev, out_idx, &freq);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+		if (!freq)=0A=
+			return -EINVAL;=0A=
+	}=0A=
+=0A=
+	rc =3D sit9531x_get_fvco(sitdev, pll_idx, &fvco);=0A=
+	if (rc)=0A=
+		return rc =3D=3D -ENODATA ? -ENODEV : rc;=0A=
+=0A=
+	t_out_ps =3D div64_u64(1000000000000ULL, freq);=0A=
+	if (!t_out_ps)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/*=0A=
+	 * Convert to unsigned absolute delay.  Both signs are folded modulo one=
=0A=
+	 * period: positive delays wrap naturally, negative delays are rendered a=
s=0A=
+	 * T_out - |phase|.=0A=
+	 */=0A=
+	if (phase_ps =3D=3D 0) {=0A=
+		abs_ps =3D 0;=0A=
+	} else if (phase_ps > 0) {=0A=
+		abs_ps =3D (u64)phase_ps;=0A=
+		div64_u64_rem(abs_ps, t_out_ps, &abs_ps);=0A=
+		phase_norm_ps =3D abs_ps;=0A=
+	} else {=0A=
+		u64 advance =3D (u64)(-(s64)phase_ps);=0A=
+=0A=
+		/*=0A=
+		 * div64_u64_rem() rather than the % operator: a 64-bit=0A=
+		 * modulo has no compiler helper on 32-bit targets and=0A=
+		 * leaves the module with an undefined __umoddi3.=0A=
+		 */=0A=
+		div64_u64_rem(advance, t_out_ps, &advance);=0A=
+		phase_norm_ps =3D -(s64)advance;=0A=
+		abs_ps =3D (advance =3D=3D 0) ? 0 : (t_out_ps - advance);=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * coarse_cycles =3D abs_ps * Fvco / 1e12 ps/s.=0A=
+	 * mul_u64_u64_div_u64() avoids overflow when abs_ps approaches=0A=
+	 * one second of 1 PPS wrap-around.=0A=
+	 */=0A=
+	coarse =3D mul_u64_u64_div_u64(abs_ps, fvco, 1000000000000ULL);=0A=
+	if (coarse >=3D (1ULL << SIT9531X_OUT_PRG_COARSE_BITS))=0A=
+		return -ERANGE;=0A=
+=0A=
+	/* Fine delay =3D round((abs_ps - coarse * vco_period_ps) / 30 ps) */=0A=
+	coarse_ps =3D mul_u64_u64_div_u64(coarse, 1000000000000ULL, fvco);=0A=
+	rem_ps =3D (abs_ps > coarse_ps) ? (abs_ps - coarse_ps) : 0;=0A=
+	if (rem_ps) {=0A=
+		u64 steps;=0A=
+=0A=
+		steps =3D div64_u64(rem_ps + SIT9531X_OUT_PRG_FINE_STEP_PS / 2,=0A=
+				  SIT9531X_OUT_PRG_FINE_STEP_PS);=0A=
+		if (steps > SIT9531X_OUT_PRG_FINE_MAX)=0A=
+			steps =3D SIT9531X_OUT_PRG_FINE_MAX;=0A=
+		fine =3D (u8)steps;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Map logical output index to the chip's physical output slot.=0A=
+	 * On SiT95317 the eight logical outputs land on chip slots=0A=
+	 * {0, 3, 4, 5, 7, 8, 9, 11}; on SiT95316 the map is identity.=0A=
+	 * Page/base must address the slot, not the logical index.=0A=
+	 */=0A=
+	slot =3D info->clkout_map[out_idx];=0A=
+	page =3D (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX) ?=0A=
+	       SIT9531X_PAGE_OUTSYS1 : SIT9531X_PAGE_OUTSYS0;=0A=
+	base =3D SIT9531X_OUT_PRG_DELAY_BASE +=0A=
+	       SIT9531X_OUT_PRG_SLOT_STRIDE * (slot % 6);=0A=
+=0A=
+	/*=0A=
+	 * The PRG_RST_DELAY bytes live in the output system, so the writes=0A=
+	 * only take effect when made inside the PRG_CMD programming state and=0A=
+	 * committed to the NVM shadow, exactly like sit9531x_output_freq_set().=
=0A=
+	 */=0A=
+	rc =3D sit9531x_prg_enter(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(old_bytes); i++) {=0A=
+		rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG(page, base + i),=0A=
+				      &old_bytes[i]);=0A=
+		if (rc)=0A=
+			goto commit;=0A=
+	}=0A=
+=0A=
+	/* PROG6 RMW: preserve OPSTG_VCASC_BUMP in [7:5] */=0A=
+	prog6_val =3D old_bytes[0] & SIT9531X_OUT_PRG_OPSTG_MASK;=0A=
+	prog6_val |=3D (fine << SIT9531X_OUT_PRG_FINE_SHIFT) &=0A=
+		     SIT9531X_OUT_PRG_FINE_MASK;=0A=
+	prog6_val |=3D (u8)((coarse >> 32) & SIT9531X_OUT_PRG_COARSE_HI_MASK);=0A=
+=0A=
+	new_bytes[0] =3D prog6_val;=0A=
+	new_bytes[1] =3D (u8)((coarse >> 24) & 0xFF);=0A=
+	new_bytes[2] =3D (u8)((coarse >> 16) & 0xFF);=0A=
+	new_bytes[3] =3D (u8)((coarse >> 8) & 0xFF);=0A=
+	new_bytes[4] =3D (u8)(coarse & 0xFF);=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(new_bytes); i++) {=0A=
+		rc =3D sit9531x_write_u8(sitdev,=0A=
+				       SIT9531X_REG(page, base + i),=0A=
+				       new_bytes[i]);=0A=
+		if (rc)=0A=
+			goto rollback;=0A=
+	}=0A=
+=0A=
+	goto commit;=0A=
+=0A=
+rollback:=0A=
+	rb_rc =3D 0;=0A=
+	for (i =3D 0; i < ARRAY_SIZE(old_bytes); i++) {=0A=
+		ret =3D sit9531x_write_u8(sitdev,=0A=
+					SIT9531X_REG(page, base + i),=0A=
+					old_bytes[i]);=0A=
+		if (ret && !rb_rc)=0A=
+			rb_rc =3D ret;=0A=
+	}=0A=
+	if (rb_rc) {=0A=
+		dev_err(sitdev->dev,=0A=
+			"out%u: phase-adjust rollback failed (%d), the delay registers are part=
 old and part new\n",=0A=
+			out_idx, rb_rc);=0A=
+		if (!rc)=0A=
+			rc =3D rb_rc;=0A=
+	}=0A=
+=0A=
+commit:=0A=
+	/*=0A=
+	 * Always leave the PRG_CMD state via prg_commit(), even on a=0A=
+	 * mid-sequence write failure, so the output loops are re-locked rather=
=0A=
+	 * than stranded unlocked; keep the first error.=0A=
+	 */=0A=
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/*=0A=
+	 * Restart the output divider phase so the freshly programmed delay is=0A=
+	 * applied against a known edge instead of the divider's arbitrary=0A=
+	 * running phase.=0A=
+	 */=0A=
+	rc =3D sit9531x_output_phase_flush(sitdev, pll_idx);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/*=0A=
+	 * Cache what the registers realize, and only once every step has=0A=
+	 * succeeded: the core drops a repeated request with the same value,=0A=
+	 * so a cache updated by a failed call would make the retry a no-op.=0A=
+	 *=0A=
+	 * Quantizing to whole VCO cycles plus 30 ps steps can land a few=0A=
+	 * picoseconds past the end of the period, which would wrap the=0A=
+	 * subtraction below; one period is the most a delay can be.=0A=
+	 */=0A=
+	coarse_ps =3D mul_u64_u64_div_u64(coarse, 1000000000000ULL, fvco);=0A=
+	abs_ps =3D coarse_ps + (u64)fine * SIT9531X_OUT_PRG_FINE_STEP_PS;=0A=
+	if (abs_ps > t_out_ps)=0A=
+		abs_ps =3D t_out_ps;=0A=
+	if (phase_norm_ps < 0)=0A=
+		sitdev->out[out_idx].phase_adj =3D=0A=
+			abs_ps ? -(s32)(t_out_ps - abs_ps) : 0;=0A=
+	else=0A=
+		sitdev->out[out_idx].phase_adj =3D (s32)abs_ps;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_clear_notifications - clear all notification registers=0A=
  *=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index db9c73a79b04..06df7a91a7c6 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -105,6 +105,9 @@ struct sit9531x_ref {=0A=
  * @routed:		output is mapped to @pll_idx by the initial=0A=
  *			configuration; an unrouted output has no DPLL pin=0A=
  * @pll_idx:		PLL driving this output (0-3)=0A=
+ * @phase_adj:		phase adjust the delay registers actually realize,=0A=
+ *			i.e. the last request quantized to whole VCO cycles=0A=
+ *			plus 30 ps fine steps, in the request's sign=0A=
  * @label:		board label from DT or default=0A=
  */=0A=
 struct sit9531x_out {=0A=
@@ -114,6 +117,7 @@ struct sit9531x_out {=0A=
 	bool		state_stale;=0A=
 	bool		routed;=0A=
 	u8		pll_idx;=0A=
+	s32		phase_adj;=0A=
 	const char	*label;=0A=
 };=0A=
 =0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index d550eb626e6d..78034b7f089c 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -815,12 +815,68 @@ sit9531x_dpll_output_pin_state_on_dpll_set(const stru=
ct dpll_pin *pin,=0A=
 	return rc;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_phase_adjust_get - read output phase adjustmen=
t=0A=
+ *=0A=
+ * Returns the applied phase cached in out->phase_adj, i.e. the value=0A=
+ * sit9531x_output_phase_adjust_set() actually programmed after quantizati=
on.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_phase_adjust_get(const struct dpll_pin *pin,=0A=
+					  void *pin_priv,=0A=
+					  const struct dpll_device *dpll,=0A=
+					  void *dpll_priv, s32 *phase_adjust,=0A=
+					  struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	*phase_adjust =3D sit9531x_out_state_get(sitdev, dpin->id)->phase_adj;=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_phase_adjust_set - set output phase adjustment=
=0A=
+ *=0A=
+ * Programs the per-output PRG_RST_DELAY registers for deterministic=0A=
+ * phase offset; see sit9531x_output_phase_adjust_set() in core.c.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_phase_adjust_set(const struct dpll_pin *pin,=0A=
+					  void *pin_priv,=0A=
+					  const struct dpll_device *dpll,=0A=
+					  void *dpll_priv, s32 phase_adjust,=0A=
+					  struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_output_phase_adjust_set(sitdev, dpin->id, phase_adjust);=
=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc) {=0A=
+		NL_SET_ERR_MSG(extack, "Phase adjust failed");=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_output_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_output_pin_direction_get,=0A=
 	.frequency_get		=3D sit9531x_dpll_output_pin_frequency_get,=0A=
 	.frequency_set		=3D sit9531x_dpll_output_pin_frequency_set,=0A=
 	.state_on_dpll_get	=3D sit9531x_dpll_output_pin_state_on_dpll_get,=0A=
 	.state_on_dpll_set	=3D sit9531x_dpll_output_pin_state_on_dpll_set,=0A=
+	.phase_adjust_get	=3D sit9531x_dpll_output_pin_phase_adjust_get,=0A=
+	.phase_adjust_set	=3D sit9531x_dpll_output_pin_phase_adjust_set,=0A=
 };=0A=
 =0A=
 const struct dpll_pin_ops *=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index 058b892d656e..f40762f06403 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -203,6 +203,33 @@=0A=
 #define SIT9531X_DEBUG_UNLOCK_VAL		0xC3=0A=
 #define SIT9531X_DEBUG_LOCK_VAL			0x00=0A=
 =0A=
+/*=0A=
+ * Per-output programmable phase delay: 34-bit coarse (in VCO clock=0A=
+ * cycles) plus a 3-bit fine field with fixed 30 ps steps.  Each output=0A=
+ * has a five-byte block PROG6..PROG2:=0A=
+ *=0A=
+ *   base + 0  PROG6  [7:5] OPSTG_VCASC_BUMP (preserve via RMW)=0A=
+ *                    [4:2] PRG_RST_FINE_DELAY[2:0]=0A=
+ *                    [1:0] PRG_RST_DELAY[33:32]=0A=
+ *   base + 1  PROG5  [7:0] PRG_RST_DELAY[31:24]=0A=
+ *   base + 2  PROG4  [7:0] PRG_RST_DELAY[23:16]=0A=
+ *   base + 3  PROG3  [7:0] PRG_RST_DELAY[15:8]=0A=
+ *   base + 4  PROG2  [7:0] PRG_RST_DELAY[7:0]=0A=
+ *=0A=
+ * Slots 0-5 are on Page 3, slots 6-11 on Page 4.  The block base=0A=
+ * within a page is 0x15 + 16 * (slot % 6), where slot is the physical=0A=
+ * output slot from clkout_map[], not the logical output index.=0A=
+ */=0A=
+#define SIT9531X_OUT_PRG_DELAY_BASE		0x15=0A=
+#define SIT9531X_OUT_PRG_SLOT_STRIDE		0x10=0A=
+#define SIT9531X_OUT_PRG_OPSTG_MASK		0xE0	/* bits [7:5], preserve */=0A=
+#define SIT9531X_OUT_PRG_FINE_SHIFT		2=0A=
+#define SIT9531X_OUT_PRG_FINE_MASK		0x1C	/* bits [4:2] */=0A=
+#define SIT9531X_OUT_PRG_COARSE_HI_MASK		0x03	/* bits [1:0] */=0A=
+#define SIT9531X_OUT_PRG_FINE_STEP_PS		30=0A=
+#define SIT9531X_OUT_PRG_FINE_MAX		7	/* 3-bit field */=0A=
+#define SIT9531X_OUT_PRG_COARSE_BITS		34=0A=
+=0A=
 /*=0A=
  * On-demand phase-flush fired from a register rather than a GPIO pin.=0A=
  * DIVO_PHASE_SEL_REG selects the in-register trigger source and=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
