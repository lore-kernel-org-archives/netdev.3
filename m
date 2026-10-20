Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.153.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792524845;
	b=W9FlKzRLYWlJyh3OY0yYXIAruzaS/6oGTXlwZpSMH2yxdYSgq7UlzeekMFqi0GZsuiW+
	 qPTvqYDh17dD2Ox/xPm/DABu0PDLLWhuAKffqkSbniYeXwyjJmUvcpm3J4xub88A1TWHX
	 7A4A1sGOVptgbb43d7ZdaXiz5WA2B8d761XdnH/LbkklUhvQrWdXfvtb/DB2k4/IBnSyR
	 LcNtBHKCCt/XZvW6P/BIBN3ZYv3uVvWh8zKckWmdRCcQow07hWBL4jAb0Hx6+7PsDWDbS
	 FXDaX3ISeN1C+/We4FqYANw2DAuKCCr1sX7TJLF0uZ7J2d8eIWxOJkfMMFmGSdBOYjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792524845;
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
	bh=NpkpID4GmG3/21HfyaT7AaZWifjFo3MoLbfz+x/9Qfc=;
	b=sApwtYxKL0mZgXg6JO8YXchrUOqIej8BUe+3l32A3Vu0//8/384fJ7A/cwMHi6LuvcVz
	 vTRseXpfOgEnixY5Rzx5WlgTGnDLkcOAlPrHGozhrNYs8wuCCftHVy0GObntDHKeeGNZx
	 kTgg34GLIe8GU6FpStvcAdWalPGAegIspprHueBPdOUV2P4ecVEmk0jGyViB1QvMUPvAv
	 hRZ7eMQakf6UEx9qDez9GK8k0pmW6Nh2GS2liKzh2eYek2tJiRA18CXF0oBIJRnbgp6ZV
	 lzqxXI/PO8e3l6VInSP8P9D3BUbeM6aC5Ie9sfDBLECoqgQJnPwK0lqhGP3zLbQzpHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=onsemi.com;
	spf=pass smtp.mailfrom=onsemi.com;
	dkim=pass header.d=onsemi.com header.i=@onsemi.com header.a=rsa-sha256 header.s=mimecast20250127 header.b=Q66RLn4b;
	arc=none smtp.remote-ip=170.10.153.120
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679B9606A333
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 19:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 679B9606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=onsemi.com header.i=@onsemi.com header.a=rsa-sha256 header.s=mimecast20250127 header.b=Q66RLn4b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1792524843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NpkpID4GmG3/21HfyaT7AaZWifjFo3MoLbfz+x/9Qfc=;
	b=Q66RLn4bOL8x3zFPZ//O+lnyKU7MCGa8xd4axNZffrHkVQqAcCTEOL/4D9is/j3SQ7Ec4l
	S3Y58W+Ms7Zxw1BNMN/khrNsDofMy17prPHtz5QWWTx6uDc5OwdGhDKzLcyQz6siDN5iCM
	8IRImhDzRFJAfPTHwHDZK4969y6v2os5qKJmG2fl0O6Q3+xpkYQCPFqY1zNcnVM8kKGccf
	8HhlJhF746F/Pbo59TFNDpaUK8QIymZAYHvxPl/p/0iw0OA5PPma0nM2A+/pqO0Hg3mGHV
	2Iqkl1Il2piy9DpUnVN9f3wtBKQvGKEPS++mkAt+yVDlWWBWLC2F362w7dsqYg==
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-48-EALiAdXvMQ2XoyThZguAkQ-2; Tue,
 20 Oct 2026 19:33:57 +0000
X-MC-Unique: EALiAdXvMQ2XoyThZguAkQ-2
X-Mimecast-MFC-AGG-ID: EALiAdXvMQ2XoyThZguAkQ_1792524829
Received: from CH0PR02MB7867.namprd02.prod.outlook.com (2603:10b6:610:110::22)
 by DM6PR02MB6921.namprd02.prod.outlook.com (2603:10b6:5:258::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Tue, 20 Oct
 2026 19:33:44 +0000
Received: from CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e]) by CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e%6]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 19:33:43 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "parthiban.veerasooran@microchip.com"
	<parthiban.veerasooran@microchip.com>, "horms@kernel.org" <horms@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"edumazet@kernel.org" <edumazet@kernel.org>, "piergiorgio.beruto@gmail.com"
	<piergiorgio.beruto@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "jerry.ray@microchip.com"
	<jerry.ray@microchip.com>, "ciprian.regus@analog.com"
	<ciprian.regus@analog.com>
Subject: RE: [PATCH net-next v9 03/11] net: ethernet: oa_tc6: Move oa_tc6.c to
 its own directory
