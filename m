Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012037.outbound.protection.outlook.com [52.101.53.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2F729DB64;
	Mon, 27 Jul 2026 02:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785118140; cv=fail; b=YwURAJJH7Wa+3m6J6st6vCYDRTrgIH73z8oQWB1kx5SbcIaW0i7U8GVzBshSQfwFwOJNFOJrethsIpgmpF9RN8utEAYPjfH9oRSmwQLqpzhpkcHOoC3lFeFSEr1ypBX5kcX5F1ivXaUQA5rvwWkjZ/XN1wWI/JXm2n3YUw+brBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785118140; c=relaxed/simple;
	bh=lzUjvS4Kdl6bAcegc8v3AHcFhBRPCOrhMEBsecrUFug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=trYrLzB3V5PvpLbPtNuGdjIP6QC95sSdtjDFdJVpjoagZRA6VMvEnr9BbCeYjbaIwIiYAablp27PbKlUCf87DJ4E+AMe42q70XvfnlAQsJ7GLxAyN+CZkpEwwjBdQ9yCbAe9LjpKlUyk+Wajg7e9bto6LxUNTT5vk+0PKHqDDQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=kNskTOj8; arc=fail smtp.client-ip=52.101.53.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="kNskTOj8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLX+pw1Wh9kRy/dUZMU0xwX1KZNX6tDfy7xkk85DQbUp109rUjNq1mkO/8NVBqGCCw7C1azlCXoRV53VUgvKONyau5jvCyWAYHvIymf25b2YxM6zPDKZj9zC32qpQxrIThCUb01w8MNsVmvunF3KOF84eYTYLAZCsIArDyHUH9Xw1NaZrbZwZZB1ICgRIO+Uv1u6PJSrQ66Yg1fJEKNHvFcfX1DSFveDilAnx+o5XN2sJSyltQZEMPm9zhi36SpHBqxNgDIwx4fL7lzvXpKez7HiCNOrBFzBinnYI/Kwy3TJUL6joFEMnRckYSOzfEWDf0p6zmqCRifcL37kouq8pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzUjvS4Kdl6bAcegc8v3AHcFhBRPCOrhMEBsecrUFug=;
 b=ITG194eO2pG5qfFSGeqbDb2TDfrLZYdQfnJyvqIaaDw5tIJiUi1fxafX5xQGKv210HLDuUUtOkCMR81Y2FJtx7H3K15WhqUIgnt4UQqlyBnu+Xwfdw2nm3dmOxWo0rn457sjivi4k/fciP1U2lsFsbd8KpwQHaOYAGRepcuVqQvdA1ehPkDg6gFte+KU1ty6hw7IR3CrarlW7CNp1WhFOyXDqwmZfCyfBIOLuoHfIShDREd9EGjqvMdfQ3PXECF56x3tlNlTkeooZrwGQBdJKjVxZGlaAMx+33alQhUqieksVALcVE4984a/4XE//aWhATzJ3w1WovBlFsL/6bMOKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzUjvS4Kdl6bAcegc8v3AHcFhBRPCOrhMEBsecrUFug=;
 b=kNskTOj8Qc2I2iufibayuz/36pnLD6FuPWXFKhoXTyx6vJhHwMtmAp1fMMsxfiy+8VwE122fY/nUeGi1q6ZeNQoxevTDaoDezqwhLwuUwjzHjk6dAhxJQ42QUBMYX0XSQb4dlbWgo/v/o40Bs/F40IrlZ7QY0B2slxIuKIwYTMCWheJif0aj1hMwu4AGjdFHMQvpvJOsa68rML2xsYi6t1Fvzy/AEkyJyLjZtE9KyvQJfzuvIUAFp3wSNgyhx63ve0QmvByjvceizYwwusH1eWIxVGUt2oZH7GHJX7/m8Q5Fv6YM5WYh0qBc/GvtoC9yQK/6k1eXfhHSlql/bWdLmQ==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DM6PR03MB5340.namprd03.prod.outlook.com (2603:10b6:5:24d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Mon, 27 Jul
 2026 02:08:56 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 02:08:56 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "dinguyen@kernel.org" <dinguyen@kernel.org>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] dt-bindings: net: altr,socfpga-stmmac: Add
 altr,socfpga-stmmac-agilex5-tsn compatible
Thread-Topic: [PATCH v4 3/4] dt-bindings: net: altr,socfpga-stmmac: Add
 altr,socfpga-stmmac-agilex5-tsn compatible
Thread-Index: AQHdFMmtrc3Nae9BAEyNgcm7P0+qFbZvyFeAgBDn1QA=
Date: Mon, 27 Jul 2026 02:08:55 +0000
Message-ID: <7b9fe974-4bb6-4b12-98f0-ce6af3a9ceda@altera.com>
References:
 <20260716021932.20037-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260716021932.20037-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260716-turtle-of-massive-thunder-be8283@quoll>
In-Reply-To: <20260716-turtle-of-massive-thunder-be8283@quoll>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|DM6PR03MB5340:EE_
x-ms-office365-filtering-correlation-id: ba68e6a8-b0c1-4158-95d1-08deeb840379
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|38070700021|11063799006|4143699003|56012099006|10067099003|55112099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 DdrU/tGUs4zJh+l0FiXVibXtfm/bN6lCaI7TIx3DtLX+8FRRe55IkA1g0hFBVVb+1JRgUjbd3PtnzKrw6rLQpqjB8UjhpIo8ni/RVo5FFm6iO2egZNNtMBIU/yk9E8ldOpscODrBAyrJBlnn35Hrf+xQ7Pvlaz2a6J/nDj1cqVHDPo9c8HnN+mSVJt4GG7vKuQYo6UK9JoFs16jFpZrPB6JNWCr8AKmhwVbRR04Ihy+MoypxrIGligHxGlOxpbl2Zic9z9Pmvu+D7USXwNX0EpsfhlHeZl/EW31ufBxxJvDxLboo/FrS1rZilEeUSJX+XmPXOWE/w4OfrQ7XeYzALi4PhOXrYi2SJR2s+QewJy99uvygMiGphJLjJwoz+Dc68kmn5AlP0sQhQSr6O+cKAtov06H66hvuqzG0T8XJV7bdJGZr7i21KCjseaDAYt0/IiER8C9xq4itDelqtouyUHJkSc83DcbUWbEap8zuBRXL6OSN4tTuhs2A2zLw0f4TvQYCwUDS+E1E6DCSaRV48DqvfW4Ocqp5vSbcdUioDUBQrdYbbo1JQYs+RBDEyZvYJBCRfS8uWW9dh8fs0jW8WQW7koTH2J9iZp/+FI0ysQWoSA9zBi1eCfbPfM62rFkBGijS7g+8SOrQGZG+vuBsjfGwo1TOtQRtEPVHdH9Im9peHbMR3QXWJ2pPD9mQLa+E/bxHCVVCI4L38k2/SEOgMQwQ7pX6ozzPqOHSgqN0aWw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(38070700021)(11063799006)(4143699003)(56012099006)(10067099003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFdGeUxpOEVVRUpOZDdZN3B3SEpKNzRkNUo0Z090aGthTTlxRjlLeGpMQ2FU?=
 =?utf-8?B?dUVucGw2bmN1bkdIK29zZmpIRjZ3d0xtNjlJSUxmVzNJRmRiUVJyTFRHNTky?=
 =?utf-8?B?T3RXeGljUFVQZjVnNzBTU2I2ZmtadndVNHQ5Z1Z2dlJDK2hSK1dJbWw4Wnph?=
 =?utf-8?B?TGZySUM2T1JwZEJwMHh5Z2VuQURrb3Zod1BWc3B2UTJ0Vk0xVUlaTXNIMGp3?=
 =?utf-8?B?dm9ITkVDWXp5RDlSL2FwUllrblB3OGJyZHRJYzlNYVRYZ2NIckZnZlZkQlBZ?=
 =?utf-8?B?alNEUjYwam0xeVlOeUpRYXc5OEI3SGFpSVRQM0VXbTBza1dzbXNVdU0yYzVG?=
 =?utf-8?B?YThvQ3JINDJ6NkQ2VzdCemREbjhMZytMbGZKU0kyOExCMzQvYWtkWnRRelVl?=
 =?utf-8?B?K3dKOTcvV2RYanBUU25tZFhFc09yQW5XTmdaMUh3aDdLNUFpRlRvakcyZCtJ?=
 =?utf-8?B?UFBWM0NmbzNPNldvOEJBaTFnTnJkbzJjMmdNdVJuaUpRV0VtSlFTcTBNT1lD?=
 =?utf-8?B?WER6SXlVYnc5NFo2U0pTYitMdEFEVkQ5SEtBUE5GR2lKbXNyd1RINFcvK2Zk?=
 =?utf-8?B?eFc3QjVsMzhTdThzcDd5U0kvODRnZGswQnZhUFY5cFhyRDVYcGdZdVJhblZY?=
 =?utf-8?B?ZXc1R0poMitIcmZUVkxTZlRDUEE2MXA2Uk9FeExVOFh3blY5VGMrN1VlbFBx?=
 =?utf-8?B?N09aWDk1ZjZJdUowTzhNZDZPQzIyMkdHSFhqTHNjK1JHMnN0UUtFWE51Smt6?=
 =?utf-8?B?WnZOaVowdmVmTDVDdnVTQ0dzMlFkalRyVDZUbGtrckt3c0F1V2JqM3ZkZEZI?=
 =?utf-8?B?bFhBU2YvSytjNk5ydDNtVDBQOUZJWUxPdXExNlM4OVZabktpUnFtQ2dEVVR2?=
 =?utf-8?B?cXNOZndGZWs4Qlgyem1acjEwU05TQUdTM1p4ZkpPWDV2akVEbC9IaHZCM3Ez?=
 =?utf-8?B?eXBBaGdLM3N5aFhDdGtNRFZuRllzOE9iU2JtUGI1V3dQSEFsNDBQOVF3MHc1?=
 =?utf-8?B?VEFETGtvb3N4WU5ZWWlkSnFBUHJMa29ldHhVZ1VvSjRwNGFiWGhMZjBuaXdj?=
 =?utf-8?B?cVIyNldENmlOdXNwb3RJV00wYlY0NTRncmtzSVZ3WEZsQXFSdU5ySDRnWTVz?=
 =?utf-8?B?QUtHQTlWNGd2YkdnM3lRaU1LcXl5YW1scjlTNGhza0ZoVTQ0TnQwR2pQUEs2?=
 =?utf-8?B?SzhSSFdRdForRmh5TGgzcGNxRll4RHdjNndDUmRIYkM1c2kyMldZRUtnL0Vp?=
 =?utf-8?B?ZEREblQ0Q1pKOWFsYi9Pem1SeWh5OXJZNFJOUHpMelVmZ2FFbWp3YWdoVDVv?=
 =?utf-8?B?OWtwWFZqYzZJb3cvMmpuNEdqRnBqSld1VCszZUV6SW9DTERkejZaRFF3YUJw?=
 =?utf-8?B?UkloN2VMeTJTOHBObmZ1cTNWZDMvbGR2QkVoWEtnWE1MQ1l1bExrTElvNHA4?=
 =?utf-8?B?ZzExanRLZ2ZGUmlaNktqY0VHWk1mbDdKMjFsY3k0S2pQRzJYZFY1M3YrOUFU?=
 =?utf-8?B?UGJteHVOUGkyQ0NNcFhlRnRkbVBXWEx5QnE3Qmo3VUJBOENadjdhRUpHRGlO?=
 =?utf-8?B?UWsvaFZmOVNUNnlSSENmekYyK1lQWjQvRG11VWFuaWxlUkpjakk1MXRYRVls?=
 =?utf-8?B?V2gvZUROaUVWclNPR3VLSUpUZ1N6U2RnbjJMTk1SL2VxMUpmTldkMVp1eTcz?=
 =?utf-8?B?aXR2cWorYTVuOU9TT2p0ZjJXNkVUL2dTWlNySzN2Um9VaERLL2UyZFNaMklx?=
 =?utf-8?B?THNkSkc1cm13ZU5kWG03U2ZSd1RickVwRHhCVWEyQm1id3k1K2FUaFN5aElm?=
 =?utf-8?B?LzBrbVRBNzVzVGgvOWlGc1M2WHVPbUI1WC9PMUV3alFQbkNRc0NBdzFVREdr?=
 =?utf-8?B?RmRyV0tBTUVYZGgxOHhIUXNZRGVCNXlxYitQLzM1dXIrbmZhb0JTUEJLdjNz?=
 =?utf-8?B?WjlEN1NodFo5VUFSYmhXNFZNdDhUTitUVStMdWJzTmhHRzVKVzdJMFhuQmww?=
 =?utf-8?B?WE9OMFAweVZTdFZHbm5hQVNSYzVXMmxWT0lWdnh0UEloOU80Q1I3ZUY0eklz?=
 =?utf-8?B?blNKbkFyTVRxRmx2TnE1ZnZVMy9aV3h5V3BnRTVraHFOeUVKeXlhTGNCVUp2?=
 =?utf-8?B?OGw3WHFEb2l3cDN2K0tjL0tzRVpIN0FqSEllMkNlNlFkTXRNeWdxMFFtdC9R?=
 =?utf-8?B?VC9hL3dBSDR1bDVVUHYyQWF5OTIyaHVLQlpYY0JjYWpJamxMNnhPWmxIY29J?=
 =?utf-8?B?M1FLSVZwaHBmVUhVK3JjeUpvUzNkTnVxeWJLSkdQdXpBa016OHgrUUFDaG5n?=
 =?utf-8?B?LzFSVUJqUnVZVlZQS2xEcmJReFVOdkZSb2pDcllpYkRKeEhSR216bXo5U3Av?=
 =?utf-8?Q?hyDXpAC3356ZHXWvySOfi+xoO5ClCONpJuQr8XV85W3aX?=
x-ms-exchange-antispam-messagedata-1: b4YqSTRcdaQlx4LVpF6JTyTwI+6RXRKY3Pk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6DC41D497A08347A3049F7CB07C2ECF@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba68e6a8-b0c1-4158-95d1-08deeb840379
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 02:08:55.9223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8MXKQPccRpzMAUFeKbiUPuTjVfes2sgvMNl+u816QGZD3IU22dwY03nGnrGcZotFYwJ2pwLGgpqXmlHrUzbLDyyREF+p3mDF3l03jl4BpB8+wRMMSWCT29gO0VmWdZzTArYGuWUmiK0VhwBlifqXPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5340

T24gMTYvNy8yMDI2IDM6NTggcG0sIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9uIFdl
ZCwgSnVsIDE1LCAyMDI2IGF0IDA3OjE5OjMxUE0gLTA3MDAsIG11aGFtbWFkLm5hemltLmFtaXJ1
bC5uYXpsZS5hc21hZGVAYWx0ZXJhLmNvbSB3cm90ZToNCj4+IEZyb206IE5hemltIEFtaXJ1bCA8
bXVoYW1tYWQubmF6aW0uYW1pcnVsLm5hemxlLmFzbWFkZUBhbHRlcmEuY29tPg0KPj4NCj4+IFRo
ZSBBZ2lsZXg1IFNvQ0RLIFRTTiBDb25maWcyIGJvYXJkIHVzZXMgYSBHTUlJLXRvLVJHTUlJIGNv
bnZlcnRlcg0KPj4gaW1wbGVtZW50ZWQgYXMgRlBHQSBzb2Z0IElQIGJldHdlZW4gZ21hYzEgYW5k
IGl0cyBQSFkuIFRoaXMgY29udmVydGVyDQo+PiBwcm92aWRlcyB0aGUgUkdNSUkgVFgvUlggY2xv
Y2sgZGVsYXlzLiBEb2N1bWVudCBhIG5ldyBjb21wYXRpYmxlIHN0cmluZw0KPj4gZm9yIHRoaXMg
TUFDIHZhcmlhbnQgc28gdGhlIGRyaXZlciBjYW4gZGV0ZWN0IGl0IGFuZCBjb25maWd1cmUgdGhl
DQo+PiBpbnRlcmZhY2UgYWNjb3JkaW5nbHkuDQo+IA0KPiBMYXN0IHNlbnRlbmNlIGlzIGNvbXBs
ZXRlbHkgcmVkdW5kYW50LiBZb3UgYXJlIG5vdCBzdXBwb3NlZCB0byByZWZlcmVuY2UNCj4gZHJp
dmVycyBoZXJlLiBJIGV2ZW4gRVhQTElDSVRMWSBtYXJrZWQgdGhpcyB3aXRoIEJPTEQgZm9udCAo
YXMgYSBjb21tb24NCj4gbWlzdGFrZSkgaW4gRFRTMTAxIHNwZWVjaC4NCj4gDQo+IEV4cGxhaW4g
d2h5IGRldmljZXMgYXJlIG9yIGFyZSBub3QgY29tcGF0aWJsZS4gWW91IGNsYWltIHRoZXkgYXJl
DQo+IGNvbXBhdGlibGUsIGJ1dCBkcml2ZXIgc3RpbGwgdHJlYXRzIHRoZW0gcGFydGlhbGx5IGlu
Y29tcGF0aWJsZS4NCg0KSGkgS3J6eXN6dG9mLA0KDQpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcu
DQoNClVuZGVyc3Rvb2QsIHdlIHdpbGwgcmVtb3ZlIHRoYXQgYW5kIHJld3JpdGUgdGhlIGNvbW1p
dCBtZXNzYWdlIHRvIA0KZGVzY3JpYmUgdGhlIGhhcmR3YXJlIGRpZmZlcmVuY2Ugb25seS4NCj4g
DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0KDQo=
