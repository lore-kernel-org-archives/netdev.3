Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4868C4779B1
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805482; cv=fail; b=TnD43UYH2baBLppBJfsvfWzLaVEjN3wR0krk62uOcl3JAra5dNlBbPO9Sz2/IhZHQJZ4FzuhGs2ltVfD+EsLEybEH0cgJxEb1ELf9uHrxLsghbSmfEUTR81qS7gsM8NDEfUEMavDNFcagAJuQQssoJHSAVucKDt3dj/PgI1FSyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805482; c=relaxed/simple;
	bh=D05T0phNU50CkVYSQdoLEVOQTyCp0iGmzkIgdndcGyo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sADPL2TZukHq0pvbO0yb+Dpd+y3sW6VRBGtjEzXhs7jABL6B4Dig0AvNCM1kFH/cFwcz+xTFM6juyWx1An2ko/0M5iq7CisxOYZBfalhfCdoOof8RgTJ4eJBRDuoqccSMb7xcjRnZypROQfzpOscUAq/Tt3qznzUYai5s0dLvMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=oybJ2MCJ; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="oybJ2MCJ"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8KvVb2321707;
	Mon, 12 Oct 2026 04:44:25 -0700
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020104.outbound.protection.outlook.com [52.101.193.104])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4h8647uud9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 04:44:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fc8XJodiBxPaAon86UWE5MuzYQNUBwc5Fo+cSiLbUp7Be60vCV60SZy4ArTW+3UtoIv3QYD7H59v2Ht3KHEI+h30LOqCCGlLcnBO1oQnue1PHptenxU3k+jxiyW6wIVdYG0SZlJCbjLrfhmqbVNGdsQepeciHL88nKIbD+fFB76Q+c17JL7MHBAWif+ylFo395DNybpHreFB38m6WUhj3VmwAF0bQe6gV7ZxyK8A7mFM+Pv1Ozi6zKFhXJs3XQFLyvBosPuAQhbHD8m70e+11oMXxt1bEEhpk8flnT6GK34QLQC3vIgITtF2+vkasGTCpNzBuoTgBH2YKZJ2dSTATw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D05T0phNU50CkVYSQdoLEVOQTyCp0iGmzkIgdndcGyo=;
 b=VkcBCxK2jHod8uG1vO4A+0z3k0h38zy7WPosTc3A4ggqM7zE73icuTZROeh6C5pmOlMewxHQM6yj/FISOXp7ID+ojNUVpiK53eJnvv7jWeZVRu7cnVtnybYJwVWYyvMO3m3IfV9Vkklq74h8rR2T3NjY4mnhF/RliDYigpMvrxpIVNa1zCPbFpbE0vwxbMrxmWFmxtAnVOZYbaQOREWVWg8/09jWfOPeGoS6EPe8iF5SdCjzAfEc//FnANWL8S+czGCfe9FZeT4JoCGkC5ceZnqQWdOj6rFznnmbsOUsHzkOwRI6q7MI5xsla047wgo3npLx0732IsnA3ZLRtaj78A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D05T0phNU50CkVYSQdoLEVOQTyCp0iGmzkIgdndcGyo=;
 b=oybJ2MCJBa0Jw/G9Z0o4bWbI8BdEC1NZN1/yaqHncfjpUUW2w5wGogSFv5FRy7dre9JjYejemNfle46RPI3zhDHQLyHJS0pu+drVptB1Qlps/7Asgv4DnqS4hRIDn4HJ4qrFYDW7gJP4BzsTeVe0u21QWQKQRmzNGq8jFNAeQvw=
