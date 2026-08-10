Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012062.outbound.protection.outlook.com [40.93.195.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978F9391E4E;
	Mon, 10 Aug 2026 10:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356725; cv=fail; b=pq36fpOftDML9Gu/CGSL5rEMZ0sJr+HZp1UnoNkgoJRK/0TPAIn9y6IKFPel/OhqLdCbHjO9clRfsEKopZMcA/3OeWNJNgYd5gQELTNHlZSYccqzLPPpMS6WNmm/I783tTVkYINtSic5Nt2VTmkYFaaUZKtL2o8JKdu9Xquxi98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356725; c=relaxed/simple;
	bh=sBG2zEU+sAYpCagpWRwXLDkz0fLGyT2mKIHHuWNAr5w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gt7mfOU7JqRYaH00XYebCqzw0ydKIYuXRw1BvRcuOzmjuV9QXcpqXo9ipSdNHsTnTXjFIz4pFtuKg6SyO0qnq4yWyRUvTXnML0SZ1gmqgzBGOwJK1ggr7EELLGDuzwwDuxwHrDpCJKsqCFftjMENwjqn2zZmRbep/rTT4GnGM1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xU8+gLCo; arc=fail smtp.client-ip=40.93.195.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xU8+gLCo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHWdsn4XTVkQLr9wxvVWyoKk1dD0z+FAU+JuxTZaj1T5Por8ysOf9eV5NCeMpQM07bHJ+Mr2gdUUwsLqeMDdkfLWnS9PPbLi3cYDjeXfrmjgfX3OR/RwykmrWWJ0svc5PuLovgdjPqx6sZQ8rgdglPD/0pMAWVRBui7YN8r9m+tbKu2b5H/K0IJEJTyy6IltZFFAoKLcoLXDRLjQUf6NzVpNYRqDx6ilVZMjH+/l4JRDpQ7kWSnl6zVZagis3VXbvZhQqybrVEjMVcRMlc51TGejNdp+ll9Mx8TdGyk0nFS3uQZcpedjKIHX+D+jVrx4R13V+rTLrUfiwRdQz7a7qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S32+DmfDVOnctBELJ92n8MlM6rvArjDCGIwhGrnLykk=;
 b=MDlUXNOBzt4em+fM5t7UN8QeJtcX/BrlwigDoFMg3ixMVhyZby98Lu8DXqNg6VYjDU662zdcfdcMjDPFdin1Tc3/vYromzDSB38CQzSH/EwL2o+Vj7ssADVYAOge9SOOdHYTKQZwSYmOusQf2B/OptZKGdEjBtam1rrdP0KdZOTXZGKH5gHvNRtluRnURvFG4Uwa67lXfTGl4AFZ+Kv1AfBC/E/lfkTm1lO2nnabob9Q9IyQqie7bwMLAE//S+8jz96X3mEe9d0COmVjCHvF/ZKRjyMNeMFsUEjV3OnRdwpiruO/2Q9Vlzwie+7Ishz/hzbj4w5Oa4Q8Y9xDgPuhKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S32+DmfDVOnctBELJ92n8MlM6rvArjDCGIwhGrnLykk=;
 b=xU8+gLCo7AWRkMQ3ctH29f3NoCgzry6cnRkqaGtDMtAxrX3mvloXXVDkjvaM6Py+YJssbetkeWXArqNrR713tSAIOaYno5YSKjEjYqzZkIdHHgznPrJxzx0RMLgYcd6q663XXsfSNvYEgBtk5O8yu0bWkMftz0IvOw/2DtxOo/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14)
 by DSWPR12MB999129.namprd12.prod.outlook.com (2603:10b6:8:36d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 10:12:00 +0000
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b]) by SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 10:11:59 +0000
Message-ID: <080ab679-cd69-48ed-b96d-c515741101ba@amd.com>
Date: Mon, 10 Aug 2026 15:41:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] net: macb: Rename MACB_CAPS_QBV to
 MACB_CAPS_TC
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Conor Dooley <conor@kernel.org>,
 Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, git@amd.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260807095012.640223-1-vineeth.karumanchi@amd.com>
 <20260807095012.640223-2-vineeth.karumanchi@amd.com>
 <20260807-juggle-porcupine-71281d2d9041@spud>
 <DKIX8UXQE9AW.3V3Y8P4USSJDR@bootlin.com>
