Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.153.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792458679;
	b=lwu9ncekjulHvK2g2PJXU5Qwb4sE7v7YdhDx77yXcY1le9zarH0KY4TrDUiQe8AkvDvj
	 dcbLiKCKVzez83VMDhdisgyp445h3HPva/yFH1E5qmpsLZ5huIZOK4u24GuwWxo0vBwAh
	 qVA6JbZD+79tqRO52scXwJpHmpWOduNmYGsBRWmbhkjtgUzMeeHkdd421THF+sdIO5guQ
	 Kj/Jhdi/6zKwoP38/m705QU7o+gdEg50O4IVhvkgq7vuCfItSckyXJ1Ig/KSeWPkepNs9
	 kftRI3Avas0Akep0Vw03TozHg4ld/ujmYnNKTswiZwTHvnL3hHe/NJ2xGJPQqrD34iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792458679;
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
	bh=hH1jfgY4mGKG5nS4TQ+SzExt7he+5/iCvu8bMPVADp0=;
	b=PWtXWgLATsfGgyWloDDVi7VEHAIKN/csmMV6UVxWOVF8N6YBjfkHD+yEiW4X498i0QfV
	 hV2yU6LOuLTzdVjItTwfESHaHPHt2oSYjPygtutCH0iP78U7yHe0o/L2xUB6/uhAjGPeo
	 niqUcJmdH7BYmNNj5oodvjwhRHa9Go/Xs3gRrMqwoXkyAaLp7Sy1knNM2V05F6cA30kkw
	 O5s8qexL/HPJvdHoumxbUfY7o+2sN5zVw7oLd2le1lhXA94dc97IGi4GVA1THBaO3LfvV
	 RyDDaXDq0NANT8pgKUqBsknNck1LP3tSg/eGP8eOwsTqN0LgIbNonjGPs7mKHB330+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=onsemi.com;
	spf=pass smtp.mailfrom=onsemi.com;
	dkim=pass header.d=onsemi.com header.i=@onsemi.com header.a=rsa-sha256 header.s=mimecast20250127 header.b="Iiw49Vq/";
	arc=none smtp.remote-ip=170.10.153.120
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF2C606A31F
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 01:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFF2C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=onsemi.com header.i=@onsemi.com header.a=rsa-sha256 header.s=mimecast20250127 header.b=Iiw49Vq/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1792458678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hH1jfgY4mGKG5nS4TQ+SzExt7he+5/iCvu8bMPVADp0=;
	b=Iiw49Vq/fbSwdF416hLC5O0Kg+sNx+41rzuIdyFjywyIGTYObMu38Lk7d+FoP0IwPTOyh4
	w1tO+qeRVv+lODkk9RB/B8AfXedudPp1OsRHYv/NfI68tc403Qht4FWWCsdhg5az0nnC7V
	8RYfbyXju6yGdz/mMO1iPgUBUqu4rWC6E34J632foXM4+Uo8QZeDHQLEzan+396LbGRByA
	ctPE+m9oJxTgWm6ZOjdMNpC0NaXTbVYcJ03dECK/CsOw3bZuDmnDaCoewlt7JxnLwLqQie
	Bsi721dv7ur4h7OMgHOOheoziEJTPDjBPacC4FKmLw9BMcw0mPaxo5z5XVTxXg==
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011020.outbound.protection.outlook.com [52.101.57.20])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-52-Ovd9-fAKPsCSVw2NmGH4dg-1; Tue,
 20 Oct 2026 01:11:11 +0000
X-MC-Unique: Ovd9-fAKPsCSVw2NmGH4dg-1
X-Mimecast-MFC-AGG-ID: Ovd9-fAKPsCSVw2NmGH4dg_1792458664
Received: from CH0PR02MB7867.namprd02.prod.outlook.com (2603:10b6:610:110::22)
 by IA5PR02MB11979.namprd02.prod.outlook.com (2603:10b6:208:60b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Tue, 20 Oct
 2026 01:11:02 +0000
Received: from CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e]) by CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 01:11:02 +0000
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
Subject: RE: [PATCH net-next v9 11/11] net: phy: ncn26000: Support for
 loopback
Thread-Topic: [PATCH net-next v9 11/11] net: phy: ncn26000: Support for
 loopback
Thread-Index: AQHdWBFk4vKz7fck/kCnIA4lIBK+1Lb3LkWAgA6AiiA=
Date: Tue, 20 Oct 2026 01:11:02 +0000
Message-ID: <CH0PR02MB7867E0C12D98C0842ADF94F883672@CH0PR02MB7867.namprd02.prod.outlook.com>
References: <20261009-s2500-mac-phy-support-v9-11-dcefe1d0bf0d@onsemi.com>
 <179166122916.434549.9063503265267082319@kernel.org>
