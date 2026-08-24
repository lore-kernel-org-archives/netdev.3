Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012024.outbound.protection.outlook.com [52.101.48.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C811F407590
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584178; cv=fail; b=r3uc87y5iJN/+yFuAcGbF1HPqbCbYXIygL7AdzVu2NaETCB5M2zklIFuyRLFY/81bUigzILJip2mYL2fHi9Ktymqbrw/DtJ3FPEQxmUVIi55J6ZrFeMGzXxfxT9NMkrskqZnVcduFi0gKO6aspRPHnSDUj5kcmrkrTMiTlnPErc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584178; c=relaxed/simple;
	bh=x+BEAv6HahFlltri7N6yN9XHyBB2+QGOiItXU3VpPX0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M4TMnUQaF8PgPDvEEcBW34lR2Qb0fuoKIWPC3yzjRsl/BehTwN1UWT/ozyEJzoPl9Qb20OzYdD/6KEemJGjrZqV7Iu/u0pXHTPuJ98DbRpmGpXuOkHWAtp29yyKAAQeHf8GMifKYWjkxGV8+nZs4KsLyFrcQ+VxbyWDZ9NG1QdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QH+yOg4l; arc=fail smtp.client-ip=52.101.48.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QH+yOg4l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlfwV9nxzijv9rJglD/rLofbVjhvfaR0Xatw/h/+ksGrgB+D0z0pj+Rfsu+3fi8wKGJBqeOAiZ/7JPzMhwW20v/zFX18ypxjvd+K3hQoSfOdDxJnz43BJcBvFyY4GhWgPc8UIelXMsYje9khn2uMKuoYeARzBp091Tf8IrL6q+ezhOM+yWvkP2mc/gTt5zwxRQLCcMwLfHcizxFmtGmJcqybUWrUYezdG9nT3Gp7EHrRoa2mieGMmwkV829z9k6hZccGg3dYiinTeVWvQm6HLrpb0/Zf/X2/qKFNNE9Wgky57ACSyqaSkmDDO62GATIrGov0dY+pDieVIT8DyiPN7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+BEAv6HahFlltri7N6yN9XHyBB2+QGOiItXU3VpPX0=;
 b=jwFYvFW24uMafA86jPmmNfC02POhm+XKN/kDqRdCGCyYkoObxs3u3vFAATytTLYtmiAlOSXXywu04vjIaWgFXCDrx80oAKyBNVEgWmJ+1BQu8CZj60gn53Z7IWenydRv8mciRRsL/GHZrWruvqIwYTVjQnS0LM695fupMw123oqyl8S6J2soKEwn2d8WiIozBy1M6AbgqrGWO8OuvpaqEG7eskeIie8qLSXoFy1CcqV6H1pL21/fnlIoDxmW2UxAW306FNrZMHskHlAR3tL9Wlr099lEz3jksfEbLl5ZYB9oiKwY7tsRrccVDOcE4oNrXRiB3yj28Psvdr31OrypXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+BEAv6HahFlltri7N6yN9XHyBB2+QGOiItXU3VpPX0=;
 b=QH+yOg4lJGCwlK1TUNME/fa8Vv9X26aJiNj8pQyiBw1m7oH4bEzgZ2WCZ9vEK3OpLjqxSu1NkCdAnxRpxhr5uWfWNZw71Ex2LlOeWPRKINe+FriVcQaGTdGPLyxCJg/7L6TaVrB4aPyXUV3auqG5K6OtTNirgi3NeavC/I4tGplvRlQQQSgPfh1vyezZ+wP+zIVMbegR9YoqIIMjLvySx2WYIwtaUryfQwXV1OQWSoqFqgi053Bz+H1/B0YlAMFgqMiadNRyCNBRqj2eDUjJ9iX/K9UpI69toQpp2d0V+44gdIotrJxur/ynTn2aiVu5txiXVBEQmQIzH+9nRcPz2g==
Received: from CH1PPF189669351.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::608) by CH3PR12MB7643.namprd12.prod.outlook.com
 (2603:10b6:610:152::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 15:09:31 +0000
Received: from CH1PPF189669351.namprd12.prod.outlook.com
 ([fe80::fed8:66e3:ec22:8059]) by CH1PPF189669351.namprd12.prod.outlook.com
 ([fe80::fed8:66e3:ec22:8059%8]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 15:09:31 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>, "kuba@kernel.org"
	<kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"edumazet@google.com" <edumazet@google.com>, Boris Pismenny
	<borisp@nvidia.com>, "kuniyu@google.com" <kuniyu@google.com>
Subject: Re: [RFC net-next 1/6] psp: steer Rx queues with the virtualization
 cookie
Thread-Topic: [RFC net-next 1/6] psp: steer Rx queues with the virtualization
 cookie
Thread-Index: AQHdMolalINeIrVjUEanABWmuRmv27arw72AgAGKCgCAAAJDAA==
Date: Mon, 24 Aug 2026 15:09:31 +0000
Message-ID: <4aa7871fcfc4a662d32a7ca7929b07a42a89ff6d.camel@nvidia.com>
References: <20260822225524.2328465-1-kuba@kernel.org>
	 <20260822225524.2328465-2-kuba@kernel.org>
	 <DKWFJ9D12OPD.2ZLQHDM0276G4@gmail.com> <20260824080122.17be0e16@kernel.org>
In-Reply-To: <20260824080122.17be0e16@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH1PPF189669351:EE_|CH3PR12MB7643:EE_
x-ms-office365-filtering-correlation-id: 8bc7629f-70fc-4e61-a780-08df01f1b32b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info:
 sD5QBN1kFsStdfKTiRHJ8I8ksM5F2rwttcr83WL3LQohby50So7edDy2Sa5VfPluzqPpx1GA3+2tBPemkOHEjP2lbUzU7GXyldoKDSvfcOuYBlCYiJs6Ge9qc9z1UFhmNnVEc3OqdKT3p2INJ91rbrzxuUbq7bKQfPwsqceJyNyL54vXAIfcNDvbfaF91D2Hrgw/ZO/w60Loa2yeWU77TsvZdap8AFp4ts2JxtYla7XP5CeDt9dQ5+wRQVQdyU3PzBIr5+TVJoUsrzeLbZLhs/v1DkQh6nNtQqaIaEAdpOqMcw33Vz8Palc7xf6QfccX3NT+QVrd11vPC37nRX9AxXtYibemtHjzDwUU4rCfsXH+3b/RxdnO92DEyty/F4zNcLl/7lHBjssVZRvEIYl53939wzTo52r0h7gqMIajFUUmB2MRc2JCsqe+eG77ErxgKnOiyyRSXpuLjMavZYHHGIpF+eF5ROVEpsiKG/INuP34HuVxeooy3F6MuZZL3K8O76ehxuo99jA8sGhXKTprCXCNcqOL9/Wu5pAWQ1z+2hKRirvlJiOql3+Yh2aOzxBfbGWVGRbQTsKFc/x/TjR8l1BIbx2GEqlDB9dd+HJwMWNTPoI+Ploiuw5HeH7wIZzgutglqX/lO3LTaMz8C0Zd59snuEd2QWT4Vt/dm4NF4GJA/8xGW2Sjw5op+dIQAqbgzepH9StDdZo3zlAVC0xng4HzNmasaT6M+jjI4pzz9do=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPF189669351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R2F6b1pnUXFjZ2wxTmhBMUJKYUYvV0h4bm51UVdQMFp6Y0JCQmQzdFJZaHNu?=
 =?utf-8?B?NHlBV0JISHlFTDUvSkFEOE52WEUyREQ5ZEJScG02WVJlejl2NUJxaGk3V1o1?=
 =?utf-8?B?eDREQlNiNHFkVnVTK09pOTFMa0JXQ1IrTE5qamVKb3FRWVdIUk5vL1NtVHEw?=
 =?utf-8?B?d2hFTmNzaktwcHpFOFI1emxkVHArR2gyYWkvajh5eG13OUtyZWpiamZXSm1z?=
 =?utf-8?B?emt5RjVVd3dPTm1jTVZaRnFnRWFtNjREZEp4Qmp6QVJydmdXSW56NWV3R2E4?=
 =?utf-8?B?eS9TREN5RGU4WXJPenlZY3ZGZ3FHdnFxT1Q4REM0YWNObFg5YTdmQ1dZUzBY?=
 =?utf-8?B?SmFJa1l0Q1pZQnNpWUhXeG12TUtxUFBRbHZ4Wk1sOWlQamRMWktucTNISjQ1?=
 =?utf-8?B?V3dKdUJPVFI3aG9DRHlIMEJGWC9VSHVpVjRzaEZ4ZklkblNhVGpSVkhCbVNr?=
 =?utf-8?B?aWNCYm5rL2luWkFjWTBrRUZNdVhuU3NnSXZ4VGlKT0p1aytKd0lIc1lIVGJH?=
 =?utf-8?B?enhzcHc1bWovY1A2NHcwbzlYdnVCZlJ2a2xhUG9vS2xCODV3MVJONWxEZFBC?=
 =?utf-8?B?VjV3V09Ya2ZjV0Q3by9PbWVRQXdWeUFkSlFYNVBycVZrd1loUW9GTG52UWor?=
 =?utf-8?B?S2cySVZvUU9OYm5JcGluVkVrenQ2NzlscXFWNU1melE5NHl5dk4wUkd2ejNG?=
 =?utf-8?B?aXhrckhGem5SNWdrYWF4dnZ6c2NCNnNaLy9nanpMM2t2cEZ2YkJpaFFORXBY?=
 =?utf-8?B?U0oydlh3emh0UUt1ZjZzcjd5RFRMdHJTbDVicjZYdXpqdlFxbUJuWmJNWUNy?=
 =?utf-8?B?NFJjVHo3MXU1emRFMG5IQ2JRdzVmRUxsMW9pU1JvMkZyOVJuTDdWTWNESUlt?=
 =?utf-8?B?ajUzVWs5ZGttZ0w0K0VYYTJrLzZ2d29jVFAvYk1LQjF0MmFjeVlvdkVESFhx?=
 =?utf-8?B?NEpOVmhHNjcwVVN3NDJLYTBYd2IrNEdLcmNTdGNtN0NSL2F4REMyb0JuSGow?=
 =?utf-8?B?cFJKOS9TclQxRndhdjd2ODljWHN6bzlWUmhtcXB1ai80c1R3OFQveS85R3I0?=
 =?utf-8?B?RVFYdWtJaUgyMDZsa0puZ0FqZFBnRlMrSk84aXBOZFBTTHM3WU9VTThUTHVz?=
 =?utf-8?B?bU9mYjNPN3UzSVVUdlhpa1c2T2YvU1hhc1Z2U2N2RndkWThna09Pb01vclFn?=
 =?utf-8?B?QUlZd1F1YjkxbVlxV1Jjc2VBMHRkUHRPblB2djRHcWxOSWdkU0YyZVcwMUhz?=
 =?utf-8?B?Ui9Hb2Z0ckZmQWx3Ui9kVDNvWDJ1TEFQb09vYUxPVWJCblZhQ25PdTBtanFU?=
 =?utf-8?B?ejQvRnN2WmpBZ016clMzZ1cwWTFCUG1hYVpCNkF6cXJaZHNDeDg2aHFIWjdV?=
 =?utf-8?B?d0pxblVscmxwQ0t5NXladXFqYldXZGhjWkJsNlE2UEg1ZE5GbFZkU3hTNEtD?=
 =?utf-8?B?RTVJd3RSenhyRlo5cmdtalZuWS9mVVZoQ3ZPSTFxMllpNzVIb3JCblBsZEJJ?=
 =?utf-8?B?eE1wSmZVbzhuRVIwQlVCbk5KOElYSENQVVB2OGxGWk9UQ3FmZCszMG1jbUVk?=
 =?utf-8?B?b3l6czBycTV2N0RZQnhuV3FDNWpuK0JsT09IUXU0Y1YvM0QwM2FzVzNGclFk?=
 =?utf-8?B?TFBsZjFQVTViUUx1RnZSOHc5R2ZEZlI5N1haTHJia1RwUzRRR0hzM2wvT0h2?=
 =?utf-8?B?ZTFjem5qYkpuVDJGMFV0OXJWZEpOZ2hDOHZIZ2hjc2prUFk1b1k4bzA0ZFAy?=
 =?utf-8?B?WmpFcCtvLzZreXNwVk9WUjRuSWU1TGV4bjhia01oTDRDamR0bHNUK3ZVYmlO?=
 =?utf-8?B?a2lEdlhwb0Z5SnlaWlpIQnVkM1Y5d0RmV1pNd0cxY1JHb0NKaGhPM2lrWVRI?=
 =?utf-8?B?L0dyU2dMUWRRNGpTc05id3E4UVBpSk02WnFsQnhybE4xUk5lNVVjci9LWmhr?=
 =?utf-8?B?Yk42Z1d1R2o1SFhCUGdOMzZ6NUJHRml6Yk9tRnhLaURFMW5oU3pSenNCQkxQ?=
 =?utf-8?B?TTMxaHNXeE9TZ0Z3SVc1TWk5SHpQRER3V2FHZnM1Z1dFemE2V1ZsMTRHbDFk?=
 =?utf-8?B?QzRVQkpVU2lod1ZLek1FS1ZKSTdNbnBXMGZSL1p5Z0RxN0JKUkJSK1dsaHNa?=
 =?utf-8?B?TE1xNmFIK3hRSFhuV3h0VEg5SHlLM3EzUm5HcEdHaVp2MmYzdUdIVm1kTFdX?=
 =?utf-8?B?aFdqYnBHOVRXek5kQ0F1Q3RkUmlKVkNUVEdXSnRqMWg1T0lJcjJhVFRuMkp3?=
 =?utf-8?B?TGVvZXJrNHBnem56c2I0M2NCaW82d2YxNDdoRndLNjkycU1xcGlYaitSU1ls?=
 =?utf-8?B?bXNLU2xwd3JZNTA5bXFpTjFoQlZ0N01NWHB0anRaaGtKTGlHaUtvZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE0ACE1BF8C40E4DBAE4B825881E18F6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH1PPF189669351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc7629f-70fc-4e61-a780-08df01f1b32b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 15:09:31.4210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRm06jsmUKjJEY+bEUnKBIQojyj+tt1prwPCBAes+kZE4HiQc088gb3kBQc1mDYIOTZSNTTmoX8RXO9yxgUW+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7643

T24gTW9uLCAyMDI2LTA4LTI0IGF0IDA4OjAxIC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gU3VuLCAyMyBBdWcgMjAyNiAxMTozMTowMyAtMDQwMCBEYW5pZWwgWmFoa2Egd3JvdGU6
DQo+ID4gT24gU2F0IEF1ZyAyMiwgMjAyNiBhdCA2OjU1IFBNIEVEVCwgSmFrdWIgS2ljaW5za2kg
d3JvdGU6DQo+ID4gPiBAQCAtNzIsNiArOTAsMjcgQEAgbmFtZTogcHNwDQo+ID4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBQcmVzZW50IHdoZW4gaW4gYXNzb2NpYXRlZCBuYW1lc3BhY2UsIGFic2Vu
dCB3aGVuIGluDQo+ID4gPiBwcmltYXJ5L2hvc3QNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
IG5hbWVzcGFjZS4NCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgdHlwZTogZmxhZw0KPiA+ID4gK8Kg
wqDCoMKgwqAgLQ0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgIG5hbWU6IHZjLXN0ZWVyLWNhcA0KPiA+
ID4gK8KgwqDCoMKgwqDCoMKgIGRvYzogfA0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoCBEZXZp
Y2UgY2FuIHN0ZWVyIHJlY2VpdmVkIHRyYWZmaWMgb24gdGhlIFBTUA0KPiA+ID4gdmlydHVhbGl6
YXRpb24NCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqAgY29va2llIChWQykuIFRoZSBWQyBpcyBz
cGxpdCBpbnRvIGEgMzJiIHJlc2VydmVkIHBhcnQsDQo+ID4gPiBhIDE2Yg0KPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoCBxdWV1ZSBJRCB0aGUgc2VuZGVyIGlzIGFza2luZyB0aGUgcGVlciB0byBz
ZW5kIHRvLCBhbmQNCj4gPiA+IGEgMTZiDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgIHF1ZXVl
IElEIGdyYW50aW5nIHRoZSBwZWVyJ3Mgb3duIHJlcXVlc3QuIFN0ZWVyaW5nDQo+ID4gPiBpbnN0
YWxscyBsb3cNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqAgcHJpb3JpdHkgcnVsZXMgbWF0Y2hp
bmcgdGhlIGxhdHRlciwgd2hpY2ggd2luIG92ZXIgdGhlDQo+ID4gPiBSU1MgdGFibGUNCj4gPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqAgcmVzdWx0LiBPbmx5IG5lZWRlZCBmb3IgdGhlIHJ4IGRpcmVj
dGlvbjsgZ3JhbnRpbmcgYQ0KPiA+ID4gcGVlcidzDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
IHJlcXVlc3QgaXMganVzdCBoZWFkZXIgZ2VuZXJhdGlvbiBhbmQgbmVlZHMgbm8gZGV2aWNlDQo+
ID4gPiBzdXBwb3J0Lg0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgIHR5cGU6IGZsYWcNCj4gPiA+ICvC
oMKgwqDCoMKgIC0NCj4gPiA+ICvCoMKgwqDCoMKgwqDCoCBuYW1lOiB2Yy1zdGVlci1lbmENCj4g
PiA+ICvCoMKgwqDCoMKgwqDCoCBkb2M6IHwNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqAgRGly
ZWN0aW9ucyB0YWtpbmcgcGFydCBpbiBWQyBiYXNlZCBxdWV1ZSBzdGVlcmluZy4NCj4gPiA+IExl
YXZlIHRoZQ0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoCBhdHRyaWJ1dGUgb3V0IG9mIGEgZGV2
LXNldCByZXF1ZXN0IHRvIGtlZXAgdGhlIGN1cnJlbnQNCj4gPiA+IHNldHRpbmcuDQo+ID4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgIEFwcGxpZXMgdG8gYXNzb2NpYXRpb25zIGNyZWF0ZWQgZnJvbSB0
aGVuIG9uLCBleGlzdGluZw0KPiA+ID4gb25lcyBrZWVwDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgIHRoZSBzZXR0aW5nIHRoZXkgd2VyZSBjcmVhdGVkIHdpdGguDQo+ID4gPiArwqDCoMKgwqDC
oMKgwqAgdHlwZTogdTMyDQo+ID4gPiArwqDCoMKgwqDCoMKgwqAgZW51bTogdmMtc3RlZXINCj4g
PiA+ICvCoMKgwqDCoMKgwqDCoCBlbnVtLWFzLWZsYWdzOiB0cnVlDQo+ID4gPiDCoMKgIA0KPiA+
IA0KPiA+IFNob3VsZCB2Yy1zdGVlci1lbmEgYmUgYSBjb25uZWN0aW9uIGxldmVsIHNldHRpbmc/
IE1heWJlIGl0IGNvdWxkDQo+ID4gZ28NCj4gPiBpbnRvIHJ4LWFzc29jLiBUaGUgd2F5IGl0J3Mg
aW1wbGVtZW50ZWQgaGVyZSwgdGhlIHN0YXRlIGlzIGFscmVhZHkNCj4gPiBwZXINCj4gPiBhc3Nv
Yy4NCj4gDQo+IFRoYXQncyB3aGF0IEkgc3RhcnRlZCB3aXRoIGJ1dCB0aGVuIGdpdmVuIHRoZSBz
ZWN1cml0eSBpbXBsaWNhdGlvbnMNCj4gb2YgdGhlIGN1cnJlbnQgc2ltcGxlIGRlc2lnbiBJIGNv
dWxkIG5vdCB0aGluayBvZiBhIHJlYXNvbiBkbw0KPiBjb25maWd1cmUNCj4gdGhpcyBjb25uZWN0
aW9uIGJ5IGNvbm5lY3Rpb24uIEJlc2lkZXMgdGhlIFNXIHN0YWNrIHJlc3BvbnNpYmxlIGZvcg0K
PiBzZWN1cml0eSBpcyBsaWtlbHkgc29tZXdoYXQgb3J0aG9nb25hbCB0byBzdGVlcmluZyBjb25m
aWd1cmF0aW9uLiANCj4gU2hvdWxkIGhhdmUgcHV0IHRoaXMgaW4gdGhlIGNvdmVyIGxldHRlciBh
cyB3ZWxsLg0KDQpJIGxvb2tlZCBhdCBpbXBsZW1lbnRpbmcgdGhlIGN1cnJlbnQgZGVzaWduIGlu
IG1seDUgYW5kIGEgcGVyLWFzc29jDQpzZXR0aW5nIHdvdWxkbid0IGJlIGVub3VnaCwgYmVjYXVz
ZSBmbGlwcGluZyB0aGlzIG9uIHJlcXVpcmVzIGRldmljZS0NCmxldmVsIHN0ZWVyaW5nIGNoYW5n
ZXMgKGJhc2ljYWxseSBhZGRpbmcgbnVtX3F1ZXVlcyBzdGVlcmluZyBydWxlcykuDQpGb3IgZGV2
aWNlLWxldmVsIHNldHRpbmdzLCB3ZSBjb252ZW5pZW50bHkgaGF2ZSB0aGUgLnNldF9jb25maWco
KQ0KY2FsbGJhY2suIFRoZXJlJ3Mgbm8gcGVyLWFzc29jIGNhbGxiYWNrcywgYnV0IHRoZW9yZXRp
Y2FsbHksIHdlIGNvdWxkDQpkZXRlY3QgdGhlIGZpcnN0IHVzZSBvZiBWQy1iYXNlZCBzdGVlcmlu
ZyBhbmQgZG8gdGhpbmdzLiBEb2Vzbid0IGZlZWwNCnRoYXQgY2xlYW4gdGhvdWdoIGNvbXBhcmVk
IHRvIGRldmljZS1sZXZlbC4NCg0KQ29zbWluLg0K
