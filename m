Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B804A9D66;
	Wed, 30 Sep 2026 23:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811443; cv=fail; b=ivdMUcNeRl7Z7S/ZBXkobUDr7uPhkz+TdajfK2mD/NMWMN/xKP17Vh3XvmQX0zGP2HhNXIm4PVEnaGWOEoyBWyuxKlcYTr1mnrj5t4Ni3COY1gCS5/I5ab25YmsxPRkSj0UpEwm17uvfClCPGYSI79JVqIgya5RbL+/qkoHCo7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811443; c=relaxed/simple;
	bh=XUySC8Upr/OJJvuViI3CMhkt/XYn32LwEeUQgRKRJvY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kPKOD36D126Jr3IF8JpPo04PtHSoA+1wn3nn4qeibsKRxKVERzQR5Ko4jCfw5PEW0xh+lAx4B+XCd/BY4oPMPwGBBU/YkshfJ7YNdBSYp5/DkNDsSfSDoNDs18sRns0+M4px5N4Xux2ztZREWIjbeBnA3ui10KWwK8yoG7UrOeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=FyRyeVrB; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=F77gRXc8; arc=fail smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="FyRyeVrB";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="F77gRXc8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=D5JG5O7v7dOS4TuCbvpZuVsAnRyOI3+fR3Ln6Lpmou0=;
 b=FyRyeVrBFJC6hGF5/bThmj+SNFcSRLcZf1Sxd5xz9GuZn13goo5IdForaHxNCyumQHaqn86F1MkJoKV5csOG273r7OILXScS/G6o4lbmWUZQLux5crPZKYramzW92iggJ6S2Pq8nPPVwumIGf1SMOJElFg7LuEOVX91WuvqLcGadhJPg39k+J++bDtKX59HJ650D/mD+XyKfdpXSdH8iqH6cCUfyQ6q6GSw1FDGHz9pLkOjnLs1etVHpfsG7lmhOpX2Rj648V9loE3jhvACgp0a8B2+v2pVgAxbpE8SNF2gr6rQplofae350RWuyvQRzgMTiJwdD3/rAzr2E+SzDQQ==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020134.outbound.protection.outlook.com [52.101.56.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 19D13100067;
	Wed, 30 Sep 2026 23:37:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuHJTzw+ip3zBhw3N3E2cb8Ubw8k9MYrxSAa1o1ZRYH4cuUshWoEcddsrIFCfvMmOs3lwznJu5eu4lXxf4mYeqG3u9Z9Vph/Tj2G5vC9i6Id1/8b1AImuXdeKVS5/OUwK+FvLEaD9Pf2tfOONFIyoc0SCsw9FMMcYZvd2SiP6e7u9GfsLcHWKA0xH8epttXfNFoQBRAL2wdIfiRorIjBY1F63XPbbSfYFaLk535ge7n0qdMVCwTz6xkP7/I37nGiCLeR/1geU5vM3fyITef35bBETTCQroLMJeOL6CnrBPQ/xw/hydTBJ8GbbrD2gf6Q+OK5cF/vGlSw6EMF/5Wd3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5JG5O7v7dOS4TuCbvpZuVsAnRyOI3+fR3Ln6Lpmou0=;
 b=nXG5TrBQdumqmcelffd4mwLDjyF6//g4QXroWQwYQgQmsG6cM3vetrT5inmIlER6XaCYDVC44tROTttJIqDE4Kt8E4sO70uLwFHpwdtL8Row4WjCHu+ioZ1FwL6vuOcmP6JmBCj/nXPs2vDUQOzdbpmAzbU3/Eu8+oSomCKQxKLsdwIcUM4bRP1V84yjIml1G2PnwzvFeGPx6XO0ACUzOZFcXhQGeB/QJZoIC4sO0p88XnxONmdgLmvHyje5YprW9adHTfnO/QqLcZoGHVHDMf8Beel1CSQ0rWeB4g4L6R/GiUoLtpaT5ck1dALksC95Qad0eaw6SIyeOdcB3+5F/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5JG5O7v7dOS4TuCbvpZuVsAnRyOI3+fR3Ln6Lpmou0=;
 b=F77gRXc8Ab05o29gv1m2c2+juELHGdYqJO5MjrBA1spQ2uukm9j4VDFTQnMVWGSpopsaXLNKITLeR4FPMtZfV33ROsX8gaSTBxOVL/2Hxsx6Msvu33XQF/ZD22l4vPnuGWR7J3SIeGhIhiGVYjphAGatF3JYZYL4NJACDN02pghBxHpeWCqULY2VdIlGJ7Q82UcU2M0s8BwuFTefSGo2lF6dzL+sH0PMzJ6iNfTJMyCSATe4hpxa2K0RnTwoSAhJxs4krgjJExKfbt2Jg/ufMaBH8uSHR4it6B25UQZ+BBXqcymw7LsCJcEA3mTKelSHgAknyyl12UoP/0lZyovlRA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by BL3PR20MB6748.namprd20.prod.outlook.com
 (2603:10b6:208:3bf::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 23:37:17 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 23:37:17 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "Oleg.Zadorozhnyi@devoxsoftware.com"
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v11 03/13] dt-bindings: dpll: add SiTime SiT95316
 clock generator
Thread-Topic: [PATCH net-next v11 03/13] dt-bindings: dpll: add SiTime
 SiT95316 clock generator
Thread-Index: AQHdUTShUiqVpM3oXk2TUznUAYFs+A==
Date: Wed, 30 Sep 2026 23:37:17 +0000
Message-ID: <20260930233714.87679-4-arouhi@sitime.com>
References: <20260930233714.87679-1-arouhi@sitime.com>
In-Reply-To: <20260930233714.87679-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|BL3PR20MB6748:EE_
x-ms-office365-filtering-correlation-id: 67289db5-16b5-4800-963d-08df1f4bc3b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|38070700021|3023799007|6133799003|10067099003|56012099006|5023799004;
x-microsoft-antispam-message-info:
 440mwg2X4wvVvpWNAgBPYRdaOSXUDvB5/2BLSAp706gshGbHBctP7fsdkL9bvEA2ndvLCQJ/kTyfccRdZZKBguzD4PliSFc8uwGVdGkVMplpK7subJb7VkGiGWoy4MkcV0dErokMiI2sIhyUgQsSO3ZoBe3u72Oe+inFFuN6QOEwxjk1eJKg8WveEjWE8ckZfEtF998Lhdi2xclTtglcBasvfOcBkVj86wRIlEbLd4zGcuRU8YX6JFtVKO8+bkBp3JBEQLve8oIYroWr7U/wTFU3nD1ScMWUlDjHj/Z0RzlFoxTK+ytrTQnxSsKjM3F7is5aapcJ61hW8EOnOgJOmyve3PTcv0Tu/UWIS5IlbqGJhZGidA6OWg74SbLkEyVwoKFBDEYMbf79DRQroRpnMFIkCQTZ3cLZRvB40Pd6i1R6Md8W9JuWa3H9YL4uKHgF/UQczHND114JtkZtybN5tXmOs5tlUqIbLARaDieQjqXHNCNsGfAd7gvMOLa0DM14xSgKdc1JVMGE7fr3fbAf9PZTKHX5QVcGOFmkcd0FI4+iPQ/ieOn2760qKVC5uVE5Hc+3sPT+N9eXj7sKB+jkMgdBfxS5op+2GfmCdJF694Hyb+Wa9a5RMmuKd9LZyAnVeKN2I7c4c7IAJZlrTMUIiolMbeSCyB3xp7dNlAnuPh0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(3023799007)(6133799003)(10067099003)(56012099006)(5023799004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vNFgIl4jLAyteCnLjx3tOJ+sairFCohOnL1HQ34cEwRlGws6xJttiAO1ds?=
 =?iso-8859-1?Q?/HEw7mhqn0pzR2ZVh4oz1BcRdot9oMqqxlNYDHJaLgMu27Xr7GlkMxuw/5?=
 =?iso-8859-1?Q?5NfDkjfz2wVJAJNXCDoBM1oLY5TYIXxHDyiFeNw7qhTc7JqjaFrpLerJJN?=
 =?iso-8859-1?Q?0gWg65Z0ahyJBlaSJl6XDNrmBYl0L9Ksppz3ww80HPYIihRFJLeLv+Tc06?=
 =?iso-8859-1?Q?M7ePRDOXMg56uquYL1F6K6/WeYq2eCgUfA5nw+18ZeASucYH3FMAw1Dt4c?=
 =?iso-8859-1?Q?dJjwhlzRe7Q1K6FSzoQk4agBnC4QVbY4nr5+/sHrNsh9FFOh9X4I9duGV8?=
 =?iso-8859-1?Q?vNJiyWXWrbyFwgJaUcsujchsKUb9L2qBSIh9a4JPQdXyRbfFNCN0bnwc3y?=
 =?iso-8859-1?Q?gVfT+wrwme3KYOQIVkBFKqj8SKFqfHD3bkeaHN4WjKJoUaCdr60qKo5wkC?=
 =?iso-8859-1?Q?rsI2XyDoxl8nZLp4e23yk+2fGjzoetLXldMb1I64IwBRdQzQlPoRyiGwCy?=
 =?iso-8859-1?Q?uRwN7hXghdqrp5s7TAOoEivpAFLqvtTQO2k/vWOd8bPZ03SbKfZiTLKbMb?=
 =?iso-8859-1?Q?PVBeg+bg2/3DB5ZT7H43/V86tJCeG+JzwP2I+uOTKPkt3e2O5mQ27kOEVt?=
 =?iso-8859-1?Q?7S23koHbkj803RmFCaicLMV2DllV7fct3/yctozo5VQ3g1dCQrHhicfc51?=
 =?iso-8859-1?Q?QlnOgPz9rqB0TB0lPrR/Vw9HiRKhLA01uAI5Vs8CaY4zOmd81QRjzBtq7G?=
 =?iso-8859-1?Q?LRwKR8PxWWSW8wULR7qcUn4TsKHohFq9IPjUZ3XtVzocnmLM1Ye+HLe1Bk?=
 =?iso-8859-1?Q?K6JZ08Pr9M2E58U+Qer/4Si3x1iL4r4pQsQpsAV5J0cXs89KQ/B5wMcAja?=
 =?iso-8859-1?Q?21fFgeyX71eqne1lHMMf98hE4f3C++qVO0I9T6WXFnuMbkgpF7J13SfbuC?=
 =?iso-8859-1?Q?XjgmK9rMXPYBA3ba3mPxP19eNnRnZNXJYBijqkLbw1kjQ5j9tM9bgzLXEQ?=
 =?iso-8859-1?Q?DW0kZgupEu4NtlpaXkELGQjB55/F039KjflDvkQ+lrENPg/V2upTYm9sLd?=
 =?iso-8859-1?Q?ZAtuk34m4uVFGradIpg591HE47yXqawzpV9lFcWk3dVnMwrOmFDKnOCMHI?=
 =?iso-8859-1?Q?Dtnka0IybfoNWd9juGFuOo5m9UnGN1vdEpNc/ed0KC3lXLP/Rz2IBzGIIs?=
 =?iso-8859-1?Q?DB7Y+yF+57OzS22Q37H8l8GZ6r/xruHgoDBmSV4zhQMuvrfzsJBsLXRIg1?=
 =?iso-8859-1?Q?xoI/rnJbwCfCSkVV4+c+wP27JZBHlHIFcmzfzO4L9UwBkB0r8uM9WNkMjv?=
 =?iso-8859-1?Q?RTLX554krBT/tJnnlyo0YRBWeuo2l2eS+1V8JcxvRVU/94tbZj8V4ZKw4M?=
 =?iso-8859-1?Q?lM+ZqXDlsLGVJIhFWQVBK4V/zXuHr2MjMellsq3fsHCk8JHbZwf+62zf1V?=
 =?iso-8859-1?Q?XxKG2wmjI5daD9sYEUqjPr+/XEMzLZQJE2b+AbfFlbon0VkKkk4/tgebcF?=
 =?iso-8859-1?Q?Mzc74eFMjnWQwd7ki9DRmaBZjMdjAmS4wmccmVfhmhGAVIND9RJiL/FL08?=
 =?iso-8859-1?Q?tkCiWpKnlLWHgi0RHo/29wFBxbThbcjd8/8AWxO/3sA3iajZruV4frNJOG?=
 =?iso-8859-1?Q?wKKRwOiHgIOXC9ol0vTbj88b4ubHtFKfR2dpei/v/7j1cQ3LPj4+r/C3Ho?=
 =?iso-8859-1?Q?+WoNae6ZIkYg218x9cwSPS6H+PWkZHtycXuLgUV8s1VSbeFG2p3Hox2zxd?=
 =?iso-8859-1?Q?kmv7MQ8JyxVmQa0qB072A+9In2PIkWkHY4KKYJWEvYKpn9?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	XOPaq3Iz1dsImSpfiX86W+cjYf5S5HGr8QkUlpedgsmFPoD/5dpJNwb/Xq3ScutaJ0/wg6h+xCOYTSY2ZhXJiShKNnlYh28JWZhuY4E6gNqYBd5OBjajb4TYBofGqX+3DIrBkMhazbX5VoAsFjULQTHTJU2MQc5V0K+RMJQduRdiPZAhNNXcXlMuAcdA455riBNZGaK0y2B+a5nmY3TuKRXMWy6SdWTRhPcAgdoDalO/r1WO3dMalzlyazB4vb2JHk2H89iJK1u3SuQRtVEHoO+16yb8VwdhBlVNU5BnyoHMehCaDyQvaEe/Hh/xyYLwf3LE9C7ttsiz2q8ap8Ka5g==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67289db5-16b5-4800-963d-08df1f4bc3b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 23:37:17.5883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bwJ9W4E1ZXiQNMj8A4ZMWUq+mwze8IowIgvlr47uCBLUndfcTKU2VgdMqd2gacoh8qV2GjGG8FEvHJ/NQSji/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR20MB6748
X-MDID: 1790811440-mbnXpQCyEOHx
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1790811440;mbnXpQCyEOHx;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

Add a binding for the SiTime SiT9531x family of clock generators: an=0A=
I2C-controlled device with four independent PLLs, up to eight input=0A=
clocks and up to twelve outputs, described as a DPLL provider.=0A=
=0A=
The XO is given either as a clock or, for firmware that describes the=0A=
oscillator as a property rather than as a clock provider, such as ACPI,=0A=
as clock-frequency.=0A=
=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 .../bindings/dpll/sitime,sit95316.yaml        | 175 ++++++++++++++++++=0A=
 MAINTAINERS                                   |   6 +=0A=
 2 files changed, 181 insertions(+)=0A=
 create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit95316.=
yaml=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml b/=
Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml=0A=
new file mode 100644=0A=
index 000000000000..997b410e8f52=0A=
--- /dev/null=0A=
+++ b/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml=0A=
@@ -0,0 +1,175 @@=0A=
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
+  input-pins:=0A=
+    type: object=0A=
+    patternProperties:=0A=
+      "^pin@[0-9a-f]+$":=0A=
+        type: object=0A=
+        properties:=0A=
+          reg:=0A=
+            maximum: 7=0A=
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
+    else:=0A=
+      properties:=0A=
+        output-pins:=0A=
+          patternProperties:=0A=
+            "^pin@[0-9a-f]+$":=0A=
+              properties:=0A=
+                reg:=0A=
+                  maximum: 11=0A=
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
index cae5962045dd..b4a901e65bfd 100644=0A=
--- a/MAINTAINERS=0A=
+++ b/MAINTAINERS=0A=
@@ -25151,6 +25151,12 @@ S:	Maintained=0A=
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
2.43.0=0A=
=0A=
