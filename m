Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013048.outbound.protection.outlook.com [52.101.83.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836A735C69F;
	Mon, 28 Sep 2026 08:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582984; cv=fail; b=WpozfuTA9DGlrUCWhlcXRcMB+Y/Xc/Y7BmjiovsG98rGajx0C2YPv5FmP5sNk0gYWIeSl7xwSzA7oF/XgCBSUPzOFem2RoC3ZP5Fc58ewF1LmrLxhuu0S8O5OE0dXGOL7fMx/yKA5XN8Bk4arFVS3GnZBxiG630fK1Q842kkXsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582984; c=relaxed/simple;
	bh=GTM6MPQ3xmcIms58QSPTSDHMI9maet9qUJEW7AVP0q0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=thAr4v9eDYWxM35G/tWGCrwAc5rgAxkDGSG2rVfwpb7wMimPSfeW9802Kf2z/vrgeetb01pKpKoGR8oolv0xF4COcxVEmDRQJ30dYqlSTWMfO5Tx3FSuAL6OHIqzKlfRMAVVb0VbHf7ZJsuMy+8EMxCb92xT8xO2jqGU40UkCxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=NgbY3P3L; arc=fail smtp.client-ip=52.101.83.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="NgbY3P3L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fh1JXVEYiXO55xRSUOPWb4+BGfk4xK3gFQGABbIi/+14YZBS+A04Vbq+3FcIrOhUBzEkxoAxBXTNjEc5fESN7vlPoGaJkSP4+79jUSB/LaO/yhJkNEC/Z5bU6HsjoU5AUveTgfoHNcY16ZhAX2CkwiogIHEWaN4oSTHQucoGd4I82mLEXHofh+eZjfd6Oa+EAk/rDFKsjcpY/+6NpO6gyjYs3IY7xk//UwjtVNOQY4C6n1uq8G9uBBYEQ/vi3/5dQWUVvkQKRA0F1H5k3/286BdDByQ5/Q/5JT0MjnPi2dtoOZmQAnuGvJHbjFy39Bk+6stAiJXr0gZ4mG9oW1b+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTM6MPQ3xmcIms58QSPTSDHMI9maet9qUJEW7AVP0q0=;
 b=gaAp+++yYt5fY/eUli0dUn8hdkMqUMaVxVj61qJF49o7Lr1V9IIiTbICnFms1FI3PYzK8YMSBkuYv5PHL835YpBidWCnFj/aP6i6dq5LCjpZ4sMKaeLCoXrtDo9ccbHPMZ+rYHPlGgqq3OFoAHdZsLwZ1ONEbxZgesT7Te9Z/WNqIw/CjJpbposFpb+bLaLnC1Y0krznikwpqI4dNj5WtYUqb34JZRaa/wr0DIfhKZJVbMSgU0WoWzS961VuR7lrU+wiQbwzpDD8iIVwWGSs6MWeXAuzv3P8ZzybbS42Itpf4LyxgbUO76xVD4GOVbdmdyBZVhYhX1ApriEygy0sUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTM6MPQ3xmcIms58QSPTSDHMI9maet9qUJEW7AVP0q0=;
 b=NgbY3P3LUDodr23NC2RiMUzy4LC4EOGpjv4hSjDlampGsKYhU/skybIpGrrew5bUHgkYPzqndNQ4GR1YENTxbaQw2o9Om53Ml6bHWBLM9OUB94fJUCQ9tqhWuqu6tVHNrGvoAf2n+5z63ASVC9FFjNwiPIb1PfWmmEZKL6y2vTIMIPS2ws/Stqsgt83AGhYSnojSWfRoC7WG9MKDT+3HUbV48udubgshIxFOEa6eJYw+FqSNUS2kt55vCuaFt/QTokPaiSvkuyd177wsQlDTwfKun8le1e8n9M7l4kJM5B9jPFoqcv+LdgiGILiTDDpRMy0PIlaVsD63Q334/tJnaQ==
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:617::19)
 by DBBP189MB1307.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 08:09:38 +0000
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3]) by DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3%3]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 08:09:38 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: =?utf-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>
Subject: RE: [PATCH] tipc: prevent GCM nonce reuse on peer key changes
Thread-Topic: [PATCH] tipc: prevent GCM nonce reuse on peer key changes
Thread-Index: AQHdTGJAYnXDVfR+i0mBwM/I1X2APrbjprMw
Date: Mon, 28 Sep 2026 08:09:38 +0000
Message-ID:
 <DU4P189MB375013802A953EFC4EA7DECCC68D2@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References: <20260924202105.3722778-1-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20260924202105.3722778-1-Jeremy.Jean@oss.cyber.gouv.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4P189MB3750:EE_|DBBP189MB1307:EE_