In-Reply-To: <179166122916.434549.9063503265267082319@kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB7867:EE_|IA5PR02MB11979:EE_
x-ms-office365-filtering-correlation-id: c7985139-d7d7-4820-61a5-08df2e47022a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|22082099003|18002099003|38070700021|4143699003|11063799006|261009223327099003|10067099003|261009221727099003|261009223027099003|261009221227099003|261009220027099003|56012099006
x-microsoft-antispam-message-info: IQnFdCgzKDY9qeHkCP6MV3IFhpGYE6HXPOMfmSCxuZRJ+JkFTRP3oEqpjSnAPzhjbOf+zp3ntjbmgrukWfoD+aVG2KaSzaveE4ygBizUvTXOd8ZxLZp7kdpJZ+ViwGNsMDs+afOd6rz4lZl3KVU0QgMaJ8pD1Z4eTIf3s2eNJ2lEoLx1NTpZ5O3kga3cPyLQCNQaWHIY+Y7kMvwPIx6LU3uRPPOOceI4FuDwBrxr+aEbggXep0h2LHgi/jX3XRU6Mh6yzE9zTAf3q0tSrMm58drbqMXk0BrMlxkhTvAKJ7Wu7mwHdQ+tqht0yh9WkaO2BrZv/wDxoWImTY9/Awg7eXZnmGRP2xWjVfsdpwhcBeXJJ99Y7XfC6iAcbqU3nfcv3fP0xsFPccSO1TbcHkXJ35mK7dHM9lF9YyjmKIQpBOX0TnEF3eQpCVbcaRvzXOfpSk/5KPtstYgJVvkcshS76qa6KC6fBdg4OpBFwd+GHmOjTy+WPiPuwcrCtDOB2XI9oNBOoqT2GfCbqU/Q/qwZS6gZSFzVqnklXgg4NiNKrshlh6Soy74pDH2kXb9N0oU2Zlise99Nh/glWWQokHRDlnmjSLO+iqXrJpJljim3RIJ92bGeMSr1axFxbwWufKPG42cgSKXhequ9Sa9BHTnTPn9LxB2edxM9NQhfagaXY1K0nB8PnWnscSLt3oguIHLYfFDChzpyVR7GJm1h40KZiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB7867.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(22082099003)(18002099003)(38070700021)(4143699003)(11063799006)(261009223327099003)(10067099003)(261009221727099003)(261009223027099003)(261009221227099003)(261009220027099003)(56012099006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3RUNHFLclppc0tWcW1NMXQvU3NFU3RHM3hyV29GNHpQWVdES2kyTDYrck12?=
 =?utf-8?B?N1hOWEJmUVFGcktIazl0azVnUzNpRmo2ZG4wb08vT3BaU0ZZZUFCa0pYNGlr?=
 =?utf-8?B?a3I4dmpkeFZ5WmVzQm0va0ZXTnEvU1lZeTkrdm83czd6VXlFYklnMkRaQkln?=
 =?utf-8?B?b1VzYTBhWmpSZkZ2dS9jVEFJQ0NscVJGR0JwN05QMXdIamZac1Z2ZTdYRzNG?=
 =?utf-8?B?NzVyN1A0YTVNZktIeTBQcHRwYmVGc0JaMldBaG5EUElCUUZTYWVQUkNOTlA4?=
 =?utf-8?B?eFZ4T2N3QjZFUTAzcWJ1ZlhDaXNWZnVETnVWRkpoV3Bic0E4L21Sc1hSYm1u?=
 =?utf-8?B?cWJUZHdqcno3dzIyc29PL2tuUlh1Tk9QRUV0QVI1SGgzZXllb3NRT2lLa3NV?=
 =?utf-8?B?eSszWVNWOUFQSlg4U0NvNlJCeWltRFB1RmhKTGdQd3UrTlhIUDZibWxGb2wv?=
 =?utf-8?B?a3hFRkZlU1NHcGxldDhUVnBXazFUR1M5TWQ0VWR2YTRIaG1YWm1hQ3U0dmxY?=
 =?utf-8?B?WmNpQ0pHVTVpd2VYZHRBeS9vS05DRE5pcUtqZ1RUNi9RUEJIdkRyd0tVSnp0?=
 =?utf-8?B?TU0vOWxtVTJ2ZG5jTWcxbEh5bGJEMVVXc21ydWg2QnpMSGV6aFVhSENpcUdl?=
 =?utf-8?B?ai81dGZMSzFHSkhTN2N1Y3JiSTlwK0ova3pKVC9ldHV0Tkx3T1BMWlMzM3Jz?=
 =?utf-8?B?TWRhM1VjZTh1T0VoRnQ5QklkNVNUcDRLZTNua2M0SnRDU2w4V0d3U3pwNGRn?=
 =?utf-8?B?L2p2VXhHZTN5cWQvR2tlSTUzUlhrd1lUdzdnOGpiQ3JoUjNqQVYyM25sSDlu?=
 =?utf-8?B?MW5DVEtPbTNVSFR1UHNqaDJUSi9kWVZjVHlzRmc0Sk9FUWFBQ2ZYRkl3QzZV?=
 =?utf-8?B?OEpCVjVyWXB6WUV1Z1pHQTV0K1lqakNGb0pETEJQOFU5OTl0ZmpmM0hqRFh1?=
 =?utf-8?B?RWRZNFBDQjJ5Q21rdndPSmlqVUF4QkhkditUVjVWYlVFY0RiT1A0dm5PMlJD?=
 =?utf-8?B?YUNEVDNVcE9UWU84Z2RxeUpBaU9nNDNkaUZoTkhkc2hyQzUzR0Nvek96RnNH?=
 =?utf-8?B?a2NpTlpHOHlqaW1zOTA2b2YrVGcrRkNJc3B4Mnc1eVJyVlBicURoUWxGZ2dX?=
 =?utf-8?B?K2ZwU3RVZGlUUkk1KzB0c0s4clFOQWcwVE50dCtmMDNXdjN4MmNsc0x0OFBF?=
 =?utf-8?B?c1ZxWUo4ekhsMUlORXpnbEpGL2QyYWttN1FNbGxvOUdZY3VCZlVHa0xNWkR5?=
 =?utf-8?B?QWMyUis1UjNCOFpUMlRTcy9zUDg3ckk0TUx1eDJNU0FjMDZ5MVNpL2xGZ3cr?=
 =?utf-8?B?ZXYyeGNhS24wWmViSEpqck5Xa3ZmalRmSDc0MjBadnhPT2N2MFpUN3Mwd3VH?=
 =?utf-8?B?dmgyTTNFOHpsWjlDODYvNzJsdy8wSjB4R09NeUtwSE0vZ1FoVHpCZVJrMlNZ?=
 =?utf-8?B?WlNTQ2dVWFhzTlRHaUZzUFdvNWpLczVsWXExTURzRUExYm82VldrWWxDWThS?=
 =?utf-8?B?by9iVDVPYTVzQ00yMlkxTDY1YnA1TGsyZTFXVUVsNmhTRFhwM0c0aXJFNERQ?=
 =?utf-8?B?c0tZSzJUREdwRzF3VkJ3bGs5d3VSVG5kajNSazJkb0diTkt5QjJ2U0RvR1ZQ?=
 =?utf-8?B?bk55eW5vcDdiNVIyQkhvT1hKM2pRcVI0WGNrRG52b2pjUjNOM2RsbGhWWG0z?=
 =?utf-8?B?NldNWjVCSDNRUWhTMmJiVGxLT2xHM3pveXovZ2dhYVdpZ01iU3RxV3FaV3hK?=
 =?utf-8?B?VVNxRlhnTXVWYXlDalRKUGlQM2ZjQS9uaVhYWU5sSHEwY0JoTEFGdHM3M0tk?=
 =?utf-8?B?SXg1cUJFdEwrZmtJemNaYUl6ZEhRdXA0a2QxdWg4Y1c4RWh0SE93OHdCU2tw?=
 =?utf-8?B?aGloK0ljV1gzcDVCSDhvUm5yOE8yaUgrQ0JITXBtbkswRmMwZXFNNWxkQ2NW?=
 =?utf-8?B?aVBlQXpvbytJVEo0V3hXMjFBY1RpQlcyRHk5UXdVNWxXakF6Q0ZGK0ZlMzlV?=
 =?utf-8?B?ak8vSGl1OWZOTWlDb0hFZERscjd3L280aVZKWVYyd3hlTmdVSW9zYTlsS3Nv?=
 =?utf-8?B?MkRucnFvSzJCcm44R2JzWHg4b3RlRmxBMEZ5a1NqSHRsbTM3blhkZEIzTXM1?=
 =?utf-8?B?ck9SL3Q2d2k0YmEvZ2Q2Qlpob3lSWEN5WkNBNkQzRThFVGtxaGVoTkFjMlQr?=
 =?utf-8?B?dmJuYy85RkZ1OWJ2dDc1TGpNU3pvWmhpR09SRndGZWplS3BJdzJ3aEJGdHQ5?=
 =?utf-8?B?RElRcWhXbGh4OERYb2o5RlEvbFRieEtZVndkMGtGN2YyaElPSGxDMVVScFln?=
 =?utf-8?B?YkkxZlQrYjFEZGtMSnh5TU40N1hJbk5FamREdVBXMDFSRzZnSXl4M0JLK3FY?=
 =?utf-8?Q?/onRi/TEsC3hLCs4=3D?=
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: enQcfpBCj9FCAMLHhsIPxK/kan9BoYxx9OfP2axrC7vfRJpgj9no9IgFikA0fgRCkF++WVD4bovMLI68whJCMgyKb0o0Iy/38FuEslxVox9PFhzv+Nu4bWLokgI5VK/j+fy+EefQCN05rWjacYWNM7Wx2B3t5qB5ekZiza1QyYJyoj/O6BT/U5Nr8cPqZ4z2TX/0mt7mx1B21ftSSzS/geR17uPJ9aN47RmLZdj0pjRXn9KFt/NERNKdMX+QVrBVY2ZTGZ3gdS5H6t8sBjfiOoMY53aaskiMvG2gmBHmSHp9XCxR1OmPmMnLW9HVd+W7e4pGl2QO5/zQtaHgELcTOw==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB7867.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7985139-d7d7-4820-61a5-08df2e47022a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 01:11:02.3447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kLrtUOBoXbYjikWddDRkucbsW46V6FyW3mUejV22uACjlR7xiXkQhfI861lAeObMWR/HHHoUkUFT2TDbdmEx128FYJFux5jlVYqNuLrdJZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR02MB11979
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: m8Q_d6XAWKzhLcrRdYyYlM2OIpROhk7EMb7GIL4dqzI_1792458664
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbmV0ZGV2LWJvdCtzYXNo
aWtvQGtlcm5lbC5vcmcgPG5ldGRldi1ib3Qrc2FzaGlrb0BrZXJuZWwub3JnPg0KPiBTZW50OiBT
YXR1cmRheSwgT2N0b2JlciAxMCwgMjAyNiAxMjo0MCBQTQ0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IG5ldC1uZXh0IHY5IDExLzExXSBuZXQ6IHBoeTogbmNuMjYwMDA6IFN1cHBvcnQgZm9yIGxvb3Bi
YWNrDQo+IA0KPiANCj4gDQo+IENyaXRpY2FsOiAwIMK3IEhpZ2g6IDAgwrcgTWVkaXVtOiAxIMK3
IExvdzogMQ0KPiANCj4gDQo+IC0gW01lZGl1bV0gVGhpcyBwYXRjaCBhZGRzIGxvb3BiYWNrIHN1
cHBvcnQgZm9yIHRoZSBTMjUwMCBieSBwb2ludGluZw0KPiAuc2V0X2xvb3BiYWNrIGF0IGdlbnBo
eV9sb29wYmFja19ub19zcGVlZCgpLg0KPiAtIFtMb3ddIFRoZSBrZXJuZWwtZG9jIGZvciBnZW5w
aHlfbG9vcGJhY2tfbm9fc3BlZWQoKSBkb2VzIG5vdCBtYXRjaCB0aGUNCj4gY29kZS4NCj4gDQo+
IC0tDQo+IA0KPiBuZXQ6IHBoeTogbmNuMjYwMDA6IFN1cHBvcnQgZm9yIGxvb3BiYWNrDQo+IA0K
PiANCj4gW1NldmVyaXR5OiBNZWRpdW1dDQo+IENhbiBuY24yNjAwMF9jb25maWdfYW5lZygpIHF1
aWV0bHkgdGFrZSB0aGUgUEhZIGJhY2sgb3V0IG9mIGxvb3BiYWNrPyBJdA0KPiB3cml0ZXMgdGhl
IHdob2xlIEJNQ1IgYW5kIGRvZXMgbm90IGtlZXAgQk1DUl9MT09QQkFDSzoNCg0KDQpBZ3JlZSBv
biB0aGUgY29tbWVudC4gQnV0IGZhbGxzIGludG8gYnVnIGZpeCwgYmVjYXVzZSBJdCBpcyBhbiBl
eGlzdGluZyBjb2RlLiBUbyBmaXggaXQsIHdlIGhhdmUgdG8gc3RhcnQgaW4gc3RhYmxlIGJyYW5j
aC4NCkkgd291bGRuJ3QgZml4IHBhcnQgb2YgdGhpcy4NCg0KDQo+IA0KPiBkcml2ZXJzL25ldC9w
aHkvbmNuMjYwMDAuYzpuY24yNjAwMF9jb25maWdfYW5lZygpIHsNCj4gLi4uDQo+IC8vIGJyaW5n
IHVwIHRoZSBsaW5rDQo+IHJldHVybiBwaHlfd3JpdGUocGh5ZGV2LCBNSUlfQk1DUiwgTkNOMjYw
MDBfQkNNUl9MSU5LX0NUUkxfQklUKTsNCj4gfQ0KPiANCg0K

