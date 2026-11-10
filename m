Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.129.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794342415;
	b=xcELx4SD13GrWSijR4DXWGGdoWK9VvVHVGrEbhIEgzq1pa/S871sSNadkTBgtJv+h1Ex
	 Si24DmH66BuK7zH8rU1vlIYOot+H64EyMk3o2sHzSepDPStq/dqTXBXaT7wVA1auAr6BV
	 Qfb4MYILqCbBPCKVUrAIdgo7MT6PCF1pday4OAxCG9NgC8H4eHZixnXNqvmq1v5Lm/Sfp
	 5wkLyymE5w9eTQQe3zutjCkh6taESQ6IkfU3+MVCMXm+5LXAhXnRRe6aub/LlCUFIWizZ
	 rbCg1ADHRWU2U98PVxLPU6rddMCq/2n9YDRDCPkFHi3sNjHKC34rJuBIAl3J0+ZH1DA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342415;
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
	bh=CQtp5ORrskeIzjoXXVQPhKBQrlLtaAa5Mdc+PcohrK4=;
	b=nWE5GSWgUV+KI+Y2hMJGuxkvYom5mV/Pd0OPGXlMLzxyAAZOn5U5pWcYcx2OTOPnc97W
	 cGiHhHk2QHwRCNvOpFD7FRc0X/N2TzVo5To+Eh7KlAOWD/c0Rfsv8Hvoq51DaqYKkHMfe
	 pLM82UxrcqsX1nJovzAGK0yiDDMBg7lldYLprwCzUBoCDNu2bI6cnJ2A9x8a/KuFtvLAm
	 /T5j2an+7y0pDKN/K1W/qSXyuQlqj4MN4aZa10jsnrEJX3PH6/0ALxaFmksPttD/KvZTs
	 Jyf48ENDvGzIiQ6akY1l1PDX5U7HYePMRzESjnDXiv28dkXQB7VhjM6KPHJbEUlyhXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sitime.com;
	spf=pass smtp.mailfrom=sitime.com;
	dkim=pass header.d=sitime.com header.i=@sitime.com header.a=rsa-sha256 header.s=mail header.b="PuwK67K/";
	dkim=pass header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-Sitime-onmicrosoft-com header.b="n0hYTD/+";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.129.49
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4F6606AD6B;
	Tue, 10 Nov 2026 20:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B4F6606AD6B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.a=rsa-sha256 header.s=mail header.b=PuwK67K/;
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-Sitime-onmicrosoft-com header.b=n0hYTD/+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=CQtp5ORrskeIzjoXXVQPhKBQrlLtaAa5Mdc+PcohrK4=;
 b=PuwK67K/kM845H+ngwaDPy8l1TWbubvvvVrYQ2c1Xpum+t3tFgPu/iIQq2o9ZpV43j4FfexrvtYoSqdSCCqH6TbJMrAud46KN1vxUrPgrTGbq5oGFvvqbUI2SgY4a3E03jZ2MkqkJT5MeEcWTou+M/VA2Z9Paduqp59rf+EXm5E79zxTED1s/+Xqeh+AN8jkGdhdjMNlQ5OcbIVcO4INcnmpSVH7NzfroV0W6SOdSCW22FzqQw39uL4hIJbIsgy0ubWyVoy8uuKwATwcJm5j57k8YCakb80mrOUcy+7ClQgoUyzBFrPw92iDTvQwqjm5gCOhnhTVmQTBklFTLFxzNw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020092.outbound.protection.outlook.com [40.93.198.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id E9613280064;
	Tue, 10 Nov 2026 20:26:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEDRvKhe6wPrm8UT9FjTvSQiPMHiY6GLnWxqx/aTbOHTfBKc5cTt//dnDk61mNySqWegUm4erdMYtTDr4zu1gVW1FUHHrb558JdBJRPlLy8KdtbNT78g/sx5OE6e48UR26W3AaqKrxBsLOKzNHMtRBotg8DbyGnHvwygooyioHyJc0Bzq9WlXBW/19oaDF22ZoXCgw8YaSI5gQtt2CFFDJPNplt8r6yyb9WgkdcufaaoIEw78jekMQWRpUTRHL7EbPZrXPibltpCS1McsJ8rPfJopj1G3kP1X2hGAZYuBOryuQTNIBsVNciIEm+9p+hfgv66EwGQj5+HwGxkXhsaFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQtp5ORrskeIzjoXXVQPhKBQrlLtaAa5Mdc+PcohrK4=;
 b=vv31nv+1PJV4Fv8ZDM2uxPsCoREdMRLUwpkHExZ4ryTKoZst2FC4H7A1deSZL7OIVJiuKtOIhytEL8WVORNdTq6hPB9aVU9fJ0hYj2DBk8oZozfyWtoOCbMU/QeH5mMQcOGnSkViu+i8oovpMA2zimTKhzw0vH6qYUz7CPMBZr77lvYRwVaV0vS4RMaVHpDD9SNkbs5W8L9ceP+99beQYyVvp0UOVeMwbwLbQk1rqxOLbWa/GJi3wfipAGkiZn6E5yb6u47KV9oFsu28DNK64HKBsMqE+eRiDzFkaesXAkh/x+qbmKtiIBuYY6o7QqCII6b4gVtnx/IWjsDJ/LRRtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQtp5ORrskeIzjoXXVQPhKBQrlLtaAa5Mdc+PcohrK4=;
 b=n0hYTD/+Hby5T1PJwY2Ycde5PzXOOEmfUbrcKCz75lnX+rsBqKzqiFgBRS2VFGDb5saxMsYGYf4i20oYZY48cWWKQGf7ouQ+ibaL9GJOkT2fJzVBCN+zLRxByfMj7D8UwvElNRYAcr5ewh4QnIvOwhttbELXly3M8sza3v2Z4/E8jSX34Xuq31kybIlm04R4BoIeseHIZTarWmAfAjtZTocyj5uFetYBnTuL3SdgL7rEoOssZyXxDiQaTP33+dDVaABy6G0k4eaXU3shuXENxghX4GeawudSzB7zha3vK0jw5RQitPUd4UGHK6DMgdVFoJ09bZIP15rIErlWrxnZAQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CH3PR20MB5745.namprd20.prod.outlook.com
 (2603:10b6:610:14d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 20:26:20 +0000
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
Subject: [PATCH net-next v15 08/13] dpll: sit9531x: add support to get and set
 priority on input pins
Thread-Topic: [PATCH net-next v15 08/13] dpll: sit9531x: add support to get
 and set priority on input pins
Thread-Index: AQHdcVG7r/DTKG8xlUa/EOqn+s4R0Q==
Date: Tue, 10 Nov 2026 20:26:14 +0000
Message-ID: <20261110202607.55744-9-arouhi@sitime.com>
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
x-ms-office365-filtering-correlation-id: 6f97ef7d-53a9-4f4e-4948-08df3f68e153
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|56012099006|18002099003|22082099003|6133799003|10067099003|261009223027099003|261021121427099003|261028144727099003|261021123027099003|261102123227099003|261022075727099003|261022105027099003|261026140227099003|261026121527099003;
x-microsoft-antispam-message-info:
 2ahnzDLEpWZAH21wIuyBUfFme8bFL9fMyz3rE3IQiPTR1lDmKvdchiY2Vsvz29/+kIVVUmkPPlKSUScdGym4srar8Efrkl+l7Bne6m5b8j4oxy/KK6aaLiriHRK3FWLMCf5Nl8YWpFEkIGTr10cbtAOKqbwP2XIbDbZTIBST11WEFCZbssRgM/MF/Llb/rxZUVGB3rcUzzq8OaDAswDR6EZheTQkPoCbvtlUbNnavJ6ftMnFSbsmoxSyDFMJBjOdfZ5sebL14gzy0nhxdG0X0FsPwH7qDeQGDhcvSg+veHEB8tpeg4TsM5jfOGPzFEaiZuABEwj4VxhRMbDiJbY/n3it+0wxwK6s/vxlRN+xGobiMIDYMQcznQ6g0ZhUlfRWL4k6XXUTU1ciT1GKr51q6UqvviNrVm9sdgIM7pYG0omPhADpuNfupN4Fa7GW5WVEZBXiFRIYwjL850FGHANGy5fhNbBTb8beeZlntRDtkPMOLDQbpMsTr9vsjLUJPZ96HnMgAerxjsYBFtf7DQGpoW+bhddx/qPkOZihbricVzR9EkzdhkTe1nF9T6Qi9dAUGP6VUyMUS2RA2Zt5+MDwIk9Wg8270DxnangnZgs5UGr0upGylrfORMfeJdV+bxNSL9n8avp3lEREetnCib6YhKRlUhNyNNenOxHhi300bGQahGfTq6LjGoNll2+3u8WkoSIpcLUcgCQgwbHNdGPtj4ZXepSXl9HxlPoqMjAH+ac=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(56012099006)(18002099003)(22082099003)(6133799003)(10067099003)(261009223027099003)(261021121427099003)(261028144727099003)(261021123027099003)(261102123227099003)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ejRlZOtPH110TxZewRvTEZLbJDE0mH6RvCH52XTiyHAg8Djc0zjtqv0tDi?=
 =?iso-8859-1?Q?x5AVTnIruRNWbc1Ox5FnYZG+8QGfYTDraQjjRlfZhS9ycC7p47itFnN/5l?=
 =?iso-8859-1?Q?gckKaIN50yoSM/va50wbF4GcQKDi88AFJpxVOnUDI9l/9zNkS5yfM6WDyJ?=
 =?iso-8859-1?Q?JWXa2sG2h8bYSKr36q02MDo4LLebbHHuaScdzj4AUsih474pLoG/Bv3da3?=
 =?iso-8859-1?Q?A+eQPPfIIy7Ooic1YKydrqFM0HoqacEuDR2mguRbzj7wY5B236x2jO3zzy?=
 =?iso-8859-1?Q?YHOrw4pbbA3SV3lmmc5qP0k9vs8H5CAwpY0hDln3G9pbrw+TFn+qpQiXub?=
 =?iso-8859-1?Q?Ekxcv80Xkr4yQnMLU1OXTbv/Q4l5CZaoppj/UhEnMucdUMOiJERHagUpiY?=
 =?iso-8859-1?Q?CkEJt8q27rM32YjEgqvWUjBV3CgoLyfrE/muzYErpkZaSxfZzY3eQ3iNuN?=
 =?iso-8859-1?Q?pvAa/Yn2hso0eM593fbyCtwJd8k2gA+06Tfk4GI8XQ1IV4YGp8hqK17H/S?=
 =?iso-8859-1?Q?UrKJJYBF+Of4ZXhm9Vs99ek6bbwx6kIovNR39bC3hDZNii2JnaUy7C4QA1?=
 =?iso-8859-1?Q?5XEAPYFRK+BrbHSeNYcKtd8gL9BEuqzAKyE4mIlmb2g93aioxXATuVk69t?=
 =?iso-8859-1?Q?bPaKqtgAJcWoeqothhP2264KgcdDmfQuXr428Vf2Tpd/REcKUkE7tzCRrX?=
 =?iso-8859-1?Q?RojJgDkLzH4j4vf1V+5B6DSR0An+YxENO0v6mAtiguWlKa+oznzWDLc/p0?=
 =?iso-8859-1?Q?BGwM7qgCc+4UPclwfoKU10G8eYHagmGlqYnxUM4+jjoyjzrPBUGISIRZkx?=
 =?iso-8859-1?Q?zaJKQsfGMyQpOj4uecZk4eBYQWdr2xl5Cbq8XaEhcujd01rYTthilHk9cG?=
 =?iso-8859-1?Q?/xw2Mn0mAGoqEZUGK0+h5NvnmVEvmfC9gH+uf4OzNfeB0OEqbtIy6YY91F?=
 =?iso-8859-1?Q?tcoDgYBk88NNYTzR7vZJ8vWJkkynYhdSPFmZiQ3+qR6mXc1HdmjGuvu4Jl?=
 =?iso-8859-1?Q?P2rgdv0e7l8ZoWYVM0tMelZtkxy5Tck4jDAZtr8y8xDUsqBRUAz3JLs2Bg?=
 =?iso-8859-1?Q?MFFeabCh4y8qh9PayGd4K/X7MG4fpx4GAIpCpWhuWCjj8RLcVvz61NonaG?=
 =?iso-8859-1?Q?weJYsnSw8rIzp/Ocbn6SS6WfTakxUtSVNDz5x4S/dACf33nJCjTx2n6X6B?=
 =?iso-8859-1?Q?uRbb4zpQqFop+J9lY1lgYqTy8kL0KOqWPMpQUT803ZYBS+QI5t/g85oj+F?=
 =?iso-8859-1?Q?zs1jvADs95+DpgMWkLzuZ/CXe3s5ohN7nDG7hKzslYb9bgy805WMKVwe6n?=
 =?iso-8859-1?Q?Aer5/HzgUjRhi9lOWsd1KMCRfS2X//8AH724V1yDVE/mf+1ZOQ5mQCcrdb?=
 =?iso-8859-1?Q?jdBhaFaQmaBTAQbOJOylJoZbYKV06nwHVtg/DxVZH9/gjCjkXV8L8IiJfC?=
 =?iso-8859-1?Q?0hHrMo7sAUo5aeFz+h/egEK3T/S4HCuHBVqYVau3xTMBs5ujVg1N1buUVA?=
 =?iso-8859-1?Q?UDT7SrjreHtlhAm1aaywujr0yvlyooR3GbC53ocXzbuCKKKoCxd8FMe1Vk?=
 =?iso-8859-1?Q?q85He2Sfq6Ecu0kCsj3rNDVn9coxIjr136o/tTba3QHaJgpn7MDBCQNCOv?=
 =?iso-8859-1?Q?YrYFu+pToT8ms7hj1SetUtIyjwHa3+FiRnmZ1K4HgKV4gDHnGb6jqHbMLu?=
 =?iso-8859-1?Q?MvJKKvrqRJxaqLv+bkBMxy2Cr0UMTQ+alqeIMRmPS2FUArqfpWE5QDjQFV?=
 =?iso-8859-1?Q?xcUU4HVntX4m6cXBqv2mVYCR7cGAnj5WodJR+9qvUHsOGR?=
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
	unaiv8mdSWnWIIXKgsparkuZGrp82d9bfDZu80j2JWYfCLEzNjPCDu6KKb0sorEb+l86AELdDio7yPl+TeOBICRb8TXzwe8AETo6unak7II9kQM6nIAY/sozRTUU0uQx+M/gisEPZvrff6o1cxFguLbNwcU/dVZGts9X6HZT9oTnXhYKLNC0/nVqd8SZd7FmYZangRsEWv62xCzeqQy15f6154u4Pr6eWi+G+wiCIz154YnTC7wExCji4Imggge4iQrkaXX3+ipMpQmSA2cpIGajqkiJfRch/URzeaxuTMczztf7GGFHawR02h1gs07IhLqLmx9MvslFB23nMgkWCg==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f97ef7d-53a9-4f4e-4948-08df3f68e153
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 20:26:14.2615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 64pQyyZ10mDQ4tqmgMG7Ay2issftF6G8GtBqJHu5Rxx8K8ooJPFyfQrpauB2emxb97Y2MJTywCZSYwZPLw6Uwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB5745
X-MDID: 1794342406-AKNQFvpi3yCV
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1794342406;AKNQFvpi3yCV;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Keep a priority per input and PLL, seeded from the table the part=0A=
loaded, and rebuild the table from it on a set. Priority and state are=0A=
separate: a priority set on a disconnected input applies when it is=0A=
connected. The range is 0 to 255 over eleven slots; inputs of equal=0A=
priority keep their table order.=0A=
=0A=
A table rewritten outside the driver, by a profile reload or an I2C=0A=
tool, becomes the new configuration, and the poll notifies the pins=0A=
whose priority moved.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c |  52 ++++++++++-=0A=
 drivers/dpll/sit9531x/core.h |   2 +=0A=
 drivers/dpll/sit9531x/dpll.c | 163 +++++++++++++++++++++++++++++++----=0A=
 drivers/dpll/sit9531x/dpll.h |   4 +-=0A=
 drivers/dpll/sit9531x/prop.c |   2 +=0A=
 5 files changed, 201 insertions(+), 22 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index af6d7918958d..b4e44f0d9820 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -605,6 +605,33 @@ bool sit9531x_input_prio_present(struct sit9531x_dev *=
sitdev, u8 pll_idx,=0A=
 	return !!(sitdev->chan[pll_idx].prio_mask & BIT(input_idx));=0A=
 }=0A=
 =0A=
+/*=0A=
+ * @input_idx is in hardware encoding (see sit9531x_input_hw_src()). A sou=
rce=0A=
+ * the PLL has never listed reports the last slot index, 10. Caller must h=
old=0A=
+ * sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_input_prio_get(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx, u8 *prio)=0A=
+{=0A=
+	const struct sit9531x_chan *chan;=0A=
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
+	if (chan->cfg_known & BIT(input_idx))=0A=
+		*prio =3D chan->cfg_prio[input_idx];=0A=
+	else=0A=
+		*prio =3D SIT9531X_PRIO_MAX_SLOTS - 1;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Take the configured priorities from the hardware table: a listed source=
 gets=0A=
  * the first slot it occupies.=0A=
@@ -735,7 +762,8 @@ static u8 sit9531x_prio_top_live(const struct sit9531x_=
dev *sitdev,=0A=
  * until it loses signal.=0A=
  */=0A=
 static u8 sit9531x_prio_activesel_pick(struct sit9531x_dev *sitdev,=0A=
-				       const u8 *old, const u8 *srcs, u8 cur)=0A=
+				       const u8 *old, const u8 *srcs, u8 cur,=0A=
+				       u8 routed)=0A=
 {=0A=
 	u8 top, i;=0A=
 =0A=
@@ -744,6 +772,12 @@ static u8 sit9531x_prio_activesel_pick(struct sit9531x=
_dev *sitdev,=0A=
 	    top !=3D sit9531x_prio_top_live(sitdev, old))=0A=
 		return top;=0A=
 =0A=
+	if (sit9531x_prio_src_usable(routed) &&=0A=
+	    sit9531x_prio_src_live(sitdev, routed))=0A=
+		for (i =3D 0; i < SIT9531X_PRIO_MAX_SLOTS; i++)=0A=
+			if (srcs[i] =3D=3D routed)=0A=
+				return routed;=0A=
+=0A=
 	cur =3D sit9531x_prio_src_canon(sitdev, cur & SIT9531X_PRIO_NIBBLE_MASK);=
=0A=
 =0A=
 	if (sit9531x_prio_src_usable(cur) &&=0A=
@@ -826,12 +860,18 @@ static int sit9531x_prio_table_commit(struct sit9531x=
_dev *sitdev, u8 pll_idx,=0A=
 =0A=
 	if (!empty) {=0A=
 		u8 sel =3D sit9531x_prio_slot_get(val, slot + 1);=0A=
+		u8 routed =3D SIT9531X_PRIO_SRC_NONE;=0A=
 =0A=
+		/*=0A=
+		 * The pick needs the signal state now, not as of the last poll.=0A=
+		 */=0A=
 		rc =3D sit9531x_input_mon_fetch(sitdev);=0A=
 		if (rc)=0A=
 			goto rollback;=0A=
+		if (!chan->stale && chan->routed_ref !=3D SIT9531X_REF_INVALID)=0A=
+			routed =3D sit9531x_input_hw_src(chan->routed_ref);=0A=
 		sel =3D sit9531x_prio_activesel_pick(sitdev, chan->prio_srcs,=0A=
-						   srcs, sel);=0A=
+						   srcs, sel, routed);=0A=
 		val =3D sit9531x_prio_slot_set(val, slot + 1, sel);=0A=
 	}=0A=
 =0A=
@@ -2277,6 +2317,14 @@ static int sit9531x_dpll_pins_register(struct sit953=
1x_dpll *sitdpll)=0A=
 			goto error;=0A=
 		}=0A=
 =0A=
+		/*=0A=
+		 * Taken before the pin is published; see=0A=
+		 * sit9531x_dpll_pin_baseline().=0A=
+		 */=0A=
+		mutex_lock(&sitdpll->dev->multiop_lock);=0A=
+		sit9531x_dpll_pin_baseline(pin);=0A=
+		mutex_unlock(&sitdpll->dev->multiop_lock);=0A=
+=0A=
 		rc =3D sit9531x_dpll_pin_register(pin, index);=0A=
 		if (rc) {=0A=
 			kfree(pin);=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index c2fa6a17be43..fa779acf7de5 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -265,6 +265,8 @@ bool sit9531x_input_prio_present(struct sit9531x_dev *s=
itdev,=0A=
 				 u8 pll_idx, u8 input_idx);=0A=
 int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
 			    u8 input_idx, u8 prio);=0A=
+int sit9531x_input_prio_get(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx, u8 *prio);=0A=
 int sit9531x_input_prio_remove(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
 			       u8 input_idx);=0A=
 int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index 56bdec4bcf67..f03145f4d1ee 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -34,6 +34,14 @@ sit9531x_dpll_is_xo_pin(const struct sit9531x_dpll_pin *=
pin)=0A=
 	       pin->id =3D=3D SIT9531X_MAX_INPUTS;=0A=
 }=0A=
 =0A=
+/* Check if the pin's state and priority can change without a request */=
=0A=
+static bool=0A=
+sit9531x_dpll_is_selection_pin(const struct sit9531x_dpll_pin *pin)=0A=
+{=0A=
+	return sit9531x_dpll_is_input_pin(pin) &&=0A=
+	       !sit9531x_dpll_is_xo_pin(pin);=0A=
+}=0A=
+=0A=
 /*=0A=
  * A frozen PLL with an empty table is in forced holdover; report holdover=
 only=0A=
  * while its holdover memory is valid.=0A=
@@ -396,11 +404,78 @@ sit9531x_dpll_input_pin_state_on_dpll_set(const struc=
t dpll_pin *pin,=0A=
 	return rc;=0A=
 }=0A=
 =0A=
+/* Report the configured priority of the source on this PLL, listed or not=
 */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_prio_get(const struct dpll_pin *pin, void *pin_pri=
v,=0A=
+				 const struct dpll_device *dpll,=0A=
+				 void *dpll_priv, u32 *prio,=0A=
+				 struct netlink_ext_ack *extack)=0A=
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
+	*prio =3D slot;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Rewrite the Page 1 priority table for a listed pin; an unlisted pin kee=
ps the=0A=
+ * priority until it is connected.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_prio_set(const struct dpll_pin *pin, void *pin_pri=
v,=0A=
+				 const struct dpll_device *dpll,=0A=
+				 void *dpll_priv, u32 prio,=0A=
+				 struct netlink_ext_ack *extack)=0A=
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
+	if (prio > U8_MAX) {=0A=
+		NL_SET_ERR_MSG(extack, "Priority out of range (0-255)");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_input_prio_set(sitdev, sitdpll->id,=0A=
+				     sit9531x_input_hw_src(dpin->id),=0A=
+				     (u8)prio);=0A=
+	if (!rc)=0A=
+		dpin->prio =3D prio;=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc) {=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set input priority");=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
 	.state_on_dpll_get	=3D sit9531x_dpll_input_pin_state_on_dpll_get,=0A=
 	.state_on_dpll_set	=3D sit9531x_dpll_input_pin_state_on_dpll_set,=0A=
 	.operstate_on_dpll_get	=3D sit9531x_dpll_input_pin_operstate_on_dpll_get,=
=0A=
+	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
+	.prio_set		=3D sit9531x_dpll_input_pin_prio_set,=0A=
 };=0A=
 =0A=
 /*=0A=
@@ -477,6 +552,43 @@ sit9531x_dpll_pin_ops_get(const struct sit9531x_dpll_p=
in *pin)=0A=
 	return &sit9531x_dpll_input_pin_ops;=0A=
 }=0A=
 =0A=
+/* Caller must hold sitdev->multiop_lock. */=0A=
+static void sit9531x_dpll_pin_snapshot(struct sit9531x_dpll *sitdpll,=0A=
+				       const struct sit9531x_dpll_pin *pin,=0A=
+				       enum dpll_pin_state *state,=0A=
+				       enum dpll_pin_operstate *operstate,=0A=
+				       u8 *prio)=0A=
+{=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	u8 id =3D pin->id;=0A=
+=0A=
+	if (id =3D=3D SIT9531X_INTSYNC_PIN_ID && sitdev->intsync_src =3D=3D sitdp=
ll->id)=0A=
+		*state =3D DPLL_PIN_STATE_DISCONNECTED;=0A=
+	else=0A=
+		sit9531x_dpll_selection_state_get(sitdev, sitdpll, id, state);=0A=
+	sit9531x_dpll_selection_operstate_get(sitdev, sitdpll, id, operstate);=0A=
+	if (sit9531x_input_prio_get(sitdev, sitdpll->id,=0A=
+				    sit9531x_input_hw_src(id), prio))=0A=
+		*prio =3D pin->prio;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Take the baseline before the pin is registered, so the first poll notif=
ies a=0A=
+ * change a request made. Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+void sit9531x_dpll_pin_baseline(struct sit9531x_dpll_pin *pin)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D pin->dpll;=0A=
+=0A=
+	lockdep_assert_held(&sitdpll->dev->multiop_lock);=0A=
+=0A=
+	if (!sit9531x_dpll_is_selection_pin(pin))=0A=
+		return;=0A=
+=0A=
+	sit9531x_dpll_pin_snapshot(sitdpll, pin, &pin->pin_state,=0A=
+				   &pin->operstate, &pin->prio);=0A=
+}=0A=
+=0A=
 /*=0A=
  * Send notifications for changed lock status and pin state; called from=
=0A=
  * sit9531x_dev_periodic_work().=0A=
@@ -511,32 +623,45 @@ void sit9531x_dpll_changes_check(struct sit9531x_dpll=
 *sitdpll)=0A=
 	if (sitdpll->ntf_pending && !dpll_device_change_ntf(sitdpll->dpll_dev))=
=0A=
 		sitdpll->ntf_pending =3D false;=0A=
 =0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
 	list_for_each_entry(pin, &sitdpll->pins, list) {=0A=
-		const struct dpll_pin_ops *ops;=0A=
+		enum dpll_pin_operstate operstate;=0A=
 		enum dpll_pin_state state;=0A=
 		bool changed;=0A=
+		u8 prio;=0A=
 =0A=
-		/*=0A=
-		 * Only references and the INTSYNC destination change state=0A=
-		 * without a request.=0A=
-		 */=0A=
-		if (!sit9531x_dpll_is_input_pin(pin) ||=0A=
-		    sit9531x_dpll_is_xo_pin(pin))=0A=
+		if (!sit9531x_dpll_is_selection_pin(pin))=0A=
 			continue;=0A=
 =0A=
-		ops =3D sit9531x_dpll_pin_ops_get(pin);=0A=
-		rc =3D ops->state_on_dpll_get(pin->dpll_pin, pin,=0A=
-					    sitdpll->dpll_dev, sitdpll,=0A=
-					    &state, NULL);=0A=
-		if (rc)=0A=
-			continue;=0A=
+		sit9531x_dpll_pin_snapshot(sitdpll, pin, &state, &operstate,=0A=
+					   &prio);=0A=
+=0A=
+		changed =3D state !=3D pin->pin_state ||=0A=
+			  operstate !=3D pin->operstate || prio !=3D pin->prio;=0A=
+		if (changed)=0A=
+			dev_dbg(sitdev->dev,=0A=
+				"%s: state %u->%u operstate %u->%u prio %u->%u\n",=0A=
+				pin->label, pin->pin_state, state,=0A=
+				pin->operstate, operstate, pin->prio, prio);=0A=
 =0A=
-		changed =3D pin->seen && state !=3D pin->pin_state;=0A=
 		pin->pin_state =3D state;=0A=
-		pin->seen =3D true;=0A=
-		if (changed) {=0A=
-			dev_dbg(sitdev->dev, "%s state changed\n", pin->label);=0A=
-			dpll_pin_change_ntf(pin->dpll_pin);=0A=
-		}=0A=
+		pin->operstate =3D operstate;=0A=
+		pin->prio =3D prio;=0A=
+=0A=
+		/*=0A=
+		 * The notification takes DPLL-subsystem locks the callbacks run=0A=
+		 * under; send it after dropping multiop_lock.=0A=
+		 */=0A=
+		if (changed)=0A=
+			pin->ntf_pending =3D true;=0A=
+	}=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	list_for_each_entry(pin, &sitdpll->pins, list) {=0A=
+		if (!pin->ntf_pending)=0A=
+			continue;=0A=
+		if (dpll_pin_change_ntf(pin->dpll_pin))=0A=
+			continue;=0A=
+		pin->ntf_pending =3D false;=0A=
 	}=0A=
 }=0A=
