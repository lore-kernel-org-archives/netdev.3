Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D384B826E;
	Wed, 30 Sep 2026 23:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811453; cv=fail; b=OMGHXCJMPQzMY4XhutrhcVEfRS5FZgZen4CYDEPU3ZLQ5JchQt4oYT1T+hauUEtSzyK6yb8LmlPJ0R6WZteLtB8X60+52BR0bzZjS/FXfm/vdqhK/eNy6/FdpeliunnJh415987Ytf4n5EO+0GSpSyCYds/hZOiDBk9JXjX8jCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811453; c=relaxed/simple;
	bh=p71mW5l4r6fCpPw/TxgsKIAjfTB3Vop5aqfnKPfg6nc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZTnAW1YtmQOoFg+jr51HUmrvssqlTmkv/WWC5iKE235+BwwcEq2hV3/y6HcXh7sk+BcLLX5dJRlF0McKE7r6dkGsSms/o0eJwdoTA+g35raE0+GBxp8j/Sf3E5LgFnelb605EPZAbzr42OITutrUZ2TWhkIm5mkjRhDLrf25iYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=UXN/TnwW; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=W9d5RLFZ; arc=fail smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="UXN/TnwW";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="W9d5RLFZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=nd4NRp4AalRYP1SUzR2GGFwxSa6AvsakYIQgONCigXg=;
 b=UXN/TnwWQi5LbSk+Fs2uoTR3PdCh5DYb+Bv+UH9Vfkg41gm09PTUMIxzxfLiAFutU89mYOs0J1TZjuTHfmvo1YOZsiBHBZSdqnbXmCZWQqjkDjm3ywLIa6RNRGmWPASqfXEwVTixNyHI+JexG1Mvf3G7s6rP5VYt1mRooDu98HA3BpvP9fwnfcb8Sv5IMUWClHaj7LJgbouBzBD3jevDTcOJE5fELvTnlOXjVHWq/xmJCZ9dUGXhBrZwtNT9cs8o45bCAkaaMhsTe/wk+S/KTwh9E5JgYld9lhJMVXsxFBGEdkzhp4n0PxN7RgkfA3Z1bDT95SAGAnTFZXu7K1q1mQ==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020097.outbound.protection.outlook.com [52.101.61.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id AFE7110005D;
	Wed, 30 Sep 2026 23:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=No360fGTl848ed3H93GtG/IXE2S66s/apfa8UGp6+lXdUKlGQ9RZp+ZcTVkwMxm7Y31EQNKo7BrH9s3ML4tXgf02YQ5pSuNJQtBqFTOYV9biT373lF6HcHz0DtCnt6wFMjTvnKQU+pXo+ePkV82Rsm7+wXCEAj+dzu7yOsWdtmpNvqzB1oRgCMnEYD8SI4RaqIrjerjaX6aLN0s2aBhDhTsn+aY6yRjjm72FaVaSeu0xJO6FaFYhIpmQUt16KSJbwWH0fxqZKCKTgDD/O29P43flYiJ583dMQCRQypV2tUhveBOh4s43G2GzUhwb0IIF7CgbiQLcW2hP6rbOPM3Rfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nd4NRp4AalRYP1SUzR2GGFwxSa6AvsakYIQgONCigXg=;
 b=oPmqssDgsysNlVMzXR1JibIQTY1UphD/jckVI2w6/vpfTq3qqEB8pRMfIgpKJE/TmDozr26a21AheFlNwfFTEiMbBvVNSXX/CfBOJv+L/zGWBchuk0MzSkCsiTuNIeYON6qqB1arOhj8/n9imKYQmxK3J2Hh00rxpcoDu8VCHl7H7C2bZqzIVkPt5EPnNoDSVeJcyDAQHx1LzskVqYW0wINHL3bUq9JY/BQ5V/Keh8V4wJ8y+cTCAWIJwsHyCEU6U6ZWuxYv9nBc0CObdAhk87NV1KP11MDc3PF6AkhVOxGqmxxqQrU6Y/7mbUKTfwjIUBHkQwbT9ROjMv32379y3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nd4NRp4AalRYP1SUzR2GGFwxSa6AvsakYIQgONCigXg=;
 b=W9d5RLFZUbbfxgB1KLCx9rXTgt9F0hbPwpltqXi4adVxcT1bslqfggC7MD+nt4mLEQHubAx6ScVkgEABIlRFzI2f8hie2lRiBmrwmYkTdlx6QGhbwA/5ShG2hayWLLsteW/P3OWa499yadNO9vsuBAH3J7qOqiPi01IpCMhFOiJeuSX+ymMr6X5KSuXv0t+6L7eVjzExqkRb0sGRxly65cvd+b7yz3Eki1m0RJB+i178uWgRNXNcHLvEjNKCS3UnPjrJhoJlt1zxfYTF0xD1JjVkI4ZRVRc0DM7D3jXz9Akh6PeLYkAxhyWDINPa8cYOw0UMqX6GTzVWjW9dF1yWFg==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by SA1PR20MB5383.namprd20.prod.outlook.com
 (2603:10b6:806:29e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 23:37:22 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 23:37:22 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "Oleg.Zadorozhnyi@devoxsoftware.com"
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v11 10/13] dpll: sit9531x: implement output pin state
 on a DPLL
Thread-Topic: [PATCH net-next v11 10/13] dpll: sit9531x: implement output pin
 state on a DPLL
Thread-Index: AQHdUTSkf1BcHEXMiUGwaPBnkwtavA==
Date: Wed, 30 Sep 2026 23:37:22 +0000
Message-ID: <20260930233714.87679-11-arouhi@sitime.com>
References: <20260930233714.87679-1-arouhi@sitime.com>
In-Reply-To: <20260930233714.87679-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|SA1PR20MB5383:EE_
x-ms-office365-filtering-correlation-id: 031240ee-a70e-488c-536b-08df1f4bc6c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|38070700021|6133799003|3023799007|10067099003|5023799004|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 URO+ObSI5/QTBe8v60a/ZT2okFq7DdRyaGeGAJawnH9ARsFxLuLpT1ySYYm/jnpt9Gthr+7bIZiHnzjyrOwbDv3OU3uV5bDGwOiOFV6gpZvqUKYorltwBjOxWkrjq2w5Neqwxp5zyKYPTx73i2pPgUswxDFCGEBHwP5dGVSAklELTStm1ek/Pq1p0LlCDDOXuLfaDEx8fwpKnLHnm+IPYUiPul9bF2qGYEZ0CljijYeQjq2FPLX126IR/H0PUDYAXVgGJoI2/7jeRUsyC5fuIYSyLgDR7V54GjYegOI8dj3YtzECtDvmk4g/KxNUXWaGNXNLtcs0Skvr5OTnOpdqsuqja1YLGEok1E6rGI6AgJhX847xEHtFdDOp78AYQFZwxuRSRHLKcCMRmse8fFU6SYlMu4iBU6BjmTLIiVGT3LK300KACjM6mm/n7ZvJ/U0gUbljAUq8swSqhGXjOrnSMn64wJwrPTVQNeIsyleLr2TAwWrC7gV459w0EEbQif86KctmF4hbiajN5ZOLu92N39UgXRjyxrNHcncknBaWY1pi9mKZ3eljEdetuykPOvLKFY8Vh9ab9ORp1NHE6jq6al2spwgQ3q4kxHDT/q8qkrqid6tEOzRjPTSzDh+ehlbukAhdiFH0La5p4IODXBTqdOBAeNE9hbodCxejR0ND15wBSfjnjFRvEufkcM4ckFq6N2Zd8pJrThM9ByILbWQd0HB/wzhj0Lt6RE9Mg7xKuV4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(6133799003)(3023799007)(10067099003)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?EIOyrpyuhMlFZt+kln3Iq/9kJ8+QqLKd2TMyhkgzm2rQ4pV2UWOFmsB2cQ?=
 =?iso-8859-1?Q?4l1TgsiB2k79pN4Im982elucCgOKa+du9QITqJhrveUd1G0yjxBhA+d9o2?=
 =?iso-8859-1?Q?WE78k/haFJnN1KsoMK2N9O4Dj3p7XUdGKK0eYrwCPqmcpR9VPhacfMwSUt?=
 =?iso-8859-1?Q?E1ziMEQJITKFV9cUKwGV1vpOcf3pYyyl1ZuMKxYcwYmQGhCc1jpyxn+3w0?=
 =?iso-8859-1?Q?HKjE8Q6363xvTZXjLeCGRKhCGII4wPxqT8XRWCeJx4Z7U54GIp/he9vsUf?=
 =?iso-8859-1?Q?DMnsXXhoFvTPlgxng/wEwZgevvHSrld12iWEP1Pw+JVcQf7mn5EFfO6YMM?=
 =?iso-8859-1?Q?vFY8RFYuVA+pqcE2mg17Tqdq5Q46FpF5Bw9MdGl+gKAfKcxsXmOa/rMxkX?=
 =?iso-8859-1?Q?37jLwNo7OtdDpO0sItFS8ka32fGr7gjY6j4diOCRoDWmx7eVV1s37+D6id?=
 =?iso-8859-1?Q?0dKWQE/IRqe4zRMFY8Fu8/miy/lykGrdh47DnxsAZ+AXgIPXQKK1brxUcs?=
 =?iso-8859-1?Q?EO7mZhfAzh904xRvt4GdbpAaF3s1U9NZTPZCILmBv8HcbKFx5w4FXRsQrC?=
 =?iso-8859-1?Q?/YLDOuV5k4RXELAO5wxBFU3hX2ERACVaK0EITgz0gEHzdBb71Q4BpaabSg?=
 =?iso-8859-1?Q?g9/qU4QOyFXQAVkKOlkitSrTvfrUkDhf6NZBPBdWVO6PVMMLRBKsZue9pN?=
 =?iso-8859-1?Q?3uVuOR/VKtFiUcayHr/bxsNt1KuSnBGp3Uvndnpzno+MvvZkWgMw+vZaU8?=
 =?iso-8859-1?Q?nn7C0CSLVU/2G/MWA10vcK0fu4a0SPwaVnCciLRO7QVAUqvZNJokQJ4IXF?=
 =?iso-8859-1?Q?P3AJqwxGBsTE3CJQUTKZjOo5NteLhc46KIf2X8EgZ0GhVD2N37FEy06blK?=
 =?iso-8859-1?Q?5PFvvqE1joFevCO4tLLaHjTQT15hR85h86o4qUpV75sRtWULquJcND4oaU?=
 =?iso-8859-1?Q?fZjBGDCVEJtwHGquVFPkIqppQsbaJulFQnOXuZCHCIxj1ple8pK9tmHwhD?=
 =?iso-8859-1?Q?Lb7+aIyOdQILIVSWW5Cp9l57pYRGgKvuPPtcU5fBh/vucQbX37N0Gmhw60?=
 =?iso-8859-1?Q?jKhxK5kCntKS0o1CrS5GEZQVVQCHwvXPq/SjL5J7IqefQX1lTGFP6xqk1s?=
 =?iso-8859-1?Q?1z2iozbZCYjtfWOsU8sMczV+i6CdeDmzb03Kh9011MKh/X5v4GcnIdpAqi?=
 =?iso-8859-1?Q?YyJnV/6W/9XGOlHybHMlUpbawZsDme7CVAy/6gZS6ZosggUL3cvyy0bvXK?=
 =?iso-8859-1?Q?cxvkq3SOaB8COQaoEZMXV9URTlvdA1B6i/jbPAmYoZYyUMwV+MW10vxGx4?=
 =?iso-8859-1?Q?jZtrMGPVWYxoZoEhPeU41b9GDERN8TdHOv02sitDh4LBQrvAQl/yanfocQ?=
 =?iso-8859-1?Q?xM0jWNTnGVVssHiAA0+fXN6pWTS6cxQlLxCMaprL3kdeaQao5PItfcu/Ny?=
 =?iso-8859-1?Q?pTvrexSqCEV8LsE57vYuQELV1LXqkMH3YP2aKes4RJkSUU5sNj9D/3f8nL?=
 =?iso-8859-1?Q?o9MP2THib9m9VZW8Xv0z/MLTVFtGaoaZt/L7kdmvi7UrfiE4od9XnCoWDi?=
 =?iso-8859-1?Q?Xk01iGczJuyOgC70St4RqCQx5noUi6HSJ28riHolBP2yzondGwgImcnWqi?=
 =?iso-8859-1?Q?BdumYUQs+WzVnRHhtjY8lEPJEauMoxySUnCuVQCniqaBqbL9WmP8H085nC?=
 =?iso-8859-1?Q?O9GDAsLKBgFwqsh6GeZQzsSJWQTKUbERG3Uc595ny4sCxQ18LF7pWKZSnE?=
 =?iso-8859-1?Q?L+tun6pPSQMj7JDOfq47Aam4VF7Yn2fRbaWqJXZl7QCB1U?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	03+BL5SSbBiTgsdz+dj/k1VF1sB96JaMtPYwF93cCHP0bLA/pF3yEKfaAOMU9morvqDPscjFW5gO7Veaq3NeERCkr9c6E/isIMF7l3v0z7Ip2vdpbj15PJdnlTpktvGy7Y3qtNBOWg+TCqOLTOPJcqdEyfcn4pG0Kb+M9KTkCrS3SY1O7VbLMP/phkSK+m4lXvHG7k0q/Ehb/TTu9sqzOIZrClXRZoNGGD7VH7YFkLV+kuqRmcyvVfotmxV6aEqJJFWoeQ22EqFRDjiEU2M4NdpQVh2FbQuz1hUudo5SjrawjRy8yxURQuhebZ16L4P3bFoBXHKr+IeEXjoWEnGKxw==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 031240ee-a70e-488c-536b-08df1f4bc6c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 23:37:22.7208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W93cKgXUGHdKQPfxAyi20NjpcReBIdTMlrsaL4WrFB7AG0IUVyiBG7l0JFnftfGf6U3T2a3xAnzypN4vPm/xmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB5383
X-MDID: 1790811449-ndIiLxr2poxV
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1790811449;ndIiLxr2poxV;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
An output is driven by its PLL rather than selected by it, so its state=0A=
says whether it carries a signal: connected while it drives, disconnected=
=0A=
while it is muted.  Setting the state mutes or un-mutes it by forcing the=
=0A=
pad to Hi-Z, the only per-output control the device offers that leaves the=
=0A=
divider alone.=0A=
=0A=
The force bit and the state bit are separate, and a pad follows the loaded=
=0A=
configuration while the force bit is clear, so both are read to decide=0A=
whether an output is muted and both are written to change it.  Which of=0A=
the four register banks applies depends on the slot and on whether the pad=
=0A=
is single-ended or differential.=0A=
=0A=
This is also where output pins start being registered at all: until now=0A=
the registration filter took inputs only, so the output operations the=0A=
earlier patches added -- direction and frequency -- had nothing to=0A=
dispatch on.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 271 ++++++++++++++++++++++++++++++++++-=0A=
 drivers/dpll/sit9531x/core.h |   7 +=0A=
 drivers/dpll/sit9531x/dpll.c | 102 +++++++++++++=0A=
 3 files changed, 374 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 3254d119b939..8fed14d8dca6 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -488,6 +488,47 @@ static int sit9531x_output_forced_hiz(struct sit9531x_=
dev *sitdev,=0A=
 					muted);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_output_state_refresh - read an output's mute state back=0A=
+ *=0A=
+ * Used when a mute could not be confirmed at the time it was written.  Th=
e=0A=
+ * driver does not poll output state, so without this the cached value wou=
ld=0A=
+ * stand until something else happened to write it.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_output_state_refresh(struct sit9531x_dev *sitdev, u8 out_idx)=
=0A=
+{=0A=
+	bool muted;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	rc =3D sit9531x_output_forced_hiz(sitdev, out_idx, &muted);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	sitdev->out[out_idx].enabled =3D !muted;=0A=
+	sitdev->out[out_idx].state_stale =3D false;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int sit9531x_hiz_set_bit(struct sit9531x_dev *sitdev,=0A=
+				unsigned int reg, u8 bit, bool set)=0A=
+{=0A=
+	u8 cur, new_val;=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, reg, &cur);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	new_val =3D set ? (cur | BIT(bit)) : (cur & ~BIT(bit));=0A=
+=0A=
+	return sit9531x_write_u8(sitdev, reg, new_val);=0A=
+}=0A=
+=0A=
 /* Attempts to re-lock the output loops before reporting them open. */=0A=
 #define SIT9531X_LOOP_LOCK_TRIES	3=0A=
 =0A=
@@ -621,6 +662,212 @@ static int sit9531x_prg_commit(struct sit9531x_dev *s=
itdev)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_output_hiz_write - mute or unmute an output=0A=
+ *=0A=
+ * Muting takes control of the pin (MASK=3D1) and forces it to Hi-Z=0A=
+ * (STATE=3D0) on every Hi-Z pair of the slot -- differential, CMOS OutP=
=0A=
+ * and CMOS OutN -- because the output must go quiet whichever way it is=
=0A=
+ * wired; unmuting releases the override on all of them and hands the pin=
=0A=
+ * back to the device.  The caller must already be in the programming=0A=
+ * state.=0A=
+ */=0A=
+static int sit9531x_output_hiz_write(struct sit9531x_dev *sitdev, u8 slot,=
=0A=
+				     bool mute)=0A=
+{=0A=
+	struct sit9531x_hiz_pair p[SIT9531X_HIZ_PAIRS];=0A=
+	u8 mask[SIT9531X_HIZ_PAIRS], state[SIT9531X_HIZ_PAIRS];=0A=
+	int i, rc, undo_rc;=0A=
+=0A=
+	sit9531x_output_get_hiz_regs(slot, p);=0A=
+=0A=
+	if (!mute) {=0A=
+		for (i =3D 0; i < SIT9531X_HIZ_PAIRS; i++) {=0A=
+			rc =3D sit9531x_hiz_set_bit(sitdev, p[i].mask, p[i].bit,=0A=
+						  false);=0A=
+			if (rc)=0A=
+				return rc;=0A=
+		}=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Remember every pair as it was: if the mute fails part-way, that=0A=
+	 * is what the pad goes back to -- which may already be a mute, from=0A=
+	 * an earlier request or from the loaded profile.=0A=
+	 */=0A=
+	for (i =3D 0; i < SIT9531X_HIZ_PAIRS; i++) {=0A=
+		rc =3D sit9531x_read_u8(sitdev, p[i].state, &state[i]);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+		rc =3D sit9531x_read_u8(sitdev, p[i].mask, &mask[i]);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Forced value first, override enable second.  Muted is decoded as=0A=
+	 * MASK set with STATE clear, so enabling the override while STATE=0A=
+	 * still holds whatever the loaded configuration left there can pin=0A=
+	 * the pad driven for the width of an I2C transfer.=0A=
+	 */=0A=
+	for (i =3D 0; i < SIT9531X_HIZ_PAIRS; i++) {=0A=
+		rc =3D sit9531x_hiz_set_bit(sitdev, p[i].state, p[i].bit, false);=0A=
+		if (!rc)=0A=
+			rc =3D sit9531x_hiz_set_bit(sitdev, p[i].mask, p[i].bit,=0A=
+						  true);=0A=
+		if (rc)=0A=
+			break;=0A=
+	}=0A=
+	if (!rc)=0A=
+		return 0;=0A=
+=0A=
+	/*=0A=
+	 * Only part of the mute reached the device.  Put every pair it may=0A=
+	 * have touched back to the bits read above -- override first, then=0A=
+	 * value, the reverse of the order they went on -- so the pad ends=0A=
+	 * where the request started rather than on part of a mute, or=0A=
+	 * un-muted when it was muted before.=0A=
+	 */=0A=
+	for (; i >=3D 0; i--) {=0A=
+		undo_rc =3D sit9531x_hiz_set_bit(sitdev, p[i].mask, p[i].bit,=0A=
+					       mask[i] & BIT(p[i].bit));=0A=
+		if (!undo_rc)=0A=
+			undo_rc =3D sit9531x_hiz_set_bit(sitdev, p[i].state,=0A=
+						       p[i].bit,=0A=
+						       state[i] & BIT(p[i].bit));=0A=
+		if (undo_rc)=0A=
+			dev_err(sitdev->dev,=0A=
+				"slot%u: Hi-Z override left part applied (%d)\n",=0A=
+				slot, undo_rc);=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_disable - mute an output (force Hi-Z)=0A=
+ * @index:	logical output index (0..info->num_outputs-1)=0A=
+ *=0A=
+ * Sets MASK and clears STATE on every Hi-Z pair of the slot, differential=
=0A=
+ * and both CMOS pads, so that the output is muted regardless of its=0A=
+ * electrical configuration.  The=0A=
+ * writes are wrapped in the PRG_CMD / NVM update / loop lock sequence=0A=
+ * so the new state is applied by the hardware.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_output_disable(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	bool muted;=0A=
+	u8 slot;=0A=
+	int rc, ret, state_rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (index >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	slot =3D info->clkout_map[index];=0A=
+	rc =3D sit9531x_prg_enter(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_output_hiz_write(sitdev, slot, true);=0A=
+=0A=
+	/*=0A=
+	 * Always leave the PRG_CMD programming state, even on a mid-sequence=0A=
+	 * write failure: prg_enter() unlocked the output loops, so returning=0A=
+	 * without prg_commit() would strand the chip in the programming state=0A=
+	 * with the loops unlocked.  Best effort -- keep the first error.=0A=
+	 */=0A=
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+	/*=0A=
+	 * Keep the software state aligned to what hardware now drives even=0A=
+	 * when one write in the sequence failed. The commit above may have=0A=
+	 * applied a partial mask/state combination.=0A=
+	 */=0A=
+	state_rc =3D sit9531x_output_forced_hiz(sitdev, index, &muted);=0A=
+	if (!state_rc) {=0A=
+		sitdev->out[index].enabled =3D !muted;=0A=
+		sitdev->out[index].state_stale =3D false;=0A=
+	} else {=0A=
+		/*=0A=
+		 * The writes may well have landed; what failed is the proof.=0A=
+		 * Mark the cached state for a read-through rather than=0A=
+		 * reporting the value it had before this call.=0A=
+		 */=0A=
+		sitdev->out[index].state_stale =3D true;=0A=
+		if (!rc)=0A=
+			rc =3D state_rc;=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_enable - un-mute an output (active state)=0A=
+ * @index:	logical output index (0..info->num_outputs-1)=0A=
+ *=0A=
+ * Releases MASK on every Hi-Z pair so the device drives the output=0A=
+ * again as the loaded profile configures it.  The writes are wrapped=0A=
+ * in the PRG_CMD / NVM update / loop lock sequence so the new state is=0A=
+ * applied by the hardware.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_output_enable(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	bool muted;=0A=
+	u8 slot;=0A=
+	int rc, ret, state_rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (index >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	slot =3D info->clkout_map[index];=0A=
+	rc =3D sit9531x_prg_enter(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_output_hiz_write(sitdev, slot, false);=0A=
+=0A=
+	/*=0A=
+	 * Always leave the PRG_CMD programming state, even on a mid-sequence=0A=
+	 * write failure: prg_enter() unlocked the output loops, so returning=0A=
+	 * without prg_commit() would strand the chip in the programming state=0A=
+	 * with the loops unlocked.  Best effort -- keep the first error.=0A=
+	 */=0A=
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+	/* See sit9531x_output_disable(): commit can apply part of it. */=0A=
+	state_rc =3D sit9531x_output_forced_hiz(sitdev, index, &muted);=0A=
+	if (!state_rc) {=0A=
+		sitdev->out[index].enabled =3D !muted;=0A=
+		sitdev->out[index].state_stale =3D false;=0A=
+	} else {=0A=
+		/*=0A=
+		 * The writes may well have landed; what failed is the proof.=0A=
+		 * Mark the cached state for a read-through rather than=0A=
+		 * reporting the value it had before this call.=0A=
+		 */=0A=
+		sitdev->out[index].state_stale =3D true;=0A=
+		if (!rc)=0A=
+			rc =3D state_rc;=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Input priority selection=0A=
  *=0A=
@@ -2348,6 +2595,8 @@ static int sit9531x_out_state_fetch(struct sit9531x_d=
ev *sitdev, u8 index)=0A=
 	if (rc)=0A=
 		return rc;=0A=
 =0A=
+	sitdev->out[index].state_stale =3D false;=0A=
+=0A=
 	/*=0A=
 	 * Each PLL page holds the PLL's output-enable mask, twelve bits:=0A=
 	 * bits 0-7 in OUT_MAP_LO and bits 8-11 in OUT_MAP_HI[3:0].  PLLA and=0A=
@@ -3165,8 +3414,8 @@ static void sit9531x_dpll_pins_unregister(struct sit9=
531x_dpll *sitdpll)=0A=
  * @index:	pin hardware index=0A=
  *=0A=
  * For input pins: delegate to sit9531x_input_pin_is_registrable().=0A=
- * A pin class whose state callback the tree does not have yet is not=0A=
- * registrable: the core refuses a pin without one.=0A=
+ * For output pins: the pin is registrable if this DPLL is routed to it,=
=0A=
+ * whether or not it is currently driving.=0A=
  *=0A=
  * Return: true if pin should be registered, false otherwise=0A=
  */=0A=
@@ -3176,13 +3425,23 @@ static bool sit9531x_dpll_pin_is_registrable(struct=
 sit9531x_dpll *sitdpll,=0A=
 {=0A=
 	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
 =0A=
-	if (dir !=3D DPLL_PIN_DIRECTION_INPUT)=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT) {=0A=
+		if (index =3D=3D SIT9531X_MAX_INPUTS)=0A=
+			return true;=0A=
+		if (index =3D=3D SIT9531X_INTSYNC_PIN_ID)=0A=
+			return false;=0A=
+=0A=
+		return sit9531x_input_pin_is_registrable(sitdev, index);=0A=
+	}=0A=
+=0A=
+	if (index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID)=0A=
 		return false;=0A=
 =0A=
-	if (index =3D=3D SIT9531X_MAX_INPUTS)=0A=
-		return true;=0A=
+	if (index >=3D sitdev->info->num_outputs)=0A=
+		return false;=0A=
 =0A=
-	return sit9531x_input_pin_is_registrable(sitdev, index);=0A=
+	return sitdev->out[index].pll_idx =3D=3D sitdpll->id &&=0A=
+	       sitdev->out[index].routed;=0A=
 }=0A=
 =0A=
 /*=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 473171a19d94..8e1378d04b77 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -99,6 +99,8 @@ struct sit9531x_ref {=0A=
  * @cmos:		output is wired single-ended; the Hi-Z pairs that=0A=
  *			speak for it are the two CMOS pad ones, not the=0A=
  *			differential=0A=
+ * @state_stale:	the cached mute state could not be confirmed against=0A=
+ *			hardware and has to be read back before it is reported=0A=
  * @routed:		output is mapped to @pll_idx by the initial=0A=
  *			configuration; an unrouted output has no DPLL pin=0A=
  * @pll_idx:		PLL driving this output (0-3)=0A=
@@ -107,6 +109,7 @@ struct sit9531x_out {=0A=
 	u64		freq;=0A=
 	bool		enabled;=0A=
 	bool		cmos;=0A=
+	bool		state_stale;=0A=
 	bool		routed;=0A=
 	u8		pll_idx;=0A=
 };=0A=
@@ -258,6 +261,10 @@ int sit9531x_input_prio_add(struct sit9531x_dev *sitde=
v, u8 pll_idx,=0A=
 			    u8 input_idx);=0A=
 =0A=
 /* ---- Output enable/disable (Hi-Z control) ---- */=0A=
+int sit9531x_output_disable(struct sit9531x_dev *sitdev, u8 index);=0A=
+int sit9531x_output_enable(struct sit9531x_dev *sitdev, u8 index);=0A=
+int sit9531x_output_state_refresh(struct sit9531x_dev *sitdev,=0A=
+				  u8 out_idx);=0A=
 =0A=
 /* ---- Output frequency ---- */=0A=
 int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index a576d918e68d..ac2d977d36f7 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -751,10 +751,112 @@ sit9531x_dpll_output_pin_frequency_set(const struct =
dpll_pin *pin,=0A=
 	return rc;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_state_on_dpll_get - get output pin state=0A=
+ *=0A=
+ * reports CONNECTED when the output is driven and=0A=
+ * DISCONNECTED when it has been muted via sit9531x_output_disable().=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_state_on_dpll_get(const struct dpll_pin *pin,=0A=
+					   void *pin_priv,=0A=
+					   const struct dpll_device *dpll,=0A=
+					   void *dpll_priv,=0A=
+					   enum dpll_pin_state *state,=0A=
+					   struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	const struct sit9531x_out *out;=0A=
+	int rc;=0A=
+=0A=
+	/*=0A=
+	 * A mute whose read-back failed left the cache unconfirmed; there is=0A=
+	 * no poll of output state to correct it, so read it here rather than=0A=
+	 * report a value that may predate the request.=0A=
+	 */=0A=
+	if (sitdev->out[dpin->id].state_stale) {=0A=
+		mutex_lock(&sitdev->multiop_lock);=0A=
+		rc =3D sit9531x_output_state_refresh(sitdev, dpin->id);=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		if (rc) {=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "Output mute state could not be read back");=0A=
+			return rc;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	out =3D sit9531x_out_state_get(sitdev, dpin->id);=0A=
+	*state =3D out->enabled ? DPLL_PIN_STATE_CONNECTED=0A=
+			      : DPLL_PIN_STATE_DISCONNECTED;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_state_on_dpll_set - mute/un-mute an output=0A=
+ *=0A=
+ * Forces Hi-Z on the output through the Hi-Z force/state register pairs=
=0A=
+ * of its slot, the differential and the single-ended one.=0A=
+ *   CONNECTED    -> enable (release the override, the device drives it)=
=0A=
+ *   DISCONNECTED -> disable (force Hi-Z)=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_state_on_dpll_set(const struct dpll_pin *pin,=0A=
+					   void *pin_priv,=0A=
+					   const struct dpll_device *dpll,=0A=
+					   void *dpll_priv,=0A=
+					   enum dpll_pin_state state,=0A=
+					   struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	bool was_enabled, changed;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	was_enabled =3D sitdev->out[dpin->id].enabled;=0A=
+=0A=
+	switch (state) {=0A=
+	case DPLL_PIN_STATE_CONNECTED:=0A=
+		rc =3D sit9531x_output_enable(sitdev, dpin->id);=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_DISCONNECTED:=0A=
+		rc =3D sit9531x_output_disable(sitdev, dpin->id);=0A=
+		break;=0A=
+	default:=0A=
+		rc =3D -EINVAL;=0A=
+		break;=0A=
+	}=0A=
+=0A=
+	changed =3D sitdev->out[dpin->id].enabled !=3D was_enabled;=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc) {=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set output pin state");=0A=
+		/*=0A=
+		 * The core notifies only a request that succeeded, and the=0A=
+		 * poll does not watch outputs.  A failed request whose=0A=
+		 * read-back shows the output did change still has to be=0A=
+		 * announced, or subscribers keep the old state for good.=0A=
+		 * The core's lock is held here, as the helper requires.=0A=
+		 */=0A=
+		if (changed)=0A=
+			__dpll_pin_change_ntf(dpin->dpll_pin);=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_output_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_output_pin_direction_get,=0A=
 	.frequency_get		=3D sit9531x_dpll_output_pin_frequency_get,=0A=
 	.frequency_set		=3D sit9531x_dpll_output_pin_frequency_set,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_output_pin_state_on_dpll_get,=0A=
+	.state_on_dpll_set	=3D sit9531x_dpll_output_pin_state_on_dpll_set,=0A=
 };=0A=
 =0A=
 const struct dpll_pin_ops *=0A=
-- =0A=
2.43.0=0A=
=0A=
