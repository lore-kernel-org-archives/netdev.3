Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C095C410D13;
	Thu, 30 Jul 2026 17:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785433441; cv=fail; b=eBJIJ6fDxJz8P/z6LZjDg2q65mXB+tsn9Nm8XVHhBvjrlsfbBBQZlt/k6rbiPZJpoGFapp8HX+uKJ+jb0JTGw/chZ9F1TO5f0S5w+ITQOw8vEmWw0WvcqbXTNewcT7ZwYOM2Uwykr8DH7hUdXMtZwz4OWWc2O2JK0XTVKaH3Ujw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785433441; c=relaxed/simple;
	bh=fZq9fAmM/UyrebFsUuVnvU0h57sEML9Bh/OduDC6Xbw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vp8qlHqfaScWxGYNDHo/Yg81OzV1T+5FxjEAPnyfrbYvfnigPP+aY2DYRdQ0npq8v73A2GNVO9ds1RrF9LHToR/WUFWiqCyGK0u/nFl9K+jHrhEox48o1DO6YRD5+0U5d2lvfWEh4shqd8YHY833ltknG7sCOb506qEl/qVqi0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=dH5WBP/L; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="dH5WBP/L"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UGYk363156933;
	Thu, 30 Jul 2026 10:43:48 -0700
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020104.outbound.protection.outlook.com [40.93.198.104])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fqu7auct6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 10:43:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAjueiOKS93GHNg7LBH0eKsoQNuKFbLQ9gotee7AtPAHPBYSIPIT71LxLH8Ic9cigGyDAsiyHQO91tcJYnHuoRasFhKWjEy6n5OxqMAq8p80c9ixYaQsnOxYJ3S84s1zABCtGr1n9swY7to5eo7h4DR80BbOhybmpMLTKH0xlhT6q7ki67n0ITSdCnvbtxVYuhZk92cdcrHqQcGDbaKIGkCS27EL4Yafa/Dn6UAkXMtzIEeuAzEbZg1V4pfkfEFB6J9AfUYfNLCg60uhyq+Zpom/uOBKW6ttMSi++ncwNuWK9LLg1xxln2kxVFHzgNj3k6moSha5q/P171SL2cdRFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZq9fAmM/UyrebFsUuVnvU0h57sEML9Bh/OduDC6Xbw=;
 b=IpStJ147Vh428wGRjB+LsEKoMJVUCiLbbKvbtVtROieMpixo8LzFZkQaqf1AVR+loq/co+u1I77pn1msip57uxiLbv8Gj42m3QzwnvlzbNko9ChK1qLi7RnFq8zuvz5k0PKSVeLj8Sv/61B2xOevsLVtChr/GzL7ct/V+pUt02LNEppn0YARs7HjQ/REcNxd3QanUn0r3dJolRyXLA+9+FaeBXz5rEC7CfdrY+ErsJpgzSyjUigcVT9SDLH/2q8yfIzPaKfS7gvyucs1h9KG1yW6cKQF0xRh9njqm0QJv4e70NAI3ZV1xeint4otv70gWXUE7Z39CdVzbHcZAPK2Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZq9fAmM/UyrebFsUuVnvU0h57sEML9Bh/OduDC6Xbw=;
 b=dH5WBP/L39ivRFqinsCUPVNqFpp0N8F178Ju3+OH5HQTN9a4bDserx0MxZYpb1mk6ISW92p0PI4Yhkcd0cXthV7KOtFkkalXUI/EcMbFEVQPxwop1qJE0ZXsVCPaBQ/BNpvCEzht+crikm5GZl49jv9CcdzFwM1TrGJ5k+VfJpg=
