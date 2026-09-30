Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E161048F011;
	Wed, 30 Sep 2026 23:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811211; cv=fail; b=JMOIZhYYaulSq7qUOuG1FWFC/czmj4sKYkF6Q/x4Scwyye3TjCc5a/ufoC8u+ezQoBZpqOWRPIlRn9M3ikr9eMr2vFa65VOCspYGkc/rJj/vt2bx3PkLSK4g+1wz5uzEGE+rKMtPyTIjh7uRA0nV1A8rLC4as+qoSdDUC63JHGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811211; c=relaxed/simple;
	bh=vxi0m2z/ujAN6TrJ+Vw9LW0S5Q531OlD3nOJ/OyyVMM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zur8pY7+dxe/0N2BD4WHhF25hQ3YWAjg6eBYtU+IFWWwh1Nxyi6u8h6Bzg4nYhvQgOUnPyWfTJmHWH97McB1t5dsIzdNRMIrWrUwfWeMczPe8SMXQUCF327UpwfGz4cOGo8fhpXG71JD+mqmDUhaS9M+XOMHiLOM52IE7/6PlRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=i22f1hxy; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=nl21LWW9; arc=fail smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="i22f1hxy";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="nl21LWW9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=9NuINhxPCXG4byxPa8GwpVy+mNOEciSlj79+F1r015Q=;
 b=i22f1hxy6Z18fgetxQTOKzJj5Ovzr0tKdHHa6EKdcGgBb9hqqCdBc7wwVuX1ehaysYYZ/agScs651zJILVpBcTrQR5vzeE4nxk+nY2+N+E9ioQ8O4NUTmNfkBxj004q75n/1GlaRXgAWUP42i0Xoap4mo0b0JjwRlqEPbSZ4LgjUiJVHg44/ghFmGBVKs5grPWnmKg1xZ33IXqMDTlihWGwi4wq/lwjP+1EwOSojHgo7v6zGblg+JHs00O/yczzQKQEGL14kDOijwCigIdNjso5G7lyUxYjk2hFJVy/Y+V0r3GMd06/2cXP3J3A+tw1bFM6HZ9LFn207nPIKFcSlFA==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021098.outbound.protection.outlook.com [40.107.208.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 9C1A0A80069;
	Wed, 30 Sep 2026 23:33:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWcbeIKihjRUmMGcgp1omi3MY0VtCWYiJ+HYxlP8jrZiGqvNdRxzvAdx7ed/aEZ4c/o6kIPxKKZCggtEHuCaUOGiw9aK7AA1VAzfDAst4HhIdu7sP5WmdRPCScnilKSxCcdLCHGbkSFA2UjNUE6XA5gtiZxqjGhgY44+Nd7IudhFLMxEDUWmspvNQzA7qtw0nn+8uCjpnODDNsSzWMjuDGnfRWjZv5cKSOoHyeJtvUSy8TtkOFBGaLWVf9W3In1pC2uneaWEAXKHRzMEikA5j1cStPGxJb9rX3km7W3yKXXuvzmB358hizaz+Xuqyrr1dsGLnewlAmnMCXqGypbeIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NuINhxPCXG4byxPa8GwpVy+mNOEciSlj79+F1r015Q=;
 b=cwopk8CzUKTbIEbpc7Z9dvqR5Te0A3teQCue7L4cqiIptZf8JFj4kfknfKMmgEBRlFL8SWkhwjtEbJkuFcXnUvWGmGY6tpHCG8crvMBQj+KFcZ1NpZQl0fUT/WICSZFppz2MUDuExmkhAbxtj8ef1qJRkpmuVArjD7Fhe8Wb6E+kjGxTv4ledQsCzfW+zBdvELgI5uEvNYcq8dyPrhkwKKL5tNZobiSGvd4Ge0kGrKKjvRO1k7Iylj1p85Eyj62hiBbDLyT30GkkxxurwrZtWHpb4ls1eMFv+qqY/GES+AXeOodmebsDLcXoh11dhvPMV61KKM+VAeMntz3Yj3hYRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NuINhxPCXG4byxPa8GwpVy+mNOEciSlj79+F1r015Q=;
 b=nl21LWW9sLytQXYvMTTBJTJBIi+9xq5SvWHg0dHYyhv5B+8HcOCMB4WgN7qvvCN7yTueWTYWeYpyJsO7McTlwiumNKV6ScW1N9WwwwRrbQSQsrERzM8x/JyjsNpRCJ4gR6Ro+nv9Sz9kkxMeCdNrgBxHqYNxYslx1HBeODPhBsUl2X7HzisaXuiq5tkgQVScKSbGWAgqkj53Q3crtI2Pdvk545/ehTIzJhgodEEXxiCk/DzIy9ORTq1Xo9O1zlg8EMukQE2dmm9oZnpXb1/cChzq/y96SEjG1NWKCL2QaplREGfpcUPR19snG88C41wKGP1PLIQx+azmm5Vg99rZRQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by BL3PR20MB6748.namprd20.prod.outlook.com
 (2603:10b6:208:3bf::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 23:33:17 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 23:33:15 +0000
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
Subject: Re: [PATCH v10 03/14] dpll: add basic SiTime SiT9531x support
Thread-Topic: [PATCH v10 03/14] dpll: add basic SiTime SiT9531x support
Thread-Index: AQHdSgVY4xZe+VfSrUGoWYUh2k3Ll7bgKx+AgAeo64A=
Date: Wed, 30 Sep 2026 23:33:15 +0000
Message-ID: <20260930233306.81858-2-arouhi@sitime.com>
References: <20260926023441.1567546-1-kuba@kernel.org>
In-Reply-To: <20260926023441.1567546-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|BL3PR20MB6748:EE_
x-ms-office365-filtering-correlation-id: ffc6db5e-dd44-409d-8028-08df1f4b332b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|38070700021|10067099003|56012099006|5023799004;
x-microsoft-antispam-message-info:
 SBjUtoSpeuA9TD4s8zw5u3Sp3ZQ8ZaSYFpnAEnTaDK93nrGiASzu/jN2HkpBcjs9vPqldnUBmRKZuGTYx7J5VA8q51jjjOkFZbFW0VDixIvt6UFbwYxBXxGG/NmH4cB/S4Z7UR9B6kKmEb4b0v5p7zZpDMTd3z/EHpa1gWiranVjSB9Sovxz0cwecGW4OfRbS6BU9lLvHytsHzgLzDFlIGvsxDlQ98UJ08IjSL6Pm5kYRuj30bDczc7HCKw2wHXJ9xXYz7KtV+TFz5MTbQSt3X2ItxE4pRT/jqePKnKaSoElDwiRQMMn5Es7zwLW+AhcnLOUm++L84E2KR/KfW3IYjvapCwqI4pOZZYegO4Ql75slvzzk+tQNpW5QH3E/y1yJXUNL9pGVbhsN/iWwWziS6YHZiT/VO6S76Vpq0F3IsOlz7Yw1mVoSa4z+2oZUh7WBHGFHwUMNo8LHaeQ193BbHzZrYc9lbSLz4+FR9WqEmbNkqjVr5Y4hXZYZdHAR69nlHcgyt9Pz6/t2S5Yxga2qzBcXsCCguJdyv8wUNA2XB1FVi8e57939sMxQ5kxzxqy6uWaVfQhQxAzSXQ38FzDVsfRW/4LqsZktc5P3CePUcyj5FYwDWX1X+zlHHO6YwHCQadtC9ApPINJzAmLoLhtj6qrksPU4v2u1kpJelc92aL+SyD+1Mn0GsTUP7FCn1wWrXms0tC9ZQaup9mpaQ1UwiQXYbj+uqo4CD+iD7ijUa4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(10067099003)(56012099006)(5023799004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?9+apHnxlEycqAMCESPgbNq70xk7vjO4VAaOGuF4bsmKJR+qGY28lSUVyzr?=
 =?iso-8859-1?Q?8QTD3YV+3O01RaSme0vgCqZxZCXm3/RMPP6CeAK9HoTv5/r4UXE9gzY/9P?=
 =?iso-8859-1?Q?OFpn6StQjoU1Knl3Lrd0w6EiLnA8Gqtc/6nnkE1rCuNzRrOZBqbIoKJ2S4?=
 =?iso-8859-1?Q?dU5Xa4Y3yng9LCKylCvBmWpS9dFsL7xxe9Le8NCiVXrOxmHIg7zncFWjFd?=
 =?iso-8859-1?Q?u6oQwGDA+5KI2ygw/SfnjJCpjrmXTQHpZWFEJxyDGJNsQxrZQloNJ7XSDn?=
 =?iso-8859-1?Q?5/GODzetARU3o3XbzvV11JlgmZTtxWphO6pCTBQTpC+3A9z22PdMAff3lf?=
 =?iso-8859-1?Q?hlE8KR46C0Whumk+7Y9BpL/JEoz/xk61kco2nPoNKt0AoBcnFzGWI2WI2l?=
 =?iso-8859-1?Q?UQ4HgTG8Ez2FvsEKUXHOgPH3u4uQkzpPAqXNx4ywY2NfbEBwL9I1L/SUoV?=
 =?iso-8859-1?Q?Sg8FLWBS5jrpMleWLcK6339F5UdE9IXAb/XmS7mTAUheNsP5LomkRVOWwd?=
 =?iso-8859-1?Q?LKFX6kfLcQNeiCIemyywCcQQ9tSkJJg16wW/jIo2i9UHbJS4eTFzAkIOrT?=
 =?iso-8859-1?Q?FFo3ToL0a4UEZGYq74Ekl28KugbzbfGGY6DeDVjvswrAOtLRp+oUzEtCf3?=
 =?iso-8859-1?Q?6Odts38RBqt2RrvVYqbj/fk48t3HcOwGMm+v//A6rcydfvOZ3+hnQ004CB?=
 =?iso-8859-1?Q?pvfzQ78wfaNez1a3Yi+mg0GeQkkHajGDMUyW9ZmkDcgbrrzVIUQmxCDqs+?=
 =?iso-8859-1?Q?5Vn83xs3AvoFID9GdSwI4h9EOaK6zCefZ1h525vUd2Ok1eyCPgLkai1CLy?=
 =?iso-8859-1?Q?aK7yIvKdlhDiSLR6u2WENTu0X/oP/e29aYSzQ4Nc60icXovmGUC3DhPFxz?=
 =?iso-8859-1?Q?Knu2pcWgSB0aS4ocf8m2VHB0trAmGXcOy6rml9jetA3CVaO3lqqIiSLcqI?=
 =?iso-8859-1?Q?OBOhWRR+eAIsPvqyXAW5WCnI6TJvyPMvFEK7M+RnzNq2wFtwJEdiQMvaE9?=
 =?iso-8859-1?Q?xuisrDOBtzZDiYxzFWTwizZB4JEjxB9R2qudsZN5+E09K3XRv42zV+rWP9?=
 =?iso-8859-1?Q?Cjz7ylkIuxGLhlVvGgpenVuzXo8xwcDv0K2otTgUOfFwMS4b4lMdQGS56t?=
 =?iso-8859-1?Q?hFDcK3emQdeH5Rj+xBjw5CbvqH4Ye4nkd8jRvWabUMOtI3NKBMHTzsI6tq?=
 =?iso-8859-1?Q?i1YqBAGKwkBvQPqAIRWybvjpsSbyxmWOC96rD4YrGAWj/cwpM1aLuSTkan?=
 =?iso-8859-1?Q?6w87Hxv6t8EI8HjbLyCwK6/sV2u8i3daXLXjxQTP95BW2gIqrT0DbDZqBO?=
 =?iso-8859-1?Q?SG4Vhu5ybRmHL7TElzCUKCtl+1tr2EQE+4EGSlZPqO6ZxQa/iXuu2TEtHi?=
 =?iso-8859-1?Q?ppr9f93B3x9qHrd2QoBe2jL2zdB38VokVOpdLrMIznHG70ndQAPLMWxF3s?=
 =?iso-8859-1?Q?e/npYToPx1LSJnx4cIuLbWvmPcilRphdwLpaPJcX/vRJKMUMxYvicbt8aH?=
 =?iso-8859-1?Q?Ucr+PKeNA3EF+w25LffHKGZeSurN5DzCf/GI+9vPY5ulGxngNtDlgo9+Yk?=
 =?iso-8859-1?Q?4+ANxY2IYq2C7vEyCK7Kayj99V7FBgAT4sC/YO5HvCAYp0+wX4iVHxwyix?=
 =?iso-8859-1?Q?KqGZ7Zjg46BNmS/wXkBbXCKox+XYbxcslnBi6hc//erR0uSdrlIiJzAcfJ?=
 =?iso-8859-1?Q?Gdkb5XwdiWxUvGomv/XNM3+5tAyI2c6I1ZhRrU+KU5A944xsvsN57UPnPG?=
 =?iso-8859-1?Q?Tu5RnuMqzmYdVpuAQcprBhCfe35a87XPRN6j9TAxIb0D3c?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	fEw2CAxLHSv/Rw9UHT8wpgOsKGjZeifQ8gB0Nc9L0kgUEqT4SN7fUDYRymnOAVfWIRNaJ/djbmroP6WIYllmfOWt0V0ru/yMvAP5EIPs2oUt3DOlHyUMqdoNLzqlIZn5YEG6T/502VRG2fRMH6JBwhFBdieccoWUsItUXCi0LdEj707VDtNug7xER+YtEqvCzDlW2Az20D5yN0PLmmKYgJ3rBW0Y0CsKmzNFxF1L/5F8GsDczgDGNmTm3SYKlEPCIQpNDf+kku3k7jOSgK2ufLohId8hbaZwHNre1R4ui6k/HuG6qe0PmWLSCcgGCCx48L+X4dW4KsMVib7fUyeL5Q==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc6db5e-dd44-409d-8028-08df1f4b332b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 23:33:15.0878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w9wpUL6ceB41Z8UGJ4r8WamfdyzGfpyXxjZCPWMRi87sCfHNa+IQV9MEdAtKN3Jdiv4aANx+glBqIZdnaMX/PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR20MB6748
X-MDID: 1790811200-C5s7KFIkkAFT
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1790811200;C5s7KFIkkAFT;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

On Fri, 25 Sep 2026, Jakub Kicinski wrote:=0A=
> [Severity: Low]=0A=
> At this commit, can SIT9531X_DPLL build anything unless some other driver=
=0A=
> selects DPLL?=0A=
>=0A=
> DPLL is a hidden bool that has no prompt. If SIT9531X_DPLL is the only DP=
LL=0A=
> user in a config, the line=0A=
>=0A=
>     obj-$(CONFIG_SIT9531X_DPLL)	+=3D sit9531x/=0A=
>=0A=
> is never evaluated, and no sit9531x object or module gets built.=0A=
=0A=
Fixed. "select DPLL" now sits in this patch's Kconfig rather than in=0A=
"dpll: sit9531x: register DPLL devices and pins", so this commit builds=0A=
what it adds and the series is bisectable for build coverage as well as=0A=
for correctness. Deferring the select was deliberate in v10 and it was=0A=
the wrong call.=0A=
=0A=
> [Severity: Medium]=0A=
> Can the cached page selector get out of sync with the chip, and then stay=
=0A=
> that way?=0A=
>=0A=
> Suppose i2c_smbus_write_byte_data() fails for the selector write. The err=
or=0A=
> comes back, but the cached value is not dropped. The raw write path in=0A=
> _regmap_raw_write_impl() does drop it with map->cache_ops->drop(). The ch=
ip=0A=
> then stays on page A while the cache says page B.=0A=
>=0A=
> Would a selector reset on the chip side also go uncorrected, for example=
=0A=
> power loss across suspend or an internal reload?=0A=
=0A=
Both cases are real and both are handled in v11.=0A=
=0A=
sit9531x_page_cache_drop() wraps regcache_drop_region() on the selector=0A=
and is called from four places: on failure in sit9531x_read_u8(), on=0A=
failure in sit9531x_write_u8(), on failure in sit9531x_update_pll_u8(),=0A=
and at the top of sit9531x_resume(). The first three cover the failed=0A=
transfer, the last covers a part that lost the selector across suspend.=0A=
The next access after any of them re-selects the page instead of=0A=
trusting the cache.=0A=
=0A=
sit9531x_update_pll_u8() is worth calling out because it was not=0A=
covered by the first version of this fix. It computes the virtual=0A=
address itself and calls regmap_update_bits() directly, and a=0A=
read-modify-write is a read and a write, so either half can leave the=0A=
selector wrong. It now fails the way the single accessors do.=0A=
=0A=
One thing your description gets at that is worth stating for the next=0A=
reader of this code: the missing drop is not ours to add here. It is in=0A=
regmap core, in _regmap_write(), which updates the cache before the bus=0A=
write and does not undo that on error, while _regmap_raw_write_impl()=0A=
does call map->cache_ops->drop(). So the asymmetry is between the two=0A=
write paths in regmap, and on adapters limited to SMBus byte data we=0A=
get the one without the drop. v11 works around it rather than fixing=0A=
it, which we think is the right scope for a new driver, but the=0A=
workaround should not read as belt-and-braces to whoever touches it=0A=
next.=0A=
=0A=
> The comment says the selector is something "only this driver moves". Does=
=0A=
> that still hold once a transfer fails or the chip resets?=0A=
=0A=
It does not, and the comment no longer says it.=0A=
=0A=
> [Severity: Low]=0A=
> This isn't a bug, but is this message meant to print the regmap virtual=
=0A=
> address rather than the SIT9531X_REG(page, offset) value the caller passe=
d=0A=
> in?=0A=
>=0A=
> For example, a failed VARIANT_ID read, SIT9531X_REG(0x00, 0x02) =3D 0x000=
2,=0A=
> is logged as "reg 0x0102", which looks like page 1, offset 0x02.=0A=
=0A=
Fixed, and taken a little further than keeping the original value. The=0A=
translated address goes into a separate variable, so reg stays intact,=0A=
and the messages now print the two fields separately:=0A=
=0A=
    "Failed to read page 0x%02x reg 0x%02x: %d\n"=0A=
    "Failed to write page 0x%02x reg 0x%02x: %d\n"=0A=
=0A=
A failed VARIANT_ID read reports page 0x00 reg 0x02, with nothing left=0A=
for the reader to decode.=0A=
=0A=
This patch is patch 4 of v11.=0A=
=0A=
Ali=0A=
