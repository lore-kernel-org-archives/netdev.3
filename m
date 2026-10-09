Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E594503EF;
	Fri,  9 Oct 2026 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791551070; cv=fail; b=pL4kqV8apb3kyhMFtLX59vcWgersWs9MlYW4IMsq985iRuP4o4CAE2QNiCQ69PSevlA81FqGXIX5uMEutLglept67i5YuwpkxbirUfw7XRFYCHiQO4pSAB4+gar8Ac5DJ21t2D9r3+YkX6RSXYvt6c7k7yZawqSNEyHg/RIH6yU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791551070; c=relaxed/simple;
	bh=y/kha1pk1haPhiNpuRtyfVwAoCVXD0cDDXStz2KOv2c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S8cs8azjVk6faRYgsJkn9UI01WzxxQ1hcxndj5m6BTk4FvivyoULzVPJnC0SxCl6OS+s5yVeA1Xxc6BwAR7ZQBNT2EzV8ZbJoBKG5NQ5DuzuQ1JYrY1OpP1NutOJgNOOtttWk1WzVu4V5AtzDglqH7ZdUsx5g9z45uHgLPURJBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=Ubgl4H9f; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mNI6dveu; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="Ubgl4H9f";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mNI6dveu"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699BEmCf2961434;
	Fri, 9 Oct 2026 09:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=y/kha1pk1haPhiNpuRtyfVwAoCVXD0cDDXStz2KOv2c=; b=Ubgl4H9
	fOm6inzMhSQvSYKcOWZqe+60SErlT3siZ8GkTNgyf0VH0TuieTG38ZokXn/YO+og
	OGWaquAHbHi2ZX9Ky4dP7lF+WnGxQcOXLq6PgQHmgG6M+fDWynHquAuqYt6aBE6a
	M5yI+BLYagAAD/EC6iemgTP8DFmW0Yedx0sPpddNxn0RA/Zm6uweprUnicyb/n6q
	9G7SGlwTlowC84CuaQUK2dSITGHEPEDe7ushmwwX1L1o4MZgZkXAMtPbrc2HLkuQ
	YrGopYSK7w2tdjg3ghCTlkFW98MXTdGTCivnrYdTnAHIENDTqN7eRPAXOpYhsTD8
	Z2BRJFqQo8SoB0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=y/kha
	1pk1haPhiNpuRtyfVwAoCVXD0cDDXStz2KOv2c=; b=mNI6dveuJduCj91/aL+6q
	hjWlR/zJeC/TM7gg6tLWXwgOwOHv1/z2V4Xq/Ch7v2IZAKFmt2y1B7ClC2WLEC1O
	iQhh0iJCbKw8g1j0Z/2ozwMo/SmCqSHDKIxTdGBDLqymJXQ6LHZAuBkk0gM8SBCM
	WHclqv+OpyRI5Z64k0DKcehoppvkVZwgeSQevuIq3+MnmxObo1tYKH/ecbIxAa0B
	1iP2ibX+9mW/XlQr1JPfPPqPxoGX+NbmYchc0dtvdxdhwa3QI59R0UiaDNVaH468
	QA6SvuoOlJV7fmMqXAT7uhWqb9GA/g6CTD6sQJYE1kREH2QP+bvxaqL2s3kroHgB
	A==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010049.outbound.protection.outlook.com [52.101.56.49])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h6y7p0h9b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 09:03:57 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcN2+KnDtu8HS5FLpH2r7J3TuJNNUxBS7UlZocHuVhTj9hPdwY/YIigqy3R5OF7Hjtzix802tZ9YdHJP46FXHlC5X7urGLmledGmFrvcNJSBWwBSKp1r1UQk3mc1TQGcpbP7uiZDRpKyIEhd/3QhgjF2/5/qksoEcxl6Mo9T0M0nU2bLShzgA9OHlufzJARMxK9O9ydbbHzwCoUlrWnC7AueK6okrpRHC/yBw1MBItZrYKRTDpgwmKCa0EauYJu2/uND1xxRYhcwz3ZykEXhulAKtN/6tUIwtakv6EJFi/s1PviPcQMaNovqm6KeXPoGuIai8GKl9l4EZfOE/D9w4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/kha1pk1haPhiNpuRtyfVwAoCVXD0cDDXStz2KOv2c=;
 b=CDbpLBS442vwO62GebquY4zkpsvU5Q/RO5kTVFsGCXlZQE5DTzV4wJURXa/xH2JwfbFkt/biyzZDvF5JD0FZpWISHqMgQ+rXr4pQG18+joufm6kO0+I8mPx/HFMfsfaLSThuNM3hDgQl+jEB4zroCpzHIHUpn4OzYGX2t8KslKNuq+hKk3WRWCOfqBVbouLR12NH2y3HNHgMfXGqUWAFPuY3u3ojuq0xAGqyhbFnHy3IKkXnxbwWUz4HNGCKQZBsyisPNsRNdzkjo6NoRBpZKLW1jv+37vzhPSVR1Xu/jfD8ohmja6ITl389qQWoGiyd/WNt3nFQqgWpGZaONiyPLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CH4PR03MB8017.namprd03.prod.outlook.com (2603:10b6:610:239::20)
 by BY1PR03MB7285.namprd03.prod.outlook.com (2603:10b6:a03:529::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 13:03:52 +0000
Received: from CH4PR03MB8017.namprd03.prod.outlook.com
 ([fe80::c55a:3b93:d644:ed5e]) by CH4PR03MB8017.namprd03.prod.outlook.com
 ([fe80::c55a:3b93:d644:ed5e%6]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 13:03:52 +0000
From: "Regus, Ciprian" <ciprian.regus@analog.com>
To: David Yang <mmyangfl@gmail.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Stanislav Fomichev
	<sdf@fomichev.me>,
        Nicolai Buchwitz <nb@tipi-net.de>,
        Maxime Chevallier
	<maxime.chevallier@bootlin.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net 04/10] net: ethernet: adi: Move setting of netops to
 fix crash
Thread-Topic: [PATCH net 04/10] net: ethernet: adi: Move setting of netops to
 fix crash
Thread-Index: AQHdVszI/qHzodMRa0Kllhim//OC9Lb1Lr6A
Date: Fri, 9 Oct 2026 13:03:51 +0000
Message-ID:
 <CH4PR03MB80176BD31C3133C4E20002C589922@CH4PR03MB8017.namprd03.prod.outlook.com>
References: <20261008022656.3592191-1-mmyangfl@gmail.com>
 <20261008022656.3592191-5-mmyangfl@gmail.com>
In-Reply-To: <20261008022656.3592191-5-mmyangfl@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH4PR03MB8017:EE_|BY1PR03MB7285:EE_
x-ms-office365-filtering-correlation-id: c0083694-19e3-4301-7e9b-08df2605c445
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 ifdGAxCldBWv4sxVX1+jUV293vA1HrAY9oVbySiS0UepNbay+gz0nov83xDKZNnA2t8rRktMLadg92nxptXSNzOQegOZcxPUN6ZxgfaxWW44w3RMFVumjjgNgkrFG8+h/bHQovOO+gzDDm8MGYJ3md9xKsaQPGF6qckv/Bf5FjHgWP84JlLHeUFaiT7a52f05Ad5tJo35HIrRE/Mq+RR5s7LCehRzZxKsF0KWnEJHDx6LMu0kKh2pte/DMkCioTScU+p8iXRysgRE5hy3+zogV34vZufYrFf9ktwsioeRSKeobQw06qpeIFS1J2YcgrngQrCoiGFEGzz99pQCAXlx0kCmgMDI7blm5HOkBSPB52thazg7fFk4CANgbpcpdD6N+V/wqxZSaWt+jCQxPyPsVtyxDL+IkSQfsALOEzmdWKWluk3nyjxYIOPOF8oqqgzarYd4QIoIHl5m7VJCpS5xpqNHjGecBZWMe3tmFlHPc7PyavN1ae3sTGLHgbZ8D41V4RJsgGK/n+j/EczKFDvoWE/K+h2OYjFeDO5+HeNhdfE2vg7v1GTqw4kzpppasIOty1tfJKNMdWwt0C4EVhfGIluooTL92INoRYsBzI4vm496TNPNiI80SwvwNPjxjCPbFHLK/eBzw5M2+3P+OoDMggDDLGY0ahFVTULe4cESPDjbDmfrOQGbQgpUzYsah+WVZ9oYc/NkVouxTO7bwpjUM0mp9ShsI1lQ4udEJjCxBg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH4PR03MB8017.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3H96acaEwsUeRBCTQjscilUKO5tsjsIrDvJmPSInz09liR/DQdh4XRNlCFth?=
 =?us-ascii?Q?GYU0zI6dT1wk9XLE1SLyFEqsaqEMFLm7a1YCAmpGAQTAuTSPFVW/sKUuwj8X?=
 =?us-ascii?Q?oV1i8r2KavTtwWtZFziITUQqyLeqypf8CZk73OijBFRyGJXbGc4bfwX167qL?=
 =?us-ascii?Q?FBjHs9DDH0RlLMe2Og0J8AyC9aSiU0TfgnnhAQKIlFJTzy+r1/+yM8BkqAAj?=
 =?us-ascii?Q?65o2bBvvp40N3prkeh3DiahyxlDojhk3KJVG3BJCmVYMSQyXz2zzzHJECUeM?=
 =?us-ascii?Q?oKekwe5v1BV9gdI5Ar32P8FaejPmlAMztu/Wfykmzign4sKH4mC7uT2NmJ+S?=
 =?us-ascii?Q?vo1e9afzdCVXnnuD2Hw5h8Nxe9C5nhhDIzw7bCRk3qDW4BGLcSHjsK3kxX+j?=
 =?us-ascii?Q?H8xtRFawdFiWKczW1/07zLBHOlGxNXu/PBe0zy8S4qnvoj/c6dWIJ6fHFz15?=
 =?us-ascii?Q?9tkz6Qyyyevf7OHw+whMXl+sCeYGrleYJ7vA+xID5z3aX7QuVSSm+ZxVjziG?=
 =?us-ascii?Q?OzCjXhuLvjrEjS/7CxbYR7IuFVSjM+zG/yJWVl1fBo+btp2WKiJYwlgBSvv+?=
 =?us-ascii?Q?9c4Od/Umz8RRle/uw9NM0ZgY/Q/ewjKa4AODmLcTmRxyZClGRy3O1MrOhK63?=
 =?us-ascii?Q?yumsDuKdFTTQyS3DG0878N5Wiq5VnBN5J7dUkMDPrQRAniOElopDKgMxpOrf?=
 =?us-ascii?Q?nFnXgXfVdjlBBYHVu1tyQ6/w5GFWT7ZALSLoay47k4x4YnFkH0qFi0NxwH3a?=
 =?us-ascii?Q?ESor3VYoKU4JNC3HRPqAh41zL0Z2T95YtvJIfbSDJJRWbwrkEhz+IgOsCjUp?=
 =?us-ascii?Q?gAW52rJOHHfm8wha+pT2KzYpEyVw1Q5PvqeVhefChnbOzKKWApFjTH2iAeGv?=
 =?us-ascii?Q?KUf50VbinpkuhRXIxWj0/XIIQG5pqSAexKsUrsV+njuXPdWVKApCriDr1/hg?=
 =?us-ascii?Q?aIGpzpUkcAc2wVs4tZ3QpgIgRtCGNvEw51kNNYSPPo3WMU+RrzFiklLJWCXY?=
 =?us-ascii?Q?PCkJgieZP3fXqqsOu3oKYzZ55nreKHsvjtYch5gmY4aOAymd+s7a0zkk1i/9?=
 =?us-ascii?Q?MQVsRf2CG/yIrIg2/UVjYdQASU+bo8tR+E1fDu0TtDzns5CL6WRiXBfnliMS?=
 =?us-ascii?Q?cR3FOkQHxwcRM+ea5DF0Y79f6O7lXOqgqJWUUFtOC+qdvAHZISYf4gnN+TGr?=
 =?us-ascii?Q?7I4y2NYGRnhz5S06MPp1Lic5NO189xeN+BvQpcflMj8VHy4PiPlAg+3elEYv?=
 =?us-ascii?Q?Fn5zRYlLHtBG+WLs3Aa70l7w4TufBaZ0Kim7kSI/klP0dfhCdY9bZj8p1Ja3?=
 =?us-ascii?Q?CF29hPuvBeFq4EDo+iuVYnTHnDUjAzEPeBOg/b6a8gMzTJ5xNVUPvdWZbQo3?=
 =?us-ascii?Q?Ssmx28UmikKJAo6Alrxw+IUiV7zCAuhm24B91G/MG5W9YF+CxVEufJUAfDsY?=
 =?us-ascii?Q?syTkrAJVjtBQLZeZraUvxh1LY5ZuOOYID3QLtgl5Q4v7UauUscbB0VcMyOTG?=
 =?us-ascii?Q?Yb6HyWmnOHaRYr/xfbfhvdSPYv8Gyeu9aT4hymktYdqr5wXT0ZD1vAYdhslw?=
 =?us-ascii?Q?EHP79D8xrIw4PV85EmXJKNzqLTAHYZ3m8Z4fSkg/xHqP63c9YuOxOeKzDKw7?=
 =?us-ascii?Q?jIu5QG0kxp/377YN89Ntu2+bMv1sZJQFZhDNK7ucprCIokkBnahNCwrbNY2a?=
 =?us-ascii?Q?65cVtCi1r0CMQEHjrzSNkqp6CTH27/royplFVOBjQFNjt7mI+h49XL/0g6/z?=
 =?us-ascii?Q?tlqR1r7UyQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	eDK3oafzOKlaQcOACU9gLKdh5e94R1HIi5XJLTPHqNAHiTZtTrr/SyYjKwJgDrrnmZ+YzD42kvuS83HLOmb/njxKRAYyTpxPxQ9ZQiss1hVVCqaaeaa/hDmH9RkMg/twSLkahM1fsA+3F7kqf7UmsFOIdy7J5R8BPlzku2/EBo2mnTYP1tc1W1yF2gcIv+oja1KOZnvE24b/t7Yi3B3ZRx/BoVCmYIX4elpR4UJJOPeWNThfOushAlvd0NGSludE+AheB2IccBDzccjonzmvpkm2GgudhxMBRwc90iuwjuJ8C41ZQPA8HKl/gYjG+fjSrrn0AqNX8oIc0Es2RnnCwA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH4PR03MB8017.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0083694-19e3-4301-7e9b-08df2605c445
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 13:03:51.8338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FMfy+pyvyTjJkbyigtLg6oyc+GBseFOVtTDOWPkjuAHgm5snLpA3Uv/nQfy1VN4QS3XApwzEJ89kMCrateMJE4hdvSfzm3vCm1R5R2ImIJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7285
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1MSBTYWx0ZWRfX55zE+DoV94g4
 Ho83ftjKcCge8VxIbT6yeRnsej5pZKc6/s5dtERbofG32kNGhauArFDTWf47wzLzivZntZLf5hm
 GORxGPStE6cPYW2cKL4pjvI2PaCWfSoiP1QfLgy7dgKPQtJnC2Q9
X-Proofpoint-GUID: sSh362oJzgWpaUyubR_2ROnG4pWt9wXw
X-Authority-Analysis: v=2.4 cv=GtfXaU1C c=1 sm=1 tr=0 ts=6ac8e63d cx=c_pps
 a=gJeMUiwA5g2xtJW4k6eMww==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8
 a=afN2RbJQjZHwFQhbCQAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: sSh362oJzgWpaUyubR_2ROnG4pWt9wXw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1MSBTYWx0ZWRfX85xYYqoI4lqn
 v88UQm2gG3u2QV0rCLQadqA4S/V3vEoj3XV1x8FsDIBBWz30V2vyycgUH3iDmw5Wm2gcGfRr4bj
 mu3OZsI5iqTwqATm+ohYRT8mPfD2j0IqOB8Hk7NUfjuqkmEShPskqgyRAxq27pH0Ai/YvRJ3h9r
 0U6x8BGvP/At5Bx2s1/dteL/+o0epkoijx4NDjYfaVzp6xZgl8QbnpzaJ1XyslXCxlI/ovD+9XE
 uygbkSqNKQJweCnO5yIgiUD59urWhZtbFKEofWUVWRB/bVkAoRX4H8kzYk2HGb6I8dxQeAWnvsX
 fDhSMmRFOLHAMQy/mvWUZ7nfFqnilEl5/tC+61NVQzHfg2MjHluJK6UfLxfDJ5zvLGeeul39M+g
 tN1INjj5yvqwqcnmeDnxutGYkxtv78JecYMUtfq8xaruk7vSP40lUODDUVgCxGjaNE2he0Q3YiJ
 n2+byhkjpWWKSuUPrNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 clxscore=1011 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090051

> adin1140_probe() calls adin1140_phy_init(), which connects the PHY,
> before netdev->netdev_ops is assigned. phy_attach_direct() ->
> phy_link_topo_add_phy() reads dev->netdev_ops through
> netdev_need_ops_lock() since the commit in question, so probing crashes
> with a NULL pointer dereference when CONFIG_NET_SHAPER is enabled.
>=20
> Assign netdev_ops before the PHY attach, as was done for emac in commit
> 7c9f391ec89c ("net: emac: move setting of netops to fix crash").
>=20
> Fixes: ded86da4bbb7 ("net: ethtool: relax ethnl_req_get_phydev() locking
> assertion")
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Ciprian Regus <ciprian.regus@analog.com>
