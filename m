Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.151.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514943;
	b=Z9+Vj5pjU2R5N9GxukcjdSnfQsuIFvmZkJaH1D1cYyA2qVdXAbKf0qdqIXVRTBEd7XTr
	 yYhUoroU20BoLcn6ATaChKT/6H8BYVeT24Xxu+fWDPNkivQfwTuXK6CvHNRnOQo8DDP7c
	 lCG5WBnCi3ysg+HvZ6VZxhBawTGBC0i2ywq9i5NVb0POI5f5/1Z1BjtUHFUj9qrgfE2KU
	 50RXE5YbLd8e3lLRHpt1U8JvWChgwPYJTlfyMryzSIjJNZDlCnCGLTZWgWtppaUsYcbKH
	 Z+oAs3OlPYiHJ/EhOhgy+ttUFg/ELBQ6GcW/H3QJVP2yhfJO7V+gLNwrtI32hWIG29w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514943;
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
	bh=88ayal/3so2TsF8N+K7ARN7KmPZKnUT/UdoqapqrQs4=;
	b=b3L7IIVkRCWPBoRjbgw7e8XKpZ4kw6ZRF8jBR62d+5vl5AfvlLbj7HRO0hqYMZ9Mb9Jm
	 W1tLj/cIMbr77fJrZxT9rwL/ZiTefGWJ4n7oEpXgSM7y5X477q339r4cjh2eDI6eaT4UF
	 k8+DDT0niHXZa3RRiC4HCt8oOcHKYA4aEYS5dJIB0oS5CZJouX5w8ayvm7bk6j/Q760PX
	 6R7CEbLgbxHYcQwvXKWQLYczBTMeTWF1ACjJ6S1bwPkkFj09XDq9/TRWtQMZjbpVb5omN
	 K01orPb0p8H2VWL4Fi8OQtQFBsfUJQ0baVW9x9ry1Pn4/CrDNeExSqKOxAsc225Bv0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=onsemi.com;
	spf=pass smtp.mailfrom=onsemi.com;
	dkim=pass header.d=onsemi.com header.i=@onsemi.com header.a=rsa-sha256 header.s=mimecast20250127 header.b="DXy1KvS/";
	arc=none smtp.remote-ip=170.10.151.120
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC63606D571
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 16:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AC63606D571
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=onsemi.com header.i=@onsemi.com header.a=rsa-sha256 header.s=mimecast20250127 header.b=DXy1KvS/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1792514937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=88ayal/3so2TsF8N+K7ARN7KmPZKnUT/UdoqapqrQs4=;
	b=DXy1KvS/GevdXK0kDBjJCuEqin9V4P3qLtgy7z6/sBNELlTfgbUL5DOCHUdNcEFdYqQ/5i
	banoUmSUzZq8tJE4kP7YSvC+NA94lJkGjFff5cNAPMn5wkqoaXBVypV23H0VX9sR0dFFEd
	RBe8RJbl6Qa9F1etS9/PYFuqjnURGM3wfi3Ij0ys2qmtRdLyV0IpAk0vpkLPZ/dDPEynkr
	irwMrlDHhdDopcm8rrNRb6abOPW1RYVeREGDQeDnz8+kowMGPeyI/9OIv09bKN2/O/zhrO
	nHTxhD0jmdQfGswgQfJax6L7TUEUiRpQnqce6XmAiH8jfKOVAl/E/qIXR9Uxfw==
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010036.outbound.protection.outlook.com
 [52.101.193.36]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-21-Fhb5DivKPSyeNOpeCqfHHQ-1; Tue, 20 Oct 2026 16:48:53 +0000
