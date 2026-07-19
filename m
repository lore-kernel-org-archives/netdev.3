Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AF838E8CB
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 14:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784470114; cv=fail; b=g4OzMjG91dvdlOBKvd+FEuRO0yKprcMAbZaPPdlW3+cvFOANxRLVcLVuYcCOBJOnqObpG1kxD+8tFn8xGZ2eQxfl8tfHpznR+mr8LxmIcqnQhaVso3XJuNf/BmYnb27vXlu9r/BWlSZAc0H3IE0N2QxREA37SojaJ/oer2QJbwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784470114; c=relaxed/simple;
	bh=K60mHNMObMslq1F7vKdgVa3Ob6MFUq+pLkCbZH2eKEY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b1FiFwyiN44A/voEHDvcTK5T00Wxv4TIG8qBdr3pItey7uoqDL2WY9obtN0nO6G4MrYdZ8yGtHCC9wHJSWAQC5F0wYWXetcMVF0VRt4Ni+wq5J8TwWfqX+0O2MoR/uM4RTfYrOB/dzA47GGAlkkczHWpDuXUHEVsDtAOabGCr7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n73MCcan; arc=fail smtp.client-ip=52.101.43.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n73MCcan"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAtbZwxjzXN+VdIq5l3zf2Afu4RYouuWHgtW4msbTAP33Ns/nQbcPJv6mZY0vgM0TXJQnQv6sI+Xlf/F2ONgVKtGufIPBuWiGGOb6fQuXPXSiRM9Xm5kPdQZERfxHKL5LxS1dgGyt0I1ppC0HfGzRCvB9AU8Z6kcCIoS4cA2HhSzzRtWPoKlJkrfkvTXmxGAX5xigGpeTrhdcWg1BORW0M5emv/Mu6au2zQtn580osXFAj8tNgNXoEymxdR98QtpHYh4yJ7o0oABj2juNSy3aLA/UuikVCkbjag7KjroT4LxoYsd4up0Bfo0dC3CGXYaVkNW/NZJQ0PKgpESdmNWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K60mHNMObMslq1F7vKdgVa3Ob6MFUq+pLkCbZH2eKEY=;
 b=M1fMwaEOeL5mE3mPCcVfTnVrXcqzs7RehmMCJCiF/Y+K8zHQvK8R4nfOsbng9qb6SMhyUJXCghvfK33rjBrhbBRVePA0pmv9PlbiKkBNY/nOqLg8ynlIAc0EDb00N+cvWVymPcZsViawk0Cso9852pCbCS2CW3dqRGcqD3M2ew/WgESbPj9QFsIOS4dhnptzNMJO44OKBcbOA+CFfMbbeERJwPYC14xGOxrkAta741LzYqZn9jDtbNLrbYaf5KoU0S9DP8o5gmCTiPZh/gueCaey5NGK8Imcm/iyJ81nEnEe4kZTXtcNaeNVM9Exb885gCg05xscLufUkBxuVpyeCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K60mHNMObMslq1F7vKdgVa3Ob6MFUq+pLkCbZH2eKEY=;
 b=n73MCcan8x9Wt5ULT3pv2/ZBQEUbyJDitq0OoCQUwckB+Jf/R1QJQvzGps3ZFVP1UoOWzuf7uo46BeIDBjvoNjvAkyPFXECjGgjhN+ZO2Lc4L9dyXGowg2BK3mUVRVdXWIQEVdVBAiWnSYtOmmsLkFla7tigrthYSWcizaMvfL7xkeWW7iydQEWODv6imeB5y1UrxVHevXpRSfKIY6Dvs9pOv6HGRCRQHOt4QD6RH0JXrUEP7G7aBngVvmAI6CIcflQHKpQBEmgKq2JGbE9mS3lxsFiCPs+a561MxEg18k2otoa4pHGCUrnhZyZ2DhpoJm/A7NLoy4GnH4rRTUoy/A==
Received: from SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Sun, 19 Jul
 2026 14:08:30 +0000
Received: from SJ2PR12MB9008.namprd12.prod.outlook.com
 ([fe80::e25c:9cce:637a:3dfd]) by SJ2PR12MB9008.namprd12.prod.outlook.com
 ([fe80::e25c:9cce:637a:3dfd%3]) with mapi id 15.21.0223.011; Sun, 19 Jul 2026
 14:08:30 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Aleksander Jan Bajkowski <olek2@wp.pl>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>, "andrew@lunn.ch" <andrew@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"jbe@pengutronix.de" <jbe@pengutronix.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH ethtool-next v3 3/3] qsfp: print all compliance codes
