Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD3F356747;
	Tue, 15 Sep 2026 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430438; cv=fail; b=UXi//5Nae3Y+af22NGnw0Rlatyee+/DuyEmjAQMztNRs2XjQJ6NoFgvxQo4hCU/+wcs0S1EMNlBC8dcXUONeCbvtyNfb9u3soOA5/8IdgS20xBtaRUPZDgPb2zQw1Of0T49JJFy6dLCWamNIDcxJq/TPgLYNLaN5E1VZrSdrvfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430438; c=relaxed/simple;
	bh=xNkaULCIOBf/Lm0LMm4G+vV73BxDXnyX44eikNLBKVU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P34oI9XytygFJR8dMMq7KgMMExgLq4vjFF3ABvrzcxSEePPy/BqGMEWo4xbmBIVyeuv2iUhmjk8oYsBK55HPkyitF62pLVNLnnEjp+kqEr2AcAKqYBarwbLAmvqdXXrJLGzFHU/0pYaq4yyxCNK5clNbNPNeyO95Iu48/yApgX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=jGEd5uvH; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=U1FIDRdW; arc=fail smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="jGEd5uvH";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="U1FIDRdW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=yvQa0iwlYToDiykaaCvjWqvqaVdCLe679NddldvdvlA=;
 b=jGEd5uvHRc7mkm1DCZxeFqTih6SVLmG+l71x7JOTvVxGcDktYm9M/wUVjfo6sXDop3uxiznFKEclUH8IGwva5wjuqMSerBkF5Ny6zh9bpEAO/G+JE7QhSgDWOAbeo+2fz5X0DDHw+u79+aWMZnLzRAeeSAnX+qOGISDMdFmBQ/G0ucsf44YA0IdFf6Z34ycUKCtO1+eHId9BCnvrezNCWqDa58weIBPb5cZ0boi022wrplLdJCyzojdmvR8E+xPh4fKePyHLZFyNkPVWwOefYIs2Sxg0j2wdZ8wePZjLKoYcQvU5ZBLo3Z3V5faaqpJ04BsFZ5GElQ7sOcbsRypcwQ==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021080.outbound.protection.outlook.com [52.101.62.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id B831378006E;
	Tue, 15 Sep 2026 00:00:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6Xs8pQxc5Yj4jn0ejnN23oR4rPPoTefYYQEhZG/bLI7+gomut4Qs+RCDTLMr4t0hcY886MhgSnwAWuufzKzo3tI6ujJHmE8lqBSCtgFZf2ttNWrByQGhRuC6rPzhxrc6Lmq0XoGwESSFbc0vkHKkvC9ott0pSlbcLtlbkWngjkhXzbk6o4kA8v/n6Gs8PeFQAUE4/Gu2K87M3gY/pZLI7uT7WOs35HjXPuuBNf1DsDzsmHhALrm9jBgrun9vExTyWhDlPG3n95iPLH/OEBlEQXUgu60SnwOrQfXEHKGAvb4U/rEhvzEJfJ4a0qhnf0ym7jAmN+urA0wbs3lIMCAGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvQa0iwlYToDiykaaCvjWqvqaVdCLe679NddldvdvlA=;
 b=U/10CTdUrDdEJq4rylMl3ffX5/Ad/UsdFDmxz6Z60IO7q7AwhXzuqPco7bU1g2q+2rErmEYF6A87lb+abZ8RHk+LxcD0luIJ83I4VRSRG/oTDqa3aEoKRBNV8Sani68bw31bmX3D44maY6woo+LKReWVN6jGLzFmJZyH+yWxO5VJCKqep3voEOG4woj+q8ygZNI+uWqif+CZTaiYz7hpLqD+SJYY92irjpIo2hdDBDnySKbagBp2qwJsaH1bzTehl7NWbReS12rkcGXiTIN0oyNJSQrsCdZMWwSf8khSC3OdvPJHYQ3XJMs0X5TepPD1aDzbKaj+HwM9nF7YBBj+Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvQa0iwlYToDiykaaCvjWqvqaVdCLe679NddldvdvlA=;
 b=U1FIDRdWYA8hmMImCMGU4WLEwtiyFz/IvzWfEayYP380JWXeKaglyWXCMxB8lYiKSXV7y92K/hMbWn8M3my/K1zx9L3qgq0MwrQCGxHSYkngN7YO81NMfTaTK2ls4Vr1Lf5Vmo+h1Iy6dtkEeqIm/sc6ApxpMLMlu+i9nK+c2ok7p6BJW8BTDs0DNq5C+XPZeTyBBcrHdw6jHcgv0V4LuGIGgZ2Y/3t2CohWv5wA1vIPGaiqlxWAEQE8Ih+m3pIhP3nuMTYybUMf/s5kRdvhMBOUBSI/3T1Tmp9nBVhLTjJPmP83PAYYRDgFpnevJwdK6b47bIrR++v4QIlPaeF9Cw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by PH0PR20MB4277.namprd20.prod.outlook.com
 (2603:10b6:510:12b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 00:00:29 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 00:00:29 +0000
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
Subject: [PATCH net-next v9 12/15] dpll: sit9531x: add support to get phase
 offset on the connected input pin
Thread-Topic: [PATCH net-next v9 12/15] dpll: sit9531x: add support to get
 phase offset on the connected input pin
Thread-Index: AQHdRKU0DYGz4JyTrEW944d/XfAgKg==
Date: Tue, 15 Sep 2026 00:00:22 +0000
Message-ID: <20260915000015.80480-13-arouhi@sitime.com>
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
x-ms-office365-filtering-correlation-id: f2746b90-4fd8-4c75-82c6-08df12bc5aeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|5023799004|56012099006|3023799007|6133799003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 2Sjs3mysRQebX9Vu7uSdhE9RyazpbCK6D7xY3VIakJErILPnqbIDugbT2S6pFbtuHxrw6SaxCkn//DSWbOK9vlZ+r+ruy/g1ShAjAiKd7Q3sOubVKFlN3/3W0p5ExNEKTj0zXmKhHIRDK2YOHtW1p9E5gFsuVvkGs0W8KZ5K4lyJURRgQdPCCCtaQn3cZOkYNn51clXOfDtLJZaSgBdV5YDS71zSR/fWcb5pHT1M1TXX+TRGeNGfmOxHtEX8pg5GP/9V0U+ty7RV/+6+hA5lDZ00oOsrlcTLt9ylfM1yUNgUtRfF4HjchQCcPFz7QNkVxYbtFtnYOmzpTqVb6c3jt4Dj+lBf7gYzJorKNofPy3dtX+KgUnKr5UsANLiEyCCkIpJVfVWf95uq5Th4csqPBfN5o5+AqhZRr6pYeY2dqD6g+aqftF/0Sd3/YivML8jdfHoyIdjYT+LRb7GB4wuNhiD/6sClCnm5wtat5go5Z1OuwLcBP3lMGRp2836Hpq5X4K1yYfxU8WFMkmjBRP/yzVFKu1F7oauCAZpJ7bd1jf7XkN1eQyoJH/TvtZYJezPGsP7l+nR6QKdLzaYqZgjHoWtXgodnEqRIdtzh2okv3YbphbmcgMmVLLcs8axRB1BFTKIF58vj9BVAA+wj+fMf90vFa4lgbSExUupnv8YMV4SLHqjrB5Aop5DmEF4RAeGCchuDOV2UhL9KWjO5DPuP7YzTSc4cUkdjoRTF5HvAXBc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(5023799004)(56012099006)(3023799007)(6133799003)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?rxvPeR3KMB9Q/9yNtwfhRZEQZQ7F5ceXpOtGhc51Hf16fwCt6Zy4Mnr7e4?=
 =?iso-8859-1?Q?n0Gb3rtMK6OsgAgPR/oHWlKBUwKOYhHwM0XGFAjCfn1p+xUpsHPp7aE/YZ?=
 =?iso-8859-1?Q?cUZQ5if7Aul9QwGPKnmekiNIrVTYkgqsyoTRxHluoplAw7Vi8ie7JyV66U?=
 =?iso-8859-1?Q?s44nndcsMSgtayD+9hF2D0om0LGiiTxgRRhu7Z3oagngM7xO2ityNaJhRZ?=
 =?iso-8859-1?Q?OvFB8PrQAD2vqEKrU39FjCFebDCcnnfGBVzuoRrrQf5iUOEtJYWaC3zegY?=
 =?iso-8859-1?Q?G4BjTehHOfCAnjdllt26IwKX1W87mZ5t9Szv+Dovx1p5bvJ1gStfAmqnNG?=
 =?iso-8859-1?Q?mqL4XOU45sUXiUzOwB+QmNYJJ4Oi9sMcFRwcp3iJiQN/RZug1YGJOmueMj?=
 =?iso-8859-1?Q?ou8LZXlkB9n4bowrZ79sZ/rt8AIpdjctmKA+nFJsT7wxtXULv0aaiW/9DJ?=
 =?iso-8859-1?Q?p5PPrwEDxmf37J3sRZGL5tx/TEZUJqsfMInyU5iMaRV/cn+FrF7/294nef?=
 =?iso-8859-1?Q?tU/qAEXgv25EojzB7PkbPUxZnKFUCu9L83VfXgVECi10tKwaihEbPgGI4P?=
 =?iso-8859-1?Q?uI8iIGXRAORqiy6Bq6lHegiIrKEy9sUPlu8CCNGjrplps6SS8oZn66a9jP?=
 =?iso-8859-1?Q?/doiM23AgdwLUx9uV+5f5WZoyo7sw+a5KLimdvtbJtq4drvw0p5OMBX5N0?=
 =?iso-8859-1?Q?rBN5POgef1ZCYTtiDzMAmA8VeC2QxEZt9Lg+mdiNINdrU/wv04ZGtrtRPa?=
 =?iso-8859-1?Q?edpSVubC1iaOYMJpVFo9cVs6HAbwRl8kxFxK4JlIrt7rt3OwCvfWDJClqL?=
 =?iso-8859-1?Q?5cjVvP7nQ1CiLiFJzm1AKrm4qTSGvOPGm9XKYf1Fw/WblIi2uroW1CfXUG?=
 =?iso-8859-1?Q?sEmUDQleqPBUJM8K9B3Yg8Nq3kqTFXRFKMiDMYMpZYo6ZEx2rUvT4V7k9t?=
 =?iso-8859-1?Q?FpKp5ae4pTWFVof0CjfAfvrpydxUn/AoZzA2ghqM/0tNgJRMh8qZGuswxg?=
 =?iso-8859-1?Q?tjpKqRzy1yIW6JIBZw7VZKGRIOISW1Yn3Z3GGRzbWYNcIemqN+vt+MS8mT?=
 =?iso-8859-1?Q?04fBnuG0MMjuvOZlhbShDOFWn2VJ5ymCWF8ik3yXSe+2uPOIs8DKgC0SLc?=
 =?iso-8859-1?Q?Qx82zArx5nx/yzutz7Ckj3MEgiXdJzatRlVKLFMTiwT3x28fmcyFcojlN3?=
 =?iso-8859-1?Q?W9aiLTtHYzf49lINs8hqq9LKm5zYQFp52zM2F4mB+woEAPrzQZ7Z5J91RT?=
 =?iso-8859-1?Q?w0tIpmGk4bCatYIaATXkw799FjikHfKaLNhKgM/Jmey4Lh95bPMlfnFHXR?=
 =?iso-8859-1?Q?Js0VpcVH1FAGIVHosTcNQIp9vodZuO6OV9446p++cleC9x0WrE78s55xpe?=
 =?iso-8859-1?Q?7Si7B3sScfRCEIW/ct6yhw3OGhVX4o788QTdNUHlNeBVhsBw3QVZj9XnJ/?=
 =?iso-8859-1?Q?tDssH9VCC1EjLn23dG/MYc8+iw3x2qfkYFLK3dnhrySQEINkpSBeGEE1K3?=
 =?iso-8859-1?Q?DjR2Rff/HVmYVkBZHyFVDeanND07I4ath6tORmsW9ZB211AdsV+0rvspQ/?=
 =?iso-8859-1?Q?/kBmKVoJH03gTsMbsYCem3aC28Dnw7gMkLNhSf+N3qZlDdcyWFQDTL/rz9?=
 =?iso-8859-1?Q?bGerNhKnf3pi4yja+29QP9qzXaNGoB9BFqtIxxQ4JTIjQ0adnzcc2jOfX1?=
 =?iso-8859-1?Q?/IiJ98lLXte6oP0r5TRL7bywzTGzO7N/XBzX+G3VmM69j450OjftlHSc9p?=
 =?iso-8859-1?Q?mqngzlacAYzGswYLZUXOC+DvAFgTsVEnT0mzuXlb+BLdyq?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	aNzQr0A8v+JQwhzvlllLyuuMhSJhybrZBnIdUcwSY9nUcRmMdxh1w2fX8N4V72i9cUX6HnsxiEy2uc7CLxyDA6IrVbz+/FN/+ebvBacz2eLyCMNVabPjJgJmlAtpenMwcdyM7HsMbYnJ71GTxE/A/xmiW086Rk6bcpaCSua7afckLI0aUh52iqDxcFN6wZ+g4VGIrqY7gD4SxHfQA35OREKZ/d8wIAbmF938RvGEZtmtKkzb+2Sf9AZkVBuB75ewKWiZJpuXvAv0Hu1aFl+D6LpS7n11626QkLPaHQyXdmLG6rWC8O11fNuX3NldkktlNS1+ssnLCvSthcV0T3789Q==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2746b90-4fd8-4c75-82c6-08df12bc5aeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 00:00:22.4552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IQpy+1N42RNsFFAQFlSbuyxMCoTGiJzM2XEe2tNHUmm8tAPxcmhyaTpe4wWOYHm0W5JYTQI0GJLYssEKEeYS/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB4277
X-MDID: 1789430433-ZgqefXFKOdDI
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1789430433;ZgqefXFKOdDI;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Report the phase difference between a PLL's reference and the PLL itself,=
=0A=
which is the loop's own residual error and therefore trends small on a=0A=
locked device -- that is the measurement, not an artefact of it.=0A=
=0A=
The value comes from the on-chip time-to-digital converter, read through=0A=
the debug window: unlock the window, point it at the converter, then read=
=0A=
the trigger register, which latches a fresh sample and returns the=0A=
previous one.  It is read three times per sample for that reason; a single=
=0A=
read hands back the sample from the last call, so a repeated measurement=0A=
would look perfectly steady while saying nothing.=0A=
=0A=
Only the input a PLL has actually selected has a phase offset against it.=
=0A=
For any other pin there is nothing to measure and zero is reported,=0A=
because the core abandons an entire pin dump on an error from any one pin.=
=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 148 +++++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/dpll.c | 102 ++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/regs.h |  38 +++++++++=0A=
 3 files changed, 288 insertions(+)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 46179a9e13c3..356d1eac4ec5 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -2132,6 +2132,154 @@ int sit9531x_output_pulse_ctrl_set(struct sit9531x_=
dev *sitdev,=0A=
 	return rc;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_phase_offset_read - read phase difference via TDC=0A=
+ * @phase_ps:	output phase difference in picoseconds=0A=
+ *=0A=
+ * Reads the Time-to-Digital Converter (TDC) signed 35-bit code from the=
=0A=
+ * PLL page registers, then converts to picoseconds using the VCO=0A=
+ * frequency: phase_diff =3D tdc_code / fvco.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_phase_offset_read(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       s64 *phase_ps)=0A=
+{=0A=
+	u64 fvco, mag_ps;=0A=
+	s64 tdc_signed;=0A=
+	u64 tdc_raw;=0A=
+	int rc, lock_rc, i;=0A=
+	bool sign;=0A=
+	u8 v;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/* Unlock the debug page so the TDC registers are accessible. */=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+				   SIT9531X_PLL_REG_DEBUG,=0A=
+				   SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+=0A=
+	/*=0A=
+	 * Select the debug clock for taps below 200 kHz, then point the=0A=
+	 * readback at the TDC.  Only the one bit is touched: writing the=0A=
+	 * modifier register whole would clear the fields belonging to=0A=
+	 * other taps.=0A=
+	 */=0A=
+	rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+				    SIT9531X_PLL_REG_DBG_WRITE_CODE,=0A=
+				    SIT9531X_DBG_LOW_FREQ_CLK_BIT,=0A=
+				    SIT9531X_DBG_LOW_FREQ_CLK_BIT);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+				   SIT9531X_PLL_REG_DBG_READ_CODE,=0A=
+				   SIT9531X_DBG_READ_CODE_TDC);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+=0A=
+	/*=0A=
+	 * Latch a sample by reading the trigger register.  A single=0A=
+	 * read returns the previous latch, so read it three times as=0A=
+	 * the documented phase-difference procedure does.=0A=
+	 */=0A=
+	for (i =3D 0; i < SIT9531X_DBG_LATCH_READS; i++) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_DBG_TRIGGER, &v);=0A=
+		if (rc)=0A=
+			goto relock;=0A=
+	}=0A=
+=0A=
+	tdc_raw =3D 0;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_4, &v);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+	sign =3D !!(v & BIT(SIT9531X_TDC_SIGN_BIT));=0A=
+	tdc_raw =3D (u64)(v & SIT9531X_TDC_MAG_HI_MASK) << 32;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_3, &v);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+	tdc_raw |=3D (u64)v << 24;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_2, &v);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+	tdc_raw |=3D (u64)v << 16;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_1, &v);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+	tdc_raw |=3D (u64)v << 8;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_0, &v);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+	tdc_raw |=3D v;=0A=
+=0A=
+	/*=0A=
+	 * Apply sign.  Per the register map the sign bit is active-high=0A=
+	 * for a positive offset: bit set -> +code, bit clear -> -code.=0A=
+	 */=0A=
+	tdc_signed =3D sign ? (s64)tdc_raw : -(s64)tdc_raw;=0A=
+=0A=
+	/*=0A=
+	 * Get VCO frequency for conversion.  -ENODATA means DIVN is not=0A=
+	 * programmed (PLL unused on this board) -- skip silently rather=0A=
+	 * than spamming the log on every poll cycle.  A register access=0A=
+	 * failure is returned as an error, not folded into a fabricated=0A=
+	 * 0 ps measurement.=0A=
+	 */=0A=
+	rc =3D sit9531x_get_fvco(sitdev, pll_idx, &fvco);=0A=
+	if (rc =3D=3D -ENODATA) {=0A=
+		dev_dbg(sitdev->dev, "PLL%c: Fvco unknown, skip TDC\n",=0A=
+			'A' + pll_idx);=0A=
+		rc =3D -ENODEV;=0A=
+		goto relock;=0A=
+	}=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+=0A=
+	/*=0A=
+	 * phase_diff (seconds) =3D tdc_code / fvco=0A=
+	 * phase_diff (ps) =3D tdc_code * 1e12 / fvco=0A=
+	 *=0A=
+	 * mul_u64_u64_div_u64() keeps the exact Hz denominator; dividing=0A=
+	 * by whole MHz instead would lose up to ~40 ppm of scale on a=0A=
+	 * fractional-DIVN Fvco.=0A=
+	 */=0A=
+	mag_ps =3D mul_u64_u64_div_u64(tdc_signed < 0 ? -tdc_signed : tdc_signed,=
=0A=
+				     1000000000000ULL, fvco);=0A=
+	*phase_ps =3D tdc_signed < 0 ? -(s64)mag_ps : (s64)mag_ps;=0A=
+=0A=
+	rc =3D 0;=0A=
+=0A=
+relock:=0A=
+	/*=0A=
+	 * Close the debug window again.  The key register opens every debug=0A=
+	 * register on this PLL while it holds the unlock value, and this read=0A=
+	 * runs on every pin-get of a connected input, so leaving it open=0A=
+	 * would mean normal monitoring permanently unlocks the block.=0A=
+	 */=0A=
+	lock_rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+					SIT9531X_PLL_REG_DEBUG,=0A=
+					SIT9531X_PLL_DEBUG_LOCK);=0A=
+	if (lock_rc && !rc)=0A=
+		rc =3D lock_rc;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_ref_state_fetch - read input reference status from hardware=0A=
  * @index:	logical input index=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index 0cad081eb599..1dfd83b635e2 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -603,6 +603,107 @@ sit9531x_dpll_input_pin_prio_set(const struct dpll_pi=
n *pin, void *pin_priv,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_phase_offset_get - phase offset of a reference=
=0A=
+ *=0A=
+ * What this reports, and what it deliberately does not:=0A=
+ *=0A=
+ * The ABI defines the attribute as the phase difference between the signa=
l=0A=
+ * on a pin and its parent DPLL device, so this is the loop's own residual=
=0A=
+ * error, sampled with the loop closed.  On a locked DPLL it therefore=0A=
+ * trends small -- that is the measurement, not an artefact of it.  The=0A=
+ * framework expects successive values to be averaged, which suits a=0A=
+ * closed-loop residual and not a one-shot open-loop capture.=0A=
+ *=0A=
+ * The chip can also measure the reference against the local oscillator=0A=
+ * with the outer loop's correction frozen, which is a different quantity=
=0A=
+ * and the one the documented phase-difference procedure produces.  That=
=0A=
+ * needs the digital loop filter held (and, on the 1PPS PLL, the automatic=
=0A=
+ * phase- and frequency-lock helpers held off), which leaves the PLL=0A=
+ * undisciplined until it is released.  A netlink read must not do that,=
=0A=
+ * so the open-loop measurement lives in a debugfs helper that owns the=0A=
+ * freeze and restores it; it is not this callback.=0A=
+ *=0A=
+ * Precondition, which this callback cannot create: the TDC compares=0A=
+ * against a signal the PLL drives, so a PLL driving no output with its=0A=
+ * zero-delay buffer off has nothing to measure.  SiTime confirms this is=
=0A=
+ * a property of the hardware rather than of their measurement script.=0A=
+ * The script satisfies it by mapping a spare output and restarting the=0A=
+ * PLL -- side effects that do not belong in a getter, so a reading taken=
=0A=
+ * in that state is simply not meaningful.=0A=
+ *=0A=
+ * Non-selected pins and a PLL with no programmed divider report zero=0A=
+ * rather than an error: the DPLL core propagates any error from this=0A=
+ * callback and fails the whole pin dump with it, unlike the frequency=0A=
+ * offset getter, where -ENODATA makes the core omit the attribute.  There=
=0A=
+ * is no per-pin "no data" for phase offset, so it is a value or no=0A=
+ * callback at all.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_phase_offset_get(const struct dpll_pin *pin,=0A=
+					 void *pin_priv,=0A=
+					 const struct dpll_device *dpll,=0A=
+					 void *dpll_priv, s64 *phase_offset,=0A=
+					 struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	enum dpll_pin_state state;=0A=
+	s64 offset;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	/*=0A=
+	 * The on-chip TDC is a per-PLL resource that always measures the=0A=
+	 * phase difference between the VCO and the PLL's currently=0A=
+	 * selected reference; it cannot be pointed at an arbitrary input.=0A=
+	 * For any input that is not the active reference there is no=0A=
+	 * meaningful per-pin phase offset, so report 0 instead of the=0A=
+	 * active reference's value.=0A=
+	 */=0A=
+	sit9531x_dpll_selection_state_get(sitdev, sitdpll, dpin->id, &state);=0A=
+	if (state !=3D DPLL_PIN_STATE_CONNECTED) {=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		dpin->phase_offset =3D 0;=0A=
+		*phase_offset =3D 0;=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	rc =3D sit9531x_phase_offset_read(sitdev, sitdpll->id, &offset);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	/*=0A=
+	 * -ENODEV means the PLL has no programmed DIVN (unused on this=0A=
+	 * board); report phase_offset =3D 0 so a full pin-get dump does not=0A=
+	 * fail just because one DPLL is dormant.=0A=
+	 */=0A=
+	if (rc =3D=3D -ENODEV) {=0A=
+		dpin->phase_offset =3D 0;=0A=
+		*phase_offset =3D 0;=0A=
+		return 0;=0A=
+	}=0A=
+	if (rc) {=0A=
+		NL_SET_ERR_MSG(extack, "TDC phase readback failed");=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * The ABI reports phase offset in units of 1/DPLL_PHASE_OFFSET_DIVIDER=
=0A=
+	 * picoseconds: the integer part of the attribute is the value divided=0A=
+	 * by the divider, the remainder is the fraction.  The TDC resolves one=
=0A=
+	 * VCO period (hundreds of picoseconds), so the fractional digits are=0A=
+	 * always zero here, but the magnitude still has to be scaled or every=0A=
+	 * reading would be reported a thousand times too small.=0A=
+	 */=0A=
+	offset *=3D DPLL_PHASE_OFFSET_DIVIDER;=0A=
+=0A=
+	dpin->phase_offset =3D offset;=0A=
+	*phase_offset =3D offset;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
 	.frequency_get		=3D sit9531x_dpll_input_pin_frequency_get,=0A=
@@ -610,6 +711,7 @@ static const struct dpll_pin_ops sit9531x_dpll_input_pi=
n_ops =3D {=0A=
 	.state_on_dpll_set	=3D sit9531x_dpll_input_pin_state_on_dpll_set,=0A=
 	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
 	.prio_set		=3D sit9531x_dpll_input_pin_prio_set,=0A=
+	.phase_offset_get	=3D sit9531x_dpll_input_pin_phase_offset_get,=0A=
 };=0A=
 =0A=
 /*=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index 9d515e109feb..08eae8a2c279 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -271,6 +271,44 @@=0A=
 #define SIT9531X_PLL_REG_DIVN_NUM		0x32  /* 4 bytes (0x32-0x35) */=0A=
 #define SIT9531X_PLL_REG_DIVN_DEN		0x38  /* 4 bytes (0x38-0x3B) */=0A=
 =0A=
+/* Debug register unlock */=0A=
+#define SIT9531X_PLL_REG_DEBUG		0xBD=0A=
+#define SIT9531X_PLL_DEBUG_UNLOCK		0xC3=0A=
+#define SIT9531X_PLL_DEBUG_LOCK			0x00=0A=
+=0A=
+/*=0A=
+ * Signal pathway debug readback -- PLL page.  Dig_Sys_ReadCode selects=0A=
+ * which point of the pathway is tapped, Dig_Sys_WriteCode carries the=0A=
+ * modifiers for that read, Dig_Sys_read7..read0 hold the sampled bytes=0A=
+ * and the trigger register latches a sample.  The TDC phase=0A=
+ * measurement is one tap among several, reached through read code 69.=0A=
+ */=0A=
+#define SIT9531X_PLL_REG_DBG_READ_CODE	0xB3=0A=
+#define SIT9531X_PLL_REG_DBG_WRITE_CODE	0xB4=0A=
+#define SIT9531X_DBG_LOW_FREQ_CLK_BIT	BIT(7)=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_0		0xB5  /* [7:0] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_1		0xB6  /* [15:8] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_2		0xB7  /* [23:16] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_3		0xB8  /* [31:24] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_4		0xB9  /* [34:32] + sign */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_5		0xBA  /* [47:40] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_6		0xBB=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_7		0xBC=0A=
+#define SIT9531X_PLL_REG_DBG_TRIGGER		0xD0  /* read to latch a sample */=
=0A=
+=0A=
+/*=0A=
+ * Reads of the trigger needed to latch a fresh sample.  One returns the=
=0A=
+ * previous latch, which the documented procedures work around by reading =
it=0A=
+ * three times.=0A=
+ */=0A=
+#define SIT9531X_DBG_LATCH_READS		3=0A=
+#define SIT9531X_DBG_DATA_BYTES		8=0A=
+=0A=
+/* Read code of the TDC phase tap, and the sign bit of its sample */=0A=
+#define SIT9531X_DBG_READ_CODE_TDC		69=0A=
+#define SIT9531X_TDC_SIGN_BIT		3=0A=
+#define SIT9531X_TDC_MAG_HI_MASK	GENMASK(2, 0)=0A=
+=0A=
 /*=0A=
  * DIVN carried as fixed point, and the unit the DPLL ABI wants the=0A=
  * fractional frequency offset in.  Equal in value, distinct in meaning.=
=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
