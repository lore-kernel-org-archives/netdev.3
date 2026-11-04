Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793761123;
	b=ebnASzGdX3eWR9VIO2FnAsCzKPH9AX3l/ii+QmZzRJy91tJj/QzL2qlqfWVATZD4NOd9
	 1dCxBKTgnd2T4Om3BeoW/Ve/nBAd7lH/2wQ0xL3aWI6hti70xl27qloJcfqY190hrCGyv
	 OkSoAJq1A6IkpkxtJVeL4sACbuJLDsFRCjaZd/6Toejr4H+HA7uB9lmnbInCzHen1MH5c
	 LmMR7wMc3D0MaBa8uSFYPZNSnDuPaP88ReJbgS/wl9kVHQ7T/q2PXLkQYsFzEXdCga1tO
	 hRRTAMuSAbjdPMqUcoIlSnepGI212/GeW0vrDhtSZAuuEQFGJJS0AFjML6zAK25ZdEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761123;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-exchange-messagesentrepresentingtype:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-sharedmailbox-routingagent-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=R5X2Qc1FSFI19Nie43goG0GstF+npWT8M/5p5gx8KPI=;
	b=l7l/XlIzS0u9LWdleZt1rBK0yIvv25m/mH7u9OUkZQPpyAtdk0ircMGfE/bTzHKFa26l
	 uAvA7vKwPSvaPVE5h9olDv1JxXTVD7/MfGFSYvWpK/lkD6ejiP0PAQ53BHf/KlHtZB4z0
	 WhzlS6JEQaPS5HWvk0os08HFzYrXMbSN9yeLM4OLo5RzhmH7VaN6fDuFscqXMoScEdGk0
	 1cps4sZtk/+KlaVGatqPWebUzQMaVVTeJ0sJFPCzYpIPQ82W7FuhAh40AKgpn2KCCBuYv
	 dkNpT/i7VO4SnCduIba2h0VzYtvMmh6QtUDdDvRh1VJ3hQOy+8yjIk/OhY4lIHwh3xA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=OHD+5WgS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.46
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012046.outbound.protection.outlook.com [52.101.66.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958F5606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 02:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 958F5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=OHD+5WgS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oODRFqlk8np5eBtcUZZLXPxnG4rsNrthPE29EnWFW007NJu9zijU95wTEMVP9SDaL4lFPVwxr3n4Kn2d10zC47u1cyvVy/vTuDhSlBxUr/ds1q3ckB0GankV0BYCr8A9vqxnckM2aoIAq3AEwGC2fnrzl56k98JrvICsYWCbU2oFpFpiSnUrtwsxB5RRTrLDt7y/fuOqrmKpoQswd1aLAxxVFnEFqR9ZdH4hZZf2tSO/ULXfFQU9bNKmlONYNOUW0amNfm3Dm0+N5Ty8jUugT2QO9YEEAHQTR6XcOdtjTgtQ0TF6P2C43FyJzmAh8Mlix5QMu4pK37jla7GaVnl4Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5X2Qc1FSFI19Nie43goG0GstF+npWT8M/5p5gx8KPI=;
 b=wOy9cbFXR2IN85LBX9ikkdPQl55OzJAVm04rix6FIJoFC5+qhhLiQhETNsRFCiOehS1EhE5h0QAT+niuuWd+fpJSUW5kcFZrqgLcSedc3ZKIF42anBzCeJDZ2pmX5t4Em2El8vFLQgy4tkkRvs7ZyE34H9uRj7oQ9lQ1ltOZK9CijPBflwTtnt26OWH30MnVXZmnGyhtWaPx6Xs1atUTm9RQPLehdJXq90ViYKvmJKV0SHuh3PFkl7pR+skIEBW5J96PBbDjcIXapmS5mfP+uzm/E4cYn+lDzXQ67mf63x5XoArRHrgxoKNl8clXCkru0ozBSYYp1cy10yTOCfA2Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5X2Qc1FSFI19Nie43goG0GstF+npWT8M/5p5gx8KPI=;
 b=OHD+5WgS7USjlWzlitsdywHI0d5wsTXandi9Gv2X+zF8q0yWhFr4s/dnpT63OW6G3XdPxYvrU+LyManza4ZYaoJlxbRP5JNqI54EvCpxNw2rlKOj6AifHJV11nQ+tn1VhF2+R9U2ArCJJ3nd7+Z1NoYRnqwcQwSLIOq834wxdaViAGWz4KOTyQD9YdTZ3jemqQCcGR8wLM6UjDcHaPfW79n5EY641Ocikla+BA2ttZNOdWRM8repmZx+1NpngTf01+tn5sPXoqg54zp+OpXKfxX6PCOacIH298q0HIO16+X9zNRQs7e39+Px80gmV2wrlDv2Q2nEjp6VLtPvhlZFcA==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by PA1PR04MB10120.eurprd04.prod.outlook.com (2603:10a6:102:461::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 02:58:35 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%7]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 02:58:35 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, "open list:NETWORKING DRIVERS"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH v6 net-next 9/9] net: dsa: netc: add PTP one-step
 timestamping support