x-ms-office365-filtering-correlation-id: c9be3d29-966a-4f71-2dd1-08df1d37d770
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|38070700021|6133799003|10067099003|5023799004|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 ywVv7ZPT2aj2ALoItU/6ZYDrcq6SsE39Y9k+ezqx90XbBOAC5fk8xJUZ4goR9/RGbnEbG6hXyyZDgAa34XTGRI0nWtY1H1zoN9O+773NJC7msOA34oevqKNW+oLYXcd0FrIctwCRWMM9g5HzA1TH4Nl7J8sS1+BxNvW6KB0jH8PLKUZ4E3Ncf9YDzokIZ1U0mecsCmD4Uuakh6T5bjDc/TwavxqZO4YyulULySJONUR8aVumqHrX2W9h7fx9/qcm/HhwxhErwVISTtnoaaHGZS2KK0W6HT6wN6hh6JpltEi0De3SApmG0XavUJanNnMLoKWaOChhySK4PaopmGI9flogpjhunyc/Bf/lTL293U2bnK0uGg/4iE+yJjxPGS9q8ZABSyisDwE3JIsXqhaHm7EiLHjBSROiN+XAj5D2fUdI0P8t25Tt6oqRZlTLUaxl005OenM5+3TEZc2G1Z5oDTc1IfUevIncEJy5E2YSLOllh29vUkRBv6psxhsDVyc89hs8e50DcAUybHp0RZ4iPP3XYs+xiH7Ek6Idzl6MunrrRFbocmFhTR6Qu6kaXc5JT2T0qs1UW3BIa5w7hfcIKV2zw/Mk83baX4zG5KfxiPQG0VzatyBtogib13TeU1WwrhxGVayolYxwxJ1cq4XrL1dyifexClBICtfjjU67LVBFdzi0/nDXrX2nZCU7l/vBZf1Pebv8UENHFBsQcn6Xbk7TctqTpS4whVPTBBBS47M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4P189MB3750.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QlZ2anVrQnhlcWtqNWQ3MUZiSys3dEpxRmM1Mi96RXdFeWNTVTFNTTNnb0Vn?=
 =?utf-8?B?bDVDTWN0SmgxZ0ljQ3hSWS9qbTlDa0JzUFBONXFqdVlvWm52cU1LcnFnbXNG?=
 =?utf-8?B?dzh5SU9manU4dW1nNDQ1T0FHdUFLTEFBeVI4QmFWejZ6YXBpTzU4WXNodSsz?=
 =?utf-8?B?Zlp0RlhRS21BL3JEM1pOY0hQbnBMQkEvTEMwekNRMm84NW5JUkpaZG1vK3R6?=
 =?utf-8?B?UFB4OXpXeEg0NVZNeStBZHVxYmc3Y1NFQ0pIVmtlZGw0VXVNd3Rvd3htTjJW?=
 =?utf-8?B?TWZjR2EyYzI1VDE1ampBWVpyZGZlS1VBVEs3dkk0RVNvQlNYTVJSeTkyVWsv?=
 =?utf-8?B?dmQrTUtvaVgrWGx1OUVMQzBOZ1padmhFZitBN0Nxd3MxRGNDUUJ5Nmpud0FE?=
 =?utf-8?B?U3VGZlVLTk5ncEpldVA3YVM2RDU5U3BrNVM5U3ZsNDJhTVBEbDQrc2M1RHRv?=
 =?utf-8?B?amNFdGlHblZBWWxpMFdmWE9hOGY3MlZ5dlpuU0FaZjBFS0daMTBweHcxdWIv?=
 =?utf-8?B?RFVvK1F2WXQzdjY5cE1pSCtScEJlSGZrVHl5VDRZUWI5UTFIRFd4Wm0wSmJw?=
 =?utf-8?B?cisyd2k4SWRRRTd2eHgxRC91S2Q3UXU4ellYYUNYM05OK0NoUFpnOGRSekxH?=
 =?utf-8?B?anpXSWcxcVZOOU44NW9OS2xsRnhwK2NOZG9COFJtL0ROUkNVcTljcnFtaHla?=
 =?utf-8?B?dy9CQVRHR0lJeTVDa1B5VXJYc3BGMGJtYzM2RlRYMVhlTThoV2RWc0ZzWW10?=
 =?utf-8?B?WHVOVHJ0dTlsY2I5YVExRkQ4ME42anliQ2ZTeUVNSTlQNG9QVzhDekZHakFi?=
 =?utf-8?B?Zjh5eEVETkxjT0RjVktyRUFLUmsvTDNSU3Z3OGd4c3BlQlhEbFpndFcremxv?=
 =?utf-8?B?VnBTRG5SaHUrRERiZ3MybS96NzJaa3NFNi84RjA4UzJXbUVOUDQ3dEtJOUQy?=
 =?utf-8?B?YVUzSzhTNjZ3TEJDb1F5NkdtSENnRit4clIzWHYxNTZpdDVGZVpuaTUzektY?=
 =?utf-8?B?eUhKN3NZL0NpbVRJYlBLQmR5SlIvN0kvcFp6TVlFOTg3SFBxaXEwNW14SmdI?=
 =?utf-8?B?T01IMzgrUVZUdDBqZjBvMktDR3IwNGthOVBHM2YxMHNDM1RROG9JVTRxNDNJ?=
 =?utf-8?B?THZYVmFQTVlFZkJzMi80MU8xQUsrZGQ1SU1Pc01YRHBKdUJDSzhzWnJMd2Fv?=
 =?utf-8?B?WnlydXlzWDludVJNNHE5M1VXNFJyYnJBM28wMEZVbDZUR01IZkhRdU5jV3g4?=
 =?utf-8?B?Rjg2SW5yVW51MzIvdGxKaW0wVnRWWm0wajQ0RHdWVk5KZXhJZWIzWFRKNko1?=
 =?utf-8?B?K3lDVU5uZHg4UitmQkZDY2o3TkFGMis0L0pQMkRPWXlnZ0hua3phSjBwSE91?=
 =?utf-8?B?UlZUb2xBK0d6N0lqd2oyMzlEdlZJT0pTR2ZoVGZLU3hPNzN3ZjVRMS95dDhQ?=
 =?utf-8?B?VEMwRTFBNnptYTJQZmgxZlhlQVR3a0JjZEttUHo0SEN2ejFWUU43V3RIa0xn?=
 =?utf-8?B?STAzTVBRc0dDR3U2Y2hkWXhSZnN3dlhobTJyNzR6UTROeTcyT1V6cnY4cmdw?=
 =?utf-8?B?VTIvMTZDMGN0V2RWeVQzdFFTcXc3ODJLL0hpV2s3bFhpV1Q3OVFPWkl0d0or?=
 =?utf-8?B?NFFmVlNFaEJUb0w0NlhqNU9IVnk0bS9GY1JVbXFNMU9BSUsrbHlYSk1Yb3lG?=
 =?utf-8?B?eGtGYmYyWFRKREJoV2VDcGIzbjcxVHA3TkE5a2NsRWV0eE9iS3htaS9XeG5X?=
 =?utf-8?B?czN6Y0dBYWlHOFpMTno4NGFaQ1pwRnhFbktVZEpsV2IrRmdITVd4czhsWEM4?=
 =?utf-8?B?Tnc1TmtIU2sxYlExelpNclB3UWF4OERUbjVrYTVQUHlQQ1dBMmV6Wm9uTGM2?=
 =?utf-8?B?WHlFT1F4eStzOGEvd2UvRGRyY0VjTk9MVlRNRCs2SmRDU2dlTE1JRUdIcGtw?=
 =?utf-8?B?NlZtTTlKaGdxaVlxZCt3K0hTWWFkTU5TdUV5dTVLdXQrVDhZQ0h5SnZVMWc2?=
 =?utf-8?B?VWRQOVlLU1ErOUViVnd0amFnMnJGM2JsUGVtOUdGTFhKY1FsRXhqRVByMXA1?=
 =?utf-8?B?eHNqNWUzaHVUTDlockdRQVIrbTdTOEpOQmxreFRUMHJ0L3UrYjFDTktadnox?=
 =?utf-8?B?ZDdhdjRiNU5QYlg1U2JLdFpSa2trKzNDejZ6cmFZTWlrM3VkTzBTWCtHSVMr?=
 =?utf-8?B?MCtmNlY1b0RsVlRaTStpaXVaTSs5Qi9qK3hRRTF0TmsxK0RvNDVxZlRwODRi?=
 =?utf-8?B?dk1hK2tmRkVXWW5tSlNRMnpDNWNUNmRiSU1mQU5CdGQzM0pLWmJ6UEMvcFhy?=
 =?utf-8?B?alYxMWtUVnA3cWNwVU92bXlqK2JjYnJjTWFycy9WTFVSSDV5TlBlQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c9be3d29-966a-4f71-2dd1-08df1d37d770
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 08:09:38.4164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guTQ8743rVcuXAEoOCTaHVhKdU5k4CdtXxZazvcdClyjsuJzsEwA3wuJns1DJ1MjJ4DlEE8FTnXj341Bv6wrEGe+3Zb/X5V7JIb351Y6LMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBP189MB1307

