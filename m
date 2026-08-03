Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724DC42FCC9
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781276; cv=fail; b=C4a3ZIovkuejZSAG0VjV6Nj+gCmI/EdeYumr15Q2UbizzRqTmUOPDR87wqlwouiZQhXJWyJiGnW7593vGcI+bewF2lvnyqmn8AvfYHopIbdKbeeZGT2hNHFmPvEd8Qtz9TARfdmS0a8XXnEyqydi/btc7AOP1ICqhZMHE6+U0GM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781276; c=relaxed/simple;
	bh=J8G9Z00+oFqiuH0TDYiX8XjtRmNq7NKB8lKBA8gsDOg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WX8DRTwrOrB3l2wjoIt0s86UixBJOsver/fX7dMvX/x4NOQh5CZNi8o49JCrKvr2SZwh2mMRTrWOwj4BXsNuQ5BvvrwAemJc/Pi43P+hw16xWyBlkKgEKlsDzu/XD/1+Vc1Tr6xn2YYYUXE+JggN+BoRfZAlOMElrdJQWz9+kj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RgdnVhTb; arc=fail smtp.client-ip=52.101.46.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RgdnVhTb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksST/2kCa+HCefXiyIxazrjgkeiFR2EDns+IS0jCD2MuNwn+5Tuu35bi0bn+FSvtT3d/yQnUI4H5rVEtTlBzqqNaXIUC028MSe2klsEqUr6G0w0VlLryG5Y3UVlREvgE0KXK5y+jE4OzdTTdKVelX1l9N3yrlULlFQhG7SBblquW6yCzOXRcPsegNkgIiLJeaKf1NHr6+8pNDPEw9tgi8ee5lHzjwzuiPNAWD73OveFzwkuUMGSswD7TtAGHsmWhdEWtxlimEJB+Rp5rDXam87hvw+aZFCzAqo4BuVJ9VaX7dBTNkQOTaIeLCIhvOwcrRJLCbQ+6e492PPHlU7LfoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8G9Z00+oFqiuH0TDYiX8XjtRmNq7NKB8lKBA8gsDOg=;
 b=IEewDV822ycpVgpfjm4EUgFbZirOXpJ820C+l8h/jMraM+lEkcAIw9wJNebNfc4nuGO21PB1Ys0RzBUFCY2xSKLMx1cIwYCZmH0BdT3GvV2UHDmm7AWKpB7UXqoFgDPFVInm4G0Fz9UX6BqJU1sJHkNN926S+szBPbRuxuF/BxcI52YPcKygSdpxy72YLnafjCvEaWsvVsncTEIUllp5vaosWg6Quwcn02V3dg3t9A9wdAOvLqwv5HEVR09mfxuP5eyuMH6xIGqjBPC5KV3akmop6vehuY9RPEkKVnMQVYCqNP3MH5ZRWpniJHTq0pbT7U4Bk1jEFNniGKbjNC69dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8G9Z00+oFqiuH0TDYiX8XjtRmNq7NKB8lKBA8gsDOg=;
 b=RgdnVhTbCZECXhsZXnOUU0OmXFuHpg/vp4DcjL2H46b75MHdJ5u7uVFhHlwmue8AVDx0ZNj5li/B9/pKHavt+KZuMIO0omm1GMLekICgY0jsUX8sF711lto6puZLqP3aosXXY3QiV60Hd0locAnGsNvX/OulYURcssiba7dv2zLXAU79zVbbcOXf0NgDpS7JYhilw3QEZimii/Xv0kD6Jzb/zsR7eWGm7VZ1UU76v74Dc9XfWoKiD/AXymTZj7d2DRG99pIQjMT/OvhZ/1qOqKrTdAIUEdKlK+mGAO6AS1TB3b+xoHAwjnpAbQgJcQMJo2gH93c12sQ8lQnFrN+qhA==
Received: from SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7)
 by DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 18:21:11 +0000
