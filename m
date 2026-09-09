Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88569572663;
	Wed,  9 Sep 2026 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964240; cv=fail; b=BvrRyeS8o4Ki1XCMFBgxH8Ek1EWCVxX5Xrvzf2e13URCtr1BTWIWnzR5x2bECVzT2ifLD3SmTpVrKldG0qD5aYS9FFydqWW4XHD+ZXkIwLx6r/Tw+4OlmB/cP4XvOcq7LLVGE7D7jIqXby4TWAMTW2V2UHL2NNfkgM43E6wIgEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964240; c=relaxed/simple;
	bh=ywyalE2vPPXguzKJTq+uhkEpzqrSRRa+AWGu4utp9X4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GcIYj1YX2L/Lld640u7RARPX8ADXLaiOqwAhqVYhzwESR5qPuBq3zVWZLgZXcdqXGEy92FkYokRXSkDtoyRFeKK5YDnVE13B0RHRRQEqJErxmmoF2Nz0ihbgsMSR+8s3Bcg04Fszc+1BgxgSjvsNPuPvDUqwoOnFtwX2XihOrGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Nzh9DlPJ; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Nzh9DlPJ"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689AoXtB2318378;
	Wed, 9 Sep 2026 09:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=yBgfb1KoP3j5wqkVxAuIVWVz/EBX9
	nyEmj1Sie+we3A=; b=Nzh9DlPJMtRlI6LDzvqf0BlCd1iZA0hbmYgum9QExUHHM
	hVydWxsjmWEacyWpCc/7fBELXuqMZaEcQ46LXivtDfA41ccup0BJQODT2SJfbFq8
	mAbMNS5RrBQpRcU62QX0+zCBYkEgPKbX49pJoZCQQb4cOzi2Kx/d0bJbq3Orkqof
	T/XtRAr3gEvgMD3wiInOthbImAqXOrXpvh4lcqM4GOLaqjHBuKG3M8JcrkO9ZyyT
	hgzV9mMX6hn20R6h2959GNEjX0Sy9+KG8NoLIGjLmLjhf3f5ez/1QyJ1rHWQCaXq
	h5kOEnylwSBNu9/8cHYVDHqf2ZSakQUEloV70UpSg==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012001.outbound.protection.outlook.com [52.101.53.1])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gk06h1ndh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 09:55:43 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=folIjYaOAdx2mcuQhiLhed4eQUfDtz1BVULfhyXocG9t+rFvsnmrxAfMwpz9SKNvQIe9lWjbM1dJL+LWwC8x/gDWbs6QHUpgNo3cSrkwlYu/eZzVrQKFE0LyPoPq+3gX55RmvKp3Ka8VYoKQ8eGs123csW6ufzJD1++EUkbF+md3gKIOPBWQZvwHhss5zFA8MeZfVoaWBMsYt2gWu5OX9zxZz8hNrSeOWxjL6fesNjGG9KqUZd1dNug3AR7nJ0MSffhZkOKwKkw6xvdz00wJF2N0A5e1NL1B8Jkbe/nitOzDyqLuEIAQW2FzB6N2uvsF9pM0IPhzmhJZ9CAO7TDm8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBgfb1KoP3j5wqkVxAuIVWVz/EBX9nyEmj1Sie+we3A=;
 b=VOYqngpt0Q69SawxgUMimw61EwpN8PI5Ar/fRBdYu7QiOSWiTVxE/0pGfRlbrK4HhxG2Lp5TuT016R1zOmecttpqtwbMRu8GpWYrKOWdaXC2JS2JIylkVNcapZM7DAUyWSz4lbaJUluu6jp2btN8oaWl7tZFPYBjXOFGOzfKumhKkAGHW0lReUsgglY77Ziv9ySV2BS15aVH/ff/yDwSVxRVppxnPNAgOOadsJx/XYfBure1wxarXCqLqE16ESEtd/ldyLkKyOwYiOSErs3wsN7Tiyy1agQ8o+FaAaNDW4pRrY9OvizxJIHolOIpqoprMXnWzQtGbWiTS6D6yQkzdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
 by DSM1PFDA52B5846.namprd03.prod.outlook.com (2603:10b6:f:fc02::55a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 13:55:42 +0000
Received: from BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3]) by BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 13:55:42 +0000
Date: Wed, 9 Sep 2026 15:55:39 +0200
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Stanislaw Pal <kuncy7@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: dsa: realtek: rtl8365mb: wait out the
 full chip reset time
