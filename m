Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1CA36E48B
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564722; cv=none; b=FOJZmfy7vf1B0ZnBZLPU0AZ9srAWI3Ed4Tow415QOmd474z1anOqof+bCJ5wPonWrc/QGBOKkva2VL+a6s0Lm3lJ1vOtVHLYfPN2WqAkIB5XKlUedlIqVaQ6VS/98prJ0e2YDHCyJZemi95n9+URvk4CeKVWa5NSamDLQYlhuGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564722; c=relaxed/simple;
	bh=2xkF+YCpSDE2uA3RN4mOJGXQ1F2TKGVV7Gbxd8KCt+Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=nisG9RzgRQMpCTyWKf30LQKTQG2iAOYtpnHA0ImlD28b5NbIjTBN+DlJ8OU9LjpayYe+Wka+f1HMnAttVus5GZdyF963SkFGeRttEXK8k4fvFmSEOOf8VQWO6Vn8aTlhAD+zb96VRLz+JymuixVyfQ+r0qPceSIkliJtbwcTfBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=JoG4CKMw; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="JoG4CKMw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1786564720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2xkF+YCpSDE2uA3RN4mOJGXQ1F2TKGVV7Gbxd8KCt+Q=;
	b=JoG4CKMwIli8QJVTv8MW1KYY/rrbQ5CkTNI8u5UmkOO/qHgBcFFsEURIfm89FRDE7yGOms
	erkR/xFmGeujmqormngWZ95Hq0cRuZ9zxKXM5AeYMWceJlwXzjxCF1TF6GIpc+ve32MMj+
	V2kRSYoQIycMg1wffNTzBOMFO8+YphKsRxncNWV3jqPg5aGSxpa+A68Fe4o6DTqdyKDWV8
	2+iO8yf05mQsXtQGwvx0yQ4LGPMnQanxYiFr7fd2+I4Y7XCfYhEhGQNtgTpwylpJJcYQCr
	f2GdKz54K8eZDPcWww5m5SHngaIXfo39uIblX07GKKg6wz0cECVGsMW3Eh/z1g==
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010003.outbound.protection.outlook.com
 [52.101.193.3]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-42-3uWPmXorN9iWQeV_urAssQ-1; Wed, 12 Aug 2026 12:58:36 -0700
