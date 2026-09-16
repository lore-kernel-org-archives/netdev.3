Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B792E6CA6;
	Wed, 16 Sep 2026 06:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541417; cv=fail; b=H79Zzq5uFlEhguoyt76Zr3CzFuuvn5VEn2wJlizrOMDePHQauQ+hnxARyaeiL6N5RXa2a+QQGLUwh1UCjFPWzozHu7yywXLlCPvmLN07c/pjF/m5TAQ0Ka1PsCrWeq2OPWXRwenMQ3SAJe21FFjMCdL+4ps8/ucDMEij2XNfnPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541417; c=relaxed/simple;
	bh=9uwES4Ua0rM0G/fif1fSSejtVqfvFnCM4I986erT8qg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yu25e98tQxVFhGVhk7HwwlLZacQ5vy/rLvO0eL1Bv2MPjQwRjjMH5dEdLVJ4NAGLBaxrdATSoOPFOPRkmtkwvVNHqnp1d215V5I2vMat7vj1nfuq+tLRj1yZpXt/NA/dxx/LvaPPF4nGyC8eG0pzt8/MMQKYIMEwUO6nfInMQuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=szKlkaT2; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="szKlkaT2"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLZAa8473334;
	Tue, 15 Sep 2026 23:50:04 -0700
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11022139.outbound.protection.outlook.com [40.107.209.139])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gq5e4pb8m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 23:50:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgMDfFdNuyIEsN+ACsB+gN1XMurerD9AjvcE+DMJOXL6wfB2ho2wPxMPcsYrhLIjXLXmME5YZazkMxIw8pnphJR9GStokwbtTPPXDIWffn0+1mi9bXK3YW4B5sDW6zjW8qLxk2Nrr3wJlhdTvm4YyJRbAgWjcvFvZgf4Wp4HtZC9tdGRnbsb/kR21+EYHpXlYlDKbaV711DjPnNQB0AglM7z4PuvUg9Ed4VadqR0TeZYCxLOL80VDLpsMhh5NUPiogyOgcAJTeYmTOBuB2jrxhrsSl3ij+qupkk2vxPTBWBhh8H70d6bODnmlVOt5WqLtqLZK/pgVyg+/RY6iqfL+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+fe5u1WuUHARWGJvBu9+rkFjJBFUfhMeR1fVBoAb/A=;
 b=cOdt9XXNLDs03iyakX05kwOM/PK2Ms10Dj9072SyBQF/WW8e81en3UlQOAsU9G2LzaZ2LQnIRXi64hJvXFFvs2UIx0aQqXp3WQcVC8ahff0rw2SU+M1UGxo1Gjbq1ZktBrzbOS4CHsdx45A5ESANs2D/LfLLGeVdXnYsmYJOFyQ6Vzf+DugcwBwfs6nIWxjaW7k4s1eIOaaNDfl/85yHoOebjKHq7+NDSNxXQK/f2tkAl4XR5xU/Ajn6Fnj0tlC0UUB3mryVIqocZHAkQQC256o9BI2F91s7+iK75WF85qMSp++uWPgfYGOeYsj7sybnNph5Si9wYxNcEuziDGFcBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+fe5u1WuUHARWGJvBu9+rkFjJBFUfhMeR1fVBoAb/A=;
 b=szKlkaT2xLxwrkCO1a62amNYSuoBvndvn1tb/ozX7wSMqBgj4vipLccC8J32rkD0wMwLAD3rdW0FeGr2WYZ0V4kks0iB+k7aPF8T4fG9jDgkpEU9+hHGfd09ZQ3moM4+MkVY2cgpJTEMCdp4siIdrcJT79nzD+SxfVKWPZgVK8c=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by DM4PR18MB4285.namprd18.prod.outlook.com (2603:10b6:5:394::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 06:50:02 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::210a:9dad:297f:3540]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::210a:9dad:297f:3540%5]) with mapi id 15.21.0382.014; Wed, 16 Sep 2026
 06:50:02 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Slavin Liu <bolin.liu@seu.edu.cn>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        Subbaraya
 Sundeep Bhatta <sbhatta@marvell.com>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH net] octeontx2-af: validate MCS blocks before
 initialization
Thread-Topic: [EXTERNAL] [PATCH net] octeontx2-af: validate MCS blocks before
 initialization
Thread-Index: AQHdQ363LJjArLoe70mDsmGvUBlt7LbQxFMQ
Date: Wed, 16 Sep 2026 06:50:02 +0000
Message-ID:
 <CH0PR18MB4339B9364231B6E9A8AF0A19CDB92@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20260913125206.109985-1-bolin.liu@seu.edu.cn>