Message-ID: <aqFaNZ8TqM9e76xN@analog.com>
References: <20260909120825.33350-1-kuncy7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260909120825.33350-1-kuncy7@gmail.com>
X-ClientProxiedBy: AM9P195CA0013.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::18) To BN9PR03MB5977.namprd03.prod.outlook.com
 (2603:10b6:408:132::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR03MB5977:EE_|DSM1PFDA52B5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 229d356e-a2b0-4555-318f-08df0e7a0989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IBCLnyWNr0Boi0oGCkJXfP6WygEOYf5eIv9wvW+pIVjvIl/9nmPq78a4xezYQcPE0Yu2WznBOOR0cr4BRaW+Y0mXJSnO3IJ+Yb6FcKmLJ2GVPR0ooBr0cUxnJImg5fMJVfOq/52WFgZzMZoV65nCb1Vm2zl9/LmjYeYrYMlyejJSLzLxUIFx/ulIEI0Ahx5naHV2QoRskQsGOUt1P23oQg6EnH1s6O3Sjp8USojgesjISGE2nQCgcOe/gBI7u93TfgG41aX9SEeJ8o2JUN972+mve1K2ykDpmdcJBKjk6cjPTMlsV9rJCN8EVdyTXItYGABCxgdDM5Jrgh0qjVzDUKF9J84NXy9f6+5IO0fZS7VjuGLSheDi3o35WMl5Ati0Tt+EPqnSnwYwy9nr9M6xmsHsC//z01Zoxg4pAszVI9b8f0E4FLf2wK+t61+sZ1+KSv9yAeP+LKikDiN0TVoL2fQpy/7RPuQbnoyGWM0jCmVkNUnCgLm9KJOKRpgYzcPBVJzQaGB5z60Pv3U90+901ecBVMbTImrJn6a2Ca2vnY4fS0ZhcHaBNVIlNQnohC5zzPm9VnDtv/JrhXNeqfVER6ZTtcFCOjwhzGVXOoqmdtn/KMNxoiyxrNuC1twSZVN1eoD3o0mYCftIdE4+ku7y1tzeK7GUPNoT1GKCtvkIcds=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB5977.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0JUVzlmUHl5bVJZTUJ6ZkNGdE9wWUttNG9nUHJtV1Q1SWpUdDMwT1BrNXRS?=
 =?utf-8?B?Zm4wWnkwcnRQM2xVcW56T09yNVhTVEc2Ykd6L3U0eTNhdDZoeThxSldOaUx5?=
 =?utf-8?B?cmw5dHY5UFlJTzVsZWNnalV0a2lVbXNqN3RUTzNGUkhGejJFZEx1VnFlcG5z?=
 =?utf-8?B?Z0FJWDlnYlJhUkJQeE4wWUNqNTBLWldIeVU3ZUpiNW9XNFlZeFU1RCs4ZXR4?=
 =?utf-8?B?enFlSmtnU0QvMTFlUkNUV3FmNWhNdTdxNTAvY0FtanlsRW9GZkM2NzlDQndj?=
 =?utf-8?B?dFdyODR4V2t1cTdERk80eis4ejZCcFhRaG1UTnBNMFgxaEovK05SVTgweS9J?=
 =?utf-8?B?VGpoTmJFR1hxdTBsVFFzelkwckhIckdjbmtzK1UrZVE3R2ZsY2ExSm02MUFW?=
 =?utf-8?B?cklXbFlaWXNQbHA1Zmcycy9SNncrelM1L1pLU1FMMWMrQzNqcldYSjgyRURU?=
 =?utf-8?B?Qk91bWVDcFhUbmtqazJRdXZJZFQrY0M0bFRwWXp1M1FaelpIZStuYm1tbTND?=
 =?utf-8?B?aVJ0WjdFb1JKcWV2WWJjQmwzamwxWXBsbjIzdUt5a2ZZb1dMekp0b1pBb3Q4?=
 =?utf-8?B?TWV3OVA3enJoYkduUFFxb1M5dWJxTVFrSjJxUmhRMlFPb1daOGVnZjJMZmxz?=
 =?utf-8?B?T3hBT3ZYVzNVYkRzbFhIdjNtUlZDWkNHNVFJZlpoZFBLckFxeGw5RU1MNldU?=
 =?utf-8?B?SFVrQ2VEZC9mbForM3lQTVRwSDJwOUx6TlpVY0dmSjZkRkZKa1lxT0M1aGta?=
 =?utf-8?B?TUFmZityRFVTeWI0RXpiY3dkcnVxaG9QczZxOFVxVkVtaFhPelFDUkpZSjBH?=
 =?utf-8?B?YU8xTmpOWVdmZlRjREoraGtDcFFNWFhVdzFwc0kyZlp2cnl0MlpRRkxDbEQw?=
 =?utf-8?B?dEdxMjBraXdYcmErSnNiT3FPS05HdE54WEhKdGExSThHVGtITXlGVjAxUWk4?=
 =?utf-8?B?WEJCVTlyT1lIME1malV5WFcvQktXQS9RZUt3OENUdW12Y2dscGRYalJQbCt4?=
 =?utf-8?B?U05FK3FaRW5Eem9TTDhHcXdhOVFIeXVRQXh3YVNOc0FzUnNPNGJqLytPRjF4?=
 =?utf-8?B?ZHk3eStpa1lqYWV5ZkY2d3ZvUGo2b0NUN2dDTnFSZDhWWGxnY2wrZWk3UFhQ?=
 =?utf-8?B?dmJWMGlhY2ZENFlVWkJqd2lJTU5aaVQrL0ZENEFrWHZlbnR4NEZFaVhlZUI3?=
 =?utf-8?B?cHdQblg2bTRybTZaSXpKdy9Ia2VnSnlHT2tPazNPZ0t2Rm5mM1BLdHNIeG0r?=
 =?utf-8?B?aGVrd01hOEgvazFyR0NtajVoS0lhbDUzVU1KQnl6ekxZbVNSWkFBZkI5OTVk?=
 =?utf-8?B?UkhqM0pDYks1RlQwcHg0MUVEYit4NzRrZGRpcUVKVEZ4eFlqL2JDbUU2UFRO?=
 =?utf-8?B?RUZiSkZCWURrQUVlNU4yYTRtUEZkUjJ4Y2JiemQ3cXQ0dkp0NXF1WGVrVDZj?=
 =?utf-8?B?UUdkc2lqNlBqemp2VDI3eXlFQUV2Z0poTmlNRUNpMG44a0pSWStQQUlEVzdL?=
 =?utf-8?B?TnREZ3hVbjlUL1NRUjZEbllMeTdMWVM5NDlVMjhBSkdIUkhHQjNJaDNObW9I?=
 =?utf-8?B?ZXVlOWJFeG5oYWI4eStubWVkS0FVU3M0VXh6N0pGNWpLS1B3clg1M1ZYalpp?=
 =?utf-8?B?Z3RHSitGRzdxWXBVN3JST3pPSVpaTURvTmFQUnhBZXVIMmZYMFZOMHpuQzdQ?=
 =?utf-8?B?dG9rNFBrbkFxMUhYbUNnMkc3SlBUbmlUbjR3a00zQk5FcWxBQng4bUwwb3BN?=
 =?utf-8?B?YThCYnVTMDlmeWY0UEZKeVBhU3RLa1BQNlAwdUdLWGw5SnAvazFSaXNWYS9h?=
 =?utf-8?B?VkUyVklXNUxhU1R5NzlKNEs1NmVoQjBpNVZ6aDA0UnVrZ3A5ZkdYdDA5TGNL?=
 =?utf-8?B?Um1Ic0VzdWc0REFJTXd0ZEExSGdlK1pFMnNSK1VBWjYzSGlEWmFQSHcvNGQy?=
 =?utf-8?B?VXAvREpUQ0pKWVZSL2lKRXFKbW51dUdGU3NjSkxBODVFUmxKSGNPbnV2WXFV?=
 =?utf-8?B?WCt2UDI3dXVOWHB0QVRQVUtTd1J2TCs5NFZrWmN3cHdBektXajd6azZzbHdr?=
 =?utf-8?B?cWlBVDIrZi9hd0FIdHN0QVdKb0V5dXAzSHd0MVl6cEt0ZlJYazhvWVBxNGNE?=
 =?utf-8?B?M0JkQ21LYkRmVytnYTVETWxtOXlNTllxblp2S1NzdHNIM1VEdktYK0JJK1pR?=
 =?utf-8?B?UkI2TjJ0a1RWN3VEQkdDL0lvYnN2SmJiTTkyd0VMalM0ejU2c2FTa3IzYnlp?=
 =?utf-8?B?Z1gzOGYwcTdMSTYxbmRzYi9ZNnRIMlJyTG8zWmR2Q3hvZ0VGSk9LVzJocUFm?=
 =?utf-8?B?SkwyaW9DTm0xWFlhOCtwWUEwZlFYRFRCWjVyL0ljaXZGbHp4eXV5Zz09?=
X-Exchange-RoutingPolicyChecked:
	tO9lLtSeJqA04+jv7hnn0N5klYN8aTs15rLRSMRKbOr/wTwIvvW1KF/UWrPu0Mbak76JgA+cjHOLO11nOQO7V0dBWa3fGqY/RyuProe2Njxtsbpaw5RvzgSFeged6/EA8sbsBMmKp2QBNnApTv02G+ZOkT16e896iAbpNl0FJD8bfMcrg8r/33FBhkn9Sy9eNPNmSzcn2Lmw8hEhxXDOivsHApHZUD5BmrCIDte68pM6Abxz/X/4pGsXHm7LqpHm+6PwHzUGlQm74bWOzDT70evQE+u1db2rtVr7x0b9xA/JnnLzwPxEs8c/sQT7djp9GYDFmgADwgwaCcEBGQOC8g==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 229d356e-a2b0-4555-318f-08df0e7a0989
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB5977.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 13:55:42.0960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQ+T8MVioNBwgcOrVDzeLfol4knoWZZt9MoxKsSx8l7iSMPdJx7gc5TZjELht7vnyFOrci8TV0KcP/wX1+yDZvpJeO5xCJMtyJurdASAoRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSM1PFDA52B5846
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE1NiBTYWx0ZWRfXynUy07I24EH9
 Ra4E0tcfKHFrPpuazFpFfUS5kciB4ebnxlxrUL/3iFh3/2/rs09SsAXbrkOZyPYPv171wv/4xc+
 lOK9hV94//obEe2HrA+fPMXLiYRTLBDHQSzCkww5tM6xmIYp1Dfq
X-Proofpoint-ORIG-GUID: SXLyF2254ChdCHkcE_mYjNHgDfRkX9RN
X-Authority-Analysis: v=2.4 cv=dNKWXuZb c=1 sm=1 tr=0 ts=6aa1655f cx=c_pps
 a=0imTBu3/wk/XLaKPibPjKw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=NEAV23lmAAAA:8 a=aVG23GSyc30s0ec_7gEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: SXLyF2254ChdCHkcE_mYjNHgDfRkX9RN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE1NiBTYWx0ZWRfX+LkfI4WuETsz
 5fGZX73d1PD/s0D/qCy6INRy1s7+7U2cOn5kJkD/1fuAQUZTJTf+5lwdSZiYQr6zJ84XOfht96M
 kHU/LSWlL3HfPdlfWjYAGMrzDMe63g8KAN8TYG/rwPpdhMmyQ69FtAkSC01ZCeZTxEZN/x8JX+V
 9kGpsp2VFLnyRmhMX51iewHrP2igAawbY++ORvTxyl4lseTM1ske8FAB2hh/TUChksuHRCyXad3
 TDeZLexbuiakaW2/ikqvuBJhFw3A2I6gQTZKIZ9urZMpuhUXWXWN9H73epKvP++Eiq0doyDneAt
 3xIZ8nbalwFrUwgxqHlLDQnceiur6i2rvrb9G2OfdLlx9dekc3Dyz60P9pjssyQEyHOUgULDakQ
 M5Yv4INZ6VwTuJfFrZ+0fWG38IRkc5giNf70Uhqy/jikHsEmAIVg3On5yixiWmG01hNqmzT0Gcv
 mC6hnPr+PtitoHa+Seg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090156

On Wed, Sep 09, 2026 at 02:08:25PM +0200, Stanislaw Pal wrote:
> Realtek documentation gives the chip 1 second to reset, and the driver
> says so in a comment, but it only sleeps 100 ms and then polls the reset
> bit and continues as soon as that bit clears. The bit reports that the
> register block is back, not that the chip has finished its internal
> bring-up:

This claim is still speculative IMO. There are a couple of other reasons
why it could be failing on your end - see below for some debugging
approaches.

> Luiz notes that older parts such as the RTL8367R need
> noticeable extra time after it clears, so a driver that keys off the bit
> alone is relying on that margin being zero.

I don't really understand this statement, or how this patch would help
such chips? FWIW I thought Luiz was talking about some older Realtek IP
which isn't compatible with this driver.

If you or Luiz could point me to the vendor API sources, it would be
great, because I can't remember much of my thought process when I wrote
the original reset code. Maybe there are some additional hints in there.

And a reference to the 1 second reset time would be good for this patch
regardless. IIRC it's part of the vendor API documentation?

Unfortunately I don't have access to these things on the current PC.

> Sleep out the documented second before touching anything, then read the
> bit once and fail with -ETIMEDOUT if the chip has not come out of reset.
> 
> Probe therefore takes 1 s on every chip the driver supports, not only on
> the part this was found on.

Increasing the probe time so significantly for all users without hard
evidence of its necessity is a hard sell IMO :(

[...]

> Alvin put the dilemma precisely: either the supplies are stable, in
> which case a cold probe and an unbind/rebind should behave the same -
> and on my board they do not - or they are not stable, in which case the
> board is out of spec and its behaviour proves nothing about the driver.
> I think the second branch is the likely one here. For what it is worth
> my device tree describes no regulators for the switch at all, so there
> is nothing for Oleksij's series to consume; I will follow that up
> separately rather than hold this patch to it. The device tree you asked
> about is not upstream yet - it is in the OpenWrt submission at
> https://github.com/openwrt/openwrt/pull/24197, file
> target/linux/qualcommax/dts/ipq5018-archer-ax55-v1.dts; the switch node
> has a reset GPIO and no supplies.

You don't necessarily need to describe the regulators perfectly in order
to test the validity of the claims at the top of this patch. It should
suffice to just introduce some artificial sleeps in the driver which
simulate blocking on regulator enablement.

Not knowing the power topology of the board, I think it would be
interesting to add the sleep in one of two places, and do some cold boot
tests for each:

1. Add an msleep(1000) right at the start of rtl83xx_reset_assert().
2. Add an msleep(1000) right at the end of rtl83xx_reset_deassert().

Don't add both, test each case independently.

If both (1) and (2) work, then I assume that it's a matter of some
always-on regulator(s) which need more time to ramp up.

If only (1) works, then I'm not sure why (2) wouldn't...

If only (2) works, then it could be that the reset signal is also
controlling some regulators that the switch consumes. In that case I
would suggest transforming the reset GPIO into a regulator enable GPIO
and using Oleksij's series to enable.

If neither work, then I wonder what else explains the unbind/bind
success case.


... ahh wait, now I see that you actually put the reset-gpios on the
MDIO bus' devicetree node. Well, in that case you also lose the
post-deassert delay here:

#define REALTEK_HW_START_DELAY		100	/* msecs */

...

	if (priv->reset_ctl || priv->reset) {
		rtl83xx_reset_assert(priv);
		dev_dbg(dev, "asserted RESET\n");
		msleep(REALTEK_HW_STOP_DELAY);
		rtl83xx_reset_deassert(priv);
		msleep(REALTEK_HW_START_DELAY);
		dev_dbg(dev, "deasserted RESET\n");
	}

Tests (1) and (2) are no-ops if you don't give the switch a reset, so
move the reset-gpios property into the switch node before performing the
tests.

Kind regards,
Alvin