diff --git a/drivers/dpll/sit9531x/dpll.h b/drivers/dpll/sit9531x/dpll.h=0A=
index 6c02aa131328..3ded177b871b 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.h=0A=
+++ b/drivers/dpll/sit9531x/dpll.h=0A=
@@ -30,7 +30,8 @@ struct sit9531x_dpll_pin {=0A=
 	u8				id;		/* hardware index */=0A=
 	u8				prio;=0A=
 	enum dpll_pin_state		pin_state;=0A=
-	bool				seen;	/* baseline taken by the poll */=0A=
+	enum dpll_pin_operstate		operstate;=0A=
+	bool				ntf_pending;=0A=
 };=0A=
 =0A=
 struct sit9531x_dpll {=0A=
@@ -56,6 +57,7 @@ int  sit9531x_dpll_register(struct sit9531x_dpll *sitdpll=
);=0A=
 void sit9531x_dpll_unregister(struct sit9531x_dpll *sitdpll);=0A=
 =0A=
 void sit9531x_dpll_lock_status_baseline(struct sit9531x_dpll *sitdpll);=0A=
+void sit9531x_dpll_pin_baseline(struct sit9531x_dpll_pin *pin);=0A=
 void sit9531x_dpll_changes_check(struct sit9531x_dpll *sitdpll);=0A=
 =0A=
 #endif /* _SIT9531X_DPLL_H */=0A=
diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c=0A=
index b9405eba49a3..69877fc94028 100644=0A=
--- a/drivers/dpll/sit9531x/prop.c=0A=
+++ b/drivers/dpll/sit9531x/prop.c=0A=
@@ -146,6 +146,7 @@ sit9531x_pin_props_get(struct sit9531x_dev *sitdev,=0A=
 		/* INTSYNC destination: a reference the PLL can lock to. */=0A=
 		props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
 		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |=0A=
 			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
 		curr_freq =3D 0;=0A=
 	} else if (sync_out) {=0A=
@@ -161,6 +162,7 @@ sit9531x_pin_props_get(struct sit9531x_dev *sitdev,=0A=
 	} else if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT) {=0A=
 		props->dpll_props.type =3D DPLL_PIN_TYPE_EXT;=0A=
 		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |=0A=
 			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
 		curr_freq =3D sitdev->ref[index].freq;=0A=
 	} else {=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
