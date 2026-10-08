Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013052.outbound.protection.outlook.com [40.107.162.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5812652B2;
	Thu,  8 Oct 2026 03:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791428913; cv=fail; b=r6JI22+/J94oV3Y9jUYToqWHzLZHQPGQxtmrM4YR0nDOjPjX8Asj/Sr/9RicPe2c5/ijlIfqJ3Wbloby1ejQIK8CKAjrfazABm3kMG7u/4utEuP4wHkmLOFeTUEBb27UnyLUNXPJ239KMVPEGfWWMKyNXdvDWj03mre55PIxNUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791428913; c=relaxed/simple;
	bh=DcbDvk+xL22k5ydXogrpCa54UYcgFi0OPd1P2Fx0ems=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HVgganL919VgzCOHBzPsLGN0J9UAB7ebu3lL2gXrN7/nWL5RiJfC0UWuDsqUBpTjhweOtWx3dW3YZK6MIvmwy5rdpw7J0bCGtNeRkHMc33ET55SD6E88ZWT5PEPRT3/YIiyYUnbXwz8Wbo1/cO++VStOcF4ndyHFOuzURV9zvn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LpAykzmj; arc=fail smtp.client-ip=40.107.162.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LpAykzmj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlKotQsrNAXp2K0eWvMeVFvsnzjE5R5JKFwS0VdPQzyWTkfnSsFu3hSG6Gkdg2f/Wb0zXJOxgDwKe45IWutAhiq2O9mpXtb1WpuicNncG6pJpYZufOpidKBNiCWCbQV4RjgaxXP7k8Wtwwz233etTPOzQM0+PIjjwk5pDteJxVTVai4jRU5uG60A5F7YBysK+Z1pbRF73dDESUB89Oc2WvD23zmBsL/+lYG3Ry972AtLX+JC9dAJLLNVzX7HFXcE0ULUthRfr4Hf27Gjtxtb46Icy1UIMrx/LnBBwuvt9tJUbERZcrrKmhEkySqaX29+X/tHCBtJ4zUEBjcP7t+bmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcbDvk+xL22k5ydXogrpCa54UYcgFi0OPd1P2Fx0ems=;
 b=lor05HaMSDyvUuHxqubIgDxfUq7bH8t+C3NuQeSbSeL3Idd6N6cLlqxh9POdBJVH+whBto71nBIjXF+F7os6r2dVHdoULFHJ3Eb2b22lkQaVAxa8bJ0Pu6HF1ETPmesx/o2GNQ/LxBXV4x0wz04uALAn11pBJXfsbPOk1/xpyc0ai4z9RmDB7Zy0T5ovGIHaqzB5hTZ8gAOmcbBiu0SzlsTwSn8Kj6SrPDw2pkpIYXgSy0o6z46JdoAlYgKbD/7rrVK/YHDEKaT6d4O6smaevMAhK2QIN30Rp99sg8aivliiQHDwMTAB9FMPUPhEsYHmMPtNY70wOumSsG+O61knpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcbDvk+xL22k5ydXogrpCa54UYcgFi0OPd1P2Fx0ems=;
 b=LpAykzmjZVIOIdDzfzJ8oWVzpkVt9thav+f+gOMzQK4zts+HQKFUqMrLOMWaIIb7+Rvfih+xrBl5Pypp2r4k7GJRr3vU4kcf6THOb/xsLLWigKgohNBeihmf5KdLcOtIS3rD6FmW9YQxCN7Uex6yrR8zwBuQPMnSIyeC7iEz3XQOtFC166xR9TMHAaRoPY/MOB7Em6lgi1WVDSy8zgdvptjDCTtIt2cpAYAFvD2DR0DLuoN/T2pcsib8kuCryAehdk64YLz0r9bBmkXbUValUAMvHQFL1otjA7SM83OFuNcFfythz7dlAQiMaljQTVcpwmGW0cuuP4kHc6NMvITrVw==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by AM0PR04MB7121.eurprd04.prod.outlook.com (2603:10a6:208:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 03:08:29 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%6]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 03:08:29 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Marek Vasut <marex@nabladev.com>, Andrew Lunn <andrew@lunn.ch>
CC: Clark Wang <xiaoning.wang@nxp.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, "David
 S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [net-next,PATCH v2] enetc: Increase eMDIO MDC rate to 2.5 MHz
Thread-Topic: [net-next,PATCH v2] enetc: Increase eMDIO MDC rate to 2.5 MHz
Thread-Index:
 AQHdTE9m1hutRzwLFUKmfktoRBJfE7bmds5AgAAWOgCAABaJ8IAAgr2AgACyLoCAABjNgIAAnAsAgAAyfgCAAJP/AIAJtvIQ
Date: Thu, 8 Oct 2026 03:08:28 +0000
Message-ID:
 <AS4PR04MB9338D6F6838E3B03BBED163F88932@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <20260924180607.60932-1-marex@nabladev.com>
 <AS4PR04MB93382AF6B2AC7B5F421019BB888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <af3d4fd1-9659-4d91-997f-6bb09ae06ba5@nabladev.com>
 <AS4PR04MB933887CA9C646F0359D8E61A888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <b4addd8f-43ba-417e-85ad-a78391c8f2fb@nabladev.com>
 <AS4PR04MB9338E76DB4A59D70F1D6AB2F888A2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <e7f574ab-5fcf-484a-a5bf-fc94d45b2311@nabladev.com>
 <AS4PR04MB9338B4278A2A5B94FA854056888A2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <0b1e6d29-5054-423c-bf7d-2206f2473579@lunn.ch>
 <42f7cfb4-d04d-4782-b789-f291d393af2f@nabladev.com>
In-Reply-To: <42f7cfb4-d04d-4782-b789-f291d393af2f@nabladev.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|AM0PR04MB7121:EE_
x-ms-office365-filtering-correlation-id: ee45f17b-344a-4eb4-1b6a-08df24e96d55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|23010399003|7416014|22082099003|18002099003|10067099003|11063799006|4143699003|38070700021|56012099006;
x-microsoft-antispam-message-info:
 ipi7M14WxvLxUBi68i8mlE6P93YdL5cV3Bkjbg6hYzx9/Lo0GqMz1jkg6DJbsT4AuhnWy4E+qWxb4JGFJnLQvHe5Ib/LBbzHmx5nD7AVdc+WDO03lwSR0h6ir/Bo18Z+vOwF1+PNpSzCYWXixP39LunkV3wrKrL4DaG/svF/dzG1B6m3jfrw3iA/gG0jrj8q8qaTmsEZVaY5ucr/Y7nGXg2AwLdgLCawLCaEf3QUAS8ZssSSMuC3WrQPF3ICHR4vpieUCv5m53sBTbBAT3sz1PhPL3Yyt+Lhih2u59/3EkWvrtAxsl9U99cbvjl7V0qIN5PUXeqpoCtZ4FjcTWprijAsbKkLUI7HwGDe9qH3xRLp2NBOIbV/u0zlL/elZ1dk/3K7kolaWDtB8srFH/fGmYLzzK0dBO+Bnzkgl5tgZCcWzVEgDtUeC5o5LrmGmZcTXjYOeI90y3g4xPsIEn5NBzhx1S/uKuMGxXIfhy2xktTpy5eU7/95FgaSuwdrhThDIUpyTiNIQXuhdBzwJDP2KqbtSCASKRbQwrNepeKNs2c7hQHe0T3l5sskKDgxOvlc7BOftfioKivhxjKF2dy3RtfhhL/oj2w8rM1Kj/Mhhk0gnMayBehRd54DiIwauPZSXk82j6mrKP4HL89f6W7NrAP624kgwYLytHkhgYrM0G1IeSMOpRgIcSILOEwCjUNmATrqJTMsRLMiUsmucv8m8i9/f5zmQycQqUYvJBiCrvY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(23010399003)(7416014)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T291RHBkbkxwcGMxTUpjV1UwMjlHeCs4VlVtZkFGL3FpbXVPeFZsc3FPL2wv?=
 =?utf-8?B?RmF3d25lSEVGK1BFNFlrTzNXY2tvSFArOUw5S1JtQ05BRitjK2hOOUdGOGth?=
 =?utf-8?B?NWx0MGdCSEtqQ281MjlEWFcyVWZoVlk3V2k1dzJWTW80ckhtRHVzQlBiOWNv?=
 =?utf-8?B?KzNYY1dsMlJKeWp5dm9GTWJwSllDNmVhcGdVQitXUjdXeCtIOWY2eFNNcUF3?=
 =?utf-8?B?dmkxUHRZeWtVTEN4YTVsU0ErSmJIZlowdVUyaUlNZHdyVDVIaEZtTFdGQllC?=
 =?utf-8?B?SSsyR0MrMjVJNXQzQzB4azkzYlVvQWoyaW5DQm55S2RBUkplM3BOQmVQLzdW?=
 =?utf-8?B?UVZGS3FTU1dHTXVEWUdxT0gyZjRXMEdMWDdWUDBRSjlqeWRBTDB5bFVtYnlV?=
 =?utf-8?B?UVRQSTZRMXB3Q3orS0JNbnk0MTRUenpJdFc1UDJKOUt0MlRqSS9KL0RDZXBT?=
 =?utf-8?B?bTFBdmxmdkRGaEFmWFNacFM4OU01NXFURzZpME9heGxXaWFWK0R6Q05Bajho?=
 =?utf-8?B?UlkzaWE0UmtiOS9EKy9pdWc3b1ladFhGM25tbXF0dktTckI4UnhibWYzWHpq?=
 =?utf-8?B?MkNERlZzRk15dDBFeVpCNEFmY3U0bFE0T2Q1Nk12NFZ4VUNJZzdCaStFYWlE?=
 =?utf-8?B?UXdJa1hYa29YSkVmdWRWT2o3Q2NYMWZZRmFtR2U5dk0veUNEVUdINm4yMkox?=
 =?utf-8?B?UnpobjFnYWIrbUZUSmROKzVWTlV2WXd1aVpyQy9wUG55aDhGWGlzMUFsZmp0?=
 =?utf-8?B?Z3h0MmE2Vkh6YUIyenZqTWpkUytIY0Yxd2JPcWRPNHRvUHYyMWQ2RFArbmpP?=
 =?utf-8?B?MnRjMjNhbEQwWXhFVGx2YWJzWm1sWGUrRXQ1QmhWTkNrZlZmeEZ0NWlqM1ky?=
 =?utf-8?B?c1hYOTR4WXJaNnNsQzFGY0YvVGtZWEMzK0tTcVpmNjlrbzRhUk1MZzZJb2gv?=
 =?utf-8?B?NWJoWmx2aSs3TjRVOGovQ0dQNC9jcmNEdkZUaTNqa0dWVmZLU01RblFiQ0Vs?=
 =?utf-8?B?UE4rRDdMbGJITlpsVnR1bk9ncllIQmFMMGsyQnE3YVZHNTVCUzJXdlNncFNk?=
 =?utf-8?B?K2xablZzb1dTUytnNWh1dWNML1llbzkzaXErMkRiM0dSZW5BUmc1WjRWeDNX?=
 =?utf-8?B?SEFnQkxJd1JoSnNOR2xEUUVWcTdmdzFyb0JMT1RVMHBkbjBZVERiWnF0VzY5?=
 =?utf-8?B?dDlsUHE0WXNtSHNxMkxyMUluZWtVUEorWHlLeEhKWTRuTXV3NStkeUVSQUNG?=
 =?utf-8?B?UXdvK0M5QjBkNzAwMFFzWFRUVEpZam5vSGVGVC9VdXRmbTVhQmw3M1RDUGQ0?=
 =?utf-8?B?MGl4R1hNUFExSFNBK082QUxDckswR3VNQTJVUUdYQnhyU29pTlFOR1RuNjdW?=
 =?utf-8?B?T2RRV1V3aTN2Q0h0UFpjVncrRWV0VXpqM1B3dFNnKysxdjFHa0xPRUlPUG15?=
 =?utf-8?B?T1huWFlkMVg1RmxZbzJ4dHEzZUMrL2tXVlZPVW1QYW85cUN0NThwQURob09s?=
 =?utf-8?B?M0FacWdqaTZlb2dBMXM2TnI4SjV4b2pNVXhyTUNNRFNPOGw3MUEvMTJjOHpB?=
 =?utf-8?B?a0lYdUh6YjJ5Q2VyN1BURWFTOGZOOXRYTXA3ckdHaStFemd2VWhaWS91cHkx?=
 =?utf-8?B?K0VXaFdEeXdkN1pBSkh2NklkMDlCR1VDanJZcmtjOXo0c0libG9VY045MXBH?=
 =?utf-8?B?ZHVSejRWOEcrUmZ3OTRaVS90MGNyOC9mZXc1cUpiWkN0Q3R6c0c2K1FGRFM0?=
 =?utf-8?B?Nm1JUVZsWHNFVFc5ekMxWlB6b0I0QXFRVjJib1NETUtrWG92Q2tkWFRBK0o1?=
 =?utf-8?B?WkJqVmxSek93d2JjSnhad2hTS1NzV3dpY0JoOHFVNjNxeUtNVVhVVVBPT0VL?=
 =?utf-8?B?NXdJV3YvN3lMMy9XZzhkRnFmSnRIV0tOUTU2ZjFSTmpOYzBUbUtyQWU4ZG1H?=
 =?utf-8?B?Zm9pNktwc050c1drZHk0UWlHcEhOd0MwM3AxTytQc2E0SUl6NG5kdEY1N21Z?=
 =?utf-8?B?L1Q5VnA2U0tQaWxwaWdUMkVReDMvK0orUG1pZSswVjdJWTlMWG9kU2hKZStZ?=
 =?utf-8?B?TEZvZ1BSbGpFUFBkcEVaVSsrUnFiMjVmenFhQ3dnekhIUnlKOW84MkF1UHhG?=
 =?utf-8?B?L1ZZMGlHWHhoeVM0U1hTL0J1b3ZOcHBLd0Y2OUZtTDFQMzROWkdzQmRxZFA2?=
 =?utf-8?B?NTlVVnB4dGd6aWlKOVN1RTNqOGcyTVdNY0tSL1FwRm96U3J4TzVPajVJSUZu?=
 =?utf-8?B?MkhJVVVKMjRTS3piVzk0SzVIVEwrdTZBY3YxZ2NmWnRyamhtYXJGb2lFaTRX?=
 =?utf-8?Q?6bNZizyZINw1WkDirw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9338.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee45f17b-344a-4eb4-1b6a-08df24e96d55
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 03:08:28.9555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kJlV/4dM4H0I2RNrZ5mhddOYF2eSbCdmKV4AeDWIBfVbDVSr0F+fZ8Zl889MkgTKKZ7aNfcz3VURCuNccu3EZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7121

PiA+IEkgY29uc2lkZXIgdGhpcyBuaWNlIHRvIGhhdmUuIEFuZCB0byBhY3R1YWxseSBpbXBsZW1l
bnQgaXQsIHlvdSBuZWVkDQo+ID4gdG8ga25vdyB0aGUgYmFzZSBmcmVxdWVuY3kgaW4gb3JkZXIg
dG8gY2FsY3VsYXRlIHRoZSBkaXZpZGVyLiBTbyBpDQo+ID4gc3VnZ2VzdCB0aGUgZmlyc3QgcGF0
Y2hlcyBpbiB0aGUgcGF0Y2hzZXQgc2V0IHRoZSBjbG9jayB0byAyLjVNaHosDQo+ID4gdGhlbiBj
b25zaWRlciBvdGhlciBEVCByZXF1ZXN0ZWQgZnJlcXVlbmNpZXMuDQo+IEkgc2VudCB0aGlzOg0K
PiANCj4gW25ldC1uZXh0LFBBVENIXSBlbmV0YzogU2V0IGVNRElPIE1EQyByYXRlIHRvIDIuNSBN
SHogb25seSBvbiBpLk1YOTUNCj4gDQo+IFRoaXMgc2V0cyBNWDk1IHRvIDIuNSBNSHogYW5kIGtl
ZXBzIG90aGVyIFNvQ3MgdW5hZmZlY3RlZC4NCj4gDQo+IFdlaSwgZm9yIHRoZSBvdGhlciBTb0Nz
LCBkbyB3ZSBrbm93IHdoaWNoIFNvQ3MgY2xvY2tzIHRoZSBNREMgKGRpdmlkZXIpDQo+IGZyb20g
d2hpY2ggY2xvY2sgPyBBbmQgY2FuIHdlIGZpZ3VyZSBvdXQgdGhlIGNsb2NrIHJhdGVzIGFuZCBk
aXZpZGVycyA/DQo+IA0KPiBGb3IgdGhlIE1YOTUsIEkgYXNzdW1lIHRoZSBjbG9jayB0aGF0IGZl
ZWQgdGhlIE1EQyBkaXZpZGVyIGFyZSAiZW5ldCINCj4gY2xvY2sgYXQgNjY2IE1IeiAsIGRpdmlk
ZWQgYnkgNjYgYW5kIGRpdmlkZWQgYnkgNCA/IFdoZXJlIGRvZXMgdGhlIDQNCj4gY29tZSBmcm9t
ID8NCg0KU2VlIHRoZSBkZXNjcmlwdGlvbiBvZiBNRElPX0NMS19ESVYgZmllbGQgaW4gUk06IFJh
dGlvIGlzDQoNCigyKk1ESU9fQ0xLX0RJVikrMS4NCg0KQW5kIGFzIEkgc2FpZCBiZWZvcmUsIHRo
ZSBORVRDIHN5c3RlbSBjbG9jayBvZiBpLk1YOTUgaXMgMzMzIE1IeiAoYSBmaXhlZA0KMS8yIGRp
dmlzb3IgaW5zaWRlIHRoZSBORVRDTUlYKSwgc28gdGhlIE1EQyBjbG9jayBmcmVxdWVuY3kgaXMN
Cg0KMzMzIC8gKCgyICogNjYpICsgMSkgPSAyLjUgTUh6DQoNCg==
