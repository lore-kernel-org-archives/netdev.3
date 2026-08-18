Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B4B47F76E
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071922; cv=none; b=e/SMCLsASeSyCOapxfU7fUk69D+fr8D+wmbcM6oZQVnza7kMSntCKGDVeh5e+dF1gfIM+sJkbbUHYlqcRJnb03Wrc7gGO3WBnFkfIB1ZJDRzNEvxcqhI0JOeoj2wG08/mohZM/qKN+daJKuPdqLy6CYfthR7OeYIMQAKicTHdpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071922; c=relaxed/simple;
	bh=wSGE5XCU3v15JkfLtFUiE+S5umoL88CXSoGPi9ygBQg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=aIpxoY8f0Fdo8Dj0lNrONyoXDWzpyr2yY53emhnah3hR0de75+NyYIPDg+/2zh05mZhgM0c+BLXxFhx9XFwKxn1BnyLbRY7f0jOCsIA6v9CD46+kS5iWDtV3g2syElqdcpUcajGAWReHrr9dUB4KQdw+KfnVpUDm0cVAQXHU4zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=cOKOD/CQ; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="cOKOD/CQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1787071920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wSGE5XCU3v15JkfLtFUiE+S5umoL88CXSoGPi9ygBQg=;
	b=cOKOD/CQsX9QwDgrTAcNfURoG554KZn/UlHX4aWdpNZHHPjJYItF14KPSdhw/CbnRnfuHM
	PRKwx/FfsSitAH2SNoElIUMxCyY4QSpEOph1lYo0FEsY6dq8hHylpzDQ4CNosw2UKHlTSO
	fEbY9u9JqzO9n6EKvJbBxd+j4SSSkwCHIzCpgZVMB/49DD7ZNtK8z2TLRA3ldWvXBOqXza
	cylen7knCZgjbGwqNU+irHJUd6P/4TNA5h6fMZat741eb0mWu+4wSQVPSPzWuqO8Ee83xj
	r229YE7cN0IaebQaniPSBpGHjp3rWaVxbt9OBwlnSTxzjdnP0j3m+KBDmTjT8g==
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012057.outbound.protection.outlook.com [52.101.53.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-8-SXkK8t4COb2xeq6n2kjVqg-2; Tue,
 18 Aug 2026 09:50:47 -0700
X-MC-Unique: SXkK8t4COb2xeq6n2kjVqg-2
X-Mimecast-MFC-AGG-ID: SXkK8t4COb2xeq6n2kjVqg_1787071845
Received: from DM5PR02MB3369.namprd02.prod.outlook.com (2603:10b6:4:68::27) by
 CH8PR02MB10947.namprd02.prod.outlook.com (2603:10b6:610:2bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 16:50:43 +0000
Received: from DM5PR02MB3369.namprd02.prod.outlook.com
 ([fe80::a77f:334f:452d:2b3e]) by DM5PR02MB3369.namprd02.prod.outlook.com
 ([fe80::a77f:334f:452d:2b3e%6]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 16:50:43 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Selvamani Rajagopal via B4 Relay
	<devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>, Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>
Subject: RE: [PATCH net v6 3/4] net: ethernet: oa_tc6: Disable tx queues on
 fatal error
Thread-Topic: [PATCH net v6 3/4] net: ethernet: oa_tc6: Disable tx queues on
 fatal error
Thread-Index: AQHdKs/q7VW66rKlKES7HGsioAxWYLakAY2AgAADN9CAAAQoAIAABGZw
Date: Tue, 18 Aug 2026 16:50:43 +0000
Message-ID: <DM5PR02MB33696A05581D6E113BB0665583A62@DM5PR02MB3369.namprd02.prod.outlook.com>
References: <20260812-fix-race-condition-and-crash-v6-0-6cf90f4a271a@onsemi.com>
	<20260812-fix-race-condition-and-crash-v6-3-6cf90f4a271a@onsemi.com>
	<20260818090655.1e28cd61@kernel.org>
	<DM5PR02MB33692A7DA56968540A3F950383A62@DM5PR02MB3369.namprd02.prod.outlook.com>
 <20260818093318.68a6e099@kernel.org>
In-Reply-To: <20260818093318.68a6e099@kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR02MB3369:EE_|CH8PR02MB10947:EE_
x-ms-office365-filtering-correlation-id: 7483741a-f7eb-43fb-43ad-08defd48d7a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|366016|38070700021|56012099006|10067099003|4143699003|18002099003|22082099003|11063799006
x-microsoft-antispam-message-info: HtnETj/g5UQ99+l82yA+nEtVV8enByE3HIfyjo8MRJizeCq6rRAW9lqjzhAm3BHO1ixKQBDqrBsDdikpQ+LWesFz3ey2WuUmxpSSP/QpWv574vYenitFqCt07yM0wkg3UfYtKPkQe+LE2jzLbh6KFjzuDvjqnqXCDPzUKKFZ12ZXOn8bHiqal/Bnkn25jdMzioR0viELIeZjJqu5gwSP9S37vSP3MkBDt3Hho8ShHL2FGY6lTtB6AUzZNCFDR5chqscGCClSo7/fj4ADIbSpwACnI3Tld6rlxOE7mdp1P3r6MzHWvDvSsPc42LLpk64P2ypvfAbQvzkzU9MpK6rEgOxub3dwm3tUsSWwE63gd6bblaVcjS2U+vArLFOIGzflzYOwTrQ7LUxnTHAyCfiETxgd7TAEwvX7iSxkRQYp7Wc5oSwXRkJDuWThIQNVv9xlIOmWNVeoonvOHDYeHDNAqNi6YbUsvemXcxVE9Rq+c0y5qfj0zlrqT8yl7MaKMCnw1h0UO0bVFJVvz8sVNfRaX4UQu0mWQEv7YeEEh0ou9tW02wb2VBb455peGQSVeojk6mpfBBB6022UUun9Z3AWvWJe7PYdrVf/miCYv3cVC2xQ4H2ywf+rscgWkBkiViFEQfw9AJVGej8VZ9EI0mqvFr3rbjswxdjqjGkLySrYRoavCb7dRwZaZCfQhBbmjADceIG4rBfsXyGkoytqRJ3NICeGUUZfHxO6/L53tUN77qA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR02MB3369.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(366016)(38070700021)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3NPQUVKb3pJaUtPWDR5SDZQQ3RHanZVcTFHMk5WQVVtbHpXZDBibmpVNmtX?=
 =?utf-8?B?TlkwQXlxd0YxeW1ld3g5M01tUmpWajJ5VWxsNE00VktNeXgvYm1SQlEwdnI0?=
 =?utf-8?B?VHVsdmVLT3pYYUlVVjA0dnNVMTdMMEZhZXFWSHJocXNyVExENjUvWHVnVGxk?=
 =?utf-8?B?T011SU5EQkNWMWJtNzkvN05kbkgrakZGaFZxV0pyQlVSeGY5TXdHaVVqdVVY?=
 =?utf-8?B?bktrZ2kyWGhGUEtTRVEwSlRUQUFwVThUS004TTQzc1Vqakp1SXoxaGdZcTRi?=
 =?utf-8?B?S0V2UlVHSUN3bFRPNktrS2M2SDhPYVRJVTk5WVdDK1pqSFpmN21LOGt0SDVX?=
 =?utf-8?B?bUZYZUd3cjBnWVFuNnFYK09RRzdOa3ZPV1R0eFBxMmtna2hYbDdadUxLOUMv?=
 =?utf-8?B?aW03R2piM0UyTzFmSjBibzdJcjNoVERqQmRWdFFTb0pOcEFmc0NwUXdxa0lB?=
 =?utf-8?B?OUNDaUlxRS9qTUZiazdQZGpoblJKQ29GSU10b0tFKzFEcytxcmN3NkRWTHZH?=
 =?utf-8?B?ek9hSWdveU0vanRhTldzdG50MjdPZDFrclpWTFNEK29yVUVuS1ZMc3J3bEs4?=
 =?utf-8?B?Y0JWamJIUmdib0lVUmRsdVpyQ2xzK2doTlN2T3NONmJkUjY0VCs5bCt1OUt4?=
 =?utf-8?B?eVZkdnJwMU9weEs5cGQ1K1NoNWFqK2RqT3dUcTBkOHh4aDlNVVNyaktpaUR2?=
 =?utf-8?B?dmFhbFBaK0QyL1BSem5xdC8zaE5vemNjWEh0VjkxTGU1anY2dGQvRkNpc3g1?=
 =?utf-8?B?ZmRicHhPREJ3dm5QNG5MTkNpUFgwcm5IM1BmVGJoSnVMdkN6Z0toaUJJWlpv?=
 =?utf-8?B?cGpYSXNkNCtXUzBHRjFkcTBSSWNpalA4MnpDTjYyT3ZzVkRka1N5c1NYYmZB?=
 =?utf-8?B?US9nQ0E2VGRMQ09rM05MaFVCRUkzK2xUbkRxcFNuREFYaWt2QWZ4Um5mcXVM?=
 =?utf-8?B?Qkh6T29HSGNrY0JJcmY1c1hSMWtNUC8rZDRnQ3dKMEtzeTVKUzYySk9jNnp6?=
 =?utf-8?B?eW9NVzBqZXJtMTJpS2o3V3NDQVBRcXlNSE1RWjdycU5VRnE2YlhrdVU3bUlh?=
 =?utf-8?B?SklOVmJObTdYWlRHMEFhTkp4UEFselYwd2V2RGNid0RiSFdHWUhCSWpYeXpl?=
 =?utf-8?B?YXBiRUdCT2Fmd3VjU09MN1VoUnV2REI4ODdGSjdCRVd3NlFWU29vM0RYci82?=
 =?utf-8?B?aS9VdnpNcmo0aS9sT1BFTSs3SWR3MWhjWXlBY1FobldIUTlaMCtxVWlsZ0NM?=
 =?utf-8?B?L081dzYzcU1TamRPeVZMdFd3SnRLRUZrbWRsUU10YVZEZlI0dS9QcGdqTmdQ?=
 =?utf-8?B?K0s0WWlGbDgzdFJvOEd0REg4RHFrNm1NdjdhNVlqV2dnQ1huWjNaOTY3aG4z?=
 =?utf-8?B?ZGMySG45ZEF3ZWwxd0V6Mk1KVXhTdU85czRiVDJ4Y0dnaWVyblJ4eUN5d1Zl?=
 =?utf-8?B?ckg5c0pGaTIvVm9sNnNoSjJSclhjVGh0NUVKcmxjNjV4aXloOE9XMGRmZWsz?=
 =?utf-8?B?c1B3djVCWGxkdnZLUHZ1WHkxcFJVVEFIL04zYWduZVBiSVU1Z3M1ZmxOZk9u?=
 =?utf-8?B?RytNcXlLWG9lNktNaWpyeHdoT0ZubVBhYmg5a3V3SVFSNmhYOHduTzVuajY2?=
 =?utf-8?B?ZDZISjJ6R3NMbThmTmtkOFhkN0JFMzM3b0hpQ3dSeVVjeEp1aFB6UTVJa2V3?=
 =?utf-8?B?Y2JpdDZwaXpjcUswYzA4U2VLSnh6Vk9ZeHZQL1U5WVF1WG83eUVRbFJMOVZx?=
 =?utf-8?B?MXhBNy9kM3ZNcVpTd2tNOUJkL0FHU2llUkExbUs3L2cwaXloSVpUTHhOaVhv?=
 =?utf-8?B?S2RheUNMUHpJR2Y3YnBxbFF0bkgxU09XN0huKzZYeURjbFc5T0hSZFhmajVC?=
 =?utf-8?B?dWlnandWYjdKUkN3S1gyMzk4eHJJblJsRHZoRVRMSThGWmNuYTFkUXZHWXRp?=
 =?utf-8?B?ME0vRjRybVdsM2ZHL09mcXEvUm51N294VHNMOWkyZy9ib1kyekN6V0ptbHVq?=
 =?utf-8?B?eDAxNWQyRFlxWFNWR0lOZk1VWHVyeFREMDRIYm9ldURxNE5odmpPQ0tnMFZi?=
 =?utf-8?B?aENTNTc2WjhEVDJhajBGNitzdjFKL2tIZXNYRWNQQ1RWQ1VpbDNLeXFuamMv?=
 =?utf-8?B?aTZVbG5wcUJKaFhYYSswODZMMzE4TVhwV3hQeTNXRnhLd3BORHYzbWdzKzZZ?=
 =?utf-8?B?KzFmMUZpaG1na0dYYW1KdGFwdE5kL0lHNnk4S1dsdzF5TUZPYSttcHlGVk5i?=
 =?utf-8?B?UytraDVPSERLVTZPWWNpY0hzeHMvWFBDN3hGNncvaHZFckdkV2RjKzZWdWJN?=
 =?utf-8?B?QVovbjBBa2MzalU2RFJna1JWSHhUR0hOanVCdzFIRWg4VjFYTURkdz09?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Xfnewgm0jf95pa3Lo31r+PnkA+98p1JLzQvS/NvRtRmL/yBgtvILi8tHH2fWk7EZOXtRD3wkrFnozKq7aC92ahmTgyNncVHFQhzHpFJHQ6N4BB2nBW8b/YfJ1xhRB+asCqZWrPuzPtzIVhY96Swoopc7n9NqD6W1gWxLVrktx5K2doQ/svloK1AuNNNEAdw8Nsh8lCj2YcH3nSa2QnwAKhMEnQY8h9VTbuEZILkPLF/ILtRlgQ+4KWDWgZkQa5kwGFLGpiFjSS1wG069bG2D4uw5YzM48K61O5FDK1hMRDRsBfl7FcD7g6ec4czBmK7ChQiiGw/jda3i2OjFiizaSg==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7483741a-f7eb-43fb-43ad-08defd48d7a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 16:50:43.0403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FtP/J0vbOkOnziqxiBjXUc35CxLkZd9dT1XHQlezgNaiW7aO90+eURaZHDjStg9Dbdm7Ne9KGf5FYbOEujc438rEqlxiNw2YTPPESESlTFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR02MB10947
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n0YQKbs56bxSamITmip_fEWpOPKQOQ1-gKyZpewrdfY_1787071845
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldCB2NiAzLzRdIG5ldDogZXRo
ZXJuZXQ6IG9hX3RjNjogRGlzYWJsZSB0eCBxdWV1ZXMgb24gZmF0YWwgZXJyb3INCj4gDQo+IA0K
PiBEdWUgdG8gYSBsaW5rIGV2ZW50PyBUaGF0J3MgYSBydW4gb2YgdGhlIG1pbGwgc2l0dWF0aW9u
IGluIGRyaXZlcnMNCj4gYW5kIGhhcyB0byBiZSBoYW5kbGVkIGJ5IGNvcnJlY3RseSBvcmRlcmlu
ZyB0aGUgZXZlbnRzLg0KPiBJIHRoaW5rIHlvdSBzaHV0IGRvd24gdGhlIElSUSBmaXJzdCwgc28g
dGhhdCdzIGdvb2QsIG5vdCBzdXJlIGlmIHRoZXJlJ3MNCj4gYW55dGhpbmcgZWxzZSB0byB3b3Jy
eSBhYm91dA0KDQpBZ3JlZS4gSWYgdGhpcyBnb2VzIGZvciBhbm90aGVyIHZlcnNpb24sIEkgY2Fu
IG1ha2UgdGhlIGNvbW1lbnQgc2ltcGxlLg0KDQo+IA0KPiA+IFRoaXMgdXNlIGNhc2Ugd2FzIHJh
aXNlZCBieSBBSSByZXZpZXcgZHVyaW5nIHRoZSBwcmV2aW91cyBzdWJtaXNzaW9uLA0KPiA+IHdo
aWNoIGlzIGEgdmFsaWQgcXVlc3Rpb24uIFNvIEkgdGhvdWdodCBJIHNob3VsZCBjYXB0dXJlIHRo
aXMgaW4gdGhlDQo+ID4gY29tbWVudC4NCj4gDQo+IFRoZSBjb21tZW50IGlzIGNvbmZ1c2luZy4N
Cg0K