X-MC-Unique: 3uWPmXorN9iWQeV_urAssQ-1
X-Mimecast-MFC-AGG-ID: 3uWPmXorN9iWQeV_urAssQ_1786564713
Received: from MWHPR02MB3375.namprd02.prod.outlook.com (2603:10b6:301:61::16)
 by CO1PR02MB8457.namprd02.prod.outlook.com (2603:10b6:303:155::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 19:58:31 +0000
Received: from MWHPR02MB3375.namprd02.prod.outlook.com
 ([fe80::f19:3f8f:e27a:e484]) by MWHPR02MB3375.namprd02.prod.outlook.com
 ([fe80::f19:3f8f:e27a:e484%4]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 19:58:31 +0000
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
Subject: RE: [PATCH net v5 3/4] net: ethernet: oa_tc6: Disable tx queues on
 fatal error
Thread-Topic: [PATCH net v5 3/4] net: ethernet: oa_tc6: Disable tx queues on
 fatal error
Thread-Index: AQHdH8PLCrxS0Z1IAkCsR9P2bn7suLaQ4VsAgAoG2rA=
Date: Wed, 12 Aug 2026 19:58:31 +0000
Message-ID: <MWHPR02MB3375AE75499A86375FBA5CE283DC2@MWHPR02MB3375.namprd02.prod.outlook.com>
References: <20260729-fix-race-condition-and-crash-v5-3-3906bc485daf@onsemi.com>
 <20260806104340.151169-1-pabeni@redhat.com>
In-Reply-To: <20260806104340.151169-1-pabeni@redhat.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR02MB3375:EE_|CO1PR02MB8457:EE_
x-ms-office365-filtering-correlation-id: 49924643-c1df-489c-5846-08def8ac15ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|5023799004|6133799003|10067099003|38070700021|11063799006|56012099006|4143699003|18002099003|22082099003
x-microsoft-antispam-message-info: Zst5hb+9EUpsaXj10WRO/qip4tNvPOnAEfnHXhKFym+s9PR+djVjeOY0JMbbFZ6D2Y6XtjFhmnDHrHIssEeE1b/hZD0jrbpUQq6L/T5kwerTdEUFnwnLtqwNuD71vXvhcBMIelRKfIrWlZGfUW/FgeLOZss8NmpzLJjo/tFZ9XahOgH5MPXx0Ax15p6IE/kOM3r0XvJkVvvXiGYe3VtzerLkQeOnU4ICH1E9yZLiYyGCx7DuoV4N45BEQQ2p5vxEdgem8p1ThASBiasartzqXeNWXR8lCI0mzN/+88lz13J/mZ0EwlRWHc/iTZ/BpaYA6GyWNlFnAtgU/5JKGYJMbpXzlV7Kelnx2/Kdd+gA/71tlEa/fF6yNfN3adR3O/Gul0VTmQ0SBvqjkPU9Ygv0fASZwj6tqpizda+AAtDMViXi+A2nTVtybVbaqzAj19CunU3D/G4VTnnYQsqszL+td6YSJR+0arvBLino8cyFnQBwESl+9NtHziW3TzEVSeFUoQqYUjujIlUevT9X6vdsijUrGqvgf1F0O03LF3SvN8FFsmI/n/bVC/fugf1Phu5XpZq4DPW/MdfHNHYn9p47+ACt10ukFAgKz3VBVCkXJTC2GQF8Jl+UCdCPj3i9czCPGZYvnDKGeQUGHG4ekpUo5iwhI5KYxraH/93Dp4wz2PBKXnbLpT7QHck0f6oAdrXd7NMGX5TI6P8f4KdGqjo55HdQNeYdnkJyVu3Vu97IRlk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB3375.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(5023799004)(6133799003)(10067099003)(38070700021)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekdtRWdRQXlmUjFtcldkVmVDL0FuUTN0RUpOVnp2dG01V05tTkhHR0ErT3gy?=
 =?utf-8?B?RE55eXE1dnRYR1RYVGk0bmJlQzBKM0p2Wm54bXcwUTJYWjJsb05YNFEyYVhq?=
 =?utf-8?B?ZVp1SmFqNzlwa3ZvcVk0dUlhQ1VhenlyZHNMYVZSODY0c2E3VWVPTHFIUGJL?=
 =?utf-8?B?Y3NPaUI0ZXRtS21UcFltZ1VkMEhzbEtoU1lXOEp5Qm13OGg0WlZWcWtWWnMw?=
 =?utf-8?B?bHpLa1AvbDVSQ1RKRjVpYUEyUFlNby9hNld3djV5MUtLaFBybkM2b0tuUlZI?=
 =?utf-8?B?Z1k4SlhBcmxjTVlNc2RQSFVMWDlrTHo0ZURDSG1LZ2dLTXRmblB6dDN2cjRE?=
 =?utf-8?B?djg0aTVhbDZhTmNjRE4xZkpLUWxmSzZiUEQxS1JveVdUS3ZNeFdPbThYcTVF?=
 =?utf-8?B?encyNm1pcVUzdEN6dU51eUN2TUR5byt1WGU4ZUF2UE40V2ZyM252Z3lOcmtC?=
 =?utf-8?B?ZmtTWkJidWkxYU5wRmVONXVuaUtST1JTZnp2cjBqSm44dzBldTIrVkM0T21n?=
 =?utf-8?B?d3EreWZqaEg3WWNsRjdha1QyaFVZeno0OG4rdzBDVXg2bi9TMGE4NFBmbjVl?=
 =?utf-8?B?VXVqaEhUN0R0SHk1cCt3NG9ReDJKYzV2c1RwVEN2S3FIeHhQUCs4RWlXYVFD?=
 =?utf-8?B?eE1mTkRaNmFjRWRWbmFLNHZIcytqSjEzNW15eTZVNG9YbjhnYzZwU0NsQ3Zs?=
 =?utf-8?B?eEtaRkJQOUVvbkRZN20yeWIwblJSRVRkTWFCbElxcWhjUXd0NTdycDZlRDRG?=
 =?utf-8?B?SFpwNml4NFYxNXR1OFhFWnEvU3VXbVpMQ1R5MXcza2VJYzRhNC9tb1JmRWdL?=
 =?utf-8?B?cUxXNy85ZWxkZHpvZk82OFJmbDNRblc0cDI1ZmRYVStHZ2dPUEV2bVFTUElM?=
 =?utf-8?B?YjFROVFlKzFBcDFXR2J0VXpJU0Q2Umwwbm9NWmllYnM4RXhIREU2SU0yYmNi?=
 =?utf-8?B?aS9yc3NZakV5QndjZ0VWMDM0REMvQ0hCTFl4citaZ0RCbDFPa2xHSFd3WFNk?=
 =?utf-8?B?TFNvb2s5ZVFqWXRjbHhpOHF4eHE1RHpPb0pYUDdwbUdXQk5Tc0hmQTF5R1hl?=
 =?utf-8?B?NS9Demx6OTFkZTk4SldTRC9TRHNKUzY4Q2ZHbzV2QVFMOUZ6aVdBYm5BU1hF?=
 =?utf-8?B?MGpDNndzMnYxNWlSRWp3UlJraS96UDArSmFNNk9SRTNpeXRMcHA5UHJVVjFW?=
 =?utf-8?B?YjU5UEU2UDN1UzlUbWYydDFyaDVtMWFraHZuVWFUdmpEUXo0VGkxQ0RXdDJl?=
 =?utf-8?B?cVZ1dG5uOXV0L004dStNNCtYYVdBM2R1ajUvMmo0eUs5NFU3OGo4NVRSN1Z1?=
 =?utf-8?B?TWpucE50MVNyaFhsLzZsZ2dNMUlJZEwvanJkMnNLTXJxc1RnM0ZLT2Y5eWox?=
 =?utf-8?B?aHBYbFE0V05JbE9ISXdVWmlTanJMMTVxcWhuenN3VHBEWmxjTGpxVnM0bzIx?=
 =?utf-8?B?YWNVazYwYnAxa01vUVlDZ2tjYmpvUEhWMWNqMExyRFVFTlJ3TE91TFlROHA3?=
 =?utf-8?B?ckREQ2RxYlN6SlVYRHBtRmkzZm5rVDl5NnU5bEIwa1pTQlFIQVhsQzJ0dXZp?=
 =?utf-8?B?MklZYTlPMkpuRU9IWkRyZEk0RmN6YmpmaUI2SVRFT3hhSUozV2daZXE4UHV1?=
 =?utf-8?B?T1RNRmlYY1BrM1RoV0JocFZrRXk0bFJ6TzN3V2ZSZDZFTk1DeE1VS3JObyto?=
 =?utf-8?B?NTN0Y3E1ck84dHpwL2V1dUk1OWJ5dGJ6ZFRMU1dJMUhWS0tOd0Q1b1FlSVk5?=
 =?utf-8?B?ZjBPOWRFOWF2YmdNc2FiU1dVREVLY3JpckI0TEV3SCtDa1Fobmg4VWloTk92?=
 =?utf-8?B?TjJFRWVRQWhWcUNvQ3BVMDlRRDFaUEh2OFMxd2Q2M3g2SEY5NG5GcXppdFNj?=
 =?utf-8?B?d0wrV3JlWXdud05UcnI2eDdjK3FmTjNOaHZLeGRCeStpNTQrWW1vNkRTUUtk?=
 =?utf-8?B?TlBNckZ3VEpaeEs4MTBZckNOcnJvdDdtV2hva2VEdDJTckhQNnprWEdCOWtI?=
 =?utf-8?B?eE43a2RqUVdEcDQ4MW0zTVFvUmR6eHQzUG9hRTkxVVZmRldURjZaSWhlWWlC?=
 =?utf-8?B?QWFvMzBlQmlQMkpta0NkZXlSWmdDU2JsYlRnVjE4V1J6VDFzM2dwbGtBMElS?=
 =?utf-8?B?Um11end0QVl1S2RHc0wySjlGTXo0UGRUWVJXRlV4OGJNckczclBVN1hkRUtm?=
 =?utf-8?B?K3BhcUdiamlnS05vazV2aHlQQ3MzdCt5UDBTQ1BXZTBsbng5aThnL0xTMC8v?=
 =?utf-8?B?TTBDaU90UnZvVXJ1ZTNyaHkxMHdLcERtdS9zNzNQSEdDZzRDTHlJcFAyQVpH?=
 =?utf-8?B?YmRLT0pxb0t4Qi9XWCtVRmlLRnFFYVFTVVdCODhoTUVySWYyVWxnQT09?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qMCK+sW+fWYzyDi+15fvVVj8C71xihOAuiuXHaXClKOLUophSrNCuqMAe5JNofvmKBi0hf3+AKxQ8St4sNTNI0l0EBQve6jhZK7JkpSRwmZTOSuFPWRUE63fPr5GcoBcrOn6Q2bNCePx1j8AHtpzW+0R/GINaTY2uxnIMOEQcWJ/Q6YTh7u2okyNvxHueWZqFca/BRKHHlbUuiq55wSHeKPgFEVgZl/3EZCOpTxIruM41u8n2fpuw2EZoY44jdfKJxAQCKmfl3IUbySgHIDhVK3zzeZHFaUcI+abtdZY6myEEZPg+NjYYIruDH5nUopldQutbVQs0hRsDNSocSwFpg==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB3375.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49924643-c1df-489c-5846-08def8ac15ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 19:58:31.4710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RF4qso1aybgloEN9Bw4kkqEsaKkY+KiNPOtSlJQR+4l7R4YPWL1yhGOolMlOXt2kvVh+sxSNXNy77o9TqUgqY+Bj5qjE8LJlnIBvEnznBGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8457
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rsLc3BIf2T7KnpY56KOcrCnShCEG7UV7ZXrbCzEvdC8_1786564713
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5p
QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgNiwgMjAyNiAzOjQ0IEFNDQo+
IA0KPiANCj4gW1NldmVyaXR5OiBNZWRpdW1dDQo+IFtGaW5kaW5nOiBtYWluLTEtMF0NCj4gW1Nv
dXJjZXM6IG9wdXMtNV0NCj4gVGhlIGNvbW1lbnQgZGVzY3JpYmVzIHRoaXMgYXMgImEgcG9pbnQg
b2Ygbm8gcmV0dXJuIHRvIHdvcmtpbmcgc3RhdGUiLCBidXQNCj4gbmV0aWZfdHhfZGlzYWJsZSgp
IG9ubHkgc2V0cyB0aGUgcmV2ZXJzaWJsZSBwZXItcXVldWUgX19RVUVVRV9TVEFURV9EUlZfWE9G
Rg0KPiBiaXQuIElzIHRoYXQgZW5vdWdoIHRvIG1ha2UgdGhlIHN0YXRlIHN0aWNrPw0KPiANCj4g
VGhlIG9ubHkgaW4tdHJlZSBjb25zdW1lciBjbGVhcnMgaXQgYWdhaW4gb24gZXZlcnkgb3Blbiwg
d2l0aG91dCBsb29raW5nIGF0DQo+IHRjNi0+ZGlzYWJsZV90cmFmZmljOg0KPiANCj4gZHJpdmVy
cy9uZXQvZXRoZXJuZXQvbWljcm9jaGlwL2xhbjg2NXgvbGFuODY1eC5jOmxhbjg2NXhfbmV0X29w
ZW4oKSB7DQo+IHJldCA9IGxhbjg2NXhfaHdfZW5hYmxlKHByaXYpOw0KPiAuLi4NCj4gcGh5X3N0
YXJ0KG5ldGRldi0+cGh5ZGV2KTsNCj4gDQo+IG5ldGlmX3N0YXJ0X3F1ZXVlKG5ldGRldik7DQo+
IH0NCj4gDQo+IFNvIGFmdGVyIG9hX3RjNl9kaXNhYmxlX3RyYWZmaWMoKSBydW5zLCBhbiBvcmRp
bmFyeQ0KPiANCj4gaXAgbGluayBzZXQgZGV2IFggZG93bg0KPiBpcCBsaW5rIHNldCBkZXYgWCB1
cA0KPiANCj4gcmUtZW5hYmxlcyB0aGUgcXVldWVzLCB3aGlsZSB0YzYtPmRpc2FibGVfdHJhZmZp
YyBzdGF5cyB0cnVlIChpdCBpcyBvbmx5DQo+IGV2ZXIgc2V0LCBuZXZlciBjbGVhcmVkKSwgdGhl
IFNQSSBpbnRlcnJ1cHQgc3RheXMgZGlzYWJsZWQgYnkNCj4gZGlzYWJsZV9pcnFfbm9zeW5jKCkg
aW4gdGhlIHRocmVhZGVkIElSUSBoYW5kbGVyIGFuZCBJTlRfTUFTSzAgbWFza3MgYWxsDQo+IGRl
dmljZSBpbnRlcnJ1cHRzLiBGcmFtZXMgdGhlbiBsYW5kIGluIHRoZSBwcmUtZXhpc3RpbmcgZHJv
cCBicmFuY2g6DQo+IA0KPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9vYV90YzYuYzpvYV90YzZfc3Rh
cnRfeG1pdCgpIHsNCj4gaWYgKHRjNi0+ZGlzYWJsZV90cmFmZmljKSB7DQo+IHNwaW5fdW5sb2Nr
X2JoKCZ0YzYtPnR4X3NrYl9sb2NrKTsNCj4gb2FfdGM2X2Ryb3BfdHhfc2tiKHRjNiwgc2tiKTsN
Cj4gcmV0dXJuIE5FVERFVl9UWF9PSzsNCj4gfQ0KPiB9DQo+IA0KPiBJcyBhbiBpbnRlcmZhY2Ug
dGhhdCBsb29rcyBvcGVyYXRpb25hbCBidXQgc2lsZW50bHkgc3dhbGxvd3MgZXZlcnkgZnJhbWUg
dGhlDQo+IGludGVuZGVkIGVuZCBzdGF0ZSBoZXJlPw0KDQpBZ3JlZSB3aXRoIGNvbW1lbnRzLiBU
aGUgZm9jdXMgb2YgdGhlIGN1cnJlbnQgZWZmb3J0IGlzIHRvIG5vdCB0byBsZWFrIGFueSBza2Ig
YnVmZmVycyBvbmNlIA0KZmF0YWwgZXJyb3IgaXMgc2Vlbi5XZSBkb24ndCBhY2NlcHQgbmV3IHBh
Y2tldHMgZm9yIHRyYW5zbWlzc2lvbi4gSGVuY2UgImRpc2FibGVfdHJhZmZpYyIgZmxhZy4gDQpT
aHV0dGluZyBkb3duIHRoZSBkcml2ZXIgY2xlYW5seSBpbiBhIHJlY292ZXJhYmxlIHdheSB3b3Vs
ZCByZXF1aXJlIHNvbWUgbGV2ZWwgb2YgZGVzaWduIGNoYW5nZS4gDQoNCj4gDQo+IFRoZXJlIGlz
IGFsc28gYW4gb3JkZXJpbmcgYXNwZWN0OiBvYV90YzZfaW5pdCgpIGFybXMgdGhlIHRocmVhZGVk
IElSUSB3aXRoDQo+IGRldm1fcmVxdWVzdF90aHJlYWRlZF9pcnEoKSBhbmQgdGhlbiBjYWxscyBp
cnFfd2FrZV90aHJlYWQoKSwgd2hpY2ggaGFwcGVucw0KPiBiZWZvcmUgdGhlIGNvbnN1bWVyJ3Mg
cmVnaXN0ZXJfbmV0ZGV2KCkgaW4gbGFuODY1eF9wcm9iZSgpLiBJZiBhIGZhdGFsDQo+IGVycm9y
IGlzIGRldGVjdGVkIGR1cmluZyB0aGF0IHdpbmRvdywgdGhlIHF1ZXVlIGRpc2FibGUgaXMgYXBw
bGllZCB0byBhDQo+IG5ldGRldiB0aGF0IGhhcyBub3QgYmVlbiByZWdpc3RlcmVkIHlldCBhbmQg
aXMgdGhlbiB1bmRvbmUgYnkgdGhlIGZpcnN0DQo+IG9wZW4uIFdvdWxkIG5ldGlmX2RldmljZV9k
ZXRhY2goKSwgbmV0aWZfY2Fycmllcl9vZmYoKSwgb3IgaGF2aW5nIG5kb19vcGVuDQo+IGNvbnN1
bHQgdGhlIHRjNiBmYXRhbCBzdGF0ZSBleHByZXNzIHRoaXMgbW9yZSBkdXJhYmx5LCBvciBzaG91
bGQgdGhlIGNvbW1lbnQNCj4gYW5kIGNvbW1pdCBtZXNzYWdlIGJlIHJld29yZGVkIHRvIG1hdGNo
IHdoYXQgdGhlIGNvZGUgYWN0dWFsbHkgZG9lcz8NCj4gDQo+IFtTZXZlcml0eTogTWVkaXVtXQ0K
PiBbRmluZGluZzogbWFpbi0xLTFdDQo+IFtTb3VyY2VzOiBvcHVzLTVdDQo+IEEgc2Vjb25kIHF1
ZXN0aW9uIGFib3V0IHRoZSBzYW1lIGNhbGwsIHJlZ2FyZGluZyB3aGF0IHVzZXJzcGFjZSBjYW4g
b2JzZXJ2ZS4NCj4gVGhlIHY0IGNoYW5nZWxvZyBub3RlcyB0aGUgY2Fycmllci1vZmYgY2hhbmdl
IHdhcyByZXZlcnRlZCwgc28gdGhlIGNhcnJpZXINCj4gc3RheXMgdXAgd2hpbGUgZXZlcnkgdHhx
IGhhcyBEUlZfWE9GRiBzZXQuIFdpdGggdGhlIHF1ZXVlcyBzdG9wcGVkLA0KPiBuZXRpZl94bWl0
X3N0b3BwZWQoKSBpcyB0cnVlIGFuZCBuZG9fc3RhcnRfeG1pdCBpcyBuZXZlciBjYWxsZWQgYWdh
aW4sIHNvIHRoZQ0KPiBwZXItZnJhbWUgYWNjb3VudGluZyBpbiB0aGUgZGlzYWJsZV90cmFmZmlj
IGJyYW5jaCBvZiBvYV90YzZfc3RhcnRfeG1pdCgpOg0KPiANCg0KDQpTYW1lIGFuc3dlciBhcyBh
Ym92ZS4gV291bGQgcmVxdWlyZSBzb21lIGxldmVsIG9mIGRlc2lnbiBjaGFuZ2UgaWYgd2UgbmVl
ZCB0byBmaXggdGhpcyBpc3N1ZS4NCg0KLS0NCj4gVGhpcyBpcyBhbiBBSS1nZW5lcmF0ZWQgcmV2
aWV3Lg0KDQo=

