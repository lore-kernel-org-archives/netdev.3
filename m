Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A5E37649D;
	Tue, 15 Sep 2026 00:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430438; cv=fail; b=dw4VpKlvIRqshTP3DBexFYpyRtcsLx6BD5WlCYCROwjZ5bX8Wt++N6Aq/RnEx/lNnbzRZz1FiElDpJgxmXvOygbscdeq4N+E6t7GoxRiEcH7M5/9UhpsGqGdLAHne13IntICPJPfvQIg9zRue9exfw+Bq3DZ05YvP5hoJwleLic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430438; c=relaxed/simple;
	bh=4ogaUqGcc0ZFH6N0e+jHGsCQG+P+kX34aFqAkgfs94k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c9Ijnl5GoKHo8RQDfsVGYputfPlh+6O9Tba/ALVl6C56JuAzXfUIfqmILqQuL6tyT9nq2cak/OyWsQOUSspzKWJIhcF6EXQfhr9Mue/Ekwj3SmGBvW4S2yN3FvBQiSWmgs/fqWSBxNXhZzOmYo53KKb0ahuyBXoqw1/pDHCCbes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=Xqf7HjkN; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=PJdR5g+i; arc=fail smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="Xqf7HjkN";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="PJdR5g+i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=HvEC18gEyUNQciFhAVYi/2MEmLGeWBrvfWyWhRUSVdU=;
 b=Xqf7HjkNMFcasvlPtUQawPAMkUT90knM+5vLRk915E9WRBzAoSJWb7KlzsdFMY/AQ8srGZFXoO8bAuPFvVkOI9z3Tx3jwVzMJu4n2M3KL2LYDhhcaxuyEO2yGG1S1QeJ89DYCVSWPQvqo/6onKd8fbqXQNSuxMorTCo/4xE/bOB59TWbM4BBf5nY9X1WY5o/dH/7+5XUu1AzZcl/XpWTlHMDDdxW9M1g+VPM09tRgLBN26kwHuT+gVJUcBmepV6PxpAahMHvOEmaj8plAsroArBI4IqJSmanONuKe+gc9FL5jazM8DZ/y0kmx+cQdOfM2zYxikYpZGMNynucJH3XAg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021133.outbound.protection.outlook.com [52.101.62.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 01145B00086;
	Tue, 15 Sep 2026 00:00:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6p/L3bCae02VWUKDZDBhC+ubdCThe5SqKyAl2PcCEemYEIKNHwF911tAk3uI1AQAREvb+Ak5nztr5p2wLoZbtEJMhgAFLpqMIfNsZzRCvSRcCgBwEUPnpVX0Bi/CJvCM5H20yLOrOcFB0mOTSZQ6EECE8zEJ0r0AYuFgeUpxqJ8xSqa7mnQq/JuJI5ewcwB0QlJx+MlOtN/7uQkDAFYftk8qIE5bYmXRNn6btRNu2mc4ItgFW8r4MHEZLw0df/M40+qQ75ggHbg/wCKOLC+26wVtYYfZOwPAQlZC9vW2H0TSTnM1/y5LN8tEY6Goac0hxtyzQPD3v5lNm/6X3X1Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvEC18gEyUNQciFhAVYi/2MEmLGeWBrvfWyWhRUSVdU=;
 b=eDdqKsKvFY8Hy8S/oXeeFVYxK0JDOAPYJGOPvE2/WyJxVj5zZGGTs3g4LxPEC92YAHyY5S5210QMPotQNtg43aSZyCP8y5YPSkI44hh4S8mON+O3PXEndH6at0y4wD25NUpaZTOPC9IfUZz9hyUb65eaAwJNiL5YnOYP4XqlKmAwt5nI2AXOtQhmb2rOOLRbPzh8/FkGe8f7vOtOJPiWTyIPu3CPeuHWMhJo5GK/qpbgGjuVGNbQ8RkXerYL/1Xo6K2AYgQmXm+acVMZ2/boZm65MhUDDIugmrctYTdkXriHT4d0/tP/7aRCAyPiOdtww50ZwXas+hwbGhgYgBIuhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvEC18gEyUNQciFhAVYi/2MEmLGeWBrvfWyWhRUSVdU=;
 b=PJdR5g+i2DWXdtZD45XvSFtV1QUwtw+45MMZYZjofUMCFndzGABvEjuLFAEkVGrQusOE4Dx+sznWv2yK542nWNOaLOZlJviXhqF6NJG4v2+7EBUBXrdWtLWGo4lAvGQnC8SyWVcDi1oWy4XPLALnFHhOBMS+nF38FpU14pCx65RnTH9Nl+hHFIdGSyM8uLPtoIsnuy12saPNBOK8ftSDJsLTYM1aVa4pMpwUZktk2/myTR0Vjw0rhty0vp9ffkX2kN72ouvv0F7GB9gcXR4DfOwk/4+ou+QRJknvr1UZkVy+rbRvjnwZjcdxAVJO+cBI9OY8AvkIx9SnRPEAraKfWg==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by PH0PR20MB4277.namprd20.prod.outlook.com
 (2603:10b6:510:12b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 00:00:31 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 00:00:31 +0000
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
Subject: [PATCH net-next v9 13/15] dpll: sit9531x: add support to get
 fractional frequency offset
Thread-Topic: [PATCH net-next v9 13/15] dpll: sit9531x: add support to get
 fractional frequency offset
Thread-Index: AQHdRKU0cSdcIKcxzk+ha1otmwaSJg==
Date: Tue, 15 Sep 2026 00:00:23 +0000
Message-ID: <20260915000015.80480-14-arouhi@sitime.com>
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
x-ms-office365-filtering-correlation-id: 0088de0b-50df-424c-e36b-08df12bc5bd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|3023799007|6133799003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 CZ5U8js8isPMdVKAsyHtN3hJeosp6cot1Aol2qtrZ7iael3picxMYCouj7Gk/GIROMxaT99YRQei1oT5lDE9KYZgpls61m+vFCjwHARZFt05tPTW+aIXzVD3pPi70Hxsr7MJn3C7LZ/41d9d2G0ekUvqIKSXJd+PCOrKi2M3KOhPtxzAhbmX27UHmDnReciHvmzk6NruB963YstUDkNpmXImrttASf1UadhxLO/fb82rSNdmCO0sozUVF+D1gqUGkizmeCkCguATxx3qBFxr3qrhXcJZdgyeSVyMfE1XKIg7CYb+3r9b7aEIQtyK6VFIR+5aDw5fSJRqYYYH2rK7H2PV3RhNK618C13OoXc9/Eap13tuTtIMvvdkOiAgX3JHbgE2I0UK4JOAg1QGfEG1oZ3GF5bXXo55wPSFW2c0OeXDC7gN0NSJOXX+T1y/dba2JWl1B6uJ0jrU83yWgaeVVwmTbN7+UiIwJsIJDIMiGdKfSDL0bTQc2re3qDOyphdqDhCTzvw66ynPuM5ae/AMklhXF7TWGml0Iejl4XSe9DhJwRJM2rSd8q5btNKYjIGWfGvSkSlF09sYA/ZPiBg1VHqzMw1I8FdnskQxs4rM00/bJ9VR+8zbsxW8+Ztu1U8KfFRjTMVRkK+TiwxOcI67TnqVh3j43Jv37H7TChfu8/VSg+EEXHVjWjbPxKAcQIvTY2IOd5exOvcUBUQhyJS+i8Zz6Het+CLhAGRfZ2Peqp8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(3023799007)(6133799003)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?eOxmHO4rk75q7nSaLO0Go/6G4BiHTxYXK8G+OVJGwYWvHUWWLAHaoGUdZN?=
 =?iso-8859-1?Q?XghWlc12bOoRgBsK0dv4625ZIB8TRr8TmJGddptsBJryDLfhH29JYGyu3O?=
 =?iso-8859-1?Q?sF5PGr55j2Xsg2XvrSb7ddURK7FZWfRpHHwJMaFPx8yMnBbbBP9mpOXZEi?=
 =?iso-8859-1?Q?fc9kLj9vtOGBWsqeHixD3PF0Xy2wuKgXU2MGlIEdRcol1t1Lg9iN/N184S?=
 =?iso-8859-1?Q?SdobQWZKDnmFuhY2ALFi18XmiVWGOTgPiaf4lyjhU1AvNwnML5vLUNj8+u?=
 =?iso-8859-1?Q?ZnXOGcJINX0ko/bDnq2LACu6V2sBwQ3jPHLzDGl17GhE3JLW75tlx2/TWv?=
 =?iso-8859-1?Q?hfOAHtxt0PlO2Y6Nz9lygrQZCZyEcqKrnarTcWzXHeEHEyr8FbceFeyRv2?=
 =?iso-8859-1?Q?XJ1BkBxuG7eD+gkvPhxbUhAbtUIQ72S1uJgLKAyc/E0cVLP5HwQb5zvgkV?=
 =?iso-8859-1?Q?7q+ZetRdT7S5EhS/9AFkZZLoFdqumHfWPm/YRugI6kt9ynMSbUXp2gh1/9?=
 =?iso-8859-1?Q?5vEmtc5//jsfhCvHv7C5vH7bPFA4/S4IYpFk/KNXxT2nkA1bsmJSRSmLUW?=
 =?iso-8859-1?Q?JhbR11ShL63y9lpUFPWDs3rTqjytsNmhgJvgto0SZDYXoi9Kf0ZdvpiO/w?=
 =?iso-8859-1?Q?u2FUNpLSgb+Xp0hrxXIhlc2rzgLZMSrtRRxYueiZLIPQmz8sek7dHxId7P?=
 =?iso-8859-1?Q?wy0ODg4UhI5/nAkye1fIbBF1QDmljtfm8dR1WkaMjOL/PxkkGrWQXdxepb?=
 =?iso-8859-1?Q?xpnQPjB08Qr0ftLHj2sFldMZAblCwZdWF7g9jjFHhA5hZnhzt/9aaLh290?=
 =?iso-8859-1?Q?rcQ+LZfdMuDlYVykdDGoeKh/yKFt1sMe7MvN7MZ8t4qFGzaYgxl8vXZHb9?=
 =?iso-8859-1?Q?IdQiu4A2Gj3DFUzsYAPEm6UIxF+ly1tj8xFtWXUcKa8UDIYm0WrSgbY38v?=
 =?iso-8859-1?Q?ox0Av9P/R0ztzU1QlRuO4SRc1L/aKQ537o4lkdT/k8MxFat2dYUFEI/FCn?=
 =?iso-8859-1?Q?KLmpVdVIrOJ9QBucWxbGbaY7DeU8sRTXFAb8GZMafy6NoPsfnHhos3HApL?=
 =?iso-8859-1?Q?S81cj9aBzE8MreM3DUYrSk4dvI0xm15UQ52A1lN0GFgXXJVuTq1jkxhZqB?=
 =?iso-8859-1?Q?ndEJ+dO/WV1Udp3g/KqF5P8CZ3TQ2tSGxFJsOkYlXYeuT/Tl5/POtbAgkC?=
 =?iso-8859-1?Q?KgfGfAOTaFx1681oZ14n+o3bbhEUfi6hzU9qpIYinryNpWX8SsVWKjFAp1?=
 =?iso-8859-1?Q?gz0CUXNGGf0/VZS5SJa7PdtZjE5Dhu6Lu0KlMtt1ZFGyJ8VgaXC9ECf3oz?=
 =?iso-8859-1?Q?bvzwgZcOKU0NAUCYibIh0i5krpWaLKw2CnTZc2iKmQ2iA+IN/LKZWIP6oV?=
 =?iso-8859-1?Q?xvhf/Vz4TcnRb2uej7yDYx93+EBdcuZHQsjq5uIg/Evm+JwNF/EHYy/u5a?=
 =?iso-8859-1?Q?Oc9Eulbz9/+K25yq1uQlSXlSf2Qk00Kj8rndy5y73GR25teJhc2aJSW2yR?=
 =?iso-8859-1?Q?NeK2VCxXWrxTFP69oFvgiVSrhuaEQVe3Nt/jexS3e2q0ZmLrh6dwrJm0bw?=
 =?iso-8859-1?Q?l5r5xF7mM3CJOMl8P5n1Dhwub7/4axk+mxdTqeI0s8QHKn9kia5wDEJQ03?=
 =?iso-8859-1?Q?wHZu0317MJRADM9Nv6/Ap8UyExwmnHbr+7m+rbfcR7/w6SMxK6q9GSlyqG?=
 =?iso-8859-1?Q?gU6JK3hk1wuCGo3cPZKH3ROBbroPM+B6AlYX3MEQvTR2vXHvTkc2v06lz8?=
 =?iso-8859-1?Q?TNONcbC1vEVQ2uVp80mOVABOOXCSBz/6TdCA6THaug7IO6?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	va2DTFxDz1cAXb8kROLI9XsmsQ8L+FMd9CPwT5WIpuDXOObcwm1IBWLiTlrrIhXEeT7svBV+PY7E8WJRaf2WT9ix/SYZb4gN5NiAGuUHUcx6TJbaBTNXbJLogFBxy2AyTxDiOwvdk6T5pLD+OQZps6Evtf/ymLHcZwxqB4psDC8vCXr5Rddxy8SQOF0P5dzy2HF6Uejk84nHUZ1BFXcQWEDZx4X2hohhe5FNqC+CXx0pUve6I7rusR/MFr0kbCuwhaQcuGc63DOlj8eIHmfeEjZmF5BeLVtGxDL7/5r70U/tBlNHCwq7ZicG1fCyUypBz70LXdXmB792M123fl/4qw==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0088de0b-50df-424c-e36b-08df12bc5bd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 00:00:23.0743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rZE+muCMDGl77IhcmZJbMMlX1NWAXhuUuOiYPxEgwgHDptSMwzZHJSwkorFs98ArIklMBErBumOp/vlsaR/waA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB4277
X-MDID: 1789430434-g1Y95ETxeVnY
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1789430434;g1Y95ETxeVnY;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Report how far a PLL's reference is from nominal, as a fraction of the=0A=
nominal rate.=0A=
=0A=
The device does not measure that directly, but it does run a feedback=0A=
divider that the loop adjusts to keep the reference in step: the=0A=
difference between the divider the loop is running and the divider the=0A=
configuration asked for is exactly the offset of the reference.  Both are=
=0A=
read from the chip -- the configured one from its registers, the running=0A=
one through the debug window -- and the offset falls out of the ratio.=0A=
=0A=
The running value comes from the same latched debug window as the phase=0A=
offset, so it is triggered three times per sample for the same reason.=0A=
=0A=
The running divider is two numbers read through a window that exposes one=
=0A=
tap at a time, so the numerator and the denominator come from separate=0A=
samples and a loop moving between them can tear the pair.  On a locked=0A=
loop the divider moves by parts per trillion between two register reads,=0A=
which is below what this measurement resolves; the part offers no way to=0A=
latch both at once.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 194 +++++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/dpll.c |  51 +++++++++=0A=
 drivers/dpll/sit9531x/regs.h |  12 +++=0A=
 3 files changed, 257 insertions(+)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 356d1eac4ec5..88bfa63b2975 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -1224,6 +1224,76 @@ static int sit9531x_is_xo_doubler_enabled(struct sit=
9531x_dev *sitdev)=0A=
 	return (~val >> SIT9531X_XO_DOUBLER_ENB_BIT) & 1u;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dbg_sample - latch and read a signal pathway debug sample=0A=
+ * @sitdev:	device pointer=0A=
+ * @pll_idx:	PLL index (0-3)=0A=
+ * @read_code:	which tap of the pathway to sample=0A=
+ * @buf:	result, least significant byte first=0A=
+ * @len:	bytes to read, at most SIT9531X_DBG_DATA_BYTES=0A=
+ *=0A=
+ * Return: 0 on success, <0 on error=0A=
+ */=0A=
+static int sit9531x_dbg_sample(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       u8 read_code, bool low_freq_clk,=0A=
+			       u8 *buf, unsigned int len)=0A=
+{=0A=
+	unsigned int i;=0A=
+	int rc;=0A=
+	u8 v;=0A=
+=0A=
+	if (len > SIT9531X_DBG_DATA_BYTES)=0A=
+		return -EINVAL;=0A=
+=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_DEBUG,=0A=
+				   SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/*=0A=
+	 * Select the debug clock this tap needs.  The device never clears=0A=
+	 * the bit, so a read that left it to whatever the previous one set=0A=
+	 * would depend on the order the taps happened to be read in.  Taps=0A=
+	 * below 200 kHz need the slow clock; the divider taps do not.=0A=
+	 */=0A=
+	rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+				    SIT9531X_PLL_REG_DBG_WRITE_CODE,=0A=
+				    SIT9531X_DBG_LOW_FREQ_CLK_BIT,=0A=
+				    low_freq_clk ?=0A=
+				    SIT9531X_DBG_LOW_FREQ_CLK_BIT : 0);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+				   SIT9531X_PLL_REG_DBG_READ_CODE, read_code);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/*=0A=
+	 * Reading the trigger latches a sample of the selected tap.  Read it=0A=
+	 * three times, as the documented phase-difference procedure does and as=
=0A=
+	 * sit9531x_phase_offset_read() already did: a single read returns=0A=
+	 * the previous latch, so a caller sampling repeatedly gets the same=0A=
+	 * value back however much the tap has moved.=0A=
+	 */=0A=
+	for (i =3D 0; i < SIT9531X_DBG_LATCH_READS; i++) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_DBG_TRIGGER, &v);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+	}=0A=
+=0A=
+	for (i =3D 0; i < len; i++) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_DBG_DATA_0 + i,=0A=
+					  &buf[i]);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * DIVN as a fixed-point value: int_part plus fracn/fracd, carried with=0A=
  * SIT9531X_DIVN_SCALE steps per unit.  The scale keeps a whole DIVN=0A=
