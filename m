Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793964567;
	b=WoGIxmvI7APfZNfKYSUDx9muZAZgRUsDV0qxQcMY7gGiswkaORzTZab72kTmax14rj5o
	 bDmqUaQk1avtw4dT+ZbDodX860OEutVXuQsSHQ8Y0SPRN4pqUBnJI0FZWC9s5w53EvkYE
	 o2v/VARmZVjE7wdkmgzg/CxE+1DsWf5nFkNgiQ8tAHrpaNWamoK8gVsIi0kJtb1oQskAe
	 31BZDjW3ZZANW/kYsKzqvwWr/GyK3TLR+PpdlOqZ/y06fQ+LIWfnVRCHvC1BllR2mg2ce
	 hwcBlYO0InMaUvkBvo4OXM6fCmappqXYtoHivClagDCo9CZRGgkAgFZCAdxQPEYvPqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964567;
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=z6mTe+88Ot0zXuKJ/sRUhzIZ8JjadFByFxkgyOWJEYw=;
	b=CeU4sjytNBE6OumSGmh6irIhk+7auBSzXvbUeEFKf5/hS438oUK3aQ4WxQOyR0ccPP7O
	 Y69H2yD5EBkncx2vYlMOmhzsV5AHhiDSfsQN6FM12T0P1RMcLd/av1l4dXnJeZvk4DTof
	 230ycQ1g9H9eMnEXICc7tpb4NaiE9NLh5mzuVK87CVMpmrqtp2f6i07bjVeTrFr44l3z7
	 PCagGXTOJdemIE0nAhHmFkVSs1Y3SxDza3oHzc8lGx8Jhin+mjkzrCik1pZQLclci6alA
	 r8dQuqB8d9wktZLtXdOEKn/SslkboKmgifqPCCGOQINkQBAk7+mYUGOB9g4Xo1KUlHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=temperror header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=YuSffwKe;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=l++cUbw9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3690606A329;
	Fri,  6 Nov 2026 11:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3690606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=YuSffwKe;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=l++cUbw9
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AR7M3264349;
	Fri, 6 Nov 2026 06:29:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=z6mTe+88Ot0zXuKJ/sRUhzIZ8JjadFByFxkgyOWJEYw=; b=YuSffwK
	evsiagHeh0pAYr0qAok17wykFTzXeAPYIpGi2jwYha+mNtNjJHHRCK/qMXPT1kK8
	Aly2pOpSgnF2ANVdnq2zBu95Cz7CfkLLwAd7I7LH30sevTtporqFPloxkNETEbK2
	z840gH15QlglL2ZbqNtvyYLtXXFSSJ8G63vvi1GTc6PV1jmOOQOgYMCnxK+72mOP
	ukMnFFk3UN2Vmsw5eLDBNOd8ZmnGdA7T/Qq+8+o+rcINMP3Tki9nHF3gQjJjlZV1
	v7REobCdqfDmbhh64Fl+WgnSqtU46Fpiz5DHklMXhYSlVgYVe9yN0hD9wu0Hgji+
	3Z9RB7bue6bdkUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=z6mTe
	+88Ot0zXuKJ/sRUhzIZ8JjadFByFxkgyOWJEYw=; b=l++cUbw9ItpcXZtwjXyVY
	Qm/PLw4zr2FAc+mj0mtLkZT93r7U3xJL3FcDJopdZZY25PKGEZrpaForluOrL4zw
	pGKbh8z9+ApC4ggAOhdvJMBXX6JYZ38OZaLCz7LxZD4mmnbZgKNUhjWN5tLWsJAU
	lwvN7emcqXR0sunJzPamKiMKFjGJrxKqNv4TEY095Y5R54sljjIwta4sDuNSS5F4
	nY0HOa7bHkfG9mQDVvOmplHpUkEqeG44rwj/MrN5sChVpW6MNv5XBdh6s39LoLKV
	Vhyon98epnEaQOY+yaV/u0Iwt6M90j8magjuZbVHwvE07SoG0piRmv+g3yeeh8kP
	Q==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hs3q03knx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 06:29:04 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTuDkUSGRo0uL4kcpC4Aic0A8X0apvBWQIq83oOqVIRXRr7Vabe/w3+B2fepqO/HBvN/IrphWTsr9tumi1C1PhqtE+iHQyrfQz5t920wGsZHbd1i/a9wiOv5k1xvU5GXC3n1FgB7kY9s8IeoE69C6DPjLRSFdRdFQaSCy6HDLS/AfbjUS1ROFKq9cjxcKB77hxKir2/Y8qt5SpMW5MPeTjVO8aAfwZrTSvnXGgTMuSCEIp4ZvonNI3QOFHLDr3zKbR7nQXsjx8gntsLe0cHyZ1mWMLTWsVIMwKoKg/XD3AtaQCZsOQUv4xpQopCbvmSenfL1UUW37633Slh2NW1brw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6mTe+88Ot0zXuKJ/sRUhzIZ8JjadFByFxkgyOWJEYw=;
 b=lbOnCIyKtFdUWR3E4PpJi7yolCq9q7XXaYZmagGazIN7JpfXEU7DmQ3fDb6xiwuwyv4AwvAEkQ1+rZbN5Sf1ArD056Td8CWlDIdNXCh1oPE1LcO0DxgeGNAwZNOzCUPNlyEuwLASdc+RvadgZkHEL2iEFXHRt3+y3dDAJI9scqcH2ZkzSjKE5y1rW0MUYfFMrPJgS/e1MEaPuddgcusxQLfjJQQY/beE8sDcLOHIsC3WlsO7qK9qWGvcuIXpEqQzmSitzWf7fGCdEIax2ggftkWvFcwOWutRAZg1KG6ItPb9uhsVF3CWHdtboxgc3UC62XcRZbEcukXEwjcAkCKkvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from IA3PR03MB8453.namprd03.prod.outlook.com (2603:10b6:208:540::16)
 by DSWPR03MB989143.namprd03.prod.outlook.com (2603:10b6:8:361::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 11:29:02 +0000
Received: from IA3PR03MB8453.namprd03.prod.outlook.com
 ([fe80::6e03:3221:b921:9c9]) by IA3PR03MB8453.namprd03.prod.outlook.com
 ([fe80::6e03:3221:b921:9c9%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 11:29:02 +0000
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
Subject: Re: [PATCH net-next 3/5] dt-bindings: net: adi,adin1110: Add
 adi,spi-oa-tc6
Thread-Topic: [PATCH net-next 3/5] dt-bindings: net: adi,adin1110: Add
 adi,spi-oa-tc6
Thread-Index: AQHda63e5o/gI+lqiUiUfXIx+OzXp7cd9b+AgAL1+N4=
Date: Fri, 6 Nov 2026 11:29:02 +0000
Message-ID:
 <IA3PR03MB8453870CB32D7E540C478F21F2762@IA3PR03MB8453.namprd03.prod.outlook.com>
References: <20261103160918.409701-1-iustin.stolniceanu@analog.com>
 <20261103160918.409701-4-iustin.stolniceanu@analog.com>
 <aus899mJ-XZg6ZgF@analog.com>
In-Reply-To: <aus899mJ-XZg6ZgF@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR03MB8453:EE_|DSWPR03MB989143:EE_
x-ms-office365-filtering-correlation-id: 977119b8-5a0d-4d33-8b0a-08df3bf92872
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|38070700021|5023799004|11063799006|4143699003|56012099006|261021121427099003|261009223027099003|261102123227099003|10067099003|18002099003|22082099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 AC+aeoKWfJoXSBWcQppYtXr7l/9kPbRceSvtoWz+VogCismA3xf9uP0CmWz8u16Vi87eskOsIcyefgXsSz+v44a7Jf19q3WudIK8DrXrVgl8pVXTMmUInu4HrEbNp5vlHegujIosf9Fpz3lJg9E7eSAiJwezD3mRfR6daNwoZolpoJPypDFm/RLXxY7beaNPv6JVCzJSjAf+wVmTEUQmDBzvlfzpAaVu2Ik8Kk7vOkm5tvtqjvkPPV0syhU4WIjEtKNrJUokZveYVjTk+FTibSg/6Y/AXVm68BwYqyDhRWlBwKyZzRpzd7ik0KOnf7Kwa44yKhZrp95e4KaT7WytJvJzGEWDNdj995dEwD4JvAjeDW5AWUrMykZNsYs5tHTsMP9zwzWuVyVYkNGSyS0MLwDiq74Dsoi9pLEvmm7wxzM7aOQcIM3R9Usezxgd59HFC3mhaVnmkajFgworRtQzXqrzj2q63Xap970OUBuZuRhGhFCMZZqlnWvSIDdXNxkqdhGLQD+BLakLfzwx6MH0qRORuOVmESU2uGvvsH/kEIlVxtjhvBE2ShWRkiQIvA4+h7aT0KgdpQtL204krsEuJahBWGzdkIRQ7UXdnnOyiFJH1EQsJFH0xJYqkQavygNJpHkLrA/xoSlkMhtyEKp1P+YyhdZ1MWRRVGzYlUzy94QJkSEQiLy2rkQRtGV4x1vVF3wjDc9BltX4Z+G2Ue5Pr38QlaEcaKMGIow+qLTTNk0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR03MB8453.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(38070700021)(5023799004)(11063799006)(4143699003)(56012099006)(261021121427099003)(261009223027099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?p4ea6UU2CNUbfftUvMzXz2qkv2sRthHc2sQ0sGjMkmr5Y90jpSUYp09/?=
 =?Windows-1252?Q?oMmqNg2WkbvB9XGJ2wJte471Y69faRRLyKXCPYzVzyjBifnbHd/Iu+xM?=
 =?Windows-1252?Q?Mf0ZQAIRoEL1GhGfUY5HKpF2Wfdb06ND4ptkSITbzbPUuY9Dl7Qgy45g?=
 =?Windows-1252?Q?vKPwoqXJS9992j17WRrnwlEd3KQ20IE3bDxshGUEKZr0PcksabX9nsUM?=
 =?Windows-1252?Q?/bjqGUIfBxFF7g/+DpykawPiyySyjnIwV1B7RzP0ko+20CLYXjXsacYa?=
 =?Windows-1252?Q?60lEYYTu//tQ+aqI2ZhhN4NoOP8gwZXIOt67kyrUzKOq/JgZg+ptCm+L?=
 =?Windows-1252?Q?gcrz3MHHgH2vP6xk612kqoer2eoHdAE/zS1uYeKRLVrPEmo7gYir4i74?=
 =?Windows-1252?Q?mmNwwzieOmCkr7wZ/j8HPPipkYRsTbHVmJ2IRz1fwbZLuwp4Fec1GgUS?=
 =?Windows-1252?Q?mbtH/BxUiYf4id/zfsFe3e5raGacEYU0J/FW3t5RcNKrlRRGxa+9jPd5?=
 =?Windows-1252?Q?Zf8D5DpxpZxLPpfAKlOpvm9rtgnA/3xBUchYYAzo4a60s4oLzCiFvb6G?=
 =?Windows-1252?Q?IbpnnB2rdhorkoV1BRgGqlFI/SnpgssJsd/l8J4lNb+IItbwYhBaPzu3?=
 =?Windows-1252?Q?PoYzCGpFlk0zxfeRvz8MafixQa67ogKmvG2vL9U/NipG/hgjw18cIh4e?=
 =?Windows-1252?Q?d8fiR+kcHNh7dXW8HEQsCW/hLDmEnuiSwMkheRVQN/gHMGoLaosC48Ol?=
 =?Windows-1252?Q?wvu/0gIFNNjndQH+YGODXbrWXZv1JlRAfNMO54hPKkogC2dgF9sksOt4?=
 =?Windows-1252?Q?QZfB2LidW7AXJf05EEDdEYD6Ca6ruO8UI8GxflWcFrTDTifR1E3E6H6E?=
 =?Windows-1252?Q?Uj/S0euPqaHK3wYb15I4vPA1MVl5S3WsW1NRV1m/BSl3lIoiiYP+aBks?=
 =?Windows-1252?Q?ayc1ryP4uJgu1i6uK7R2sAGpLdj9mhqLwUrJkerMaGBAJCtdpkTNI+I4?=
 =?Windows-1252?Q?CxCzeaj9uVES45dmaqF7G9OEhu/Op1Hm2UrDr0fzgODPNsQeFMoG6kOk?=
 =?Windows-1252?Q?MyYokID0L9kHa+wusaBA7qHWPiwtXLv4AAjF65JKDXe5s1toneHphQQQ?=
 =?Windows-1252?Q?kjMtvdnFo5uf0Q5IcKahk606awTPyi33xEBBNvvVIEbl8Q34H6DwFxg2?=
 =?Windows-1252?Q?tQck6HKJ7O+TqBybOrnyaQj3tanZqlEbUU4nRCekCRbSmexvwtUykmZg?=
 =?Windows-1252?Q?1kH2ZvpwPPdbT5tGxbvv4XJkEefqw9wDe9/bAwVNu9dKLrzPKxR2GQnW?=
 =?Windows-1252?Q?wXoGnkPsdZHG4aRE5ayVBxbKR7XuP87DSpk9/ndYRE9hgzmDfJLe8BWl?=
 =?Windows-1252?Q?rLJH721WJG7iaDwsNwGv6pEJHvYJRvlTOzLXizS+fHw7wJUhA6pX23Py?=
 =?Windows-1252?Q?h4ROP80zwJCVvpt8wjljmUs+XOGjDIFkvvvOfWziNomlqi55Nam9Df9D?=
 =?Windows-1252?Q?q4lCcuFGlPur0xixhHnt5z1vTWk1Nv3QOWWwJoUl9I7JkfuhwH1601M9?=
 =?Windows-1252?Q?8MP56mo02SiyPn0xC5it/BD1PZ3CX64e83z0IFkafwh++Q5PQtZzNrBs?=
 =?Windows-1252?Q?MZLvrDZiqEuZIpqdFE7OqTt8YQpUtZwuaVVVZsmN4Mt2OILKeSXwcn4i?=
 =?Windows-1252?Q?YCbyZ9tqq3Dopwp9aaPhmy1WmwSyNNlUtXQNKkvVcJTdern8BlIPzf9f?=
 =?Windows-1252?Q?eCSMNAHBS/FGLNxIy3IDOm3cqcZtrMQV3dV4G+uxEH0zB+Qk/bicRfnw?=
 =?Windows-1252?Q?SnifUxlpTCWcloqZabO7DnoNZgf6FwnKWaMQK3nQb+Cs4Ba5yw6HEzKL?=
 =?Windows-1252?Q?O2x0bexUoa0HqA=3D=3D?=
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
	5NnSN9pJC8xn26fC4YxLp1MsbOT9JcHG2nUtbcdrqtalxR1zkG1ULFfXT+4V4NI9QUYp1JnldHrvTyT03eKwTieTtCOYE8DPwGmruxc7xIXzTuhnbMXyo34WEC/CVaiIOAswluEq0ds+QCSs/UWCX3Q4Ijq2TyY0bZSTZCQo7a0c2SosVRzzInx4psF9V3PBe//9S+OySCVIhHEGLqL0fyql0AUHLx6f5kLCLknhMN3Ma0oFS95pMyBKwGh5BrSWxqo0CE5lY94aAvQAYpuvttN/4/g/0iZUd/X3yvsmfshw0NRMIsW3Eq0nArvz7aA5Sem+fFYKCiqGlDDeKydOxw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8453.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977119b8-5a0d-4d33-8b0a-08df3bf92872
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 11:29:02.0725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GWyF55x+PC9HgZ+b0CyRBbzADlzQ6Xw2UFdzEOQtf51jSPrKmTzIZdfF4I/0JP3xcnyq9UWhRPAgia7niFYBdzfIVWz5fEd8CFITWuYE3Z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR03MB989143
X-Proofpoint-ORIG-GUID: 8zcJvvMhOILk6eZzKQ3AKuTO_6X0_LOU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA0NSBTYWx0ZWRfX0tExww3vABIR
 5pXnCOfoqi9fWOYiPMwCf56P1lwDjB7MfxCpLiCW1520pbpqqgVlMLs9CmXOauT/Yh6FngxdJB6
 udX+lI+xa4cSOfyVEgqGWwMwCrhC8PdptTBdhRvzRTcIx9LF57kl
X-Authority-Analysis: v=2.4 cv=Lt8HWXdc c=1 sm=1 tr=0 ts=6aedba00 cx=c_pps
 a=1kzZLs4G264k5kMmJ/E+Xg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=N659UExz7-8A:10
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=-0HdNglx9A_OYmkyANYA:9 a=pILNOxqGKmIA:10
X-Proofpoint-GUID: 8zcJvvMhOILk6eZzKQ3AKuTO_6X0_LOU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA0NSBTYWx0ZWRfX2mUk4vXcwG0i
 QRMNSXoBzGMCmRJDW3VOCOR9hcDtILMMGC2VTsToB4AKfXoODfrCfCAhhtwHn0PWohNVpXDUCtA
 hGcnYEVX8pj2iDOqKML2QtjYFiUoNAdSQDvU0+oRY4Ea121rMat00ju/LKD1cjztXxIOM0qTAuz
 Qx/UVA2FgBBzEyhlJvwi8ofzm0UPmm+bn5W2QNbLNa/7qKmiz5JsLMqFo5hUpcQqhofbDdDrfjL
 TDvJrxgkyrJIOUTwBHvMgs0fH5BMHYcWJbjG3jfhLopYh4j5vRcMOnS7SlFeNIPbL/ddZfWVbIG
 eVhCJSWqL2JbC5N0TxiAwKW4GDvGFRxGYcBH4dXNYB+n/SqR/ANwsJXq2rlEMyww0gn/7H/uI4a
 mhwfA4tDFmFvb/ogfXHDnu3oZyJIm82qb0vggXYLtqpFaziUOXq64kSdG+4Nkju6eodd58FEJBE
 UV3iYOw6KLzI5oVJbNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060045

On Wed, Nov 04, 2026 at 03:12:41PM +0100, Alvin =8Aipraga wrote:=0A=
> Should this disallow the adi,spi-crc property if set?=0A=
=0A=
Yes. adi,spi-crc only applies to the generic SPI protocol, so in v2=0A=
the binding no longer allows it together with adi,spi-oa-tc6.=0A=
=0A=
> I also see that there's a similar protection concept in OA TC6, but that=
=0A=
> seems not to be supported here? Is that intrinsically the same as adi,spi=
-crc?=0A=
=0A=
It is the same strap (SPI_CFG0) and the same bit (CONFIG0.PROTE), but=0A=
it's a different mechanism. In OA TC6 mode every control word is sent=0A=
together with its complement, whereas the generic protocol appends a=0A=
CRC8. PROTE is read-only and latched from SPI_CFG0 at reset.=0A=
=0A=
It is supported, but it needs no DT property. oa_tc6_init() reads=0A=
CONFIG0.PROTE (oa_tc6_check_ctrl_protection()) and enables control=0A=
protection when the bit is set. I checked this on an EVAL-ADIN1110EBZ=0A=
with SPI_CFG0 in both positions. With protection strapped, CONFIG0 reads=0A=
0x8026 (PROTE set), every reply carries the complement, and the driver=0A=
works without any extra property.=0A=
=0A=
That's also the difference between the two straps. SPI_CFG0=0A=
(protection/CRC) can be read back through CONFIG0.PROTE, but SPI_CFG1=0A=
(generic SPI vs OA TC6) has no register at all. So only the protocol=0A=
needs a DT property, which is why adi,spi-oa-tc6 exists.=0A=
=0A=
Thanks,=0A=
Iustin=0A=
