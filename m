Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BAF3EFFC2;
	Mon, 21 Sep 2026 20:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.183
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021485; cv=fail; b=kTGpIZgKQgj+IZCxmN2G+WrI4VdygjbJFhAaJGS9hZEGQupJonKp/uUkEF4W4Xicl5KAkzPWQvepE3ctb4pGpa826kntvIcPP5IU+9R2XP/VIQ61XZKLlUlBCicLNExEdJPPXTSu99kH72YvLniZyEX0U+Kr7yCDWV0E84dXvj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021485; c=relaxed/simple;
	bh=xxaAT6C6KIRVHpMOt0Gsv/UANAXCrdtxaHDtvIE4z/o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OI7wXUpHZBFkpD0anZ24cs8F2WwaiZ+HkyUVe0KDWAJq/VfkztmavpgW2idMhzDAMQoXDKBap4h8AjkQa0veL6gTZsKhAukSZah2k81zz4betc7hzBigZMf2188m+lBdOdPY+qdp9JuFPk4lWL5rCuLgEuo79g+X4Jhw/p7YwOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=brEHOx7V; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=PUHpXO2T; arc=fail smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="brEHOx7V";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="PUHpXO2T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=n0Tdl/oTlOemZLEU2i+bgqjAlTNmqh7bimKC1J6/C2U=;
 b=brEHOx7VPp7oY+PY0Nr4sib6Ztjfaq03f0G35UgKyoDyBSK59HeT+4eToxJjU/DvnmzuPQKx1vvW1fc8wMsT9A6Zvd/Gime5C1bITBokjgUfLkmaovKl/4Uk46x+5711U88oK0/2j5AxidDSqKg8SI40SY33LvI4BZ58Rt5WckQwAY0or4siWVx5/Q32t8mZ63WKG8sdsn3aZ54Tf8LnpKiJnOmmR/gW4eGJQhyPJAdrhFuC9QEP+iCOjIMl7ZaHX7Rlh0aDYLkfxIkXufwJh/MyybCbgn94gWUzdp1dsLdkRHIm7ehSZhrpMhE3in9F4Ws7FjusuCZi87guRYAIew==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020140.outbound.protection.outlook.com [52.101.193.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 72743940079;
	Mon, 21 Sep 2026 20:11:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kojO13FT31Fy1u4sSjzDVrE1V1FAIP20fj7P9ayTHs8/WVoIGZ3Ym13N4C2jj9HxyLfhA/RLdvG21ljr/JRCX+1FNOeVQVfRQgUv+d5U3qeKTwtEmqHj4gio+4XZxMXfmfRvBs/rw7Qbnk9RIA2QkPU8fXUYbsWWXiekVxyxgBulsP+pohl2EoHu3CVbgbZOsaTym+pERsRHoRtlktmcLMDZZe+iZy3buj5jLUiYgZu1Q4RpXleyZAMDMPDpTcwAkJBiQpjbWleaeiryk8CzTPH46dBrVbnkTfi3B95dejBX9J9bE/0ylWjixFXQWqUUmnwLUj7RLmiqVERNOQXLbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0Tdl/oTlOemZLEU2i+bgqjAlTNmqh7bimKC1J6/C2U=;
 b=tnWlM/RHg7+f+m4uVV6hNRlFsgDx2FSP5tc+fujmdTFh51wj2lxT5Cfbyx1C0DZyQOxZq/X7fnPUGf4mclbu7vwpfaUPo8wWKUCGBpeSF8kLytL6cDFozvj+CSNNuWkJdbw2W5q5rXmzZwkUyCR7oLVAMu5gPtowN1xRahA2dLpYJ2SL5zR1fwJzGsG69ky3btTqI8OT/u+HWUWJtWEM6R+jln/zkKsUUFw9Q26dPUSlzPClydKDw1C+tyuiChFkGKalskhjSJxY5i6O1NusypsqSlSEdWjrRd6RZABJuCZI41GinVOnpRBNQWSvLlIztLUbOXQnVjzZDNqu7yB4qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0Tdl/oTlOemZLEU2i+bgqjAlTNmqh7bimKC1J6/C2U=;
 b=PUHpXO2TolL2WaR6/5yjDhfVRUbT3mUeDypjm9LKfm5aa/qQBInOQQQM+jt3JL4VreqjgQuBCcQAUEFFv/tZwyI9M1FoW86JelbFAsHClQCWy199Hpxe4u7HDo6Y3210nlEC4rX4XyXjQLPqKMelbPK5dkwuI/0m2uhzXC53/0dYyGw1KmKlTQrAjmIoMFfEuf/QG/u5M1VYTxYOA0GOepZ2vZRzzZts0wltUASV8cGhanj9fDAKJHY1RBFi2ce+YcjyJlmHaaHZePluayqXTqhbU2Cpt7tOpSzzkca2IMQfMU4K06K1bDBdNGZPqgbopGM65Aj/0HcjCOzEEGShCQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS3PR20MB7783.namprd20.prod.outlook.com
 (2603:10b6:8:2df::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:11:14 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 20:11:14 +0000
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
Subject: [PATCH v10 08/14] dpll: sit9531x: add support to get and set
 frequency on pins
Thread-Topic: [PATCH v10 08/14] dpll: sit9531x: add support to get and set
 frequency on pins
Thread-Index: AQHdSgVayShNagGJu0WeHwNp5yCxSg==
Date: Mon, 21 Sep 2026 20:11:14 +0000
Message-ID: <20260921201108.42676-9-arouhi@sitime.com>
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
x-ms-office365-filtering-correlation-id: 03f8b32e-f189-4335-22df-08df181c7cf1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|3023799007|6133799003|22082099003|18002099003|5023799004|38070700021;
x-microsoft-antispam-message-info:
 k37DITTLudwqqlUDwDWJeKT3ZHp7oalGgsLyz0tRaDlMlXb8KBVMF/0U7tyAZ7kcQvcY7BGqjZOuqz+/y+QSSSw3SNfHG3KaYWeAbyGbQGqplA0P+MPTAUoRDQUcdZDctdBNGmqoohNqGYp7/NPq+XHWCytsgg8KVrABcKwOP5CilVtRhRDvBlhFRYRClwih0n4oK8p+OReNvtqfU7ZRhgZPAB74HeoTbcIClj66wEsZLQYytpnsuL/Pwt921FVdY9nYh9zsYEXRVUOxWh6vqaC7QJyPMPOfWNNbBsB05YJkxdJByEl0G1BkuKab4m90jE0fZCBe3zaGMtgYPI/+7El9vDjui5Ez6tkeL0pBUupH2pNxy/op8A6nYUpZWAmUrnqSlPBsHRsqx0tS9irMJheWaaqv2yR1QdcavniofNNidtvkFCmHW9nOVgHE+rxj50X9GeyZjt2hsdJbH6Dxx17IwsohTY+ze98G6vlqf4k/SugQtlNdnfUPRPzokBSYKVT8ugZlE1BiW4EsBpJA57itCMF/z2MkE6sshvx6eose1i9dOBF9tFEcPP4iTrAKIz1qk16S5thWsPXW61S1VBxUikiuJq332ixOWPS7BAKk5EhALAdR4/XRYk8ttVzxAxrhACzIrw33S2HcFXgDAEjO5ybFdc5TjzcNse1uPdJz0zyryBG3ZxvLjZvBBC6Z7QLkc0HnOUqi3SUuz+eLkhmV9+elavGeAEt3KNFBmDo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003)(5023799004)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?EBmZQmUlxJ3mLmtxBMu8BbT8mjK8iZJ31nJk8Ail09VhJiLgNR99b4p2+E?=
 =?iso-8859-1?Q?PZ+yJwPNGL0kOfghSau2GKwN5HhI+XQx+HQpuLMnhRVT2y4meUARZxuWC4?=
 =?iso-8859-1?Q?3hGQs4eWIvGy0J8jR4o1OIVz17UMi8KN87YKXwD3/4dVfuCO6yRJr/8kT3?=
 =?iso-8859-1?Q?Qj1Hdlck98wAok0iDh3gepzpBtlrmKBdUyh8v3cmgKymkvaG7oANZ0UJds?=
 =?iso-8859-1?Q?Iwp2Ef/8H3RMjFoUsDszmXrLjS+RED2un/uK3fAB9kj6VUXEn7xPl9sLb4?=
 =?iso-8859-1?Q?lKCN1kfl3QDcxVwd3KdeXQG9ivWFEHF3Mq/flnqTPXztd5+sWu9z0izwX3?=
 =?iso-8859-1?Q?wGDJFAf7fRrvwUMbWhTbILlCtnCFZZoqPvtBpfAKj4Kx7AWK2FglX5Mook?=
 =?iso-8859-1?Q?KCDPERmT+pmLEBXk8PhuOlOfCD4mkQ1kqZE2LbrZs7Sf2cOVckv27kViJH?=
 =?iso-8859-1?Q?vhfZASq9mTc9LqRc4J5lxhkqtAkQ3nVU1rd6YGqUK7ng0vIyRloAPRqFu7?=
 =?iso-8859-1?Q?rysKnBqDoVmzW9sR+CCsrHwRhmvqhFj4iHBusz57UKJAHY4kXodR3GqKYn?=
 =?iso-8859-1?Q?1MPRtCBqJEqWZAy+xz9pxEA45PKyy1yU5HwHT4pgTVG0e8q5MNDdo+Py1U?=
 =?iso-8859-1?Q?aXaH867o5pFAd/D+AUs5aRMyt8wNXSDtyGF72WTBkfefZwBGqrsUXx4cp5?=
 =?iso-8859-1?Q?hbEJq9er9GzzOqiHxLn9KGRAK0k4qFYxE0D23A0cddQd+BBGeERmEyPp/c?=
 =?iso-8859-1?Q?fgs0ZX48rBkABu831sqPW7/0nrBGMhUWbMSEsy/uA/VHnYx0wgGi6KkEhg?=
 =?iso-8859-1?Q?bMqSiSr2Tm9OJjHbmtrqs7vwF5f7KMiTZHApx+wMkeld5x59Pa76hJHNAn?=
 =?iso-8859-1?Q?FlXC/zCHVs2IaDl7sWwqm4LZ7GkYEC1KJMrwXJeIw6dQbTuNg6UXNqyoiT?=
 =?iso-8859-1?Q?pQe/KyyR7e6FS+y/MOL87w25ZWWFHF8vWoKW84J383Q1yDAJQPydiIoVgQ?=
 =?iso-8859-1?Q?uzxAPrSR6gWp8K8v6DBNPpRo3cyPnJlAzoVaz0hQTOjt0fWMBrlX01KDjG?=
 =?iso-8859-1?Q?Lloethicux/nqO2/FOzmi55pmIXXXLEiX0Cu8z2GXV5DXwQWDV0gYF+L94?=
 =?iso-8859-1?Q?ITWxPtdEFQd3taECKYEI/AyteI27zuUDYljVdK0qcplQA7nwRjiMLueNKF?=
 =?iso-8859-1?Q?neNS7/hmSDlzoNOBD6YdpOA3Rlh0kazDLI2bGwPV2gJcNGz3ka+xdKUHWN?=
 =?iso-8859-1?Q?YFVJn61mQ6NNndkZgfbMzoafIeA6PzWEalo7OrKWXwFYBXjvpyuEUutZeJ?=
 =?iso-8859-1?Q?q3ZTleSXWtXkN54DFIzS5MqiC3DArddoijBZyyUS+DFB/lQpCVP9AKRMuV?=
 =?iso-8859-1?Q?t+I+aDlyvGlPkQddrwLbFjhpWKtBZLMlxzQlAXUX3//Q2UnXKtsPoTZlr8?=
 =?iso-8859-1?Q?1wZvRGPIiouslLTxAGWesuUTDURhvoawQM1VpaVnI5fd7+WLtnVslYwuha?=
 =?iso-8859-1?Q?pRVIrsbT8DSXDjD98A0FteybDLbJs5eMoBEba3oJwnhCEbpKV6CZo+lvvc?=
 =?iso-8859-1?Q?UfiEohcWapWD7y7sYbdnQUUzJ4Hj18RC+RSP1VU0mPes/hHcKflFGEBIpK?=
 =?iso-8859-1?Q?rh52/PkAC0VQRWt/PnoVV6tWoiva5N63IZTx6kWCEBU+ghQ9HkV/gTlLZE?=
 =?iso-8859-1?Q?aS21t9UU0nc0vIvXEG8jImVikBYkFcjwz/sk2WuEi2Jcbbk6ohavnyIhpc?=
 =?iso-8859-1?Q?hSXlIVlNrY3D0tsqG7b4WCWyoKO8Ug6xRzzF5n4DGl9VnF?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	UM4tiDvlV1/yy/nWqgdkHGkx3tMzi0viA8i2+e5eNgT2ynbsCK7qlZaQfeFUr53Rq2QjLPvMzUa0l7TGEmnv/dopQfmVQCzCXyrUOe3j1uHVIQ3dbM5jsUza13+jeUUjMFupkCse91qAy/pR++Myr5gq9PjPfDDhB5QQtVwYTFXxNoPKW6lmwci9n/G4x28BNLoZX7pzOzP271jrLZ1byiJv8It4Y+YgGq16YmFdz+p5NFrkuGAXtS2H4qjZgy4FDFsp0Ni+JlIriF/JK3MNe63oCZmbBGlwP4uFfGbm4Xa1iIllPwvkoj9ctOXH1P68wYr/o/ZOEgTIpjNYwwQpsg==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f8b32e-f189-4335-22df-08df181c7cf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 20:11:14.3701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yb6zDrdO/LJkf/ISFpcMmjEeVwpW3s/cElQIq/IM2HkItOJkeGCjpTAYRqjA/DH28vUXQ3pSB1xhtuHj4P0zzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR20MB7783
X-MDID: 1790021480-ZW7KDnRa4Np4
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1790021480;ZW7KDnRa4Np4;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Both directions in one patch, since they share everything that matters.=0A=
=0A=
An input's frequency is what the board presents, so it is reported from=0A=
the firmware description rather than read back: the chip has no divider on=
=0A=
an input whose rate it merely qualifies.=0A=
=0A=
An output's frequency is the VCO divided by that output's divider, so it=0A=
is computed from the divider read back from the chip and set by writing a=
=0A=
new one.  The VCO in turn comes from the feedback divider, which is why=0A=
the crystal rate is needed at probe.  A divider write only takes effect=0A=
inside the programming state, and that state has to be left with the=0A=
output loops re-locked whatever happened in between, so the exit runs even=
=0A=
when a write in the middle failed and the first error is the one returned.=
=0A=
=0A=
Programming a divider costs about a hundred milliseconds under the device=
=0A=
lock: a dozen or so register transactions, then the settling time the part=
=0A=
requires after the loop-lock command, which is a property of the hardware=
=0A=
rather than a conservative guess.  The DPLL core holds its own lock across=
=0A=
the whole callback, so a frequency set on this device delays netlink=0A=
traffic for every DPLL in the system for that long.  Splitting the wait=0A=
out would need the ops to complete asynchronously, which the interface=0A=
does not offer; issuing the commit without waiting would let the next=0A=
request program a part that has not settled.  A rate change is a=0A=
configuration action, not something a running system does per packet, so=0A=
the cost is paid where it is visible rather than hidden behind a=0A=
completion the caller cannot wait for.=0A=
=0A=
The phase flush that follows a divider write realigns every output fed by=
=0A=
that PLL, not only the one that changed.  The flush is a per-PLL function=
=0A=
in the device and there is no per-output equivalent, so an output whose=0A=
rate is set while its siblings are running will step their phase too.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
=0A=
Notes:=0A=
    Changes in v10:=0A=
    Arithmetic and overflow: a DIVN fraction whose numerator is not below=
=0A=
    its denominator is refused rather than divided, which could fault the=
=0A=
    kernel from an ordinary pin get; the output divider rounds to nearest=
=0A=
    and refuses a rate it cannot produce exactly rather than running the=0A=
    nearest one and reporting success.=0A=
    =0A=
    The VCO clamp moved into the accessor, so a frequency get and a=0A=
    frequency set work from the same number.=0A=
    =0A=
    Error reporting: entering the programming state closes the loops and=0A=
    the debug key when it fails; a phase flush that fails after the divider=
=0A=
    is committed is a warning rather than a failed rate change.=0A=
    =0A=
    The small-change directive is written whole, not read-modify-written --=
=0A=
    it is a command register.=0A=
=0A=
 drivers/dpll/sit9531x/core.c | 681 +++++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/core.h |   4 +=0A=
 drivers/dpll/sit9531x/dpll.c |  94 +++++=0A=
 drivers/dpll/sit9531x/prop.c |  36 +-=0A=
 drivers/dpll/sit9531x/regs.h |  17 +=0A=
 5 files changed, 823 insertions(+), 9 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index ac184c93258c..0687ad6de861 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -418,6 +418,127 @@ static int sit9531x_output_forced_hiz(struct sit9531x=
_dev *sitdev,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/* Attempts to re-lock the output loops before reporting them open. */=0A=
+#define SIT9531X_LOOP_LOCK_TRIES	3=0A=
+=0A=
+/*=0A=
+ * sit9531x_prg_abort - leave the programming state without committing=0A=
+ *=0A=
+ * Entering the state is two writes, and the second can fail with the debu=
g=0A=
+ * block already unlocked and the part possibly already in PRG_CMD.  There=
=0A=
+ * is nothing to commit in that case, but the loops still have to be close=
d=0A=
+ * and the debug key put back, which is otherwise only done by=0A=
+ * sit9531x_prg_commit().=0A=
+ */=0A=
+static void sit9531x_prg_abort(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	u8 attempt;=0A=
+	int rc =3D -EIO;=0A=
+=0A=
+	for (attempt =3D 0; attempt < SIT9531X_LOOP_LOCK_TRIES; attempt++) {=0A=
+		rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
+				       SIT9531X_LOOP_LOCK);=0A=
+		if (!rc)=0A=
+			break;=0A=
+		usleep_range(1000, 2000);=0A=
+	}=0A=
+	if (rc)=0A=
+		dev_err(sitdev->dev,=0A=
+			"output loops left unlocked after a failed entry: %d\n",=0A=
+			rc);=0A=
+=0A=
+	sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,=0A=
+			  SIT9531X_DEBUG_LOCK_VAL);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Enter the output-system programming state: unlock the debug=0A=
+ * registers on Page 3 and issue the PRG_CMD state command.  Register=0A=
+ * writes that reconfigure the output system only take effect when=0A=
+ * they are made inside this state.=0A=
+ */=0A=
+static int sit9531x_prg_enter(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,=0A=
+			       SIT9531X_DEBUG_UNLOCK_VAL);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
+			       SIT9531X_PRG_CMD_STATE);=0A=
+	if (rc) {=0A=
+		/*=0A=
+		 * The debug block is unlocked at this point, and a transfer=0A=
+		 * that reported an error may still have reached the part --=0A=
+		 * which would leave the device in PRG_CMD with its output=0A=
+		 * loops open.  Callers skip the commit when the entry=0A=
+		 * fails, so close both here.=0A=
+		 */=0A=
+		sit9531x_prg_abort(sitdev);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Commit a programming sequence started by sit9531x_prg_enter():=0A=
+ * update the NVM shadow and re-lock the loops.  The sleep gives the=0A=
+ * hardware its required settling time after the loop-lock command;=0A=
+ * it is intentional despite the caller holding multiop_lock, as the=0A=
+ * whole NVM + lock sequence must be atomic.=0A=
+ */=0A=
+static int sit9531x_prg_commit(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int rc, rc2 =3D 0, rc3;=0A=
+	u8 attempt;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
+			       SIT9531X_UPDATE_NVM);=0A=
+=0A=
+	/*=0A=
+	 * Issue the loop lock even if the update failed.  Callers reach=0A=
+	 * this function through a goto so that the chip never stays in=0A=
+	 * the PRG_CMD state with its loops open; returning early here=0A=
+	 * would defeat that and leave the outputs unlocked until the=0A=
+	 * next successful commit.=0A=
+	 */=0A=
+	/*=0A=
+	 * Re-lock the loops.  Leaving them open is worse than any other=0A=
+	 * failure this function can report, and nothing else closes them,=0A=
+	 * so retry as the priority table does with its own latch.=0A=
+	 */=0A=
+	for (attempt =3D 0; attempt < SIT9531X_LOOP_LOCK_TRIES; attempt++) {=0A=
+		rc2 =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
+					SIT9531X_LOOP_LOCK);=0A=
+		if (!rc2)=0A=
+			break;=0A=
+		usleep_range(1000, 2000);=0A=
+	}=0A=
+	if (rc2)=0A=
+		dev_err(sitdev->dev,=0A=
+			"output loops left unlocked after programming: %d\n",=0A=
+			rc2);=0A=
+=0A=
+	msleep(100);=0A=
+=0A=
+	/*=0A=
+	 * Put the output-system debug block back the way the device powers=0A=
+	 * up.  Its key register unlocks every debug register while it holds=0A=
+	 * the unlock value, and each programming sequence writes that value=0A=
+	 * itself, so nothing needs it left unlocked in between.=0A=
+	 */=0A=
+	rc3 =3D sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,=0A=
+				SIT9531X_DEBUG_LOCK_VAL);=0A=
+=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	return rc2 ? rc2 : rc3;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Input priority selection=0A=
  *=0A=
