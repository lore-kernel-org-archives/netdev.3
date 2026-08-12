Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A30483BC0;
	Wed, 12 Aug 2026 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786557354; cv=fail; b=IcntBmAd1Ff8GAlHuppaPAgVpd/ilVO2XMJnjAB3qBRBnR2eYQp5FPLqeVY5kzdJNdIAoDRaDxi31fGDbeBOXziPNmzgNHH0JgM+hpiPxRxSK+6IcJMq5vvWOKAqyL93C2oGc5KShDJ8cVUydmMbTn7PwJ+FndxGlNiTMb/Ugnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786557354; c=relaxed/simple;
	bh=564jgdN5dieO/xxak7unwamPHGdus2q07dNAtxXRaiM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=swtM896LiAqZ1wmOsNm2eCadLLAKR4mja2m7GIyeEOWR9WSsFFMx8DxHFF1uLAKpa2utW5zwdVWc2KrILyPOqwSu7hKQ3aYG9XComp9+DgpsAqRN7emxwcMeykd68qTAA60c7M7nR9DEV51wSN1HBC2A5ggRRyso9I2b4dYVU3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=XOW7gHKR; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=Xxr3VNlx; arc=fail smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="XOW7gHKR";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="Xxr3VNlx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=E1VjNok8SmsDxzfEyhIyNC2KramG8DJTd8gffIjDCvA=;
 b=XOW7gHKRaNhYlIuZtCnzr7SpPhaQPBrnAW5ZuxJunAEOoDw2Ta3IoQW0Jqe1Q+NSj2twhKmlT7pMarsTdePEF9kYhPSk/0Psq+OIkPdkwh3ouqJDKWQ9I9fam3skL8fwjfFr2Z7hs/yJPoKkxseb5N9q77jHyofM1PnPiocxkaLV+tIYYguKQ6rmv4/S2RWy8yvkPflyu9Dz/nciPmHldWeZCH1xUqwQp3VStRQw2dlNvEXR9Gt+oLvsQrrBv1NcVwOzGKLhHWeQ0nv4ZDxzw7p0gimaZv53UZRlyf8Z4Jh2l72HZNM0fmcy0qMDR6yr7qYhJ+oNzw0LP9eUzoYleQ==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020110.outbound.protection.outlook.com [52.101.56.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id AE595340071;
	Wed, 12 Aug 2026 17:55:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x27guTclkh918IoWlaFkJTTTFGNHBZY9ZssW3zDr9TLhTUlwAyfYFwHFm+uICqfM5s4xC4MvGA2pA4pHigmsUVHZFCFcNaWNhedmWxAprbMEqlvWTuzDKgoyfi8R9BAJeTG+Zgr4iqe9BDkXJfR+gFyRe4YxsXIAxbVdmKaufsp32ugDJZR+RmIffOfZTSHlOV6wrUtbrgdoYcFMyX8xsiGW6A9xj1OL6u8AvCly5hgJjE4O+vrwosHjubQymT4hZCZofHg4tNL5ye0f+LWup6/e50AFI9Sst0Tw1ir4byRKXfGwW+2oSYUZ/1xzuumYhCF/AT6lG/od9N0O2JHi/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1VjNok8SmsDxzfEyhIyNC2KramG8DJTd8gffIjDCvA=;
 b=eO9l+HcIEzPNOF7yFEE6alCFzuJ15PPjyYDqd6hVU41aHxTRdBscpJcIokTQSvD2cZm71p9e0rQYkyqnxGm5dghRtLS9glotxfEXZv6B639nCOIK69fzt4X3Mkr6GFQFst+6hnpyR+85k1D8gXuCVi+F9oi60vwPTbFnQaRXB3qP3soVlbHwdn+FqIeLXpjIk1JdLagGnIOFPSSbFl8zWsn7iHpj3ahKQi+qWKxhEEpvfhInefYu6uTvh2tX/TndpPIUBKzITg1jI8qWcw86AwwJ/JlksiKBmGqKg/d7kcAyo7iCHGLGo71ovtHnNdejvnc+vQBsw6B7PZ04xWX31w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1VjNok8SmsDxzfEyhIyNC2KramG8DJTd8gffIjDCvA=;
 b=Xxr3VNlxXXKgGF094yN5dLQnNZOFBo8w9yzV5gb29GSi/VhGlvljgZcWTNnGDIRgb8Y0hvUCBAwuUFY8jSHXPbFZZ04h4KYn7paSINUGXtv2vBcFjnbdFb3kimE+aGTXS9qapnd5pR1GUjZ9OMFwSq8hyDYiELo26gotNn7cKXGJzWc1dQ5Is3CnKvz41p6nfX0+Zuv4A7z1wcHLrJd/kV5hX1qgpqcm/q63ACSIo4XrWZJg+yZPDaimNOM38Bb8Mgb21dDbFD5w8PRq0jV5unIzeawJUF2dhd+8V2B13zN8kjw74YQNq4GJGCL6FnAnJHlsHcxmGnEEBn7RKtmpug==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DM6PR20MB3282.namprd20.prod.outlook.com
 (2603:10b6:5:2a1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 17:55:26 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0315.008; Wed, 12 Aug 2026
 17:55:26 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"cjubran@nvidia.com" <cjubran@nvidia.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ali Rouhi
	<arouhi@sitime.com>
Subject: [PATCH net-next v6 3/3] dpll: add SiTime SiT9531x DPLL clock driver
Thread-Topic: [PATCH net-next v6 3/3] dpll: add SiTime SiT9531x DPLL clock
 driver
Thread-Index: AQHdKoPBzoB8WJzpgk2RJxANoCwigQ==
Date: Wed, 12 Aug 2026 17:55:26 +0000
Message-ID: <20260812175337.18155-4-arouhi@sitime.com>
References: <20260812175337.18155-1-arouhi@sitime.com>
In-Reply-To: <20260812175337.18155-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|DM6PR20MB3282:EE_
x-ms-office365-filtering-correlation-id: 778e971e-862c-4689-30a6-08def89ae3e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|38070700021|6133799003|3023799007|10067099003|56012099006|5023799004|18002099003|22082099003;
x-microsoft-antispam-message-info:
 ygHtxE8jqSDnuFzcsCDbZqIYhC07qlyMDONSTQH43Hu3mA0WEhpApUdCNPBU3oQB3Ti5PEedllb5cRSzGr2zD2RTJcdwBdfAMMGEpOG+iT0bsZww2MGiOaA1lIKGX5JXPIBWeSGpud682b1YICW3b0yqkXTLq9h7GGKeXRxhefOvathDUkcL0d8ejUFt689dDs7LnsFWWnWm/WQkHvqdJC4r0YGhfWDDwdDn713yFZ8UFv0IwQY4C8dOucToBIPUNXsifKvtxcrKm/NOivyzQ001mpv55fZGAemgMY9buF+7vt7/ZxMvzbwNAKorjIC1uJAEGTsUHuMYc6F7EcBVl3BoBDkY4uJhFjDqEnoaBpVLnXNBsSmyMtFmFXWVDbTgihwbyUH6v1F4zcjeYD+Am9u7WMoJlTa49ZQnD7G78GQdpxLz3y+U5Ji2ZZs4MUtqqXUNz2wgXRgakhoFgAU3etQHI9EQ8YvQVRZN1YJAImToJetlfIOsCJBVGixYs++oqKtVeV3FH0ZxQ++vdr0xWKOv7k8bLdls7sActFsfXf2eJdBlwNwaNUaMq12bl5AhRWNHzVQvO+AE3fYv2y43uGwtsh+v4YcTcmOikP+bbqhwhRSMaM0pNZmKGYxGkTFXVOQFDytsXFxCGm3CIydcYlTlHPTioy/d7FTScwFOo5c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(6133799003)(3023799007)(10067099003)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?cYn7rv0DTeZ8ih5za9P5SjnXvcnEY5y84EjR+9/lXv7/Ygw9RQaSDIVqp4?=
 =?iso-8859-1?Q?mzRwCbBtit+hQerzXR61dMn+RdS8Wmd8FeyA21Sqn2UacFAB3UEpai8pXL?=
 =?iso-8859-1?Q?I8NsK9lVi6LLKwTeskkM9zSbFs0cSwhcznHf5RWh/Cb514PufqSBJyp+SQ?=
 =?iso-8859-1?Q?Dt0kL+F4aSBUubMyezQTlqVu0lRJUEd2YAR7+2yTTUBUNV4eKbgn2MBvgh?=
 =?iso-8859-1?Q?If1CV+6veOTy425Wm/4M9FsQtmt9+cyI6lHC2gPkGkCvrd9X7HGLEsRqUX?=
 =?iso-8859-1?Q?+koFdBOLZvSxbekZnDyg5Xv3mOOSmOZF5AF0o8M0Jt/C5xNWXciShwbg/X?=
 =?iso-8859-1?Q?8ngMopx+4k9I+NY9MTaNrmvxFuq7mghqRhiadIndVtVks7lewvyDjWdCe2?=
 =?iso-8859-1?Q?sgblMAVW6XnLCIdqsZzxx3ycy84U4+5R/vrRTTAWmrReB0riMRA6lULMx/?=
 =?iso-8859-1?Q?Ko3F3IcALr41kw6yOJTls5c5Ij4DgNf6Un/Mvq2j7XnwKwjA4x2gCYojKh?=
 =?iso-8859-1?Q?S2HkJZ3bpNl+zJzp2HPxVSyjn4nE5wcDNIKNgK7ST54TO9FGep3WBjVpVg?=
 =?iso-8859-1?Q?mr8CXcvXLPCQAhSQYfQLyxBQ4WT1A5BeqsTwiKPGwwmud410TbeORhhslr?=
 =?iso-8859-1?Q?sOwk1ARjcsazVFVxq2CcUiUUNpK4eJ0MQfLgxJL5RmtwPxyJPo9MxEB9ib?=
 =?iso-8859-1?Q?d5/19kzJk+7jUfBdGLLJ0rNUjsflGkefBALwyU9duDVR7IE2/dtSZVpvjG?=
 =?iso-8859-1?Q?ork7V+yr5h6nwCrFs/0nHisS+0BcBIqJ0U98ykShD4uOLrDqnUFUjzrzqw?=
 =?iso-8859-1?Q?8IFVVNkpkebMB+htbg5g7kL/i5ryPOkN2XxqjDtmYJ8AweXYiOsqPu7Wgn?=
 =?iso-8859-1?Q?xNmDVUf7ec2/JVMpJ6yvtBI7PF8d3sxPOc0Lf8+X5BDMxKyBAelduwtWA/?=
 =?iso-8859-1?Q?MbIr3Mof4zZFec8wo6z6+UbUWcyFNScjWzmkHXq1E4UXE45+TnhB5ekHL8?=
 =?iso-8859-1?Q?vQH+TcUDvmyVGja4nQ+Nv/H9LAnzJOCF5cOEddVDhBYgMSIBBanrLym+14?=
 =?iso-8859-1?Q?WKTpYQATpB07CGZmnytZbzpEF074SQEiDvfSH7Hv4l/hYVAZP5cNwwcAJl?=
 =?iso-8859-1?Q?/anFwsVEZNe1MiCwGvkoq9owZBF8UKRxuIe/JR7exmiE58lm9Z1oFH3jdI?=
 =?iso-8859-1?Q?PMi1IrlaB6NIW0LDVG1YmBgHsaNEjXZkbdmuI+49A2ExThsQQNP6M89uB7?=
 =?iso-8859-1?Q?J4u9yMuNjOBw2Advee6E5xCFnbV47VF9xuqBGKUQjOMFmpgJdWFvt7fs7y?=
 =?iso-8859-1?Q?lTkiIMM32LfCfQVlHmFoI8ClP9twFOEILnUqyAfePblovrCGEKzoWTj/R5?=
 =?iso-8859-1?Q?89MSP/sVAViX/eYY0S803RGK+NfZ4ZENUJunDqwtsdi2i+R3b8NZ15Vw7o?=
 =?iso-8859-1?Q?LALTm3x0Fvxh02h4+KSxay18gwEe9SJ0yuBWDEYcOpwa6oRKnyXGcq6aWF?=
 =?iso-8859-1?Q?ON3JkuTV8l07YjBd4Pag6rJLtRZJxDxlxhxnCoi2qf+1S9v/U82RLzXGpH?=
 =?iso-8859-1?Q?4IRBwJYnFI59KpYSetPusUhbLaWEoHmZ71ZQ9HRuLJuPCgCsmaIUoRBt5J?=
 =?iso-8859-1?Q?IRDUnlYEsArp9sSdV8kv0M36rGs3FwyzhRRpvCa1M6uRiSVaIZbEkt7tev?=
 =?iso-8859-1?Q?hVr+SzpWA3dcV8D+PyFXrOdYf3rTVx6KD21BmrBoCxCU+WSILrH+vamZNJ?=
 =?iso-8859-1?Q?WOywftwRClYQr3QrVIA9Mel7H+ZSxRdsR+s1U6FJqsFn+r?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	auqfqOuvSF2uy/ANjU0QLcgG5S8xdWDfBSuglxET0vu9k2L22L5C8M2ow11fG8hZTqbBTVbuaq7DtrE2Wz4Uri7P0HpBpreDYMHiTSQPdot5ErG3LQcWtAMxdCrYqtHIpHJvivCTVdpusGGyt9mlV8930lDoX+HRoVmD7fPO2KUt8pZIq9bG63D7hiNVI3ciYJvsLtplYvoAiZFBvK3dncczlFeBkh7BKb87wjnL+MhVDVTIuaJutrdQxsXq4MXh3RnYKB64MYR2zunKG7hnpDEGfuefcFgRWbbVJi/cFn7pA713Lv2E1tBkJv4OAsk9wJlONv0zdLgB5UGlpoo4dQ==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 778e971e-862c-4689-30a6-08def89ae3e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 17:55:26.4091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VRZlBPVrID9RfxuaMe04Zl8+nJXPh0oKtOBvvY/emoo1oEL3nBNuU1AdyTVuoBhGZIwCdIAocVWjuRfYwR3e+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR20MB3282
X-MDID: 1786557332-PaW5GqLpP3dm
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1786557332;PaW5GqLpP3dm;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

Add a DPLL subsystem driver for the SiTime SiT95316 and SiT95317=0A=
clock generators. These devices provide low-jitter clock outputs=0A=
commonly used in telecom, networking, and data center timing=0A=
applications.=0A=
=0A=
The driver exposes all inputs and outputs through the Linux DPLL=0A=
subsystem, supporting:=0A=
 - Lock status monitoring via register polling or optional INTRB IRQ=0A=
 - Input priority management for automatic reference switchover=0A=
 - Per-output frequency readback from hardware state=0A=
 - Phase offset measurement via TDC (time-to-digital converter)=0A=
 - Phase adjustment for fine output alignment=0A=
 - Embedded sync (esync) pulse control=0A=
 - SYSREF/SYNCB/Pulser output mode control=0A=
 - Optional reset-gpios for hardware reset=0A=
=0A=
The driver reads all configuration from the device's on-chip NVM=0A=
at probe time -- no firmware loading is required.=0A=
=0A=
Co-developed-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 MAINTAINERS                    |    7 +=0A=
 drivers/dpll/Kconfig           |    1 +=0A=
 drivers/dpll/Makefile          |    1 +=0A=
 drivers/dpll/sit9531x/Kconfig  |   17 +=0A=
 drivers/dpll/sit9531x/Makefile |    4 +=0A=
 drivers/dpll/sit9531x/core.c   | 3120 ++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/core.h   |  372 ++++=0A=
 drivers/dpll/sit9531x/dpll.c   | 1202 ++++++++++++=0A=
 drivers/dpll/sit9531x/dpll.h   |   69 +=0A=
 drivers/dpll/sit9531x/prop.c   |  397 ++++=0A=
 drivers/dpll/sit9531x/prop.h   |   39 +=0A=
 drivers/dpll/sit9531x/regs.h   |  371 ++++=0A=
 12 files changed, 5600 insertions(+)=0A=
 create mode 100644 drivers/dpll/sit9531x/Kconfig=0A=
 create mode 100644 drivers/dpll/sit9531x/Makefile=0A=
 create mode 100644 drivers/dpll/sit9531x/core.c=0A=
 create mode 100644 drivers/dpll/sit9531x/core.h=0A=
 create mode 100644 drivers/dpll/sit9531x/dpll.c=0A=
 create mode 100644 drivers/dpll/sit9531x/dpll.h=0A=
 create mode 100644 drivers/dpll/sit9531x/prop.c=0A=
 create mode 100644 drivers/dpll/sit9531x/prop.h=0A=
 create mode 100644 drivers/dpll/sit9531x/regs.h=0A=
=0A=
diff --git a/MAINTAINERS b/MAINTAINERS=0A=
index a82b6ec9c567..8dfab3ac6a17 100644=0A=
--- a/MAINTAINERS=0A=
+++ b/MAINTAINERS=0A=
@@ -24905,6 +24905,13 @@ S:	Maintained=0A=
 W:	http://www.winischhofer.at/linuxsisusbvga.shtml=0A=
 F:	drivers/usb/misc/sisusbvga/=0A=
 =0A=
+SITIME SIT9531X DPLL DRIVER=0A=
+M:	Ali Rouhi <arouhi@sitime.com>=0A=
+L:	netdev@vger.kernel.org=0A=
+S:	Maintained=0A=
+F:	Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml=0A=
+F:	drivers/dpll/sit9531x/=0A=
+=0A=
 SL28 CPLD MFD DRIVER=0A=
 M:	Michael Walle <mwalle@kernel.org>=0A=
 S:	Maintained=0A=
diff --git a/drivers/dpll/Kconfig b/drivers/dpll/Kconfig=0A=
index be98969f040a..ea77b9c11ab1 100644=0A=
--- a/drivers/dpll/Kconfig=0A=
+++ b/drivers/dpll/Kconfig=0A=
@@ -23,6 +23,7 @@ config DPLL_REFCNT_TRACKER=0A=
 =0A=
 	  If unsure, say N.=0A=
 =0A=
+source "drivers/dpll/sit9531x/Kconfig"=0A=
 source "drivers/dpll/zl3073x/Kconfig"=0A=
 =0A=
 endmenu=0A=
diff --git a/drivers/dpll/Makefile b/drivers/dpll/Makefile=0A=
index 9e7a3a3e592e..4adc50d748d4 100644=0A=
--- a/drivers/dpll/Makefile=0A=
+++ b/drivers/dpll/Makefile=0A=
@@ -8,4 +8,5 @@ dpll-y                  +=3D dpll_core.o=0A=
 dpll-y                  +=3D dpll_netlink.o=0A=
 dpll-y                  +=3D dpll_nl.o=0A=
 =0A=
+obj-$(CONFIG_SIT9531X_DPLL)	+=3D sit9531x/=0A=
 obj-$(CONFIG_ZL3073X)	+=3D zl3073x/=0A=
diff --git a/drivers/dpll/sit9531x/Kconfig b/drivers/dpll/sit9531x/Kconfig=
=0A=
new file mode 100644=0A=
index 000000000000..47aea8674327=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/Kconfig=0A=
@@ -0,0 +1,17 @@=0A=
+# SPDX-License-Identifier: GPL-2.0-only=0A=
+=0A=
+config SIT9531X_DPLL=0A=
+	tristate "SiTime SiT9531x DPLL driver"=0A=
+	depends on I2C && NET=0A=
+	select DPLL=0A=
+	select REGMAP_I2C=0A=
+	help=0A=
+	  Driver for SiTime SiT9531x family clock generators=0A=
+	  (SiT95317, SiT95316).=0A=
+=0A=
+	  This driver registers each on-chip PLL as a DPLL device=0A=
+	  and exposes input/output clocks as DPLL pins, providing=0A=
+	  runtime configuration via Generic Netlink.=0A=
+=0A=
+	  To compile this driver as a module, choose M here: the=0A=
+	  module will be called sit9531x.=0A=
diff --git a/drivers/dpll/sit9531x/Makefile b/drivers/dpll/sit9531x/Makefil=
e=0A=
new file mode 100644=0A=
index 000000000000..b97d2656a460=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/Makefile=0A=
@@ -0,0 +1,4 @@=0A=
+# SPDX-License-Identifier: GPL-2.0-only=0A=
+=0A=
+obj-$(CONFIG_SIT9531X_DPLL) +=3D sit9531x.o=0A=
+sit9531x-y :=3D core.o dpll.o prop.o=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
new file mode 100644=0A=
index 000000000000..711ab16b0897=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -0,0 +1,3120 @@=0A=
+// SPDX-License-Identifier: GPL-2.0=0A=
+/*=0A=
+ * SiTime SiT9531x DPLL core driver=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ *=0A=
+ * Core I2C probe, regmap configuration, hardware state management,=0A=
+ * and periodic work thread.=0A=
+ */=0A=
+=0A=
+#include <linux/bitfield.h>=0A=
+#include <linux/bits.h>=0A=
+#include <linux/clk.h>=0A=
+#include <linux/delay.h>=0A=
+#include <linux/dev_printk.h>=0A=
+#include <linux/device.h>=0A=
+#include <linux/gpio/consumer.h>=0A=
+#include <linux/i2c.h>=0A=
+#include <linux/interrupt.h>=0A=
+#include <linux/kernel.h>=0A=
+#include <linux/kthread.h>=0A=
+#include <linux/module.h>=0A=
+#include <linux/property.h>=0A=
+#include <linux/regmap.h>=0A=
+#include <linux/slab.h>=0A=
+#include <linux/string.h>=0A=
+=0A=
+#include "core.h"=0A=
+#include "dpll.h"=0A=
+#include "prop.h"=0A=
+#include "regs.h"=0A=
+=0A=
+/* Number of input + output pin positions for pin index allocation */=0A=
+#define SIT9531X_NUM_INPUT_PINS		(SIT9531X_MAX_INPUTS + 2) /* +xtal +INTSY=
NC */=0A=
+#define SIT9531X_NUM_OUTPUT_PINS	(SIT9531X_MAX_OUTPUTS + 1) /* +INTSYNC sr=
c */=0A=
+#define SIT9531X_NUM_PINS_TOTAL		(SIT9531X_NUM_INPUT_PINS + SIT9531X_NUM_O=
UTPUT_PINS)=0A=
+=0A=
+#define SIT9531X_CHIP(_id, _nin, _nout, _name, _map) \=0A=
+	{ .id =3D (_id), .num_inputs =3D (_nin), .num_outputs =3D (_nout), \=0A=
+	  .name =3D (_name), .clkout_map =3D (_map) }=0A=
+=0A=
+/* Per-variant output index -> physical slot mapping */=0A=
+static const u8 clkout_map_95317[] =3D {0, 3, 4, 5, 7, 8, 9, 11};=0A=
+static const u8 clkout_map_95316[] =3D {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, =
11};=0A=
+=0A=
+static const struct sit9531x_chip_info sit9531x_chip_ids[] =3D {=0A=
+	SIT9531X_CHIP(SIT9531X_VARIANT_ID_95317,  8,  8, "SiT95317", clkout_map_9=
5317),=0A=
+	SIT9531X_CHIP(SIT9531X_VARIANT_ID_95316,  8, 12, "SiT95316", clkout_map_9=
5316),=0A=
+};=0A=
+=0A=
+#define SIT9531X_RANGE_OFFSET	SIT9531X_PAGE_SIZE=0A=
+=0A=
+static const struct regmap_range_cfg sit9531x_regmap_range =3D {=0A=
+	.range_min	=3D SIT9531X_RANGE_OFFSET,=0A=
+	.range_max	=3D SIT9531X_RANGE_OFFSET +=0A=
+			  (SIT9531X_NUM_PAGES * SIT9531X_PAGE_SIZE) - 1,=0A=
+	.selector_reg	=3D SIT9531X_PAGE_SEL,=0A=
+	.selector_mask	=3D GENMASK(7, 0),=0A=
+	.selector_shift	=3D 0,=0A=
+	.window_start	=3D 0,=0A=
+	.window_len	=3D SIT9531X_PAGE_SIZE,=0A=
+};=0A=
+=0A=
+const struct regmap_config sit9531x_regmap_config =3D {=0A=
+	.reg_bits	=3D 8,=0A=
+	.val_bits	=3D 8,=0A=
+	.max_register	=3D SIT9531X_RANGE_OFFSET +=0A=
+			  (SIT9531X_NUM_PAGES * SIT9531X_PAGE_SIZE) - 1,=0A=
+	.ranges		=3D &sit9531x_regmap_range,=0A=
+	.num_ranges	=3D 1,=0A=
+	.cache_type	=3D REGCACHE_NONE,=0A=
+};=0A=
+=0A=
+/*=0A=
+ * sit9531x_read_u8 - read an 8-bit register=0A=
+ * @reg:	register in SIT9531X_REG(page, offset) form=0A=
+ * @val:	output value=0A=
+ */=0A=
+int sit9531x_read_u8(struct sit9531x_dev *sitdev, unsigned int reg,=0A=
+		     u8 *val)=0A=
+{=0A=
+	unsigned int tmp;=0A=
+	int rc;=0A=
+=0A=
+	reg =3D (SIT9531X_REG_PAGE(reg) * SIT9531X_PAGE_SIZE) +=0A=
+	      SIT9531X_REG_OFFSET(reg) + SIT9531X_RANGE_OFFSET;=0A=
+=0A=
+	rc =3D regmap_read(sitdev->regmap, reg, &tmp);=0A=
+	if (rc)=0A=
+		dev_err(sitdev->dev, "Failed to read reg 0x%04x: %d\n",=0A=
+			reg, rc);=0A=
+	else=0A=
+		*val =3D (u8)tmp;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_write_u8 - write an 8-bit register=0A=
+ * @reg:	register in SIT9531X_REG(page, offset) form=0A=
+ * @val:	value to write=0A=
+ */=0A=
+int sit9531x_write_u8(struct sit9531x_dev *sitdev, unsigned int reg,=0A=
+		      u8 val)=0A=
+{=0A=
+	int rc;=0A=
+=0A=
+	reg =3D (SIT9531X_REG_PAGE(reg) * SIT9531X_PAGE_SIZE) +=0A=
+	      SIT9531X_REG_OFFSET(reg) + SIT9531X_RANGE_OFFSET;=0A=
+=0A=
+	rc =3D regmap_write(sitdev->regmap, reg, val);=0A=
+	if (rc)=0A=
+		dev_err(sitdev->dev, "Failed to write reg 0x%04x: %d\n",=0A=
+			reg, rc);=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_read_pll_u8 - read a register on a PLL page=0A=
+ * @val:	output value=0A=
+ */=0A=
+int sit9531x_read_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			 u8 offset, u8 *val)=0A=
+{=0A=
+	return sit9531x_read_u8(sitdev,=0A=
+				SIT9531X_REG(sit9531x_pll_page(pll_idx), offset),=0A=
+				val);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_write_pll_u8 - write a register on a PLL page=0A=
+ * @val:	value to write=0A=
+ */=0A=
+int sit9531x_write_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			  u8 offset, u8 val)=0A=
+{=0A=
+	return sit9531x_write_u8(sitdev,=0A=
+				 SIT9531X_REG(sit9531x_pll_page(pll_idx), offset),=0A=
+				 val);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_update_pll_u8 - read-modify-write a register on a PLL page=0A=
+ * @mask:	bits to modify=0A=
+ * @val:	new value for masked bits=0A=
+ */=0A=
+int sit9531x_update_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			   u8 offset, u8 mask, u8 val)=0A=
+{=0A=
+	unsigned int reg;=0A=
+=0A=
+	reg =3D (sit9531x_pll_page(pll_idx) * SIT9531X_PAGE_SIZE) +=0A=
+	      offset + SIT9531X_RANGE_OFFSET;=0A=
+=0A=
+	return regmap_update_bits(sitdev->regmap, reg, mask, val);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_get_regs - get force mask and state register addresses=
=0A=
+ * @index:	logical input index=0A=
+ * @force_reg:	output force mask register address=0A=
+ * @state_reg:	output state register address=0A=
+ *=0A=
+ * Selects the correct Page 0x02 register pair based on the pair's=0A=
+ * signal mode and the lane (P/N) the index refers to.=0A=
+ */=0A=
+static void sit9531x_input_get_regs(const struct sit9531x_dev *sitdev,=0A=
+				    u8 index,=0A=
+				    unsigned int *force_reg,=0A=
+				    unsigned int *state_reg)=0A=
+{=0A=
+	if (sitdev->ref[index].sig_mode =3D=3D SIT9531X_MODE_DE) {=0A=
+		*force_reg =3D SIT9531X_REG_IN_DE_FORCE;=0A=
+		*state_reg =3D SIT9531X_REG_IN_DE_STATE;=0A=
+	} else if (sit9531x_input_is_n(index)) {=0A=
+		*force_reg =3D SIT9531X_REG_IN_SEN_FORCE;=0A=
+		*state_reg =3D SIT9531X_REG_IN_SEN_STATE;=0A=
+	} else {=0A=
+		*force_reg =3D SIT9531X_REG_IN_SEP_FORCE;=0A=
+		*state_reg =3D SIT9531X_REG_IN_SEP_STATE;=0A=
+	}=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_disable - disable an input reference=0A=
+ * @index:	logical input index (0-N)=0A=
+ *=0A=
+ * Sets the force mask bit and clears the state bit for the given=0A=
+ * input, effectively disabling it.  Register selection depends on=0A=
+ * the pair's signal mode (SE/DE) and the lane (P/N); the bit within=0A=
+ * each register addresses the input pair.=0A=
+ */=0A=
+int sit9531x_input_disable(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	struct sit9531x_ref *ref =3D &sitdev->ref[index];=0A=
+	unsigned int force_reg, state_reg;=0A=
+	u8 pair =3D sit9531x_input_pair(index);=0A=
+	u8 val;=0A=
+	int rc;=0A=
+=0A=
+	sit9531x_input_get_regs(sitdev, index, &force_reg, &state_reg);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, force_reg, &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, force_reg, val | BIT(pair));=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, state_reg, &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, state_reg, val & ~BIT(pair));=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	ref->enabled =3D false;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_enable - enable an input reference=0A=
+ * @index:	logical input index (0-N)=0A=
+ *=0A=
+ * Clears the force mask bit for the given input, returning it to=0A=
+ * hardware default (enabled).=0A=
+ */=0A=
+int sit9531x_input_enable(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	struct sit9531x_ref *ref =3D &sitdev->ref[index];=0A=
+	unsigned int force_reg, state_reg;=0A=
+	u8 pair =3D sit9531x_input_pair(index);=0A=
+	u8 val;=0A=
+	int rc;=0A=
+=0A=
+	sit9531x_input_get_regs(sitdev, index, &force_reg, &state_reg);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, force_reg, &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, force_reg, val & ~BIT(pair));=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	ref->enabled =3D true;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Output enable / disable (Hi-Z control)=0A=
+ *=0A=
+ * SiT9531x outputs can be configured as differential (DIFF) or=0A=
+ * single-ended (SE) depending on the factory blob.  Each output slot=0A=
+ * has TWO Hi-Z force/state register pairs on Page 0x03 -- one for the=0A=
+ * DIFF path, one for the SE path.=0A=
+ *=0A=
+ * We write to BOTH pairs so the function mutes the output regardless=0A=
+ * of whether it's been configured DIFF or SE on this board.=0A=
+ *=0A=
+ *   slot 0-7 :=0A=
+ *     DIFF mask=3D0xF2 state=3D0xF3   SE mask=3D0xF8 state=3D0xF9=0A=
+ *   slot 8-11:=0A=
+ *     DIFF mask=3D0xF4 state=3D0xF5   SE mask=3D0xFA state=3D0xFB=0A=
+ *=0A=
+ * MASK bit =3D 1  -> driver takes control of that output's Hi-Z state=0A=
+ * STATE bit =3D 0 -> output is forced to Hi-Z (muted)=0A=
+ * STATE bit =3D 1 -> output is driven (active)=0A=
+ *=0A=
+ * The output "index" in the driver is logical; the physical slot comes=0A=
+ * from info->clkout_map[].=0A=
+ */=0A=
+=0A=
+struct sit9531x_hiz_regs {=0A=
+	unsigned int diff_mask;=0A=
+	unsigned int diff_state;=0A=
+	unsigned int se_mask;=0A=
+	unsigned int se_state;=0A=
+	u8 bit;=0A=
+};=0A=
+=0A=
+static void sit9531x_output_get_hiz_regs(u8 slot,=0A=
+					 struct sit9531x_hiz_regs *r)=0A=
+{=0A=
+	if (slot <=3D 7) {=0A=
+		r->diff_mask  =3D SIT9531X_REG_HIZ_DIFF_07_MASK;=0A=
+		r->diff_state =3D SIT9531X_REG_HIZ_DIFF_07_STATE;=0A=
+		r->se_mask    =3D SIT9531X_REG_HIZ_SE_07_MASK;=0A=
+		r->se_state   =3D SIT9531X_REG_HIZ_SE_07_STATE;=0A=
+		r->bit =3D slot;=0A=
+	} else {=0A=
+		r->diff_mask  =3D SIT9531X_REG_HIZ_DIFF_811_MASK;=0A=
+		r->diff_state =3D SIT9531X_REG_HIZ_DIFF_811_STATE;=0A=
+		r->se_mask    =3D SIT9531X_REG_HIZ_SE_811_MASK;=0A=
+		r->se_state   =3D SIT9531X_REG_HIZ_SE_811_STATE;=0A=
+		r->bit =3D slot - 8;=0A=
+	}=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Report whether a slot is currently forced into Hi-Z, i.e. the driver=0A=
+ * (or the blob) took control of the Hi-Z state (MASK bit set) and drives=
=0A=
+ * it low (STATE bit clear).  Either register pair muting the slot counts,=
=0A=
+ * mirroring what sit9531x_output_disable() programs.=0A=
+ */=0A=
+static int sit9531x_output_forced_hiz(struct sit9531x_dev *sitdev, u8 slot=
,=0A=
+				      bool *muted)=0A=
+{=0A=
+	struct sit9531x_hiz_regs r;=0A=
+	u8 mask, state;=0A=
+	int rc;=0A=
+=0A=
+	sit9531x_output_get_hiz_regs(slot, &r);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, r.diff_mask, &mask);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_read_u8(sitdev, r.diff_state, &state);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	*muted =3D (mask & BIT(r.bit)) && !(state & BIT(r.bit));=0A=
+	if (*muted)=0A=
+		return 0;=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, r.se_mask, &mask);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_read_u8(sitdev, r.se_state, &state);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	*muted =3D (mask & BIT(r.bit)) && !(state & BIT(r.bit));=0A=
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
+	return sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
+				 SIT9531X_PRG_CMD_STATE);=0A=
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
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
+			       SIT9531X_UPDATE_NVM);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
+			       SIT9531X_LOOP_LOCK);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	msleep(100);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_disable - mute an output (force Hi-Z)=0A=
+ * @index:	logical output index (0..info->num_outputs-1)=0A=
+ *=0A=
+ * Sets MASK+STATE on BOTH the DIFF and SE register pairs so that the=0A=
+ * output is muted regardless of its electrical configuration.  The=0A=
+ * writes are wrapped in the PRG_CMD / NVM update / loop lock sequence=0A=
+ * so the new state is applied by the hardware.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_output_disable(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	struct sit9531x_hiz_regs r;=0A=
+	u8 slot;=0A=
+	int rc, ret;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (index >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	slot =3D info->clkout_map[index];=0A=
+	sit9531x_output_get_hiz_regs(slot, &r);=0A=
+=0A=
+	rc =3D sit9531x_prg_enter(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/* Take control (MASK=3D1) and mute (STATE=3D0) on both DIFF and SE */=0A=
+	rc =3D sit9531x_hiz_set_bit(sitdev, r.diff_mask, r.bit, true);=0A=
+	if (rc)=0A=
+		goto commit;=0A=
+	rc =3D sit9531x_hiz_set_bit(sitdev, r.diff_state, r.bit, false);=0A=
+	if (rc)=0A=
+		goto commit;=0A=
+	rc =3D sit9531x_hiz_set_bit(sitdev, r.se_mask, r.bit, true);=0A=
+	if (rc)=0A=
+		goto commit;=0A=
+	rc =3D sit9531x_hiz_set_bit(sitdev, r.se_state, r.bit, false);=0A=
+=0A=
+commit:=0A=
+	/*=0A=
+	 * Always leave the PRG_CMD programming state, even on a mid-sequence=0A=
+	 * write failure: prg_enter() unlocked the output loops, so returning=0A=
+	 * without prg_commit() would strand the chip in the programming state=0A=
+	 * with the loops unlocked.  Best effort -- keep the first error.=0A=
+	 */=0A=
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+	if (!rc)=0A=
+		sitdev->out[index].enabled =3D false;=0A=
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
+	struct sit9531x_hiz_regs r;=0A=
+	u8 slot;=0A=
+	int rc, ret;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (index >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	slot =3D info->clkout_map[index];=0A=
+	sit9531x_output_get_hiz_regs(slot, &r);=0A=
+=0A=
+	rc =3D sit9531x_prg_enter(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_hiz_set_bit(sitdev, r.diff_mask, r.bit, false);=0A=
+	if (rc)=0A=
+		goto commit;=0A=
+	rc =3D sit9531x_hiz_set_bit(sitdev, r.se_mask, r.bit, false);=0A=
+=0A=
+commit:=0A=
+	/*=0A=
+	 * Always leave the PRG_CMD programming state, even on a mid-sequence=0A=
+	 * write failure: prg_enter() unlocked the output loops, so returning=0A=
+	 * without prg_commit() would strand the chip in the programming state=0A=
+	 * with the loops unlocked.  Best effort -- keep the first error.=0A=
+	 */=0A=
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+	if (!rc)=0A=
+		sitdev->out[index].enabled =3D true;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Input priority selection=0A=
+ *=0A=
+ * The SiT9531x has a 12-slot priority table per PLL on Page 1.  Each=0A=
+ * register holds two slots nibble-packed (even slot in [3:0], odd slot=0A=
+ * in [7:4]).=0A=
+ *=0A=
+ * The procedure:=0A=
+ *   1. Force PLL into holdover (PLL page reg 0x6F bit 4)=0A=
+ *   2. Write priority slots on Page 1=0A=
+ *   3. Small change update (Page 0 reg 0x0F bit 1)=0A=
+ *   4. Release holdover=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+=0A=
+/* Page-1 register holding priority slot @slot of @pll_idx. */=0A=
+static u16 sit9531x_prio_reg(u8 pll_idx, u8 slot)=0A=
+{=0A=
+	return SIT9531X_REG(SIT9531X_PAGE_PRIOSYS,=0A=
+			    SIT9531X_PRIO_BASE_REG +=0A=
+			    SIT9531X_PRIO_REGS_PER_PLL * pll_idx +=0A=
+			    slot / SIT9531X_PRIO_SLOTS_PER_REG);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Extract priority slot @slot from its register value.  The register=0A=
+ * holding slots 2n and 2n+1 keeps the earlier slot in the high nibble=0A=
+ * (CLK_SPARE<2n>SEL) and the later one in the low nibble.=0A=
+ */=0A=
+static u8 sit9531x_prio_slot_get(u8 val, u8 slot)=0A=
+{=0A=
+	if (slot & 1)=0A=
+		return val & SIT9531X_PRIO_NIBBLE_MASK;=0A=
+=0A=
+	return val >> SIT9531X_PRIO_HI_SHIFT;=0A=
+}=0A=
+=0A=
+/* Place source @src in priority slot @slot of a register value. */=0A=
+static u8 sit9531x_prio_slot_set(u8 val, u8 slot, u8 src)=0A=
+{=0A=
+	if (slot & 1)=0A=
+		return (val & (SIT9531X_PRIO_NIBBLE_MASK <<=0A=
+			       SIT9531X_PRIO_HI_SHIFT)) |=0A=
+		       (src & SIT9531X_PRIO_NIBBLE_MASK);=0A=
+=0A=
+	return (val & SIT9531X_PRIO_NIBBLE_MASK) |=0A=
+	       ((src & SIT9531X_PRIO_NIBBLE_MASK) <<=0A=
+		SIT9531X_PRIO_HI_SHIFT);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Commit a priority-table programming sequence through the Page-0=0A=
+ * programming directive register.=0A=
+ *=0A=
+ * A small change update is all the table needs.  The NVM-bank and=0A=
+ * loop-lock directives that the output system issues do not belong=0A=
+ * here: the former programs non-volatile storage from the efuse and=0A=
+ * the latter only means anything after an escape to the PRG_CMD=0A=
+ * state.  This matches the vendor input_priority_sel() procedure.=0A=
+ */=0A=
+static int sit9531x_prio_prg_commit(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,=0A=
+			       SIT9531X_SMALL_UPDATE_CMD);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	usleep_range(1000, 2000);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_prio_set - set input priority for a PLL=0A=
+ * @input_idx:	input source in hardware encoding (0-11, see=0A=
+ *		sit9531x_input_hw_src())=0A=
+ * @prio:	priority slot position (0 =3D highest)=0A=
+ *=0A=
+ * Writes a single priority slot assignment.  The input source is=0A=
+ * placed at the requested slot, and all lower-priority (higher-numbered)=
=0A=
+ * slots are filled with the same source to avoid stale entries.=0A=
+ */=0A=
+int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx, u8 prio)=0A=
+{=0A=
+	u8 val, slot;=0A=
+	int rc, prg_rc, ho_rc;=0A=
+	u16 reg;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+	if (input_idx >=3D SIT9531X_PRIO_NUM_SRC)=0A=
+		return -EINVAL;=0A=
+	if (prio >=3D SIT9531X_PRIO_MAX_SLOTS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/* Force PLL into holdover. */=0A=
+	rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+				    SIT9531X_PLL_REG_HO_CTRL,=0A=
+				    BIT(SIT9531X_PLL_HO_FORCE_BIT),=0A=
+				    BIT(SIT9531X_PLL_HO_FORCE_BIT));=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	usleep_range(10000, 12000);=0A=
+=0A=
+	/*=0A=
+	 * Write the requested slot on Page 1, then fill the remaining=0A=
+	 * slots with the same source, matching the procedure script's=0A=
+	 * backfill behaviour.=0A=
+	 */=0A=
+	for (slot =3D prio; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {=0A=
+		reg =3D sit9531x_prio_reg(pll_idx, slot);=0A=
+=0A=
+		rc =3D sit9531x_read_u8(sitdev, reg, &val);=0A=
+		if (rc)=0A=
+			goto commit;=0A=
+=0A=
+		val =3D sit9531x_prio_slot_set(val, slot, input_idx);=0A=
+=0A=
+		rc =3D sit9531x_write_u8(sitdev, reg, val);=0A=
+		if (rc)=0A=
+			goto commit;=0A=
+	}=0A=
+=0A=
+commit:=0A=
+	/*=0A=
+	 * Latch the table even when a slot write failed, so a partially=0A=
+	 * written table takes effect as a whole rather than waiting for an=0A=
+	 * unrelated update to latch the leftovers later.  Best effort --=0A=
+	 * keep the first error.=0A=
+	 */=0A=
+	prg_rc =3D sit9531x_prio_prg_commit(sitdev);=0A=
+	if (prg_rc && !rc)=0A=
+		rc =3D prg_rc;=0A=
+=0A=
+	/*=0A=
+	 * Release holdover.  This must run even when an earlier step=0A=
+	 * failed, so its own error is only surfaced when it would not mask a=0A=
+	 * prior failure -- otherwise a failing release could leave the PLL=0A=
+	 * stuck in forced holdover while the function reports success.=0A=
+	 */=0A=
+	ho_rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+				       SIT9531X_PLL_REG_HO_CTRL,=0A=
+				       BIT(SIT9531X_PLL_HO_FORCE_BIT), 0);=0A=
+	if (ho_rc && !rc)=0A=
+		rc =3D ho_rc;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_prio_get - read an input's priority slot for a PLL=0A=
+ * @input_idx:	input source in hardware encoding (see=0A=
+ *		sit9531x_input_hw_src())=0A=
+ * @prio:	output slot position (0 =3D highest); set to=0A=
+ *		SIT9531X_PRIO_MAX_SLOTS when the source is not in the table=0A=
+ *=0A=
+ * Scans the PLL's 12-slot priority table on Page 1 and returns the=0A=
+ * highest-priority (lowest-numbered) slot that references the source.=0A=
+ * This reads the value the chip actually holds rather than a cached=0A=
+ * default, so pin-get reflects the real hardware priority.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_input_prio_get(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx, u8 *prio)=0A=
+{=0A=
+	u8 val, slot, src;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {=0A=
+		rc =3D sit9531x_read_u8(sitdev,=0A=
+				      sit9531x_prio_reg(pll_idx, slot), &val);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+=0A=
+		src =3D sit9531x_prio_slot_get(val, slot);=0A=
+=0A=
+		if (src =3D=3D input_idx) {=0A=
+			*prio =3D slot;=0A=
+			return 0;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	*prio =3D SIT9531X_PRIO_MAX_SLOTS;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_prio_table_commit - write a full priority table for a PLL=0A=
+ * @srcs:	array of SIT9531X_PRIO_MAX_SLOTS source codes, slot 0 first=0A=
+ *=0A=
+ * Programs all priority slots (nibble-packed, two per register) for=0A=
+ * the PLL using the same holdover / small-update sequence as=0A=
+ * sit9531x_input_prio_set().  Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static int sit9531x_prio_table_commit(struct sit9531x_dev *sitdev, u8 pll_=
idx,=0A=
+				      const u8 *srcs)=0A=
+{=0A=
+	u8 val, slot;=0A=
+	int rc, prg_rc, ho_rc;=0A=
+	u16 reg;=0A=
+=0A=
+	rc =3D sit9531x_update_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_HO_CTRL,=
=0A=
+				    BIT(SIT9531X_PLL_HO_FORCE_BIT),=0A=
+				    BIT(SIT9531X_PLL_HO_FORCE_BIT));=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	usleep_range(10000, 12000);=0A=
+=0A=
+	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {=0A=
+		reg =3D sit9531x_prio_reg(pll_idx, slot);=0A=
+=0A=
+		rc =3D sit9531x_read_u8(sitdev, reg, &val);=0A=
+		if (rc)=0A=
+			goto commit;=0A=
+=0A=
+		val =3D sit9531x_prio_slot_set(val, slot, srcs[slot]);=0A=
+=0A=
+		rc =3D sit9531x_write_u8(sitdev, reg, val);=0A=
+		if (rc)=0A=
+			goto commit;=0A=
+	}=0A=
+=0A=
+commit:=0A=
+	/* Latch unconditionally, as in sit9531x_input_prio_set(). */=0A=
+	prg_rc =3D sit9531x_prio_prg_commit(sitdev);=0A=
+	if (prg_rc && !rc)=0A=
+		rc =3D prg_rc;=0A=
+=0A=
+	ho_rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+				       SIT9531X_PLL_REG_HO_CTRL,=0A=
+				       BIT(SIT9531X_PLL_HO_FORCE_BIT), 0);=0A=
+	if (ho_rc && !rc)=0A=
+		rc =3D ho_rc;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_prio_table_read - read a PLL's priority-table source codes=0A=
+ * @srcs:	output array of SIT9531X_PRIO_MAX_SLOTS source codes=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static int sit9531x_prio_table_read(struct sit9531x_dev *sitdev, u8 pll_id=
x,=0A=
+				    u8 *srcs)=0A=
+{=0A=
+	u8 val, slot;=0A=
+	int rc;=0A=
+=0A=
+	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {=0A=
+		rc =3D sit9531x_read_u8(sitdev,=0A=
+				      sit9531x_prio_reg(pll_idx, slot), &val);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+=0A=
+		srcs[slot] =3D sit9531x_prio_slot_get(val, slot);=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_prio_remove - drop an input from a PLL's priority table=
=0A=
+ * @input_idx:	input source in hardware encoding=0A=
+ *=0A=
+ * Rewrites the priority table with the source removed: the remaining=0A=
+ * sources are compacted toward the highest-priority slots and the freed=
=0A=
+ * tail slots are backfilled with the lowest-priority remaining source=0A=
+ * (matching sit9531x_input_prio_set()).  This makes a disconnected=0A=
+ * input ineligible for automatic reference selection, not just gated at=
=0A=
+ * the input buffer.  It is a no-op when the source is absent, or when it=
=0A=
+ * is the only source (the buffer disable then drives the PLL to=0A=
+ * holdover and the table must not be left empty).=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_input_prio_remove(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       u8 input_idx)=0A=
+{=0A=
+	u8 srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	u8 kept[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	u8 slot, count =3D 0;=0A=
+	bool found =3D false;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	rc =3D sit9531x_prio_table_read(sitdev, pll_idx, srcs);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {=0A=
+		if (srcs[slot] =3D=3D input_idx)=0A=
+			found =3D true;=0A=
+		else=0A=
+			kept[count++] =3D srcs[slot];=0A=
+	}=0A=
+=0A=
+	if (!found || count =3D=3D 0)=0A=
+		return 0;=0A=
+=0A=
+	/* Backfill freed tail slots with the lowest-priority remaining src */=0A=
+	while (count < SIT9531X_PRIO_MAX_SLOTS) {=0A=
+		kept[count] =3D kept[count - 1];=0A=
+		count++;=0A=
+	}=0A=
+=0A=
+	return sit9531x_prio_table_commit(sitdev, pll_idx, kept);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_prio_add - make an input eligible in a PLL's table=0A=
+ * @input_idx:	input source in hardware encoding=0A=
+ *=0A=
+ * Ensures the source appears in the priority table so it can be picked=0A=
+ * by automatic reference selection again after a disconnect.  If the=0A=
+ * source is already listed the table is left untouched; otherwise it is=
=0A=
+ * placed in the lowest-priority slot.  The original priority is not=0A=
+ * restored -- use sit9531x_input_prio_set() to reassign it.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx)=0A=
+{=0A=
+	u8 srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	u8 slot;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	rc =3D sit9531x_prio_table_read(sitdev, pll_idx, srcs);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++)=0A=
+		if (srcs[slot] =3D=3D input_idx)=0A=
+			return 0;=0A=
+=0A=
+	srcs[SIT9531X_PRIO_MAX_SLOTS - 1] =3D input_idx;=0A=
+=0A=
+	return sit9531x_prio_table_commit(sitdev, pll_idx, srcs);=0A=
+}=0A=
+=0A=
+/* Per-slot DIVO base register offsets (6 slots per page) */=0A=
+static const u8 clkout_odr_divn_base[] =3D {=0A=
+	0x14, 0x24, 0x34, 0x44, 0x54, 0x64=0A=
+};=0A=
+=0A=
+/* XO doubler register */=0A=
+#define SIT9531X_REG_XO2_GENERIC		SIT9531X_REG(0x00, 0x2D)=0A=
+#define SIT9531X_XO_DOUBLER_ENB_BIT		7   /* inverted: 0 =3D enabled */=0A=
+=0A=
+/* VCO frequency bands (Hz) */=0A=
+#define SIT9531X_FVCO_LOWBAND_MIN		4915200000ULL=0A=
+#define SIT9531X_FVCO_LOWBAND_MAX		5898240000ULL=0A=
+#define SIT9531X_FVCO_HIGHBAND_MIN		6875000000ULL=0A=
+#define SIT9531X_FVCO_HIGHBAND_MAX		7812500000ULL=0A=
+=0A=
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
+			       u8 read_code, u8 *buf, unsigned int len)=0A=
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
+	rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+				   SIT9531X_PLL_REG_DBG_READ_CODE, read_code);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/* Reading the trigger latches a fresh sample of the selected tap. */=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_TRIGGER, &v);=0A=
+	if (rc)=0A=
+		return rc;=0A=
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
+	*divn =3D sit9531x_divn_fixed(int_part, (s32)fracn_raw,=0A=
+				    (u64)fracd_raw + 1);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
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
+				 buf, SIT9531X_DBG_DATA_BYTES);=0A=
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
+				 SIT9531X_DBG_READ_CODE_DIVN_DEN, buf,=0A=
+				 SIT9531X_DBG_DATA_BYTES);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	for (i =3D 5; i >=3D 0; i--)=0A=
+		fracd =3D (fracd << 8) | buf[i];=0A=
+=0A=
+	fracd |=3D (u64)(buf[6] & SIT9531X_DIVN_RT_INT_HI_BIT) << 48;=0A=
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
+	if (configured <=3D 0)=0A=
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
+/*=0A=
+ * sit9531x_get_fvco - read VCO frequency from chip's DIVN registers=0A=
+ *=0A=
+ * Fvco =3D Fref * DIVN, where DIVN comes from sit9531x_divn_static() and=
=0A=
+ * Fref =3D xtal_freq << doubler.  DIVN is the=0A=
+ * steady-state Fvco/Fref target programmed by the NVM blob and is=0A=
+ * authoritative in both free-run and sync modes; the previous split=0A=
+ * between free-run and sync formulas returned 0 on chips that didn't=0A=
+ * have a sync input populated, which broke the TDC phase readback.=0A=
+ *=0A=
+ * Return: Fvco in Hz, or 0 on error=0A=
+ */=0A=
+static u64 sit9531x_get_fvco(struct sit9531x_dev *sitdev, u8 pll_idx)=0A=
+{=0A=
+	int doubler, rc;=0A=
+	s64 divn;=0A=
+	u64 fref;=0A=
+=0A=
+	/*=0A=
+	 * DT board-config override: some configs (e.g. an INTSYNC PLL)=0A=
+	 * run a VCO that Fref*DIVN does not reproduce.  When the board=0A=
+	 * supplies the measured VCO, use it verbatim.=0A=
+	 */=0A=
+	if (pll_idx < SIT9531X_NUM_PLLS && sitdev->pll_fvco[pll_idx])=0A=
+		return sitdev->pll_fvco[pll_idx];=0A=
+=0A=
+	rc =3D sit9531x_divn_static(sitdev, pll_idx, &divn);=0A=
+	if (rc || divn <=3D 0)=0A=
+		return 0;=0A=
+=0A=
+	doubler =3D sit9531x_is_xo_doubler_enabled(sitdev);=0A=
+	if (doubler < 0)=0A=
+		return 0;=0A=
+=0A=
+	fref =3D (u64)sitdev->xtal_freq << doubler;=0A=
+=0A=
+	return mul_u64_u64_div_u64(fref, (u64)divn, SIT9531X_DIVN_SCALE);=0A=
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
+ * The sequence mirrors the vendor procedure: arm the on-demand PHFL and=
=0A=
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
+	/* Latch it with the PLL small-change update. */=0A=
+	rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+				    SIT9531X_PLL_REG_SMALL_UPDATE,=0A=
+				    SIT9531X_SMALL_UPDATE_CMD,=0A=
+				    SIT9531X_SMALL_UPDATE_CMD);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/*=0A=
+	 * Select the in-register phase trigger, preserving the OEb bits.=0A=
+	 * Remember the original register value (with the trigger de-asserted)=0A=
+	 * so the trigger-source select can be restored once the pulse has=0A=
+	 * fired.=0A=
+	 */=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, &ctrl);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	orig =3D ctrl & ~SIT9531X_DIVO_PHASE_TRIG;=0A=
+	ctrl =3D orig | SIT9531X_DIVO_PHASE_SEL_REG;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, ctrl);=0A=
+	if (rc)=0A=
+		return rc;=0A=
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
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_freq_set - set output clock frequency=0A=
+ * @out_idx:	output index (0-N for this chip variant)=0A=
+ * @pll_idx:	PLL driving this output (0-3)=0A=
+ * @frequency:	desired output frequency in Hz=0A=
+ *=0A=
+ * Computes DIVO =3D Fvco / frequency and writes the 34-bit output divider=
=0A=
+ * to the output system registers on Pages 3/4.  The write sequence is:=0A=
+ *   1. Unlock debug registers (Page 3)=0A=
+ *   2. Enter PRG_CMD state=0A=
+ *   3. Write 5-byte DIVO to the correct page/slot=0A=
+ *   4. NVM update=0A=
+ *   5. Loop lock=0A=
+ *   6. Wait for lock to settle=0A=
+ *   7. Flush the output phase so the new divider starts aligned=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, <0 on error.  Actual frequency may differ=0A=
+ *         due to integer division; the output state is updated with=0A=
+ *         the effective frequency (Fvco / DIVO).=0A=
+ */=0A=
+int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			     u8 pll_idx, u64 frequency)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u8 slot, page, base_reg, divo_bytes[5], msb_old;=0A=
+	u64 fvco, divo, fvco_min, fvco_max;=0A=
+	int rc, j, ret;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (out_idx >=3D info->num_outputs || pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	if (!frequency)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/* Determine VCO frequency band limits */=0A=
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
+	/*=0A=
+	 * Read current VCO frequency.  When the board supplies an explicit=0A=
+	 * Fvco via "sitime,pll-fvco" the override is the source of truth=0A=
+	 * (e.g. a chip variant that runs out of the documented band, or a=0A=
+	 * mode like INTSYNC where Fref*DIVN does not reproduce the VCO), so=0A=
+	 * skip the band clamp in that case.=0A=
+	 */=0A=
+	fvco =3D sit9531x_get_fvco(sitdev, pll_idx);=0A=
+	if (!fvco) {=0A=
+		fvco =3D fvco_min;=0A=
+	} else if (!sitdev->pll_fvco[pll_idx]) {=0A=
+		if (fvco < fvco_min)=0A=
+			fvco =3D fvco_min;=0A=
+		else if (fvco > fvco_max)=0A=
+			fvco =3D fvco_max;=0A=
+	}=0A=
+=0A=
+	divo =3D div64_u64(fvco, frequency);=0A=
+	if (!divo)=0A=
+		return -EINVAL;=0A=
+=0A=
+	dev_dbg(sitdev->dev,=0A=
+		"out%u: Fvco=3D%llu freq=3D%llu DIVO=3D%llu (effective %llu Hz)\n",=0A=
+		out_idx, fvco, frequency, divo, div64_u64(fvco, divo));=0A=
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
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,=0A=
+			       SIT9531X_DEBUG_UNLOCK_VAL);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
+			       SIT9531X_PRG_CMD_STATE);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	divo_bytes[0] =3D (divo >>  0) & 0xFF;=0A=
+	divo_bytes[1] =3D (divo >>  8) & 0xFF;=0A=
+	divo_bytes[2] =3D (divo >> 16) & 0xFF;=0A=
+	divo_bytes[3] =3D (divo >> 24) & 0xFF;=0A=
+	divo_bytes[4] =3D (divo >> 32) & 0x03;  /* only bits [1:0] */=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev,=0A=
+			      SIT9531X_REG(page, base_reg - 4), &msb_old);=0A=
+	if (rc)=0A=
+		goto commit;=0A=
+	divo_bytes[4] |=3D msb_old & 0xFC;=0A=
+=0A=
+	for (j =3D 0; j < 5; j++) {=0A=
+		rc =3D sit9531x_write_u8(sitdev,=0A=
+				       SIT9531X_REG(page, base_reg - j),=0A=
+				       divo_bytes[j]);=0A=
+		if (rc)=0A=
+			goto commit;=0A=
+	}=0A=
+=0A=
+commit:=0A=
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
+	rc =3D sit9531x_output_phase_flush(sitdev, pll_idx);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	sitdev->out[out_idx].freq =3D (u32)div64_u64(fvco, divo);=0A=
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
+	fvco =3D sit9531x_get_fvco(sitdev, pll_idx);=0A=
+	if (!fvco)=0A=
+		return -ENODEV;=0A=
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
+	sitdev->out[out_idx].freq =3D (u32)*frequency;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Phase adjust (PRG_RST_DELAY register-based).=0A=
+ *=0A=
+ * The chip exposes a per-output 34-bit coarse delay measured in VCO=0A=
+ * clock periods plus a 3-bit fine delay in fixed 30 ps steps.  The=0A=
+ * five bytes PROG6..PROG2 hold the field across registers:=0A=
+ *   base + 0  PROG6  [7:5] OPSTG_VCASC_BUMP (preserved via RMW)=0A=
+ *                    [4:2] PRG_RST_FINE_DELAY=0A=
+ *                    [1:0] PRG_RST_DELAY[33:32]=0A=
+ *   base + 1  PROG5  PRG_RST_DELAY[31:24]=0A=
+ *   base + 2  PROG4  PRG_RST_DELAY[23:16]=0A=
+ *   base + 3  PROG3  PRG_RST_DELAY[15:8]=0A=
+ *   base + 4  PROG2  PRG_RST_DELAY[7:0]=0A=
+ *=0A=
+ * Outputs 0-5 live on Page 3, outputs 6-11 on Page 4, with each=0A=
+ * output's block at base =3D 0x15 + 16 * (out_idx % 6).=0A=
+ *=0A=
+ * The chip only supports unsigned positive delay.  A negative phase=0A=
+ * adjustment (advance) is wrapped to (T_out - |phase|) modulo one=0A=
+ * output period, which is identical for a periodic signal.=0A=
+ */=0A=
+=0A=
+int sit9531x_output_phase_adjust_set(struct sit9531x_dev *sitdev,=0A=
+				     u8 out_idx, s32 phase_ps)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u64 abs_ps, fvco, coarse, coarse_ps, rem_ps;=0A=
+	u8 page, base, prog6_val, fine =3D 0;=0A=
+	u8 pll_idx, slot;=0A=
+	u32 freq;=0A=
+	int rc, ret;=0A=
+=0A=
+	if (out_idx >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	pll_idx =3D sitdev->out[out_idx].pll_idx;=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	freq =3D sitdev->out[out_idx].freq;=0A=
+	if (!freq)=0A=
+		return -EINVAL;=0A=
+=0A=
+	fvco =3D sit9531x_get_fvco(sitdev, pll_idx);=0A=
+	if (!fvco)=0A=
+		return -EIO;=0A=
+=0A=
+	/*=0A=
+	 * Convert to unsigned absolute delay.  Negative phase (advance)=0A=
+	 * is rendered as T_out - |phase|, modulo the output period.=0A=
+	 */=0A=
+	if (phase_ps =3D=3D 0) {=0A=
+		abs_ps =3D 0;=0A=
+	} else if (phase_ps > 0) {=0A=
+		abs_ps =3D (u64)phase_ps;=0A=
+	} else {=0A=
+		u64 t_out_ps =3D div64_u64(1000000000000ULL, freq);=0A=
+		u64 advance =3D (u64)(-(s64)phase_ps);=0A=
+=0A=
+		if (t_out_ps =3D=3D 0)=0A=
+			return -EINVAL;=0A=
+		advance %=3D t_out_ps;=0A=
+		abs_ps =3D (advance =3D=3D 0) ? 0 : (t_out_ps - advance);=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * coarse_cycles =3D abs_ps * Fvco / 1e12 ps/s.=0A=
+	 * mul_u64_u64_div_u64() avoids overflow when abs_ps approaches=0A=
+	 * one second of 1 PPS wrap-around.=0A=
+	 */=0A=
+	coarse =3D mul_u64_u64_div_u64(abs_ps, fvco, 1000000000000ULL);=0A=
+	if (coarse >=3D (1ULL << SIT9531X_OUT_PRG_COARSE_BITS))=0A=
+		return -ERANGE;=0A=
+=0A=
+	/* Fine delay =3D round((abs_ps - coarse * vco_period_ps) / 30 ps) */=0A=
+	coarse_ps =3D mul_u64_u64_div_u64(coarse, 1000000000000ULL, fvco);=0A=
+	rem_ps =3D (abs_ps > coarse_ps) ? (abs_ps - coarse_ps) : 0;=0A=
+	if (rem_ps) {=0A=
+		u64 steps;=0A=
+=0A=
+		steps =3D div64_u64(rem_ps + SIT9531X_OUT_PRG_FINE_STEP_PS / 2,=0A=
+				  SIT9531X_OUT_PRG_FINE_STEP_PS);=0A=
+		if (steps > SIT9531X_OUT_PRG_FINE_MAX)=0A=
+			steps =3D SIT9531X_OUT_PRG_FINE_MAX;=0A=
+		fine =3D (u8)steps;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Map logical output index to the chip's physical output slot.=0A=
+	 * On SiT95317 the eight logical outputs land on chip slots=0A=
+	 * {0, 3, 4, 5, 7, 8, 9, 11}; on SiT95316 the map is identity.=0A=
+	 * Page/base must address the slot, not the logical index.=0A=
+	 */=0A=
+	slot =3D info->clkout_map[out_idx];=0A=
+	page =3D (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX) ?=0A=
+	       SIT9531X_PAGE_OUTSYS1 : SIT9531X_PAGE_OUTSYS0;=0A=
+	base =3D SIT9531X_OUT_PRG_DELAY_BASE +=0A=
+	       SIT9531X_OUT_PRG_SLOT_STRIDE * (slot % 6);=0A=
+=0A=
+	/* Caller (dpll.c) holds multiop_lock around the whole sequence. */=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	/*=0A=
+	 * The PRG_RST_DELAY bytes live in the output system, so the writes=0A=
+	 * only take effect when made inside the PRG_CMD programming state and=0A=
+	 * committed to the NVM shadow, exactly like sit9531x_output_freq_set().=
=0A=
+	 */=0A=
+	rc =3D sit9531x_prg_enter(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/* PROG6 RMW: preserve OPSTG_VCASC_BUMP in [7:5] */=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG(page, base),=0A=
+			      &prog6_val);=0A=
+	if (rc)=0A=
+		goto commit;=0A=
+=0A=
+	prog6_val &=3D SIT9531X_OUT_PRG_OPSTG_MASK;=0A=
+	prog6_val |=3D (fine << SIT9531X_OUT_PRG_FINE_SHIFT) &=0A=
+		     SIT9531X_OUT_PRG_FINE_MASK;=0A=
+	prog6_val |=3D (u8)((coarse >> 32) & SIT9531X_OUT_PRG_COARSE_HI_MASK);=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG(page, base),=0A=
+			       prog6_val);=0A=
+	if (rc)=0A=
+		goto commit;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG(page, base + 1),=0A=
+			       (u8)((coarse >> 24) & 0xFF));=0A=
+	if (rc)=0A=
+		goto commit;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG(page, base + 2),=0A=
+			       (u8)((coarse >> 16) & 0xFF));=0A=
+	if (rc)=0A=
+		goto commit;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG(page, base + 3),=0A=
+			       (u8)((coarse >> 8) & 0xFF));=0A=
+	if (rc)=0A=
+		goto commit;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG(page, base + 4),=0A=
+			       (u8)(coarse & 0xFF));=0A=
+=0A=
+commit:=0A=
+	/*=0A=
+	 * Always leave the PRG_CMD state via prg_commit(), even on a=0A=
+	 * mid-sequence write failure, so the output loops are re-locked rather=
=0A=
+	 * than stranded unlocked; keep the first error.=0A=
+	 */=0A=
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/*=0A=
+	 * Restart the output divider phase so the freshly programmed delay is=0A=
+	 * applied against a known edge instead of the divider's arbitrary=0A=
+	 * running phase.=0A=
+	 */=0A=
+	return sit9531x_output_phase_flush(sitdev, pll_idx);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_clear_notifications - clear all notification registers=0A=
+ *=0A=
+ * Clears all write-1-to-clear notification registers:=0A=
+ *   - PLL outer LOL notification (Page 0, reg 0x07)=0A=
+ *   - PLL holdover freeze notification (Page 0, reg 0x0B)=0A=
+ *   - PLL inner LOL notification (Page 0, reg 0x93)=0A=
+ *   - Clock monitor XO/PLL notification (Page 0, reg 0x9E)=0A=
+ *   - Clock input notifications (Page 6, regs 0x03/0x07/0x93/0x97)=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_clear_notifications(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	/* Page 0x00 W1C notification registers */=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_OUTER_LOL_NOTIF, 0xFF);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_HO_FREEZE_NOTIF, 0xFF);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PLL_INNER_LOL_NOTIF, 0xFF);=
=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_CMON_NOTIF, 0xFF);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/* Page 0x06 clock input monitor notifications */=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_CLKMON_P_NOTIF_01, 0xFF);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_CLKMON_P_NOTIF_23, 0xFF);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_CLKMON_N_NOTIF_01, 0xFF);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_CLKMON_N_NOTIF_23, 0xFF);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	dev_dbg(sitdev->dev, "All notification registers cleared\n");=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * INTSYNC configuration register values.=0A=
+ * These are written to the source PLL's EXT page to enable/disable=0A=
+ * inter-PLL synchronization (lock frequency PLL to phase PLL).=0A=
+ */=0A=
+struct sit9531x_intsync_reg {=0A=
+	u8 offset;=0A=
+	u8 en_val;=0A=
+	u8 dis_val;=0A=
+};=0A=
+=0A=
+static const struct sit9531x_intsync_reg intsync_config[] =3D {=0A=
+	{ 0x2D, 0x02, 0x00 },=0A=
+	{ 0x50, 0x08, 0x00 },=0A=
+	{ 0x51, 0x04, 0x00 },=0A=
+	{ 0x54, 0x02, 0x00 },=0A=
+	{ 0x55, 0x28, 0x20 },=0A=
+	{ 0x5C, 0x0F, 0x00 },=0A=
+	{ 0x5D, 0xFF, 0x00 },=0A=
+	{ 0x6C, 0xDD, 0x00 },=0A=
+};=0A=
+=0A=
+/*=0A=
+ * sit9531x_intsync_enable - enable inter-PLL synchronization=0A=
+ * @src_pll_idx: source (frequency) PLL index (0-3)=0A=
+ *=0A=
+ * Enables INTSYNC global bit, unlocks the source PLL's EXT page=0A=
+ * debug registers, writes configuration, and triggers a small=0A=
+ * update on the source PLL.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_intsync_enable(struct sit9531x_dev *sitdev, u8 src_pll_idx)=
=0A=
+{=0A=
+	u8 ext_page, val;=0A=
+	int rc, i;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (src_pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	ext_page =3D SIT9531X_PLL_EXT_PAGE(src_pll_idx);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL,=0A=
+			       val | BIT(SIT9531X_INTSYNC_EN_BIT));=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/* Small update on Page 0 */=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,=0A=
+			       SIT9531X_SMALL_UPDATE_CMD);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/* Unlock debug on EXT page */=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG(ext_page, SIT9531X_PLL_REG_=
DEBUG),=0A=
+			       SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(intsync_config); i++) {=0A=
+		rc =3D sit9531x_write_u8(sitdev,=0A=
+				       SIT9531X_REG(ext_page,=0A=
+						    intsync_config[i].offset),=0A=
+				       intsync_config[i].en_val);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+	}=0A=
+=0A=
+	/* Small update on source PLL */=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, src_pll_idx,=0A=
+				   SIT9531X_PLL_REG_SMALL_UPDATE,=0A=
+				   SIT9531X_SMALL_UPDATE_CMD);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_intsync_disable - disable inter-PLL synchronization=0A=
+ * @src_pll_idx: source (frequency) PLL index (0-3)=0A=
+ *=0A=
+ * Clears INTSYNC global bit, writes disable values to the source=0A=
+ * PLL's EXT page, and triggers a small update.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_intsync_disable(struct sit9531x_dev *sitdev, u8 src_pll_idx)=
=0A=
+{=0A=
+	u8 ext_page, val;=0A=
+	int rc, i;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (src_pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	ext_page =3D SIT9531X_PLL_EXT_PAGE(src_pll_idx);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL,=0A=
+			       val & ~BIT(SIT9531X_INTSYNC_EN_BIT));=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/* Small update on Page 0 */=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,=0A=
+			       SIT9531X_SMALL_UPDATE_CMD);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/* Unlock debug on EXT page */=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG(ext_page, SIT9531X_PLL_REG_=
DEBUG),=0A=
+			       SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(intsync_config); i++) {=0A=
+		rc =3D sit9531x_write_u8(sitdev,=0A=
+				       SIT9531X_REG(ext_page,=0A=
+						    intsync_config[i].offset),=0A=
+				       intsync_config[i].dis_val);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+	}=0A=
+=0A=
+	/* Small update on source PLL */=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, src_pll_idx,=0A=
+				   SIT9531X_PLL_REG_SMALL_UPDATE,=0A=
+				   SIT9531X_SMALL_UPDATE_CMD);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_pulse_ctrl_set - program per-output PULSE_CTRL byte=0A=
+ * @out_idx:	logical output index (translated to chip slot internally)=0A=
+ * @pulse_ctrl:	8-bit PULSE_CTRL value (PROG0)=0A=
+ *=0A=
+ * Writes ODRn_PROG0 on the output page (Page 3 for slots 0..5,=0A=
+ * Page 4 for slots 6..11) at offset 0x1B + 16 * (slot % 6).=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_output_pulse_ctrl_set(struct sit9531x_dev *sitdev,=0A=
+				   u8 out_idx, u8 pulse_ctrl)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u8 slot, page, reg;=0A=
+	int rc, ret;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (out_idx >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	slot =3D info->clkout_map[out_idx];=0A=
+	page =3D (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX) ?=0A=
+		SIT9531X_PAGE_OUTSYS1 : SIT9531X_PAGE_OUTSYS0;=0A=
+	reg =3D SIT9531X_OUT_PROG0_BASE +=0A=
+	      SIT9531X_OUT_PRG_SLOT_STRIDE * (slot % 6);=0A=
+=0A=
+	/*=0A=
+	 * PROG0 lives in the output system, so like the DIVO and=0A=
+	 * PRG_RST_DELAY writes it only takes effect inside the PRG_CMD=0A=
+	 * programming state committed to the NVM shadow.=0A=
+	 */=0A=
+	rc =3D sit9531x_prg_enter(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG(page, reg), pulse_ctrl);=0A=
+=0A=
+	/*=0A=
+	 * Always leave the PRG_CMD state via prg_commit(), even if the write=0A=
+	 * failed, so the output loops are re-locked rather than stranded=0A=
+	 * unlocked; keep the first error.=0A=
+	 */=0A=
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/* Retries (at 1 s each) to wait for a PLL to reach its active state. */=
=0A=
+#define SIT9531X_PLL_ACTIVE_RETRIES	90=0A=
+=0A=
+/*=0A=
+ * sit9531x_phase_offset_read - read phase difference via TDC=0A=
+ * @phase_ps:	output phase difference in picoseconds=0A=
+ *=0A=
+ * Reads the Time-to-Digital Converter (TDC) 40-bit code from the=0A=
+ * PLL page registers, then converts to picoseconds using the VCO=0A=
+ * frequency: phase_diff =3D tdc_code / fvco.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_phase_offset_read(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       s64 *phase_ps)=0A=
+{=0A=
+	u64 fvco, fvco_mhz;=0A=
+	s64 tdc_signed;=0A=
+	u64 tdc_raw;=0A=
+	int rc, i;=0A=
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
+		return rc;=0A=
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
+		return rc;=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+				   SIT9531X_PLL_REG_DBG_READ_CODE,=0A=
+				   SIT9531X_DBG_READ_CODE_TDC);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/* Latch a sample by reading the trigger register 3 times. */=0A=
+	for (i =3D 0; i < 3; i++) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_DBG_TRIGGER, &v);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+	}=0A=
+=0A=
+	tdc_raw =3D 0;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_4, &v);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	sign =3D !!(v & BIT(SIT9531X_TDC_SIGN_BIT));=0A=
+	tdc_raw =3D (u64)(v & 0x07) << 32;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_3, &v);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	tdc_raw |=3D (u64)v << 24;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_2, &v);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	tdc_raw |=3D (u64)v << 16;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_1, &v);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	tdc_raw |=3D (u64)v << 8;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_0, &v);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	tdc_raw |=3D v;=0A=
+=0A=
+	/*=0A=
+	 * Apply sign.  Per the vendor reference the sign bit is active-high=0A=
+	 * for a positive offset: bit set -> +code, bit clear -> -code.=0A=
+	 */=0A=
+	tdc_signed =3D sign ? (s64)tdc_raw : -(s64)tdc_raw;=0A=
+=0A=
+	/*=0A=
+	 * Get VCO frequency for conversion.  Fvco=3D=3D0 means DIVN is not=0A=
+	 * programmed (PLL unused on this board) -- skip silently rather=0A=
+	 * than spamming the log on every poll cycle.=0A=
+	 */=0A=
+	fvco =3D sit9531x_get_fvco(sitdev, pll_idx);=0A=
+	if (!fvco) {=0A=
+		dev_dbg(sitdev->dev, "PLL%c: Fvco unknown, skip TDC\n",=0A=
+			'A' + pll_idx);=0A=
+		return -ENODEV;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * phase_diff (seconds) =3D tdc_code / fvco=0A=
+	 * phase_diff (ps) =3D tdc_code * 1e12 / fvco=0A=
+	 *=0A=
+	 * To avoid 64-bit overflow:=0A=
+	 *   phase_ps =3D tdc_code * 1e6 / (fvco / 1e6)=0A=
+	 */=0A=
+	fvco_mhz =3D div64_u64(fvco, 1000000ULL);=0A=
+	if (!fvco_mhz)=0A=
+		return -EIO;=0A=
+=0A=
+	*phase_ps =3D div64_s64(tdc_signed * 1000000LL, (s64)fvco_mhz);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_ref_state_fetch - read input reference status from hardware=0A=
+ * @index:	logical input index=0A=
+ *=0A=
+ * Reads LOS and OOF status for the given input lane from the Page 0x06=0A=
+ * clock monitor registers.  P and N lanes have separate register banks;=
=0A=
+ * each register carries two input pairs nibble-packed (even pair in=0A=
+ * bits [3:0], odd pair in [7:4]).=0A=
+ */=0A=
+static int sit9531x_ref_state_fetch(struct sit9531x_dev *sitdev, u8 index)=
=0A=
+{=0A=
+	unsigned int reg, force_reg, state_reg;=0A=
+	u8 pair, status, force, state;=0A=
+	struct sit9531x_ref *ref;=0A=
+	int rc;=0A=
+=0A=
+	/*=0A=
+	 * The XTAL/XO reference (index SIT9531X_MAX_INPUTS) is the on-chip=0A=
+	 * oscillator that feeds every PLL.  It cannot be routed or deselected,=
=0A=
+	 * so its pin is modelled as permanently connected (see=0A=
+	 * sit9531x_dpll_xo_pin_ops) and its LOS/OOF flags are never consulted.=
=0A=
+	 * Only the routable per-lane inputs (0..num_inputs-1) are polled here.=
=0A=
+	 */=0A=
+	if (index >=3D SIT9531X_MAX_INPUTS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	ref =3D &sitdev->ref[index];=0A=
+	pair =3D sit9531x_input_pair(index);=0A=
+=0A=
+	if (sit9531x_input_is_n(index))=0A=
+		reg =3D pair < 2 ? SIT9531X_CLKMON_N_STATUS_01=0A=
+			       : SIT9531X_CLKMON_N_STATUS_23;=0A=
+	else=0A=
+		reg =3D pair < 2 ? SIT9531X_CLKMON_P_STATUS_01=0A=
+			       : SIT9531X_CLKMON_P_STATUS_23;=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, reg, &status);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	if (pair & 1)=0A=
+		status >>=3D 4;=0A=
+=0A=
+	ref->los =3D !!(status & (BIT(SIT9531X_CLKMON_CLK_LOSS) |=0A=
+				BIT(SIT9531X_CLKMON_CLK_LOSS_FD)));=0A=
+	ref->oof =3D !!(status & (BIT(SIT9531X_CLKMON_FREQ_FINE) |=0A=
+				BIT(SIT9531X_CLKMON_FREQ_COARSE)));=0A=
+=0A=
+	/*=0A=
+	 * Whether the receiver is on.  This has to come from the chip: it=0A=
+	 * is the loaded configuration that decides, and without reading it=0A=
+	 * back every input would look disabled until something called=0A=
+	 * sit9531x_input_enable().  A lane counts as disabled only while=0A=
+	 * the force bit overrides it to the off state; with the force bit=0A=
+	 * clear it follows the configuration, which is the enabled case.=0A=
+	 */=0A=
+	sit9531x_input_get_regs(sitdev, index, &force_reg, &state_reg);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, force_reg, &force);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_read_u8(sitdev, state_reg, &state);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	ref->enabled =3D !((force & BIT(pair)) && !(state & BIT(pair)));=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_mode_fetch - detect SE/DE configuration of an input pair=
=0A=
+ * @pair:	input pair number (0-3)=0A=
+ *=0A=
+ * Reads CLKINx_INPUT_MODE and stores the detected signal mode on both=0A=
+ * lanes of the pair.  A pair with neither SE lane enabled is running=0A=
+ * differential.=0A=
+ */=0A=
+static int sit9531x_input_mode_fetch(struct sit9531x_dev *sitdev, u8 pair)=
=0A=
+{=0A=
+	enum sit9531x_signal_mode sig_mode;=0A=
+	u8 mode;=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_IN_MODE(pair), &mode);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	if (mode & (SIT9531X_IN_MODE_SE_P_EN | SIT9531X_IN_MODE_SE_N_EN))=0A=
+		sig_mode =3D SIT9531X_MODE_SE;=0A=
+	else=0A=
+		sig_mode =3D SIT9531X_MODE_DE;=0A=
+=0A=
+	sitdev->ref[pair * 2].sig_mode =3D sig_mode;=0A=
+	sitdev->ref[pair * 2 + 1].sig_mode =3D sig_mode;=0A=
+=0A=
+	dev_dbg(sitdev->dev, "CLKIN%u mode reg 0x%02x -> %s\n", pair, mode,=0A=
+		sig_mode =3D=3D SIT9531X_MODE_DE ? "differential" : "single-ended");=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_chan_state_fetch - read PLL channel status from hardware=0A=
+ *=0A=
+ * Reads lock status and mode from the PLL status register.=0A=
+ */=0A=
+/* Read the PLL active-state bit (PLL page reg 0x02 bit 0). */=0A=
+static int sit9531x_pll_is_active(struct sit9531x_dev *sitdev, u8 pll_idx,=
=0A=
+				  bool *active)=0A=
+{=0A=
+	u8 v;=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_ACTIVE, &v)=
;=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	*active =3D !!(v & SIT9531X_PLL_ACTIVE_BIT);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int sit9531x_chan_state_fetch(struct sit9531x_dev *sitdev, u8 pll_i=
dx)=0A=
+{=0A=
+	u8 status, outer_lol, input_sel, inner_lol, ho_freeze, activesel_reg;=0A=
+	struct sit9531x_chan *chan =3D &sitdev->chan[pll_idx];=0A=
+	bool active;=0A=
+	int rc;=0A=
+=0A=
+	/*=0A=
+	 * Whether the PLL is running at all.  The loss-of-lock bit read=0A=
+	 * below is driven by the PLL itself, so on one the loaded=0A=
+	 * configuration leaves unused it simply stays clear and would=0A=
+	 * otherwise read as a lock.=0A=
+	 */=0A=
+	rc =3D sit9531x_pll_is_active(sitdev, pll_idx, &active);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_STATUS, &status);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_OUTER_LOL_STATUS,=0A=
+			      &outer_lol);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/*=0A=
+	 * Read the input source the PLL has currently selected as its=0A=
+	 * active reference.  This lives in the low nibble of the last=0A=
+	 * register of the PLL's page-1 priority block (CLK_ACTIVESEL_PLL),=0A=
+	 * not on the PLL page -- PLL-page 0x29 is a config register.=0A=
+	 */=0A=
+	activesel_reg =3D SIT9531X_PRIO_BASE_REG +=0A=
+			SIT9531X_PRIO_REGS_PER_PLL * pll_idx +=0A=
+			SIT9531X_PRIO_ACTIVESEL_OFF;=0A=
+	rc =3D sit9531x_read_u8(sitdev,=0A=
+			      SIT9531X_REG(SIT9531X_PAGE_PRIOSYS,=0A=
+					   activesel_reg),=0A=
+			      &input_sel);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_PLL_INNER_LOL_STATUS,=0A=
+			      &inner_lol);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_HO_FREEZE_STATUS, &ho_freeze=
);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/* STATUS_1_GENERIC reports loss of lock, so invert it. */=0A=
+	chan->active =3D active;=0A=
+	chan->locked =3D active && !(outer_lol & BIT(pll_idx));=0A=
+	chan->mode =3D !!(status & SIT9531X_PLL_STATUS_OUTER_DIS);=0A=
+	chan->selected_ref =3D=0A=
+		sit9531x_hw_src_input(input_sel & SIT9531X_PRIO_NIBBLE_MASK);=0A=
+	chan->inner_lol =3D !!(inner_lol & BIT(pll_idx));=0A=
+	chan->ho_freeze =3D !!(ho_freeze & BIT(pll_idx));=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_out_state_fetch - read output status from hardware=0A=
+ *=0A=
+ * Reads the output PLL association from the PLL page output map=0A=
+ * registers into out->routed / out->pll_idx, and the current drive=0A=
+ * state from the Hi-Z force bits into out->enabled.  The two are=0A=
+ * separate: routing decides whether the output gets a DPLL pin at all,=0A=
+ * while a muted but routed output keeps its pin and reports=0A=
+ * DPLL_PIN_STATE_DISCONNECTED until it is un-muted.=0A=
+ */=0A=
+static int sit9531x_out_state_fetch(struct sit9531x_dev *sitdev, u8 index)=
=0A=
+{=0A=
+	struct sit9531x_out *out =3D &sitdev->out[index];=0A=
+	u8 map_lo, map_hi, slot;=0A=
+	int pll_idx;=0A=
+	bool muted;=0A=
+	int rc;=0A=
+=0A=
+	slot =3D sitdev->info->clkout_map[index];=0A=
+=0A=
+	rc =3D sit9531x_output_forced_hiz(sitdev, slot, &muted);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/*=0A=
+	 * DT board-config override: the per-PLL OUTPUT_ENABLE bitmaps=0A=
+	 * (0x27/0x28) do not unambiguously express output->PLL routing on=0A=
+	 * every config (overlaps, and some outputs routed outside that=0A=
+	 * path).  When the board supplies an explicit map, trust it.=0A=
+	 */=0A=
+	if (sitdev->out_pll_map_valid) {=0A=
+		u8 m =3D sitdev->out_pll_map[index];=0A=
+=0A=
+		if (m < SIT9531X_NUM_PLLS) {=0A=
+			out->pll_idx =3D m;=0A=
+			out->routed =3D true;=0A=
+			out->enabled =3D !muted;=0A=
+		} else {=0A=
+			out->pll_idx =3D 0;=0A=
+			out->routed =3D false;=0A=
+			out->enabled =3D false;=0A=
+		}=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * The OUT_MAP_LO/HI bitmaps are indexed by the physical slot the=0A=
+	 * output occupies on the chip, not by the driver's logical output=0A=
+	 * index (translated above via the chip-info clkout_map[]: identity=0A=
+	 * on SiT95316, non-contiguous on SiT95317).=0A=
+	 *=0A=
+	 * Determine which PLL drives this output by checking each PLL's=0A=
+	 * output map registers (0x27 =3D slots 8-11, 0x28 =3D slots 0-7).=0A=
+	 */=0A=
+	for (pll_idx =3D 0; pll_idx < SIT9531X_NUM_PLLS; pll_idx++) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_OUT_MAP_LO, &map_lo);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_OUT_MAP_HI, &map_hi);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+=0A=
+		if (slot < 8) {=0A=
+			if (map_lo & BIT(slot)) {=0A=
+				out->pll_idx =3D pll_idx;=0A=
+				out->routed =3D true;=0A=
+				out->enabled =3D !muted;=0A=
+				return 0;=0A=
+			}=0A=
+		} else {=0A=
+			if (map_hi & BIT(slot - 8)) {=0A=
+				out->pll_idx =3D pll_idx;=0A=
+				out->routed =3D true;=0A=
+				out->enabled =3D !muted;=0A=
+				return 0;=0A=
+			}=0A=
+		}=0A=
+	}=0A=
+=0A=
+	/* Output not mapped to any PLL */=0A=
+	out->pll_idx =3D 0;=0A=
+	out->routed =3D false;=0A=
+	out->enabled =3D false;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_ref_pll_mask_fetch - seed the input-to-PLL usage masks=0A=
+ *=0A=
+ * ref->pll_mask is the refcount the disconnect path uses to decide when=
=0A=
+ * an input receiver may be powered down: the physical input is only=0A=
+ * disabled once the last DPLL has released it.  It therefore has to=0A=
+ * start out matching the hardware.  Without this pass every mask starts=
=0A=
+ * at zero, and disconnecting an input from one DPLL drops the mask to=0A=
+ * zero and disables a receiver the other DPLLs are still locked to.=0A=
+ *=0A=
+ * An input is counted for a PLL when it appears in that PLL's Page-1=0A=
+ * priority table, which is exactly the condition the connect and=0A=
+ * disconnect callbacks maintain.  Sources that are not physical inputs=0A=
+ * (OCXO, INTSYNC) and reserved codes are skipped.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static int sit9531x_ref_pll_mask_fetch(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	u8 srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	u8 pll_idx, slot, index;=0A=
+	int rc;=0A=
+=0A=
+	for (pll_idx =3D 0; pll_idx < SIT9531X_NUM_PLLS; pll_idx++) {=0A=
+		rc =3D sit9531x_prio_table_read(sitdev, pll_idx, srcs);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+=0A=
+		for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {=0A=
+			index =3D sit9531x_hw_src_input(srcs[slot]);=0A=
+			if (index >=3D sitdev->info->num_inputs)=0A=
+				continue;=0A=
+=0A=
+			/*=0A=
+			 * On a differentially configured pair only the P lane=0A=
+			 * has a DPLL pin, so that is the lane the connect and=0A=
+			 * disconnect callbacks account for.  Fold an N-lane=0A=
+			 * table entry onto its P lane, otherwise the count=0A=
+			 * would land on a lane nothing ever releases.  The=0A=
+			 * signalling mode is already known here:=0A=
+			 * sit9531x_input_mode_fetch() runs first.=0A=
+			 */=0A=
+			if (sit9531x_input_is_n(index) &&=0A=
+			    sitdev->ref[index].sig_mode =3D=3D SIT9531X_MODE_DE)=0A=
+				index--;=0A=
+=0A=
+			sitdev->ref[index].pll_mask |=3D BIT(pll_idx);=0A=
+		}=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dev_state_fetch - read all hardware state at startup=0A=
+ *=0A=
+ * Called once during probe to populate the initial state cache.=0A=
+ */=0A=
+static int sit9531x_dev_state_fetch(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int rc;=0A=
+	u8 i;=0A=
+=0A=
+	/* Detect SE/DE configuration before any per-lane access */=0A=
+	for (i =3D 0; i < sitdev->info->num_inputs / 2; i++) {=0A=
+		rc =3D sit9531x_input_mode_fetch(sitdev, i);=0A=
+		if (rc) {=0A=
+			dev_err(sitdev->dev,=0A=
+				"Failed to fetch CLKIN%u mode: %d\n", i, rc);=0A=
+			return rc;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	for (i =3D 0; i < sitdev->info->num_inputs; i++) {=0A=
+		rc =3D sit9531x_ref_state_fetch(sitdev, i);=0A=
+		if (rc) {=0A=
+			dev_err(sitdev->dev,=0A=
+				"Failed to fetch input %u state: %d\n", i, rc);=0A=
+			return rc;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * The priority-table read walks the Page-1 registers, so it runs=0A=
+	 * with multiop_lock held like every other multi-register sequence.=0A=
+	 * Nothing can race with it here -- the DPLLs are not registered and=0A=
+	 * the monitor is not running yet -- but the page handling stays=0A=
+	 * serialized the same way as at runtime.=0A=
+	 */=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_ref_pll_mask_fetch(sitdev);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+	if (rc) {=0A=
+		dev_err(sitdev->dev,=0A=
+			"Failed to fetch input priority tables: %d\n", rc);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	for (i =3D 0; i < sitdev->info->num_outputs; i++) {=0A=
+		rc =3D sit9531x_out_state_fetch(sitdev, i);=0A=
+		if (rc) {=0A=
+			dev_err(sitdev->dev,=0A=
+				"Failed to fetch output %u state: %d\n", i, rc);=0A=
+			return rc;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
+		rc =3D sit9531x_chan_state_fetch(sitdev, i);=0A=
+		if (rc) {=0A=
+			dev_err(sitdev->dev,=0A=
+				"Failed to fetch PLL%c state: %d\n",=0A=
+				'A' + i, rc);=0A=
+			return rc;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static void sit9531x_dev_ref_states_update(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int i, rc;=0A=
+=0A=
+	for (i =3D 0; i < sitdev->info->num_inputs; i++) {=0A=
+		rc =3D sit9531x_ref_state_fetch(sitdev, i);=0A=
+		if (rc)=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "Failed to get REF%u status: %d\n", i, rc);=0A=
+	}=0A=
+}=0A=
+=0A=
+static void sit9531x_dev_chan_states_update(struct sit9531x_dev *sitdev)=
=0A=
+{=0A=
+	int i, rc;=0A=
+=0A=
+	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
+		rc =3D sit9531x_chan_state_fetch(sitdev, i);=0A=
+		if (rc)=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "Failed to get PLL%c state: %d\n",=0A=
+				 'A' + i, rc);=0A=
+	}=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dev_periodic_work - periodic hardware state polling=0A=
+ * @work:	kthread_work pointer=0A=
+ *=0A=
+ * Polls hardware state at SIT9531X_STATUS_POLL_MS intervals.=0A=
+ * Updates reference and channel states, then delegates change=0A=
+ * detection to sit9531x_dpll_changes_check() for each registered DPLL.=0A=
+ */=0A=
+static void sit9531x_dev_periodic_work(struct kthread_work *work)=0A=
+{=0A=
+	struct sit9531x_dev *sitdev =3D container_of(work, struct sit9531x_dev,=
=0A=
+						   work.work);=0A=
+	struct sit9531x_dpll *sitdpll;=0A=
+	int rc;=0A=
+=0A=
+	/*=0A=
+	 * Update the cached ref[]/chan[] arrays under multiop_lock so the=0A=
+	 * fetches are serialized against the DPLL callbacks that read=0A=
+	 * these fields and against the chip's page selector.=0A=
+	 *=0A=
+	 * The lock is then dropped before sit9531x_dpll_changes_check(),=0A=
+	 * which calls dpll_pin_change_ntf() / dpll_device_change_ntf().=0A=
+	 * Those notification helpers take DPLL-subsystem locks that are=0A=
+	 * already held when our callbacks are invoked from netlink=0A=
+	 * context, and nesting multiop_lock around them would invert the=0A=
+	 * lock order.  changes_check() reads the cache published above,=0A=
+	 * which is already consistent.=0A=
+	 */=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	sit9531x_dev_ref_states_update(sitdev);=0A=
+	sit9531x_dev_chan_states_update(sitdev);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	list_for_each_entry(sitdpll, &sitdev->dplls, list)=0A=
+		sit9531x_dpll_changes_check(sitdpll);=0A=
+=0A=
+	/*=0A=
+	 * Acknowledge the chip's notification latches after the tick has=0A=
+	 * read and acted on them.  Without this, the W1C bits remain set=0A=
+	 * and -- on boards that wire INTRB -- the line stays asserted,=0A=
+	 * re-firing the threaded handler back to back.  The helper writes=0A=
+	 * W1C bits across page 0 and page 6 and must run under=0A=
+	 * multiop_lock to serialize the page selector against userspace=0A=
+	 * dpll ops.  Failure is non-fatal: status was already consumed=0A=
+	 * for this tick and the next tick re-processes whatever stayed=0A=
+	 * latched.=0A=
+	 */=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_clear_notifications(sitdev);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+	if (rc)=0A=
+		dev_warn_ratelimited(sitdev->dev,=0A=
+				     "Failed to clear notifications: %d\n",=0A=
+				     rc);=0A=
+=0A=
+	/* Run twice a second */=0A=
+	kthread_queue_delayed_work(sitdev->kworker, &sitdev->work,=0A=
+				   msecs_to_jiffies(SIT9531X_STATUS_POLL_MS));=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_irq_thread_fn - threaded IRQ handler for the chip's INTRB line=
=0A=
+ *=0A=
+ * Triggered when the chip asserts INTRB (and only when DT wires up the=0A=
+ * client interrupt; absent property =3D=3D handler never installed).  The=
=0A=
+ * action mirrors a periodic-work tick: queue an immediate run so status=
=0A=
+ * registers are read and DPLL changes_check fires without waiting for=0A=
+ * the next poll deadline.  Polling continues to run as a fallback.=0A=
+ */=0A=
+static irqreturn_t sit9531x_irq_thread_fn(int irq, void *data)=0A=
+{=0A=
+	struct sit9531x_dev *sitdev =3D data;=0A=
+	int rc;=0A=
+=0A=
+	/*=0A=
+	 * Acknowledge the chip's notification latches from the threaded=0A=
+	 * handler itself.  With IRQF_ONESHOT the line is unmasked on=0A=
+	 * return, so deferring the W1C clear to the async kworker would=0A=
+	 * let a still-asserted INTRB re-fire immediately (interrupt storm).=0A=
+	 * Clear here, then kick the poll worker to read state and run=0A=
+	 * changes_check.=0A=
+	 */=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_clear_notifications(sitdev);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+	if (rc)=0A=
+		dev_warn_ratelimited(sitdev->dev,=0A=
+				     "IRQ: failed to clear notifications: %d\n",=0A=
+				     rc);=0A=
+=0A=
+	kthread_mod_delayed_work(sitdev->kworker, &sitdev->work, 0);=0A=
+	return IRQ_HANDLED;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dev_start - start normal operation=0A=
+ *=0A=
+ * Fetches initial hardware state, registers all DPLL devices and=0A=
+ * their pins, and starts the periodic monitoring thread.=0A=
+ */=0A=
+int sit9531x_dev_start(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll;=0A=
+	int rc;=0A=
+=0A=
+	/* Fetch device state */=0A=
+	rc =3D sit9531x_dev_state_fetch(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	list_for_each_entry(sitdpll, &sitdev->dplls, list) {=0A=
+		rc =3D sit9531x_dpll_register(sitdpll);=0A=
+		if (rc) {=0A=
+			dev_err_probe(sitdev->dev, rc,=0A=
+				      "Failed to register DPLL%u\n",=0A=
+				      sitdpll->id);=0A=
+			return rc;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	kthread_queue_delayed_work(sitdev->kworker, &sitdev->work, 0);=0A=
+=0A=
+	/* Development/test knobs (best-effort) */=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dev_stop - stop normal operation=0A=
+ *=0A=
+ * Cancels the monitoring thread and unregisters all DPLL devices=0A=
+ * and their pins.=0A=
+ */=0A=
+void sit9531x_dev_stop(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll;=0A=
+=0A=
+	kthread_cancel_delayed_work_sync(&sitdev->work);=0A=
+=0A=
+	list_for_each_entry(sitdpll, &sitdev->dplls, list) {=0A=
+		if (sitdpll->dpll_dev)=0A=
+			sit9531x_dpll_unregister(sitdpll);=0A=
+	}=0A=
+}=0A=
+=0A=
+static struct sit9531x_dpll_pin *=0A=
+sit9531x_dpll_pin_alloc(struct sit9531x_dpll *sitdpll,=0A=
+			enum dpll_pin_direction dir, u8 id)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *pin;=0A=
+=0A=
+	pin =3D kzalloc_obj(*pin, GFP_KERNEL);=0A=
+	if (!pin)=0A=
+		return ERR_PTR(-ENOMEM);=0A=
+=0A=
+	pin->dpll =3D sitdpll;=0A=
+	pin->dir =3D dir;=0A=
+	pin->id =3D id;=0A=
+=0A=
+	return pin;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_pin_register - register a DPLL pin with the subsystem=0A=
+ * @index:	absolute pin index for clock_id namespace=0A=
+ *=0A=
+ * Gets pin properties from firmware, creates or gets a dpll_pin,=0A=
+ * and registers it with the parent DPLL device.=0A=
+ */=0A=
+static int sit9531x_dpll_pin_register(struct sit9531x_dpll_pin *pin,=0A=
+				      u32 index)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D pin->dpll;=0A=
+	struct sit9531x_pin_props *props;=0A=
+	const struct dpll_pin_ops *ops;=0A=
+	int rc;=0A=
+=0A=
+	props =3D sit9531x_pin_props_get(sitdpll->dev, pin->dir, pin->id);=0A=
+	if (IS_ERR(props))=0A=
+		return PTR_ERR(props);=0A=
+=0A=
+	strscpy(pin->label, props->package_label, sizeof(pin->label));=0A=
+	pin->fwnode =3D fwnode_handle_get(props->fwnode);=0A=
+	pin->esync_control =3D props->esync_control;=0A=
+=0A=
+	pin->dpll_pin =3D dpll_pin_get(sitdpll->dev->clock_id, index,=0A=
+				     THIS_MODULE, &props->dpll_props,=0A=
+				     &pin->tracker);=0A=
+	if (IS_ERR(pin->dpll_pin)) {=0A=
+		rc =3D PTR_ERR(pin->dpll_pin);=0A=
+		goto err_pin_get;=0A=
+	}=0A=
+	dpll_pin_fwnode_set(pin->dpll_pin, props->fwnode);=0A=
+=0A=
+	ops =3D sit9531x_dpll_pin_ops_get(pin);=0A=
+=0A=
+	rc =3D dpll_pin_register(sitdpll->dpll_dev, pin->dpll_pin, ops, pin);=0A=
+	if (rc)=0A=
+		goto err_register;=0A=
+=0A=
+	sit9531x_pin_props_put(props);=0A=
+=0A=
+	return 0;=0A=
+=0A=
+err_register:=0A=
+	dpll_pin_put(pin->dpll_pin, &pin->tracker);=0A=
+err_pin_get:=0A=
+	/* dpll_pin_get() left an ERR_PTR here. */=0A=
+	pin->dpll_pin =3D NULL;=0A=
+	fwnode_handle_put(pin->fwnode);=0A=
+	pin->fwnode =3D NULL;=0A=
+	sit9531x_pin_props_put(props);=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+static void sit9531x_dpll_pin_unregister(struct sit9531x_dpll_pin *pin)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D pin->dpll;=0A=
+	const struct dpll_pin_ops *ops;=0A=
+=0A=
+	ops =3D sit9531x_dpll_pin_ops_get(pin);=0A=
+=0A=
+	dpll_pin_unregister(sitdpll->dpll_dev, pin->dpll_pin, ops, pin);=0A=
+	dpll_pin_put(pin->dpll_pin, &pin->tracker);=0A=
+	pin->dpll_pin =3D NULL;=0A=
+=0A=
+	fwnode_handle_put(pin->fwnode);=0A=
+	pin->fwnode =3D NULL;=0A=
+}=0A=
+=0A=
+static void sit9531x_dpll_pins_unregister(struct sit9531x_dpll *sitdpll)=
=0A=
+{=0A=
+	struct sit9531x_dpll_pin *pin, *next;=0A=
+=0A=
+	list_for_each_entry_safe(pin, next, &sitdpll->pins, list) {=0A=
+		sit9531x_dpll_pin_unregister(pin);=0A=
+		list_del(&pin->list);=0A=
+		kfree(pin);=0A=
+	}=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_pin_is_registrable - check if an input pin is registrabl=
e=0A=
+ *=0A=
+ * Split out so input-model changes stay local to this helper.=0A=
+ *=0A=
+ * Return: true if the input pin should be registered, false otherwise=0A=
+ */=0A=
+static bool sit9531x_input_pin_is_registrable(struct sit9531x_dev *sitdev,=
=0A=
+					      u8 index)=0A=
+{=0A=
+	if (index >=3D sitdev->info->num_inputs)=0A=
+		return false;=0A=
+=0A=
+	/*=0A=
+	 * The N lane of a differentially-configured pair is not a=0A=
+	 * standalone input and is skipped (zl3073x model).=0A=
+	 */=0A=
+	if (sit9531x_input_is_n(index) &&=0A=
+	    sitdev->ref[index].sig_mode =3D=3D SIT9531X_MODE_DE)=0A=
+		return false;=0A=
+=0A=
+	return true;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_pin_is_registrable - check if a pin should be registered=
=0A=
+ * @dir:	pin direction=0A=
+ * @index:	pin hardware index=0A=
+ *=0A=
+ * For input pins: delegate to sit9531x_input_pin_is_registrable().=0A=
+ * For output pins: the pin is registrable if this DPLL is routed to it,=
=0A=
+ * whether or not it is currently driving.=0A=
+ *=0A=
+ * Return: true if pin should be registered, false otherwise=0A=
+ */=0A=
+static bool sit9531x_dpll_pin_is_registrable(struct sit9531x_dpll *sitdpll=
,=0A=
+					     enum dpll_pin_direction dir,=0A=
+					     u8 index)=0A=
+{=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT) {=0A=
+		/* The internal INTSYNC and XO pins are always registrable */=0A=
+		if (index =3D=3D SIT9531X_INTSYNC_PIN_ID ||=0A=
+		    index =3D=3D SIT9531X_MAX_INPUTS)=0A=
+			return true;=0A=
+=0A=
+		return sit9531x_input_pin_is_registrable(sitdev, index);=0A=
+	}=0A=
+=0A=
+	/* The internal INTSYNC source pin is always registrable */=0A=
+	if (index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID)=0A=
+		return true;=0A=
+=0A=
+	/* Output -- check if driven by this DPLL */=0A=
+	if (index >=3D sitdev->info->num_outputs)=0A=
+		return false;=0A=
+=0A=
+	/*=0A=
+	 * Routing, not the current drive state: an output the initial=0A=
+	 * configuration muted still gets a pin, so userspace can see it and=0A=
+	 * un-mute it.  Only outputs no PLL drives are left unregistered.=0A=
+	 */=0A=
+	return sitdev->out[index].pll_idx =3D=3D sitdpll->id &&=0A=
+	       sitdev->out[index].routed;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_pins_register - register all registrable pins=0A=
+ *=0A=
+ * Enumerates all possible input and output pins, checks registrability,=
=0A=
+ * and registers each one.  Input pins come first, then output pins,=0A=
+ * with input pins first, then output pins.=0A=
+ */=0A=
+static int sit9531x_dpll_pins_register(struct sit9531x_dpll *sitdpll)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *pin;=0A=
+	enum dpll_pin_direction dir;=0A=
+	u8 id, index;=0A=
+	int rc;=0A=
+=0A=
+	for (index =3D 0; index < SIT9531X_NUM_PINS_TOTAL; index++) {=0A=
+		if (index < SIT9531X_NUM_INPUT_PINS) {=0A=
+			id =3D index;=0A=
+			dir =3D DPLL_PIN_DIRECTION_INPUT;=0A=
+		} else {=0A=
+			id =3D index - SIT9531X_NUM_INPUT_PINS;=0A=
+			dir =3D DPLL_PIN_DIRECTION_OUTPUT;=0A=
+		}=0A=
+=0A=
+		if (!sit9531x_dpll_pin_is_registrable(sitdpll, dir, id))=0A=
+			continue;=0A=
+=0A=
+		pin =3D sit9531x_dpll_pin_alloc(sitdpll, dir, id);=0A=
+		if (IS_ERR(pin)) {=0A=
+			rc =3D PTR_ERR(pin);=0A=
+			goto error;=0A=
+		}=0A=
+=0A=
+		rc =3D sit9531x_dpll_pin_register(pin, index);=0A=
+		if (rc) {=0A=
+			kfree(pin);=0A=
+			goto error;=0A=
+		}=0A=
+=0A=
+		list_add(&pin->list, &sitdpll->pins);=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+=0A=
+error:=0A=
+	sit9531x_dpll_pins_unregister(sitdpll);=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+static int sit9531x_dpll_device_register(struct sit9531x_dpll *sitdpll)=0A=
+{=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc;=0A=
+=0A=
+	sitdpll->ops =3D sit9531x_dpll_device_ops;=0A=
+=0A=
+	sitdpll->dpll_dev =3D dpll_device_get(sitdev->clock_id, sitdpll->id,=0A=
+					    THIS_MODULE, &sitdpll->tracker);=0A=
+	if (IS_ERR(sitdpll->dpll_dev)) {=0A=
+		rc =3D PTR_ERR(sitdpll->dpll_dev);=0A=
+		sitdpll->dpll_dev =3D NULL;=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	rc =3D dpll_device_register(sitdpll->dpll_dev,=0A=
+				  sit9531x_prop_dpll_type_get(sitdev,=0A=
+							      sitdpll->id),=0A=
+				  &sitdpll->ops, sitdpll);=0A=
+	if (rc) {=0A=
+		dpll_device_put(sitdpll->dpll_dev, &sitdpll->tracker);=0A=
+		sitdpll->dpll_dev =3D NULL;=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+static void sit9531x_dpll_device_unregister(struct sit9531x_dpll *sitdpll)=
=0A=
+{=0A=
+	dpll_device_unregister(sitdpll->dpll_dev, &sitdpll->ops, sitdpll);=0A=
+	dpll_device_put(sitdpll->dpll_dev, &sitdpll->tracker);=0A=
+	sitdpll->dpll_dev =3D NULL;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_alloc - allocate a DPLL device structure=0A=
+ * @sitdev:	parent device=0A=
+ * @ch:		PLL channel number (0-3)=0A=
+ *=0A=
+ * Return: pointer to allocated DPLL on success, error pointer on error=0A=
+ */=0A=
+struct sit9531x_dpll *sit9531x_dpll_alloc(struct sit9531x_dev *sitdev, u8 =
ch)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll;=0A=
+=0A=
+	sitdpll =3D kzalloc_obj(*sitdpll, GFP_KERNEL);=0A=
+	if (!sitdpll)=0A=
+		return ERR_PTR(-ENOMEM);=0A=
+=0A=
+	sitdpll->dev =3D sitdev;=0A=
+	sitdpll->id =3D ch;=0A=
+	sitdpll->lock_status =3D DPLL_LOCK_STATUS_UNLOCKED;=0A=
+	INIT_LIST_HEAD(&sitdpll->pins);=0A=
+=0A=
+	return sitdpll;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_free - deallocate a DPLL device structure=0A=
+ * @sitdpll:	DPLL to free=0A=
+ */=0A=
+void sit9531x_dpll_free(struct sit9531x_dpll *sitdpll)=0A=
+{=0A=
+	kfree(sitdpll);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_register - register DPLL device and all its pins=0A=
+ *=0A=
+ * Registers the DPLL device with the subsystem and then registers=0A=
+ * all input and output pins that are connected to this PLL.=0A=
+ */=0A=
+int sit9531x_dpll_register(struct sit9531x_dpll *sitdpll)=0A=
+{=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_dpll_device_register(sitdpll);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_dpll_pins_register(sitdpll);=0A=
+	if (rc) {=0A=
+		sit9531x_dpll_device_unregister(sitdpll);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/* sit9531x_dpll_unregister - unregister DPLL device and its pins */=0A=
+void sit9531x_dpll_unregister(struct sit9531x_dpll *sitdpll)=0A=
+{=0A=
+	sit9531x_dpll_pins_unregister(sitdpll);=0A=
+	sit9531x_dpll_device_unregister(sitdpll);=0A=
+}=0A=
+=0A=
+static void sit9531x_dpll_list_free(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll, *next;=0A=
+=0A=
+	list_for_each_entry_safe(sitdpll, next, &sitdev->dplls, list) {=0A=
+		list_del(&sitdpll->list);=0A=
+		sit9531x_dpll_free(sitdpll);=0A=
+	}=0A=
+}=0A=
+=0A=
+/* Runs only once the device is fully started, see the caller. */=0A=
+static void sit9531x_dev_dpll_fini(void *ptr)=0A=
+{=0A=
+	struct sit9531x_dev *sitdev =3D ptr;=0A=
+=0A=
+	sit9531x_dev_stop(sitdev);=0A=
+	kthread_destroy_worker(sitdev->kworker);=0A=
+	sit9531x_dpll_list_free(sitdev);=0A=
+}=0A=
+=0A=
+static int sit9531x_devm_dpll_init(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	struct kthread_worker *kworker;=0A=
+	struct sit9531x_dpll *sitdpll;=0A=
+	unsigned int i;=0A=
+	int rc;=0A=
+=0A=
+	INIT_LIST_HEAD(&sitdev->dplls);=0A=
+	kthread_init_delayed_work(&sitdev->work, sit9531x_dev_periodic_work);=0A=
+=0A=
+	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
+		sitdpll =3D sit9531x_dpll_alloc(sitdev, i);=0A=
+		if (IS_ERR(sitdpll)) {=0A=
+			rc =3D dev_err_probe(sitdev->dev, PTR_ERR(sitdpll),=0A=
+					   "Failed to alloc DPLL%u\n", i);=0A=
+			goto err_free_dplls;=0A=
+		}=0A=
+=0A=
+		list_add_tail(&sitdpll->list, &sitdev->dplls);=0A=
+	}=0A=
+=0A=
+	kworker =3D kthread_run_worker(0, "sit9531x-%s", dev_name(sitdev->dev));=
=0A=
+	if (IS_ERR(kworker)) {=0A=
+		rc =3D PTR_ERR(kworker);=0A=
+		goto err_free_dplls;=0A=
+	}=0A=
+	sitdev->kworker =3D kworker;=0A=
+=0A=
+	rc =3D sit9531x_dev_start(sitdev);=0A=
+	if (rc) {=0A=
+		rc =3D dev_err_probe(sitdev->dev, rc, "Failed to start device\n");=0A=
+		goto err_destroy_worker;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Only now is every field the cleanup touches valid, so this is the=0A=
+	 * first point at which the action may be registered.  On failure it=0A=
+	 * runs the action itself, which is correct here and only here.=0A=
+	 */=0A=
+	return devm_add_action_or_reset(sitdev->dev, sit9531x_dev_dpll_fini,=0A=
+					sitdev);=0A=
+=0A=
+err_destroy_worker:=0A=
+	kthread_destroy_worker(sitdev->kworker);=0A=
+err_free_dplls:=0A=
+	sit9531x_dpll_list_free(sitdev);=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_read_variant_id - read chip variant ID byte from hardware=0A=
+ * @id:		output variant ID byte=0A=
+ *=0A=
+ * Reads the single-byte variant identification register from Page 0=0A=
+ * reg 0x02 (95317 =3D 0x17, 95316 =3D 0x31).  Reg 0x03 holds a separate=
=0A=
+ * revision byte and is intentionally not consumed here.=0A=
+ */=0A=
+static int sit9531x_read_variant_id(struct sit9531x_dev *sitdev, u8 *id)=
=0A=
+{=0A=
+	return sit9531x_read_u8(sitdev, SIT9531X_REG_VARIANT_ID, id);=0A=
+}=0A=
+=0A=
+static const struct sit9531x_chip_info *sit9531x_match_variant(u8 id)=0A=
+{=0A=
+	unsigned int i;=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(sit9531x_chip_ids); i++) {=0A=
+		if (sit9531x_chip_ids[i].id =3D=3D id)=0A=
+			return &sit9531x_chip_ids[i];=0A=
+	}=0A=
+=0A=
+	return NULL;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_derive_clock_id - build EUI-64 clock identifier=0A=
+ *=0A=
+ * Generates a deterministic 64-bit identifier from the SiTime OUI,=0A=
+ * the chip ID, and the I2C address.  This provides a stable clock_id=0A=
+ * across reboots.=0A=
+ *=0A=
+ * Return: 64-bit clock identifier=0A=
+ */=0A=
+static u64 sit9531x_derive_clock_id(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	u64 clkid;=0A=
+=0A=
+	clkid  =3D SIT9531X_OUI << 24;=0A=
+	clkid |=3D (u64)sitdev->info->id << 8;=0A=
+	clkid |=3D (u64)sitdev->client->addr;=0A=
+=0A=
+	return clkid;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Board-config overrides for fixed efuse/blob routing the chip registers =
do=0A=
+ * not describe unambiguously.  Absent properties leave pll_fvco[] zeroed=
=0A=
+ * (derive from DIVN) and out_pll_map_valid false (use the OUT_MAP registe=
rs).=0A=
+ */=0A=
+static void sit9531x_parse_board_config(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	u32 map[SIT9531X_MAX_OUTPUTS];=0A=
+	int n, i;=0A=
+=0A=
+	device_property_read_u64_array(sitdev->dev, "sitime,pll-fvco",=0A=
+				       sitdev->pll_fvco, SIT9531X_NUM_PLLS);=0A=
+=0A=
+	if (!device_property_present(sitdev->dev, "sitime,output-pll-map"))=0A=
+		return;=0A=
+=0A=
+	/*=0A=
+	 * Any 1..MAX_OUTPUTS length is accepted so the 8-output SiT95317 need=0A=
+	 * not pad to 12; variant detection has not run yet and entries past=0A=
+	 * the detected num_outputs are never indexed.  Trailing entries of a=0A=
+	 * short map must read as unmapped rather than 0 (=3D=3D PLLA), which=0A=
+	 * would mark unrouted outputs active in sit9531x_out_state_fetch().=0A=
+	 */=0A=
+	memset(sitdev->out_pll_map, SIT9531X_OUT_PLL_UNMAPPED,=0A=
+	       sizeof(sitdev->out_pll_map));=0A=
+=0A=
+	n =3D device_property_count_u32(sitdev->dev, "sitime,output-pll-map");=0A=
+	if (n <=3D 0 || n > SIT9531X_MAX_OUTPUTS ||=0A=
+	    device_property_read_u32_array(sitdev->dev, "sitime,output-pll-map",=
=0A=
+					   map, n))=0A=
+		return;=0A=
+=0A=
+	for (i =3D 0; i < n; i++)=0A=
+		sitdev->out_pll_map[i] =3D map[i];=0A=
+	sitdev->out_pll_map_valid =3D true;=0A=
+}=0A=
+=0A=
+int sit9531x_dev_probe(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	struct clk *xtal_clk;=0A=
+	u8 variant_id;=0A=
+	int rc;=0A=
+=0A=
+	/*=0A=
+	 * Fvco =3D Fref * (DIVN + frac/2^32) with Fref =3D xtal_freq << doubler,=
=0A=
+	 * so every freq_set and phase_adjust path divides by a rate derived=0A=
+	 * from the XO feeding XIN/XO_CLK.=0A=
+	 */=0A=
+	xtal_clk =3D devm_clk_get_enabled(sitdev->dev, "xtal");=0A=
+	if (IS_ERR(xtal_clk))=0A=
+		return dev_err_probe(sitdev->dev, PTR_ERR(xtal_clk),=0A=
+				     "Failed to get xtal clock\n");=0A=
+	sitdev->xtal_freq =3D clk_get_rate(xtal_clk);=0A=
+	if (!sitdev->xtal_freq)=0A=
+		return dev_err_probe(sitdev->dev, -EINVAL,=0A=
+				     "xtal clock has no rate\n");=0A=
+=0A=
+	/*=0A=
+	 * Held deasserted, never pulsed: the chip configuration comes from=0A=
+	 * efuse or an NVM blob applied before probe, and a reset would=0A=
+	 * discard it.  Must precede the first I2C access, as a board that=0A=
+	 * powers up asserted keeps the chip unreachable until released.=0A=
+	 */=0A=
+	sitdev->reset_gpio =3D devm_gpiod_get_optional(sitdev->dev, "reset",=0A=
+						     GPIOD_OUT_LOW);=0A=
+	if (IS_ERR(sitdev->reset_gpio))=0A=
+		return dev_err_probe(sitdev->dev, PTR_ERR(sitdev->reset_gpio),=0A=
+				     "Failed to request reset gpio\n");=0A=
+	if (sitdev->reset_gpio)=0A=
+		fsleep(10000);	/* internal boot after release */=0A=
+=0A=
+	sit9531x_parse_board_config(sitdev);=0A=
+=0A=
+	rc =3D sit9531x_read_variant_id(sitdev, &variant_id);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	sitdev->info =3D sit9531x_match_variant(variant_id);=0A=
+	if (!sitdev->info)=0A=
+		return dev_err_probe(sitdev->dev, -ENODEV,=0A=
+				     "Unknown variant ID: 0x%02x\n", variant_id);=0A=
+=0A=
+	sitdev->clock_id =3D sit9531x_derive_clock_id(sitdev);=0A=
+	sitdev->intsync_src =3D -1;=0A=
+=0A=
+	rc =3D devm_mutex_init(sitdev->dev, &sitdev->multiop_lock);=0A=
+	if (rc)=0A=
+		return dev_err_probe(sitdev->dev, rc,=0A=
+				     "Failed to initialize mutex\n");=0A=
+=0A=
+	/*=0A=
+	 * Before the IRQ: the handler reaches sitdev->kworker through=0A=
+	 * kthread_mod_delayed_work(), so the worker has to exist before an=0A=
+	 * INTRB assertion can land.=0A=
+	 */=0A=
+	rc =3D sit9531x_devm_dpll_init(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/* Absent "interrupts" leaves client->irq 0 and the poll in charge. */=0A=
+	sitdev->irq =3D sitdev->client ? sitdev->client->irq : 0;=0A=
+	if (sitdev->irq > 0) {=0A=
+		rc =3D devm_request_threaded_irq(sitdev->dev, sitdev->irq,=0A=
+					       NULL, sit9531x_irq_thread_fn,=0A=
+					       IRQF_ONESHOT,=0A=
+					       dev_name(sitdev->dev), sitdev);=0A=
+		if (rc)=0A=
+			return dev_err_probe(sitdev->dev, rc,=0A=
+					     "Failed to request IRQ %d\n",=0A=
+					     sitdev->irq);=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int sit9531x_i2c_probe(struct i2c_client *client)=0A=
+{=0A=
+	struct sit9531x_dev *sitdev;=0A=
+	struct regmap *regmap;=0A=
+=0A=
+	regmap =3D devm_regmap_init_i2c(client, &sit9531x_regmap_config);=0A=
+	if (IS_ERR(regmap))=0A=
+		return dev_err_probe(&client->dev, PTR_ERR(regmap),=0A=
+				     "Failed to initialize regmap\n");=0A=
+=0A=
+	sitdev =3D devm_kzalloc(&client->dev, sizeof(*sitdev), GFP_KERNEL);=0A=
+	if (!sitdev)=0A=
+		return -ENOMEM;=0A=
+=0A=
+	sitdev->dev =3D &client->dev;=0A=
+	sitdev->client =3D client;=0A=
+	sitdev->regmap =3D regmap;=0A=
+	i2c_set_clientdata(client, sitdev);=0A=
+=0A=
+	return sit9531x_dev_probe(sitdev);=0A=
+}=0A=
+=0A=
+static const struct of_device_id sit9531x_of_match[] =3D {=0A=
+	{ .compatible =3D "sitime,sit95316" },=0A=
+	{ .compatible =3D "sitime,sit95317" },=0A=
+	{ }=0A=
+};=0A=
+MODULE_DEVICE_TABLE(of, sit9531x_of_match);=0A=
+=0A=
+static struct i2c_driver sit9531x_i2c_driver =3D {=0A=
+	.driver =3D {=0A=
+		.name		=3D "sit9531x",=0A=
+		.of_match_table	=3D sit9531x_of_match,=0A=
+	},=0A=
+	.probe		=3D sit9531x_i2c_probe,=0A=
+};=0A=
+module_i2c_driver(sit9531x_i2c_driver);=0A=
+=0A=
+MODULE_AUTHOR("Ali Rouhi <arouhi@sitime.com>");=0A=
+MODULE_AUTHOR("Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>");=0A=
+MODULE_DESCRIPTION("SiTime SiT9531x DPLL subsystem driver");=0A=
+MODULE_LICENSE("GPL");=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
new file mode 100644=0A=
index 000000000000..05d4ee0c712e=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -0,0 +1,372 @@=0A=
+/* SPDX-License-Identifier: GPL-2.0 */=0A=
+/*=0A=
+ * SiTime SiT9531x DPLL core driver=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ *=0A=
+ * Device structure, register access helpers, and core function=0A=
+ * declarations.=0A=
+ */=0A=
+=0A=
+#ifndef _SIT9531X_CORE_H=0A=
+#define _SIT9531X_CORE_H=0A=
+=0A=
+#include <linux/gpio/consumer.h>=0A=
+#include <linux/i2c.h>=0A=
+#include <linux/kthread.h>=0A=
+#include <linux/list.h>=0A=
+#include <linux/mutex.h>=0A=
+#include <linux/regmap.h>=0A=
+#include <linux/types.h>=0A=
+=0A=
+#include "regs.h"=0A=
+=0A=
+#define SIT9531X_NUM_PLLS		4=0A=
+#define SIT9531X_MAX_INPUTS		8=0A=
+#define SIT9531X_NUM_INPUT_PAIRS	(SIT9531X_MAX_INPUTS / 2)=0A=
+#define SIT9531X_MAX_OUTPUTS		12=0A=
+/* out_pll_map[] entry meaning "this output is not routed to any PLL" */=
=0A=
+#define SIT9531X_OUT_PLL_UNMAPPED	0xFF=0A=
+/*=0A=
+ * INTSYNC (the inter-PLL sync net) is modelled as two pins.  The=0A=
+ * destination PLL that locks to INTSYNC sees an input pin=0A=
+ * (SIT9531X_INTSYNC_PIN_ID, in the input id namespace after the physical=
=0A=
+ * inputs and the xtal); the source PLL that drives INTSYNC sees an output=
=0A=
+ * pin (SIT9531X_INTSYNC_OUT_PIN_ID, appended after the physical outputs).=
=0A=
+ */=0A=
+#define SIT9531X_INTSYNC_PIN_ID		(SIT9531X_MAX_INPUTS + 1)=0A=
+#define SIT9531X_INTSYNC_OUT_PIN_ID	SIT9531X_MAX_OUTPUTS=0A=
+#define SIT9531X_NUM_PINS		(SIT9531X_MAX_INPUTS + 2 + SIT9531X_MAX_OUTPUTS=
 + 1)=0A=
+#define SIT9531X_STATUS_POLL_MS		500=0A=
+=0A=
+/* selected_ref value when the active source is not a registered input */=
=0A=
+#define SIT9531X_REF_INVALID		0xFF=0A=
+=0A=
+/* SiTime IEEE OUI for EUI-64 generation */=0A=
+#define SIT9531X_OUI			0x0090C2FFFEULL=0A=
+=0A=
+struct sit9531x_dpll;=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_chip_info - chip variant identification=0A=
+ * @id:		variant ID byte read from register=0A=
+ * @num_inputs:	number of input clock pins=0A=
+ * @num_outputs: number of output clock pins=0A=
+ * @name:	human-readable variant name=0A=
+ * @clkout_map:	per-output slot mapping (output index -> physical slot)=0A=
+ */=0A=
+struct sit9531x_chip_info {=0A=
+	u8		id;=0A=
+	u8		num_inputs;=0A=
+	u8		num_outputs;=0A=
+	const char	*name;=0A=
+	const u8	*clkout_map;=0A=
+};=0A=
+=0A=
+/*=0A=
+ * enum sit9531x_signal_mode - input signal electrical mode=0A=
+ * @SIT9531X_MODE_SE: single-ended=0A=
+ * @SIT9531X_MODE_DE: differential=0A=
+ */=0A=
+enum sit9531x_signal_mode {=0A=
+	SIT9531X_MODE_SE =3D 0,=0A=
+	SIT9531X_MODE_DE,=0A=
+};=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_ref - input reference state=0A=
+ * @freq:		configured frequency in Hz=0A=
+ * @enabled:		reference is enabled for monitoring=0A=
+ * @los:		loss-of-signal detected=0A=
+ * @oof:		out-of-frequency detected=0A=
+ * @pll_mask:		bitmask of PLLs this input feeds (bit 0 =3D PLLA)=0A=
+ * @label:		board label from DT or default=0A=
+ * @sig_mode:		signal mode of the pair this lane belongs to=0A=
+ *			(detected from CLKINx_INPUT_MODE at probe)=0A=
+ */=0A=
+struct sit9531x_ref {=0A=
+	u32		freq;=0A=
+	bool		enabled;=0A=
+	bool		los;=0A=
+	bool		oof;=0A=
+	u8		pll_mask;=0A=
+	const char	*label;=0A=
+	enum sit9531x_signal_mode	sig_mode;=0A=
+};=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_out - output state=0A=
+ * @enabled:		output is driving, i.e. not forced into Hi-Z=0A=
+ * @routed:		output is mapped to @pll_idx by the initial=0A=
+ *			configuration; an unrouted output has no DPLL pin=0A=
+ * @pll_idx:		PLL driving this output (0-3)=0A=
+ * @label:		board label from DT or default=0A=
+ */=0A=
+struct sit9531x_out {=0A=
+	u32		freq;=0A=
+	bool		enabled;=0A=
+	bool		routed;=0A=
+	u8		pll_idx;=0A=
+	const char	*label;=0A=
+};=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_chan - per-PLL channel state=0A=
+ * @active:		PLL has reached its active state; a PLL the loaded=0A=
+ *			configuration leaves unused never does, and its=0A=
+ *			loss-of-lock bit stays clear because nothing drives it=0A=
+ * @locked:		PLL is locked (raw status register bit)=0A=
+ * @mode:		0 =3D sync (outer loop enabled), 1 =3D free-run=0A=
+ * @selected_ref:	logical input index of the currently selected=0A=
+ *			reference (the INTSYNC net maps to=0A=
+ *			SIT9531X_INTSYNC_PIN_ID), or SIT9531X_REF_INVALID=0A=
+ *			when the hardware source encoding is reserved=0A=
+ * @inner_lol:		PLL inner loop loss-of-lock detected=0A=
+ * @ho_freeze:		holdover freeze active=0A=
+ */=0A=
+struct sit9531x_chan {=0A=
+	bool		active;=0A=
+	bool		locked;=0A=
+	u8		mode;=0A=
+	u8		selected_ref;=0A=
+	bool		inner_lol;=0A=
+	bool		ho_freeze;=0A=
+};=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_dev - SiT9531x device instance=0A=
+ * @info:		detected chip variant info=0A=
+ * @multiop_lock:	mutex for multi-register atomic operations=0A=
+ * @ref:		array of input reference states=0A=
+ * @out:		array of output states=0A=
+ * @chan:		array of per-PLL channel states=0A=
+ * @xtal_freq:		crystal oscillator frequency in Hz=0A=
+ * @kworker:		kthread worker for periodic polling=0A=
+ * @work:		delayed work for periodic state checks=0A=
+ * @clock_id:		IEEE 1588 EUI-64 clock identifier=0A=
+ * @reset_gpio:		optional reset line (DT "reset-gpios"), NULL if absent=0A=
+ * @irq:		optional INTRB IRQ number (from DT "interrupts" via the=0A=
+ *			I2C client), 0 if no IRQ is wired=0A=
+ * @pll_fvco:		optional per-PLL VCO in Hz from DT=0A=
+ *			"sitime,pll-fvco"; 0 means derive from DIVN=0A=
+ * @out_pll_map:	optional per-output source PLL (0-3, 0xff =3D=0A=
+ *			unmapped) from DT "sitime,output-pll-map"=0A=
+ * @out_pll_map_valid:	true when out_pll_map[] was populated from DT;=0A=
+ *			false means use the chip's OUT_MAP registers=0A=
+ * @intsync_src:	PLL index currently sourcing inter-PLL=0A=
+ *			synchronization (INTSYNC), or -1 when disabled=0A=
+ */=0A=
+struct sit9531x_dev {=0A=
+	struct device			*dev;=0A=
+	struct i2c_client		*client;=0A=
+	struct regmap			*regmap;=0A=
+	const struct sit9531x_chip_info	*info;=0A=
+	/* Serializes multi-step register sequences */=0A=
+	struct mutex			multiop_lock;=0A=
+=0A=
+	/* Hardware state */=0A=
+	struct sit9531x_ref	ref[SIT9531X_MAX_INPUTS + 1]; /* +1 for xtal */=0A=
+	struct sit9531x_out	out[SIT9531X_MAX_OUTPUTS];=0A=
+	struct sit9531x_chan	chan[SIT9531X_NUM_PLLS];=0A=
+	u32			xtal_freq;=0A=
+=0A=
+	/* DPLL channels */=0A=
+	struct list_head	dplls;=0A=
+=0A=
+	/* Monitor */=0A=
+	struct kthread_worker		*kworker;=0A=
+	struct kthread_delayed_work	work;=0A=
+=0A=
+	/* Device identity */=0A=
+	u64			clock_id;=0A=
+=0A=
+	/* Optional DT-described GPIO / IRQ lines */=0A=
+	struct gpio_desc	*reset_gpio;=0A=
+	int			irq;=0A=
+=0A=
+	/* Optional DT board-config overrides */=0A=
+	u64			pll_fvco[SIT9531X_NUM_PLLS];=0A=
+	u8			out_pll_map[SIT9531X_MAX_OUTPUTS];=0A=
+	bool			out_pll_map_valid;=0A=
+=0A=
+	/* Inter-PLL synchronization state */=0A=
+	s8			intsync_src;=0A=
+=0A=
+};=0A=
+=0A=
+extern const struct regmap_config sit9531x_regmap_config;=0A=
+=0A=
+/* ---- Core lifecycle ---- */=0A=
+int  sit9531x_dev_probe(struct sit9531x_dev *sitdev);=0A=
+int  sit9531x_dev_start(struct sit9531x_dev *sitdev);=0A=
+void sit9531x_dev_stop(struct sit9531x_dev *sitdev);=0A=
+=0A=
+/* ---- Register access ---- */=0A=
+int sit9531x_read_u8(struct sit9531x_dev *sitdev, unsigned int reg,=0A=
+		     u8 *val);=0A=
+int sit9531x_write_u8(struct sit9531x_dev *sitdev, unsigned int reg,=0A=
+		      u8 val);=0A=
+int sit9531x_read_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			 u8 offset, u8 *val);=0A=
+int sit9531x_write_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			  u8 offset, u8 val);=0A=
+int sit9531x_update_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			   u8 offset, u8 mask, u8 val);=0A=
+=0A=
+/* ---- Input enable/disable ---- */=0A=
+int sit9531x_input_disable(struct sit9531x_dev *sitdev, u8 index);=0A=
+int sit9531x_input_enable(struct sit9531x_dev *sitdev, u8 index);=0A=
+=0A=
+/* ---- Input priority ---- */=0A=
+int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx, u8 prio);=0A=
+int sit9531x_input_prio_get(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx, u8 *prio);=0A=
+int sit9531x_input_prio_remove(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       u8 input_idx);=0A=
+int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx);=0A=
+=0A=
+/* ---- Output enable/disable (Hi-Z control) ---- */=0A=
+int sit9531x_output_disable(struct sit9531x_dev *sitdev, u8 index);=0A=
+int sit9531x_output_enable(struct sit9531x_dev *sitdev, u8 index);=0A=
+=0A=
+/* ---- Output frequency ---- */=0A=
+int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			     u8 pll_idx, u64 frequency);=0A=
+int sit9531x_output_freq_get(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			     u64 *frequency);=0A=
+=0A=
+/* ---- Output phase adjust (PRG_RST_DELAY register-based) ---- */=0A=
+int sit9531x_output_phase_adjust_set(struct sit9531x_dev *sitdev,=0A=
+				     u8 out_idx, s32 phase_ps);=0A=
+=0A=
+/* ---- Notification clear ---- */=0A=
+int sit9531x_clear_notifications(struct sit9531x_dev *sitdev);=0A=
+=0A=
+/* ---- INTSYNC (inter-PLL synchronization) ---- */=0A=
+int sit9531x_intsync_enable(struct sit9531x_dev *sitdev, u8 src_pll_idx);=
=0A=
+int sit9531x_intsync_disable(struct sit9531x_dev *sitdev, u8 src_pll_idx);=
=0A=
+=0A=
+/* ---- Output pulse control ---- */=0A=
+int sit9531x_output_pulse_ctrl_set(struct sit9531x_dev *sitdev,=0A=
+				   u8 out_idx, u8 pulse_ctrl);=0A=
+=0A=
+/* ---- Phase offset (TDC readback) ---- */=0A=
+int sit9531x_pll_ffo_ppt(struct sit9531x_dev *sitdev, u8 pll_idx, s64 *ffo=
);=0A=
+int sit9531x_phase_offset_read(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       s64 *phase_ps);=0A=
+=0A=
+/* ---- State helpers ---- */=0A=
+=0A=
+/*=0A=
+ * sit9531x_pll_page - get register page for PLL index=0A=
+ * @pll_idx: PLL index (0 =3D PLLA, 3 =3D PLLD)=0A=
+ */=0A=
+static inline u8 sit9531x_pll_page(u8 pll_idx)=0A=
+{=0A=
+	return SIT9531X_PAGE_PLLA + pll_idx;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Logical input pins are interleaved: even index =3D P lane, odd=0A=
+ * index =3D N lane of pair index/2 (IN0P, IN0N, IN1P, IN1N, ...).=0A=
+ * Index SIT9531X_MAX_INPUTS is the XO input.=0A=
+ */=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_pair - get input pair number for a logical input index=
=0A=
+ * @index: logical input pin index=0A=
+ */=0A=
+static inline u8 sit9531x_input_pair(u8 index)=0A=
+{=0A=
+	return index >> 1;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_is_n - check if a logical input index is an N lane=0A=
+ * @index: logical input pin index=0A=
+ */=0A=
+static inline bool sit9531x_input_is_n(u8 index)=0A=
+{=0A=
+	return index & 1;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_hw_src - translate logical input index to source encodin=
g=0A=
+ * @index: logical input pin index=0A=
+ *=0A=
+ * The priority table and CLK_ACTIVESEL registers use a non-contiguous=0A=
+ * source encoding: 0-3 =3D CLK0P..CLK3P, 5 =3D OCXO, 6 =3D INTSYNC,=0A=
+ * 7-10 =3D CLK0N..CLK3N.=0A=
+ */=0A=
+static inline u8 sit9531x_input_hw_src(u8 index)=0A=
+{=0A=
+	if (index =3D=3D SIT9531X_MAX_INPUTS)=0A=
+		return SIT9531X_PRIO_SRC_OCXO;=0A=
+	if (index =3D=3D SIT9531X_INTSYNC_PIN_ID)=0A=
+		return SIT9531X_PRIO_SRC_INTSYNC;=0A=
+	if (sit9531x_input_is_n(index))=0A=
+		return SIT9531X_PRIO_SRC_N_BASE + sit9531x_input_pair(index);=0A=
+	return sit9531x_input_pair(index);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_hw_src_input - translate source encoding to logical input inde=
x=0A=
+ * @src: 4-bit hardware source encoding=0A=
+ *=0A=
+ * Return: logical input index (INTSYNC maps to SIT9531X_INTSYNC_PIN_ID),=
=0A=
+ * or SIT9531X_REF_INVALID if @src is a reserved value=0A=
+ */=0A=
+static inline u8 sit9531x_hw_src_input(u8 src)=0A=
+{=0A=
+	if (src < SIT9531X_NUM_INPUT_PAIRS)=0A=
+		return src * 2;=0A=
+	if (src =3D=3D SIT9531X_PRIO_SRC_OCXO)=0A=
+		return SIT9531X_MAX_INPUTS;=0A=
+	if (src =3D=3D SIT9531X_PRIO_SRC_INTSYNC)=0A=
+		return SIT9531X_INTSYNC_PIN_ID;=0A=
+	if (src >=3D SIT9531X_PRIO_SRC_N_BASE &&=0A=
+	    src < SIT9531X_PRIO_SRC_N_BASE + SIT9531X_NUM_INPUT_PAIRS)=0A=
+		return (src - SIT9531X_PRIO_SRC_N_BASE) * 2 + 1;=0A=
+	return SIT9531X_REF_INVALID;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_ref_state_get - get reference state by index=0A=
+ * @index:	logical input index=0A=
+ *=0A=
+ * Return: pointer to the cached input reference state=0A=
+ */=0A=
+static inline const struct sit9531x_ref *=0A=
+sit9531x_ref_state_get(const struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	return &sitdev->ref[index];=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_out_state_get - get output state by index=0A=
+ * @index:	logical output index=0A=
+ *=0A=
+ * Return: pointer to the cached output state=0A=
+ */=0A=
+static inline const struct sit9531x_out *=0A=
+sit9531x_out_state_get(const struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	return &sitdev->out[index];=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_chan_state_get - get channel state by PLL index=0A=
+ *=0A=
+ * Return: pointer to the cached per-PLL channel state=0A=
+ */=0A=
+static inline const struct sit9531x_chan *=0A=
+sit9531x_chan_state_get(const struct sit9531x_dev *sitdev, u8 pll_idx)=0A=
+{=0A=
+	return &sitdev->chan[pll_idx];=0A=
+}=0A=
+=0A=
+#endif /* _SIT9531X_CORE_H */=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
new file mode 100644=0A=
index 000000000000..364f870ac304=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -0,0 +1,1202 @@=0A=
+// SPDX-License-Identifier: GPL-2.0=0A=
+/*=0A=
+ * SiTime SiT9531x DPLL subsystem callbacks and registration=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ *=0A=
+ * DPLL device ops, pin ops (separate input/output), pin registration,=0A=
+ * and periodic change detection.=0A=
+ */=0A=
+=0A=
+#include <linux/dpll.h>=0A=
+#include <linux/err.h>=0A=
+#include <linux/kthread.h>=0A=
+#include <linux/list.h>=0A=
+#include <linux/netlink.h>=0A=
+#include <linux/slab.h>=0A=
+=0A=
+#include "core.h"=0A=
+#include "dpll.h"=0A=
+#include "prop.h"=0A=
+#include "regs.h"=0A=
+=0A=
+#define SIT9531X_ESYNC_FREQ_10MHZ	10000000ULL=0A=
+#define SIT9531X_ESYNC_PULSE_DEFAULT	50=0A=
+=0A=
+static const struct dpll_pin_frequency sit9531x_esync_ranges[] =3D {=0A=
+	DPLL_PIN_FREQUENCY(0),=0A=
+	DPLL_PIN_FREQUENCY(SIT9531X_ESYNC_FREQ_10MHZ),=0A=
+};=0A=
+=0A=
+static inline bool=0A=
+sit9531x_dpll_esync_pin_supported(const struct sit9531x_dpll_pin *dpin)=0A=
+{=0A=
+	return dpin->esync_control;=0A=
+}=0A=
+=0A=
+static inline bool sit9531x_dpll_is_input_pin(const struct sit9531x_dpll_p=
in *pin)=0A=
+{=0A=
+	return pin->dir =3D=3D DPLL_PIN_DIRECTION_INPUT;=0A=
+}=0A=
+=0A=
+static inline bool=0A=
+sit9531x_dpll_is_intsync_pin(const struct sit9531x_dpll_pin *pin)=0A=
+{=0A=
+	return sit9531x_dpll_is_input_pin(pin) &&=0A=
+	       pin->id =3D=3D SIT9531X_INTSYNC_PIN_ID;=0A=
+}=0A=
+=0A=
+static inline bool=0A=
+sit9531x_dpll_is_intsync_src_pin(const struct sit9531x_dpll_pin *pin)=0A=
+{=0A=
+	return !sit9531x_dpll_is_input_pin(pin) &&=0A=
+	       pin->id =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID;=0A=
+}=0A=
+=0A=
+static inline bool=0A=
+sit9531x_dpll_is_xo_pin(const struct sit9531x_dpll_pin *pin)=0A=
+{=0A=
+	return sit9531x_dpll_is_input_pin(pin) &&=0A=
+	       pin->id =3D=3D SIT9531X_MAX_INPUTS;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The cached state this reports comes from the outer loss-of-lock byte=0A=
+ * (page 0, reg 0x06), the PLL mode bit (PLL page, reg 0x31), inner LOL=0A=
+ * (reg 0x92) and the holdover freeze byte (reg 0x0A).=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_lock_status_get(const struct dpll_device *dpll, void *dpll_p=
riv,=0A=
+			      enum dpll_lock_status *status,=0A=
+			      enum dpll_lock_status_error *status_error,=0A=
+			      struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	const struct sit9531x_chan *chan;=0A=
+=0A=
+	if (status_error)=0A=
+		*status_error =3D DPLL_LOCK_STATUS_ERROR_NONE;=0A=
+=0A=
+	chan =3D sit9531x_chan_state_get(sitdev, sitdpll->id);=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (!chan->active) {=0A=
+		/*=0A=
+		 * A PLL the loaded configuration leaves unused never reaches=0A=
+		 * its active state.  Nothing drives its loss-of-lock bit, so=0A=
+		 * without this it would report a lock it does not have.=0A=
+		 */=0A=
+		*status =3D DPLL_LOCK_STATUS_UNLOCKED;=0A=
+	} else if (chan->locked) {=0A=
+		if (chan->mode)=0A=
+			*status =3D DPLL_LOCK_STATUS_LOCKED;       /* free-run */=0A=
+		else=0A=
+			*status =3D DPLL_LOCK_STATUS_LOCKED_HO_ACQ; /* sync */=0A=
+	} else if (chan->ho_freeze) {=0A=
+		*status =3D DPLL_LOCK_STATUS_HOLDOVER;=0A=
+	} else {=0A=
+		*status =3D DPLL_LOCK_STATUS_UNLOCKED;=0A=
+	}=0A=
+=0A=
+	/* Report inner LOL as an error condition */=0A=
+	if (status_error && chan->inner_lol)=0A=
+		*status_error =3D DPLL_LOCK_STATUS_ERROR_UNDEFINED;=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_mode_get - report current PLL operating mode=0A=
+ *=0A=
+ * reads outer loop disable bit (PLL page reg 0x31[5]).=0A=
+ * Free-run -> MANUAL, sync -> AUTOMATIC.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_mode_get(const struct dpll_device *dpll, void *dpll_priv,=0A=
+		       enum dpll_mode *mode, struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	const struct sit9531x_chan *chan;=0A=
+=0A=
+	chan =3D sit9531x_chan_state_get(sitdev, sitdpll->id);=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	*mode =3D chan->mode ? DPLL_MODE_MANUAL : DPLL_MODE_AUTOMATIC;=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_mode_set - switch PLL between free-run and sync mode=0A=
+ *=0A=
+ * writes PLL page reg 0x31[5] to enable/disable the=0A=
+ * outer loop, then triggers a small update via reg 0x0F.=0A=
+ *=0A=
+ * The driver maps AUTOMATIC to sync mode (outer loop enabled; the PLL=0A=
+ * selects its reference automatically from the priority table) and=0A=
+ * MANUAL to free-run (outer loop disabled via bit 0x31[5]). The chip=0A=
+ * also has a separate manual-active-select path (MANUAL_ACTIVE_SEL_PLL=0A=
+ * plus the per-PLL man_in_sel registers) that can pin one reference=0A=
+ * while still syncing; that path is not wired to a DPLL callback here.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_mode_set(const struct dpll_device *dpll, void *dpll_priv,=0A=
+		       enum dpll_mode mode, struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	u8 val;=0A=
+	int rc;=0A=
+=0A=
+	/*=0A=
+	 * Outer loop disable bit:=0A=
+	 *   0 =3D sync mode (outer loop enabled)  -> AUTOMATIC=0A=
+	 *   1 =3D free-run (outer loop disabled)  -> MANUAL=0A=
+	 */=0A=
+	val =3D (mode =3D=3D DPLL_MODE_MANUAL) ? SIT9531X_PLL_STATUS_OUTER_DIS : =
0;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	rc =3D sit9531x_update_pll_u8(sitdev, sitdpll->id,=0A=
+				    SIT9531X_PLL_REG_STATUS,=0A=
+				    SIT9531X_PLL_STATUS_OUTER_DIS, val);=0A=
+	if (rc) {=0A=
+		NL_SET_ERR_MSG(extack, "Failed to write PLL mode register");=0A=
+		goto unlock;=0A=
+	}=0A=
+=0A=
+	/* Trigger small update to apply without full NVM cycle */=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, sitdpll->id,=0A=
+				   SIT9531X_PLL_REG_SMALL_UPDATE,=0A=
+				   SIT9531X_SMALL_UPDATE_CMD);=0A=
+	if (rc) {=0A=
+		NL_SET_ERR_MSG(extack, "Failed to trigger small update");=0A=
+		goto unlock;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Keep the cached mode in step with the register.  The periodic=0A=
+	 * monitor refreshes it too, but mode_get and the reference-selection=0A=
+	 * path read this cache and would otherwise report or act on the=0A=
+	 * pre-switch mode until the next poll.=0A=
+	 */=0A=
+	sitdev->chan[sitdpll->id].mode =3D !!val;=0A=
+=0A=
+unlock:=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+static int=0A=
+sit9531x_dpll_supported_modes_get(const struct dpll_device *dpll,=0A=
+				  void *dpll_priv, unsigned long *modes,=0A=
+				  struct netlink_ext_ack *extack)=0A=
+{=0A=
+	__set_bit(DPLL_MODE_AUTOMATIC, modes);=0A=
+	__set_bit(DPLL_MODE_MANUAL, modes);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+const struct dpll_device_ops sit9531x_dpll_device_ops =3D {=0A=
+	.lock_status_get	=3D sit9531x_dpll_lock_status_get,=0A=
+	.mode_get		=3D sit9531x_dpll_mode_get,=0A=
+	.mode_set		=3D sit9531x_dpll_mode_set,=0A=
+	.supported_modes_get	=3D sit9531x_dpll_supported_modes_get,=0A=
+	/* temp_get not available -- SiT9531x has no on-die temp sensor */=0A=
+};=0A=
+=0A=
+static int=0A=
+sit9531x_dpll_input_pin_direction_get(const struct dpll_pin *pin,=0A=
+				      void *pin_priv,=0A=
+				      const struct dpll_device *dpll,=0A=
+				      void *dpll_priv,=0A=
+				      enum dpll_pin_direction *direction,=0A=
+				      struct netlink_ext_ack *extack)=0A=
+{=0A=
+	*direction =3D DPLL_PIN_DIRECTION_INPUT;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
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
+/*=0A=
+ * sit9531x_dpll_input_pin_state_on_dpll_get - get input pin DPLL state=0A=
+ *=0A=
+ * determines pin state from channel state: connected=0A=
+ * if this input is the selected reference on a locked PLL, selectable=0A=
+ * if enabled in automatic mode, disconnected otherwise.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_state_on_dpll_get(const struct dpll_pin *pin,=0A=
+					  void *pin_priv,=0A=
+					  const struct dpll_device *dpll,=0A=
+					  void *dpll_priv,=0A=
+					  enum dpll_pin_state *state,=0A=
+					  struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	const struct sit9531x_chan *chan;=0A=
+	const struct sit9531x_ref *ref;=0A=
+=0A=
+	chan =3D sit9531x_chan_state_get(sitdev, sitdpll->id);=0A=
+	ref =3D sit9531x_ref_state_get(sitdev, dpin->id);=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	/*=0A=
+	 * Report CONNECTED only when the PLL is genuinely locked to this=0A=
+<<<<<<< HEAD=0A=
+	 * input: outer loop locked AND inner loop locked.  Gating on the=0A=
+	 * outer bit alone let an idle PLL whose outer loop happens to read=0A=
+	 * locked (e.g. an unused PLLD) falsely claim its default source=0A=
+	 * (IN0P) as connected right after probe.=0A=
+=3D=3D=3D=3D=3D=3D=3D=0A=
+	 * input.  chan->locked already excludes a PLL the configuration=0A=
+	 * leaves unused, which would otherwise claim its default source as=0A=
+	 * connected right after probe; the inner loop has to be locked as=0A=
+	 * well before the reference can be called connected.=0A=
+>>>>>>> 7117164f1c60 (dpll: sit9531x: do not report an unused PLL as locke=
d)=0A=
+	 */=0A=
+	if (chan->locked && !chan->inner_lol &&=0A=
+	    chan->selected_ref =3D=3D dpin->id)=0A=
+		*state =3D DPLL_PIN_STATE_CONNECTED;=0A=
+	/* In auto mode, enabled inputs with good signal are selectable */=0A=
+	else if (!chan->mode && ref->enabled && !ref->los && !ref->oof)=0A=
+		*state =3D DPLL_PIN_STATE_SELECTABLE;=0A=
+	else=0A=
+		*state =3D DPLL_PIN_STATE_DISCONNECTED;=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_state_on_dpll_set - set input pin DPLL state=0A=
+ *=0A=
+ * Enables or disables the physical input receiver via Page 0x02=0A=
+ * force/state registers (sit9531x_input_disable/enable()) and updates=0A=
+ * this DPLL's Page 1 priority table so the state is honoured by the=0A=
+ * PLL's automatic reference selection, not just at the input buffer.=0A=
+ *   DISCONNECTED -> drop the input from this DPLL's priority table and=0A=
+ *                  release this DPLL's claim on the input=0A=
+ *   SELECTABLE   -> claim the input for this DPLL and make it eligible=0A=
+ *                  again in the priority table=0A=
+ *   CONNECTED    -> same as SELECTABLE (the PLL auto-switch logic does=0A=
+ *                  the actual selection)=0A=
+ *=0A=
+ * The priority table is per PLL, so it is always updated for this DPLL.=
=0A=
+ * A single physical input feeds every DPLL, so the hardware receiver is=
=0A=
+ * only cut off once the last DPLL has released it: ref->pll_mask tracks=
=0A=
+ * which DPLLs currently claim the input, and the physical disable=0A=
+ * happens on the transition to an empty mask.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *pin,=0A=
+					  void *pin_priv,=0A=
+					  const struct dpll_device *dpll,=0A=
+					  void *dpll_priv,=0A=
+					  enum dpll_pin_state state,=0A=
+					  struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	struct sit9531x_ref *ref =3D &sitdev->ref[dpin->id];=0A=
+	u8 hw_src =3D sit9531x_input_hw_src(dpin->id);=0A=
+	u8 pll_bit =3D BIT(sitdpll->id);=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	switch (state) {=0A=
+	case DPLL_PIN_STATE_DISCONNECTED:=0A=
+		rc =3D sit9531x_input_prio_remove(sitdev, sitdpll->id, hw_src);=0A=
+		if (rc)=0A=
+			break;=0A=
+		ref->pll_mask &=3D ~pll_bit;=0A=
+		if (ref->pll_mask)=0A=
+			rc =3D 0;	/* another DPLL still uses this input */=0A=
+		else=0A=
+			rc =3D sit9531x_input_disable(sitdev, dpin->id);=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_SELECTABLE:=0A=
+	case DPLL_PIN_STATE_CONNECTED:=0A=
+		rc =3D sit9531x_input_enable(sitdev, dpin->id);=0A=
+		if (rc)=0A=
+			break;=0A=
+		rc =3D sit9531x_input_prio_add(sitdev, sitdpll->id, hw_src);=0A=
+		if (rc)=0A=
+			break;=0A=
+		/*=0A=
+		 * Claim the input for this DPLL only once it is both enabled=0A=
+		 * and present in the priority table.  Setting the mask before=0A=
+		 * prio_add would leak the claim if prio_add failed, keeping the=0A=
+		 * shared input receiver powered even after every DPLL released=0A=
+		 * it.=0A=
+		 */=0A=
+		ref->pll_mask |=3D pll_bit;=0A=
+		break;=0A=
+	default:=0A=
+		rc =3D -EINVAL;=0A=
+		break;=0A=
+	}=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc)=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set input pin state");=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_prio_get - read input pin priority=0A=
+ *=0A=
+ * reads the PLL's priority table on Page 1 (via=0A=
+ * sit9531x_input_prio_get()) and returns the slot the input=0A=
+ * occupies, so pin-get reports the real hardware priority rather=0A=
+ * than a software default.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_prio_get(const struct dpll_pin *pin, void *pin_pri=
v,=0A=
+				 const struct dpll_device *dpll, void *dpll_priv,=0A=
+				 u32 *prio, struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	u8 slot;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_input_prio_get(sitdev, sitdpll->id,=0A=
+				     sit9531x_input_hw_src(dpin->id), &slot);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	dpin->prio =3D slot;=0A=
+	*prio =3D slot;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_prio_set - set input pin priority=0A=
+ *=0A=
+ * writes input priority table on Page 1 via=0A=
+ * core.c sit9531x_input_prio_set().  Forces holdover during update.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_prio_set(const struct dpll_pin *pin, void *pin_pri=
v,=0A=
+				 const struct dpll_device *dpll, void *dpll_priv,=0A=
+				 u32 prio, struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc;=0A=
+=0A=
+	if (dpin->dir !=3D DPLL_PIN_DIRECTION_INPUT) {=0A=
+		NL_SET_ERR_MSG(extack, "Priority applies only to input pins");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	if (prio >=3D SIT9531X_PRIO_MAX_SLOTS) {=0A=
+		NL_SET_ERR_MSG(extack, "Priority out of range (0-10)");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_input_prio_set(sitdev, sitdpll->id,=0A=
+				     sit9531x_input_hw_src(dpin->id),=0A=
+				     (u8)prio);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc) {=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set input priority");=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	dpin->prio =3D (u8)prio;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_phase_adjust_get - read phase adjustment=0A=
+ *=0A=
+ * returns cached phase adjustment value (in ps).=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_phase_adjust_get(const struct dpll_pin *pin,=0A=
+					 void *pin_priv,=0A=
+					 const struct dpll_device *dpll,=0A=
+					 void *dpll_priv, s32 *phase_adjust,=0A=
+					 struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+=0A=
+	*phase_adjust =3D dpin->phase_adjust;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_phase_offset_get - read phase offset=0A=
+ *=0A=
+ * reads the TDC (Time-to-Digital Converter) hardware=0A=
+ * to measure the phase difference in picoseconds via=0A=
+ * sit9531x_phase_offset_read().=0A=
+ */=0A=
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
+	int rc;=0A=
+=0A=
+	if (sitdev->chan[sitdpll->id].selected_ref !=3D dpin->id)=0A=
+		return -ENODATA;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_pll_ffo_ppt(sitdev, sitdpll->id, &ffo->ffo);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
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
+	if (sitdev->chan[sitdpll->id].selected_ref !=3D dpin->id) {=0A=
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
+static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {=0A=
+	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.frequency_get		=3D sit9531x_dpll_input_pin_frequency_get,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_input_pin_state_on_dpll_get,=0A=
+	.state_on_dpll_set	=3D sit9531x_dpll_input_pin_state_on_dpll_set,=0A=
+	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
+	.prio_set		=3D sit9531x_dpll_input_pin_prio_set,=0A=
+	.phase_adjust_get	=3D sit9531x_dpll_input_pin_phase_adjust_get,=0A=
+	.phase_offset_get	=3D sit9531x_dpll_input_pin_phase_offset_get,=0A=
+	/*=0A=
+	 * The measurement compares the PLL's running feedback divider with=0A=
+	 * its configured one, so it describes the device's own reference=0A=
+	 * rather than a port rate.=0A=
+	 */=0A=
+	.supported_ffo		=3D BIT(DPLL_FFO_PIN_DEVICE),=0A=
+	.ffo_get		=3D sit9531x_dpll_input_pin_ffo_get,=0A=
+};=0A=
+=0A=
+/*=0A=
+ * INTSYNC pin ops=0A=
+ *=0A=
+ * INTSYNC is the chip's inter-PLL sync net: one PLL drives it and other=
=0A=
+ * PLLs may lock to it instead of to an external reference.  The two=0A=
+ * roles are exposed as two separate pins so neither overloads the other:=
=0A=
+ *=0A=
+ *   - a source (output) pin registered on every DPLL.  Connecting it on a=
=0A=
+ *     DPLL makes that DPLL drive INTSYNC; only one DPLL may drive it at a=
=0A=
+ *     time.  It has no priority ops -- driving the net is not a reference=
=0A=
+ *     selection.=0A=
+ *   - a destination (input) pin registered on every DPLL.  Connecting it=
=0A=
+ *     on a DPLL makes that DPLL eligible to lock to INTSYNC as a=0A=
+ *     reference, so it carries the priority ops.=0A=
+ */=0A=
+=0A=
+/* ---- INTSYNC source (output) pin ---- */=0A=
+=0A=
+/* The INTSYNC source pin is an output; its direction_get is defined below=
. */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_direction_get(const struct dpll_pin *pin,=0A=
+				       void *pin_priv,=0A=
+				       const struct dpll_device *dpll,=0A=
+				       void *dpll_priv,=0A=
+				       enum dpll_pin_direction *direction,=0A=
+				       struct netlink_ext_ack *extack);=0A=
+=0A=
+static int=0A=
+sit9531x_dpll_intsync_src_state_on_dpll_get(const struct dpll_pin *pin,=0A=
+					    void *pin_priv,=0A=
+					    const struct dpll_device *dpll,=0A=
+					    void *dpll_priv,=0A=
+					    enum dpll_pin_state *state,=0A=
+					    struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	if (sitdev->intsync_src =3D=3D sitdpll->id)=0A=
+		*state =3D DPLL_PIN_STATE_CONNECTED;=0A=
+	else=0A=
+		*state =3D DPLL_PIN_STATE_DISCONNECTED;=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_intsync_src_state_on_dpll_set - drive INTSYNC from a PLL=
=0A=
+ *=0A=
+ *   CONNECTED    -> this PLL drives the INTSYNC net=0A=
+ *   DISCONNECTED -> stop driving INTSYNC if this PLL drives it=0A=
+ *=0A=
+ * SELECTABLE is rejected: driving the net is an explicit output routing,=
=0A=
+ * not an automatic-selection candidate, matching the regular output pin.=
=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_intsync_src_state_on_dpll_set(const struct dpll_pin *pin,=0A=
+					    void *pin_priv,=0A=
+					    const struct dpll_device *dpll,=0A=
+					    void *dpll_priv,=0A=
+					    enum dpll_pin_state state,=0A=
+					    struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc =3D 0;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	switch (state) {=0A=
+	case DPLL_PIN_STATE_CONNECTED:=0A=
+		if (sitdev->intsync_src =3D=3D sitdpll->id)=0A=
+			break;=0A=
+		if (sitdev->intsync_src >=3D 0) {=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "INTSYNC is already sourced by another PLL");=0A=
+			rc =3D -EBUSY;=0A=
+			break;=0A=
+		}=0A=
+		rc =3D sit9531x_intsync_enable(sitdev, sitdpll->id);=0A=
+		if (!rc)=0A=
+			sitdev->intsync_src =3D sitdpll->id;=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_DISCONNECTED:=0A=
+		if (sitdev->intsync_src !=3D sitdpll->id)=0A=
+			break;=0A=
+		rc =3D sit9531x_intsync_disable(sitdev, sitdpll->id);=0A=
+		if (!rc)=0A=
+			sitdev->intsync_src =3D -1;=0A=
+		break;=0A=
+	default:=0A=
+		rc =3D -EINVAL;=0A=
+		break;=0A=
+	}=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc && rc !=3D -EBUSY)=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set INTSYNC source state");=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+static const struct dpll_pin_ops sit9531x_dpll_intsync_src_pin_ops =3D {=
=0A=
+	.direction_get		=3D sit9531x_dpll_output_pin_direction_get,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_intsync_src_state_on_dpll_get,=0A=
+	.state_on_dpll_set	=3D sit9531x_dpll_intsync_src_state_on_dpll_set,=0A=
+};=0A=
+=0A=
+/* ---- INTSYNC destination (input) pin ---- */=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_intsync_dst_state_on_dpll_get - INTSYNC reference state=
=0A=
+ *=0A=
+ * CONNECTED when this PLL is locked to INTSYNC as its reference,=0A=
+ * SELECTABLE when it runs in automatic mode and a source PLL is driving=
=0A=
+ * INTSYNC, DISCONNECTED otherwise.  The PLL that drives INTSYNC can never=
=0A=
+ * be its own destination.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_intsync_dst_state_on_dpll_get(const struct dpll_pin *pin,=0A=
+					    void *pin_priv,=0A=
+					    const struct dpll_device *dpll,=0A=
+					    void *dpll_priv,=0A=
+					    enum dpll_pin_state *state,=0A=
+					    struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	const struct sit9531x_chan *chan;=0A=
+=0A=
+	chan =3D sit9531x_chan_state_get(sitdev, sitdpll->id);=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	if (sitdev->intsync_src =3D=3D sitdpll->id)=0A=
+		*state =3D DPLL_PIN_STATE_DISCONNECTED;=0A=
+	else if (chan->locked && !chan->inner_lol &&=0A=
+		 chan->selected_ref =3D=3D SIT9531X_INTSYNC_PIN_ID)=0A=
+		*state =3D DPLL_PIN_STATE_CONNECTED;=0A=
+	else if (!chan->mode && sitdev->intsync_src >=3D 0)=0A=
+		*state =3D DPLL_PIN_STATE_SELECTABLE;=0A=
+	else=0A=
+		*state =3D DPLL_PIN_STATE_DISCONNECTED;=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_intsync_dst_state_on_dpll_set - lock a PLL to INTSYNC=0A=
+ *=0A=
+ *   CONNECTED/SELECTABLE -> add INTSYNC to this PLL's priority table=0A=
+ *   DISCONNECTED         -> drop INTSYNC from this PLL's priority table=
=0A=
+ *=0A=
+ * INTSYNC is an internal net with no physical receiver, so only the=0A=
+ * per-PLL priority table is touched; the source pin controls generation.=
=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_intsync_dst_state_on_dpll_set(const struct dpll_pin *pin,=0A=
+					    void *pin_priv,=0A=
+					    const struct dpll_device *dpll,=0A=
+					    void *dpll_priv,=0A=
+					    enum dpll_pin_state state,=0A=
+					    struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	u8 hw_src =3D sit9531x_input_hw_src(SIT9531X_INTSYNC_PIN_ID);=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	switch (state) {=0A=
+	case DPLL_PIN_STATE_DISCONNECTED:=0A=
+		rc =3D sit9531x_input_prio_remove(sitdev, sitdpll->id, hw_src);=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_SELECTABLE:=0A=
+	case DPLL_PIN_STATE_CONNECTED:=0A=
+		if (sitdev->intsync_src =3D=3D sitdpll->id) {=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "PLL cannot lock to the INTSYNC it drives");=0A=
+			rc =3D -EINVAL;=0A=
+			break;=0A=
+		}=0A=
+		rc =3D sit9531x_input_prio_add(sitdev, sitdpll->id, hw_src);=0A=
+		break;=0A=
+	default:=0A=
+		rc =3D -EINVAL;=0A=
+		break;=0A=
+	}=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc && rc !=3D -EINVAL)=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set INTSYNC input state");=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Do not add .frequency_get / the generic input state getter here: the=0A=
+ * destination pin id is SIT9531X_INTSYNC_PIN_ID, one past the end of the=
=0A=
+ * ref[] array (INTSYNC is an internal net with no ref[] entry).  The ops=
=0A=
+ * below only ever key on chan[] and the priority table, never ref[id].=0A=
+ */=0A=
+static const struct dpll_pin_ops sit9531x_dpll_intsync_dst_pin_ops =3D {=
=0A=
+	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_intsync_dst_state_on_dpll_get,=0A=
+	.state_on_dpll_set	=3D sit9531x_dpll_intsync_dst_state_on_dpll_set,=0A=
+	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
+	.prio_set		=3D sit9531x_dpll_input_pin_prio_set,=0A=
+};=0A=
+=0A=
+/*=0A=
+ * XO (crystal oscillator) pin ops=0A=
+ *=0A=
+ * The XO is the chip's internal reference oscillator that feeds every=0A=
+ * PLL.  It is exposed so userspace can see the on-chip reference, but it=
=0A=
+ * cannot be routed or disconnected, so it is reported permanently=0A=
+ * connected and offers no state_on_dpll_set / prio ops.=0A=
+ */=0A=
+=0A=
+static int=0A=
+sit9531x_dpll_xo_pin_state_on_dpll_get(const struct dpll_pin *pin,=0A=
+				       void *pin_priv,=0A=
+				       const struct dpll_device *dpll,=0A=
+				       void *dpll_priv,=0A=
+				       enum dpll_pin_state *state,=0A=
+				       struct netlink_ext_ack *extack)=0A=
+{=0A=
+	*state =3D DPLL_PIN_STATE_CONNECTED;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static const struct dpll_pin_ops sit9531x_dpll_xo_pin_ops =3D {=0A=
+	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.frequency_get		=3D sit9531x_dpll_input_pin_frequency_get,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_xo_pin_state_on_dpll_get,=0A=
+};=0A=
+=0A=
+static int=0A=
+sit9531x_dpll_output_pin_direction_get(const struct dpll_pin *pin,=0A=
+				       void *pin_priv,=0A=
+				       const struct dpll_device *dpll,=0A=
+				       void *dpll_priv,=0A=
+				       enum dpll_pin_direction *direction,=0A=
+				       struct netlink_ext_ack *extack)=0A=
+{=0A=
+	*direction =3D DPLL_PIN_DIRECTION_OUTPUT;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_frequency_get - read output pin frequency=0A=
+ *=0A=
+ * Reads the DIVO divider back from the chip and computes the live=0A=
+ * frequency as Fvco / DIVO.  Falls back to the cached value when the=0A=
+ * output is not resolvable through the divider chain (e.g. not mapped=0A=
+ * to a PLL), so a netlink dump never fails on such pins.=0A=
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
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc)=0A=
+		*frequency =3D sit9531x_out_state_get(sitdev, dpin->id)->freq;=0A=
+=0A=
+	return 0;=0A=
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
+	const struct sit9531x_out *out;=0A=
+=0A=
+	out =3D sit9531x_out_state_get(sitdpll->dev, dpin->id);=0A=
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
+/*=0A=
+ * sit9531x_dpll_output_pin_phase_adjust_get - read output phase adjustmen=
t=0A=
+ *=0A=
+ * returns cached value.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_phase_adjust_get(const struct dpll_pin *pin,=0A=
+					  void *pin_priv,=0A=
+					  const struct dpll_device *dpll,=0A=
+					  void *dpll_priv, s32 *phase_adjust,=0A=
+					  struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+=0A=
+	*phase_adjust =3D dpin->phase_adjust;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_phase_adjust_set - set output phase adjustment=
=0A=
+ *=0A=
+ * Programs the per-output PRG_RST_DELAY registers for deterministic=0A=
+ * phase offset; see sit9531x_output_phase_adjust_set() in core.c.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_phase_adjust_set(const struct dpll_pin *pin,=0A=
+					  void *pin_priv,=0A=
+					  const struct dpll_device *dpll,=0A=
+					  void *dpll_priv, s32 phase_adjust,=0A=
+					  struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_output_phase_adjust_set(sitdev, dpin->id, phase_adjust);=
=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc) {=0A=
+		NL_SET_ERR_MSG(extack, "Phase adjust failed");=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	dpin->phase_adjust =3D phase_adjust;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int=0A=
+sit9531x_dpll_output_pin_esync_get(const struct dpll_pin *pin,=0A=
+				   void *pin_priv,=0A=
+				   const struct dpll_device *dpll,=0A=
+				   void *dpll_priv,=0A=
+				   struct dpll_pin_esync *esync,=0A=
+				   struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+=0A=
+	if (!sit9531x_dpll_esync_pin_supported(dpin))=0A=
+		return -EOPNOTSUPP;=0A=
+=0A=
+	esync->range =3D sit9531x_esync_ranges;=0A=
+	esync->range_num =3D ARRAY_SIZE(sit9531x_esync_ranges);=0A=
+	esync->pulse =3D SIT9531X_ESYNC_PULSE_DEFAULT;=0A=
+	esync->freq =3D dpin->esync_freq;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int=0A=
+sit9531x_dpll_output_pin_esync_set(const struct dpll_pin *pin,=0A=
+				   void *pin_priv,=0A=
+				   const struct dpll_device *dpll,=0A=
+				   void *dpll_priv,=0A=
+				   u64 freq,=0A=
+				   struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	u8 actual_pll;=0A=
+	int rc;=0A=
+=0A=
+	if (!sit9531x_dpll_esync_pin_supported(dpin)) {=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Embedded sync not enabled for this pin");=0A=
+		return -EOPNOTSUPP;=0A=
+	}=0A=
+=0A=
+	actual_pll =3D sitdev->out[dpin->id].pll_idx;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	/*=0A=
+	 * This output is a dedicated embedded-sync pin.=0A=
+	 * Treat freq=3D0 as a request to disable the entire output.=0A=
+	 */=0A=
+	if (!freq) {=0A=
+		rc =3D sit9531x_output_disable(sitdev, dpin->id);=0A=
+		if (!rc)=0A=
+			dpin->esync_freq =3D 0;=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	if (freq !=3D SIT9531X_ESYNC_FREQ_10MHZ) {=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Only 10 MHz esync frequency is supported");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	rc =3D sit9531x_output_freq_set(sitdev, dpin->id, actual_pll,=0A=
+				      SIT9531X_ESYNC_FREQ_10MHZ);=0A=
+	/*=0A=
+	 * Program the pulse generator (PROG0 PULSE_CTRL) so the embedded-sync=0A=
+	 * pulse is actually emitted; without it the output carries the clock=0A=
+	 * but no esync marker.  SIT9531X_ESYNC_PULSE_DEFAULT is the same duty=0A=
+	 * the esync_get callback advertises.=0A=
+	 */=0A=
+	if (!rc)=0A=
+		rc =3D sit9531x_output_pulse_ctrl_set(sitdev, dpin->id,=0A=
+						    SIT9531X_ESYNC_PULSE_DEFAULT);=0A=
+	if (!rc)=0A=
+		rc =3D sit9531x_output_enable(sitdev, dpin->id);=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (!rc)=0A=
+		dpin->esync_freq =3D SIT9531X_ESYNC_FREQ_10MHZ;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+static const struct dpll_pin_ops sit9531x_dpll_output_pin_ops =3D {=0A=
+	.direction_get		=3D sit9531x_dpll_output_pin_direction_get,=0A=
+	.frequency_get		=3D sit9531x_dpll_output_pin_frequency_get,=0A=
+	.frequency_set		=3D sit9531x_dpll_output_pin_frequency_set,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_output_pin_state_on_dpll_get,=0A=
+	.state_on_dpll_set	=3D sit9531x_dpll_output_pin_state_on_dpll_set,=0A=
+	.phase_adjust_get	=3D sit9531x_dpll_output_pin_phase_adjust_get,=0A=
+	.phase_adjust_set	=3D sit9531x_dpll_output_pin_phase_adjust_set,=0A=
+	.esync_get		=3D sit9531x_dpll_output_pin_esync_get,=0A=
+	.esync_set		=3D sit9531x_dpll_output_pin_esync_set,=0A=
+};=0A=
+=0A=
+const struct dpll_pin_ops *=0A=
+sit9531x_dpll_pin_ops_get(const struct sit9531x_dpll_pin *pin)=0A=
+{=0A=
+	if (!sit9531x_dpll_is_input_pin(pin)) {=0A=
+		if (sit9531x_dpll_is_intsync_src_pin(pin))=0A=
+			return &sit9531x_dpll_intsync_src_pin_ops;=0A=
+		return &sit9531x_dpll_output_pin_ops;=0A=
+	}=0A=
+	if (sit9531x_dpll_is_intsync_pin(pin))=0A=
+		return &sit9531x_dpll_intsync_dst_pin_ops;=0A=
+	if (sit9531x_dpll_is_xo_pin(pin))=0A=
+		return &sit9531x_dpll_xo_pin_ops;=0A=
+	return &sit9531x_dpll_input_pin_ops;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_changes_check - check for state changes and notify=0A=
+ *=0A=
+ * Called from sit9531x_dev_periodic_work().  Compares current hardware=0A=
+ * state against cached values and sends netlink notifications on changes.=
=0A=
+ */=0A=
+void sit9531x_dpll_changes_check(struct sit9531x_dpll *sitdpll)=0A=
+{=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	enum dpll_lock_status lock_status;=0A=
+	struct sit9531x_dpll_pin *pin;=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_dpll_lock_status_get(sitdpll->dpll_dev, sitdpll,=0A=
+					   &lock_status, NULL, NULL);=0A=
+	if (rc) {=0A=
+		dev_err(sitdev->dev, "Failed to get DPLL%u lock status: %d\n",=0A=
+			sitdpll->id, rc);=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	/* If lock status changed, notify DPLL core */=0A=
+	if (sitdpll->lock_status !=3D lock_status) {=0A=
+		sitdpll->lock_status =3D lock_status;=0A=
+		dpll_device_change_ntf(sitdpll->dpll_dev);=0A=
+	}=0A=
+=0A=
+	list_for_each_entry(pin, &sitdpll->pins, list) {=0A=
+		const struct dpll_pin_ops *ops;=0A=
+		enum dpll_pin_state state;=0A=
+=0A=
+		/*=0A=
+		 * Poll input pins whose state can change autonomously: regular=0A=
+		 * references and the INTSYNC destination pin.  Outputs (incl.=0A=
+		 * the INTSYNC source) change only through their own set=0A=
+		 * callback and the XO is permanently connected, so skip those.=0A=
+		 * Each pin's own state_on_dpll_get resolves to the right getter.=0A=
+		 */=0A=
+		if (!sit9531x_dpll_is_input_pin(pin) ||=0A=
+		    sit9531x_dpll_is_xo_pin(pin))=0A=
+			continue;=0A=
+=0A=
+		ops =3D sit9531x_dpll_pin_ops_get(pin);=0A=
+		rc =3D ops->state_on_dpll_get(pin->dpll_pin, pin,=0A=
+					    sitdpll->dpll_dev, sitdpll,=0A=
+					    &state, NULL);=0A=
+		if (rc)=0A=
+			continue;=0A=
+=0A=
+		if (state !=3D pin->pin_state) {=0A=
+			dev_dbg(sitdev->dev, "%s state changed: %u->%u\n",=0A=
+				pin->label, pin->pin_state, state);=0A=
+			pin->pin_state =3D state;=0A=
+			dpll_pin_change_ntf(pin->dpll_pin);=0A=
+		}=0A=
+	}=0A=
+}=0A=
diff --git a/drivers/dpll/sit9531x/dpll.h b/drivers/dpll/sit9531x/dpll.h=0A=
new file mode 100644=0A=
index 000000000000..e5eef4514bcd=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/dpll.h=0A=
@@ -0,0 +1,69 @@=0A=
+/* SPDX-License-Identifier: GPL-2.0 */=0A=
+/*=0A=
+ * SiTime SiT9531x DPLL subsystem interface=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ *=0A=
+ * DPLL device and pin structures, and function declarations for=0A=
+ * the DPLL registration and callback layer.=0A=
+ */=0A=
+=0A=
+#ifndef _SIT9531X_DPLL_H=0A=
+#define _SIT9531X_DPLL_H=0A=
+=0A=
+#include <linux/dpll.h>=0A=
+#include <linux/list.h>=0A=
+#include <linux/types.h>=0A=
+=0A=
+struct sit9531x_dev;=0A=
+=0A=
+/* Per-pin DPLL state. */=0A=
+struct sit9531x_dpll_pin {=0A=
+	struct list_head		list;=0A=
+	struct sit9531x_dpll		*dpll;=0A=
+	struct dpll_pin			*dpll_pin;=0A=
+	dpll_tracker			tracker;=0A=
+	struct fwnode_handle		*fwnode;=0A=
+	char				label[8];	/* "IN0", "OUT3" */=0A=
+	enum dpll_pin_direction		dir;=0A=
+	u8				id;		/* hardware index */=0A=
+	u8				prio;=0A=
+	enum dpll_pin_state		pin_state;=0A=
+	s32				phase_adjust;	/* picoseconds */=0A=
+	s64				phase_offset;	/* picoseconds */=0A=
+	bool				esync_control;=0A=
+	u64				esync_freq;	/* 0 =3D=3D disabled */=0A=
+};=0A=
+=0A=
+/* Per-PLL DPLL device state. */=0A=
+struct sit9531x_dpll {=0A=
+	struct list_head		list;=0A=
+	struct sit9531x_dev		*dev;=0A=
+	struct dpll_device		*dpll_dev;=0A=
+	dpll_tracker			tracker;=0A=
+	struct dpll_device_ops		ops;	/* per-instance copy */=0A=
+	struct list_head		pins;=0A=
+	u8				id;	/* 0 =3D PLLA .. 3 =3D PLLD */=0A=
+	enum dpll_lock_status		lock_status;=0A=
+};=0A=
+=0A=
+/* ---- DPLL allocation and registration ---- */=0A=
+/*=0A=
+ * The callback tables stay with the callbacks; the registration code that=
=0A=
+ * hands them to the subsystem lives next to probe() in core.c.=0A=
+ */=0A=
+extern const struct dpll_device_ops sit9531x_dpll_device_ops;=0A=
+const struct dpll_pin_ops *=0A=
+sit9531x_dpll_pin_ops_get(const struct sit9531x_dpll_pin *pin);=0A=
+=0A=
+struct sit9531x_dpll *sit9531x_dpll_alloc(struct sit9531x_dev *sitdev, u8 =
ch);=0A=
+void sit9531x_dpll_free(struct sit9531x_dpll *sitdpll);=0A=
+int  sit9531x_dpll_register(struct sit9531x_dpll *sitdpll);=0A=
+void sit9531x_dpll_unregister(struct sit9531x_dpll *sitdpll);=0A=
+=0A=
+/* ---- Periodic change detection ---- */=0A=
+void sit9531x_dpll_changes_check(struct sit9531x_dpll *sitdpll);=0A=
+=0A=
+#endif /* _SIT9531X_DPLL_H */=0A=
diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c=0A=
new file mode 100644=0A=
index 000000000000..8a0105c8c647=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/prop.c=0A=
@@ -0,0 +1,397 @@=0A=
+// SPDX-License-Identifier: GPL-2.0=0A=
+/*=0A=
+ * SiTime SiT9531x firmware node property parsing=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ *=0A=
+ * Retrieves pin properties from Device Tree firmware nodes (or=0A=
+ * applies defaults when no firmware node exists).=0A=
+ */=0A=
+=0A=
+#include <linux/dev_printk.h>=0A=
+#include <linux/dpll.h>=0A=
+#include <linux/err.h>=0A=
+#include <linux/fwnode.h>=0A=
+#include <linux/property.h>=0A=
+#include <linux/slab.h>=0A=
+#include <linux/string.h>=0A=
+=0A=
+#include "core.h"=0A=
+#include "prop.h"=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_pin_label - fill the package label for an input pin=0A=
+ *=0A=
+ * Split out so input-naming changes stay local to this helper.=0A=
+ */=0A=
+static void sit9531x_input_pin_label(struct sit9531x_dev *sitdev,=0A=
+				     struct sit9531x_pin_props *props, u8 id)=0A=
+{=0A=
+	u8 pair =3D sit9531x_input_pair(id);=0A=
+=0A=
+	if (sitdev->ref[id].sig_mode =3D=3D SIT9531X_MODE_DE)=0A=
+		snprintf(props->package_label,=0A=
+			 sizeof(props->package_label), "IN%u", pair);=0A=
+	else=0A=
+		snprintf(props->package_label,=0A=
+			 sizeof(props->package_label), "IN%u%c", pair,=0A=
+			 sit9531x_input_is_n(id) ? 'N' : 'P');=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_prop_pin_package_label_set - generate package label=0A=
+ * @dir:	pin direction=0A=
+ * @id:		pin index=0A=
+ *=0A=
+ * Generates a package label string.  Output pins are named "OUT0",=0A=
+ * "OUT1", ...  Input pins are named after the physical pair and lane:=0A=
+ * "IN0P", "IN0N", "IN1P", ... for single-ended lanes, or "IN0",=0A=
+ * "IN1", ... when the pair is configured differential (the N lane is=0A=
+ * not registered in that case).=0A=
+ */=0A=
+static void=0A=
+sit9531x_prop_pin_package_label_set(struct sit9531x_dev *sitdev,=0A=
+				    struct sit9531x_pin_props *props,=0A=
+				    enum dpll_pin_direction dir, u8 id)=0A=
+{=0A=
+	/* The internal INTSYNC pin has a fixed label */=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+	    id =3D=3D SIT9531X_INTSYNC_PIN_ID) {=0A=
+		strscpy(props->package_label, "INTSYNC",=0A=
+			sizeof(props->package_label));=0A=
+		props->dpll_props.package_label =3D props->package_label;=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	/* The internal XO reference has a fixed label */=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT && id =3D=3D SIT9531X_MAX_INPUTS)=
 {=0A=
+		strscpy(props->package_label, "XO",=0A=
+			sizeof(props->package_label));=0A=
+		props->dpll_props.package_label =3D props->package_label;=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	/* The internal INTSYNC source (output) pin has a fixed label */=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
+	    id =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID) {=0A=
+		strscpy(props->package_label, "SYNCOUT",=0A=
+			sizeof(props->package_label));=0A=
+		props->dpll_props.package_label =3D props->package_label;=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT)=0A=
+		sit9531x_input_pin_label(sitdev, props, id);=0A=
+	else=0A=
+		snprintf(props->package_label, sizeof(props->package_label),=0A=
+			 "OUT%u", id);=0A=
+=0A=
+	props->dpll_props.package_label =3D props->package_label;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_prop_pin_fwnode_get - find firmware node for a pin=0A=
+ * @dir:	pin direction=0A=
+ * @id:		pin index=0A=
+ *=0A=
+ * Searches for input-pins/output-pins child nodes in DT, looking=0A=
+ * for a child whose "reg" property matches @id.=0A=
+ *=0A=
+ * Return: 0 on success, -ENOENT if no firmware node exists=0A=
+ */=0A=
+static int=0A=
+sit9531x_prop_pin_fwnode_get(struct sit9531x_dev *sitdev,=0A=
+			     struct sit9531x_pin_props *props,=0A=
+			     enum dpll_pin_direction dir, u8 id)=0A=
+{=0A=
+	struct fwnode_handle *pins_node, *pin_node;=0A=
+	const char *node_name;=0A=
+=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT)=0A=
+		node_name =3D "input-pins";=0A=
+	else=0A=
+		node_name =3D "output-pins";=0A=
+=0A=
+	pins_node =3D device_get_named_child_node(sitdev->dev, node_name);=0A=
+	if (!pins_node) {=0A=
+		dev_dbg(sitdev->dev, "'%s' sub-node is missing\n", node_name);=0A=
+		return -ENOENT;=0A=
+	}=0A=
+=0A=
+	/* Enumerate child pin nodes and find the requested one */=0A=
+	fwnode_for_each_child_node(pins_node, pin_node) {=0A=
+		u32 reg;=0A=
+=0A=
+		if (fwnode_property_read_u32(pin_node, "reg", &reg))=0A=
+			continue;=0A=
+=0A=
+		if (id =3D=3D reg)=0A=
+			break;=0A=
+	}=0A=
+=0A=
+	fwnode_handle_put(pins_node);=0A=
+=0A=
+	props->fwnode =3D pin_node;=0A=
+=0A=
+	dev_dbg(sitdev->dev, "Firmware node for %s %sfound\n",=0A=
+		props->package_label, pin_node ? "" : "NOT ");=0A=
+=0A=
+	return pin_node ? 0 : -ENOENT;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_pin_props_get - get pin properties for a given pin=0A=
+ * @dir:	pin direction (INPUT or OUTPUT)=0A=
+ * @index:	pin index=0A=
+ *=0A=
+ * Allocates a pin properties structure, generates a package label,=0A=
+ * looks up the firmware node if available, and reads optional=0A=
+ * properties (label, connection-type, supported-frequencies-hz,=0A=
+ * esync-control).=0A=
+ *=0A=
+ * Call sit9531x_pin_props_put() to free the returned structure.=0A=
+ *=0A=
+ * Return: pointer to pin properties on success, error pointer on error=0A=
+ */=0A=
+struct sit9531x_pin_props *=0A=
+sit9531x_pin_props_get(struct sit9531x_dev *sitdev,=0A=
+		       enum dpll_pin_direction dir, u8 index)=0A=
+{=0A=
+	struct dpll_pin_frequency *ranges;=0A=
+	struct sit9531x_pin_props *props;=0A=
+	int i, j, num_freqs =3D 0, rc;=0A=
+	u64 *freqs =3D NULL;=0A=
+	const char *type;=0A=
+	u32 curr_freq;=0A=
+=0A=
+	props =3D kzalloc_obj(*props, GFP_KERNEL);=0A=
+	if (!props)=0A=
+		return ERR_PTR(-ENOMEM);=0A=
+=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+	    index =3D=3D SIT9531X_INTSYNC_PIN_ID) {=0A=
+		/*=0A=
+		 * INTSYNC destination pin: a PLL locks to the INTSYNC net as a=0A=
+		 * reference, so it can be connected and re-prioritised.=0A=
+		 */=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
+		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |=0A=
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
+		curr_freq =3D 0;=0A=
+	} else if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
+		   index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID) {=0A=
+		/*=0A=
+		 * INTSYNC source pin: a PLL drives the INTSYNC net.  It can be=0A=
+		 * connected/disconnected but carries no priority (driving the=0A=
+		 * net is not a reference selection) and no frequency.=0A=
+		 */=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
+		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
+		curr_freq =3D 0;=0A=
+	} else if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+		   index =3D=3D SIT9531X_MAX_INPUTS) {=0A=
+		/* The XO reference is fixed: no state or priority control. */=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
+		props->dpll_props.capabilities =3D 0;=0A=
+		sitdev->ref[index].freq =3D sitdev->xtal_freq;=0A=
+		curr_freq =3D sitdev->xtal_freq;=0A=
+	} else if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT) {=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_EXT;=0A=
+		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |=0A=
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
+		curr_freq =3D sitdev->ref[index].freq;=0A=
+	} else {=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_GNSS;=0A=
+		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
+		curr_freq =3D sitdev->out[index].freq;=0A=
+	}=0A=
+=0A=
+	/* Allow phase-adjust over +/-1 ms window.  The subsystem rejects=0A=
+	 * pin_set(phase-adjust, X) when X falls outside [min, max], so=0A=
+	 * leaving these at 0 silently blocks every netlink call.  1 ms is=0A=
+	 * well beyond the DCO dynamic range but costs nothing.=0A=
+	 */=0A=
+	props->dpll_props.phase_range.min =3D -1000000000; /* -1 ms in ps */=0A=
+	props->dpll_props.phase_range.max =3D  1000000000; /* +1 ms in ps */=0A=
+=0A=
+	/* Generate package label */=0A=
+	sit9531x_prop_pin_package_label_set(sitdev, props, dir, index);=0A=
+=0A=
+	/*=0A=
+	 * Both INTSYNC pins are internal to the chip and have no board-level=0A=
+	 * wiring, so they take no properties from the firmware node.=0A=
+	 */=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+	    index =3D=3D SIT9531X_INTSYNC_PIN_ID)=0A=
+		goto skip_fwnode_props;=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
+	    index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID)=0A=
+		goto skip_fwnode_props;=0A=
+=0A=
+	rc =3D sit9531x_prop_pin_fwnode_get(sitdev, props, dir, index);=0A=
+	if (rc)=0A=
+		goto skip_fwnode_props;=0A=
+=0A=
+	/* Look for "label" property -> board label */=0A=
+	fwnode_property_read_string(props->fwnode, "label",=0A=
+				    &props->dpll_props.board_label);=0A=
+=0A=
+	/* Look for "connection-type" property -> pin type enum */=0A=
+	if (!fwnode_property_read_string(props->fwnode, "connection-type",=0A=
+					 &type)) {=0A=
+		if (!strcmp(type, "ext"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_EXT;=0A=
+		else if (!strcmp(type, "gnss"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_GNSS;=0A=
+		else if (!strcmp(type, "int") ||=0A=
+			 !strcmp(type, "int-oscillator"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
+		else if (!strcmp(type, "synce") ||=0A=
+			 !strcmp(type, "synce-eth-port"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_SYNCE_ETH_PORT;=0A=
+		else if (!strcmp(type, "mux"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_MUX;=0A=
+		else=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "Unknown pin type '%s'\n", type);=0A=
+	}=0A=
+=0A=
+	props->esync_control =3D=0A=
+		fwnode_property_read_bool(props->fwnode, "esync-control");=0A=
+=0A=
+	num_freqs =3D fwnode_property_count_u64(props->fwnode,=0A=
+					      "supported-frequencies-hz");=0A=
+	if (num_freqs <=3D 0) {=0A=
+		num_freqs =3D 0;=0A=
+		goto skip_fwnode_props;=0A=
+	}=0A=
+=0A=
+	freqs =3D kcalloc(num_freqs, sizeof(*freqs), GFP_KERNEL);=0A=
+	if (!freqs) {=0A=
+		rc =3D -ENOMEM;=0A=
+		goto err_alloc_freqs;=0A=
+	}=0A=
+=0A=
+	fwnode_property_read_u64_array(props->fwnode,=0A=
+				       "supported-frequencies-hz",=0A=
+				       freqs, num_freqs);=0A=
+=0A=
+	/*=0A=
+	 * Seed the runtime ref->freq / out->freq with the first DT-listed=0A=
+	 * supported frequency so the netlink frequency_get callback reports=0A=
+	 * a sane initial value before any pin_set occurs.  DT lists the=0A=
+	 * physically-wired reference frequency for each input pin and the=0A=
+	 * default output frequency for each output pin.=0A=
+	 */=0A=
+	if (num_freqs > 0) {=0A=
+		if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT)=0A=
+			sitdev->ref[index].freq =3D (u32)freqs[0];=0A=
+		else=0A=
+			sitdev->out[index].freq =3D (u32)freqs[0];=0A=
+		curr_freq =3D (u32)freqs[0];=0A=
+	}=0A=
+=0A=
+skip_fwnode_props:=0A=
+	/* Neither INTSYNC pin carries a frequency attribute */=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+	    index =3D=3D SIT9531X_INTSYNC_PIN_ID)=0A=
+		return props;=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
+	    index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID)=0A=
+		return props;=0A=
+=0A=
+	/* Allocate frequency ranges list -- DT discrete entries + current=0A=
+	 * freq + one catch-all wide range so the subsystem never pre-=0A=
+	 * rejects a frequency_set call.  The chip's real admissible set=0A=
+	 * is bounded by VCO / divider math in sit9531x_output_freq_set().=0A=
+	 */=0A=
+	ranges =3D kcalloc(num_freqs + 2, sizeof(*ranges), GFP_KERNEL);=0A=
+	if (!ranges) {=0A=
+		rc =3D -ENOMEM;=0A=
+		goto err_alloc_ranges;=0A=
+	}=0A=
+=0A=
+	/* Current freq as first entry */=0A=
+	ranges[0] =3D (struct dpll_pin_frequency)DPLL_PIN_FREQUENCY(curr_freq);=
=0A=
+	j =3D 1;=0A=
+=0A=
+	for (i =3D 0; i < num_freqs; i++) {=0A=
+		struct dpll_pin_frequency freq =3D DPLL_PIN_FREQUENCY(freqs[i]);=0A=
+=0A=
+		if (freqs[i] =3D=3D curr_freq)=0A=
+			continue;=0A=
+		ranges[j++] =3D freq;=0A=
+	}=0A=
+=0A=
+	/* Always append a wide catch-all range */=0A=
+	ranges[j].min =3D 1;=0A=
+	ranges[j].max =3D 1000000000ULL; /* 1 GHz */=0A=
+	j++;=0A=
+=0A=
+	props->dpll_props.freq_supported =3D ranges;=0A=
+	props->dpll_props.freq_supported_num =3D j;=0A=
+=0A=
+	kfree(freqs);=0A=
+=0A=
+	return props;=0A=
+=0A=
+err_alloc_ranges:=0A=
+	kfree(freqs);=0A=
+err_alloc_freqs:=0A=
+	fwnode_handle_put(props->fwnode);=0A=
+	kfree(props);=0A=
+=0A=
+	return ERR_PTR(rc);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_pin_props_put - release pin properties=0A=
+ * @props:	pin properties to free=0A=
+ */=0A=
+void sit9531x_pin_props_put(struct sit9531x_pin_props *props)=0A=
+{=0A=
+	kfree(props->dpll_props.freq_supported);=0A=
+=0A=
+	if (props->fwnode)=0A=
+		fwnode_handle_put(props->fwnode);=0A=
+=0A=
+	kfree(props);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_prop_dpll_type_get - get DPLL channel type from firmware=0A=
+ * @index:	DPLL channel index (0-3)=0A=
+ *=0A=
+ * Reads the "dpll-types" string array property from the firmware node=0A=
+ * and returns the corresponding DPLL type enum.=0A=
+ *=0A=
+ * Return: DPLL type for the given channel (default: DPLL_TYPE_PPS)=0A=
+ */=0A=
+enum dpll_type=0A=
+sit9531x_prop_dpll_type_get(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	const char *types[SIT9531X_NUM_PLLS];=0A=
+	int count;=0A=
+=0A=
+	count =3D device_property_read_string_array(sitdev->dev, "dpll-types",=0A=
+						  types, ARRAY_SIZE(types));=0A=
+=0A=
+	if (index >=3D count)=0A=
+		return DPLL_TYPE_PPS;=0A=
+=0A=
+	if (!strcmp(types[index], "pps"))=0A=
+		return DPLL_TYPE_PPS;=0A=
+	else if (!strcmp(types[index], "eec"))=0A=
+		return DPLL_TYPE_EEC;=0A=
+=0A=
+	dev_warn(sitdev->dev, "Unknown DPLL type '%s', using default\n",=0A=
+		 types[index]);=0A=
+=0A=
+	return DPLL_TYPE_PPS;=0A=
+}=0A=
diff --git a/drivers/dpll/sit9531x/prop.h b/drivers/dpll/sit9531x/prop.h=0A=
new file mode 100644=0A=
index 000000000000..f7f1c854b955=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/prop.h=0A=
@@ -0,0 +1,39 @@=0A=
+/* SPDX-License-Identifier: GPL-2.0 */=0A=
+/*=0A=
+ * SiTime SiT9531x firmware node property parsing=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ */=0A=
+=0A=
+#ifndef _SIT9531X_PROP_H=0A=
+#define _SIT9531X_PROP_H=0A=
+=0A=
+#include <linux/dpll.h>=0A=
+#include <linux/fwnode.h>=0A=
+=0A=
+struct sit9531x_dev;=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_pin_props - pin properties from firmware=0A=
+ * @fwnode:		firmware node handle (NULL if no DT node)=0A=
+ * @dpll_props:		DPLL core pin properties=0A=
+ * @package_label:	pin package label (e.g. "IN0", "OUT3")=0A=
+ * @esync_control:	embedded sync is controllable=0A=
+ */=0A=
+struct sit9531x_pin_props {=0A=
+	struct fwnode_handle		*fwnode;=0A=
+	struct dpll_pin_properties	dpll_props;=0A=
+	char				package_label[8];=0A=
+	bool				esync_control;=0A=
+};=0A=
+=0A=
+enum dpll_type sit9531x_prop_dpll_type_get(struct sit9531x_dev *sitdev,=0A=
+					   u8 index);=0A=
+struct sit9531x_pin_props *sit9531x_pin_props_get(struct sit9531x_dev *sit=
dev,=0A=
+						  enum dpll_pin_direction dir,=0A=
+						  u8 index);=0A=
+void sit9531x_pin_props_put(struct sit9531x_pin_props *props);=0A=
+=0A=
+#endif /* _SIT9531X_PROP_H */=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
new file mode 100644=0A=
index 000000000000..5c3dbeefd86b=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -0,0 +1,371 @@=0A=
+/* SPDX-License-Identifier: GPL-2.0 */=0A=
+/*=0A=
+ * SiTime SiT9531x register definitions=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ */=0A=
+=0A=
+#ifndef _SIT9531X_REGS_H=0A=
+#define _SIT9531X_REGS_H=0A=
+=0A=
+/*=0A=
+ * I2C register model:=0A=
+ *   - Page select register at offset 0x01=0A=
+ *   - Each page has 128 registers (0x00-0x7F)=0A=
+ *   - Some pages are paired (e.g. 0x0A/0x1A for PLLA)=0A=
+ */=0A=
+#define SIT9531X_PAGE_SEL		0xFF=0A=
+#define SIT9531X_PAGE_SIZE		0x100=0A=
+#define SIT9531X_NUM_PAGES		32=0A=
+=0A=
+/* Helper macros for page:offset addressing */=0A=
+#define SIT9531X_REG(_page, _offset)		(((_page) << 8) | (_offset))=0A=
+#define SIT9531X_REG_PAGE(_reg)		((_reg) >> 8)=0A=
+#define SIT9531X_REG_OFFSET(_reg)		((_reg) & 0xFF)=0A=
+=0A=
+/* ---- Page definitions ---- */=0A=
+#define SIT9531X_PAGE_MAINSYS0		0x00=0A=
+#define SIT9531X_PAGE_MAINSYS1		0x01=0A=
+#define SIT9531X_PAGE_INPUTSYS		0x02=0A=
+#define SIT9531X_PAGE_OUTSYS0		0x03=0A=
+#define SIT9531X_PAGE_OUTSYS1		0x04=0A=
+#define SIT9531X_PAGE_CLKMON0		0x06=0A=
+#define SIT9531X_PAGE_CLKMON1		0x07=0A=
+#define SIT9531X_PAGE_PLLA			0x0A=0A=
+#define SIT9531X_PAGE_PLLA_EXT		0x1A=0A=
+#define SIT9531X_PAGE_PLLB			0x0B=0A=
+#define SIT9531X_PAGE_PLLB_EXT		0x1B=0A=
+#define SIT9531X_PAGE_PLLC			0x0C=0A=
+#define SIT9531X_PAGE_PLLC_EXT		0x1C=0A=
+#define SIT9531X_PAGE_PLLD			0x0D=0A=
+#define SIT9531X_PAGE_PLLD_EXT		0x1D=0A=
+=0A=
+/* PLL index to page mapping */=0A=
+#define SIT9531X_PLL_PAGE(_idx) \=0A=
+	(SIT9531X_PAGE_PLLA + (_idx))=0A=
+=0A=
+/*=0A=
+ * VARIANT_ID is a single byte at page 0 reg 0x02 (95317 =3D 0x17, 95316 =
=3D 0x31).=0A=
+ * Reg 0x03 carries an unrelated revision byte and must not be combined in=
to=0A=
+ * the variant identifier.=0A=
+ */=0A=
+#define SIT9531X_REG_VARIANT_ID		SIT9531X_REG(0x00, 0x02)=0A=
+=0A=
+/* DCO trigger pulse timing: minimum 6 ns required by hardware */=0A=
+=0A=
+#define SIT9531X_REG_HOLDOVER_HISTORY	SIT9531X_REG(0x00, 0x58)=0A=
+=0A=
+/* Page 0 -- PLL inner loop loss-of-lock */=0A=
+#define SIT9531X_REG_PLL_INNER_LOL_STATUS	SIT9531X_REG(0x00, 0x92)=0A=
+#define SIT9531X_REG_PLL_INNER_LOL_NOTIF	SIT9531X_REG(0x00, 0x93)=0A=
+=0A=
+/* Page 0 -- Clock monitor PLL / XO status */=0A=
+#define SIT9531X_REG_CMON_NOTIF		SIT9531X_REG(0x00, 0x9E)=0A=
+=0A=
+/* Page 0 -- PLL outer-loop loss-of-lock */=0A=
+#define SIT9531X_REG_OUTER_LOL_STATUS	SIT9531X_REG(0x00, 0x06)=0A=
+#define SIT9531X_REG_OUTER_LOL_NOTIF		SIT9531X_REG(0x00, 0x07)=0A=
+=0A=
+/* Page 0 -- PLL holdover freeze status */=0A=
+#define SIT9531X_REG_HO_FREEZE_STATUS	SIT9531X_REG(0x00, 0x0A)=0A=
+#define SIT9531X_REG_HO_FREEZE_NOTIF	SIT9531X_REG(0x00, 0x0B)=0A=
+=0A=
+/* Page 0 -- INTSYNC (inter-PLL synchronization) global enable */=0A=
+#define SIT9531X_REG_INTSYNC_GLOBAL		SIT9531X_REG(0x00, 0x40)=0A=
+#define SIT9531X_INTSYNC_EN_BIT		6=0A=
+=0A=
+/*=0A=
+ * Priority table: 6 registers per PLL, each holds two priority slots=0A=
+ * nibble-packed.  The register holding slots 2n and 2n+1 keeps the=0A=
+ * earlier slot (CLK_SPARE<2n>SEL_PLL) in [7:4] and the later one in=0A=
+ * [3:0].=0A=
+ *=0A=
+ * Base registers for PLLA: 0x16-0x1B (slots 0-10 plus the=0A=
+ * active-reference nibble).=0A=
+ * For PLL N:  base + 6 * N  (e.g. PLLB starts at 0x1C).=0A=
+ *=0A=
+ * Input source encoding (4-bit value):=0A=
+ *   0=3DIN0P, 1=3DIN1P, 2=3DIN2P, 3=3DIN3P, 4=3DIN4P,=0A=
+ *   5=3DOCXO, 6=3DINTSYNC,=0A=
+ *   7=3DIN0N, 8=3DIN1N, 9=3DIN2N, 10=3DIN3N, 11=3DIN4N=0A=
+ */=0A=
+#define SIT9531X_PAGE_PRIOSYS		0x01=0A=
+#define SIT9531X_PRIO_BASE_REG		0x16=0A=
+#define SIT9531X_PRIO_REGS_PER_PLL		6=0A=
+#define SIT9531X_PRIO_SLOTS_PER_REG		2=0A=
+/*=0A=
+ * 11 priority slots, CLK_SPARE0SEL_PLL through CLK_SPARE10SEL_PLL.=0A=
+ * The twelfth nibble of the block is not a slot: it is=0A=
+ * CLK_ACTIVESEL_PLL, see SIT9531X_PRIO_ACTIVESEL_OFF below.=0A=
+ */=0A=
+#define SIT9531X_PRIO_MAX_SLOTS		11=0A=
+/* Number of source encodings (0-11), unrelated to the slot count */=0A=
+#define SIT9531X_PRIO_NUM_SRC		12=0A=
+#define SIT9531X_PRIO_NIBBLE_MASK		0x0F=0A=
+#define SIT9531X_PRIO_HI_SHIFT		4=0A=
+/* Input source encoding values (see table above) */=0A=
+#define SIT9531X_PRIO_SRC_OCXO		5=0A=
+#define SIT9531X_PRIO_SRC_INTSYNC		6=0A=
+#define SIT9531X_PRIO_SRC_N_BASE		7=0A=
+/*=0A=
+ * The last register of each PLL's priority block holds, in its low=0A=
+ * nibble, the input source the PLL has currently selected as its=0A=
+ * active reference (CLK_ACTIVESEL_PLL, same 4-bit encoding as above).=0A=
+ */=0A=
+#define SIT9531X_PRIO_ACTIVESEL_OFF		5=0A=
+=0A=
+/*=0A=
+ * Page 0 -- PRG_Directives_GENERIC_0, the main system's programming=0A=
+ * directive register.  Every page carries its own copy of this=0A=
+ * register at offset 0x0F with the same bit layout:=0A=
+ *=0A=
+ *   bit 6  proceed to loop lock / active state from the PRG_CMD state=0A=
+ *   bit 4  update the NVM bank from the efuse contents=0A=
+ *   bit 3  read the efuse=0A=
+ *   bit 2  program the efuse=0A=
+ *   bit 1  small change update (SIT9531X_SMALL_UPDATE_CMD)=0A=
+ *   bit 0  escape to the PRG_CMD state=0A=
+ *=0A=
+ * Only the small change update belongs in a runtime path; the efuse=0A=
+ * and NVM directives touch non-volatile storage.=0A=
+ */=0A=
+#define SIT9531X_REG_GLOBAL_UPDATE		SIT9531X_REG(0x00, 0x0F)=0A=
+#define SIT9531X_SMALL_UPDATE_CMD		0x02=0A=
+=0A=
+/* PLL holdover control (PLL page offset) */=0A=
+#define SIT9531X_PLL_REG_HO_CTRL		0x6F=0A=
+#define SIT9531X_PLL_HO_FORCE_BIT		4=0A=
+=0A=
+/* One bit per input PAIR (bit 0 =3D CLKIN0, ..., bit 3 =3D CLKIN3) */=0A=
+#define SIT9531X_REG_IN_DE_FORCE		SIT9531X_REG(0x02, 0xE8)=0A=
+#define SIT9531X_REG_IN_DE_STATE		SIT9531X_REG(0x02, 0xE9)=0A=
+#define SIT9531X_REG_IN_SEP_FORCE		SIT9531X_REG(0x02, 0xEA)=0A=
+#define SIT9531X_REG_IN_SEP_STATE		SIT9531X_REG(0x02, 0xEB)=0A=
+#define SIT9531X_REG_IN_SEN_FORCE		SIT9531X_REG(0x02, 0xF2)=0A=
+#define SIT9531X_REG_IN_SEN_STATE		SIT9531X_REG(0x02, 0xF3)=0A=
+=0A=
+/*=0A=
+ * One register per input pair at 0x1B + 0x10 * pair=0A=
+ * (CLKIN0 =3D 0x1B, CLKIN1 =3D 0x2B, CLKIN2 =3D 0x3B, CLKIN3 =3D 0x4B).=
=0A=
+ * SE_P_EN/SE_N_EN set means the corresponding lane is configured=0A=
+ * single-ended; both clear means the pair runs differential.=0A=
+ */=0A=
+#define SIT9531X_REG_IN_MODE(_pair)		\=0A=
+	SIT9531X_REG(0x02, 0x1B + 0x10 * (_pair))=0A=
+#define SIT9531X_IN_MODE_SE_P_EN		BIT(0)=0A=
+#define SIT9531X_IN_MODE_SE_N_EN		BIT(1)=0A=
+=0A=
+/* ---- Page 0x03 (Output System) registers -- Hi-Z control ---- */=0A=
+#define SIT9531X_REG_HIZ_DIFF_07_MASK	SIT9531X_REG(0x03, 0xF2)=0A=
+#define SIT9531X_REG_HIZ_DIFF_07_STATE	SIT9531X_REG(0x03, 0xF3)=0A=
+#define SIT9531X_REG_HIZ_DIFF_811_MASK	SIT9531X_REG(0x03, 0xF4)=0A=
+#define SIT9531X_REG_HIZ_DIFF_811_STATE	SIT9531X_REG(0x03, 0xF5)=0A=
+#define SIT9531X_REG_HIZ_SE_07_MASK		SIT9531X_REG(0x03, 0xF8)=0A=
+#define SIT9531X_REG_HIZ_SE_07_STATE		SIT9531X_REG(0x03, 0xF9)=0A=
+#define SIT9531X_REG_HIZ_SE_811_MASK		SIT9531X_REG(0x03, 0xFA)=0A=
+#define SIT9531X_REG_HIZ_SE_811_STATE	SIT9531X_REG(0x03, 0xFB)=0A=
+=0A=
+/*=0A=
+ * Output divider registers in Pages 3/4.  Each output has a 34-bit=0A=
+ * integer divider mapped to 5 bytes (LSB at base reg, MSB at base-4).=0A=
+ * Outputs 0-5 are on Page 3, outputs 6-11 are on Page 4.=0A=
+ *=0A=
+ * The base register for slot N within a page is:=0A=
+ *   clkout_odr_divn_base[slot] =3D { 0x14, 0x24, 0x34, 0x44, 0x54, 0x64 }=
=0A=
+ *=0A=
+ * Layout: base=3DLSB, base-1, base-2, base-3, base-4[1:0]=3DMSB.=0A=
+ *=0A=
+ * Per-chip clkout_map[] translates output index to slot position.=0A=
+ */=0A=
+#define SIT9531X_PAGE_OUTSYS0_SLOT_MAX	5   /* slots 0-5 on Page 0x03 */=0A=
+=0A=
+/* Misc output system registers */=0A=
+#define SIT9531X_REG_PRG_DIR_GEN		SIT9531X_REG(0x03, 0x0F)=0A=
+#define SIT9531X_PRG_CMD_STATE		0x01=0A=
+#define SIT9531X_UPDATE_NVM			0x10=0A=
+#define SIT9531X_LOOP_LOCK			0x40=0A=
+=0A=
+/* Debug register (same offset, per-page) */=0A=
+#define SIT9531X_REG_OUTSYS_DEBUG		SIT9531X_REG(0x03, 0xBD)=0A=
+#define SIT9531X_DEBUG_UNLOCK_VAL		0xC3=0A=
+=0A=
+/*=0A=
+ * Per-output programmable phase delay: 34-bit coarse (in VCO clock=0A=
+ * cycles) plus a 3-bit fine field with fixed 30 ps steps.  Each output=0A=
+ * has a five-byte block PROG6..PROG2:=0A=
+ *=0A=
+ *   base + 0  PROG6  [7:5] OPSTG_VCASC_BUMP (preserve via RMW)=0A=
+ *                    [4:2] PRG_RST_FINE_DELAY[2:0]=0A=
+ *                    [1:0] PRG_RST_DELAY[33:32]=0A=
+ *   base + 1  PROG5  [7:0] PRG_RST_DELAY[31:24]=0A=
+ *   base + 2  PROG4  [7:0] PRG_RST_DELAY[23:16]=0A=
+ *   base + 3  PROG3  [7:0] PRG_RST_DELAY[15:8]=0A=
+ *   base + 4  PROG2  [7:0] PRG_RST_DELAY[7:0]=0A=
+ *=0A=
+ * Outputs 0-5 are on Page 3, outputs 6-11 on Page 4.  The block base=0A=
+ * within a page is 0x15 + 16 * (out_idx % 6).=0A=
+ */=0A=
+#define SIT9531X_OUT_PRG_DELAY_BASE		0x15=0A=
+#define SIT9531X_OUT_PRG_SLOT_STRIDE		0x10=0A=
+#define SIT9531X_OUT_PRG_OPSTG_MASK		0xE0	/* bits [7:5], preserve */=0A=
+#define SIT9531X_OUT_PRG_FINE_SHIFT		2=0A=
+#define SIT9531X_OUT_PRG_FINE_MASK		0x1C	/* bits [4:2] */=0A=
+#define SIT9531X_OUT_PRG_COARSE_HI_MASK		0x03	/* bits [1:0] */=0A=
+#define SIT9531X_OUT_PRG_FINE_STEP_PS		30=0A=
+#define SIT9531X_OUT_PRG_FINE_MAX		7	/* 3-bit field */=0A=
+#define SIT9531X_OUT_PRG_COARSE_BITS		34=0A=
+=0A=
+/*=0A=
+ * Per-output pulse-count control byte used in SYSREF / SYNCB modes.=0A=
+ * Slot N within a page sits at 0x1B + 16 * (slot % 6).  Same page=0A=
+ * mapping as PRG_RST_DELAY: slots 0-5 on Page 3, slots 6-11 on Page 4.=0A=
+ */=0A=
+#define SIT9531X_OUT_PROG0_BASE		0x1B=0A=
+=0A=
+/*=0A=
+ * On-demand phase-flush fired from a register rather than a GPIO pin.=0A=
+ * DIVO_PHASE_SEL_REG selects the in-register trigger source and=0A=
+ * DIVO_PHASE_TRIG flushes the output phase when pulsed high then low.=0A=
+ * The unrelated OEb trigger pair in bits [7:6] must be preserved.=0A=
+ */=0A=
+#define SIT9531X_REG_GPIO_FUNC_CTRL1	SIT9531X_REG(0x00, 0x65)=0A=
+#define SIT9531X_DIVO_PHASE_SEL_REG	BIT(5)=0A=
+#define SIT9531X_DIVO_PHASE_TRIG	BIT(4)=0A=
+=0A=
+/* ---- PLL page registers (apply to pages 0x0A-0x0D) ---- */=0A=
+#define SIT9531X_PLL_REG_SMALL_UPDATE	0x0F=0A=
+=0A=
+/* On-demand phase-flush enable (PLL page reg 0x3D bit 7) */=0A=
+#define SIT9531X_PLL_REG_PHFL_CTRL	0x3D=0A=
+#define SIT9531X_PLL_PHFL_ON_DEMAND_EN	BIT(7)=0A=
+=0A=
+/*=0A=
+ * Loop-filter coefficients on PLL_PAGE regs 0x10-0x15 (3 normal +=0A=
+ * 3 fast-lock) are GUI/NVM-generated by the timing configurator and must =
not be=0A=
+ * reprogrammed at runtime; the register map flags them as=0A=
+ * "GUI generated configuration should not change manually".=0A=
+ */=0A=
+=0A=
+#define SIT9531X_PLL_REG_OUT_MAP_HI		0x27=0A=
+#define SIT9531X_PLL_REG_OUT_MAP_LO		0x28=0A=
+#define SIT9531X_PLL_REG_STATUS		0x31=0A=
+#define SIT9531X_PLL_REG_NVM_UPDATE		0x3F=0A=
+=0A=
+/* DIVN registers (free-run divider readback) */=0A=
+#define SIT9531X_PLL_REG_DIVN_INT		0x30=0A=
+#define SIT9531X_PLL_REG_DIVN_NUM		0x32  /* 4 bytes (0x32-0x35) */=0A=
+#define SIT9531X_PLL_REG_DIVN_DEN		0x38  /* 4 bytes (0x38-0x3B) */=0A=
+=0A=
+/* DIVN2 registers (sync divider readback) */=0A=
+#define SIT9531X_PLL_REG_DIVN2_INT		0x3E  /* 5 bytes (0x3E-0x42) */=0A=
+#define SIT9531X_PLL_REG_DIVN2_FRAC_NUM	0x43  /* 4 bytes (0x43-0x46) */=0A=
+#define SIT9531X_PLL_REG_DIVN2_FRAC_DEN	0x49  /* 4 bytes (0x49-0x4C) */=0A=
+=0A=
+/* Debug register unlock */=0A=
+#define SIT9531X_PLL_REG_DEBUG		0xBD=0A=
+#define SIT9531X_PLL_DEBUG_UNLOCK		0xC3=0A=
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
+#define SIT9531X_PLL_REG_DBG_DATA_4		0xB9  /* [39:32] + sign */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_5		0xBA  /* [47:40] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_6		0xBB=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_7		0xBC=0A=
+#define SIT9531X_PLL_REG_DBG_TRIGGER		0xD0  /* read to latch a sample */=
=0A=
+#define SIT9531X_DBG_DATA_BYTES		8=0A=
+=0A=
+/* Read code of the TDC phase tap, and the sign bit of its sample */=0A=
+#define SIT9531X_DBG_READ_CODE_TDC		69=0A=
+#define SIT9531X_TDC_SIGN_BIT		3=0A=
+=0A=
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
+/*=0A=
+ * DIVN carried as fixed point, and the unit the DPLL ABI wants the=0A=
+ * fractional frequency offset in.  Equal in value, distinct in meaning.=
=0A=
+ */=0A=
+#define SIT9531X_DIVN_SCALE		1000000000000ULL=0A=
+#define SIT9531X_PPT_PER_UNIT		1000000000000ULL=0A=
+=0A=
+/*=0A=
+ * TDC phase-difference measurement setup (PLL page).  Per the vendor=0A=
+ * PhaseDifferenceReader reference procedure, a valid TDC reading needs=0A=
+ * the digital loop filter frozen (so the VCO does not track out the=0A=
+ * measured offset mid-sample) and, on PLLA (the 1PPS phase DPLL), the=0A=
+ * automatic phase/frequency-lock helpers held off.=0A=
+ */=0A=
+#define SIT9531X_PLL_REG_DLPF_FREEZE0	0x8A=0A=
+#define SIT9531X_PLL_REG_DLPF_FREEZE1	0x8B=0A=
+#define SIT9531X_PLL_DLPF_FREEZE_BIT	BIT(5)  /* freeze DLPF (hitless HO) *=
/=0A=
+#define SIT9531X_PLL_REG_APL_CTRL		0x4D=0A=
+#define SIT9531X_PLL_APL_WAKEUP_DIS_BIT	BIT(7)  /* disable APL at wake-up =
*/=0A=
+#define SIT9531X_PLL_APL_SWITCH_EN_BIT	BIT(5)  /* APL on switchover */=0A=
+#define SIT9531X_PLL_REG_AFL_CTRL		0x4E=0A=
+#define SIT9531X_PLL_AFL_WAKEUP_DIS_BIT	BIT(5)  /* disable AFL at wake-up =
*/=0A=
+#define SIT9531X_PLL_CONFIG47_PHFL_BIT	BIT(7)  /* PHFL enable (reg 0x47) *=
/=0A=
+#define SIT9531X_PLL_REG_ACTIVE		0x02=0A=
+#define SIT9531X_PLL_ACTIVE_BIT		BIT(0)  /* PLL reached active state */=0A=
+#define SIT9531X_PLL_REG_RESTART		0x05=0A=
+#define SIT9531X_PLL_RESTART_BIT		BIT(0)  /* restart the PLL */=0A=
+#define SIT9531X_PLL_REG_ZDB0		0x2B=0A=
+#define SIT9531X_PLL_REG_ZDB1		0x1E=0A=
+#define SIT9531X_PLL_ZDB_EN_BIT		BIT(4)  /* zero-delay buffer enabled */=
=0A=
+=0A=
+/* PLL EXT page INTSYNC configuration registers */=0A=
+#define SIT9531X_PLL_EXT_PAGE(_idx)		(SIT9531X_PAGE_PLLA_EXT + (_idx))=0A=
+=0A=
+/* PLL STATUS register bits */=0A=
+#define SIT9531X_PLL_STATUS_LOCK		BIT(0)=0A=
+#define SIT9531X_PLL_STATUS_OUTER_DIS	BIT(5)=0A=
+=0A=
+/* P-polarity status registers */=0A=
+#define SIT9531X_CLKMON_P_STATUS_01		SIT9531X_REG(0x06, 0x02)  /* inputs 0=
,1 */=0A=
+#define SIT9531X_CLKMON_P_NOTIF_01		SIT9531X_REG(0x06, 0x03)=0A=
+#define SIT9531X_CLKMON_P_STATUS_23		SIT9531X_REG(0x06, 0x06)  /* inputs 2=
,3 */=0A=
+#define SIT9531X_CLKMON_P_NOTIF_23		SIT9531X_REG(0x06, 0x07)=0A=
+=0A=
+/* N-polarity status registers */=0A=
+#define SIT9531X_CLKMON_N_STATUS_01		SIT9531X_REG(0x06, 0x92)  /* inputs 0=
,1 */=0A=
+#define SIT9531X_CLKMON_N_NOTIF_01		SIT9531X_REG(0x06, 0x93)=0A=
+#define SIT9531X_CLKMON_N_STATUS_23		SIT9531X_REG(0x06, 0x96)  /* inputs 2=
,3 */=0A=
+#define SIT9531X_CLKMON_N_NOTIF_23		SIT9531X_REG(0x06, 0x97)=0A=
+=0A=
+/* Per-input bit offsets within clock monitor nibble */=0A=
+#define SIT9531X_CLKMON_FREQ_FINE		0  /* bit 0 / bit 4 */=0A=
+#define SIT9531X_CLKMON_FREQ_COARSE		1  /* bit 1 / bit 5 */=0A=
+#define SIT9531X_CLKMON_CLK_LOSS		2  /* bit 2 / bit 6 */=0A=
+#define SIT9531X_CLKMON_CLK_LOSS_FD		3  /* bit 3 / bit 7 */=0A=
+=0A=
+/* ---- Debug / NVM unlock registers ---- */=0A=
+#define SIT9531X_REG_DBG_UNLOCK1		0x24=0A=
+#define SIT9531X_REG_DBG_UNLOCK2		0x25=0A=
+=0A=
+/* ---- Variant ID values (single byte read from SIT9531X_REG_VARIANT_ID) =
---- */=0A=
+#define SIT9531X_VARIANT_ID_95317	0x17=0A=
+#define SIT9531X_VARIANT_ID_95316	0x31=0A=
+=0A=
+#endif /* _SIT9531X_REGS_H */=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
