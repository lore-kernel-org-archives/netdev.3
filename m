Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2822F406261;
	Mon, 21 Sep 2026 20:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.183
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021485; cv=fail; b=RnZ6TfXHZK5SXyiYSmg8kk0ljwD77+lF6J3WMWPQqczU+WZwmdRCYR5sPoPqrZFy19PpcLdQ8kFjN5Belr15ZsX1CeYPJFbfzE/L1L3XHHUKQZ0cREUyVB2a8Ts2mHNA6JUiHSrHLi9G8OzSoPh2SIrygYRbleSP6dO6xFu97IU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021485; c=relaxed/simple;
	bh=r0Q7G6LSEeTCTSSDNMQHVScd8i//uwqyats8HCkKFyE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=csRk18dpsrD6FwP5sJXxhM5wbdgym7ApQXYHTkux5C4oTaEltUHL2wP/5PwzXP8/isQt/zt5HCGzYsjjg0+kFyKSL+p14G6+f7xIycTPtD14bCk2mCbSAr0ClFOJViNcRluWlDBJNaSJceU3q00A3TziboJvdsqnxfs6lbfitVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=LKGPUAVI; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=j1gySxfm; arc=fail smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="LKGPUAVI";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="j1gySxfm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=ruLMedQHoGGng1Hr/f8Y0dtGAFrXUG2iMPDsp7aNo3g=;
 b=LKGPUAVIANKN2MsvurVnPRD4WdQri2mm+++PzQdYz1mxZMe+mO5MuBojbY1QwZOhCpAjoxokDc5BfWNCQByEZswjB+NVjEGxmBXPVIWVIrLPhes+Z2kEHGO2ZQ+tmaHh5kYaPfD/BULMXivcsupduVtqkxqoPoZjM5ZJOP/0BNQIq49i9P1Wj+tq/9UvJ7DaPPBN+Eh1w5ocMmc5oR/zJWTFxwo3ZFclM/QvgFNH9J+d3Gl5tEVPP1cJXAcuIbkFgftz2C0ccN4BGMmxJVbYMfsteP+ieRTs8b7gox5EUrrFrTQb6mH+qX96Su7J3GykaKF7IbrbRBgsETpA5E4LRQ==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020140.outbound.protection.outlook.com [52.101.193.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id D2D37940088;
	Mon, 21 Sep 2026 20:11:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I16bYkVy+2UzfSLu94xxrZulMXXhQdFYFuEw/mLRbxHtp5UOpz9pJ6hcOE2tX/bHjCEfSkmZi+2XqQ17Jc0CwJAt01LRUcPXGP/GjOA0WWqYYaH1cv8lF/c6VqEm5/wit14R/GJB3panoeMdZFBqLCCm4ON/28iMtM+ZAsz4RpOKHvVaWt6FEe62ki7qarD5kxsQPpBYcB+7V8L8YOywGH0cB+rD+FIlRuoWpri55LvHnPMj5QreQBDavwlAPV2SV1YB18e9ti5iNMzHdxVYaIPuGDoKU3H3nR2r6DxO5hyuuukuniZCW8fQ2DDK9IVaodOGo+uwJpyXZpdgRLfGyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruLMedQHoGGng1Hr/f8Y0dtGAFrXUG2iMPDsp7aNo3g=;
 b=m8z6FlgJ7ETmBNp1F1KZPiQYeLIVNNLti6j4q0Xu2huevTRklmR1Mm8DRdIT8f6R4a/TmxPfNhB+MqK0tjgE+LkjIFd0BDHK/CB4ZIcXIktemZnazxqPygLHhoYJDpgHSRl/SoSdLh3y4ePtthNBcsUqCLV9+/V6PaZjRZ47X48UGvXW92P/G3N6YOGACHvEvF64HqlB+bLrqctplM8GGFm51dkQbeKFF11NL16mqQlHfNJbdAbtpnK4pvQAP3/RNsvuCwQcgzmnR/i99wjKOhd+P5bPpguAEOiRyKoA1Xun2Uvg97J2JGPTJnQ7TFibPuIjuGfn2IAoa78n5xKPCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruLMedQHoGGng1Hr/f8Y0dtGAFrXUG2iMPDsp7aNo3g=;
 b=j1gySxfmUApBqmTMPEvaeXtVETALlB2AM6CJ9rLIWOSK7c58LmwfENMsCSgTBLQWa7k52IDDQJ78rrBToEc1bWQf0vjv/Q/BYCHzaKrFR7mgKc1H0zwKXapJyJw5xpEgnjj19QLoVgPTJZgahlKP/68YRg81pDpsbFipHF5xl99lK0mCPgNS4UJ7gIHt919iEwOvGKMyk0ewJDn3iYnfwIA6S4Ubg3CQQo3csse3Ibno7Q3iHyZ+pCtRCvA6tZNlBDpnb6stAk3mDh4h5ha0EWB/ethLpzEy1pE9/ppaVarFePRznLuJZmsBegvqditIUk7PlwERYTbu16bnaWpkfQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS3PR20MB7783.namprd20.prod.outlook.com
 (2603:10b6:8:2df::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:11:16 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 20:11:16 +0000
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
Subject: [PATCH v10 10/14] dpll: sit9531x: add support to adjust output phase
Thread-Topic: [PATCH v10 10/14] dpll: sit9531x: add support to adjust output
 phase
Thread-Index: AQHdSgVbEu4xzG2ARUSsYB0kvUZTDg==
Date: Mon, 21 Sep 2026 20:11:16 +0000
Message-ID: <20260921201108.42676-11-arouhi@sitime.com>
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
x-ms-office365-filtering-correlation-id: bf07858d-488f-4c0e-901b-08df181c7deb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|3023799007|6133799003|22082099003|18002099003|5023799004|38070700021;
x-microsoft-antispam-message-info:
 WCCxgaXZGeft8tRlkC3fglGaaltC3ShdxMve4b5zz2GR8E+35V/fkZ1WdoXrM4yRuG4tCPDMLEXlBp++leyOGM5SGq6kC/O1eU2HIZc4iFA59ETttViineAqSrww98tlHANSct7iShP29Uh28m8tTIldHq04dwVV7YoPpg7oADhvE5oziay4QrQ6d0zqFxBp3fuGObNYGBaFUP4puSIo2o5v/mNKJyLoI8rnwlKbf3FZ+2gyUqfmFq2KICf4gkPBDnR3dssSP/K5nkIERh1u/ijlLuP8vrY/GJHlT/Qtvb3NXFHHJnHdFSrbAgIDvykEk5oy6TJvb5jhKDeFuaK7UsOXThsMU33gTq+ETAbLI86GzSIjJWzV/WxAKs7oshRbv9t0cDS5DaXBGrI8byMkXt68tI+NRnQPa8xsJjdJDXUxBX1fw9DTzpTwZnj7jbOFTifcNwgQAj4qUzswspnmT9esTn0juKldMLnPdYsSfRj/HDC7FZ60UbTmA8vMipRZYlE8exaoaEnPtXdCwLV88Lrc+yC8w+eoRlQ9YCDxrpV40RmT5j5f+I64AURJy0lJsQimYCLYedlJWsVCCBXgoPqg1WkdpV/1mHUS2yWNtcU7tFeNi65cKdVSBMdqba4Q2MExqWLqpPDvCSfN9D6HqrHZe0VR6rmn/yRSYfp3PFDxrbcmM+AfLCUK+3U+bAfzA7ryJT0upZz3XVL/5qBfvbVQkn3JOE8xF3fAy6MZ3zE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003)(5023799004)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?bpEDGSe7TqYMQ25CSnGWtHUVuYIYeLqcOpr6WDzK9Q9LbkX5Uek1Asw7i8?=
 =?iso-8859-1?Q?5/8I94Lp0rNWyU8BsSZibYhXBzud7xRHT37wc+AZisPFou3mwlwZKliG9Q?=
 =?iso-8859-1?Q?cQp4/nBnlbr3ND0a294IgPbUsGKbbzg/fQZXSskHyZNDwuMuh4UrFIrcn7?=
 =?iso-8859-1?Q?/gzaIV8S0DfJXGJZh8KoVh7UGPMTxdbeJLvYJbLCfRcpA6rvKQvseR0oFN?=
 =?iso-8859-1?Q?/0MMNHpCXwQllYlMFUUsLVKGARGUEJLJ1oJTFp9SimEJMfkBY/20STzB71?=
 =?iso-8859-1?Q?9bBRUZMxK+4CnZnmrHI0SUwQm/F9NzFF4B28k6hPQJc3rmD1guWWXxKifN?=
 =?iso-8859-1?Q?O+HWiqEJwgrzYn2M7gpbO1//cCqT4rb3p+L732IWG4UsiVr8sz0aM8DaJd?=
 =?iso-8859-1?Q?5+bYwvsxkrm4nZ5ey2t0Ux8MNTse51I71ffesCP3JQ1ygEpp88qn4RuavG?=
 =?iso-8859-1?Q?onxGKrtpCWg2rF3lnFanBAO6+d4npVuZIz+vI8ult/VA91hKEe6fj4tQTd?=
 =?iso-8859-1?Q?S0prsa2UuNZj9T18ckSLbePKP2HPGE1JV0ZeWqPTF7wIcoGZhQ51qcJ5xo?=
 =?iso-8859-1?Q?y5mtll74Pn7cfZIM4xblOiqar1A1FAQQE3DnlPLKYNG2Z73SQOGbG6NNzF?=
 =?iso-8859-1?Q?+qbiRRBZyZ2tmG6X1G+A0yBahBr5zZ+RmD+qwpD9Bs0rFzcXWZSXATYFfg?=
 =?iso-8859-1?Q?LbMABE2vztLj+fap93vsqLUiaPczCXllcLtlq+njjaV78MMOGeo1vKZrSw?=
 =?iso-8859-1?Q?gfzTQL+KA3U0cUY4Pp2THppsrMmFuabkfIxyW/8cjroYv5UKjjOEaktYxY?=
 =?iso-8859-1?Q?5DW/EJyxQzpMvmONj0NP9KafdDiWLNQmqFY7POvGx1nTJb85lWx4OTbg0L?=
 =?iso-8859-1?Q?+b+wnIll61BX14zgeTGZnNVrrTiPaVogtU7IRgaBuOEUkh4n9EcHJpvjqX?=
 =?iso-8859-1?Q?v29UvZedK2oy+Uvdyukp7i74sFPvtXKT48vfmX7ONZHuUrKW2hn+Kl0JG8?=
 =?iso-8859-1?Q?H5BxzDMaYmeYDhAQD70f2DuooWv4UcQPgHu9/hjva1MNMFzyMOEb0KLrt6?=
 =?iso-8859-1?Q?2FTqp/kBHuQFA65hqJw+soImveLpHhPf8fpM/Vuf6KwdV8neTs3BSE6D23?=
 =?iso-8859-1?Q?jcQKerYgNHRlm3HhFa0uYJuQZtlM1NlyMrNoOidWG5Ad74LtLRknUCrie7?=
 =?iso-8859-1?Q?S1/9hPCWkbb1Yb1Xo2luKPHPhi+oMr9CHSwMluV9Zbrx0uEelxqy2PA4B7?=
 =?iso-8859-1?Q?7ZFjC5wdspKQkPTJBE49gZeS61UuWmM+NronGBPFpg0xPL3szzT+dX8ogT?=
 =?iso-8859-1?Q?Ha29Cb1t2PoMnUzOt+ijy+VP/gRqLWROqXIyO4RHGxqWoJJe2oYGOBL5U7?=
 =?iso-8859-1?Q?/GDvModXzs4aKw//s0spGDOEj4U9R37UqPFHrSegPWSz5QkLiv9eHYSZGS?=
 =?iso-8859-1?Q?p2Of7ZPm5VpshLJ7xVDLsKfee2erqz1KG5aOjdX2dLv0LzKlnGGJLXH0De?=
 =?iso-8859-1?Q?JnGd/nEbKzl76f9f2pUPFgPUs4wNsDC4wBwacJeUw45cJaDSD/w6O1r4Lf?=
 =?iso-8859-1?Q?Rr4npOfIf0f7OWUHBJgxMXJaY8Ywg9XPzUPbl7y5stBKQmKaGlQUBALLdO?=
 =?iso-8859-1?Q?gwZF1vi1ZNFifq1QirOvUAwqMOwcLohX/cAfMJjRtRfP+tWRZsj3+6NgEj?=
 =?iso-8859-1?Q?xVOU2/pGuqF6W9PqoV+MpSMDgvBj5Sdh9EI0kscNbHtRaWpmdeauVxSyX2?=
 =?iso-8859-1?Q?QsnAFhMdCZ0TiAw8vcROgixp/4HYs+CzLDbwV7gkPtBBxX?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	XmUA+Wa/vfZQx4mnnWadQTDk3EKR3OvsEoe9krNipRxRAWceUXYOxvioHx70n/v6rgahKMxSvS2ExVhL+hlf7VxZxlWUTiX1HaytK4PhEa/s9pTli2Qtp2TDhTUnxoi+GltyIWTj2mshEGcGjrKwqyrjs+g1tff11+bD8/KiDTNiMIyhGfSj+WHRPc5cujMXmVVojn4sTxyYVbVa/IBY7Flw37cCiVBVhsnNopGnNj6YBQ1exbMu83Kq7Km6ubhawGmNZ3KuL/NKHhrIZTZr83mwbVBQv/7gVWuul0nX7V44bCOUVzBAA8dy3hMRSOr/SPFBMG5Z+g+JdayPSz/nJA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf07858d-488f-4c0e-901b-08df181c7deb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 20:11:16.0293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mz9FM+qC9nSq4udnpdmtMufHCKYW+28w7VXfSp/hbM7YLxoda2gBwbUV5EvPwDKawJL3Fl/YdQ6CUu7XIcJEQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR20MB7783
X-MDID: 1790021480-P8ugOBvKqVK4
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1790021480;P8ugOBvKqVK4;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Shift an output in time against the others driven by the same PLL.  The=0A=
device has a coarse delay counted in VCO cycles and a three-bit fine field=
=0A=
in fixed thirty-picosecond steps, so a requested offset is split between=0A=
the two and what the core reads back is what the registers hold rather=0A=
than what was asked for.=0A=
=0A=
Delay only ever advances, so an offset larger than one output period is=0A=
folded back into a single period -- for a periodic signal that is the same=
=0A=
phase.  The write takes effect in the programming state, which is left=0A=
with the loops re-locked even when a write inside it failed.=0A=
=0A=
The device has no per-output phase flush, so realigning the adjusted=0A=
output restarts the divider phase of every output that PLL drives.  On a=0A=
part where outputs are deliberately skewed against each other that is a=0A=
visible edge jump on the others, and there is no register that would let=0A=
the driver avoid it.=0A=
=0A=
Suggested-by: Ivan Vecera <ivecera@redhat.com>=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
=0A=
Notes:=0A=
    Changes in v10:=0A=
    Read the programmed delay back from the device: decoded at probe, so a=
=0A=
    delay the profile carries can be cleared, and re-read when a request=0A=
    could not be confirmed.=0A=
    =0A=
    A rate change whose re-timing failed is reported as the rate change it=
=0A=
    was, with the re-timing warned about.=0A=
    =0A=
    Said in the changelog that the device has no per-output phase flush, so=
=0A=
    realigning one output restarts the divider phase of all of them.=0A=
    =0A=
    Folded the three-way sign handling into one abs() and a remainder, and=
=0A=
    skipped the coarse and fine encoding for a zero offset, both as Ivan=0A=
    Vecera suggested.=0A=
=0A=
 drivers/dpll/sit9531x/core.c | 341 ++++++++++++++++++++++++++++++++++-=0A=
 drivers/dpll/sit9531x/core.h |  14 ++=0A=
 drivers/dpll/sit9531x/dpll.c |  78 ++++++++=0A=
 drivers/dpll/sit9531x/prop.c |  19 ++=0A=
 drivers/dpll/sit9531x/regs.h |  28 +++=0A=
 5 files changed, 477 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 8daf0fbf6772..c8c3cd6a64ba 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -1811,6 +1811,69 @@ static int sit9531x_output_divo_write(struct sit9531=
x_dev *sitdev, u8 out_idx,=0A=
 	return rc;=0A=
 }=0A=
 =0A=
+/**=0A=
+ * sit9531x_output_phase_read - read an output's programmed delay back=0A=
+ * @sitdev:	device pointer=0A=
+ * @out_idx:	logical output index=0A=
+ * @phase_ps:	result in picoseconds, always a delay (never an advance)=0A=
+ *=0A=
+ * The delay the chip holds is part of the profile it loads before probe,=
=0A=
+ * and a rate or phase request that failed after its writes reached the=0A=
+ * device leaves the cache describing something else.  Decoding the five=
=0A=
+ * PRG_RST_DELAY bytes is the only way to say what the output is really=0A=
+ * doing.  The registers carry an unsigned delay, so a request that was=0A=
+ * made as an advance reads back as the equivalent delay.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, <0 on error=0A=
+ */=0A=
+int sit9531x_output_phase_read(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			       s32 *phase_ps)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u8 bytes[5], page, base, slot, fine, i;=0A=
+	u64 coarse =3D 0, fvco, ps;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (out_idx >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	rc =3D sit9531x_get_fvco(sitdev, sitdev->out[out_idx].pll_idx, &fvco);=0A=
+	if (rc)=0A=
+		return rc =3D=3D -ENODATA ? -ENODEV : rc;=0A=
+=0A=
+	slot =3D info->clkout_map[out_idx];=0A=
+	page =3D (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX) ?=0A=
+	       SIT9531X_PAGE_OUTSYS1 : SIT9531X_PAGE_OUTSYS0;=0A=
+	base =3D SIT9531X_OUT_PRG_DELAY_BASE +=0A=
+	       SIT9531X_OUT_PRG_SLOT_STRIDE * (slot % 6);=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(bytes); i++) {=0A=
+		rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG(page, base + i),=0A=
+				      &bytes[i]);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+	}=0A=
+=0A=
+	fine =3D (bytes[0] & SIT9531X_OUT_PRG_FINE_MASK) >>=0A=
+	       SIT9531X_OUT_PRG_FINE_SHIFT;=0A=
+	coarse =3D (u64)(bytes[0] & SIT9531X_OUT_PRG_COARSE_HI_MASK) << 32;=0A=
+	coarse |=3D (u64)bytes[1] << 24;=0A=
+	coarse |=3D (u64)bytes[2] << 16;=0A=
+	coarse |=3D (u64)bytes[3] << 8;=0A=
+	coarse |=3D bytes[4];=0A=
+=0A=
+	ps =3D mul_u64_u64_div_u64(coarse, 1000000000000ULL, fvco);=0A=
+	ps +=3D (u64)fine * SIT9531X_OUT_PRG_FINE_STEP_PS;=0A=
+=0A=
+	*phase_ps =3D (s32)min_t(u64, ps, S32_MAX);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
 			     u8 pll_idx, u64 frequency)=0A=
 {=0A=
@@ -1864,7 +1927,41 @@ int sit9531x_output_freq_set(struct sit9531x_dev *si=
tdev, u8 out_idx,=0A=
 =0A=
 	sitdev->out[out_idx].freq =3D div64_u64(fvco, divo);=0A=
 =0A=
-	return 0;=0A=
+	/*=0A=
+	 * The programmed reset delay counts VCO cycles against the output=0A=
+	 * period in force when it was written, so a rate change silently=0A=
+	 * re-times a previously requested phase adjust.  Re-encode the=0A=
+	 * cached picosecond request against the new rate.=0A=
+	 *=0A=
+	 * Keyed off whether a delay was ever programmed rather than off the=0A=
+	 * cached value: quantization can leave a whole period in the=0A=
+	 * registers, which is the same phase and caches as zero, and that=0A=
+	 * still has to be re-timed when the period changes.=0A=
+	 */=0A=
+	if (sitdev->out[out_idx].phase_armed) {=0A=
+		s32 phase_ps =3D sitdev->out[out_idx].phase_adj;=0A=
+		int ph_rc;=0A=
+=0A=
+		/*=0A=
+		 * The rate is already programmed and latched at this point.=0A=
+		 * Failing the request for a re-timing that did not take=0A=
+		 * would report a frequency set that did not happen, and the=0A=
+		 * core drops an identical retry because it asks the driver=0A=
+		 * for the current rate first -- which is the new one.  Say=0A=
+		 * what went wrong and mark the delay for a read-back=0A=
+		 * instead.=0A=
+		 */=0A=
+		ph_rc =3D sit9531x_output_phase_adjust_set(sitdev, out_idx,=0A=
+							 phase_ps);=0A=
+		if (ph_rc) {=0A=
+			sitdev->out[out_idx].phase_stale =3D true;=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "out%u: rate changed but the phase adjust was not re-timed (%d)\n",=
=0A=
+				 out_idx, ph_rc);=0A=
+		}=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -1946,14 +2043,227 @@ int sit9531x_output_freq_get(struct sit9531x_dev *=
sitdev, u8 out_idx,=0A=
  *   base + 3  PROG3  PRG_RST_DELAY[15:8]=0A=
  *   base + 4  PROG2  PRG_RST_DELAY[7:0]=0A=
  *=0A=
- * Outputs 0-5 live on Page 3, outputs 6-11 on Page 4, with each=0A=
- * output's block at base =3D 0x15 + 16 * (out_idx % 6).=0A=
+ * Slots 0-5 live on Page 3, slots 6-11 on Page 4, with each slot's=0A=
+ * block at base =3D 0x15 + 16 * (slot % 6); the slot is the physical=0A=
+ * output position from clkout_map[], not the logical output index.=0A=
  *=0A=
  * The chip only supports unsigned positive delay.  A negative phase=0A=
  * adjustment (advance) is wrapped to (T_out - |phase|) modulo one=0A=
  * output period, which is identical for a periodic signal.=0A=
  */=0A=
 =0A=
+int sit9531x_output_phase_adjust_set(struct sit9531x_dev *sitdev,=0A=
+				     u8 out_idx, s32 phase_ps)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u64 abs_ps, fvco, coarse =3D 0, coarse_ps, t_out_ps;=0A=
+	s64 phase_norm_ps =3D 0;=0A=
+	u8 page, base, prog6_val, fine =3D 0;=0A=
+	u8 old_bytes[5], new_bytes[5], i;=0A=
+	u8 pll_idx, slot;=0A=
+	u64 freq;=0A=
+	int rc, ret, rb_rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (out_idx >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	pll_idx =3D sitdev->out[out_idx].pll_idx;=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	freq =3D sitdev->out[out_idx].freq;=0A=
+	if (!freq) {=0A=
+		/*=0A=
+		 * The cache is only seeded by a DT frequency list or an=0A=
+		 * earlier get/set; a board without supported-frequencies-hz=0A=
+		 * would otherwise get -EINVAL on every phase request forever.=0A=
+		 * Read the effective rate back from the divider chain.=0A=
+		 */=0A=
+		rc =3D sit9531x_output_freq_get(sitdev, out_idx, &freq);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+		if (!freq)=0A=
+			return -EINVAL;=0A=
+	}=0A=
+=0A=
+	rc =3D sit9531x_get_fvco(sitdev, pll_idx, &fvco);=0A=
+	if (rc)=0A=
+		return rc =3D=3D -ENODATA ? -ENODEV : rc;=0A=
+=0A=
+	t_out_ps =3D div64_u64(1000000000000ULL, freq);=0A=
+	if (!t_out_ps)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/*=0A=
+	 * Convert to unsigned absolute delay.  Both signs are folded=0A=
+	 * modulo one period: positive delays wrap naturally, negative=0A=
+	 * delays are rendered as T_out - |phase|.  abs() is safe here=0A=
+	 * because the core rejects anything outside the advertised phase=0A=
+	 * range, which is +/-1 ms.  div64_u64_rem() rather than the %=0A=
+	 * operator: a 64-bit modulo has no compiler helper on 32-bit=0A=
+	 * targets and leaves the module with an undefined __umoddi3.=0A=
+	 */=0A=
+	abs_ps =3D abs(phase_ps);=0A=
+	div64_u64_rem(abs_ps, t_out_ps, &abs_ps);=0A=
+	phase_norm_ps =3D phase_ps < 0 ? -(s64)abs_ps : (s64)abs_ps;=0A=
+	abs_ps =3D (phase_ps < 0 && abs_ps) ? t_out_ps - abs_ps : abs_ps;=0A=
+=0A=
+	if (abs_ps) {=0A=
+		u64 rem_ps;=0A=
+=0A=
+		/*=0A=
+		 * coarse_cycles =3D abs_ps * Fvco / 1e12 ps/s.=0A=
+		 * mul_u64_u64_div_u64() avoids overflow when abs_ps approaches=0A=
+		 * one second of 1 PPS wrap-around.=0A=
+		 */=0A=
+		coarse =3D mul_u64_u64_div_u64(abs_ps, fvco, 1000000000000ULL);=0A=
+		if (coarse >=3D (1ULL << SIT9531X_OUT_PRG_COARSE_BITS))=0A=
+			return -ERANGE;=0A=
+=0A=
+		/*=0A=
+		 * Fine delay =3D round((abs_ps - coarse * vco_period_ps) / 30 ps)=0A=
+		 */=0A=
+		coarse_ps =3D mul_u64_u64_div_u64(coarse, 1000000000000ULL, fvco);=0A=
+		rem_ps =3D (abs_ps > coarse_ps) ? (abs_ps - coarse_ps) : 0;=0A=
+		if (rem_ps) {=0A=
+			u64 steps;=0A=
+=0A=
+			steps =3D div64_u64(rem_ps +=0A=
+					  SIT9531X_OUT_PRG_FINE_STEP_PS / 2,=0A=
+					  SIT9531X_OUT_PRG_FINE_STEP_PS);=0A=
+			if (steps > SIT9531X_OUT_PRG_FINE_MAX)=0A=
+				steps =3D SIT9531X_OUT_PRG_FINE_MAX;=0A=
+			fine =3D (u8)steps;=0A=
+		}=0A=
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
+	for (i =3D 0; i < ARRAY_SIZE(old_bytes); i++) {=0A=
+		rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG(page, base + i),=0A=
+				      &old_bytes[i]);=0A=
+		if (rc)=0A=
+			goto commit;=0A=
+	}=0A=
+=0A=
+	/* PROG6 RMW: preserve OPSTG_VCASC_BUMP in [7:5] */=0A=
+	prog6_val =3D old_bytes[0] & SIT9531X_OUT_PRG_OPSTG_MASK;=0A=
+	prog6_val |=3D (fine << SIT9531X_OUT_PRG_FINE_SHIFT) &=0A=
+		     SIT9531X_OUT_PRG_FINE_MASK;=0A=
+	prog6_val |=3D (u8)((coarse >> 32) & SIT9531X_OUT_PRG_COARSE_HI_MASK);=0A=
+=0A=
+	new_bytes[0] =3D prog6_val;=0A=
+	new_bytes[1] =3D (u8)((coarse >> 24) & 0xFF);=0A=
+	new_bytes[2] =3D (u8)((coarse >> 16) & 0xFF);=0A=
+	new_bytes[3] =3D (u8)((coarse >> 8) & 0xFF);=0A=
+	new_bytes[4] =3D (u8)(coarse & 0xFF);=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(new_bytes); i++) {=0A=
+		rc =3D sit9531x_write_u8(sitdev,=0A=
+				       SIT9531X_REG(page, base + i),=0A=
+				       new_bytes[i]);=0A=
+		if (rc)=0A=
+			goto rollback;=0A=
+	}=0A=
+=0A=
+	goto commit;=0A=
+=0A=
+rollback:=0A=
+	rb_rc =3D 0;=0A=
+	for (i =3D 0; i < ARRAY_SIZE(old_bytes); i++) {=0A=
+		ret =3D sit9531x_write_u8(sitdev,=0A=
+					SIT9531X_REG(page, base + i),=0A=
+					old_bytes[i]);=0A=
+		if (ret && !rb_rc)=0A=
+			rb_rc =3D ret;=0A=
+	}=0A=
+	if (rb_rc) {=0A=
+		dev_err(sitdev->dev,=0A=
+			"out%u: phase-adjust rollback failed (%d), the delay registers are part=
 old and part new\n",=0A=
+			out_idx, rb_rc);=0A=
+		if (!rc)=0A=
+			rc =3D rb_rc;=0A=
+	}=0A=
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
+	rc =3D sit9531x_output_phase_flush(sitdev, pll_idx);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/*=0A=
+	 * Cache what the registers realize, and only once every step has=0A=
+	 * succeeded: the core drops a repeated request with the same value,=0A=
+	 * so a cache updated by a failed call would make the retry a no-op.=0A=
+	 *=0A=
+	 * Quantizing to whole VCO cycles plus 30 ps steps can land a few=0A=
+	 * picoseconds past the end of the period, which would wrap the=0A=
+	 * subtraction below; one period is the most a delay can be.=0A=
+	 */=0A=
+	coarse_ps =3D mul_u64_u64_div_u64(coarse, 1000000000000ULL, fvco);=0A=
+	abs_ps =3D coarse_ps + (u64)fine * SIT9531X_OUT_PRG_FINE_STEP_PS;=0A=
+	if (abs_ps > t_out_ps)=0A=
+		abs_ps =3D t_out_ps;=0A=
+	if (phase_norm_ps < 0)=0A=
+		sitdev->out[out_idx].phase_adj =3D=0A=
+			abs_ps ? -(s32)(t_out_ps - abs_ps) : 0;=0A=
+	else=0A=
+		/*=0A=
+		 * The cache is an s32 because that is what the ABI carries.=0A=
+		 * A delay is bounded by the output period, which on a slow=0A=
+		 * output is wider than that, so bound the cast.  The negative=0A=
+		 * branch above needs no bound: what it stores is the advance=0A=
+		 * that was asked for, and that came in as an s32.=0A=
+		 */=0A=
+		sitdev->out[out_idx].phase_adj =3D (s32)min(abs_ps,=0A=
+							  (u64)S32_MAX);=0A=
+=0A=
+	/*=0A=
+	 * Record that a delay is programmed whatever it quantized to.  A=0A=
+	 * request that lands on a whole period caches as zero, and the rate=0A=
+	 * change that follows still has to re-time what the registers hold.=0A=
+	 */=0A=
+	sitdev->out[out_idx].phase_armed =3D true;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_clear_notifications - clear all notification registers=0A=
  *=0A=
@@ -2368,12 +2678,37 @@ static int sit9531x_dev_state_fetch(struct sit9531x=
_dev *sitdev)=0A=
 	}=0A=
 =0A=
 	for (i =3D 0; i < sitdev->info->num_outputs; i++) {=0A=
+		s32 phase_ps;=0A=
+=0A=
 		rc =3D sit9531x_out_state_fetch(sitdev, i);=0A=
 		if (rc) {=0A=
 			dev_err(sitdev->dev,=0A=
 				"Failed to fetch output %u state: %d\n", i, rc);=0A=
 			return rc;=0A=
 		}=0A=
+=0A=
+		/*=0A=
+		 * The delay registers are part of the profile the chip loads=0A=
+		 * before probe, so an output can already carry one.  Seeding=0A=
+		 * the cache from the device is what lets a request of 0 ps=0A=
+		 * clear it: the core drops a request equal to what the=0A=
+		 * getter reports, and a cache that started at zero would=0A=
+		 * make clearing a programmed delay impossible.  An output=0A=
+		 * the configuration does not route has no Fvco to decode=0A=
+		 * against, which is not an error here.=0A=
+		 */=0A=
+		mutex_lock(&sitdev->multiop_lock);=0A=
+		rc =3D sit9531x_output_phase_read(sitdev, i, &phase_ps);=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		if (!rc) {=0A=
+			sitdev->out[i].phase_adj =3D phase_ps;=0A=
+			sitdev->out[i].phase_armed =3D !!phase_ps;=0A=
+		} else if (rc !=3D -ENODEV) {=0A=
+			dev_err(sitdev->dev,=0A=
+				"Failed to read output %u delay: %d\n",=0A=
+				i, rc);=0A=
+			return rc;=0A=
+		}=0A=
 	}=0A=
 =0A=
 	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 3b35bf1c4cd5..7848ac9bd6ca 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -102,6 +102,13 @@ struct sit9531x_ref {=0A=
  * @routed:		output is mapped to @pll_idx by the initial=0A=
  *			configuration; an unrouted output has no DPLL pin=0A=
  * @pll_idx:		PLL driving this output (0-3)=0A=
+ * @phase_stale:	the programmed delay may differ from @phase_adj=0A=
+ * @phase_armed:	a phase adjust has been programmed, so a rate=0A=
+ *			change has to re-time it even when it quantized=0A=
+ *			to zero=0A=
+ * @phase_adj:		phase adjust the delay registers actually realize,=0A=
+ *			i.e. the last request quantized to whole VCO cycles=0A=
+ *			plus 30 ps fine steps, in the request's sign=0A=
  * @label:		board label from DT or default=0A=
  */=0A=
 struct sit9531x_out {=0A=
@@ -111,6 +118,9 @@ struct sit9531x_out {=0A=
 	bool		state_stale;=0A=
 	bool		routed;=0A=
 	u8		pll_idx;=0A=
+	s32		phase_adj;=0A=
+	bool		phase_armed;=0A=
+	bool		phase_stale;=0A=
 	const char	*label;=0A=
 };=0A=
 =0A=
@@ -268,6 +278,10 @@ int sit9531x_output_freq_get(struct sit9531x_dev *sitd=
ev, u8 out_idx,=0A=
 			     u64 *frequency);=0A=
 =0A=
 /* ---- Output phase adjust (PRG_RST_DELAY register-based) ---- */=0A=
+int sit9531x_output_phase_read(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			       s32 *phase_ps);=0A=
+int sit9531x_output_phase_adjust_set(struct sit9531x_dev *sitdev,=0A=
+				     u8 out_idx, s32 phase_ps);=0A=
 =0A=
 /* ---- Notification clear ---- */=0A=
 int sit9531x_clear_notifications(struct sit9531x_dev *sitdev);=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index c1ab202bf297..af1089f192b6 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -868,12 +868,90 @@ sit9531x_dpll_output_pin_state_on_dpll_set(const stru=
ct dpll_pin *pin,=0A=
 	return rc;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_phase_adjust_get - read output phase adjustmen=
t=0A=
+ *=0A=
+ * Returns what the delay registers hold, i.e. the value=0A=
+ * sit9531x_output_phase_adjust_set() programmed after quantization, read=
=0A=
+ * from the cache unless a failed request left it unconfirmed.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_phase_adjust_get(const struct dpll_pin *pin,=0A=
+					  void *pin_priv,=0A=
+					  const struct dpll_device *dpll,=0A=
+					  void *dpll_priv, s32 *phase_adjust,=0A=
+					  struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	/*=0A=
+	 * A request whose writes reached the device but whose commit or=0A=
+	 * phase flush failed left the cache describing the delay before it.=0A=
+	 * There is no poll of the delay registers to correct that, so read=0A=
+	 * them here rather than report a value the output is not using.=0A=
+	 */=0A=
+	if (sitdev->out[dpin->id].phase_stale) {=0A=
+		s32 phase_ps;=0A=
+=0A=
+		rc =3D sit9531x_output_phase_read(sitdev, dpin->id, &phase_ps);=0A=
+		if (rc) {=0A=
+			mutex_unlock(&sitdev->multiop_lock);=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "Output delay could not be read back");=0A=
+			return rc;=0A=
+		}=0A=
+		sitdev->out[dpin->id].phase_adj =3D phase_ps;=0A=
+		sitdev->out[dpin->id].phase_armed =3D !!phase_ps;=0A=
+		sitdev->out[dpin->id].phase_stale =3D false;=0A=
+	}=0A=
+	*phase_adjust =3D sit9531x_out_state_get(sitdev, dpin->id)->phase_adj;=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
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
+	return 0;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_output_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_output_pin_direction_get,=0A=
 	.frequency_get		=3D sit9531x_dpll_output_pin_frequency_get,=0A=
 	.frequency_set		=3D sit9531x_dpll_output_pin_frequency_set,=0A=
 	.state_on_dpll_get	=3D sit9531x_dpll_output_pin_state_on_dpll_get,=0A=
 	.state_on_dpll_set	=3D sit9531x_dpll_output_pin_state_on_dpll_set,=0A=
+	.phase_adjust_get	=3D sit9531x_dpll_output_pin_phase_adjust_get,=0A=
+	.phase_adjust_set	=3D sit9531x_dpll_output_pin_phase_adjust_set,=0A=
 };=0A=
 =0A=
 const struct dpll_pin_ops *=0A=
diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c=0A=
index 8270b8ee91be..82e8cd2266f5 100644=0A=
--- a/drivers/dpll/sit9531x/prop.c=0A=
+++ b/drivers/dpll/sit9531x/prop.c=0A=
@@ -228,6 +228,25 @@ sit9531x_pin_props_get(struct sit9531x_dev *sitdev,=0A=
 		props->dpll_props.capabilities =3D=0A=
 			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
 		curr_freq =3D sitdev->out[index].freq;=0A=
+=0A=
+		/*=0A=
+		 * Allow phase-adjust over a +/-1 ms window.  The subsystem=0A=
+		 * rejects pin_set(phase-adjust, X) when X falls outside=0A=
+		 * [min, max], so leaving these at 0 silently blocks every=0A=
+		 * netlink call.  1 ms is well beyond the DCO dynamic range=0A=
+		 * but costs nothing.  Only outputs get a range: input pins=0A=
+		 * have no .phase_adjust_set, and advertising one there would=0A=
+		 * promise userspace something every set would refuse.=0A=
+		 */=0A=
+		/* +/-1 ms, in ps */=0A=
+		props->dpll_props.phase_range.min =3D -1000000000;=0A=
+		props->dpll_props.phase_range.max =3D 1000000000;=0A=
+		/*=0A=
+		 * The fine step is 30 ps, but requests are accepted at 1 ps=0A=
+		 * resolution and rounded to the nearest achievable delay, so=0A=
+		 * advertise the request granularity, not the hardware step.=0A=
+		 */=0A=
+		props->dpll_props.phase_gran =3D 1;=0A=
 	}=0A=
 =0A=
 	/* Generate package label */=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index 8ce048e9c8f1..cbce62404c97 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -194,6 +194,34 @@=0A=
 #define SIT9531X_DEBUG_UNLOCK_VAL		0xC3=0A=
 #define SIT9531X_DEBUG_LOCK_VAL			0x00=0A=
 =0A=
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
+ * Slots 0-5 are on Page 3, slots 6-11 on Page 4.  The block base=0A=
+ * within a page is 0x15 + 16 * (slot % 6), where slot is the physical=0A=
+ * output slot from clkout_map[], not the logical output index.=0A=
+ */=0A=
+#define SIT9531X_OUT_PRG_DELAY_BASE		0x15=0A=
+#define SIT9531X_OUT_PRG_SLOT_STRIDE		0x10=0A=
+/* bits [7:5], preserve */=0A=
+#define SIT9531X_OUT_PRG_OPSTG_MASK		0xE0=0A=
+#define SIT9531X_OUT_PRG_FINE_SHIFT		2=0A=
+#define SIT9531X_OUT_PRG_FINE_MASK		0x1C	/* bits [4:2] */=0A=
+#define SIT9531X_OUT_PRG_COARSE_HI_MASK		0x03	/* bits [1:0] */=0A=
+#define SIT9531X_OUT_PRG_FINE_STEP_PS		30=0A=
+#define SIT9531X_OUT_PRG_FINE_MAX		7	/* 3-bit field */=0A=
+#define SIT9531X_OUT_PRG_COARSE_BITS		34=0A=
+=0A=
 /*=0A=
  * On-demand phase-flush fired from a register rather than a GPIO pin.=0A=
  * DIVO_PHASE_SEL_REG selects the in-register trigger source and=0A=
-- =0A=
2.43.0=0A=
=0A=
