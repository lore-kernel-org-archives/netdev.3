Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C20371CE4;
	Mon, 27 Jul 2026 05:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785130350; cv=fail; b=OdInt9TSaKSP9a20VKeIXphwG71EDRLLSRpFOHAfI7bLvumdpOGclnhX1NMNhN2h1rRQkYFwsYRHvFPyA8FgMjwnCgYggmDRRSE6aZSwkt7vkIhHkauYDkx+KICun9HCg3Ay0g5H28E2BIjOy9LPeZsGMRXSN5aTNNiijiMEh7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785130350; c=relaxed/simple;
	bh=siYa+uHYdvm/Rm03Hjmy8+UBjV+OVNYGv1+g0qwVP/M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dNocZQ+9Lp3FOADx+j377hs0ObSw5/3kuhq/Jm8ZhvoORC+StD583bIgSvBDSchDhZ7PkT7yYgo7XdiBJvEfmFo6Id4bL/DIlx8Q4zcRJPscMf5DC/q3+z2Z8/4kAZjCUmunuQud3ISPRex1e0LmMhBtlDmwinifltTeIRHfLsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2omjp/km; arc=fail smtp.client-ip=52.101.48.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2omjp/km"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRUpngR/R60qqJ72W+jtQ/G2yLF0kJ6v7kZSZF/1i/7F1+1NN0UK2yMXoawhvF1bE1TyuZTJAEre9eKjC9/2JfLSpiYxbiJqpoSkxVn4vgZ43SUyMRnmRap1Ox+FiHZoTz0kDcVwfb6SLQBDLuJIdvcgorBXS0zBkFM8HDsW+mvhfE+vtVJcJnyD0wCyqiMwFhFZwT1Y51bdBBhQ1tSgZal/Uy5/aCjoE7xOBv6IT5F/XI9bsS9wRQNNjAVBrlnPnCdrkqokOoJ5raFXZUzDL3UkM0FgR9y6VQjkx8+dQJXCldb7Jc6yKvo9/dW+8zeGfaTugze/YzgVRCAlwaUmoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7tIpDyopXqPjzJROoGr8n0Bz66fTD0S65dSTZGWeBI=;
 b=Epy7Dm94QnfvkfMzXPb9g5/KU+0y1lpIqRPbgXu2mfKsWXdSuNmcwv+rwELfDOp7VSZrgwh5bm4EpWMX1LDFUpNO3oaC9EOcsb/HIEdKWMWEmIg8C7lLZCwHOqTQ4iTZjH24V0OKprW4QTDF17KZ013vauKE8fbRZDt5AO1zbseYyZdSk72lMbDyB9CLqFqsBPocSV2PBDQDiRTUKfFWEliUpPEXMdt/IKnXokKA4KIMrQik4BCfXIvYiwYfbXbLh+g7RQep5iU8kammSE5oG4Fb9yZSGp6I926WokzhS5Odk6GjJ6ztkKHRT0gP9ibIK+U/NAdxtXp6hTT8qsbCPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7tIpDyopXqPjzJROoGr8n0Bz66fTD0S65dSTZGWeBI=;
 b=2omjp/kmgSlZRWNg8U652CqfmLeGZytDbMCmC4xxsSKl7PkOygt+nbbwJC/OoQ/opqtg5aThVUJtpKZJU2IvBRktW+KMOslruqhwJ1tHf4IZTp/53LrUHj2CvBeouc+AsF78N+vxiXU1rDKOxp3EfwhfTOhtLJMku4VRqblQF14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14)
 by SJ0PR12MB6989.namprd12.prod.outlook.com (2603:10b6:a03:448::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 05:32:24 +0000
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b]) by SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 05:32:23 +0000
Message-ID: <3924babc-9755-46ce-97b2-bd6dfce6f6c6@amd.com>
Date: Mon, 27 Jul 2026 11:02:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: macb: configure ENST registers for all
 queues
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Vineeth Karumanchi <vineeth.karumanchi@amd.com>, conor.dooley@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: git@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260724043257.2221030-1-vineeth.karumanchi@amd.com>
 <20260724043257.2221030-3-vineeth.karumanchi@amd.com>
 <DK701YU8OWST.2CDXDR5SUJYJQ@bootlin.com>