X-MC-Unique: Fhb5DivKPSyeNOpeCqfHHQ-1
X-Mimecast-MFC-AGG-ID: Fhb5DivKPSyeNOpeCqfHHQ_1792514931
Received: from CH0PR02MB7867.namprd02.prod.outlook.com (2603:10b6:610:110::22)
 by CH3PR02MB9257.namprd02.prod.outlook.com (2603:10b6:610:150::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Tue, 20 Oct
 2026 16:48:48 +0000
Received: from CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e]) by CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e%6]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 16:48:48 +0000
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
Subject: RE: [PATCH net-next v9 03/11] net: ethernet: oa_tc6: Move oa_tc6.c to
 its own directory
Thread-Topic: [PATCH net-next v9 03/11] net: ethernet: oa_tc6: Move oa_tc6.c
 to its own directory
Thread-Index: AQHdWBF4M/EMxq6bWUq+jfBhDl2vh7b3LjCAgA+A+RA=
Date: Tue, 20 Oct 2026 16:48:48 +0000
Message-ID: <CH0PR02MB786710538BD4784E5CF2C9A183672@CH0PR02MB7867.namprd02.prod.outlook.com>
References: <20261009-s2500-mac-phy-support-v9-3-dcefe1d0bf0d@onsemi.com>
 <179166121127.434549.2014178695820662916@kernel.org>
