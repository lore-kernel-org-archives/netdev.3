Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39D9502548;
	Fri,  9 Oct 2026 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570734; cv=fail; b=uvhzaiEgB3CrVwiRn8PhcIwyaYobptmLX6qgYGqQ/DzqO07VhozeVV2awlv0uaX+No7TjpZYr3SRRvE9ObtJ/6s7ubjpdY7KOoJRIr36NPvEbrxi6qCzBg3LZXyjf5ky36WnuaXsfgBEyzy3EyoOznquVMatT+GHDOB/7QBxpDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570734; c=relaxed/simple;
	bh=2ILYh+qRUfm7EJhqXmlc6ahoMY9BtTsi7YckV/i0/Jc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NjPWwInV08jrcpVq6qDXmL3wKpvxLBJLzgO+Dr9B+98e9xXcJ9bLSGlJ8OG45YEIYSK7qZaDeGEZsnG9IFww0zZZBbYPO/QD5giSW04bkOJY3PJdEB8/H1LXrf3IzZlCfrd5ohgfqvcjekZokaRpgopip1gqTrNaj98mIWKiIrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=A5vAxm/g; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=KQ+QvMEr; arc=fail smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="A5vAxm/g";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="KQ+QvMEr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=xVVWuVA9JF6rNZyQ5xBu0PBo5UeOvGT8lBWPvYxhe3Y=;
 b=A5vAxm/gLGy/3ZrkFClmSejGvtLMwVDAT8A+44X154SeAK06hkEzCumoeoBccPh7dX86LBaZ77iKvixSIpS2H5dE4uQtzsJgc1tkGH/AtDYrAY4Pz4xplU4sOgTDjBxSatUkEiFgsipFBUgeoLaU6/lPOWLjR+jT329LOYOrimhirm9cRnJ7Q7TNXdqwmylxxAfPgNMrDD41EfS8v6K5mAYd7bS2j9v8i4lIPXfVmPh3vBeq1phxMf/+LK9i4NcyES3jxOGa73WF+Qb75on9OmBbeOzWlk3TSv5AJLj2TTpx0lrkcBQT3FnwvNhPcPShnP6ucOEXrsQ5RxB6wTssoQ==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023138.outbound.protection.outlook.com [40.93.201.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 315B3C007C;
	Fri,  9 Oct 2026 18:31:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ni5LjEtDDLyXkukWdWLI7LuXIIARi4j4cppxr3jjAbbp+jckMj0lVipDdEFHG5dsprXnV/+VuVTYQ6s8v6UuYwfGIWMkSNvk+cieNiq0oA7FdrPlmuL0E5EGmHLCvRU0rsSne2LvJ+ztGNGKnWVzSPH6Zieb0yrJ0Gc5qMUZneEseiNrT66Qxl9XBnCSA+iDGx1swjS/KRYaKjGYhqqZfA88SqwTHClmCGd4fZ4Ik3WQruvYd5WVnmLU6MuFACgG85rHW/9tv8FVcY8kaWCwPNqfOHC4G8sc3aGnnROy4oxJfmE4hujlVuoUDd8ITTLp3hAcXq+pFtPCSJad+Yoq5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVVWuVA9JF6rNZyQ5xBu0PBo5UeOvGT8lBWPvYxhe3Y=;
 b=buqfScrHUnQ2jDcl3CEqnP+Yw8q3gRSwjEI+/yubWYOIR38m5TzPU9B9NHmeayBxgz+CqmvwgIN3qBxm5JsZKOgQlc0J36cikhgXzGJuoKp03ap1p2ZuLOBSL7BmFiLCGWXjkZDgC/3NdwHEz9XDiXNa0DnqOANAdbtZ+LZ1DjoPZlfW70TBpQ4bIqRKTljGzueXlSuaJ26IcectBrqNgulbdZdDr+UK9bcYm8H6rjzRcEeTBNaYWZfiRSKvbESguevB5wy5B5DYWtMQBKU+nwvrzwg+EqkauP63K9gW/PiGFtLA7oBCXsZKlqaOWRCT73S3xQBEjS+Jnxaw5kDF0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVVWuVA9JF6rNZyQ5xBu0PBo5UeOvGT8lBWPvYxhe3Y=;
 b=KQ+QvMErcKX47qTnNT7IC546L007vzo9w7AmmN+BCtx5DQh1qo/baC3Bk8e/A8vu5fo+y4BKu/6R4tY0WoipP2CZv7rRjD8/TKYXGwB0emSDGYFVFcGfsFPT5JroSrTQEupem7wAbIAm9BtyeDFPO3eMPnskt3bcIvA7OkeZ0rSBA7RecYRi7RcVn2H1+gyKx+4biF5tqbWVeEI648exAf1OLJGk0NeLTJiBs2CdLWNptZHQ4Fc553L6ukTaxdfFINdRBUaxBlacAcfbAlvILPi7hczTDdKtARZe19dzi3kkK6jt++ycbSaZaszMoZjcpAHoYhp2+T1QJc1k+4WdmA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CH8PR20MB995515.namprd20.prod.outlook.com
 (2603:10b6:610:2eb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 18:31:54 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:31:54 +0000
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
Subject: [PATCH net-next v12 02/12] dt-bindings: dpll: add SiTime SiT95316
 clock generator
Thread-Topic: [PATCH net-next v12 02/12] dt-bindings: dpll: add SiTime
 SiT95316 clock generator
Thread-Index: AQHdWBx1fHIkpCZDMUqD922ZywxLzA==
Date: Fri, 9 Oct 2026 18:31:53 +0000
Message-ID: <20261009183151.78497-3-arouhi@sitime.com>
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
x-ms-office365-filtering-correlation-id: 221cc9b9-9232-40c6-c9c1-08df263397c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|56012099006|5023799004|10067099003|22082099003|18002099003|3023799007|6133799003;
x-microsoft-antispam-message-info:
 OrOib96CI+JT2dbdTYQ7/Y56eWTh5MJ5/98yb0y3w1cvv3do34+Lpb0+lk5GLXtYr9pVuZiZxZJ3prprjIenc2J8GCB3ozSX+Tuh+tFuv/7BbgwYXsPbRyVa/opKRWNH5v7YyVZ/HXBalpQanfeYhsPjNfdZ5uErHUIFGM+Q8k87uVAxFHdFaUFURaTrLDIG0q84w/YC/Mi1U6ZbcbouChS2xgga5WBI6G6V6CUvOLqfDCmxzyd2fU/vfZbnO0miGGtyufpLT/3x3rRB7N/FvWGpdBBk9VnZ2s2VLiDFqq71L5PvzyhH7cuYXxkdHJGajgwm7um6da4Vvk8flrNcaWj0XgLw880vSdXW0krKOBGyebPE58HhdDnhS7aWog8RyyK1uc1Sn5aHk6qTHjXnFG/ncszm14plT5zb0IuAncDybEgSIrWvzXsRfuiNBJbjEW95bKYK93XBwB5JCtiYWkDPR/uECiwWmker4NwCDOICHuiZ25OBhe7KyWDl8mZs//MNh2pKwEYJ9yw5641VWYqPqIdvx9Dsv85mle7v+Yk7H0Y6r64Eeozmpbq2SIO9G2e5wevKviOc6BbUg+irZyRwPmFdlrPr339VC62S7HXCOkbK++ZcovUQH1bHo61PVtREEVL6oZikiUJd0ndBrtq8STzSEj6UXVhT3B1wx2g=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(56012099006)(5023799004)(10067099003)(22082099003)(18002099003)(3023799007)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Q6bQAhfqovYfYVfPfsCCQAXSo/nZfS+y6LIHAmNtxgGo8acwhWhuowxldP?=
 =?iso-8859-1?Q?BNwq7xCulXu6mgBT0l5T5vGda3JfBTbawupAvdlNpD5OgnJhfch+PQknkf?=
 =?iso-8859-1?Q?8ztQ8bOiIE0J3Nnfon7OCX6ARfn/z/mb/6kSpAoF7G/WzHb7roa6/XGw2y?=
 =?iso-8859-1?Q?j/cbUeq8CN1M0S26ZfhJMnuo+7HFDYoI0Cqu5nVXlbspGGni6IQ5PrUNuq?=
 =?iso-8859-1?Q?JnyznL+JmOWyaMap6I2PJL+1pavhhv00tMFS/NPLbvVFPkg9cJ5G9aD969?=
 =?iso-8859-1?Q?DxYd87prCRdR62RE70VtHes8GDUmgPYrfB8w/jUNZXdRJufbGX/W/JE3YS?=
 =?iso-8859-1?Q?BgZGOtCXHCh6xfChBKIHatBJNwKLmd8ZTgkTb/sKUjJTdVLXivM/tMQN7X?=
 =?iso-8859-1?Q?LSn/g1bBm94c37YZusxgw4yGMSaKoKev0VYtT5tPDk3whjIH8LZWou0/UI?=
 =?iso-8859-1?Q?dS1TAD3pQTxXl2I60Epf7vL2xRSxFpXKvaXtzz/uGkXVVMMIlwjHieo0if?=
 =?iso-8859-1?Q?Jjys0Z3YjsuIlUc5F4TSrp3MWo6aHjaFWql6lA0BMhSTSy/LkWcP/TVuSE?=
 =?iso-8859-1?Q?kOxjne9R9/KvMSd3DXuXtBWPuVDGB5YHDE7EwQMxb1vZSSF9dKqSYhR0/7?=
 =?iso-8859-1?Q?ZeAm7Sny9WNjEAg/53XZ/dsEkP1Ib2BNgdLptC30MPxDLkyZuBMVUmQjAD?=
 =?iso-8859-1?Q?WQEvVkYNYb8k14XQSUi3+YhVvC4oNI7mBJOJkoPzUeMr3q7zZvKP6FnSnh?=
 =?iso-8859-1?Q?7eLSTFNCzRvRHcsNZLkqPMDPftdXIp3fcO3q1e7DGd8INXX8Vxh6n2Gi+g?=
 =?iso-8859-1?Q?iOFxKHD5I3yos+Da1jU70GrnBU5sL2Ngu+lNV6AiAY3iwXe/i3kHE3uo5J?=
 =?iso-8859-1?Q?EsDvbKLXfRFhrzTwIvWgRgzUKvyxbgAaTHF7l6bAHn/vdjI1tikIFUVTRI?=
 =?iso-8859-1?Q?TntAnqw2h7ZZ8PJO6jQXD81N3ity3HBV1wP0o8Omw6sGo9Xiicn+Rx5oLu?=
 =?iso-8859-1?Q?LiSEyg0L6CZZ202GdV4d0P6EmGtwz+IzpntXMzZS87iQ1HaKhN1JwX5CtL?=
 =?iso-8859-1?Q?vRomUzFSEK6GoUQZo06CDmExA5MSfgRiTefetfgeivJsSrWUwR5Dhix7rR?=
 =?iso-8859-1?Q?ZmVpmqbph8TYJQRvKR+ygxrwO23nkRvIjqkR25lc5ZpcTKsqb82OlzwX7L?=
 =?iso-8859-1?Q?G+hN914OY1plE6/OwbueVNQov0KQYhjGPaUvHreLW644v5Go04hAPo1KCD?=
 =?iso-8859-1?Q?LTDx0kcXOP+CG7xJSgMH7c2O+QyzZFTFr1/LDuc+1a+8fvyxb+ppWnpIRD?=
 =?iso-8859-1?Q?OlqrHYT7vupKrUZM0exXOCudLICpq9XlKEf4OjreviKrpOAi9LOWwt1Jq2?=
 =?iso-8859-1?Q?eabwBd7+ac31aBDVyxK2ACopQ8/qFL2qGln/9DaAk+GKWLHm3bFZPcW7I4?=
 =?iso-8859-1?Q?Rkfzcs9C0OwpkZGcgh7tOYfJhhc5XlMj31GxnHgfsQIlha0VHqUx1BUaNr?=
 =?iso-8859-1?Q?QEBW1CYu+NaCUsoGNUxLO3sjeyoXaQTyXU76hk/Lzp/lWL8BxaXrM0A3Oy?=
 =?iso-8859-1?Q?FwPOxeH7UQPJuKYVXFRaJhFPz8fW25IOvS25aPM8p6N45uo6/PDenW0ujS?=
 =?iso-8859-1?Q?t0K42OTKvaJ89zuJq8hD9OmU+3GrR8wf2Gh19UM/p9+agAVQxsoW9jtEoJ?=
 =?iso-8859-1?Q?LS9WbzIJ6uHPqesanFoVsMyQGUnBdloKNklVI/XlNpZ6VTPgX8mxhHtROL?=
 =?iso-8859-1?Q?if5YC0i/eqel2HgyOID9MT8Ys9wYuAHCER5F9p5nR8xno+?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	CKX6IC9VkF8vSPFFz/cURrfncig2ubcQts9uH+PaTEBZtyE+yD62iGiw3ya4LdlfjHE/wFG0K2ASOK48QzLSm+BLW2qrmODvxARyXVeffx4NIsI3RNI26vaEmKXjxsXl+lRGb0CyRJTzFj1ULp3YXhgS5agDCbG4RVHz7mhpzjgHBdRw0OI7mOfIhD+RRCAfzARP3WMeOzZJrkhohKLLOlDQx/bRv64I+kkZE/Q4U01YpH4RcRwPNciCtWpGsjIDkzWBHXsJHFtuWJOPTmiQp3erugHH2uZnuRvP30Cw1GyUrz14fW7LUC2Nq1Rg2ALoyrwI+TLAjs1gGpmjSMPRig==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 221cc9b9-9232-40c6-c9c1-08df263397c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 18:31:53.9246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vMBrQ+6j4DOpy3lwXAyq7/GEhLDta2U8icfoMXTL4KfuBZRnDWbGaybeDjJnxK+zcSZ6rgcFkWexdcGb1je8OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR20MB995515
X-MDID: 1791570717-P1mZ1vWRVgzr
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1791570717;P1mZ1vWRVgzr;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

Add a binding for the SiTime SiT9531x family of clock generators: an=0A=
I2C-controlled device with four independent PLLs, up to eight input=0A=
clocks and up to twelve outputs, described as a DPLL provider.=0A=
=0A=
The XO is given either as a clock or, for firmware that describes the=0A=
oscillator as a property rather than as a clock provider, such as ACPI,=0A=
as clock-frequency.=0A=
=0A=
The supplies are described by their pin names: the core and input rails,=0A=
the GPIO rail the SiT95317 has, and one per output-driver pin -- VDDO0 to=
=0A=
VDDO7 on the SiT95317, VDDO0_1, VDDO2 to VDDO9 and VDDO10_11 on the=0A=
SiT95316.  The driver does not enable them, since the boards so far=0A=
power the part permanently; describing them gives a board with=0A=
switchable rails a way to say so.=0A=
=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 .../bindings/dpll/sitime,sit95316.yaml        | 213 ++++++++++++++++++=0A=
 MAINTAINERS                                   |   6 +=0A=
 2 files changed, 219 insertions(+)=0A=
 create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit95316.=
yaml=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml b/=
Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml=0A=
new file mode 100644=0A=
index 000000000000..200b9f709a57=0A=
--- /dev/null=0A=
+++ b/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml=0A=
@@ -0,0 +1,213 @@=0A=
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)=0A=
+%YAML 1.2=0A=
+---=0A=
+$id: http://devicetree.org/schemas/dpll/sitime,sit95316.yaml#=0A=
+$schema: http://devicetree.org/meta-schemas/core.yaml#=0A=
+=0A=
+title: SiTime SiT95316/SiT95317 DPLL Clock Generator=0A=
+=0A=
+maintainers:=0A=
+  - Ali Rouhi <arouhi@sitime.com>=0A=
+=0A=
+description: |=0A=
+  SiTime SiT95316 and SiT95317 are I2C-controlled programmable clock=0A=
+  generators with integrated DPLL for synchronization applications.  Both=
=0A=
+  variants contain four PLLs with automatic/manual reference selection,=0A=
+  DCO frequency adjustment, and phase offset measurement via an on-chip=0A=
+  TDC (Time-to-Digital Converter).=0A=
+=0A=
+  Both parts have 4 differential input pairs whose lanes can also be=0A=
+  driven independently as single-ended references, so 8 inputs are=0A=
+  individually selectable.  SiT95317 drives 8 outputs, SiT95316=0A=
+  drives 12.=0A=
+=0A=
+  Pin numbering.  An input pin's reg is its lane: 2k is INkP and 2k + 1=0A=
+  is INkN, 0 to 7.  A pair the loaded configuration runs differential is=
=0A=
+  one input, described at 2k.  An output pin's reg is its physical output=
=0A=
+  OUTn, 0 to 11; the SiT95317 bonds out OUT0, OUT3, OUT4, OUT5, OUT7, OUT8=
,=0A=
+  OUT9 and OUT11.=0A=
+=0A=
+properties:=0A=
+  compatible:=0A=
+    enum:=0A=
+      - sitime,sit95316=0A=
+      - sitime,sit95317=0A=
+=0A=
+  reg:=0A=
+    maxItems: 1=0A=
+=0A=
+  clocks:=0A=
+    maxItems: 1=0A=
+=0A=
+  clock-names:=0A=
+    items:=0A=
+      - const: xtal=0A=
+=0A=
+  clock-frequency:=0A=
+    description:=0A=
+      XO rate in Hz feeding XIN/XO_CLK, for firmware that describes the=0A=
+      oscillator as a property rather than as a clock provider, such as=0A=
+      ACPI.  Use either this or "clocks", not both.=0A=
+=0A=
+  reset-gpios:=0A=
+    maxItems: 1=0A=
+    description:=0A=
+      GPIO connected to the chip's active-low reset pin (RESETB).=0A=
+=0A=
+  interrupts:=0A=
+    maxItems: 1=0A=
+    description:=0A=
+      Interrupt from the chip's active-low INTRB output.  Asserted when=0A=
+      the device detects a status change such as lock acquisition or loss.=
=0A=
+=0A=
+  dpll-types:=0A=
+    maxItems: 4=0A=
+=0A=
+  vdd-supply:=0A=
+    description: Core supply of the PLLs, 1.8 V (the VDD pins).=0A=
+=0A=
+  vddin-supply:=0A=
+    description:=0A=
+      Supply of the input receivers and dividers, 3.3 V (VDDIN).=0A=
+=0A=
+  vdds-supply:=0A=
+    description:=0A=
+      Supply of the two GPIO pins that have their own rail (VDDS).  The=0A=
+      SiT95316 has no such pin.=0A=
+=0A=
+  input-pins:=0A=
+    type: object=0A=
+    patternProperties:=0A=
+      "^pin@[0-9a-f]+$":=0A=
+        type: object=0A=
+        properties:=0A=
+          reg:=0A=
+            maximum: 7=0A=
+=0A=
+          supported-frequencies-hz:=0A=
+            description:=0A=
+              The rate wired to the input, in Hz, as a single entry.  An=
=0A=
+              input runs at the rate the board feeds it and has no=0A=
+              frequency to select, so that entry is what the pin reports=
=0A=
+              as its frequency.=0A=
+=0A=
+patternProperties:=0A=
+  "^vddo([0-9]|1[01]|0_1|10_11)-supply$":=0A=
+    description: |=0A=
+      Supply of an output driver, named after its VDDO pin.  The SiT95317=
=0A=
+      has one per output, VDDO0 to VDDO7, numbered as that part's=0A=
+      datasheet numbers its outputs; in the pin numbering of this binding=
=0A=
+      those are outputs 0, 3, 4, 5, 7, 8, 9 and 11, in that order.  The=0A=
+      SiT95316 has VDDO0_1, VDDO2 to VDDO9 and VDDO10_11, the two shared=
=0A=
+      pins each powering the pair of outputs they are named after.=0A=
+=0A=
+required:=0A=
+  - compatible=0A=
+  - reg=0A=
+=0A=
+dependencies:=0A=
+  clocks: [ clock-names ]=0A=
+=0A=
+oneOf:=0A=
+  - required:=0A=
+      - clocks=0A=
+  - required:=0A=
+      - clock-frequency=0A=
+=0A=
+allOf:=0A=
+  - $ref: /schemas/dpll/dpll-device.yaml#=0A=
+  - if:=0A=
+      properties:=0A=
+        compatible:=0A=
+          const: sitime,sit95317=0A=
+    then:=0A=
+      properties:=0A=
+        output-pins:=0A=
+          patternProperties:=0A=
+            "^pin@[0-9a-f]+$":=0A=
+              properties:=0A=
+                reg:=0A=
+                  enum: [0, 3, 4, 5, 7, 8, 9, 11]=0A=
+      patternProperties:=0A=
+        "^vddo(8|9|1[01]|0_1|10_11)-supply$": false=0A=
+    else:=0A=
+      properties:=0A=
+        vdds-supply: false=0A=
+        output-pins:=0A=
+          patternProperties:=0A=
+            "^pin@[0-9a-f]+$":=0A=
+              properties:=0A=
+                reg:=0A=
+                  maximum: 11=0A=
+      patternProperties:=0A=
+        "^vddo(1[01]|[01])-supply$": false=0A=
+=0A=
+unevaluatedProperties: false=0A=
+=0A=
+examples:=0A=
+  - |=0A=
+    #include <dt-bindings/gpio/gpio.h>=0A=
+    #include <dt-bindings/interrupt-controller/irq.h>=0A=
+=0A=
+    i2c {=0A=
+        #address-cells =3D <1>;=0A=
+        #size-cells =3D <0>;=0A=
+=0A=
+        dpll@68 {=0A=
+            compatible =3D "sitime,sit95316";=0A=
+            reg =3D <0x68>;=0A=
+            clocks =3D <&xo2>;=0A=
+            clock-names =3D "xtal";=0A=
+            reset-gpios =3D <&gpio 78 GPIO_ACTIVE_LOW>;=0A=
+            interrupts =3D <12 IRQ_TYPE_LEVEL_LOW>;=0A=
+            vdd-supply =3D <&reg_1v8>;=0A=
+            vddin-supply =3D <&reg_3v3>;=0A=
+            vddo0_1-supply =3D <&reg_3v3>;=0A=
+            vddo10_11-supply =3D <&reg_1v8>;=0A=
+            dpll-types =3D "eec", "eec", "eec", "eec";=0A=
+=0A=
+            input-pins {=0A=
+                #address-cells =3D <1>;=0A=
+                #size-cells =3D <0>;=0A=
+=0A=
+                /* IN0P and IN0N: pair 0 runs single-ended */=0A=
+                pin@0 {=0A=
+                    reg =3D <0>;=0A=
+                    label =3D "clkin0";=0A=
+                    connection-type =3D "ext";=0A=
+                    supported-frequencies-hz =3D /bits/ 64 <10000000>;=0A=
+                };=0A=
+=0A=
+                pin@1 {=0A=
+                    reg =3D <1>;=0A=
+                    label =3D "clkin1";=0A=
+                    connection-type =3D "synce";=0A=
+                    supported-frequencies-hz =3D /bits/ 64 <156250000>;=0A=
+                };=0A=
+            };=0A=
+=0A=
+            output-pins {=0A=
+                #address-cells =3D <1>;=0A=
+                #size-cells =3D <0>;=0A=
+=0A=
+                pin@0 {=0A=
+                    reg =3D <0>;=0A=
+                    label =3D "clkout0";=0A=
+                    supported-frequencies-hz =3D /bits/ 64 <156250000>;=0A=
+                };=0A=
+=0A=
+                pin@1 {=0A=
+                    reg =3D <1>;=0A=
+                    label =3D "clkout1";=0A=
+                    supported-frequencies-hz =3D /bits/ 64 <25000000>;=0A=
+                };=0A=
+=0A=
+                pin@a {=0A=
+                    reg =3D <10>;=0A=
+                    label =3D "clkout10";=0A=
+                    supported-frequencies-hz =3D /bits/ 64 <10000000>;=0A=
+                };=0A=
+            };=0A=
+        };=0A=
+    };=0A=
+...=0A=
diff --git a/MAINTAINERS b/MAINTAINERS=0A=
index 72ca3aab2106..858fe1c4332c 100644=0A=
--- a/MAINTAINERS=0A=
+++ b/MAINTAINERS=0A=
@@ -25182,6 +25182,12 @@ S:	Maintained=0A=
 W:	http://www.winischhofer.at/linuxsisusbvga.shtml=0A=
 F:	drivers/usb/misc/sisusbvga/=0A=
 =0A=
+SITIME SIT9531X DPLL DRIVER=0A=
+M:	Ali Rouhi <arouhi@sitime.com>=0A=
+L:	netdev@vger.kernel.org=0A=
+S:	Maintained=0A=
+F:	Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml=0A=
+=0A=
 SL28 CPLD MFD DRIVER=0A=
 M:	Michael Walle <mwalle@kernel.org>=0A=
 S:	Maintained=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
