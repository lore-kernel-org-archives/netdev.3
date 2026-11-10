Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.129.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794342410;
	b=HufYY+iDj7O9C9QCxoDVj2ZFmI8KG8AXvCzfGIchEpaCLm97fOPge+zm3zvwIziIPAa/
	 K5diBIIk9hv5B145GfsOoQR/ZjiX26zHKgxjbgFgTzp4QlBr44+9LysuGwZqwYngCpn89
	 tQIyiPwpkUGsUCIcWH9V5AIdAgZm7qxx3GgpQpQkfrudYGufkFMxULX8aOSUBrjLgbMHQ
	 2zRUIkKD5uBUPj4aITLN2uqGDflOLBG3hZ8d3wD5b3mHxgs1S2m72dPKmvq5k89tXUhis
	 vcPOXv4oozW5ST3a4qlFM3+2Z7jHzh5Bps19gM1HjFXun8INTOSb2aQ0rMhLINHEaqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342410;
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
	bh=FMMwIr1Pc/2ODGmZkWtJN4oK/AphDE6TIND2duAcEYU=;
	b=J0iKHxYSY88jW8XH/4oiS5U9ihXk40zu9e9g8See0Z8hGS2NFJSELlmMB7BGC6SZZ5m8
	 a5Sh5ZSSYOIcm7RluURPM4hQJGVy0C/zF6oFjSy2VLEgUA38PzQh/uIfDv4vstmasKhgx
	 N6h/i57Q7fg7NRCrjep7A32msFEljywGawRKSwJjJHzRB4Cz+V9qvP0nhwEHeo/4Zn0yF
	 0AjxnCuhp70boHY0lccdwYOJUhl9JwXPEZM0dyieZrFj+e+q+d7Y1usxq3iEPahrA4L3C
	 gNF3SVV8Mfna9YhxSa5ULui90xv6/TfmkX3VBFv6RmlfO+XbuTz7ujeEk3ic+BQ+N9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sitime.com;
	spf=pass smtp.mailfrom=sitime.com;
	dkim=pass header.d=sitime.com header.i=@sitime.com header.a=rsa-sha256 header.s=mail header.b=bLkD9jyx;
	dkim=pass header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-Sitime-onmicrosoft-com header.b="K3/N+imB";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.129.52
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D212360A260D;
	Tue, 10 Nov 2026 20:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D212360A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.a=rsa-sha256 header.s=mail header.b=bLkD9jyx;
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-Sitime-onmicrosoft-com header.b=K3/N+imB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=FMMwIr1Pc/2ODGmZkWtJN4oK/AphDE6TIND2duAcEYU=;
 b=bLkD9jyxk6fDY99gufiH1TUu42mNXr9Q7nh8Cr2UqpaTffYDYjLo9KtsKfgbcpzRaRg19rt4eGpaAqDRvtPkFED/trnREZSbV5sgzJTtuL09VHZzR6xjaaOpWKsMxkR+6vvZC5pJtGCAwJD/0UtEIKPBoo1H706htyugd9cYNDsqWpqkbc/Bo2RlvdWHmjjPS/BUAaDF1moEoh3LECJsrlV4/kcnPq2fmAQAYXphcflXapGJ4/cdPb6yZBU5VmZFupRNOX95Q3g1zGjOVFvE1eegqCBZYcaTMml4FQ2Vj8LpV5sEM+dm51I3Gbnhag/vQW+ARcJ3p4jnr+Fm4HV3HQ==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020092.outbound.protection.outlook.com [40.93.198.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 85714280084;
	Tue, 10 Nov 2026 20:26:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2qKXZhRE0wytW5JMUNReeq8yE7uETTkmANe0AsAIlQbpIHfiOE78k/C4E2D10+61HZdOPhgouc+QkWF8qwSyfXwMxa1B/b6A+s22p5vtoAVr4FaVFzfGJtVz4c+GCkK5BdNZVTIVmzLm+X8gU20/AXulyhi087wzBGHDMybTM6KhBvIHV2j0SLHIN4I9TwtPJbAkprNzTL2Tq+oH8to4VliJwSnFdme1r6Q/MIqyh6YVuZGNX3u43Z5NzpImPi1yeNiZ/bw+z3HFxsvrAonWilG9ffHjFxARa97vV4q/tf+DobyTShBUGC+LmxtdsCu7Z3FAld4qmJx48jWEUsEWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMMwIr1Pc/2ODGmZkWtJN4oK/AphDE6TIND2duAcEYU=;
 b=mL03R3EU6N+rdRi/VIEGf7+nfpXMvPAeP0i0ZiBoRKh48R4KYAK1bO0ZXynsx3NGDFYt4qt6wY+c9wPrkrntUvnHOfg3GAnRoS76u1y1nWGTCbz6BTHcVaOF5SatzChFkRBDZ4ET542PNwlFr8QHUN9yO8aMggAjMGSiAaKwObxkTU2rHA3B53I1WMtiv4p3jDYUnIpdzyWMmYOn1xfQ1MBgv/V2oFr6bFAAZdJVd68ZB+QRVC0/QobqaZyq/9goAqBxZxzqr+o3XdQrhTfvlTHdXcbgDVByxqn+YJMmMrJPmdwqfngi7MGjSUK+hZc5K5cxNa4AeXg81blhJG/5Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMMwIr1Pc/2ODGmZkWtJN4oK/AphDE6TIND2duAcEYU=;
 b=K3/N+imBqrZKLiLBOtRBL3QfxtCRSuVDIutuIWbMaVP9gx2yHRr/9UQngVXFNU4JGQcwF++qWk9AtB9Cm5/ezvBPmRXk1eq4oUZ/iYzPfXzy8+1+X1KyW4jLTB7wilFhvGmkKu2kLY7M54oc9DpZZoHkYeYpVJE3OQyiJlaH2phdCjXx6anS741XfQgn0zyhsiXI44l8x/H2V5MfsuxfdyzqehqPZ+cVyKI9/yt+eX8KHsqKLTxYxQXTAIjuy6BMaAIsp1g8WEpJLMJbmsixnE/SoZXQZ3JoF7gyV1imuSV5Iz64ZN4ZZL/fQujZ0h1u3abhs/AyZnSSXSHYIobmKA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CH3PR20MB5745.namprd20.prod.outlook.com
 (2603:10b6:610:14d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 20:26:19 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 20:26:19 +0000
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
Subject: [PATCH net-next v15 07/13] dpll: sit9531x: implement input pin state
 on a DPLL
Thread-Topic: [PATCH net-next v15 07/13] dpll: sit9531x: implement input pin
 state on a DPLL
Thread-Index: AQHdcVG7WKuhBCBcGU6cGmi6jKB87A==
Date: Tue, 10 Nov 2026 20:26:13 +0000
Message-ID: <20261110202607.55744-8-arouhi@sitime.com>
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
x-ms-office365-filtering-correlation-id: 224dff35-dbff-44b8-5e3c-08df3f68e0e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|56012099006|5023799004|18002099003|22082099003|6133799003|10067099003|261009223027099003|261021121427099003|261028144727099003|261021123027099003|261021130227099003|261102123227099003|261021133027099003|261026130827099003|261022075727099003|261022105027099003|261026140227099003|261026121527099003|261026135527099003|261022113327099003|3023799007|261022115727099003|261021135927099003;
x-microsoft-antispam-message-info:
 09fTFXSsYwWAzL9y42n6SJ2s5pMD812bcGAk+ge5Go4dv12XIVpDO6p7BJpGeHsyELQI+8a8ZtgM8IjSQO7nG5XTuDVVYbsEPB+hhS04A3liTKO7EE9fSByj0IynIqZLf79TGppq1VpRiDF8ayjQ+LjnUYAwsBZ1hyyyaVE9pJakZaFN34D3Tq1cvpfkPnGWN7LbusPEBZLQR8YH99dmzuuc5GWF1C9vMJw2f/X3IqprImw2P4Ci+TVtVxgpoA0SGsn/rWS8UQB0+3SdhcLqSxsAfGwfFu10ID108R6qxLjSsRixgIx/Ag1MxfP6vneuV6zsO/laYUArjP8Tn2iUX2Dk5cUI1gY+Gc+ftGMM963LFHukUMDsmhLFvT1X/HIjumjprfRqjGgBUObFSpLIiq7xbB4ADITwdmmmWrUTTbWCLunkNbdsFqoks+TuQv1VaquEa8UeDePH6DDgl2STMgtR2nAYOql6ZCu1zQ4wxGdReZJALndDPODkrGS20TgMWx0zTvzZelVt3NXeD3drsoDbdBWFhsF1sckrIWCqjb5/3IMoJOn4rkJO9rDefBraLtOST4eat7XKoVJJfjFZ2A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(56012099006)(5023799004)(18002099003)(22082099003)(6133799003)(10067099003)(261009223027099003)(261021121427099003)(261028144727099003)(261021123027099003)(261021130227099003)(261102123227099003)(261021133027099003)(261026130827099003)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261026135527099003)(261022113327099003)(3023799007)(261022115727099003)(261021135927099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+dtayrNWdcL/D2i9qYgDTnSx0uSiEG7fhZ2E46fqBs1HSWTXDwiV681NnL?=
 =?iso-8859-1?Q?4OPyRDOqImFd7AbRCCPI4V8ToYCR40/kGZzBkFnPSP9opmdAl45oFg7Lma?=
 =?iso-8859-1?Q?KgsttxMuAgT44yZFK0wV/vfyhlydDmhMdIeBDwPxFwSDnH/BmSSdV5ZW/6?=
 =?iso-8859-1?Q?uG72fhPm1vMt0fGRxl+R92Wxoqj3ObhS6l8jacsszXVf5Ezlb3M9QvOzyu?=
 =?iso-8859-1?Q?f0yIRCR9xIIBNQQUK6javB0UzcqcHhTBEIQWH8P46fBdbw00tL7PJvVjFo?=
 =?iso-8859-1?Q?QKu7gzvC7ZRCXSY5OMB5ENrHLmbnBe8TKQI0mQikSI1hk11T8wBjafWiKq?=
 =?iso-8859-1?Q?SEsO67Q5zDbNlbvPKrA+fhZr8/UhYxjWmTn2527+OgiWdrrBBa2H7tlgbT?=
 =?iso-8859-1?Q?7mfmHbxN/EkxhX9k7s/vEz5fRJ/DroWOJuTt1I04ESynwnfJ4TcgaYFYun?=
 =?iso-8859-1?Q?emKeWRx6vWja3jRvB2+QYbxJhIGMAZx3vtFNfBDdR3la+koM54RjXqeIMY?=
 =?iso-8859-1?Q?3V12FCgeVFd4v6JaJZ+fOR52dKuk76isg7xr54i3lS1g9MK1oWrI9KsMTw?=
 =?iso-8859-1?Q?x5ODFU8UKV56x9ZfRfV0e/NUftPjptRITKIWopo8WVZI9Q/QFHvjgf6l5m?=
 =?iso-8859-1?Q?vNCWirR8rq7+QbRRc/xeC+cu8LawnKOApQylGxheVV1HxHFUaiBofTiDkS?=
 =?iso-8859-1?Q?MzqWbbLdBbD6uCUfjt7PXBxsCAnpeJyKA379eo6Fj3tCI4/y1izBFZlAtS?=
 =?iso-8859-1?Q?bq6BeOl0+nBEtnmE5R5rYpwjtSpzzm8COPSwAIkPBfZLNZ6YXRQA78c8kj?=
 =?iso-8859-1?Q?h8Ay/ipOPllzJMTTZaoMmYfcHsCjhK1Pw1kADQBqhOYL8oWDjbQN/SoOHy?=
 =?iso-8859-1?Q?28NQHGDQjFXIvWmyl3yjyQYajY9aZSii6pTKMUXv2ncip1Ce6PiFVOkvKS?=
 =?iso-8859-1?Q?/j6/gVw5gRUMn0Hf7EPvAl2pIC9Pef/wp/OvSxZTmy5+8LDK2ZS6P+WupE?=
 =?iso-8859-1?Q?VMGrdvbi0MprO3tfTitNXeOEeHDLNERsd7OfdTRadUB18ef3TClU5s+mi9?=
 =?iso-8859-1?Q?7jY8VbsYEN4Qndk1j/LLOPkOKQVLQXljmXL41M4VXupTTfsUePSq1cqK/G?=
 =?iso-8859-1?Q?zNN+LNovtds5Vu+8HF143vLZ+s7utkHqOnK/nmciQalt/GdTm1m6PpZIfL?=
 =?iso-8859-1?Q?gb6DS2OBCctvCQEA25rcANQLUlj4f775oPzQVWwscPyUxOYlJPEybykZUI?=
 =?iso-8859-1?Q?9+69v4lSW8VJ8zSQ1xjkpnP7fRM11wgj9X1JePOu91Rrvg+fEWorZ+xTOJ?=
 =?iso-8859-1?Q?NNOBd4cA1T4d2JWlJK2wDKkikMkr2vuPOk1m/IQZSPlHOxHFrrcQmsk0Yw?=
 =?iso-8859-1?Q?v00QAXfel6FyuJgG1c3Y5Tz2aM4klXU8O27eyEldgRNQdoG3NZVxgq2FH8?=
 =?iso-8859-1?Q?nBJYBbk5zrbsfxvAS68VKQn993d4lZxwWQnAmmOiiapwAuDxCszHSMozMN?=
 =?iso-8859-1?Q?hKvTgnL/TetVKeV5AMmYijXiG4uXQMsaEXO2n05FaGmkg+t3Yn2y3oH3lv?=
 =?iso-8859-1?Q?spgn0/qsCDrJeKxLKBZ4L1+tstVMk6t1wG9yZxliFESTv7epMVwvlpTLtA?=
 =?iso-8859-1?Q?8VYxMuYDWSqqw1Ez1m6/7kXriF//NPEghGhTC+E9Fz0FanYhqfg1HqLKGF?=
 =?iso-8859-1?Q?4poG8DgAFIeBiu30JavBZMT6uVuAQ58IJ1WB1VFgfYdzPjosdqob8/xDO8?=
 =?iso-8859-1?Q?UhGmslAwnMXCvovyAnFl5i/H/6OFvUl2YTd4IL3gEyJfCy?=
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
	Fk3q440Hh/SwcUwhR7pO+WUpczz9t550FAP9oNyDuIeODbu2M7TzSK+RaQLqbWKGnN+jlHww8rGQtJQjtAD0MAZ7RohKOG7wNEtPrSvx6D83RDc7CgccZ3xH7EWP63qf9Xb0Be9hi3j5g1M5ydme0s8XP0b1D3BtgC52t46fgCOhtS9IVCNCF45BPrIiYi0+RS4K+Qa26IAJiX5j00vqztZ/0RWPD+XJkw51flVVnxWx9PTD6nH4JXKUKJGdlyBkHYE7rcvzfWVogb8d5eOjUOMs4GvytcCrwov0yAEIJw120vfAF9RbqXjmMDdGJ610im7C3s7f+OV14TvkPOwJaw==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 224dff35-dbff-44b8-5e3c-08df3f68e0e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 20:26:13.6379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xbaWpCVh5qd0l2b6wLxiWQr3SqHsNo6FO7CImwTIb1gffu9UKdT5Adwdr8Hdjx1do1t6SJJ60eWhCeat7RoxeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB5745
X-MDID: 1794342407-KGAXsBKSxBAp
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1794342407;KGAXsBKSxBAp;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Report and set whether an input takes part in a PLL's reference=0A=
selection. The PLL picks its reference from a priority table: an input=0A=
in the table is SELECTABLE, one absent is DISCONNECTED, and setting the=0A=
state adds or removes it. CONNECTED is refused, as the driver does not=0A=
program manual input select.=0A=
=0A=
A table write uses the documented procedure: force holdover, write=0A=
the slots, latch with a small update, release. The pin reported active=0A=
is the one the part feeds the PLL while the PLL tracks it and the lane=0A=
has signal.=0A=
=0A=
A PLL in holdover after losing its reference is re-selected when a=0A=
listed source returns.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 1122 ++++++++++++++++++++++++++++++++--=0A=
 drivers/dpll/sit9531x/core.h |   65 +-=0A=
 drivers/dpll/sit9531x/dpll.c |  257 +++++++-=0A=
 drivers/dpll/sit9531x/regs.h |   38 ++=0A=
 4 files changed, 1432 insertions(+), 50 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 209671e7917e..af6d7918958d 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -61,10 +61,21 @@ static const struct sit9531x_chip_info sit9531x_chip_id=
s[] =3D {=0A=
  * One 256-register page is visible at a time, selected by offset 0xFF on =
every=0A=
  * page. The map covers that window, uncached; the accessors select the pa=
ge.=0A=
  */=0A=
+/*=0A=
+ * Each read of the debug status data register advances the status bus lat=
ch;=0A=
+ * marking it precious stops a debugfs dump from reading it.=0A=
+ */=0A=
+static bool sit9531x_precious_reg(struct device *dev __maybe_unused,=0A=
+				  unsigned int reg)=0A=
+{=0A=
+	return reg =3D=3D SIT9531X_PLL_REG_DBG_STATUS_DATA;=0A=
+}=0A=
+=0A=
 static const struct regmap_config sit9531x_regmap_config =3D {=0A=
 	.reg_bits	=3D 8,=0A=
 	.val_bits	=3D 8,=0A=
 	.max_register	=3D SIT9531X_PAGE_SEL,=0A=
+	.precious_reg	=3D sit9531x_precious_reg,=0A=
 	.cache_type	=3D REGCACHE_NONE,=0A=
 };=0A=
 =0A=
@@ -206,6 +217,34 @@ int sit9531x_update_pll_u8(struct sit9531x_dev *sitdev=
, u8 pll_idx,=0A=
 	return rc;=0A=
 }=0A=
 =0A=
+#define SIT9531X_CLOSE_TRIES		3=0A=
+=0A=
+/* Write a register, retrying on failure */=0A=
+static int sit9531x_write_close(struct sit9531x_dev *sitdev, unsigned int =
reg,=0A=
+				u8 val)=0A=
+{=0A=
+	u8 attempt;=0A=
+	int rc;=0A=
+=0A=
+	for (attempt =3D 0; attempt < SIT9531X_CLOSE_TRIES; attempt++) {=0A=
+		if (attempt)=0A=
+			usleep_range(1000, 2000);=0A=
+		rc =3D sit9531x_write_u8(sitdev, reg, val);=0A=
+		if (!rc)=0A=
+			break;=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+static int sit9531x_write_pll_close(struct sit9531x_dev *sitdev, u8 pll_id=
x,=0A=
+				    u8 offset, u8 val)=0A=
+{=0A=
+	return sit9531x_write_close(sitdev,=0A=
+				    SIT9531X_REG(sit9531x_pll_page(pll_idx),=0A=
+						 offset), val);=0A=
+}=0A=
+=0A=
 static void sit9531x_input_get_regs(const struct sit9531x_dev *sitdev,=0A=
 				    u8 index,=0A=
 				    unsigned int *force_reg,=0A=
@@ -223,6 +262,72 @@ static void sit9531x_input_get_regs(const struct sit95=
31x_dev *sitdev,=0A=
 	}=0A=
 }=0A=
 =0A=
+/* Caller must hold sitdev->multiop_lock. */=0A=
+int sit9531x_input_disable(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	unsigned int force_reg, state_reg;=0A=
+	struct sit9531x_ref *ref;=0A=
+	u8 pair, val;=0A=
+	int rc, ret;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (index >=3D SIT9531X_MAX_INPUTS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	ref =3D &sitdev->ref[index];=0A=
+	pair =3D sit9531x_input_pair(index);=0A=
+	sit9531x_input_get_regs(sitdev, index, &force_reg, &state_reg);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, force_reg, &val);=0A=
+	if (!rc)=0A=
+		rc =3D sit9531x_write_u8(sitdev, force_reg, val | BIT(pair));=0A=
+=0A=
+	ret =3D sit9531x_read_u8(sitdev, state_reg, &val);=0A=
+	if (!ret)=0A=
+		ret =3D sit9531x_write_u8(sitdev, state_reg, val & ~BIT(pair));=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+	ref->enabled =3D false;=0A=
+	ref->off_pending =3D rc !=3D 0;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Release the force so the lane uses the loaded configuration. Caller mus=
t hold=0A=
+ * sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_input_enable(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	unsigned int force_reg, state_reg;=0A=
+	struct sit9531x_ref *ref;=0A=
+	u8 pair, val;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (index >=3D SIT9531X_MAX_INPUTS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	ref =3D &sitdev->ref[index];=0A=
+	pair =3D sit9531x_input_pair(index);=0A=
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
+	ref->off_pending =3D false;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Output Hi-Z control: each slot has three force/state pairs on Page 0x03=
,=0A=
  * for the differential path and the CMOS OutP and OutN pads. A mute write=
s=0A=
@@ -359,7 +464,7 @@ static int sit9531x_output_forced_hiz(struct sit9531x_d=
ev *sitdev,=0A=
  *   1. Force PLL into holdover (PLL page reg 0x6F bit 4)=0A=
  *   2. Write priority slots on Page 1=0A=
  *   3. Small change update (Page 0 reg 0x0F bit 1)=0A=
- *   4. Release holdover=0A=
+ *   4. Release holdover, unless something other than this driver forced i=
t=0A=
  *=0A=
  * Caller must hold sitdev->multiop_lock.=0A=
  */=0A=
@@ -381,20 +486,460 @@ static u8 sit9531x_prio_slot_get(u8 val, u8 slot)=0A=
 	return val >> SIT9531X_PRIO_HI_SHIFT;=0A=
 }=0A=
 =0A=
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
+ * Latch a priority table with a small change update, as in the documented=
=0A=
+ * input_priority_sel() procedure.=0A=
+ */=0A=
+static int sit9531x_prio_prg_commit(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_write_close(sitdev, SIT9531X_REG_GLOBAL_UPDATE,=0A=
+				  SIT9531X_SMALL_UPDATE_CMD);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	usleep_range(1000, 2000);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Four registers carry a nibble per lane: loss of signal and the fine and=
=0A=
+ * coarse frequency-drift flags. Caller must hold sitdev->multiop_lock, or=
 run=0A=
+ * before registration.=0A=
+ */=0A=
+static int sit9531x_input_mon_fetch(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	static const unsigned int regs[] =3D {=0A=
+		SIT9531X_CLKMON_P_STATUS_01, SIT9531X_CLKMON_P_STATUS_23,=0A=
+		SIT9531X_CLKMON_N_STATUS_01, SIT9531X_CLKMON_N_STATUS_23,=0A=
+	};=0A=
+	u8 val[ARRAY_SIZE(regs)], i, pair, nib;=0A=
+	int rc;=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(regs); i++) {=0A=
+		rc =3D sit9531x_read_u8(sitdev, regs[i], &val[i]);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+	}=0A=
+=0A=
+	for (i =3D 0; i < sitdev->info->num_inputs && i < SIT9531X_MAX_INPUTS;=0A=
+	     i++) {=0A=
+		struct sit9531x_ref *ref =3D &sitdev->ref[i];=0A=
+=0A=
+		/* Lane 2k is INkP, 2k + 1 INkN; a register holds two pairs. */=0A=
+		pair =3D sit9531x_input_pair(i);=0A=
+		nib =3D val[(sit9531x_input_is_n(i) ? 2 : 0) + pair / 2];=0A=
+		nib =3D (pair & 1) ? nib >> 4 : nib & 0x0F;=0A=
+=0A=
+		ref->los =3D !!(nib & SIT9531X_CLKMON_LOSS);=0A=
+		ref->qual_fail =3D !ref->los &&=0A=
+				 !!(nib & (SIT9531X_CLKMON_FINE_DRIFT |=0A=
+					   SIT9531X_CLKMON_COARSE_DRIFT));=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Check if the device can lock to @src now; a differential pair is watche=
d=0A=
+ * through its P lane.=0A=
+ */=0A=
+static bool sit9531x_prio_src_live(const struct sit9531x_dev *sitdev, u8 s=
rc)=0A=
+{=0A=
+	u8 index =3D sit9531x_hw_src_input(src);=0A=
+=0A=
+	if (index >=3D sitdev->info->num_inputs)=0A=
+		return true;=0A=
+=0A=
+	return !sitdev->ref[index].los;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Map an N-lane source of a differential pair to its P lane, the lane its=
 DPLL=0A=
+ * pin represents.=0A=
+ */=0A=
+static u8 sit9531x_prio_src_canon(const struct sit9531x_dev *sitdev, u8 sr=
c)=0A=
+{=0A=
+	u8 index =3D sit9531x_hw_src_input(src);=0A=
+=0A=
+	if (index >=3D sitdev->info->num_inputs)=0A=
+		return src;=0A=
+=0A=
+	if (sit9531x_input_is_n(index) &&=0A=
+	    sitdev->ref[index].sig_mode =3D=3D SIT9531X_MODE_DE)=0A=
+		return sit9531x_input_hw_src(index - 1);=0A=
+=0A=
+	return src;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * @input_idx is in hardware encoding (see sit9531x_input_hw_src()). Calle=
r must=0A=
+ * hold sitdev->multiop_lock.=0A=
+ */=0A=
+bool sit9531x_input_prio_present(struct sit9531x_dev *sitdev, u8 pll_idx,=
=0A=
+				 u8 input_idx)=0A=
+{=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return false;=0A=
+=0A=
+	input_idx =3D sit9531x_prio_src_canon(sitdev, input_idx);=0A=
+	if (input_idx >=3D SIT9531X_PRIO_NUM_SRC)=0A=
+		return false;=0A=
+=0A=
+	return !!(sitdev->chan[pll_idx].prio_mask & BIT(input_idx));=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Take the configured priorities from the hardware table: a listed source=
 gets=0A=
+ * the first slot it occupies.=0A=
+ */=0A=
+static void sit9531x_prio_cfg_seed(struct sit9531x_dev *sitdev, u8 pll_idx=
,=0A=
+				   const u8 *srcs)=0A=
+{=0A=
+	struct sit9531x_chan *chan =3D &sitdev->chan[pll_idx];=0A=
+	u16 seeded =3D 0;=0A=
+	u8 slot, src;=0A=
+=0A=
+	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {=0A=
+		src =3D srcs[slot] & SIT9531X_PRIO_NIBBLE_MASK;=0A=
+		if (!sit9531x_prio_src_usable(src))=0A=
+			continue;=0A=
+		src =3D sit9531x_prio_src_canon(sitdev, src);=0A=
+		if (seeded & BIT(src))=0A=
+			continue;=0A=
+		seeded |=3D BIT(src);=0A=
+		chan->cfg_prio[src] =3D slot;=0A=
+		chan->cfg_known |=3D BIT(src);=0A=
+	}=0A=
+=0A=
+	for (src =3D 0; src < SIT9531X_PRIO_NUM_SRC; src++) {=0A=
+		if (chan->cfg_known & BIT(src))=0A=
+			continue;=0A=
+		chan->cfg_prio[src] =3D SIT9531X_PRIO_MAX_SLOTS - 1;=0A=
+		chan->cfg_known |=3D BIT(src);=0A=
+	}=0A=
+=0A=
+	memcpy(chan->seen_srcs, srcs, sizeof(chan->seen_srcs));=0A=
+	chan->seen_valid =3D true;=0A=
+}=0A=
+=0A=
+/* Order the members by configured priority */=0A=
+static void sit9531x_prio_table_build(struct sit9531x_dev *sitdev, u8 pll_=
idx,=0A=
+				      u16 members, u8 *srcs)=0A=
+{=0A=
+	const struct sit9531x_chan *chan =3D &sitdev->chan[pll_idx];=0A=
+	u8 order[SIT9531X_PRIO_NUM_SRC], n =3D 0, i, j, src;=0A=
+=0A=
+	for (src =3D 0; src < SIT9531X_PRIO_NUM_SRC; src++)=0A=
+		if (members & BIT(src))=0A=
+			order[n++] =3D src;=0A=
+=0A=
+	for (i =3D 1; i < n; i++) {=0A=
+		u8 cur =3D order[i];=0A=
+=0A=
+		for (j =3D i; j > 0; j--) {=0A=
+			u8 prev =3D order[j - 1];=0A=
+			u16 kc, kp;=0A=
+=0A=
+			kc =3D (chan->cfg_known & BIT(cur)) ?=0A=
+			     chan->cfg_prio[cur] : U8_MAX;=0A=
+			kp =3D (chan->cfg_known & BIT(prev)) ?=0A=
+			     chan->cfg_prio[prev] : U8_MAX;=0A=
+			if (kc =3D=3D kp) {=0A=
+				/* Keep the hardware order among equals. */=0A=
+				kc =3D chan->prio_last[cur] ?: U8_MAX;=0A=
+				kp =3D chan->prio_last[prev] ?: U8_MAX;=0A=
+			}=0A=
+			if (kp <=3D kc)=0A=
+				break;=0A=
+			order[j] =3D prev;=0A=
+		}=0A=
+		order[j] =3D cur;=0A=
+	}=0A=
+=0A=
+	for (i =3D 0; i < SIT9531X_PRIO_MAX_SLOTS; i++)=0A=
+		srcs[i] =3D i < n ? order[i] : SIT9531X_PRIO_SRC_NONE;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Refresh the cached membership mask, per-slot copy and first-slot array =
of a=0A=
+ * PLL's priority table.=0A=
+ */=0A=
 static void sit9531x_prio_mask_build(struct sit9531x_dev *sitdev, u8 pll_i=
dx,=0A=
 				     const u8 *srcs)=0A=
 {=0A=
+	struct sit9531x_chan *chan =3D &sitdev->chan[pll_idx];=0A=
+	u8 first[SIT9531X_PRIO_NUM_SRC] =3D { 0 };=0A=
+	u8 slot, src, src_canon;=0A=
 	u16 mask =3D 0;=0A=
-	u8 slot;=0A=
 =0A=
 	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {=0A=
-		u8 src =3D srcs[slot] & SIT9531X_PRIO_NIBBLE_MASK;=0A=
+		src =3D srcs[slot];=0A=
+		src &=3D SIT9531X_PRIO_NIBBLE_MASK;=0A=
+		chan->prio_srcs[slot] =3D src;=0A=
+		src_canon =3D sit9531x_prio_src_canon(sitdev, src);=0A=
+		if (!sit9531x_prio_src_usable(src))=0A=
+			continue;=0A=
+=0A=
+		mask |=3D BIT(src_canon);=0A=
+		if (!first[src_canon])=0A=
+			first[src_canon] =3D slot + 1;=0A=
+	}=0A=
+=0A=
+	for (src =3D 0; src < SIT9531X_PRIO_NUM_SRC; src++)=0A=
+		chan->prio_last[src] =3D first[src];=0A=
+=0A=
+	chan->prio_mask =3D mask;=0A=
+}=0A=
+=0A=
+#define SIT9531X_HO_CLEAR_TRIES		3=0A=
+=0A=
+static int sit9531x_prio_table_read(struct sit9531x_dev *sitdev, u8 pll_id=
x,=0A=
+				    u8 *srcs);=0A=
+static int sit9531x_chan_state_fetch(struct sit9531x_dev *sitdev, u8 pll_i=
dx);=0A=
+=0A=
+static u8 sit9531x_prio_top_live(const struct sit9531x_dev *sitdev,=0A=
+				 const u8 *srcs)=0A=
+{=0A=
+	u8 i, src;=0A=
+=0A=
+	for (i =3D 0; i < SIT9531X_PRIO_MAX_SLOTS; i++) {=0A=
+		src =3D srcs[i] & SIT9531X_PRIO_NIBBLE_MASK;=0A=
+		src =3D sit9531x_prio_src_canon(sitdev, src);=0A=
+		if (sit9531x_prio_src_usable(src) &&=0A=
+		    sit9531x_prio_src_live(sitdev, src))=0A=
+			return src;=0A=
+	}=0A=
+=0A=
+	return SIT9531X_PRIO_SRC_NONE;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Pick the active selection to latch; after a latch the PLL uses that sou=
rce=0A=
+ * until it loses signal.=0A=
+ */=0A=
+static u8 sit9531x_prio_activesel_pick(struct sit9531x_dev *sitdev,=0A=
+				       const u8 *old, const u8 *srcs, u8 cur)=0A=
+{=0A=
+	u8 top, i;=0A=
+=0A=
+	top =3D sit9531x_prio_top_live(sitdev, srcs);=0A=
+	if (top !=3D SIT9531X_PRIO_SRC_NONE &&=0A=
+	    top !=3D sit9531x_prio_top_live(sitdev, old))=0A=
+		return top;=0A=
+=0A=
+	cur =3D sit9531x_prio_src_canon(sitdev, cur & SIT9531X_PRIO_NIBBLE_MASK);=
=0A=
+=0A=
+	if (sit9531x_prio_src_usable(cur) &&=0A=
+	    sit9531x_prio_src_live(sitdev, cur))=0A=
+		for (i =3D 0; i < SIT9531X_PRIO_MAX_SLOTS; i++)=0A=
+			if (srcs[i] =3D=3D cur)=0A=
+				return cur;=0A=
+=0A=
+	if (top !=3D SIT9531X_PRIO_SRC_NONE)=0A=
+		return top;=0A=
+=0A=
+	for (i =3D 0; i < SIT9531X_PRIO_MAX_SLOTS; i++)=0A=
+		if (sit9531x_prio_src_usable(srcs[i]))=0A=
+			return srcs[i];=0A=
+=0A=
+	return srcs[0];=0A=
+}=0A=
+=0A=
+static int sit9531x_prio_table_commit(struct sit9531x_dev *sitdev, u8 pll_=
idx,=0A=
+				      const u8 *srcs)=0A=
+{=0A=
+	u8 val, last_old, slot, attempt, written =3D 0, restored =3D 0;=0A=
+	u8 now[SIT9531X_PRIO_MAX_SLOTS], back[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	struct sit9531x_chan *chan =3D &sitdev->chan[pll_idx];=0A=
+	int rc =3D 0, prg_rc, ho_rc =3D 0;=0A=
+	bool empty, ho_foreign, pending =3D false;=0A=
+	bool pending_before =3D chan->table_pending;=0A=
+	u16 reg;=0A=
+=0A=
+	empty =3D true;=0A=
+	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++)=0A=
+		if (sit9531x_prio_src_usable(srcs[slot]))=0A=
+			empty =3D false;=0A=
+=0A=
+	memcpy(back, chan->table_pending ? chan->table_back : chan->prio_srcs,=0A=
+	       sizeof(back));=0A=
+=0A=
+	/*=0A=
+	 * Treat a forced holdover as set by this driver only when the table is=
=0A=
+	 * empty or a release is pending; leave any other in place.=0A=
+	 */=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_HO_CTRL,=0A=
+				  &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
 =0A=
-		if (sit9531x_prio_src_usable(src))=0A=
-			mask |=3D BIT(src);=0A=
+	ho_foreign =3D (val & BIT(SIT9531X_PLL_HO_FORCE_BIT)) &&=0A=
+		     chan->prio_mask && !chan->ho_release_pending;=0A=
+=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_HO_CTRL,=
=0A=
+				   val | BIT(SIT9531X_PLL_HO_FORCE_BIT));=0A=
+	if (rc)=0A=
+		goto release;=0A=
+=0A=
+	usleep_range(10000, 12000);=0A=
+=0A=
+	for (slot =3D 0; slot + 1 < SIT9531X_PRIO_MAX_SLOTS; slot +=3D 2) {=0A=
+		reg =3D sit9531x_prio_reg(pll_idx, slot);=0A=
+=0A=
+		val =3D sit9531x_prio_slot_set(0, slot, srcs[slot]);=0A=
+		val =3D sit9531x_prio_slot_set(val, slot + 1, srcs[slot + 1]);=0A=
+=0A=
+		written =3D slot + 2;=0A=
+		rc =3D sit9531x_write_u8(sitdev, reg, val);=0A=
+		if (rc)=0A=
+			goto rollback;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * The last register holds slot 10 in [7:4] and the device's active=0A=
+	 * selection in [3:0], addressed as the slot past the last.=0A=
+	 */=0A=
+	reg =3D sit9531x_prio_reg(pll_idx, slot);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, reg, &last_old);=0A=
+	if (rc)=0A=
+		goto rollback;=0A=
+=0A=
+	val =3D sit9531x_prio_slot_set(last_old, slot, srcs[slot]);=0A=
+=0A=
+	if (!empty) {=0A=
+		u8 sel =3D sit9531x_prio_slot_get(val, slot + 1);=0A=
+=0A=
+		rc =3D sit9531x_input_mon_fetch(sitdev);=0A=
+		if (rc)=0A=
+			goto rollback;=0A=
+		sel =3D sit9531x_prio_activesel_pick(sitdev, chan->prio_srcs,=0A=
+						   srcs, sel);=0A=
+		val =3D sit9531x_prio_slot_set(val, slot + 1, sel);=0A=
+	}=0A=
+=0A=
+	written =3D SIT9531X_PRIO_MAX_SLOTS;=0A=
+	rc =3D sit9531x_write_u8(sitdev, reg, val);=0A=
+	if (rc)=0A=
+		goto rollback;=0A=
+=0A=
+rollback:=0A=
+	if (rc && written) {=0A=
+		for (slot =3D 0; slot < written; slot +=3D 2) {=0A=
+			const u8 *prev =3D &chan->prio_srcs[slot];=0A=
+			u8 old;=0A=
+=0A=
+			if (slot + 1 < SIT9531X_PRIO_MAX_SLOTS) {=0A=
+				old =3D sit9531x_prio_slot_set(0, slot, prev[0]);=0A=
+				old =3D sit9531x_prio_slot_set(old, slot + 1,=0A=
+							     prev[1]);=0A=
+			} else {=0A=
+				old =3D last_old;=0A=
+			}=0A=
+			if (sit9531x_write_u8(sitdev,=0A=
+					      sit9531x_prio_reg(pll_idx, slot),=0A=
+					      old))=0A=
+				break;=0A=
+=0A=
+			restored =3D slot + 2;=0A=
+		}=0A=
+		pending =3D restored < written;=0A=
+		written =3D restored;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Latch unconditionally: the PLL uses the register contents only after=
=0A=
+	 * a latch.=0A=
+	 */=0A=
+	prg_rc =3D sit9531x_prio_prg_commit(sitdev);=0A=
+	if (prg_rc && !rc) {=0A=
+		pending =3D true;=0A=
+		rc =3D prg_rc;=0A=
+	}=0A=
+=0A=
+	if (!rc) {=0A=
+		sit9531x_prio_mask_build(sitdev, pll_idx, srcs);=0A=
+		memcpy(chan->seen_srcs, srcs, sizeof(chan->seen_srcs));=0A=
+		chan->seen_valid =3D true;=0A=
+		chan->table_pending =3D false;=0A=
+	} else if (pending || pending_before) {=0A=
+		sit9531x_prio_mask_build(sitdev, pll_idx, back);=0A=
+		memcpy(chan->table_back, back, sizeof(chan->table_back));=0A=
+		chan->table_pending =3D true;=0A=
+	} else if (!sit9531x_prio_table_read(sitdev, pll_idx, now)) {=0A=
+		sit9531x_prio_mask_build(sitdev, pll_idx, now);=0A=
+		memcpy(chan->seen_srcs, now, sizeof(chan->seen_srcs));=0A=
+		chan->seen_valid =3D true;=0A=
 	}=0A=
 =0A=
-	sitdev->chan[pll_idx].prio_mask =3D mask;=0A=
+release:=0A=
+	/*=0A=
+	 * An empty table keeps the forced holdover; the PLL uses the source in=
=0A=
+	 * the selection nibble, which still names the old one.=0A=
+	 */=0A=
+	if (!chan->prio_mask) {=0A=
+		dev_dbg(sitdev->dev,=0A=
+			"PLL%c: no source listed, holdover kept\n",=0A=
+			'A' + pll_idx);=0A=
+		chan->ho_release_pending =3D false;=0A=
+		goto out;=0A=
+	}=0A=
+=0A=
+	if (ho_foreign) {=0A=
+		dev_dbg(sitdev->dev,=0A=
+			"PLL%c: holdover was forced before the write, left in place\n",=0A=
+			'A' + pll_idx);=0A=
+		goto out;=0A=
+	}=0A=
+=0A=
+	if (chan->table_pending) {=0A=
+		dev_dbg(sitdev->dev,=0A=
+			"PLL%c: priority table restore pending, holdover kept\n",=0A=
+			'A' + pll_idx);=0A=
+		chan->ho_release_pending =3D true;=0A=
+		goto out;=0A=
+	}=0A=
+=0A=
+	for (attempt =3D 0; attempt < SIT9531X_HO_CLEAR_TRIES; attempt++) {=0A=
+		ho_rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+					       SIT9531X_PLL_REG_HO_CTRL,=0A=
+					       BIT(SIT9531X_PLL_HO_FORCE_BIT),=0A=
+					       0);=0A=
+		if (!ho_rc)=0A=
+			break;=0A=
+		usleep_range(1000, 2000);=0A=
+	}=0A=
+	if (ho_rc) {=0A=
+		dev_err(sitdev->dev, "PLL%c left in forced holdover: %d\n",=0A=
+			'A' + pll_idx, ho_rc);=0A=
+		if (!rc)=0A=
+			rc =3D ho_rc;=0A=
+	}=0A=
+	chan->ho_release_pending =3D !!ho_rc;=0A=
+=0A=
+out:=0A=
+	/* The core reads the pin getters as soon as the setter returns. */=0A=
+	if (sit9531x_chan_state_fetch(sitdev, pll_idx))=0A=
+		chan->stale =3D true;=0A=
+=0A=
+	return rc;=0A=
 }=0A=
 =0A=
 /* Caller must hold sitdev->multiop_lock. */=0A=
@@ -416,6 +961,128 @@ static int sit9531x_prio_table_read(struct sit9531x_d=
ev *sitdev, u8 pll_idx,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Rewrite a PLL's table for a new member set; skip an unchanged table, si=
nce=0A=
+ * each write forces holdover.=0A=
+ */=0A=
+static int sit9531x_prio_table_apply(struct sit9531x_dev *sitdev, u8 pll_i=
dx,=0A=
+				     u16 members)=0A=
+{=0A=
+	u8 srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
+=0A=
+	if (hweight16(members) > SIT9531X_PRIO_MAX_SLOTS)=0A=
+		return -ENOSPC;=0A=
+=0A=
+	sit9531x_prio_table_build(sitdev, pll_idx, members, srcs);=0A=
+	if (!memcmp(srcs, sitdev->chan[pll_idx].prio_srcs, sizeof(srcs)))=0A=
+		return 0;=0A=
+=0A=
+	return sit9531x_prio_table_commit(sitdev, pll_idx, srcs);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Check if the device holds the table the configured priorities give for=
=0A=
+ * @members.=0A=
+ */=0A=
+static bool sit9531x_prio_table_held(struct sit9531x_dev *sitdev, u8 pll_i=
dx,=0A=
+				     u16 members)=0A=
+{=0A=
+	u8 srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
+=0A=
+	sit9531x_prio_table_build(sitdev, pll_idx, members, srcs);=0A=
+=0A=
+	return !memcmp(srcs, sitdev->chan[pll_idx].prio_srcs, sizeof(srcs));=0A=
+}=0A=
+=0A=
+/*=0A=
+ * @input_idx is in hardware encoding (0-11, see sit9531x_input_hw_src()).=
 A=0A=
+ * source not in the table keeps the priority for when it is connected. Ca=
ller=0A=
+ * must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx, u8 prio)=0A=
+{=0A=
+	struct sit9531x_chan *chan;=0A=
+	u16 old_known;=0A=
+	u8 old_prio;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+	input_idx =3D sit9531x_prio_src_canon(sitdev, input_idx);=0A=
+	if (input_idx >=3D SIT9531X_PRIO_NUM_SRC)=0A=
+		return -EINVAL;=0A=
+=0A=
+	chan =3D &sitdev->chan[pll_idx];=0A=
+	old_prio =3D chan->cfg_prio[input_idx];=0A=
+	old_known =3D chan->cfg_known;=0A=
+	chan->cfg_prio[input_idx] =3D prio;=0A=
+	chan->cfg_known |=3D BIT(input_idx);=0A=
+=0A=
+	if (!(chan->prio_mask & BIT(input_idx)))=0A=
+		return 0;=0A=
+=0A=
+	rc =3D sit9531x_prio_table_apply(sitdev, pll_idx, chan->prio_mask);=0A=
+	if (rc && !sit9531x_prio_table_held(sitdev, pll_idx, chan->prio_mask)) {=
=0A=
+		chan->cfg_prio[input_idx] =3D old_prio;=0A=
+		chan->cfg_known =3D old_known;=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Removing the last source leaves an empty table, which keeps the PLL in=
=0A=
+ * holdover. Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_input_prio_remove(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       u8 input_idx)=0A=
+{=0A=
+	struct sit9531x_chan *chan;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+	input_idx =3D sit9531x_prio_src_canon(sitdev, input_idx);=0A=
+	if (input_idx >=3D SIT9531X_PRIO_NUM_SRC)=0A=
+		return -EINVAL;=0A=
+=0A=
+	chan =3D &sitdev->chan[pll_idx];=0A=
+	if (!(chan->prio_mask & BIT(input_idx)))=0A=
+		return 0;=0A=
+=0A=
+	return sit9531x_prio_table_apply(sitdev, pll_idx,=0A=
+					 chan->prio_mask & ~BIT(input_idx));=0A=
+}=0A=
+=0A=
+/*=0A=
+ * A source the PLL never listed gets the priority of the last slot. Calle=
r must=0A=
+ * hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx)=0A=
+{=0A=
+	struct sit9531x_chan *chan;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+	input_idx =3D sit9531x_prio_src_canon(sitdev, input_idx);=0A=
+	if (input_idx >=3D SIT9531X_PRIO_NUM_SRC)=0A=
+		return -EINVAL;=0A=
+=0A=
+	chan =3D &sitdev->chan[pll_idx];=0A=
+	if (chan->prio_mask & BIT(input_idx))=0A=
+		return 0;=0A=
+=0A=
+	return sit9531x_prio_table_apply(sitdev, pll_idx,=0A=
+					 chan->prio_mask | BIT(input_idx));=0A=
+}=0A=
+=0A=
 /* XO doubler register */=0A=
 #define SIT9531X_REG_XO2_GENERIC		SIT9531X_REG(0x00, 0x2D)=0A=
 #define SIT9531X_XO_DOUBLER_ENB_BIT		7   /* inverted: 0 =3D enabled */=0A=
@@ -577,6 +1244,7 @@ static int sit9531x_chan_select_fetch(struct sit9531x_=
dev *sitdev, u8 pll_idx)=0A=
 	if (rc)=0A=
 		return rc;=0A=
 	chan->manual_input =3D false;=0A=
+	chan->manual_ref =3D SIT9531X_REF_INVALID;=0A=
 	if (!(cfg & SIT9531X_PLL_CONFIG1F_MANUAL_SEL))=0A=
 		return 0;=0A=
 =0A=
@@ -597,6 +1265,9 @@ static int sit9531x_chan_select_fetch(struct sit9531x_=
dev *sitdev, u8 pll_idx)=0A=
 	chan->manual_input =3D true;=0A=
 	if (sel & SIT9531X_MAN_IN_SEL_FROM_REG) {=0A=
 		sel =3D FIELD_GET(SIT9531X_MAN_IN_SEL_MASK, sel);=0A=
+		chan->manual_ref =3D=0A=
+			sit9531x_hw_src_input(sit9531x_prio_src_canon(sitdev,=0A=
+								      sel));=0A=
 		dev_info(sitdev->dev,=0A=
 			 "PLL%c: the profile selects its reference from the register, input cod=
e %u; reported as manual\n",=0A=
 			 'A' + pll_idx, sel);=0A=
@@ -609,17 +1280,65 @@ static int sit9531x_chan_select_fetch(struct sit9531=
x_dev *sitdev, u8 pll_idx)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Read the reference the device feeds a PLL from the debug status bus; th=
e=0A=
+ * active selection does not change on a fallback. The caller rules out fr=
ee-run=0A=
+ * first and must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static int sit9531x_chan_routed_ref_read(struct sit9531x_dev *sitdev,=0A=
+					 u8 pll_idx, u8 *ref)=0A=
+{=0A=
+	int rc, lock_rc;=0A=
+	u8 v, i;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_DEBUG,=0A=
+				   SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+				   SIT9531X_PLL_REG_DBG_STATUS_ADDR,=0A=
+				   SIT9531X_DBG_STATUS_ROUTED_SRC);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+=0A=
+	/* The first reads return earlier latches; the last is current. */=0A=
+	for (i =3D 0; i < SIT9531X_DBG_STATUS_READS; i++) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_DBG_STATUS_DATA,=0A=
+					  &v);=0A=
+		if (rc)=0A=
+			goto relock;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Canonicalize like the table entries: a differential pair fed through=
=0A=
+	 * its N-lane code is the P-lane pin.=0A=
+	 */=0A=
+	v =3D sit9531x_prio_src_canon(sitdev, v & SIT9531X_DBG_ROUTED_SRC_MASK);=
=0A=
+	*ref =3D sit9531x_hw_src_input(v);=0A=
+=0A=
+relock:=0A=
+	lock_rc =3D sit9531x_write_pll_close(sitdev, pll_idx,=0A=
+					   SIT9531X_PLL_REG_DEBUG,=0A=
+					   SIT9531X_PLL_DEBUG_LOCK);=0A=
+=0A=
+	return rc ? rc : lock_rc;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Read the PLL's run, lock and holdover state, mode, selection and priori=
ty=0A=
  * table.=0A=
  */=0A=
 static int sit9531x_chan_state_fetch(struct sit9531x_dev *sitdev, u8 pll_i=
dx)=0A=
 {=0A=
-	u8 status, outer_lol, input_sel, inner_lol, ho_freeze, activesel_reg;=0A=
+	u8 status, outer_lol, inner_lol, ho_freeze, pll_status_1;=0A=
 	struct sit9531x_chan *chan =3D &sitdev->chan[pll_idx];=0A=
 	u8 srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
-	u8 pll_status_1;=0A=
-	bool active;=0A=
+	u8 routed =3D SIT9531X_REF_INVALID;=0A=
+	bool active, tracking;=0A=
 	int rc;=0A=
 =0A=
 	/*=0A=
@@ -640,21 +1359,6 @@ static int sit9531x_chan_state_fetch(struct sit9531x_=
dev *sitdev, u8 pll_idx)=0A=
 	if (rc)=0A=
 		return rc;=0A=
 =0A=
-	/*=0A=
-	 * The active selection is CLK_ACTIVESEL_PLL, the low nibble of the last=
=0A=
-	 * register of the PLL's Page 1 priority block. PLL-page 0x29 is a=0A=
-	 * config register.=0A=
-	 */=0A=
-	activesel_reg =3D SIT9531X_PRIO_BASE_REG +=0A=
-			SIT9531X_PRIO_REGS_PER_PLL * pll_idx +=0A=
-			SIT9531X_PRIO_ACTIVESEL_OFF;=0A=
-	rc =3D sit9531x_read_u8(sitdev,=0A=
-			      SIT9531X_REG(SIT9531X_PAGE_PRIOSYS,=0A=
-					   activesel_reg),=0A=
-			      &input_sel);=0A=
-	if (rc)=0A=
-		return rc;=0A=
-=0A=
 	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_PLL_INNER_LOL_STATUS,=0A=
 			      &inner_lol);=0A=
 	if (rc)=0A=
@@ -665,23 +1369,48 @@ static int sit9531x_chan_state_fetch(struct sit9531x=
_dev *sitdev, u8 pll_idx)=0A=
 	if (rc)=0A=
 		return rc;=0A=
 =0A=
+	/*=0A=
+	 * Read the routed reference only while the PLL tracks one; in free-run=
=0A=
+	 * it has none.=0A=
+	 */=0A=
+	tracking =3D active && !(outer_lol & BIT(pll_idx)) &&=0A=
+		   !(status & SIT9531X_PLL_STATUS_OUTER_DIS) &&=0A=
+		   !(ho_freeze & BIT(pll_idx));=0A=
+	if (tracking) {=0A=
+		rc =3D sit9531x_chan_routed_ref_read(sitdev, pll_idx, &routed);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+	}=0A=
+=0A=
 	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_STATUS_1,=
=0A=
 				  &pll_status_1);=0A=
 	if (rc)=0A=
 		return rc;=0A=
 =0A=
-	rc =3D sit9531x_prio_table_read(sitdev, pll_idx, srcs);=0A=
-	if (rc)=0A=
-		return rc;=0A=
+	/* Keep the cached table while its write-back is pending */=0A=
+	if (!chan->table_pending) {=0A=
+		rc =3D sit9531x_prio_table_read(sitdev, pll_idx, srcs);=0A=
+		if (rc)=0A=
+			return rc;=0A=
 =0A=
-	sit9531x_prio_mask_build(sitdev, pll_idx, srcs);=0A=
+		sit9531x_prio_mask_build(sitdev, pll_idx, srcs);=0A=
+=0A=
+		/*=0A=
+		 * A table that differs from the last one written was changed=0A=
+		 * outside the driver; take it as the configuration.=0A=
+		 */=0A=
+		if (!chan->seen_valid ||=0A=
+		    memcmp(srcs, chan->seen_srcs, sizeof(chan->seen_srcs)))=0A=
+			sit9531x_prio_cfg_seed(sitdev, pll_idx, srcs);=0A=
+	}=0A=
 =0A=
 	/* STATUS_1_GENERIC reports loss of lock, so invert it. */=0A=
 	chan->active =3D active;=0A=
 	chan->locked =3D active && !(outer_lol & BIT(pll_idx));=0A=
 	chan->mode =3D !!(status & SIT9531X_PLL_STATUS_OUTER_DIS);=0A=
-	chan->selected_ref =3D=0A=
-		sit9531x_hw_src_input(input_sel & SIT9531X_PRIO_NIBBLE_MASK);=0A=
+	chan->routed_ref =3D routed;=0A=
+	if (chan->manual_input && routed !=3D SIT9531X_REF_INVALID)=0A=
+		chan->manual_ref =3D routed;=0A=
 	chan->inner_lol =3D !!(inner_lol & BIT(pll_idx));=0A=
 	chan->ho_freeze =3D !!(ho_freeze & BIT(pll_idx));=0A=
 	chan->ho_valid =3D !!(pll_status_1 & SIT9531X_PLL_STATUS_1_HO_VALID);=0A=
@@ -792,11 +1521,39 @@ static int sit9531x_ref_pll_mask_fetch(struct sit953=
1x_dev *sitdev)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Mark the input each manual-select PLL uses; its table need not list it.=
=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static void sit9531x_manual_claims_add(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	const struct sit9531x_chan *chan;=0A=
+	u8 pll_idx;=0A=
+=0A=
+	for (pll_idx =3D 0; pll_idx < SIT9531X_NUM_PLLS; pll_idx++) {=0A=
+		chan =3D &sitdev->chan[pll_idx];=0A=
+		if (chan->manual_input &&=0A=
+		    chan->manual_ref < sitdev->info->num_inputs)=0A=
+			sitdev->ref[chan->manual_ref].pll_mask |=3D BIT(pll_idx);=0A=
+	}=0A=
+}=0A=
+=0A=
+/* Arm the one-shot re-select of every PLL; see sit9531x_reselect(). */=0A=
+static void sit9531x_reselect_arm(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	u8 i;=0A=
+=0A=
+	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++)=0A=
+		sitdev->chan[i].reselect_armed =3D true;=0A=
+}=0A=
+=0A=
 static int sit9531x_dev_state_fetch(struct sit9531x_dev *sitdev)=0A=
 {=0A=
 	int rc;=0A=
 	u8 i;=0A=
 =0A=
+	sit9531x_reselect_arm(sitdev);=0A=
+=0A=
 	/* Detect SE/DE configuration before any per-lane access */=0A=
 	for (i =3D 0; i < sitdev->info->num_inputs / 2; i++) {=0A=
 		rc =3D sit9531x_input_mode_fetch(sitdev, i);=0A=
@@ -816,6 +1573,13 @@ static int sit9531x_dev_state_fetch(struct sit9531x_d=
ev *sitdev)=0A=
 		}=0A=
 	}=0A=
 =0A=
+	rc =3D sit9531x_input_mon_fetch(sitdev);=0A=
+	if (rc) {=0A=
+		dev_err(sitdev->dev,=0A=
+			"Failed to read the input clock monitors: %d\n", rc);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
 	mutex_lock(&sitdev->multiop_lock);=0A=
 	rc =3D sit9531x_ref_pll_mask_fetch(sitdev);=0A=
 	mutex_unlock(&sitdev->multiop_lock);=0A=
@@ -851,34 +1615,211 @@ static int sit9531x_dev_state_fetch(struct sit9531x=
_dev *sitdev)=0A=
 		return rc;=0A=
 	}=0A=
 =0A=
+	/* Needs the select registers and samples read above */=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	sit9531x_manual_claims_add(sitdev);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
 	return 0;=0A=
 }=0A=
 =0A=
-static void sit9531x_dev_ref_states_update(struct sit9531x_dev *sitdev)=0A=
+/*=0A=
+ * Read each receiver's enable and every lane's clock monitor; return true=
 if=0A=
+ * any read succeeds.=0A=
+ */=0A=
+static bool=0A=
+sit9531x_dev_ref_states_update(struct sit9531x_dev *sitdev)=0A=
 {=0A=
+	bool answered =3D false;=0A=
 	int i, rc;=0A=
 =0A=
 	for (i =3D 0; i < sitdev->info->num_inputs; i++) {=0A=
 		rc =3D sit9531x_ref_state_fetch(sitdev, i);=0A=
 		if (rc)=0A=
-			dev_warn(sitdev->dev,=0A=
-				 "Failed to get REF%u status: %d\n", i, rc);=0A=
+			dev_warn_ratelimited(sitdev->dev,=0A=
+					     "Failed to get REF%u status: %d\n",=0A=
+					     i, rc);=0A=
+		else=0A=
+			answered =3D true;=0A=
 	}=0A=
+=0A=
+	rc =3D sit9531x_input_mon_fetch(sitdev);=0A=
+	if (rc)=0A=
+		dev_warn_ratelimited(sitdev->dev,=0A=
+				     "Failed to read the input clock monitors: %d\n",=0A=
+				     rc);=0A=
+	else=0A=
+		answered =3D true;=0A=
+=0A=
+	return answered;=0A=
 }=0A=
 =0A=
-static void sit9531x_dev_chan_states_update(struct sit9531x_dev *sitdev)=
=0A=
+/*=0A=
+ * Retry turning off a receiver unless a PLL has claimed the input since. =
Caller=0A=
+ * must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static void sit9531x_input_off_retry(struct sit9531x_dev *sitdev)=0A=
 {=0A=
+	u8 i;=0A=
+=0A=
+	for (i =3D 0; i < sitdev->info->num_inputs; i++) {=0A=
+		struct sit9531x_ref *ref =3D &sitdev->ref[i];=0A=
+=0A=
+		if (!ref->off_pending)=0A=
+			continue;=0A=
+		if (ref->pll_mask)=0A=
+			ref->off_pending =3D false;=0A=
+		else=0A=
+			sit9531x_input_disable(sitdev, i);=0A=
+	}=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Rebuild pll_mask from the cached priority tables and the manual-select=
=0A=
+ * inputs. Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static void sit9531x_ref_pll_mask_rebuild(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	u8 pll_idx, src, index;=0A=
+=0A=
+	for (index =3D 0; index < sitdev->info->num_inputs; index++)=0A=
+		sitdev->ref[index].pll_mask =3D 0;=0A=
+=0A=
+	for (pll_idx =3D 0; pll_idx < SIT9531X_NUM_PLLS; pll_idx++) {=0A=
+		u16 mask =3D sitdev->chan[pll_idx].prio_mask;=0A=
+=0A=
+		for (src =3D 0; src < SIT9531X_PRIO_NUM_SRC; src++) {=0A=
+			if (!(mask & BIT(src)))=0A=
+				continue;=0A=
+=0A=
+			index =3D sit9531x_hw_src_input(src);=0A=
+			if (index < sitdev->info->num_inputs)=0A=
+				sitdev->ref[index].pll_mask |=3D BIT(pll_idx);=0A=
+		}=0A=
+	}=0A=
+=0A=
+	sit9531x_manual_claims_add(sitdev);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Retry a pending forced-holdover release; a pending table write-back rel=
eases=0A=
+ * it instead. Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static void sit9531x_ho_release_retry(struct sit9531x_dev *sitdev, u8 pll_=
idx)=0A=
+{=0A=
+	struct sit9531x_chan *chan =3D &sitdev->chan[pll_idx];=0A=
+=0A=
+	if (!chan->ho_release_pending || chan->table_pending)=0A=
+		return;=0A=
+=0A=
+	if (sit9531x_update_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_HO_CTRL,=0A=
+				   BIT(SIT9531X_PLL_HO_FORCE_BIT), 0))=0A=
+		return;=0A=
+=0A=
+	chan->ho_release_pending =3D false;=0A=
+	dev_info(sitdev->dev, "PLL%c: forced holdover released\n",=0A=
+		 'A' + pll_idx);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Write back the priority table after a failed write. Caller must hold=0A=
+ * sitdev->multiop_lock.=0A=
+ */=0A=
+static void sit9531x_table_back_retry(struct sit9531x_dev *sitdev, u8 pll_=
idx)=0A=
+{=0A=
+	u8 back[SIT9531X_PRIO_MAX_SLOTS];=0A=
+=0A=
+	if (!sitdev->chan[pll_idx].table_pending)=0A=
+		return;=0A=
+=0A=
+	memcpy(back, sitdev->chan[pll_idx].table_back, sizeof(back));=0A=
+	if (sit9531x_prio_table_commit(sitdev, pll_idx, back))=0A=
+		return;=0A=
+=0A=
+	dev_info(sitdev->dev, "PLL%c: priority table written back\n",=0A=
+		 'A' + pll_idx);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Rewrite the priority table when a listed source returns to a PLL withou=
t a=0A=
+ * reference; the latch restarts acquisition. Caller must hold=0A=
+ * sitdev->multiop_lock.=0A=
+ */=0A=
+static void sit9531x_reselect(struct sit9531x_dev *sitdev, u8 pll_idx)=0A=
+{=0A=
+	struct sit9531x_chan *chan =3D &sitdev->chan[pll_idx];=0A=
+	u8 top;=0A=
+	int rc;=0A=
+=0A=
+	/* A PLL on manual input select uses no priority table */=0A=
+	if (chan->manual_input || !chan->prio_mask || chan->mode ||=0A=
+	    chan->ho_release_pending || chan->table_pending)=0A=
+		return;=0A=
+=0A=
+	top =3D sit9531x_prio_top_live(sitdev, chan->prio_srcs);=0A=
+	if (chan->reselect_armed) {=0A=
+		if (top =3D=3D SIT9531X_PRIO_SRC_NONE || !chan->ho_freeze) {=0A=
+			chan->reselect_armed =3D false;=0A=
+			chan->live_top =3D top;=0A=
+			return;=0A=
+		}=0A=
+	} else {=0A=
+		if (top =3D=3D chan->live_top)=0A=
+			return;=0A=
+		/*=0A=
+		 * Tracking is locked and not frozen; the two bits are read=0A=
+		 * independently.=0A=
+		 */=0A=
+		if (top =3D=3D SIT9531X_PRIO_SRC_NONE ||=0A=
+		    (chan->locked && !chan->ho_freeze)) {=0A=
+			chan->live_top =3D top;=0A=
+			return;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	rc =3D sit9531x_prio_table_commit(sitdev, pll_idx, chan->prio_srcs);=0A=
+	if (rc) {=0A=
+		dev_warn_ratelimited(sitdev->dev,=0A=
+				     "PLL%c: failed to re-select a returned source: %d\n",=0A=
+				     'A' + pll_idx, rc);=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	chan->reselect_armed =3D false;=0A=
+	chan->live_top =3D top;=0A=
+	dev_info(sitdev->dev, "PLL%c: re-selecting, a source is back\n",=0A=
+		 'A' + pll_idx);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Retry pending writes, then read each PLL's state; return true if any st=
ate=0A=
+ * read succeeds.=0A=
+ */=0A=
+static bool=0A=
+sit9531x_dev_chan_states_update(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	bool answered =3D false;=0A=
 	int i, rc;=0A=
 =0A=
+	sit9531x_input_off_retry(sitdev);=0A=
 	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
+		sit9531x_table_back_retry(sitdev, i);=0A=
+		sit9531x_ho_release_retry(sitdev, i);=0A=
 		rc =3D sit9531x_chan_state_fetch(sitdev, i);=0A=
 		if (rc) {=0A=
 			sitdev->chan[i].stale =3D true;=0A=
-			dev_warn(sitdev->dev,=0A=
-				 "Failed to get PLL%c state: %d\n",=0A=
-				 'A' + i, rc);=0A=
+			dev_warn_ratelimited(sitdev->dev,=0A=
+					     "Failed to get PLL%c state: %d\n",=0A=
+					     'A' + i, rc);=0A=
+			continue;=0A=
 		}=0A=
+		answered =3D true;=0A=
+		sit9531x_reselect(sitdev, i);=0A=
 	}=0A=
+=0A=
+	sit9531x_ref_pll_mask_rebuild(sitdev);=0A=
+=0A=
+	return answered;=0A=
 }=0A=
 =0A=
 static void sit9531x_dev_periodic_work(struct kthread_work *work)=0A=
@@ -886,6 +1827,7 @@ static void sit9531x_dev_periodic_work(struct kthread_=
work *work)=0A=
 	struct sit9531x_dev *sitdev =3D container_of(work, struct sit9531x_dev,=
=0A=
 						   work.work);=0A=
 	struct sit9531x_dpll *sitdpll;=0A=
+	bool answered;=0A=
 	int rc;=0A=
 =0A=
 	/*=0A=
@@ -893,8 +1835,8 @@ static void sit9531x_dev_periodic_work(struct kthread_=
work *work)=0A=
 	 * take DPLL-subsystem locks, which nest outside it.=0A=
 	 */=0A=
 	mutex_lock(&sitdev->multiop_lock);=0A=
-	sit9531x_dev_ref_states_update(sitdev);=0A=
-	sit9531x_dev_chan_states_update(sitdev);=0A=
+	answered =3D sit9531x_dev_ref_states_update(sitdev);=0A=
+	answered |=3D sit9531x_dev_chan_states_update(sitdev);=0A=
 	mutex_unlock(&sitdev->multiop_lock);=0A=
 =0A=
 	list_for_each_entry(sitdpll, &sitdev->dplls, list)=0A=
@@ -912,8 +1854,14 @@ static void sit9531x_dev_periodic_work(struct kthread=
_work *work)=0A=
 				     "Failed to clear notifications: %d\n",=0A=
 				     rc);=0A=
 =0A=
+	if (answered || !rc)=0A=
+		sitdev->poll_fails =3D 0;=0A=
+	else if (sitdev->poll_fails < SIT9531X_POLL_STRETCH_MAX)=0A=
+		sitdev->poll_fails++;=0A=
+=0A=
 	kthread_queue_delayed_work(sitdev->kworker, &sitdev->work,=0A=
-				   msecs_to_jiffies(SIT9531X_STATUS_POLL_MS));=0A=
+				   msecs_to_jiffies(SIT9531X_STATUS_POLL_MS <<=0A=
+						    sitdev->poll_fails));=0A=
 }=0A=
 =0A=
 /* Queue an immediate poll tick; polling continues as a fallback. */=0A=
@@ -1046,6 +1994,63 @@ static void sit9531x_pll_states_report(struct sit953=
1x_dev *sitdev)=0A=
 	}=0A=
 }=0A=
 =0A=
+static bool sit9531x_input_pin_is_registrable(struct sit9531x_dev *sitdev,=
=0A=
+					      u8 index)=0A=
+{=0A=
+	if (index >=3D sitdev->info->num_inputs)=0A=
+		return false;=0A=
+=0A=
+	/* The N lane of a differential pair is not a standalone input. */=0A=
+	if (sit9531x_input_is_n(index) &&=0A=
+	    sitdev->ref[index].sig_mode =3D=3D SIT9531X_MODE_DE)=0A=
+		return false;=0A=
+=0A=
+	return true;=0A=
+}=0A=
+=0A=
+/* Warn about a pin node whose reg names no registrable pin */=0A=
+static void sit9531x_pin_nodes_check(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	struct fwnode_handle *pins, *node;=0A=
+	bool found;=0A=
+	u32 reg;=0A=
+	u8 i;=0A=
+=0A=
+	pins =3D device_get_named_child_node(sitdev->dev, "input-pins");=0A=
+	fwnode_for_each_child_node(pins, node) {=0A=
+		if (fwnode_property_read_u32(node, "reg", &reg))=0A=
+			continue;=0A=
+		if (reg < sitdev->info->num_inputs &&=0A=
+		    sit9531x_input_pin_is_registrable(sitdev, reg))=0A=
+			continue;=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "input-pins/%pfwP: reg %u is %s, node ignored\n",=0A=
+			 node, reg,=0A=
+			 reg < sitdev->info->num_inputs ?=0A=
+			 "the N lane of a differential pair" :=0A=
+			 "not an input lane");=0A=
+	}=0A=
+	fwnode_handle_put(pins);=0A=
+=0A=
+	pins =3D device_get_named_child_node(sitdev->dev, "output-pins");=0A=
+	fwnode_for_each_child_node(pins, node) {=0A=
+		if (fwnode_property_read_u32(node, "reg", &reg))=0A=
+			continue;=0A=
+		found =3D false;=0A=
+		for (i =3D 0; i < sitdev->info->num_outputs; i++) {=0A=
+			if (sitdev->info->clkout_map[i] =3D=3D reg) {=0A=
+				found =3D true;=0A=
+				break;=0A=
+			}=0A=
+		}=0A=
+		if (!found)=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "output-pins/%pfwP: reg %u is not an output of %s, node ignored\n",=
=0A=
+				 node, reg, sitdev->info->name);=0A=
+	}=0A=
+	fwnode_handle_put(pins);=0A=
+}=0A=
+=0A=
 static int sit9531x_dev_start(struct sit9531x_dev *sitdev)=0A=
 {=0A=
 	struct sit9531x_dpll *sitdpll;=0A=
@@ -1060,6 +2065,8 @@ static int sit9531x_dev_start(struct sit9531x_dev *si=
tdev)=0A=
 	sit9531x_pll_states_report(sitdev);=0A=
 	mutex_unlock(&sitdev->multiop_lock);=0A=
 =0A=
+	sit9531x_pin_nodes_check(sitdev);=0A=
+=0A=
 	list_for_each_entry(sitdpll, &sitdev->dplls, list) {=0A=
 		rc =3D sit9531x_dpll_register(sitdpll);=0A=
 		if (rc) {=0A=
@@ -1084,6 +2091,7 @@ static int sit9531x_dev_start(struct sit9531x_dev *si=
tdev)=0A=
 static void sit9531x_dev_stop(struct sit9531x_dev *sitdev)=0A=
 {=0A=
 	struct sit9531x_dpll *sitdpll;=0A=
+	u8 i;=0A=
 =0A=
 	kthread_cancel_delayed_work_sync(&sitdev->work);=0A=
 =0A=
@@ -1091,6 +2099,30 @@ static void sit9531x_dev_stop(struct sit9531x_dev *s=
itdev)=0A=
 		if (sitdpll->dpll_dev)=0A=
 			sit9531x_dpll_unregister(sitdpll);=0A=
 	}=0A=
+=0A=
+	/*=0A=
+	 * Write back tables first: forced holdover stays set while a table=0A=
+	 * write-back is pending.=0A=
+	 */=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
+		sit9531x_table_back_retry(sitdev, i);=0A=
+		if (sitdev->chan[i].table_pending)=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "PLL%c priority table left as written, holdover kept\n",=0A=
+				 'A' + i);=0A=
+	}=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
+		sit9531x_ho_release_retry(sitdev, i);=0A=
+		if (sitdev->chan[i].ho_release_pending &&=0A=
+		    !sitdev->chan[i].table_pending)=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "PLL%c left in forced holdover\n", 'A' + i);=0A=
+	}=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
 }=0A=
 =0A=
 static struct sit9531x_dpll_pin *=0A=
@@ -1209,10 +2241,15 @@ static bool sit9531x_dpll_pin_is_registrable(struct=
 sit9531x_dpll *sitdpll,=0A=
 					     enum dpll_pin_direction dir,=0A=
 					     u8 index)=0A=
 {=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+=0A=
 	if (dir !=3D DPLL_PIN_DIRECTION_INPUT)=0A=
 		return false;=0A=
 =0A=
-	return index =3D=3D SIT9531X_MAX_INPUTS;=0A=
+	if (index =3D=3D SIT9531X_MAX_INPUTS)=0A=
+		return true;=0A=
+=0A=
+	return sit9531x_input_pin_is_registrable(sitdev, index);=0A=
 }=0A=
 =0A=
 static int sit9531x_dpll_pins_register(struct sit9531x_dpll *sitdpll)=0A=
@@ -1600,6 +2637,9 @@ static int sit9531x_resume(struct device *dev)=0A=
 =0A=
 	/* After power loss the part is on page 0, not the cached page */=0A=
 	sit9531x_page_cache_drop(sitdev);=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	sit9531x_reselect_arm(sitdev);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
 	if (sitdev->irq > 0)=0A=
 		enable_irq(sitdev->irq);=0A=
 	kthread_queue_delayed_work(sitdev->kworker, &sitdev->work, 0);=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 9e873432df3d..c2fa6a17be43 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -41,7 +41,7 @@=0A=
  */=0A=
 #define SIT9531X_POLL_STRETCH_MAX	3=0A=
 =0A=
-/* selected_ref value when the active source is not a registered input */=
=0A=
+/* routed_ref value when the PLL is fed no registered input */=0A=
 #define SIT9531X_REF_INVALID		0xFF=0A=
 =0A=
 /* SiTime IEEE OUI for EUI-64 generation */=0A=
@@ -79,14 +79,20 @@ enum sit9531x_signal_mode {=0A=
  * struct sit9531x_ref - input reference state=0A=
  * @freq: configured frequency in Hz=0A=
  * @enabled: input receiver is on=0A=
+ * @off_pending: receiver gate-off to retry while no PLL claims the input=
=0A=
  * @pll_mask: PLLs this input feeds (bit 0 =3D PLLA)=0A=
+ * @los: clock monitor reports loss of signal=0A=
+ * @qual_fail: clock monitor reports frequency drift while the input has s=
ignal=0A=
  * @sig_mode: signal mode of the input pair, read from CLKINx_INPUT_MODE a=
t=0A=
  *   probe=0A=
  */=0A=
 struct sit9531x_ref {=0A=
 	u64		freq;=0A=
 	bool		enabled;=0A=
+	bool		off_pending;=0A=
 	u8		pll_mask;=0A=
+	bool		los;=0A=
+	bool		qual_fail;=0A=
 	enum sit9531x_signal_mode	sig_mode;=0A=
 };=0A=
 =0A=
@@ -100,6 +106,8 @@ struct sit9531x_ref {=0A=
  * @routed: mapped to @pll_idx by the initial configuration; an unrouted=
=0A=
  *   output has no pin=0A=
  * @pll_idx: PLL driving this output (0-3)=0A=
+ * @retime_pending: re-timed delay not yet applied; the poll applies @reti=
me_ps=0A=
+ * @retime_ps: delay to apply while @retime_pending=0A=
  */=0A=
 struct sit9531x_out {=0A=
 	u64		freq;=0A=
@@ -108,6 +116,8 @@ struct sit9531x_out {=0A=
 	bool		part_muted;=0A=
 	bool		routed;=0A=
 	u8		pll_idx;=0A=
+	bool		retime_pending;=0A=
+	s32		retime_ps;=0A=
 };=0A=
 =0A=
 /*=0A=
@@ -118,14 +128,30 @@ struct sit9531x_out {=0A=
  * @stale: last state read failed; the fields hold the previous sample and=
=0A=
  *   are not reported=0A=
  * @mode: 0 =3D sync (outer loop enabled), 1 =3D free-run=0A=
- * @selected_ref: logical index of the selected reference (INTSYNC:=0A=
- *   SIT9531X_INTSYNC_PIN_ID), or SIT9531X_REF_INVALID for a reserved code=
=0A=
+ * @routed_ref: input the device routes to the PLL, as a logical index=0A=
+ *   (INTSYNC: SIT9531X_INTSYNC_PIN_ID); SIT9531X_REF_INVALID if none=0A=
  * @inner_lol: inner loop loss of lock=0A=
  * @ho_freeze: holdover freeze active=0A=
  * @ho_valid: holdover memory holds a valid estimate=0A=
  * @manual_input: PLL uses its manual input select (pins or=0A=
  *   GPIO_INPUT_FUNC_CTRL5..8), which table writes do not change; reported=
=0A=
  *   as MANUAL=0A=
+ * @manual_ref: logical input of a manual PLL, SIT9531X_REF_INVALID if=0A=
+ *   unknown; its receiver stays claimed for the PLL=0A=
+ * @ho_release_pending: forced holdover not yet released=0A=
+ * @live_top: highest-priority listed source with signal at the last poll,=
=0A=
+ *   or SIT9531X_PRIO_SRC_NONE; a change while the PLL tracks no source=0A=
+ *   rewrites the table=0A=
+ * @reselect_armed: no poll since probe or resume; the first poll rewrites=
=0A=
+ *   the table of a PLL in holdover while a listed source has signal=0A=
+ * @flush_pending: output divider realignment flush not yet triggered afte=
r=0A=
+ *   a rate or delay commit=0A=
+ * @table_pending: priority table partly written or not latched; the PLL=
=0A=
+ *   stays in forced holdover=0A=
+ * @table_back: table reported and to be rewritten while @table_pending=0A=
+ * @tap_pending: debug taps not restored after a phase-offset read=0A=
+ * @prio_srcs: cached priority table, a source code per slot=0A=
+ * @prio_last: first slot of each source plus one, 0 if absent=0A=
  * @prio_mask: bit per canonical source in the priority table read back=0A=
  *   from hardware=0A=
  * @cfg_prio: configured priority of each canonical source, listed or not;=
=0A=
@@ -140,11 +166,21 @@ struct sit9531x_chan {=0A=
 	bool		locked;=0A=
 	bool		stale;=0A=
 	u8		mode;=0A=
-	u8		selected_ref;=0A=
+	u8		routed_ref;=0A=
 	bool		inner_lol;=0A=
 	bool		ho_freeze;=0A=
 	bool		ho_valid;=0A=
 	bool		manual_input;=0A=
+	u8		manual_ref;=0A=
+	bool		ho_release_pending;=0A=
+	u8		live_top;=0A=
+	bool		reselect_armed;=0A=
+	bool		flush_pending;=0A=
+	bool		table_pending;=0A=
+	u8		table_back[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	bool		tap_pending;=0A=
+	u8		prio_srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	u8		prio_last[SIT9531X_PRIO_NUM_SRC];=0A=
 	u16		prio_mask;=0A=
 	u8		cfg_prio[SIT9531X_PRIO_NUM_SRC];=0A=
 	u16		cfg_known;=0A=
@@ -176,6 +212,7 @@ struct sit9531x_chan {=0A=
  * @irq: optional INTRB IRQ, 0 if not wired=0A=
  * @intsync_src: PLL sourcing INTSYNC, or -1=0A=
  * @irq_ack_fails: consecutive failed INTRB acknowledgements=0A=
+ * @loops_open: output loops not yet re-locked=0A=
  */=0A=
 struct sit9531x_dev {=0A=
 	struct device			*dev;=0A=
@@ -206,6 +243,8 @@ struct sit9531x_dev {=0A=
 	int			irq;=0A=
 =0A=
 	s8			intsync_src;=0A=
+=0A=
+	bool			loops_open;=0A=
 };=0A=
 =0A=
 int sit9531x_read_u8(struct sit9531x_dev *sitdev, unsigned int reg,=0A=
@@ -219,6 +258,18 @@ int sit9531x_write_pll_u8(struct sit9531x_dev *sitdev,=
 u8 pll_idx,=0A=
 int sit9531x_update_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
 			   u8 offset, u8 mask, u8 val);=0A=
 =0A=
+int sit9531x_input_disable(struct sit9531x_dev *sitdev, u8 index);=0A=
+int sit9531x_input_enable(struct sit9531x_dev *sitdev, u8 index);=0A=
+=0A=
+bool sit9531x_input_prio_present(struct sit9531x_dev *sitdev,=0A=
+				 u8 pll_idx, u8 input_idx);=0A=
+int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx, u8 prio);=0A=
+int sit9531x_input_prio_remove(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       u8 input_idx);=0A=
+int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx);=0A=
+=0A=
 static inline u8 sit9531x_pll_page(u8 pll_idx)=0A=
 {=0A=
 	return SIT9531X_PAGE_PLLA + pll_idx;=0A=
@@ -287,4 +338,10 @@ sit9531x_chan_state_get(const struct sit9531x_dev *sit=
dev, u8 pll_idx)=0A=
 	return &sitdev->chan[pll_idx];=0A=
 }=0A=
 =0A=
+static inline bool sit9531x_chan_tracking(const struct sit9531x_chan *chan=
)=0A=
+{=0A=
+	return chan->locked && !chan->inner_lol && !chan->mode &&=0A=
+	       !chan->ho_freeze && !chan->stale;=0A=
+}=0A=
+=0A=
 #endif /* _SIT9531X_CORE_H */=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index 6d676fabf13e..56bdec4bcf67 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -34,10 +34,23 @@ sit9531x_dpll_is_xo_pin(const struct sit9531x_dpll_pin =
*pin)=0A=
 	       pin->id =3D=3D SIT9531X_MAX_INPUTS;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * A frozen PLL with an empty table is in forced holdover; report holdover=
 only=0A=
+ * while its holdover memory is valid.=0A=
+ */=0A=
+static enum dpll_lock_status=0A=
+sit9531x_dpll_frozen_status(const struct sit9531x_chan *chan)=0A=
+{=0A=
+	if (!chan->prio_mask && !chan->ho_valid)=0A=
+		return DPLL_LOCK_STATUS_UNLOCKED;=0A=
+=0A=
+	return DPLL_LOCK_STATUS_HOLDOVER;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Report the lock status from the last poll: outer LOL (page 0 reg 0x06),=
 PLL=0A=
- * mode (PLL page reg 0x31), inner LOL (reg 0x92), holdover freeze (reg 0x=
0A)=0A=
- * and holdover-valid (PLL page reg 0x06).=0A=
+ * mode (PLL page reg 0x31), inner LOL (reg 0x92), holdover freeze (reg 0x=
0A),=0A=
+ * holdover-valid (PLL page reg 0x06) and priority table.=0A=
  */=0A=
 static int=0A=
 sit9531x_dpll_lock_status_get(const struct dpll_device *dpll, void *dpll_p=
riv,=0A=
@@ -71,7 +84,7 @@ sit9531x_dpll_lock_status_get(const struct dpll_device *d=
pll, void *dpll_priv,=0A=
 		 * The core reports the error detail only with an unlocked or=0A=
 		 * holdover status.=0A=
 		 */=0A=
-		*status =3D chan->ho_freeze ? DPLL_LOCK_STATUS_HOLDOVER :=0A=
+		*status =3D chan->ho_freeze ? sit9531x_dpll_frozen_status(chan) :=0A=
 					    DPLL_LOCK_STATUS_UNLOCKED;=0A=
 	} else if (chan->mode) {=0A=
 		/*=0A=
@@ -84,8 +97,8 @@ sit9531x_dpll_lock_status_get(const struct dpll_device *d=
pll, void *dpll_priv,=0A=
 		 * Test freeze before lock: a frozen PLL tracks no reference=0A=
 		 * whatever its outer loss-of-lock bit reads.=0A=
 		 */=0A=
-		*status =3D DPLL_LOCK_STATUS_HOLDOVER;=0A=
-	} else if (chan->locked) {=0A=
+		*status =3D sit9531x_dpll_frozen_status(chan);=0A=
+	} else if (sit9531x_chan_tracking(chan)) {=0A=
 		if (chan->ho_valid)=0A=
 			*status =3D DPLL_LOCK_STATUS_LOCKED_HO_ACQ;=0A=
 		else=0A=
@@ -155,6 +168,120 @@ const struct dpll_device_ops sit9531x_dpll_device_ops=
 =3D {=0A=
 	.supported_modes_get	=3D sit9531x_dpll_supported_modes_get,=0A=
 };=0A=
 =0A=
+/*=0A=
+ * Pin-state contract. An input is SELECTABLE while listed in this PLL's=
=0A=
+ * priority table and DISCONNECTED otherwise; CONNECTED is refused because=
 the=0A=
+ * device selects by priority. Operstate is ACTIVE when the device feeds t=
he PLL=0A=
+ * this input (chan->routed_ref), the PLL is tracking and the lane has sig=
nal;=0A=
+ * NO_SIGNAL on loss of signal; QUAL_FAILED on frequency drift; STANDBY=0A=
+ * otherwise. The routed reference is used because on loss of signal the d=
evice=0A=
+ * falls back to another listed source and leaves the selection naming the=
 lost=0A=
+ * one. On manual input select, the routed input is CONNECTED. The XO pin =
is=0A=
+ * always CONNECTED.=0A=
+ */=0A=
+=0A=
+/* Caller must hold sitdev->multiop_lock. */=0A=
+static void=0A=
+sit9531x_dpll_selection_state_get(struct sit9531x_dev *sitdev,=0A=
+				  const struct sit9531x_dpll *sitdpll,=0A=
+				  u8 pin_id, enum dpll_pin_state *state)=0A=
+{=0A=
+	const struct sit9531x_chan *chan;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	chan =3D sit9531x_chan_state_get(sitdev, sitdpll->id);=0A=
+=0A=
+	if (chan->manual_input) {=0A=
+		if (chan->routed_ref =3D=3D pin_id && !chan->stale)=0A=
+			*state =3D DPLL_PIN_STATE_CONNECTED;=0A=
+		else=0A=
+			*state =3D DPLL_PIN_STATE_DISCONNECTED;=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	if (chan->prio_mask & BIT(sit9531x_input_hw_src(pin_id)))=0A=
+		*state =3D DPLL_PIN_STATE_SELECTABLE;=0A=
+	else=0A=
+		*state =3D DPLL_PIN_STATE_DISCONNECTED;=0A=
+}=0A=
+=0A=
+/* Caller must hold sitdev->multiop_lock. */=0A=
+static bool=0A=
+sit9531x_dpll_selection_active(struct sit9531x_dev *sitdev,=0A=
+			       const struct sit9531x_dpll *sitdpll, u8 pin_id)=0A=
+{=0A=
+	const struct sit9531x_chan *chan;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	chan =3D sit9531x_chan_state_get(sitdev, sitdpll->id);=0A=
+=0A=
+	if (chan->routed_ref !=3D pin_id || !sit9531x_chan_tracking(chan))=0A=
+		return false;=0A=
+=0A=
+	/*=0A=
+	 * Do not report a lane without signal as locked, whatever the lock bit=
=0A=
+	 * says; the PLL is about to switch away from it.=0A=
+	 */=0A=
+	if (pin_id < sitdev->info->num_inputs &&=0A=
+	    sit9531x_ref_state_get(sitdev, pin_id)->los)=0A=
+		return false;=0A=
+=0A=
+	return true;=0A=
+}=0A=
+=0A=
+/* Caller must hold sitdev->multiop_lock. */=0A=
+static void=0A=
+sit9531x_dpll_selection_operstate_get(struct sit9531x_dev *sitdev,=0A=
+				      const struct sit9531x_dpll *sitdpll,=0A=
+				      u8 pin_id,=0A=
+				      enum dpll_pin_operstate *operstate)=0A=
+{=0A=
+	const struct sit9531x_ref *ref;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (sit9531x_dpll_selection_active(sitdev, sitdpll, pin_id)) {=0A=
+		*operstate =3D DPLL_PIN_OPERSTATE_ACTIVE;=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	if (pin_id < sitdev->info->num_inputs) {=0A=
+		ref =3D sit9531x_ref_state_get(sitdev, pin_id);=0A=
+		if (ref->los) {=0A=
+			*operstate =3D DPLL_PIN_OPERSTATE_NO_SIGNAL;=0A=
+			return;=0A=
+		}=0A=
+		if (ref->qual_fail) {=0A=
+			*operstate =3D DPLL_PIN_OPERSTATE_QUAL_FAILED;=0A=
+			return;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	*operstate =3D DPLL_PIN_OPERSTATE_STANDBY;=0A=
+}=0A=
+=0A=
+static int=0A=
+sit9531x_dpll_input_pin_operstate_on_dpll_get(const struct dpll_pin *pin,=
=0A=
+					      void *pin_priv,=0A=
+					      const struct dpll_device *dpll,=0A=
+					      void *dpll_priv,=0A=
+					      enum dpll_pin_operstate *state,=0A=
+					      struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	sit9531x_dpll_selection_operstate_get(sitdev, sitdpll, dpin->id,=0A=
+					      state);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static int=0A=
 sit9531x_dpll_input_pin_direction_get(const struct dpll_pin *pin,=0A=
 				      void *pin_priv,=0A=
@@ -167,8 +294,123 @@ sit9531x_dpll_input_pin_direction_get(const struct dp=
ll_pin *pin,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
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
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	sit9531x_dpll_selection_state_get(sitdev, sitdpll, dpin->id, state);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The input receiver is shared by all DPLLs and is switched off when=0A=
+ * ref->pll_mask becomes empty.=0A=
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
+	bool enabled_here =3D false;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	switch (state) {=0A=
+	case DPLL_PIN_STATE_DISCONNECTED:=0A=
+		if (!sit9531x_input_prio_present(sitdev, sitdpll->id, hw_src) &&=0A=
+		    !ref->off_pending) {=0A=
+			rc =3D 0;=0A=
+			break;=0A=
+		}=0A=
+		rc =3D sit9531x_input_prio_remove(sitdev, sitdpll->id, hw_src);=0A=
+		if (rc && sit9531x_input_prio_present(sitdev, sitdpll->id,=0A=
+						      hw_src))=0A=
+			break;=0A=
+		ref->pll_mask &=3D ~pll_bit;=0A=
+		if (!ref->pll_mask) {=0A=
+			int off_rc =3D sit9531x_input_disable(sitdev, dpin->id);=0A=
+=0A=
+			if (off_rc && !rc)=0A=
+				rc =3D off_rc;=0A=
+		}=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_CONNECTED:=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Device selects its reference by priority; use selectable");=0A=
+		rc =3D -EOPNOTSUPP;=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_SELECTABLE:=0A=
+		/*=0A=
+		 * The receiver can be off even when this PLL already lists the=0A=
+		 * input.=0A=
+		 */=0A=
+		if (!ref->enabled) {=0A=
+			rc =3D sit9531x_input_enable(sitdev, dpin->id);=0A=
+			if (rc)=0A=
+				break;=0A=
+			enabled_here =3D true;=0A=
+		}=0A=
+		rc =3D sit9531x_input_prio_add(sitdev, sitdpll->id, hw_src);=0A=
+		if (rc && !sit9531x_input_prio_present(sitdev, sitdpll->id,=0A=
+						       hw_src)) {=0A=
+			if (enabled_here && !ref->pll_mask)=0A=
+				sit9531x_input_disable(sitdev, dpin->id);=0A=
+			break;=0A=
+		}=0A=
+		ref->pll_mask |=3D pll_bit;=0A=
+		break;=0A=
+	default:=0A=
+		rc =3D -EINVAL;=0A=
+		break;=0A=
+	}=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc =3D=3D -ENOSPC)=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Priority table is full of unique sources on this PLL");=0A=
+	else if (rc && rc !=3D -EOPNOTSUPP && rc !=3D -EINVAL)=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set input pin state");=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_input_pin_state_on_dpll_get,=0A=
+	.state_on_dpll_set	=3D sit9531x_dpll_input_pin_state_on_dpll_set,=0A=
+	.operstate_on_dpll_get	=3D sit9531x_dpll_input_pin_operstate_on_dpll_get,=
=0A=
+};=0A=
+=0A=
+/*=0A=
+ * For a PLL on manual input select: the select pins or register choose th=
e=0A=
+ * reference, so the pin has no state setter and no priority.=0A=
+ */=0A=
+static const struct dpll_pin_ops sit9531x_dpll_input_pin_manual_ops =3D {=
=0A=
+	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_input_pin_state_on_dpll_get,=0A=
+	.operstate_on_dpll_get	=3D sit9531x_dpll_input_pin_operstate_on_dpll_get,=
=0A=
 };=0A=
 =0A=
 /*=0A=
@@ -223,10 +465,15 @@ static const struct dpll_pin_ops sit9531x_dpll_output=
_pin_ops =3D {=0A=
 const struct dpll_pin_ops *=0A=
 sit9531x_dpll_pin_ops_get(const struct sit9531x_dpll_pin *pin)=0A=
 {=0A=
+	const struct sit9531x_dev *sitdev =3D pin->dpll->dev;=0A=
+=0A=
 	if (!sit9531x_dpll_is_input_pin(pin))=0A=
 		return &sit9531x_dpll_output_pin_ops;=0A=
 	if (sit9531x_dpll_is_xo_pin(pin))=0A=
 		return &sit9531x_dpll_xo_pin_ops;=0A=
+	/* Read once at probe, before any pin is registered. */=0A=
+	if (sit9531x_chan_state_get(sitdev, pin->dpll->id)->manual_input)=0A=
+		return &sit9531x_dpll_input_pin_manual_ops;=0A=
 	return &sit9531x_dpll_input_pin_ops;=0A=
 }=0A=
 =0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index 832d0360a398..39d836f6b563 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -96,6 +96,10 @@=0A=
 #define SIT9531X_REG_GLOBAL_UPDATE		SIT9531X_REG(0x00, 0x0F)=0A=
 #define SIT9531X_SMALL_UPDATE_CMD		0x02=0A=
 =0A=
+/* PLL holdover control (PLL page offset) */=0A=
+#define SIT9531X_PLL_REG_HO_CTRL		0x6F=0A=
+#define SIT9531X_PLL_HO_FORCE_BIT		4=0A=
+=0A=
 /* One bit per input PAIR (bit 0 =3D CLKIN0, ..., bit 3 =3D CLKIN3) */=0A=
 #define SIT9531X_REG_IN_DE_FORCE		SIT9531X_REG(0x02, 0xE8)=0A=
 #define SIT9531X_REG_IN_DE_STATE		SIT9531X_REG(0x02, 0xE9)=0A=
@@ -183,6 +187,29 @@=0A=
 =0A=
 #define SIT9531X_PLL_STATUS_OUTER_DIS	BIT(5)=0A=
 =0A=
+/*=0A=
+ * Writing the key unlocks the page's debug registers; writing zero locks =
them.=0A=
+ */=0A=
+#define SIT9531X_PLL_REG_DEBUG		0xBD=0A=
+#define SIT9531X_PLL_DEBUG_UNLOCK		0xC3=0A=
+#define SIT9531X_PLL_DEBUG_LOCK			0x00=0A=
+=0A=
+/*=0A=
+ * The address register selects the block the data register reports. A dat=
a read=0A=
+ * returns what the previous read latched; the documented procedures read =
it=0A=
+ * three times.=0A=
+ */=0A=
+#define SIT9531X_PLL_REG_DBG_STATUS_ADDR	0xD1=0A=
+#define SIT9531X_PLL_REG_DBG_STATUS_DATA	0xD0=0A=
+#define SIT9531X_DBG_STATUS_READS		3=0A=
+=0A=
+/*=0A=
+ * Low nibble: the source the input subsystem routes to the PLL, in the=0A=
+ * priority-table encoding.=0A=
+ */=0A=
+#define SIT9531X_DBG_STATUS_ROUTED_SRC	0xB0=0A=
+#define SIT9531X_DBG_ROUTED_SRC_MASK		GENMASK(3, 0)=0A=
+=0A=
 /*=0A=
  * PLL_CONFIG1F_PLL bit 6: manual active select, no priority arbitration. =
The=0A=
  * register is GUI generated; the driver only reads it.=0A=
@@ -213,6 +240,17 @@=0A=
 #define SIT9531X_PLL_REG_STATUS_1		0x06=0A=
 #define SIT9531X_PLL_STATUS_1_HO_VALID	BIT(2)=0A=
 =0A=
+/*=0A=
+ * Clock monitor status, one nibble per input lane; the lower-numbered inp=
ut of=0A=
+ * each register is in the low nibble.=0A=
+ */=0A=
+#define SIT9531X_CLKMON_P_STATUS_01		SIT9531X_REG(0x06, 0x02)=0A=
+#define SIT9531X_CLKMON_P_STATUS_23		SIT9531X_REG(0x06, 0x06)=0A=
+#define SIT9531X_CLKMON_N_STATUS_01		SIT9531X_REG(0x06, 0x92)=0A=
+#define SIT9531X_CLKMON_N_STATUS_23		SIT9531X_REG(0x06, 0x96)=0A=
+#define SIT9531X_CLKMON_FINE_DRIFT		BIT(0)=0A=
+#define SIT9531X_CLKMON_COARSE_DRIFT		BIT(1)=0A=
+#define SIT9531X_CLKMON_LOSS			BIT(2)=0A=
 #define SIT9531X_CLKMON_P_NOTIF_01		SIT9531X_REG(0x06, 0x03)=0A=
 #define SIT9531X_CLKMON_P_NOTIF_23		SIT9531X_REG(0x06, 0x07)=0A=
 =0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
