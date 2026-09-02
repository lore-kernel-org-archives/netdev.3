Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B45C41A926;
	Wed,  2 Sep 2026 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.183
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788385264; cv=fail; b=oD183nxDZewr/M9Enh6960DIqvnJ3YFCh5KokRIyMZNzy13ZGEkHLJ6uCCh5B1hqfjMmTh8kCz5aGHE+x5E7URw9N5BsvMGeUKoivFx9nmvBvpFP/meJPOUKSyD21hKp24vxoUPAvWSy9rJ0TIdTFLWNMAfeUe9NwGSKObADO7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788385264; c=relaxed/simple;
	bh=I1vkIPN8No6m0k2wcWX1mLch42Uax3T4shEq43an3BA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HkenjDlLUuhBBOGQfGtTrLBD66W046i+rPyDvcTnbKp9XQI6m3FkYPmLgsred+zveB+5xntkBkxc3KeE4C0IMl9O4S0MF+/sxaP4zTLqO/sJWPfBf1yUdDobSLdC9u3GvbjcMv1+EWU+Mqn9MF62EOcwXHoCxnbg84KcMOqPrkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=NybLTPKG; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=b4uT70Pw; arc=fail smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="NybLTPKG";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="b4uT70Pw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=eEeoN04dPv+JerQ0uNv9rLagqEOA0aRjNOC4lg1xntU=;
 b=NybLTPKGQtMhx54IS1UCqBwH8t0Oop8qFZ++tGJ3iKtNYAefWiVPiOqwOD1cTXhtW0cZ+fm9D2l9SzEX5Gme9L9kH5+bxyxSwqy6SQNmdC7FBmmY/5NjTX6OQQMvjeNNiVkfZCygWBcQgkQYCU+fQ8MwIypr0LXiQXddbkVHsHLQpaUxoST5Wg92je6lMaApaIbvJkXbkPDS+50qVeq3xZhP6iQSjEdKcFnbZGMybDMxPfxgM4PUdAv/yEeFVjmJdp2vVqMxuO2a6AlqKNRBoomQNfdQZRvlgtREUOnZEf3m2bZ5b0gVL6i1VuzgP2zjO/Ixcbo7d6gNNlROtJM9Mg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020096.outbound.protection.outlook.com [52.101.85.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id B4CC424006B;
	Wed,  2 Sep 2026 21:40:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdpHiXyKzp14WjPt2QAqmInfoL/G2kHKs/G0la1h77KC+UKWqyr4G1fuNJV/9IIL0tsJqbem+4xfNamcbgHTAdO5NJuIjbjWNT4ODfLDpodrzHaxAB45uiroXKwZEU39MUnGmcWR27Z+Tv7vfDQ4PSzOLnnBbcZo0UtMMAsHBjz9gHRZzJSkQKVSwJQu4EhMxMT/dYV7HLO9h3xnwK+KMuXnWY+cMfwT1bdfpWlpWJwBb+mHJ/hhlfVKayk6TBG1Xb5Ey2rhUmrQK3CWAfUPBHSX3OVQUamowfIv7Hxin8UmibEYQ+YOtUEGlMFn7kokXhvqiCxWSg91Xu3lDp3VfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEeoN04dPv+JerQ0uNv9rLagqEOA0aRjNOC4lg1xntU=;
 b=QTAgYjT0IzETP4ttOm43YeNeKIPrUx88CJRvEMm5hBbnM5AWjyOyeJ9QqQgZuRxeOXFBtVvXcCAtmL9JnykWhbzj3u7ry5H/GQ9XGbAxnAdoMItVPQH9cw3L5kJSd75bcBc9li3AStWq9F1GDIu9cnBzgXw9ghUMhqnQJj5sAqfFa7XsXzCqP+icRe+nGoEx4OPxFbn7X3rizbQdJuX3fHK8wtmPV7wfxT3N+T0qpAoqgmyKdsBa46L8m0XbVKRZRVq5uIxWHrSbfga8rqj8ZIZ2q2j9bhSXCxo3yI3DyRZYRMvN/7CdABKnptm0X6rBU0p8GhSD9G3az/irX6vFIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEeoN04dPv+JerQ0uNv9rLagqEOA0aRjNOC4lg1xntU=;
 b=b4uT70PwGEJS4bCjJ4EiVXNdSvCsNuVSDOBvG4rV9hB9/siPyZAnsfWKNHkhUWwjiW76wjNv6EQWirBSTFW4Beb4btNaSV0GRr0mTNXMoGIzl1oRKSFx2/rNKLjwI6ywgRIjQsSbRSax7ANdP9vtHAvW+ZRxPuiP6Cf18IdDLTVy5vCNpleBr2CcevRNzXt+RhBn2UGy0opdc7umi61z187U1pP4JkKjDU1B1AuXX9o6Rmw2fsOYdY195VWsGInsigKfph7HXuzhxlwVPY/IQ9XVU6JY/5jmsqoeObFky9y0pvulpKSZCKtY6b0mMwn8otz9pcikHVXobQQHUJbNHg==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS7PR20MB4877.namprd20.prod.outlook.com
 (2603:10b6:8:97::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 21:40:33 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 21:40:33 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "Oleg.Zadorozhnyi@devoxsoftware.com"
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ali Rouhi <arouhi@sitime.com>
Subject: [PATCH net-next v8 03/15] dpll: add basic SiTime SiT9531x support
Thread-Topic: [PATCH net-next v8 03/15] dpll: add basic SiTime SiT9531x
 support
Thread-Index: AQHdOyOu5s1ccX3ED0ePRcFt1M9LwQ==
Date: Wed, 2 Sep 2026 21:40:32 +0000
Message-ID: <20260902214030.20955-4-arouhi@sitime.com>
References: <20260902214030.20955-1-arouhi@sitime.com>
In-Reply-To: <20260902214030.20955-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|DS7PR20MB4877:EE_
x-ms-office365-filtering-correlation-id: dbde10c2-e13f-4f5d-8d74-08df093ad112
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|3023799007|38070700021|6133799003|10067099003|5023799004;
x-microsoft-antispam-message-info:
 9rT8ws/mPHxg8XqS45+4xvTJYkwy7aWF2/+NwMrSrurHMoyxH+N7warg7KCK8wi+1g83ljxx6dQjdfBo2C/OdMQZDqk07nf+ySADBGJaWRQWRn8bai60AmX48KG7uxIHI/kIjUMrx0UmDejSbQ0lHl1sreSGNZ337cQ1O4VBtCS5GMF4auG55COUaz9a/q+2sU7H6He4ycorhNygeMPwFAcTKpitA3UVIcdHS0cHUB5mo+UmzzKuG3iR9+IWKVGIsjDviJ4ujJ4/HEXADAiqnaFGeYHvNuR7Jox2+mmfbqxRN/PviotwlSONdOe9WqiuF6AG9PVhh0NUnl8apR61gJlO0Uq328sRqkSOIMH3u6TBSDqr7u/berXoDecD0iLjLGpwUnXgibzY/BFwZH5OJttYZAC3XgdOH7IqjfTUpPKESFWw5gKii4EvARCtmpXfrNLBuRg/lFaFtOIN7irtDJFMdIgcGRskG9hiV1XQFbgDmlVOfBzqABRoiRcjz5jWivmSumcO4/Hia+jTPY7VXrsXOlwzoGgcsZO51+6t3c9kT1o6UNPJDgfsXa/5d3kmT8ic7nbNmVQmx0NnZJUM8LKUnYvx0tnUUayC2Jc7zq0uR1ddVuS6ztIivBzHsgmBaoTCxW235CB1VNgjN0VCCu7uIdoUMSjNS9QD38rKmw1AQQwfP4+aQgFpg0Kf7SworjBfWiKdLqArdRMa5L1tyDznCUDQXCt+ngVCJHRudvM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(3023799007)(38070700021)(6133799003)(10067099003)(5023799004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Ohd6XKdYnsAA3rsmvu0KZ/cGev+mEEMoaxRsmEdYKdfz8D3xwhwkg2dfpM?=
 =?iso-8859-1?Q?6V7gPTZT0fk2ZqOjQ/CMxz0KxuCkt84Q9FWqe1mpRQnrELqbNJdkJGG8Sr?=
 =?iso-8859-1?Q?YAChnqD9MWkTNxUW8FnX4WSUYRAEs93hYE/kUcaZ6KXyeOKljZRuowCcrM?=
 =?iso-8859-1?Q?FO69eKZiTsDzL0ujz1MzfBel7zmIHss89SKMdy15fAIObEOknZNDrW70Zy?=
 =?iso-8859-1?Q?OOAxOSVAKxJXAr1u/FKf6uVGNCRYDxyLT8jHBQ4/O3v6MiOnwF4RRxU+kC?=
 =?iso-8859-1?Q?NIduMN9UeHHg/tGcTh3sNAOGBUpTrNkVu1MjMf5PlzMrD9zMXELzUO/aM8?=
 =?iso-8859-1?Q?Ef8bh/m9x2bQfLZfGHm1To8M+WABXV2YFwz5h+MnX0J8uxHvkhCCZawkFx?=
 =?iso-8859-1?Q?c3+c+6ESfLiEPHbxNcj5nny74yEgd+ny2j8yWhNEUSzrkNQ2pTA5dHK1uO?=
 =?iso-8859-1?Q?CdoCkvbyIDKRIkeDcMQ6Oypt233vDIl56AkpvsY1LANkB+uIN0ljvn6l4P?=
 =?iso-8859-1?Q?maGMp7aHw7h+X4Em3fp1Ic8jSNqtAv+p4UrIqSf+TF8X+gY5Y/ZTeL/bw+?=
 =?iso-8859-1?Q?dXVgGiTwyJQ//dHP7FZEXHX3Mtv9fU1OtU7S/SVjX+H5JUgRmvQF6ACk9l?=
 =?iso-8859-1?Q?R4Oda4k5BUjBfC6YLD+aSQXD9dNzq1quSL5KRZr5WdeA1CjO/5Pn++hfDN?=
 =?iso-8859-1?Q?c2i4PMxHEmfrCfXPLBg/Lm+19P3fnMpyk6lNwuKcQPDbcgMR0vlc4jMHJw?=
 =?iso-8859-1?Q?IwzyWH8y7Utlc1+y0eC45lyEkU6gxewVJwXmn+Oao/a4f5BAZMYmXQlQYs?=
 =?iso-8859-1?Q?VBEstosmObOhpZptmqBx2csnY+fIoCwCbiGk1RUOPHpLXMxkr4UoUUUrc6?=
 =?iso-8859-1?Q?iC1QSykIE0dMW+UWVKIBbapYmXlSh8QeJpA1h7lXzY41KRe3GotNMGuMaT?=
 =?iso-8859-1?Q?q0KmtKjPl2x1Wa3fgY7m9sjjgKKTWe+FsSfx+wOLt+B8gF0j7x2Jwl//NV?=
 =?iso-8859-1?Q?pQKtBltPshLha6LDiJqBMlleZKDHEgQQ+S0KRxjkLhlRzNTtjEkt1yzRpk?=
 =?iso-8859-1?Q?cCAiJwa3t2dehecqASiDr1NyeWuTOH5i8G9zoDnIUmK0pp3XWV9bn53Iio?=
 =?iso-8859-1?Q?Y9Ond11phRONZ0o4m2YcPHhrrx6u+AWIBHReEHCJeD6wENhx+5d6NIgSbh?=
 =?iso-8859-1?Q?+GcHie9kYIAhuaKGCb3hkFLpqV+7UfqZMCYKBL6fC9L5p4XXMFGcBqs9Me?=
 =?iso-8859-1?Q?FeSYALCJBYsZC5kkeMuPfsF0uKuawvY2/z3fXzWX5Ds5JTFnJrBlsau6QJ?=
 =?iso-8859-1?Q?yNoIlJLzM0I687ssLkhCQ+kk5cXlDSrTgAQhHlB5UzW5jyB3vMseuWvKj0?=
 =?iso-8859-1?Q?o1YWu8SGIzOV8ERevcekOaILBEmYM23pnLYHAHBqiFt+pcwCTdwbKW5Cxf?=
 =?iso-8859-1?Q?VSvaSzlLVxpx+b6BDXAUagphLHAHKlvKJ0A71w82KrZBN6o0k4HyJxc93w?=
 =?iso-8859-1?Q?6aQo8dXif22y/glwLBuixdl3HGNhVv3jpVv0JA4VVx4cTq76BVrNP1EHR4?=
 =?iso-8859-1?Q?9i4uXZhDBuWaIAFKPZXkRsv33/O4kTyA2P4kVns9ODD6yIhSAZo5uYUmdy?=
 =?iso-8859-1?Q?rBvsplRxjkfsFosG33xCFgY+++7G5g8PkkojiGvJXagcSpYqzv8JG4qp/u?=
 =?iso-8859-1?Q?LHNxT2aFcuSLY+d4k5te21OZJv2EHRdn/ggjvA4kHCwwE/KPMpfyPRdc0a?=
 =?iso-8859-1?Q?Cjlp+qXCYmzFliNNSLfPFMS2yiD3Bj9CZX93N1UI9txjHi?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	dN8LtZYO0zwhPNeCuvUlvkWF9Gr4jY/U6X+3vKyS+h9W4bCY5cjLivYtVYSlFPZdJuvVtQ3MoezXa2vhLM9SjH6hqmDNtRbSqk8yJye9EbFxjTw9JQ5x91lw+A4BMkBypP2O1BtvyTswwq5c3ZBTT3WnUaKsCA3f+kutMR/ldqD7Agr5T36xgWNIH6IlJABL6ohwVVmxm2dCjb4+60JDil6gYec/oRTMlT2BEw7lpGO1bUIkkWwUdEXR3RvQS4wePffNuf15h3cO7eZkIax5MLFWCnudH62RuNKa6afOTdjeyv4LgdCPB+bXUDpUfh1I7TlTDQJwKSCqXBGBpwIxKA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbde10c2-e13f-4f5d-8d74-08df093ad112
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 21:40:32.9557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hAX7syPc/KQjxp3n61wTho5XtjBCiCA9ex0GWa5rUMDpMp/MSiVhBv22YFI0enR4jbYqDD16vsiXN+00ruSIvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB4877
X-MDID: 1788385237-WYZkq9sKEUcK
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1788385237;WYZkq9sKEUcK;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
The SiT9531x is an I2C clock generator with four independent PLLs, up to=0A=
eight input clocks and up to twelve outputs.  Later patches register the=0A=
PLLs with the DPLL subsystem and expose the clocks as pins; this one adds=
=0A=
only what is needed to reach the device.=0A=
=0A=
The register space is paged: 32 pages of 256 registers, selected by=0A=
writing the page number to offset 0xFF, which is present in every page.=0A=
A regmap range configuration describes that window, so the rest of the=0A=
driver addresses a register as a page and an offset and never touches the=
=0A=
selector itself.  Pages come in pairs for the PLLs (0x0A/0x1A for PLLA,=0A=
and so on).=0A=
=0A=
Probe reads the rate of the crystal feeding XIN, since every frequency=0A=
the driver later computes derives from it; takes the optional reset line=0A=
and leaves it deasserted, because the device configuration comes from=0A=
efuse or from a blob applied before probe and a reset would discard it;=0A=
then identifies the variant from the single byte at page 0 offset 0x02=0A=
and refuses to bind on anything unknown.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 MAINTAINERS                    |   1 +=0A=
 drivers/dpll/Kconfig           |   2 +=0A=
 drivers/dpll/Makefile          |   1 +=0A=
 drivers/dpll/sit9531x/Kconfig  |  17 +++=0A=
 drivers/dpll/sit9531x/Makefile |   4 +=0A=
 drivers/dpll/sit9531x/core.c   | 271 +++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/core.h   |  91 +++++++++++=0A=
 drivers/dpll/sit9531x/regs.h   |  60 ++++++++=0A=
 8 files changed, 447 insertions(+)=0A=
 create mode 100644 drivers/dpll/sit9531x/Kconfig=0A=
 create mode 100644 drivers/dpll/sit9531x/Makefile=0A=
 create mode 100644 drivers/dpll/sit9531x/core.c=0A=
 create mode 100644 drivers/dpll/sit9531x/core.h=0A=
 create mode 100644 drivers/dpll/sit9531x/regs.h=0A=
=0A=
diff --git a/MAINTAINERS b/MAINTAINERS=0A=
index ef07a53b5fc4..73cc0634c213 100644=0A=
--- a/MAINTAINERS=0A=
+++ b/MAINTAINERS=0A=
@@ -25162,6 +25162,7 @@ M:	Ali Rouhi <arouhi@sitime.com>=0A=
 L:	netdev@vger.kernel.org=0A=
 S:	Maintained=0A=
 F:	Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml=0A=
+F:	drivers/dpll/sit9531x/=0A=
 =0A=
 SL28 CPLD MFD DRIVER=0A=
 M:	Michael Walle <mwalle@kernel.org>=0A=
diff --git a/drivers/dpll/Kconfig b/drivers/dpll/Kconfig=0A=
index be98969f040a..f8f7ca121b93 100644=0A=
--- a/drivers/dpll/Kconfig=0A=
+++ b/drivers/dpll/Kconfig=0A=
@@ -23,6 +23,8 @@ config DPLL_REFCNT_TRACKER=0A=
 =0A=
 	  If unsure, say N.=0A=
 =0A=
+source "drivers/dpll/sit9531x/Kconfig"=0A=
+=0A=
 source "drivers/dpll/zl3073x/Kconfig"=0A=
 =0A=
 endmenu=0A=
diff --git a/drivers/dpll/Makefile b/drivers/dpll/Makefile=0A=
index 9e7a3a3e592e..4adc50d748d4 100644=0A=
--- a/drivers/dpll/Makefile=0A=
+++ b/drivers/dpll/Makefile=0A=
@@ -8,4 +8,5 @@ dpll-y                  +=3D dpll_core.o=0A=
 dpll-y                  +=3D dpll_netlink.o=0A=
 dpll-y                  +=3D dpll_nl.o=0A=
 =0A=
+obj-$(CONFIG_SIT9531X_DPLL)	+=3D sit9531x/=0A=
 obj-$(CONFIG_ZL3073X)	+=3D zl3073x/=0A=
diff --git a/drivers/dpll/sit9531x/Kconfig b/drivers/dpll/sit9531x/Kconfig=
=0A=
new file mode 100644=0A=
index 000000000000..47aea8674327=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/Kconfig=0A=
@@ -0,0 +1,17 @@=0A=
+# SPDX-License-Identifier: GPL-2.0-only=0A=
+=0A=
+config SIT9531X_DPLL=0A=
+	tristate "SiTime SiT9531x DPLL driver"=0A=
+	depends on I2C && NET=0A=
+	select DPLL=0A=
+	select REGMAP_I2C=0A=
+	help=0A=
+	  Driver for SiTime SiT9531x family clock generators=0A=
+	  (SiT95317, SiT95316).=0A=
+=0A=
+	  This driver registers each on-chip PLL as a DPLL device=0A=
+	  and exposes input/output clocks as DPLL pins, providing=0A=
+	  runtime configuration via Generic Netlink.=0A=
+=0A=
+	  To compile this driver as a module, choose M here: the=0A=
+	  module will be called sit9531x.=0A=
diff --git a/drivers/dpll/sit9531x/Makefile b/drivers/dpll/sit9531x/Makefil=
e=0A=
new file mode 100644=0A=
index 000000000000..a221fe55386a=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/Makefile=0A=
@@ -0,0 +1,4 @@=0A=
+# SPDX-License-Identifier: GPL-2.0-only=0A=
+=0A=
+obj-$(CONFIG_SIT9531X_DPLL) +=3D sit9531x.o=0A=
+sit9531x-y :=3D core.o=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
new file mode 100644=0A=
index 000000000000..f355b08aebca=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -0,0 +1,271 @@=0A=
+// SPDX-License-Identifier: GPL-2.0=0A=
+/*=0A=
+ * SiTime SiT9531x DPLL core driver=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ *=0A=
+ * I2C probe, paged regmap configuration and register access helpers.=0A=
+ */=0A=
+=0A=
+#include <linux/bits.h>=0A=
+#include <linux/clk.h>=0A=
+#include <linux/delay.h>=0A=
+#include <linux/dev_printk.h>=0A=
+#include <linux/device.h>=0A=
+#include <linux/gpio/consumer.h>=0A=
+#include <linux/i2c.h>=0A=
+#include <linux/kernel.h>=0A=
+#include <linux/module.h>=0A=
+#include <linux/regmap.h>=0A=
+=0A=
+#include "core.h"=0A=
+#include "regs.h"=0A=
+=0A=
+#define SIT9531X_CHIP(_id, _nin, _nout, _name, _map) \=0A=
+	{ .id =3D (_id), .num_inputs =3D (_nin), .num_outputs =3D (_nout), \=0A=
+	  .name =3D (_name), .clkout_map =3D (_map) }=0A=
+=0A=
+/* Per-variant output index -> physical slot mapping */=0A=
+static const u8 clkout_map_95317[] =3D {0, 3, 4, 5, 7, 8, 9, 11};=0A=
+static const u8 clkout_map_95316[] =3D {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, =
11};=0A=
+=0A=
+static const struct sit9531x_chip_info sit9531x_chip_ids[] =3D {=0A=
+	SIT9531X_CHIP(SIT9531X_VARIANT_ID_95317,  8,  8, "SiT95317", clkout_map_9=
5317),=0A=
+	SIT9531X_CHIP(SIT9531X_VARIANT_ID_95316,  8, 12, "SiT95316", clkout_map_9=
5316),=0A=
+};=0A=
+=0A=
+#define SIT9531X_RANGE_OFFSET	SIT9531X_PAGE_SIZE=0A=
+=0A=
+static const struct regmap_range_cfg sit9531x_regmap_range =3D {=0A=
+	.range_min	=3D SIT9531X_RANGE_OFFSET,=0A=
+	.range_max	=3D SIT9531X_RANGE_OFFSET +=0A=
+			  (SIT9531X_NUM_PAGES * SIT9531X_PAGE_SIZE) - 1,=0A=
+	.selector_reg	=3D SIT9531X_PAGE_SEL,=0A=
+	.selector_mask	=3D GENMASK(7, 0),=0A=
+	.selector_shift	=3D 0,=0A=
+	.window_start	=3D 0,=0A=
+	.window_len	=3D SIT9531X_PAGE_SIZE,=0A=
+};=0A=
+=0A=
+const struct regmap_config sit9531x_regmap_config =3D {=0A=
+	.reg_bits	=3D 8,=0A=
+	.val_bits	=3D 8,=0A=
+	.max_register	=3D SIT9531X_RANGE_OFFSET +=0A=
+			  (SIT9531X_NUM_PAGES * SIT9531X_PAGE_SIZE) - 1,=0A=
+	.ranges		=3D &sit9531x_regmap_range,=0A=
+	.num_ranges	=3D 1,=0A=
+	.cache_type	=3D REGCACHE_NONE,=0A=
+};=0A=
+=0A=
+/*=0A=
+ * sit9531x_read_u8 - read an 8-bit register=0A=
+ * @reg:	register in SIT9531X_REG(page, offset) form=0A=
+ * @val:	output value=0A=
+ */=0A=
+int sit9531x_read_u8(struct sit9531x_dev *sitdev, unsigned int reg,=0A=
+		     u8 *val)=0A=
+{=0A=
+	unsigned int tmp;=0A=
+	int rc;=0A=
+=0A=
+	reg =3D (SIT9531X_REG_PAGE(reg) * SIT9531X_PAGE_SIZE) +=0A=
+	      SIT9531X_REG_OFFSET(reg) + SIT9531X_RANGE_OFFSET;=0A=
+=0A=
+	rc =3D regmap_read(sitdev->regmap, reg, &tmp);=0A=
+	if (rc)=0A=
+		dev_err(sitdev->dev, "Failed to read reg 0x%04x: %d\n",=0A=
+			reg, rc);=0A=
+	else=0A=
+		*val =3D (u8)tmp;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_write_u8 - write an 8-bit register=0A=
+ * @reg:	register in SIT9531X_REG(page, offset) form=0A=
+ * @val:	value to write=0A=
+ */=0A=
+int sit9531x_write_u8(struct sit9531x_dev *sitdev, unsigned int reg,=0A=
+		      u8 val)=0A=
+{=0A=
+	int rc;=0A=
+=0A=
+	reg =3D (SIT9531X_REG_PAGE(reg) * SIT9531X_PAGE_SIZE) +=0A=
+	      SIT9531X_REG_OFFSET(reg) + SIT9531X_RANGE_OFFSET;=0A=
+=0A=
+	rc =3D regmap_write(sitdev->regmap, reg, val);=0A=
+	if (rc)=0A=
+		dev_err(sitdev->dev, "Failed to write reg 0x%04x: %d\n",=0A=
+			reg, rc);=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_read_pll_u8 - read a register on a PLL page=0A=
+ * @val:	output value=0A=
+ */=0A=
+int sit9531x_read_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			 u8 offset, u8 *val)=0A=
+{=0A=
+	return sit9531x_read_u8(sitdev,=0A=
+				SIT9531X_REG(sit9531x_pll_page(pll_idx), offset),=0A=
+				val);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_write_pll_u8 - write a register on a PLL page=0A=
+ * @val:	value to write=0A=
+ */=0A=
+int sit9531x_write_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			  u8 offset, u8 val)=0A=
+{=0A=
+	return sit9531x_write_u8(sitdev,=0A=
+				 SIT9531X_REG(sit9531x_pll_page(pll_idx), offset),=0A=
+				 val);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_update_pll_u8 - read-modify-write a register on a PLL page=0A=
+ * @mask:	bits to modify=0A=
+ * @val:	new value for masked bits=0A=
+ */=0A=
+int sit9531x_update_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			   u8 offset, u8 mask, u8 val)=0A=
+{=0A=
+	unsigned int reg;=0A=
+=0A=
+	reg =3D (sit9531x_pll_page(pll_idx) * SIT9531X_PAGE_SIZE) +=0A=
+	      offset + SIT9531X_RANGE_OFFSET;=0A=
+=0A=
+	return regmap_update_bits(sitdev->regmap, reg, mask, val);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_get_regs - get force mask and state register addresses=
=0A=
+ * @index:	logical input index=0A=
+ * @force_reg:	output force mask register address=0A=
+ * @state_reg:	output state register address=0A=
+ *=0A=
+ * Selects the correct Page 0x02 register pair based on the pair's=0A=
+ * signal mode and the lane (P/N) the index refers to.=0A=
+ */=0A=
+=0A=
+static int sit9531x_read_variant_id(struct sit9531x_dev *sitdev, u8 *id)=
=0A=
+{=0A=
+	return sit9531x_read_u8(sitdev, SIT9531X_REG_VARIANT_ID, id);=0A=
+}=0A=
+=0A=
+static const struct sit9531x_chip_info *sit9531x_match_variant(u8 id)=0A=
+{=0A=
+	unsigned int i;=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(sit9531x_chip_ids); i++) {=0A=
+		if (sit9531x_chip_ids[i].id =3D=3D id)=0A=
+			return &sit9531x_chip_ids[i];=0A=
+	}=0A=
+=0A=
+	return NULL;=0A=
+}=0A=
+=0A=
+int sit9531x_dev_probe(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	struct clk *xtal_clk;=0A=
+	u8 variant_id;=0A=
+	int rc;=0A=
+=0A=
+	/*=0A=
+	 * Fvco =3D Fref * (DIVN + frac/2^32) with Fref derived from the XO=0A=
+	 * feeding XIN/XO_CLK, so the rate is needed before anything can be=0A=
+	 * computed from a divider.=0A=
+	 */=0A=
+	xtal_clk =3D devm_clk_get_enabled(sitdev->dev, "xtal");=0A=
+	if (IS_ERR(xtal_clk))=0A=
+		return dev_err_probe(sitdev->dev, PTR_ERR(xtal_clk),=0A=
+				     "Failed to get xtal clock\n");=0A=
+	sitdev->xtal_freq =3D clk_get_rate(xtal_clk);=0A=
+	if (!sitdev->xtal_freq)=0A=
+		return dev_err_probe(sitdev->dev, -EINVAL,=0A=
+				     "xtal clock has no rate\n");=0A=
+=0A=
+	/*=0A=
+	 * Held deasserted, never pulsed: the chip configuration comes from=0A=
+	 * efuse or an NVM blob applied before probe, and a reset would=0A=
+	 * discard it.  Must precede the first I2C access, as a board that=0A=
+	 * powers up asserted keeps the chip unreachable until released.=0A=
+	 */=0A=
+	sitdev->reset_gpio =3D devm_gpiod_get_optional(sitdev->dev, "reset",=0A=
+						     GPIOD_OUT_LOW);=0A=
+	if (IS_ERR(sitdev->reset_gpio))=0A=
+		return dev_err_probe(sitdev->dev, PTR_ERR(sitdev->reset_gpio),=0A=
+				     "Failed to request reset gpio\n");=0A=
+	if (sitdev->reset_gpio)=0A=
+		fsleep(10000);	/* internal boot after release */=0A=
+=0A=
+	rc =3D sit9531x_read_variant_id(sitdev, &variant_id);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	sitdev->info =3D sit9531x_match_variant(variant_id);=0A=
+	if (!sitdev->info)=0A=
+		return dev_err_probe(sitdev->dev, -ENODEV,=0A=
+				     "Unknown variant ID: 0x%02x\n",=0A=
+				     variant_id);=0A=
+=0A=
+	rc =3D devm_mutex_init(sitdev->dev, &sitdev->multiop_lock);=0A=
+	if (rc)=0A=
+		return dev_err_probe(sitdev->dev, rc,=0A=
+				     "Failed to initialize mutex\n");=0A=
+=0A=
+	dev_info(sitdev->dev, "%s detected, %u inputs, %u outputs\n",=0A=
+		 sitdev->info->name, sitdev->info->num_inputs,=0A=
+		 sitdev->info->num_outputs);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int sit9531x_i2c_probe(struct i2c_client *client)=0A=
+{=0A=
+	struct sit9531x_dev *sitdev;=0A=
+	struct regmap *regmap;=0A=
+=0A=
+	regmap =3D devm_regmap_init_i2c(client, &sit9531x_regmap_config);=0A=
+	if (IS_ERR(regmap))=0A=
+		return dev_err_probe(&client->dev, PTR_ERR(regmap),=0A=
+				     "Failed to initialize regmap\n");=0A=
+=0A=
+	sitdev =3D devm_kzalloc(&client->dev, sizeof(*sitdev), GFP_KERNEL);=0A=
+	if (!sitdev)=0A=
+		return -ENOMEM;=0A=
+=0A=
+	sitdev->dev =3D &client->dev;=0A=
+	sitdev->client =3D client;=0A=
+	sitdev->regmap =3D regmap;=0A=
+	i2c_set_clientdata(client, sitdev);=0A=
+=0A=
+	return sit9531x_dev_probe(sitdev);=0A=
+}=0A=
+=0A=
+static const struct of_device_id sit9531x_of_match[] =3D {=0A=
+	{ .compatible =3D "sitime,sit95316" },=0A=
+	{ .compatible =3D "sitime,sit95317" },=0A=
+	{ }=0A=
+};=0A=
+MODULE_DEVICE_TABLE(of, sit9531x_of_match);=0A=
+=0A=
+static struct i2c_driver sit9531x_i2c_driver =3D {=0A=
+	.driver =3D {=0A=
+		.name		=3D "sit9531x",=0A=
+		.of_match_table	=3D sit9531x_of_match,=0A=
+	},=0A=
+	.probe		=3D sit9531x_i2c_probe,=0A=
+};=0A=
+module_i2c_driver(sit9531x_i2c_driver);=0A=
+=0A=
+MODULE_AUTHOR("Ali Rouhi <arouhi@sitime.com>");=0A=
+MODULE_AUTHOR("Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>");=0A=
+MODULE_DESCRIPTION("SiTime SiT9531x DPLL subsystem driver");=0A=
+MODULE_LICENSE("GPL");=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
new file mode 100644=0A=
index 000000000000..76a2632f0ce4=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -0,0 +1,91 @@=0A=
+/* SPDX-License-Identifier: GPL-2.0 */=0A=
+/*=0A=
+ * SiTime SiT9531x DPLL core driver=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ *=0A=
+ * Device structure, register access helpers, and core function=0A=
+ * declarations.=0A=
+ */=0A=
+=0A=
+#ifndef _SIT9531X_CORE_H=0A=
+#define _SIT9531X_CORE_H=0A=
+=0A=
+#include <linux/gpio/consumer.h>=0A=
+#include <linux/i2c.h>=0A=
+#include <linux/mutex.h>=0A=
+#include <linux/regmap.h>=0A=
+#include <linux/types.h>=0A=
+=0A=
+#include "regs.h"=0A=
+=0A=
+#define SIT9531X_NUM_PLLS		4=0A=
+#define SIT9531X_MAX_INPUTS		8=0A=
+#define SIT9531X_MAX_OUTPUTS		12=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_chip_info - chip variant identification=0A=
+ * @id:		variant ID byte read from register=0A=
+ * @num_inputs:	number of input clock pins=0A=
+ * @num_outputs: number of output clock pins=0A=
+ * @name:	human-readable variant name=0A=
+ * @clkout_map:	per-output slot mapping (output index -> physical slot)=0A=
+ */=0A=
+struct sit9531x_chip_info {=0A=
+	u8		id;=0A=
+	u8		num_inputs;=0A=
+	u8		num_outputs;=0A=
+	const char	*name;=0A=
+	const u8	*clkout_map;=0A=
+};=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_dev - SiT9531x device instance=0A=
+ * @dev:		parent device=0A=
+ * @client:		I2C client=0A=
+ * @regmap:		paged register map=0A=
+ * @info:		detected chip variant info=0A=
+ * @multiop_lock:	serializes multi-register sequences=0A=
+ * @xtal_freq:		crystal oscillator frequency in Hz=0A=
+ * @reset_gpio:		optional reset line (DT "reset-gpios"), NULL if absent=0A=
+ */=0A=
+struct sit9531x_dev {=0A=
+	struct device			*dev;=0A=
+	struct i2c_client		*client;=0A=
+	struct regmap			*regmap;=0A=
+	const struct sit9531x_chip_info	*info;=0A=
+	/* Serializes multi-step register sequences */=0A=
+	struct mutex			multiop_lock;=0A=
+=0A=
+	u32			xtal_freq;=0A=
+=0A=
+	struct gpio_desc	*reset_gpio;=0A=
+};=0A=
+=0A=
+/*=0A=
+ * sit9531x_pll_page - get register page for PLL index=0A=
+ * @pll_idx: PLL index (0 =3D PLLA, 3 =3D PLLD)=0A=
+ */=0A=
+static inline u8 sit9531x_pll_page(u8 pll_idx)=0A=
+{=0A=
+	return SIT9531X_PAGE_PLLA + pll_idx;=0A=
+}=0A=
+=0A=
+extern const struct regmap_config sit9531x_regmap_config;=0A=
+=0A=
+/* ---- Core lifecycle ---- */=0A=
+int  sit9531x_dev_probe(struct sit9531x_dev *sitdev);=0A=
+=0A=
+/* ---- Register access ---- */=0A=
+int sit9531x_read_u8(struct sit9531x_dev *sitdev, unsigned int reg, u8 *va=
l);=0A=
+int sit9531x_write_u8(struct sit9531x_dev *sitdev, unsigned int reg, u8 va=
l);=0A=
+int sit9531x_read_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx, u8 offse=
t,=0A=
+			 u8 *val);=0A=
+int sit9531x_write_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx, u8 offs=
et,=0A=
+			  u8 val);=0A=
+int sit9531x_update_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx, u8 off=
set,=0A=
+			   u8 mask, u8 val);=0A=
+=0A=
+#endif /* _SIT9531X_CORE_H */=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
new file mode 100644=0A=
index 000000000000..8337f1235472=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -0,0 +1,60 @@=0A=
+/* SPDX-License-Identifier: GPL-2.0 */=0A=
+/*=0A=
+ * SiTime SiT9531x register definitions=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ */=0A=
+=0A=
+#ifndef _SIT9531X_REGS_H=0A=
+#define _SIT9531X_REGS_H=0A=
+=0A=
+/*=0A=
+ * I2C register model:=0A=
+ *   - Page select register at offset 0xFF, present in every page=0A=
+ *   - Each page has 256 registers (0x00-0xFF)=0A=
+ *   - Some pages are paired (e.g. 0x0A/0x1A for PLLA)=0A=
+ */=0A=
+#define SIT9531X_PAGE_SEL		0xFF=0A=
+#define SIT9531X_PAGE_SIZE		0x100=0A=
+#define SIT9531X_NUM_PAGES		32=0A=
+=0A=
+/* Helper macros for page:offset addressing */=0A=
+#define SIT9531X_REG(_page, _offset)		(((_page) << 8) | (_offset))=0A=
+#define SIT9531X_REG_PAGE(_reg)		((_reg) >> 8)=0A=
+#define SIT9531X_REG_OFFSET(_reg)		((_reg) & 0xFF)=0A=
+=0A=
+/* ---- Page definitions ---- */=0A=
+#define SIT9531X_PAGE_MAINSYS0		0x00=0A=
+#define SIT9531X_PAGE_MAINSYS1		0x01=0A=
+#define SIT9531X_PAGE_INPUTSYS		0x02=0A=
+#define SIT9531X_PAGE_OUTSYS0		0x03=0A=
+#define SIT9531X_PAGE_OUTSYS1		0x04=0A=
+#define SIT9531X_PAGE_CLKMON0		0x06=0A=
+#define SIT9531X_PAGE_CLKMON1		0x07=0A=
+#define SIT9531X_PAGE_PLLA			0x0A=0A=
+#define SIT9531X_PAGE_PLLA_EXT		0x1A=0A=
+#define SIT9531X_PAGE_PLLB			0x0B=0A=
+#define SIT9531X_PAGE_PLLB_EXT		0x1B=0A=
+#define SIT9531X_PAGE_PLLC			0x0C=0A=
+#define SIT9531X_PAGE_PLLC_EXT		0x1C=0A=
+#define SIT9531X_PAGE_PLLD			0x0D=0A=
+#define SIT9531X_PAGE_PLLD_EXT		0x1D=0A=
+=0A=
+/* PLL index to page mapping */=0A=
+#define SIT9531X_PLL_PAGE(_idx) \=0A=
+	(SIT9531X_PAGE_PLLA + (_idx))=0A=
+=0A=
+/*=0A=
+ * VARIANT_ID is a single byte at page 0 reg 0x02 (95317 =3D 0x17, 95316 =
=3D 0x31).=0A=
+ * Reg 0x03 carries an unrelated revision byte and must not be combined in=
to=0A=
+ * the variant identifier.=0A=
+ */=0A=
+#define SIT9531X_REG_VARIANT_ID		SIT9531X_REG(0x00, 0x02)=0A=
+=0A=
+/* Variant ID values (page 0 reg 0x02) */=0A=
+#define SIT9531X_VARIANT_ID_95317	0x17=0A=
+#define SIT9531X_VARIANT_ID_95316	0x31=0A=
+=0A=
+#endif /* _SIT9531X_REGS_H */=0A=
-- =0A=
2.43.0=0A=
=0A=