Content-Language: en-US
From: "Karumanchi, Vineeth" <vineeth@amd.com>
In-Reply-To: <DK701YU8OWST.2CDXDR5SUJYJQ@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0227.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::8) To SJ2PR12MB8953.namprd12.prod.outlook.com
 (2603:10b6:a03:544::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8953:EE_|SJ0PR12MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 670659e3-7dbb-4e00-753f-08deeba06fba
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|22082099003|10067099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	+sWYIh1ywwEgdd2ewrWpqRs5w8CqtIsT0gA+Q1YCpNe9SvIoQj90DiU0RfL2dNhs90HJ9Z5tVn7X4Mr63lBvt9F+jTbsMOVkB7W+bQ9M8xfnFYtYZ0VjCPIPxzjq/FjP229m2eODIe0PSOmngC5mTjIyJy/j2vfoZ0Sg3frzgBFQyT4AMXXB43KmfyjDEeahhA3GmlVKmNyjOHQwm8l/od2ovTlQpeTgoJtAZ5P0UADB5CfrvBDxVFcxWsVyt0SCKdXe1SkrieHlmz4nbAFydOgobI+101O3l7EBaiuBfTNHAFg3K0qim5SZam73O1Bprn4TIRUFzLNXrgjLJB5b+c+O1f3BFidRnqddBQ1sVtaSPl1V51aSwicR2NVrDbc2dbHBXdahxO4ff2OzWAsVxuuWjYT7pIETDLhgP/lfR43OJS1FsVNvobLYtj2pcGuZMEJu4h1Jl9WOaQosHDZKnOLhRM5ARwQYhsrR+mbNNhJh4g1xbAp22I1hkgdMoELh4zzY6htfSduCAm6pB5HpwGFZQ0Q+wFBMjJ97tK+jJNXlPnXdyr2G1y3CNMsfyUPAuLkdbu6p+ORQXaJ9nJ+yXShYz/UTO+KHHd27h6OeLx0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(22082099003)(10067099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmxuMFlFa2xKeEtPRHEvanhGMk91WEVwZUJ1dUFjV3BJUUlnekNOSTIvSVc0?=
 =?utf-8?B?b2dhUzNpcnN4dElyVHczeEY0ak9sMU5KTUpXSURPbmJMNFdscjFnSjh1Ujgv?=
 =?utf-8?B?VVRnZnQyZUJqWjJzd2UxVXdrWTdOVENuVGRzc256blZldzJOQ2dTYUg5bUE0?=
 =?utf-8?B?YkJqcFEvZ2ZndG5ialVaR1NBU0pKRHJlaXdEYTJzU1lUb1FtM1lYY1JtZzdn?=
 =?utf-8?B?a1hZbDFpbzUzYlRBTXhrTDQ5bHJRdXQ1SDFnZ096b2NtdlR4T2h5NjUwQi9B?=
 =?utf-8?B?K3hXSGQwRFhobHMra2JCMnFiTmlIK2xCa0YrMU0rY0o5S1RrZ3hWb2MrS2g0?=
 =?utf-8?B?YVJKN1FtbW5LakNyY0tvcDd0Mi9vS2graitvZlpuejNndjhTVlU1dklWVXlH?=
 =?utf-8?B?VnlpZExLTUZXQmZhZjdaei9ZNXlVK1M1NDlBNjcrZHcwdld3eVB1OGdXL2tD?=
 =?utf-8?B?eWpKeWV3NitReUNac1A0Vnp4QWFkYjBnckFvL0hNN2thN3hyZERTQm53alhV?=
 =?utf-8?B?Tm9qa09LUlMrTzJ5T1JMWkhhWDVRSis0aHJOQ0JtN3FkbFRjeHpVcWc0WWVo?=
 =?utf-8?B?bTZHSUQ5Y3QwbmJMaW53M2dzWGJoYldFb2k4K2JUWGNkUFhLZGZ6cTVLTUZt?=
 =?utf-8?B?S2s1ZFFCSThlbnhIYTdSamoxd2NsUG15YmhXSGdPREg2UTJpMzFWc25JWDln?=
 =?utf-8?B?dUNJSnBjVkxBeWZlQmZxb3ZYb1Y2YXZDZThjMlpwUEc0S096SzFiWmVqekNm?=
 =?utf-8?B?ekJwMEt4OXduaFN1QnNxV2l3alhvTFBxWWtsSkcvelVKZkZDWitNM0RVS0x1?=
 =?utf-8?B?UUJPcDlCRStaVEZUNEhtMlVnVUxleHJVY05LZ3RsMmFuSDNPSDVOcHpzRTVi?=
 =?utf-8?B?OWxCR1hFZnJkSFF6TXFkbGV2U3AyRSt1eWFveTVJRjhOajdpand2WlJRVG1L?=
 =?utf-8?B?NFBha0VmUXdVcjZ5R3M2TlpLQUE0M25zc0NjeUVFZiszNnIzVWRDMFdBeEFK?=
 =?utf-8?B?UGx1TElUTVRsTVBtVTB2anlTbUtmT1ExSGM2MFBZWm5NOVVHbWVZRjVKZ3ZU?=
 =?utf-8?B?R1dwMCs1aURNZ0wwS1NhS3ZXdWNIL0dOanNVQ0FOdjRZYngyUjZEcG1WallH?=
 =?utf-8?B?Q2pjRjFOK3BSd1diTGxBcDIrUkFFM1lMbDZEbVBiUTB5L3BXb01UNllGMXpo?=
 =?utf-8?B?UjBxT25xempON2dZa0dlTmZudzhubGxwcVFNdSt1Q1pQWWdSS0VJZHNFMmpM?=
 =?utf-8?B?M3I1V2hOYmcxd1kyQllzYW9hSHZJbzRSVUJPcU5PYlgvcWt0bE10ZTkvcEZ6?=
 =?utf-8?B?S2xROUdBMjI5VDM5bUhMbHJLM0lRSXFnTWhROVJzS284SHhhQnkyQWhneXpD?=
 =?utf-8?B?ZmdFZXBRVFNSWWhqd1BMN1BwRzRVTlhDZGRRSi9yNHVYbm1HWmFYRThpUWV4?=
 =?utf-8?B?bTY2MDRORzVROXhuN1c4Wm9rM3htS3RZcGF2UTlEdGdvTURxTjFYdjcyeVpi?=
 =?utf-8?B?R0l2THlpU1I4M2JEUDk3eHRJemtXSEp0NTBDenBoYVFVTTJ6T0RVTVRRQklE?=
 =?utf-8?B?WnBxdmxkTENQa3U2WGZvVUZQMDlrMVVmMnlRRGFLSU9ZZ3p2OU5Jb0l2ZDlE?=
 =?utf-8?B?WTI4bkJyT0xObEQ0Y3hZUGFCMHNGN3p5SWxxckVXMzJvTENJcTg3VXFHLzZV?=
 =?utf-8?B?VWdBY0g0U3RaKzZXSFZnU2F1eTJuckVPbHIzUGpKMGZSR1lzcHBLRjY1S0VM?=
 =?utf-8?B?c20wK21odFhrNXdzOFFaRGtQTENJcmNnUlFYQ1N0cEs3UEVjbzl6WXlPdGxi?=
 =?utf-8?B?RTZsWE5QbzN6TWNNVHpacmtLQ0EwYlBEbmJpazRaVVh4ZlA4WDhISDZ3WUNh?=
 =?utf-8?B?TGplVUdZQUo0KzAycVk4V0xzTzR5dTVhODQ3c2hFSmMwRGlaVlMyYzJUai9T?=
 =?utf-8?B?ZkhMRmlZY2U0T0ovZXVIMGVnTlVQREx3cDRDVGJYK3ZCSDVkaFJKMEpqMmhu?=
 =?utf-8?B?eFJvd2p0TURKWjlLNTFvSXlpSjc5R1F6ajVsYWZHMk9adVpxcXh3cFI1YmIw?=
 =?utf-8?B?d0FTdnhmai84cXlUNVlHQ29ZMGc2Unpjd0k2NFhGRmpSK1BlTjQyRmxFUDhV?=
 =?utf-8?B?R2p4QndIaWxBZVFuMG1Ma3FaS1pla3FoWCtKYXRUL25pYmRNdmR4Vzl6NjRI?=
 =?utf-8?B?U1A1alhBOW1IVW1wRmZYV2dIL0RVeUZZRTd0ZUJtdkkxbTMvN1VqamNSSEZy?=
 =?utf-8?B?a3NhVk9qKzRVbTdqVTZtZnJZTlIvTUs4ZXlKb0xFb2dnYVZWTnhxYk84bys3?=
 =?utf-8?B?b1VlSnB1VWNFVWV3SDBqWnhUbUo5bjFtNHNONGxuakxnNnpiM0ZOQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 670659e3-7dbb-4e00-753f-08deeba06fba
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 05:32:23.8645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSPHJ6MPwREZ75ak7iNTkSTgR73q6uq+UXIsjvl456AukxGArZZjC9vtmrNscfv6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6989

Hi Théo Lebrun,

On 7/24/2026 11:36 PM, Théo Lebrun wrote:
> Hello Vineeth,
>
> On Fri Jul 24, 2026 at 6:32 AM CEST, Vineeth Karumanchi wrote:
>> The initial "tc" command was not overwriting the reset value of ENST
>> registers if only a subset of queues were configured, leading to an
>> invalid setup. To fix this, configure all queues unconditionally.
>> Unconfigured queues are zero-initialized via kcalloc(), ensuring a
>> complete and consistent configuration.
> But if a subset of queues are configured, the remaining queues don't
> have their ENST support enabled thanks to ENST_CONTROL and their ENST
> per-queue register values aren't read? Or HW is broken and reads ENST
> registers anyway? Or something else I misunderstood?
>
> What reset value of ENST regs you observed that caused you trouble?
> That info could make it into the commit message.
//
Yes, this is a confirmed hardware issue. We raised it with Cadence, and 
they have
acknowledged the problem. The reset value of the |enst_on_time_qX| 
registers is *0x0001FFFF*.

During ENST initialization, packet interleaving was observed when only a
subset of the available queues was configured, while the remaining 
queues—whose
corresponding |enst_on_time_qX| registers still contained non-zero 
values—were left disabled in |ENST_CONTROL|.


For example, in a configuration where only two of the four queues are 
enabled,
some packets from *Q0* getting transmitted during the *Q1* time slot, 
and vice versa.

Furthermore, once the hardware enters this state, it does not recover 
even after a
complete ENST queue reconfiguration is performed.

Thanks

🙏 Vineeth

>> The queue_id field in struct macb_queue_enst_config becomes redundant
>> once the array is indexed by queue id, so drop it.
>>
>> Key changes:
>> - Drop queue_id from struct macb_queue_enst_config
>> - Allocate enst_queue[] based on bp->num_queues instead of
>>    conf->num_entries
>> - Index enst_queue[] directly with the queue number
>> - Program ENST registers for all queues
>>
>> Fixes: 89934dbf169e ("net: macb: Add TAPRIO traffic scheduling support")
>> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> Thanks,
>
> --
> Théo Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
