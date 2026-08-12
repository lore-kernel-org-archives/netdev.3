Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07A81D5AD4
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 20:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786565114; cv=none; b=PON5qXCwDWKvr5ofoAujC5SKEy6EmO0Q1QzLu6Q9JAIef0NOBBo6+i/6eyt71N0t9HiD6pzZyYh8RsDTkJTbSWDWWp0uapePYMXcTii4uNjh5qD1UKSHdvTBUOSasx0WrDcRcxEjDNb88M6Bvd9KXKzWVijTwFk8FlsLeR+FgzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786565114; c=relaxed/simple;
	bh=+XToLgUHHiyvAoAGQPE05To72aIvWRgNHpvASNmKryk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Dzj/m0aGh2V0Sej2kh4ZNtHKpptSwW40k+0xWbKoYCPgGyVinOiU5HHf5Rekjxfb/nlbp7y8LFJ3OvztuSs+5ECGQbbaxKzKfYS1DISkDXkNpuGrP7sY//qDg03ggOIP/+xhk43wdCRPh1Fw/weOBsjnLt6PSKVKfy3R/ce49jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=cjsh/w2e; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="cjsh/w2e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1786565112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+XToLgUHHiyvAoAGQPE05To72aIvWRgNHpvASNmKryk=;
	b=cjsh/w2ewVEYaEkfDywBb00KD04glKy1zvq0gFl3SNovLYPaE4+H8bQWN4Eh9gyP4Hgh6X
	l+jesb5gGKLu+0KyXtr0oD+ep8TPlFgoL5HtRNZYl3GXaAlVwzBELZNBj/d1P5XQkoUZLO
	OPwbty6RNaYjIgDObjm+dJyCU3OdsRvfth4H1paaoVbXSkTqrJO9wuw8b8giLSXWKeIqwi
	DmtnLToYkHC9heT2Me7b9OR7x4y2O2eaK7t+0YXw7K2CMeTLk10vcJKjfFdQ+Pd7dCoIkQ
	u0pzFADr0rRrfAQmTm1q1JcJCXktnvZIGpwD7cQZr0A5rFJRnsGID9SnUtxwGA==
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012069.outbound.protection.outlook.com
 [40.107.200.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-57-JU9MRo0WMR2fhszcGtwA6A-2; Wed, 12 Aug 2026 13:05:09 -0700
X-MC-Unique: JU9MRo0WMR2fhszcGtwA6A-2
X-Mimecast-MFC-AGG-ID: JU9MRo0WMR2fhszcGtwA6A_1786565108
Received: from MWHPR02MB3375.namprd02.prod.outlook.com (2603:10b6:301:61::16)
 by SA1PR02MB9832.namprd02.prod.outlook.com (2603:10b6:806:376::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 20:05:05 +0000
Received: from MWHPR02MB3375.namprd02.prod.outlook.com
 ([fe80::f19:3f8f:e27a:e484]) by MWHPR02MB3375.namprd02.prod.outlook.com
 ([fe80::f19:3f8f:e27a:e484%4]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 20:05:05 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: "parthiban.veerasooran@microchip.com"
	<parthiban.veerasooran@microchip.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "Parthiban.Veerasooran@microchip.com"
	<Parthiban.Veerasooran@microchip.com>
Subject: RE: [PATCH net v5 1/4] net: ethernet: oa_tc6: Protect skb pointer
 used by two different kernel instances
Thread-Topic: [PATCH net v5 1/4] net: ethernet: oa_tc6: Protect skb pointer
 used by two different kernel instances
Thread-Index: AQHdH8POOUHFFXklf0uzf4K1fEFxZ7aQyjyAgAogLWA=
Date: Wed, 12 Aug 2026 20:05:05 +0000
Message-ID: <MWHPR02MB3375A1D6694AF69928D72D1083DC2@MWHPR02MB3375.namprd02.prod.outlook.com>
References: <20260729-fix-race-condition-and-crash-v5-1-3906bc485daf@onsemi.com>
 <20260806092055.101202-1-pabeni@redhat.com>
In-Reply-To: <20260806092055.101202-1-pabeni@redhat.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR02MB3375:EE_|SA1PR02MB9832:EE_
x-ms-office365-filtering-correlation-id: 4d900d71-1aa5-425d-9252-08def8ad00a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|38070700021|6133799003|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003
x-microsoft-antispam-message-info: cv3TPtctbj7Hk1RBMCu2NgXr7yA14J0Xq/K+w/3mZuxBg3+AFX9F60qi0Fx1BUS9SEovnSDdU3JCV+wupQ8VBz18l0jjmvimWIEVtwhObTGe84Gofu8uRxrToAs763PT6oyzcbYbM4ecqmD0XCt4WUC5lt4XfRoym480GaigbDQ3NwEa8vOlaUFWa2HReM0ZGema6RcxaLpCUo977/0asFJbbKViPuz4cFgs6mTKb+Hlk1vMXnmYqayraNJlWFbBSZ4XjfxexAv/UdGADvJq5UgrL3+4DPliZwxI+zg7B4714Rh3/Ax8STBYNSaOxDldWYTGNAgq+u0iwLUm2H9LpYMj2tE88cm5pRC7Iy8PprM8OgsrZ2X5WYplB+B5sOW0iDGREEL34en6ojxWkg5v5QSvpEEQawtSvu2m4dXLxU7ov3HKCmuj1emzTtcbqH/WVUbG7jmCYLEGWA/qhAWse1jssBHVdkPZ+XdDvJv1MDTd2r3mYvpMM49a/z82A4b/WCgWSVRS/8o22eQf0Li4Brq8tISV18n7X2SVhNKXMA8RFay177HCbWxdnLcMo5K4y+Dtpt6T7YuyXTD3RZnHwA+heUqmLdyy4PBxK6OGQ6UJjv1wDECDJmrRk7ExRR7BaipoPGmhmMQSQI0WJR/GPY2PS3tEypHpchVB/q+b1XeFW2/qXpGSPNb3RHx9a+D4OFkAaDhm2fwvQ0gxiVgkSx/FMHyHTWNg4+XJJi1T+iM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB3375.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVE1UEh5VzBDUmFtcTZNcDFCdSswcmRpdTF1QnhhTjdNQVhsV20xL3NqS0dt?=
 =?utf-8?B?c0Q0WmhYQlVIbHNpQjFaK0t3OGptaFJSNzlsdCtOVWdld0kzOUVkamZ1OU1t?=
 =?utf-8?B?b2xpNUhqU3ZuazZ0MzZJb01LTjV5VWNocTA3ekhhL0JPbVVTUHh2alVrcWxB?=
 =?utf-8?B?T2tvWGZuYmdPMDF5eTlxS1JlNkVPTzZyWWhHVkdSSVBxNWlOb0IvYkN1Ym8v?=
 =?utf-8?B?VFpUUStWOTdwdTJlT21XRkpCNklBeUJ5NWFsMlRnemswaTUzeDJkL2hzVjFt?=
 =?utf-8?B?Q3VoNjZOQnlJdmlicFo0SXo3Sy9TdmJiMGNmYnZCb1VhMVMrb1I2UXhjb1ZU?=
 =?utf-8?B?Zm9ncWdNcUQrTWlEWnZ0b21kblYzWHcyUGN5cm1BcVRwWW0zVkFWbmorazA1?=
 =?utf-8?B?MVNBcDJDdE9YcTYvNXZnL3FIMFU0RlpEa2o0SWdQUGZxVDdBZGdzc0c1MkE2?=
 =?utf-8?B?am1QOWJNSnNzSzVSbEkvK2lIcVE1M1lvWHcxd1BOYlpXRVNyT0s5M0pXSVo0?=
 =?utf-8?B?anhXdWIxQjRTd3cxVm5yU3dZN21KaUdoZDJDbjdta1pXSWxkZGNnZnM1MkVX?=
 =?utf-8?B?anhjaE45QmdDMEZXelk2cFo2STJYZm5CU21raEhuc25sZmEvRUNQa3Q1YXUz?=
 =?utf-8?B?YVBOTGRBbzdvYU5vd1FYeWcyQ2RQY01kNG5pM0NCVENUSUNrL1JkalhUQk54?=
 =?utf-8?B?eUhlMXhEekF5cHJaUWhjWXlRcm90ekdKV21XeW9RS1ozSnZMa2plWE5XT2FJ?=
 =?utf-8?B?Q1R2YWJzWEhHa0premxpSnRnNThhV2ZoRzNEdDR6R0hMUjMrQzYzWTVnSVBJ?=
 =?utf-8?B?MWVJOVgyUm45bnRUTy8xSE5uTThFRm9jOGw4Q2xBMWZyYUhUTEtTZlpVTW5H?=
 =?utf-8?B?dWwrZnZ0REVWc20xazkxR0RPbURGRktGblh4TXI1bFpqRGF6c1RZNDByWEJI?=
 =?utf-8?B?YkljNlQwajk3U2FnN1ZyL3FZVEVQZWw3RkdrVVZHNHJGenVxYUFqUllyM2Mx?=
 =?utf-8?B?NkNIcXRnQzJUaHAvcnhXYXBEU0gxZ1NUQVM2TVJReFZWTHBBN1NKS2pGQ084?=
 =?utf-8?B?ZTE0L1VDdS82SFFNdnQwZCt4cGMwWGlTdjU4T2ZUaTY2Smo2MGt4S3BtbmxZ?=
 =?utf-8?B?VFBTTlNkK1hzbnFPemJyc1JPNVNyTDhsanI2SjZrQWxZSk9GUzJXTDk3a0lp?=
 =?utf-8?B?czVheGIzc3ROQ2hEMm1Kd0lkT2sxVVA4bXBWZEM0TDBVQ2NhZTUyRFkxQTdI?=
 =?utf-8?B?MVdjbDg2WE5OWkFIaUU4djVBZmdYcnZwRklQQm55NmswN0RuQ3doNmV0UytU?=
 =?utf-8?B?aGJFb1NGYUprQUYwL2JNNXdlTnZQb0ZFdHV1TUNJeGt1OFVtM3YwMjZKcTF5?=
 =?utf-8?B?WVE3LzNjTE1TenVrR1ZFVHpRbXVjN2FWeEFCMURlU0llKys1L052Y2ZMazNt?=
 =?utf-8?B?eDVZTlFrQVhtRVc3Vmh2U01najFLckRBZGR5UGdFbFE1UDVpaWp2eXh1SnMx?=
 =?utf-8?B?WEhHNWhTR0piUWhrYzUvcDdWaFVyaDJycko5Nmp2MVBnNVh6K0JyalhKdmhj?=
 =?utf-8?B?MUhsYkRlUTNaZDZZK3Q2RFFYTjZOVVpwZE1GWEZhaS9oR0ZNL2hIKzA0Wnlr?=
 =?utf-8?B?YVpON3lwcmNMdnh1Vm5nTS9wT2o5V1lzVzVzNXNpTjNqclhKYStlUmFxZkV3?=
 =?utf-8?B?aHVZdUlUeEYrOVZEdlNtUWlPR3dBY3RNZy9Cb0psYzZXaUF5QmFweUNiWW9P?=
 =?utf-8?B?cS9BVWlJMnNLeEllZDJvUzl6bS9zdVNEaTAvVDlYayt3SFRLVHpOeXo2ZWNq?=
 =?utf-8?B?cXFOVUFPR3hSd1Q4b2lSOXN5NTJtSnhIMUZhWTcraStzV2oyTmtWdEpUenRp?=
 =?utf-8?B?MnhWMmowN1RPQ3FDVzV6dmZRSUR2blRIWFV1clBzZ3FSM3R3aU41bWV3NE5z?=
 =?utf-8?B?d2d6NGkzbHh0dVJDWlBaMjhkNW53K21yaEI4SVBFNlh1S0pmTEU1MlExcnRO?=
 =?utf-8?B?NHdCMUcyQlZqNy9LdjZleXVTK1laUU1KYjBwZk1lZTl0MTNnV3hxdElTTTRR?=
 =?utf-8?B?N1lEeWVyNzBXNk9BU0o1ZGVLNFBOclJmdDcwbTFvMFpsVUJCZFl1YWg3Y3Qy?=
 =?utf-8?B?bGhSbmtxbHU2bmVCdmlEMGZpNzNYRjgvNHdCVDBwTmh4QjRuNEtHY0Y0UFhx?=
 =?utf-8?B?RVpXN1FoSUVsTWIrYjdwTUhmK3dqWmo4Yzc1T2VuYStpdXJmK1NPL29IM0tG?=
 =?utf-8?B?bUJCM1hnSEFacFZmN0JQZEliZlRKMDhrelViM0R2cDQ2K3hmQ2wycE0xa2Fq?=
 =?utf-8?B?dVpFU0U3dThBVHdPWEE5Z2xUNHlub1dPeVlDRXkwaGhCMHluQjlvZz09?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: m6+L8aiBljnO2JljUdqJRkLGnXkUcuuafQBUFVkGpIf4QRDPOvEfY2nVW2NmKiCi4JFEhKKjaX4KTEVnksVNlgv99v9YAaZwCGyKlmVtjcIuLPG3eCK8sTwXrp07ZiJ555kGepz2Fdc9iqEey8T+h//IbqK5KZjR+z2UWp95NZhx4eSGIZRb/s4CInbzKn+eXNe7Z55Iy8daW7VDWsjxkZ1xE/LBoXfCPwKj+3ce4qFOGFgarnVem4ODOS9LfXSTNJig0aFmSc6iuNiGEhPtgqsbTFmJeWtRHIiCGV1mueHSG7F4tVZ89tiM61NndiRI+tNdIX+cVdoJxp69yQLWAg==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB3375.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d900d71-1aa5-425d-9252-08def8ad00a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 20:05:05.6415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NSP+1Txls5IKuwr5L1Vm+vBrMaE27mwKoOyCpVA/DtSnl6NALsM4SZBADsiYz2ctZ890w3DhdULTel5aY6iIDxef7p/pN3Vj4Prvst+RwnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB9832
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wKFBUjS-63clz6-aBDM3hF_0qWuXzmZui-JwA1Dj1wU_1786565108
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5p
QHJlZGhhdC5jb20+DQo+IA0KPiANCj4gW1NldmVyaXR5OiBNZWRpdW1dDQo+IFtGaW5kaW5nOiBt
YWluLTEtMV0NCj4gW1NvdXJjZXM6IG9wdXMtNV0NCj4gU2hvdWxkIHRoZSBjaGFuZ2Vsb2cgbWVu
dGlvbiB0aGUgb3RoZXIgYmVoYXZpb3VyYWwgY2hhbmdlcyB0aGF0IGNvbWUgd2l0aA0KPiB0aGlz
IGZpeD8gVGhlIG1lc3NhZ2Ugb25seSBkZXNjcmliZXMgYWRkaW5nIG11dHVhbCBleGNsdXNpb24g
Zm9yDQo+IHdhaXRpbmdfdHhfc2tiLCBidXQgdGhlIHBhdGNoIGFsc286DQo+IA0KPiBUaGUgZXhh
Y3QgaW50ZXJsZWF2aW5nIHRoYXQgbGVha3MgdGhlIHNrYiBpcyBhbHNvIG5vdCBzcGVsbGVkIG91
dC4gU2luY2UNCj4gdGhpcyBjYXJyaWVzIGEgRml4ZXM6IHRhZyBhbmQgd2lsbCBiZSBwaWNrZWQg
dXAgZm9yIHN0YWJsZSwgY291bGQgdGhlDQo+IG1lc3NhZ2UgZGVzY3JpYmUgdGhlIGxlYWtpbmcg
c2VxdWVuY2UgYW5kIHRoZSByZXR1cm4tY29kZSBjaGFuZ2U/IFRoZQ0KPiBkaXNhYmxlX3RyYWZm
aWMgbG9ja2luZyBpcyBvbmx5IG1lbnRpb25lZCBpbiB0aGUgdjMgY2hhbmdlbG9nIGJlbG93IHRo
ZQ0KPiBjdXQsIHdoaWNoIGlzIGRyb3BwZWQgd2hlbiB0aGUgcGF0Y2ggaXMgYXBwbGllZC4NCg0K
VXBkYXRlZCBjb21taXQgbWVzc2FnZSB3aXRoIG1vcmUgaW5mby4NCg0KPiANCj4gSW4gb2FfdGM2
X2V4aXQoKSB0aGUgc3RvcmUgaGFwcGVucyB1bmRlciB0aGUgbG9jayBhbmQgZGlzYWJsZV9pcnEo
KSBvbmx5DQo+IHJ1bnMgYWZ0ZXJ3YXJkczoNCj4gDQo+IHNwaW5fbG9ja19iaCgmdGM2LT50eF9z
a2JfbG9jayk7DQo+IHRjNi0+ZGlzYWJsZV90cmFmZmljID0gdHJ1ZTsNCj4gc3Bpbl91bmxvY2tf
YmgoJnRjNi0+dHhfc2tiX2xvY2spOw0KPiBkaXNhYmxlX2lycSh0YzYtPnNwaS0+aXJxKTsNCj4g
DQo+IENhbiBhIGxldmVsIHRyaWdnZXJlZCBpbnRlcnJ1cHQgaW4gdGhhdCB3aW5kb3cgbWFrZSBv
YV90YzZfbWFjcGh5X2lzcigpDQo+IG9ic2VydmUgYSBzdGFsZSBmYWxzZSwgc2V0IGludF9mbGFn
IGFuZCB3YWtlIHRoZSB0aHJlYWQsIHdoaWNoIHRoZW4gdGFrZXMNCj4gdGhlIGVhcmx5IHJldHVy
biBhYm92ZSB3aXRob3V0IGRvaW5nIHRoZSBkYXRhIGNodW5rIHRyYW5zZmVyIHRoYXQNCj4gZGVh
c3NlcnRzIElOVD8NCg0KTW92aW5nIGRpc2FibGVfaXJxIGNhbGwgYmVmb3JlIHNldHRpbmcgdGhl
IGRpc2FibGVfdHJhZmZpYyBmbGFnLg0KDQo+IA0KPiA+IHNwaW5fbG9ja19iaCgmdGM2LT50eF9z
a2JfbG9jayk7DQo+ID4gKyBpZiAodGM2LT53YWl0aW5nX3R4X3NrYikgew0KPiA+ICsgbmV0aWZf
c3RvcF9xdWV1ZSh0YzYtPm5ldGRldik7DQo+ID4gKyBzcGluX3VubG9ja19iaCgmdGM2LT50eF9z
a2JfbG9jayk7DQo+ID4gKyByZXR1cm4gTkVUREVWX1RYX0JVU1k7DQo+ID4gKyB9DQo+IA0KPiBb
U2V2ZXJpdHk6IExvd10NCj4gW0ZpbmRpbmc6IGZhYmxlLTUtMS01XQ0KPiBbU291cmNlczogZmFi
bGUtNSwgb3B1cy01XQ0KPiBEb2VzIG1vdmluZyBza2JfbGluZWFyaXplKCkgaW4gZnJvbnQgb2Yg
dGhlIHdhaXRpbmdfdHhfc2tiIGNoZWNrIGNoYW5nZSB0aGUNCj4gYmFjay1wcmVzc3VyZSBwb2xp
Y3k/DQo+IA0KPiBQcmV2aW91c2x5IGFuIHhtaXQgdGhhdCBoaXQgdGhlIGJ1c3kgY2FzZSByZXR1
cm5lZCBORVRERVZfVFhfQlVTWSB3aXRob3V0DQo+IHRvdWNoaW5nIHRoZSBza2IuIE5vdyBldmVy
eSB4bWl0IGxpbmVhcml6ZXMgZmlyc3QsIHNvIGEgdHJhbnNpZW50DQo+IHNrYl9saW5lYXJpemUo
KSAtRU5PTUVNIGR1cmluZyBhIGJ1c3kgcGVyaW9kIGZyZWVzIHRoZSBmcmFtZSBhbmQgcmV0dXJu
cw0KPiBORVRERVZfVFhfT0ssIHdoZXJlIGJlZm9yZSBpdCB3b3VsZCBoYXZlIGJlZW4gcmVxdWV1
ZWQgYW5kIHJldHJpZWQuDQo+IA0KPiBUaGUga2VybmVsLWRvYyBhYm92ZSBvYV90YzZfc3RhcnRf
eG1pdCgpIHN0aWxsIHNheXM6DQo+IA0KPiAqIFJldHVybjogTkVUREVWX1RYX09LIGlmIHRoZSB0
cmFuc21pdCBldGhlcm5ldCBmcmFtZSBza2IgYWRkZWQgaW4gdGhlIHR4X3NrYl9xDQo+ICogb3Ro
ZXJ3aXNlIHJldHVybnMgTkVUREVWX1RYX0JVU1kuDQo+IA0KPiB3aGljaCBubyBsb25nZXIgY292
ZXJzIHRoZSBkcm9wIGNhc2VzLiBTaG91bGQgdGhhdCBiZSByZWZyZXNoZWQgdG9vPw0KDQoNClll
cy4gVXBkYXRpbmcgdGhlIGNvbW1lbnQgdG8gY292ZXIgYWxsIHRoZSByZXR1cm4gY29uZGl0aW9u
cy4NCg0KPiANCg0K

