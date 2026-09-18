Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB0025783C;
	Fri, 18 Sep 2026 06:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789712059; cv=fail; b=CyoKBoEJDWYh759hBdh+YzZ73OzOE3RYmhJHMxbLdsk0G5+WD0IirJotM8/3jFLQpMdflt19yJysbEULJbht+AmvAeKCrsoSODOikiCUXD8DqSVRkt8+ks5JpMLhVEpmxv5zl3UyS9wmxE8kkf1wso+lPahqd+d6FV6inqNUJWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789712059; c=relaxed/simple;
	bh=VLEDf5uku9w6uTMH6Gtd/BNRdQfAEf8deGJo2RVC6SE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SIcnmByeyII2T8bdIJNNiAqNWi2/uS84JxFdxbMQkcqVZj4LdhmyaLutBWRnyQY5FJEOVhM3TdVB2P74/it0P2cve2I6wmt/tHW8TyEwg2CJBbPazyy/Y8o7qlmIBWsRLKeXixBE6fovQYlwSMVvz+ywhO9BYz+XdA/+GNUdg6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=gLBVcdUV; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="gLBVcdUV"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I604IL780796;
	Thu, 17 Sep 2026 23:14:07 -0700
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020116.outbound.protection.outlook.com [52.101.201.116])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4grs0e9yg2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 23:14:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9oA6vlKjb7d5S+KMG0IgRoHwoYs6LR1BedJdB7xYYHuVh8iaYYnVUR1GZb2lgUUqY6EhtX1psXk4YmF2un7Ph2H2kpSaw+Z6fzQ5ZGao5nVVfRYixKppoLoVcCZswckLAU7ITrvuTHHDWzuX8r/3NU0pqbLKLxQH5Avgsol3RnEEYRaoC8Gtvjp9UFzhzZ5Jrg8sAEWDAP2LpJOUScwu2ImV6aZH9UMMC/dtnV6W5OOlEd4ZxbRSnVfs/0xnId9w0o8E7JWb3Cu9bCGsWAjcgyt/Wy2W6m9HcA8rKh2KgCx8Oa7EjEN4UQxf2FIwYxuut9ILmawoa/lpIv/pSByrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLEDf5uku9w6uTMH6Gtd/BNRdQfAEf8deGJo2RVC6SE=;
 b=P5yIJr+tkE0gIoFbUaaNY/HD5MSQF0vBEFkN+pFuVT2IsvFUizhmo5/AQoUY91Wx1kCdso37oNursoqNMRzzz3brlQpMmaCJYdhJuGtH0Tau8wfMzCot2A31xMEK2g3lLGDMIGsyki0iAPYCcixykFrUAr91DQnS2ZgXu98OaOKmTZGVL/LzDZnmZ7v25hRRsDczsSMwX9+G+cNWxUGinaq+SkDZtRppsLMidDiYDDU+mCixL1BqDt1Pqu9XHWNIvjsiZ3UHM75w9XeeABR4yeT0SKeeweMYxWrpyCtO8lw/Whc7l0QzBzTmhxrO5cV9XKdG51wV7R5clE0gxwrtLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLEDf5uku9w6uTMH6Gtd/BNRdQfAEf8deGJo2RVC6SE=;
 b=gLBVcdUVgA6SRGYiDwNdbYPyAu17yItqNmy+dKU7jv26toIVX85JKdG9lpx7ZFJgxwlNcpR6hs76rQpgHiTunH/YEcw+p0mKwsX37LN+NveLIcAIDrqkMq9zFgRjLdmo9erBbTQFuew4t0joBJNYlJyWHqn+iH6j9kPvguW8vdY=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by DM6PR18MB3523.namprd18.prod.outlook.com (2603:10b6:5:2ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 06:14:04 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::210a:9dad:297f:3540]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::210a:9dad:297f:3540%5]) with mapi id 15.21.0382.014; Fri, 18 Sep 2026
 06:14:03 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: TechyMinati <sinha.aryan03@gmail.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        Subbaraya
 Sundeep Bhatta <sbhatta@marvell.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH] octeontx2-af: remove duplicate SCTP port
 flags
Thread-Topic: [EXTERNAL] Re: [PATCH] octeontx2-af: remove duplicate SCTP port
 flags
Thread-Index: AQHdRzPjQ2dvsCldv0i0bAp1KXxalLbT2oPw
Date: Fri, 18 Sep 2026 06:14:03 +0000
Message-ID:
 <CH0PR18MB4339FB477B7BCF4A296B0766CD872@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20260918060323.53860-1-sinha.aryan03@gmail.com>
 <CAN_7xUoyoCoq9G41A04owA2JJbHARn==NueTxB3i=LjCRymOSQ@mail.gmail.com>