@@ -1291,6 +1361,130 @@ static int sit9531x_divn_static(struct sit9531x_dev=
 *sitdev, u8 pll_idx,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_divn_runtime - read the DIVN the digital loop is commanding=0A=
+ * @sitdev:	device pointer=0A=
+ * @pll_idx:	PLL index (0-3)=0A=
+ * @divn:	result, fixed point as per sit9531x_divn_fixed()=0A=
+ *=0A=
+ * Same quantity as sit9531x_divn_static(), but sampled from the running=
=0A=
+ * loop rather than from the configuration registers, and carried at a=0A=
+ * wider precision: the numerator is 48 bits, two's complement, the=0A=
+ * denominator 49.  The integer part shares its tap with the numerator.=0A=
+ *=0A=
+ * The denominator is taken as it reads.  The configuration register holds=
=0A=
+ * the divisor minus one, and correcting for that reproduces a profile's=
=0A=
+ * stated VCO exactly, to the last bit of the fraction; this tap is a wide=
r=0A=
+ * field sampled from the loop itself and the documented readback uses it =
as it=0A=
+ * comes, so the bias is not applied here.=0A=
+ *=0A=
+ * The numerator and the denominator come from two separate latches:=0A=
+ * the debug window exposes one tap at a time, so the pair can be torn=0A=
+ * by a loop that moves between them.  The divider changes by parts per=0A=
+ * trillion between samples on a locked loop, which is below what this=0A=
+ * measurement resolves.=0A=
+ *=0A=
+ * Return: 0 on success, <0 on error=0A=
+ */=0A=
+static int sit9531x_divn_runtime(struct sit9531x_dev *sitdev, u8 pll_idx,=
=0A=
+				 s64 *divn)=0A=
+{=0A=
+	u8 buf[SIT9531X_DBG_DATA_BYTES];=0A=
+	u64 fracn_raw =3D 0, fracd =3D 0;=0A=
+	u32 int_part;=0A=
+	int rc, i;=0A=
+=0A=
+	rc =3D sit9531x_dbg_sample(sitdev, pll_idx, SIT9531X_DBG_READ_CODE_DIVN,=
=0A=
+				 false, buf, SIT9531X_DBG_DATA_BYTES);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	for (i =3D 5; i >=3D 0; i--)=0A=
+		fracn_raw =3D (fracn_raw << 8) | buf[i];=0A=
+=0A=
+	int_part =3D buf[6] | ((u32)(buf[7] & SIT9531X_DIVN_RT_INT_HI_BIT) << 8);=
=0A=
+=0A=
+	rc =3D sit9531x_dbg_sample(sitdev, pll_idx,=0A=
+				 SIT9531X_DBG_READ_CODE_DIVN_DEN, false, buf,=0A=
+				 SIT9531X_DBG_DATA_BYTES);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	for (i =3D 5; i >=3D 0; i--)=0A=
+		fracd =3D (fracd << 8) | buf[i];=0A=
+=0A=
+	fracd |=3D (u64)(buf[6] & SIT9531X_DIVN_RT_INT_HI_BIT) << 48;=0A=
+=0A=
+	/*=0A=
+	 * sit9531x_divn_fixed() drops the fractional part when the=0A=
+	 * denominator is zero.  That is right for a configuration register=0A=
+	 * that was never programmed, but a running loop reading zero means=0A=
+	 * the sample is unusable, and returning the whole part alone would=0A=
+	 * put a wrong DIVN into the frequency offset without saying so.=0A=
+	 */=0A=
+	if (!fracd)=0A=
+		return -ENODATA;=0A=
+=0A=
+	*divn =3D sit9531x_divn_fixed(int_part,=0A=
+				    sign_extend64(fracn_raw,=0A=
+						  SIT9531X_DIVN_RT_NUM_BITS - 1),=0A=
+				    fracd);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/**=0A=
+ * sit9531x_pll_ffo_ppt - fractional frequency offset of a PLL's reference=
=0A=
+ * @sitdev:	device pointer=0A=
+ * @pll_idx:	PLL index (0-3)=0A=
+ * @ffo:	result in parts per trillion=0A=
+ *=0A=
+ * A locked PLL commands whatever DIVN keeps its VCO tracking the=0A=
+ * reference.  How far that sits from the configured DIVN is how far the=
=0A=
+ * reference sits from the local oscillator, which is the fractional=0A=
+ * frequency offset the DPLL ABI reports for the pin feeding the device.=
=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, -ENODATA when DIVN is not programmed, <0 on=0A=
+ * error.=0A=
+ */=0A=
+int sit9531x_pll_ffo_ppt(struct sit9531x_dev *sitdev, u8 pll_idx, s64 *ffo=
)=0A=
+{=0A=
+	s64 configured, running, delta;=0A=
+	u64 magnitude;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	rc =3D sit9531x_divn_static(sitdev, pll_idx, &configured);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	/*=0A=
+	 * Scaling by a divider far below one whole cycle overflows the=0A=
+	 * 64-bit product and comes back as ~0, which would be reported=0A=
+	 * as a plausible offset.  A DIVN that small is not a running=0A=
+	 * loop, so treat it as no measurement.=0A=
+	 */=0A=
+	if (configured < SIT9531X_DIVN_SCALE)=0A=
+		return -ENODATA;=0A=
+=0A=
+	rc =3D sit9531x_divn_runtime(sitdev, pll_idx, &running);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	delta =3D running - configured;=0A=
+	magnitude =3D mul_u64_u64_div_u64(abs(delta), SIT9531X_PPT_PER_UNIT,=0A=
+					(u64)configured);=0A=
+=0A=
+	*ffo =3D delta < 0 ? -(s64)magnitude : (s64)magnitude;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_get_fvco - read VCO frequency from chip's DIVN registers=0A=
  *=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index 1dfd83b635e2..2a973364a9cd 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -603,6 +603,50 @@ sit9531x_dpll_input_pin_prio_set(const struct dpll_pin=
 *pin, void *pin_priv,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_ffo_get - read the input's frequency offset=0A=
+ *=0A=
+ * The offset is derived from how far the PLL's running DIVN sits from=0A=
+ * its configured one, which only says something about the reference the=
=0A=
+ * PLL is actually tracking.  For every other input there is no=0A=
+ * measurement, and -ENODATA leaves the attribute out rather than=0A=
+ * reporting the active reference's figure against the wrong pin.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_ffo_get(const struct dpll_pin *pin, void *pin_priv=
,=0A=
+				const struct dpll_device *dpll, void *dpll_priv,=0A=
+				struct dpll_ffo_param *ffo,=0A=
+				struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	enum dpll_pin_state state;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	/*=0A=
+	 * Publish FFO only for the input the DPLL is actively tracking.=0A=
+	 * selected_ref alone is not enough (free-run, LOL, holdover), so use=0A=
+	 * the same CONNECTED criterion as the generic selection-state logic.=0A=
+	 */=0A=
+	sit9531x_dpll_selection_state_get(sitdev, sitdpll, dpin->id, &state);=0A=
+	if (state !=3D DPLL_PIN_STATE_CONNECTED) {=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		return -ENODATA;=0A=
+	}=0A=
+=0A=
+	rc =3D sit9531x_pll_ffo_ppt(sitdev, sitdpll->id, &ffo->ffo);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc && rc !=3D -ENODATA)=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Failed to measure the frequency offset of the selected referenc=
e");=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_dpll_input_pin_phase_offset_get - phase offset of a reference=
=0A=
  *=0A=
@@ -712,6 +756,13 @@ static const struct dpll_pin_ops sit9531x_dpll_input_p=
in_ops =3D {=0A=
 	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
 	.prio_set		=3D sit9531x_dpll_input_pin_prio_set,=0A=
 	.phase_offset_get	=3D sit9531x_dpll_input_pin_phase_offset_get,=0A=
+	/*=0A=
+	 * The measurement compares the PLL's running feedback divider with=0A=
+	 * its configured one, so it describes the device's own reference=0A=
+	 * rather than a port rate.=0A=
+	 */=0A=
+	.supported_ffo		=3D BIT(DPLL_FFO_PIN_DEVICE),=0A=
+	.ffo_get		=3D sit9531x_dpll_input_pin_ffo_get,=0A=
 };=0A=
 =0A=
 /*=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index 08eae8a2c279..78e8a47e96ab 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -309,6 +309,18 @@=0A=
 #define SIT9531X_TDC_SIGN_BIT		3=0A=
 #define SIT9531X_TDC_MAG_HI_MASK	GENMASK(2, 0)=0A=
 =0A=
+/*=0A=
+ * Read codes of the running DIVN taps.  Unlike the configuration=0A=
+ * registers these report what the digital loop currently commands, so=0A=
+ * they carry the correction the loop applies to track its reference.=0A=
+ * The integer part and the numerator share one tap, the denominator=0A=
+ * has its own.=0A=
+ */=0A=
+#define SIT9531X_DBG_READ_CODE_DIVN		0x57=0A=
+#define SIT9531X_DBG_READ_CODE_DIVN_DEN	0x56=0A=
+#define SIT9531X_DIVN_RT_NUM_BITS		48=0A=
+#define SIT9531X_DIVN_RT_INT_HI_BIT		BIT(0)=0A=
+=0A=
 /*=0A=
  * DIVN carried as fixed point, and the unit the DPLL ABI wants the=0A=
  * fractional frequency offset in.  Equal in value, distinct in meaning.=
=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