Thread-Topic: [PATCH net-next v9 03/11] net: ethernet: oa_tc6: Move oa_tc6.c
 to its own directory
Thread-Index: AQHdWBF4M/EMxq6bWUq+jfBhDl2vh7b3LjCAgA+A+RCAADNzAIAAAMXA
Date: Tue, 20 Oct 2026 19:33:43 +0000
Message-ID: <CH0PR02MB786738897F3887015191954B83672@CH0PR02MB7867.namprd02.prod.outlook.com>
References: <20261009-s2500-mac-phy-support-v9-3-dcefe1d0bf0d@onsemi.com>
 <179166121127.434549.2014178695820662916@kernel.org>
 <CH0PR02MB786710538BD4784E5CF2C9A183672@CH0PR02MB7867.namprd02.prod.outlook.com>
 <e40a4fae-b339-4a5a-b21e-3a31dd3ddd5a@lunn.ch>
In-Reply-To: <e40a4fae-b339-4a5a-b21e-3a31dd3ddd5a@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB7867:EE_|DM6PR02MB6921:EE_
x-ms-office365-filtering-correlation-id: 5999e16e-66e3-4158-f26d-08df2ee10d3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|38070700021|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003
x-microsoft-antispam-message-info: W5BHNuw0JqospCNdamWu6E/WtYj2XzC3dFrXhmxrFk+SM2FHDXBvDaVKAzOh7NYqrqoueuaYHgVRfwEO1OBwfeXBJKpY9lv8+tr+BAYuKZUnGMHSkv7GHLtEVlWgv4Z0BQixoicQLhVKZSlhQi49bJrQ1WpvOOW6/pxZ9dAguEvGjwwcNKcVSzVR0PA7/LLk9Z2ltUgMyNhpPChEo1hMSlC3pdZVkUBx8v0wQd6lATb+PRq5irBG61SOf5G6U5yl3zZNa73/i/gLilD2mJSmmSeeGh124wvSTRpgz/lcMH+xdQbuMBdo1jy5c1b1DZx5s9WWXSUgnuPOkXU+m7n1T5clysvL3pGQtoAZQAshGLGlV7WdLgq8lLcDvqNiLkLGOTjYg9MPTFhHmV5XzUds2VUDIeLQkODgc3WXxNHKWfdbOpyxTQg/wt6UtCt12VZempWgJvSqIHZFVjcRRq3/KPic2a+81usftlPP5elVzJcJgCY79pTwXn0q1VU61KFALpeFEX5wr9XO27NQDsy/Re3Vtb9sqNyB7p+ECU2oAGxWpM1OVR/K3E/AqOmtLLcf2vY1XINyM5eqiXHQ/SplLNIeehvFmVhm//EYhSqoCbMA1ngROiZob7Z6fbrpLXp2tcbjJbH19aSqxVm7r9AhFXyMOtK0ooOQ0/YLBtqA028ng9gLfscCd56Hhc0WV36vR1QL39f+2TmYfjIiW/vNtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB7867.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHZkM3FQN09BdjhwT1VhamYwNElSc2RwRTFQVE5OVlJzOVNSLzVyaWZzMCtV?=
 =?utf-8?B?ZG9nMXd1TittcG8rZjB2Q2NyOUxoV2ZIYlJQb2h0cnd6N1FWSm5EOWp4TklC?=
 =?utf-8?B?dUNXZGxZMFBRRWgxWXJJNHdvZzBHK2g1RTBKNUVmTUZaRWgwNGluamdaNFZr?=
 =?utf-8?B?Uk8xT0NjSFV3SERVaytFb1cyUlYvZ0k2SHh5aS9ZN1h2YlhIYWRhTHI5TUo5?=
 =?utf-8?B?OXJGc1E3SDNSZ0VQVENHMldWZkFGVzNzV000dk9BSFJxVjR3ajVtT2NwTnpT?=
 =?utf-8?B?dWJlV3RjSDFhLzNrQmdmbEhtTzdMVElOT1AxU3Z0L2tEZHViY1ZXenhkbnl6?=
 =?utf-8?B?NGtoNzZqSWNJTlUwTTk1YkY1VWJHMHZ2Yk1Pd2t5NTh4eHhVRTJxZDkwRjR3?=
 =?utf-8?B?ZWo3TzREWWU4L3FUd25hQitpbjlabFhjQzlYMTM3SnBtNWJjdlNRSnIwZ2pv?=
 =?utf-8?B?b0ZKUkx3WDhJZU5qamg5WkRuTjBZekpMTjdyTjh4eVg5U2Nyb2hOdGUzOWJw?=
 =?utf-8?B?V1pQQndWTkEzSGg1VUcyY2YwVUVPTWE3MDUxVGtiaGZPOVVsSWwrdVFqWWJw?=
 =?utf-8?B?dEROZTEwSngrelJqSENhZFBCb003TVBqNmtya2RVUThmTW50UEFINmZLSi9O?=
 =?utf-8?B?VE5jdW9Ba1lHbkdYVFAyWWc4elBpWVpiL1IrN0cxS2QzSDNPZTlJS0RBaStR?=
 =?utf-8?B?elBxczVKUWNkTzlZZEtZNzBIdTh3V08vdnZjTkFSNGppd1llTnk2RzVYY3RI?=
 =?utf-8?B?bXBmUkM4cTNPNkVhWVpQUWFFVHVSQjdCbE9xanhWNHdXV01ad2VlSE9QRTNX?=
 =?utf-8?B?OUlZZEw3MVBicFpnVmF6OTgvM1ZUL1cyZGNPcWdmZ3Eya2ZCc3BlaTVCTFA5?=
 =?utf-8?B?SThScEp6azNCSi8vRHZmMzdZSkYycWRKbVFjem0xUVNIVEJlTHozMXBZa1N1?=
 =?utf-8?B?ZlVobFU5anFZY3p2N3hEd3VQTFpCWnZnY29oUUQzcldQZDNhYkozVnFrc1c2?=
 =?utf-8?B?bm96NnNzd0RubGtqQmt3NFlpdEFSQlBIZUJqdlRtNk4wKytkMzNhSUF6WEpP?=
 =?utf-8?B?SmlTT2lNOXpVN2lXYVcrN0hHUEdHV0RiNmJSWFlZcHhWTkx6L2dwT2k1OE1w?=
 =?utf-8?B?THpqQVpWR0xET2IwOVM2Z3ozNFFNaWd0SFhDQ01TN1I4OVVqWUtSUzRwbHUw?=
 =?utf-8?B?YkpKd2VrMTJqbDNzQW4zYnhaOTFKVnhnWE5oKzJRN1E3UDNEbHBrVE9OcFVK?=
 =?utf-8?B?VW1ZQVpYYWFydTFWUUs4VDhUYVZwSmVKcTNOaEVvMHlXdThIcWdUbXFlNnBN?=
 =?utf-8?B?bUlLWUJsckVRMzRIbkJ6amI0TThSTnJUaW8yVVdiTkRCTHZYTDU1bGRxZ2Zv?=
 =?utf-8?B?UVQrTnBjbkRMbHF0Sm5qNGM1UmFKMU1jeXoyRkJ0VjZSNGJHdW0zbEV2YTBw?=
 =?utf-8?B?NkRJb2hBQnNkcHQraUZBZ2R6WVZtek1yMW51V1Mvcy9pdG53NDlTdEFQK3FW?=
 =?utf-8?B?RVF2UFQ5cmQ3WE1VVy9KNVFpY01BUVpqSS9nR3lLSjlHdGJ5T1FzeldsQlNi?=
 =?utf-8?B?OVhoR1dST1BIWTlsaEFzNDlITnlkUjV4eS90dUFjZ05obktHSmJxL0lQYmVD?=
 =?utf-8?B?YXVLM3BrUXQyQXNDa2RhQ2wvRlpsSkhUVVN0N0g4Tm1BOXN3UTZnSGE5RU5Y?=
 =?utf-8?B?U3JLT0dQMzYvRFdBMXhzb28xYVlBUXNVdlRVVm5OcFo1ZmZuei9FU3o3Tlp1?=
 =?utf-8?B?cWFLSi9sU2xwTXNKY0U5UkU5ZXdjUzEyaWwwRk5kSXhkc3dYWlNRNFphSVdD?=
 =?utf-8?B?U1pGTmI2R2NYc0JEeFZNOUJ0MVBubnNkSU9pSzNQRmttUDNTTUsyUE1JdUJY?=
 =?utf-8?B?Z2U0YkRTelRiUlBoWm5QRzhIK1UybVZ6VmYrNWtEaGZLbjF3bVpPaE5oNCs4?=
 =?utf-8?B?akxCRzZSZmU2RUwzKzhZcjhENkEwd3ZQNFFZTHZ6Q2hlR3dPOWNJVjhJUDNw?=
 =?utf-8?B?dk1NNFZRKzBuWXpYaEpZUGVLeWoya21IZjg2YjE2NDl6L2I5SktIUUxJNVpY?=
 =?utf-8?B?YWlvcWdCMG1TQ0lNMzY3V0hRRlJkOVJKcWFsMTJjSm5abkJaVFVRS1RNQWFv?=
 =?utf-8?B?TFVDZTd5WE9wRUVGNlc1OXZmSXc5d3A5T3drdlA5Sm4rczJFTlBDR2xkUGlX?=
 =?utf-8?B?a3JZdmtpb3FCcjc5c2ZCSENVWmsvancrdVlwUmNzazhZMitnUWlIcHNCTFNq?=
 =?utf-8?B?Y0RGNkh0VkhsRG5BSy9JTjk2ZnNQUm9zczNMOWNGVFpHaWJYaWRVc1V4cmVH?=
 =?utf-8?B?S2JXaUdmQ1lqcUtMbkM5S3A2Z0JqTUhVYVpXa2NnNHJubVh6M0phbmxPUnRY?=
 =?utf-8?Q?8BAzk1GTBGMjWnr4=3D?=
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VJk5hrU4UPnMTxwt/1R4JTPlQJVR8tlCuAWPxIzmK8szZyeKMVkSneimg+Rh4gcVbtdpHCepuce9f1hMt2h64TQ3KiOspr1n6hPndxrK8owQKHYIlQFpM9OLS5YK9OVHCxdArLNFp86e4JybTzqZlBvOTzgUgKSnopQnmI43qq1NMxfIgTqOZ31VYjCOjzeFZ15dVvOOdhAxfU81z5/RyvkPwph/9I03+Xam8tBWy69DYBAN+vdlL1zYYau5iy3HQRtbNH89eIqhhS/xAvDCckvSNerT+3zfZrgj3SVlKEAmzpUteXLB0rohQbQMYagn1m/Blp1+8GQ71bpZBzBhNA==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB7867.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5999e16e-66e3-4158-f26d-08df2ee10d3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 19:33:43.4237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6P81sfvAvRZdXEAvthCj6nLlomDCUZhJZg0bht8mNsLJ9USUxLMaTEyK5q2OLS42Pxa+pY1phwignmvOoE0n6IP/Yqkr28IpmggnotrdGO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6921
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: q5GXdZmC_hGyw6UWAUP3aZdkOCvZhE8-g8u_FdZcx0I_1792524829
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

