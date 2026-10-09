Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9C94F93B8;
	Fri,  9 Oct 2026 18:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570220; cv=fail; b=YBIFGdRpZoCyumIdIccNKh1gwN8P4aYpNDyA+c5/15ZkyWdF1XgzM5t22SdlrY4eiT/MjnoMvGD5R0+HsWYdSEFdzeCHqsTZTZF3HUKEzQDgSU/29eoO/NpEdnH+qu9iriclnFSQDTNwOb2tuZp6ylDI80lHag55QKsJq2KsIVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570220; c=relaxed/simple;
	bh=nuSq7Kn/lvbasDoslt6wbhXnBYF2+t/FP+5ioxmmGiE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jwWYPthE79sZrUyShgeDRkD5Uc/W1FdBG3w936ZY78nZnUz1/xHzGvRAMq3wwKSqhVPPuRvgiPaR+pziIwvBVj6YnpvJ7O2oFAKcU5NOK9lDQO265WrtI7HF7ZT0n15434fWLx1VhxsfTvEm/frm9012d/hx8fjZoQu54GOgB3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=Yz2QYnO+; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=qOovll4y; arc=fail smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="Yz2QYnO+";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="qOovll4y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=nuSq7Kn/lvbasDoslt6wbhXnBYF2+t/FP+5ioxmmGiE=;
 b=Yz2QYnO+W3Qnjfk0G3OF97KgNOsEkg/+Yhd/AEXPE8ly1eqd7oazawENNsp6HhUjwdpbL9iJESx9oeGaIgV/Pzkq/7cSeQ62q+2SsnVO4DzR6Kn87Xdt153DLiVrmCpwqo78p/ref4eOz464eWj9AEz0y7Q6JYUAKZH0+UtENy0pMsSK6H+8OnB9L5433t89EOVAYvpSqR0Eo9K/QMVseD/txQoM/z2S4Rnf5hcfj+s9FNmgSyleS3bhSsl8WMUnX+kYg6S3PK/v6uG58PPTnrqGPH7XlbpGZsOCfr8bEt9/Eb9IDdZx4HA3myrKX+Nzo45f9yXARpqa0Ar5kbkvYg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020076.outbound.protection.outlook.com [52.101.56.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 9ECB7C40064;
	Fri,  9 Oct 2026 18:23:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1/7a7Hm5R/e0i1icwX1DOZ32JANzuAwf/25VZOBVvsZNEnptvMvBp98OeMhIHpGmssDN39GvmzbIvZfJo0qcO1fDshedJhDb46iZo1LafmoujVoqxDybBAfeghY4feG6o6YwgyV8jSdUJMndTsDT81KpA8QedXbhz1BkGQuxgW/GstlkHHPuUH2bcsI0j73Ep6m82XuwSHBQ5pLyKczFkV97aUKlJFbayX0+JLPqnSHNrgQB81+mnBW2LWXIW1RPrkO306vuwi9BW81ZIpQtIIXmTnJpmO/EsX2ZsteZIxGWmqwvkOwQEdk2sEc+GeOBMx+ANMhMYF41N3Bys6HJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuSq7Kn/lvbasDoslt6wbhXnBYF2+t/FP+5ioxmmGiE=;
 b=hpJEoHCszxNVb9g2D8HhvQvKEBlFNhZsVmgCpH6YmtkzOGviO0aKTahYA4eS7yKGzx4wbvXiu18alKbiZ1NleKKkt5jTuymKNPN3lOXIYDY7J0mpweRIs/UYFXyuGOuVv7g7QVK9jGnOZy+f00f9Pcl3B1BijKuTAO5i3lcbPvoq9n77xFLlqCLKDopaxhl3zKD/vUMSUbXYn849pM+cWF/bCBQq5LOmA2xrZGPhPJALkyOcKiG30MVOyMpTON5w+Vo3toSVZCeQ4fOhrkdKjDcxGQ3FtXcGcU8VjKH8nMz+W059FdRUmN0/46My2VJPLv3J87R71YrYM8WmFzbwVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuSq7Kn/lvbasDoslt6wbhXnBYF2+t/FP+5ioxmmGiE=;
 b=qOovll4yfegJnLuRCMUQDcAXnDDQu5zgWkNkxVf4EOWOdAGfsDaIiJ+sM9VMMB5sZyWkju1S2CLscT9Rr1I3SoW80v2RQDRFe9A1YpNmB9nPqmdhmyYSQ+dipfeSh3WaPXHyEeeQYz75fIUrBRK2Pu60k11DXtqwF1KftdMLisYtmy62f5B7ldmzvN12Dk6p6os82Bs3zDfnFLtIqeD0iIZbo4RBI9/j/CqkTAdSiszIOLBQK/h4GKz8eFqTIvBuJN6/ZK7MWrmSHV+N/iB+HxUYwLXi//sgN8p/IE776V9oye2/rTCl+fILGnG2Mzjfn285Tiowt0if+Bmt28HZMA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CH9PR20MB007164.namprd20.prod.outlook.com
 (2603:10b6:610:314::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 18:23:28 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:23:28 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Oleg Zadorozhnyi
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v11 10/13] dpll: sit9531x: implement output pin
 state on a DPLL
Thread-Topic: [PATCH net-next v11 10/13] dpll: sit9531x: implement output pin
 state on a DPLL
Thread-Index: AQHdUTSkf1BcHEXMiUGwaPBnkwtavLbuKhgAgAdqBAA=
Date: Fri, 9 Oct 2026 18:23:28 +0000
Message-ID: <20261009182323.76166-8-arouhi@sitime.com>
References: <179116260402.434549.6445320171946602725@kernel.org>
In-Reply-To: <179116260402.434549.6445320171946602725@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|CH9PR20MB007164:EE_
x-ms-office365-filtering-correlation-id: 97431c06-3513-486a-5206-08df26326a90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|38070700021|56012099006|5023799004|22082099003|10067099003|3023799007;
x-microsoft-antispam-message-info:
 C+oGYQ0IQnqVMq2pqf0n9AsvQLeEosqXlcPGOKtI2vf4q1HwF0rdHqMRN3DWlTIGmY+sbz4xKhNi5Amdbv4uZdlq0wsBaBDIIjEd/9+uTwjN78BSIPtvquWm66TwPs7U52Kw+pJwWhvvEW9vCSB97de5Hr2J++O6wuo/dHNGlQ8Fxk3ib8gcfSyCy7ATnYAzocYonyE4V5DE2t+9AffDRqD0FczkzYoCgUw6pEP63FMnN0BBxGuiRuZNH/CDdoULb+MDjWRlMzj76r4Rb+hnnJd6Gy0tTVGBrF1iI2OPf33lWzKq/GZaIX3nBlHk6YfRiJDunKmtuZWl5RC6oUafbel2aybjfX+vl6cSwp6cuyiV+GVdzxJyYY002yGeYWN3enw8kSe16lAO+nMtyiVJVPqjo7h60WzzNSjly1JXRqEWEMY7oLAk8P+uHX74HtIhmCoQLN1rwClW3GrPAFuHC/ekubXBy4hpHmcIDJXJxiw+/FwR+v358yBeUsg25NtXvKKMKjlC8O44cCsyvktrBgZyw/z4Qvjr4tx+rTkXiwqMbChd3sISB9g+T5nqT7TgFHkbM8k70GrHwxApb+k7Scmfw190SZvxkQ+jwqcmF/EwN0uqdyXPejHdLaleyVPplUn0HUuy44DTZ8+Ip1j8sTDW8C99eJ111TrkoFh2hrffTAJE6lrwNFIxdsnfC1mt/Qgqftcqzsp10EAFADUxSWvgVurKcHYueWqa79GCxDg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(38070700021)(56012099006)(5023799004)(22082099003)(10067099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Qa+8LwGLDtDwXueqxfu5ZSxcyJO76DeZTkiXXAgqCbnoRfXk7llfFHKwrG?=
 =?iso-8859-1?Q?OWuZlnV9ckpyCDBlEt+tKIE6gglecTrxwTLVN8VgrO2UkbD9j/s72exZz6?=
 =?iso-8859-1?Q?dmHtjP5Q4O8NkdCVn9ouzEzS/943htZIsRS11UqAAR33n/K0uNWgBy4s3I?=
 =?iso-8859-1?Q?AjKfT5Unl8KfXLoUOfqX3ypH5wvQSmspl3jIZv26Ma5C0wsHVRzW/KL1m+?=
 =?iso-8859-1?Q?NKFPI4zIUvgxLSu2cHb6mO+7zK10qpv6UEe/X1ltR5ZEmWnlqSzRKZUX2q?=
 =?iso-8859-1?Q?tM12kKtpPTn8cJRkfwlf3ASHF8wLPAEJtE0s4zDCS4gYI1N3rDGsQz7vCn?=
 =?iso-8859-1?Q?Odm7aMnKwYnGTXkb26hzTe7mrQ8+6z9ZEBmOOD5cNlXpXwDh5RogOWsdvM?=
 =?iso-8859-1?Q?+dQ6cADZXoIwhLRc6BWzKWZ1in/OgMUQ/TbVsrTYcqrpCmyGfYi6WVesbS?=
 =?iso-8859-1?Q?ksctfh7v83iOekU4PuvG1SaxExOCNBu54Wxq7kN3sjDuPyfgUObGHWOzJ4?=
 =?iso-8859-1?Q?pD84ZZnEaF163V+gaSHo5Sn+F7n0yNvQgwMr+Wezi0j0oNjdW2uvEIHxvj?=
 =?iso-8859-1?Q?oXIPEN9EPEK6VccPh2hwl7kjBckAAebKbZSCneWZLzoFXFL6KipMN3Z04Q?=
 =?iso-8859-1?Q?mPQhjcjFq/ZZiN7Kg8IkG9q6VITkk/pqxEQ/WCFJqmgi8lUvDL1K05r31N?=
 =?iso-8859-1?Q?CZeVv/I2PlJPAM2oOqUSpuyRCRB4FEWik38qNwBEDL8sTRKhhIZyz5hO8t?=
 =?iso-8859-1?Q?hooDVzULgYDd3yQlHL1R4+u19uxf+tz6tvbnChAP95n+wsMxxRcy2kS19g?=
 =?iso-8859-1?Q?SccnLn6tgbw4W7EPwXaeIT9+Vp0w0bo6rRysvs9r/OK+KqUu31IaayLLjV?=
 =?iso-8859-1?Q?ypx13LGh71/RrHSi3MxexjGHtewW+ttigINpL/1iLbQ70D4XiesARsqEc0?=
 =?iso-8859-1?Q?UlVjSXpVUoZm7GnsqzWqSlGB5sN5iuIbNgqvNhXX/5Z3lsQ9Yie9rIvMg8?=
 =?iso-8859-1?Q?Ay1pFag28V9NV2KCIny/I2P1uEXCIeaYx6MSHotcMUUUQiL1LfMfbj/D//?=
 =?iso-8859-1?Q?WOy0h+SY87LrD6E7E1nv1mCCkbF8Dr+MwEaTDn3c5ti+44VvRmKW0cLBko?=
 =?iso-8859-1?Q?M4MEX6RaUqH+fiV2KXCpKME9wMl6prualAhQsvrC+n164wrhEk3i0s0VqA?=
 =?iso-8859-1?Q?pOAiFoNmUO/wburhaG9jXrXr9h9NUVRd6/4zdC1afbmKq02IlyYXw/CzrK?=
 =?iso-8859-1?Q?ZL7kCbtEPOk7TgpOk5UDC05G5VsWrP6MINA6JHCLxZbfygnDd5JH1ApTja?=
 =?iso-8859-1?Q?Y65M7jRMKaV9NSRsXyveQRtSNqWqI6snZ8a/Aw5K8+tq3eaSMa0v0V0HNg?=
 =?iso-8859-1?Q?kGtJHI6PdYbNRTkJt1C28203gBbVHQVCP+r/QhnAlKiCpP0cPUQjMJzt1x?=
 =?iso-8859-1?Q?cZm3pwcpTPGbnIzLhuWtZ7SIPBDa19DaK/2fzMROcQRACL18nqA1rD/XOJ?=
 =?iso-8859-1?Q?diuT3dJaK3TpmEvKyXCEfCuYUDxOu4iA+JydHdPXyvwZPOfqyla6RePmZ2?=
 =?iso-8859-1?Q?nGHLHwt/kfMJsW5zVuvse9jJkozJgYK8AN2P6l2i2eJZbAVE97l3X2dgy1?=
 =?iso-8859-1?Q?bB+EpQhhs11VlwEMJWSCQ9ckWGAeaCRVkC06C2a0r/apWNeXXWf6kKikCY?=
 =?iso-8859-1?Q?Q9YJHpXiMR728izmR4SEViHtSaLl/iDvKSLho6ITkDGoXjbTzmgxwL/MDl?=
 =?iso-8859-1?Q?QVMxqmuZ/9CXupektT11vrYmKLISSxajhCYSc+OQe2vsSV?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	A2pveuYOvpMtPeBCb3KzIB+U7W7olQnRbkLONjvTG82B4P6oF2ZoVumUCG4v9AMZPN25tzn8v7+lxLnX1Y5WRQ7kKJ+pwUHnQk0a2PhNa+gj4p9qWIJj/hfdAn0e1ARiG0D3MaP2Giylm1Z++rNPIQf0y7YoezLN3Y/7yjtXeYl5heljeNSyCyFvhc4iMk0OnULwk+Eyct/Fnc4tHDfvAut0j78drVqXSBrxUorEx4Xb1fi6M6ChH/hzsxo/5kMKwilZvZ68e7grHi9iHl8H5eQgrDU1CsTp6hHqKuWZJWJQ78NkrOhxd2lE8CPcq9nERNW+ncxFbVkDWFCzPhEh4g==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97431c06-3513-486a-5206-08df26326a90
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 18:23:28.7861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RzX3p0PG/bkUek6yh5tU2MlIM8MJ012M6Iga2ztfGCn4tW5p6kEmSliXyy766+2BVoa9lJZmqidO8Fg3r+3R0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR20MB007164
X-MDID: 1791570213-6jIBULOw8Pdz
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1791570213;6jIBULOw8Pdz;<arouhi@sitime.com>;5de2396b9b83917d02f0372d9ae54394
X-PPE-TRUSTED: V=1;DIR=OUT;

On Mon, 5 Oct 2026, netdev-bot+sashiko@kernel.org wrote:=0A=
=0A=
Replies inline, in the order of the summary list. All three are right=0A=
and all three are fixed in v12.=0A=
=0A=
> [Severity: High]=0A=
> Can dpin->dpll_pin be NULL here if the device is being torn down?=0A=
>=0A=
> [...]=0A=
>=0A=
> Would it be safer to use the pin argument the core passes to this=0A=
> callback, which stays valid until dpll_pin_unregister() returns? Another=
=0A=
> option is to read dpin->dpll_pin once and skip the notification when it i=
s=0A=
> NULL.=0A=
=0A=
Right. sit9531x_dpll_pin_unregister() clears the handle before it can=0A=
take the core's lock, and the setter read it after more than a hundred=0A=
milliseconds of transfers with nothing between the two.=0A=
=0A=
The setter now reads the handle once and sends no notification when it is=
=0A=
NULL; the clear and the read are a WRITE_ONCE/READ_ONCE pair. The poll's=0A=
own notifications need no guard, since the poll is cancelled before any=0A=
pin is unregistered.=0A=
=0A=
> [Severity: Medium]=0A=
> Should there be an early return when the request matches the current stat=
e?=0A=
>=0A=
> [...]=0A=
>=0A=
> Also, the commit message calls the mute a per-output control that "leaves=
=0A=
> the divider alone". It doesn't mention that every request runs the=0A=
> device-wide programming sequence above.=0A=
=0A=
Fixed: the Hi-Z pairs are read first and a request that matches them=0A=
returns without entering the programming state. Each state change that=0A=
does change something still runs the device-wide programming sequence,=0A=
and the commit message now says so.=0A=
=0A=
> [Severity: Medium]=0A=
> Can a state change go unannounced when the read-back fails?=0A=
>=0A=
> [...]=0A=
>=0A=
> Should state_stale count as a possible change here? Alternatively, the=0A=
> later refresh could announce the new state if it differs from the cached=
=0A=
> one.=0A=
=0A=
Fixed: the notification is sent when the cached state moved or when the=0A=
read-back failed and left it marked stale, so a subscriber is not left=0A=
with the old state; the getter's read-through supplies the value.=0A=
=0A=
pw-bot: cr=0A=