In-Reply-To:
 <CAN_7xUoyoCoq9G41A04owA2JJbHARn==NueTxB3i=LjCRymOSQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|DM6PR18MB3523:EE_
x-ms-office365-filtering-correlation-id: eb48a3b5-40e5-492d-54e4-08df154c09db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|38070700021|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 pV9P27vmtbFbjZDI2Pledw/r0dLy3U6OelKijGE26SESKF9ahDk9BCu2uDOXii2NpTlF43U1DyoPahngkqahs1lQmRjE77JrCgF9lFdFw2LVY4Z14gKhX6vdvdWixA2JU3U1VVwesBu+zINSU4BaHnP2Xll1boidB1P2MEOBTmr5gs8RIfjGZatvBEnQG9sIk8c5XLIwEahNQUGqkbk0ueue8UKMVDYcX29xmJlV9QYb4Ptow2278NTLLDgqyX7sbOEqEdhMz1EXEbfIIRCCtqn8/IGntDNfkt8btpCffG665p2bqPSAjf8SoXpLCnUCQmJNiLNb9FJv1uD+QaoFA81guKwj//P9JkSrmyIvqN0HPSdcRigfIPe2nYymCnMuUIgvbX12L4dv7RhiViU/esiT2GQ7fg3AObj+I6M4Sv5jFSvV1EO9nIZ1ShHVeR1C3rvCyUrE9RfFml5iatcZnvo+gFbmAbxhdpyxlcuiRfnxu0fWyHIMosmqoAUbp8DDNTkkH0tISUs5xbwEQs7crYMaDkhoV9A8JIv042bdlmKIcmNrb+RoaB0PJOEpnh0pWnAGw6dNTqK5MgBWPCB8/McXdr33lrBvW+b90GcpPvkN1VxAwCeR7XPNPTSOOLXyNTuXb4AIE2mgDYalXoIkDa9CS9FPSXZ06tblSauMHr3leFGZV1IbvsKOXMcr4K+PZVVl+wDg7FyezSLvxrr9bphXGxi85IttXYqA93XkTv0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YVZ4eld5MFQ3bVhnOXRmU3NyZXgrWjA1TEZYaVVpMmN6SG56cXBVOEVVdGpN?=
 =?utf-8?B?NldMaWZtcXJQeXRmOEd5dVRxMlF1K2dhT2NQa0VlelJVQlVNMTZGcGM3TmxP?=
 =?utf-8?B?S3loZlZtTzhoT0J0cUpzaHhkWGZQbW1EYVRQeHhjTCtvbllJMFArbS9rOUtU?=
 =?utf-8?B?S0lhSm8wcHU1VzFyMW1QQU5DRmNnYTFzUmxObERqMFg5ZlBzeXJWeEdCYmt3?=
 =?utf-8?B?ekE2b3J2cHBDTXVOdUorM3FYRTM3VllpSnp4NnVXSmh0TVR4aHlSTTB6YjU0?=
 =?utf-8?B?bnFodVpTbXIvOU14SmlHV2RFdmYySnpEOGRFQXFOUTJSUWVRbndBWWFydjdm?=
 =?utf-8?B?RmdBckh1T1AraStTa3hDay9CNXl4WkdITW93amVhSWxJVWJ1UnNpb0dYY3hC?=
 =?utf-8?B?SFIrbmJVN2xxTWhpMmlzUVZiVWVUdTNUMzdCZm5hVnFiaWJnOUw4VjJpNEpP?=
 =?utf-8?B?ZXhreUdLUi9WTTBuR1dSUmszS2k1d0Uwd0Z6V0NmRHFOdmM3RGw0VEkzYml4?=
 =?utf-8?B?b0o2eTlMV0RLMFVaVkJxMjhsN2xRdVBPaWFkS0hzOCtnK2tRSjhMRlRlTU9s?=
 =?utf-8?B?OEFsYUlVVVd2YzlrcVBWeVhHd0NwdjNXR2NvSjZvbnFXam9Cc3BSZURYYWhF?=
 =?utf-8?B?cUhab3BmenkzWHlZUDBvbnRYa3hucENrMElRSTljQkVJNm5jR2RidzBjbGI5?=
 =?utf-8?B?bWEvVzl4SFJvYlg5YmVKZWtPeXIxb0NXTDAyRU85S0o5UzhnZ011VzA0QUdj?=
 =?utf-8?B?VTkwZnNUOERQbzFJY2p1MkVBdGI4MlQyNnllWjczSUwyZVYrZ3MvOHpJVkl4?=
 =?utf-8?B?RkdIazB5U2NKdDVWdXpzMnNoUDEvSDhQdzMzNnB2dGd6ckpxS2VhMDEvdnVI?=
 =?utf-8?B?Y3UrV2M2RVJtSitJNjgvQmhLNGcvV3VIRXRlRW1KZWlIOTQxb2ZQcUJHV25y?=
 =?utf-8?B?MDg1MVh2YXVWQmRyYmxiczZEaUxHQWVlcmtqT0lJN3V5WWx1eEQ3ekxsWlhS?=
 =?utf-8?B?SlF6SHBRRHdLNXVJeE9razczVGpQL3pIVXExcjNNQjRRY2hLTmxVaVV0bTZC?=
 =?utf-8?B?Mnhib0N5blVSTGdqUGx1QmJzaTI5dm5kNmtYSDM3N29IZXBxZTRaZ0NaVHQ2?=
 =?utf-8?B?TnRwL1ZOb0w4Q2NaMkRLRi9VQm9zYjZjOWI2MW56SlR1djhMVHBzNko3RUZH?=
 =?utf-8?B?WkcvUEVlakVPZHlqOXEvdVoxRGtvNHVSRElna21VZHJ0cmpPdWFNMWxZbmV0?=
 =?utf-8?B?a1RkK3RLaGVYeVkrWUVaZ2xKZTFHaktjVzU0RDJjakZsclArdXpuUkNwdkEv?=
 =?utf-8?B?L3NTM09HWHVjWTlQQmpCOGEyMkhXb1ZTc0dXNURvRHlpclhPYXJ3Qy9uSXpE?=
 =?utf-8?B?VGpzU3JxYTl3dk5DVExFRXZEQWtTOHhCa01vcVRZdlRCQjlpL0dsNGd4YlAv?=
 =?utf-8?B?ejNNSmZFTlJ5UWJkOGRXd3g4a2IwSmVSUjNmZmZGY1NDT21ZUTdNMTJjalQv?=
 =?utf-8?B?U1dsYVlMYlFqN29lT1pTOUs4K0U5SnlaYzFmcFlYRlIwakFjUit0MEV1MzZG?=
 =?utf-8?B?TFZYYXM2VUVwTUdkbkF1cHB6VWRacXF1L3M4aGJ4ZlZHa281RGhkcTV6VkNT?=
 =?utf-8?B?a296SDJHNEJrTWZSYWJnTnZaK1hWN21JeCtFL1MxNUFiNXFZYjJUTERMc2w0?=
 =?utf-8?B?R3RFTjJUSDNDVWNGNkNVb3NZaXRJUW9hVmZmekhaazdqVUpldS81VUtZUUxV?=
 =?utf-8?B?ZTk1NGxLZ0ZJdFNjREZaS2k2VUxHNjFISGtnMjA4TnQyMkUwMEFVaDBBN0Nt?=
 =?utf-8?B?U255VlF1VExZR3N3YUpHOEtkbkxGT0pVWXNFTGpXQzBJRWlOTjhnUXNyYlZ4?=
 =?utf-8?B?dFI2OFhYYnFMSWtMdjJtOFZxdXN6ejlrT2xzMTBPa0JuUE9MeFMwdllTMmV1?=
 =?utf-8?B?SXkwU1B6SjlYQmRhKzFwZk5qYmxTZk16OTRYNVZ2MWRUak9abTNZKzdLYUUr?=
 =?utf-8?B?Zitua1czbytuaW1VbXg1UEp3endGWENYTncwMTB0NmYvYzhnME5TYzMvWUNo?=
 =?utf-8?B?Q09QbkRzdUt4NUN2UHNNU043TGMwQy9yWGROQUIvM24yU1VwcEJwaHJlSDBq?=
 =?utf-8?B?M0ZsK1lzN3RlK0pRYU9zRzlWT2h3VnR5K1ZRMTVRdElTVENYeEJLcHppUlNh?=
 =?utf-8?B?SkZseWlNc092L3JRYjJYMFBaSTJ2dnlDN0NweENGbkZFRzdXb1RxZ0hkQnpk?=
 =?utf-8?B?MTIwYytKdERFZEZMN2hPWTZzNDhPNWlFQWJjUHBqaXZwZlp6OTg4enZIWVZN?=
 =?utf-8?Q?IVqNKwakoYGVPvY4Nm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	JRnkUYudZ+hHQQN0NzM3XAuTUHYAJvYjTso7fc06BB88UtKBP9uEvMz+K4Cb8xxySkBowL4VM3WQ28Bf1VDuoR161+zQRa0It6Pd/R7O1LAeHrF+kKwn1vEcNSkAaG6g8u/Fix1IaxK3nmxOTYDhWhFRZ1DXO5Slf5HVn1iLj2PQobkL7yVJjyyBU9+6Y1DlBIzM4voYEE+Wjb3NyFSOmKBMrghw/UP7xjIiWG72CzX0UbV+fbG1K0we1ZoQuPBpR7Ek7dBhZzUu3a3JLTc7BycqhxOCt5dIEknK21tvA1/qk++dJaqlDu8EAzHkhNRTDhkxd1sGoTH7Ql6TdlhqZw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb48a3b5-40e5-492d-54e4-08df154c09db
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 06:14:03.6439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LR5SAztBW0dKYCdCpX8dwUFmQhe2MmcztmQBMnYwvNANmgwpxGbG6HQS3aZ0XCjH89EnXfrjo+giNlwen+LX8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3523
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA4MiBTYWx0ZWRfX4pVB/MMTemjq
 VE/4SHwMtkFawATcOtq1Mvzl3fCXpwnq6QAQzqVbt3AB2elpH1EN2LavkwOHrl/p33A9OSFkAUb
 JhMwLR69a7GqjKp21o5nbEkb/sAWw8c=
