Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7225414429;
	Mon, 21 Sep 2026 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021490; cv=fail; b=ZSf8LYLYzRgKdyRIoJwwHE8FgGKr3TPuWSnrzREXgPNB8359Hhyj8M8xNHRZ+9ICX0iC5CHTyjpoSPCr0TobMOtJgYaGWTCHTO5Z9qb7uhafVLcxCBk3jvGmjELaqriLWz8a8sZEL/ouXD8PQVFk4+CZBiXM0M9YNRDLVE85FPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021490; c=relaxed/simple;
	bh=JvX3z4CnF8xIPXkOzqGzRYwWFe9Z71/TsqMBu8VplYA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F0EuPQ78aJNRDxTLteRTo3VOPyRu4T1dmsE54O4yLA2uZkkAyvhbYLk6BNZUoNrdzP4lINnvHUKFwZlNRzoUbacrhJias1s6EPYoyKF9hqdL9aAv2ZCusLFdL2Aru5MbQPm8dofLGANa+J5IpbOQqz7fNTSaNaYeg2EeTOgcwq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=gSVDaQTj; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=MDmb3tkR; arc=fail smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="gSVDaQTj";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="MDmb3tkR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=qaxq0jggmL3iRRwAGeWvv/xy6gtU9sYom9ya4dihDt0=;
 b=gSVDaQTj9X5DuEmAN5UCmGHVud+AwB4dX5hEgBye6/gRWpHaq2CCRzXcnYU7/03+hPFE7HdEhn79koVdmKdhyGEsVERF5J1rdeBzgzNdPDPYO/9VSNmDMD3ers2h4PPzT73GzRFTLAuRwjJNAf2qbKxoITiTpR23jFALIl8Uyw6CB88jzTyuogwOHhpM2Y9KrWSwBw6CGWWgZMT+VjuUToHj62zIzBNnz47quO8bPYxWPd7bjuuOJ1JmXDVOLZr3eoqThPdqmg9WEBaNzKLntG+3FSg/Fy//DenBRy/eznD5d9kyoKI0NX3DZhorZfxTTfoZPJfvEErS7K+jJvZoxg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020140.outbound.protection.outlook.com [52.101.193.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 4493C940079;
	Mon, 21 Sep 2026 20:11:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3wtZGqD1KRW+HyUnB5ayM284J3dVm1Y6o1vz/8DU1/H8jU7bVtAWhN5nqk67ZPCFdPPJsbJzMdsuk+IVE+MGqVeG+wk4+iVu/dmI3TTvc8OFIK3R2LLS1gsVrFkgZQK7oaQPgDRVM2Iy+PDXfSHEJt4RrwiLWEYsG1X17E44UpQnA2FeX58Fn+iPdEVTfsxObaNzXdFsdsZVP4GvPuY1sVMsHH+um9ksBpRdWJqFH4pblTj2AakruP/sXDZby+4kdpEpPCRgg1UrE4l4xyJF/lcx2eROMNm18axzXDDFbrb/Gk+KGWMcfh67c/AQeHPxaDqkUWlc9Vt3tOH+CEJ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaxq0jggmL3iRRwAGeWvv/xy6gtU9sYom9ya4dihDt0=;
 b=gwDQwZFRfI52CKgTXJAdIOP9T0QRfBCrgvLJlxfm3YkXNMVSKuaZMSvo1tynSeVCg3YW2XyfzVOVg3RSMuSpUM5dk42Xz3R3I56vywjm/EEvtDkqoZl6PHy7oDhkktR85LVVeSpWpoDFYM3ahK4ngBsmkntMWNM+GAe3NxZHH3Gpm5LCAaTwAGdYbUn9cif2jv4wXt8lYjX2vgQrUXsdnP5mr26gyEJvKYNOW9oeF3ArtGbwNmcP9CzOSb0UUeGPoGuHCIZTSN8JW6YK6JmOioQBqCUOB1+Nkjkl9H/gVj2qAwMvG16Lzz6oqvS2MMh1JhhswnpSya2z6jknHv1QaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaxq0jggmL3iRRwAGeWvv/xy6gtU9sYom9ya4dihDt0=;
 b=MDmb3tkR6J7iuzMJzr4qvhDUAGpTYdAqxQMwkKRwRfXtbvolUCzdtzLh3C2YuClku5v1Vj97LiHS6fpZzDeOuwiaWjzFjdPxFCwfh8myayJbTetveFOsmg6FCZRIP5+vMMr7tjUFODnxg3Xd+9J4Wb99PFSvSlJZBJ0pSTAMEq+OClc3xGftLs2unXq/XTEnOLP4p8St9/im7LmzYMQG0G5eN9fLq3b9rfoE8T0VIub6TegsJQPApJOE1XZB3sA9x2NNVs/8i3Y7qDpbbRX7F4li6zcOUTa/3ghFnA49XpdncIF/TrYYpDdxV45734oVpVCuL4GqFAEIt7rd8yW7/g==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS3PR20MB7783.namprd20.prod.outlook.com
 (2603:10b6:8:2df::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:11:13 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 20:11:13 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"prabhakar.mahadev-lad.rj@bp.renesas.com"
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "dev@kael-k.io" <dev@kael-k.io>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ali Rouhi
	<arouhi@sitime.com>
Subject: [PATCH v10 07/14] dpll: sit9531x: add support to get and set priority
 on input pins
Thread-Topic: [PATCH v10 07/14] dpll: sit9531x: add support to get and set
 priority on input pins
Thread-Index: AQHdSgVaFQJB3d6PmkqlmfJok9jEfg==
Date: Mon, 21 Sep 2026 20:11:13 +0000
Message-ID: <20260921201108.42676-8-arouhi@sitime.com>
References: <20260921201108.42676-1-arouhi@sitime.com>
In-Reply-To: <20260921201108.42676-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|DS3PR20MB7783:EE_
x-ms-office365-filtering-correlation-id: fbd98a31-d73e-4195-9f49-08df181c7c90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|3023799007|6133799003|22082099003|18002099003|5023799004|38070700021;
x-microsoft-antispam-message-info:
 K89kdobtovKNsVlpGMLh8V1cj/xJmpQrX7wR4QwaCFbb05i6WcRQERDkptWqMSWRRAE2SJ13KHXYssBVxPYM4XxrVeaOHRFpPX+klY5GppJYeJhN8sBDtkTdxDkVi/byx1OdJZtEZiKI4g99lquuHsgUCuVb4mTM1pgSO9sa9SXlv48iRxSShqRT4MctDSYboghSlbZBYDPqXBPkU0OKhgRsFXEByRapUxZiBGicatSViq0X/NsEFls08OooSKuahuz0e5/kCGSgfn2ts54EyR3VdFcs99a7aDcof/0EJ0637iZ+0DvX5tx2pxYNqulEuvi8FWFqfFS2bUWcNBfLKsAV2cdEox5hZOeTjglLLVOF39WBm9IBjavpwb++O+zfQdOLop62fu/GYaouNpKIJXGdR0r7FPgWNRPLK+gF1QwlhWe1M35QVE8ohelOSGVvXrGBX3puf/C7jDKunf2cgxrc/uep/wBGLYfSjDJW1Ep5JyX6Q/h6zxauO/krRAXQsbRKAcLod8OajgdbfW2L6N7t7f6CCzGyydPw88El/vbSuytNQtEfKskUwn1vGR4Irl9UzZxkDVRO3q7Rcu66fQsgCXWJlAUzYmmYXlT88ExgRuZNyKeHLWNzI2VaJ3893iwJDfSaNV9jXxUuYWCvJPgeNo3SkhdrxHa7Lv6h1vDp4CHg2I9zGP5HJf05d4oYZW3Z+EwoJz2ani6BNZzfcLStbaf/Jul1tUNPh+ZD2ZI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003)(5023799004)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ULoijxEYPlnmE6tXMLWODHa0OqRUIrH34lfmwz6YeTBJWr6u4C6kdhmoyS?=
 =?iso-8859-1?Q?skahiqnT5680/z0nECWk342dKTbkIOeyxwk6UlXbtLaUwv7Kdi8mWtE7kU?=
 =?iso-8859-1?Q?+ZiIxrcWk9ba+uwqs5w04XAkT9o0NeDy+Oumb1U7uijx4y6N9EOgYPbWzR?=
 =?iso-8859-1?Q?ZKlTNIvn0TvhPpl4//7FoxjZtDOY+l2LDZqmeMDCEz/sLiR9ZxUC5+4kpt?=
 =?iso-8859-1?Q?fJ+gm1SQ3KaVH/i8+/jyF+988hFPlbuXM0aA54jBRgzgDAzB4R1lqXZy9s?=
 =?iso-8859-1?Q?huRNQpxjD9cEYSKJAaU2BssLHHYSl23UguvoQSE0TN5PMiUtsX9LdV5k5e?=
 =?iso-8859-1?Q?jpGzfBwA6eWLtMYbBg9uXC64ZFLkpoGkbAlOX7JdwlNP5Pq4CI8DqMGgC9?=
 =?iso-8859-1?Q?pc1YiKdAb4kA340S+G/So/qRbTOSLXAyutbHNaMyc1cFhIBFxocpd7/KEV?=
 =?iso-8859-1?Q?rFfj5UyRboH3nKXeic3UY90sXGHHusm+2KmFPt1j6s0Ie/5htW0PklYWbE?=
 =?iso-8859-1?Q?cVbveDmFQqgzVXfMNMOTZp6iR8aeU6tJ9QwyiNYVDWf91L0oPQmUDE6iRT?=
 =?iso-8859-1?Q?IzLGyMP3+jvQZkGfOOTBKawEdohHHci00hUHmeTOt1HTCiTvg5CIL5J0t4?=
 =?iso-8859-1?Q?nHi7+b7fK75zt7CagZEty5CkgKgLDooRHPts76iNn2XXMitHEUOXM7tUA5?=
 =?iso-8859-1?Q?TSpFDLtLx3YMG347lxeWr5CTlA3FFsT7MoYc8VIs8v88dvLw4KJTfN5Y8t?=
 =?iso-8859-1?Q?4eIOxwD+aM2tz6h5a/Lt4oq9Xfy/h2Khw6wqts/STMAh9OWtHaNI3G5Y2j?=
 =?iso-8859-1?Q?TJ3iAe8KCvHMLGrbmfndcrTd0uvEc3ElCrw9xBdy4U8xiipmK68bo8o4YQ?=
 =?iso-8859-1?Q?6cVcyh910RWCivhJTYYKpN+K4xYuhpW3fbaUPUN7uAZft/uNFezb2aUWgZ?=
 =?iso-8859-1?Q?etJaTJBB3i3QgoU5O/q6Oy52ZUqiu8nxcuLpOnFXwcxPFyJ4Gcl6AYcSFN?=
 =?iso-8859-1?Q?LNDR0LBKoPano6+74cuF0rN3SB8l/c8qtk1o0Fiefg0OkmN2Yi+AEdo0BL?=
 =?iso-8859-1?Q?UkxiI3KZODJWyUEBE2qt6k2Ofg8nIanjT2sN2BUx6xIs3t6H3GK3Tc5mST?=
 =?iso-8859-1?Q?IbnM7cFFmF1CHNU1xrgM0Hbn9QZDNZT1crVH5VfXCpu6dS2lChEgjMvLTx?=
 =?iso-8859-1?Q?Uj2uy+laExU0aBqtdhJdfj3qAQTSB104v8wSWRrxoqx4BGBTXV93vcCr6v?=
 =?iso-8859-1?Q?iCN9jQ4oMP7TmVWR2aCLmHVmADNpJk/MHNQhna/+KoIa1ibLi0EBfEg0Dt?=
 =?iso-8859-1?Q?G8I1cZSeyF3q1VC6gVtXnrNo4WeEudsF9jJlkOoVttNhOvy90X1n/2n4sJ?=
 =?iso-8859-1?Q?uCLUagi9Vn38sEy7lbE1NwqD7BEsSdTYSYgh3vVeqLmqORSxtxzW4Mxrzp?=
 =?iso-8859-1?Q?z5IUanqrs8oGhBO+E3+XXQ/pxWo9MOCClb2d0pGi3jEQnA6Y2YrMzN/zFr?=
 =?iso-8859-1?Q?fF6E+/hodk7CpjcLhr4Pu9jHocjp+OL8Qq6HEsJmiGwjTfINr+OHY0l8H6?=
 =?iso-8859-1?Q?5/ziA9YUGOMDr0OuI2bmxARCJLnlFVlFsby4g20/PQAxxvucSdFkD3wxp5?=
 =?iso-8859-1?Q?clQuhcq+h34vxE6jNs85xCqsRNECG6u0Z3xbHCzgkZBWltHvurn+TAscH4?=
 =?iso-8859-1?Q?58FpfSEDUxvm6f2R+GMfOq95COnf2owKh9kWn3RJGLbM+QCC+F4PsO/zpX?=
 =?iso-8859-1?Q?+wd1L7yjXxJ1Z9lWiugWj32Cc4+XbKqbtGQklQidcNBd0r?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	CVocAZjf2h4ucGS0efEdFLkugD4liIle9Q7XcwoXS4udfCildKXHMOC8TP9KhBl7OSoAHRJDVO28sZtEqt3ETri5bcNly2AfG8Nub5z7Q2P1SBM/+97A1GhV/1c1cEvVKaY8kwK1PKKi4WsjMryp5/zMkeIe+sFcgq0Wdp99G55H6hVhcG3vxeAQpCLsPLM/uLeUVhk9fmjmie1fMnONAEpnejfsW3mPMhuvG/fUx4lXpmE+7A33iPjO1eNjXt73xdDBvb7E0dcrbofn33XZYQ5f3cUHIZHqx/eDeF68lNymJMdda3wiCjVefSsBZszZ80iFwtL1S1kmT7G3P+V3lA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd98a31-d73e-4195-9f49-08df181c7c90
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 20:11:13.7499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kc0o8P3fBvkpOJ9GAZfx9+QTD02oJ8+gmR7i7t+p3W7E+fV2Qi5o8q2rFY7cpcOtURbZSnkKVpsTHrZJrgZWjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR20MB7783
X-MDID: 1790021480-FSTe4xCfKcUU
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1790021480;FSTe4xCfKcUU;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
The priority table is ordered: the slot an input occupies is its=0A=
priority, and the device selects the lowest occupied slot whose signal is=
=0A=
qualified.  Getting the priority is therefore a search of the table for=0A=
the input, and setting it moves the input to the requested slot.=0A=
=0A=
A priority change can shift the slots of the other inputs on the same=0A=
PLL.  The core notifies only the pin the request named, so this callback=0A=
notifies the rest itself, with __dpll_pin_change_ntf(): the core already=0A=
holds the device lock across a pin op, and that helper is the one that=0A=
expects to be called with it held.=0A=
=0A=
The two directions treat an absent input differently, because the core=0A=
asks different things of them.  A set names a slot to move an input to,=0A=
so an input that is not in the table is refused with -EINVAL rather than=0A=
inserted behind the request's back.  A get has to return a number, so an=0A=
absent input reports the lowest slot -- the same value a real=0A=
lowest-priority input reports, since the interface has no way to say=0A=
"not in the table".=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
=0A=
Notes:=0A=
    Changes in v10:=0A=
    Notified the sibling pins with the helper meant for a caller that=0A=
    already holds the device lock, left the pin the request named to the=0A=
    core, and skipped a pin that is being unregistered.=0A=