Thread-Topic: [PATCH ethtool-next v3 3/3] qsfp: print all compliance codes
Thread-Index: AQHdF12/U5OFl3l010qZG1SPFUVX57Z04Uow
Date: Sun, 19 Jul 2026 14:08:30 +0000
Message-ID:
 <SJ2PR12MB9008FB06832900F1CC23578ED8C42@SJ2PR12MB9008.namprd12.prod.outlook.com>
References: <20260719090458.659332-1-olek2@wp.pl>
 <20260719090458.659332-3-olek2@wp.pl>
In-Reply-To: <20260719090458.659332-3-olek2@wp.pl>
Accept-Language: en-US, he-IL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB9008:EE_|CH3PR12MB8330:EE_
x-ms-office365-filtering-correlation-id: df7fa95f-f786-4ff4-dd79-08dee59f35f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|3023799007|6133799003|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 k4ehjqv/+YqHyiQMNYmvAB+ywEvFsyj75aYOfPnFBORVBFWHAK8XZ2aHOG4jzgSWCNtmSM4qM464tC/IsICUXyjv/AszUhZFt0SJQTsC62jTm+rXx34gUxyA+8HN4C+aPzdTtvbI5uLJxLi4Tkn+VWzJIMDNeCAI+jvImWxsXWL9eZmGpn6mJkP7DEHhd+ifuFgQkMfiLyOiWgGZJ50PdHLIL4BrNU8n5r294spoCQibiWFn+ilRY2dmrda9mVawi3/KfIsmKlUZWpQMoNCtoWDE+eleZE0bl0ryV13nb9nvH1wm+Uz1+DqHbSvGrU7JBhtghCAtKd5bMPkaaIuCQfDfD0Gxr6TmHirHWZgUvu+y7pwDNKZGig0S9z1iUNwP4AfH5gMrj5v9T57IIWOtbb0jy7MEibMJoR70zwczP7RjGEHSnrdw+tYyTl+M/5vROzUhkKO+h3RNZLUwtF0n7OurhjsqCdrUhmuzxnEEArh/6PUgshxVOBspN0gnsWhy36YZ2dmSZlvDV4c67vTc7Nlrd8adUFwM8KvoXTCAjbUhdNxQ0CBPZTPPEVxCXxcQg/SqwOQbLumuEhqpfScHIUkVb5iBUBHYRu3ny1gPSUUxFrS6phrDi4mbKiZ1WioXt3vMbxNCZSFip6PI8Szlrq22HTdYk4Z9fKWflUJ/fuOJI9WbDLDkAvgRGzU0vPmY8SZ4obHpAe5YPXnxaw4AheXSIMd7xc3KpVUiDJ7pEPE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(3023799007)(6133799003)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WGlmSVpGUUhWOE5zTks4MFp0Y1FkeEJva2NUb0xwRE9kMENmTlhKZFF6MWhR?=
 =?utf-8?B?UkhGNWZWNEZ5NGtDODFpQzdGR09OejV0MThUWWpZc243eXd4VldUbVh4TVFp?=
 =?utf-8?B?MDE0MnVZTUxMRFp3SmtmZVF2TXBDOGt0MFRKa3NWL2c4d0l0aWsvWXA5U1Rs?=
 =?utf-8?B?K2hsSGVjTGFZV1VldXMySWpsR0VocWtpUDRodkQ2NDZDVEFiL085UWkyam9Q?=
 =?utf-8?B?RHplV0NHcER1T2RST2lKRGlQMnRWSVNxVGVoaWk3L1BaSHk5dGZON1lLb0Vt?=
 =?utf-8?B?blgvMThPbHp4NmRncWZ6bDFmdUVnRm80S3dCc3gzRUZaRVF1c1U5RXowNEI0?=
 =?utf-8?B?QnJtdGJ4NEZrM2NEa2haVDJXTmlYeG5oNGJMMTRORGpWUkxtbUU2bUNPbUVR?=
 =?utf-8?B?Z0E4V0MvZ3BOT3RkdnozYzY3Ui84bERENkhOdURtWmtKaWJWb3VTQkhNb3ZV?=
 =?utf-8?B?TmVrRUkxNFlMR3lLWHR3aVJJTWh2cXQ4dFhQZXcxV1p0M3I2SGszM0Y4bnk4?=
 =?utf-8?B?THNWUk9UR3hoMUVQQ1RobU5LU3F0TzdQY1FXaTVGTU5mTURTUTBVYktMQmE4?=
 =?utf-8?B?OGVneXZNV0ZRUE1sWTlCMk5yR2RicXlkbFNuZlR6aDU2R1ppTXF6blpxUitT?=
 =?utf-8?B?SytOVGR3RmVWSFFNNkhiQlJmamZKOHhFS0NoMWlLait3TEdQMzA1ZEJkbXhM?=
 =?utf-8?B?SUVJQ1FoNk9HRXRNem94c25zRTFKVWtFMFp0Szd4OHJ2OG15ZlJGb1p0cWp6?=
 =?utf-8?B?MG15Qk9uRVQ1U1Y1UGFmY1I2YW1vVG5tbDFRL29mSkxkSERqemMrN28yVkZZ?=
 =?utf-8?B?ekNPSnFEM2hVWWd2N0Uvd0NVWlRRTzl6YVg1NmRFcE9vazkzUFBDZG9IcjFl?=
 =?utf-8?B?NzBJNEJUbzFmRHd3QVhWYnlTdXNEYXFkZy8zOE83dDZWUVBPNXlFQ0RWUUZE?=
 =?utf-8?B?QW5CNmNUeGpzb1E0K2NQcEFEUzRFVGp4S2xSU2RrelhueGZsUG5JUGlSak8w?=
 =?utf-8?B?QVBodDBaSEp3V0xIQmVBVmhQQXRSTC9qL3VqejQ2ZEJpcklhMlJyWC9RcmVm?=
 =?utf-8?B?S3pFRzN2cFloSVRsMVpSYTBqbk92WS9Ud1pldGhCemlQeDFnNVNxTHpRYVBp?=
 =?utf-8?B?VUlVQUxPSm5YWHdhTnhBSVZCQTBtaDhiMWZWSzZBSEpDbWozMzVHUnlsM1lL?=
 =?utf-8?B?VnZnVTEwcjBwT3NVcFI5UURsR0dzbEdaUDZucURUbFpDTGhuZjZBOWpIWlU3?=
 =?utf-8?B?UWZtVlBhdGdYc05LeWcwdWwxNUhzQVlJbkZOeDZkaDlBajVJRDNDTk9qNVJr?=
 =?utf-8?B?TnlUTVE4SWJqZm1rL244ckdoN2lTV1VPOFJhVGtxb01BUE9wTElDeEMramZQ?=
 =?utf-8?B?TVV3cnFtZ1RyU21ZbmFSQVo0NVdCTGJFb1RGRVRQQ0VlZ3NzNmRhRTI3R0Z0?=
 =?utf-8?B?c2l2NUhyYzRIREFDNEdYKzJSRUQ4NG90RjlWTmtHSVM3QTRucGtsNmhIM0RR?=
 =?utf-8?B?UE5zQnhVUVpCQURZY0hRd1JtQ2hjb3ZmSXg1QkFQWUZUNFIvdEV2SlErRDky?=
 =?utf-8?B?ZFVPOXhhM0lBVGs0RjZzbDdXd0ZBbDk5V3JXbmw2UUJoNHptelNuUW5XeWlt?=
 =?utf-8?B?Mi91SmtFdFBteExnanY4T0paZ0EvVDBHQ0J2MTlJS2J5QUJxd1dnSi9yOE8v?=
 =?utf-8?B?YWdoUy9zU09aeW9RRVkzWnN3UXpHQTlPbldBYWZRakthek44bTVMODNrQkZ2?=
 =?utf-8?B?V3RMWStMWHpjTitsR3gwcWlObENjbUtYaFdJbnJtamlGcUZjcXRKMWNSMk80?=
 =?utf-8?B?a0RlUllzb2czOUFRUitzMndaMytNcWljWUZ3cy9VRUg1MkI5WTA4NDl6elNG?=
 =?utf-8?B?eVhQZWJlWXJ3RmNOU1JxT1JNN2ZVRERkUTN2MWVlNWV4cEZHOVQzVzdhNlQr?=
 =?utf-8?B?NW9vUjVwdCtPY21MM2h2ZTdDYXFKbkVXS0MzdHRlK25IcVVueksvQ3FRMXhx?=
 =?utf-8?B?dEI3UmF0ZWY5M1F0K0NjUXRBOHBrci9aODhHMCtxQXBNaUNtaTMxYzQwbmNt?=
 =?utf-8?B?b2NTUGRVUG9MQ1ZKMkMramVNRHZzVWtnbkZ5bkZSMDhSLzdkZkpWdU9wNFh1?=
 =?utf-8?B?UDlRQjg3SlBNNnNHMzNPZG9vOFJ5N0JFelBoTnZGSFpzeTczd044YUp2S0FD?=
 =?utf-8?B?UHYrcFRFaXdyemZPN1FzdUxwaEFNK3UxOFVRcThGMjc0ZW0zN0lqVzBuZnZn?=
 =?utf-8?B?Q2REUndGZzBWY215MjJzU1ZCd1I2SEtDcjR6c0RjMU1KQkJUaXlWRm9WYWJu?=
 =?utf-8?Q?pEtlqUFYFgb/FC1HdW?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df7fa95f-f786-4ff4-dd79-08dee59f35f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2026 14:08:30.0378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t8YUaqEOvfOuZHudet/psucemWBPcIzm0TuN+uQ3EFIMszGOj4ZWkr6vgtAs/G3cufEy5spy8PEk5c5I24Zjkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGVrc2FuZGVyIEphbiBCYWpr
