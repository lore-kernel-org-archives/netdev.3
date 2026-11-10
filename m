Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.154.183
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794342413;
	b=KmCsKb3zVPSio2D628e/qnXH8zRHHK8HJbGhwCWFhvatUGHhUphuH0qsPkp/io/WIx3B
	 WpWrzEAVciSAV8dSuIJWhR9cy23VW8FXOjomM7D0NImzBGCqCTnFz/IXEJzJkk9Q/uY8t
	 RW/+egXDUM9D/5E4k1t+TKABbeWfbe/gIz7ozlGieuD3POAby0EaW9YeLDyjExANizihv
	 D6TS2oRlqCjLdr32bAauZqpLX9e09s9FnvdPTkeGZ+1rEoaLy7w/wvClAAV3kL8H8lhnH
	 3MqtDLQureJ5UdFOPTgGJ1zKsE2Dc03LKyauWVgx2jYupNZFfaoxX0p6cTxyPcH5VRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342413;
	h=DMARC-Filter:DKIM-Signature:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-MDID:X-PPE-STACK:
	 X-MDID-O:X-PPE-TRUSTED;
	bh=JkhMhbgCNLSiBc4JnuDQTmZeqFw8xX3MLPLMpFN18Tw=;
	b=QIGP7vfBjvn68VkF/HD3h8MGFkiqiUZ6lMsoa2/8aoum6qh4hLYl/FYn7ZPrugswbBgE
	 JVDosSHjRKat8wN5FG3G2HqkMCwLT2JsAT17mOjSF62+QDiitpRK49yTptrHhOKPCVepF
	 cqUA5bJiVRR3ue5DyEnCoZl2ZeWnOxdE+iGU7Bl1j8XY8M5TyXSinVvZJSfZGHU15xpfy
	 ZGb7Ra+DZm0Bd2qnKBBP+YPj9UuljBANgAcbYIER+5IgWF1VfneiwSu+aB+5h0Pm3+USh
	 narC5AiIipBv8D36NOYP7qO7aq2VLs2hLHJfZcTauft/CkdkSNQwXb8vjH8rctUiZFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sitime.com;
	spf=pass smtp.mailfrom=sitime.com;
	dkim=pass header.d=sitime.com header.i=@sitime.com header.a=rsa-sha256 header.s=mail header.b=oYIp8pV8;
	dkim=pass header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-Sitime-onmicrosoft-com header.b=1It055Ft;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.154.183
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82175606A89A;
	Tue, 10 Nov 2026 20:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82175606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.a=rsa-sha256 header.s=mail header.b=oYIp8pV8;
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-Sitime-onmicrosoft-com header.b=1It055Ft
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=JkhMhbgCNLSiBc4JnuDQTmZeqFw8xX3MLPLMpFN18Tw=;
 b=oYIp8pV8dJ6dafRt2VegZgFLexoMA1mtFs5eOCJ0oBUodnKD6mzWKDSsXMFqJdVGubRRuKIrvUvpOzfagh8nHwfu7Eortf7nioVYyluvzBSZcxtCfYeD3/nUpT/tX3FCJYk6WOExtMoWoo+XOb7DRJnYBVId0z6iJcqx3tQcDYR0/MjeLJm15OHimvop8Mz82FpVr9WoIuBE+UYs/m45TFp5xGkx18pFDJlf/0dwngd5RfnhW8Q1lF/shsNsrA129qy2b6OdQmzlJ2su1I3gdS+I53tC3YINoQA56m+Df2xOgM6ev5AmKa+8Lsw7QkhN9V7o/BH2NhOszHbStImj0g==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023085.outbound.protection.outlook.com [40.107.201.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 84D493C006A;
	Tue, 10 Nov 2026 20:26:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJDLf6bu8BjwO+cYdkaE8z6LgJZvvbqkvraiuXHFQz+AZvnLEG0NipUj3Fh6uE4gaK7Pbe3dYVZCY2gX9HaXovzDf4U5uVplQPmKxVehs58h2K85T78QhM1FI0lEFu3RPyoT8B0ymbRDUcUE3kXV1goeZKJ+3dTm8RzTe/JLpbMmP/NYmbWHiWsGmVEWtMEv+BIu/ZMPaEoRPZ87Fb+fvuHyrGzlymN9ZjK4eYopsePJCcF5RAiEr8XspGvHPFpvFFntPrfvJZqR6RyllxCIwHco0krnLUPlHdw4oYOcec2pIgvGqvZIUyd9wuDMV3Qj6FuWGoQE2mRtxqx0LCR3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkhMhbgCNLSiBc4JnuDQTmZeqFw8xX3MLPLMpFN18Tw=;
 b=CscUaQn6dieEJZUTFzga1gk0FrUMxGNGk4dKnrRMw+gwHJpgfmkT9/7mZKIWR83T5Nolb9W3jxlC0tRNBMdLktw1MwJ51k39hVV9NelYiEbTaNu3AOOEMpWntxKrHvHiFdsUhaKrvCPLaZepHm2UnS8HUSvW7VcNbnjAM5vlI7ShSMS70s4HEfSYHfb+ZmUFMiE/bDspQLAK+lzKjITvb03r6tXfo9D1Y7ODGHzUTjgdsffFBqdU9RsKEt3xt+n2lDt9/ZMxTKxQZVMblOlA8iWL+AIcHeC7Heozp6Bq7EZONKzxu0KpfJ0zAeeb1orLKN0P24XLEaxEIgBTjNST8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkhMhbgCNLSiBc4JnuDQTmZeqFw8xX3MLPLMpFN18Tw=;
 b=1It055Ft2FZ9pEprhWifKeWoRhkrj4RlGDQxewM9/IUFXqg1rV+dJT4HnsLyf+7HwMZH6V5cIuWI2fM19B0yFzV8hsA4hq+yQ9TYpT38o1GEJjJVqaqckvZOQwCwRWJuHHFccFrbwV18u1/waZzFDfdmt8LkpGR5AeXVaERf2FHAWGq5/tr/rfJpX0/KVYLN0RQgouiK84Sos23soMuSMh+X4E7uyrY05NuU1Vpp4XvHnybdABvuzFuOVBqdVb4nUa9ItxcPo/pFWrn7M+k4ODXeHgZBeLbmhu5c0fH/PGwu+iKANGbDMZbuP+HEW/ZV6yNsHAgySFcQChKQmOWQ/Q==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CH3PR20MB5745.namprd20.prod.outlook.com
 (2603:10b6:610:14d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 20:26:23 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 20:26:23 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "Oleg.Zadorozhnyi@devoxsoftware.com"
	<Oleg.Zadorozhnyi@devoxsoftware.com>,
	"prabhakar.mahadev-lad.rj@bp.renesas.com"
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v15 09/13] dpll: sit9531x: add support to get and set
 frequency on pins
Thread-Topic: [PATCH net-next v15 09/13] dpll: sit9531x: add support to get
 and set frequency on pins
Thread-Index: AQHdcVG7o7sdd6yBTkWc7dxYLNIA4g==
Date: Tue, 10 Nov 2026 20:26:14 +0000
Message-ID: <20261110202607.55744-10-arouhi@sitime.com>
References: <20261110202607.55744-1-arouhi@sitime.com>
In-Reply-To: <20261110202607.55744-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|CH3PR20MB5745:EE_
x-ms-office365-filtering-correlation-id: c423c921-455b-4648-1219-08df3f68e33f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|56012099006|5023799004|18002099003|22082099003|6133799003|10067099003|261009223027099003|261009223327099003|261009220027099003|261009221227099003|261009221727099003|261021121427099003|261028144727099003|261021123027099003|261102123227099003|261022075727099003|261022105027099003|261026140227099003|261026121527099003|3023799007;
x-microsoft-antispam-message-info:
 JpMKIOHz0G8Cfr/vArj6VKW0fTkuTl1+dSQPlTxDG6XkIV3zi35WfKqX8avBNLQwYd52WdhFUHcGJPbQwyN1qQ+ZpAte7WDe3Qt7tv9UY6rho8mnN6ZDXhfftezmowFJYxhjBtbNr3ULdvDdhoBJcJCbdiw6LVadLamjA2Tgo+d0H5Fhj+yvVfVrTe2xBd72S7CrmZ6bZuSejazy0Lqi3JaaUt8NKymiJxLwRNn6Eozcz8aDcVgbgjXa9NDd/s8T4MhyUQgmwFqgWfIgw9f/L7cLLGDUm6qFy2TxbtFwO4GWqmr3ionF0YzqtPAR+050Mw0qEY/lUVgt47UBTcrn030lddNYwSAB/ICkSCVNQcet2VVf2+nlRnOz/IPqc43rcxbX78DbP5JZZu/JBA4ilvxfy5AgJ1UkxVsFk/OMAP2ftwDAp+lZMLQAcjGoQsl015N9wTzBHe+hIBmGajoidNbskYyPUv/v6ilaElWKmb/GzTOobhOhqO5zQDlq3zIxPZcB1KTijLtMEHWYl/uAL+uJW4RGdL13AgdzA1amHXA6OJeSu9Vp8q0FLyBMxwrxbYbzYHn4cEiPvh2TkiGq/fTdsgwXitGuPlG3hYRzzqNB2DhQMQ1J1JAOn0AcCKiZPl9bp/Q2FGdBLlcDdsZjQth7kNmBi6g3Bfvu8AKlo1Dlhre+BgFgDdujEoGpb7nZOs3ejM4oJw8PJhtsu6ibjoS0mwDXH2KNJfLzf61mOe4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(56012099006)(5023799004)(18002099003)(22082099003)(6133799003)(10067099003)(261009223027099003)(261009223327099003)(261009220027099003)(261009221227099003)(261009221727099003)(261021121427099003)(261028144727099003)(261021123027099003)(261102123227099003)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CeQU/QKSFV6SPoA9RGO5qkt+LRUi+tvuRj1KnEbcAJ0d4Pf+fR8w3FoFWa?=
 =?iso-8859-1?Q?UdfO+r9t5x21iSAuedbT31jO36TbBs92YjV17KX2y0G/ZUpP80+zu/7WiK?=
 =?iso-8859-1?Q?drk12l4xYoixkOpvXRHzqNog808CpI1zIXFRSy49h/A11OMZ6Dq+y7Js/R?=
 =?iso-8859-1?Q?5ajYGFSup3C+jGDRbDwv1O/Ed5qMu5LMGz/x0nOzSTnRDLmJaZNk1AWuxm?=
 =?iso-8859-1?Q?3Qo6HeX5Tk9DbL1/oS1N98uLle2b3i0EKirUzkj+9AOVqfKkamVWZv3slg?=
 =?iso-8859-1?Q?cHVI3G3i9pS9+qOXbd88MRqiU7RKrUuVGAtrExprlaYXMM9+FZoNXp+n2y?=
 =?iso-8859-1?Q?oPLDQ9gJT/o/ts62Wl3bHeVxOMIkfl2QZ9HV/CXJYYJikbY1xIjU4AUEtQ?=
 =?iso-8859-1?Q?qq6eTQBrCDI7+OR38Nf1/Hssw4ZlQAecE4Dlya4ECZLUDt/h+zRDz+MMXv?=
 =?iso-8859-1?Q?b1bard5An5OcOyT2msIDvwAkqcj5jlLg5mfsoPmigzShCNpe8kL+9nqKxJ?=
 =?iso-8859-1?Q?iWg/iw2MpBLR7qmhkgz/is2g+8vqHsfA30QTT5BHQnhSjcvdHUlV+RwW9I?=
 =?iso-8859-1?Q?zpV6ECq4T+nRDH2T7lm2FIrX070SbbYeT99Y0KaGuV3EeewlhgpQ6elhMy?=
 =?iso-8859-1?Q?x+dn1WstOkkKmMD8Ld8HgxjJhKemGNdBkFGHVwOsS605rOsA8JXMGyXxWN?=
 =?iso-8859-1?Q?ACh8rHANaZHKJApn4/FlmaMMKWpWyFFgGtKBo78HqGq3tUWlqBSmiB3MXW?=
 =?iso-8859-1?Q?etMPuH4edgh/WgEULKwB4FNECsRB0BQElJoDOoYcr+NvxG+G808PIBpSrb?=
 =?iso-8859-1?Q?9NTc6EbI4j6EiZkO+FFbMqpWuaSe9q6iurihf/KZPdUM3jWk7p0wJk/VFL?=
 =?iso-8859-1?Q?nuRKQUgqDhCVloMj5y+QLM9HS5gvWMFA0JuWcE8JFCM5WQgax1o3CvaMa3?=
 =?iso-8859-1?Q?a8aaW3k/qV2bf69jaLcvsQRN/xg4j/hlmv7/p3m3DtL7AKhQ1amwn2BZXJ?=
 =?iso-8859-1?Q?zpUwzcVccLOVTqUZ7Afnmna9ZYzKRSpmDdK9Y1HUfITD/utvjf63L5dvW/?=
 =?iso-8859-1?Q?+VfOQ51MKK5sg5a6bI2R7xsAqsGeIEeB+lYa+RUzTeFlSbUz7OiFKWzN0L?=
 =?iso-8859-1?Q?GNLt6XDh98zKypt8lZivJmrx7HlHW5yOiFFrc9qdqZsW6qYh+D8+DauahX?=
 =?iso-8859-1?Q?h+9fq3jzuLGndTgNLWB9YyGJNo4MOHKJnVknkzd4/MeG6fXm0kE4kSNTJl?=
 =?iso-8859-1?Q?a/dyGVDZgaK4WYUjFWQXbrAzrO1O1B0891W+W3SiM2x05VjPENvXfH1VcF?=
 =?iso-8859-1?Q?vSj3Jd69k5UEbDCs+V2mCdB8nVkiWSG/ry/szbgZ/p6CNRAPmPbmdFCgm2?=
 =?iso-8859-1?Q?hMbjTWW6j3WUl9WAF64GtTwcb2pu0s4M3E1kQWT0eX8NM1wJF3gZEJj4pv?=
 =?iso-8859-1?Q?NifiwESd6jq2roavkCYVJWivpanRNtcke4NHnthEPWB9OQVDBRJw5lBV5e?=
 =?iso-8859-1?Q?+7ys4a6pwa1zf2AEy0+v7f8wIW+/XZaqCr0Ea2r4amtAwNPulhDrKPJy6c?=
 =?iso-8859-1?Q?9iFCZuEyLA0uEZSAEIGoOBQAgtJK0RnEgr5cbrbl7HbtH1tc2U6zYC7SIr?=
 =?iso-8859-1?Q?VqbG2UDRHWfy/2VZGq/hSJbQIcU36/CgZOjnuoloDLAjIOIGxlWZhYGE78?=
 =?iso-8859-1?Q?z8LXlt9E3H2KeEfMhqMSBk6FDWdw/rYM8C6kg7yYMQZJmMvJP9c0GBkN70?=
 =?iso-8859-1?Q?Wp7h+tJdW/8EZfF3WAUqX0DOWCYOwo9feyZUHF/ZJMKlPw?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	P9qLTT6TSbV4hxAk4sQVzWDWpejMMABAIazQtk7r4lwLgF5i6KjwJtZyA7Fx8/4wpzEARYCkxoS3YDdYZdKDbm6S8g2EfjwTszvUVMpiFqXOeeqgdpdbRcy9qjdHonFPl6sSXkNhFEZiUXcVF3kFo9dlA7/3dNixpPwtCvnqWts0oFmu5IQDn9LgKO95C+9A/RqAz6pNyBDnlYCTgh39NZQrBXDskjtHXG8FtAzz9/BsvlZ/QrB20ZFNpcxyoJKGmq+5MOyZ2SyX2rQhYL8Rupk7Mb4LMmexvqrqPKHBvUe3iaLpAHVyAy7e61Hi2dpwMl97LgkSH7TAT/QYssHMng==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c423c921-455b-4648-1219-08df3f68e33f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 20:26:14.8790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tjOmtG7R3slXvp4/zxnQ/86t7yGeTStQt9yYJB5QKO7CPCJsJ/XmP894BS+88gkEB81XOJu6kLsxmBJEOra0bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB5745
X-MDID: 1794342406-C_C563g1F8D6
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1794342406;C_C563g1F8D6;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Report an input's frequency from the firmware description and an=0A=
output's as the VCO rate over its output divider; set an output's=0A=
frequency by writing a new divider. The VCO rate is Fref * DIVN, and a=0A=
rate is accepted only when the VCO rate is a whole multiple of it.=0A=
=0A=
A divider write takes effect only inside the programming state, and the=0A=
documented settling time after the loop-lock command, about 100 ms, is=0A=
waited under the device lock. The phase flush after it is enabled=0A=
per PLL, so it realigns every output the PLL drives.=0A=
=0A=
Output pins are registered by the next patch, which adds the state=0A=
callback the core requires.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 614 +++++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/core.h |  18 +-=0A=
 drivers/dpll/sit9531x/dpll.c | 120 ++++++-=0A=
 drivers/dpll/sit9531x/prop.c |  28 +-=0A=
 drivers/dpll/sit9531x/regs.h |  21 ++=0A=
 5 files changed, 793 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index b4e44f0d9820..c7ab33993c28 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -459,6 +459,101 @@ static int sit9531x_output_forced_hiz(struct sit9531x=
_dev *sitdev,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+#define SIT9531X_LOOP_LOCK_TRIES	3=0A=
+=0A=
+/* Close the loops and lock the debug block without committing */=0A=
+static void sit9531x_prg_abort(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int rc =3D -EIO;=0A=
+	u8 attempt;=0A=
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
+ * Unlock the Page 3 debug registers and enter PRG_CMD; output-system writ=
es=0A=
+ * take effect only in this state.=0A=
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
+		sit9531x_prg_abort(sitdev);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Update the NVM shadow and re-lock the loops after sit9531x_prg_enter().=
 The=0A=
+ * sleep is the settling time after loop lock.=0A=
+ */=0A=
+static int sit9531x_prg_commit(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int rc, rc2 =3D 0, rc3;=0A=
+	u8 attempt;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
+			       SIT9531X_UPDATE_NVM);=0A=
+=0A=
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
+	sitdev->loops_open =3D !!rc2;=0A=
+=0A=
+	msleep(100);=0A=
+=0A=
+	/*=0A=
+	 * The debug key register unlocks every debug register while it holds=0A=
+	 * the unlock value.=0A=
+	 */=0A=
+	rc3 =3D sit9531x_write_close(sitdev, SIT9531X_REG_OUTSYS_DEBUG,=0A=
+				   SIT9531X_DEBUG_LOCK_VAL);=0A=
+=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	if (rc2)=0A=
+		return rc2;=0A=
+=0A=
+	if (rc3)=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "output debug block left unlocked after programming: %d\n",=0A=
+			 rc3);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Procedure:=0A=
  *   1. Force PLL into holdover (PLL page reg 0x6F bit 4)=0A=
@@ -1123,6 +1218,11 @@ int sit9531x_input_prio_add(struct sit9531x_dev *sit=
dev, u8 pll_idx,=0A=
 					 chan->prio_mask | BIT(input_idx));=0A=
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
@@ -1135,6 +1235,507 @@ int sit9531x_input_prio_add(struct sit9531x_dev *si=
tdev, u8 pll_idx,=0A=
 =0A=
 #define SIT9531X_DIVO_MAX			GENMASK_ULL(33, 0)=0A=
 =0A=
+/* Register 0x2D bit 7 is active-low: 0 =3D doubler enabled. */=0A=
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
+ * DIVN in fixed point: int_part + fracn/fracd, SIT9531X_DIVN_SCALE steps =
per=0A=
+ * unit.=0A=
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
+ * Read a PLL's configured DIVN, fixed point as per sit9531x_divn_fixed().=
=0A=
+ * Fractions are stored LSB first; the numerator is two's complement 32-bi=
t and=0A=
+ * the denominator register holds the divisor minus one.=0A=
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
+/* PLLB and PLLD run their VCO in the high band, PLLA and PLLC in the low.=
 */=0A=
+static bool sit9531x_fvco_in_band(u8 pll_idx, u64 fvco)=0A=
+{=0A=
+	if (pll_idx =3D=3D 1 || pll_idx =3D=3D 3)=0A=
+		return fvco >=3D SIT9531X_FVCO_HIGHBAND_MIN &&=0A=
+		       fvco <=3D SIT9531X_FVCO_HIGHBAND_MAX;=0A=
+	return fvco >=3D SIT9531X_FVCO_LOWBAND_MIN &&=0A=
+	       fvco <=3D SIT9531X_FVCO_LOWBAND_MAX;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Fvco =3D Fref * DIVN with Fref =3D xtal_freq << doubler; DIVN is the pr=
ofile's=0A=
+ * steady-state value in free-run and sync modes alike.=0A=
+ */=0A=
+static int sit9531x_get_fvco(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			     u64 *fvco)=0A=
+{=0A=
+	int doubler, rc;=0A=
+	u64 fref;=0A=
+	s64 divn;=0A=
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
+	/*=0A=
+	 * Round to the nearest hertz; the fixed-point DIVN is already floored=0A=
+	 * once.=0A=
+	 */=0A=
+	*fvco =3D mul_u64_u64_div_u64(2 * fref, (u64)divn, SIT9531X_DIVN_SCALE);=
=0A=
+	*fvco =3D (*fvco + 1) / 2;=0A=
+=0A=
+	/* Below the low VCO band the divider is not programmed */=0A=
+	if (*fvco < SIT9531X_FVCO_LOWBAND_MIN)=0A=
+		return -ENODATA;=0A=
+=0A=
+	/*=0A=
+	 * Outside the PLL's VCO band, Fref * DIVN is usually not the rate the=0A=
+	 * PLL runs at, as for a PLL fed from another PLL.=0A=
+	 */=0A=
+	if (!sit9531x_fvco_in_band(pll_idx, *fvco) &&=0A=
+	    !(sitdev->fvco_band_warned & BIT(pll_idx))) {=0A=
+		sitdev->fvco_band_warned |=3D BIT(pll_idx);=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "PLL%c: Fref * DIVN =3D %llu Hz is outside its VCO band\n",=0A=
+			 'A' + pll_idx, *fvco);=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int sit9531x_pll_small_update(struct sit9531x_dev *sitdev, u8 pll_i=
dx)=0A=
+{=0A=
+	return sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+				     SIT9531X_PLL_REG_SMALL_UPDATE,=0A=
+				     SIT9531X_SMALL_UPDATE_CMD);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Realign the PLL's output dividers with the on-demand phase flush (PHFL)=
, or=0A=
+ * restart the PLL when its profile has PHFL off (PLL page 0x47 bit 7 clea=
r), as=0A=
+ * Dely_program_output.py does. Without either, a rewritten DIVO keeps a f=
ixed=0A=
+ * edge offset. Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static int sit9531x_output_phase_flush(struct sit9531x_dev *sitdev, u8 pll=
_idx)=0A=
+{=0A=
+	u8 ctrl, orig, phfl, armed_mask =3D 0, parked =3D 0, i;=0A=
+	int rc, ret;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_CONFIG47,=
=0A=
+				  &phfl);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	if (!(phfl & SIT9531X_PLL_CONFIG47_PHFL_EN))=0A=
+		return sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+					     SIT9531X_PLL_REG_DIRECTIVES,=0A=
+					     SIT9531X_PLL_DIRECTIVE_RESTART);=0A=
+=0A=
+	/*=0A=
+	 * The phase trigger is chip-global and fires every PLL with on-demand=0A=
+	 * flush enabled; record which ones the profile arms.=0A=
+	 */=0A=
+	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, i, SIT9531X_PLL_REG_PHFL_CTRL,=0A=
+					  &phfl);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+		if (phfl & SIT9531X_PLL_PHFL_ON_DEMAND_EN)=0A=
+			armed_mask |=3D BIT(i);=0A=
+	}=0A=
+=0A=
+	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
+		if (i =3D=3D pll_idx || !(armed_mask & BIT(i)))=0A=
+			continue;=0A=
+		parked |=3D BIT(i);=0A=
+		rc =3D sit9531x_update_pll_u8(sitdev, i,=0A=
+					    SIT9531X_PLL_REG_PHFL_CTRL,=0A=
+					    SIT9531X_PLL_PHFL_ON_DEMAND_EN, 0);=0A=
+		if (rc)=0A=
+			goto unpark;=0A=
+		rc =3D sit9531x_pll_small_update(sitdev, i);=0A=
+		if (rc)=0A=
+			goto unpark;=0A=
+	}=0A=
+=0A=
+	rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+				    SIT9531X_PLL_REG_PHFL_CTRL,=0A=
+				    SIT9531X_PLL_PHFL_ON_DEMAND_EN,=0A=
+				    SIT9531X_PLL_PHFL_ON_DEMAND_EN);=0A=
+	if (rc)=0A=
+		goto disarm;=0A=
+=0A=
+	/*=0A=
+	 * Write the update register whole; a read-modify-write skips the write=
=0A=
+	 * while the bit still reads set from the previous command.=0A=
+	 */=0A=
+	rc =3D sit9531x_pll_small_update(sitdev, pll_idx);=0A=
+	if (rc)=0A=
+		goto disarm;=0A=
+=0A=
+	/*=0A=
+	 * Select the in-register phase trigger; the register also holds the OEb=
=0A=
+	 * bits.=0A=
+	 */=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, &ctrl);=0A=
+	if (rc)=0A=
+		goto disarm;=0A=
+=0A=
+	orig =3D ctrl & ~SIT9531X_DIVO_PHASE_TRIG;=0A=
+	ctrl =3D orig | SIT9531X_DIVO_PHASE_SEL_REG;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, ctrl);=0A=
+	if (rc)=0A=
+		goto restore;=0A=
+=0A=
+	/*=0A=
+	 * No delay between set and clear; one I2C transfer is longer than the=0A=
+	 * minimum pulse width.=0A=
+	 */=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1,=0A=
+			       ctrl | SIT9531X_DIVO_PHASE_TRIG);=0A=
+=0A=
+restore:=0A=
+	ret =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, orig);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+disarm:=0A=
+	/*=0A=
+	 * Restore the profile's flush enable; an armed flush re-flushes every=0A=
+	 * output divider of this PLL on the next trigger.=0A=
+	 */=0A=
+	if (!(armed_mask & BIT(pll_idx))) {=0A=
+		ret =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+					     SIT9531X_PLL_REG_PHFL_CTRL,=0A=
+					     SIT9531X_PLL_PHFL_ON_DEMAND_EN, 0);=0A=
+		if (!ret)=0A=
+			ret =3D sit9531x_pll_small_update(sitdev, pll_idx);=0A=
+		if (ret && !rc)=0A=
+			rc =3D ret;=0A=
+	}=0A=
+=0A=
+unpark:=0A=
+	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
+		if (!(parked & BIT(i)))=0A=
+			continue;=0A=
+		ret =3D sit9531x_update_pll_u8(sitdev, i,=0A=
+					     SIT9531X_PLL_REG_PHFL_CTRL,=0A=
+					     SIT9531X_PLL_PHFL_ON_DEMAND_EN,=0A=
+					     SIT9531X_PLL_PHFL_ON_DEMAND_EN);=0A=
+		if (!ret)=0A=
+			ret =3D sit9531x_pll_small_update(sitdev, i);=0A=
+		if (ret && !rc)=0A=
+			rc =3D ret;=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Compute an output's divider and VCO rate; call before entering the=0A=
+ * programming state.=0A=
+ */=0A=
+static int sit9531x_output_divo_calc(struct sit9531x_dev *sitdev, u8 out_i=
dx,=0A=
+				     u8 pll_idx, u64 frequency, u64 *fvco_out,=0A=
+				     u64 *divo_out)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u64 fvco, divo, nearest, rem;=0A=
+	int rc;=0A=
+=0A=
+	if (out_idx >=3D info->num_outputs || pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/* An unrouted output has a placeholder in pll_idx. */=0A=
+	if (!sitdev->out[out_idx].routed)=0A=
+		return -ENODEV;=0A=
+=0A=
+	if (!frequency)=0A=
+		return -EINVAL;=0A=
+=0A=
+	if (frequency > U32_MAX)=0A=
+		return -EINVAL;=0A=
+=0A=
+	rc =3D sit9531x_get_fvco(sitdev, pll_idx, &fvco);=0A=
+	if (rc)=0A=
+		return rc =3D=3D -ENODATA ? -ENODEV : rc;=0A=
+=0A=
+	if (!sit9531x_fvco_in_band(pll_idx, fvco)) {=0A=
+		dev_dbg(sitdev->dev,=0A=
+			"out%u: PLL%c Fvco %llu Hz is outside its VCO band, rate not settable\n=
",=0A=
+			out_idx, 'A' + pll_idx, fvco);=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	divo =3D div64_u64(fvco + frequency / 2, frequency);=0A=
+	if (!divo)=0A=
+		return -EINVAL;=0A=
+=0A=
+	if (divo > SIT9531X_DIVO_MAX)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/*=0A=
+	 * Refuse a rate that is not exactly Fvco/N; the quotient truncates to=0A=
+	 * the request whenever the remainder is below N.=0A=
+	 */=0A=
+	nearest =3D div64_u64_rem(fvco, divo, &rem);=0A=
+	if (nearest !=3D frequency || rem) {=0A=
+		dev_dbg(sitdev->dev,=0A=
+			"out%u: %llu Hz is not Fvco/N (Fvco=3D%llu, nearest %llu Hz)\n",=0A=
+			out_idx, frequency, fvco, nearest);=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	dev_dbg(sitdev->dev, "out%u: Fvco=3D%llu freq=3D%llu DIVO=3D%llu\n",=0A=
+		out_idx, fvco, frequency, divo);=0A=
+=0A=
+	*fvco_out =3D fvco;=0A=
+	*divo_out =3D divo;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Caller must be in the programming state; @back reports whether the divi=
der=0A=
+ * holds its old value.=0A=
+ */=0A=
+static int sit9531x_output_divo_write(struct sit9531x_dev *sitdev, u8 out_=
idx,=0A=
+				      u64 divo, bool *back)=0A=
+{=0A=
+	u8 slot, page, base_reg, divo_bytes[5], old_bytes[5], msb_old;=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	int rc, j, rb_rc;=0A=
+	u8 written =3D 0;=0A=
+=0A=
+	*back =3D false;=0A=
+=0A=
+	slot =3D info->clkout_map[out_idx];=0A=
+=0A=
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
+	/* The byte whose write failed may have reached the part */=0A=
+	*back =3D true;=0A=
+	for (j =3D 0; j <=3D written && j < 5; j++) {=0A=
+		rb_rc =3D sit9531x_write_u8(sitdev,=0A=
+					  SIT9531X_REG(page, base_reg - j),=0A=
+					  old_bytes[j]);=0A=
+		if (rb_rc) {=0A=
+			*back =3D false;=0A=
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
+static int sit9531x_output_divo_read(struct sit9531x_dev *sitdev, u8 out_i=
dx,=0A=
+				     u64 *divo)=0A=
+{=0A=
+	u8 slot, page, base_reg, v;=0A=
+	int rc, j;=0A=
+=0A=
+	slot =3D sitdev->info->clkout_map[out_idx];=0A=
+	if (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX)=0A=
+		page =3D SIT9531X_PAGE_OUTSYS1;=0A=
+	else=0A=
+		page =3D SIT9531X_PAGE_OUTSYS0;=0A=
+	base_reg =3D clkout_odr_divn_base[slot % 6];=0A=
+=0A=
+	*divo =3D 0;=0A=
+	for (j =3D 4; j >=3D 0; j--) {=0A=
+		rc =3D sit9531x_read_u8(sitdev,=0A=
+				      SIT9531X_REG(page, base_reg - j), &v);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+		if (j =3D=3D 4)=0A=
+			v &=3D 0x03;=0A=
+		*divo =3D (*divo << 8) | v;=0A=
+	}=0A=
+=0A=
+	return *divo ? 0 : -ENODATA;=0A=
+}=0A=
+=0A=
+int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			     u8 pll_idx, u64 frequency)=0A=
+{=0A=
+	u64 fvco, divo;=0A=
+	int rc, ret;=0A=
+	bool back;=0A=
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
+	rc =3D sit9531x_output_divo_write(sitdev, out_idx, divo, &back);=0A=
+	/* NVM update and loop lock */=0A=
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/* Flush the output phase so the new DIVO starts aligned */=0A=
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
+ * Read the output rate back as Fvco / DIVO and refresh the cached rate. C=
aller=0A=
+ * must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_output_freq_get(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			     u64 *frequency)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u64 fvco, divo;=0A=
+	u8 pll_idx;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (out_idx >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	pll_idx =3D sitdev->out[out_idx].pll_idx;=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS || !sitdev->out[out_idx].routed) {=0A=
+		sitdev->out[out_idx].freq =3D 0;=0A=
+		return -ENODATA;=0A=
+	}=0A=
+=0A=
+	rc =3D sit9531x_get_fvco(sitdev, pll_idx, &fvco);=0A=
+	if (!rc)=0A=
+		rc =3D sit9531x_output_divo_read(sitdev, out_idx, &divo);=0A=
+	if (rc) {=0A=
+		if (rc =3D=3D -ENODATA)=0A=
+			sitdev->out[out_idx].freq =3D 0;=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	*frequency =3D div64_u64(fvco, divo);=0A=
+	sitdev->out[out_idx].freq =3D *frequency;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Phase adjust: per-output 34-bit coarse delay in VCO periods plus a 3-bi=
t=0A=
  * fine delay in 30 ps steps, in PROG6..PROG2:=0A=
@@ -1841,6 +2442,10 @@ sit9531x_dev_chan_states_update(struct sit9531x_dev =
*sitdev)=0A=
 	bool answered =3D false;=0A=
 	int i, rc;=0A=
 =0A=
+	/* Retry pending writes first so the reads below see their result */=0A=
+	if (sitdev->loops_open)=0A=
+		sit9531x_prg_commit(sitdev);=0A=
+=0A=
 	sit9531x_input_off_retry(sitdev);=0A=
 	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
 		sit9531x_table_back_retry(sitdev, i);=0A=
@@ -2163,6 +2768,15 @@ static void sit9531x_dev_stop(struct sit9531x_dev *s=
itdev)=0A=
 				 "PLL%c left in forced holdover\n", 'A' + i);=0A=
 	}=0A=
 	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	if (sitdev->loops_open) {=0A=
+		sit9531x_prg_commit(sitdev);=0A=
+		if (sitdev->loops_open)=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "output loops left unlocked at removal\n");=0A=
+	}=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
 }=0A=
 =0A=
 static struct sit9531x_dpll_pin *=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index fa779acf7de5..6b50b5b64b75 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -212,20 +212,25 @@ struct sit9531x_chan {=0A=
  * @irq: optional INTRB IRQ, 0 if not wired=0A=
  * @intsync_src: PLL sourcing INTSYNC, or -1=0A=
  * @irq_ack_fails: consecutive failed INTRB acknowledgements=0A=
+ * @fvco_band_warned: bit per PLL warned for Fref * DIVN outside its VCO=
=0A=
+ *   band; written under @multiop_lock=0A=
  * @loops_open: output loops not yet re-locked=0A=
+ * @flush_ctrl_pending: @flush_ctrl still to be written back=0A=
+ * @flush_ctrl: trigger register value to restore=0A=
+ * @flush_arm_pending: bit per PLL whose flush enable is still to be resto=
red=0A=
+ * @flush_armed: of those, the PLLs the profile arms=0A=
  */=0A=
 struct sit9531x_dev {=0A=
 	struct device			*dev;=0A=
 	struct i2c_client		*client;=0A=
 	struct regmap			*regmap;=0A=
 	const struct sit9531x_chip_info	*info;=0A=
-	/* Serializes multi-step register sequences */=0A=
 	struct mutex			multiop_lock;=0A=
-	/* Serializes a page select and the transfer it is for */=0A=
 	struct mutex			page_lock;=0A=
 	int				page;=0A=
 =0A=
 	u8			irq_ack_fails;=0A=
+	u8			fvco_band_warned;=0A=
 	struct sit9531x_ref	ref[SIT9531X_MAX_INPUTS + 1]; /* +1 for xtal */=0A=
 	struct sit9531x_out	out[SIT9531X_MAX_OUTPUTS];=0A=
 	struct sit9531x_chan	chan[SIT9531X_NUM_PLLS];=0A=
@@ -245,6 +250,10 @@ struct sit9531x_dev {=0A=
 	s8			intsync_src;=0A=
 =0A=
 	bool			loops_open;=0A=
+	bool			flush_ctrl_pending;=0A=
+	u8			flush_ctrl;=0A=
+	u8			flush_arm_pending;=0A=
+	u8			flush_armed;=0A=
 };=0A=
 =0A=
 int sit9531x_read_u8(struct sit9531x_dev *sitdev, unsigned int reg,=0A=
@@ -272,6 +281,11 @@ int sit9531x_input_prio_remove(struct sit9531x_dev *si=
tdev, u8 pll_idx,=0A=
 int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
 			    u8 input_idx);=0A=
 =0A=
+int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			     u8 pll_idx, u64 frequency);=0A=
+int sit9531x_output_freq_get(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			     u64 *frequency);=0A=
+=0A=
 static inline u8 sit9531x_pll_page(u8 pll_idx)=0A=
 {=0A=
 	return SIT9531X_PAGE_PLLA + pll_idx;=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index f03145f4d1ee..a450a81d02f4 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -302,6 +302,24 @@ sit9531x_dpll_input_pin_direction_get(const struct dpl=
l_pin *pin,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/* Report the first supported-frequencies-hz entry */=0A=
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
 static int=0A=
 sit9531x_dpll_input_pin_state_on_dpll_get(const struct dpll_pin *pin,=0A=
 					  void *pin_priv,=0A=
@@ -470,6 +488,20 @@ sit9531x_dpll_input_pin_prio_set(const struct dpll_pin=
 *pin, void *pin_priv,=0A=
 }=0A=
 =0A=
 static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {=0A=
+	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.frequency_get		=3D sit9531x_dpll_input_pin_frequency_get,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_input_pin_state_on_dpll_get,=0A=
+	.state_on_dpll_set	=3D sit9531x_dpll_input_pin_state_on_dpll_set,=0A=
+	.operstate_on_dpll_get	=3D sit9531x_dpll_input_pin_operstate_on_dpll_get,=
=0A=
+	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
+	.prio_set		=3D sit9531x_dpll_input_pin_prio_set,=0A=
+};=0A=
+=0A=
+/*=0A=
+ * For an input with no supported-frequencies-hz: the core fails a whole p=
in=0A=
+ * dump if any callback returns an error.=0A=
+ */=0A=
+static const struct dpll_pin_ops sit9531x_dpll_input_pin_norate_ops =3D {=
=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
 	.state_on_dpll_get	=3D sit9531x_dpll_input_pin_state_on_dpll_get,=0A=
 	.state_on_dpll_set	=3D sit9531x_dpll_input_pin_state_on_dpll_set,=0A=
@@ -483,6 +515,13 @@ static const struct dpll_pin_ops sit9531x_dpll_input_p=
in_ops =3D {=0A=
  * reference, so the pin has no state setter and no priority.=0A=
  */=0A=
 static const struct dpll_pin_ops sit9531x_dpll_input_pin_manual_ops =3D {=
=0A=
+	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.frequency_get		=3D sit9531x_dpll_input_pin_frequency_get,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_input_pin_state_on_dpll_get,=0A=
+	.operstate_on_dpll_get	=3D sit9531x_dpll_input_pin_operstate_on_dpll_get,=
=0A=
+};=0A=
+=0A=
+static const struct dpll_pin_ops sit9531x_dpll_input_pin_norate_manual_ops=
 =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
 	.state_on_dpll_get	=3D sit9531x_dpll_input_pin_state_on_dpll_get,=0A=
 	.operstate_on_dpll_get	=3D sit9531x_dpll_input_pin_operstate_on_dpll_get,=
=0A=
@@ -518,6 +557,7 @@ sit9531x_dpll_xo_pin_state_on_dpll_get(const struct dpl=
l_pin *pin,=0A=
 =0A=
 static const struct dpll_pin_ops sit9531x_dpll_xo_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.frequency_get		=3D sit9531x_dpll_input_pin_frequency_get,=0A=
 	.state_on_dpll_get	=3D sit9531x_dpll_xo_pin_state_on_dpll_get,=0A=
 };=0A=
 =0A=
@@ -533,23 +573,97 @@ sit9531x_dpll_output_pin_direction_get(const struct d=
pll_pin *pin,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Report Fvco / DIVO, or the cached rate when the divider chain does not=
=0A=
+ * resolve.=0A=
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
+	if (rc =3D=3D -ENODATA)=0A=
+		*frequency =3D sit9531x_out_state_get(sitdev, dpin->id)->freq;=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return rc =3D=3D -ENODATA ? 0 : rc;=0A=
+}=0A=
+=0A=
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
+	bool moved =3D false;=0A=
+	u64 was, hz;=0A=
+	u8 actual_pll;=0A=
+	int rc;=0A=
+=0A=
+	actual_pll =3D sitdev->out[dpin->id].pll_idx;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	was =3D sitdev->out[dpin->id].freq;=0A=
+	rc =3D sit9531x_output_freq_set(sitdev, dpin->id, actual_pll,=0A=
+				      frequency);=0A=
+	if (rc) {=0A=
+		if (!sit9531x_output_freq_get(sitdev, dpin->id, &hz))=0A=
+			moved |=3D hz !=3D was;=0A=
+	}=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc) {=0A=
+		struct dpll_pin *dpll_pin;=0A=
+=0A=
+		NL_SET_ERR_MSG(extack, "Output frequency set failed");=0A=
+		/* The core notifies only a request that succeeded */=0A=
+		dpll_pin =3D READ_ONCE(dpin->dpll_pin);=0A=
+		if (moved && dpll_pin)=0A=
+			__dpll_pin_change_ntf(dpll_pin);=0A=
+	}=0A=
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
 sit9531x_dpll_pin_ops_get(const struct sit9531x_dpll_pin *pin)=0A=
 {=0A=
 	const struct sit9531x_dev *sitdev =3D pin->dpll->dev;=0A=
+	bool manual;=0A=
 =0A=
 	if (!sit9531x_dpll_is_input_pin(pin))=0A=
 		return &sit9531x_dpll_output_pin_ops;=0A=
 	if (sit9531x_dpll_is_xo_pin(pin))=0A=
 		return &sit9531x_dpll_xo_pin_ops;=0A=
 	/* Read once at probe, before any pin is registered. */=0A=
-	if (sit9531x_chan_state_get(sitdev, pin->dpll->id)->manual_input)=0A=
-		return &sit9531x_dpll_input_pin_manual_ops;=0A=
-	return &sit9531x_dpll_input_pin_ops;=0A=
+	manual =3D sit9531x_chan_state_get(sitdev, pin->dpll->id)->manual_input;=
=0A=
+	/*=0A=
+	 * Set before any pin of the input is published and not written again.=0A=
+	 */=0A=
+	if (!sit9531x_ref_state_get(sitdev, pin->id)->freq)=0A=
+		return manual ? &sit9531x_dpll_input_pin_norate_manual_ops :=0A=
+				&sit9531x_dpll_input_pin_norate_ops;=0A=
+	return manual ? &sit9531x_dpll_input_pin_manual_ops :=0A=
+			&sit9531x_dpll_input_pin_ops;=0A=
 }=0A=
 =0A=
 /* Caller must hold sitdev->multiop_lock. */=0A=
diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c=0A=
index 69877fc94028..f726fbe037f3 100644=0A=
--- a/drivers/dpll/sit9531x/prop.c=0A=
+++ b/drivers/dpll/sit9531x/prop.c=0A=
@@ -233,7 +233,10 @@ sit9531x_pin_props_get(struct sit9531x_dev *sitdev,=0A=
 		goto err_alloc_ranges;=0A=
 	}=0A=
 =0A=
-	/* The first listed rate seeds the input's rate */=0A=
+	/*=0A=
+	 * The driver does not read an input's rate; the first listed rate seeds=
=0A=
+	 * it.=0A=
+	 */=0A=
 	if (num_freqs > 0 && dir =3D=3D DPLL_PIN_DIRECTION_INPUT && !xo)=0A=
 		curr_freq =3D freqs[0];=0A=
 =0A=
@@ -241,6 +244,21 @@ sit9531x_pin_props_get(struct sit9531x_dev *sitdev,=0A=
 	if (sync_in || sync_out)=0A=
 		return props;=0A=
 =0A=
+	/*=0A=
+	 * Read the divider into the cached output rate used by phase adjust;=0A=
+	 * -ENODATA is an unprogrammed divider or unknown VCO rate.=0A=
+	 */=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
+	    index < sitdev->info->num_outputs) {=0A=
+		u64 hw_freq;=0A=
+=0A=
+		mutex_lock(&sitdev->multiop_lock);=0A=
+		rc =3D sit9531x_output_freq_get(sitdev, index, &hw_freq);=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		if (rc && rc !=3D -ENODATA)=0A=
+			goto err_alloc_ranges;=0A=
+	}=0A=
+=0A=
 	/*=0A=
 	 * An output with no listed rates gets one wide range, as the setter=0A=
 	 * checks Fvco/N; the XO gets its one rate.=0A=
@@ -251,8 +269,12 @@ sit9531x_pin_props_get(struct sit9531x_dev *sitdev,=0A=
 		goto err_alloc_ranges;=0A=
 	}=0A=
 =0A=
-	/* Set after the last allocation that can fail */=0A=
-	if (curr_freq && dir =3D=3D DPLL_PIN_DIRECTION_INPUT)=0A=
+	/*=0A=
+	 * Set after the last allocation that can fail, and only once, as pins=0A=
+	 * of other DPLLs on this input may already be published.=0A=
+	 */=0A=
+	if (curr_freq && dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+	    !sitdev->ref[index].freq)=0A=
 		sitdev->ref[index].freq =3D curr_freq;=0A=
 =0A=
 	j =3D 0;=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index 39d836f6b563..3f8ceb7e9798 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -156,6 +156,7 @@=0A=
 /* Debug register (same offset, per-page) */=0A=
 #define SIT9531X_REG_OUTSYS_DEBUG		SIT9531X_REG(0x03, 0xBD)=0A=
 #define SIT9531X_DEBUG_UNLOCK_VAL		0xC3=0A=
+#define SIT9531X_DEBUG_LOCK_VAL			0x00=0A=
 =0A=
 /*=0A=
  * Register-triggered phase flush: DIVO_PHASE_SEL_REG selects the register=
=0A=
@@ -169,6 +170,18 @@=0A=
 /* PLL page register offsets, pages 0x0A-0x0D */=0A=
 #define SIT9531X_PLL_REG_SMALL_UPDATE	0x0F=0A=
 =0A=
+/* On-demand phase-flush enable (PLL page reg 0x3D bit 7) */=0A=
+#define SIT9531X_PLL_REG_PHFL_CTRL	0x3D=0A=
+#define SIT9531X_PLL_PHFL_ON_DEMAND_EN	BIT(7)=0A=
+=0A=
+/* Whether the PLL has the phase-flush feature (PLL page reg 0x47 bit 7) *=
/=0A=
+#define SIT9531X_PLL_REG_CONFIG47	0x47=0A=
+#define SIT9531X_PLL_CONFIG47_PHFL_EN	BIT(7)=0A=
+=0A=
+/* Directives_GENERIC_PLL: the restart bit restarts the PLL, self-clearing=
 */=0A=
+#define SIT9531X_PLL_REG_DIRECTIVES	0x05=0A=
+#define SIT9531X_PLL_DIRECTIVE_RESTART	BIT(0)=0A=
+=0A=
 /*=0A=
  * PLL page regs 0x10-0x15 hold the loop-filter coefficients (3 normal, 3=
=0A=
  * fast-lock); they are GUI generated and must not be changed at runtime.=
=0A=
@@ -182,6 +195,14 @@=0A=
 #define SIT9531X_PLL_REG_OUT_MAP_LO		0x28=0A=
 #define SIT9531X_PLL_REG_STATUS		0x31=0A=
 =0A=
+/* DIVN registers (free-run divider readback) */=0A=
+#define SIT9531X_PLL_REG_DIVN_INT		0x30=0A=
+#define SIT9531X_PLL_REG_DIVN_NUM		0x32  /* 4 bytes (0x32-0x35) */=0A=
+#define SIT9531X_PLL_REG_DIVN_DEN		0x38  /* 4 bytes (0x38-0x3B) */=0A=
+=0A=
+/* DIVN is carried as fixed point, in steps of 1e-12 of a whole divider */=
=0A=
+#define SIT9531X_DIVN_SCALE		1000000000000ULL=0A=
+=0A=
 #define SIT9531X_PLL_REG_ACTIVE		0x02=0A=
 #define SIT9531X_PLL_ACTIVE_BIT		BIT(0)  /* PLL reached active state */=0A=
 =0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
