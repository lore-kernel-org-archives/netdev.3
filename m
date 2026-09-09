Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBA45476D6;
	Wed,  9 Sep 2026 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953500; cv=fail; b=TSD9gPELXRJkLs1gXWi1qAHK8cJpnOzbOeMZiWdkXmeMk9jj7Ihr8Vc0eM4rDftFJxeP9OktgpYAhd4N6Pq26p8msQBumBD2tePYKltEltx1R911KSWXI+6uzcD+i6Fjz8E8dSe5T7M8+YRkq4ICwbR6poZBbGuGwaE6CRob2Kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953500; c=relaxed/simple;
	bh=QnImKKrpo86bYBowdhvkC9Jh9JmG2VwPr4/cqmWivOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MKS8UCYEYMazW7d9JHSUpFTkjrS3LqkKfikL6ziQ5dyShnmQIik0ygcgwDoBWsHztpVFuxT6uds7hoid15YM7i16KKo5tX9cRlrBHD9MuFva830l7QAJSzitQKBpLTUkK/1eGG+wES824n6tKNSBT9ecPZutG3njz5Gw1fDVFIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yoEdvAGE; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yoEdvAGE"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689Ar6JK542980;
	Wed, 9 Sep 2026 07:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=Xwulrt3msbQ7Jp0t6GegiNubfpoyX
	IjHDbDjIsWax0s=; b=yoEdvAGEhm3N0Z/cnDZvNOrwgKuX+kVYR199VLRKe9Ud5
	kJDCu5TDrfglaoxdLkwmy0c74rFtf8r3nE8sLKH7qoYFGSUz+Z1dFxjI2YrftVGX
	SPDMsklkRqaSCvg9wCxyILjEG5bHi3d8hjo4nJ9ivw0o7lY//M0bw2Lcg5C4JM4h
	pDhf6+ZIvVzTmN8zEnhSl95gStrtb9GlzN3hFiLlQD1FVDt4EKSpOOb2oHwpxIQc
	hS1/fgV8rL2bqBZhoSg6PU0veKfcrL7lV0dmLzy5Z3cL2+ED1VUK3+sUlm4NFIkv
	hxHifBvwGkE2wOWz5O2kSH2xV9YH8cDSyk1rIrG/A==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010032.outbound.protection.outlook.com [52.101.201.32])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gjwbaj8e9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 07:31:27 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6RNDeqeBkeEwFxDJA2E57L/e/ChHNPOiDzEYcvV1ERN7GRi3PrOKG/7DsOmNgfwPuM6lKdnirtJq9sDAzzJYDff75RoPXo5Li+kZENWrj2BaSH4XwwCwTcJh4ExqJFESZooubSOZ1CF6cdf8qaOWgTSeDiJr4eHfMiIgCVUJ4SpP/BZH8AONVIxNIZsG9T+j4Jk58lWk9EvOZMP6Kd1vhdk3PM6GtTDIh0Rbjsjy7QlF5zjOWW1ATxyyJieZpl2HBiJnRjnyoGqVe/IyqYnIccRpZk53z7l8BFPvvFLlFtY/MgakyMkbfeiK092yQM0prkMSHD9KanbgKkZeWQQSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xwulrt3msbQ7Jp0t6GegiNubfpoyXIjHDbDjIsWax0s=;
 b=Hnhg74FPfDh68CbRWEIZ3DoHn2wIui0Z98dUPLceWsaGJ+cON75Hzg465eTT1C1bzoPj3X7+BTN6EKWnLY3NGxcQEtJf9SkIdBoBFsoPBNvlReVHv4GCPtvQvARworZJ+HtAkvtnQclH1QjxrtYsuDfKziAXNTYkFeZU+o1Jn5NJZKpt/rxVlELy5TT/8n78jipNXaFAxnAxNRt0cb/tyB1Wa/qe8nZTQemj4HjjQbGuVYBMLZHvgKD7hXU5z4GdNHElITLcZr1YEMrXSo90jBoPjsbHMYywC+ZOgkJCXXWqHQftNgRstAdvAEdL632wSJcZiINqUyaSE27N0KfTPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
 by LV2PR03MB449088.namprd03.prod.outlook.com (2603:10b6:408:3a5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 11:31:25 +0000
Received: from BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3]) by BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 11:31:25 +0000
Date: Wed, 9 Sep 2026 13:31:22 +0200
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Stanislaw Pal <kuncy7@gmail.com>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Linus Walleij <linusw@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: realtek: rtl8365mb: wait out the full
 chip reset time