X-Authority-Analysis: v=2.4 cv=U6YHnuru c=1 sm=1 tr=0 ts=6aacd6ae cx=c_pps
 a=3HzPxjwlbby21TQhxie9EQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=pGLkceISAAAA:8
 a=M5GUcnROAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=y-mLPJUFECSElyayzcAA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-GUID: AnJGoRgvYl9pDfEunKdI0irOBe78lHuE
X-Proofpoint-ORIG-GUID: AnJGoRgvYl9pDfEunKdI0irOBe78lHuE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA4MiBTYWx0ZWRfX2BWln6oHT6fh
 /bwiJI6jipHO8hwc/AbwzDljlkTfOGOuTw3wCoJdMM8yLLv3Aif8DJfjj5ABKgAlKSEs6QnHm4y
 BR8t6NuH/RoGS1r1uer86thywNZzTrm4rLP7tgf4jXsWNwtit3A7eED01xxkVo6Zu7vktcuUIx3
 owlY8va+AuNUxAHBH2EXPPgv1qswoFhEQtXGHfNjyBGZp+ftvITlU3SFAKQFZq3ZKKaCkYNdSQk
 75WTpQsiTmOD0t4CHjkHDteLI8EvyF5/ShclKgqCQdVDiOmy1tCJOU0QSphiI7cLo/gRdYevXiL
 yl4xIvL1PqBTMkGxxKqQKjXEOTpFWXkVosdIGWGQj5NrE9VToNTZ1ZBlQoEDQ/Hb89LJ6F4NnEA
 VAd5JE7w88ECt9ZJES22qSnUiQf27zNM/Zm4hwfBm19WmrLPQaC5fyHCo9eJHxk9rYo4FS8CkPZ
 SdBSb/k4lSLKak9loXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFRlY2h5TWluYXRpIDxzaW5o