b3dza2kgPG9sZWsyQHdwLnBsPg0KPiBTZW50OiBTdW5kYXksIDE5IEp1bHkgMjAyNiAxMjowMQ0K
PiBUbzogRGFuaWVsbGUgUmF0c29uIDxkYW5pZWxsZXJAbnZpZGlhLmNvbT47IG9sZWsyQHdwLnBs
Ow0KPiBta3ViZWNla0BzdXNlLmN6OyBhbmRyZXdAbHVubi5jaDsgZGF2ZW1AZGF2ZW1sb2Z0Lm5l
dDsNCj4gZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0
LmNvbTsNCj4gamJlQHBlbmd1dHJvbml4LmRlOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IFN1
YmplY3Q6IFtQQVRDSCBldGh0b29sLW5leHQgdjMgMy8zXSBxc2ZwOiBwcmludCBhbGwgY29tcGxp
YW5jZSBjb2Rlcw0KPiANCj4gUVNGUCBtb2R1bGVzIGltcGxlbWVudCBtdWx0aXBsZSBjb21wbGlh
bmNlIGNvZGVzLiBUaGlzIGlzIGNvbW1vbiBmb3IgZHVhbC0NCj4gcmF0ZSBtb2R1bGVzLiBCZWZv
cmUgdGhlIGBqc29uYCBvcHRpb24gd2FzIGludHJvZHVjZWQsIGFsbCBjb21wbGlhbmNlIGNvZGVz
DQo+IHdlcmUgZGlzcGxheWVkLiBDdXJyZW50bHksIG9ubHkgdGhlIGxhc3QgY29kZSBpcyBkaXNw
bGF5ZWQuIFRoaXMgY29tbWl0IGZpeGVzDQo+IHRoYXQgYnVnLiBDb21wbGlhbmNlIGNvZGVzIGFy
ZSByZXByZXNlbnRlZCBhcyBhcnJheS4NCj4gDQo+IEZpeGVzOiA0MDcxODYyZjU4ZDggKCJzZnBp
ZDogQWRkIEpTT04gb3V0cHV0IGhhbmRsaW5nIHRvIC0tbW9kdWxlLWluZm8gaW4NCj4gU0ZGODA3
OSBtb2R1bGVzIikNCj4gU2lnbmVkLW9mZi1ieTogQWxla3NhbmRlciBKYW4gQmFqa293c2tpIDxv
bGVrMkB3cC5wbD4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjM6DQo+ICAtIGFkZCBwYXRjaCB0byBz
ZXJpZXMNCj4gLS0tDQoNClJldmlld2VkLWJ5OiBEYW5pZWxsZSBSYXRzb24gPGRhbmllbGxlckBu
dmlkaWEuY29tPg0K