=0A=
 drivers/dpll/sit9531x/core.c | 119 ++++++++++++++++++++++++++------=0A=
 drivers/dpll/sit9531x/core.h |  10 +++=0A=
 drivers/dpll/sit9531x/dpll.c | 129 +++++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/prop.c |   2 +=0A=
 4 files changed, 240 insertions(+), 20 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 84c1f86e6d4c..ac184c93258c 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -543,34 +543,87 @@ bool sit9531x_input_prio_present(struct sit9531x_dev =
*sitdev, u8 pll_idx,=0A=
 }=0A=
 =0A=
 /*=0A=
- * Rebuild a PLL's membership mask from the source codes of its priority=
=0A=
- * table.  The mask is what the pin state getters test, so it is refreshed=
=0A=
- * from exactly the values the table holds -- here after a write, and once=
=0A=
- * per poll from the read-back in sit9531x_chan_state_fetch().=0A=
+ * sit9531x_input_prio_get - read an input's priority slot for a PLL=0A=
+ * @input_idx:	input source in hardware encoding (see=0A=
+ *		sit9531x_input_hw_src())=0A=
+ * @prio:	output slot position (0 =3D highest)=0A=
+ *=0A=
+ * Reports the last slot this source occupied on this PLL.  The value is=
=0A=
+ * cached from the hardware table read at startup and refreshed after ever=
y=0A=
+ * table write and poll read-back, so pin-get reflects hardware state with=
out=0A=
+ * issuing synchronous register reads per pin.  A source with no known slo=
t=0A=
+ * falls back to the lowest-priority valid slot.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_input_prio_get(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx, u8 *prio)=0A=
+{=0A=
+	const struct sit9531x_chan *chan;=0A=
+	u8 slot;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+	input_idx =3D sit9531x_prio_src_canon(sitdev, input_idx);=0A=
+	if (input_idx >=3D SIT9531X_PRIO_NUM_SRC)=0A=
+		return -EINVAL;=0A=
+=0A=
+	chan =3D &sitdev->chan[pll_idx];=0A=
+	slot =3D chan->prio_last[input_idx];=0A=
+	if (!slot)=0A=
+		slot =3D SIT9531X_PRIO_MAX_SLOTS;=0A=
+=0A=
+	*prio =3D slot - 1;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Refresh a PLL's cached view of its priority table from the source codes=
=0A=
+ * the table holds -- here after a write, and once per poll from the=0A=
+ * read-back in sit9531x_chan_state_fetch().=0A=
+ *=0A=
+ * The membership mask is what the pin state getters test; the per-slot=0A=
+ * copy and the last-slot-seen array are what priority get answers from,=
=0A=
+ * so neither costs a register read per pin.=0A=
  */=0A=
 static void sit9531x_prio_mask_build(struct sit9531x_dev *sitdev, u8 pll_i=
dx,=0A=
 				     const u8 *srcs, u8 written)=0A=
 {=0A=
+	struct sit9531x_chan *chan =3D &sitdev->chan[pll_idx];=0A=
+	u8 first[SIT9531X_PRIO_NUM_SRC] =3D { 0 };=0A=
 	u16 mask =3D 0;=0A=
-	u8 slot;=0A=
-=0A=
-	/*=0A=
-	 * A table written only in part is not described by the values the=0A=
-	 * request carried, and there is nothing here to describe it with=0A=
-	 * instead, so the mask it had stands until the next poll reads the=0A=
-	 * table back.=0A=
-	 */=0A=
-	if (written < SIT9531X_PRIO_MAX_SLOTS)=0A=
-		return;=0A=
+	u8 slot, src, src_canon;=0A=
 =0A=
 	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {=0A=
-		u8 src =3D srcs[slot] & SIT9531X_PRIO_NIBBLE_MASK;=0A=
+		/*=0A=
+		 * A slot the caller could not write still holds what it=0A=
+		 * held before, so take that rather than the value the=0A=
+		 * request wanted to put there.=0A=
+		 */=0A=
+		src =3D slot < written ? srcs[slot] : chan->prio_srcs[slot];=0A=
+		src &=3D SIT9531X_PRIO_NIBBLE_MASK;=0A=
+		chan->prio_srcs[slot] =3D src;=0A=
+		src_canon =3D sit9531x_prio_src_canon(sitdev, src);=0A=
+		if (!sit9531x_prio_src_usable(src))=0A=
+			continue;=0A=
 =0A=
-		if (sit9531x_prio_src_usable(src))=0A=
-			mask |=3D BIT(src);=0A=
+		mask |=3D BIT(src_canon);=0A=
+		if (!first[src_canon])=0A=
+			first[src_canon] =3D slot + 1;=0A=
 	}=0A=
 =0A=
-	sitdev->chan[pll_idx].prio_mask =3D mask;=0A=
+	/*=0A=
+	 * Assign unconditionally: a source that has left the table has no=0A=
+	 * slot, and leaving its old one behind would keep reporting it as=0A=
+	 * listed for as long as the device runs.=0A=
+	 */=0A=
+	for (src =3D 0; src < SIT9531X_PRIO_NUM_SRC; src++)=0A=
+		chan->prio_last[src] =3D first[src];=0A=
+=0A=
+	chan->prio_mask =3D mask;=0A=
 }=0A=
 =0A=
 /* Attempts to release a forced holdover before reporting it stuck. */=0A=
