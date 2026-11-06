Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793965404;
	b=cuiF+qQVzR65cMJ2s87CQKmP7fuzo4VNPky7Ca1OkXb6F1NK+0lRnnCtU9UEhIHK0c3+
	 HO/SRzg7pBpIqCK1qwuaBWk/9bHjSipLmqUdlkHTQZghJBl1Jarb5khqEXdUN5oNPh1XX
	 OeR3mACsg1Sc1pgvix9xjm//Ms15NllNyIHztyHQNTgS3eAenvNDCyG6T/D6NTSvVyyn0
	 isG+G6FlAiWLQWtJgjRvCjEOS3HFsrEpCLiGf4+UGDJxrh/tnfZ9hoW6OSUD9+vTWwSFw
	 V6PlMKltO3qPmcpwCQlQwjbc7eNU9r1DsmYh+QqqJX7GhoETlhsH2STlqc2uuIbcItw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965404;
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
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=gnm058jVPa880DiCQJhTFXzuGqwM2NvPXZNzYQjIQKQ=;
	b=M9jzwvrVPiaiPZ5ju/lt8/AKpZKqn1jPKODK5/ycsTeFWNJDBYqSzcV4H+6jh/HD4FN6
	 YI5iP0VJ1AOxNLEp2VvKPbyZU8d8hRZI65r3Z19mSw3HqaFFIf9knlkZp1rZkjCDn8p5a
	 +vsMyJU0DHVFcGYiXa1HYYBfhjUZ8ZspEucTPIv08fqVFVMrJebbNJNms8ZJyl0YHB2Vs
	 huXBkPLcNU+SiHuH7X9x4Uy+cy9SldIkdJlDXhQJph4ttgSxX5RU7P3v2zxakEoSJhIt5
	 6O3gTaSwqJLW5pF2BKICXboLxA4s2H1lyLxzwQewcDE1kJGrEtlPIqSt45BjqUbqEtA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=dnDgBucR;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=uLDwL7yD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2745E606A33F;
	Fri,  6 Nov 2026 11:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2745E606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=dnDgBucR;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=uLDwL7yD
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AQYKL2477592;
	Fri, 6 Nov 2026 06:43:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=gnm058jVPa880DiCQJhTFXzuGqwM2NvPXZNzYQjIQKQ=; b=dnDgBuc
	RByOG4ziSxWLiDI4p5OAU0qkCsknKFoCq8M3/aFC0BvBq963WJ+ANG8IeFwlkHjH
	KRYQowe+5zFAbE/l5Myvh5DFsHBJIUPfeA/U20ukw8r8zcG3EHtr1ej1jkTK+z0i
	zAl2YC/xWIcmcSo5DYAND4V8l31elpNJibzFqafBcltnIMiS5Z5pD5IqrGCiswUN
	TpD0Q5UWjiO7u2uWAV7MZU0ACN23w8yU/t2R3XSjKoi+VHDjrBYBWEDSLrvShIfg
	rrXoBhu8vetda+QoiBmnopJSZFi8WiCwM5ytPzTgJeb7yzLsJerKuRElYfGs8Yto
	/ef5yDArrYViCVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=gnm05
	8jVPa880DiCQJhTFXzuGqwM2NvPXZNzYQjIQKQ=; b=uLDwL7yDXP0K1g70ZZyI8
	tEoa64y+wJn/ByVrchzGtUSojgiBTTOc8QpMl+RvzcHqDzlhSVdvANw5ClmEo5ni
	kc75t9Gv0Q42VE2VRpNR4eFe5WjJx8bbAlSaxrsLnbRGcpG3djuPihMLt93Bgg9U
	8Uvi3W3YSr7uXbDJDfhWQJ5iafEBBLG4eZWrNAmmWuUFtW+L+pe6j05cqwz2oI3Q
	0YL15Xr1ioAoxdfBRpSg4CWJaSKMjdYqhFZNbHOgkOobHa6Io27S9b7V0v0Ryht6
	SWjYZEpSwzgKZmW0tAGbDihKcnlx8rjK77H6bK6eVPMvzPs/NMOebpBy1p0Bn1ej
	g==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010053.outbound.protection.outlook.com [40.93.198.53])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hs3pwud5a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 06:43:09 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOVl5Ri1Io4IsVOThvqQJbRK/hsxb53a/u2zH6VQUPaNgo5TXsrMSPYnm3/ByR88daTdxUdBxIN99hAqdqXdRoPSvoyg66Y5JLBR9XNDsOxSi4bpa9J7E+E1wfOWzH1JZc3qoL2mztsAwVZgpVr121R2pSslkiWx44f/XL2CQjXLHFzjNk7onbhkBfXMmApYKYVJUhRaVlAsO7QP3CzrzmZjwU07lrPwZVoYNrFdi+A8wPFPXGQZ9xbrc/t7zceE+oW4OHOcQSe78NYq94I2n3qmLW2uEXHplB3ZKsbayk66CcuBvQSMg4kDagpZ+U6lVPbsfQTsJErnU4rVAyPPQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnm058jVPa880DiCQJhTFXzuGqwM2NvPXZNzYQjIQKQ=;
 b=L8RmS12VdUfcQlS6E1EW+sjTblb6kNlwioLn14l/U2yUXDzca6skfSjTpmCZmne19en3pUdAQmAIFuIK8cXAUGnCMMzVjTldLfpI7WbLfOImmHgwhC0ItB8HmHoiXRqCV/HeJXwacDUvruAUQrngJZnU5D+Uig0h2yB6aI95qfIldeXcpUQbz+5M/GoDik/LqZzlEp9T7EOIxxo93YEs4wVWbLTdUJrsxV+cMr568BrjibTmmY5Df8OCMCqHHuBf2mFMmv9I1BkmZ4v1D3j0RK26U9his4E/b+tjrNNDOLdyeN4KWMXS1Meayi5nwv0jrwJwavknoaz5FR2yMFij7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from IA3PR03MB8453.namprd03.prod.outlook.com (2603:10b6:208:540::16)
 by LV4PPF393250B39.namprd03.prod.outlook.com (2603:10b6:40f:fc02::209) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 11:43:07 +0000
