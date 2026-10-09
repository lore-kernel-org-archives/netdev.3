Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B934A50EC04;
	Fri,  9 Oct 2026 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570226; cv=fail; b=dyFCop4vGwuj1h9HQsaKlnEJq5R+5m5l7g/AeWivcbo6lrzn/KcGiW1hwtsx6jj858cxwazdU+CTUKiwK2i1/K1d+VtDOjSDgcMsyrAxGEOLgyKI419eGRMlUvgc72gHJDHwm68BsEDVeMpWodTmrisZcwRyPjTwAPb96+qk1bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570226; c=relaxed/simple;
	bh=DhoNFJL5mzuNGco759fJnKcpZUvGI83lVmCZ/JqK0uo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FlSqdZ8rk7qOlFzuomnZRKSyUEXURX4OnT1guCG42KwkYKzQi7/Qq+u8g+jpob+g3cOaXe/wpE9a5+941YO/EhJa5w0pNM5NF4DF9nJV7u/u2D9VXYVTLmmJaX6ahPPajT7dnAR73G5kqeAwQmKQrfxpneUWOlxlrD8GZxGjiEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=YuloC+f6; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=s27/HwJa; arc=fail smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="YuloC+f6";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="s27/HwJa"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D22CD60D0D8;
	Fri,  9 Oct 2026 18:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=DhoNFJL5mzuNGco759fJnKcpZUvGI83lVmCZ/JqK0uo=;
 b=YuloC+f65maNEtBEu9p8ppAyZnkXtrS0eneDIpz6m+a2X/coGTlwyvoXr4ny1vt5nBo4cNVkIfUccDfCoqbZ/a5Cz/PgvsbGx9+LsHKTPbLvXiMCuHfIt7SMwDIpBy8GJBkDUUPcK4+KpQxk45uYUprKiiDEkAuo2KicvSp344WUSM+smUELhhj4R18bHA8sg2KYONy7xQhEAH/IDt4KvB6VCBXq8bcvdybWOa434qgeJTei21PlfAJjkAGjBnRKXxSF/ffRbupaZA6crPsHEq1qmvJnq4oz0b8vzsnq892sLf+Ge42Hy9GPigCELxsnG7GLfHYHuB4VeSfh5XL4hw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021124.outbound.protection.outlook.com [40.107.208.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id DD3BBB0007C;
	Fri,  9 Oct 2026 18:23:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkZBrVYPmUXvCfvdvYGBhlFwnxteLwHSpZ8S1pWZNC+hCF1fJVxX2ma7hv1XuOlB0knl9hUGoaZYq8dJBo3wsE9X5I+tQmJ3zgQ904vIgHlJxmgEelJ9D/hIFmyccteTAvBmcmTJ4+K8QG42+jITyP6MA9o46bTqXOnEDNmSMUcpz2wvuW6SD/BxpasR5Igryouru8zT3q961lnP+Z2eNiBEXoSZftz/W8xRAur01qkG2E30R2y9RVRq3Cv8mWMtiuHBC+oGIPiEqR3pHxK3ph9QFpBDij/LiA+8UHxtP8cG1h79X7EZJYB7smsPSOVpzIDoO/Hlo610XSr6aTOScg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhoNFJL5mzuNGco759fJnKcpZUvGI83lVmCZ/JqK0uo=;
 b=NmQ0C9TIdu8MK9lfttn0pZot89o38zaOpTsCvG0udqBt2CqXgp+J2dhYWNEDZ3SPumxyQmzAoAk5+g2hxvZ1+Lfq9iZU/Ikma6CP8HqMJhxVaXOu+1qVauG1IviBHO7mlujKQtdeI5jml0ol+GqY2SLZJAFpv+B4TnMBrd3kZeWUzUl+SPXS8bsY5s7k4NJPMs56sKlBD9PGmC8PCbOx8QJ5gCL6NkkgpH+b181vyfIke27m/MML1DwX86Kby/6k481XtcOqjdEyRu5Z2/hGMfMjaGDkoe/VHGgXAivJbrUXhaOluL9j3a69ovSqZkCK7BvyXkjUD2S8Yr/c8ImCJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhoNFJL5mzuNGco759fJnKcpZUvGI83lVmCZ/JqK0uo=;
 b=s27/HwJaIjKShn02D+Pfs54Ao0a2n40nW0nXymXF3IyL3tk4aAHWrsu4fGLWffSFUZyjv8O1ADnKi/5Rwt+t3BYkkzm25AGqPhpJq67U0A+u1Es3Z6rOFH3p+LLSiKR9YxymxAblhZG5zVWZ1Y3CWML6bG3j93ueGZt6hRUEXCGt3E20aIUBPRIV4i0fS1KqX0reBjb0BDCLYPoKczbRG8Dhxn2njmOzlkTb8xVI0jZrif7KbPs16KPp7aubaqyF+BYMX+M7UBiTkZU7BDF97OBjiPFsH4Mp+9IU6hvuFdiPRiUdUc8ESGN7SsmC2Axd4EN/5UuzO4tKUcCly7N8iw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by BN7PPFEE39645EB.namprd20.prod.outlook.com
 (2603:10b6:40f:fc02::76d) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 18:23:30 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:23:29 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Oleg Zadorozhnyi
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v11 11/13] dpll: sit9531x: add support to adjust
 output phase