@@ -1013,6 +1134,11 @@ int sit9531x_input_prio_add(struct sit9531x_dev *sit=
dev, u8 pll_idx,=0A=
 	return sit9531x_prio_table_commit(sitdev, pll_idx, srcs);=0A=
 }=0A=
 =0A=
+/* Per-slot DIVO base register offsets (6 slots per page) */=0A=
+static const u8 clkout_odr_divn_base[] =3D {=0A=
+	0x14, 0x24, 0x34, 0x44, 0x54, 0x64=0A=
+};=0A=
+=0A=
 /* XO doubler register */=0A=
 #define SIT9531X_REG_XO2_GENERIC		SIT9531X_REG(0x00, 0x2D)=0A=
 #define SIT9531X_XO_DOUBLER_ENB_BIT		7   /* inverted: 0 =3D enabled */=0A=
@@ -1026,6 +1152,561 @@ int sit9531x_input_prio_add(struct sit9531x_dev *si=
tdev, u8 pll_idx,=0A=
 /* The output divider is a 34-bit field */=0A=
 #define SIT9531X_DIVO_MAX			GENMASK_ULL(33, 0)=0A=
 =0A=
+/*=0A=
+ * sit9531x_is_xo_doubler_enabled - check if Fref doubler is active=0A=
+ *=0A=
+ * Register 0x2D bit 7 is active-low: 0 =3D doubler enabled, 1 =3D disable=
d.=0A=
+ *=0A=
+ * Return: 1 if enabled, 0 if disabled, <0 on error=0A=
+ */=0A=
+static int sit9531x_is_xo_doubler_enabled(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	u8 val;=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_XO2_GENERIC, &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	return (~val >> SIT9531X_XO_DOUBLER_ENB_BIT) & 1u;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * DIVN as a fixed-point value: int_part plus fracn/fracd, carried with=0A=
+ * SIT9531X_DIVN_SCALE steps per unit.  The scale keeps a whole DIVN=0A=
+ * well inside s64 while resolving far below the parts-per-trillion the=0A=
+ * frequency offset is reported in.=0A=
+ */=0A=
+static s64 sit9531x_divn_fixed(u32 int_part, s64 fracn, u64 fracd)=0A=
+{=0A=
+	s64 whole =3D (s64)int_part * SIT9531X_DIVN_SCALE;=0A=
+	u64 frac;=0A=
+=0A=
+	if (!fracd)=0A=
+		return whole;=0A=
+=0A=
+	frac =3D mul_u64_u64_div_u64(abs(fracn), SIT9531X_DIVN_SCALE, fracd);=0A=
+=0A=
+	return fracn < 0 ? whole - (s64)frac : whole + (s64)frac;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_divn_static - read the configured DIVN of a PLL=0A=
+ * @sitdev:	device pointer=0A=
+ * @pll_idx:	PLL index (0-3)=0A=
+ * @divn:	result, fixed point as per sit9531x_divn_fixed()=0A=
+ *=0A=
+ * Reads PLL page regs 0x30 (integer part), 0x32-0x35 (numerator) and=0A=
+ * 0x38-0x3B (denominator).  The numerator is a two's complement 32-bit=0A=
+ * value, so DIVN can sit below the integer part, and the denominator=0A=
+ * register holds the divisor minus one.=0A=
+ *=0A=
+ * Return: 0 on success, <0 on error=0A=
+ */=0A=
+static int sit9531x_divn_static(struct sit9531x_dev *sitdev, u8 pll_idx,=
=0A=
+				s64 *divn)=0A=
+{=0A=
+	u32 int_part, fracn_raw =3D 0, fracd_raw =3D 0;=0A=
+	u64 fracd;=0A=
+	s64 fracn;=0A=
+	int rc, i;=0A=
+	u8 v;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DIVN_INT, &v);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	int_part =3D v;=0A=
+=0A=
+	for (i =3D 3; i >=3D 0; i--) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_DIVN_NUM + i, &v);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+		fracn_raw =3D (fracn_raw << 8) | v;=0A=
+	}=0A=
+=0A=
+	for (i =3D 3; i >=3D 0; i--) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_DIVN_DEN + i, &v);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+		fracd_raw =3D (fracd_raw << 8) | v;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * NUM/DEN is the fractional part of DIVN, so |NUM| is below DEN by=0A=
+	 * construction.  A pair that says otherwise did not come from a=0A=
+	 * programmed divider, and handing it on would divide by a=0A=
+	 * denominator small enough for the quotient to leave u64 -- which=0A=
+	 * is a divide-error exception on x86, not a value a caller could=0A=
+	 * reject.=0A=
+	 */=0A=
+	fracn =3D (s32)fracn_raw;=0A=
+	fracd =3D (u64)fracd_raw + 1;=0A=
+	if ((u64)abs(fracn) >=3D fracd)=0A=
+		return -ENODATA;=0A=
+=0A=
+	*divn =3D sit9531x_divn_fixed(int_part, fracn, fracd);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_get_fvco - read VCO frequency from chip's DIVN registers=0A=
+ *=0A=
+ * Fvco =3D Fref * DIVN, where DIVN comes from sit9531x_divn_static() and=
=0A=
+ * Fref =3D xtal_freq << doubler.  DIVN is the steady-state Fvco/Fref=0A=
+ * target programmed by the NVM blob and is authoritative in both=0A=
+ * free-run and sync modes.=0A=
+ *=0A=
+ * Return: 0 with *fvco set on success, -ENODATA when DIVN is not=0A=
+ * programmed (dormant PLL), or the register access error.  A bus=0A=
+ * failure is never folded into the -ENODATA case, so callers can fail=0A=
+ * a request instead of acting on a guessed rate.=0A=
+ */=0A=
+static int sit9531x_get_fvco(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			     u64 *fvco)=0A=
+{=0A=
+	u64 fref, fvco_min, fvco_max;=0A=
+	int doubler, rc;=0A=
+	s64 divn;=0A=
+=0A=
+	/*=0A=
+	 * DT board-config override: some configs (e.g. an INTSYNC PLL)=0A=
+	 * run a VCO that Fref*DIVN does not reproduce.  When the board=0A=
+	 * supplies the measured VCO, use it verbatim.=0A=
+	 */=0A=
+	if (pll_idx < SIT9531X_NUM_PLLS && sitdev->pll_fvco[pll_idx]) {=0A=
+		*fvco =3D sitdev->pll_fvco[pll_idx];=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	if (pll_idx =3D=3D 1 || pll_idx =3D=3D 3) {=0A=
+		/* PLLB, PLLD: high band */=0A=
+		fvco_min =3D SIT9531X_FVCO_HIGHBAND_MIN;=0A=
+		fvco_max =3D SIT9531X_FVCO_HIGHBAND_MAX;=0A=
+	} else {=0A=
+		/* PLLA, PLLC: low band */=0A=
+		fvco_min =3D SIT9531X_FVCO_LOWBAND_MIN;=0A=
+		fvco_max =3D SIT9531X_FVCO_LOWBAND_MAX;=0A=
+	}=0A=
+=0A=
+	rc =3D sit9531x_divn_static(sitdev, pll_idx, &divn);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	if (divn <=3D 0)=0A=
+		return -ENODATA;=0A=
+=0A=
+	doubler =3D sit9531x_is_xo_doubler_enabled(sitdev);=0A=
+	if (doubler < 0)=0A=
+		return doubler;=0A=
+=0A=
+	fref =3D (u64)sitdev->xtal_freq << doubler;=0A=
+=0A=
+	*fvco =3D mul_u64_u64_div_u64(fref, (u64)divn, SIT9531X_DIVN_SCALE);=0A=
+=0A=
+	/*=0A=
+	 * A DIVN of less than one whole cycle passes the check above and=0A=
+	 * still truncates the product to zero.  Callers divide by this, so=0A=
+	 * report the unprogrammed divider it describes rather than handing=0A=
+	 * back a zero denominator.=0A=
+	 */=0A=
+	if (!*fvco)=0A=
+		return -ENODATA;=0A=
+=0A=
+	/*=0A=
+	 * The bands bound what the VCO can physically run at, and a rate=0A=
+	 * derived from registers the loaded configuration may never have=0A=
+	 * programmed can fall outside them.  Clamp rather than refuse:=0A=
+	 * the readback is the only estimate available, and refusing would=0A=
+	 * make every output unprogrammable on such a part.  Clamping here=0A=
+	 * rather than in the divider calculation keeps the rate a frequency=0A=
+	 * get reports and the rate a frequency set divides the same one.=0A=
+	 */=0A=
+	if (*fvco < fvco_min)=0A=
+		*fvco =3D fvco_min;=0A=
+	else if (*fvco > fvco_max)=0A=
+		*fvco =3D fvco_max;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_phase_flush - flush the output phase of a PLL=0A=
+ *=0A=
+ * Fires the chip's on-demand phase-flush (PHFL) so every output divider=
=0A=
+ * of @pll_idx restarts aligned to the PLL phase.  Without it a rewritten=
=0A=
+ * DIVO keeps counting from an arbitrary point and the output edge lands=
=0A=
+ * with a persistent offset against the tracked reference (only a power=0A=
+ * cycle realigned it).=0A=
+ *=0A=
+ * The sequence mirrors the documented procedure: arm the on-demand PHFL a=
nd=0A=
+ * latch it with the PLL-page small-change update, then select the=0A=
+ * in-register phase trigger on Page 0 and pulse it.  The Page 0 trigger=
=0A=
+ * register is touched read-modify-write so the unrelated OEb bits are=0A=
+ * preserved.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static int sit9531x_output_phase_flush(struct sit9531x_dev *sitdev, u8 pll=
_idx)=0A=
+{=0A=
+	u8 ctrl, orig;=0A=
+	int rc, ret;=0A=
+=0A=
+	/* Arm the on-demand phase-flush on the PLL page. */=0A=
+	rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+				    SIT9531X_PLL_REG_PHFL_CTRL,=0A=
+				    SIT9531X_PLL_PHFL_ON_DEMAND_EN,=0A=
+				    SIT9531X_PLL_PHFL_ON_DEMAND_EN);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/*=0A=
+	 * Latch it with the PLL small-change update.  Written whole, like=0A=
+	 * every other issue of this directive: the register is a command=0A=
+	 * register, and a read-modify-write skips the write entirely when=0A=
+	 * the bit still reads back set from the previous command.=0A=
+	 */=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+				   SIT9531X_PLL_REG_SMALL_UPDATE,=0A=
+				   SIT9531X_SMALL_UPDATE_CMD);=0A=
+	if (rc)=0A=
+		goto disarm;=0A=
+=0A=
+	/*=0A=
+	 * Select the in-register phase trigger, preserving the OEb bits.=0A=
+	 * Remember the original register value (with the trigger de-asserted)=0A=
+	 * so the trigger-source select can be restored once the pulse has=0A=
+	 * fired.=0A=
+	 */=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, &ctrl);=0A=
+	if (rc)=0A=
+		goto disarm;=0A=
+=0A=
+	orig =3D ctrl & ~SIT9531X_DIVO_PHASE_TRIG;=0A=
+	ctrl =3D orig | SIT9531X_DIVO_PHASE_SEL_REG;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, ctrl);=0A=
+	if (rc)=0A=
+		goto disarm;=0A=
+=0A=
+	/*=0A=
+	 * Pulse the phase trigger.  No explicit delay is needed between the=0A=
+	 * set and clear writes: each I2C transaction takes far longer than=0A=
+	 * any minimum pulse width.=0A=
+	 */=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1,=0A=
+			       ctrl | SIT9531X_DIVO_PHASE_TRIG);=0A=
+=0A=
+	/*=0A=
+	 * Restore the original trigger-source select.  The pulse above has=0A=
+	 * already latched the flush, so a one-shot flush must not leave the=0A=
+	 * phase trigger permanently pinned to the in-register source.  This=0A=
+	 * runs even when the pulse write failed, otherwise a failed flush=0A=
+	 * would keep a hardware trigger source hijacked; the restore error=0A=
+	 * is only surfaced when it would not mask the pulse failure.=0A=
+	 */=0A=
+	ret =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, orig);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+disarm:=0A=
+	/*=0A=
+	 * Disarm the on-demand flush enable armed above.  Leaving it set=0A=
+	 * would let a later assertion of the restored trigger source=0A=
+	 * re-flush every output divider of this PLL, which is exactly the=0A=
+	 * persistent side effect the one-shot sequence must not have.=0A=
+	 */=0A=
+	ret =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+				     SIT9531X_PLL_REG_PHFL_CTRL,=0A=
+				     SIT9531X_PLL_PHFL_ON_DEMAND_EN, 0);=0A=
+	if (!ret)=0A=
+		ret =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+					    SIT9531X_PLL_REG_SMALL_UPDATE,=0A=
+					    SIT9531X_SMALL_UPDATE_CMD);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_divo_calc - work out an output's divider and its VCO=0A=
+ *=0A=
+ * Separated from the write so a caller that programs more than the=0A=
+ * divider in one sequence can compute the value before it enters the=0A=
+ * programming state.=0A=
+ */=0A=
+static int sit9531x_output_divo_calc(struct sit9531x_dev *sitdev, u8 out_i=
dx,=0A=
+				     u8 pll_idx, u64 frequency, u64 *fvco_out,=0A=
+				     u64 *divo_out)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u64 fvco, divo;=0A=
+	int rc;=0A=
+=0A=
+	if (out_idx >=3D info->num_outputs || pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	if (!frequency)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/*=0A=
+	 * The core validates the request against the supported ranges with=0A=
+	 * the value narrowed to u32 but hands the full u64 down, so a value=0A=
+	 * like U32_MAX + 1 Hz validates as 1 Hz.  Reject anything that does=0A=
+	 * not fit the narrowed width the validation actually covered.=0A=
+	 */=0A=
+	if (frequency > U32_MAX)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/*=0A=
+	 * sit9531x_get_fvco() returns the board override verbatim and a=0A=
+	 * register-derived rate clamped to the PLL's band, so a frequency=0A=
+	 * get and a frequency set divide the same number.  A VCO that=0A=
+	 * cannot be read fails the request: programming a divider from a=0A=
+	 * guessed rate would put the output far from what was asked for=0A=
+	 * while reporting success.=0A=
+	 */=0A=
+	rc =3D sit9531x_get_fvco(sitdev, pll_idx, &fvco);=0A=
+	if (rc)=0A=
+		return rc =3D=3D -ENODATA ? -ENODEV : rc;=0A=
+=0A=
+	/*=0A=
+	 * Round to nearest rather than down: flooring picks the worse of the=0A=
+	 * two adjacent dividers whenever the remainder is above half the=0A=
+	 * request.=0A=
+	 */=0A=
+	divo =3D div64_u64(fvco + frequency / 2, frequency);=0A=
+	if (!divo)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/*=0A=
+	 * DIVO is a 34-bit field.  With a band-clamped Fvco this cannot=0A=
+	 * overflow, but a DT Fvco override is taken verbatim, so guard the=0A=
+	 * field width rather than silently truncating the divider.=0A=
+	 */=0A=
+	if (divo > SIT9531X_DIVO_MAX)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/*=0A=
+	 * The output divider is an integer divider of the VCO, so the only=0A=
+	 * rates the part can make are Fvco/N.  An output pin that lists no=0A=
+	 * supported frequencies advertises a continuous range, because the=0A=
+	 * divisors cannot be enumerated ahead of a known Fvco, so a request=0A=
+	 * for a rate between two of them arrives here.  Refuse it: running=0A=
+	 * the output at the nearest divider instead and reporting success=0A=
+	 * would leave the pin several percent off what was asked for with=0A=
+	 * nothing saying so.=0A=
+	 */=0A=
+	if (div64_u64(fvco, divo) !=3D frequency) {=0A=
+		dev_dbg(sitdev->dev,=0A=
+			"out%u: %llu Hz is not Fvco/N (Fvco=3D%llu, nearest %llu Hz)\n",=0A=
+			out_idx, frequency, fvco, div64_u64(fvco, divo));=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	dev_dbg(sitdev->dev,=0A=
+		"out%u: Fvco=3D%llu freq=3D%llu DIVO=3D%llu (effective %llu Hz)\n",=0A=
+		out_idx, fvco, frequency, divo, div64_u64(fvco, divo));=0A=
+=0A=
+	*fvco_out =3D fvco;=0A=
+	*divo_out =3D divo;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_divo_write - write the five DIVO bytes of an output=0A=
+ *=0A=
+ * The caller must already be in the programming state.  Bytes written=0A=
+ * before a failure are put back, so the output keeps the divider it had=
=0A=
+ * rather than a mixture of the two.=0A=
+ */=0A=
+static int sit9531x_output_divo_write(struct sit9531x_dev *sitdev, u8 out_=
idx,=0A=
+				      u64 divo)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u8 slot, page, base_reg, divo_bytes[5], old_bytes[5], msb_old;=0A=
+	int rc, j, rb_rc;=0A=
+	u8 written =3D 0;=0A=
+=0A=
+	/* Map output index to physical slot */=0A=
+	slot =3D info->clkout_map[out_idx];=0A=
+=0A=
+	/* Determine page and per-page slot register */=0A=
+	if (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX)=0A=
+		page =3D SIT9531X_PAGE_OUTSYS1;=0A=
+	else=0A=
+		page =3D SIT9531X_PAGE_OUTSYS0;=0A=
+	base_reg =3D clkout_odr_divn_base[slot % 6];=0A=
+=0A=
+	divo_bytes[0] =3D (divo >>  0) & 0xFF;=0A=
+	divo_bytes[1] =3D (divo >>  8) & 0xFF;=0A=
+	divo_bytes[2] =3D (divo >> 16) & 0xFF;=0A=
+	divo_bytes[3] =3D (divo >> 24) & 0xFF;=0A=
+	divo_bytes[4] =3D (divo >> 32) & 0x03;  /* only bits [1:0] */=0A=
+=0A=
+	for (j =3D 0; j < 5; j++) {=0A=
+		rc =3D sit9531x_read_u8(sitdev,=0A=
+				      SIT9531X_REG(page, base_reg - j),=0A=
+				      &old_bytes[j]);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+	}=0A=
+=0A=
+	msb_old =3D old_bytes[4];=0A=
+	divo_bytes[4] |=3D msb_old & 0xFC;=0A=
+=0A=
+	for (j =3D 0; j < 5; j++) {=0A=
+		rc =3D sit9531x_write_u8(sitdev,=0A=
+				       SIT9531X_REG(page, base_reg - j),=0A=
+				       divo_bytes[j]);=0A=
+		if (rc)=0A=
+			goto rollback;=0A=
+		written++;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+=0A=
+rollback:=0A=
+	for (j =3D 0; j < written; j++) {=0A=
+		rb_rc =3D sit9531x_write_u8(sitdev,=0A=
+					  SIT9531X_REG(page, base_reg - j),=0A=
+					  old_bytes[j]);=0A=
+		if (rb_rc) {=0A=
+			dev_err(sitdev->dev,=0A=
+				"out%u: DIVO rollback failed (%d), the divider is part old and part ne=
w\n",=0A=
+				out_idx, rb_rc);=0A=
+			if (!rc)=0A=
+				rc =3D rb_rc;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			     u8 pll_idx, u64 frequency)=0A=
+{=0A=
+	u64 fvco, divo;=0A=
+	int rc, ret;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	rc =3D sit9531x_output_divo_calc(sitdev, out_idx, pll_idx, frequency,=0A=
+				       &fvco, &divo);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_prg_enter(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_output_divo_write(sitdev, out_idx, divo);=0A=
+	/*=0A=
+	 * Step 4: NVM update + loop lock.  Always run prg_commit() so the chip=
=0A=
+	 * leaves the PRG_CMD state with the output loops re-locked, even when a=
=0A=
+	 * write above failed; keep the first error to return.  It also carries=
=0A=
+	 * the required post-lock settling sleep.=0A=
+	 */=0A=
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/*=0A=
+	 * Step 5: flush the PLL's output phase so the new DIVO starts=0A=
+	 * aligned instead of keeping the arbitrary phase the divider=0A=
+	 * happened to be at.=0A=
+	 */=0A=
+	/*=0A=
+	 * The divider is committed by this point, so the part is already=0A=
+	 * running at the new rate.  A flush that fails leaves the output=0A=
+	 * divider on its old phase, which is a realignment that did not=0A=
+	 * happen rather than a rate that did not change -- and reporting a=0A=
+	 * failure would be doubly wrong, because the core asks for the=0A=
+	 * current rate first and would drop an identical retry.=0A=
+	 */=0A=
+	rc =3D sit9531x_output_phase_flush(sitdev, pll_idx);=0A=
+	if (rc) {=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "out%u: rate changed but the divider phase was not realigned (%d)\n",=
=0A=
+			 out_idx, rc);=0A=
+		rc =3D 0;=0A=
+	}=0A=
+=0A=
+	sitdev->out[out_idx].freq =3D div64_u64(fvco, divo);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_freq_get - read output clock frequency from hardware=0A=
+ * @out_idx:	output index (0-N for this chip variant)=0A=
+ * @frequency:	output frequency in Hz=0A=
+ *=0A=
+ * Reads the 34-bit DIVO divider back from the output system registers=0A=
+ * and computes the live output frequency as Fvco / DIVO.  This stays=0A=
+ * correct even when the divider was reprogrammed behind the driver's=0A=
+ * back (e.g. by a direct-I2C userspace tool), where the cached value=0A=
+ * would be stale.=0A=
+ *=0A=
+ * The cached output state is refreshed with the computed value.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, -ENODEV when the output divider or VCO rate=0A=
+ *	   is not resolvable, <0 on register access error=0A=
+ */=0A=
+int sit9531x_output_freq_get(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			     u64 *frequency)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u8 slot, page, base_reg, pll_idx, v;=0A=
+	u64 fvco, divo =3D 0;=0A=
+	int rc, j;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (out_idx >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	pll_idx =3D sitdev->out[out_idx].pll_idx;=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -ENODEV;=0A=
+=0A=
+	rc =3D sit9531x_get_fvco(sitdev, pll_idx, &fvco);=0A=
+	if (rc)=0A=
+		return rc =3D=3D -ENODATA ? -ENODEV : rc;=0A=
+=0A=
+	slot =3D info->clkout_map[out_idx];=0A=
+	if (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX)=0A=
+		page =3D SIT9531X_PAGE_OUTSYS1;=0A=
+	else=0A=
+		page =3D SIT9531X_PAGE_OUTSYS0;=0A=
+	base_reg =3D clkout_odr_divn_base[slot % 6];=0A=
+=0A=
+	for (j =3D 4; j >=3D 0; j--) {=0A=
+		rc =3D sit9531x_read_u8(sitdev,=0A=
+				      SIT9531X_REG(page, base_reg - j), &v);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+		if (j =3D=3D 4)=0A=
+			v &=3D 0x03;=0A=
+		divo =3D (divo << 8) | v;=0A=
+	}=0A=
+=0A=
+	if (!divo)=0A=
+		return -ENODEV;=0A=
+=0A=
+	*frequency =3D div64_u64(fvco, divo);=0A=
+	sitdev->out[out_idx].freq =3D *frequency;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Phase adjust (PRG_RST_DELAY register-based).=0A=
  *=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 2c5d0100b450..91b84b420011 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -255,6 +255,10 @@ int sit9531x_input_prio_add(struct sit9531x_dev *sitde=
v, u8 pll_idx,=0A=
 /* ---- Output enable/disable (Hi-Z control) ---- */=0A=
 =0A=
 /* ---- Output frequency ---- */=0A=
+int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			     u8 pll_idx, u64 frequency);=0A=
+int sit9531x_output_freq_get(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			     u64 *frequency);=0A=
 =0A=
 /* ---- Output phase adjust (PRG_RST_DELAY register-based) ---- */=0A=
 =0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index 56a8213dee07..9f0678ddfe0e 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -337,6 +337,28 @@ sit9531x_dpll_input_pin_direction_get(const struct dpl=
l_pin *pin,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_frequency_get - read input pin frequency=0A=
+ *=0A=
+ * returns cached frequency from DT or last set.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_frequency_get(const struct dpll_pin *pin,=0A=
+				      void *pin_priv,=0A=
+				      const struct dpll_device *dpll,=0A=
+				      void *dpll_priv, u64 *frequency,=0A=
+				      struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	const struct sit9531x_ref *ref;=0A=
+=0A=
+	ref =3D sit9531x_ref_state_get(sitdpll->dev, dpin->id);=0A=
+	*frequency =3D ref->freq;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_dpll_input_pin_state_on_dpll_get - get input pin DPLL state=0A=
  *=0A=
@@ -618,6 +640,7 @@ sit9531x_dpll_input_pin_prio_set(const struct dpll_pin =
*pin, void *pin_priv,=0A=
 =0A=
 static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.frequency_get		=3D sit9531x_dpll_input_pin_frequency_get,=0A=
 	.state_on_dpll_get	=3D sit9531x_dpll_input_pin_state_on_dpll_get,=0A=
 	.state_on_dpll_set	=3D sit9531x_dpll_input_pin_state_on_dpll_set,=0A=
 	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
@@ -676,6 +699,7 @@ sit9531x_dpll_xo_pin_state_on_dpll_get(const struct dpl=
l_pin *pin,=0A=
 =0A=
 static const struct dpll_pin_ops sit9531x_dpll_xo_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.frequency_get		=3D sit9531x_dpll_input_pin_frequency_get,=0A=
 	.state_on_dpll_get	=3D sit9531x_dpll_xo_pin_state_on_dpll_get,=0A=
 };=0A=
 =0A=
@@ -691,8 +715,78 @@ sit9531x_dpll_output_pin_direction_get(const struct dp=
ll_pin *pin,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_frequency_get - read output pin frequency=0A=
+ *=0A=
+ * Reads the DIVO divider back from the chip and computes the live=0A=
+ * frequency as Fvco / DIVO.  Falls back to the cached value only when=0A=
+ * the output is not resolvable through the divider chain (e.g. not=0A=
+ * mapped to a PLL), so transport/register errors still surface.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_frequency_get(const struct dpll_pin *pin,=0A=
+				       void *pin_priv,=0A=
+				       const struct dpll_device *dpll,=0A=
+				       void *dpll_priv, u64 *frequency,=0A=
+				       struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_output_freq_get(sitdev, dpin->id, frequency);=0A=
+	if (rc =3D=3D -ENODEV)=0A=
+		*frequency =3D sit9531x_out_state_get(sitdev, dpin->id)->freq;=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return rc =3D=3D -ENODEV ? 0 : rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_frequency_set - set output pin frequency=0A=
+ *=0A=
+ * computes DIVO =3D Fvco / frequency and writes the=0A=
+ * 34-bit output divider to the output system registers via=0A=
+ * sit9531x_output_freq_set().=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_frequency_set(const struct dpll_pin *pin,=0A=
+				       void *pin_priv,=0A=
+				       const struct dpll_device *dpll,=0A=
+				       void *dpll_priv, u64 frequency,=0A=
+				       struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	u8 actual_pll;=0A=
+	int rc;=0A=
+=0A=
+	/*=0A=
+	 * Read the PLL that drives this output from its OUT_MAP state=0A=
+	 * (populated by out_state_fetch from the chip's OUT_MAP registers).=0A=
+	 * That is the index the output register programming below is keyed=0A=
+	 * by; the output is registered under the DPLL matching this PLL.=0A=
+	 */=0A=
+	actual_pll =3D sitdev->out[dpin->id].pll_idx;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_output_freq_set(sitdev, dpin->id, actual_pll,=0A=
+				      frequency);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc)=0A=
+		NL_SET_ERR_MSG(extack, "Output frequency set failed");=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_output_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_output_pin_direction_get,=0A=
+	.frequency_get		=3D sit9531x_dpll_output_pin_frequency_get,=0A=
+	.frequency_set		=3D sit9531x_dpll_output_pin_frequency_set,=0A=
 };=0A=
 =0A=
 const struct dpll_pin_ops *=0A=
diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c=0A=
index 4c6a2249300f..8270b8ee91be 100644=0A=
--- a/drivers/dpll/sit9531x/prop.c=0A=
+++ b/drivers/dpll/sit9531x/prop.c=0A=
@@ -295,16 +295,34 @@ sit9531x_pin_props_get(struct sit9531x_dev *sitdev,=
=0A=
 	}=0A=
 =0A=
 	/*=0A=
-	 * Seed the runtime ref->freq / out->freq with the first DT-listed=0A=
-	 * supported frequency so the netlink frequency_get callback reports=0A=
-	 * a sane initial value before any pin_set occurs.  DT lists the=0A=
-	 * physically-wired reference frequency for each input pin and the=0A=
-	 * default output frequency for each output pin.=0A=
+	 * Seed the runtime ref->freq with the first DT-listed supported=0A=
+	 * frequency: an input's rate is a board fact the device cannot be=0A=
+	 * asked for, so firmware is the only source.  An output is left to=0A=
+	 * the read-back below, which knows what the divider is actually=0A=
+	 * doing.=0A=
 	 */=0A=
-	if (num_freqs > 0) {=0A=
-		if (dir !=3D DPLL_PIN_DIRECTION_INPUT ||=0A=
-		    index !=3D SIT9531X_MAX_INPUTS)=0A=
-			curr_freq =3D freqs[0];=0A=
+	if (num_freqs > 0 && dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+	    index !=3D SIT9531X_MAX_INPUTS)=0A=
+		curr_freq =3D freqs[0];=0A=
+=0A=
+	/*=0A=
+	 * An output's current rate is the one its divider produces, so read=0A=
+	 * it rather than assume the first entry of a list of the rates the=0A=
+	 * board supports is the one in force.  A rate taken from firmware=0A=
+	 * that the part is not running would be reported as current and,=0A=
+	 * worse, used as the output period the phase adjust quantizes=0A=
+	 * against.  An output the configuration does not route has no rate=0A=
+	 * to read, which is not an error.=0A=
+	 */=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
+	    index < sitdev->info->num_outputs) {=0A=
+		u64 hw_freq;=0A=
+=0A=
+		mutex_lock(&sitdev->multiop_lock);=0A=
+		rc =3D sit9531x_output_freq_get(sitdev, index, &hw_freq);=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		if (!rc)=0A=
+			curr_freq =3D hw_freq;=0A=
 	}=0A=
 =0A=
 skip_fwnode_props:=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index 4d8eb3ceac9f..8ce048e9c8f1 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -192,6 +192,7 @@=0A=
 /* Debug register (same offset, per-page) */=0A=
 #define SIT9531X_REG_OUTSYS_DEBUG		SIT9531X_REG(0x03, 0xBD)=0A=
 #define SIT9531X_DEBUG_UNLOCK_VAL		0xC3=0A=
+#define SIT9531X_DEBUG_LOCK_VAL			0x00=0A=
 =0A=
 /*=0A=
  * On-demand phase-flush fired from a register rather than a GPIO pin.=0A=
@@ -206,6 +207,10 @@=0A=
 /* ---- PLL page registers (apply to pages 0x0A-0x0D) ---- */=0A=
 #define SIT9531X_PLL_REG_SMALL_UPDATE	0x0F=0A=
 =0A=
+/* On-demand phase-flush enable (PLL page reg 0x3D bit 7) */=0A=
+#define SIT9531X_PLL_REG_PHFL_CTRL	0x3D=0A=
+#define SIT9531X_PLL_PHFL_ON_DEMAND_EN	BIT(7)=0A=
+=0A=
 /*=0A=
  * Loop-filter coefficients on PLL_PAGE regs 0x10-0x15 (3 normal +=0A=
  * 3 fast-lock) are GUI/NVM-generated by the timing configurator and must =
not be=0A=
@@ -217,6 +222,18 @@=0A=
 #define SIT9531X_PLL_REG_OUT_MAP_LO		0x28=0A=
 #define SIT9531X_PLL_REG_STATUS		0x31=0A=
 =0A=
+/* DIVN registers (free-run divider readback) */=0A=
+#define SIT9531X_PLL_REG_DIVN_INT		0x30=0A=
+#define SIT9531X_PLL_REG_DIVN_NUM		0x32  /* 4 bytes (0x32-0x35) */=0A=
+#define SIT9531X_PLL_REG_DIVN_DEN		0x38  /* 4 bytes (0x38-0x3B) */=0A=
+=0A=
+/*=0A=
+ * DIVN carried as fixed point, and the unit the DPLL ABI wants the=0A=
+ * fractional frequency offset in.  Equal in value, distinct in meaning.=
=0A=
+ */=0A=
+#define SIT9531X_DIVN_SCALE		1000000000000ULL=0A=
+#define SIT9531X_PPT_PER_UNIT		1000000000000ULL=0A=
+=0A=
 #define SIT9531X_PLL_REG_ACTIVE		0x02=0A=
 #define SIT9531X_PLL_ACTIVE_BIT		BIT(0)  /* PLL reached active state */=0A=
 =0A=
-- =0A=
2.43.0=0A=
=0A=
