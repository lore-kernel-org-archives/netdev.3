Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBDD50EBF9;
	Fri,  9 Oct 2026 18:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570740; cv=fail; b=FWMRLykZO1uaZGoKsmCmxAw5zn0Qr/HbIgNVEvFRYvU1+Z7SGS8T3mccVd4V636X5pmSxx2EwCskMdcIa+Cc25G7W0XHsPK/EGk+9yYvnjqedHPsho3ehYGJSjn6EGc01pZMkGAKbUu/sJqAI3Q2l4oxwU7QnxSzqmgtm2JSOr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570740; c=relaxed/simple;
	bh=1iIrrzxY/8HzmS6cqBXAujoj3dbUwkNWkGoQu7/TqUM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gfpQ7M+CkrjBFLWL9L6dHBDojw1pnlWrqnXQznomMduiKIE645jI/xc51/C5QQ41FWCODfEVhpIgDiKWROgrFPT8Bj5RqbKH7w1YPICJIiLpgr3izrjpGBXarxPwiWXRVcU4P7IlISrjsRau35RBOweJ3l+OqVvl0v41B3x9p0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=RmBXpZN9; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=fVG9mUHh; arc=fail smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="RmBXpZN9";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="fVG9mUHh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=DnZzAANWt5aLtprR38JF/mdNopeV5B/37nFscp1No/k=;
 b=RmBXpZN9Pv7tmKdKUdk+5fDOrQovO5VeQ7KsILyGvjwoqD0MQ6JlxkgJNIXknsH1z87dk69q5O6neVKwbmnvGy587jULqoNtmHVMIKXe7D1aDen/9lJx1hvOJiQcH6cYDn0+hFYiThqCXEEPkCRdgfHQwbQPoLNOlqs4VevCzd0DMrwZEKEjK058lvvNZFHvSqBDokNcUAh4C/CxjjxDg7ILkVOoJW0PXNJKrx38alzN0f2VJgrEx7Xd5BMH1hoIWKURqQbuue0CrV7fJVWHQYu6jQXtxUotzFmcbnZ4VoaGbwP0nXzpqWodSAhhb2NashG3QeyMX9mWgesqA+Yp5A==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023142.outbound.protection.outlook.com [40.93.201.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 4E591A80076;
	Fri,  9 Oct 2026 18:32:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSn63G3JifM/0/TtgWmOjSgXdgDnzy9KQVZo7dhG5pXsrg8JoKOnKZNPrzT9cjhlq0Zq6wFbJkWCQXvhcs4DZQeVunmAhBkrko5OzGo/3BEKwBKqRO2TFdB6CBB2kIr3ZklFXjFhMJmXYQYUyXq58dRdff495lyh6th1apBLj0KIxhUtfqDxA2itfrzL71L9SWkAkP5XCC/ajGid8of6NdDE3pPOu3zgrOVh7O/5WTHPizeGXECqQExqVD3SVV7y1cCouGOx7gIuTpKh1YJvn7Fp9jTo8E53+QrNSQ3iAPcjOmsdKvnbuNmzrGBeZ59bJMVu4VImKt/PElv4Gn+/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnZzAANWt5aLtprR38JF/mdNopeV5B/37nFscp1No/k=;
 b=iBVeyfuRJIiUVb019L6ntwsXBXouQNOrzEBL2+DIWxDjOkXs/B9/efWDXCkDadysbD9GwyqPbKiOf/ew3D4u26+drKZ+xc9I3nz0pPtBmC4iI6OtqcjnBOFRYJnpXpDhvgD/4l/c76LTq+LCidTr85S/z9m7dHhAk68opHuTKpbarbpE7k1Q/B0ifJkL51+sOCVJeATIv9paMqHxa6JesN6S8z+SIVA1ExAx8jcKjbkjT17iFut3iEZpWkjkzEKOD5i8uoyXEoXIobRev3GkPPrSbB1cAZ2B4Wgaf7vN7MwRDTKG4whh6rNAzGUtLoELvfN+gCnfOZQzy8D6oL/nRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnZzAANWt5aLtprR38JF/mdNopeV5B/37nFscp1No/k=;
 b=fVG9mUHhIqV8qewbBESM/9itD8EYD3Q3bfbAKSUNgBFQIWSj8rHSs1cU4Cg61UtbvIXKGB6nP73QroUgHOUspx7k3bh2YboGa+TxKB5aaAJjUNr3cOh80eU/r5liO7PuZxthXhj3sVqjCXBY6nFdntZUPc0KVEmfAY3RHiVUzXHgnDNyhqUeiO188sBHPCazOMBNNSZYvVaofDoLMi+jrIGIuAk9ziumyop1nhZyf9IHe29oZgWaKYBGSZbhaLBK3lSyit6IOKQXT/fNhoCuxUS6bPkwam+Xth3iGL+tPQtxi3US8kSKGtRJDMOSRrlf9PSzycZXSk/Dd/ybVJy8FA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CH8PR20MB995515.namprd20.prod.outlook.com
 (2603:10b6:610:2eb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 18:32:00 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:32:00 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Oleg Zadorozhnyi
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v12 11/12] dpll: sit9531x: add support to get phase
 offset on the connected input pin
Thread-Topic: [PATCH net-next v12 11/12] dpll: sit9531x: add support to get
 phase offset on the connected input pin
Thread-Index: AQHdWBx4wzOZFR3yNkS/B0/b7lHImw==
Date: Fri, 9 Oct 2026 18:31:59 +0000
Message-ID: <20261009183151.78497-12-arouhi@sitime.com>
References: <20261009183151.78497-1-arouhi@sitime.com>
In-Reply-To: <20261009183151.78497-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|CH8PR20MB995515:EE_
x-ms-office365-filtering-correlation-id: d7f1d5ef-4f8c-449b-93f6-08df26339b5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|56012099006|5023799004|260925021311599003|260925021911599003|260925022911599003|10067099003|22082099003|18002099003|3023799007|6133799003;
x-microsoft-antispam-message-info:
 m70gG0uChFpXZOnv2K0IhOF1GPwT7N8mleH/z1Iiz02FgcKPgrusG21W+t9Xe8EyQ6mieqy717tISI2wmqSj3aFU9ZLi/SfvEHDB9R5sSkgkxVMCpHYJQD2hHyKj5wW7G976pxCigGTz+hFKZG7yDO7elHG+lKf/tV+PaQQzZyDrO68Ay7EYnyvseBTna2PXAL/xWuM4xH4C+L1FQQ2BHZIPYb+54QjqbQqoykiTTszYm+408nAyDM/8zTD1bpUDmmFKBvs2tBKDYXL9GIidFinb7K3pBxDlz2ClqEyVnzNYp8FMjcV2SmN5DRlGfqFdoySX+bIFWFNe63bmW/iLRUp0GEn8JNIbtGIC0re1W3KFQj3X84Pkfow07+q4az5DOVwEG/Xngyxu7hT7j5eIrFbDrfXrCcX9JxuDpBzFVrHICCPlnv8Dcp/4tuUyV3QC/e1utrA8gsRmsqWUZ/jP8+BAkysuCG8/03GA7YPowQPHZRzvYeBBOAMkzZ9XCJNM6n3RbEyUECi+aIm2AyKRhFpgp5BtFjYT9nMKUSBIgwGrIbXftI5/5nupAN6zSsbrW7QghUtxiVAOk86uzAtnT2hHSjpLMZjKH7f634ctK7Ct6h/4DGlKRrnKDSiQwtL5jUY7x/bS3gxO/OVyMZ1oLZwbduqmLyOsG+gnPTpEmAgWuGbAnlwsBjKOq/CcdTW6I10xPSmivlFgZcFhaddmwx7bWi/5hRMZ/GlVoJqwez8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(56012099006)(5023799004)(260925021311599003)(260925021911599003)(260925022911599003)(10067099003)(22082099003)(18002099003)(3023799007)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?o4MuoNvp1GGFlI5p+IptiBkNdA3iuitzvYP069UgqwkSkicO8FzjfJmmOn?=
 =?iso-8859-1?Q?ur1HEJoydR1S/MZLtPcBWLduJBjGGTFr3SCFVFP72vYq2faTV4NkxXsdn9?=
 =?iso-8859-1?Q?Etz293UWeFDVcAsAQthHdBr6PXcFV5zIIY/VMneBEEhuborzKBFxmMTEid?=
 =?iso-8859-1?Q?TqPjXDkrNAO28wUfk/xUXrv/BMVIyv3EJMcsi/VWni6ZE7gEmrjgScFZhq?=
 =?iso-8859-1?Q?HCz8DTsdOZty3GqfCLUe+jhQCT1fqykot/3teslQ49LZoCO+03naDdzGrb?=
 =?iso-8859-1?Q?Rj92FPfkTb24/R5BahfLLCmAZLkOeHaStX3GiPPMxA50IvntFLyDpEJN8Y?=
 =?iso-8859-1?Q?rTpGEAv/HXRe9PM9sW0z5guIX+8+VzdHWOq5sPb5JolhVrSzSq3WSCJYX7?=
 =?iso-8859-1?Q?XjLJ45WHSlny7s0htl8y5zI9ixXbE86Cm8le8Bx/XKl85bMViXENaUXXip?=
 =?iso-8859-1?Q?YxzfkGfYQoUhZM1hO/7/w5i+nQx88uA1LAwFz2dgfCE7R0rZGcrCzQP3xz?=
 =?iso-8859-1?Q?gXk/CGH5bGQ99NLhdXtfB+ZcKe7ckK20KwgXwe+DCdWCGsa5mOd3Dgpob/?=
 =?iso-8859-1?Q?ix8wdQyRh9taZbugC/UsIE5/WVTiPxFK1k1RLX1DL+wTnTPGmAPq1JLFl+?=
 =?iso-8859-1?Q?ag3vsWCCb2CzqJuBbK5/Tg3HVf0FB2k38V4ERvNxHe1QVwPRT63VYlthNe?=
 =?iso-8859-1?Q?lqhas5QflIpmjfi/ZL/ZOe0Fhne69pbKHra4h8wcDkYC4X2kqNSXDE1xjl?=
 =?iso-8859-1?Q?YyYhNia4clJfHMvnIVloT/HRPrv/XZPb4JvIfF9Q1GvPHaF4cg0lk+RKIi?=
 =?iso-8859-1?Q?RLowWQOXMK/ITGKfsdx3Dpj+tfkeOCtz6OO6966IbFUNSnpgsZBV3p3bcB?=
 =?iso-8859-1?Q?8oyY3eoeRGVZq8aSNjeDRYe4jw3/PKuTxIxlCZAs//xAaLxBGqDbx11ZU1?=
 =?iso-8859-1?Q?STBe/DaclrVWinsBdAtxN96cwSmt20NNy66FN+VjnysrRV/gUPGhEh/k/7?=
 =?iso-8859-1?Q?gkODhhzBOsAp0Q9eMSw7BsV276YKsJXLQt0pFpH8N9Dwyw/2vBSLdS9QVh?=
 =?iso-8859-1?Q?Uab04+pYVIL0lE1SJoPCSqJY9lbqCwmScX9OyeGC3/3Gc+Lw2lEa/urNeO?=
 =?iso-8859-1?Q?PZQ5598LBGvlq9HQDJXDDonaHf7QrnFCtXCoeJPKbbvakm3CjKOdkIh7/Q?=
 =?iso-8859-1?Q?wbi6Bl+rY3jo/jb0eoe0+iYqSezmhMh8iO6DSjerJ2QqljPaDJ1gdVajJE?=
 =?iso-8859-1?Q?LCcMkAUQBhw4E9l6UbawGrJeASye0T7uH5P56yEYRx72NIGCL+74wpcw6R?=
 =?iso-8859-1?Q?0b8/gm4tOO9DZ0aXFct2F6k3NL14n53qUggR3q/7dqoYHCwUCFhUhgDN5Q?=
 =?iso-8859-1?Q?gWUqjkvmjFudbPXGwC39CF3fV4zOakGILgvhI1eza60NuJ4VpwTN1jTdFU?=
 =?iso-8859-1?Q?4HgNF/GnKj0hFht0Rc5Rcrb+Y1C1BsJBN7OLDSkuYhwuNiEAg8uVZsFbsT?=
 =?iso-8859-1?Q?DkwsEopiNQyjxiU1hh2f1I4uB8/Z/IfaqyiST+GqHB9kXsE1jLPzUpK9MA?=
 =?iso-8859-1?Q?tGvLn3PK91eV3RP1HGf97Whdl8pCCAqKv+S9tyr7STaTEXewcWEZ1KCb5d?=
 =?iso-8859-1?Q?7twdrKDM7L4uHthZE0gDYMYvKZ6AITAanyE3CfrzrfYJuGQ4K3PX2tloaE?=
 =?iso-8859-1?Q?ougTDm3Q6GFBcOs4x+b2qY1C9NNN+wbMyBFD7BRAouDfyC9OTtU8CAh1B9?=
 =?iso-8859-1?Q?LdR1bIxApN9ynHZgb+uNDM1hpkSbqjUlucK7spoC8/rDjz?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	I3c++kZdQ79ebqz28o1nNXNm5E3+ImNLHUY1AERDxAuepBwj+/0s2FPIklPQ14Nofv9kMU2jvGZVRONQPB0xLdj0oYPL2dY24K16fm1HoK+gX472VDD8M/LxM6tOpltDErPvRRXv3d1InlKsq5blfIq+3ny/80MqzloqJnhvonAthU5a3q9AMUi5x0JMJ1qr8jF3k0PGV2MVHF1gRDR/YH45XaATZTxjz1sPnsu7XJylv23FIlaObrqLtfpaaMNvxM41qDp+6aa39JoIQw7OOJ+WTlWHR1C8S/Nh02uimrGGG+0VLGjb+kgmuN5OySlsPdR2vwRKTxp5Z8KZcR07sg==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f1d5ef-4f8c-449b-93f6-08df26339b5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 18:31:59.9485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qYuLA0cocWdsI9r/I4t3WbD5VUo2U9WBydR5J3vDDFCQy69+BXMK9UJ13x+gRmbhWsVUaPiEJl9SXpWFF/UyfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR20MB995515
X-MDID: 1791570722-xlZsiLhMgb9F
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1791570722;xlZsiLhMgb9F;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
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
would look perfectly steady while saying nothing.  The offset keeps the=0A=
fraction of a picosecond the converter resolves.=0A=
=0A=
Only the input the device feeds a PLL has a phase offset against it.=0A=
For any other pin there is nothing to measure and zero is reported,=0A=
because the core abandons an entire pin dump on an error from any one pin.=
=0A=
That pin reads zero too when no sample was taken: the PLL is not=0A=
tracking, drives no un-muted output, has no usable VCO rate, or the=0A=
device moved it off the pin, or the lane lost its signal, between the=0A=
check and the sample.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: LLM=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 220 +++++++++++++++++++++++++++++++++--=0A=
 drivers/dpll/sit9531x/core.h |   5 +=0A=
 drivers/dpll/sit9531x/dpll.c | 147 +++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/regs.h |  22 ++++=0A=
 4 files changed, 385 insertions(+), 9 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 8a8872b18d2c..fbac70787ada 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -922,8 +922,9 @@ static int sit9531x_prio_prg_commit(struct sit9531x_dev=
 *sitdev)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
-/*=0A=
+/**=0A=
  * sit9531x_input_mon_fetch - read the clock monitor status of every lane=
=0A=
+ * @sitdev:	device pointer=0A=
  *=0A=
  * Four registers carry a nibble per lane.  Loss of signal and frequency=
=0A=
  * drift are what separate an input the device could lock to from one it=
=0A=
@@ -932,7 +933,7 @@ static int sit9531x_prio_prg_commit(struct sit9531x_dev=
 *sitdev)=0A=
  *=0A=
  * Caller must hold sitdev->multiop_lock, or run before registration.=0A=
  */=0A=
-static int sit9531x_input_mon_fetch(struct sit9531x_dev *sitdev)=0A=
+int sit9531x_input_mon_fetch(struct sit9531x_dev *sitdev)=0A=
 {=0A=
 	static const unsigned int regs[] =3D {=0A=
 		SIT9531X_CLKMON_P_STATUS_01, SIT9531X_CLKMON_P_STATUS_23,=0A=
@@ -3026,6 +3027,202 @@ int sit9531x_clear_notifications(struct sit9531x_de=
v *sitdev)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/**=0A=
+ * sit9531x_phase_offset_read - read phase difference via TDC=0A=
+ * @sitdev:	device pointer=0A=
+ * @pll_idx:	PLL index (0-3)=0A=
+ * @phase_offset:	phase difference in units of 1/DPLL_PHASE_OFFSET_DIVIDER=
=0A=
+ *		of a picosecond, as the DPLL subsystem carries it=0A=
+ *=0A=
+ * Reads the Time-to-Digital Converter (TDC) code from the PLL page=0A=
+ * registers -- a 35-bit magnitude with a separate sign bit -- then=0A=
+ * converts it using the VCO frequency: phase_diff =3D tdc_code / fvco.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, -ENODATA when the PLL has no known VCO rate=0A=
+ * (nothing is sampled then), or the register access error=0A=
+ */=0A=
+int sit9531x_phase_offset_read(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       s64 *phase_offset)=0A=
+{=0A=
+	u8 v, old_write_code, old_read_code;=0A=
+	bool have_old =3D false;=0A=
+	int rc, ret, i;=0A=
+	s64 tdc_signed;=0A=
+	u64 fvco, mag;=0A=
+	u64 tdc_raw;=0A=
+	bool sign;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/*=0A=
+	 * Get the VCO rate first.  -ENODATA means the PLL has no rate to=0A=
+	 * convert against (a divider this board leaves unprogrammed), and=0A=
+	 * there is then no reason to open the debug window at all -- which=0A=
+	 * also keeps a bus error while it is open from ever being reported=0A=
+	 * as that benign case.=0A=
+	 */=0A=
+	rc =3D sit9531x_get_fvco(sitdev, pll_idx, &fvco);=0A=
+	if (rc) {=0A=
+		if (rc =3D=3D -ENODATA)=0A=
+			dev_dbg(sitdev->dev,=0A=
+				"PLL%c: Fvco unknown, skip TDC\n",=0A=
+				'A' + pll_idx);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	/* Unlock the debug page so the TDC registers are accessible. */=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+				   SIT9531X_PLL_REG_DEBUG,=0A=
+				   SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+=0A=
+	/*=0A=
+	 * Remember the tap selection so it can be put back.  The key=0A=
+	 * register is re-locked below, but the mux is not part of the key:=0A=
+	 * leaving it parked on the TDC with a slow sampling clock selected=0A=
+	 * is a state change the caller did not ask for, and the next reader=0A=
+	 * of a different tap would have to know to undo it.=0A=
+	 */=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_WRITE_CODE,=0A=
+				  &old_write_code);=0A=
+	if (!rc)=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_DBG_READ_CODE,=0A=
+					  &old_read_code);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+=0A=
+	have_old =3D true;=0A=
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
+	 * Latch a sample by reading the debug status data register.  A=0A=
+	 * single read returns the previous latch, so read it three times=0A=
+	 * as the documented phase-difference procedure does.=0A=
+	 */=0A=
+	for (i =3D 0; i < SIT9531X_DBG_STATUS_READS; i++) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_DBG_STATUS_DATA,=0A=
+					  &v);=0A=
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
+	 * phase_diff (seconds) =3D tdc_code / fvco=0A=
+	 * phase_diff (ps) =3D tdc_code * 1e12 / fvco=0A=
+	 *=0A=
+	 * Scaled by the subsystem's divider before the division rather than=0A=
+	 * after it: one TDC code is 1e12 / fvco ps, a fraction of a=0A=
+	 * picosecond more often than not (203.45 ps at 4.9152 GHz), and=0A=
+	 * truncating to whole picoseconds first would leave the three=0A=
+	 * fractional digits the attribute carries always zero.  The=0A=
+	 * quotient fits u64 for any rate sit9531x_get_fvco() returns: it=0A=
+	 * refuses one below the VCO band.=0A=
+	 *=0A=
+	 * mul_u64_u64_div_u64() keeps the exact Hz denominator; dividing=0A=
+	 * by whole MHz instead would lose up to ~40 ppm of scale on a=0A=
+	 * fractional-DIVN Fvco.=0A=
+	 */=0A=
+	mag =3D mul_u64_u64_div_u64(tdc_signed < 0 ? -tdc_signed : tdc_signed,=0A=
+				  1000000000000ULL * DPLL_PHASE_OFFSET_DIVIDER,=0A=
+				  fvco);=0A=
+	*phase_offset =3D tdc_signed < 0 ? -(s64)mag : (s64)mag;=0A=
+=0A=
+	rc =3D 0;=0A=
+=0A=
+relock:=0A=
+	if (have_old) {=0A=
+		ret =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+					    SIT9531X_PLL_REG_DBG_READ_CODE,=0A=
+					    old_read_code);=0A=
+		if (ret && !rc)=0A=
+			rc =3D ret;=0A=
+		ret =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+					    SIT9531X_PLL_REG_DBG_WRITE_CODE,=0A=
+					    old_write_code);=0A=
+		if (ret && !rc)=0A=
+			rc =3D ret;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Close the debug window again.  The key register opens every debug=0A=
+	 * register on this PLL while it holds the unlock value, and this read=0A=
+	 * runs on every pin-get of a connected input, so leaving it open=0A=
+	 * would mean normal monitoring permanently unlocks the block.=0A=
+	 */=0A=
+	ret =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+				    SIT9531X_PLL_REG_DEBUG,=0A=
+				    SIT9531X_PLL_DEBUG_LOCK);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_ref_state_fetch - read input reference status from hardware=0A=
  * @index:	logical input index=0A=