Thread-Topic: [PATCH net-next v11 11/13] dpll: sit9531x: add support to adjust
 output phase
Thread-Index: AQHdUTSkd5y/Ix0Z+0CNcg6LO2tBgbbuKhoAgAdqA4A=
Date: Fri, 9 Oct 2026 18:23:29 +0000
Message-ID: <20261009182323.76166-9-arouhi@sitime.com>
References: <179116260667.434549.14297756482397841280@kernel.org>
In-Reply-To: <179116260667.434549.14297756482397841280@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|BN7PPFEE39645EB:EE_
x-ms-office365-filtering-correlation-id: 75808c22-c669-41e0-bc05-08df26326ae6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|5023799004|6133799003|3023799007|22082099003|10067099003|18002099003|38070700021|56012099006;
x-microsoft-antispam-message-info:
 RO9VSPmuVxrQ5H2S+qfAhpCzmexxSIqsoV4c2zg9axjG2TYvhH3f89BKLSAkLM31uc7aHt4r4RUULq32oEFwFJ3zf6tifbw/3Svn1vKOsk+lzeu70sI5rjnRCJvVB3OL8Qffqri3dkizF5DJzxNEnRgDAebtSMb0vM8Z18EggzcJDBJtGdDkd3hc5WMuuvJvwp/A1JoKaZSMhq+Vq1gmGDrMB3RuVeLEWAq7lE5UBrFx0UNb2n5pwf39wnt/hg16w1qaxmyq9FfeZuIAQwVjlxnrSot8tyze9DSObtIxfA1R/H0H70USxhKc4TLFF3alzkSRzQTJvM/PfAFl1s7fjXXME2XpxDVr4NnNbRpCd0N0AabHHFY203EEk+5muwJx30VnKoEZIPVAFkvwZCU7WAoYzSO+619r5zymiVisa7JSPBMR6Y6JGVd8Lq4Fl1OpOAhFDDuVAnnTruRSfc6s4CEa1NssVz5eDORvbwFr0USGfvNlHhWnzinkfim7tTNsreKZ7za8G9ka8zmrof8I2nfharqFOoJepmMkha4IdBgftt9Fq9p78pz/p8xXc8novEzEZum+aPnC686RNL4rM+jfymt2RuiYbBfvNLu2iAqc5iQNgVjqbXKhmjWK4I92VwANcyskDTje1VojDZeCCUtdv5ce2AKZ2mrf5CdlcqNac7U8gaXlnLpRHdU9B/QYWtXZ9hcGgiMCF3mQE3Yy7SBFjIebHrlAieO+DC6m7no=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(5023799004)(6133799003)(3023799007)(22082099003)(10067099003)(18002099003)(38070700021)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?59ga+V/qakbShRyRb6yD4tj1VxbPY21ZS7G+AJTwtRI48RzPgZayVQKQ0j?=
 =?iso-8859-1?Q?TG9uuU4fOdsdukgvbjxK/FlvoRi1QVJcDNJbg/oCbZqEWiULGiZP+AuqhL?=
 =?iso-8859-1?Q?OWPJ6L3jO2zB4YjgCGNskGSxhEcsENoVnPHxLcdBa8RtLuJuxDZ0esC7+G?=
 =?iso-8859-1?Q?s82L1Hjq0w8TCsnfMdAL1Zpsyy4k6ghsjRF38QqZSdVk9DgCg8yTL8zSIF?=
 =?iso-8859-1?Q?LtHB071ADdOPtxpgXLTo++fV80gWKGQcXGTH8pCkLBuyg9wHY2G4PeENyb?=
 =?iso-8859-1?Q?3ILp10k4+vhoE4VH9LwVMGFXFsufpkY0nnm02O0z0YT0KfFsEsBWMKJZ6J?=
 =?iso-8859-1?Q?h7TkJu2eDrn2X2Z0zUkre3Z8Jmxog2QySZoba9ss9pFPKjfLFunWfwL82Y?=
 =?iso-8859-1?Q?pe58R7WCtXIE7o80/2Uwy1PLPvdl/xOLndBwmP9p+/OTgpHQmkyOoxVQcL?=
 =?iso-8859-1?Q?qDRUlekdp6dBCH7j7Eh/xtw6mdnOCQpLWOZcVUhQH5PaH6jSbegoDI5rGL?=
 =?iso-8859-1?Q?fnhhLD7XVky6HHisYD0bsUPwJ+OiMdHfvexa82NYx5CWQJxK0GUrlxvd/J?=
 =?iso-8859-1?Q?noyGz6l8ZhCx4yXPA8Ms9sTRpizPThHn6tjEin2lG8USAU3zdV3rJqk9cq?=
 =?iso-8859-1?Q?riKAOLczjRmMUJ3im+Nezsl3pAhaq0x8FKFaccGVPF3pGtlym7s3n98Ilg?=
 =?iso-8859-1?Q?K61R/cmrjLpTlcKU6duvGxE5t2eD7wmeq9j3wiMQ0NxrJasxLWmvmZGL0d?=
 =?iso-8859-1?Q?nSRpUWNPuw/pdrKuuVxy68E5NuJAdUE+TTT8k+0FhuufQz/zVmOw2P4Cfk?=
 =?iso-8859-1?Q?8uidfr/NTo0OFu+0qTm8OUMCN3qOsuEblfWClO8ueaAP3TsbmCPwDxKhEW?=
 =?iso-8859-1?Q?+5xUVGOd4zbDuqWbWWE9BcFmq+1D1HJN+IgzLW5vVhG6GqEMq6o3pMrAzu?=
 =?iso-8859-1?Q?rpoLXAXAOrJceppHWkVoB2/jST587f8YQSBCf0Pgd4ESjAEajXleHJcFHt?=
 =?iso-8859-1?Q?tN8l0qX0ILU6q323Cl6mBkYN1H/7osGx8QGg/nEIZxuz/+JRzLxLhqiyAu?=
 =?iso-8859-1?Q?lfBpL/mgbySODivD1xSBVgLWyULrpkA7v0aDrSmM9EU/nv93hfc6nVhuaZ?=
 =?iso-8859-1?Q?p8FB0bqU3Uyfx8SMPl1kanGf23sqstcaqU4yROZQ4k7g7VF8O6bSYQYqbw?=
 =?iso-8859-1?Q?ixsuZsDdNe9J+J3zc4FuUpkrB/PE2vCgxaLBsPNgHbXkDhu7KbDBMdIO6Y?=
 =?iso-8859-1?Q?a03f/McFMQPNH6wwe+4I5ymssu1s7KMaQ2mB8cFn0rwuF8sBr1G1jDxn5i?=
 =?iso-8859-1?Q?gLptad5+aqW71XAiSNI0EFhlC0IFKozOjacwq+OzeqESKylznbLbAOqm3d?=
 =?iso-8859-1?Q?OFalJjEi+I5AC4QdMLlIys4IWrEzxd0mqfXbbIQ1R8d8AWGFHfAszmRBmi?=
 =?iso-8859-1?Q?pTAOo0l6jIRMJe3vL2IH8XJ3TgKcKIMVew8UUSg0bgL0LAxzRmoVnyMe58?=
 =?iso-8859-1?Q?6tqLdfa8dt3RWRt45DwYNkFsFD6jNknGS3Xt0yBiq8fF3OEsjdCCJidDiX?=
 =?iso-8859-1?Q?Gam0syQZrNPf5ZNPOfQNGvB4RXbrE1d8SkUWXBKMLHiIWNHa4gWJMKYSGX?=
 =?iso-8859-1?Q?l7phbY1/2BUgrlZO02n2gA15FcZ1xr7a7o7mXrybiyww0fr83NJeCV76VY?=
 =?iso-8859-1?Q?953pKB1ixq0g9bdAiE7kbSmHWZ/MNQJjraPF2qK22oK0hfNk6Co7Wi9HRt?=
 =?iso-8859-1?Q?lwsNLWLekIjGbnkvgZx3pT0NXGlTIzQHI6T2QHgac/hSOU?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	F2cZBvCQ1I7Za4uQikAanN0THtbqAtx7ZnKKs1e2wCNw7pWNm4zuV7yjHyAcI0g3PS8shHs/iIkoCA5yYwN8SZhBkgvGFYoXKwSyPLL2C/fD4PQ52Ogq4tvHZSzjL0IgwTQqcSQmdYr1CKA4Lo6S3jnO9cNGvpE7hEFF7xdggFQfyKHALVFoWUSS1zr/hEA+B8SrJZpo12nrqjr0+eoT04LJ88qaq4C8XWMdhxzHF9GtaaXkLeoQzGGEgGumujZCYJS7U3ba59cNBGEkKjmHyD2U22WpSVTuJB4KUiVZoKVCXaP3jBWMHzbHxsVGCNBq4KH6oRx6BMhkZFr0KIk/jg==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75808c22-c669-41e0-bc05-08df26326ae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 18:23:29.3277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hUUMCui7iSe2oC9lzkcgfEbsgu61gLDZzPOkHTW65A1FI3iqajXwJQPXOAYcPfYgu6UxWu66I635kVG/YBJKQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFEE39645EB