In-Reply-To: <179166121127.434549.2014178695820662916@kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB7867:EE_|CH3PR02MB9257:EE_
x-ms-office365-filtering-correlation-id: f3d8046b-f6ec-4acd-7826-08df2eca0362
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|18002099003|22082099003|10067099003|38070700021|4143699003|11063799006|56012099006
x-microsoft-antispam-message-info: O2EfbugKjM5EqGkAXXgc/6ktNm/oVImD/CSeWNS07FzdMj6QKX5KIVorRPwy8jH6woMU3TD3xaD7wDuCLYn1gydIkb6hMYtMUh8yo0PzVf8r1yf7BFNCKdWVPyF49B1fPDEUzxWqe8GU1aAJJQVm+GFAGPpEcwzY/l+Babto4hWXI9yvpYyNeZEJEoRIV6pAkCrCm/fJtjVquMMbOIFruGfBiiM/Wp9IUOV3KdqdyX3phTTpcXO+MQs0rcoxkamyzjEZ5Af4OwnipI8+TyEsRCQhVFsj3uI5VcxeLIjJQdIjHfQ50v/GcXMbSW2MJWJC4hvZfhpCc1HlzTObiuZ7MQcxjGle+0uZ8tIkAsJnWBbbOP/oLGRdDnURIQZ4PWa4xSrgMbIAFrW9QnPgzhaJyf1wzDHb2lO7Gek+Kh7JJDN9+2StQeEeyDKsNKx00Y+TeHFy9juVxSDlAx7CiLywUdRMOpBBJdi57n33qsyoWTOPGBx1zKmmvJ3p9IIjCiqmqb+8CXGHZOhM/GciX/MhVh/MDCcjCqQ0SqIninByR2py4honOWcLSiXgIqL5bGj9tKy6JNpyWsqscwa1I9k2dnZ5BtENnPdOoCBG0VXA5asu0My/YAzh7drEpAbUWrBNQ2pP4h3edM5Jj0FlVT/CB3yk8ZCP57zhh4kzNqZjAl1HNLJvDrAVLHHcf12fZ0v1J3PGQXj6jcxJ8/gZRnF4pw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB7867.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(10067099003)(38070700021)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THNjRHdQejZ1anBtT2lJQUIyVGl6MFJWVi9wYXQ0OXUrajl4eklkVzdESWhR?=
 =?utf-8?B?ekpScmVQaXFoMXY1Mno3d0dQTWZLOTN2anR1UXEvSFcxZEhJaHJuVUI4cnpv?=
 =?utf-8?B?Z3dtdEF4L1lKeis1Q2FDUkpDdk9kd01vZkZaeURPYVpvazNJSC8vTTd6NStw?=
 =?utf-8?B?YUVQMWFWcHpTZHhmSzBkSnRkbEtyd0p4dXBWOE8rMGk0YmdmRmM0eUZDa1I0?=
 =?utf-8?B?VVVZSXplMXZmN0dGaG5qTmVXb3BienA1STlnUkNUUElwWG82RWpESkwvMUxI?=
 =?utf-8?B?T3p0bG4yUTNEdVp4RkpVNGc4bDRKQ2lPRlpMelJMblljbkhka2lOdXdCQ0Z0?=
 =?utf-8?B?eEJkQUhKYUNYdU5BVVA5Z08wUkRvKzdYd1paTXp5T081T1VOak4vUlQwcXJT?=
 =?utf-8?B?RmJXTzdpNHRwaGlEekd6RG9aVk4yU0pQM2toOXUxQ0JvVjg1WEhKVVJ2dEMw?=
 =?utf-8?B?TXE5VmRacVJVRUNXY1ZCS2RYWXJVMVpVRzFURVJJZkVGOUZsOElkL3RvYzhS?=
 =?utf-8?B?T1hST3owUjhTdUQ5UEYzMmNjaDVjbFdkOUhCU3NDMHZPeUM2OE9kSURvQlgy?=
 =?utf-8?B?QmErOE5iSllFZnBLV2ZUT25YR0ZGRmZBMXVCYzE1a280T0ZJWEdMNEFmRjk4?=
 =?utf-8?B?djFsRk96cEFFYStyZjVWMndvck5kRFVkU1kzVjYxb2VyZVBpQWNTenNTaE9a?=
 =?utf-8?B?N0ZqTCtHNVdCUHpRYTYwTnhtSGV5d1hkUVdKZVh4dmJaQ2VsLzdpYWsvMHpy?=
 =?utf-8?B?Rlh1RjlWVmtZeURTYzNzMnZlNVRqUTY0UmM2VlRCdTFlVWxvQ25pU3pZaDZ0?=
 =?utf-8?B?VEh3Y2lYMkcvR3dPK1VhN0Y1aXYxcXZkcGovRThBYmFaODVUNDVJN0psclY0?=
 =?utf-8?B?eFlBT29mSTlybUZvc1Y3T1VPQUZ1cXVqU0JpY01RK0JoTnpQazU2ckJVNlgx?=
 =?utf-8?B?RDJqVUcrZWpGR3J4S1lib3JOaVhZMUcvT2Z0bEwySE1xdktacW9JNTZHaUdN?=
 =?utf-8?B?bGxLV01XNEx5dGcvRXMrcG9MdzB6Zy91alBUaXQwRE1COHhKVFA2dEViekVp?=
 =?utf-8?B?cmV0VVhVK0c2STczcFlQejY5dlpRd3owM2pVQ2t0T0x6RjdpUk9lRS80Z2lQ?=
 =?utf-8?B?RzFQMkhBM0NnY0V1KzNvekk3dTJlVDNhRlN4K09JNmY2OFloNlcxZlphQjVI?=
 =?utf-8?B?RDVqMkhZNm5PaGhPMnlCLzJ4bzFpbkZjZXFJU0ZWY3BqVFlUNWgrekRUL3dO?=
 =?utf-8?B?cWM2OG5PK2lJNk9jSjlpTmI4SU53aTZhdUhmK29DMldJemZTL0srZ3ZHRW5i?=
 =?utf-8?B?bnM3QmtsRG5NUlZvUkE5a0tiYTc0V0NLZkRKNG1Ed2IrTWZTOFhibERYdUMr?=
 =?utf-8?B?clowSXYvV0M5T0NPczB2a2ZvNU1XZnFCdUhPeXMwOUJrN21ZUVFTWCs5TlBq?=
 =?utf-8?B?NjNEQ3pVWi9FajFkakJWcGtZMjljREZ6Y2JWTXI1M2IzeXB5MHIrMG8rNTYr?=
 =?utf-8?B?cFYzVnlCREhtMlJkYVY0bW5DZUhKbzJCYmdrejk1cUlEMEZOcDgyajFZTHdE?=
 =?utf-8?B?VGV4aDBXYnBxNjlweG5xOVc1aElNMHd1ejR4cldaQ2EycnF5ZDFNN2xjcmdM?=
 =?utf-8?B?MTB0OUNmcmplcXZUenNhK29qMlNUeXNESHhxNDFFMVFIK2lZN09SektGTFVo?=
 =?utf-8?B?eFJQWTlKblBTeTkzWURMK0hVaWFFNzlGSWhHRCs4MGhzQzhRNG8yS0dZQUVy?=
 =?utf-8?B?WmgrVWt0VmgwZTZtUHQ3bHJuaG5Wc040UlIzVFBIOUZOTlZyUHpBdExZYldO?=
 =?utf-8?B?Um9pdGEwWWJxNFV4aFFXZ0M5cWdya0g2c3gxVHBxZlp0SVoyZlR6a1ZYbW4v?=
 =?utf-8?B?VmJ4eXdqWnA4VFZmK085K2dHTXArNTB1bDFoSWQva2NEM2lCY3Fkb3FSeHJj?=
 =?utf-8?B?YkdFZjZ4QnV2bzZkUTlxNFR0RXdCRDM5QWNYbERxWWVlaFllWlJoblh1WVE0?=
 =?utf-8?B?NGdBREdubnJkT205UkNGczdJNzF1bkMrZEY3ZzA5clNYbFdMb3l5bmhWZWs1?=
 =?utf-8?B?TnZaUUFabnZ2REh0Z0l3eHJLTmVVUFQ1RE81TW9BWHdlQUFLVXBLSHRQTHo0?=
 =?utf-8?B?akFaQ21TbGoycGM3UnUzOTN4SXdpK3drZUZxVG5Ga09CMmJkM0NUQ2p1RHJ6?=
 =?utf-8?B?QXhaU3hnWWZrRE45c2JadUdIS3k0MXY4NE91Qm1TYjMrZFpwVXl4RmhuMFRl?=
 =?utf-8?B?MFJtdXhZdS9hdFJGb1VZTlRXNnAvT1FjR2xtTmlhNGc4aEsvZDdxY1cvMGRM?=
 =?utf-8?B?REZnSFNHNzVhTG1hZVVvVUhQUndERjl1SVNPUVBFZFczMmZKUkRUSVl0dGNO?=
 =?utf-8?Q?RecepwiHUu4wW/Bo=3D?=
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jD4JtIc7a98vmTAu9KS/+AxaG2Wk1rg431naVHHsmMSnGuy/E+3HCHZW9t3jerxSBFlASCL4UBfotomv3GQqc2spaOILadPdMnV/ekh+2lWtW6qC7eDvVL9y+0eaFX/NWKOw5vLMz/Trn/o0EzQIiQ92degsauVFLEHa1HB8+zAMrP5hc6HFrzyg6IsgggtRLKOt6FvJDHWsIPMsdr3kWZnPvMDojfQfPbjiwKtVputKeVyC6DxAaihtEPOb0A9DqpeVCT6Q+9feLYGzBFjbbZBk1NoHYQEypZDT3zmHV7t4d88AHuYE26RhgEaI87E4HvHZLXoTmZA1OUHhrPeMag==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB7867.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d8046b-f6ec-4acd-7826-08df2eca0362
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 16:48:48.4767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CwA+ahRwz6qVOw2yIylHN+dTOQES3nBhznbDymRM80cQXub2tajipK61ZLuV5daTT2wH490r/zwPJf1GgW+9a5hK0GBjgq5e9Rz7MRdZmec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9257
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GLb8A9TddHAwetJZVwW-Go0yWxPq-Bsos8N25H8Kuyw_1792514931
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

