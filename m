Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D9F502772;
	Fri,  9 Oct 2026 18:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570703; cv=fail; b=VRIRbKX3PE7EHr7oBjIuR+3r5HBYC976ENbwEzav2gfpGCpBgHvaoypDFW0u5xte+zfw6Zuy3e9Ftcu87Xz+RtUTYRtMLgIqFg/vqhZA/Nrl73YU4iFrgu20af4g6p5ZbzrVG1BEIFlraKYqmnKB5Ar4ayKH8ZAgAm/x6EqBFLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570703; c=relaxed/simple;
	bh=L1M/gvNXkOF5lpl91w4KZ9EWsZgwvJ4Y/a9Bsb82+N8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mcrmh6185FImFxKFkDcyhTRmVDkRQ0ULFrtbML5RR/vhoftr4YOyLCEu1JSB643U8c0tJpUbRaJcEMoG2tAQgx0AD2RPkqYYBuOqDh1nTUrJjxEohXjce4XIMbmt99nDyWqGLyVrdmTTboPoI2sQ/V6Kk3cnnph8aOxeGPl+p7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=Ep2WlOiD; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=JUo/cC58; arc=fail smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="Ep2WlOiD";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="JUo/cC58"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CF8AF60D0D7;
	Fri,  9 Oct 2026 18:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=L1M/gvNXkOF5lpl91w4KZ9EWsZgwvJ4Y/a9Bsb82+N8=;
 b=Ep2WlOiDd+W/YQBWt2EPHAR0txsqlFqHM9W6oDOzdyy2vloAEb/tPYalSdHsy3qNipeqOF5hjhZsRRBFX3pTTL+cabuNnIAtZXYU/W2nOdFPHUg91o08CJWMoHcuJiyOawqJ9ojcSx20UHZlCRMYTOxU2raSo3jNT+Rn095Nz8lD0ufKd8IyWh6Qo6kUEnsc9+Fire290pwMwHfkhUsUCSlSIevtS1ghfyFJbHsKyTm+7COqntwc6GV+3UUnoNa9Ncje76FnB/HlYc9HheVA++WYYA261zxmprs+wqWOilX6ycJt2vkW7g0bFEEAXqkIKbR0hswdBnWhxOCzgSELMQ==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021124.outbound.protection.outlook.com [40.107.208.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 2B57BB0007A;
	Fri,  9 Oct 2026 18:23:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9u8U0MahoY4W5+QU69yxQEZRAGC4vqR1U3FnKbTbgDbrXMmUAlEhJhLduAcHwYExcUDlJ4qYoOG/+RlveoFy4sQX6Zx16i4kNqMe7DNnDAjsPMd1sGm5lcRLGNZc4tQfC31Qk2NOzekaqtLrXt9Qw6HfEfEsFHyPs1mI5U5giQ0EnttHiB/ciqDVAU+aUVC61jAkOnEVoD+ERcMj3/gLRT0/27A9YQD81lZXT/pGfkGQVzA0nb6J5welAOoYj5csGqjFMsTS2LMmZblPPsmpwDlVzvmYi/CWwho8y3dtpv2YXaUElRBfW9jRq/bszlGLx1G2lI2ZYaerji+peNTFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1M/gvNXkOF5lpl91w4KZ9EWsZgwvJ4Y/a9Bsb82+N8=;
 b=Juwrb5NbVAGy0emYJTEDjnkyMUcZYRrBi4e/+DpWASN2HJOpYFG0I7VsdCWcQ5NDJD/ehMO//SBO/zxKEZJAbcP6ZJo3Pd+WNAt/VE7VOjCfe5PoDCnu22Bmhpm/TsYe5rQBWiRYFwzYwSHmWM1y7QyF4C2GQ0lKPM/sdeKATnKBjqbjmGYtfUqEG0NGmMauUsOJ5Fylkn/Rh/8s+9GFlNSPb4nHMAsdXsgcYl+10W8HiTK6CpjSi2Jo0yKVNS6vZVBNM21ZJhbammF67pJbX/XUkSa98nMlMNU3OVkCNeIZ7hY+iIReRN6wuoG2uoil/FsmRUFkD66bX/KF0h9UOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1M/gvNXkOF5lpl91w4KZ9EWsZgwvJ4Y/a9Bsb82+N8=;
 b=JUo/cC58O7UemPk19KM35gqNbl3hooLW6ulSJEIvT9rdMtzSADLwIXP8ejmu4f76gh8N2wVMiKsCBCHneFn/vK0AzG4ENOSrJYbXo5u1V62Hr3ttGDpwX75GNBIRyI4Md2AcOQFFFF2i0tRlvIG2ZQcOyfoWn13qcUOtUKEdBSA5Z2wATZgduvXV2fITaNb+cpACnAGG5ZjnXfGPq8fhtRVTzS1qeNKigmhFywkKOhng4HjFoidGiB+GdCs9g5PEuY5DLagU/5IrywUvVVSJRpfzPBlZyHeUwevAHrzX4JZeGJOOzGS7bN8yokFqCabOnUCQc8lmse85/uugnZe9hQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by BN7PPFEE39645EB.namprd20.prod.outlook.com
 (2603:10b6:40f:fc02::76d) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 18:23:32 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:23:32 +0000
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
Subject: Re: [PATCH net-next v11 13/13] dpll: sit9531x: model the inter-PLL
 sync net as a pair of pins
Thread-Topic: [PATCH net-next v11 13/13] dpll: sit9531x: model the inter-PLL
 sync net as a pair of pins
Thread-Index: AQHdUTSl7g3aEHGUEEeWm4NUuXPOY7buKh6AgAdqAYA=
Date: Fri, 9 Oct 2026 18:23:30 +0000
Message-ID: <20261009182323.76166-11-arouhi@sitime.com>
References: <179116260977.434549.11247923823182031360@kernel.org>
In-Reply-To: <179116260977.434549.11247923823182031360@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|BN7PPFEE39645EB:EE_
x-ms-office365-filtering-correlation-id: e5c3c396-01b3-43ad-bf2a-08df26326cd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|5023799004|6133799003|3023799007|22082099003|10067099003|18002099003|38070700021|56012099006;
x-microsoft-antispam-message-info:
 GgGiPeTYsmYJgJiEqLnTjrd6PX91RYnjHQKm+l+KQkYJb3ReqSmro00Fk+I7CLuhIZJoUYbEcndIwR3wSGQvNkyvtGUJZ4euCD+QEreJhbCuW/lo7XSebziVscyv8FrRD3aV2CSdMsykFPRjfWMaTM3B0fjF+TyR7IPOBAHhfkKbEF9+9W+KR9OonGZCNA0CG+mmA648swD4+rqFk5L5vvJwux/vae5Y4MGkfG2DDARvO7qw84phMlNmAhZBPz9ofLIz9e6B5kJ0F/767bFioVj20AIOqeoOMx4VKrfC5FQAvBwy/05JHR1HkNSFHLoRUDc1gXQCVM2bqEI1H+BNgqqbaGGrPOirJZzfK9Cw9ii9uCIorpIFHrSDoYPMUpqS0MUIXo+IBcWGW9nmfvewCgyjORytz9sUc1ItaucU+SGB4vqdPbzZa+GOO7bRxp3NnWd9rkWJUm47ArHm8zxSfssnQucpXOWdxOMPaRL0ig+jxqFBW2tHis/Zp72G/sIIymaltoc94s9I7B1MkZZSTRwpCp98biZ6cz56SuOtbfHcWvweov/wNwcmLpQ1GnIGIZOF9l+66ViIrpCrIWcLuYNHyQKQ8eHFoRRfY3smveYOWBDQTFYlse/3bhnyTBRHwO/6KL6ZNh+wmYKhGxlr0pKU2gY7T5WKIatAxczoTh5PiDKfy6DgbknyOshRwLJIu2N7x5DZPxSO69bSFaN0tIyk8KpdgjQxRhyOU5phIME=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(5023799004)(6133799003)(3023799007)(22082099003)(10067099003)(18002099003)(38070700021)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?MgmewoRtJXUAm0uzftBRe3DQI3MSI97tmmst3Miqly9b5ynsdr42uwKqFZ?=
 =?iso-8859-1?Q?CVm6K0qt7vVI61FvJPjLHmhm1r59ObtGmV7riHH12HpKdoDEreMrzrURJz?=
 =?iso-8859-1?Q?c9CltQjL3qPoksCTvjbMgru7Q6bbCYS4SIbptvMyRXkjQJzac5fvC3eIxd?=
 =?iso-8859-1?Q?7jFhuADADpVAdDMdyk5/pNQEQJmHSu+AO1xQJ/KgG/W5NB/BYsX9j0fD29?=
 =?iso-8859-1?Q?z+FoAVPYCqbRtGcvESIHDkQsfR4zUlONYy4qdR6VnSeVwzI5LVjAttflrz?=
 =?iso-8859-1?Q?rRFZt0L2/e6B2xn9ddVkOHgYbLJ9vgbn5KS/WLdBZDxhjOiamMm6x1FcOq?=
 =?iso-8859-1?Q?8o9TUkmKBIYxVuvqPi8IFrmZNCUkTCOov6+ygrXpdd+u+9QvT+yh+LdPq5?=
 =?iso-8859-1?Q?e7nVCShEL30Fr+/BVN80UNqsyaUqy95e49X1BTqGL/HasXuWCNUy5bN+4w?=
 =?iso-8859-1?Q?n3SC4uukvyoOwcUYccFeZWMyEG2hF17iXid40qkPrkr9MiHkQZFJJ5OjnQ?=
 =?iso-8859-1?Q?MaLD16TazFm3Iz+ojuDuAb7t9aA1l9pKsTrRmFUWL5Qw2aDIYsE6X26zwK?=
 =?iso-8859-1?Q?7CdTZXQVVzpqgS+WSXm5AXOGlD3h7CtLlMvua2HLBcr2RmihOfGZB3cAEx?=
 =?iso-8859-1?Q?lmjsqnf5KrXrT8HbqJ4Wqu1l7k7TjflnhnEhe65LYoQywDoGM8iloHjCsk?=
 =?iso-8859-1?Q?oXgQXp+MkCJmJaGd28mnYUd12MLpFMZyO+JQM7hMVAeFQ13jLVaUzsL2HD?=
 =?iso-8859-1?Q?pGcL8RJ2ziDuTLv0jWuhQL8H1BNpYTbmDjWmvGlyUbautDUi3QriO3CMPK?=
 =?iso-8859-1?Q?fO+Cv7LJ2nqe4m5qjVXS3RDnWrGMk4R1ncfPk3beNpZiI2NsNZUhI4TGMK?=
 =?iso-8859-1?Q?q0U5OibgXrpyJbwsnV56TH0teXD4WibZSTkRVqfx1WOPQZ5sUL76K/ZCoO?=
 =?iso-8859-1?Q?dIzRQUEYB5KOAIwbujUGBz2SaQsBnIcMR7mUvBXaLSmWcSvHEpa/xuyv4k?=
 =?iso-8859-1?Q?F46lW1VcSvxZCbtJ/0MFJN8KOftkDDg79fTUy/k4YgR7TA9NN/AS17uqpJ?=
 =?iso-8859-1?Q?xDPR24JTauOZRk9txW1PNzQ+Ak1IjSLBmiMEU3oGLKVhTTVKbHknf0bzAD?=
 =?iso-8859-1?Q?1wBjQJYY3BEML5mTbhlQpQBI8tD8MDIeVegGYLgJgeejIlD/rcr/Ck1qK9?=
 =?iso-8859-1?Q?pXWIe62v47Ql8PCiLoBNKE1jWy7ct1tYHH6MxG72CnIcQ7blwYNAxh20lD?=
 =?iso-8859-1?Q?aMyI5qgrGxh87tnPGvgMqydAu5r9xZ40po37s6DaNINUK5o/a3D0EFNHX1?=
 =?iso-8859-1?Q?Pv2V7cBxPHf58a5AoVoM1NMcaF+i52Q/y3GkkAHUGdDydPleskfldXQZxK?=
 =?iso-8859-1?Q?R4bDmDw8ZocG0SrJVysoKnthfWTXpJh7x/lI6biV67sPMIJFeE8Uh/Fmfw?=
 =?iso-8859-1?Q?ktbMexSZFV8Zf/zSaNc325dMlZUz247z8o+X8Q9W5n6MHPE+BHIsysdmMD?=
 =?iso-8859-1?Q?6nM1uccYdoBZuKsqM8Yri2z5nrlGAOQuCOYIGCdKhTVq0Gpp8o650wP4nz?=
 =?iso-8859-1?Q?PdRXEIxhAdXZXn9JjPsDk1/XqxxwRDK03akxFpIYTnm8YkcvMq76znxqsw?=
 =?iso-8859-1?Q?oKTm5gsekoNOSJrpBmvChtk/yHLBE0WA36svr6DABM2/y9vPEq9Gc/yPKH?=
 =?iso-8859-1?Q?EMVT+jfZKdD5iOAccXPf4uQeG8sc2IZjNjd3hGU+nz2uk9WrQaK41Re/9q?=
 =?iso-8859-1?Q?UjWPGFeYgbfJI1RDRUH1w1G4N5dpw/ROZxtcjh66gVyZPi?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	pG4QhTy3U42blQdAgzMkjNYjw41SMOyGYJ1PPTLu5ol5NZPB9qw7fV3nDkcZELULn793UUG+p1ZCgh7zIxqxaz47gcq2MHVHDGzDZVRZlCMj0E0I+eQK6GtXATapWUvCR0MY9bvfojWvM/nVbweV3DL6NidOS/3hQ1eidLtLMBlbj2emLn+leUK/p6QYZGJs6rh0N1CRSRjvXrmK52tCm288psWrTEK+owp14tFE0leoFORtnvbsloxQrPk5wd2P/rEROCDgO+5b9NlPH3xkFf4gOHGGfzSw0XmeLDsmBoGDwjqMy8ab+HN8TNREARUAReGXZHEu7uJ7AyAEQelmrw==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c3c396-01b3-43ad-bf2a-08df26326cd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 18:23:30.3413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KY+YW2Ob7LQxx04OooqqInk1zMrKx/M9mT8JAU4tDCeFKIBygkza8uFQF+8bBjnFBryit+KlZh5TGqAjA4gamA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFEE39645EB
X-MDID: 1791570215-1iR0SL-PTNOc
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1791570215;1iR0SL-PTNOc;<arouhi@sitime.com>;5de2396b9b83917d02f0372d9ae54394
X-PPE-TRUSTED: V=1;DIR=OUT;

On Mon, 5 Oct 2026, netdev-bot+sashiko@kernel.org wrote:=0A=
=0A=
Replies inline, in the order of the summary list.=0A=
=0A=
> [Severity: Medium]=0A=
> Will this report STANDBY even when no PLL drives the net?=0A=
>=0A=
> [...]=0A=
>=0A=
> Should the destination pin report NO_SIGNAL when intsync_src < 0?=0A=
=0A=
Fixed: a destination pin whose net no PLL drives reports NO_SIGNAL, as an=
=0A=
external input that lost its clock does, and is not active. The poll's=0A=
change check goes through the same helper.=0A=
=0A=
The test is not intsync_src < 0 on its own. A source the driver enabled,=0A=
or whose configuration its scan found already in place, says the net is=0A=
driven; a source found only partly configured does not. Past that, a=0A=
loaded profile can drive the net with a configuration of its own, so a=0A=
PLL the device feeds from the net and holds locked also counts as the net=
=0A=
carrying a signal.=0A=
=0A=
> [Severity: Medium]=0A=
> If the request fails but this re-scan moves intsync_src, what sends the=
=0A=
> pin change notification?=0A=
>=0A=
> [...]=0A=
>=0A=
> Without the same handling here, won't subscribers keep the stale SYNCOUT=
=0A=
> state?=0A=
=0A=
Fixed: the source setter takes whether this PLL owns the net before and=0A=
after the request and sends a pin-change notification when a failed=0A=
request moved it, which is what the output state setter already did.=0A=
=0A=
> [Severity: Medium]=0A=
> If only this last step fails, should restore_global still set the global=
=0A=
> bit again?=0A=
>=0A=
> [...]=0A=
>=0A=
> The EXT page then holds no enable pattern, so detect reports no owner.=0A=
> The global enable stays asserted, and the driver has no owner on record=
=0A=
> that would ever clear it.=0A=
=0A=
Fixed, both halves. A failure of the final per-PLL latch no longer=0A=
restores the global enable, since the net is not configured at that=0A=
point. The rollback of a failed enable uses a variant that does not=0A=
restore it either, so an enable that failed cannot leave a global bit no=0A=
PLL owns.=0A=
=0A=
> [Severity: Medium]=0A=
> What happens to the cached owner if this rollback also fails?=0A=
>=0A=
> [...]=0A=
>=0A=
> Isn't this the case the setter's comment says it has to prevent ("a cache=
=0A=
> that wrongly says nobody drives the net would let a second PLL be=0A=
> configured to drive it")?=0A=
=0A=
Fixed: when the scan after a failed enable fails too, the requesting PLL=0A=
is recorded as a partial owner, so a retry re-runs the enable instead of=0A=
being refused as busy while the configuration sits half in place.=0A=
=0A=
> [Severity: Medium]=0A=
> Does this write need a page-0 small update after it?=0A=
>=0A=
> [...]=0A=
>=0A=
> Later, an unrelated priority-table change on any PLL ends in=0A=
> sit9531x_prio_prg_commit(), which also writes SIT9531X_REG_GLOBAL_UPDATE.=
=0A=
> Could that latch the pending bit and turn inter-PLL sync back on over a=
=0A=
> half-written EXT page, without anyone requesting it?=0A=
=0A=
Fixed: the restore write is followed by the page-0 small update and its=0A=
settle, as every other write to that register is.=0A=
=0A=
> [Severity: Low]=0A=
> Once this runs, is there any way to tell a half-configured source from a=
=0A=
> fully connected one?=0A=
>=0A=
> [...]=0A=
>=0A=
> It returns success without running the enable sequence again. Does the=0A=
> configuration ever get completed in that case?=0A=
=0A=
That is what this revision changed: the probe-time scan records a partly=0A=
configured source as partial, the source pin reports it disconnected, and=
=0A=
a connect on it re-runs the enable rather than returning early.=0A=
=0A=
> [Severity: Low]=0A=
> Should INTSYNC ownership also be detected again on resume?=0A=
>=0A=
> [...]=0A=
>=0A=
> - A's SYNCOUT pin still reports CONNECTED.=0A=
> - A CONNECTED on A returns success without programming anything.=0A=
> - A CONNECTED on another PLL fails with -EBUSY.=0A=
> - A's INTSYNC destination pin is forced to DISCONNECTED.=0A=
=0A=
Fixed: resume re-detects the net's owner and reads every output's mute=0A=
state back from the part before the poll and the interrupt are=0A=
re-enabled, and marks an output whose read failed for a read-through.=0A=