VGhhbmtzIEFuZHJldy4gDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
QW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDIw
LCAyMDI2IDEyOjMwIFBNDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQgdjkgMDMvMTFd
IG5ldDogZXRoZXJuZXQ6IG9hX3RjNjogTW92ZSBvYV90YzYuYyB0byBpdHMgb3duDQo+IGRpcmVj
dG9yeQ0KPiANCj4gDQo+ID4gTXkgcXVlc3Rpb24gaXMsIHNob3VsZCBJIGNoYW5nZSB0aGUgbW9k
dWxlIG5hbWUgYmFjayB0byB0aGUgb3JpZ2luYWwgb2FfdGM2LmtvIChmcm9tDQo+ID4gb2FfdGM2
X21vZC5rbyB0aGF0IGlzIHVzZWQgaW4gdGhpcyBwYXRjaCBzZXJpZXMpLiBJZiBJIGNob29zZSB0
byBkbyB0aGF0LCBvcmlnaW5hbCBmaWxlDQo+IG5hbWUgb2FfdGM2LmMNCj4gPiB3b3VsZCBoYXZl
IHRvIGNoYW5nZSB0byBvYV90YzZfY29yZS5jIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+IA0K
PiBJIGRvbid0IHRoaW5rIHdlIGNvbnNpZGVyIG1vZHVsZSBuYW1lcyBBQkkuDQo+IA0KPiBIb3dl
dmVyLCBzb21lIGRpc3Ryb3MsIGVzcGVjaWFsbHkgaW4gdGhlIGVtYmVkZGVkIHNwYWNlIHN1Y2gg
YXMgeW9jdG8sDQo+IGRvIG1ha2UgdXNlIG9mIHRoZSBtb2R1bGUgbmFtZSwgaXQgcHJvZHVjZXMg
YSBiaW5hcnkgUlBNIG5hbWVkIGZyb20NCj4gdGhlIG1vZHVsZSBuYW1lLiBTbyBpZiBhIHJlbmFt
ZSBjYW4gYmUgYXZvaWRlZCwgdGhhdCB3b3VsZCBiZSBncmVhdC4NCg0KDQpTdXJlLiBXaWxsIHJl
c3RvcmUgdGhlIG1vZHVsZSB0byBpdHMgb3JpZ2luYWwgbmFtZS4NCg0KPiANCj4gR2l0IGlzIHBy
ZXR0eSBnb29kIGF0IGZvbGxvd2luZyByZW5hbWVzLCBzbyByZW5hbWluZyBvYV90YzYuYyB0bw0K
PiBvYV90YzZfY29yZS5jIGluIG9yZGVyIHRvIGtlZXAgdGhlIG1vZHVsZSBuYW1lIHRoZSBzYW1l
IHNob3VsZCBub3QNCj4gY2F1c2UgcHJvYmxlbXMuDQo+IA0KPiBBbmRyZXcNCg0K