QW5kcmV3LCBKYWt1YiAoYW5kIG90aGVyIGNvbmNlcm5lZCByZXZpZXdlcnMpLg0KDQpUaGlzIGZv
bGxvd2luZyBmZWVkYmFjayBhYm91dCBjaGFuZ2Ugb2YgbW9kdWxlIG5hbWUgaXMgYmVpbmcgcmFp
c2VkIHJlZ3VsYXJseS4gV2hpbGUgSSB1bmRlcnN0YW5kIA0KdGhlIGNvbmNlcm4gKGFuZCBJIGFn
cmVlIHdpdGggaXQpLCB0aGlzIGlzIGhvdyBpdCBoYXMgYmVlbiBmcm9tIHRoZSBiZWdpbm5pbmcg
YW5kIEkgZGlkbid0IHNlZSBhbnkgDQpjb25jZXJuIGZyb20gdGhlIHJldmlld2Vycy4gU28sIEkg
dGhvdWdodCBpdCBpcyBvayB0byBsZWF2ZSBpdCB0aGUgd2F5IGl0IGlzLg0KDQpNeSBxdWVzdGlv
biBpcywgc2hvdWxkIEkgY2hhbmdlIHRoZSBtb2R1bGUgbmFtZSBiYWNrIHRvIHRoZSBvcmlnaW5h
bCBvYV90YzYua28gKGZyb20NCm9hX3RjNl9tb2Qua28gdGhhdCBpcyB1c2VkIGluIHRoaXMgcGF0
Y2ggc2VyaWVzKS4gSWYgSSBjaG9vc2UgdG8gZG8gdGhhdCwgb3JpZ2luYWwgZmlsZSBuYW1lIG9h
X3RjNi5jDQp3b3VsZCBoYXZlIHRvIGNoYW5nZSB0byBvYV90YzZfY29yZS5jIG9yIHNvbWV0aGlu
ZyBsaWtlIHRoYXQuDQoNClNpbmNlcmVseQ0KU2VsdmENCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IG5ldGRldi1ib3Qrc2FzaGlrb0BrZXJuZWwub3JnIDxuZXRkZXYt
Ym90K3Nhc2hpa29Aa2VybmVsLm9yZz4NCj4gU2VudDogU2F0dXJkYXksIE9jdG9iZXIgMTAsIDIw
MjYgMTI6NDAgUE0NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQtbmV4dCB2OSAwMy8xMV0gbmV0
OiBldGhlcm5ldDogb2FfdGM2OiBNb3ZlIG9hX3RjNi5jIHRvIGl0cyBvd24gZGlyZWN0b3J5DQo+
IA0KPiANCj4gDQo+IC0gW01lZGl1bV0gVGhlIGNvbW1pdCBtZXNzYWdlIHByZXNlbnRzIHRoaXMg
YXMgYSBwdXJlIGZpbGUgbW92ZSAoIk1vdmUNCj4gb2FfdGM2LmMgdG8gaXRzIG93biBkaXJlY3Rv
cnkiLCBzaW1pbGFyaXR5IGluZGV4IDEwMCUpLCBidXQgdGhlIHBhdGNo4oCmDQo+IA0KPiANCj4g
W1NldmVyaXR5OiBNZWRpdW1dDQo+IERvZXMgdGhpcyBjaGFuZ2UgdGhlIG5hbWUgb2YgdGhlIG1v
ZHVsZT8gQmVmb3JlIHRoaXMgcGF0Y2gsIHRoZSBwYXJlbnQNCj4gTWFrZWZpbGUgaGFkOg0KPiAN
Cj4gb2JqLSQoQ09ORklHX09BX1RDNikgKz0gb2FfdGM2Lm8NCj4gDQo+IFRoYXQgYnVpbHQgb2Ff
dGM2LmtvLiBXaXRoIHRoZSBjb21wb3NpdGUgdGFyZ2V0IGhlcmUsIENPTkZJR19PQV9UQzY9bQ0K
PiBidWlsZHMgb2FfdGM2X21vZC5rbyBpbnN0ZWFkLCBhbmQgS0JVSUxEX01PRE5BTUUgYmVjb21l
cyAib2FfdGM2X21vZCIuDQo+IA0KDQpwdy1ib3Q6IGNyDQo=

