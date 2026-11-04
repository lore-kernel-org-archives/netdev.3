Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793779634;
	b=ukavFvhjAO8W2cAphcT2hVBJEFAoQBxiVkwaX4kEOeghPqwT+FzIUtXvO6XExlbQjUK1
	 axF8fhRmoS0hL6fIJaPzFqliDpsgu9aeCyes3Qd7jKdffVft1HjbZRK+O3Ie7ew+tQQ+U
	 rukTXtnyWOYCYavFDAWNbMR2JVAgWV7S5YlHeFOhu3o50ZU0vnKaQM7mKp8kaMpBKKe/K
	 5frD1Z1aMMusQOqWnN8rnaaeNeD28OQnUKXIHYXbNhRMlYpQGkhIySaFjz2tue5B67gy9
	 pqog7aLltrBgUuc6jK8SQ+Zp1odm27IBm63S29q/LwQ72p23KZz27Di6/e6u5GszsTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793779634;
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
	bh=Nz9zCyJNmEuXb1+7164fD9Yu0v4n73P4nuiyIGAVpvU=;
	b=FAGFhcTKBrJ/T/ti3xslQAIVlQi2ZtU8/AlEwYlFisjmcPSyuTctJQLbRb/9PvPdLFeN
	 oBRAsd3XWyed5hwJfcMfvW+1OrkfV7lPUqZHcCFZCnti5PumqO9SZg9vyR9C4BoPfpmYA
	 6EUc2SLyoT+JhbTByV6KsyLApiGJEy4qrw0x1kgI3NiC9e7POi8VWhQWTKAEnqmPO1UaS
	 KctuqFMMjleqF7wBnZSbb7DIoHSuUEbBIXjPPurEjX57hrIU+qjQ+ZXLGpVJJXgPGpWxg
	 5nYAI7P0qVt/gmGXKaeAKTYN/g8iaFgyQ+2Q89SgeHSc0DmG9up4Or6Wm+PDQ4+LzHQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=nRhLXX0V;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="X/pOmj7u";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26FA606A326;
	Wed,  4 Nov 2026 08:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F26FA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=nRhLXX0V;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=X/pOmj7u
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A476RGm3705425;
	Wed, 4 Nov 2026 03:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=Nz9zCyJNmEuXb1+7164fD9Yu0v4n73P4nuiyIGAVpvU=; b=nRhLXX0
	VW+ZBH5dLMPVfrG3GJ12MHsVXuHXowi0kzcu1+K8NCc/JrHLVE+BKXvGbQo1vjFN
	pL+hKRocNuks99MPeVwEo95WfbDN1yGTGvwby5iCJUsARwZsPnOolvx4HCUTmELT
	P9scmcuQBzIXwPWiHRrw+nAfpHj3cb9U4am2rVhd4659phU4yNo9suG7okzo3wyt
	U9E/mPqyQxQSygFQirHmUZuxeT3Mt4cGU/zE4+RUk6+kDz8Ey7WxHMJ+KOYC2V9N
	WT68TBvT0NPa16TcaxHCKdHxIf+PrqZROe0BwMrTZngjvj/Mmr0VoQEcjeUiJUBw
	F3lfyqSwumSga0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Nz9zC
	yJNmEuXb1+7164fD9Yu0v4n73P4nuiyIGAVpvU=; b=X/pOmj7ui38gv9BqypFLt
	311S4yId4Ce84nSS/NW78bbiHJM4h15C0Bqkeae08mlmcTCXBuKKI+eVEcVlXhIt
	Rvx7xUvVHdjJuFSwN53xMUb8WaYF0C3ElQ0UHQVwa7u+xLHog8yC8pCD96VSgfUJ
	7N0NOj8xfUTzi8FA4Qmj6am46ss4JlTS2UxDDDvycyMT21RyZ0wJQNhpUxYyfrMa
	tb3aRg2mUTU72vg8k0Oygv9LYZ86Jo3SBfhf1AnEj1sCUbrI1M0cl+COcO2DwbMt
	kGD2B9C6XYWKmmGdgCMFXxofxKWcb+YqbvbwFOtIdYsjInD5ZEK9VJTIMDWmrVlA
	Q==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hqnftbbvf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 03:06:59 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNBQgBBw7cfMmBbTbOPDhwQcS0nr4gmHUfWtSMv34jVpuWkcbUq4NRR8zatB+9lZSGHnp6fZt5kfWo4PV8GFnDwvT2+fjttOaU8ud0PwC5RcJdwdsCLJ+6BE1OndFShx+VSEEzjf4L9KI2a6mSjJED/Q5NmK2xtHLhQM9/zKMU0h0DoxXgDHmqirt7fu+H/HiB54xemZeUUzTBX0wi8oFDoGSTM5U+//XlJGBuFZJ+pXLpiotwKpTj5yRY7gEB+CNMI2CrXQdcTCdX6GUa/CAIRsqLOo2WsR+NxuWdCHa5PzU4Lwn9LCSScpX+vZmD2RAIdUoW6i+aLhyntYzO79CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nz9zCyJNmEuXb1+7164fD9Yu0v4n73P4nuiyIGAVpvU=;
 b=lrTpJKuivxAHRG14CxSHs+8nuZ3dV3Oq3AO+EmSKlmB5niiI9XY+bQC+b1XMYl0vB9X2XAYubYFCc+mB3kvhdsesKkVFODXB5aP1xlym1kGyIIbt5Io449tEkkAWfPWWweETHH7MhgLAeA79+Z3vl6Lw8/RPy911MVHSAT5/TCTv7MT0ALcVyqBnOfimyBO6YHxqRCS4KKeCqRFB2vuWUdQCsab9J+905aq01Kcic3yVAlQX+AZGgxpqub6Tr79bF0A8fdw4LYie7clSx9BFGxCreHc5ayHWclrFWGh/RpSh57lPu9gvFE648XhvdrNU1P8LQHEVQxuymqeOyFdNhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from IA3PR03MB8453.namprd03.prod.outlook.com (2603:10b6:208:540::16)
 by DS2PR03MB8468.namprd03.prod.outlook.com (2603:10b6:8:32e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 08:06:57 +0000
Received: from IA3PR03MB8453.namprd03.prod.outlook.com
 ([fe80::6e03:3221:b921:9c9]) by IA3PR03MB8453.namprd03.prod.outlook.com
 ([fe80::6e03:3221:b921:9c9%6]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 08:06:56 +0000
From: "Stolniceanu, Iustin" <Iustin.Stolniceanu@analog.com>
To: Andrew Lunn <andrew@lunn.ch>
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
Subject: Re: [PATCH net-next 0/5] net: ethernet: adi: adin1110: Add OPEN
 Alliance TC6 support
Thread-Topic: [PATCH net-next 0/5] net: ethernet: adi: adin1110: Add OPEN
 Alliance TC6 support
Thread-Index: AQHda63FFPYRb0b+CkKBWRg5PRQUArcc0jKAgAC7AoI=
Date: Wed, 4 Nov 2026 08:06:56 +0000
Message-ID:
 <IA3PR03MB8453F2E91946AE59A9818B9AF2682@IA3PR03MB8453.namprd03.prod.outlook.com>
References: <20261103160918.409701-1-iustin.stolniceanu@analog.com>
 <49b292c4-c0e9-4b19-aa4d-d15dd20d25b6@lunn.ch>
In-Reply-To: <49b292c4-c0e9-4b19-aa4d-d15dd20d25b6@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR03MB8453:EE_|DS2PR03MB8468:EE_
x-ms-office365-filtering-correlation-id: 93c6a20e-7e43-4d5f-9cb8-08df3a4a981e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|10067099003|22082099003|18002099003|3023799007|38070700021|4143699003|56012099006|11063799006|261026121527099003|261021135927099003;
x-microsoft-antispam-message-info:
 RUZism4A4OSEJwNC/RT3Yq6VEhbf9Cjg8Mr20cAZ3UzNnaRoF/DDGuaKgLXuVygE+AdJb1KgROwAIq4hYVCnTfvWzuT9heJKzYkjzzd3srumAPfj1DanAkkaoN3xZRFf1xtqmkC/rgdhBTCgqEqTcmst30YxBWEzIz/w/qaXRYD72Jmob3SMXK2dJnnT77y2DvuqTJ7YAxLjJP0onvh4CE+yj/ZItHDzYloVbwLHNlEa/o9jVurNJWbcj+sEXKXvekdjxSdmxC/0M0Kur3pbhelTLFdmVvAVMc6U/m+djJIDUH7uUn8HkEoWI/681Qba5Oc/t+l4r1C6PP/Ws+9t7aoF7H+vsWIiRrNzfYlTegd/xsODVSMQhOwaZc2qfZJJP5SHJy5DE6XnOoo/YH3nk51k/k5wK0U7zSHMjZ3paUYF+2ZS4wgxOFqaSaigZycaeDtEZNODz4bpVnNL7BBvXDPBOCj0T6IRKpYkWgFoi0oUVi2q2EbBr200HtfqDOKYa31qNUNfHaLjEXW/OMVwcSWCOV7gwaLpjoueWXlFGfi7xqCwVvn98BBDHNMNThFcYbDxQYH/JnXfw/vO4gKdvtqEPZiXNEAmrjYxGVGjOXAa72cTjgASnaLZWu/FzN7YFjdgDRAeYPlda71Ys4rW9pLCRAHxcX3DhnQsh2GtldBTeqgaPXNkTPsm/0GZO8novozZHsULl3Xypdpbtji5WGbv10/LE1ffdH5H+Z3YtvQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR03MB8453.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(22082099003)(18002099003)(3023799007)(38070700021)(4143699003)(56012099006)(11063799006)(261026121527099003)(261021135927099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?NQC9C23toqQo0jEFkDkmwOzwYCyefxAU4u6xtDS2knAvNqn5HUJKza1VFv?=
 =?iso-8859-1?Q?tyi0xSdF+XJiHDtDkYBSQbhB3z/XaXl3Zcg00tV2SG7WNoVXAmOeXM92H0?=
 =?iso-8859-1?Q?2CSOYeH/lo+nNyQOSklR8RTPa1TyMIfyZu/wXuq7srEPxlJFu3NWlBge6n?=
 =?iso-8859-1?Q?vvcE0ZME7LC7XlCfiibRip2jlE6C8SWfn3zM6u//q7Zt4XtYTNeK1JQVbl?=
 =?iso-8859-1?Q?JXat8mnJE9UKDb8Bl6lOIRaf8G2EIefVNVDiW3IrvZyFXziqiOk+FGMj3v?=
 =?iso-8859-1?Q?t+859xwPVa0lLzYvg5HRKPydHq/mMbMYLfXf/EIti0K3sdSWFc6D06RRmq?=
 =?iso-8859-1?Q?MQ2n6SOb0djOfO98Gcd3C6NCCauTvwk6VsmmF4QyocI37LN/JpUqmYu8oA?=
 =?iso-8859-1?Q?FB//S3+vSCfffJyw4lcYPY4pKMl9cqFapmREsT6vkloanQb6nIERcgStSq?=
 =?iso-8859-1?Q?4Tjz++dY3QGLmG8Dvna1wbtp5LNqXyK9dq4gE/hNRwjYaH49UJhS9ZB/Zc?=
 =?iso-8859-1?Q?gVcn77aQ2dkoRj8HU48WXdX/ofs7TDLRxRg9bpWFj3uIU2+oLVSdSrLFXR?=
 =?iso-8859-1?Q?F0JGdx9C2Qs/pDldGGeFrQ3UQ1FuuSv1zmb/mHX3GhsmFr/citcgziUtfv?=
 =?iso-8859-1?Q?INa4hycxT+ogIBSZk7kRcLiOt3bwUnYgNxYN4x2gLT90OXlTEbInhCQar/?=
 =?iso-8859-1?Q?AVfATKzuebyth9+tG/kM7gO27IOZBkqe6dEhUxYfZYHK80oYQaprmDpcWs?=
 =?iso-8859-1?Q?kGHNNkMCp3oYHQIoIqWq3fnvMdhm/XRE/BOMA5pq5442rLQWHpNujZgSOj?=
 =?iso-8859-1?Q?uRytaCzL1NQgeSPJj1zipYkjJE7Y4vjY3j39dwAaUgyVpXVdNiG2fMn9m8?=
 =?iso-8859-1?Q?QdlHUCLjZ3p8mprDTS3+MSHrBrI3xy/Cb83C5lD4ILaqR+82TGNKRTqnf2?=
 =?iso-8859-1?Q?f4G6QlnusYpqIZjWIvgRQITyoTyL0i+cdP4A2yHkNi8Yc51mwv5donPd8Q?=
 =?iso-8859-1?Q?SidM3LqYImL4XetWS6M++4q9fIQ5HH2laAN0PDJns84854kb7ySzS2N9pQ?=
 =?iso-8859-1?Q?gw4vT2oFBbOjYLKQgcsxpZqPoXrhb22bij6bhYpEvWNUDX4hB4n/vc1266?=
 =?iso-8859-1?Q?QQtscLUGnz5VnLUNd6vFeBF4qZT9U4AO5GkyQZVWkEDV/dsVfr2PeO7YzO?=
 =?iso-8859-1?Q?jHx5leVeHk7Q7aaxu2w/CkNby4Ejs37Iib+m29OL15e9wzCKcwYjjzPlOE?=
 =?iso-8859-1?Q?s5q7rNs6hwoiY6R2UrWozYO4j20rKUdzunKOqhkHZxDHzSweqdwGt6/gjJ?=
 =?iso-8859-1?Q?AMTmp4rxoZHj0pym+cc9chg7ar6JTepa7nc0EHjz5VE22byBiSi6YD7qM9?=
 =?iso-8859-1?Q?LUFxVbMeZxvnnJPFLCBtS53GXokk8GC+ZK5cbe063weoiEnW7WHRh2mzNT?=
 =?iso-8859-1?Q?z1U325pj/ESN73tcnFBh4Ptrtd/Xntj+GOazrySxV/Oex0kPL7+UaDADFY?=
 =?iso-8859-1?Q?a83UFS2LqZhSJqnNIZZBf3FQzxJ5wItoU/Qenp18eAQWtfWuOdnpCDK++J?=
 =?iso-8859-1?Q?mVmSNEb2Pw5nFnUcLampvHFvkG5YdXOJELCA6Y1rhr6/Crh3IpcEFwoXg8?=
 =?iso-8859-1?Q?ijw7AsdN7KKuUXblqzaFBTkkCHi+AYLz/Mx8JphGOunORksR1VShaGQKLw?=
 =?iso-8859-1?Q?Gk0r0phrdTNLmqBhv+f/N0npt7nWSYtjtT4ciNzYGCyIxUJaSIE8aO3SGV?=
 =?iso-8859-1?Q?YF2RXqndSes6dHOa1g+VX5QnWNCZOUqp8szDZzyd7K0MfVLrGxIki+N1Mw?=
 =?iso-8859-1?Q?B0OBSjRKiw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
	jHY71lJU0jF7v8c9o4ZehsmZfEci0IAhN2d5uJvFC7pbRvK5qeO/zJOfRy2nUiHA/IKun+afrU3mQBiTu5Aw7nDVOSHBbdWs/Isc1Ko3j7p6rJV88S3entQh/9BcFBo0MNG4LNjQkXJ1zGuB/US0XF3e+4jb0deqBfgaSIMc5RKAxtaNJqbtwyy0KPUBoUB2Uj4cMXVO08W8hIu/IjoU7KgaFy+8kI9lk+ylfBXIReFVFFD+tbLaDbKRH57Qsg3l2iA0XK18ycWmFRSj03MhJN4acIttBCQieYGMm6e+37HpkQOwjEfPWixbNLe4pvG4GwrlZT7lxd+yPyHnYxEkRw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8453.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c6a20e-7e43-4d5f-9cb8-08df3a4a981e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 08:06:56.3723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XH+i8n3/o+ANuR1yNlbkYwhSrweqp+KQvZ2lJXYZ44Hs7OBBH6+0c6uPj4QJsiZsId3oEkw2tqDd0x2rGKw0K/zF/bNbnsOKti8ZBZF1ZJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR03MB8468
X-Authority-Analysis: v=2.4 cv=Ef5d0/mC c=1 sm=1 tr=0 ts=6aeae7a3 cx=c_pps
 a=UPJ12yLMGL5ZZCNrBMA7tw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ugNRTJOwpmtT476g4l8T:22 a=ZCnO6MNnUw9PNK2d_38A:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: khnNEY4Vg6jz5ceDuGxZgg0kXvxucMq4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzMiBTYWx0ZWRfX28PiK4JT2sdz
 1ZjVc5iCD8A4oqjY7fksR9a3K7XJcZQzKe5acJ6/cR30DQeY+0vY67NsD8gqjfF2kWcQUqV9EZ1
 G7fed7bUsl5fBSXMQLiOLx4x8AtjWvhvfgL3WvBZy0HCZMZ6hBfg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzMiBTYWx0ZWRfX5eHcSuBwtz0G
 qxmNBRS++xDSMhHedxfkxxR52MFljZCk4YDBgSoaVAK/x9qTkhl/iJzhlEfRNgvnqkLsPKKn5MZ
 WHDo/tMyesjf2okHF3jGi223hCetPGG16tzrWCPPXRJypcwt1mevKwZaP8iDRXklmAg1R3Vjxav
 hRb70kB3Ii/4IbuavT5KoGm1Ae0LOOTFLFkEqIE1We/iw6MQVjWXX5Ix3kYp85yXB3VGA/d/dr8
 DY68RyiRLLygHkF6p2fz3VXFsVeE7dnytQr8N2dUkXyroLhcN4aZZcmsBRhgEv5bKoBJeXr314a
 LI+yMclsyVElKokJaNZlBMMj2Holb1fQcK9vE9o1lJr5wRVcxMc00w4ZScduPvek/fnE7R+TXLx
 mhPnKU7smpAPUtgclNxQn3Khbf7yoku1JYOrArCC47FDejoH/hgX/GbdrM502mWJ1trgfmPPprS
 EBZjfvvXY0vyjhGvJaA==
X-Proofpoint-ORIG-GUID: khnNEY4Vg6jz5ceDuGxZgg0kXvxucMq4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 clxscore=1011 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040032

On Tue, Nov 03, 2026 at 20:49 UTC, Andrew Lunn wrote:=0A=
> On Tue, Nov 03, 2026 at 06:09:13PM +0200, Iustin Stolniceanu wrote:=0A=
> > The ADIN1110 supports two SPI host interface protocols: the generic SPI=
=0A=
> > protocol, which the adin1110 driver implements today, and the OPEN=0A=
> > Alliance TC6 protocol. The protocol is selected by the SPI_CFG1 pin,=0A=
> > which the device latches when it comes out of reset.=0A=
>=0A=
> Is it possible to read the status of this pin from a register?=0A=
=0A=
No, not for SPI_CFG1. The ADIN1110 has no register that reports the =0A=
SPI_CFG1 level or the selected host protocol.=0A=
=0A=
The only way to detect the mode at runtime would be to probe it:=0A=
read the PHYID register using one framing and fall back to the=0A=
other if the value does not match. I have not tried that yet, and I=0A=
am not sure that clocking a transaction in the wrong framing is=0A=
harmless for the device, so I went with a DT property describing how=0A=
the board straps the pin.=0A=
=0A=
If you would prefer autodetection, I can try it on hardware for V2.=0A=
=0A=
Thanks,=0A=
Iustin=