Content-Language: en-US
From: "Karumanchi, Vineeth" <vineeth@amd.com>
In-Reply-To: <DKIX8UXQE9AW.3V3Y8P4USSJDR@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::17) To SJ2PR12MB8953.namprd12.prod.outlook.com
 (2603:10b6:a03:544::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8953:EE_|DSWPR12MB999129:EE_
X-MS-Office365-Filtering-Correlation-Id: 3161e144-035e-4f3e-d86b-08def6c7d093
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|18002099003|22082099003|56012099006|10067099003|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	kUNHRDzxUNgcgLW+D3Ws+DI99tBvidCJqQLwO0PqWRH4selwlsqsqT+etXK1fhKyrl9muaV1vjRUZq/zW/ajKSXZxp6z3dZPJLavUl64f/62ZmgFAnMlu4uCx+HdLJ2/buiX6qNqkRTTBsjXAGfBLA7YE0hSAU9vWza0oeyki176mHR63iuf62IEs64JLF/I4ruJlJacLg5wPj9wsvTKguIMOPV9cG+8sXHAgOhjpy4RKUYA6zacF0PxEtZI2sJ/lkkuRoQkoTOGrBLL1c6dlmfyDJKpJ6jVL3Sa+cNI/12WZa6wuzR3pLgqSjvQAc8coRJuJnbINE+JRek1CZ30axIPQ8ZYET8ywEdbWURuz0mGNe5hlswKpnZ0pWAYxEdLrl7ruhiKjkgQE8Dntsx2v82Z36sybI6uAhGxDpOuhZM7rEpWI5fiO5isnBmRyKBSQ/bozbWIpLHmhjZgJzyZtIWutFlNtnl2bQ1/sjdCVTSogtIOm5i7YHeP6XFXBE1DBeMycXcQh6r4u8zJ8lqNfzAQqNtZX63DFd7apd8HNxPZ6ij2Rivp1Yi/GAicW4UXd3SLFj/bRJ/cCIktLiuMet2HyF+uBQWIefTYos+ht3Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzcvSnkzZCsxN2M5TzBpSC9lQnoyLzh4L2h2NVR5MlhtdVJEYVp4YkFaYUc2?=
 =?utf-8?B?ejNUSDd3N1FKamthQU5ScllNeWM2L01TOEVwWHliWlJ0Q0IrZ2poa0h6c2Fx?=
 =?utf-8?B?TWRnb05pVUs0OWZxb1ovenZkQmVTODFROW5OOEpQZktBK29lRWM3YTY1TzVy?=
 =?utf-8?B?US9YRmdJSnQwV1l3Q1R1SEZjZDJQc0RlaG9oWlo5SXpDd1lmeEN0Unh4bVlV?=
 =?utf-8?B?Tjk2c3JBRTJ0TUEvbkFBZXNiRU1YQk1HRWt2QVNKc3poR0tvT0dRbm5ZMUk4?=
 =?utf-8?B?amE1a1FlR3RNNkNxakJoYldZVFBBYXlmekgvcFJrd2toanloV05KM0kwMExZ?=
 =?utf-8?B?eUN3dnJFeitZR01SYUNyYWQ5akhDWXdZQ3RHUncrR0QzVjEzMlhuZjIwRkx5?=
 =?utf-8?B?ZFE4ZmwzS0dRWkR2Zzc1YlM2UXNWMXhHUzdTTE9vWmozUVZiLzE3NHJQS3NU?=
 =?utf-8?B?WUI3RDlCU2ZFRkhQTmNsRWZncUNMUVlxbkhoalVwU3pNREhubG4yVEJTSXlH?=
 =?utf-8?B?TzZHdmVGMDdpZVFwOS92S1hBWG1SNm5TUmJUVWt0L2Fqb0gvN2l4NXRDbktQ?=
 =?utf-8?B?aFNzeVZFclJQWGNlL0dZU1Y1S0J0QzJtQytBZUVudFFVd1cxbkxYcWNneThV?=
 =?utf-8?B?RkhFZzY0RnZ4YkN4dEt1MjB0Y21sZFd2UzJ3ZkcyL0dEOWhsYUpJWTdYWlZq?=
 =?utf-8?B?VWU1MWllWjlyQnNMK1dXLytpK3ZSRGxsalJwZEZwUStSeWdRZ0dmY21UUWo0?=
 =?utf-8?B?QVo0Z1F6UFRGQjZhZTk5ZFhOTjJxK1IvL2FlT2dmQ0tKRVlVR2RkSW9aQTky?=
 =?utf-8?B?MWVoSTZTRWdCS2kzbk1UMGF2NkMwdzdIRUlsQVl1YjNSd0RVcUxQNFBKNXJY?=
 =?utf-8?B?cEoweGRZWnAwRHZCazY2SnYwSk5NMHhaWkVncm9OV3pUN0hSd2JCQUlYR2hs?=
 =?utf-8?B?bWtsUSt2bjdkUGxEdVVmSENBTkRxY3NqYUthVThoY0pEa3FlZ0Y0OGRKU1RO?=
 =?utf-8?B?MmZwdldkdzRSSUJkMC81MjVTNkpoSXJlQ1QrWC9hajJtbDZFaXY0V3ZncFFo?=
 =?utf-8?B?STlxUllaYXZtcm11eUJXcXJ1cTd0VElyM1BnVlRpc3ZESi9qNjFhNmdUWmtt?=
 =?utf-8?B?TitKNlROdmJ2d1JWTzVYcXVaRzUvajJTVEVnQ2xJS1ZZRWZFQWhzaGNGdjcx?=
 =?utf-8?B?VHNlZkNrcTJZRUIrZ1I3b3lnZHVSa29paGp5U3VtTUFValQrV0hhajF1NmZG?=
 =?utf-8?B?eTlsVGR3U0RTN0UrODloWXkyckp2bTlVV3hDNzg5aWNoRUlqSW5Wd3gyQlo0?=
 =?utf-8?B?NlJ3amhJd005cFh1RlhNNGF3U2M2RWd2dkIzMjg5Nnk1a3A0cmFEOG5Ma1A4?=
 =?utf-8?B?M1lmaTJnZ1FHdUs2UW11dTN2T3RKK0tnb1NCVGV0WnBaKzNuZkEwWEQxY0tP?=
 =?utf-8?B?NzJqbVkxTFZnNCtwT0IxWXNPdkhQR2JlK0NZa0RiVXliRmZJZ1hMMk1mQkEw?=
 =?utf-8?B?SmJMcE53bzVMTnA5MFNmVjhubDZ5eVBEVklxZFVyaHk1TmNrM2RMQkFaSEVj?=
 =?utf-8?B?b093OWo0a0gyMTBCbUY0c0tiUHhBakdJM0VRMkhMSVhTUEFTdnErWW1QWjhi?=
 =?utf-8?B?eW81UWRwNk5oNkxZbndzVFhWdG0yUlA5Tlc2Yzc0ZDFSa1cwSEFhSHJiNWcx?=
 =?utf-8?B?alpnSys3U2o2eHdMdTBGbGVhRjI3YU1UU1JqeXFGb0tTZEVmaE9lRjJ6NmFt?=
 =?utf-8?B?bVY3K1duTVpCYkoxRXI1V3lxdWRYOGFBM2JWc1YyRUtSWGkvbTdTU2VJbEw3?=
 =?utf-8?B?eUd1d000RDM1L2RhNkR1L1phSXk1cXd5MWZQaDNJS3hpOTF6MHVISHV1UktK?=
 =?utf-8?B?YSsrTWtlZVBEVnpFUUZWb2Q2WkpYamc2ZUZiS1VENGdrTSttaitYWlFQVEFT?=
 =?utf-8?B?d0UzWDJGTTNzeldYTkVkdWlTVUJNUGg3ZG9MYm1wM2ZjcjBSOHZuTUo3TlQx?=
 =?utf-8?B?ZVRmTGJ0RDFEWk9DTklsYWlqME1jWUdDRHk0NWRmayttU3hOM1pad3RseFlE?=
 =?utf-8?B?bmhsYWNmOHRvTDdHbjBTSnNpK3MycUM1VEhDVFZCd2QxTndnWnJJUXlkYlhQ?=
 =?utf-8?B?MFZnRjErbFl2bFJQTW1BcjBxa1NjWC9jWVZpUmJHRENXVlo1b1lPMFI0OVJH?=
 =?utf-8?B?WlVKT0l6VFpCVU5vM0d2SEo5aFA3Qm1PSWpkNEgrdThHZUNZb1FVSFhvSGgz?=
 =?utf-8?B?N1c4N0JYMkVTRzQ0VWNxaEFEQkE2YmFQUHFld1VvNkxiQkJIQWZtbFlTLzV6?=
 =?utf-8?Q?2aa58cDdP1CKeFsYKQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3161e144-035e-4f3e-d86b-08def6c7d093
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 10:11:59.3078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHTKC9UPbRdxJQ7aR3pSKneRnr0k+GpGIZ+DLIl3QlRzaRXYkeOuvmbExhwHujiD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999129

Hi Conor & Théo Lebrun,

On 8/7/2026 11:56 PM, Théo Lebrun wrote:
> Hello Vineeth & Conor,
> 
> On Fri Aug 7, 2026 at 7:09 PM CEST, Conor Dooley wrote:
>> On Fri, Aug 07, 2026 at 03:20:09PM +0530, Vineeth Karumanchi wrote:
>>> The MACB_CAPS_QBV capability flag was originally introduced to
>>> gate TAPRIO/QBV support. However, GEM IP versions that support
>>> QBV also implement multiple TSN clauses.
>>>
>>> Replace this with a generic capability flag that can be reused
>>> by other TSN features. Rename MACB_CAPS_QBV to MACB_CAPS_TC to
>>> better reflect its role as a general traffic-class offload capability.
>>
>> I'm not convinced that this is broadly correct, whether or not there's
>> Qav support (which is what you're using the newly renamed flag for)
>> depends on an IP configuration time define that I think is independent
>> of whether or not there's Qbv support (gem_exclude_cbs).
>>
>> That said, the only platform that supports Qbv that I have the exact
>> documentation for does not disable the CBS bits.
> 
> EyeQ5 instances have both active qbv and cbs as well.>
> I see two ways forward:
>  - MACB_CAPS_TC aggregating the two, coming from match data
>  - split and use runtime-detection, see DCFG1/0x0280 bits 1 and 24

This was the initial plan for the QBV implementation.

Quoting from
https://lore.kernel.org/netdev/20250814071058.3062453-3-vineeth.karumanchi@amd.com/

"The 'exclude_qbv' bit in the designcfg_debug1 register varies across
MACB/GEM IP revisions, making direct probing unreliable for detecting
QBV support. This patch introduces a capability-based approach for
consistent QBV feature identification across the IP family."


We currently have access to four GEM IP versions. Across these versions,
TSN support is either fully available (including features such as Qav
and Qbv) or not supported at all. Based on this observation, we adopted
this approach for capability detection.

Please let me know your thoughts

> 
> What I like with 1 is that when reading code it's easy to see what
> platform can use what features.
> 
> What I like with 2 is that it's less churn overall: no modification of
> match data once support is merged.
> 
> I guess let's go with 2?
> 
> (I'll review the rest of the series later on.)
> 
> Thanks,
> 
> --
> Théo Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

Thanks,
-- 
🙏 Vineeth