Thread-Topic: [PATCH v6 net-next 9/9] net: dsa: netc: add PTP one-step
 timestamping support
Thread-Index: AQHdazf7qzDWzVtQHEOFWoUonbC/K7cdK+SAgAAObBA=
Date: Wed, 4 Nov 2026 02:58:35 +0000
Message-ID:
 <AS4PR04MB933856093C3FFD9A3EC5B92388682@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <20261103021024.3121936-1-wei.fang@oss.nxp.com>
 <20261103021024.3121936-10-wei.fang@oss.nxp.com>
 <sashiko-outbox-196431@kernel.org>
In-Reply-To: <sashiko-outbox-196431@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-11-04T02:42:12.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|PA1PR04MB10120:EE_
x-ms-office365-filtering-correlation-id: ee0a9220-ac17-4733-a382-08df3a1f84c7
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|19092799006|38070700021|11063799006|4143699003|56012099006|261009223027099003|261026121527099003|261022075727099003|261028144727099003|261022105027099003|261026140227099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 j9YoeuodS+ZFWCVni1HQ1Mr79UzlETsvVN0l4d7KyoWID2i2y12Brb/NQ0plabrzfsgkHx40YVvdp0yo3U7s0/EXOmywHWUJOdHInCmJD8C1dCwxbNMkybMv/+VfZjpYgdxbk1fgRV16CJkM6ka54zXHjZuC1OGRBfUqfq2bk+J+WY97SwOz+/oltQAmKLKTJhjkJzIeh+oGOThULFIaKOQgyjW+k8k5vi95WUB+MuBm079sncTgdEEQ7zelQI8XCFE4UByCPLuuSexTSvw+2qfKqkF5+tAAz2/6EOXvOrwV8yvhJfNU1iag/vaijGisam2yO0Vp44sxK4YXVMI3sVdkgDuvmYweLGS3kjdfi/+NrHgLBq9Hltew//XammbdHxrwPI8IA6qF8ZalYOjbmFmcfpVoxDLANi3giSBUHPUxkYIBINa64lZTogvORtJ/tIzzXazJikCnjNXQ/Obt4bBnnjruBhraVIGa//QqwH/D6C5yJ+JLngJrL97Qc9glkI7ysY8XaG2Iu7bz83O/aScVHhv5YT3fDsX3bKIOhF+tuOAzpcAg47sFfgAZJqfyAd0ZsLW3RmYqI3+G8EYIkJ5A/q+ehf7ceAAYaBDiUL7pJZ0l4PJOSTWGzJUnoxyG9caKjChuGDigi+VgSmc4uB4sOBt2tGzqvToneCAlZ/kZe1Pgj63Xsjb8HJv5TEFlox8xcCgoPGTXRQjDG7ZOKorvwo4AcXNe3kJ5VYAW6LM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(19092799006)(38070700021)(11063799006)(4143699003)(56012099006)(261009223027099003)(261026121527099003)(261022075727099003)(261028144727099003)(261022105027099003)(261026140227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFdBcm1JRnJPQ0hJNEhPSkpuVm1GSVc0bEVpYmk4V1dVdytLRDV4WFVvQTZT?=
 =?utf-8?B?THgrZHVCUmdwelZ1NkhlciszeGZzV0hlNkFNakphVEcxL0tJVHF3NDR0VmJp?=
 =?utf-8?B?NVFHUTJLMzQ5S3NJYnROQnVodnhDRTVTN2d6aVQzN3RYdG5BSUNCT0RoeE96?=
 =?utf-8?B?RHJQa1NpZkF6NEs1RnBGL3hLSmJGRm9UNEY4Y2xPMjF4MlljelQ3NVd6aXBU?=
 =?utf-8?B?MjI2ZmpFOGFIUHFrV3UwMSs2bnVvWmtqNUdzS01TN24rRU1UNEY5U2ZGUXlF?=
 =?utf-8?B?WmJKNk1XVHBJR3FQeWM2TVh2UkRPajlZNUJJaUdTQWE2ZFJrM3Nodk5ram1C?=
 =?utf-8?B?cnF5YXRTOEZZMlFDazdJMUJyOW1YWXpRcncrc0dVdEFIaG56aXFSdTQwY0Jl?=
 =?utf-8?B?MGIwSWpweUk0a3BsN1JESndCYjA1THgxS3lpaTM5UHlsbWZ5KzBwWkpzaUt6?=
 =?utf-8?B?ZERQV0xJTUo5ZTlkSHE4dEkxajlRb0cwM2lqRFRCcHcyV0JtNStaaVMvQUVE?=
 =?utf-8?B?UHRtd1U1dGZ1eHN5Y1FkVUV5MXlDV2kyVmlkT1I1bEFrSm9vYXVDTE1LaUJN?=
 =?utf-8?B?K1ZxbHEzbTI2Ulp6RHVDUXY5VUdsUFArSmFmR1lmdE1EaWsvUU5WS2N1bVJw?=
 =?utf-8?B?SmdKTnpCUXhDc3RZNkxhR2tQcUxoQ0diWUNrQ1FwckhHb3VHSmRVckFlUkZp?=
 =?utf-8?B?TkZXNmRmQmhiclU1dHdud1Z4Zngyci9sTCt4YVozVThVSGxrMWhHRDlrMnkr?=
 =?utf-8?B?NVd0blFPY2h4RWwrODVzc01GSWtFbmsyMitxV2s3VThOV3F6c1BOZmxuNFNZ?=
 =?utf-8?B?cXdGMnQwS0NCRzRwazJwTzZRYlZuNDZNZ0NSNFFYeWhIZUNySUZ5ZFZNVEtG?=
 =?utf-8?B?cEdjUjR3b0hXaEpsaUc5amtJcVJjU3FJRXlHNkI0Zi9iRmxvclNmWW85MkJj?=
 =?utf-8?B?MFZRa014S1FBcG9WMVBUdFVGNlBEUFdGSnJCZ2gwV2NQQnM4Q09nc1Z2N1Zp?=
 =?utf-8?B?L2szTytGbDBlYWJBTml4aGxnZUkrSWVtUi81aUtDclZjNmp6LzVlbkJLcVhZ?=
 =?utf-8?B?eHNkTzVjYndCTndlZWpzSEhuL1BvSmE1eHdYZ1o3SHFMSGwwQjZXbUxTNStv?=
 =?utf-8?B?ZnFxaU11NFdDZWZhUHF1WWVCcGNxV1ZwRzRDdmpEVkd4OWVFZFNqNEhzMGp3?=
 =?utf-8?B?bFp5UGVBd3VIZzRDVE5aV0RBZnRqamdoeWdMMkxpaVF0MmJFQmlmZk5lYUNa?=
 =?utf-8?B?dXcvUHV2OE81ejNENVRqaVJLcHJQdmh5Z1RYOTZIRXNoOTNKTlY2QjNnNFlP?=
 =?utf-8?B?VmE0NVg4cE92ODZyU1Z3RkJKdnNBZlJsWHY4a1lIRWc3bEpYQm9wTXpDREMz?=
 =?utf-8?B?a3NNU2JMd3ErQVFFT2U0T3lyOVJhNVJ4U2N2RkR1b2VtOUQ5SzZJUnJlM2lP?=
 =?utf-8?B?RmhabDRkRzdSMjhqdnZIV1dvWVNTS3FxM3ltNEtISXZDM1V3c24yVVFPWlVZ?=
 =?utf-8?B?Q1BaTGRuWjAzc1BMWEpPQVpPd20xWXNDZXV2SytQbzFDMDNqQ09yL3FaeU43?=
 =?utf-8?B?OWxsM3czb2E0V0RUcFRZYjN4QUhabzlmZEVnNHNoeGYyU1FnYXdiS21DTURN?=
 =?utf-8?B?TUlFcW5GSlZITWQ4MGJRbjNvcTlkcjRDdU15bER2c2VzejhDZEM1L0hMYjcy?=
 =?utf-8?B?TUVydnptZ25JN2tjMndaTUNwbk9rZmpmeGhqSnQzVzJsSENQVC9vKzBRdms5?=
 =?utf-8?B?RSt4RTFNb3d5NlF2enFVbnVINTQvL2k2ZXFYVFBVUEZ3MFBkWXlQUkxQWGlM?=
 =?utf-8?B?bGxrZURSWUQ1Zm9ZWjFjWVU5UFNuYkZFTWdxeFYzTFY5bW1NVGx1UndjS1JB?=
 =?utf-8?B?THB3QXR1c0Z5VHlkNXJyQnlMenVpZVpUcmhJdTI2QlBFdmM4dGpPcDZyL1pF?=
 =?utf-8?B?UXZRN1VkVHFXYmVVSWdwY0NYWjd1VklGL01XZmFLdjZWMEE2d09lejBWYUpY?=
 =?utf-8?B?UEVFOURTNEsvYXpvVzR5M1l6K1VnbjEyNDZFa1FKREQ1QzNiNzJXYi9jaHRM?=
 =?utf-8?B?NWZPWEZhK0Ywdm9kZ3lncWxLRkFXdFR0NTg1VklkUzFQV0JCRlFkNFpYOU5M?=
 =?utf-8?B?OGNkZS9jMXhyOVkvSlFucVZSSEdZZHdTTWRxV1hvOUt6elh6OEluWVM0S3ZK?=
 =?utf-8?B?blpDcEQzSk1uN1FVMGE2c1dES1E4ZlhhR3V2ZUh0VERPdHlUeTBJKzZIcmJq?=
 =?utf-8?B?SFdDNXVLK1NXenFPenZTWFUwSWRTUUNxMEhEQlpQSkduYjBySXRiZmFKMjhn?=
 =?utf-8?Q?k7mgMvzUNuvI9Mb/Ac?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9338.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0a9220-ac17-4733-a382-08df3a1f84c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 02:58:35.5720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dg+kojbar6la/NTpk2g/pGRVynpBYfPAH2HIvAM0ghn35M1MtY+SJCl0lpoi8TDf4eROI6ZGyShWYloWaW7giQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10120

