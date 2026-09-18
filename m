Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF300365A14;
	Fri, 18 Sep 2026 06:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713286; cv=fail; b=F2d2F+pQTusWPlH8p0lAHIHBeXY87Kv/8CVgzMd5dG0LK+PPqtfQCr/mr2QnFEqzvQ1f2mVlayhU6htdDdVQiMzjpSwBBkwZNf/H2l7x9edtHVyTzYN42DaJhb1TRY1xBLjIqmtKLBXUfd+rsQGkYX786icJlpeJvX4NxYduXk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713286; c=relaxed/simple;
	bh=MtvM7kZmIxCQvj1DB2uZUb/5DeeJ9IU9K8t8UKfpzXA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hSx0b7SSE9GxDRr647+tf4xk8ZHisKajDrxaaZyUHgewTsPDoeCFMglJWcy69fROCrL+7DEokZm8A+Mtg8fewc2khUrkTQzums2F6jgJf9WLSJlwtyYcSnt1YXlM/cE/76JNyAB312J3P57r2Y9ELbtv9+JvRIDYqHQfhPz456Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=fBfgrfzZ; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="fBfgrfzZ"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I5xYTs744830;
	Thu, 17 Sep 2026 23:34:35 -0700
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11022113.outbound.protection.outlook.com [52.101.53.113])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4grxxb8904-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 23:34:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yObmq4e9QArpDmdRdcu8+R2rC14a2I+9zpD32kprvX65Yd34nYuJPgqdQuibOtJvLwaZq4oAOGvKGu+uV8hU8LzE06Sz0QySuHa6Kl4YX7iIuCqc3iuKbObmgxgz/zwsYB9xty4BoFjmaZVucmYbFeImSDIm1p4TXbx+SZPkQedjtErJ6e0TASrB015N84OGJGhOm7K280outhaR2mQGCPDzsGPFtumLyqYOrOddumTSsUHpHIa0xFYg+9iPu23FLD2SfSLxUEQMrVQzQtQXfzYWKHt3gkfOie95Nr3+PEwg5YydXAMkbpu4+6NTBw+DJyESyF4lX+HFr43U3TPLdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLGUAGkbTXrP5Gd59m8fTxvnx0etl6TiWInPIQaFvW0=;
 b=sQJwG4c/kIeiX+gUPOuDqIY7Y7sIxj5tNrDCNBFdP+nyHQ1rXLpf1NxfXf6UGEfRf928UMFFABMHnoPQ2yHgsxzsuWuQdLVBdk36iivcsZcx3/apNeliFpL2bz0bjcDl5usk/L/kEsT528/nrcNMhOYieap6U+CHRG+h1sn9kP/sHevEUHI4JLgNGjkGRxVh/Ofv4vOOm4COBWOqNIg2T7LZfrEvcI/LlQ5S7GrRi8LYjidfckLGGH3gBOuOSWkbzMNJdNAHiqdtNQuIBKEFu8KJ86NQqDKF0rVm4tH/x69rP4Ar7LP/GwaKhTYtsaZddsXcen6PpFFIPCtNUS1+Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLGUAGkbTXrP5Gd59m8fTxvnx0etl6TiWInPIQaFvW0=;
 b=fBfgrfzZVMHe/+5UTZorF8aKGe/izPp/thW1s4hCkFE+jDUG+1DEE8LQJby4rel0aPvl1OXXFnXQTRY63NbDw1cUHhaKFPjnt1ByOjCMEboVyNEOyNsNJnZXeibNN48mj2xaM//+2LmMMk+njWtcU+IdchDws8lIQ2Xf9vaMxnM=