Received: from CH0PR18MB4244.namprd18.prod.outlook.com (2603:10b6:610:bb::18)
 by PH0PR18MB4037.namprd18.prod.outlook.com (2603:10b6:510:2e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 17:43:45 +0000
Received: from CH0PR18MB4244.namprd18.prod.outlook.com
 ([fe80::7491:b2d:4603:97f1]) by CH0PR18MB4244.namprd18.prod.outlook.com
 ([fe80::7491:b2d:4603:97f1%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 17:43:44 +0000
From: Elad Nachman <enachman@marvell.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
CC: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH] net: prestera: validate firmware header length
Thread-Topic: [EXTERNAL] [PATCH] net: prestera: validate firmware header
 length
Thread-Index: AQHdDSl+QNcSVnpMbUSClsQkydQeVbaGes/g
Date: Thu, 30 Jul 2026 17:43:44 +0000
Message-ID:
 <CH0PR18MB424430965013D79E04A1B384DBC92@CH0PR18MB4244.namprd18.prod.outlook.com>
References: <20260706092602.79240-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260706092602.79240-1-pengpeng@iscas.ac.cn>
Accept-Language: en-US, he-IL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4244:EE_|PH0PR18MB4037:EE_
x-ms-office365-filtering-correlation-id: 2fc7e4eb-80d2-492c-70db-08deee621a53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|10067099003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 8MGT1fYUHfRlFTzoZkvImVb5F5ZuySEhwGrwxMHcc4rM6Sr95H1Urs0qG5sRC1pT6sc37oAqiipm+0oBiMDTr89G/ZsjW+RG6cgH+kc7/BAoF08ucM5U+EAEejtp2yBXdL0ULLnisD7FqVJBRwORWfrmrjSCibBBjwt3w6ijpbSKFtmumBgy6E239bN3vHh8mqGDNn7E154IW/StsZgqv6Bwa6Jcrq4VC5wBMnIigYBSMNitZOGLNDKY+XUvVxD1dEDuF84/i5yhkb2BSDmf9l9law4mt41aEybKl1oSOBgNrQ6C9vRxUQvYcZhNMdoRh0+2S4nOxg/mNNHKCn4XyutAXMZYLATf4crDlp0rYaIYk+qZMV4jpMK+wqJ7e7M+IoTQPoFEWYiKczfajmDb+UPfzpn0V91QArOtv3PYcifrui2vfarQFPJisul5jYoWPHR5wAlFEd/F4OrmwXkGHOAx2MjT6mCzSpWRKhAMkCuzooQeRsJlysMUlsBlA/EDAOkGM+IQNHNztKq75lebawmp5/DWBBira4XUHinmUfxcs3y/s+Qf++OE6cLcm18usmTONEwidfG63df91EMUoZnHTlLieOZ1f3i2TbnSWanQ4pycqOmYkf+cEQfppyadkyyCmjboEP01X5qFJ08pBtNAB4JsleTCDI8o9leMhEkNHezVVVj2Dn7bMxmvTK60Lubsys5o7PZy/GeZ6TnBkajMkL6YoVEW7r+n2q3j47E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4244.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NFcyelM2cnZpWnIxUlRVTzIrOGV2OUJkcjBNWWRDRzl5MEV3Y3YvYzl4NEx3?=
 =?utf-8?B?dmd1ZFllQVZ3emhuTU9QVjI4bEpXVnFmcDRXdmR6MWtzVEpkNnNreUxCWkFi?=
 =?utf-8?B?LytCQ2FKVk9VcXI0amVTSGVlUEZFaDg0VHgvVjFieTNzdlU5RzI3WEpOTklP?=
 =?utf-8?B?bDByaWFjdmhWS0hmWHU0aHdZdVQ2aW9xNGc1alNkRjl0M0tHUG9pWDVZT0V3?=
 =?utf-8?B?MkV1Qnl4ZVkxRVFZOXpLNmRzYkNsRlQvR2ljeXBvSGp0dTFwcXQybnZvVGNG?=
 =?utf-8?B?SG9peVZUeitFdHpRSG5MVUtldWFTeE5INXlXbkY5azkvblNuQWdWaHZoTS92?=
 =?utf-8?B?aE5SYWI0dGk4b1d3elFwT2RPWE43aWxXYlFNQ3JUdTA1MW5QM3VwTHNiODhH?=
 =?utf-8?B?U2ZydG0xNURySU13MGpuWXJBeERVb0FROEhza2NWM2E5MWxpYm85WE9iWG5I?=
 =?utf-8?B?KzR6MVlvb09jL1JsWDZVV2RGZTVBOU1QYXlrV0dMeVdveVN3NUdnaG9mbzYz?=
 =?utf-8?B?VjZtQ2xLNmpEZGx2Q0hha3hWQnh4VFk0VVZFK3FkcTViTzJkd1dpQkw5NTUz?=
 =?utf-8?B?MHYyZEZBOXJRVS9UMjUzKzltcTVxajRSQ0JvclBQZVVDUUQyZHQxZDI3N3g2?=
 =?utf-8?B?MjdOaDNjZStHNjJlOVhSZ1NIMUdQMGpEZVNMRFgrTmtKTmd1cHlYYVZvODJK?=
 =?utf-8?B?WlRiU01BTzQyNG1OcWJGUXEzWFljdC9yeVhyV3Rzc0NTRnVUTWNPWjVMZ2ZM?=
 =?utf-8?B?aTVVdWxaVkdkbURLRlB4akV5M25lYTNZNUJRRWcwblJpdVcrZFB2VnZTMDZw?=
 =?utf-8?B?WTAyOUM2RzVrMUJzUEN4WlNOV0pZTmpVUXo3eHVmZ3BmOHlDeTZDa3EyOXov?=
 =?utf-8?B?T3M4d3ZrR0RMaUZxcXRpYVlubHR5ZElkWTZRWnlTN1lGZ2RocW9VYzRYRjdR?=
 =?utf-8?B?OUdkdU9lOUZTZmNlQzkrVlZ1M1hndVh5amR4TTJPV3ZZRmVjNVVKZWlPZlRO?=
 =?utf-8?B?Vno2N0FCR1k2QmNlN2Fha2NVOWkwdy9yeWthTTB4Njd2Z1FYcWVzbUs2cXJ6?=
 =?utf-8?B?S0R4eXZHVzlPMTI3WVNkQjFSTDQ2WUNFT00vU2NxUmJDWjJINkRLVXUwZkU3?=
 =?utf-8?B?NmtFbnFjOG5kSGI2cS9xOWZUQmFsWmM1UmY2SFRIVTJvS1dsNnpDdzNaTVc5?=
 =?utf-8?B?OXA3N3pwaVBjZDlkamJDSjhqWHZYeHprTWV5NFRTd2tCUDBPSFVINU5YNnpH?=
 =?utf-8?B?UEJBcThaL3FBcStNUS92VEdvR0srTU9mZFFKYTFNSWlnN0MvbHQ3Z3ZLcEx5?=
 =?utf-8?B?ZWxzcEVnUzZuZFpMa04wZWRrVVFsY1JPYi9YbTZuWklxUDA4SENoeE5Yb0pa?=
 =?utf-8?B?MnVZVEV0RWpWa0lnY0U3akFlWHp2UjRtb3NlSUhLWE4xT0lhOTd1dER3c21M?=
 =?utf-8?B?UEFsdm1WQWhVamdHMXA2amJ5aTJmbGVlY2FZOWNTU05tcnZwb2RZTzMvMzZk?=
 =?utf-8?B?R2N2Mno5TzhRaUhWbEovK2JQL3ZMUGNmbFljcFBHV1IrZmtSQTVIVlg0ajht?=
 =?utf-8?B?ckZubGpnakQwTURRSFRUUjluODlLTHBQVjZKbmxqcVAzNlhmbDZnbWZhVXB3?=
 =?utf-8?B?UUcxdUJNeDdIL0RBVlc0bVFFVkJXL2JLY2h1OURNd28wQXp4eE1vZE5iYTZZ?=
 =?utf-8?B?YjIvazRyWUZWSkx0WDB4a0JYV0cxd3M5U09rQ2JBVmcxRWo2VXc0OGVUYmlB?=
 =?utf-8?B?S05nZlFMekxhUkFMbjdzRG40T3RNakYrN0dDdHQ3R0lzUWgxTjcrNFhsVXBm?=
 =?utf-8?B?cWhpR3hid2lmcDdyQ1M1SWhtVXFqNkQyeEpGNGRMNDhyWEdsSU9LMXhVRGhP?=
 =?utf-8?B?UGt1MW94UnlndlhFUnYvSU9pbFlwbzdJenBULzlaSUhlejdwZlNNSVNZZDJJ?=
 =?utf-8?B?Q1dsZy9pSjB4Z2Mvd1BUQmptNEpXV252SmhnemdLblNJSzg1MW5HRjVsMkZm?=
 =?utf-8?B?clQxNlNWb2Z0VUVCRUZIeDJxY0tHNkcwREE3T3I3WmhkcW1kR3owTzVpbUwz?=
 =?utf-8?B?Rk4xYnd2Rzd6dnZucGR0RDEvNVVjVlg1TTl5WHR2UlFJU0xRdm5tUENWOFJX?=
 =?utf-8?B?VW4zb2ZRWjdONG52VHJBSHpBNXpSNlZKUitxVWhaZjZQZzBBcm51RDU5eE5N?=
 =?utf-8?B?cmQ4SVg5dnZ0NVpvQThBcG5wb3JacWVhdjlORVJmV1lvMWNNWVpwMDN6dUJp?=
 =?utf-8?B?QWhZeDlFaDlEQ3ROQmswWDdEU1pOZ1V1U0xRcHhwN2xKQWlEcU9PRk03UTU0?=
 =?utf-8?Q?FpV1T/gdvRSfTVLaAV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	SurLFPSLFx+prYI6SVZbau4JaDYCera6IvoUxVwahu9d4zPCsho3IW2c2ZRvKNYFzrkF+uEiGvT5E8lWhA4wgo+43HpnO7VIYFDyZ8Loq3Sbcsg0HEyAVKS6sdhGjLhTNzrtaeXUQV2JMSoSJY1dVkoxyGeupXDuaYAhL11eTgu3p70rcYLD4LjM5G51cjobjm2NsABWp546DxE/cNl2PHIlw26pD+6EzwOHOGk3Y1rLHAnx605CeuPcBGp1QVYuG13w1xRalt8k8cZN/fpFqVT84dr3S/Ds2HbcWtYDsq4xt7hghenFv2sLXxS/tgZ0tNmQT3tlupxKBywRHj9IQA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4244.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc7e4eb-80d2-492c-70db-08deee621a53
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 17:43:44.8725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: baHdCCm/3DrU13l6N6XdP7ZfRwfk8LRBvfSSrYFSm9bbLmH15NWvCovizQyXDpvwRGWT+NDDdFidRJGS8cGaxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4037
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEzMiBTYWx0ZWRfX2QW4aLfKKUVE
 HS8xD6QkxghQlyTS3Z/G8lnO8mJ1L6u2NX4ycRrPDBdJajDz9UzC1z2WgI73sLlRkms56TClLhh
 dgRqpmogysmj5zVYcmovnq9utWE7UpOMfofrZfUoediyhAvtWvpc7Hb+lt/oyuu8fHolpQeAak0
 EB0g4ChYz3DzlhZGFF4C9VLFHApIz2hMz6/qLbGWEyhQcQExO00uSui9j6r9CzcQ/vWr9aBxlzc
 5jUxrW8c8c+OZJxhSTeK1WBy9ITku/lMwIp/aCwkTgVNYM9S0QHu1Uh0ZzDsbdxu0I5GG9yy8cS
 XY65JoQTU2A515F1WUjF/aDh/gqVuvVQwSCZ4ET0okmS6idybYC0ffv2mNrDqKQ2nozHPOaYKFr
 CSimXXGOQiG0swf5nVWNL23iXRaQDj3XJDbxDadO0mNXvnDXLf5B5F+BTBq8wIt4rKQED/UBrQ8
 7FkBSSi3f4Dqm4OTIMA==
X-Authority-Analysis: v=2.4 cv=TbKmcxQh c=1 sm=1 tr=0 ts=6a6b8d53 cx=c_pps
 a=/l2LzaSN5HZ5zNViGO9i2Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=53fTOkpDZIen14EW-cwA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-GUID: DA7xpRweKBg-VS6kEnBnRWbzT6xAgSOv
X-Proofpoint-ORIG-GUID: DA7xpRweKBg-VS6kEnBnRWbzT6xAgSOv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEzMiBTYWx0ZWRfX7KR6xe1Z7iDg
 R1X087YZj94HBy/la5RNtiVgGYtHnTyDNXnMyoTlOzQhOSQ6ymKVLnhxdkOjg4n6kDD6eoafV/S
 2wlkfij/XQMwpvOIUD/TysufqP5gL5Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_05,2026-07-30_01,2025-10-01_01

Pg0KPg0KPiBGcm9tOiBQZW5ncGVuZyBIb3UgPHBlbmdwZW5nQGlzY2FzLmFjLmNuPg0KPiBTZW50
OiBNb25kYXksIEp1bHkgNiwgMjAyNiAxMjoyNiBQTQ0KPiBUbzogRWxhZCBOYWNobWFuIDxlbmFj
aG1hbkBtYXJ2ZWxsLmNvbT4NCj4gQ2M6IFBlbmdwZW5nIEhvdSA8cGVuZ3BlbmdAaXNjYXMuYWMu
Y24+OyBBbmRyZXcgTHVubiA8YW5kcmV3K25ldGRldkBsdW5uLmNoPjsgRGF2aWQgUy4gTWlsbGVy
IDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29t
PjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pIDxwYWJlbmlA
cmVkaGF0LmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVEVSTkFMXSBbUEFUQ0hdIG5ldDogcHJlc3RlcmE6IHZh
bGlkYXRlIGZpcm13YXJlIGhlYWRlciBsZW5ndGgNCj4NCj4gcHJlc3RlcmFfZndfaGRyX3BhcnNl
KCkgcmVhZHMgdGhlIGZpcm13YXJlIGhlYWRlciBiZWZvcmUgY2hlY2tpbmcgdGhhdCB0aGUgZmly
bXdhcmUgaW1hZ2UgY29udGFpbnMgdGhhdCBoZWFkZXIuIFJlamVjdCBpbWFnZXMgc2hvcnRlciB0
aGFuIHN0cnVjdCBwcmVzdGVyYV9md19oZWFkZXIgYmVmb3JlIGRlY29kaW5nIHRoZSBtYWdpYyBh
bmQgdmVyc2lvbiBmaWVsZHMuIFNpZ25lZC1vZmYtYnk6IFBlbmdwZW5nIEhvdSA8cGVuZ3BlbmdA
4oCKaXNjYXMu4oCKYWMu4oCKY24+DQo+IHByZXN0ZXJhX2Z3X2hkcl9wYXJzZSgpIHJlYWRzIHRo
ZSBmaXJtd2FyZSBoZWFkZXIgYmVmb3JlIGNoZWNraW5nDQo+IHRoYXQgdGhlIGZpcm13YXJlIGlt
YWdlIGNvbnRhaW5zIHRoYXQgaGVhZGVyLg0KPg0KPiBSZWplY3QgaW1hZ2VzIHNob3J0ZXIgdGhh
biBzdHJ1Y3QgcHJlc3RlcmFfZndfaGVhZGVyIGJlZm9yZSBkZWNvZGluZyB0aGUNCj4gbWFnaWMg
YW5kIHZlcnNpb24gZmllbGRzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBQZW5ncGVuZyBIb3UgPG1h
aWx0bzpwZW5ncGVuZ0Bpc2Nhcy5hYy5jbj4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5l
dC9tYXJ2ZWxsL3ByZXN0ZXJhL3ByZXN0ZXJhX3BjaS5jIHwgMyArKysNCj4gIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L21hcnZlbGwvcHJlc3RlcmEvcHJlc3RlcmFfcGNpLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5l
dC9tYXJ2ZWxsL3ByZXN0ZXJhL3ByZXN0ZXJhX3BjaS5jDQo+IGluZGV4IDI5ODlhNzdlM2I0Mi4u
MWFkMGU2MmE4NDMzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxs
L3ByZXN0ZXJhL3ByZXN0ZXJhX3BjaS5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21h
cnZlbGwvcHJlc3RlcmEvcHJlc3RlcmFfcGNpLmMNCj4gQEAgLTY4NCw2ICs2ODQsOSBAQCBzdGF0
aWMgaW50IHByZXN0ZXJhX2Z3X2hkcl9wYXJzZShzdHJ1Y3QgcHJlc3RlcmFfZncgKmZ3KQ0KPiAg
ICAgICBzdHJ1Y3QgcHJlc3RlcmFfZndfaGVhZGVyICpoZHI7DQo+ICAgICAgIHUzMiBtYWdpYzsN
Cj4NCj4gKyAgICAgaWYgKGZ3LT5iaW4tPnNpemUgPCBzaXplb2YoKmhkcikpDQo+ICsgICAgICAg
ICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ICsNCj4gICAgICAgaGRyID0gKHN0cnVjdCBwcmVzdGVy
YV9md19oZWFkZXIgKilmdy0+YmluLT5kYXRhOw0KPg0KPiAgICAgICBtYWdpYyA9IGJlMzJfdG9f
Y3B1KGhkci0+bWFnaWNfbnVtYmVyKTsNCj4gLS0NCj4gMi40My4wDQo+DQoNClBsZWFzZSBmaXgg
dGhlIHN1YmplY3QgbGluZSBwZXIgQW5kcmV3J3MgZS1tYWlsLg0KQWZ0ZXIgdGhhdCB0aGUgcGF0
Y2ggY2FuIGJlIGFwcHJvdmVkLCBhcyB0aGUgc291cmNlIGNvZGUgbW9kaWZpY2F0aW9uIGlzIE9L
Lg0KDQpFbGFkLg0K