@@ -3124,8 +3321,13 @@ static int sit9531x_pll_is_active(struct sit9531x_de=
v *sitdev, u8 pll_idx,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
-/*=0A=
- * Read the reference the device feeds a PLL.=0A=
+/**=0A=
+ * sit9531x_chan_routed_ref_read - read the reference the device feeds a P=
LL=0A=
+ * @sitdev:	device pointer=0A=
+ * @pll_idx:	PLL index (0-3)=0A=
+ * @ref:	result: logical input index, SIT9531X_INTSYNC_PIN_ID for the=0A=
+ *		inter-PLL sync net, or SIT9531X_REF_INVALID when the code=0A=
+ *		names no registered input=0A=
  *=0A=
  * The active selection names the source the PLL was told to follow.  The=
=0A=
  * input subsystem feeds the PLL that source while it has signal and falls=
=0A=
@@ -3140,12 +3342,12 @@ static int sit9531x_pll_is_active(struct sit9531x_d=
ev *sitdev, u8 pll_idx,=0A=
  * free-run the PLL is fed nothing and the bus is not consulted, so the=0A=
  * caller checks the mode first.=0A=
  *=0A=
- * @ref is the logical input index, SIT9531X_INTSYNC_PIN_ID for the=0A=
- * inter-PLL sync net, or SIT9531X_REF_INVALID when the code names no=0A=
- * registered input.  Caller must hold sitdev->multiop_lock.=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, <0 on error=0A=
  */=0A=
-static int sit9531x_chan_routed_ref_read(struct sit9531x_dev *sitdev,=0A=
-					 u8 pll_idx, u8 *ref)=0A=
+int sit9531x_chan_routed_ref_read(struct sit9531x_dev *sitdev, u8 pll_idx,=
=0A=
+				  u8 *ref)=0A=
 {=0A=
 	int rc, lock_rc;=0A=
 	u8 v, i;=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 19efff5112a3..1ed20354f94d 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -310,6 +310,11 @@ int sit9531x_clear_notifications(struct sit9531x_dev *=
sitdev);=0A=
 /* ---- INTSYNC (inter-PLL synchronization) ---- */=0A=
 =0A=
 /* ---- Phase offset (TDC readback) ---- */=0A=
+int sit9531x_chan_routed_ref_read(struct sit9531x_dev *sitdev, u8 pll_idx,=
=0A=
+				  u8 *ref);=0A=
+int sit9531x_input_mon_fetch(struct sit9531x_dev *sitdev);=0A=
+int sit9531x_phase_offset_read(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       s64 *phase_offset);=0A=
 =0A=
 /* ---- State helpers ---- */=0A=
 =0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index 436e4b76a727..aab5a4f0f946 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -669,6 +669,151 @@ sit9531x_dpll_input_pin_prio_set(const struct dpll_pi=
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
+ * documentation describes the reported value as one that may be averaged=
=0A=
+ * over prior measurements, which suits a closed-loop residual and not a=
=0A=
+ * one-shot open-loop capture; the core publishes whatever this callback=
=0A=
+ * returns, so the averaging, if any, would be this driver's to do.=0A=
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
+ * so that measurement is not offered here at all; it belongs to a caller=
=0A=
+ * that can own the freeze and restore it.=0A=
+ *=0A=
+ * Precondition, which this callback cannot create: the TDC compares=0A=
+ * against a signal the PLL drives, so a PLL driving no output with its=0A=
+ * zero-delay buffer off has nothing to measure.  SiTime clock=0A=
+ * engineering confirms this is a property of the hardware, not of=0A=
+ * SiTime's TDC measurement procedure, which satisfies it by mapping a=0A=
+ * spare output and restarting the PLL -- side effects that do not belong=
=0A=
+ * in a getter, so a reading taken in that state is simply not meaningful.=
=0A=
+ *=0A=
+ * Non-selected pins and a PLL with no programmed divider report zero=0A=
+ * rather than an error: the DPLL core propagates any error from this=0A=
+ * callback and fails the whole pin dump with it.  The core has no per-pin=
=0A=
+ * "no data" for phase offset, as it has -ENODATA for the fractional=0A=
+ * frequency offset, so it is a value or no callback at all.=0A=
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
+	bool drives =3D false;=0A=
+	s64 offset;=0A=
+	u8 routed, i;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	/*=0A=
+	 * The on-chip TDC is a per-PLL resource that always measures the=0A=
+	 * phase difference between the VCO and the PLL's currently=0A=
+	 * selected reference; it cannot be pointed at an arbitrary input,=0A=
+	 * so an input that is not the active reference reports 0 rather=0A=
+	 * than the active reference's value.=0A=
+	 *=0A=
+	 * The sample needs both: the PLL tracking this pin as the poll last=0A=
+	 * saw it (locked, outer loop running, not frozen), and the device=0A=
+	 * still feeding it this pin, read now -- the device moves on its=0A=
+	 * own, and a cache up to a poll period old could attribute a live=0A=
+	 * measurement to the pin the PLL used to be fed.  The device is read=0A=
+	 * again after the sample for the same reason: it can switch during=0A=
+	 * the dozen transfers the sample takes.=0A=
+	 *=0A=
+	 * The TDC also compares against a signal the PLL drives, so a PLL=0A=
+	 * with no routed, driving output has nothing to measure and reports=0A=
+	 * 0 like any other pin without a reading.  Output state is never=0A=
+	 * polled, so a mute or unmute whose read-back failed is read=0A=
+	 * through here first, as the output's own getter does, rather than=0A=
+	 * taken from a cache that was left describing the state before it.=0A=
+	 */=0A=
+	for (i =3D 0; i < sitdev->info->num_outputs; i++) {=0A=
+		if (!sitdev->out[i].routed ||=0A=
+		    sitdev->out[i].pll_idx !=3D sitdpll->id)=0A=
+			continue;=0A=
+		if (sitdev->out[i].state_stale) {=0A=
+			rc =3D sit9531x_output_state_refresh(sitdev, i);=0A=
+			if (rc) {=0A=
+				mutex_unlock(&sitdev->multiop_lock);=0A=
+				NL_SET_ERR_MSG(extack,=0A=
+					       "Output mute state could not be read back");=0A=
+				return rc;=0A=
+			}=0A=
+		}=0A=
+		if (sitdev->out[i].enabled)=0A=
+			drives =3D true;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * The lane's signal is read live as well: a loss since the last poll=0A=
+	 * makes the device fall back on its own, and a sample taken then=0A=
+	 * would be credited to a pin the PLL is no longer on.=0A=
+	 */=0A=
+	rc =3D sit9531x_input_mon_fetch(sitdev);=0A=
+	if (rc) {=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Failed to read the input clock monitors");=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	if (!drives ||=0A=
+	    !sit9531x_dpll_selection_active(sitdev, sitdpll, dpin->id)) {=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		*phase_offset =3D 0;=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	rc =3D sit9531x_chan_routed_ref_read(sitdev, sitdpll->id, &routed);=0A=
+	if (!rc && routed =3D=3D dpin->id) {=0A=
+		rc =3D sit9531x_phase_offset_read(sitdev, sitdpll->id, &offset);=0A=
+		if (!rc)=0A=
+			rc =3D sit9531x_chan_routed_ref_read(sitdev, sitdpll->id,=0A=
+							   &routed);=0A=
+		if (!rc && routed !=3D dpin->id)=0A=
+			rc =3D -ENODATA;=0A=
+	} else if (!rc) {=0A=
+		rc =3D -ENODATA;=0A=
+	}=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	/*=0A=
+	 * -ENODATA means no reading: the PLL has no known VCO rate, or the=0A=
+	 * device moved the PLL off this pin around the sample.  Report 0 so a=0A=
+	 * full pin-get dump does not fail over it.  Every other errno,=0A=
+	 * -ENODEV from a vanished adapter included, is a failure.=0A=
+	 */=0A=
+	if (rc =3D=3D -ENODATA) {=0A=
+		*phase_offset =3D 0;=0A=
+		return 0;=0A=
+	}=0A=
+	if (rc) {=0A=
+		NL_SET_ERR_MSG(extack, "TDC phase readback failed");=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	*phase_offset =3D offset;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
 	.frequency_get		=3D sit9531x_dpll_input_pin_frequency_get,=0A=
@@ -677,6 +822,7 @@ static const struct dpll_pin_ops sit9531x_dpll_input_pi=
n_ops =3D {=0A=
 	.operstate_on_dpll_get	=3D sit9531x_dpll_input_pin_operstate_on_dpll_get,=
=0A=
 	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
 	.prio_set		=3D sit9531x_dpll_input_pin_prio_set,=0A=
+	.phase_offset_get	=3D sit9531x_dpll_input_pin_phase_offset_get,=0A=
 };=0A=
 =0A=
 /*=0A=
@@ -693,6 +839,7 @@ static const struct dpll_pin_ops sit9531x_dpll_input_pi=
n_norate_ops =3D {=0A=
 	.operstate_on_dpll_get	=3D sit9531x_dpll_input_pin_operstate_on_dpll_get,=
=0A=
 	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
 	.prio_set		=3D sit9531x_dpll_input_pin_prio_set,=0A=
+	.phase_offset_get	=3D sit9531x_dpll_input_pin_phase_offset_get,=0A=
 };=0A=
 =0A=
 /*=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index 7c41111dca20..1891679698e2 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -284,6 +284,28 @@=0A=
 #define SIT9531X_PLL_REG_DIVN_NUM		0x32  /* 4 bytes (0x32-0x35) */=0A=
 #define SIT9531X_PLL_REG_DIVN_DEN		0x38  /* 4 bytes (0x38-0x3B) */=0A=
 =0A=
+/*=0A=
+ * Signal pathway debug readback -- PLL page.  Dig_Sys_ReadCode selects=0A=
+ * which point of the pathway is tapped, Dig_Sys_WriteCode carries the=0A=
+ * modifiers for that read, Dig_Sys_read7..read0 hold the sampled bytes=0A=
+ * and a read of the debug status data register latches a sample.  The=0A=
+ * TDC phase measurement is one tap among several, reached through read=0A=
+ * code 69.=0A=
+ */=0A=
+#define SIT9531X_PLL_REG_DBG_READ_CODE	0xB3=0A=
+#define SIT9531X_PLL_REG_DBG_WRITE_CODE	0xB4=0A=
+#define SIT9531X_DBG_LOW_FREQ_CLK_BIT	BIT(7)=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_0		0xB5  /* [7:0] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_1		0xB6  /* [15:8] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_2		0xB7  /* [23:16] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_3		0xB8  /* [31:24] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_4		0xB9  /* [34:32] + sign */=0A=
+=0A=
+/* Read code of the TDC phase tap, and the sign bit of its sample */=0A=
+#define SIT9531X_DBG_READ_CODE_TDC		69=0A=
+#define SIT9531X_TDC_SIGN_BIT		3=0A=
+#define SIT9531X_TDC_MAG_HI_MASK	GENMASK(2, 0)=0A=
+=0A=
 /* DIVN is carried as fixed point, in steps of 1e-12 of a whole divider */=
=0A=
 #define SIT9531X_DIVN_SCALE		1000000000000ULL=0A=
 =0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
