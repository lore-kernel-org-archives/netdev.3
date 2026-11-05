Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793888083;
	b=Vf1RWFvcCV2yLPP9NI3imtSAfx9cZEWRdVOEuCOtp/YO2VzrpytAyzSAXFRYbvFXtYBh
	 zoO3mBt9TuKJaw2FEP+hYtcZ1E9ADYDSVMLv7q/BIxWud6YAHB/H73KI3YFwTOPS8PWlV
	 OI+Tg90jUE6sSp5sqcpxg7XMZQDWKXI1YtofgzcBqDkdJsZVj5WbpsRab/daFjDL6Jx6K
	 U30jNIVXdJEUInSQuzds7naEp4YFldYljs9HXORcEZQge7wSBdBbjuRwbXL1nBsfpPBce
	 4eh9MR223/eQiqzwULwd4yKZNBJ2DQY0vGycJj16BhhH95ReJE3CuEwI7s6EdDSpcvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888083;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=DkGKsPRHK0MTZIU3lFFqvcn2CknRuZqD+J7fYHDCZNI=;
	b=V5K+S6pOZhGastdtxEuxrfPLrnR32e4scfeGRRNYY1usvrhTC8rbuYyDXeU3i5QEGsxO
	 dsVOkgUiiiJcTVi4cLkBeclz4a/LJLOCt3xrbSd2R1La5neqmi+SMQaKgR+5cws5ytl/G
	 NbWu6yaTYrhbmCOhPiH12enWavkSipKhRhVvwr+oIHtTLkHARmUy/JJzikrVea2jK6mso
	 AzoHUEM13d0qBIUZRl01aq6shEvfNhNrUG3vgQXrRHQIkICZGSQkrNbsYKzaaLppIiPZS
	 KU37fS7JEnx1DzFjAvStyCVLGNPHxkfBX815/MR/3XovCyzD06G6kePzcxzPccOjmiA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mtSdQG2E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.31
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012031.outbound.protection.outlook.com [40.107.200.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AC46083611;
	Thu,  5 Nov 2026 14:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86AC46083611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mtSdQG2E
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FADLxZ3FhX683EZFnKW9O1L4R7PzDLQGyH1BvLCR9XKcX/FKLPQrlu5s1GrtTv2F8SO5jNc/2Kzrh4JY+66zMDGJWi4GsGiJDMb6loRDa8KzIBV7UPjGDOssi60Oy58CMNfIfQuWrZ7gSmIpgsEYMwidsPWK8rB0gSCkem+aJ7casDIBjNvjuJkOhusKiucB2LX1rLfhG0arjb7Jg1OesyniKcdYp5GKpB5k6ehNh+nF7dsTSVC7/T+bvAKhzAIjf2ANgwODB2LGu1B0TogPiWYA/ZZLUscoUlh5U+yxsYB86XNXPm1NLuDGDP7j0KKmNiI2LnZ4JIjwSmfZB/Wbfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkGKsPRHK0MTZIU3lFFqvcn2CknRuZqD+J7fYHDCZNI=;
 b=yuhR6juOtVC3QxnTy5cIIxwaenoqwxK6t/6QpMMLfylx6I9Vf7eADybRH1hjgulio7d0ZLACnFRVL0JnZJNDKVKatahBK/Xbowud5fLdxE0vMaG6GBLtEeNBBslEdYX4p+p/wlpBC2mFJ+usj2Lfm9fyIkvIOhgeuYjiTQFUQMJl71L+wNKLhH4A1wLneWFG1yM3hxckyJi+q36lKh/lSMAYP1QEpPRZMdlyO956MsQ0vswTMDkl9DPkkAGlKB5szDmclLQ2drTVO4D4yMPHa6LAn9dqqrAAiCyvH+yIxSf2wlZfr2qyLpn7hywNBXA1XHwAEjKOiqwyLFwz2PtKWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkGKsPRHK0MTZIU3lFFqvcn2CknRuZqD+J7fYHDCZNI=;
 b=mtSdQG2E0VQ/CCUvp4BA9Y3djx9ZcQX8K2o9p541uwIhGFobrTlC2GbWL1GrVvqtSRZXqjTa7CW8EOwSZTDS/5KQBY0lluT9ZbfQTJMJSdpBFX0wXEUPHZLJYYDQXkTTkoEPdJjGfGbazA9Aa5fkdv3drXTVZCRrfnyUBIX0oFcNwX2Ce+s1S5q5zkSz/uewM846JaHuco3TqlB+n1xnWPO1/mg7yV1lT2tPEDmL6n+O7TVS799gACzSbZOy0R5TeTJnug3gRu/U/CiInznQj+qBOqJzuPPVOc/5JYjf6pkhy/QxqMH7/a6rJAYW5UjoQYFOC5IOyJjVYLknq333GA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22) by BY5PR12MB4242.namprd12.prod.outlook.com
 (2603:10b6:a03:203::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 14:14:37 +0000
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205]) by CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205%6]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 14:14:36 +0000
Message-ID: <4cd75251-fbc4-402f-8939-1f6133f3b40a@nvidia.com>
Date: Thu, 5 Nov 2026 15:14:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: mlx5e:zero-prefix corruption during TCP DMA-BUF RX - help
 requested
