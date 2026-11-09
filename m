Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.151.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193926;
	b=2nceOXqvmXq4GNgU6/48rocfUTpvEwU65HS8UlEJ9aKWbQOsCljY8ppYPeo+AYnv33vh
	 uxrjzGB/OdgiUE44bpCv8vdtlt18UKcd7gnWnaD73NfXrMu0lYAyGHRJAxK0w5BaJsjcZ
	 nSSRxHDP50fj69seGKbT7jYB1QPYYy+GfLM+u8RPurYe1+0BD8APPNcYnF+IKDCCzKJtm
	 XHUFOCBkq3ffs10QYqh3M6jGoTHaYlKxttnYqqVI1EzKxbsj4SzANCJnrFg1CTWz+2IGo
	 B0JmVr31xSONgJ26u742FLz/HRwnKQ2Qvlx3OD+6c6CHXW3DZKhsR9bAc9ahz+97okA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193926;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Language:Content-Type:Content-Transfer-Encoding;
	bh=i9cvEXmNAwz74fTebOq0heAOpDzfzTtEIUi+RoomRzY=;
	b=xLdqtbYp4M4dra5ZzbiAtT1Mk635kMplcWQGu9uhGQrKIdeh3kdetc7wKappglCGKPsU
	 GQE3SRTOXvXi07WCYYga5NVMhKCIjn7RoBNA5ZCWryUbrRfoZ5kz5vLaRZpR+yqE1z9Ak
	 LjOhNMe+5rISIVxpZzbdFiVLKJbsPNM7romuvDwwcEGGbK3NkcS0wsUCi0QASP3or6BLL
	 VMML2LWlrySRndqIlbM+6Xgr4WPO9Wq+2cuzwAl4X00NVZjL/b1Y0FCrwdGy0+7ad/cX2
	 3uxCElG/Sa7AX9gzzUGLvyAzQuQ1a4wuJU+36zXZruG8mBv7CIol3XjBCY+RcztyVOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=onsemi.com;
	spf=pass smtp.mailfrom=onsemi.com;
	dkim=pass header.d=onsemi.com header.i=@onsemi.com header.a=rsa-sha256 header.s=mimecast20250127 header.b=bsNjOWGp;
	arc=none smtp.remote-ip=170.10.151.120
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DD2606A322
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 03:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1DD2606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.a=rsa-sha256 header.s=mimecast20250127 header.b=bsNjOWGp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1794193919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i9cvEXmNAwz74fTebOq0heAOpDzfzTtEIUi+RoomRzY=;
	b=bsNjOWGpNdt69V5nGT5jZk+dTO22B6lUSme10MKQn5rjpchJfVK8jbnQkS6q84uqYb88xR
	U666Y0fGvDW2UwpqHq+ZULbXDO7KoGnxi3OG0d/aM3uu+bIv+SaCSrZ1kAsrrTfk2mbz0L
	u19vlrmdpMEh2H69TfVlHODi2BhauwXhHC799ddcyMOi5xQ2l4BPk+Na0Eu5xDRJYlrWWp
	lKX9+B1/JdNNGaNXR1pYlOoG4dpswgn4/6cNzA8GV4niKyy8F0DOGaqCsO7glGZPQ1stX/
	m66EdVZjXa8X2AjBhuHKccrVsRee+glUzL+niQpGX4EzeeGqdKMjVf5VIyiQeA==
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-83-5CUGUEL6PeumhUUaBi8OgQ-1; Sun,
 08 Nov 2026 19:11:54 -0800
X-MC-Unique: 5CUGUEL6PeumhUUaBi8OgQ-1
X-Mimecast-MFC-AGG-ID: 5CUGUEL6PeumhUUaBi8OgQ_1794193911
Received: from CH0PR02MB7867.namprd02.prod.outlook.com (2603:10b6:610:110::22)
 by CO1PR02MB8476.namprd02.prod.outlook.com (2603:10b6:303:15b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 03:11:49 +0000
Received: from CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e]) by CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e%6]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 03:11:48 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "parthiban.veerasooran@microchip.com"
	<parthiban.veerasooran@microchip.com>, "horms@kernel.org" <horms@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "edumazet@kernel.org"
	<edumazet@kernel.org>, "piergiorgio.beruto@gmail.com"
	<piergiorgio.beruto@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "jerry.ray@microchip.com"
	<jerry.ray@microchip.com>, "ciprian.regus@analog.com"
	<ciprian.regus@analog.com>
