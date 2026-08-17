Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9393BFE5D
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 12:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786969925; cv=fail; b=M+4qHvtO95pI8pMyXdu+7VBPOJZ6DYtfOJcTRy9ih7+3XmxO7lWwOX7w+B+8CDwbyq+CvF0/KXbVsYucITIMw+RoOoxhhJ/Sf2XsE/eHLugmzBk2FlkjGEOrBGhZNDMALomTViAoigHKtqBbqy94soBC7e/cR0pX27u0oCPB5oI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786969925; c=relaxed/simple;
	bh=9FGOeovU4CnrOAFVMPA+SoNaQdcPxOQTZpMmPlx4aI0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qfmzFZNvE7lO45fB8P6MAksbo/HjXqgSo5bg3oCgb34FH4ZsyPt6+BdL7R74SPoGt3JSeedt0/FEGE4Ci/qqVpO2YtOObNC0TW2aeuseFLQOry+1fC1O8OjS4xjsHUwfmoH+fqSj80lwRBYbXto/qbMAZPSoBEuqR3GQ4/0b+Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YjoVE6vW; arc=fail smtp.client-ip=52.101.43.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YjoVE6vW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QARfKOBCPEYUeBr8Wke3JdyLv2SHt+/CUNnAl5ux5cvkSWRrZ6E3sQe7JDPlDSsPITZX5iofE5rteiICza+i0AzocXv2F8sERnAbkrtd5RjWw+ZMPsuDoIsd35olA5IgleqAJQLkLpw1kUciiLdxYkgtEUq+7br8KwASUzgtjJjStC3OHuRmhcCcYtVgUOCTaHgR2Qt6ayzGoW3SH4uJavxkVioxqNz0Qaq26ujga9MoUkxO64MZa2bQ62RGxP8Iku2Hu//r2v+gHJ8Cqgxc5jEcMO42ve0Mj10gfZdeeiyzHdMw9B7WHUh2LYTNKo33j5N3qe/tj9COzOqxbDIiwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XiSdDwvsl72aQ4LHMEhIAP4Q7DyN8OcSXUR/vz2izY=;
 b=SWPlEfbwugaa3jheG9i8RVQe4sWf2I4yRi8iUtdICV0RDvU320RQ5jmaOSWknz/c672tmvrrjHIVriakpHCrLr6qpHo4IvWfVhtP6LW9i2wjqj05CHTRzu23tDFysAupurUK1eRnoWKb9lAERQ+8OSnptA2n1W5jyNs6M76Fx9kqB78i+nRCfAjuXz9WFvxzAmZqIouJbk1fIbTCeXXpS+g8RDAfIofhB91CPa6IgFwQWk6ZEucZuTYjrLqqYjw2koV6Ll0EMWCNHaIRg4XSnL2uUXA5BZtbDqtoU0yyFjWF1QriVtUvE1UHzG+mrA7bSnVjV9AFrTEtIHgljBhkcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XiSdDwvsl72aQ4LHMEhIAP4Q7DyN8OcSXUR/vz2izY=;
 b=YjoVE6vWDo44PW+fG4MtwUj37HAsLpCSX8Nl+m/Y7Vks50QgqRvAIADykZ5J7ABrGvXd4s+RsDLvE4Y3Dj388NsFjpcIkNakSxmAtmwlvE1BGrfCvXJitgrC8cUuIJPNw0ADeWhIXQYvN/CHn1BEuMxwr+ngokzdrXB+K4/zF9JPFS3KTNOHJ6XhQ6Z5MQk6++SvL4mo3xmnMFI+cYatRVvwJLcznjk8c0b9EbelNuYMGdyq7P2sQqk1ADbHNM9SAhpsiO3M7YEPBTRP8cjpaPZfol0Tra6MouNzBgJ9n+55e2hmx3+5XQ02jq8EtVKi9EjoFsIcFsXGyv6m4j1/lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by PH0PR12MB7907.namprd12.prod.outlook.com (2603:10b6:510:28d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 12:31:59 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 12:31:59 +0000
Message-ID: <1c767f25-fa23-44aa-b8d7-b1374627fc9a@nvidia.com>
Date: Mon, 17 Aug 2026 14:31:55 +0200
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [TEST] CX7 timeouts on reconfig w/ page pool failure injection
To: Jakub Kicinski <kuba@kernel.org>
Cc: Nimrod Oren <noren@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20260804094518.53b56d24@kernel.org>
 <7caf12fd-f63b-46f0-a5bd-e9887cb25f9d@nvidia.com>
 <20260811080433.26f404dd@kernel.org>
 <8aa8c49b-736c-42b3-92d3-26bdfeb90a22@nvidia.com>
 <20260811103832.28e5c8d4@kernel.org>
 <2d2aab62-a4fe-48eb-94e6-c8a0ec910ee9@nvidia.com>
 <20260812095947.3d0e6ca6@kernel.org>
 <a0b4e051-546a-4950-8dba-03391bcded70@nvidia.com>
 <20260812154101.72b64936@kernel.org>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20260812154101.72b64936@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::18) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|PH0PR12MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: b9a61bed-d6b7-40f5-e744-08defc5b881b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|6133799003|18002099003|22082099003|3023799007|56012099006|10067099003|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	klIy8NTLUCVbLSKn/qbNJ3qF5KBnE/WtEOM6mAdtBvw3/hmEeFzTdgTODvrQ+p/QMF4uvRY/3//+UHWLKHloy+tkBeijnhJ6Y6Us33lZ8aejHgloai7zzqRkTPOUnhKWctp/KgjEFEcHADfoE/AMUQ/CgRUAAGC42SFG8MAujqKLQOmkruzjz+E3g3BzEwIDOYUOQK7o1Lz9GKPpakDenYJqIjZzb4bgcGBrOXR5opWewCRg6kaWo41bVr1mtHtbE5WZk3wM0BMfVLKFd7K+5yDZd3joQCYf89wkMUVnPqfkmbLpGL69tZd4bDYtcqCpS10eiAtCgCZay5K9ARCOgKwbJzt/YpvOJOe77Stpe/QCUsjgrMVrwNs+glG73Cs9IXo4myVdoW/M6/etD7L6ZatSt/IQbXyHpT9jmt1NAGpARlrp4F2KPj/YSd1groQ7ztPbnfUhQjlrqrtDpBkxDTgNFJWO+hAoQpdbdYiyV6iSobpZ/l1apr8eesOyP/kgR1qAqseQbewp7TmwHTrs4YwvjiZj3Y/TRmKOE5QLYh1mYbtxLbVj7nRT/mZTl3Xls5QPe57qGG1Y0MxkQnnlNhAqjfsem46XmZZ8vYATSq0aJ/wxWBXg6K0olGkzJ2Hu0l0KEvX8DYJON2XynIAfQyXZJ2QTMhP/LQ1YBbCkgB8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(10067099003)(4143699003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1J6TjBqTVF1TXdzNFJGQklmWi9DZkpzTC9XR2d2c25KZGd5WWZOQ0VVeFVR?=
 =?utf-8?B?QmV0RXRiQXZLcWh0ZlFqS0ZMcGtkS2dvOHk3N3U0UjBaekY0V2xYSnd3SU9S?=
 =?utf-8?B?VkpIV0J5UUpNenpKUzR0RFJpMDVPendYOFc3T2lweDNTYVY0eE16cDlvdlFm?=
 =?utf-8?B?SzljZWgxU0tuWml3dDUwV2VJbEhyT3FkbUp6RVNKWVdJSEFwRzdRMTAra2w2?=
 =?utf-8?B?dGtiR1BYcUdjdXNyRDN0dUZZbmlPZVpGMzlXZDdpemxuV0tZMmhSTnNhcFRX?=
 =?utf-8?B?VTRuVVNEU2xvYU9TMnpvSXBwclQra0FtQVE0UTdrQVNqQzV1eU1MamZoKzZD?=
 =?utf-8?B?cGxOUGVVMWN3Q2JwLzN6RTVYZnFpczFNVDVVWThWanVhcDVlWjhkV0w4Q1M3?=
 =?utf-8?B?RDNCY0RkTjUwdk1DdFlHVFlUdnEzSE5UUURiS3hpMGJiWmFZdC9FYTc3eDMv?=
 =?utf-8?B?S3BUYlZPY3B5WGFXNkpGOFB4T2pzTVE1dXN4S2xVejdlRldzdWprK1dYbGdR?=
 =?utf-8?B?ZDNFeHlvampCWmV5SXF2eVVZNk9QcEh3V1NZQ0loM1JJSS95U2tKMHJJMmJP?=
 =?utf-8?B?MzZUKzdLOGx3QUdNZ2JHUjFhbjJWNE13d0dmTGxidUlEOEo3RGt3WGgzZTNr?=
 =?utf-8?B?NG1SamF6Z2hnNk5ZTzBhOTZtbit3WVZUSit5RXhnVTR3STFGVnBmMDNWYUtx?=
 =?utf-8?B?NnlwYjM4RVBRVVBBQ2h6U0hZWnZJeWxKb3BzRENGQmJEY2pTOS96VDdoem91?=
 =?utf-8?B?eXFYdTBlWWpzZjdTL0tKTzhJQjg1dnprVmlHU3BhMXlWUTEzUitua3hMbnN5?=
 =?utf-8?B?VnJmTzRlMDQzK1NvUFNVdXR5RHBFeVozUmV2L04vZHFCSHFGU05tU2ZqVjlz?=
 =?utf-8?B?UjBMMDJVeU1XSkFQQlp1R09ubUxDWEFwUXZJcy9UMVYvWE9QdmtjSUhmcHVS?=
 =?utf-8?B?WElsd2NQcG1tcHJjdVhQNG4yVEZoTHF1NStzSDRyWWtoNmwxb2FDOWpRRHlr?=
 =?utf-8?B?V1BxYlRpTlgyc2dyRFNIMTM1c2ZWK2FZV2ZSY0k2VGdSeXNON3VxWU1RNzBR?=
 =?utf-8?B?N3ZKeXRvazlQeXFHZ0lnMk5FQ2hvRnZiOGZ4MWM5MDhDWlMrZ1RkeUpEcnNk?=
 =?utf-8?B?V0xIK0YwYWc5L1pXQzhJRnlzc3BuSTl2N3V2VjJUQzJ0NEd3M214OGMrYnV0?=
 =?utf-8?B?dmw3bFhPN3BKaS9FVzExd2N0RUlCVUJlQkRGeTNtMmV0STNCMkVZd0Z5Ulda?=
 =?utf-8?B?L3J0a3pNS3hoMjhZMzVtaEs0SHdKTlNlS0Y1NkJnRjh1amhkdUhNbW9UbGVN?=
 =?utf-8?B?a25xRzhxQjNxYkZsU0d6YnZpd3lKa2RQT2xyR0xhWWdTbDdIV1hUV0RvWnl2?=
 =?utf-8?B?QXV6YlRVUXBXSXpLTkl3MVBBemdFTnNyUktLSDJqeFJJeGdSVFBCeWxjbGlW?=
 =?utf-8?B?anNDR29YQnNrcVJCVTVXUXVVU3lQbTUzNVVuVC9iSnJxTUVJVzQzeDlZaUh5?=
 =?utf-8?B?YUo1bzkrSE9GR3ZscmZ6ZGViQnNuMDBtQjlZdUNXbkd5TlppOEhtRm1Zb283?=
 =?utf-8?B?OXdmNzg4STdiWXNJL205L1djaHg2TnlWc3FnWXJ3YnJtbzhhT0lkNE9iLzNj?=
 =?utf-8?B?QjZYU2xHRThGSWw0TEI5V0tVaVl1eFlBcjRWVVczR0FxbllzWkpWWDZ5U0RT?=
 =?utf-8?B?WVdVTnRtVXJ3ZEc0TFFTTUQyZmtUQTY4YmN1OUNaaGdZR3R1OG9JVXBBNEhV?=
 =?utf-8?B?MVNVdDVwaEpjZnFxb3RDaWNzbnNJWGN5ZXZWNTFENEtPMGdXejFDeGlKTG1Q?=
 =?utf-8?B?b2I1cm8zODN5a1lJYUQ4UGs4N2h2bW1zanhnVno1V0o2V2RRdENqNnFwVnVF?=
 =?utf-8?B?QlZvN3RNQkR4bkpKU0M3N3AveStaRDJ1S1ludlQ2OWhNTUJFYU5DYzVGalFy?=
 =?utf-8?B?dldyQ1lkMzdvVmxId2RkeTNFNFI5MkpkRjE0cWRGNCtKMjBiTVcyV3pqOHli?=
 =?utf-8?B?emhPaHgwZGI0NzZ5WWZVV2kwdFJoSzQram1MbGVTeTJLMW9lbTV3V01veUZK?=
 =?utf-8?B?WnhwS1lLRHh5YVNvNlB3d3Jka1lyY3BvclphaVVWS2l6OGZhOWxNN25mVFRR?=
 =?utf-8?B?a3F2WUYrYzY4NW5ZTlRjcHdOaGlxTm1FaVdQa09IRXRuK1BkbWR4OFArcERR?=
 =?utf-8?B?SGVuckNmbEZGeG8wZUF5Sno3WnU1eEduU2Y2czhIMVhTVTE1czhpSXlhSlZx?=
 =?utf-8?B?alJsT2N3L3RhT09FTy9iYnVMSm40aE0xN0JZd1hkSUJ5WWswUEFTQXNIa3I3?=
 =?utf-8?B?U01KY2VJenlJNnBlOFhHTHBjRHJ1dUorRFFkay83SUxoNFR4am1adz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a61bed-d6b7-40f5-e744-08defc5b881b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 12:31:59.1250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybEDGxqNhI6XWxHc0Og5mOCAXqDTrgi+3U2jvNYBm+VmhNeJSjykR95Z1bbLR3b7Su8h1RklKWfozuzjvRZMow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7907