Received: from IA3PR03MB8453.namprd03.prod.outlook.com
 ([fe80::6e03:3221:b921:9c9]) by IA3PR03MB8453.namprd03.prod.outlook.com
 ([fe80::6e03:3221:b921:9c9%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 11:43:07 +0000
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
Subject: Re: [PATCH net-next 4/5] net: ethernet: adi: adin1110: Add OA TC6
 protocol support for ADIN1110
Thread-Topic: [PATCH net-next 4/5] net: ethernet: adi: adin1110: Add OA TC6
 protocol support for ADIN1110
Thread-Index: AQHda63Wwqm7anKamU2Gwt3hosU3+bcd+YCAgAL1ru0=
Date: Fri, 6 Nov 2026 11:43:07 +0000
Message-ID:
 <IA3PR03MB84531C29DE02BFFDE950BA43F2762@IA3PR03MB8453.namprd03.prod.outlook.com>
References: <20261103160918.409701-1-iustin.stolniceanu@analog.com>
 <20261103160918.409701-5-iustin.stolniceanu@analog.com>
 <aus-LdkVRPxR6lFu@analog.com>
In-Reply-To: <aus-LdkVRPxR6lFu@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR03MB8453:EE_|LV4PPF393250B39:EE_
x-ms-office365-filtering-correlation-id: 91e60c99-a137-464c-f32b-08df3bfb202f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|18002099003|6133799003|22082099003|10067099003|38070700021|11063799006|4143699003|261026121527099003|261022105027099003|261026140227099003|261028144727099003|261102123227099003|261022075727099003|261009223027099003|261021121427099003|56012099006;
x-microsoft-antispam-message-info:
 zeoWYb3IMHFsR19RPMTyMszR+9QSAY0627nNxUaRwpq7ZD0ri48FEI/PDE1CSikON4ES6h8zbEnvP30JWl6OkPDJwylvxEnkPDE/lnw83Zr0C07OsPaOQp3TWDfaSEJfN+7Y8dhkkzOMNSQLXOOR+PGVQ5K0M8MJyHBZ8qDQTDSyI+0xchy6CHYHB5URzYa09zXx9kHCXy7ifpyUub2Kzpp/KfRpVSpsqruRZgypGvCsLJGewvi014nd8mKLLxL5nLlaEuFSoM5ZCSNQv1BTbds+LPXdlWKqeVmOeYQ42IpMsg8fBt8inixb8J8sN+iwxpBIz90/HX4GLJj2NzjP9cC2hV6utdhTo7SuEPejTf3N6/RYpIgRzyaNETtbAY3+i5T9Gxt3+/Kg+X+N9wWpS54fw54hut4csLbp7AgnoG8oZfaZcPBsP0/muOUnrlbH/os4AhxLXtTToQSwAXpti0W6LV6ZtnGaU6tbEKbx3Zx15cS2gbJK2HIWM5SWEO50QB2mnazcfK0V5pz/iRBxhTSTlOukPmQ/M7fWnPBx957s5CenORszpIjEZtT85ab7fwAE9He1QjNT4z23Hamx7KIo6yypmcIZQm5h+Fj8XXCxaK8wFPSFdl2cXbzD4Sbk60u1BZ2hz9ZLT0XXh2i5ilCkUwTEarit0NjyZ8pFknM34/fCB0oyABOrbbh7nH9bNlncHVoLcAiAspTfRZ1HH0qFoJKRBXpzcp86iD+G95k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR03MB8453.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(18002099003)(6133799003)(22082099003)(10067099003)(38070700021)(11063799006)(4143699003)(261026121527099003)(261022105027099003)(261026140227099003)(261028144727099003)(261102123227099003)(261022075727099003)(261009223027099003)(261021121427099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?Rca3Pts5GNUc+ftSQjw18uiBevtZiMN5WKW07X32uCJCbf1H9nrVt4z/?=
 =?Windows-1252?Q?4sKuAGc2KXPkyBiC9p++r/sdENNfyf9/3MrR6iupbLVBF4TaCvIRMtlJ?=
 =?Windows-1252?Q?3qqwSPwwXUDdKmZYoTiJRwS12UTUxjum6WCQfosLkLRVMG/abIGzNVMr?=
 =?Windows-1252?Q?Gxrd+P8+fQtDU9dukK7AVtmaKUjJyWa7afOtGOnPhI8MB+2O0dUSV0wt?=
 =?Windows-1252?Q?nhcXWmmlkSWVUObGFBLp+Qqyt+SgjHWqGolNJx1CcpIi3Om6IbiseVb4?=
 =?Windows-1252?Q?wlDO3dQbJkMOLiYck2LF4H3j2ygCXHSj7lN9gUJuT+539YxZNAC4joX5?=
 =?Windows-1252?Q?k88rzEMCQBjlRIan+ctTBPeZl8CioaVcJOk4vpBzazdEbSvD7CGzFrxW?=
 =?Windows-1252?Q?zOFTlVa4Hdf0NwQIHYnXkhVUKtTmWDz2fIiAXgx21CdX8OAcHSkB4hUI?=
 =?Windows-1252?Q?qY0cB4wHaHv4g7JMHZ3oTK8+hkCIUk+9vlK0CxwmEos8IJYSdn1VrWOz?=
 =?Windows-1252?Q?NXt1uKQDTk6VRaFgUYyMIuj7Pk93ogZaRE8bqy7M06blBxyIuV00qYrw?=
 =?Windows-1252?Q?9A2fNMBrouf8gJrhaMtfEJF6gynpksbmn1kUFwU8ajns9iWL3J/4bhEL?=
 =?Windows-1252?Q?bUXvbsWEfIylh55mR5bj/0S97MBQkPz7XLp7YZZZTYTd7Hv+p+3u+XK3?=
 =?Windows-1252?Q?o+Ufp8VaChv3j2qciSTNVqvp4oNmDSe5395Le950IuEq+GTugPIBFllC?=
 =?Windows-1252?Q?3xXS1SvqJQJIk82JL2jYxCQInWW7b/i405i2xK2d22gOxsxn66OYM5/3?=
 =?Windows-1252?Q?OtcfrKFsF4Puc+IO1uFUKfFpYuvCz/uMF+dRfoVGg6QyhjGTRIg7aAn1?=
 =?Windows-1252?Q?kU+EH6JzDW6DDY/dz2+/eOzffTTXrUS5dgJY6oZrBCOGwXjgvd9yiG/B?=
 =?Windows-1252?Q?40zNOqROFAThhDCHGMwq2I+8Rc+WfpBA0egVVI8eJXfeuJwYDWDsvAwv?=
 =?Windows-1252?Q?47lvKq1cxE7PHRNymkHh8JncG8LXGgHm9zIiuKZPuHiO/lZWNuQliFFc?=
 =?Windows-1252?Q?uKTnDecRQoJy/pUQFQLJrnCkudTrvXNgs2Scr9tOnEtSPChH37el3V4O?=
 =?Windows-1252?Q?tsXzPp9WMEnrA4TXwRkYHJT2cYuTXwylzWGikzZgFy+hPfm/styyv1EN?=
 =?Windows-1252?Q?rj8gje9x5WE5LNxhic4tVC4Z7rYhwBIWcQuZDQpsilBf7euB6N0NfOsy?=
 =?Windows-1252?Q?e1Uav6ZbvvTjvz6oI3Jyvpb3KggrtJVxjpgzb2yWb61XoyTERIPFacWz?=
 =?Windows-1252?Q?OzW1hGoYFs1k0TyBoe0OzjyRpusvTwNbQVvmPvkMkQy9wuP/5oRoaXW0?=
 =?Windows-1252?Q?RYv9xJvbw7tvIPUlwfm6oBfA/ic4axIlT2pYIgfN8WMLFVtUhq1ixGvh?=
 =?Windows-1252?Q?xeFgVk70mS/QJAWcd29WIS/ARd+WDfbQIUDAuJcB7yrzsXqjw6PW4Y/j?=
 =?Windows-1252?Q?LoC+Jf6NP+URlUECMBEoDKBREgBghifTXyqhDUYrvAbxIkNJtxNVFcU0?=
 =?Windows-1252?Q?xy5YIdCZnmM268KiDrCHZ+UTzTZUScIXE/nWS4bZN4DhVtkqedhWy4R+?=
 =?Windows-1252?Q?l2GoaREAEeYDG880nv5/2ZTkfmezXfTpiGxegt4ZMKLw5FurXBVrmTPi?=
 =?Windows-1252?Q?vo7sIagZOy7gLTTs0iLnRsgvG6Vg/8D+rWZ3gy6l+R7+q5r7li8khO6H?=
 =?Windows-1252?Q?BY7F5wFWQbhoyyaRyvZk3RVbt3JUiroWU5qaWFOHnYzvdY/p0q35bqpI?=
 =?Windows-1252?Q?nOXP2/IOD0Wp+1dUp0hNDktb+IzsmXG0iIJvh38ud361fxMpbGE2Garh?=
 =?Windows-1252?Q?S1OFuyH+qgoLtA=3D=3D?=
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
	pEDuOD0//OXqacGKG4BYGPALYoq2Cg8qObwzx5s9vDINAeEp3nNNKbKnzN2FcbAGXjnP1tBy9lTxqbHmkz09i9Gl7Wdx46ttVQsWJloxHXtkXT/XjbNypIM2ri3sONnaTkqAgtBXQ1QjVS1fSQBj+GluKUWRaTWg3odtK/56aRPlOaMejQJ9Y/kJi7K2YxYADMG35V2wK0B2Ia4s3iWBJhjL0CpPNdna9nYUfftxfKrUiWtibLRfmFglSmoAMKQ194v1hGoMXt4EftOSHDWVzzon6ofsBCPKld05ssDBI9ucwZnC+vpySJyY+ObLKrycJ0uYtDchtUfItK5oNLZgOw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8453.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e60c99-a137-464c-f32b-08df3bfb202f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 11:43:07.2111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DQFJZsLrplWfJZ4ptgDwI7HVhzti3L6wqVuHXRU+rv20wrw99Rv5bA4Vhbk4+yeaf/XmUJ4Q6NrKNbC1zQc/kRNPDxm9/PoHCUG7N36cghA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PPF393250B39
X-Authority-Analysis: v=2.4 cv=UYnE26SN c=1 sm=1 tr=0 ts=6aedbd4d cx=c_pps
 a=LHD7XSEJEyETsD/152cTOg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=N659UExz7-8A:10
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=_jAD5XSDOtq9-5Nde2OG:22 a=Y4KFbJurpwol_It53xMA:9 a=pILNOxqGKmIA:10
X-Proofpoint-GUID: c9U2F8gRWvoLjMEGSGhOf6kHpF-hmoLq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA0NiBTYWx0ZWRfX25y5lGrYG5QH
 wC2q5osQakKkktu7olWCqC1q9Op3G13sTgeHW1co95zO6ZNhvdQaXNoRvgVFQSUG+wHblzkBmpz
 4VhputO/8f6RvRC6ftaVz0pM5yeig27elVfB5w93jMcyzzNnGt+W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA0NiBTYWx0ZWRfX4iRSjH/ggHgj
 qLhx74LXTNAGx94WK/TLDQVfy1YXab6AQzS0d6Kogo64rQZ3MAoizTv4c4a/hksVq1op41SUznj
 52kEeMNgfgU8WiYdNcd/4xbe8auMGPa+pdtaegsCf5bTkiEx711xC1Sn7IEvJatejNWI4OqZD1A
 frIM6fB/1lmNRjg5PsjGNwyVWCOYRHeIgmj7dqykUa62UevXkbbRQ4qNNvsxuVXsAJGpB4sf16T
 it/8TKnM7rrMBILqyTQ3Nqa0QrwP+DObHbOjChJv76CLRJaTP0WLf75LU1Q4zGaG4nqM3pdyDoA
 5QPJDkh3dq0Z5n5uMcUEJg1RIt1+QPEXQCuFGIelqp2ETgfoSN8eXyRMLB9M7H31zJ5AhTXfHZx
 LU4onoQBgvV7uw60l7QSKOshyQDVoSC9szN4IGZWkX8FFGHUocxxrA1cnvnrXxeW29JWzbxcZWU
 7a+cUusU+AEaVPHX1og==
X-Proofpoint-ORIG-GUID: c9U2F8gRWvoLjMEGSGhOf6kHpF-hmoLq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060046

On Wed, Nov 04, 2026 at 03:26:07PM +0100, Alvin =8Aipraga wrote:=0A=
> > The ADIN2111 is not supported in OPEN Alliance TC6 mode yet, and probe=
=0A=
> > fails with -EOPNOTSUPP.=0A=
>=0A=
> Not sure -EOPNOTSUPP is correct, maybe -EIO or something?=0A=
=0A=
I went with -ENODEV in v2. The I/O itself works; the driver just can't=0A=
handle this device in this configuration. -ENODEV also matches what the=0A=
strap/DT mismatch check returns.=0A=
=0A=
> guard(mutex)(&priv->lock)?=0A=
>=0A=
> OK, but the rest of the driver doesn't use that, so I can see why you=0A=
> refrained from going that way.=0A=
=0A=
Andrew pointed out that netdev weakly prefers plain=0A=
lock/unlock, so I kept it.=0A=
=0A=
> For the above, it wasn't quite clear to me why you don't call=0A=
> adin1110_port_set_forwarding_state()?=0A=
=0A=
It does the same as the generic adin1110_net_open(), which also only =0A=
sets the port state and the MAC address. The extra step in =0A=
adin1110_port_set_forwarding_state() is adin1110_setup_rx_mode(), but =0A=
the core calls ndo_set_rx_mode_async right after ndo_open, which already =
=0A=
does that with the right flags. On the first open port_priv->flags is still=
 0, =0A=
so calling it from open would briefly turn off broadcast reception. =0A=
The hardware forwarding branch only applies to the ADIN2111. =0A=
=0A=
=0A=
> Would it make sense to use the async mode for the non-tc6 case as well?=
=0A=
> Then you can drop the work there and have the same ndo callback for both.=
=0A=
=0A=
It would, but it changes the generic SPI path, which is out of scope =0A=
for this series, and that path needs its own regression testing =0A=
(including ADIN2111). I'd prefer to do it as a separate follow-up after thi=
s =0A=
series, if that's OK.=0A=
=0A=
> Spurious newline above.=0A=
> Spurious newline.=0A=
=0A=
Both fixed in v2. =0A=
=0A=
> > +struct mii_bus;=0A=
>=0A=
> A mistake here? Doesn't seem related.=0A=
=0A=
It is needed. adin1110.c includes oa_tc6.h before linux/phy.h, and the=0A=
Clause 45 MDIO prototypes in oa_tc6.h use struct mii_bus. Without the=0A=
forward declaration a W=3D1 build fails with "'struct mii_bus' declared=0A=
inside parameter list". I've explained this in the v2 commit message.=0A=
=0A=
Thanks,=0A=
Iustin=0A=
=0A=
=0A=
