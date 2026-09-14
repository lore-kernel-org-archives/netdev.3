Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31EB37C93F;
	Mon, 14 Sep 2026 23:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426854; cv=fail; b=qN7TtDuwOvUkOE6c8DLAfptGuvw5QDZthQ5zTn2DZV0bO2T9nnxQp1H6qFKi+25EnAsq5efFrAzSQP9ignS628DiWy5jzg6I5iPOZksYkuNYA+zxJDOXbBJD9C7jozT4KQBvQN75HBhF4rKhQKnB7+yTNolbH2I6URONbTAOnxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426854; c=relaxed/simple;
	bh=l79hDJCWMjoJBLy0WK8Yc2N84/d9Go/IBs43sjPQr3c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ueSAQUrvIZxx+To2LSJ0HL59/q+z+OY++XITYEyWjPds+MbKSW7oHwzh5s6Web2o873txFa+Be5J4awNjMfM0SvhIKTjCvWqHkxMTts4xetqOBDbgcH4eWe5DhP6X1/xSEdLexmtaDLwqVhBaxZANqFKQIp0lLigGrC2AhxCE2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=oBzCkaFO; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=EaMPZgi1; arc=fail smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="oBzCkaFO";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="EaMPZgi1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=MZYbQMRApdSq3e9vx9xJQpwUAHCRx8pSURM4jplpxJA=;
 b=oBzCkaFOPG/7Wwut9OelXrXuf08wAMnuR/q8n+1MD0Z/OQ5kHghLm7nkaMcd09K4HehLlM3koGa5RaUIBS4XAV8CvYC1hn882gIhCe5YP+UoFtch+W1YzCnUBpuaLbs6R86RyrucTId4uPKamxMNVqaUkYrHbPcguJdHCmL6KNYI/HFKaLdFZnLi6B718CNQ1iLIs3AnBUcDfF0Q1qrQYmOgFdHqpY9kTtQN1f+9t2/NDX77Psgdo485DjYqgKftyapk0Te6KSbwAcOXOJnKSnJfP5qVui1DVP2d4XhckyIwIH+dy5958pRzlKcUpCxn3ludBYm+lV+AST/RDMbnqA==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021110.outbound.protection.outlook.com [40.107.208.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id A0607A80077;
	Mon, 14 Sep 2026 23:00:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZocaGBjixX0vA4d2PyRnTZwapd2SjuJfAdt/yv7XQ1Pp7azqGE9x2ADiKS1hZYAmHYowkw16MorM/vevOqkwPGLkIOzQWL+Z1gZJTuV6oUKXNinN7w1+wFo6xlQ0Y81nWbTk5NH160NhvASv8vXxGrQ+mmhaG2LLbxL2Qsd79k9krmp4EoB6RtkMzQHbrzpSx8ePde19txQv2CGgPqiZK53WD6Va++4Q0P+9FN1Js5IJvXX4rTukZG4ZwhctVJ/p/dQqG3bb5/+YChloH/thwukVAfre+aYQb+pdDG4G0WuyhjFsq+Hq22D4YoEQYQykvF+zQDudyy8DTfVJPNoONw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZYbQMRApdSq3e9vx9xJQpwUAHCRx8pSURM4jplpxJA=;
 b=hwaHwl/1aQF/J2bB5xbjbO2PftCYmnUlv17V6RtwVDU9guFArs+79LLbKjPqrRJxb1GvFcGDbDH/H2OTolmzfTJMydADO+agFF6BJbcgefr/38cTDyPTcKgD4ygPHPKtLFjOSUexyiHTofB5bLStk4+mTh1hR47TplhHxjfmHC+CaBDu/SkUR4fD9RNPXBXCtF26m5DQG7DmNByYv0BHJfuilZFt1W+uLXgpwQHaWpqPcW5Y6lsOiG3AYUdNp1llPcccOpfsS/E3wiUTC2YA3UzdCeIwSrqVXJiTXiaqt+AJxkwpLAY7qMQVH1CdXihOJOsHDzZpFHgOqnybc7ql3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZYbQMRApdSq3e9vx9xJQpwUAHCRx8pSURM4jplpxJA=;
 b=EaMPZgi1/a5EjJHdisRUktJaFZ/r3MVU4v105PsNwbuBXhYpbz/D2VdRN/lEUkO95JGyqK8Z2CMXOHE4bJmhO1grszlvU6Gn+9G2BBywOkhjbX1ZIY3je4B+wtlLND4kXTNamE1qaNds5q6r3kfd1nEyHJ+Uj0admOUo/4tc2pyOaSst2Lm28AcqJyK1PZN/fMPKzbMJFi5mr9YKBl0oZJ4NffAqAS1FxzdztQMVI/+Pn8V/JR0m9rpFo59Gw587ZcDSYTb8CWYdmrZeTuK6XdAFTwpEL6k9nOIHwxN1gkvX/3ZEvqgw3FZ8DqgUEkT5H4P7/f868FAI0FYP2T9XLg==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by MW6PR20MB6839.namprd20.prod.outlook.com
 (2603:10b6:303:23e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Mon, 14 Sep
 2026 23:00:40 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 23:00:40 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Ali Rouhi <arouhi@sitime.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v8 08/15] dpll: sit9531x: add support to get and
 set frequency on pins
Thread-Topic: [PATCH net-next v8 08/15] dpll: sit9531x: add support to get and
 set frequency on pins
Thread-Index: AQHdOyOwcC+FoFSTvEyLo9BKWxvO6bbEqYYAgAoZ2wA=
Date: Mon, 14 Sep 2026 23:00:37 +0000
Message-ID: <20260914230034.63861-7-arouhi@sitime.com>
References: <178887151864.219967.4978978194985471898@kernel.org>
In-Reply-To: <178887151864.219967.4978978194985471898@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|MW6PR20MB6839:EE_
x-ms-office365-filtering-correlation-id: 8d773bab-b930-416c-91bc-08df12b3ffa0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|38070700021|6133799003|10067099003|56012099006|5023799004|3023799007|18002099003|22082099003;
x-microsoft-antispam-message-info:
 rUUH32k7BxDwDsKrXGIRlyjGrs2DpEV71QZNrsQMUjvzrZ5Ra1qD/5l4l6mopNsJG6WBckJfP0EP8sM7F4Tn2XJayheK+cIK7yRwXaJu9pnWhHLG4ZmbW1Cfu/k07p3bGxQZ/Vdw4FoOp4X/rKrA/SLrPMpzvN2exTxLsB4u4F5IcF5a+BBPPzT7NKfv9zaiOZH1RhzSnn1X0JuKJiWBGrlKNlAPaXh2QRZBsJV75PvSjWa1CoFFq6cEewXYIespVANyJX6l7zI/uo+sQXZrmF2RlY1CHOlz1D/KQSUW1MEU5M5he92VBzEhShbQcS32BsQHhFnC2idRAv3pzCYDwwVWzHrz9lT//33j3mxx6H8PjrFtNZLEZjvTuktlXz8lrpgvXBgmJb7tXYhZiAZaqY2uGhlcsAsSVAbFQ7FfgQ2nkj6PoaIcoNqglhdJ9yfcKwUDeZVeSo5nUPgUgu0X5q4FSOD2RTujYXjhWg3jFYwB80Ou/sy51ITyku1YFvJXLOloQHv74rjJ87QwDUCoLBPF29XuRKyOAAub12Kaxwxpvgs7+wQrNfV57kbpKzfz+mSJPcofwLf8+udur84UQa4iEFfsZgc8YUuYLXMG8jHfh55/aTonS4I3Q0d99Xs0pigUXSUDOVNQLgMpoDlLtboKBPZcGMPwk57yFfztZIcDGAJXbgzoL+2xrTe9zAohEluCXVbneR6RXvCefjTRVgIJtnTsJCRjj5VzcbLgVp0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(6133799003)(10067099003)(56012099006)(5023799004)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?pphihM491iDRmqQ4zHmUufjcyBNev83U6KGj3aNgE/f2chZ+qh0hH7S7/R?=
 =?iso-8859-1?Q?Kb3RXVWTU9Bdp8iTBGOBV79bGkecjU4kMLrbUv8rLDMOVUr//OwDLrzs0h?=
 =?iso-8859-1?Q?QQRmTE9oH70hjUF2sewE4kOt2JqQKxmczHJNoxwrrz2JeaR//Z2FA9zAiX?=
 =?iso-8859-1?Q?xdO/fzLi5iiJ701rbh2dloVHNVNpa+CEjbTd3yZFHfQm9IwvlcfELUUInL?=
 =?iso-8859-1?Q?ajFdRjpP7Tgp1830UasF9UyUnP7G/P95PR+KlKPn/nIAmGb/bVvRpipj3x?=
 =?iso-8859-1?Q?sl/UC/1tHLCTWHJMyZ47lxA8zKfgtD+tFATVClWrOYkoOk6uAaMDvSS2tS?=
 =?iso-8859-1?Q?kBhzGNQulSLsKkdZKrjn8h4LJj/cQHY9Xn7n5+QoAnV/qaqTMPa+0nba1Y?=
 =?iso-8859-1?Q?7pC+0yAm4yTVzKagpDRw9F/RfxxtTjPQdUiaA7hjDfUf8i6LxcSSzOxXAZ?=
 =?iso-8859-1?Q?vzgRFiYa//mboE4bgLJ1DA60jEndW+1g5+qQklMK4jXI0d3KEMwm7Jz9SI?=
 =?iso-8859-1?Q?OQcOuEiUfgeZ5vtwATaT3uaTM9h82kjTXNFiNQs17dJNVCYVD1jKQPz9/v?=
 =?iso-8859-1?Q?cVSrW1jw6GtesaVLkwle2VWOoJc1gEpp1rwKeAcDC+WA+V1yl5vc0qesUu?=
 =?iso-8859-1?Q?1TMYlttSfGssAGVUj+gv7tqar+ysD4zb/10ZoeXmQQfBBH/iZQ7qFyf0Te?=
 =?iso-8859-1?Q?BkI059nxOMNG7ed/0XfaV/brjJmG1oFi2DEHr2kObv830LbaiamJbqKRu+?=
 =?iso-8859-1?Q?6EQS5Fi6sisvJhZlmcqhHqD1i10hfAFJGt2J0yZFNk+taPlYjtPedmyoas?=
 =?iso-8859-1?Q?C4gnO4JAip/iDNGWmC9DYmAaHk/EDXs6nMQWQHCo+hrVfeORIk2sbIVK6l?=
 =?iso-8859-1?Q?iRVAOALzWrw9uTKIOcSfzvW05g7nO7InGdZ1/yr74NE7blIygJ33xUAg5d?=
 =?iso-8859-1?Q?zk2SnW1V2ydpcl0cNJJybSoZjorm/nLKRzO3lKv/uD4Y4W1ukGcx32GRKQ?=
 =?iso-8859-1?Q?53BNUnWTrn6G6HBTcLNZmvrzGgUIA9Rk0V8viXtusqywAB/qxS0babRAfp?=
 =?iso-8859-1?Q?tVrdebKqrJYkghU+gk8SA7fkmgksJlBoEPi0YTqRfWRk4U5ZjohMky2EYa?=
 =?iso-8859-1?Q?c3SyICspEmiqxPUazXd+RxgHhNc84c7R7G0PSuW2nT6JrXEJ9mDwsHAmAR?=
 =?iso-8859-1?Q?w3YHrYNPdZtWBw5Amnf/fw5MtpcSlvEfF+pDkQIKLlbN0e02kzTS9H8XsZ?=
 =?iso-8859-1?Q?CYFxPS+aa6bMEKbASwixmdTV5qW7dsL3NgNP1NDdKhuMF7WSwZ13pFUk2B?=
 =?iso-8859-1?Q?A5mPqiG6Zk8F4mALKMwuQzTRavugKpqhfWnrSQ2iGxDpOGlBwLjVFardrG?=
 =?iso-8859-1?Q?/UhOLbxzwWPRAsLHxdgH2Spd+x/6dAvkMhnDQ/kMvooO2UfjrI0immkl0+?=
 =?iso-8859-1?Q?eQT7Rp9nuB0HQ/nZxrviubs8e0ZZPbolbZJxC+rIsgGtFRHaobeHeK+7vB?=
 =?iso-8859-1?Q?9sPSihOxLBh0TxWxJMlkD/+2mJCmoxanbJIr3dAQgjpWdn6yGs4pgGfDl2?=
 =?iso-8859-1?Q?DNbgbMSBbmSAA2ECT8GPb3ye5/ExHRNZGJO6YFAuZO5ycTu2uhkOOg+Fzz?=
 =?iso-8859-1?Q?q4P3jIecEJrH8/p0UyloFOKpw78st1dfcp7ZP4ELucA/6cSEknCDbjZn2i?=
 =?iso-8859-1?Q?QTTlCvH7ehk9LgvOQvrOLwjfOy03z1TWdn+/Ta3kIs1koeBFieAGpMWZFd?=
 =?iso-8859-1?Q?Rt2wJ36tttXbJy+Lhh1pDuqGOLy/TziIiezPga5ZGbmIBM?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	JB98zsiO4sZocneCjM4C+40rvMZT9pRkDKQRz1MYrU/CMM4RfaXEgOCSkVVsqF8iMc46B/0vnjKOkmanr6EWwkiNIhE653qaP9iffYQRNpBjc374hW/7ndJ5tYZkCJsYMtD2dZVIipUggNC5y2plcTyIHlmJE75oad73XpsfVWYKnZ6UI+DbUIVxMh/O6Suh2wJw/mum+OXRnhSFCT1chrq29QWly4sGWYK/jiKQKwDWk1wwAYSCB7xBXpiKIHijHgEMmdWG3UANa3kNAhhMANA4CaoS8059RTBJvB1SOR6Rb8o6TH5Fg9UV5xPstOIWga+aCYggJZ40xU/c5Lq/tw==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d773bab-b930-416c-91bc-08df12b3ffa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 23:00:37.8969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XkBWMz+ebzdo5Zqj+WUCQ1gKVHmb2sp9KPAivKwZ3eTYhVERIkcykZVr2ndqw7p9ifGM2SwbKhlzafehHVuxiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR20MB6839
X-MDID: 1789426844-X9ks3jaGrd6w
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1789426844;X9ks3jaGrd6w;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

Replies inline.=0A=
=0A=
> Does a single pin set also carry two side effects the message does not=0A=
> mention? [NVM shadow write, sibling phase restart, ~100 ms]=0A=
=0A=
The v9 changelog now states that a per-pin frequency set runs=0A=
inside the chip's programming state: it updates the NVM shadow, re-locks th=
e=0A=
loops with the required settle time, and restarts the output dividers of th=
e=0A=
owning PLL phase-aligned.  That is the device's programming model for divid=
er=0A=
changes, not something the driver can decompose.=0A=
=0A=
> This comment describes "the previous split between free-run and sync=0A=
> formulas" [...] Could the paragraph be dropped [...]?=0A=
=0A=
Dropped in v9 -- the sit9531x_get_fvco() kernel-doc now describes what=0A=
the function does, without referring to out-of-tree history.=0A=
=0A=
> Is SIT9531X_PLL_PHFL_ON_DEMAND_EN meant to stay set after the flush?=0A=
=0A=
No -- fixed in v9: the on-demand enable is disarmed after the one-shot=0A=
flush, together with the trigger-source restore, so a later assertion of th=
e=0A=
restored trigger cannot re-flush the PLL's outputs.=0A=
=0A=
> Is it safe to program a real divider from a guessed VCO rate here? [...]=
=0A=
> Would returning an error when the VCO cannot be read be preferable, and=
=0A=
> should sit9531x_get_fvco() distinguish a bus error from a dormant PLL?=0A=
=0A=
v9 makes sit9531x_get_fvco()=0A=
propagate a register-read failure as an error distinct from "DIVN not=0A=
programmed", and the frequency setter fails the request instead of programm=
ing=0A=
a divider from a band-edge guess.=0A=
=0A=
> Can a request that the driver advertised as supported be satisfied at a=
=0A=
> materially different rate here?=0A=
=0A=
The advertised set was the real problem and is fixed=0A=
in v9: pins now advertise the concrete firmware-listed rates (plus the curr=
ent=0A=
one), so the normal path validates against rates the divider chain actually=
=0A=
produces.  The wide range remains only on outputs whose DT lists nothing; f=
or=0A=
those the divider can only produce Fvco/N and v9 reports the effective rate=
=0A=
back through frequency_get, which is the value the core then exposes.  We=
=0A=
prefer reporting the achievable truth over rejecting, since a board that=0A=
declares its rates never hits the rounding path.=0A=
=0A=
> What happens to the 34-bit divider when one of these five writes fails=0A=
> partway through?=0A=
=0A=
Fixed in v9: the five previous bytes are read and saved before the=0A=
write, and a mid-sequence failure restores them before the commit, so a mix=
ed=0A=
old/new divider is never latched.=0A=
=0A=
> Is a u32 wide enough for the effective rate this line caches?=0A=
=0A=
The reachable overflow is closed in v9: the setter rejects any request=0A=
above U32_MAX (see below), so no accepted request can cache a wrapping rate=
.=0A=
=0A=
> The Return: block lists 0, -ENODEV and register access errors, but this=
=0A=
> -EINVAL [...] is not among them. [and step numbering]=0A=
=0A=
Both fixed in v9 -- the Return: block lists -EINVAL and the step=0A=
numbering in the doc block and the body agree.=0A=
=0A=
> The changelog says "An input's frequency is what the board presents".  Is=
=0A=
> ref->freq actually that value when a board lists several rates?=0A=
=0A=
The device cannot measure an input's rate, so the board's declaration=0A=
is the only source there is.  When a board lists several rates the first en=
try=0A=
is taken as the nominal one presently wired -- that is a board-authoring=0A=
convention we will spell out in the binding description.  Boards for which=
=0A=
this matters can list the live rate first or list only one rate.=0A=
=0A=
> does this read past ref[] for the INTSYNC pin at this point in the series=
?=0A=
=0A=
Resolved by the v9 registration restructure: the=0A=
INTSYNC pins are not registered until their dedicated ops tables exist, so =
no=0A=
intermediate commit exposes ref[9]/out[12] through the frequency callbacks.=
=0A=
=0A=
> does this also swallow I2C and regmap errors? [freq_get fallback]=0A=
=0A=
v9 falls back to the cached value=0A=
only for -ENODEV (the genuinely unresolvable routing case the comment=0A=
describes) and propagates register access errors, so a transient bus failur=
e=0A=
is not reported as a live frequency and cannot spoof the set path's=0A=
old =3D=3D new short-circuit.=0A=
=0A=
> Should this setter sanity-check the upper bound of frequency itself?=0A=
=0A=
Yes -- fixed in v9: the setter rejects any request above U32_MAX,=0A=
closing the "4294967297 Hz validates as 1 Hz" hole, and independently rejec=
ts=0A=
a DIVO that does not fit its 34-bit field.=0A=