Received: from SJ0PR12MB6806.namprd12.prod.outlook.com
 ([fe80::3981:4d43:82f5:adf6]) by SJ0PR12MB6806.namprd12.prod.outlook.com
 ([fe80::3981:4d43:82f5:adf6%2]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 18:21:10 +0000
From: Parav Pandit <parav@nvidia.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Shay Drori
	<shayd@nvidia.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>
Subject: RE: [PATCH net] devlink: Expose external flag for PCI SF ports
Thread-Topic: [PATCH net] devlink: Expose external flag for PCI SF ports
Thread-Index: AQHdIyaj/XCZ2S68E0SQa1JEi35J4baMV4iAgABJ4fA=
Date: Mon, 3 Aug 2026 18:21:10 +0000
Message-ID:
 <SJ0PR12MB68060E8F0C80BD00F9918798DCD52@SJ0PR12MB6806.namprd12.prod.outlook.com>
References: <20260803090012.257242-1-shayd@nvidia.com>
 <8992095d-c856-41c9-912d-5e41f395a0d8@intel.com>
In-Reply-To: <8992095d-c856-41c9-912d-5e41f395a0d8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6806:EE_|DS0PR12MB6534:EE_
x-ms-office365-filtering-correlation-id: 92292696-609b-4966-a0f6-08def18bfea9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|6133799003|11063799006|4143699003|56012099006|18002099003|22082099003|10067099003|38070700021;
x-microsoft-antispam-message-info:
 lWI0gsZopbskByPfdvv/DBYLD0qofPO9fTtjFEosVf+XojHcmYGcXgJhDPV96+tr+2IXxjIfDplrDKjqKPM5AARMrV6J4jNRG7rr+feb/gQtexrxmVgHZfOSmD2t4PyAnIc+/VdDWw2WTVjoXeGzG9JsgDR4gja8LS6rIdmn7ufNAlulQHjvjazXMZQAlc2AEeZ25ZD2b5M2ZEdYzqI8N06kiqoquDlDg5Y4Mdix3ZZmzdKAlQOSmIx6JL/qMx2Yl5KySHyH4L3qOwuruCyNn3nIkxMALkXh9jznfTldP2ShSxHu5Y87Zwj9JEVyxF+3qXe1sSQM+OHgL6qtdoY1soFzuEAfBiFhAnCMM/Q+b1CztwWOypODBUqfk095Q00Rllg288GjET+RxShnaPzCxmLl2YRpG7ZcQLU+1PHpBCgBHmPum/UdWyeDxoF+uin6xjI0CuZaFRT4EKkjNWjbkTcRd2F/okf96TCdClcHnlEkteTDJDSaX/9zIihXWTSjrnIuckl6VyGU5wt5OK2kGkEnmwEKd7DGM0tjbGRuVPJTx1MUNNSJbR6USi/SVUh29neVFpKVKCoNpN7b8o4cvvdA/pTTeLGNj1AHGFMPHNsaTzc7Z5T6Q4gKNXZohu3U9N4VGsJY1AXvvRNp15dCb3Kr+oKuG7hlrnzSvzMQ3SX2WcJyCwtD1w2IG4KBgJ43d/NQhJBNHUs5BQ+Vui5sJ8d0djRePspyU+1fcBtzhjw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6806.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(10067099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dlI4SUJ0dE45VzlmMUttV2pqblU1UFF5eXA3Z1hDSXdEMk41ZGVRTHVsNDZZ?=
 =?utf-8?B?VEtCK090Y2VGeG5ySmMvVUJ4L0lKZm1JUzZiR2QyNGx6dTJmM2ZMd29QUnZ3?=
 =?utf-8?B?cEVkU1NoZzlIajNuY0srM1NGOUk3cHRWaXBld2JZSkw2Ykp0U2RyRFhwMEJ0?=
 =?utf-8?B?bUp3d1hOelJPbjIwYkRZUko5ZTZtcTJ1Vk54MWtuNVFJZzR6bGdFbFByQTBC?=
 =?utf-8?B?U1JKOHg4WHN6VWtHdms2VkhaV2RJZnVMNjdVc0c4OVdzQlkrUjV4R2FYVVJz?=
 =?utf-8?B?U1V0L2pOYXlWYTJ5RWVrZlNxOHNZZmt1QnZHSDRYczBQUDl5cFJ3bXpVWkc4?=
 =?utf-8?B?WGFoQjRaRnFxZmt3ZURhcUltcW5rQmxnOUlBVXZ3N1RaY2R3MDE0empQR01v?=
 =?utf-8?B?c1hvNlhNcDBTTXUrN1BlVmZ1R3FzRzk2cjR3alhzckltOEl1UGR5RmZrTXhB?=
 =?utf-8?B?eC9vY3FIOTRCL01lckU4UHNncFBwMm96SlM0bVJtNCthZWx6WVNMRWU1R0FO?=
 =?utf-8?B?LzluTm1KWlo3QUF1OUsxaU5Id0NUZFlXQUFqTDRKQVlVU1Mvc09DbHFEbjQr?=
 =?utf-8?B?ZEVRUWpMRWNGZ0VwMEtOYkk1aGJvWHYxa1d2S1dydkV6MFNJbTNGMzhVcFBS?=
 =?utf-8?B?Y1NEeTVwNFREL0JCWVdzQ3BqajY0UElxcXdiOEdhS1hDV0dqZXNpTE9zYlRX?=
 =?utf-8?B?dWNya0ZVSktqRUtzZmtSYkVnRytyREpLNDYwUTNpdllWdVlBSXhXUyt6NFpj?=
 =?utf-8?B?TVkxNElCclFyRjZ2SzBWSDViNG1zNGRveUE1cnMrbFJ3OHZ1WnA4TDBJWFM3?=
 =?utf-8?B?TmVYY1FDdkw5QkQ2SjVHZW9Xb212bkdFdFB2WkovaU5ZOUcrRFFod2d6TXNZ?=
 =?utf-8?B?NzN2d3l0OGtnMVRBWG9Rem4zMExWWXVQV3dEaExodmtGVitkK2g2R284dlhs?=
 =?utf-8?B?dmtlblViK2VsVkVuMlFwSFJHbEU5c0NoRlFlMERpWUJqQUNJNjV2U2E1WWdr?=
 =?utf-8?B?OXViZUxSN3UvaUpWZ2lFS3d3dGx6NUN4YnFLajllbnJNOXNXQ2ZydGdYTm80?=
 =?utf-8?B?Y2lzTTF3dndTV3d3bjdQUU4vbXZLSkJiSFVoMTUxbFErOUxlQ1haMFJ3T2h3?=
 =?utf-8?B?alNOTnNBMzFJWlFXcUhrbHVkeWVOeGV5b1MyMFVBdEhGelg0QTJNOXViNGJy?=
 =?utf-8?B?Y3ZjVjMySjNONVFnYkREZlYrM3ZVd2NBV3M1YlhOc21XS3hDM3RFZDNma01N?=
 =?utf-8?B?dFhMU0pMSHpUdmRpV0dXUStldzliS3RnRklSajNSRXROVWpZRTdjenVseWJm?=
 =?utf-8?B?aVU3R2NocStORVZQSDMxRkZwVldYb0puZlR3WkxZS1hnM3ozMG02UXAwclFB?=
 =?utf-8?B?SWZ4REpoc3hTaHMzalpmdFJtN0NaQzAxVTV6MjNJdWR1RCtjd3BtejdkcDR1?=
 =?utf-8?B?NXNraWIrdVpXd2FnR1IySmphRWN0SXZPTkhyYW5ZVitRZzZVRVdQZ0xEazB1?=
 =?utf-8?B?dUpHSEZ6NzdxSUpGYmIremEvS2cwQTVxZUNOTGFzb1daZ1d5OHNQNDkrZlMr?=
 =?utf-8?B?Mm81Wmd3cVViWGs2aEhjbnRYeFFlQjR1ZElmL1RUY0crUlF5MmtNSWxSME0w?=
 =?utf-8?B?Q3I0VURTbmRyS0JpY2c4Z29uVUE0Q0dydTgzcDA2M2ZvUUcwTjF2MXFMTllm?=
 =?utf-8?B?blVzQ1V1VnEybyt2bkdrZjFLODM0N3ZVbFRkaEl0TkZ3dTVvb2E5eVFvSGFI?=
 =?utf-8?B?bnMvUk9EUkhLakpzRitmOERVeXlJODlURnk5MjZXN2g3bDh1czVTR0w4MW8y?=
 =?utf-8?B?bkZJOEVyRC9aRzI3RlRFVC8xTlF6NUluOHNLRWxiUS9kTGlFWnRtYjJpbXQ0?=
 =?utf-8?B?QlpycnVvRWJaNklSam84MFY0cjloWVA2bTJpa09sNlVrODNiR1JodExBK1o4?=
 =?utf-8?B?TlJqa0o4dG1PUm1mcUNOR2s2U1VCTUdWcGx2SzV5ODhjcmJDa1hrM3NLbDZT?=
 =?utf-8?B?cUdnSG9GYzZTZjlGYkUwbGpoWEt2WmlHUmh3UXF6Z1gzeDBlNkh1eHk2UXBw?=
 =?utf-8?B?bkhWLzUvcERSM2xQM1J0QXM5N3hqc1JnWjhjWVhKZ1FDN1FQMTZFUk1mWXlq?=
 =?utf-8?B?c2h0Q0JyYlRkaTlxR2RHZ081RzdEZCtKTlRmRXU5OHJCck5DSmZxL1NYcnhs?=
 =?utf-8?B?VHpjclp3aXhRbkZ5ZXFHV1RiL3ZjYS8vMGIwc2FiZHpYS3dkell0V3RPaXFu?=
 =?utf-8?B?OVVmZWVWSU4xeFhsMlRSNlFFYjhFaVlzZWZmWlFpblpPWHFaMmx2VTFBU2xi?=
 =?utf-8?Q?XJcYRa82imdtGcueDu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6806.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92292696-609b-4966-a0f6-08def18bfea9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 18:21:10.7310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gzmINdfl8mjKo0G3gpyaPzVzhVv68OzHWc/6HxaWIaupnYeWMaL9w4mBiomv9D32wASBY6PH6OT56fofeZ8mgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534

DQoNCj4gRnJvbTogUHJ6ZW1layBLaXRzemVsIDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29t
Pg0KPiBTZW50OiAwMyBBdWd1c3QgMjAyNiAwNzoyMCBQTQ0KPiANCj4gT24gOC8zLzI2IDExOjAw
LCBTaGF5IERyb3J5IHdyb3RlOg0KPiA+IFRoZSBleHRlcm5hbCBmbGFnIGlzIHBhcnQgb2YgdGhl
IFBDSSBTRiBwb3J0IGF0dHJpYnV0ZXMsIGJ1dCB1bmxpa2UgdGhlDQo+ID4gUENJIFBGIGFuZCBQ
Q0kgVkYgZmxhdm91cnMgaXQgd2FzIG5ldmVyIGZpbGxlZCBpbnRvIHRoZSBwb3J0IGR1bXAsIHNv
DQo+ID4gdXNlcnNwYWNlIGNvdWxkIG5vdCBxdWVyeSBpdCBkaXJlY3RseS4NCj4gPg0KPiA+IFJl
cG9ydGluZyBvZiB0aGUgZXh0ZXJuYWwgZmxhZyB3YXMgbWlzc2VkIGZvciBTRiBwb3J0cy4gSGVu
Y2UsIHB1dA0KPiA+IERFVkxJTktfQVRUUl9QT1JUX0VYVEVSTkFMIGZvciB0aGUgUENJIFNGIGZs
YXZvdXIgYXMgd2VsbCwgbWF0Y2hpbmcgd2hhdA0KPiA+IFBDSSBQRiBhbmQgUENJIFZGIHBvcnRz
IGFscmVhZHkgcmVwb3J0Lg0KPiA+DQo+ID4gJCBkZXZsaW5rIHBvcnQgc2hvdyBwY2kvMDAzMzow
MTowMC4wLzE2Mzg0MA0KPiA+ICAgcGNpLzAwMzM6MDE6MDAuMC8xNjM4NDA6IHR5cGUgZXRoIG5l
dGRldiBldGgxIGZsYXZvdXIgcGNpc2YgY29udHJvbGxlciAxIHBmbnVtIDAgc2ZudW0gNzcgZXh0
ZXJuYWwgdHJ1ZSBzcGxpdHRhYmxlIGZhbHNlDQo+ID4NCj4gPiBGaXhlczogYTFhYjNlNDU1NGI1
ICgiZGV2bGluazogRXh0ZW5kIFNGIHBvcnQgYXR0cmlidXRlcyB0byBoYXZlIGV4dGVybmFsIGF0
dHJpYnV0ZSIpDQo+IA0KPiBDaXRlZCBjb21taXQgaGFzIG5laXRoZXIgaW50cm9kdWNlZCBhIHVz
ZXItb2JzZXJ2ZWQgYnVnIG5vciBhIGJ1Z2d5DQo+IGZlYXR1cmUsIG1lcmVseSBhICJiYWNrZW5k
IGZvciBhIGZlYXR1cmUiLCBhbmQgbm93IHlvdSBleHBvc2VzIGl0LA0KPiBtYWtpbmcgInRoZSBm
cm9udGVuZCIuDQo+IElPVzogSSB3aWxsIHJhdGhlciBjYWxsIGl0IGEgbmV4dCBtYXRlcmlhbC4N
Cj4NCkl0IGlzIGluZGVlZCBhIHVzZXIgb2JzZXJ2YWJsZSBidWcgdG8gYW4gZXh0ZW50IHRoYXQg
U0YgcG9ydCBpcyBleHRlcm5hbCwgYnV0IHVzZXIgaXMgbm90IGFibGUgdG8gc2VlIHRoZSBzYW1l
Lg0KRXh0ZXJuYWwgYXR0cmlidXRlIHdhcyBleHBvc2VkIGFzIGRldmxpbmsgcG9ydCAnZnJvbnRl
bmQnIGF0dHJpYnV0ZS4NCg0KQSBzY3JpcHQgdGhhdCB3YXMgc3VwcG9zZWQgdG8gd29yayBmb3Ig
dGhlIGV4dGVybmFsIFBGLCBmYWlscyB0byBmaW5kIHRoZSBhdHRyaWJ1dGUgb24gdGhlIFNGIG9m
IHRoZSBleHRlcm5hbCBQRi4NCg0KVGhlIGNpdGVkIHBhdGNoIG1pc3NlZCB0byBleHBvc2UgdGhl
IGF0dHJpYnV0ZSwgd2hpY2ggd2FzIHRoZSBwYXRjaCdzIG9yaWdpbmFsIGludGVudDsgd2hpY2gg
aW4gbXkgdmlldyBpcyBhIGJ1ZyBhbmQgZml4ZXMgdGFnLg0KDQpCdXQgYXQgdGhlIHNhbWUgdGlt
ZSwgb25lIGNhbiBhbHNvIHNheSwgdGhhdCBleHRlcm5hbCBmbGFnIGl0c2VsZiB3YXMgbm90IGV4
cG9zZWQuLi4NCg0KSW5jbGluZWQgZm9yIG5ldCBiZWNhdXNlIG9mIHByZXNlbmNlIG9mIGZpeGVz
IHRhZy4NCk5vdCB2ZXJ5IHN0cm9uZyBvcGluaW9uIHRob3VnaC4uLg0KIA0KPiBPVE9ILCBjb2Rl
IGlzIGZpbmUNCj4gDQo+ID4gUmV2aWV3ZWQtYnk6IFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlh
LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGF5IERyb3J5IDxzaGF5ZEBudmlkaWEuY29tPg0K
PiA+IC0tLQ0KPiA+ICAgbmV0L2RldmxpbmsvcG9ydC5jIHwgMiArKw0KPiA+ICAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL25ldC9kZXZsaW5r
L3BvcnQuYyBiL25ldC9kZXZsaW5rL3BvcnQuYw0KPiA+IGluZGV4IGRjODJjYWM2OGU3ZC4uMTUy
OGYyZDE0OGRmIDEwMDY0NA0KPiA+IC0tLSBhL25ldC9kZXZsaW5rL3BvcnQuYw0KPiA+ICsrKyBi
L25ldC9kZXZsaW5rL3BvcnQuYw0KPiA+IEBAIC0yNjcsNiArMjY3LDggQEAgc3RhdGljIGludCBk
ZXZsaW5rX25sX3BvcnRfYXR0cnNfcHV0KHN0cnVjdCBza19idWZmICptc2csDQo+ID4gICAJCSAg
ICBubGFfcHV0X3UzMihtc2csIERFVkxJTktfQVRUUl9QT1JUX1BDSV9TRl9OVU1CRVIsDQo+ID4g
ICAJCQkJYXR0cnMtPnBjaV9zZi5zZikpDQo+ID4gICAJCQlyZXR1cm4gLUVNU0dTSVpFOw0KPiA+
ICsJCWlmIChubGFfcHV0X3U4KG1zZywgREVWTElOS19BVFRSX1BPUlRfRVhURVJOQUwsIGF0dHJz
LT5wY2lfc2YuZXh0ZXJuYWwpKQ0KPiA+ICsJCQlyZXR1cm4gLUVNU0dTSVpFOw0KPiA+ICAgCQli
cmVhazsNCj4gPiAgIAljYXNlIERFVkxJTktfUE9SVF9GTEFWT1VSX1BIWVNJQ0FMOg0KPiA+ICAg
CWNhc2UgREVWTElOS19QT1JUX0ZMQVZPVVJfQ1BVOg0KDQo=