DQo+ID4gQEAgLTY4LDEyICs5NywyODYgQEAgc3RhdGljIGludCBuZXRjX2dldF90c19yZXFfaWQo
c3RydWN0IG5ldGNfcG9ydCAqbnApDQo+ID4gIHZvaWQgbmV0Y19wb3J0X3B0cF9pbml0KHN0cnVj
dCBuZXRjX3BvcnQgKm5wKQ0KPiA+ICB7DQo+ID4gICAgIC8qIEluaXRpYWxpemUgdG8gaW52YWxp
ZCBlbnRyeSBJRHMgKi8NCj4gPiAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBORVRDX1BUUF9NQVg7
IGkrKykNCj4gPiAgICAgICAgICAgICBucC0+cHRwX2lwZnRfZWlkW2ldID0gTlRNUF9OVUxMX0VO
VFJZX0lEOw0KPiA+DQo+ID4gKyAgIHNwaW5fbG9ja19pbml0KCZucC0+b25lc3RlcF9sb2NrKTsN
Cj4gPiArICAgX19za2JfcXVldWVfaGVhZF9pbml0KCZucC0+b25lc3RlcF9xdWV1ZSk7DQo+ID4g
KyAgIElOSVRfV09SSygmbnAtPm9uZXN0ZXBfd29yaywgbmV0Y19wb3J0X29uZXN0ZXBfd29yayk7
DQo+ID4gKw0KPiA+ICAgICBzcGluX2xvY2tfaW5pdCgmbnAtPnRzdGFtcF9sb2NrKTsNCj4NCj4g
W1NldmVyaXR5OiBNZWRpdW1dDQo+IENhbiBlbmFibGluZyBvbmUtc3RlcCB0aW1lc3RhbXBpbmcg
aW4gYm90aCBuZXRjX3BvcnRfZW5hYmxlKCkgYW5kDQo+IG5ldGNfbWFjX2xpbmtfdXAoKSBjb3Jy
dXB0IG5wLT5vbmVzdGVwX3N0YXRlIGFjcm9zcyBpbnRlcmZhY2UgYnJpbmd1cD8NCj4NCj4gSW4g
bmV0Y19wb3J0X3B0cF9pbml0KCksIG5wLT5vbmVzdGVwX3N0YXRlIGlzIGxlZnQgYXQgMCAoTkVU
Q19PTkVTVEVQX0lETEUpDQo+IHJhdGhlciB0aGFuIE5FVENfT05FU1RFUF9QT1JUX0lOQUNUSVZF
LiBXaGVuIGEgdXNlciBwb3J0IGlzIG9wZW5lZCB2aWENCj4gZHNhX3VzZXJfb3BlbigpIC0+IGRz
YV9wb3J0X2VuYWJsZV9ydCgpLCBuZXRjX3BvcnRfZW5hYmxlKCkgcnVucyBiZWZvcmUNCj4gcGh5
bGlua19zdGFydChkcC0+cGwpIGFuZCBjYWxscyBuZXRjX3BvcnRfZW5hYmxlX29uZXN0ZXAobnAp
LCBzZXR0aW5nDQo+IG5wLT5vbmVzdGVwX3N0YXRlID0gTkVUQ19PTkVTVEVQX0lETEUgd2hpbGUg
dGhlIHBoeXNpY2FsIGxpbmsgaXMgc3RpbGwgZG93bg0KPiBhbmQgdGhlIHBvcnQgTUFDIFRYIHBh
dGggaXMgc3RpbGwgZGlzYWJsZWQgKFBPUl9UWERJUyBpcyBzZXQgYW5kDQo+IFBNX0NNRF9DRkdf
VFhfRU4gaXMgMCB1bnRpbCBuZXRjX21hY19saW5rX3VwKCkgcnVucykuIEJlY2F1c2UNCj4gcGwt
Pm9sZF9saW5rX3N0YXRlIHN0YXJ0cyBhcyBmYWxzZSBpbiBwaHlsaW5rX3N0YXJ0KCksIHBoeWxp
bmtfcmVzb2x2ZSgpIGRvZXMNCj4gbm90IGNhbGwgbmV0Y19tYWNfbGlua19kb3duKCkgd2hpbGUg
dGhlIGxpbmsgc3RheXMgZG93biBkdXJpbmcNCj4gYXV0b25lZ290aWF0aW9uDQo+IG9yIHdoZW4g
bm8gY2FibGUgaXMgcGx1Z2dlZCBpbi4NCj4NCj4gU2luY2UgRFNBIHVzZXIgbmV0X2RldmljZXMg
dXNlIElGRl9OT19RVUVVRSwgb25lLXN0ZXAgU3luYyBmcmFtZXMNCj4gdHJhbnNtaXR0ZWQNCj4g
YmV0d2VlbiBkc2FfdXNlcl9vcGVuKCkgYW5kIG5ldGNfbWFjX2xpbmtfdXAoKSBwYXNzIHRoZQ0K
PiBORVRDX09ORVNURVBfUE9SVF9JTkFDVElWRSBjaGVjayBpbg0KPiBuZXRjX3BvcnRfb25lc3Rl
cF9zeW5jX2VucXVldWUoKToNCj4NCj4gbmV0Y19wb3J0X29uZXN0ZXBfc3luY19lbnF1ZXVlKCkN
Cj4gICAtPiBzY2hlZHVsZV93b3JrKCZucC0+b25lc3RlcF93b3JrKQ0KPiBuZXRjX3BvcnRfb25l
c3RlcF93b3JrKCkNCj4gICAtPiBhbGxvY2F0ZXMgdHNfcmVxX2lkIGFuZCBkdW1teV9za2Igb24g
bnAtPnRzdGFtcF9xdWV1ZQ0KPiAgIC0+IG5wLT5vbmVzdGVwX3N0YXRlID0gTkVUQ19PTkVTVEVQ
X0lOX0ZMSUdIVA0KPiAgIC0+IHRhZ2dlcl9kYXRhLT5vbmVzdGVwX3N5bmNfeG1pdChza2IsIG5k
ZXYpDQo+DQo+IFRoZSBmaXJzdCBTeW5jIGZyYW1lIGlzIHNlbnQgdG8gdGhlIGRpc2FibGVkIE1B
QyBhbmQgZHJvcHBlZCB3aXRob3V0IGENCj4gdGltZXN0YW1wIHJlc3BvbnNlIHdoaWxlIHN1YnNl
cXVlbnQgU3luYyBmcmFtZXMgYWNjdW11bGF0ZSBpbg0KPiBucC0+b25lc3RlcF9xdWV1ZS4NCj4N
Cj4gV2hlbiB0aGUgbGluayB0aGVuIGNvbWVzIHVwLCBuZXRjX21hY19saW5rX3VwKCkgY2FsbHMN
Cj4gbmV0Y19wb3J0X2VuYWJsZV9vbmVzdGVwKG5wKSBhIHNlY29uZCB0aW1lLCB1bmNvbmRpdGlv
bmFsbHkgb3ZlcndyaXRpbmcNCj4gbnAtPm9uZXN0ZXBfc3RhdGUgd2l0aCBORVRDX09ORVNURVBf
SURMRSBldmVuIHRob3VnaCBhIGZyYW1lIGlzIGFscmVhZHkNCj4gaW4NCj4gZmxpZ2h0IG9yIHNj
aGVkdWxlZC4gQXMgYSByZXN1bHQ6DQo+DQo+IDEuIFdoZW4gbmV0Y19wb3J0X3RzdGFtcF90aW1l
b3V0X3dvcmsoKSBsYXRlciByZWNsYWltcyB0aGUgdGltZWQtb3V0DQo+ICAgIGR1bW15X3NrYiwg
bnAtPm9uZXN0ZXBfc3RhdGUgPT0gTkVUQ19PTkVTVEVQX0lOX0ZMSUdIVCBpcyBmYWxzZSwgc28N
Cj4gICAgcmVzdW1lX29uZXN0ZXAgaXMgbm90IHNldCBhbmQgYW55IHNrYnMgd2FpdGluZyBpbiBu
cC0+b25lc3RlcF9xdWV1ZSBhcmUNCj4gICAgc3RyYW5kZWQgdW50aWwgYW5vdGhlciBTeW5jIGZy
YW1lIGFycml2ZXMgb3IgdGhlIHBvcnQgZ29lcyBkb3duLg0KPg0KPiAyLiBBbHRlcm5hdGl2ZWx5
LCBpZiBhIGZyYW1lIGlzIHN0aWxsIGluIGZsaWdodCB3aGVuIG5ldGNfbWFjX2xpbmtfdXAoKQ0K
PiAgICByZXNldHMgbnAtPm9uZXN0ZXBfc3RhdGUgdG8gTkVUQ19PTkVTVEVQX0lETEUsIHRoZSBu
ZXh0IFN5bmMgZnJhbWUNCj4gICAgYXJyaXZpbmcgYXQgbmV0Y19wb3J0X29uZXN0ZXBfc3luY19l
bnF1ZXVlKCkgc2VlcyBORVRDX09ORVNURVBfSURMRQ0KPiBhbmQNCj4gICAgaW1tZWRpYXRlbHkg
c2NoZWR1bGVzIG5ldGNfcG9ydF9vbmVzdGVwX3dvcmsoKSwgcmVwcm9ncmFtbWluZw0KPiAgICBO
RVRDX1BNX1NJTkdMRV9TVEVQKDApIGJlZm9yZSB0aGUgZWFybGllciBmcmFtZSBmaW5pc2hlcy4N
Cj4NCj4gU2hvdWxkIG5ldGNfcG9ydF9wdHBfaW5pdCgpIGluaXRpYWxpemUgbnAtPm9uZXN0ZXBf
c3RhdGUgdG8NCj4gTkVUQ19PTkVTVEVQX1BPUlRfSU5BQ1RJVkUsIHdpdGggbmV0Y19wb3J0X2Vu
YWJsZV9vbmVzdGVwKG5wKSBjYWxsZWQNCj4gb25seSBmcm9tDQo+IG5ldGNfbWFjX2xpbmtfdXAo
KT8NCg0KSSBkbyBub3QgdGhpbmsgdGhpcyBpcyBhIHJlYWwgaXNzdWUgZm9yIFBUUCBwYWNrZXRz
LCB0aGUgcHRwNGwgd2lsbCBjaGVjayB0aGUNCmNhcnJpZXIgc3RhdHVzIGJlZm9yZSBzZW5kaW5n
IHRoZSBQVFAgcGFja2V0cy4NCg0KDQpOWFAgQ29uZmlkZW50aWFsDQo=