Hi,

On 13.08.26 00:41, Jakub Kicinski wrote:
> On Wed, 12 Aug 2026 21:48:31 +0200 Dragos Tatulea wrote:
>>> Ack, I'll send a patch to bump the timeout shortly.
>>>
>>> That said, the page pool warnings were probabilistic to begin with.
>>> And they were hit in page_pool_unref_netmem(), I think _some_ bug
>>> must still be there?
>>>
>>> IOW mlx5e_page_release_fragmented() is draining more references than
>>> the pp page use counter, that's not normal whether some command timeout
>>> out or not.  
>> Yes, this shouldn't happen.
>>
>> You mentioned tag net-next-hw-2026-07-03--00-00 as the first where the
>> crash occurred. Do you know if it ran before without crashing? I can't
>> find older data in nipa. And there's nothing that seems relevant around
>> that timeframe. I'm thinking that this issue could be older.
> 
> The data should be there but I think there may be limits on how much
> the DB returns. Anyway, querying directly - looks like until ~june
> there was something missing in the kconfig so the test was skipping.
> But here is a June 1st run which passes:
> 
> https://netdev.bots.linux.dev/logview.html?f=/logs/hwksft/CX7-dbg/results/672642/test-outputs/35-pp-alloc-fail-py/stdout
> 
> so either it was running and not crashing for all of june...
> or our crash tracking was broken in June :)
There were 2 corner cases that were missed by the last fix in
the area regarding handling of XDP buffer geometry changes
(fragments get deleted):
- napi_alloc_skb() error path. Probably this is the one one
  that triggered the crash, it occurs when injecting an error
  there.
- XDP drop path. Doesn't make sense but it is possible.

We have a fix in the pipeline for these.

Thanks,
Dragos