Received: from DM4PR18MB4384.namprd18.prod.outlook.com (2603:10b6:5:39d::13)
 by SAVPR18MB988313.namprd18.prod.outlook.com (2603:10b6:806:4e7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 06:34:31 +0000
Received: from DM4PR18MB4384.namprd18.prod.outlook.com
 ([fe80::99a5:6a38:56fa:cda3]) by DM4PR18MB4384.namprd18.prod.outlook.com
 ([fe80::99a5:6a38:56fa:cda3%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 06:34:28 +0000
From: Subrat Pandey <subratp@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        Geethasowjanya Akula
	<gakula@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH net v6 2/2] octeontx2-af: mcs: Fix SC
 resource cleanup loop
Thread-Topic: [EXTERNAL] Re: [PATCH net v6 2/2] octeontx2-af: mcs: Fix SC
 resource cleanup loop
Thread-Index: AQHdQO100HCbt/NFsUioVdHCm4X6xbbSD6sAgAHayz0=
Date: Fri, 18 Sep 2026 06:34:28 +0000
Message-ID:
 <DM4PR18MB438449564EB49636777F49BCAB872@DM4PR18MB4384.namprd18.prod.outlook.com>
References: <20260910062657.3712256-3-subratp@marvell.com>
 <20260917020342.2544346-1-kuba@kernel.org>
In-Reply-To: <20260917020342.2544346-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR18MB4384:EE_|SAVPR18MB988313:EE_
x-ms-office365-filtering-correlation-id: acf5497b-a9b1-4def-fae0-08df154ee425
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|6133799003|10067099003|4143699003|22082099003|18002099003|11063799006|56012099006|5023799004|38070700021;
x-microsoft-antispam-message-info:
 okiVsb8KJfgnvu869zG9eY2dQuUsbaoOCgMtGJ1RfLcGSDIR6mCCQczZEz9a1iUvlW/omat2Z+g9HEpa6jL5bpOzgrhWiE5r6YxnhfNr0f1109v/PAtjiqv5m0DUigrVRhy455Fw9ofsaVfCm14QKKJiel0JLXSxVbDLol1TdqQqLy0ve9Qwb1Z2bjo+uMX8xIt0IyNDTrw+YbngJY/40o4XyqhdT2gbIMK0dgOq3sUuvyOa5vXUVZi6U0Ym/ink+/+WwOjCcKW1qu6GLtIEwAkj8hABcKOHRPmqQcDNxTdyKuiN3omC14L+l1Xqg7rtdo8BRPtyPy2lbZy9eAvIMd+ygMWd0WfoB17XkxDz90lZA2w1Bn5Q1YxXc1NoCDbVAva2ATOwxpD6V9dZfVk6V0XM3MY+ypN5Vqj6orBwL94NLgE+4CTQT/hwAcN/cN0yBqVYKgIrsjIVljQHtYcD/3hJM74btvYOhiOxUELGkjZa2IgPmVh4Fajh2WRJzYuZ3OsfUcGpYRRaUxoHnwdyVpE4eUfb9QWP4uzu1e0+fSUJZWpXHQiviqvd0qC84pxiNcZEhb+Iz/HqEjfuJD6m8o2VQ+YUea6Km9bApq1MSeYke42R2EkNzeKjnRdJX+lq/r8ionkNa0aJ+1KF0XZMfu17IttxefRVson5EVauolxnXFFpwk3bmREYmY+qKGAS5gakzv4wo08MSaNA0t9Tc0y3MM023dPl9wiXndK3n78=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR18MB4384.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(10067099003)(4143699003)(22082099003)(18002099003)(11063799006)(56012099006)(5023799004)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?TdPHoo+FQrMgGXQZFznPmzPnpheMJWaxEJQlkGCHfS3ohnYu6geXosX3yV?=
 =?iso-8859-1?Q?H76jJjvoGBLAgiW89UNYkwE36igR3yGrpI6yOny2DNzacu4QEs8PjQFEDB?=
 =?iso-8859-1?Q?Im+LOvekgNECrhxiZg6U0bdWnv94XSnqWs59uA22XvQuiD8USqpkSTA9mk?=
 =?iso-8859-1?Q?aqVH/1w2+yXYwh51zkD2Kw0deQs+RQH91OE0LnAxtDotCB0M+k4ZbwJPT0?=
 =?iso-8859-1?Q?8lbUUbhNgj76K1/6VcP7rA3jBGJbSKJrZMX7Nqy4qEfNHr5QtIbao+uS1d?=
 =?iso-8859-1?Q?7WBu0+Z9BeXE8w0TLugLHNZN0kvcIqLOrTKYBhHdThVt7Y33BYPXI73tew?=
 =?iso-8859-1?Q?rs8DCgWzpuzv8RJn0hQvuRMHsQK4fPWGs5l4GzSEAAWWCb3PoJ/MmtsWKt?=
 =?iso-8859-1?Q?VN6BNo2OBPpwE5Y1q9ktwCESiVuypj2vVCQ65R/NDr+shzvYIbF3cWwyfT?=
 =?iso-8859-1?Q?9UUfBtzU4IlEoUnInkT9E7FXhxZlkeOSxcdmv+ySt12+lLNlH8FkVVZIJX?=
 =?iso-8859-1?Q?K/iMabGklACbueQtqn7CITVbO31V53LL0ND9JcmIXauMfpgPZKZ3W8nCC2?=
 =?iso-8859-1?Q?EdmLqFtsVjNiivX6Vb6+/QkjeRLk5QaN5z+qxGI0bnLWJ2QvKU2X/YlcMq?=
 =?iso-8859-1?Q?fdLNpCRWLTeoqFrhWni8SXQbhQvFJZdApmTjJPNDiXn0EdDW6RrNLigmLa?=
 =?iso-8859-1?Q?Cl8YdJ9TVesgdNIB7ZompXuU+sONPASC5d2xQjTmUvdgSObIX8XD440D7i?=
 =?iso-8859-1?Q?EyWTtQqXYTQ2+86udNwaAhKud16r8WVt1lApVXUE+Cm3B72IHYYRPHiSKh?=
 =?iso-8859-1?Q?Ht8FE1Bc3sb+6ya/19v8TZprNRF9n9y1QdSMaOhJkWWp46E9ORlIKvpyNx?=
 =?iso-8859-1?Q?oOFNmWEQZdka9g/TX7f2DA613OVtm7c3+HPCGpyn2KtCnuKIUM5mcDZWOJ?=
 =?iso-8859-1?Q?kwXlmYHeMCn6xLbDFbBgPHDA7uojmEKAsI2kG+hYA/g3gjy0mx3LiX/JWV?=
 =?iso-8859-1?Q?JEkMWlWy7nWAbcQ/frYPkx/QoBH/ewBSDjU+3bu9AkYvzyX8snFVY7gD0/?=
 =?iso-8859-1?Q?bPShHoBmxMydab9I9UACCV2LdpJ0L3PUKZO4if9BH1hKaqTnA0mnFk8Vku?=
 =?iso-8859-1?Q?N7Xmwk2sdb1jexjyuoraGBVYsrzXPK+LiavVpuwLPp8S6KRT+vff4LnSTX?=
 =?iso-8859-1?Q?BPZ6fGB0Uit2758VzneKXEpf09eSxuyaKkbi2WtPzNBtU56/Q7LAWcPtUB?=
 =?iso-8859-1?Q?cgtKeshV0hxqDVKuM1j/X3QxInHbMLMRtXHlhYK+SuLECbAkEsKlXG2xDc?=
 =?iso-8859-1?Q?6iYfovEVBFOi/8ojOzwnFduxVPvwpdLlsdWhRl9t7lhhZXFdQ/E1fEoBsv?=
 =?iso-8859-1?Q?QOVQjCk+R3Z7Tj+aqv3Og9EibQsVhhkNuCtGxNFoMmjePawGK5Jl0RiUEU?=
 =?iso-8859-1?Q?eKsIFX7jXtUfXcgYeVhufScLpq9kB4jDzEZzwkjhsNJig7lsMJSzagDgev?=
 =?iso-8859-1?Q?XfpWStzOFr1aoySYYNxxtT2Ze+eRmIuQPv9Dv/yVVDGdNDoLsqLZz3iHhq?=
 =?iso-8859-1?Q?eslBuFjJBmbss2HmiEcxGk4ZdfUPRnVa6J02kOLDoN7aPY+3DbiNQSC9AX?=
 =?iso-8859-1?Q?VcVeR18bObG58L+8qTca1aOnm4DM/TwwVEvbnnj06TIdxSzc7UtqqybAeJ?=
 =?iso-8859-1?Q?+Ayaj/F274WFnppgLrMDVxGh7dqymlsf5D7pGyKvYMrAR8D12XHMJ4bUN5?=
 =?iso-8859-1?Q?vROqx4KVQ5M52I7UnJqCkaxk1llVOM0tO7kycMqYBAWnIm?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	lO9SN4PaTrB8UY27RPdnIfbA1UhCfd7dGoFNCPymmFRpwJI2Mh/W22HTiW4XifQHMkrIHoQsm+ajvHNGvr642etn6DrJ5PT4qy1Ofu5aKdiSoI7fJmdeXAJPLM0nRVgzjnGVKu1vDk4RRHSdpnPOcjQP8QwU68oLvfwH5mv9Me8VKoPLc1EiUmdg/KK0HLn7kLG3NgS9We0fsF169yew37kZyaxaCTnYRqf30REfCp9s0yhNSJU0eSwZwUaOmAhcD4/qJA4dSzLul/RrNjdfsm8AU0gqzv8xma70MpYvEzYTyAIGSfRLOMYOB73OVz0BLSAq4jSir3nFYfci496tUQ==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB4384.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acf5497b-a9b1-4def-fae0-08df154ee425
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 06:34:28.9124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ONsEYA2ZkFyObHgpRowNsmimqt247/7uJN4d3PtWV9Yt4wo/3IL1/x7IboVBg0HrkOL+Ri8bTKDXqHacbRhPqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR18MB988313
X-Proofpoint-GUID: xr3xx5hGwQqQ0UVt6NRe_ObEs06gZHMF
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA4NyBTYWx0ZWRfX+QUG47sicjQV
 /QSfqBiJ8HYo2vG0ltBERR6A4lnEXcrH8IUa0di5HR2mMnUyjhw0b8oaKpTjpXhCBfNpAZ2IlLV
 KEAezvCBxvWwzASOGev5FR2DJvS4giM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA4NyBTYWx0ZWRfX4xNWJRrzRRWB
 JsJA7WUzqZZzMDHd6az5YAtmGGbV9zoH7+zVCEJhMZa54sDYvts78i6AxPZsNn7inmcWeYGarT2
 2XWGDKcKKoF9+xpa3/KxBmR817H1KZD0PsVfwI10zi7lwxIxcwAC+L1oyV05Wc1sQGdr1HNhPxE
 4bGNOfJgKotg2jPMpGDDeacAOPU1cNTHiCHAD7SrzvJzrPNKEz6BCgaKdU3FiyUOvMZ5o92dBjc
 62EY9+zZFHPLMLJ1EeM4MLktJTXzs3XOEMdYYdOUi4132j+TbMb/HgWJJXF0f/GC4ub3JL6xwDe
 bRtIGHOg4nv8RazI1MGVCGrjPQ1ZuF/L9mfmh5dfk+tUaceXFgZP2Pd2BJehD/jF1zf4dOg75gA
 nezYuAdVkIDPtODewHU4+JcO+MD58fVKCmOIefsin1yRygPYrJZseKWscivIA5SXHJnlwXHL9cP
 +li3NVW7c9M1EJYqcrw==
X-Authority-Analysis: v=2.4 cv=JfApPkKV c=1 sm=1 tr=0 ts=6aacdb7b cx=c_pps
 a=opNks6lJvPUjoR/Ci7CsCA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VdqzKS8jKosA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=FwErtEDXAU5-nTxXkOkA:9
 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: xr3xx5hGwQqQ0UVt6NRe_ObEs06gZHMF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01

=0A=
> This is an AI-generated review of your patch. The human sending this=0A=
> email has considered the AI review valid, or at least plausible.=0A=
> ---=0A=
> octeontx2-af: mcs: Fix SC resource cleanup loop=0A=
> =0A=
> This changes the SC loops in mcs_clear_all_stats() and mcs_free_all_rsrc(=
)=0A=
> to use map->sc.max instead of map->secy.max as the loop bound.  Since=0A=
> mcs_alloc_struct_mem() sets secy.max =3D hw->secy_entries - MCS_RSRC_RSVD=
_CNT=0A=
> while sc.max =3D hw->sc_entries, the old bound was one short.=0A=
> =0A=
> > octeontx2-af: mcs: Fix SC resource cleanup loop=0A=
> >=0A=
> >     The SC resource cleanup loop was incorrectly iterating over secy.ma=
x=0A=
> >     instead of sc.max. Use sc.max as the loop bound.=0A=
> =0A=
> [Severity: Medium]=0A=
> The message describes a single "SC resource cleanup loop", but the diff=
=0A=
> changes two loops in two different functions: the SC statistics loop in=
=0A=
> mcs_clear_all_stats() and the SC free loop in mcs_free_all_rsrc().  Could=
=0A=
> the message mention both call sites, since one of them is statistics=0A=
> clearing rather than resource cleanup?=0A=
> =0A=
> Could the message also state the observable consequence?  The numbers mak=
e=0A=
> this look like an off-by-one that skipped exactly the highest SC id:=0A=
> =0A=
> mcs_alloc_struct_mem():=0A=
>         res->secy.max =3D hw->secy_entries - MCS_RSRC_RSVD_CNT;=0A=
>         ...=0A=
>         res->sc.max =3D hw->sc_entries;=0A=
> =0A=
> with MCS_RSRC_RSVD_CNT =3D=3D 1, and both HW variants setting=0A=
> secy_entries =3D=3D sc_entries (128 for cn10kb, 64 for cnf10kb).  So SC i=
d 127=0A=
> (63 on cnf10kb) could be handed out by rvu_alloc_rsrc() but was never=0A=
> freed on teardown or FLR, its sc2pf_map[] entry stayed owned by a dead=0A=
> pcifunc, its RX SC CAM entry stayed enabled because=0A=
> mcs_ena_dis_sc_cam_entry() was skipped, and its stats were never cleared=
=0A=
> for the next owner.=0A=
> =0A=
> That information seems useful for anyone deciding whether to backport thi=
s.=0A=
> =0A=
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c b/drivers/=
net/ethernet/marvell/octeontx2/af/mcs.c=0A=
> > index 211c10aa5880f..30c672d526a0c 100644=0A=
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c=0A=
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c=0A=
> =0A=
> [ ... ]=0A=
> =0A=
> > @@ -738,7 +738,7 @@ int mcs_free_all_rsrc(struct mcs *mcs, int dir, u16=
 pcifunc)=0A=
> >       }=0A=
> >=0A=
> >       /* free sc entries */=0A=
> > -     for (id =3D 0; id < map->secy.max; id++) {=0A=
> > +     for (id =3D 0; id < map->sc.max; id++) {=0A=
> >               if (map->sc2pf_map[id] !=3D pcifunc)=0A=
> >                       continue;=0A=
> >               mcs_free_rsrc(&map->sc, map->sc2pf_map, id, pcifunc);=0A=
> =0A=
> [Severity: Low]=0A=
> This isn't a bug introduced by this patch, but the new bound now passes=
=0A=
> sc_id =3D=3D 127 into mcs_ena_dis_sc_cam_entry() a few lines below, in th=
e=0A=
> dir =3D=3D MCS_RX case.  That helper picks the second register but shifts=
 by=0A=
> the unmasked index:=0A=
> =0A=
> mcs_ena_dis_sc_cam_entry() {=0A=
>         reg =3D MCSX_CPM_RX_SLAVE_SC_CAM_ENA(0);=0A=
>         if (sc_id > 63)=0A=
>                 reg =3D MCSX_CPM_RX_SLAVE_SC_CAM_ENA(1);=0A=
> =0A=
>         if (ena)=0A=
>                 val =3D mcs_reg_read(mcs, reg) | BIT_ULL(sc_id);=0A=
>         else=0A=
>                 val =3D mcs_reg_read(mcs, reg) & ~BIT_ULL(sc_id);=0A=
> }=0A=
> =0A=
> For sc_id in 64..127 (cn10kb sets hw->sc_entries =3D 128) the shift count=
 is=0A=
> at least 64, which is undefined in C, so this can produce a UBSAN "shift=
=0A=
> exponent too large" report.  On arm64 the variable shift is masked to six=
=0A=
> bits and 127 % 64 =3D=3D 63, so the bit that gets touched happens to be t=
he=0A=
> intended one, and the enable side via mcs_rx_sc_cam_write() uses the same=
=0A=
> idiom, so the two stay consistent.  Would BIT_ULL(sc_id % 64) be a=0A=
> worthwhile follow-up cleanup here and in mcs_ena_dis_flowid_entry()?=0A=
> =0A=
> [Severity: High]=0A=
> This is a pre-existing issue, but this patch widens the region it applies=
=0A=
> to from map->secy.max to map->sc.max entries, so it may be worth a look.=
=0A=
> Is mcs_free_all_rsrc() safe to call without rvu->rsrc_lock?=0A=
> =0A=
> The mailbox paths serialize the same bitmaps and ownership arrays:=0A=
> =0A=
> rvu_mbox_handler_mcs_alloc_resources()=0A=
>    mutex_lock(&rvu->rsrc_lock);=0A=
>    ... mcs_alloc_rsrc() -> rvu_alloc_rsrc() -> __set_bit()=0A=
> =0A=
> rvu_mbox_handler_mcs_free_resources()=0A=
>    mutex_lock(&rvu->rsrc_lock);=0A=
>    ... mcs_free_rsrc() / mcs_free_all_rsrc()=0A=
> =0A=
> The FLR path does not:=0A=
> =0A=
> __rvu_flr_handler()=0A=
>    mutex_lock(&rvu->flr_lock);=0A=
>    ...=0A=
>    rvu_mcs_flr_handler()=0A=
>       mcs_free_all_rsrc(mcs, MCS_RX, pcifunc);=0A=
>       mcs_free_all_rsrc(mcs, MCS_TX, pcifunc);=0A=
> =0A=
> rvu_alloc_rsrc() and rvu_free_rsrc() use the non-atomic __set_bit() /=0A=
> __clear_bit(), so the read-modify-write of a bitmap word in the FLR work=
=0A=
> item can race with another function's mailbox thread, and both sides also=
=0A=
> write the same pf_map[] array.=0A=
> =0A=
> Can a lost update here hand the same SC/SA/SECY/flowid id to two differen=
t=0A=
> pcifuncs, or leak an id permanently?=0A=
> =0A=
> [Severity: High]=0A=
> This is a pre-existing issue and not introduced by this patch, but=0A=
> mcs_free_rsrc() is the callee whose use this loop widens, so mentioning i=
t=0A=
> here.  Is req->rsrc_id range checked anywhere before it reaches this=0A=
> function?=0A=
> =0A=
> rvu_mbox_handler_mcs_free_resources() validates only req->mcs_id and then=
=0A=
> passes the caller-supplied u8 rsrc_id (0-255, struct mcs_free_rsrc_req)=
=0A=
> straight through:=0A=
> =0A=
>         switch (req->rsrc_type) {=0A=
>         case MCS_RSRC_TYPE_FLOWID:=0A=
>                 rc =3D mcs_free_rsrc(&map->flow_ids, map->flowid2pf_map, =
req->rsrc_id, pcifunc);=0A=
>                 mcs_ena_dis_flowid_entry(mcs, req->rsrc_id, req->dir, fal=
se);=0A=
> =0A=
> mcs_free_rsrc() then dereferences it with no bound against rsrc->max:=0A=
> =0A=
>         /* Check if the rsrc_id is mapped to PF/VF */=0A=
>         if (pf_map[rsrc_id] !=3D pcifunc)=0A=
>                 return -EINVAL;=0A=
> =0A=
>         rvu_free_rsrc(rsrc, rsrc_id);=0A=
>         pf_map[rsrc_id] =3D 0;=0A=
> =0A=
> The pf_map arrays are sized from hardware capability in=0A=
> mcs_alloc_struct_mem(): flowid2pf_map, secy2pf_map and sc2pf_map are 128=
=0A=
> u16 entries on cn10kb (64 on cnf10kb), sa2pf_map is 256 (128 on cnf10kb).=
=0A=
> So a rsrc_id above the corresponding max reads up to 254 bytes past the=
=0A=
> devm_kcalloc() allocation.=0A=
> =0A=
> If that out-of-bounds slot happens to contain the caller's pcifunc, does=
=0A=
> this then also write out of bounds?  rvu_free_rsrc() does=0A=
> __clear_bit(rsrc_id, rsrc->bmap) on a bitmap allocated as=0A=
> BITS_TO_LONGS(max) longs by rvu_alloc_bitmap(), which is 16 bytes for=0A=
> max 127/128, and pf_map[rsrc_id] =3D 0 stores past the array.  Adjacent s=
lab=0A=
> allocations make this plausible: flowid2pf_map and secy2pf_map are both=
=0A=
> 256 bytes and allocated back-to-back, so flowid2pf_map[128 + i] can read=
=0A=
> secy2pf_map[i], which legitimately holds the caller's pcifunc after an=0A=
> "alloc all" request.=0A=
> =0A=
> Separately, mcs_ena_dis_flowid_entry(), mcs_clear_secy_plcy() and=0A=
> mcs_ena_dis_sc_cam_entry() are called with the same unvalidated index=0A=
> regardless of the mcs_free_rsrc() return code, so the index also reaches=
=0A=
> the MMIO offset arithmetic.  Should the handler reject rsrc_id >=3D max f=
or=0A=
> the requested type before the switch?=0A=
> =0A=
> [Severity: Medium]=0A=
> This is a pre-existing gap rather than something this patch introduces,=
=0A=
> but since mcs_free_all_rsrc() is the "free everything owned by pcifunc"=
=0A=
> helper being touched: should it also release ctrlpktrule resources?=0A=
> =0A=
> It frees flow_ids, secy, sc and sa, but there is no map->ctrlpktrule /=0A=
> ctrlpktrule2pf_map loop, and rvu_mcs_flr_handler() calls only=0A=
> mcs_free_all_rsrc() for RX and TX.  The only release path is the req->all=
=0A=
> branch of mcs_free_ctrlpktrule(), which needs an explicit mailbox request=
=0A=
> from the function that just went through FLR.=0A=
> =0A=
> So a rule allocated via rvu_mbox_handler_mcs_alloc_ctrl_pkt_rule() stays=
=0A=
> marked allocated in map->ctrlpktrule and stays enabled in hardware, since=
=0A=
> MCSX_PEX_{RX,TX}_SLAVE_RULE_ENABLE is only cleared by=0A=
> mcs_free_ctrlpktrule().  Recovery appears to require a driver reload.=0A=
> =0A=
> No in-tree consumer allocates these rules today (nothing under=0A=
> octeontx2/nic/ references ctrl_pkt_rule, and cn10k_macsec.c only uses=0A=
> FLOWID/SECY/SC/SA), so this needs an out-of-tree or other user of the AF=
=0A=
> mailbox to trigger.=0A=
=0A=
All pre-existing issues, not introduced by this patch. We'll address them i=
n a separate patch=0A=
and reword the commit message in the next version.=
