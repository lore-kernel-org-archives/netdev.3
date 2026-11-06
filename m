Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793964317;
	b=JD13DWidDHUxR3BQSXmLzSrdg7SyOgXEjLvRmbShXjPcAITQhZyrw02NwC8K6adNBbSJ
	 w/McubEb3RBFhf+lro/m07jUnlSK24xKCNbSEr5OsjV8F1dhB7Y3BtskntvCmQxEGaZZ7
	 TWiYepu8E5p3X/N9rbMaLy+txGumYdm3fKb+oG4qGXIpPXSdN+Fj+yxD3NPbnnBlLLQ5W
	 OdHzPyuCBtQ9Wy+NoX5tw8pvWVI2WNBJM4X5t/cIs9RyKW8KMWWcqvBt97g2TtKrwIOtc
	 6JHJ0ffLz4Fmt1PFoCvpm0TMkY2goaJuyAc7XL8ORtBTY3gbiqMwXiv2kYnjDcwvuUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964317;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=SwCghQmuWgM9uE/ZvatBcq4E+IZnUTHNJiQ4IFtKwmw=;
	b=rtBHCfs7a3ozRSWaoTMFYTKdw5EuVc6Id8FsqTcx8ZlJwWthqqi3DmRPRFX6Z5mlxWDN
	 WRP81/ReBABMy3BfeQ3b0Rf7+E0Ugz31ttpG+9yeqlq4NQ6SZ5Gcf7pYabxmBow37QYlY
	 dsSf6kj+SihCifl9IOBiook7Xs3T9WTTNF70Znm3Lord8YtYcDaauw1aDQnpmTlwPtHjV
	 MGRBZTO5ZUVWznevBykRYObrL6nudulPdhHSUeG0w1KpH7npzwXCC3QcpaW2Gc9XKx6li
	 OcwBLRPAy4Dg960vovffkBOm+XVdWpodcXbF1oNBX7Gc0f0VsCwT5zZIQmpPLo7BgNg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=JgW1O6Ua;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="Ar2hCf/J";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35BC606A326;
	Fri,  6 Nov 2026 11:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A35BC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=JgW1O6Ua;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Ar2hCf/J
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AQOjw1924936;
	Fri, 6 Nov 2026 06:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=SwCghQmuWgM9uE/ZvatBcq4E+IZnUTHNJiQ4IFtKwmw=; b=JgW1O6U
	a31QUz4OjsQdhLlB8DcxjBMTF+A8HhVNz1wvnH0uwWff2seq5MOJZ4Vjj/FSUUl8
	qlEJwt3XYUbrqg9ZAnoQZ1yFnpZZpjI6BcJSAjA+iFeqnJN1KV/u8BUl/sh7a0yL
	I9dpDrM0wip9tlFEyHlx4UIwE8ZCT46fOrRPbWYrd6rW0yKeDvot+YLBC8vqAIFG
	xpV/HAM3+A0Tvnc3Y+gdyNkSGgn16hbMuNIjPhjhGEQurxRkXJOPLN3H775BNTHq
	MLELSz5dbbG7HGlr2HHZmbYV2Ao3H26aGEhI+PyEcKTpY4SHD/KGezWMjkJ7awcJ
	m4IB0yFMftU10Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SwCgh
	QmuWgM9uE/ZvatBcq4E+IZnUTHNJiQ4IFtKwmw=; b=Ar2hCf/JFg0wNEZVuGLwe
	AtkpD4wAyVcGd7bfMayEEgsXNG0S/PD9UPtcRZgt6YIjKa0VepTykNjwLdxfzSqy
	eOtrLl/L9mTUOo99uX1GibKyJwxGMFudBJn6K/Bf+Ss4G3FekxGkAGzoIoTBbAeX
	PLTgT18QNMpdQhx0Afdbg2nlwo2OKSDQwq63YTUUL/lZ0Pj3Q3E6rmq81sczFncG
	azp9ShDA7f1Z+1jy+7QdeJ4jCHHwuNLqRWvfgjWxkPrhfmRx8d8amLpkmdmVMU3c
	PUjXeIsYfSDwJcE0bxYtcFBDFw0Qji6cuXN85fmUc39urSNiECVgD+ACXXHOzDun
	A==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hs3pxu7qj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 06:25:05 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zaqtlf+BTaFcgqj+MZMovl0lzBKx5PGVfs+gj6nH13HjqpPIulkiuVr3QXejzaP9Mx9xALKdOJ+mRYcWGDJ5u035+V94LaWZPsH5j+qKuj75iKnRKHJDs222FUjA32KbNnr99zQf0pj9ahqBmWA2nhTKIXkJj3w2V5Gu79x2tmRVy4IFld00l7a00pCivvwE2lvbw/QkitF+oEpTkpXMoH8Fa9UZlXqFyVYEU2lKt+wXVg/zLuK5lX/MBPSWuBZNF/+cnFN7S1F53w9bgUBqBSUVoWvk5LDVWhQdkYnZFHI2n/hmbhDCCwn14hl3J42iq3VVEVX1/r3gxznW73CsrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwCghQmuWgM9uE/ZvatBcq4E+IZnUTHNJiQ4IFtKwmw=;
 b=qLBXBmDIEqvvYEFgugelhJ2WAaBOfM7YeqSWyTMTj4xPCL/GhIiVflK7w15aZ5M4uYRKTfYgZiTyTH3LuelY4d/LbMLrZDpBcYPYh+6l21+/hLDQFO+RbDOL1SMVCR5sVmQ8Tel80zI19SF+VfyjzhEpt+q7vyouVdeHyzVyVwcRiOB5eorKXbV3uUOQumzKAI1+AQ3GBtxmsNSA22UxBy4HZP4fEZJBQDXajzfjXviHbrm0Q/blMSopIyYnlic3Mu1SdletvWSA9RH1R68C+BRGhRU9FD8h0XQRLpsjancjLX0m3A6L9BLmWAj1po5MDphyarT3Pn0omvwgBgS5OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from IA3PR03MB8453.namprd03.prod.outlook.com (2603:10b6:208:540::16)
 by SA3PR03MB736295.namprd03.prod.outlook.com (2603:10b6:806:53b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 11:25:03 +0000
Received: from IA3PR03MB8453.namprd03.prod.outlook.com
 ([fe80::6e03:3221:b921:9c9]) by IA3PR03MB8453.namprd03.prod.outlook.com
 ([fe80::6e03:3221:b921:9c9%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 11:25:03 +0000
From: "Stolniceanu, Iustin" <Iustin.Stolniceanu@analog.com>
To: "Sipraga, Alvin" <alvin.sipraga@analog.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>,
        Heiner Kallweit
	<hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "Schmitt,
 Marcelo" <marcelo.schmitt@analog.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "Regus, Ciprian" <ciprian.regus@analog.com>
Subject: Re: [PATCH net-next 2/5] net: ethernet: oa_tc6: Add support for MDIO
 indirect access
Thread-Topic: [PATCH net-next 2/5] net: ethernet: oa_tc6: Add support for MDIO
 indirect access
Thread-Index: AQHda63O0QobK3HJvEK5xdwIguclm7cd9ImAgAL27+c=
Date: Fri, 6 Nov 2026 11:25:03 +0000
Message-ID:
 <IA3PR03MB845350976599F1F6C41EA096F2762@IA3PR03MB8453.namprd03.prod.outlook.com>
References: <20261103160918.409701-1-iustin.stolniceanu@analog.com>
 <20261103160918.409701-3-iustin.stolniceanu@analog.com>
 <aus8GQ-Xut5XBNwU@analog.com>
In-Reply-To: <aus8GQ-Xut5XBNwU@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR03MB8453:EE_|SA3PR03MB736295:EE_
x-ms-office365-filtering-correlation-id: cf0e03ff-2261-4df3-bfa0-08df3bf89a1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|38070700021|11063799006|4143699003|56012099006|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 2leC0oR7/Z58XzuEM7JvU5Z5UFQhqGeuCL9YdV2TqOJ1JfmJnt8Q7UadR0zxHaAnyz8GWRdPwwfZMgIYZJI/oRYNUdmutS3gXx5iMzV53hVsOLTGwIQDvZl7P5vHxXovVv2qxVDF5qfX8K/JuJPLXIgC214zzgZgS8pkjyFBfKkWsC76OxPNkHRvrXoyA5hC1g4Acb4Z9xiycjxK3XHjWDvlOlIHTLEDmROw83YOnzTMWLwZT+RMSvEZhmdJFdocOk837mhI7RiK6H63PwlCDzsKnDPCdfkx4dhozgjOmqMbS77BiJloHzrJuZFQncbnWgn6Tam0AcDwKofY/r7H/FOB+e/s0+HtMN3Tr3b70GtHYx81HmHdEcX69ii7haxwJnt+/Dwuf/rdPcJiM0k11jgKzjLtLd+R2qdW/zh070n2a8DM4lz9+VS4KZ1aMSWNTWBYYgOaeaLruXI3uA0WGNNCCI/E8cCeIdXiea/VkL2uzflSWVs6ge2OP308vhz/hHNzXeJhifuudaZEQaRou9BAqGH/rxRe2ZWo7zuAFOFOYlurQ4vNX61coTx0Skn5EicANDedU5Tb++b41OKL4gFbCuLfcBhtYf1YxuzQ4I+RkKi0BBwdX0IlqWxY86agvDTIcTUybNIXqNN9SfyvSjWiTq+a4h2OBDZYirRzbiQw/PQOhCK4ZrPwdRN1DopNT3HeSDVbGSkDEznDP6czdoXpgyuhRohy/CqFZ87hFtU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR03MB8453.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(38070700021)(11063799006)(4143699003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?+rKYeTAdp7DsadBUgjdZ/zVnUcOoKt2FSvX1zkOHXQ57fhM2N3jmBo7Z?=
 =?Windows-1252?Q?b75hzG1WbPiNHwvVJePa2u5iIq1gH11lnJ4Ybf6W23L5hYJg7FoXdy0G?=
 =?Windows-1252?Q?CgCrQ4Giq8uGP3RXQIMh1qkk8TnNt3FsUpAjK4C0oSbzDpEW/qn9JLYV?=
 =?Windows-1252?Q?1He7MaDPJkAt/Ju+P4GFhxPcjnfjURESBqJzRIgShDG/Nr1eJPif1jbt?=
 =?Windows-1252?Q?4NrV0G6HdQzKC6IvUqSpGBijYmDcMJTljQTV0n7zY1v7DSWZPxggsQwW?=
 =?Windows-1252?Q?5RHxDoHoQbzA3pJ0RKCvCXEK53yrIgdsbktxWZCnuZoXGyqykfH3hObI?=
 =?Windows-1252?Q?ETYq3zEcBs/oht+NgxHZGHqzDx5hEJk82FnP4jkVMJM3xg/JDou9ZgTZ?=
 =?Windows-1252?Q?2lbp/BL9Iu2XBIQIezY8Opl1nvisoqLN1lpruS4KLxeaj5iLHxoyNVv9?=
 =?Windows-1252?Q?RL3ONKNHABQKO6Sp93G+fFN6iFfKPh3+q27PkTpGQEZJ+QTmh2xR3BNH?=
 =?Windows-1252?Q?Q3mEq2Qgw9ssblHYNm3/SfZYAb8F+PlldnRden6g+bNniPYdYtnk+R2A?=
 =?Windows-1252?Q?UE/AmoZ+QnD9hYCIef+N2AFrc//kAIU/NK+FGG3Mu8DEbQ7feWKeXlyS?=
 =?Windows-1252?Q?CUiC+R3j9e1sWe0kcAMvdHmeEjKDiSe/cquTFyYV4z9Pu3w0hciwTb6o?=
 =?Windows-1252?Q?s/BQJrgOdWvzF8PeCFVjiL0UndEIQg7PCUTHE03S8Og8YwsRlf/1U1XJ?=
 =?Windows-1252?Q?jg+8l5Tek67BYuj/hqgX9UYNpuKw+VIXskusku0wEfF8Jm06YrhLdRWF?=
 =?Windows-1252?Q?4ZS/knGXUCSfYrT8NnyG3N6+JIBib3nMzNSpA8jCxiiREp2n3IJVMN9l?=
 =?Windows-1252?Q?qikDu/li+tJl29Xm/zvsmDW7TLdP26jfVKMbUYEuMcoqrJUVoNPqi6xO?=
 =?Windows-1252?Q?6WBgUSXkMpbWTz7VKhvVGVQq2AKFA6XrMSbEy+Tka7epZuFiccRRTw7/?=
 =?Windows-1252?Q?DUfX4wbdDuJ49if7SNWF9XYsBRy7kK54GWBVsrMudLT0wJHgD4A8PZvu?=
 =?Windows-1252?Q?1bj7NOaWEfg8knpdg9U2zHfIuWMzvWYGI9L/sFiOMZzx4neO4o1eRfQU?=
 =?Windows-1252?Q?hCRDzLZBQsaQTatMFtZQefodXnH4qQnX6i3/qwf0SrFPFK8JMQEROwrW?=
 =?Windows-1252?Q?vsoKg94V4oOo1fddWlEDp53thGI5no/0FIew6nSQipdkr1XEBRmFupba?=
 =?Windows-1252?Q?ygd8g+OdMeyPxrI2OTp/K9CgE44ILrk5KDHfbwCp6W+FfFadX75GqdMO?=
 =?Windows-1252?Q?wZI2B/jXJ4yataSOrxf1JhlxeUwHJM5HT+UIxzlHX5//ScDqXseSjDwX?=
 =?Windows-1252?Q?sHqjqoD4/dnDPttujqCmjMhb+Ci5ZcD5fx/kfDc+2gzPeImJQ01o24vM?=
 =?Windows-1252?Q?HrBNILJvBFzVr/jmVCz6mPIf+0G35/2LWuEi9YR4HkK21p8O7u6vnsgh?=
 =?Windows-1252?Q?fWtDKKN6wmPDJ+9+43XY11YNpXs/t33A98tHFrUsTq+kQC2P/2PXOveD?=
 =?Windows-1252?Q?/5l6UTPH8EYOBccUjGtJZCyaeE5Y2ERbwKb00qrmeB2udhMw7wk3pXf0?=
 =?Windows-1252?Q?ixfplE7gdQQ0cRXuDmnAr7JE0Ol7ixP1UAm6SzDYb+UYFQb9R72wCdcW?=
 =?Windows-1252?Q?WwRZq+sKweRgGziyBHc9nm85/TR/VWVh1KKomvS3M0qAcdpKolbJBH8t?=
 =?Windows-1252?Q?raEuW6zLyegA0BbCWAXEDITH7KhG7Z71gAR1mRiqUkK8Db8hTAE7YInS?=
 =?Windows-1252?Q?99mvMfsDl4VZRxcv90Y8hPGoYqFVTAyVZmHrWgDLvfppdIIe6Y1J5A06?=
 =?Windows-1252?Q?H6n6vP+hhku0QQ=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	xr4mVuGkvhYL9Uquc2ICC3oTnoOM6nNhn86WRLSBU0j9t5vltVE4yZC6sxwaTub49AOM9DItdV0V70PkpBZDjgoqW9t6rqvAFBzLmnKuT5wuBcclEJK2OyadNYt1Qv84Mf86W1vd9XJSYLwcnvQqYXrcMqTLbq25xusQdLPbqwtACpuJ6K0IfkSYK/kA9IUs6x4bGLohMwUnjtECQ8OFMqa7cVWbg7zx3mg30cXHvoXGWIBhrMjCytDXEIGpvTPl568rXVsmkckdcpWN1YV14Vf2AMXYzRHF/U7xaTI+zZH6lYU2UV5tEesjHTC1UFOEmHRy3x9X0quiY5kc+1/g+Q==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8453.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0e03ff-2261-4df3-bfa0-08df3bf89a1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 11:25:03.3094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MHFc3YsW+mHmc8ypMp8EjlE3HhdCcuzdLtnrHieyCmzO/IUa1RC4hVURdSWuE6lTcmGGEZAvqKUUW8CLJU+zpJC2jeD53afysdNh7/s9PrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB736295
X-Authority-Analysis: v=2.4 cv=DOQacCNb c=1 sm=1 tr=0 ts=6aedb911 cx=c_pps
 a=eZaJmiuXqmfvnt2b4sL4XQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=N659UExz7-8A:10
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=iZSIUCweCk2Oy3QsdGPA:22 a=f0EDR_dgbw-FTc22wjAA:9 a=pILNOxqGKmIA:10
X-Proofpoint-ORIG-GUID: VqP9uaFutEJZklvpcNq1pakkl6KruDtI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA0NSBTYWx0ZWRfXzdFdQrFELhEy
 icKOj4sEfEACB9gZJaQ3csxH+VwpC8ZMN8/xTu2kbFvPhcXk158BXFSxYvk72yhaoGRkHya53ka
 br25glH6VbBKsg+TLIX8z63QYY1t4qjVKiDnFHv2d38X4/N0+evWXgyzCMaYcXIheFjk+KFf1VF
 pds1/W4k9NlYXdqvR10mQCPjru6iQANiJpAqZnoG7qtxd5aswaNR4xChLyPlIhiNCp1uPF5guDf
 mxd2G8dlE7Ft7n5NuIHX/1NqvOKk4pGowPMiVsmP6cKW7gXxmhi/jNIG65A8nKdUBbHvcT3Bu+H
 9b+/tFFwOSxW9mG/Jj97IYtYoyQi4dQaYayiGAEb0kdyIwF4MHmecLPP7KCFo3+ybUqJOe70Pfr
 vQNSn4QMKY9Fe76YWz3p/Qw5NSzV3xFbgx46e+FBuDB/z/3c9S7Bx9bbd8KxYjtFcSCydie8Hdk
 drXR1uctEVnCOXqe6dw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA0NSBTYWx0ZWRfXzwdZsnRCBQ9A
 FY4xVwuOoBHVUvioViuJLOnWC4dpfplG8Qb2HpYPOQykChlT6toT33TsbtrHlBkjfPoYxGb7Fy3
 rDFmeVaNxrtnbcu4Q5yLdENEvj9caSsyZ21oCuNjE3/GLOGlwtcq
X-Proofpoint-GUID: VqP9uaFutEJZklvpcNq1pakkl6KruDtI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060045

On Wed, Nov 04, 2026 at 03:08:21PM +0100, Alvin =8Aipraga wrote:=0A=
> > +	tc6->mdio_indirect_mode =3D !(OA_TC6_STDCAP_DIRECT_PHY_REG_ACCESS &=
=0A=
> > +				    regval);=0A=
>=0A=
> Maybe just if (xxx) tc6->mdio_indirect_mode =3D true?=0A=
=0A=
Agreed, it reads better. Changed in v2:=0A=
=0A=
	if (!(regval & OA_TC6_STDCAP_DIRECT_PHY_REG_ACCESS))=0A=
		tc6->mdio_indirect_mode =3D true;=0A=
=0A=
Iustin=0A=
