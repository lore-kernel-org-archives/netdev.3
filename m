Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793964215;
	b=BMlNoMH9DYzaW60BnXIA1ESa0BXRxvBwG/+QJJgQ20AdGXck5Fz81nl2iAZYEi9VMrZ6
	 sMDR7wd32Pfkr0U8rKYSydh2asBZhthxI0xlowNjUEFDZKye1VqMP0UTsFDIdwZBydhOC
	 ceWHDYc/1WLdogiNnlUKTOAOhOYRrt5M2UnOZQS8Qz+vivmdSDf6JMvUvW9ppYftdFCgE
	 7mYiQBq4xlV5TskwS0IxR+aN8YEIjZaklhSY1Z631wkAY5yPFJd8bLKvRV1vDSdtDr12h
	 CHs19amYtgjQjupKP6cah2Gk0ej8Y6j+wn3gPzKsp7xP708Q6iW2bUWw38lxQMOBunw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964215;
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=rFh5MiGl+00o7N8CR1TGe2QlxAC8xyM5CZi4wf9eDcI=;
	b=DWhAHLrPaF2eRwuQ1do7AhEvthgI7pX9fjF3VQht7KWVVrOBHsUdf1mdsHBgjiXCDtnp
	 5DBeJ8SvCIOqLvbKFRO/kh3Yz4m6WBgYSS003Ov/WYZBY9BXJBTYcEB1jWsRdadrBalSQ
	 14N32WlgLpTdSxECyQ9vcpDXPvDmAtW1nm/oRd/Sg7MqrpRdhHxqq1MmP1amhsPG5Mxn9
	 V4TCbXFj1DsP5VSkUWxQCox1nhqx9U/cZ3kvM5VEkixeS+Y7wKayM+cZg/IEpgrbDCgAl
	 D1+NYtg+W5xSxmCDCJYEBnJLQKd34CTKxe0fQ/oBjYkbiLmzPjKo0vctET5125NnC8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=B84bK3P2;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=C2jp0OVC;
	arc=fail smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DEF606A331;
	Fri,  6 Nov 2026 11:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44DEF606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=B84bK3P2;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=C2jp0OVC
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AQcKT2958936;
	Fri, 6 Nov 2026 06:23:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=rFh5MiGl+00o7N8CR1TGe2QlxAC8xyM5CZi4wf9eDcI=; b=B84bK3P
	2e4xQdMKFrCDWI2M+MZD95qHQk2md89ID0oHQXBSaQnGvpCnFequS9Cpigr7fFEf
	MzVDmUHnsyF3sqAwhlIiaz3+egL1qlnjius4uRXGlFU1pdSWDt9biPJ5a/O2cbj4
	1EAT+9k+uaG2BuQdVQqVy+Noc63pSmQXBwoyEtCOb/pq8QLYfyUpsr1/mXS/xiz5
	nbAM7xbDdBKmnMRNzu7kgoGfSL3ca/6MgzflKnH06wZt/8sSnVrrPzuZeN18DNai
	800Nwk36zUTyBN6iBF3ZJL7gjVlYhXxopopJ/IE1Kkel4dAkoHnf4LLm+dm4wL5J
	Q7HRch5iSO5CkVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=rFh5M
	iGl+00o7N8CR1TGe2QlxAC8xyM5CZi4wf9eDcI=; b=C2jp0OVCT7o7ahP06Y7B1
	bdDlpypAtApFnMydHidF2u7swtgzhZZX0WjBYpPQeudTTVwYIbOGu+ClMdSP7tQL
	JhpirGsCc8Zx8B75qB1qIA7sHcRW3a69eM7aVOUtsb86zv6OUt6UVTX7dHIMoRl/
	ag8aWYho3kRrWVIZXsQ8CTQnR535qUyUApMKoqP36uC7K4fMaSpyMHC9nYvslVVN
	3UH5NPevQwbzCeMJX7+o6qmx+5ru+qg3o23h6km7IPTz7NXshgXG/Eo0WYTHPYAd
	e0KhwRBD1W/7d+X5xCiy4knvnhd9BMwpeVt00A0BBxZwrCgHrm7jVuehXJ0sisBe
	g==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012006.outbound.protection.outlook.com [52.101.48.6])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hs3pyu73r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 06:23:16 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4EmSjM/uYUPms5kLllVI1BX0TcfDGY5bhgoGWXy1TOfbxuTQlxL9Xsl0HDD0iTotPGNvUFG1TOXx1mjnJ9t/AlbkHOqXqwJbMEF/B+CkAnwxqC6sAZp0dqNH63g5j2AFCm9yggYZvit9p9BLIpNrfaAj3cvn0aliUSAfe6YHGHjEHnCLkjxdUn+C+fEI2JcgPB/xjMrHjs9r7ZYGC4XiyUfIpdjtvSJRXOGU3NhBKXnwPyfkiNQTIVzHuO/LIlrnfEzU2rj6PFNKugbpSRx6P9wQjwtH8l6yK0OHYYe7vkbLtKOPTRX9i1jjHYC5LKqC6paj/3EjlTLWbK/UFCxZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFh5MiGl+00o7N8CR1TGe2QlxAC8xyM5CZi4wf9eDcI=;
 b=R3uY+in8jgvjjURba7Bbu1CxzIQM+qxqsKAWvsk9T+5pQIs48EUNJJKZHCwDexPQR60sMr9TupTZDMDo6ZaIgLeTceDdgAMA1lewm4Wmn8R/N1vUUwagoePYeNDoQvWLpTeCXGoKdjYjByKlnFAeh6m/g5AFpixV4rHGpEmrD1y5vLWCAxtEhuQ6HyPyvMYyaPoFN5/f/sJuuYaNGk1L93OW+tJyQTKLpv7pqvbVsorW3CYiqgvpCPJ7tE/xNDSKyTyDwt7gFfCvdhuffWQtzm9k20YorTopNhlnAQRPitKDTwCXHNVVkl2N7Bj5VbCtlZX3apH389OPYdszDzYOkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from IA3PR03MB8453.namprd03.prod.outlook.com (2603:10b6:208:540::16)
 by BLAPR03MB5474.namprd03.prod.outlook.com (2603:10b6:208:285::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 11:23:13 +0000
Received: from IA3PR03MB8453.namprd03.prod.outlook.com
 ([fe80::6e03:3221:b921:9c9]) by IA3PR03MB8453.namprd03.prod.outlook.com
 ([fe80::6e03:3221:b921:9c9%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 11:23:13 +0000
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
Subject: Re: [PATCH net-next 1/5] net: ethernet: oa_tc6: Allow custom reset
 settle time values
Thread-Topic: [PATCH net-next 1/5] net: ethernet: oa_tc6: Allow custom reset
 settle time values
Thread-Index: AQHda63CXLbFHdIkYU6Jba4I+V9Sk7cd9UIAgAL1djI=
Date: Fri, 6 Nov 2026 11:23:13 +0000
Message-ID:
 <IA3PR03MB845332B85FCA0FF56CE39716F2762@IA3PR03MB8453.namprd03.prod.outlook.com>
References: <20261103160918.409701-1-iustin.stolniceanu@analog.com>
 <20261103160918.409701-2-iustin.stolniceanu@analog.com>
 <aus8XiLynJmSXaXc@analog.com>
In-Reply-To: <aus8XiLynJmSXaXc@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR03MB8453:EE_|BLAPR03MB5474:EE_
x-ms-office365-filtering-correlation-id: 0c9581b7-6693-492d-6ba3-08df3bf858b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|10067099003|38070700021|4143699003|11063799006|261028144727099003|261026140227099003|261026121527099003|261022105027099003|56012099006;
x-microsoft-antispam-message-info:
 oEQ45SmjGODBL6uOXpCnYz5Shm4O0UYPAXnFNgmq7+E8Kg2xuqtTTBwZpbFyG1+Reeb+Pm1RcKmR+u1goaqG9PzNokaq7UsX6Bk+npmOxevAJPjjSICnTs3y6a2oKOk2zTvMurTVxdjE8fNFN18db4rRihAod6u79wbiD7dLGRi+FWYlFjSaoKjktp/VnPjLGhKfAlWBx7Wo7JHV6zNiJSJrf+tUFIe1j00EJy9R17J6RbSeFcfvzzDEv9hoEUWXYt5t3CtJRC/uYbpxM0TyBcOFosdzbnhI1usBEWKJYXH/mC2CrHgeRgOazjXCPx0RtcZ3gboJmiOTyxxthfH2EVCKETquGBhVS2IqKoFevcgzhW/Dbhv2IsMl3m8XiWUZRa62aTpoOFzHfOdC9mOKKeU863tOoA16FbxqTJfdfMBqz8ujDijfVlfuVUduKB8fpmigkTiVMKmjsAtvSz33WvP57tkJGb4pZPW3Ae6Til83qt3IAb9BYadpF3MwF4BgEe5FR7wdIsg5Q9TzozV3h7KaG2UP+n6GN1IqJRWZWaakZcPUjWzVYzkQdMWnbLmCE7YvlMecW/gAmVj5oy1RBCw7FVhIGRseiUMkKXleD4fAbvAMkCaUsuRu/Ch3ADBgcaGyf8Rjg77Q7UOedp3fL65KnAZSxaF1QNhZGqQ9qzgWapqc/y5KThkgoVSj5mIFJ7z0cpp+0wiYpzJEqLgvQQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR03MB8453.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(10067099003)(38070700021)(4143699003)(11063799006)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?PXKdCl20f+QPZkQr7LvNalBHlHrmncNIarhq6uq8+4kvAjgPdAkL0Re3?=
 =?Windows-1252?Q?nymn/lGljHQLiJhtaUIIhH4+GqJ1GgWeYaH43/024ZwS29ljp0fZ8cir?=
 =?Windows-1252?Q?UhsHzFxO0w6Omuor4zVab/JsGrjcDkCwdf2KsKkwGmUxIhaGgweIsCTF?=
 =?Windows-1252?Q?1RYvhWQUtL+pxgOqMhZAtVsl3U9So7rj03OjADT3W/xLMC4Qsy8ltbH1?=
 =?Windows-1252?Q?z+dKBrmXAtm0t7uWWo/9mEIniJFxXrjrUI3olL1NqBne+QoJ2FXe6SMT?=
 =?Windows-1252?Q?sDrNQp5zwoX4PXFQXKuT1iJkHecaGuxhKqSX9BsF84GX5388Um9+NCOY?=
 =?Windows-1252?Q?UIAxbgWT0OR/4IelIo7kv1CR7bo257dc3JkGUtBeqf9Lq9GJ+wqAZWgF?=
 =?Windows-1252?Q?IZGbKfKYPfk3Ahl3dyEohzfkn6SGvupk4Z7zU77MlGi5vEwj0mqUZIYj?=
 =?Windows-1252?Q?/vqAmkyE0vjnYlkohKKXssZjvP0ZM36/n0pFMVrxiNwe2JBL9NmArsFg?=
 =?Windows-1252?Q?AYVAkTNxSuFsW8NikKmcilyjGrbFE7jTz8bvzF3j83hkZaUh54bu3Lik?=
 =?Windows-1252?Q?O+9Vyw3XZsUY/aYiVNv0plmxGtOQWDuFMVjY2Y7cQhso8jWHGyFOBpgo?=
 =?Windows-1252?Q?2hefUfFpOGbEJZG266vYCNtVayXE0pLXowjqIWq2UffWSPlhgJTH3tej?=
 =?Windows-1252?Q?xo3ZTulticzE2VACVYBVGQUfJJ/6by4kJ/Qe2NeMOwegD5WUEGI5JHuJ?=
 =?Windows-1252?Q?uNrD+hRcoF5z3l2jwcmhwbvmwn18gsusKs905fqKO3dO7sb1xKQNmAK8?=
 =?Windows-1252?Q?Ehw790g+jgB6cfMSAhLXGaFOLfU9xZ6824ZfntMu5K7VnxPBZVsXcX3G?=
 =?Windows-1252?Q?JCzJhZGXhdJzqeLWVcsss6Yjn8biwWMRA/FjBHf0Smc+SWzxFYls/c1n?=
 =?Windows-1252?Q?ukqKdIUGQn1PsFg6zgwFEhU72Ek6IstHaSCAdvP+ZiXxXblr/nz011dc?=
 =?Windows-1252?Q?UVHRRzqrunZT5P2HSgBlzSyg5InH/XD6mDYjE4J8nQ7de6vXtckzBj2C?=
 =?Windows-1252?Q?Vs5Zg6v0YRtOxcetcpQ8sJGmMaaf9IvV0zU9M5n7NZi0Ur3pwMNP78UY?=
 =?Windows-1252?Q?wy1G6l8ypop7xmxsRTWcGxc5u2xCK91eZ2Vcw7KATClwwXxI8rqI1uYQ?=
 =?Windows-1252?Q?QrnU1fXCHdjZO0W3mGZf+d50QMxVTVe96qHtVhweuG5SVwCajyfcxhk6?=
 =?Windows-1252?Q?QZZdAMeoWUz9mkCnzjTk7B5fAOxMrullo/gZ1pX+my+t+6UCoSc/reVv?=
 =?Windows-1252?Q?RZp4TOizwBhbUI4RUZ6ctsWr6FSWlZvPZO4LG6eu5pOZNPGSbGwON0mw?=
 =?Windows-1252?Q?vPqYglcS64tbmnsTqD81J4d5BDf04q4Z9s+ITD0TPSkbBgdqcSzExYCN?=
 =?Windows-1252?Q?V43wBglQw4DCrEQEs8BWph1aqkdWOjPduM6lx+r5G+18BaW3pzb+esXQ?=
 =?Windows-1252?Q?6Y2dUYL4DvzUJZSg/3BZ4VXxoQ+HONRCqFST2uxsl4S/VGYvZuIL3HIv?=
 =?Windows-1252?Q?tEzP/03SauTa/4+vYEYfeS7p1NKA117+eHz1vDp6YHV0i+2UA2iNAFD6?=
 =?Windows-1252?Q?vFrZWIz0873Bmh2cu9pAacwjOIZikufp5aXWf5QYwCvQOCJymJDXhmFZ?=
 =?Windows-1252?Q?BTKhyXBuQGf1cT6YdfBR7ZdlV2Ih6fu1wqZ1VaKOZ0DrtKWKdJFghS6D?=
 =?Windows-1252?Q?au87qXb8cz265wYtmL2BQZZo1eut9wnj5I7t2DKUbjQ1DCD+UTZ5w6D7?=
 =?Windows-1252?Q?utyb8yjG7ushC5unlbhPpC6bdDkiMVHfkIkQDzxK1Qwloof+LX1og/0D?=
 =?Windows-1252?Q?/ZOtJ0iguuJxag=3D=3D?=
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
	tmxuSHpvpNQSceAsHHKNnUyp2lUPD2zpMi3p56+bObrqhMikppF+NBd/I3TY2WzBC/bCzs0FyqbEU/WlLubdQ4pOHSrsQeYGRdL90I5Z6BdlCL73eKR75IS9RVuGUDgsNZXNJ3N7cZMvXruaGbd2b2WpeoZHD6wlg5oT+twmDZng/IJ2Ts9Cf8Vgyfw/OR4kTEe3z394EdlNzMKwzKfnB5ZqHH0gBl8eYXL9XedXmus/ijvcf9YYj0IWkFbEpmL6xeRDo1a5gjKCfq+gCfsistvchOBLoN1Q2WqSybYlmI8mhQBMIjJEFaBucpP1cbIt927cKV6SmL7WZlbDhSIa8Q==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8453.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9581b7-6693-492d-6ba3-08df3bf858b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 11:23:13.5492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ppktf3RssLNRbF0gs6LtchG9RoMTiUkN2qyV0leM98UTe1Mh7hD9F4CVS4IVQwPO/v0fDcET2Y5kdFDVvQWT8zzWRkLHqC3PlZBOZ3daw5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5474
X-Proofpoint-ORIG-GUID: -c47flJdNZS3zlnor_K8QGdtjJ21ZfA4
X-Proofpoint-GUID: -c47flJdNZS3zlnor_K8QGdtjJ21ZfA4
X-Authority-Analysis: v=2.4 cv=ZOtCCn7b c=1 sm=1 tr=0 ts=6aedb8a4 cx=c_pps
 a=UC7P8Ip5M4jKPNRdwLma8g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=N659UExz7-8A:10
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ZQxX5BWu6Z8IJBb2zLX7:22 a=6ehgGptOwyBs9EcT4pIA:9 a=pILNOxqGKmIA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA0NSBTYWx0ZWRfX4tLn7RxhJ1mC
 dIg6mLHS19YWkEtjEIOemvXhzXxRAqC8a9YU1WYGlJJ6L1HAlLopMXD5Zker0Dkc751wu83WoMK
 CGOxSo72JbMJdOGXHvUTjgllIw8YCMIR8rgholCazHmHcD9wMd4v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA0NSBTYWx0ZWRfXzDOM72pusleL
 CaCxfmZlZKyyy7cWSdoVDqc6vkklJlBbZkAcQ8sB6YC0WQTGPVLMxJ9MlnxjlDQ/kw5wKL2IoTZ
 y8/uaHqszb2wL6YgnlLjXpVtQcU2VFpql1JHXhpRFgY7tCJC0KS7ewDEu1rGNP+s0zE8oyLCJ1w
 xtW0Ch5BDzBxi1qCgbJNh6AhctG1JirT52MtrYzrM/qJEBcsRhO/sitxh35H38W6kQ3RCjdrXnA
 aWiNe1XcXbn/Qvh6rLGFnfisg6vuIbbMdB0IEY67+FZq+SWatgzF9N/Sv32Zwoah8NYtkr+LvgG
 PHr/MWGsiTglwZ33P9ajPpGjj3LlAPlsYGh3UlbsVU9Fv3aF521r7HDOTYeFosz8pmrPaTZ4E+Y
 c8Sf6esizDwwowMyM6MtA5Zfw9rGUb/1+jX4jasnc9os46piywUJzimnedj/Bp8vgcJNkZn/uKL
 0sffvjfvqb8BAvMafcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060045

On Wed, Nov 04, 2026 at 03:10:56PM +0100, Alvin =8Aipraga wrote:=0A=
> Would it maybe make sense to split this into two quirk values? Something=
=0A=
> like hwreset_settle_us and softreset_settle_us? The ADIN1110 datasheet=0A=
> seems to have a slightly lower value for software reset.=0A=
=0A=
Yes. The datasheet gives 50 ms max after RESET is deasserted and=0A=
10 ms max after a software reset. v2 will have two fields,=0A=
hwreset_settle_us (default 1000 when not set, as today) and=0A=
softreset_settle_us (default 0), and the ADIN1110 will set 50000 and=0A=
10000.=0A=
=0A=
> If you have a separate softreset version, you can just set the value=0A=
> if (quirks) and flseep() here unconditionally.=0A=
=0A=
Will do. Since the default is 0, I'll apply the hwreset default in=0A=
oa_tc6_init() as well, so both call sites become a plain fsleep().=0A=
=0A=
Thanks,=0A=
Iustin=
