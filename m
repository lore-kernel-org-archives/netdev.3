Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010052.outbound.protection.outlook.com [40.93.198.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846EA3321A7
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583914; cv=fail; b=XGQvgDt8S5EMw97i96OrLYW1MGBs5NBGaHeP63bF1W1zlPne7YHLjMmmT1H/oPcmpTaduQjzgjonQgYPSr0z71/21LAb3ByUlMdFwC/3S+WHcIRV8ezOSwTQCIZ4+f+brspENx4ZCkrHblad7rM12IonVVsQxyurZsL4D6b+pIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583914; c=relaxed/simple;
	bh=exDtSd5X78G0hySLQXpdtGcUeLJASl3uQYp1Ip7HH8A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SClOcBUgr27grUjpWOPMYiBBONYRMV9JrQBmKbuBOlEdb2FIqTia9qWhUcNCpdOof7cVoCG2X4TRuXkjS/1/m7+uCU+6ZaFaBb224jWf424N3Zf5abM2+0qzVOBk5THsWZmFZPXb3/0GovQpGY+c8caKoBpECd8JgJqdr1tOt9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IQ8fEyue; arc=fail smtp.client-ip=40.93.198.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IQ8fEyue"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iiYBZHR7Hd+tsEnLZ9SC4wt3EZHwADILsh6kM778OdnBEnhBFKeR4TToTPlPG59EDidpLlUxIxl1vBt/cVzpfE+6UcgrkU1lBK4jz3761qopTaVHXI2MtjYpJTGfOOtkx9i0Xt8BBVoztodGvf7/JjvlqbksN6RgU2Gd9gRdVNbYE45oz2ftY5qXaXGG2pZmE8iiMNIGptkd2vtjs7efmsQbl8BQE8gHIkCl0fORIlxXuCBjlAdSHi7OgeSzYmMw40CX3DVH7+EQCWZHCM+3QtBpCLkRp8xpHqt/ar3RZHk8O8Twrp0RBOlW6VDGn1kkqlfW9dp+UOL3991bTUFoJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exDtSd5X78G0hySLQXpdtGcUeLJASl3uQYp1Ip7HH8A=;
 b=HYs7H7BvqmYY2jo+zmZkj+mLsFiqx8PAl7SU8INY0h4+zRYNEt5pxRrrCfZSqXnBjBUD6R1S3RT2rlB51gkMMXNz3YWg4vL48wH4H/edyPjzaz5gmsCbTpkNt+QJO8KsS4pp0nXkQ+fETbF1ZRLrHbvKq00iM/QHx7OVL11WafDrZdLyTTEBKJA9BvkehDtwzAL1YOLWkFMDNdq8oiWdN6Q6XlFkIdk28sEClbITYPCrEBp5U+dxcMMtJwO15Ccow7CXQShQgTbeAEddfGytpG9eIwT3RIQA5iyQsAm6XtshNrXPW7IsH4MQ8rKj8lOHYq5wCmi2xMR2EVZNmrmLew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exDtSd5X78G0hySLQXpdtGcUeLJASl3uQYp1Ip7HH8A=;
 b=IQ8fEyuerr7QtYaAAWDSiXAjWd4pCdqAX2/cV2VwbEuSPU1dBigpLJrA0AeukelnV7ifdbZIuSucc8PNwIrrSOxIsfvOH/IBg+NVN1TXHN0wqlGFja2XxpzjP5rKv7BbBzgZFaFskPtN2BYJS56kCo1MST4vllm64quFuBuUA0KZjELUxzfGLf4HnwV5V21qKUS5/W/im6VfSO49pFttblT6dx4D5mi3jnmHfU1/SNgTah3To2XnhHP+ETZxN7r7cduwEdww1lEt88yN/7tpHPSofi6kHVyBnOThz03FraHE3gkf0PEeA1jrskqiPUxlg3Y7aPWkUw2jAMuGOOxUxw==
Received: from CH1PPF189669351.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::608) by DM6PR12MB4435.namprd12.prod.outlook.com
 (2603:10b6:5:2a6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 15:05:06 +0000
Received: from CH1PPF189669351.namprd12.prod.outlook.com
 ([fe80::fed8:66e3:ec22:8059]) by CH1PPF189669351.namprd12.prod.outlook.com
 ([fe80::fed8:66e3:ec22:8059%8]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 15:05:06 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>,
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"kuba@kernel.org" <kuba@kernel.org>
CC: "edumazet@google.com" <edumazet@google.com>, Boris Pismenny
	<borisp@nvidia.com>, "kuniyu@google.com" <kuniyu@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC net-next 0/6] psp: use virt cookie as Rx steering hint
Thread-Topic: [RFC net-next 0/6] psp: use virt cookie as Rx steering hint
Thread-Index: AQHdMolZcioeE/Gpn02iujIOQZmferar6gaAgAFky4A=
Date: Mon, 24 Aug 2026 15:05:06 +0000
Message-ID: <9d75871db36b1801eb381f5445c10fd29e2ad8a8.camel@nvidia.com>
References: <20260822225524.2328465-1-kuba@kernel.org>
	 <willemdebruijn.kernel.1157fb673940e@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1157fb673940e@gmail.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH1PPF189669351:EE_|DM6PR12MB4435:EE_
x-ms-office365-filtering-correlation-id: a54ee249-95ce-4b54-6c7b-08df01f11569
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info:
 MYLUltBe05Q+xO7TaQ37ks0Nc+QFkzcnadmo4fgOsNTkF9gOTWaq4uDXmHMYj3s/stMEUYwni9PRzxIjkdTKdcqbpejVlG7+ErNiqjpCKLrIqUmLO5CQL0xlT7StveUgLHAn//d9IEtDw0w6SS55WiAUX+Yry/XF6hDBV6suy1Aet48t7kYOETUY1OBPYvgj2yYr021LyoBdHfGxRtD0StijOEaZyBA3so/kgtfI8esudU+2xxm32ezdQQNY0iOV3+5j+EjxhNp23u0rpzETDdg8ntXmpo+NaKIlxtxh6f0J5gIjgjhAELZQ6Yq352Psq6SCOp2sAjSWKyLJtbmNglyPEOVbPgGsa/l8BvWqwvCqILY3pMmC5j69dACkujlMiEZky3JR2DpHGrrVLVeDFYjM8De87sQEuIwzsMU0OhU0Krnaqla4CXufDehe13xnEpK26e9u/ZgkCdUSIeO/HQ1bW0HK8qh4vpredgrSWGLJoKxVOLB1yg1luT718ZU2Nekt5iiH92qWOzcDScDIdnTrYlMSylQCekUPPqmj48gSeB/j7mRxCrYPJ5janl5+l6SVzDIQ4MQD+B5iqfPhmIREBvw48AkTiO+16FdLkBp9/r5ECmV4jZxOQtOOwF9rTKbqake4ehY66CSU2er7iqgdQJVlyYrts8M1cIdCqskyN6TOMCP7o8EIat14zI+uwH+SRvGkQQxMlPwSchcyT0Skx6eJ22zowDyZrrtNxas=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPF189669351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UDk2empQT1UxaFV0SzB5a2FmRStrYUpMQ1Jra1dNUVNiaDdXcHo0UzlvS0xW?=
 =?utf-8?B?OHBXRGZ1RTVVcWtjOFZEZkk4eFZKR2xMeGlxVTdzWVJ3NE9aMDlYS3hOZ2x6?=
 =?utf-8?B?TFBUMW5vVlQ0T0thNjFVUHlZYXBrL3lORXlsRDBXa3FzMllURmtHSkVMNVJI?=
 =?utf-8?B?akhINm1lY09RdWFjS1BRajFTT3BzNGtOK0V2YXNnVUVmWlgyOUt2QjE1RUpj?=
 =?utf-8?B?OFBXb0Yya0hWVi95eG9tUjA4MWNwaTlvMlBxU0VwNHBjSUJKekRzMUw1WmlF?=
 =?utf-8?B?YmRHRk4xRldXNkpzbU4xbWNnUkNJZnpXc3R0ZFBpU2R2MGxxcjVVOUZ0bTdt?=
 =?utf-8?B?Vm0zSGFobW5sakVUSkRjcWNYYlpLbEZURFJLdVpZVVFVQlpDenVnVjJ0ZmZE?=
 =?utf-8?B?WUgvemUvNHVYSzRvMXYvV3JYSmNlYnFoNWpGamg4N2JzaUxKeHcwN3NoOHJZ?=
 =?utf-8?B?dzB4L3gvVGlVNnFtMG1Va1ZKMlQ5OWhWcE1uRU1ycTJtSnZhSnJWT0d1cDhM?=
 =?utf-8?B?ZUcrWDFFMnFGVzNacFhXY21kanl1WjBJNDdKVS94TU5HL1dXUWV3T3JhZjRv?=
 =?utf-8?B?QlZEMmo0VFNJTnRoa0puT056emVOM1F6M0tjakNpSFNuaTY2d1JNcTdqUUJx?=
 =?utf-8?B?VWtOQnFCOXQ1TURWMjZBNnZ1MDRvRjNBMCtvTjZuYnI5aWhSc2dDY0l2QnJQ?=
 =?utf-8?B?eHBYQmFqNjhZZzE2OHdSMDB6ZmRmNElvMEVrKytVb05PK2RGNnZMMHRlRWhy?=
 =?utf-8?B?NUtTSVZMSUUyUWZwN28wbUsySDlQNEwyMVVCS2FOMGJEVzdxcDZLQk5pZjBQ?=
 =?utf-8?B?S1RHZzMxSzQ5MWpjdVFrU3hrWlhNbDdSZkVobVRHQk9iQ1YrWEJUSlR2TVhI?=
 =?utf-8?B?Rm1CenFicU1MZkpDcExxL1hLZ1NtaGdQNkNXaExNUTdqL0FCMWxzejdoaG5m?=
 =?utf-8?B?VE9OVWlYc2FYcHVFWEtITXQwaFNrU2I4Q0dPeUgvN3pLbmw4Yi9xM0V6VjBK?=
 =?utf-8?B?TWtXbXhZNkNTbmt0dmFzOGkwOXVYT1o0b2lrUGk3dlNLZ29JdGdpYklVVW9V?=
 =?utf-8?B?cWk5OEVqbHUwRUU5MklCbTVEZEZGSHNIRkZiK1ltRGtOMzN0Y0JXVEdteXR6?=
 =?utf-8?B?YUZ6SjRXdHhPdjZRZEFnTnhnNTlzdGJMOXRQeXpVSkdZalBBS3hqdk1MUGxi?=
 =?utf-8?B?Z3JDUDRMZ2k4a0V4eGNnSEY2Nzk4TUhCTmQ1NVhuSkJkMWJFVEFSU2VScTVE?=
 =?utf-8?B?UEhmS2R1a2t2bVlHY3Y5U28yZ2NIbTdTbC9UVExXR1FicXMxTllmT3NLKzVo?=
 =?utf-8?B?T2pDUmxMbjlrK0hMTkcyN0ZDUFUwQnZTaWlGdmxDdTBmdFFEdWs1Q1FydlRU?=
 =?utf-8?B?bTNFOTRYd2ZBNmhvZEJyZDQ5bDAzbGdQa3ROWHR0Z2tuVUo0RGNESlRudzU0?=
 =?utf-8?B?a3ZwUzdoWStLUWZ5Z3NXL3BKUE80ZGdxSEI5cjdJZ0oxZlBsUzJFeTNjSVB0?=
 =?utf-8?B?ZHl2R3VWbzVETnVZdjRqekMyUTMramtnYzBQWS9HYlVya1Vqd3VpejRDRm1i?=
 =?utf-8?B?K1ZCcmVrd0xjRnFMbEcrZHZrZXpLY3ZZekt0Z2tYSXVDbnpFQlhURUk4N21I?=
 =?utf-8?B?UUExY2VGNGE2b09nU250RXlpSmtYVUJ3MG85WHVLbVk3dXQwV3c0U2tvMGd0?=
 =?utf-8?B?bEpoTEVrNmYrbjFmYW5KSmNPZVRJTlhaR0p0NlJId1FVeWMwK29iL2hhTktL?=
 =?utf-8?B?OGRZR1BTSm9vcHdrRW5hMVRVQU84U2R5N2xCMGpMSGFrWXBrSUZQeDhZd085?=
 =?utf-8?B?SUdTT1JBbUlWcUpKVDQ3cHg0dFJKcHNFdFYrRGtzWUxzYjg1MEd4YTVvNDhE?=
 =?utf-8?B?ODVJMTJqZXlQaVEvMmU2VTFmdXVrbWI4a09sb2xOdUEreFRoY21oTXk1UUFO?=
 =?utf-8?B?aml4MDJUMHVHRkl0QVdQTHJVLzZtbjRWczBid3owYjkxL3R3VFdyS1pXMlBW?=
 =?utf-8?B?OXBRb2MyVE8xN1BhZWJ2RForOXdiQkRjUk1nTmFyZVlvVkhhTmxZVi8wY0FM?=
 =?utf-8?B?c3VOQjFWUTNQc3l6dG01VXYxRHVwOUpLdVp1YnpxUkovdG9aTXpGSWhqV2wr?=
 =?utf-8?B?Rk05YTAvUnJSWVBYdTZKK0tWN3NBUUNydDA3QzNBSkdFR0RQQ2dhWm1vUzZT?=
 =?utf-8?B?RGp1MDBCSGs1OFZRZlRFQVJLcE56NngxWG5RZ0NvSHEvb0JBZW9hdmp3YWg4?=
 =?utf-8?B?TlpJemN5Yms4MFhLeHUwdUlQaHo1amdkNDlFMDFGN3JrZ0k4VmJqR045MVkv?=
 =?utf-8?B?Ulc4SU9ZZmZJcEhYdGlISm5Qd2tJV05FNDlrUDNWdHNmQytneURLdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F0535B756E7B349AEEDE4F5C7E5362E@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a54ee249-95ce-4b54-6c7b-08df01f11569
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 15:05:06.7462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pStNEIoxt8iJeiOIHlbliNYQI/v8bMxk3t924Dzg+ARjQgJsPuLM0eyRFH4BqOoaxAOKuHc4Wrr0e78+cDUjZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435

T24gU3VuLCAyMDI2LTA4LTIzIGF0IDEzOjQ4IC0wNDAwLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3Rl
Og0KPiBKYWt1YiBLaWNpbnNraSB3cm90ZToNCj4gPiBIaSENCj4gPiANCj4gPiBUaGlzIFBvQyBz
ZXJpZXMgdXNlcyBhIGZpZWxkIG9mIHRoZSBQU1AgaGVhZGVyIGludGVuZGVkIGZvciB0dW5uZWxz
DQo+ID4gdG8gYXV0by1zdGVlciBSeCB0cmFmZmljLiBWYXJpb3VzIGF0dGVtcHRzIGhhdmUgYmVl
biBtYWRlIGF0IHRyeWluZw0KPiA+IHRvIGdldCBSeCB0cmFmZmljIHRvIGxhbmQgY2xvc2UgdG8g
dGhlIGNvcmUgd2hlcmUgdGhlIGFwcGxpY2F0aW9uDQo+ID4gcnVucy4NCj4gPiBCeSBkZWZhdWx0
IFJTUyBwaWNrcyB0aGUgUnggcXVldWUgYmFzZWQgb24gdGhlIGZsb3cgaGFzaC4NCj4gPiBJJ20g
bm90IGdvaW5nIHRvIGNvdmVyIGFsbCBwcmV2aW91cyBzb2x1dGlvbnMgaW4gZGV0YWlsIGJ1dCBi
cm9hZGx5DQo+ID4gLSB3ZSBoYXZlIFJGUyBpbiBTVyB3aGljaCBsb29rcyBvbiB3aGljaCBDUFUg
VHggaGFwcGVucyBhbmQNCj4gPiBiYWNrbG9ncw0KPiA+IFJ4IHBhY2tldHMgdGhlcmUsIGl0IGlz
IHF1aXRlIGVmZmljaWVudC4gYVJGUyBpcyBidWlsdCBvbiB0b3ANCj4gPiBvZiBSRlMgYnV0IHRy
aWVzIHRvIHByb2dyYW0gZmxvd3MgaW50byB0aGUgTklDLiBTb21lIE5JQ3MgaGF2ZQ0KPiA+IGEg
ImNhY2hlIiBhbmQgdHJ5IHRvIGF1dG9tYXRpY2FsbHkgcmVtZW1iZXIgdGhlIGZsb3cgdG8gcXVl
dWUNCj4gPiBhc3NvY2lhdGlvbi4NCj4gPiANCj4gPiBBbGwgdGhvc2Ugc29sdXRpb25zIGFyZSBl
bnRpcmVseSBsb2NhbCB0byB0aGUgcmVjZWl2ZXIuDQo+ID4gSWRlYWxseSB3ZSB3b3VsZCB3YW50
IHRoZSBzb2x1dGlvbiB0byBsb29rIHNvbWV0aGluZyBsaWtlDQo+ID4gVENQIHRpbWVzdGFtcCBv
cHRpb24gLSB3ZSBzZW5kIGFuIG9wYXF1ZSBjb29raWUgdG8gdGhlIHBlZXIsDQo+ID4gYW5kIHRo
ZSBwZWVyIGVjaG9lcyBpdCBiYWNrIHRvIHVzLiBPdXIgTklDIGNhbiBzdGVlciBiYXNlZA0KPiA+
IG9uIHRoYXQgZWNob2VkIGNvb2tpZS4NCj4gDQo+IEFub3RoZXIgb3B0aW9uIGlzIHRvIHJldmVy
c2UgUlNTIGVudHJvcHkuIFRoaXMgcmVxdWlyZXMga25vd2xlZGdlIG9mDQo+IHRoZSBSU1Mgc2Vj
cmV0Lg0KPiANCj4gRXNwZWNpYWxseSB3aXRoIFBTUCwgdGhlIG91dGVyIFVEUCBzb3VyY2UgcG9y
dCBpcyBkZWZpbmVkIGFzIGZsb3cNCj4gaGFzaCwgc28gY2FuIGJlIHVzZWQgZm9yIHRoaXMuDQo+
IA0KPiBIYXZlIHRoZSByZWNlaXZlciBjb21wdXRlIGEgNC10dXBsZSBoYXNoIHN1Y2ggdGhhdCBp
dCBrbm93cyB0aGUgUlNTDQo+IGJsb2NrIHdpbGwgc2VsZWN0IHRoZSBpbnRlbmRlZCBxdWV1ZS4g
VGhlIG9ubHkgZnJlZSB2YXJpYWJsZSBoZXJlIGluDQo+IGdlbmVyYWwgaXMgdGhlIHNvdXJjZSBw
b3J0LiBUaGVuIGNvbW11bmljYXRlIHRoaXMgcHJlZmVycmVkIHNvdXJjZQ0KPiBwb3J0IHRvIHRo
ZSBzZW5kZXIuDQoNCkkgd2FzIHRoaW5raW5nIG9mIHNvbWV0aGluZyBhbG9uZyB0aGVzZSBsaW5l
cyBhcyBhbiBhbHRlcm5hdGl2ZS4NCldoZW4gaW5pdGlhbGl6aW5nIFBTUCBmb3IgYSBjb25uZWN0
aW9uLCBsb29rIGF0IHdoYXQgdGhlIGRldmljZSB1c2VzDQp3aXRoIC5nZXRfcnhmaCgpLCBhbmQg
ZmluZCBhIHZhbHVlIHNwb3J0IChlaXRoZXIgYnkgbGluZWFyIGFsZ2VicmEgb3INCmxpbmVhciBw
cm9iaW5nKSBzdWNoIHRoYXQgdGhlIDQtdHVwbGUgaGFzaCByZXN1bHRzIGluIHRoZSBkZXNpcmVk
DQpxdWV1ZS4gVGhpcyBtaWdodCByZXF1aXJlIHNvbWUgbm9uLXRyaXZpYWwgY29kZSBjaGFuZ2Vz
IHRvIHJlaW1wbGVtZW50DQp0aGUgaGFzaGVzIGluIFNXIHRob3VnaCwgYnV0IGl0J3MgbG9jYWwg
dG8gdGhpcyBzcG9ydCBzZWxlY3Rpb24gb25seS4NCg0KcHNwX2Rldl9lbmNhcHN1bGF0ZSgpIGFu
ZCBwc3Bfd3JpdGVfaGVhZGVycygpIGJvdGggY29udmVuaWVudGx5IGFscmVhZHkNCmhhdmUgYSBz
cG9ydCBhcmd1bWVudCwgd2hpY2ggaXMgY3VycmVudGx5IGlnbm9yZWQsIHNvIHBsdW1iaW5nIHRo
aXMgaXMNCmVhc3kuDQoNClRoaXMgd291bGQgcmVzdWx0IGluIHplcm8gUlggY2hhbmdlcyBmb3Ig
ZHJpdmVyIGltcGxlbWVudG9ycy4NCg0KQW4gZWFzaWVyIGFsdGVybmF0aXZlIHRvIGF2b2lkIHJl
dmVyc2UgZW5naW5lZXJpbmcgUlNTIGhhc2gNCmltcGxlbWVudGF0aW9ucyB3b3VsZCBiZSB0byB2
YXJ5IHRoZSBkZXNpcmVkIHNwb3J0IGFjcm9zcyBtdWx0aXBsZQ0KcGFja2V0cyBhbmQgdW50aWwg
cGFja2V0cyBzdGFydCBjb21pbmcgdG8gdGhlIGRlc2lyZWQgcXVldWUuIFByZXN1bWFibHkNCnRo
aXMgY291bGQgY29udmVyZ2UgdG8gdGhlIGRlc2lyZWQgcXVldWUgaW4gTyhudW1fcXVldWVzKSBU
WCBwYWNrZXRzICsNCmFja3MuIE1heWJlIGNvdWxkIGJlIGRvbmUgd2l0aCBUQ1Aga2VlcCBhbGl2
ZXMgYXQgY29ubmVjdGlvbiBzZXR1cD8NCg0KQ29zbWluLg0K