PlN1YmplY3Q6IFtQQVRDSF0gdGlwYzogcHJldmVudCBHQ00gbm9uY2UgcmV1c2Ugb24gcGVlciBr
ZXkgY2hhbmdlcw0KPg0KPlRJUEMgY2FuIGVuY3J5cHQgdHJhZmZpYyBiZXR3ZWVuIG5vZGVzIHVz
aW5nIGEgZGlmZmVyZW50IHRyYW5zbWl0IGtleSBmb3IgZWFjaA0KPm5vZGUuIEluIHRoaXMgbW9k
ZSwgdGhlIEFFUy1HQ00gbm9uY2UgZm9yIGEgcGFja2V0IHNlbnQgdG8gYSBrbm93biBwZWVyDQo+
Y29uc2lzdHMgb2YgYSAzMi1iaXQgcHJlZml4IChhIHBlci1rZXkgc2FsdCBYT1IgdGhlIHBlZXIn
cw0KPmFkZHJlc3MpIGZvbGxvd2VkIGJ5IGEgNjQtYml0IGNvdW50ZXIuIFRoYXQgY291bnRlciBp
cyBzdG9yZWQgaW4gdGhlIHBlZXIncyBSWA0KPmNyeXB0byBvYmplY3QuIFdoZW4gdGhlIHBlZXIg
cmVwb3J0cyBhIGNoYW5nZSBpbiB3aGljaCBrZXkgaXQgdXNlcyB0byByZWNlaXZlDQo+cGFja2V0
cywgVElQQyByZXNldHMgdGhpcyBjb3VudGVyLiBUaGUgc2VuZGVyIGNhbiBzdGlsbCBiZSB1c2lu
ZyB0aGUgc2FtZSBUWCBrZXkNCj5hbmQgc2FsdCwgc28gc3Vic2VxdWVudCBwYWNrZXRzIHJldXNl
IGVhcmxpZXIgbm9uY2VzLiBUaGlzIG5vbmNlIHJldXNlIGJyZWFrcw0KPmNvbmZpZGVudGlhbGl0
eSBhbmQgZXhwb3NlcyBHQ00ncyBhdXRoZW50aWNhdGlvbiBrZXkuIFRoaXMgbWFrZXMgZm9yZ2Vy
aWVzDQo+dHJpdmlhbDogYW4gYXR0YWNrZXIgY2FuIGV4cGxvaXQgQ1RSIG1hbGxlYWJpbGl0eSB0
byBhbHRlciBjYXB0dXJlZCBjaXBoZXJ0ZXh0cw0KPmFuZCB1c2UgdGhlIHJlY292ZXJlZCBhdXRo
ZW50aWNhdGlvbiBrZXkgdG8gY29tcHV0ZSBhIHZhbGlkIHRhZyBmb3IgdGhlDQo+bW9kaWZpZWQg
Y2lwaGVydGV4dCwgdW5kZXIgdGhlIHNhbWUga2V5IGFuZCBub25jZS4NCj4NCj5Vc2UgdGhlIFRY
IGtleSdzIGV4aXN0aW5nIGFlYWQtPnNlcW5vIGNvdW50ZXIgaW5zdGVhZC4gQWxsIGVuY3J5cHRp
b25zIHVzaW5nDQo+dGhhdCBrZXkgb2JqZWN0IHNoYXJlIHRoZSBzYW1lIGF0b21pYyBjb3VudGVy
LCBzbyBjb25jdXJyZW50IGVuY3J5cHRpb25zIGdldA0KPmRpc3RpbmN0IG5vbmNlIGNvdW50ZXIg
dmFsdWVzLiBUaGUgY291bnRlciBzdXJ2aXZlcyBrZXkgYWN0aXZhdGlvbiBhbmQgcGVlcg0KPnJl
Y29ubmVjdGlvbiwgYW5kIHBlZXIga2V5LXN0YXR1cyByZXBvcnRzIGNhbm5vdCByZXNldCBpdC4g
VGhpcyBwcmV2ZW50cyB0aG9zZQ0KPnRyYW5zaXRpb25zIGZyb20gY2F1c2luZyBub25jZSByZXVz
ZSB3aGlsZSB0aGUgc2FtZSBUWCBrZXkgcmVtYWlucyBpbnN0YWxsZWQuDQo+DQo+VGhlIG5vbmNl
IGZvcm1hdCBpcyB1bmNoYW5nZWQsIGFuZCByZWNlaXZlcnMgZG8gbm90IHJlcXVpcmUgY29uc2Vj
dXRpdmUNCj5jb3VudGVyIHZhbHVlcywgc28gc2hhcmluZyB0aGUgY291bnRlciBhY3Jvc3MgcGVl
cnMgcmVtYWlucyBjb21wYXRpYmxlIHdpdGgNCj5leGlzdGluZyByZWNlaXZlcnMuIEEgcHJlLWV4
aXN0aW5nIGNoZWNrIHN0aWxsIGludm9rZXMga2V5IHJldm9jYXRpb24gaW4gdGhlDQo+dW5saWtl
bHkgZXZlbnQgdGhhdCB0aGUgY291bnRlciB3cmFwcyB0byB6ZXJvLg0KPg0KPkZpeGVzOiBmYzFi
NmQ2ZGUyMjAgKCJ0aXBjOiBpbnRyb2R1Y2UgVElQQyBlbmNyeXB0aW9uICYgYXV0aGVudGljYXRp
b24iKQ0KPkFzc2lzdGVkLWJ5OiBMTE0NCj5TaWduZWQtb2ZmLWJ5OiBKw6lyw6lteSBKZWFuIDxK
ZXJlbXkuSmVhbkBvc3MuY3liZXIuZ291di5mcj4NCj4NCg0KTmV4dCB0aW1lLCBwbGVhc2UgYWRk
ICduZXQnIHRvIFtQQVRDSF0gZm9yIGJ1ZyBmaXguDQoNClJldmlld2VkLWJ5OiBUdW5nIE5ndXll
biA8dHVuZy5xdWFuZy5uZ3V5ZW5AZXN0LnRlY2g+DQo=