X-MDID: 1791570215-474j1S5WO0kf
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1791570215;474j1S5WO0kf;<arouhi@sitime.com>;5de2396b9b83917d02f0372d9ae54394
X-PPE-TRUSTED: V=1;DIR=OUT;

On Mon, 5 Oct 2026, netdev-bot+sashiko@kernel.org wrote:=0A=
=0A=
Replies inline, in the order of the summary list. Nine of the ten are=0A=
fixed; the third is answered and its documentation fixed.=0A=
=0A=
> [Severity: Medium]=0A=
> How many times does one rate change disturb the PLL here?=0A=
> sit9531x_output_freq_set() has already called sit9531x_output_phase_flush=
()=0A=
> after the DIVO commit.=0A=
>=0A=
> [...]=0A=
>=0A=
> Should the commit message mention the full PLL restart? And could the rat=
e=0A=
> change avoid the second programming cycle and flush?=0A=
=0A=
Fixed: a rate change on an output with a programmed delay re-times the=0A=
delay inside the rate change's own programming window, so there is one=0A=
sequence and one flush instead of two of each.=0A=
=0A=
The commit message now also says what the flush is on a PLL the loaded=0A=
profile builds without the phase-flush feature: realigning its outputs=0A=
restarts the whole PLL, so a phase adjust or a rate change on such a PLL=0A=
is a loss of lock as well as an edge jump on its other outputs.=0A=
=0A=
> [Severity: Medium]=0A=
> Can this seed a clamped value that a later rate change then writes to the=
=0A=
> device?=0A=
>=0A=
> [...]=0A=
>=0A=
> The getter also reports +1 ms while the hardware holds 10 ms. A request=
=0A=
> for exactly +1 ms is therefore dropped by dpll_pin_phase_adj_set() and=0A=
> never reaches the device.=0A=
=0A=
Fixed: a delay the loaded configuration left beyond the advertised window=
=0A=
is reported clamped and is not armed, so a later rate change does not=0A=
write the clamp into the device. The setter arms only a request that=0A=
quantized to something. Both comments are corrected.=0A=
=0A=
> [Severity: Medium]=0A=
> Is this the inverse of the encoding in=0A=
> sit9531x_output_phase_adjust_set()? After the fold, ps < t_out_ps. When=
=0A=
> t_out_ps <=3D SIT9531X_OUT_PHASE_ADJ_MAX_PS, which is every output faster=
=0A=
> than 1 kHz, the two conditions can never both hold, so the function never=
=0A=
> returns a negative value.=0A=
>=0A=
> [...]=0A=
>=0A=
> The kernel-doc above says such an advance "reads back as that advance".=
=0A=
> That does not seem to hold for these outputs.=0A=
=0A=
The register is unsigned, so a delay D and an advance of T - D are the=0A=
same edge, and the sign the driver reports for it is a convention. The=0A=
reader reports the advance form only where the delay form lies beyond the=
=0A=
advertised window, which for an output faster than 1 kHz never happens;=0A=
so a -30000 ps request on 10 MHz reads back as +70000 ps. Both describe=0A=
the same edge, and a later rate change re-times the same edge either way.=
=0A=
=0A=
What was wrong is the kernel-doc, which promised the advance form=0A=
unconditionally. It now says when it applies, and the commit message says=
=0A=
the same.=0A=
=0A=
> [Severity: Medium]=0A=
> Does this drop register access errors from sit9531x_output_divo_read()?=
=0A=
> An I2C or regmap error is handled the same way as -ENODATA, and the=0A=
> function falls through to:=0A=
>=0A=
> [...]=0A=
>=0A=
> Should only -ENODATA skip the fold, with other errors returned?=0A=
=0A=
Fixed: a bus error from the divider read fails the read-back; only the=0A=
"no divider programmed" case skips the fold.=0A=
=0A=
> [Severity: Medium]=0A=
> Is a failed flush here ever retried? The delay bytes can be committed and=
=0A=
> then sit9531x_output_phase_flush() can fail, for example on its first=0A=
> CONFIG47 read. When that happens, phase_stale is the only record of the=
=0A=
> failure.=0A=
>=0A=
> [...]=0A=
>=0A=
> Either way the realignment never happens, although phase_stale exists to=
=0A=
> force a rewrite after this kind of failure. Should a pending flush be=0A=
> tracked separately from an unconfirmed cache?=0A=
=0A=
Fixed: a flush that failed after the delay was committed is remembered in=
=0A=
its own flag, which the getter leaves alone and the setter honors by=0A=
flushing even when the requested bytes match the cache. The cache keeps=0A=
the value the output actually realizes.=0A=
=0A=
> [Severity: Medium]=0A=
> Does truncating the period to whole picoseconds give the wrong fold for=
=0A=
> requests longer than one period? The dropped fraction accumulates once fo=
r=0A=
> every period that is folded away.=0A=
>=0A=
> [...]=0A=
>=0A=
> The read-back fold in sit9531x_output_phase_read() uses the same truncate=
d=0A=
> period.=0A=
=0A=
Fixed: the fold is counted in VCO cycles modulo the divider, which is=0A=
exactly the period, and the sub-cycle picoseconds are carried across.=0A=
1e8 ps on a 128 MHz output of a 5.12 GHz VCO folds to zero, as it should,=
=0A=
and the read-back folds the same way.=0A=
=0A=
> [Severity: Medium]=0A=
> Is this block reached on every path where the divider changed? Earlier in=
=0A=
> sit9531x_output_freq_set(), the function returns before getting here:=0A=
>=0A=
> [...]=0A=
>=0A=
> Should the error path set phase_stale when phase_armed is set?=0A=
=0A=
Fixed: when the commit fails after the divider was written, an armed=0A=
delay is marked stale so the next read goes to the device rather than to=0A=
a cache that describes the old period.=0A=
=0A=
> [Severity: Medium]=0A=
> Can this conversion overflow and raise a divide error? Here coarse is a=
=0A=
> raw 34-bit value from the device. sit9531x_get_fvco() only rejects=0A=
> fvco =3D=3D 0; an out-of-band fvco gets a dev_warn_once() and is returned=
=0A=
> anyway.=0A=
>=0A=
> [...]=0A=
>=0A=
> sit9531x_divn_static() already guards against this kind of #DE. Should=0A=
> these conversions also bound fvco or the result?=0A=
=0A=
Fixed through the VCO floor described on 09/13: a rate below the low band=
=0A=
is reported as no data before any conversion runs, so neither the phase=0A=
code nor the time-to-digital converter path can divide by it.=0A=
=0A=
> [Severity: Low]=0A=
> Is "well beyond the DCO dynamic range" accurate? The PRG_RST_DELAY coarse=
=0A=
> field is 34 bits of VCO cycles, about 3.4 s at 5 GHz, and requests are=0A=
> folded modulo one output period. On a 1 PPS output, the hardware can=0A=
> therefore realize delays anywhere in the 1 s period.=0A=
>=0A=
> [...]=0A=
>=0A=
> On slow outputs, the +/-1 ms window is narrower than what the hardware ca=
n=0A=
> do. The real limit is the s32 picosecond uAPI (about +/-2.147 ms), not th=
e=0A=
> device.=0A=
=0A=
Fixed: the device holds a delay anywhere within the output period, so on=0A=
a slow output the bound is the signed 32-bit picosecond attribute rather=0A=
than the hardware. The comment in prop.c and the commit message say that=0A=
instead.=0A=
=0A=
> [Severity: Low]=0A=
> Is the previous coarse cycle ever considered here? The fine field goes up=
=0A=
> to 7 * 30 =3D 210 ps, which is longer than one VCO period in every=0A=
> supported band. So coarse - 1 with a large fine code can be closer, or=0A=
> even exact.=0A=
>=0A=
> [...]=0A=
>=0A=
> The quantizer is also not idempotent for such encodings. A profile holdin=
g=0A=
> coarse 0 / fine 7 seeds phase_adj =3D 210 and phase_armed =3D true. The n=
ext=0A=
> frequency_set re-encodes it as 200 ps, which rewrites the registers and=
=0A=
> flushes the PLL.=0A=
=0A=
Fixed: the candidates are one cycle fewer, the floor and one cycle more,=0A=
each with the fine steps capped, and the nearest wins; 210 ps at 5 GHz=0A=
encodes as seven fine steps exactly rather than one cycle short. The=0A=
comment that said the fine field tops out below one VCO period was wrong=0A=
too -- 210 ps exceeds every in-band cycle -- and is gone.=0A=