Received: from DS4PPF7D4D8EFA4.namprd18.prod.outlook.com
 (2603:10b6:f:fc00::aa8) by SJ0PR18MB5161.namprd18.prod.outlook.com
 (2603:10b6:a03:438::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 12 Oct
 2026 11:44:21 +0000
Received: from DS4PPF7D4D8EFA4.namprd18.prod.outlook.com
 ([fe80::1aa4:25ac:43fc:2a79]) by DS4PPF7D4D8EFA4.namprd18.prod.outlook.com
 ([fe80::1aa4:25ac:43fc:2a79%7]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 11:44:21 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Ratheesh
 Kannoth <rkannoth@marvell.com>,
        "Stanislaw Kardach [C]"
	<skardach@marvell.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "alok.a.tiwarilinux@gmail.com" <alok.a.tiwarilinux@gmail.com>
Subject: RE: [EXTERNAL] [PATCH net] octeontx2-af: Fix CQ enable state tracking
 after AQ writes
Thread-Topic: [EXTERNAL] [PATCH net] octeontx2-af: Fix CQ enable state
 tracking after AQ writes
Thread-Index: AQHdWX/KQDLvlsUnBUqzwoj36ILcQbb5yrog
Date: Mon, 12 Oct 2026 11:44:21 +0000
Message-ID:
 <DS4PPF7D4D8EFA423ECB0425B0B17B454BBC69F2@DS4PPF7D4D8EFA4.namprd18.prod.outlook.com>
References: <20261011125508.534618-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20261011125508.534618-1-alok.a.tiwari@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF7D4D8EFA4:EE_|SJ0PR18MB5161:EE_
x-ms-office365-filtering-correlation-id: 6d785fa7-e409-4d64-ccdd-08df2856282b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|6133799003|4133799003|261009223027099003|22082099003|18002099003|921020|38070700021|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 BQR8GI3TuTY06anr8yByxRknPt/bWuf2AYWHFygUzzwaSNb9sZ5X0g5irkpYdIAcJ70xjB3eH7dIsHg8lpmSveJRFwVuUInaH0OZmnNy6HYI0igpLrq/Q+TACj7eC0ElrztBg4FWIs8vLn8Z7fIk+qxWcdkpmKVcYOmmwsMq9V0epVFmdxiJyo73dKLGdEa0eVfywbJIuJWczNxX02IiyjN/e+H0AbnS3tV/WQeRu83WnbLoHql1891yRFVInf5rmRKSfxivhfvKg1dWMTjU2DJF1Cakq9XmAkmIgpeQupMi/j3n2DlF6F6dsQs2YMgxU/g87gfK/vOBwHTEfISJiuxwGynehZCDD8mmN6ncumunHtrZ6LwZyYRlN8ixJ87Am2F8aaqqE7hrFV72egapcwKheJSjhocLZAVAJDGUzQcKqWuy/bhGiZNOdzIIsMva/6rQ6sv+tJEZx3TOGhZQRCQYChh/ysdbmh8jzip+LJHpUuIR0GGEHpTlj0+DI3CP73+3D2l3fKgTlS8HE2bvXjRRfetasCblgE2ggLw6NGVEHkudsKXz8xpmS9tFfqB6QqUPsVf+4TmyAlmwL7Xal6GvP3+PPobNGdMcDqTWAQMP17JbJ2ZIIWIjeeCvW3pzMsjtlKD0EBh9L8DnuX2j14qICNbdMHbS2eWu32BCnBGXXxdlmUoxePYB3VNxVf/x
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF7D4D8EFA4.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(4133799003)(261009223027099003)(22082099003)(18002099003)(921020)(38070700021)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eXJXS3NvekxlUmE5clpwVkgyTy9iNFBmY0E2Z1pyQlJkWDBkaUxzak1mUVBw?=
 =?utf-8?B?R2x5Zi9mVEJGVEp2N0ovZ0NxaENFbTlaSUlFejNXZ1VYL3RUTHhjNHRLekNl?=
 =?utf-8?B?LzFKQzV5cVBOUVRGbnZKM0RoM0Y3MHMzUlJPS2V1TzZKcHVRTnNXSDFWcUdJ?=
 =?utf-8?B?Wi9rWnZuS3o5ckRubEZnWmpaYllXM1piNXNmU0Y3ZEc3T1pFUzFwbFR6ZFZH?=
 =?utf-8?B?TjhxOTVuUmo5bGZVaXRUbS9XazNBWmV6eFpSY3BpTzUraGM4ZkF5Q2gwMWI2?=
 =?utf-8?B?WE03bEJITGQ2LzdXcHJvazd3Yk9mNmRvNXdjSW82UVhya3FJV3dlZHlqRXlY?=
 =?utf-8?B?V1A5K0JKdVJRRW9JTFdDOFNhM0RrY05Dbyt6SnJpb1ptRU5IVmRvYkZDTGs0?=
 =?utf-8?B?c1lhZXNtVDMxU1k5dTBtRVNnUnBqbU83TWV5M2RJODBKT0xhVUptR0FjaTNj?=
 =?utf-8?B?bUpFdG9kTXBINVkvR1dSYWJqV1JQZzVHNUczYTgyczFCQVRyMmZneVdSMk5t?=
 =?utf-8?B?aWVpS0ZibStxcmlCc0pEdHp2YTlmaFJIdTVoL2JVRS9LQkM4MmhXYTFjNUJ2?=
 =?utf-8?B?Y2MwaXFpc2xBdGh3OHA5WXYvWmNJN2JIc2k0V2FmeE9mVU9XNTVHYllKbmw1?=
 =?utf-8?B?NXBodzBVUGhuS016R3Z1WkpMTEx1KytBSjdsbVRINEMxSS9TU3hEMFRNb3ZB?=
 =?utf-8?B?NzFDUU9zYXc1WVR6dEx5VU9zd0ZvUnp2T3RZVU1IaE5pZExaNlpYazlIcWhZ?=
 =?utf-8?B?d1BtcTMvNUYvcnM4dlY1cE5UdkFZM05MbU81VjBsWmVOVnVhR243Wmo1WkdM?=
 =?utf-8?B?emdrY2dHZDNOcEdpSTFSeVhLRTNsU2RBYnkwSU9DVUk3d3Bnd2dXMUx6K3FH?=
 =?utf-8?B?alhwSURSaHplV0JYT2FjRWs0Y3Fod0tBYU5rN3FPRnBucFk2V2Z3V05aOFVx?=
 =?utf-8?B?ZjBzSnlsdVJlU25qTE5sOUx2dzZTVGNyQlpZdk1GZk5sNHZ4amxJQTB1QW4z?=
 =?utf-8?B?ZzdDUy8xWWNaQ3c4dWNYeTJJdWFxNkNlQ055d1ZYUWVoMEhYd1h4NHM0K0dq?=
 =?utf-8?B?SkJHYjVVd1J3c1RUeGhCVld6U0JuZUlYTXh5ZmZvZFpBSjVZL3VqZ2hFdkVX?=
 =?utf-8?B?WDdTZTRrR0FMR2lCQXZ3REhKT2RyUTlnZ0o4eWRnakZUbWwybzl1NFVxRXc0?=
 =?utf-8?B?Q1Q5ZjFVbXNELy9Ld2JacjVnY3B4Q2NlN3RQSzh5ckpDQzVLK3V0RjQzTmxB?=
 =?utf-8?B?M3Znc1RoUitUQlo0c1BSZWZ4aXNJOVZBZkZvcUNWc1p0c2FnMEZ3UEpieHNJ?=
 =?utf-8?B?T0FkWmtBeFdiVlQ1QjR4WHFmTzNXSHRRc2wvcGlxaXJGaTV4MUJSNFpXWlFG?=
 =?utf-8?B?T0J3ZDZ2VFp2a2toV2ZudEtGdXNNRlVrb0doc1dNV01WOC91SEpONlVaTzlo?=
 =?utf-8?B?U3JVbkJxRi80ODZCQ01ydVhjREFQKzk1MUVXT3lhNUdxTjMwWTRDOTMwS3BF?=
 =?utf-8?B?TCtvYm0vV01SRHhRRURzQWpZRzhNaWwvaUsxRS9sc1BCWjVFSGxIRlZ2Rk92?=
 =?utf-8?B?MFAxQTJpODJIWmU5VnVuMFpoL2NKTGx3bEZGS21XUnhwRDd5RUhQMlk4U1BU?=
 =?utf-8?B?R1FpU0NvUXFOMTcvbzE4NUxlL2tKOTFDZmg3N0c3UlF4WGprTWVrQUIzMWlw?=
 =?utf-8?B?L01tZ3dOVENhUkpVNjdQR3F6NkFQaGxiWjBZTWZWUTRCUzFIYkNicFBVa3I5?=
 =?utf-8?B?bGphRUlUOTdNWkNKTldWZkFoQUtjV1p1RjI4bGFFckE5VXVxR1lzQmZLaTNs?=
 =?utf-8?B?NmRVa2lTa1VmL2JRbzdXT20rREVmTnBlUFcrN3VpRnB2d1QvUW5IS214MzJl?=
 =?utf-8?B?Nk91eWJYSEk1TktlMzgrTVd0amRWWTd0N1BHTHJkWmNZcDFCdU9iOHVPMHo2?=
 =?utf-8?B?NlBHN3hEWXpuRE5wNzZoRGtoNWdoK0owcVVsMGZ6Tlk3SDlLK2pvallWVjkx?=
 =?utf-8?B?ckhUc1E0c293djZoWWdXc3dmNUlYdEVPdTRVQmFtZWJXSGZRVnRCamtrM2VM?=
 =?utf-8?B?RDk5MTVOYkx0Q2dNVFFUVmdqdnI3S1lPUE5qNUd5OVY3U3VJVVJoMmRKOGNz?=
 =?utf-8?B?K3FscUJnR3gvSjlUS2xjaGVrK1RWbGFULzloVnk4NkxZT2JDOEdnemNxQmpu?=
 =?utf-8?B?UTdUVzI0Z01UMzdUUko1VWxtVTFuV1kxV0dFc2VSb09XU1pBSVRIbTlTWGlw?=
 =?utf-8?B?WXpiS2d6K1dINURjU0IwazFyazhtTlQyZ2F5SWhCbFZySzZaUjlYZFEwWkJH?=
 =?utf-8?B?bzVCUnpNWnhnVDdZcnNlZXltVG1UYi80MzFoVEhzbS82UlhGcXRZUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	xwpznYMpWDFd4ir5HaAM2YAP//buQft+9N0lgqOsZ46WnSdk66lFCHehPbFMGYbzS73kTYD18lXVzDCBGldUSSjcEgeA7FyXTU8R+JtL7DXr30JTVh6hcTRtQVz8MhbmrElKypzYUbUg7vFHvB1Ogm+Ee2xxKu0YBlRedeTGSdwyaZLp1Y61Ni1UX1dqZpv5Ys0kau4Pit9kFsbYT3W7/UJhMRbXDU1U9h45DVWL/tVmJETjs4mClU8EfwzGUtUI4hmPhYaATgeIvp1XEeI9zCYif+etgiJ2af+XunwTrKEXwmJ0OLnhinFwgPwGp7/ZaXWzp1h60pU0uwgcSVxm/w==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF7D4D8EFA4.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d785fa7-e409-4d64-ccdd-08df2856282b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 11:44:21.6043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: br6qtaar9EuhWIK/ZSElTOR8WMkSEhPlVADPQkZTjoQXLcr41di5vLXPgBaNFmYEMS8udAS2L7tFEgtRy1BZcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB5161
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: JK-hiKFGay3P0cudkVfRGziWm5sWfFId
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0NiBTYWx0ZWRfXwiyuwNdcPFEy
 l+RL+d2db0h0SCxCHKzaGOzABKE+ctQVcBu5eAEQJ61SSiHRO5SM6E1U5hiUz0gs1teRfsy67Ni
 azaDxTb1Jxk8O4bXzhM4Es/w0RqSPirCIplTlqKdXoE7E3eTn3uEVkZKSmj6cntPw9rOYvNf87e
 7VP5+iyk2RjiBsYCsxZl/qGsPStUP3JXOnIoc9/TvriG9C1qVGLDaCFR5IyZDIhPE7tJ/QjvhFy
 MvxJzJeYGk9rMgHfLqMIT3b9RFGLlFPo4LKYOAHbVKAD+/NOckk2BdwrOD09C4xLpiiL8vmwYvM
 i9hAugSCq86iVwXrY8ym8OOVHV8GOXcsw1hyK9bfyDjsdnP93JspXVauVdYDHhgJJyZYNCN/I+D
 DrFxUZTnyPrLbLbA9khmUSSeRr2Um8t17bL5Ql2DttMJtZjSwTbD2D/wieH0MpaLMwx3ST2Ldse
 CasA4BH0e++1aEnEqag==
X-Authority-Analysis: v=2.4 cv=MOD1C8Zl c=1 sm=1 tr=0 ts=6accc819 cx=c_pps
 a=vLRhozfdQXdtFHbAT0K/AA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=yPCof4ZbAAAA:8
 a=M5GUcnROAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=RpNjiQI2AAAA:8 a=u1uZkOqfyyUSf7Ke2lAA:9
 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-ORIG-GUID: wDnIPTWBsc2cJ3XpjGVhtF6Eh7ellzJp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0NiBTYWx0ZWRfX0kyW0Dr6ActW
 jjQ1Qjyyu7hP5QKy8Q7+b11lqfXZfJbEQKVfY1f4DjARA7686jaOlUEYbjBs6ve9V3mQCEZnIIE
 E1D63GYnarVTZaQcT8N6HAya2ewV1gs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEFsb2sgVGl3YXJpIDxhbG9r
LmEudGl3YXJpQG9yYWNsZS5jb20+DQo+U2VudDogU3VuZGF5LCBPY3RvYmVyIDExLCAyMDI2IDY6
MjUgUE0NCj5UbzogU3ViYmFyYXlhIFN1bmRlZXAgQmhhdHRhIDxzYmhhdHRhQG1hcnZlbGwuY29t
PjsgR2VldGhhc293amFueWEgQWt1bGENCj48Z2FrdWxhQG1hcnZlbGwuY29tPjsgU3VuaWwgS292
dnVyaSBHb3V0aGFtIDxzZ291dGhhbUBtYXJ2ZWxsLmNvbT47DQo+UmF0aGVlc2ggS2Fubm90aCA8
cmthbm5vdGhAbWFydmVsbC5jb20+OyBTdGFuaXNsYXcgS2FyZGFjaCBbQ10NCj48c2thcmRhY2hA
bWFydmVsbC5jb20+OyBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7
DQo+ZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNv
bTsNCj5uZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+Q2M6IGFsb2suYS50aXdhcmlsaW51eEBnbWFp
bC5jb207IGFsb2suYS50aXdhcmlAb3JhY2xlLmNvbQ0KPlN1YmplY3Q6IFtFWFRFUk5BTF0gW1BB
VENIIG5ldF0gb2N0ZW9udHgyLWFmOiBGaXggQ1EgZW5hYmxlIHN0YXRlIHRyYWNraW5nIGFmdGVy
DQo+QVEgd3JpdGVzDQo+DQo+VXNlIHRoZSBDUSBjb250ZXh0J3MgZW5hIGZpZWxkIHdoZW4gdXBk
YXRpbmcgdGhlIENRIGVuYWJsZSBiaXRtYXAuIFRoZSBjdXJyZW50DQo+Y29kZSByZWFkcyBycS7i
gIplbmEsIHdoaWNoIG92ZXJsYXBzIGJpdCAwIG9mIHRoZSBDUSBiYXNlIGFkZHJlc3MgYW5kIGNh
biBsZWF2ZSB0aGUNCj5iaXRtYXAgb3V0IG9mIHN5bmMgd2l0aCB0aGUgaGFyZHdhcmUgY29udGV4
dC4gVGhpcyBjYW4gY2F1c2UgZW5hYmxlZCBDUXMgdG8gYmUNCj5za2lwcGVkIFpqUWNtUVJZRnBm
cHRCYW5uZXJTdGFydCBQcmlvcml0aXplIHNlY3VyaXR5IGZvciBleHRlcm5hbCBlbWFpbHM6DQo+
Q29uZmlybSBzZW5kZXIgYW5kIGNvbnRlbnQgc2FmZXR5IGJlZm9yZSBjbGlja2luZyBsaW5rcyBv
ciBvcGVuaW5nIGF0dGFjaG1lbnRzDQo+PGh0dHBzOi8vdXMtcGhpc2hhbGFybS0NCj5ld3QucHJv
b2Zwb2ludC5jb20vRVdUL3YxL0NSVm1Ya3FXIXRtM1oxZjhVWWxYYTFDLWMtDQo+WDM2Ynh3VkQx
T2hIeXhid3d4OWk2QTd3V2l1TGlPcmdWUXQydXpJVGNhdnVjcjRZeWlwRzN4cVZyYWhfUERzMXVy
YQ0KPk9HM0xiVmQySUFxenFQcDMkPg0KPlJlcG9ydCBTdXNwaWNpb3VzDQo+DQo+WmpRY21RUllG
cGZwdEJhbm5lckVuZA0KPlVzZSB0aGUgQ1EgY29udGV4dCdzIGVuYSBmaWVsZCB3aGVuIHVwZGF0
aW5nIHRoZSBDUSBlbmFibGUgYml0bWFwLg0KPlRoZSBjdXJyZW50IGNvZGUgcmVhZHMgcnEuZW5h
LCB3aGljaCBvdmVybGFwcyBiaXQgMCBvZiB0aGUgQ1EgYmFzZSBhZGRyZXNzIGFuZCBjYW4NCj5s
ZWF2ZSB0aGUgYml0bWFwIG91dCBvZiBzeW5jIHdpdGggdGhlIGhhcmR3YXJlIGNvbnRleHQuIFRo
aXMgY2FuIGNhdXNlIGVuYWJsZWQNCj5DUXMgdG8gYmUgc2tpcHBlZCBkdXJpbmcgdGVhcmRvd24u
DQo+DQo+VXNlIHNxLmVuYSBmb3IgdGhlIFNRIGJpdG1hcCB1cGRhdGUgYXMgd2VsbCwgc28gZWFj
aCBxdWV1ZSB0eXBlIHJlYWRzIGl0cyBvd24NCj5jb250ZXh0Lg0KPg0KPkZpeGVzOiA1NTdkZDQ4
NWVhZWIgKCJvY3Rlb250eDItYWY6IFN1cHBvcnQgZm9yIGRpc2FibGluZyBOSVggUlEvU1EvQ1EN
Cj5jb250ZXh0cyIpDQo+U2lnbmVkLW9mZi1ieTogQWxvayBUaXdhcmkgPGFsb2suYS50aXdhcmlA
b3JhY2xlLmNvbT4NCj4tLS0NCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250
eDIvYWYvcnZ1X25peC5jIHwgNCArKy0tDQo+IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+DQo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0
L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dV9uaXguYw0KPmIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
bWFydmVsbC9vY3Rlb250eDIvYWYvcnZ1X25peC5jDQo+aW5kZXggOTY0YmNhYWUwOThlLi42OWM0
OWFkYWFlYzIgMTAwNjQ0DQo+LS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rl
b250eDIvYWYvcnZ1X25peC5jDQo+KysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9v
Y3Rlb250eDIvYWYvcnZ1X25peC5jDQo+QEAgLTEyMzEsNyArMTIzMSw3IEBAIHN0YXRpYyBpbnQg
cnZ1X25peF9ibGtfYXFfZW5xX2luc3Qoc3RydWN0IHJ2dSAqcnZ1LA0KPnN0cnVjdCBuaXhfaHcg
Km5peF9odywNCj4gCQkJCV9fY2xlYXJfYml0KHJlcS0+cWlkeCwgcGZ2Zi0+cnFfYm1hcCk7DQo+
IAkJfQ0KPiAJCWlmIChyZXEtPmN0eXBlID09IE5JWF9BUV9DVFlQRV9TUSkgew0KPi0JCQllbmEg
PSAocmVxLT5ycS5lbmEgJiByZXEtPnNxX21hc2suZW5hKSB8DQo+KwkJCWVuYSA9IChyZXEtPnNx
LmVuYSAmIHJlcS0+c3FfbWFzay5lbmEpIHwNCj4gCQkJCSh0ZXN0X2JpdChyZXEtPnFpZHgsIHBm
dmYtPnNxX2JtYXApICYNCj4gCQkJCX5yZXEtPnNxX21hc2suZW5hKTsNCj4gCQkJaWYgKGVuYSkN
Cj5AQCAtMTI0MCw3ICsxMjQwLDcgQEAgc3RhdGljIGludCBydnVfbml4X2Jsa19hcV9lbnFfaW5z
dChzdHJ1Y3QgcnZ1ICpydnUsDQo+c3RydWN0IG5peF9odyAqbml4X2h3LA0KPiAJCQkJX19jbGVh
cl9iaXQocmVxLT5xaWR4LCBwZnZmLT5zcV9ibWFwKTsNCj4gCQl9DQo+IAkJaWYgKHJlcS0+Y3R5
cGUgPT0gTklYX0FRX0NUWVBFX0NRKSB7DQo+LQkJCWVuYSA9IChyZXEtPnJxLmVuYSAmIHJlcS0+
Y3FfbWFzay5lbmEpIHwNCj4rCQkJZW5hID0gKHJlcS0+Y3EuZW5hICYgcmVxLT5jcV9tYXNrLmVu
YSkgfA0KPiAJCQkJKHRlc3RfYml0KHJlcS0+cWlkeCwgcGZ2Zi0+Y3FfYm1hcCkgJg0KPiAJCQkJ
fnJlcS0+Y3FfbWFzay5lbmEpOw0KPiAJCQlpZiAoZW5hKQ0KPi0tDQo+Mi41Mi4wDQoNClRoYW5r
cyBmb3IgdGhlIHBhdGNoLg0KDQpSZXZpZXdlZC1ieTogU3VuaWwgR291dGhhbSA8c2dvdXRoYW1A
bWFydmVsbC5jb20+DQoNCg0KDQo=