@@ -579,7 +632,8 @@ static void sit9531x_prio_mask_build(struct sit9531x_de=
v *sitdev, u8 pll_idx,=0A=
 static int sit9531x_prio_table_commit(struct sit9531x_dev *sitdev, u8 pll_=
idx,=0A=
 				      const u8 *srcs)=0A=
 {=0A=
-	u8 val, slot, attempt, written =3D 0;=0A=
+	struct sit9531x_chan *chan =3D &sitdev->chan[pll_idx];=0A=
+	u8 val, slot, attempt, written =3D 0, restored =3D 0;=0A=
 	int rc =3D 0, prg_rc, ho_rc =3D 0;=0A=
 	u16 reg;=0A=
 =0A=
@@ -629,9 +683,34 @@ static int sit9531x_prio_table_commit(struct sit9531x_=
dev *sitdev, u8 pll_idx,=0A=
 =0A=
 	written =3D SIT9531X_PRIO_MAX_SLOTS;=0A=
 =0A=
+	if (rc && written) {=0A=
+		/*=0A=
+		 * Put the slots that did reach the device back the way they=0A=
+		 * were.  Latching a table that is neither the previous order=0A=
+		 * nor the requested one hands the reference selection loop=0A=
+		 * a priority list nobody asked for.  The cache is the table=0A=
+		 * as last read, which is what those slots held.=0A=
+		 */=0A=
+		for (slot =3D 0; slot < written; slot +=3D 2) {=0A=
+			u8 old;=0A=
+=0A=
+			old =3D sit9531x_prio_slot_set(0, slot,=0A=
+						     chan->prio_srcs[slot]);=0A=
+			old =3D sit9531x_prio_slot_set(old, slot + 1,=0A=
+						     chan->prio_srcs[slot + 1]);=0A=
+			if (sit9531x_write_u8(sitdev,=0A=
+					      sit9531x_prio_reg(pll_idx, slot),=0A=
+					      old))=0A=
+				break;=0A=
+=0A=
+			restored =3D slot + 2;=0A=
+		}=0A=
+		written =3D restored;=0A=
+	}=0A=
+=0A=
 commit:=0A=
 	/*=0A=
-	 * Latch unconditionally: slots written before a failed write are in=0A=
+	 * Latch unconditionally: the slots that reached the device are in=0A=
 	 * the table regardless, so the latch keeps hardware and the cache=0A=
 	 * refresh below consistent with what was actually written.=0A=
 	 */=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 033e1059bde9..2c5d0100b450 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -126,6 +126,12 @@ struct sit9531x_out {=0A=
  * @ho_freeze:		holdover freeze active=0A=
  * @ho_valid:		holdover memory acquired, i.e. the holdover window=0A=
  *			holds a valid estimate to fall back on=0A=
+ * @prio_srcs:		cached copy of the priority table, one source code=0A=
+ *			per slot; refreshed together with @prio_mask, so=0A=
+ *			priority reads generate no register traffic=0A=
+ * @prio_last:		slot each source occupies, plus one (0 =3D the source=0A=
+ *			is not in the table); refreshed from the same scan=0A=
+ *			as @prio_mask, so the two never disagree=0A=
  * @prio_mask:		bit per hardware source code present in this PLL's=0A=
  *			priority table, i.e. the sources it may select.  Read=0A=
  *			back from the table by the periodic worker and=0A=
@@ -140,6 +146,8 @@ struct sit9531x_chan {=0A=
 	bool		inner_lol;=0A=
 	bool		ho_freeze;=0A=
 	bool		ho_valid;=0A=
+	u8		prio_srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	u8		prio_last[SIT9531X_PRIO_NUM_SRC];=0A=
 	u16		prio_mask;=0A=
 };=0A=
 =0A=
@@ -237,6 +245,8 @@ bool sit9531x_input_prio_present(struct sit9531x_dev *s=
itdev,=0A=
 				 u8 pll_idx, u8 input_idx);=0A=
 int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
 			    u8 input_idx, u8 prio);=0A=
+int sit9531x_input_prio_get(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx, u8 *prio);=0A=
 int sit9531x_input_prio_remove(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
 			       u8 input_idx);=0A=
 int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index 4437c95f578f..56a8213dee07 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -489,10 +489,139 @@ sit9531x_dpll_input_pin_state_on_dpll_set(const stru=
ct dpll_pin *pin,=0A=
 	return rc;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_prio_get - read input pin priority=0A=
+ *=0A=
+ * Reports the cached slot from sit9531x_input_prio_get().  The cache is=
=0A=
+ * refreshed from hardware at startup and by periodic read-back, so pin-ge=
t=0A=
+ * reports hardware priority without synchronous per-pin I2C reads.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_prio_get(const struct dpll_pin *pin, void *pin_pri=
v,=0A=
+				 const struct dpll_device *dpll,=0A=
+				 void *dpll_priv, u32 *prio,=0A=
+				 struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	u8 slot;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_input_prio_get(sitdev, sitdpll->id,=0A=
+				     sit9531x_input_hw_src(dpin->id), &slot);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	dpin->prio =3D slot;=0A=
+	*prio =3D slot;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_prio_set - set input pin priority=0A=
+ *=0A=
+ * writes input priority table on Page 1 via=0A=
+ * core.c sit9531x_input_prio_set().  Forces holdover during update.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_prio_set(const struct dpll_pin *pin, void *pin_pri=
v,=0A=
+				 const struct dpll_device *dpll,=0A=
+				 void *dpll_priv, u32 prio,=0A=
+				 struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct dpll_pin *changed[SIT9531X_MAX_INPUTS + 1];=0A=
+	struct sit9531x_dpll_pin *sibling;=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	u8 changed_cnt =3D 0, hw_src, slot;=0A=
+	int get_rc, rc;=0A=
+=0A=
+	if (dpin->dir !=3D DPLL_PIN_DIRECTION_INPUT) {=0A=
+		NL_SET_ERR_MSG(extack, "Priority applies only to input pins");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	if (prio >=3D SIT9531X_PRIO_MAX_SLOTS) {=0A=
+		NL_SET_ERR_MSG(extack, "Priority out of range (0-10)");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_input_prio_set(sitdev, sitdpll->id,=0A=
+				     sit9531x_input_hw_src(dpin->id),=0A=
+				     (u8)prio);=0A=
+	if (!rc) {=0A=
+		list_for_each_entry(sibling, &sitdpll->pins, list) {=0A=
+			if (!sit9531x_dpll_is_input_pin(sibling) ||=0A=
+			    sit9531x_dpll_is_xo_pin(sibling))=0A=
+				continue;=0A=
+=0A=
+			hw_src =3D sit9531x_input_hw_src(sibling->id);=0A=
+			get_rc =3D sit9531x_input_prio_get(sitdev, sitdpll->id,=0A=
+							 hw_src, &slot);=0A=
+			if (get_rc)=0A=
+				continue;=0A=
+=0A=
+			if (sibling->prio =3D=3D slot)=0A=
+				continue;=0A=
+=0A=
+			sibling->prio =3D slot;=0A=
+=0A=
+			/*=0A=
+			 * The core notifies the pin the request named, so=0A=
+			 * only the others are collected here.  A pin whose=0A=
+			 * dpll_pin is already NULL is mid-unregister: that=0A=
+			 * runs with the device lock dropped between the=0A=
+			 * unregister and the free, so it can be seen from=0A=
+			 * here, and notifying through it would follow a=0A=
+			 * pointer that is on its way out.=0A=
+			 */=0A=
+			if (sibling =3D=3D dpin || !sibling->dpll_pin)=0A=
+				continue;=0A=
+=0A=
+			if (changed_cnt < ARRAY_SIZE(changed))=0A=
+				changed[changed_cnt++] =3D sibling->dpll_pin;=0A=
+		}=0A=
+	}=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc =3D=3D -EINVAL) {=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Pin is not a reference of this DPLL; connect it first");=0A=
+		return rc;=0A=
+	}=0A=
+	if (rc =3D=3D -ERANGE) {=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Priority is past the last reference this DPLL lists");=0A=
+		return rc;=0A=
+	}=0A=
+	if (rc) {=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set input priority");=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * The core notifies only the pin the request named, so the ones whose=0A=
+	 * slots moved are notified here.  This runs inside a pin op, where=0A=
+	 * the core already holds the lock the notification needs, so it is=0A=
+	 * the underscore helper rather than the wrapper that takes it.=0A=
+	 */=0A=
+	while (changed_cnt--)=0A=
+		__dpll_pin_change_ntf(changed[changed_cnt]);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
 	.state_on_dpll_get	=3D sit9531x_dpll_input_pin_state_on_dpll_get,=0A=
 	.state_on_dpll_set	=3D sit9531x_dpll_input_pin_state_on_dpll_set,=0A=
+	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
+	.prio_set		=3D sit9531x_dpll_input_pin_prio_set,=0A=
 };=0A=
 =0A=
 /*=0A=
diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c=0A=
index 1a09bd168163..4c6a2249300f 100644=0A=
--- a/drivers/dpll/sit9531x/prop.c=0A=
+++ b/drivers/dpll/sit9531x/prop.c=0A=
@@ -191,6 +191,7 @@ sit9531x_pin_props_get(struct sit9531x_dev *sitdev,=0A=
 		 */=0A=
 		props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
 		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |=0A=
 			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
 		curr_freq =3D 0;=0A=
 	} else if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
@@ -214,6 +215,7 @@ sit9531x_pin_props_get(struct sit9531x_dev *sitdev,=0A=
 	} else if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT) {=0A=
 		props->dpll_props.type =3D DPLL_PIN_TYPE_EXT;=0A=
 		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |=0A=
 			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
 		curr_freq =3D sitdev->ref[index].freq;=0A=
 	} else {=0A=
-- =0A=
2.43.0=0A=
=0A=