YS5hcnlhbjAzQGdtYWlsLmNvbT4NCj5TZW50OiBGcmlkYXksIFNlcHRlbWJlciAxOCwgMjAyNiAx
MTozNiBBTQ0KPlRvOiBTdW5pbCBLb3Z2dXJpIEdvdXRoYW0gPHNnb3V0aGFtQG1hcnZlbGwuY29t
PjsgUmF0aGVlc2ggS2Fubm90aA0KPjxya2Fubm90aEBtYXJ2ZWxsLmNvbT47IEdlZXRoYXNvd2ph
bnlhIEFrdWxhIDxnYWt1bGFAbWFydmVsbC5jb20+Ow0KPlN1YmJhcmF5YSBTdW5kZWVwIEJoYXR0
YSA8c2JoYXR0YUBtYXJ2ZWxsLmNvbT4NCj5DYzogQW5kcmV3IEx1bm4gPGFuZHJldytuZXRkZXZA
bHVubi5jaD47IGRhdmVtQGRhdmVtbG9mdC5uZXQ7DQo+ZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3Vi
YUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsNCj5uZXRkZXZAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+U3ViamVjdDogW0VYVEVSTkFMXSBSZTog
W1BBVENIXSBvY3Rlb250eDItYWY6IHJlbW92ZSBkdXBsaWNhdGUgU0NUUCBwb3J0DQo+ZmxhZ3MN
Cj4NCj5UaGlzIHRhcmdldHMgbmV0LW5leHQuIFNvcnJ5IGZvciB0aGUgbWlzc2luZyBzdWJqZWN0
IHRhZy4NCj4NCj5PbiBGcmksIFNlcCAxOCwgMjAyNiBhdCAxMTozM+KAr0FNIEFyeWFuIFNpbmhh
IDxzaW5oYS5hcnlhbjAzQGdtYWlsLmNvbQ0KPjxtYWlsdG86c2luaGEuYXJ5YW4wM0BnbWFpbC5j
b20+ID4gd3JvdGU6DQo+DQo+DQo+CXByb3RvX2ZsYWdzIE9ScyBCSVRfVUxMKE5QQ19TUE9SVF9T
Q1RQKSBhbmQNCj5CSVRfVUxMKE5QQ19EUE9SVF9TQ1RQKQ0KPglhcmUgcHJlc2VudCB0d2ljZS4g
Qm90aCBmaWVsZHMgYXJlIGFscmVhZHkgY292ZXJlZCBieSB0aGUgZmlyc3QgcGFpciwgc28NCj50
aGUgc2Vjb25kDQo+CW9uZSBoYXMgbm8gZWZmZWN0Lg0KPg0KPglEcm9wIGl0LiBObyBmdW5jdGlv
bmFsIGNoYW5nZS4NCj4NCj4JU2lnbmVkLW9mZi1ieTogQXJ5YW4gU2luaGEgPHNpbmhhLmFyeWFu
MDNAZ21haWwuY29tDQo+PG1haWx0bzpzaW5oYS5hcnlhbjAzQGdtYWlsLmNvbT4gPg0KPgktLS0N
Cj4JIGRyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dV9ucGNfZnMu
YyB8IDEgLQ0KPgkgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4NCj4JZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dV9ucGNfZnMu
Yw0KPmIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvYWYvcnZ1X25wY19m
cy5jDQo+CWluZGV4IGQ0MjJiZGQ1ZS4uZWMwMDRlYTUxIDEwMDY0NA0KPgktLS0gYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnVfbnBjX2ZzLmMNCj4JKysrIGIv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvYWYvcnZ1X25wY19mcy5jDQo+
CUBAIC02OTgsNyArNjk4LDYgQEAgc3RhdGljIHZvaWQgbnBjX3NldF9mZWF0dXJlcyhzdHJ1Y3Qg
cnZ1ICpydnUsIGludA0KPmJsa2FkZHIsIHU4IGludGYpDQo+CSAgICAgICAgcHJvdG9fZmxhZ3Mg
PSBCSVRfVUxMKE5QQ19TUE9SVF9UQ1ApIHwNCj5CSVRfVUxMKE5QQ19TUE9SVF9VRFApIHwNCj4J
ICAgICAgICAgICAgICAgICAgICAgICBCSVRfVUxMKE5QQ19EUE9SVF9UQ1ApIHwgQklUX1VMTChO
UENfRFBPUlRfVURQKSB8DQo+CSAgICAgICAgICAgICAgICAgICAgICAgQklUX1VMTChOUENfU1BP
UlRfU0NUUCkgfCBCSVRfVUxMKE5QQ19EUE9SVF9TQ1RQKQ0KPnwNCj4JLSAgICAgICAgICAgICAg
ICAgICAgICBCSVRfVUxMKE5QQ19TUE9SVF9TQ1RQKSB8IEJJVF9VTEwoTlBDX0RQT1JUX1NDVFAp
DQo+fA0KPgkgICAgICAgICAgICAgICAgICAgICAgIEJJVF9VTEwoTlBDX1RZUEVfSUNNUCkgfCBC
SVRfVUxMKE5QQ19DT0RFX0lDTVApIHwNCj4JICAgICAgICAgICAgICAgICAgICAgICBCSVRfVUxM
KE5QQ19UQ1BfRkxBR1MpOw0KPg0KPgktLQ0KPgkyLjQ2LjANCj4NCj4NClJldmlld2VkLWJ5OiBH
ZWV0aGEgc293amFueWEgPGdha3VsYUBtYXJ2ZWxsLmNvbT4NCg==
