Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C0F348C5C;
	Tue, 15 Sep 2026 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430437; cv=fail; b=MD6b0Gvuuz5Sl71DZku4A90a/KBCypDGKSnc4B+RkzlfIzlwjpwxVD0u/BnVoToapZhzztLJAHm6fF8Sj8g9E990XcxCUisNIbLxkjrUOaPuiJvrqAGMBHeulEe7MNi7l/MKWYZmCtEgPFg0nWsptcEUR9EAm2HywdnGDheeCHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430437; c=relaxed/simple;
	bh=w0mlYyjgqD1ztMdn350A0dyi+C418fj8Jr5QpW2ixJQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RMfmnlEyk/+yOwm1akYc5E7YiH1wRmnO1VbzdeGEtu9Tbpm+52cXLZhrZNWSQ2ExRqZ26BRRFMMktuHNk2DFMoowGF8xF2nNWPvXfb7kyVnp8FARYGwYKHZkrZ9W3sGIi3Jw7jykvCCTZSpT/hYi5NCQ2+lwEsd7bG43yddIgh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=BfcLHnzW; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=bo06oJda; arc=fail smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="BfcLHnzW";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="bo06oJda"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=xOMABdzrfpo1ezWS631AgPBYlDfI5JCgtymdXDmvRLA=;
 b=BfcLHnzWN0ewyXPtQm0LhCIbGxbJ5MPwpULiyHHJAbcACdDdVjfEK1W0zEvO33Vvg2eHlQ8dyNzBAitwfWN1U9byyH1I7zB9RV0SzhfZ3JuDcPpplK1TTcdipU0Vy2sMP2tYMXHr4LX1fAsGqwIvC4jicZIcfboTrbZrn8AVYLRp2q447/5pgg3o7VLWTcSa5M2fHz8jScNc/KPtZ53J4IoHW8ylpXFSTBxVGOyf5Z8cBj8flgyBoGcjXEIyPdDUj0lvWSoOQCRUB8U/2lPYvyPvxXmdQvPil81hklDJIbdGWSMzfj0RKW/S3kBfu9F8p/dQ3gNhwVIbDhC0fixtZg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021084.outbound.protection.outlook.com [52.101.57.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id A930010006E;
	Tue, 15 Sep 2026 00:00:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NOfig8Cypc/eOrLV8ZkcAifOLSwUGYPNWmoWYNHKGtorGleUIFX3+L7sMhtBLrqRcHad/c1NHj9/8aetduWDyM/XTIuyKwr29JtB3swGszB5X6aMOv7tGUwbcaWwmGQlLa/ok6Vew+0qnDb6/sjYQlRuZmwOZcCZm/gdT+cOCBt59+PHcVrFuTIumL6mTuHOSNLXuMkPubFrZ37EwVMdg04svcYXqVE0eoUTQkaf3il7dAAIFxKixvLBJmZ3ImURni54ZcmOlyf46Ig5Gwt9Iw4Lo2FYgWVrJu80lawzkPBfLNNla6qkNLT2G9IgOkCLlTjyyM+3TLUJlUkD0Ei1KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOMABdzrfpo1ezWS631AgPBYlDfI5JCgtymdXDmvRLA=;
 b=S7IcDtMF2YZI/sSRtxX2eO49ZTG9xS/DSLIRVGR47vBjqZ2VPqbK6EW+yniwBwqSz219O2yDP6k6imJTFkb/xfWaqZwBOff9XkcFP4czK9rzijpYIAZEQDMb5qnzN0lOj+9IxbUq1/nFOAbN0OzeR3xsYRJJAsUSLmW+YIlN61cH15ZrLYRXIjSLxW0T4B6fYDR8ocLBZ0aXMZNdu9uDTy8nV5ABg257NRQWS83FFI04sficuMbmZcsM2m4+7s1brT+ubSxL6msIDi8E+Jqi//ZbeSczmcqz8TYS7xg/GL4VaAAMs5KoIjrA7wIPIqNj7NIU+zkRCGv96GkdEQuGIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOMABdzrfpo1ezWS631AgPBYlDfI5JCgtymdXDmvRLA=;
 b=bo06oJdaxVWHPccw+LFb2tnvo9BB3VU3LyycYgjVQSrIhr43LXK7g6CtaJt9ENdjRabKTYjKxa4bzroFAfG0Q5f1bnIud3Y340kjs46b98K1PwvCHHoycyQ2cOmRI7QFWvXcfkzjjGMILIK3AdR3dPqEfgKIcgOmHCKSBL8RN26sc2C8j0X4WKIFP/fGWjEpL+B23arp3UYxckMGhNBXXE50L/6qcV0Cumud8bab7RXROhCAo0Zqi0/Oi/TGOCnRqXi3m/cSB45o8eOmT7SRGCBwUJzTlFObkbpEH6Ncp6b19dtR6LEIZTqy9ZJxkKJbRHsWuw8vNg5XdBnA5SdOyw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by PH0PR20MB4277.namprd20.prod.outlook.com
 (2603:10b6:510:12b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 00:00:26 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 00:00:26 +0000
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
Subject: [PATCH net-next v9 09/15] dpll: sit9531x: implement output pin state
 on a DPLL
Thread-Topic: [PATCH net-next v9 09/15] dpll: sit9531x: implement output pin
 state on a DPLL
Thread-Index: AQHdRKUzKEUDZX65aE+u8Dd4XiffMA==
Date: Tue, 15 Sep 2026 00:00:21 +0000
Message-ID: <20260915000015.80480-10-arouhi@sitime.com>
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
x-ms-office365-filtering-correlation-id: e78b6b67-ba83-43f2-1b17-08df12bc5923
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|5023799004|56012099006|3023799007|6133799003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 F+C5axDvx/z8IuC1Pn2pib93jlWnRg088dGauiTmwmgdo55btRqL/qVgfDsUP8ihn1nbnGOpEw24Tt6ijOsSr6HZRB69hWPyplPSjXLICH7952ixXROZyAbQw56towAlCcveW6LUxcjD5N56REIG/Aju3q7PRk26BJeYwrXS/Z5ydy7PeFsKV+lQcLr9m46LIY0hvhoAIO43VltV7LVNx6X1WJVmq1uySgOBQHyT1RFJndnbifHrJHS2ilvGm1YwMTuHtsNmjqgXXa/Hu4sZCiwyvZgQvXd9Y9VMJ8V0jqbvblBntYEpBEzh0UqVVe6pNv+E/mZgZsJEbybfZZG1VaI/lN4ZNMuFa67z+FlkWJaBnAcws+HsVmOJxWX4eUL20Zk/xEVlCVuAHrEMSM49aBVU8wK4Oeq2mkc3PE6mLPjmZhF+Oa5hCgBp3G8t6ICxAgDqTZf9lkBYgowtRWgcjc8JgxjozDLFGe+pEg5PG2DkZ/n/k80zIl5HXGyAEVILrWEyYlBDk4H9qB/m/vyYdyNoQOlw1Q+IMCjvDcKQCO3IPBnVBV1zxDL8DZFIVAuCLROFKpdnLhGa+zKE9hunKECZF3VlnAyvNyq6Bv35B4c4Ayc/Am5hJST2DcEFlPUvxTy3XK6MAmye2q9/R28aEye74K4y9urDLFCC60Lz4hn0jCCmNrcHkURzcf9q5ZInFPjxzjUzNObtldu+dMYcHCkmWKellbtbSQ5SkUM7XQ4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(5023799004)(56012099006)(3023799007)(6133799003)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?F69K/xuz7QEW/s2LCGwyAKaqDDGHG3EkGxElC+fMljH6n+U3ynixJnogOk?=
 =?iso-8859-1?Q?0CyPyCkD6wmZsp8e6q5zH1MEDYatFUJeqRHiralD11UyQCEJYEafiyVRXk?=
 =?iso-8859-1?Q?VkK0X2Q9GT1gbv2ELZpNTS8yL22IuRR5NFmh60QroG61ToCh3sJddzrXsB?=
 =?iso-8859-1?Q?gFb7YRJV5SXH3DRYHFy1WoGZmf5kTWaPjeP5bm4unm6+NYfTg6ehRtoOl4?=
 =?iso-8859-1?Q?YYfesCYFcf6SqaJL8UYbTiaotNpnvB/L9WJww8+T86g2VgRstqntlxc0on?=
 =?iso-8859-1?Q?Q5gXaagch5jDB2Iv8rfOVOoj0nXJcNpIyG8G0f83MPegiQyyETxina0iOc?=
 =?iso-8859-1?Q?G3gHyF64utJ9cQ9zmyBW0QHHK+pgPfFk/VRAxpZWtXhMN/XhW81iulcfAq?=
 =?iso-8859-1?Q?ikabFZAYgJbglFYmm6v/YrBcHW9Hp8VVy/zGlvHWO3TENJV/KdyF2lyn1x?=
 =?iso-8859-1?Q?NBfXTkUfbpfNLwYZUISDrbma3cvDFjftfrgQO7C7z0EtlOStgPOM9p1PoE?=
 =?iso-8859-1?Q?HS6Sj36EH9QMrtEdnhenCbdFYaP97D+nqVrPZgW8hyvqvYHvkf3b8mOEIk?=
 =?iso-8859-1?Q?XGxxTT1e+Tt+fJhlkqVQIVhL4yhPeGm1eYig+F6ldQRsROgW+pC4TxHTNf?=
 =?iso-8859-1?Q?XBKL3ZtUdulMQtUhHapAYzfzN6fLkL7romTT9WbN33ToVzdXnShZcam/xp?=
 =?iso-8859-1?Q?SPKBJ4u8dLIVQ6ZCakSCCTn5Ptcf1PEWRzBJyB1CSK2NsWJZmwTKWzenWp?=
 =?iso-8859-1?Q?ovoX5HGujJhA+DDAbhOJv1SPPby1bn2JWc+4DHUbLPvDbDhEWzKmQi84Wo?=
 =?iso-8859-1?Q?Mg4R7wd0Q3sO2cIZolcFrJ8fODM98/YTdvpyHb4FQ3hg1ANONjBI9LqUJw?=
 =?iso-8859-1?Q?SY0XD/MxhQIRZaNb4ICc3nuiDAPkYBFOHl9Atgw07Yjn9wvgles/fMp9fY?=
 =?iso-8859-1?Q?xlyJKGY8yCBo6GQaV+oa5vpHyEI3kIcUlVdNClHjnuzyofWQxqm+xHktE4?=
 =?iso-8859-1?Q?xnPBn7i9piwZmBdQjmOYo3GJYVc/FWzGiDAhPGTwVP+pJ5K7/1YojiAX8u?=
 =?iso-8859-1?Q?cw8nEV0husbT2l+oF6baq+mG12Pldca0dOvzgwIVIIJfwjgCbuIjEHa695?=
 =?iso-8859-1?Q?zFClxRZ6wvd/hsgS/YjKd1qQkNMrJ2mOUAotn3mhxoI+EVh3VBP8Mibq7h?=
 =?iso-8859-1?Q?E9+zw2HAh09tu1hPx2PdLfjdFfK3wsdh88PeJrRRhBMi7kScNvst8W1sgG?=
 =?iso-8859-1?Q?fc/sE+6koTJMIdGxdlX2/G7Cr3Fi9jhZrLIt3BUTgRGfZjrL9MEw6e4ZKf?=
 =?iso-8859-1?Q?Z9GYbpLHXyL2Uv0XWBwkUr0eiLpMC5cVeZznT8bmlKWHvott1T4lcuwfkl?=
 =?iso-8859-1?Q?YCyJIwoy6aScSOKDDkAd2JHoYEDEpc/zZE4FE/gqMOtkylHU2Uj3WQd64f?=
 =?iso-8859-1?Q?QbpqnsSrZrDb2Izfl1USmpsuP0yA9JECxWs979Jf2+Njo80sZSnx+Kgrp/?=
 =?iso-8859-1?Q?2qY0D1DgtTSREbHvX//JDDhbeyJExKD9ZAgRSIHPeabw7qTkH+WYEWnsiy?=
 =?iso-8859-1?Q?eGyofl+TbNdUJJEyfulGoC+cZZ23InSpxUbT5+HOo6/I7I3VsmDNE5KI2g?=
 =?iso-8859-1?Q?sEHNOlv+ZRYyOIwuH4Ej8Qj9JflofgngJKG1sug4rzaFCb4g6qD57jNeXt?=
 =?iso-8859-1?Q?hFd//kGrSTsgXAixIkrTE90w/qK5cfQjACBPKHjwVCdqkt1p0rO8OMjMBU?=
 =?iso-8859-1?Q?uojcWoNYOUTXx8LYUT3faMd5Ybo+DxklaMS3PAUVtk+MEr?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	xDkiqSrpcmrWlMozaZkhbBlzQFsPC2wgQxP+UcsJkLyzGUpOk0w8nk/PmsOgDvW/alaMENLpWIwINkLTv5asPE3jtoZlWR9kj2zAnw9aY3vSnfP0BIMulTfRG6N3zsGJY+qKSl10i5Fhm6xwqO8mmEzI7kd1pYE7XLl+VoOEi8i10c038ErkcTGutEPUMv5zWu+0uAdTR946yjO9h6syAsJ4Azl6gNS9hd/d/tg52U7/+fRG21LvziGb3n7HpEi7R1WFYzE53Wzf2DycekhtQ7dquDIyjYXzqLsujNCrpjKnrxWnQZLqfNCWWMrxn/bwagcG2kqtHf3YtJgYz7VhVg==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e78b6b67-ba83-43f2-1b17-08df12bc5923
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 00:00:21.0720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /cQcttYJWfW4CR7ZA2FYDtNNzt529QIT9nXEW8FMPTyb3+Lllfv2WgV5nYrB+p4v604rBayqGSG31CpsZpFkVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB4277
X-MDID: 1789430432-hKnQPViwVdMs
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1789430432;hKnQPViwVdMs;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
An output is driven by its PLL rather than selected by it, so its state=0A=
says whether it carries a signal: connected while it drives, disconnected=
=0A=
while it is muted.  Setting the state mutes or un-mutes it by forcing the=
=0A=
pad to Hi-Z, the only per-output control the device offers that leaves the=
=0A=
divider alone.=0A=
=0A=
The force bit and the state bit are separate, and a pad follows the loaded=
=0A=
configuration while the force bit is clear, so both are read to decide=0A=
whether an output is muted and both are written to change it.  Which of=0A=
the four register banks applies depends on the slot and on whether the pad=
=0A=
is single-ended or differential.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 221 ++++++++++++++++++++++++++++++++++-=0A=
 drivers/dpll/sit9531x/core.h |   5 +=0A=
 drivers/dpll/sit9531x/dpll.c |  81 +++++++++++++=0A=
 3 files changed, 303 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index a83bf8ac83c1..bba42fe302a3 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -396,6 +396,47 @@ static int sit9531x_output_forced_hiz(struct sit9531x_=
dev *sitdev,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_output_state_refresh - read an output's mute state back=0A=
+ *=0A=
+ * Used when a mute could not be confirmed at the time it was written.  Th=
e=0A=
+ * driver does not poll output state, so without this the cached value wou=
ld=0A=
+ * stand until something else happened to write it.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_output_state_refresh(struct sit9531x_dev *sitdev, u8 out_idx)=
=0A=
+{=0A=
+	bool muted;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	rc =3D sit9531x_output_forced_hiz(sitdev, out_idx, &muted);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	sitdev->out[out_idx].enabled =3D !muted;=0A=
+	sitdev->out[out_idx].state_stale =3D false;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int sit9531x_hiz_set_bit(struct sit9531x_dev *sitdev,=0A=
+				unsigned int reg, u8 bit, bool set)=0A=
+{=0A=
+	u8 cur, new_val;=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, reg, &cur);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	new_val =3D set ? (cur | BIT(bit)) : (cur & ~BIT(bit));=0A=
+=0A=
+	return sit9531x_write_u8(sitdev, reg, new_val);=0A=
+}=0A=
+=0A=
 /*=0A=
  * Enter the output-system programming state: unlock the debug=0A=
  * registers on Page 3 and issue the PRG_CMD state command.  Register=0A=
@@ -474,6 +515,166 @@ static int sit9531x_prg_commit(struct sit9531x_dev *s=
itdev)=0A=
 	return rc2 ? rc2 : rc3;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_output_hiz_write - mute or unmute an output=0A=
+ *=0A=
+ * Muting takes control of the pin (MASK=3D1) and drives it low (STATE=3D0=
) on=0A=
+ * both the differential and the single-ended register pair, because the=
=0A=
+ * output must go quiet whichever way it is wired; unmuting hands it back=
=0A=
+ * to the device's own state machine.  The caller must already be in the=
=0A=
+ * programming state.=0A=
+ */=0A=
+static int sit9531x_output_hiz_write(struct sit9531x_dev *sitdev, u8 slot,=
=0A=
+				     bool mute)=0A=
+{=0A=
+	struct sit9531x_hiz_regs r;=0A=
+	int rc;=0A=
+=0A=
+	sit9531x_output_get_hiz_regs(slot, &r);=0A=
+=0A=
+	if (!mute) {=0A=
+		rc =3D sit9531x_hiz_set_bit(sitdev, r.diff_mask, r.bit, false);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+=0A=
+		return sit9531x_hiz_set_bit(sitdev, r.se_mask, r.bit, false);=0A=
+	}=0A=
+=0A=
+	rc =3D sit9531x_hiz_set_bit(sitdev, r.diff_mask, r.bit, true);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_hiz_set_bit(sitdev, r.diff_state, r.bit, false);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_hiz_set_bit(sitdev, r.se_mask, r.bit, true);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	return sit9531x_hiz_set_bit(sitdev, r.se_state, r.bit, false);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_disable - mute an output (force Hi-Z)=0A=
+ * @index:	logical output index (0..info->num_outputs-1)=0A=
+ *=0A=
+ * Sets MASK and clears STATE on BOTH the DIFF and SE register pairs so th=
at the=0A=
+ * output is muted regardless of its electrical configuration.  The=0A=
+ * writes are wrapped in the PRG_CMD / NVM update / loop lock sequence=0A=
+ * so the new state is applied by the hardware.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_output_disable(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	bool muted;=0A=
+	u8 slot;=0A=
+	int rc, ret, state_rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (index >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	slot =3D info->clkout_map[index];=0A=
+	rc =3D sit9531x_prg_enter(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_output_hiz_write(sitdev, slot, true);=0A=
+=0A=
+	/*=0A=
+	 * Always leave the PRG_CMD programming state, even on a mid-sequence=0A=
+	 * write failure: prg_enter() unlocked the output loops, so returning=0A=
+	 * without prg_commit() would strand the chip in the programming state=0A=
+	 * with the loops unlocked.  Best effort -- keep the first error.=0A=
+	 */=0A=
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+	/*=0A=
+	 * Keep the software state aligned to what hardware now drives even=0A=
+	 * when one write in the sequence failed. The commit above may have=0A=
+	 * applied a partial mask/state combination.=0A=
+	 */=0A=
+	state_rc =3D sit9531x_output_forced_hiz(sitdev, index, &muted);=0A=
+	if (!state_rc) {=0A=
+		sitdev->out[index].enabled =3D !muted;=0A=
+		sitdev->out[index].state_stale =3D false;=0A=
+	} else {=0A=
+		/*=0A=
+		 * The writes may well have landed; what failed is the proof.=0A=
+		 * Mark the cached state for a read-through rather than=0A=
+		 * reporting the value it had before this call.=0A=
+		 */=0A=
+		sitdev->out[index].state_stale =3D true;=0A=
+		if (!rc)=0A=
+			rc =3D state_rc;=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_enable - un-mute an output (active state)=0A=
+ * @index:	logical output index (0..info->num_outputs-1)=0A=
+ *=0A=
+ * Releases MASK on BOTH register pairs so the output returns to=0A=
+ * whatever the initial_config blob programmed.  The writes are wrapped=0A=
+ * in the PRG_CMD / NVM update / loop lock sequence so the new state is=0A=
+ * applied by the hardware.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_output_enable(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	bool muted;=0A=
+	u8 slot;=0A=
+	int rc, ret, state_rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (index >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	slot =3D info->clkout_map[index];=0A=
+	rc =3D sit9531x_prg_enter(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_output_hiz_write(sitdev, slot, false);=0A=
+=0A=
+	/*=0A=
+	 * Always leave the PRG_CMD programming state, even on a mid-sequence=0A=
+	 * write failure: prg_enter() unlocked the output loops, so returning=0A=
+	 * without prg_commit() would strand the chip in the programming state=0A=
+	 * with the loops unlocked.  Best effort -- keep the first error.=0A=
+	 */=0A=
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+	/* See sit9531x_output_disable(): commit can apply a partial sequence. */=
=0A=
+	state_rc =3D sit9531x_output_forced_hiz(sitdev, index, &muted);=0A=
+	if (!state_rc) {=0A=
+		sitdev->out[index].enabled =3D !muted;=0A=
+		sitdev->out[index].state_stale =3D false;=0A=
+	} else {=0A=
+		/*=0A=
+		 * The writes may well have landed; what failed is the proof.=0A=
+		 * Mark the cached state for a read-through rather than=0A=
+		 * reporting the value it had before this call.=0A=
+		 */=0A=
+		sitdev->out[index].state_stale =3D true;=0A=
+		if (!rc)=0A=
+			rc =3D state_rc;=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Input priority selection=0A=
  *=0A=
@@ -1815,6 +2016,8 @@ static int sit9531x_out_state_fetch(struct sit9531x_d=
ev *sitdev, u8 index)=0A=
 	if (rc)=0A=
 		return rc;=0A=
 =0A=
+	sitdev->out[index].state_stale =3D false;=0A=
+=0A=
 	/*=0A=
 	 * DT board-config override: the per-PLL OUTPUT_ENABLE bitmaps=0A=
 	 * (0x27/0x28) do not unambiguously express output->PLL routing on=0A=
@@ -2455,13 +2658,23 @@ static bool sit9531x_dpll_pin_is_registrable(struct=
 sit9531x_dpll *sitdpll,=0A=
 {=0A=
 	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
 =0A=
-	if (dir !=3D DPLL_PIN_DIRECTION_INPUT)=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT) {=0A=
+		if (index =3D=3D SIT9531X_MAX_INPUTS)=0A=
+			return true;=0A=
+		if (index =3D=3D SIT9531X_INTSYNC_PIN_ID)=0A=
+			return false;=0A=
+=0A=
+		return sit9531x_input_pin_is_registrable(sitdev, index);=0A=
+	}=0A=
+=0A=
+	if (index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID)=0A=
 		return false;=0A=
 =0A=
-	if (index =3D=3D SIT9531X_MAX_INPUTS)=0A=
-		return true;=0A=
+	if (index >=3D sitdev->info->num_outputs)=0A=
+		return false;=0A=
 =0A=
-	return sit9531x_input_pin_is_registrable(sitdev, index);=0A=
+	return sitdev->out[index].pll_idx =3D=3D sitdpll->id &&=0A=
+	       sitdev->out[index].routed;=0A=
 }=0A=
 =0A=
 /*=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 1ab8ebfd78da..db9c73a79b04 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -100,6 +100,8 @@ struct sit9531x_ref {=0A=
  * @enabled:		output is driving, i.e. not forced into Hi-Z=0A=
  * @cmos:		output is wired single-ended; the Hi-Z pair that=0A=
  *			speaks for it is the SE one, not the differential=0A=
+ * @state_stale:	the cached mute state could not be confirmed against=0A=
+ *			hardware and has to be read back before it is reported=0A=
  * @routed:		output is mapped to @pll_idx by the initial=0A=
  *			configuration; an unrouted output has no DPLL pin=0A=
  * @pll_idx:		PLL driving this output (0-3)=0A=
@@ -109,6 +111,7 @@ struct sit9531x_out {=0A=
 	u64		freq;=0A=
 	bool		enabled;=0A=
 	bool		cmos;=0A=
+	bool		state_stale;=0A=
 	bool		routed;=0A=
 	u8		pll_idx;=0A=
 	const char	*label;=0A=
@@ -253,6 +256,8 @@ int sit9531x_input_prio_add(struct sit9531x_dev *sitdev=
, u8 pll_idx,=0A=
 /* ---- Output enable/disable (Hi-Z control) ---- */=0A=
 int sit9531x_output_disable(struct sit9531x_dev *sitdev, u8 index);=0A=
 int sit9531x_output_enable(struct sit9531x_dev *sitdev, u8 index);=0A=
+int sit9531x_output_state_refresh(struct sit9531x_dev *sitdev,=0A=
+				  u8 out_idx);=0A=
 =0A=
 /* ---- Output frequency ---- */=0A=
 int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index 88122a368053..d550eb626e6d 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -736,10 +736,91 @@ sit9531x_dpll_output_pin_frequency_set(const struct d=
pll_pin *pin,=0A=
 	return rc;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_state_on_dpll_get - get output pin state=0A=
+ *=0A=
+ * reports CONNECTED when the output is driven and=0A=
+ * DISCONNECTED when it has been muted via sit9531x_output_disable().=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_state_on_dpll_get(const struct dpll_pin *pin,=0A=
+					   void *pin_priv,=0A=
+					   const struct dpll_device *dpll,=0A=
+					   void *dpll_priv,=0A=
+					   enum dpll_pin_state *state,=0A=
+					   struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	const struct sit9531x_out *out;=0A=
+=0A=
+	/*=0A=
+	 * A mute whose read-back failed left the cache unconfirmed; there is=0A=
+	 * no poll of output state to correct it, so read it here rather than=0A=
+	 * report a value that may predate the request.=0A=
+	 */=0A=
+	if (sitdev->out[dpin->id].state_stale) {=0A=
+		mutex_lock(&sitdev->multiop_lock);=0A=
+		sit9531x_output_state_refresh(sitdev, dpin->id);=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+	}=0A=
+=0A=
+	out =3D sit9531x_out_state_get(sitdev, dpin->id);=0A=
+	*state =3D out->enabled ? DPLL_PIN_STATE_CONNECTED=0A=
+			      : DPLL_PIN_STATE_DISCONNECTED;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_state_on_dpll_set - mute/un-mute an output=0A=
+ *=0A=
+ * forces Hi-Z on the output pin via the Page 0x03=0A=
+ * force/state register pair.=0A=
+ *   CONNECTED    -> enable (release force, back to factory default)=0A=
+ *   DISCONNECTED -> disable (force Hi-Z)=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_state_on_dpll_set(const struct dpll_pin *pin,=0A=
+					   void *pin_priv,=0A=
+					   const struct dpll_device *dpll,=0A=
+					   void *dpll_priv,=0A=
+					   enum dpll_pin_state state,=0A=
+					   struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	switch (state) {=0A=
+	case DPLL_PIN_STATE_CONNECTED:=0A=
+		rc =3D sit9531x_output_enable(sitdev, dpin->id);=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_DISCONNECTED:=0A=
+		rc =3D sit9531x_output_disable(sitdev, dpin->id);=0A=
+		break;=0A=
+	default:=0A=
+		rc =3D -EINVAL;=0A=
+		break;=0A=
+	}=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc)=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set output pin state");=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_output_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_output_pin_direction_get,=0A=
 	.frequency_get		=3D sit9531x_dpll_output_pin_frequency_get,=0A=
 	.frequency_set		=3D sit9531x_dpll_output_pin_frequency_set,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_output_pin_state_on_dpll_get,=0A=
+	.state_on_dpll_set	=3D sit9531x_dpll_output_pin_state_on_dpll_set,=0A=
 };=0A=
 =0A=
 const struct dpll_pin_ops *=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