From: Dragos Tatulea <dtatulea@nvidia.com>
To: jiabin deng <dengjiabin2023@gmail.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, linux-kernel@vger.kernel.org
References: <CAFxp=AY2cVRQrZvB9WNnigbsobuw11NMG-cagHx0_V+ur2ToFw@mail.gmail.com>
 <e4054f5a-e60c-4253-bccf-d05cc7c615b7@nvidia.com>
 <CAFxp=AapgUYLUhipVjR8oM0fRDSLDX60AQf0UP8=U4M1ASqmOA@mail.gmail.com>
 <e6a557b3-2986-486d-9679-e7a4fd1cee5c@nvidia.com>
 <CAFxp=AbmdmTsj4ugjxdKhRR=LJuuC1yr7DFnLCSgOpC2g9470g@mail.gmail.com>
 <atZKOtjrb9HKSNHF@dtatulea-c5.nvidia.com>
 <CAFxp=AYqVgR_Eahz2QsC=cCdxo5GmTwdHcgBdXRGf9P+v0OJxQ@mail.gmail.com>
 <d6c14ede-1cfd-4800-a8bf-5093ab8c000a@nvidia.com>
Content-Language: en-US
In-Reply-To: <d6c14ede-1cfd-4800-a8bf-5093ab8c000a@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::8) To CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHAPR12MB999248:EE_|BY5PR12MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: 581e04c4-b54f-443d-af5e-08df3b471f54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|261022105027099003|56012099006|11063799006|4143699003|261021121427099003|261026140227099003|261028144727099003|261102123227099003|261026121527099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Au1k/DDPy0oCNIpAOxXqDl7/fN6tn10TBnLm7LXHlV7507wGCiTjs0i9Mqcwpt3oCFx0ykBREi7QDmrjndYkbP6v44YSXYusWNqp4pf7o0zzcJ9FSYooovZIkjSrIgs6DltDcVdZNhHt/DD/kb52KgG/qzw4ss/nNsCaZ0BkExBLwoB+ZNdLuqx4ndFxQqkNE5jiVZMqyTsf3E22mYPmQGigzfinsgXgUO3HD74yMWVNynVjMbahsNPraie2B+Oncv0iHJaDX9MQmhteMNqF1T0K1OUy0ST+wjlsmhsaN730B0JysoKY7UN/rixOBW5z4x4StKqmHQiFU8T1Lvwc8Cv3NmiU8V3lyAVPMPxX3TYZkQH/83KjaBmib8algBeo5GuvXnGphdwxIOeOkkali4GSep6ky/nWfnhxZPQ8SQKh7o1x2TLFiGzE3ehASr8MhLzonzDgXMyuay5A3AQRl4N6qQywGirirC3l4C53d92zUc8Lnkno+e8LAqRap3eRkA6Br64q26UIAY5GuuOzj6y7xNB3tCL/4moOuE8xwojElEwfAZcabjV45f1vUqmLivQM42WBLLbgCxdUd/PjdvZLD4PeUvKkSJiJjTj/RWBgiHm1sRH4ytW+anF6GIL2Qxm0HGeCt1Y2uAp5H2HgGL8DWlFXxif9twvfRdPATwQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHAPR12MB999248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(261022105027099003)(56012099006)(11063799006)(4143699003)(261021121427099003)(261026140227099003)(261028144727099003)(261102123227099003)(261026121527099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXdOMDdnc2VGV0dYTTUvQllqZGIzNjRBYVpVQ1B1TldNVlhzdGlNQSs4dHc1?=
 =?utf-8?B?YUwxWnJnYXFGTTNPUnhob29VYXBLQ0ljU1NYM3BtSlVEV0RhMDBZdGNiQXVh?=
 =?utf-8?B?WTJwcHlzYmExT0d1SGlMUFZjaXJKSlgwdWV4NE5Gd0ZUTVhJYlVIYm83QlNy?=
 =?utf-8?B?VnlYQVJjeFJxUDErSlNzVCt6UEIwaUV6TVNqQ0pFb3ZMS3krSzRia3A3UkZt?=
 =?utf-8?B?ZWJYWWt3MUtRc3RvM0R4SWxLUlhlTUdlQ1Z3dFpyRmxmQU5sb1IyYkxHV0lN?=
 =?utf-8?B?UVhBWVRNVU94eCtUVnBzQlpkem9FQlY3cHhqbFphVHpiSDJhK0NaU1FtSWti?=
 =?utf-8?B?cmRBblVTcEhsYmZadGU2bVRFR3hkWXZXMU9FUW5mQVdpaTNFTVU0eWdaeUF3?=
 =?utf-8?B?K3Mzcm8zOGQxRm9Wekd6WlQ0bWtnY2twaXJwUnhJTG5xdGFYRHZ5Y3pySDBX?=
 =?utf-8?B?RGEwS0hzNmUyWERNRm5ibG5HaXh6SDEvU05vM2MrdklacnRUc2VXamN2Ri9z?=
 =?utf-8?B?azljdGJmZUt0RWJrVnpjVnBzUGJYd2pSall5NXBiMXR0TCtpRUxoNlJpN1ha?=
 =?utf-8?B?eFExWld2RzVaRmk5dG5XK0tac2RreTVaVFByTG52b28rNFRaRDZ2bW1lZExK?=
 =?utf-8?B?ZXN2UjNFZzRFZmFHOEZ4cENpWm9pRTNMd3RlMXhSS3JPK2RuTnhIck9GODd6?=
 =?utf-8?B?dkswRHdTZ1JJUy9rNDhSbGY4WHllQUpWQ0hWUGNFZkFQQWdIUXFCaFRyQXpq?=
 =?utf-8?B?aDZRcjdab2NBY082WGFveTFoOEtmMnUySTY0d1Q1aVVsYjRnQUI4emEydlll?=
 =?utf-8?B?QTBrSldDZFlvWGJwQzhScWNYWFVmNHM5N0dGa2Yra1pmWm5jZFVQWDB4dFFv?=
 =?utf-8?B?NGlMcmZ3Y2trajFFV0N2cndGcnV6eXpML2ZlVTV4cGdBMXF0S0lTUk9TeC9G?=
 =?utf-8?B?dVNvdFdxMlhHMWpUdkkrQzEvR004YnlhQTU1Y1pwNFRRUU5nZnVZVzd6UDJJ?=
 =?utf-8?B?azBYbzlPQm5LUkVnL1dsUkNmZUpXYlQ1cS9YLzJTQnF2d2FpVVM5L0xGaitY?=
 =?utf-8?B?Rno1TERFNitqNTduZ3pQMXl5RWFEbCtnQU5IaDEvblIwZ1dVbGFRS0h1RTc0?=
 =?utf-8?B?S2lxZWU2TGNqS1lyclJUd3NWaThJeXZCOFZkNllqOWFOWDJWZ1lUWnJ5aXl0?=
 =?utf-8?B?V0JRa1l2WHJsK2ZXY2FPT2NacFN1VC9Pa2ZDakVhMGI3a0YwaGpjay9QQUZI?=
 =?utf-8?B?d2FsQ0p0UHV2MWMxQzl2ZFZJU2hUcDJ3bTV0dU94akxqYmRhUWZ4WHZ3WmlR?=
 =?utf-8?B?L2EwdUVRYzNxZTczVHlaUzNzbnVFcGhtNFhQN0JCVjFrQzUyU1lTbHRWUzBC?=
 =?utf-8?B?ZXF5bmN5eVZnc3NTYk5nRXFiMXFkeTdWUEhIalVGTlZyajNGdmpQNnoreFBW?=
 =?utf-8?B?VzFjdllkSjRjVDBqT0QyMzRnU0toV0hTVDJLbnU1bW1aQ0JXV0U2MktjSUxB?=
 =?utf-8?B?THBpRjV4UjQwNlpiTzF0Qlh5eFRIbmdhclo1NTB0bFROZXZYN3ZuSi9lTWox?=
 =?utf-8?B?K280emdrb245dER2QnZhQ3IwSUdqQ0pzSDUyTnBac292MTFDdmRMV3oxalYv?=
 =?utf-8?B?NW1QZFhEZmJBc0xNcTdOcTRLdytlaUtRay9hZmxYMkhJWFpjQkpqWXd3Ym1w?=
 =?utf-8?B?aU04aFQ2bVZNSVN6dDk4YnhBT3Y5aFNKSEtsUFh4OW1OY3R3MHo0WndYUjY4?=
 =?utf-8?B?ZG5Bc3FDc2JiYzg2SDJBaXY5R0orVzRzRWk4aHhDRVhSWGZBMEhWMTR4SmYx?=
 =?utf-8?B?clJqT20yN0c5bS8rRE9LeXY5aG43RWYySUMrOHZJcG5Ya1R1OGlUa2t2RHlP?=
 =?utf-8?B?eVFPN0FNUlovVkdnbGxmMm9pcmRCc1E0cXd2Q25YQkZleFkwR0JRL0FGLzMw?=
 =?utf-8?B?QWlnaFlKWEp4ZE1zbDcwUTdqa0Y3MHJ1OFRjOGJabG5jTWtLWUxVZkFHK2Mr?=
 =?utf-8?B?Q2FpVTNmMUFzUHk2T0lIdngxbXZyNUxodWQ1TXNxSFJkdjdsbHEzcnRmRmhV?=
 =?utf-8?B?VXFaY2pnbHYvdEU2RXNwTldJZDlSUkFpeFdGSnpWUmxDbDV3SzZjNFlObVhV?=
 =?utf-8?B?NEdUU0tCaDVLYVNmKzh6VzQzTklTL01sckl5YW1HdExmYW9BcmRIdUk0QnQ0?=
 =?utf-8?B?Nkp0bW9yTEdyNEFaSEZoaGxEbUo4UXN5YnpTTlF5YWM4NDBTYmpjb0NqalNu?=
 =?utf-8?B?QXhRUUdXc0hZVnduVzJhc3JpY3M3Q2VQaVR1eER5bTVLZkFuQ1k5OGJodkJy?=
 =?utf-8?B?eVF2MmVpSUtDTG5CZkRhZ1dlSStsQXhGZ3VPQVNqTE55Tnh4aFR4dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 581e04c4-b54f-443d-af5e-08df3b471f54
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 14:14:36.6288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UdP4W16v2ZJbzotYelwx+yw1+aJ4YCTVvADLSJvlXt31S5pWSagjPocN2w1iAi6guKLehQFQ4EJEXcuSIuDUow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4242

On 23.10.26 15:14, Dragos Tatulea wrote:
> On 21.10.26 07:19, jiabin deng wrote:
>> Hi Dragos,
>>
>> [...]
>> Thank you for continuing to investigate this issue and for suggesting
>> the fix. I also greatly appreciate the time and effort you and the
>> other maintainers dedicate to the open-source community. As a student,
>> I am excited to have the opportunity to contribute to the community
>> and to learn from this process.
>>
> Thank you for your good analysis and fast response!
> 
>> I would be happy to help prepare a formal patch with the test results.
>> Would you prefer to submit the fix yourself, or would it be helpful
>> for me to prepare and submit it based on your suggested change?
>>
> I am still waiting for input from the HW folks to understand if this
> change is needed for all SHAMPO cases or only specific P2P DMA
> cases.
> 
> I think you should submit the fix as you did most of the work. Just
> give me some time to check the above. I'll ping you hopefully next
> week.
> 
I got my answers. Feel free to go ahead send a fix. If you won't get
to, let me know so that we do it.

Thanks,
Dragos