In-Reply-To: <20260913125206.109985-1-bolin.liu@seu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|DM4PR18MB4285:EE_
x-ms-office365-filtering-correlation-id: 7f103576-fa9e-40d5-4719-08df13bebbaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|18002099003|22082099003|38070700021|10067099003|56012099006|5023799004|11063799006;
x-microsoft-antispam-message-info:
 +t4u1cxo/azVY5IjiuMi8aV9Xf2l13W/D0TSrMBP/4ewvB0QGAieBUq05KZ1Ayjlj9TGyo8ybnVl1V/4mXSU0I5vGkeLGwq2cwNzj2aNVfiBGjjfWPvsUkOD7JNMzQG1paz9N5mM3FGZrMhP+EneJupcmPGW6YizKsN75EGkV1R+nA0jyNmWZBHU4Z3C8+pLtWcZnzyphnPikUkG43mU0rQci/azZE09m3aIB5Ss16L3wAVoVgH0HOBJWiKfS3NzEYShtKjGA8oTBKuvqKOJ7+yGdImwY664I0jQtRLoX3TjOSQnzvxSKfXmc2fgmXr6BcG/PFaAsxW+32dDFkfwEOtEUejNJOQiyLsumRTFgaXJXOwflYH2shrijP9SyFp74O3iYgobjUahQ8oWX+WretRv/gtLdUTyjVbwPRjEn1qCLDsRpqUmcYU9pnbUdlwiydVzZtF0qW10V1PD71YJozHScKZ4ib9LEEpNl4P9wn+tbmx9OTuROvYrXmhcBa29ebBKv7WmS/CYrAAe6E/FQBguWvpqIGW5qa1pzlokl4vveMStMRURjMNly9d6qeF9h3UaTr1BSI9q+lame7XrwL+Sxy98A5sVqV+46HTJO7i86k9Q4d8g2kOugQj4Xe/ZE6TQnnri9mpRwUkopEONWMwD6iVnM6buzwhshk1QA6WsnuZwzqal4S1It52zCgJ9L+uf6TS3WxTHkEoFVlgUNMPGqm45CpAykZfv5aZdueg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(38070700021)(10067099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0yVIPuKVLUkzy+8g9r1whNGW7UmeKIUW38Jquzpygj7VCW/lxq15lCcNmije?=
 =?us-ascii?Q?ntloEEaex9LLrpqZIjJDqETT4Y7pyXmFCy6MLSp/LKzhVb9kndL7SJV7l2gD?=
 =?us-ascii?Q?iTOedl8Yr4K+7hXArEMPGEAM+T5Az1CmvPvi2qH5EdUbkpYjdl2TULf9/s7i?=
 =?us-ascii?Q?iGScfvn4g82xh0BOCFqBZCc01ma2lMrfzk5PwY92jkcfAb7S4wAzOu9XAJBR?=
 =?us-ascii?Q?sEXXz1mRnuKmuIRwFJ8jxh3A4wwrCh5f9+JeaS/ps6Itr+5ZRibe4vYZhQNC?=
 =?us-ascii?Q?4S16lYj73FzpsHtZZaZKoXvc5JKVsR3cLG1XaE82VhwFhjy+yoNveE5xzpVM?=
 =?us-ascii?Q?fcm5ZG3fshm3HOEY60uKr+Tzq/Ic/g9MP0/LJvQPauMt/1DHwl3MYkKQHrgu?=
 =?us-ascii?Q?NtBIPW/XMAeNFFz1KAa0gdqVQdfnRDcfvtxbDke/KXykKIjoaRN2SW3YRZPi?=
 =?us-ascii?Q?T90v5GnTEnZ9PaNVKAAxNOgNrYqOGpjeOiYM1w5AYR5yZu7BViAf2oGFVHlq?=
 =?us-ascii?Q?OR96fQfI7xVGVgv/rM9T5H7o5FAZYP9If0mnONa7srnThNOH1UrlRZH/YcKC?=
 =?us-ascii?Q?VeW7bgXsnrWCy7HohPXxBGEepajMpini09MPDAtE9PiBan9zvBoWNI7VSOwc?=
 =?us-ascii?Q?CH+NqxI1bwmFPBLtqcYpP8mlwlvMPIJQWz+vrde3DwVdK4Vw2yn3dJF2/fiU?=
 =?us-ascii?Q?GIKwMnNJx/RytqTJ1MwBzQZjYcLS32zkA0HBe0uF+OeczWfmaLEINJzEVqj8?=
 =?us-ascii?Q?Qo4juZebxPtB7PUmZpT44ejV0hLr5suEGzMOwgCiZAO/sl1A+xxkLH0JwRIR?=
 =?us-ascii?Q?fJyAn8cGKua+CXzRWe1kHYUa/ASG0hZ5/T46xNCPTJnIhcsyQsGJrxCqQXw9?=
 =?us-ascii?Q?D71bC9dEXmr3Ft2Prwa4iVzg/xH5N1ykW5ychOM/XwoOAdrWCKPZ1LyeAwGT?=
 =?us-ascii?Q?T6fHfir9GwqQmtmWACJc0QLFrug1k5FgJxFBwCaQ61QgNIsrqH96phaC3L1G?=
 =?us-ascii?Q?ubvs6p7TJ2qq9X2cw51xQHthi0nscH5gG9n4WmAqLLxEC9re1qfXza3ad42q?=
 =?us-ascii?Q?HDcs+pInQ5ik9qwCaFIDQ1qWOnZN0N0OqZJkxi8fw7Zc5Nu9bgiBlLQP4S/a?=
 =?us-ascii?Q?OX+7lVk7bOQcQlr3WYzxNvDnrkR9dAmPCu0CoL9msAQzaf556ZVqd1QHh8jn?=
 =?us-ascii?Q?sEZ9XzNN+5YwHT95/+4Gu4r93dCoLB58G6OHDFaQqfDfsVQGJ6jjAbLy94Et?=
 =?us-ascii?Q?xOKbccXNtaOXX9aUIVvwtuJCy3o15ssBkrFdvvAWqw/Npf5IrUld7dM6yqNG?=
 =?us-ascii?Q?lFIhC5VM2GANInnzktOv+saGcsZ8TyMVrAQuKfKT+uvynhk4dJTBoW22XUnS?=
 =?us-ascii?Q?K8tTKPoj4Q3DQQHWrlwkWCAy2BfPNXHk3HBwMaYcEFfDPKXr6QpjeTUgfyYB?=
 =?us-ascii?Q?QHOjskKuSHv/hU3FZjFqBc4OleOGkZaEgfB7b78JiAFua+PKVzYTj+OOH/Kt?=
 =?us-ascii?Q?0+XinNS13upd/TM3ArBj15pxbSPi7WM1H84McH9KwCHFykP1eW7rdE65+BHf?=
 =?us-ascii?Q?v0pK0sNq1UqQS94HykXMqZzQpJMHAKsadEOJI/rB2Co2Ba/Wsf3fcAlemGjb?=
 =?us-ascii?Q?AhqXL9jvP/vyQRVTiG22JZ9orNEHIy4PVY2K3sT/aFihcS7StrBQH9YaceUa?=
 =?us-ascii?Q?6lIktYTd2UFEQ0S8EfIO3AihfKpfw+8aqBXGUPyLOAwR11LE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	TUQsT5LGFmZz44pZ6j5p0h5DRXYvUDHpx2OOKaMDepqSzngfwrsRpWZxAC38UgzCgoI7BqET0JWjFGb5Gytmrz+brCSYQIFcoL0vU6fHY33njTfA5USc7wbg9OzzlSl2ZvHtCBezc40LtNb3jULNvYWpfi02wA0892B+D/HJrAank1qN49Ye5yN2vqDD8oG7BfJwAwWdkPMH/KwDPeS9hV5alVeOWprNABCAeVRagW5mxTigXkZDLZah+tTZiyYPBC7QAyOvmTuZlPitVG+PIjWMMAjdbZd5WnZGSDqZ4EOxUM3oJ5TU7raU6Zam5FisL1xDOUzLOv/4jSVq8sV6mg==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f103576-fa9e-40d5-4719-08df13bebbaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 06:50:02.2892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zUANMByoI4tF/+60M78VIMzy/L4sY6OikYbuvDM+H+/6j6yG10Yxw3Y1GTEMPyYwHCkMczvQ9/GRHxv8wSKh4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4285
X-Proofpoint-GUID: yGtcP9i8ctkPfR1ipCrqyzibU7x6h0HJ
X-Proofpoint-ORIG-GUID: yGtcP9i8ctkPfR1ipCrqyzibU7x6h0HJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDA4NiBTYWx0ZWRfX3UolFMukTKXE
 yPc/Wku+d388dLkTJkUDtTGSjH/17ASSnUFUyv54wocV6G4zK7lifKxoAONs72CgAaDn36A2yVL
 i1xUUWh6jIZu//Z85SVBLtt369cOLlLBKGDdo8oW7TdX2uNWP/NECtH8BNIs15zwfmgNBIuBxMt
 Ld9vz2xpdJ2LLy3DH1p3P9zU9DpLE2H4D3tO6uViuNat4UJwFh1K2fCvvknxxJ/oeTX0RELK5r8
 GgUs2hucFf+fDKlft2urgo+wFdnXayBeD66IgKvFrj2/zcJwPnQ0O/c5Z4oM74C80aOzqR/c5K+
 fVpnStK5ktc2IKtwlwcFnAgPrtDfcgBHd5E3g6jt7RwmvkhqfHPPRvdRrWfG+YTeRpQKNldNa9A
 GjKBNFemPuaFexPtD3F97/llCpP0lhiv85pmSkLEu4WwhNL9XGfv4yB/id9Kveps9YdcaQky6d+
 qKsReiGz0rPBUb3g+PA==
X-Authority-Analysis: v=2.4 cv=N6W8hG9B c=1 sm=1 tr=0 ts=6aaa3c1c cx=c_pps
 a=A91p8pFdSY8iZOlwlHItIA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8
 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=4oP7AnTtpOX4v7av_QoA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDA4NiBTYWx0ZWRfX3nN3mVSpee+V
 MrJs64DygHRiTMoZv033UPddrPEpKBtJ07HCXMsiddGmfcStmWZzI9kv6qAqZenpKISL+da6tnR
 He4Na8dFmBFzM9u0LUU/k16TfMgBkwQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01



>-----Original Message-----
>From: Slavin Liu <bolin.liu@seu.edu.cn>
>Sent: Sunday, September 13, 2026 6:22 PM
>To: Sunil Kovvuri Goutham <sgoutham@marvell.com>; Ratheesh Kannoth
><rkannoth@marvell.com>; Geethasowjanya Akula <gakula@marvell.com>;
>Subbaraya Sundeep Bhatta <sbhatta@marvell.com>;
>andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
>kuba@kernel.org; pabeni@redhat.com
>Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
>bolin.liu@seu.edu.cn
>Subject: [EXTERNAL] [PATCH net] octeontx2-af: validate MCS blocks before
>initialization
>The MCS count is a maximum successful ID plus one, not proof of a dense
>device set. Validate the complete range before programming any block, so a
>failed lower-ID probe cannot cause a NULL dereference.
>
>Detected by static analysis and reviewed with AI-assisted source auditing.
>
>Fixes: 080bbd19c9dd ("octeontx2-af: cn10k: mcs: Add mailboxes for port
>related operations")
>Assisted-by: LLM
>Signed-off-by: Slavin Liu <bolin.liu@seu.edu.cn>
>---
> drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
>b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
>index fce22e314cac..0ee2d0d698e5 100644
>--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
>+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
>@@ -889,6 +889,11 @@ int rvu_mcs_init(struct rvu *rvu)
> 		rvu_mcs_set_lmac_bmap(rvu);
> 	}
>
>+	for (mcs_id =3D 0; mcs_id < rvu->mcs_blk_cnt; mcs_id++) {
>+		if (!mcs_get_pdata(mcs_id))
>+			return -ENODEV;
>+	}
>+
> 	/* Install default tcam bypass entry and set port to operational mode
>*/
> 	for (mcs_id =3D 0; mcs_id < rvu->mcs_blk_cnt; mcs_id++) {
> 		mcs =3D mcs_get_pdata(mcs_id);

Thanks, Slavin, for the patch.
The additional check can be moved into the existing loop below, which avoid=
s iterating over the MCS blocks twice.

Also, on CN10KB silicon, the MCS block count is always 1. Therefore, the ex=
isting check: "if (!rvu->mcs_blk_cnt)"=20
should be sufficient to handle the absence of MCS blocks.
         =20
@@ -892,6 +892,8 @@ int rvu_mcs_init(struct rvu *rvu)
        /* Install default tcam bypass entry and set port to operational mo=
de */
        for (mcs_id =3D 0; mcs_id < rvu->mcs_blk_cnt; mcs_id++) {
                mcs =3D mcs_get_pdata(mcs_id);
+               if (!mcs_get_pdata(mcs_id))
+                       return -ENODEV
                mcs_install_flowid_bypass_entry(mcs);