Subject: RE: [PATCH net-next v10 05/11] net: ethernet: oa_tc6: Support for
 hardware timestamp
Thread-Topic: [PATCH net-next v10 05/11] net: ethernet: oa_tc6: Support for
 hardware timestamp
Thread-Index: AQHdbxZHSF2Lknc3ZkOJR7BOz7uGkbclBDxw
Date: Mon, 9 Nov 2026 03:11:48 +0000
Message-ID: <CH0PR02MB786735C6706C24532622196983732@CH0PR02MB7867.namprd02.prod.outlook.com>
References: <20261106-s2500-mac-phy-support-v10-5-31b5a69b85b7@onsemi.com>
 <179409693726.994134.240483510639902959@kernel.org>
In-Reply-To: <179409693726.994134.240483510639902959@kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB7867:EE_|CO1PR02MB8476:EE_
x-ms-office365-filtering-correlation-id: 8dd2202f-4f3e-4bf3-32a9-08df3e0f31a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|38070700021|5023799004|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261021135927099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|10067099003|22082099003|18002099003
x-microsoft-antispam-message-info: DZJdMmm/+QfcVpppzy3bTO0HSWxBK1UuYTNzKc08oPhAWcIUPUbTM9Wo4v/W/BwZFVdPsxbP7e9uckP+EqcSDrcdvS7C+FHfaHM15PpxmGKjI9kDywZwnkmqImvGy5ewTiILvFzgq1AcoXhAbtJdXkU4CQuhGAMkuCgldKSCjtazrZ5GyC/UrVy0wcb6iGFfANVdfNb+//hR8eV6ryv3GeNoMiTOb59xa3MgQuM/L4glOgZCPGpb/t7vP0RxNlCfYKw0rE4VlHD5MNXYzj9eivVwXPuaB5QIFum5tLoF2muMofjjma7kZMBYHIBbWkKRZ8dXBw8ag1vrKI6N1SBF+Dj3x3r023U0MTjZjbmvK97VAKTN9co2jQM6yDI4FLT6ytowBRpAG/5x9WXtrjyPXtl4KVqHl2uccVBKr5qiA1e8wj287c4zrsIIBCcrkHFHeRfFimAB1ndZ6SCZreLWKcsHsdWfLhysku6qCXXr1nsYXmM0R3zr+ApZPfmfhMo5w4Gga79IefH+rMazRyeVLbn1qn7oQn8Pf3uGm7eX7utxJtvNIdXrsKQs16+EO8b4i1FZRj5aeBVWb55LjwUHkM1Kku6WrpBpUoJM1+cFtfZgxZPPzSOYcYE8uIfoMA38Abhwsm+hDkMtPH1XLTUrYJtBtNR9S0oTScI23VND5Qs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB7867.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(38070700021)(5023799004)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261021135927099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L21TWGhzL2VFSk82blJGUUNubmZ6b0NlNkJ1VlQ2QkcxZ2xsdXd1QWF0RnZC?=
 =?utf-8?B?Z3cvNjNWS0hTZmVzU213S2cvNFMrYUh6eUlFOHdHVnFEYkN2L3dKY3lKR1Ju?=
 =?utf-8?B?QkF4Tkt4U1p2cWV0QW1LMUpmbElzRjJVRTVMVzBKWWlRUWYwRzF4OFh2UGtF?=
 =?utf-8?B?cXE5YnZ3Y0k1N3JmcVZKY0VNN3RjRU9PNkNONTZJaVA4SWdFZTB1NDVvd3dx?=
 =?utf-8?B?clg3SXVSbHVEdnJVTUFlSGFvanYvUjdWWE9PRVBLZy90ZFcwdU1ycWhCUVZT?=
 =?utf-8?B?UVB6RnlDZ2xEcXNHejFnK2RMMnhGVUxCRmdBbXZNNWUrWWxZVm1lVnd1dFdI?=
 =?utf-8?B?MFpaQ3NqL0hxNzJHcVVjay9EcEY4aTFiZElrUWt5K2x2S2N6V1lRdmRqWCtn?=
 =?utf-8?B?VUxESC9vS2VzSTc4T3FXdkdlK1lNOXVxRXZ5ZUN1a0dRYThjNlFKNENwcFUr?=
 =?utf-8?B?RUJpS1VPcXIzbjF4ekZ5ajRnMEJXTnVaYk44dzNhYjhHejVuYSttMDR6TlJR?=
 =?utf-8?B?OElrdW5obnNTM1Fmb0tvbHlYbWJnV041NFdUQ1FHdjY3SVl0YkNQWjBQRmpI?=
 =?utf-8?B?RlBWN0lDbHhBWTczSGcrR2NFNDRNSXVRcHhrYlY5S3Z1aWhwZFQxOXI4VDBC?=
 =?utf-8?B?UVhNWEVId1h3YWZNNlFIR1BrWm0rSytiSlN2dFlKbGQ1VU9uNFN5OWlWMTVi?=
 =?utf-8?B?UVlKZktLUWFLenA0Z1o3UzY3NSthOFJ3UnhEVks5eTdXSGkvdVhrS3MwOUdH?=
 =?utf-8?B?N3pqNGdlK21qcW4vQnBZVHE5a0Nvd0lyZHlCWUxTT2llaXcwOU1JU3h6K1RT?=
 =?utf-8?B?dUJSM01OZkQ3SVBqMU5GL3dZV01QdS8vN05nNWgxM05xYUJVcjNGdnFiYXRM?=
 =?utf-8?B?SGVhREZQemZESmVGaDQ4SE92aUZIeGJlOUh6Y3JxYUtES1NUS1phVDN3YXhv?=
 =?utf-8?B?c29lVXBUTjV2YkhhVmZOWERiTEFBTERhcFh4bXI1bGRacHVRVmtSdkRUSGV3?=
 =?utf-8?B?TFd6Y3BEZ1QycCtaMnJQdGtkamwveG9VbzRVUUt6QTdOT051ZXZvM0w1MU1G?=
 =?utf-8?B?OFZ1bk0raEZEZ2xVWFFvZ3RuamVKeEVjVEFsU1pVN3RTS0lIdVg0U1BjZXZj?=
 =?utf-8?B?NWRCV0dWVE85Rm5TcVE3aWFOZG51dGNyQzVWQVN5N0Zwc1gvYWVVMTFLR0dl?=
 =?utf-8?B?Y0N5WFZ5UGk5MjZDTERHdkRPM2l5VWhtdjRDaFFnQ2dNT2ljU2JUZFFjL0Ft?=
 =?utf-8?B?djA2VlFoSjNJMlh6RTMyK2lFbkdiSUhGc0RyVHpQVG1tajNUbTZ5OTlDaXor?=
 =?utf-8?B?SW9hbkFOQWt3SXQzOGdvb3J5WGU2bUJ4MkpSTEl0T2x5U0gzalEwWndqQmNx?=
 =?utf-8?B?L3BVd1d4VWlpUEhRQWxWYW5nV1VsV2VCYUl4RGdGMDdFTzR4dWtLZkJ2RDdI?=
 =?utf-8?B?VFBFaFBHVldVQjhtVW1Uczh3Y1R4WkpNRDJ2QXdOZk1wYXRreDNtZVJ5Vjdu?=
 =?utf-8?B?QVhzY1NSek5nQUhldlh6Y3JxUmlXa08vY25Qck5Rc0dwV0QvNlM1VUU0SGV2?=
 =?utf-8?B?UlZxZ3lpUGVyVDhmMU9VSmtoazBIeCtObXV4V0t5WG0vWC90YkVQMG5NbUFC?=
 =?utf-8?B?Mm8rTjVkUDdwdEg3RTZCQjhLc1Q3dGpNVUxFRW1ndmZSV2dqNWtpRHE0VnA0?=
 =?utf-8?B?U1RWR2lPRENNSThKbzRJcmNBcmYzbUFNdWpLTkQxbW51TmVYSERNNkZGMFk4?=
 =?utf-8?B?VURSTnZ2S0JETTdNRWNkR0tPSitqSFhYVlp1UEdkbzh6MUZoS2lCaHNFNjd1?=
 =?utf-8?B?bkRCTGZlaTJyb2VXdmFrSDJYR0d0ZXlmblNqVWpDWFB4TzMvMlUyRVE5WDYz?=
 =?utf-8?B?Yzd4eDB1Vm0xQVVCcXYzaW9WSGlHbjR6aE5nUzBIZzNEejdHQ0FlaEZMa1VS?=
 =?utf-8?B?QkxROGljbmhrWS8wQnRMMjlmaGptdGl6cTdCdlpHMk5KM2tlVnNtYjY1NDRJ?=
 =?utf-8?B?R29pNEI2MUlaLzVwcTlMM3kvYjlBU3BWTi91clUwdU1jWHgzc2ZFenBHTHRl?=
 =?utf-8?B?dnVQalFKT2MvbXdYYi9MNEtDYjBIdWF0VnY2M29mUC9BVVNtY2tCaU1tU0Ix?=
 =?utf-8?B?My9pQnUyWWZmK2p6dm1xWFJrbVdpMmYvOVlmOU9acThRcXpSZnBoQnpWbGI1?=
 =?utf-8?B?am90MkYzWXh1cjRUdEkvVHVaR0RNL1ZJazB0ZW04bG4wdjJzZk1FY1NpN3pJ?=
 =?utf-8?B?bWVrb3A4b1cyRmZ4RVFvUUxXRkRJMFNVYXNuaUdPTHZhWWpMM1R2OUZtTzJj?=
 =?utf-8?B?cVZ1cVU2akFMRXIxMVk4NUdOQVhhejE3VFVCOHU5WVdTUnhaVkIzdz09?=
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eDohTt2SZTQI1HZSozmvfj+pbPD62FxmiZExeBu5UHLKuFynsyDFlfS4WUh4SgeSymN1+WjNByVpms5auoVD6cx0jN5Z+yDjaCQr0fxgTcuveSPcBGt/WoBpeUUz2JyawRMgcNqXJcVkMXKekahH41bQt5WJqwtio7w04sjMhdyNe9iqybO2iRe7M219vM73XBSz8LKgMq6xLXcRIrntuZVHHNdDtXGRsKlPJx/A5FY4kzxx6m6xbbB2yGR0i5f260ljAWby6uT++TJ7ezsN76vsc37zWDZcYSZrZjFoZgzSUxbT1krsRN6MXTltQiqjV/59RAmnG4cMg1FVDj5Anw==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB7867.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd2202f-4f3e-4bf3-32a9-08df3e0f31a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 03:11:48.8333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YK13ouUjU58wHPvdDsDm1qanWk9vqX4xBej2dN2BBy+t5XeUbuUv2wy9yNQGLtI049tODTh3ANxFvMUH4iddmH3Kc/KIgOor+q/6SoKN88A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8476
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RDRV4kO1LREzMrn836D6mcyIMVowTp5qFD7PZYVEdKA_1794193911
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbmV0ZGV2LWJvdCtzYXNo
aWtvQGtlcm5lbC5vcmcgPG5ldGRldi1ib3Qrc2FzaGlrb0BrZXJuZWwub3JnPg0KPiBTZW50OiBT
YXR1cmRheSwgTm92ZW1iZXIgNywgMjAyNiA0OjE2IFBNDQo+IFRvOiBTZWx2YW1hbmkgUmFqYWdv
cGFsIDxTZWx2YW1hbmkuUmFqYWdvcGFsQG9uc2VtaS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggbmV0LW5leHQgdjEwIDA1LzExXSBuZXQ6IGV0aGVybmV0OiBvYV90YzY6IFN1cHBvcnQgZm9y
IGhhcmR3YXJlDQo+IHRpbWVzdGFtcA0KPiANCj4gDQo+IA0KPiBbU2V2ZXJpdHk6IE1lZGl1bV0N
Cj4gV2hhdCByZWxlYXNlcyBhIHNsb3QgaWYgaXRzIGNhcHR1cmUgZXZlbnQgbmV2ZXIgYXJyaXZl
cz8NCj4gDQoNCg0KTWFueSB0cmFuc2FjdGlvbnMgZGVwZW5kIG9uIHByb21wdCBkZWxpdmVyeSBv
ZiBpbnRlcnJ1cHRzLiBBcyBsb25nIGFzDQp0aGVyZSBpcyBubyBidWcgdGhhdCBjYXVzZWQgdGhl
IG1pc3NlZCBpbnRlcnJ1cHQsIHdlIHNob3VsZCBiZSBvay4gDQpJIGRvbid0IHdhbnQgdG8gZ28g
Zm9yIHRpbWVvdXQgd2l0aG91dCBldmlkZW5jZSBvZiBhbnkgaXNzdWUuDQoNCj4gDQo+IFsgLi4u
IF0NCj4gDQo+IA0KPiBbU2V2ZXJpdHk6IE1lZGl1bV0NCj4gQ2FuIGFuIG9sZCBjYXB0dXJlIGJl
IGRlbGl2ZXJlZCB0byB0aGUgd3Jvbmcgc2tiIGFmdGVyIHRoaXM/DQo+IA0KPiBUYWtlIGEgVFhf
T04gdG8gVFhfT0ZGIHRvIFRYX09OIHRvZ2dsZS4gb2FfdGM2X3NldF9od3RzdGFtcF9zZXR0aW5n
cygpDQoNClRoaXMgaXMgdGVjaG5pY2FsbHkgcG9zc2libGUuIEkgY29uc2lkZXIgdGhpcyBhcyBl
eHRyZW1lIGNvcm5lciBjYXNlLiANCklmIGFwcGxpY2F0aW9uIGlzIHJ1bm5pbmcsIHdoZW4gdGlt
ZXN0YW1wIHN1cHBvcnQgaXMgZmxpcHBlZCwgIGFwcGxpY2F0aW9uIG1heSANCmdldCB3cm9uZyBk
YXRhLiBJIGRvbid0IGNvbnNpZGVyIHRoaXMgYXMgd29ydGggZml4aW5nIGl0Lg0KDQoNCj4gPiAr
IHJldCA9IG9hX3RjNl91cGRhdGVfc3RhbmRhcmRfY2FwYWJpbGl0eSh0YzYpOw0KPiA+ICsgaWYg
KHJldCkgew0KPiA+ICsgZGV2X2VycigmdGM2LT5zcGktPmRldiwgIkZhaWxlZCB0byByZWFkIGNh
cGFiaWxpdHlcbiIpOw0KPiA+ICsgZ290byBwaHlfZXhpdDsNCj4gPiArIH0NCj4gPiArDQo+IA0K
PiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IENhbiB0aGlzIGdvdG8gZGVyZWZlcmVuY2UgYSBOVUxMIHBo
eWRldj8gDQoNClllcy4gSXQgaXMgYW4gaXNzdWUuIFdpbGwgZml4IGl0IGluIHRoZSBuZXh0IHN1
Ym1pc3Npb24uDQoNCg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9vYV90
YzYvb2FfdGM2X3B0cC5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvb2FfdGM2L29hX3RjNl9w
dHAuYw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwMC4u
N2QyMWMwNjA4ZWU4MA0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9kcml2ZXJzL25ldC9l
dGhlcm5ldC9vYV90YzYvb2FfdGM2X3B0cC5jDQo+IA0KDQoNCj4gW1NldmVyaXR5OiBNZWRpdW1d
DQo+IFdoYXQgaGFwcGVucyB0byBJTlRfTUFTSzAgaWYgdGhpcyBDT05GSUcwIHdyaXRlIGZhaWxz
PyBJTlRfTUFTSzAgaGFzDQo+IGFscmVhZHkgYmVlbiB3cml0dGVuIGFuZCBub3RoaW5nIHJlc3Rv
cmVzIGl0LiB0YzYtPnRzX2NvbmZpZyBhbmQNCj4gaHdfdHN0YW1wX2VuYWJsZWQgYXJlIGFsc28g
bGVmdCBhcyB0aGV5IHdlcmUuDQoNCg0KV2hpbGUgcXVlc3Rpb24gaXMgbGVnaXRpbWF0ZSwgaWYg
cmVhZCBvciB3cml0ZSBvcGVyYXRpb24gZmFpbHMsIGl0IG9ubHkgbWVhbnMgU1BJDQp0cmFuc2Fj
dGlvbiBmYWlscywgd2hpY2ggaXMgbW9yZSBzZXJpb3VzIGlzc3VlIHRoYW4ganVzdCBoYXZpbmcg
YSBtaXNjb25maWd1cmVkDQpoYXJkd2FyZS4gU28sIG5vdCBhdHRlbXB0aW5nIHRvIGZpeCB0aGlz
Lg0KDQo+IA0KPiBbIC4uLiBdDQo+IA0KPiA+ICt2b2lkIG9hX3RjNl9nZXRfdHNfc3RhdHMoc3Ry
dWN0IG9hX3RjNiAqdGM2LA0KPiA+ICsgc3RydWN0IGV0aHRvb2xfdHNfc3RhdHMgKnN0YXRzKQ0K
PiA+ICt7DQo+ID4gKyBzdGF0cy0+cGt0cyA9IHRjNi0+dHhfaHd0c3RhbXBfcGt0czsNCj4gPiAr
IHN0YXRzLT5lcnIgPSB0YzYtPnR4X2h3dHN0YW1wX2VycjsNCj4gPiArIHN0YXRzLT5sb3N0ID0g
dGM2LT50eF9od3RzdGFtcF9sb3N0Ow0KPiA+ICt9DQo+IA0KDQoNCj4gPiAraW50IG9hX3RjNl9n
ZXRfdHNfaW5mbyhzdHJ1Y3Qgb2FfdGM2ICp0YzYsDQo+ID4gKyBzdHJ1Y3Qga2VybmVsX2V0aHRv
b2xfdHNfaW5mbyAqaW5mbykNCj4gPiArew0KPiA+ICsgaWYgKCF0YzYtPnB0cF9jbG9jaykNCj4g
PiArIHJldHVybiBldGh0b29sX29wX2dldF90c19pbmZvKHRjNi0+bmV0ZGV2LCBpbmZvKTsNCj4g
DQo+IFtTZXZlcml0eTogTWVkaXVtXQ0KPiBEb2VzIHRoaXMgZmFsbGJhY2sgYWR2ZXJ0aXNlIHNv
ZnR3YXJlIFRYIHRpbWVzdGFtcHMgdGhhdCB0aGUgZHJpdmVyIG5ldmVyDQo+IHByb2R1Y2VzPyAN
Cg0KDQpZZXMuIEl0IGRvZXMuIEZpeGluZyBpdC4NCg0KDQo+IC0tDQo+IFNhc2hpa28gQUkgcmV2
aWV3IMK3IGh0dHBzOi8vbmV0ZGV2LWFpLmJvdHMubGludXguZGV2L3Nhc2hpa28vIy9wYXRjaHNl
dC8yMDI2MTEwNi1zMjUwMC0NCj4gbWFjLXBoeS1zdXBwb3J0LXYxMC0wLTMxYjVhNjliODViNyU0
MG9uc2VtaS5jb20NCj4gPGh0dHBzOi8vbmV0ZGV2LWFpLmJvdHMubGludXguZGV2L3Nhc2hpa28v
Iy9wYXRjaHNldC8yMDI2MTEwNi1zMjUwMC1tYWMtcGh5LXN1cHBvcnQtdjEwLTAtMzFiNWE2OWI4
NWI3JTQwb25zZW1pLmNvbQ0KPiBuZXRkZXYtYWkuYm90cy5saW51eC5kZXY+DQoNCg==

