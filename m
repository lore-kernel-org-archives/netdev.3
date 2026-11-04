Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.111
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793791322;
	b=GX7ehMQldNnKPhuXgS0RcwgbCfuhnW2k1OZWcxGUfyysgSGw/U3Zsi8COwlG54dTsJPQ
	 beKXSKNATgeyAfYLOfiARge7fh4G1j9++6G9mjyn36JobXPu6qV9laCZR61WmvWJdxwce
	 K00kLfZ0saF1rt8I816AasRQHkyYkj9HP6TxSeOa84IyCBo+9eNeCXf0EBqz+rZPPYsxF
	 MoDMEBv+B5kNyf44BtJE85h5RlAwBrCsiXYaFTD2FRGDPt3lYP6S5hIv7g/gfBh85kdOP
	 v5xL0LuzSo9HjjK4PhoILO6tU83inDpiqYTZD7Zgzi2Mh8B81281x709qP4bhfUJIvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793791322;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=xUI1L0eIbeRXJqhgQBI4Xu03a/a6YnKmEf6JUXO5Y5o=;
	b=4n+UhCYSF7AoNdYmPDnV/ef1KuJKGFrwmpu5Jf5bt8/PxOkGTOS89hVDTPOg82LXjpIo
	 L9i8fDdfLUv0vplYQqdwRHnsQM0gEpFG/6+2RGJIIUaR/wYYMyc68HX7Mm4QoA9xdOxQj
	 rlvgQWq1kRLr7JnXpfEcdvBZpUps5xO29fqqynQMgPbDyBNgUPQFNEyPFBmZeUYf4rlOQ
	 spAfchAmOdNKxxDzJPy31lfemge3adCOjt3UVzdFRGojKj1zLnr2sMrZpUKlUDqnbg+8D
	 MDEP8n0Ezr6E5k1n23hyyO4SV7oB3/qXDVU6KwjpVvjQngTWcrY4izuafh5OypNy3RA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aspeedtech.com;
	spf=pass smtp.mailfrom=aspeedtech.com;
	dkim=pass header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=fvjUoIjg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.111
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022111.outbound.protection.outlook.com [40.107.75.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2544606A31B;
	Wed,  4 Nov 2026 11:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2544606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=fvjUoIjg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rh0cS4DPEzO/IWV57i3Ns9MGW+FjQcethqsg/lyZmgazcMDo9OSXlG8fHOtissKfTOzlIOBvGqgQSNuMJ0D6t10cxfc75DNmlOl8vHBinwUWoMoN87m3DFmqMmLSIj2YPKQ6txBizQa64poumQI9vDeZGt35IVABey7LZvty7meeYG5ecoCZIMSFq3jieIMB7cAPvsOfyzuxIbO7732TqO3bI2dAwoJM6AVeu/3AUKI/c0sY0DpN8IIwje66XKsT/ttDv1DRYB12E3LhH6ywmQ3ofJxwofjuO+xJTtFCGjoSZx3EXuA0yhr7PYxY3fgHKwluaKpyrQRM9gzGKWr3Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUI1L0eIbeRXJqhgQBI4Xu03a/a6YnKmEf6JUXO5Y5o=;
 b=iMs3K1dqnjkErVYbmI95IWGWLogme7k02ioBlovs/5jTZbRn+g4K2HF34cXHTBg51JjvlAlIsOBwsLWTQ9LBCiDEtD4mOyyRRkNxI93UF2emziaDa4AziZxQY2TYNI3v/kVsge/XZ/GcQuPT1gjvBFaznPh4dSTXRxqIWOOG/uRSiAtqZC9jUti7wDVhxMhz47/zpMjhg80nQiQn0LZPnLrzuM7CgPATHzebl7qBpNNg9CgSKrZUjXPNbRboT6jJxS+ZwF0Y7yAoyQpF/kehfnq2NAMBNvT5UhA4oWdcdTUOxIHaaoa7y69NC0F/sODyMVDYw2JvF6n7u32Cy9StlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUI1L0eIbeRXJqhgQBI4Xu03a/a6YnKmEf6JUXO5Y5o=;
 b=fvjUoIjgT/yAaFDo0hiY40SQ1HwKvGjl74x4hLHr/y0lNwh215c1Y/mThzZzH35h9nfBfLBMpfLzOkaOd01Vwtt6O5NmWWt3T5ZI+23yCA+nhAKg1yILnBiBgAyo9gUoXRuGRoIJkwzB7ToOYNLo7yGyNJtNQmtYqAcmqnOdsr7ozqxYYuRSMkKYhrfKdG5MGl180cRWqWQQ6RcIy4x1NmC+3XXKeQ/EcNPE4IaKkABmbIpS8uA+WauwNcmxpi4a13xQIiY+Xi2H+K7fA1JSoil+/mz2FtAVnHtmZZXmMRa6si/+sYzZvF7s/mnTrG4nGzqsDdBnFGuT7JV8S1WI5A==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYZPR06MB5298.apcprd06.prod.outlook.com (2603:1096:400:1f5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 11:21:58 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%3]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 11:21:57 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Po-Yu Chuang
	<ratbert@faraday-tech.com>, Eric Dumazet <edumazet@kernel.org>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggbmV0LW5leHQgdjUgMS83XSBkdC1iaW5kaW5nczog?=
 =?utf-8?B?bmV0OiBmdGdtYWMxMDA6IE1ha2UgQXNwZWVkIGNvbXBhdGlibGVzIHN0YW5k?=
 =?utf-8?Q?alone?=
Thread-Topic: [PATCH net-next v5 1/7] dt-bindings: net: ftgmac100: Make Aspeed
 compatibles standalone
Thread-Index: AQHdbBy8iK0bacl+gkmJItDgUE8TnbcduOEAgAAHQtA=
Date: Wed, 4 Nov 2026 11:21:57 +0000
Message-ID:
 <SEYPR06MB513412E04F4F0AE8ADE0375E9D682@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20261104-support_ast2700-v5-0-44057f4dde75@aspeedtech.com>
 <20261104-support_ast2700-v5-1-44057f4dde75@aspeedtech.com>
 <20261104-helpful-courageous-hedgehog-f05bbf@quoll>
In-Reply-To: <20261104-helpful-courageous-hedgehog-f05bbf@quoll>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYZPR06MB5298:EE_
x-ms-office365-filtering-correlation-id: 55800f3b-f846-4b78-5645-08df3a65d68b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|22082099003|18002099003|10067099003|56012099006|261009223027099003|261022105027099003|4143699003|38070700021|261026140227099003|261026121527099003|261028144727099003;
x-microsoft-antispam-message-info:
 Z2QrUVJfsT3XMFg4ZN5q9KI+FSRjRWo93SdjbCdTc7Ajw48jlCDO7pE8Fl1YqWYiQe4slijzcrcsuMF50ii5/5ZN0j0YOJNIYv/GkG8SQPKMBRqqEXYNo3tLnUbMeivFq/sljqF9EiI2HlK1O2LFyQty1rTUThGJpPuLPbuuFSVSTDzw6/qlS7SH8N2MEUeq+iZulQEEIt1vgGC1eIAawwc8scqHHVzmt9T+a0o+22I0PPp0N+irJ/XxRPOH3CAKhN3nVA0YOucZqCjuL5Z3x45k2FsayZz2vtjH9NHIRkqZVI5lqX+mlmj6QrmdEwRGQROQp6ojomc3Iapgk9DeVJ0IZTfPjIZ0EzjtZ0N/kwdWeWTDbD+zenlGRrb8Ma3bkbVYPbKj4PBE6gSfqEZPjoFTJEQwCbRo2Lxdzh5U4TIyZhO6E8tSI9XbMPqjW+dyjdJxkNN33RvMPuOjztAkPhn2tgF9Xd/OyAjB5vAmHNIsl7pMZVQkamJgjcXyK82c/mcvQQHCi5h1+m1fSsDnpe3cEDIuxyGHMVch5c+m7R/uDB+mA2H9DpnkDiPoBAQXUSyb9ikAC0zwkAXbd8UbjTZcbpE7g9e+yNITX278t73SzyDHsAy9+LvfueIDrOew1iY3D/hJW7jdnKpJtszqwX8p91JK/JSe7xM9kANM7aUh/bVlcF9mzEvGN155znsaTOwuEeuL8K8FFfiDZBAJLA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(261009223027099003)(261022105027099003)(4143699003)(38070700021)(261026140227099003)(261026121527099003)(261028144727099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dTludEtvVENHSjB2NGtzb1duUmVDdk5TMjdzS1d3cHdvS3htalBKMytRRnFN?=
 =?utf-8?B?SW4rSnhTYUNucXVHbDFvaHhpVHdrSVFxUDNYdWNjQ2VwaFlIZTc4TU0wMm16?=
 =?utf-8?B?a3NZRFN6MmliQldMQmRGVDE5TCtwT043dUxlYWxPbC85MTN5ZEx4ZEVJYmtC?=
 =?utf-8?B?TDJYRDZHWk1zY3pvNU4wcUVOeVdWUU1vMmRyV3NOdDJuams4VGhDRkM5UGEw?=
 =?utf-8?B?dzB4RVpRZVo3T0tieEtXd0NiVkJ4QTNIM05qUURSNE1SOUd4MzF0dnIvSFhV?=
 =?utf-8?B?b29UMjRuVHBUYTl0YzFPTllqY0w4YzVPYWlETjJiUkw5WW4wNjRpMnkxM0cw?=
 =?utf-8?B?MTUzcnRVTGIwUjdQMXd1bGJ2N29pWjBOdlhmWDlYeWdsa1RseVFQVE9GelVw?=
 =?utf-8?B?cUVtVGVhNzRhd2NrQzN3U0szVUUrNDVnWnN2VllhN2RVazVwazhrUWxpUHRx?=
 =?utf-8?B?MFdYTlBRcVFIeFJraUMwNm9vTFpSbm5lM0k1bVBJQjh1cm9yRVlFM2gyYXpC?=
 =?utf-8?B?Q3hwT1RjUDhRbTlDZE5rZDVrTnFqL01QVzlVUSt5VjVZSS9EQTNINnhFRGRr?=
 =?utf-8?B?MFNnV1FrOUJwZWN0RytOL29oSDNsRHh3VnZIMlpuMnF2cGZLYTRMaEtRa05m?=
 =?utf-8?B?dHJHMnVDRTZXQjVEZTFOUlk4U0c0RzMzeWhJRVpWWmZCN0JvZEJDUlVZRmc3?=
 =?utf-8?B?bEJUelZKd1RxRWFOWFJXVy9WS2dMNFZ1RWV1NVkyRnZBbnkvSVlOR0tMdFNt?=
 =?utf-8?B?aitLcUZYbk8vbWhvZ052cGltb1B4V0kvS0lTRWVKSjdmUUZsMjlCamkvZFpQ?=
 =?utf-8?B?WGdId0lvS2JHNXU1WW44UkJlSXBFRnc4ZktBNFFkSFFWQ3VFS0VKV1RxTVlG?=
 =?utf-8?B?RzlMaTIyeXVTNlh3SnhBYWppVFZsN0JZdVlFOEJzUHNjbmlaQ1hsVE9sbzR2?=
 =?utf-8?B?VCt3RXJ4aWgrUXhuTHRBTWVqWFZMWGVyODdSZUZjeWJaVVU3dFh0VHptV3B0?=
 =?utf-8?B?aTRKZTNCb3JUdmoyVnFpSm12b1J0RHhLWlhtaEtXNEx2Y3BqMUhFUmlEUnRU?=
 =?utf-8?B?ZXpMQ3NuNEMrY0V2NjBXMmw1TnMvWUYrZXNUSDRsamQ1N0xFaXZkVmtRNFVn?=
 =?utf-8?B?Ukd4d0NYWW5iR1d6OU9Qa0kxbHkvTlRmd3VQQnJrQ0QrYjZsNWc1L29qZlg3?=
 =?utf-8?B?MnBCVWQzekpwMzRHSUJId2MycEZzY3ErWHV0RFhJckpmbXRqWUhtSG5MUzlK?=
 =?utf-8?B?cHBuTDFBb2xvdGRtRzhGcDRXYXY2VUhNMkFGZ2VPYmI2Y0JMdzdyNE9ZNHNR?=
 =?utf-8?B?RTlXZkdJcGZyL1NtWHdMRXM3dVRJcFNldnNZenlHUHdCVWFWMWtob3pPb0cv?=
 =?utf-8?B?M1ZBdTdaU1Y1WmFpYUlxZUNuV05xdHY3ZzJRQ3NPRkVBZEJOUytYSVZOVlFV?=
 =?utf-8?B?dTU0cHp6d092eVI2R3J5ZkU4N3FkU3FZT2xkSUxvMk1Tc3dlQTZaL3ZzMDBI?=
 =?utf-8?B?OG45dU8zWFRGd3VETFdDZ2QxNndpa2xWdEptMytJcjdISGE4QktXQUozZWdv?=
 =?utf-8?B?UFk3S1FoR0FwRFROdWlUejJCSHJOQmpTUUVJd1BrcXNLdFo2VHUyOTVJUXdE?=
 =?utf-8?B?YjQyeUxOVXF5bjQ0Q3hYVk9tL2ZiTWtPM3R5RGt2bFhWWjFmemdUZkFicitI?=
 =?utf-8?B?eDRVRDYvck5PclFWRGhFSVp3by9KMDZDbEIxSVJocGpEdHJETGZ0S1Yzc2lo?=
 =?utf-8?B?ZUVsL1lya1VTc01NT0d1UmYwV0ZGaWxqa1NNS2pvWm5kQTQ4VUZQU0p0N2Rr?=
 =?utf-8?B?YW9YSlN4aDlabEkxY3BXdjRXWUZ2d1BsR0ZwbFRBbm12WWRyQUNjM2pMeGtT?=
 =?utf-8?B?L2VaUEZhQ3NNUWdQQTlQTUpXcVhyOVpqV3NHVTNjaEJMdE1kYWJXUWNNYkVK?=
 =?utf-8?B?Tm9Rd1l6bnYwMTBKQlpRaGJUTDZZbEhUbnRkNjZPWlJtd0pCSHZFZFdmNUR5?=
 =?utf-8?B?ZTQ5ajY1TkZGcVRkWTBHVWMwdFhCVXJsQzdtQzdFaXRBS1JYOG10T1orTE12?=
 =?utf-8?B?ZFJzVS9jUFIrM3IrL2Fqa2FNNXcvVXlzUksyUDVqb1REMGQ2SG9kWERhK1Uw?=
 =?utf-8?B?YkZzcVhEMVFwZDJzRkxud0RhM0FCL3hjZ2tlbzU5a3VEbm9pbDFKL0JMNkl2?=
 =?utf-8?B?Um9qZUQyK2hwOXNHNTNKN0laYXNVc3ZIUHhPVXNOWEFEV0FDZUhFUXBmeit2?=
 =?utf-8?B?WUFsWmV4bTgrZlR5UzBzQmo2amFvWmRYSzZrNVBZeWE5L3RkK0cyZVFtT3Ni?=
 =?utf-8?B?ZCtpNE1DMkZzcjNVcStZWklqdmRVbHcvWWVSdmRnbWx4dENMbXc5Zz09?=
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
X-Exchange-RoutingPolicyChecked:
	XX7zzdD+0s5Nu9rpAfHBLLQknP4XMIRxz4d32WFUYANd9DDOMFfVYtQu7fnfqSSadN6eZvrBTFvl2lyaqDjAzkatJOl9m5oa6IPRTCP6FMnKVdmEZ7nxhkLBwkSAOwBa3rr7kR4P1m1EAkjOPOeoJX8hYI9WDBMAYQ9dYLg0M6DT25B/YYbKCNDf/jwLonavOXVU2fzhFkF81taxNfAw6Et7+/GvMmf1aHO2ZABrzotAPQ99t5ebvp1mKvBgrWaoE1Wu9OqkPwWRevOkVubn6RAbSD4ffHZXNahpW09wwJNhmFFOTfF6jSppQxzgM0u38nfJStjaa1hGCTWnu+YyXw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55800f3b-f846-4b78-5645-08df3a65d68b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 11:21:57.5136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 81L5k7G4pv8OJshvc3W+UugFGlBlWdXXvbfdQVxlhIZoU+xwjwE6cuYf+X+CjSWQ1+l3fuyNUDhpESh2Sk8d1MjKqZoBfsXAJrhtqwFTwHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5298

SGkgS3J6eXN6dG9mLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuDQoNCj4gPiBUaGUgYXNw
ZWVkLGFzdDI0MDAtbWFjLCBhc3BlZWQsYXN0MjUwMC1tYWMsIGFuZCBhc3BlZWQsYXN0MjYwMC1t
YWMNCj4gPiBjb21wYXRpYmxlcyBhcmUgY3VycmVudGx5IG9ubHkgdmFsaWQgd2hlbiBwYWlyZWQg
d2l0aCB0aGUgZ2VuZXJpYw0KPiA+ICJmYXJhZGF5LGZ0Z21hYzEwMCIgZmFsbGJhY2s6IGlmIGEg
bm9kZSBldmVyIGJvdW5kIHRocm91Z2ggdGhlIGdlbmVyaWMNCj4gPiBlbnRyeSBhbG9uZSwgZnRn
bWFjMTAwX3Byb2JlKCkgd291bGQgc2V0DQo+ID4gcnhkZXMwX2Vkb3JyX21hc2svdHhkZXMwX2Vk
b3RyX21hc2sgdG8gQklUKDE1KSBpbnN0ZWFkIG9mIHRoZSBBc3BlZWQNCj4gPiBCSVQoMzApLCBz
a2lwIEFzcGVlZCBjbG9jayBzZXR1cCwgYW5kIGxlYXZlIHRoZSBETUEgbWFzayB0b28gbmFycm93
Lg0KPiANCj4gQW5kIGRldmljZSB3b3VsZCB3b3JrIG9yIG5vdD8gSWYgZGV2aWNlIHN0aWxsIHdv
cmtzIGFmdGVyIGFsbCB0aGVzZSBzdGVwcyBhYm92ZSwNCj4gdGhlbiB3aHkgaXNuJ3QgZmFsbGJh
Y2sgYXBwbGljYWJsZT8NCj4gDQo+IEJlIGV4cGxpY2l0LCBiZWNhdXNlIEkgaGF2ZSBubyBjbHVl
IHdoZXRoZXIgQXNwZWVkIGNsb2NrIHNldHVwIGlzIG5lY2Vzc2FyeSBmb3INCj4gZGV2aWNlIHRv
IG9wZXJhdGUuDQo+IA0KDQpJdCBpcyBuZWNlc3Nhcnk6IGZ0Z21hYzEwMF9zZXR1cF9jbGsoKSBl
bmFibGVzIHRoZSBNQUMncyBjbG9jaywgYW5kDQpvbmx5IHJ1bnMgd2hlbiBwcml2LT5pc19hc3Bl
ZWQgaXMgdHJ1ZSAtIHNraXBwZWQgaWYgYSBub2RlIGV2ZXIgYm91bmQNCnRocm91Z2ggdGhlIGdl
bmVyaWMgZW50cnkuIFdpdGhvdXQgZnRnbWFjMTAwX3NldHVwX2NsaygpLCB0aGUgTUFDIG9uDQpB
c3BlZWQgcGxhdGZvcm0gd291bGQgYmUgbGVmdCB3aXRob3V0IGEgd29ya2luZyBjbG9jaywgc28g
aXQgd291bGRuJ3QNCmJlIGFibGUgdG8gY29uZmlndXJlIHJlZ2lzdGVyIGFuZCBUWC9SWCBhdCBh
bGwuDQoNCj4gPg0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9m
YXJhZGF5LGZ0Z21hYzEwMC55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbmV0L2ZhcmFkYXksZnRnbWFjMTAwLnlhbWwNCj4gPiBpbmRleCBkMTQ0MTAwMThiY2Yu
LmM4NzBkZDBiZGE3YiAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbmV0L2ZhcmFkYXksZnRnbWFjMTAwLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2ZhcmFkYXksZnRnbWFjMTAwLnlhbWwNCj4gPiBA
QCAtMTMsMTIgKzEzLDEwIEBAIHByb3BlcnRpZXM6DQo+ID4gICAgY29tcGF0aWJsZToNCj4gPiAg
ICAgIG9uZU9mOg0KPiA+ICAgICAgICAtIGNvbnN0OiBmYXJhZGF5LGZ0Z21hYzEwMA0KPiANCj4g
VGhpcyBjb25zdCBnb2VzIHRvIHlvdXIgbmV3IGVudW0NCj4gDQo+ID4gLSAgICAgIC0gaXRlbXM6
DQo+ID4gLSAgICAgICAgICAtIGVudW06DQo+ID4gLSAgICAgICAgICAgICAgLSBhc3BlZWQsYXN0
MjQwMC1tYWMNCj4gPiAtICAgICAgICAgICAgICAtIGFzcGVlZCxhc3QyNTAwLW1hYw0KPiA+IC0g
ICAgICAgICAgICAgIC0gYXNwZWVkLGFzdDI2MDAtbWFjDQo+ID4gLSAgICAgICAgICAtIGNvbnN0
OiBmYXJhZGF5LGZ0Z21hYzEwMA0KPiA+ICsgICAgICAtIGVudW06DQo+IA0KPiBoZXJlLg0KPiAN
Cg0KQWdyZWVkLCB3aWxsIGNvbGxhcHNlIHRvIGEgZmxhdCBlbnVtIGluIG5leHQgdmVyc2lvbjoN
Cg0KICBjb21wYXRpYmxlOg0KICAgIGVudW06DQogICAgICAtIGZhcmFkYXksZnRnbWFjMTAwDQog
ICAgICAtIGFzcGVlZCxhc3QyNDAwLW1hYw0KICAgICAgLSBhc3BlZWQsYXN0MjUwMC1tYWMNCiAg
ICAgIC0gYXNwZWVkLGFzdDI2MDAtbWFjDQoNClRoYW5rcywNCkphY2t5DQoNCg==