Message-ID: <aqE-KZMa_oBDHfHT@analog.com>
References: <CAJq09z4qBz+poVQR3tEQzB-_4se5ka76Xq1mwEM0RvEnTuGLNw@mail.gmail.com>
 <20260909101355.25660-1-kuncy7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260909101355.25660-1-kuncy7@gmail.com>
X-ClientProxiedBy: AM0PR02CA0186.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::23) To BN9PR03MB5977.namprd03.prod.outlook.com
 (2603:10b6:408:132::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR03MB5977:EE_|LV2PR03MB449088:EE_
X-MS-Office365-Filtering-Correlation-Id: 49f1a3d1-04d9-4da1-e1b0-08df0e65e1e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|11063799006|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9cmBIQVDcDMPG6/Z7217hWu51HzPVKI18cXIj2weNYJukmNer573gJ31vKrcgnJOJCbWxGVCIQ21I5M2AU57L21ftQ4ISKdY/GC/8DNFFdD0KYjKb8Wdwvy1/7NUHIrG9GTKMmNwdK+guOs+vHWx3+R8LyNPhPiSucZxP7a2uXZ0Spro38PV6knUsoE8Ku2CmwyYNJfp+t3rdqujhs7iXYPgp7C4yrFTJYJf65Kfrd3J1cd+dBQs6ya+jJFi51hcHfXnFG1HgqA8Sud5DaERTOJrKCOZVOz7thnkz8RWYKuh+fhPelTlAXK84UbH7JblURGI+zI1EKLRlktVb0922vKItbcPqYkj4FEJnaEdH0oButZaDUXBgrljaP0goZJJeq9cX22LXxfgZHejigBWZGlokwNBuXWP3Sq4GxYjCCNQgSqYSaM5og6O+GWRp/EKXY772lSDfGzr1+umH/Gz301zlSTMp+JfVjL9PwHpIF7iHAI/OX04fCQFcr5QC/0QD72QaGkqLneZCpkgzcDtWJHF/WC2lGtOqiRnHZCrxEAmT7u0B9WehAq7INzgUI4j5zuxsF06hSTigcjqYrQy1lBvsnwXbMwm+P+wT0vFYi7nc5Jqti4dhVmxtnjn+rI+2eNddZMg8MPpWMRJzY6j2iujgsbVioTt4UJ5i3VkaiM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB5977.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(11063799006)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHErcmZMVVovdWU3ci9rbkcrOEppUkdGQ24yYnUrcGZBWGNFVmVHdzlweG5Y?=
 =?utf-8?B?NFdhK0pSK0NOV3NmbnZtTm9XNHEwT0prRFVPUVRnUzFrbXFZTCsvTXFKY2JB?=
 =?utf-8?B?WkVPQmhCbE9ac2FTR3pGaTZpbWdxVG1MU08vK3lKY1JxSkZMeHFkeEhzMktP?=
 =?utf-8?B?Y0dISVN0WFJCUEhSblBZQ0pDTkp2VDRGcWNZWWpEQkdpZHEvaHp6aC9KNWxP?=
 =?utf-8?B?eDZkVWxvWlZQZmFQWUk1WFU0K0dyZlNCaEhzdVFWSWlITlJrNEp6OW1FV09V?=
 =?utf-8?B?Z3FkWTd1WnZmdmd6ZVZXVFMvU3dQV1VGZDhhTEx3L2pNWTQ1NFFsU0FPWUxN?=
 =?utf-8?B?czVqUERZWStacXIwSFgwYVp0bkhDNkYrRExpTzlUdGNYV1pSZmNqYjlBbm5E?=
 =?utf-8?B?b1hmSjk0MjRxaVhXajB4K3U4eGkxZ0pHanBrN1hLOUZGUU5pZkFRT0lZZ0tY?=
 =?utf-8?B?a2c3SkRpaUw3T1FhdCtUZjMvT2lDSnhOSUsvZXVsN1U5bXV6U2c1WU1PTkp3?=
 =?utf-8?B?cUM2eXMvQVI2Z0hvMDRIUTdmT1lqMDVvRHg0cEhLWHFlS1plcVBXWUVzaWs3?=
 =?utf-8?B?WVRCVndOaE9sbzd2T2xJYVR3MlJ2WlF2UjdvRkhEKzNRYTAycUdZL0Z0cHZz?=
 =?utf-8?B?YWM0YUhrUzlZVE11b0NDTytpNnprWStJWGtHY0tmSlZQc00vMGRBTEZ2c2xS?=
 =?utf-8?B?M1dTd2kxaEt5Ylp6L0t2WkoyNlo2c0IrczN3eUNEakVReXZld2lXZ0NLMFpx?=
 =?utf-8?B?RmRNOTZJV2hWRDZzZllzTWN4aWR3WDZpNlVudmxJSGxKRkgyYjkwQmpodWZa?=
 =?utf-8?B?c0xkSlNaYVhrbzVsSVNoNm90V3dDQnEyL29PSXlhTjR5RzJFQUg0eU5SRDhZ?=
 =?utf-8?B?NkZGVk1qMmdOV0UxZG9TZGQrOXBra3Y5d1BYMUlrQy8zbnpwU3cwQnBOWk4z?=
 =?utf-8?B?N0NjZ1ZYTEFIVm9LWWZ0OUpSR2pRU2ltdEkvakVtckZoczBsenVlQUY0UkRm?=
 =?utf-8?B?emxORGRWbUMzSHE5UlliSEZqM0JFY0RhajlDbWhmbEcvV1RDalJ6Y2E1NitP?=
 =?utf-8?B?cXRuVEFNcGtkTENVN2QwaXo1NVZrZjU1dnd1RmVUNXlGRkZINUZTazg4WkNS?=
 =?utf-8?B?RVh6MUdMc2c2NW9CWC9pQS9jVEkyaHhCYVZEL1BwZlp1VVc2MTdoNmQrTlZk?=
 =?utf-8?B?L2xHeit3QnFFQUlKclczVGV6b2FxQ05KdnNiWWpWRlVCQUZlZVRQeTUyQm1W?=
 =?utf-8?B?SUwwSWxKUXFVYzVHRDE4enBoSHNuN3RiZ1BBTE5IYjhUYWJmd2tMdVNmSUhF?=
 =?utf-8?B?Qk1QN2xFRGkveDRrYktEcmVYQ1N4MU8ySHVwR3cxQzFiSVpKaVEwdkFiNi82?=
 =?utf-8?B?TjN3OTlpc3V0eSsyY29yWngzZXl0dDdDM2E3NTFCempZcTFuaktITC9odnMz?=
 =?utf-8?B?VjhaeG5idFF1SmNscFZPQVF3WllDQXFjOW13Sm81R0xKNytBMHpkeXFMMDUz?=
 =?utf-8?B?eDdqTkloUWh5dms1ZkZka2lIcVJzbG9xZm95dElSTU9wUEFvU3B0anVMUTls?=
 =?utf-8?B?UFNiSVNOSmpCT3hjMnJIZW1GbFhna3pQeWYrSnlUTG1PQVNYZmlSRWZBalVT?=
 =?utf-8?B?aThjbjdacXJLT1ZOck9NSmxQK0RZSTJiWjhhb3FjeWFHL3VicXlPSi8zdVFP?=
 =?utf-8?B?bzRscm9Ia1hONnV6YjZwS0ZUMHUwdEtmQ2Vic3U0ZDA1Ymc4RnVLQ1FLcisv?=
 =?utf-8?B?Q2dhY29nMThZdW1jT1hybGNPNUl3WHdOVC8xSG1BQjNPaUVKR1dMUnhGWWlH?=
 =?utf-8?B?VXlpbnhEcEtNOWhHdlBXZkIvbEFsRFBiYzNteWMrWTBKVGZJT3g0ZXR2MzV0?=
 =?utf-8?B?OFlOM0JyS0Z2ZW5WTWM5eFI1cXlOWE8vT3dRUXArV3k5b3Ewb2hCZXpDRUln?=
 =?utf-8?B?enRNbERzbTRkTW5sanVjeHMxZ2RUQk9zYUdZblQ0TTRva1BRSC9kaXlrQWxz?=
 =?utf-8?B?ZkxFN0pDa1doZUdiZlpKUVhMNGZURWZDc2dPdk1JVkNTdzJNaUtpR3BSajEr?=
 =?utf-8?B?c0VKU3o3NllTODROQTJGbkdkRVMwUVFxYUlaNUo2bkRQcnE1b2poaW9vZ0hm?=
 =?utf-8?B?MnNmbDRQb3hLYnp1NzlLNUxiUUF4dXdFMFk2YTVHakUzOXgxS2lnamxCU1V2?=
 =?utf-8?B?d2VFRUNwampobCtsZUpKbWVTcVpyL2VzeGJDUCs4N3QxSHZ1and4MXhyUGZ6?=
 =?utf-8?B?aEJzV0cyQmFIV1FDSUR0aW1iYllZZlZDWnRjNEdJSGZiYkYrTjBoYXhKeHNF?=
 =?utf-8?B?NkxCWVJiM0hKb3hUV1M3ZHovZkRYMHN4R3FETjFBc0NBYmxPYUdVZz09?=
X-Exchange-RoutingPolicyChecked:
	re080/CTo9UTTLQosN7SoOUvT0EgYDDUNAa8iZe6pdNis2oYtD6rtuK7ojoc4jfYKI5TRm8yMBqHiHitF1RcBXCuKmfKFzUWF/0fLOpDWVUbLu47MA0i0tnzjRm/AjaamHyYjLXSWUyn2W0oQ38TsSj2ILOlI/69HlQ8rkGjvVnKKKKfj+7eSYxSrRIe/6Iz7YPXnUWCzCHiU3HXLaxMVkY4yZ7zbs+4StXW7PTAmKnKmwxR+Haq3q+0ahRiBrzlD8GOdk6Njm/Cqwx+gb8Q9tTMVjrO3Da28yjWB8u1z1dem1wX03ORDIPReiCDBb5bu1CA94qWOInIG1zJKH/6Xg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f1a3d1-04d9-4da1-e1b0-08df0e65e1e1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB5977.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 11:31:25.5925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPadE7d0aq9kiFrFrcaDBRS7K38b82GhNEtWJVCN1h8pNusE4IPjtIajlz94guFjTh2uxk0Vq1eI+5bMM41xFnCxuLbs2FmO1CPPlLRG8j0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR03MB449088
X-Proofpoint-GUID: 8AfYKN3WEGXjOED44OUZoYoIExNYK3vl
X-Authority-Analysis: v=2.4 cv=WNtPmHsR c=1 sm=1 tr=0 ts=6aa1438f cx=c_pps
 a=yMiMM/zaslgybVO5xx/4Yg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=VwQbUJbxAAAA:8 a=DxXjzc9rhVf24KB0ctYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEyOCBTYWx0ZWRfX09vOzpiZzR3m
 ZMGCfjSSi/6uA6vKyUghXRnelhv1lwXui6iXuKWBS3vsL46SfuIVaY2Q78dmzvSOh+oU8KcHWww
 udqvusG152HAZKKtb5nVE4rclGcGiiX0L3Bj9S4sgDRkM1GMr9SKXHhv0qrBSQIeYjpoZRaP+4h
 T0M+Yj4jxn8Bb65uZ3FHkq39SSUAfG2+1fMfznaUDFWQCOxDe+B+XZsu6LwkrO6kihSBeyEC5v6
 HeAdX4bl7Hrmbj2JBigIqq73qxEIOfECFwAkziaWxulwnpTBl9tglURjvuiHbDAUTf1+bhtZ4ep
 F3PIgg4fa2zkjJjaNzs4dypBWtq7w0yylskvvk8LDCpSCKzGzJ591UQXNoH59qDmEO2n8jdHe6e
 WGmwXrjMDlJlSpeg2oDOJN3a0GeHiFZMZ2Fm/saV6lq+17ke7SQ7IxUZDBwgffQR332UpNA/viT
 SN4H9XY3Y28JN7vEskA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEyOCBTYWx0ZWRfX6uuDfXjX4uKM
 6QVoNT3V+bru2sU/iQzmJMbFi9Uf09/nwdArCQnuExi1tXxB1knSKDfueScePzHWjKNNmHGzIJM
 AGK300/gmSQyxKHztCDxk8VnouutP/U7ypuCuacry6aNBqar8eiU
X-Proofpoint-ORIG-GUID: 8AfYKN3WEGXjOED44OUZoYoIExNYK3vl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 suspectscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090128

Hi Stanislaw, Luiz,

On Wed, Sep 09, 2026 at 12:13:55PM +0200, Stanislaw Pal wrote:
> Hi Luiz,
> 
> Thanks - all three points are fair, and the first one I owe you a
> correction on.
> 
> 
> The power supply
> ----------------
> 
> That July message was too broadly worded, and I should have followed up
> in that thread rather than leaving it as the last word.
> 
> What the A/B/A established still holds, but for a narrower fault than I
> claimed. The July signature was link up at 2.5G/Full with 326 FCS errors
> and 326 drop events on the switch's CPU-facing port; swapping the supply
> made it go away and putting the old one back brought it straight back.
> I have no reason to doubt that part.
> 
> What I got wrong was declaring the cold-start problem closed. On the new
> supply the board later came up broken again, several times, with a
> different signature: no FCS errors, no drop events, no CRC or symbol
> errors anywhere - the switch simply never forwards what the CPU sends,
> and the MIB TX counters on the user ports stay at zero. A power cycle or
> a driver re-probe clears it. That is the failure these patches address,
> and it happens on a supply that is not faulty.
> 
> So: two faults, one supply-related and settled, one not. I conflated
> them in July.
> 
> 
> Why unbind/rebind always works
> ------------------------------
> 
> I do not have a measurement that settles this, so treat what follows as
> a hypothesis.
> 
> At rebind the chip has been powered for minutes or hours, so whatever
> internal power-on sequence it runs is long finished; the driver's reset
> then only restarts the register blocks, and they come back quickly. From
> cold, the reset lands while that power-on initialisation is still in
> progress, and the two overlap. That would explain why the extra wait
> only ever matters on the first probe after power-on, and why every warm
> path - rebind, reboot, sysupgrade - is clean regardless.

Can you share the device tree for the device you are testing on?

Your unbind/bind test observations seem to contradict the headline in
your patch - that the chip reset register bit gets cleared prematurely.
Either the supplies are stable - in which case the "cold probe" scenario
should behave the same as the "warm probe" (unbind/rebind) scenario - or
they're not, in which case we're out of spec and weird behavior is to be
expected.

Oleksij has a separate series recently applied to net-next [1] which
makes the driver consume the regulators. But since your patch is to net,
I assume that you've been testing without that. Maybe it's possible that
the driver probe races with power-up of the regulators? The management
interface supply (DVDDIO?) could accidentally be stable, so you can
still write to the register and observe the bit flipping, but other
random parts remain un(der)-powered?

Assuming you have the regulators described in your device tree, maybe
you can try applying Oleksij's series and seeing if it fixes the problem
for you? Note that some regulators take longer to ramp-up than others,
so this only helps if those timings are properly described. You can try
with some conservative values if you're not sure.

[1] https://lore.kernel.org/all/178839965088.3035212.12735726271200270390.git-patchwork-notify@kernel.org/

All that said, I'm not sure that backporting Oleksij's changes is really
a proper fix for stable, since the supplies were not even part of the
bindings to begin with.

> It also fits your RTL8367R observation: if the reset bit reflects the
> register-level reset rather than the completion of the internal boot,
> then how much slack there is after the bit clears is a property of the
> part, and a driver that keys off the bit alone is relying on that slack
> being zero.
> 
> 
> The deadline arithmetic
> -----------------------
> 
> I have no attachment to the implementation, but I would rather not
> change it on my own judgement here, because you and Linus have landed on
> opposite sides: he reviewed this version specifically liking the
> deadline optimisation, and you would rather see the complexity gone.
> 
> If you two settle on the simple form I will send a v3 with
> 
> 	msleep(RTL8365MB_CHIP_RESET_TIME_MS);
> 
> up front and a single read of RTL8365MB_CHIP_RESET_HW_MASK afterwards,
> returning -ETIMEDOUT if it is still set. Total probe time is the same
> either way; what the current version buys is only that a chip whose poll
> already took the full second does not wait twice, which on reflection is
> not worth the arithmetic if it reads as complexity to the people
> maintaining this.

I don't see much point in polling if you are going to sleep for the same
amount of time regardless. Why not just write the reset bit, msleep(),
and check the bit has cleared - returning -ETIMEDOUT if it hasn't?

> Numbers
> -------
> 
> One thing I should be straight about: the "one cold boot in seven"
> figure was measured with both patches applied together, so it does not
> attribute the failures to either one on its own. Johan raised the same
> point on the OpenWrt PR. I am running per-arm cold-boot counts now -
> neither patch, 714-01 alone, both - on the only board I have that
> reproduces this, and I will report the counts when I have enough boots
> for them to mean anything. If 714-01 alone turns out to be sufficient,
> the second patch should be dropped rather than respun.

Kind regards,
Alvin
