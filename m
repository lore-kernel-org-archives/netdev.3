Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011071.outbound.protection.outlook.com [52.101.70.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ECB220F2A
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 02:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786329608; cv=fail; b=B7ANKOGGrDKpcCQDcVRkku5sFLHy86vhM1fh9B3XNjgMU1COQ8nshHn68WNEPXY+CMXdVFmM88vq4K4QLzQcK6o17F1FtzDyCbbMjFjXFGJC+e4P/pkxM8m/AYChPYwzCSQHCTdZS/5xdo66SkjKcnD/Z3B0dqTnc0ny2UpMNCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786329608; c=relaxed/simple;
	bh=2i7pQoTdiC9YXydtnT2BsgClyoXvXvhA9BcbX0/tuT0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QDl3yEANETCBVtz6avSKSLELiI5tRp/ZYXOl+RLUurf0exIugW6/fzldO4HRaQtzTLZLjAvKx1DI/imo04FyUVVmwFo4WKouvHGCgqE9cJMHGFPJ6nnWGk2bL0ll3uN+DoAk1j6dzrZ+vWUAPOQQBw/F0zoeyPh08WIj/JJXIsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cN5qyU6Z; arc=fail smtp.client-ip=52.101.70.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cN5qyU6Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1YPsfC0Tuwy0knOTXt5JIT6b8CKes4R9KoICp8Hnye8fpiK5/0MOK74TOEzihp2hR7+vZ+bwAi0HMY1Up7EppPybwT/3eGEV+DLD8jakPg0Zesyno5398of5wYcon9/WJx23pwdRlRx7lRCsjxrx00VZn/2KH5ad6I97XXaH8W2YM8/5B8L1XGz/wdO/KP1OfRJf+gZB9WUfUQyo3r7CjaCFcmuPe9DTOGI5K+++L9puRoNyPkgrPWrajS2D3eGH4aOIh07WcSJaUayFra7+iLE2Vxr69YL4OiDcmuBPXmiPntbA4aCHzRkKOKHaQil5xO/d8HJEO484nw5Jyq79A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2i7pQoTdiC9YXydtnT2BsgClyoXvXvhA9BcbX0/tuT0=;
 b=S8++eWWic8kF+b7XOdJ8iMlIzr1aN5ANP3QnC1mOHvsUO63CaJTJMKyXRqnFDCNHlFy4dTk8MEoOMWOKNOCmCwCYpH1mo5ZD1axavF16Y58CMnMFdIDoJjgvmttcATHK6toihzdIJDZPrKtLZ6Fjj+MURAhxXT2oKTmPXmsl87O681xp65l7CdKD4jvndUK9JRhK66nEI/nvmGOVlAdNaDuoEYSuDe75FFMfBvTFekMfswT/5MOF4GcxL0crlQUgZEPsHeXln2/s4PT1DQdmjd1/Rlv+5+zTzKCzqvF8lxCjbMVTxiLLgj8ydZ2KGqjp2okfvazqGJfFzT8MXVNaCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2i7pQoTdiC9YXydtnT2BsgClyoXvXvhA9BcbX0/tuT0=;
 b=cN5qyU6ZlWGsOaBP3AVf316n4KGfKDD52qIYW4OXPEWZU5cCdg47I7c13My0NtaJiQD7RNPIe0/qmloSCq9yXrp9KXiOiNPk4EB9U2YbwZwFd0ou+bCVn6b51dy49WNuPVlX8UcPfwtJfCvAQ7w0ga+6+vbOsC7Sbby4XZmbHt8/Yl3z4/FeRSLa1VSDPElo72PJPaAR6fOMhjihBCTzfWRbcwTQdfD3D9zoCghOUPRrO/CuZ5O/DdlotsMsfentE4z8Y3eS5a+6oogomoZVvPbIFCj4pxYHt1/u7LEfYQ0Dg5BqCugEPnU9z15f5HcQuDpviwhnHB3WRRJH4lxSPQ==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by GVXPR04MB12265.eurprd04.prod.outlook.com
 (2603:10a6:150:30f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 02:40:00 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 02:40:00 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, network dev <netdev@vger.kernel.org>
Subject: RE: [PATCH v2 net-next 5/7] net: dsa: netc: enable ingress port
 filtering lookup by default
Thread-Topic: [PATCH v2 net-next 5/7] net: dsa: netc: enable ingress port
 filtering lookup by default
Thread-Index: AQHdJuSeO2PGzTYqnEGEbIh6VrsxQLaVDd8AgAGHaAA=
Date: Mon, 10 Aug 2026 02:40:00 +0000
Message-ID:
 <GV2PR04MB11739F27D5C3B374E6667293E88DE2@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260808032146.2335723-1-wei.fang@oss.nxp.com>
 <20260808032146.2335723-7-wei.fang@oss.nxp.com>
 <20260809031905.520531F00A3D@smtp.kernel.org>
In-Reply-To: <20260809031905.520531F00A3D@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|GVXPR04MB12265:EE_
x-ms-office365-filtering-correlation-id: f111cbcd-1ee2-4e5c-e535-08def688ac76
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|23010399003|366016|1800799024|38070700021|6133799003|5023799004|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 QsdoKr3m4Z6FcwR1yKyMvD2kOEQPReBM42a4ZqZe0xaNp6D+TqO2jWXwThHbpYlXx/L90WmQthAtN/2KWYO4zdtDnr/Msd2zL5gSBs3/NfZD1BvYxIF3MhjnS314Lj0acP4HjIpaAFW+olmqsxXPj2pMzPMMzciImVunfTakbFC1iHRH10R2XujB4SKS4jjnxrHqv6U0u+uzaCH0J+wKS4fOgBoQNmS+e1ml5pBmmdWTm4VsEcCCJ/SsmRWg5N9neXRpkbZP+FYaIHvOIwje4S5tpaJ7TRfTqQ8aTX01NIi235Hz1Y+Gcfkt49ILSLAVPSaHfyC5WDatMwxyEJZIBsOCQTQ2c8qY6x3fhjTZOhCQ/2i5ZlXTMaxtp6IS1AvpSRIcBAjC9RJgXqNptcI9OjUPRpGPqKpfEs4aNHj90eBRtgAJYoozqWTD9KJy//wZlgpOsj4/aBiH/9q3Sy5incA+G08Z4skjhZGlcG1ecutBwlvB/A0xdPNV83Ra4yqeMvd0xAR/oCxKcMEZlxiCxftliE41mAN2jpFNOFbINB5FkBh9vYiVri920KuAmKo25tfgt15f8YGePrcc0UVRT7ylnglbWbTw18rR7PlhA9N+WzCrMFhYLWX3G+TtgT28URwkwBeF3IOkzNL+4I6ROb+EKplYIzak6T6IWndUYc7n8yRr0PNkrHnsSy2DeFe2yHDLX6zFaLqqkt6uLB5HuekCdfhAEutppLEvngmPX2c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(23010399003)(366016)(1800799024)(38070700021)(6133799003)(5023799004)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dERDVnpVQ2E4Z3lzS0VBNFJLVVJPUzdESTJKY2RGaHJlMTZFQ0FqMHBNVFFp?=
 =?utf-8?B?NVJ5Y1pqNC9vdnc2b2poR1VCQWJYVlJ6S1didURUb2R6a3ZOQ2NHZG40ZnZO?=
 =?utf-8?B?NHFvQjVQbUxielRzMmZ3bkdYVEdmTmIvRnB5Sk1yRDk2TkNGTnJyWVROa3Iv?=
 =?utf-8?B?ZHVBTXQ5R0cxbVd2ZElRUTZIS1o3US9YbUQwUnNJY3hBQ1NDS0RFWnJUaU9h?=
 =?utf-8?B?Qm8xZTA5UXJYTVNvTzUzR2xob0UybWpyamp2bXc3dk54dzhVVWVLOW5QM05R?=
 =?utf-8?B?c1E3TGthVDk2TU9XanVtZXhaRnlYQ1ArVzQ1czM5UkZsOTFVZWZKRS9iU0xE?=
 =?utf-8?B?MXo0cDc1dlpDMXFKazdkRUYyRWdVSlJuT3FWdjZTMXpUMmk2OTE2Y3ZGS09Z?=
 =?utf-8?B?ZlBZMUNyUTJxcWk3MUVBZVI3czEyNndvRFlKUkNSbi82YWorL0o4cWtnblFR?=
 =?utf-8?B?eTgyS0tZaGpDZWN2bnNhZVl4ai8yUml3MElnSXpybDBJS2pmVk5jT09sRXlM?=
 =?utf-8?B?TlFZV2JENlMyWm15OHZ2bG1rYmc4OXIwRHhkN04zNlFZNDVyZER2V3pZRllv?=
 =?utf-8?B?L0hNOU5TaU10Y1k3TzJqWWQyUTJ5R09YRnF3d2tGR0dVKzVrbjBOZk5adHZ4?=
 =?utf-8?B?b3d2TThuNjRmS01KclNtYUYvUit0WTkwL3B1TUhKMlpvN05OdzNoQjNSb2Z1?=
 =?utf-8?B?V21SNUExZjZ0MHo3dldXbDRIMFVQSXYwSGp4SWFRQ0lRU3p1YStlRit4cm1Y?=
 =?utf-8?B?cHhHZ3J6UUwwVng3eVYyd0tFNnNGQUVHdWlUUjJtaGw3U1g4d20xY1lUZXVt?=
 =?utf-8?B?MFNsbDZkZjlXV3I4U3Q4cFRvVjFNL3RIeC9uRXQwaUp3U1hyaFUrekVPWGE1?=
 =?utf-8?B?QXlCTUJGVEx6eG5rRUZGYy9MQ2MzaXVkUUxFOFVhdmhlbXhaNFZKT1hlTnk1?=
 =?utf-8?B?bzBidE9KNGUvTnpCdGRDeU1ocFdZL3N0d1o3TTRxTktmL2E0akcrMDZSOEto?=
 =?utf-8?B?enROV2xtaFRkNFBYRitQcGROK1paeExHV29SQkc0dTNBRCtkMkc2SEdjRS9n?=
 =?utf-8?B?WUFrb0NTend4S2hldi84SHJYMzZjVUdFYWlnTXJ0eE9DZVRHY0ZybWVlWWZF?=
 =?utf-8?B?NHh5Y0paeGxGTlJKOVoreVBKcjlMMEd1di8zQ0hWK3cvMEVpWmR5VXN0Si90?=
 =?utf-8?B?QXhNQk40MkhxSmxOUU43ZER5amhVVTlpbWJNdTdxMHZNK0hSMGMxeldyV3Qy?=
 =?utf-8?B?VHpxQVh6dWNibmdEN2I3ZTd2NjNUTVlUOTUxWkZ4TWUyUEZWK2NIbzdjc1hX?=
 =?utf-8?B?Wk8rUHFkMis2Y0ROaFlUWGRUY00rcGJSM1g4OFQxa3pTdC8wdmRTZU9JMWp2?=
 =?utf-8?B?cjN2a0t4MW5FT282dllsVjgxamJCckwyZVZ3MjZuSlBLbmZwUkJTcmlsV2Nt?=
 =?utf-8?B?R2hQRGlHdm90YnFWMXFrSXBJWHQ0VjRXNlpIWU9CZzJFcXZ1em5QWnR0a0l0?=
 =?utf-8?B?MTRCYkEwSHhqTjhONlpxeDZMK3lLQjhiaElad1lBcXJrWWp3amNVTmR6eDZt?=
 =?utf-8?B?R0pPdHM1a2x3b3lTamo5VzVqRUNoYk1TMjNxbzhMeVpDbVVWTklUUmxoK3p6?=
 =?utf-8?B?NS9EbjhuQWZRWk15UWt5SnpXcE9LSjN0dUJYSm1YNVA1Y2dFa3ZDcFQyS1JO?=
 =?utf-8?B?ZkN5VlBWTCt4dzBOKzdJL2lFOWhDRFp0NkVIUDA3SlgxdHVFZ2YwbWQxRG1V?=
 =?utf-8?B?Tm55Q2NmZ1ZEaWMwcnZ1K0ZWdEJ6WWJHb3ZoRmg2Q0hnYUp5ZE9qWHhxeko1?=
 =?utf-8?B?VU5rV24zZ0k5VEVGdlQ2RkVZTStwbUloL3B5UzBVVlZ3S0g0SlBhSy9FS0N0?=
 =?utf-8?B?YWkyWWlKUHo0aWxrdXhtcFNXMCtzeWdkS0pVQmNsQ0d0b2R2U1FnbjUrKzN0?=
 =?utf-8?B?c3oxMG1sUXVRNmNXQWZFZkZDb2tIN2NRb1pXWThKNklyZ2doMFI2ei9VcnJV?=
 =?utf-8?B?aCtYcDdObEN1czlHUE5MSyt4Y1NqVzJwYnU2NGxsdENpOWJQS0RQWjJoWWlS?=
 =?utf-8?B?L2o0NGFzbEl2UmRWK2xWNnR0dVMxb2o3U1BKK3I5QUwxS1hobkZ5anMyUUZH?=
 =?utf-8?B?QklzVGc1dExMaDcyeHVyRkJ4Rmhjc3pkbUJVaFVZbnl4RlllMHNsUlBXTGZm?=
 =?utf-8?B?STBSY3d4TVNlWGJFR0tIUndwVTdyMDlUL2tZNmYvcmIvOEw3c0hlQm9XSkxn?=
 =?utf-8?B?dm1CRmJPV3hZQVpBOUhMTmkzZVBrWFlwMTl3SWlZZzV2a0EyQkFHaDdQemdn?=
 =?utf-8?Q?NYphFy1RTXCbsADslc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f111cbcd-1ee2-4e5c-e535-08def688ac76
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 02:40:00.2229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ndYt8IU+Hgg5F5XJ2R7l4pjYzbaWynCMJmJ5qFqsfugY57UvSxTDDptarRSOax6nT4TNp7zUGkJJONagZGbzmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12265

PiA+IEBAIC0xNzUzLDggKzE3NTcsNiBAQCBzdGF0aWMgaW50IG5ldGNfcG9ydF9hZGRfaG9zdF9m
bG9vZF9ydWxlKHN0cnVjdA0KPiBuZXRjX3BvcnQgKm5wLA0KPiA+ICAJbnAtPnVjID0gdWM7DQo+
ID4gIAlucC0+bWMgPSBtYzsNCj4gPiAgCW5wLT5pcGZ0X2hmX2VpZCA9IGhvc3RfZmxvb2QtPmVu
dHJ5X2lkOw0KPiA+IC0JLyogRW5hYmxlIGluZ3Jlc3MgcG9ydCBmaWx0ZXIgdGFibGUgbG9va3Vw
ICovDQo+ID4gLQluZXRjX3BvcnRfd3IobnAsIE5FVENfUElQRkNSLCBQSVBGQ1JfRU4pOw0KPiA+
DQo+ID4gIGZyZWVfaG9zdF9mbG9vZDoNCj4gPiAgCWtmcmVlKGhvc3RfZmxvb2QpOw0KPiANCj4g
W1NldmVyaXR5OiBIaWdoXQ0KPiBUaGlzIGlzbid0IGEgYnVnIGludHJvZHVjZWQgYnkgdGhpcyBw
YXRjaCwgYnV0IGRvZXMNCj4gbmV0Y19wb3J0X2FkZF9ob3N0X2Zsb29kX3J1bGUoKSBleGVjdXRl
IHNsZWVwYWJsZSBvcGVyYXRpb25zIGluIGF0b21pYw0KPiBjb250ZXh0Pw0KPiANCj4gV2hlbiB1
c2Vyc3BhY2UgY2hhbmdlcyBpbnRlcmZhY2UgZmxhZ3MgKGUuZy4sIGlwIGxpbmsgc2V0IGRldiBl
dGhYIHByb21pc2Mgb24pLA0KPiB0aGUgbmV0d29yayBjb3JlIGNhbGxzIG5kb19jaGFuZ2Vfcnhf
ZmxhZ3Mgd2hpbGUgaG9sZGluZw0KPiBuZXRpZl9hZGRyX2xvY2tfYmgoKSwNCj4gd2hpY2ggZGlz
YWJsZXMgYm90dG9tIGhhbHZlcyBhbmQgZXN0YWJsaXNoZXMgYW4gYXRvbWljIGNvbnRleHQuDQo+
IA0KPiBUaGUgRFNBIGNvcmUgZGVsZWdhdGVzIHRoaXMgdG8gdGhlIHBvcnRfc2V0X2hvc3RfZmxv
b2QgY2FsbGJhY2ssIHdoaWNoIGNhbGxzDQo+IG5ldGNfcG9ydF9zZXRfaG9zdF9mbG9vZCgpIC0+
IG5ldGNfcG9ydF9hZGRfaG9zdF9mbG9vZF9ydWxlKCkgc3luY2hyb25vdXNseS4NCj4gDQo+IExv
b2tpbmcgYXQgdGhlIGNvZGUsIGRvIHRoZXNlIGZ1bmN0aW9ucyBleGVjdXRlIHNsZWVwYWJsZSBv
cGVyYXRpb25zPw0KPiANCj4gLSBBbGxvY2F0aW5nIG1lbW9yeSB1c2luZyBHRlBfS0VSTkVMICh2
aWEga3phbGxvY19vYmooKSBpbg0KPiAgIG5ldGNfcG9ydF9hZGRfaG9zdF9mbG9vZF9ydWxlKCkp
DQo+IC0gQWNxdWlyaW5nIGEgc2xlZXBpbmcgbG9jayAodmlhIG11dGV4X2xvY2soKSBpbiBudG1w
X3NlbGVjdF9hbmRfbG9ja19jYmRyKCkpDQo+IC0gWWllbGRpbmcgdG8gdGhlIHNjaGVkdWxlciAo
dmlhIHJlYWRfcG9sbF90aW1lb3V0KCkgd2l0aCBzbGVlcD10cnVlIGluDQo+ICAgbmV0Y194bWl0
X250bXBfY21kKCkpDQo+IA0KPiBDb3VsZCB0aGlzIGxlYWQgdG8gYSAic2NoZWR1bGluZyB3aGls
ZSBhdG9taWMiIHBhbmljIGlmDQo+IENPTkZJR19ERUJVR19BVE9NSUNfU0xFRVAgaXMgZW5hYmxl
ZD8gU2hvdWxkIHRoaXMgaGFyZHdhcmUNCj4gY29uZmlndXJhdGlvbg0KPiBiZSBkZWZlcnJlZCB0
byBhIHdvcmtxdWV1ZT8NCj4gDQoNClRoaXMgYSBmYWxzZSBwb3NpdGl2ZSwgZGV2X2NoYW5nZV9y
eF9mbGFncygpIGlzIG5vdCBjYWxsZWQgaW4gdGhlDQpuZXRpZl9hZGRyX2xvY2tfYmggY29udGV4
dC4NCg0KZGV2X2NoYW5nZV9yeF9mbGFncygpDQrilJzilIDilIAgX19kZXZfc2V0X3Byb21pc2N1
aXR5KCkNCuKUgiAgIOKUnOKUgOKUgCBuZXRpZl9zZXRfcHJvbWlzY3VpdHkoKQ0K4pSCICAg4pSC
ICAg4pSU4pSA4pSAIGRldl9zZXRfcHJvbWlzY3VpdHkoKSAgICAgICAgICBbbmV0ZGV2X2xvY2tf
b3BzID0gbXV0ZXhdDQrilIIgICDilJzilIDilIAgX19kZXZfY2hhbmdlX2ZsYWdzKCkNCuKUgiAg
IOKUgiAgIOKUnOKUgOKUgCBuZXRpZl9jaGFuZ2VfZmxhZ3MoKQ0K4pSCICAg4pSCICAg4pSCICAg
4pSc4pSA4pSAIGRvX3NldGxpbmsoKSAgICAgICAgICAgICAgIFtydG5sX25ldHNfbG9jayA9IG11
dGV4XQ0K4pSCICAg4pSCICAg4pSCICAg4pSc4pSA4pSAIGRldl9jaGFuZ2VfZmxhZ3MoKSAgICAg
ICAgIFtuZXRkZXZfbG9ja19vcHMgPSBtdXRleF0NCuKUgiAgIOKUgiAgIOKUgiAgIOKUlOKUgOKU
gCB2bGFuX2Rldl93b3JrL25kb193b3JrICAgICBbbmV0ZGV2X2xvY2tfb3BzID0gbXV0ZXhdDQri
lIIgICDilIIgICDilJTilIDilIAgcnRubF9jb25maWd1cmVfbGluaygpICAgICAgICAgIFtuZXRk
ZXZfbG9ja19vcHMgPSBtdXRleF0NCuKUgiAgIOKUlOKUgOKUgCBuZXRpZl9yeF9tb2RlX3J1bigp
ICAgICAgICAgICAgICAgIFttaWdodF9zbGVlcCgpICsgbmV0ZGV2X2Fzc2VydF9sb2NrZWRfb3Bz
X2NvbXBhdF0NCuKUgiAgICAgICDilJzilIDilIAgbmV0aWZfcnhfbW9kZV9zeW5jKCkgICAgICAg
ICAgIFtuZXRkZXZfbG9ja19vcHMgPSBtdXRleF0NCuKUgiAgICAgICDilJTilIDilIAgbmV0ZGV2
X3dvcmtfcHJvYygpICAgICAgICAgICAgIFtydG5sX2xvY2sgKyBuZXRkZXZfbG9ja19vcHMgPSBt
dXRleF0NCuKUnOKUgOKUgCBuZXRpZl9zZXRfYWxsbXVsdGkoKQ0K4pSCICAg4pSc4pSA4pSAIF9f
ZGV2X2NoYW5nZV9mbGFncygpICAgICAgICAgICAgICAgKFNhbWUgYXMgYWJvdmUpDQrilIIgICDi
lJTilIDilIAgZGV2X3NldF9hbGxtdWx0aSgpICAgICAgICAgICAgICAgICBbbmV0ZGV2X2xvY2tf
b3BzID0gbXV0ZXhdDQrilJTilIDilIAgX19kZXZfY2hhbmdlX2ZsYWdzKCkgICAgICAgICAgICAg
ICAgICAgKFNhbWUgYXMgYWJvdmUpDQoNCl9fZGV2X3NldF9yeF9tb2RlKCkgaXMgY2FsbGVkIHdp
dGggbmV0aWZfYWRkcl9sb2NrX2JoKCkgaGVsZCwgcGxhY2luZyBpdA0KaW4gYXRvbWljIGNvbnRl
eHQuIEhvd2V2ZXIsIGRyaXZlcnMgaW1wbGVtZW50aW5nIG5kb19jaGFuZ2VfcnhfZmxhZ3MNCmFy
ZSBub3QgaW52b2tlZCBkaXJlY3RseSBmcm9tIHRoaXMgcGF0aC4NCg0KSW5zaWRlIF9fZGV2X3Nl
dF9yeF9tb2RlKCksIHRoZXJlIGlzIGFuIGV4cGxpY2l0IGd1YXJkOg0KDQppZiAob3BzLT5uZG9f
c2V0X3J4X21vZGVfYXN5bmMgfHwgb3BzLT5uZG9fY2hhbmdlX3J4X2ZsYWdzIHx8DQogICAgbmV0
ZGV2X25lZWRfb3BzX2xvY2soZGV2KSkgew0KICAgIG5ldGlmX3J4X21vZGVfcXVldWUoZGV2KTsN
CiAgICByZXR1cm47DQp9DQoNCklmIGEgZHJpdmVyIGltcGxlbWVudHMgbmRvX2NoYW5nZV9yeF9m
bGFncywgdGhlIGZ1bmN0aW9uDQppbW1lZGlhdGVseSBlbnF1ZXVlcyBhIHdvcmsgaXRlbSB2aWEg
bmV0aWZfcnhfbW9kZV9xdWV1ZSgpIGFuZA0KcmV0dXJucyB3aXRob3V0IGludm9raW5nIGFueSBk
cml2ZXIgY2FsbGJhY2suIFRoZSBhY3R1YWwNCm5kb19jaGFuZ2VfcnhfZmxhZ3MgY2FsbCBpcyBk
ZWZlcnJlZCB0byBhIHdvcmtxdWV1ZSwgd2hpY2ggcnVucyBpbg0KcHJvY2VzcyBjb250ZXh0IHVu
ZGVyIHJ0bmxfbG9jayBhbmQgbmV0ZGV2X2xvY2tfb3BzKCkg4oCUIGJvdGggbXV0ZXhlcw0KdGhh
dCBhbGxvdyBzbGVlcGluZy4NCg0K
