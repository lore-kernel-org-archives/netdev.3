Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694184E5333
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667673; cv=fail; b=cjdFHnWH9hlTeF32bMynShhhG6vGIVKGtHmkY5YZXQQh34X/ZcMZKFfNrtR4TsCyISIm/qjR8BZdV2NmIZs+YWKzwaN68YDBMtpykzcBioQNxus/esAs4fEuiEsKx7AuKq3gMLbAAEGUYU9RkCtyQbTow+zOjVXUYA1rZBJoFTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667673; c=relaxed/simple;
	bh=HMPJ6p2srMaYJzkLylL0+sZ0iIInJhiDNe8ggy4ChHA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fBMY46eLVja/e9VIlFu8Hne2AwWXlnSKb/dYXBaXWJIV8IbDZz7JXp7zCF5YjcPuoiYiKcRdPG0WrBNMekAEARMThlueiJvgHL9jUZhJwt69D6PvV3KtXRP5sHfaZ+qss3qIsHFiAuGBzVrLi1vns3br4vaK6e43Ky/AP9fZHLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JCgQPlDE; arc=fail smtp.client-ip=52.101.46.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JCgQPlDE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UA3zNv3TviPpAl22i/tzPwgZkgzoHrDKSPey9tSyyDcWTz7eeFH2ZKJvQ4A4ALj5tPRDgbUM0WfyAMpfhneZ30MXCYnmiNuwcKByy1UBpUWkbWAg0h5MocYoYw/9z9zLUYUNvZEYnBBhTox7YjaHetVy2O84kNR20k3WD21iZalA9PlXSuOeNta++mPCGDDk8xNt96URCZDoYExXsi3XROc9r/OEZb92sC/hCUw86eiwItOCHUB2tLQRN5zvPLXMAJjcPQ6LUdTUsVHGRkesTflVbO+dvWGMgniB0C8uIXtM5TiROOFjgDO7l26QkXpdQyawxiKhdm3EmnLaFh4AcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjWude0W83J2Ovp7kFmL4rouL3lRwloW/aysGhOnEh4=;
 b=aMx1C8+2mnLY5L5oo6zzVtxf53uQeGcITPnhE6b97x3wtSfyoS3sfjR0JxzcN9z1j5DNHnqrrrgQL1vkbwrNgKjR0n5bHD49lfs2oFqPbX/Gnz9DJClzmz98cN0blbOgd7y2hCq0iMDYhSlX3H1wfGnTs7p8RW1mhwaQ5h4CmHy7TasjugcxEC2nJJrgbRiIEeQCWpLVRUEeJHpYkgrDKI+RDQe7SJ3xSWyMBmsBxK/CBWNdi8Hi7Papt7OjIFjUk6bgNh9piMURmEz4Bs9caJctjTybkbScHN3a4YjYMhtJpE8ka22ZlTdJp/41W4AtDU+MY12iLjPuO4ygxRIixg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjWude0W83J2Ovp7kFmL4rouL3lRwloW/aysGhOnEh4=;
 b=JCgQPlDEQVsDwdRKBPkygXBSeGgluuUwS4VbakW/JdAFnMmG3t8dCpkfre0htSMBY3ucKpN2xDdrtJmTKbVZbIifise7FIyK0bRxYBAhtRt/+j1zb6/gPkzr3GeC9i2TZR7QduRzI/nYUHeyRkqsHpbLkW2UY8m75L8oB/lJPftxQP3ZrVSnqCofV83X0AXEFsX/4JzJ4dFHytBnKKMOIUS9dj4H5ENru7YuiObPSkNkJzlfK8VKDuYTiYlsEnUSrP94QNlGnpTMkzxuhMQjaWLBEEi9EgrFI23AIpJEjSfunpgxDoO2fhvXVhjVjVN8r8GIN2gbGr4LOFBLU21Kwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10)
 by SJ2PR12MB9244.namprd12.prod.outlook.com (2603:10b6:a03:574::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 17:54:24 +0000
Received: from CH1PR12MB9647.namprd12.prod.outlook.com
 ([fe80::228c:766a:191d:77b2]) by CH1PR12MB9647.namprd12.prod.outlook.com
 ([fe80::228c:766a:191d:77b2%3]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 17:54:24 +0000
Message-ID: <be27a1e3-6ed1-45ea-9158-479c3358f304@nvidia.com>
Date: Thu, 17 Sep 2026 19:54:19 +0200
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
 <1c767f25-fa23-44aa-b8d7-b1374627fc9a@nvidia.com>
 <20260917094101.0115277f@kernel.org>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20260917094101.0115277f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::16) To CH1PR12MB9647.namprd12.prod.outlook.com
 (2603:10b6:610:2b0::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PR12MB9647:EE_|SJ2PR12MB9244:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b7596a-f9bf-426e-af65-08df14e4b54f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|6133799003|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	+RsUES8V9ASt11rrOK5fWdrpS4O9sjGwGRxYbTGVeAsYH+rRWvtYTX2f8O+6aqG95Dj9AHaIHRlQ5abt+VE8o+nCTnxCHqH3IcuF76cQ6BZRNfXKtI59AXIAsQst2c+PToxLztEsaJfUZtq+1UZjETQNX0I1/xAfSaGXm22wGjXgruRnmgYXEPQDVeMMrqStkLy3w/paPEQHXd+pFSNBKRwV7eeaEC1VsHo1F7Cg/3awqwSOpf5MjokPsl6uNqlPBbILAzwdmfnZ94R/Q9aRNK9uknFmLvU4mxbP9kICqg6kbl5aSSRRru2YHGRU44+LZWlSo6LKVvoR3xExznIe6cSgm2/x3bnkBP2//Hkd14OOZhq04PLtizVYeW2A+rLOs4ZDkZq2zbU4TmOJUtk0DBrYbnMy3QuVt4dc025Zaze0D5zVxd8CpjrCGzqtseeFs4MY43Mvig0dnrk4+OVdrU6fCXeEpJVrck6MMLqGXVyYgh2N9ewD0xhAofRLOXfhw8AviKsej2YpILwwpcMseYYT4kibE9f/9d23JCUgcqzoOses2pCReLVuV+Az8ArERzHxDw2sd9rpq88AUwf/ksivKG1MkBTdYStv/DAf9M8P+coQ1wEti6MtTKvXGsf3+PPs8VKLeQMag3foeCHsuR1GLGncgwitFpfLCfluHCc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PR12MB9647.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STB5Q0hreEpxOU5GbHlwZGFHZ0E3SEZaNGpZLzFCZEQ3c3ZLeVRaNzdoSTlM?=
 =?utf-8?B?V0d0a1VtekxhNDIycW5RaVpHai9DL3RCQ1pRN1ozb3VlU0dEQkV2d3BHZUZN?=
 =?utf-8?B?SWd2VWNJckpCRnR6OTBBcmUrMnRROTZ3ZnM1ck9QSmZONkNPUUxjdmE3OGxJ?=
 =?utf-8?B?ZFVqdzFOVW40RmtOMXVMYWRTa1BhUXQ2RUR1QTREbUkrZzNDZ0YvRXY5dm42?=
 =?utf-8?B?VHBzSERyQzBuRmhwdFM3MURFa04yTFR6UHJNMk9NWE82WkJGKzlDZHU5WEtn?=
 =?utf-8?B?dEhMcURFUUdWS3ZaT01YYkZhejlJbm56WGtYN0hLSFg1bnVJWk5vN0hUR0Nu?=
 =?utf-8?B?c09QanRqNS9DdzRPSkhDKzBQYVBwODRwU21FaVVrZjFScEc1WlU4cTQ3SWFa?=
 =?utf-8?B?ZHNyYVI4RWRNTWNJN0FNL3oxTXI5ai9nankzUXhaOU42ei9JQmFxeEdwZ1RZ?=
 =?utf-8?B?WnJwL21YRTQ2SDVqREFyTUp1dmJlQlhSQ2gvMWRpeE8zNVZ0UVpMTTIyamM5?=
 =?utf-8?B?YTJ1ZjZrdmhsbXBzZkIveG85Z2RYV3FIbTFKTFhmYjVHbitNYXhvQUhBOHVY?=
 =?utf-8?B?VXh4aSt2eGFkMkMxODJKNWR3b1dySktTMWFmUFFCTWZqSzc1VmJTMVZGcThV?=
 =?utf-8?B?V2FscmdMVFMxVXo2V3NSWHJWVFZVREZFbHZTWU9tWHVkYUlGSkoxdEdXNjdF?=
 =?utf-8?B?MVBwM25Rbzc3UWcyRGIrZEdGZXFBcFAyMUN3aTkzeVNvcGlUZlhjdm9COWdI?=
 =?utf-8?B?azNkK3UwQjkyVUZWOE92R0RDbm9VNU1TQ3RZRFExdnc1RFRDRDZLdnFVeEdp?=
 =?utf-8?B?Y1p1QlJrV0EydEpMZW92NFJSMXJ4c0xOZks2UWtpNlBrQTZkUVlwaVNGanFE?=
 =?utf-8?B?WWdCUU5zWDJYdnVBQ2c2YlFyT1NmaTJPWW1iTExLSmhVTWR1TFVMRFBTd21j?=
 =?utf-8?B?TVRYcU8xOTRha09lUkZTdDhRdzIrbXR6cXZxc28zL3MrZjdJR1E3ZnVHK1VN?=
 =?utf-8?B?bUUvaExyZndzOGhWQ1IrT2tWRlhkMGhsSmpaOGRVMWFqbC9NK3UrWUV2MGRt?=
 =?utf-8?B?Z0RZYUpCdlN1QUJiS3gyWE5WbWloUFVpb0ZoNzVvYjEyS2NGVkxqYVpzb0hT?=
 =?utf-8?B?eXhGWVRrSExjMUhhRGUxYmQ2QmFQZldLMjZHZHptSFMrWFhFSk5OalhHRk5O?=
 =?utf-8?B?SkJIMmFmK1RRNjZtbGorSzJHSlJ1ZytsNDRLbWt1amFQSXNrbDQySmlJT2VD?=
 =?utf-8?B?N2pNbVora3p0MTg5R3pra2F6QXpldWM3VS9xcGVhMFRGcWY0R21FR1Y3VTVp?=
 =?utf-8?B?OHU3MW5CN1JFY0tHdm9mUHRERlQ5NXIxa3BlWFhaQlJienRUVXk2eE1YYXZu?=
 =?utf-8?B?QTZhM0hiSUNnWmE4Snh2NlZ0K1RBZXQwWTBtNkNmU0ZyMkR0MzcxRzErK29t?=
 =?utf-8?B?Lys1OHZ3cm90NExadkluRitGQmc0NFVrbkwzT2ZzeHhKV3NTVkVlSUF6d3c4?=
 =?utf-8?B?V0ExTXRPQUVOVWRaVHRMTjBLditqQklqVUg3dThiaGV3d0FnU1UvakhzZVZR?=
 =?utf-8?B?K2xlc0RTM2ZwQWZvdHVLY3J2Z2tHTVRBbVJEaG9QVWZBQmFQeWhRdWlzdXNs?=
 =?utf-8?B?UDFNeVlGWWpiT29DL2Nnc0dmYzAxcHVGdlpRS29GNk1aUFRiVWR6bkFhWWlj?=
 =?utf-8?B?YVA2T05GYisxZDgzcXRiNHJqcmhReWNLTmJoSEpZSnY5N21sWGQzSWRCc01w?=
 =?utf-8?B?eGtkcy9UTHBlaWJWSlJJZHhpVHJTWjNiVkJXcmg1MjhKUisxUHRSeE93bktj?=
 =?utf-8?B?ZzdFa2IxMUtRTlRmZWFlelI2TXJKbzIzZWhKekw1eGFPYnBKZEZiemlISGhv?=
 =?utf-8?B?LzY4TVEwRWh1OUt1dCtGbHJ2NDVuNlR4THBxc1h3VHoyOUU1eHhYOVRzNE1t?=
 =?utf-8?B?ZStJcDBTd0hRalcrWjYwRVZZWmtmM1NKc2hxZHlUOHU4VHEzUE95bnd4Ynl3?=
 =?utf-8?B?K2J0cHVpemVPbDhjNzlTQmtzdm1mWU9VU3FIM1BSVmU0K2NaeHJ6N3dTdU1Z?=
 =?utf-8?B?MmJWbm5vTnF4ZGs5ZDJzNk1aWTVkWDI1U2FmbnR0b0pKRVJhR1gwZkJpMW1Q?=
 =?utf-8?B?ZXJrdXVOUk50OHJZZmFBN0lkNEJqS2dZaGE1VVRhTVlkeFFZcXNEOHVxMGVa?=
 =?utf-8?B?OXBKZ0ZmSU1QV2czK2ZUankxK0Zyb2V4RUw0NmlRb1lRYTZ4U3B0V0orLzZk?=
 =?utf-8?B?TlpSMTJQTlJmQmdZNnhrajBBMXJSMHpsZy9lK1VabHk5MkI4Z2hjcTAzWE1o?=
 =?utf-8?B?UHorNGJjM3ZYajJzUlJpYllMRjVucTAyb051R0ZwOHlabnJsdkx2QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b7596a-f9bf-426e-af65-08df14e4b54f
X-MS-Exchange-CrossTenant-AuthSource: CH1PR12MB9647.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 17:54:24.0433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QcPlRjrtRivyv6fUzA5vdbNOOtIhWCbkwX9puyrcF8UTW5SlPGVJZxP3Yc/yvISKWs/PJazzZFer7z7gWdu1ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9244



On 17.09.26 18:41, Jakub Kicinski wrote:
> Hi!
> 
> Sorry to re-heat an old thread but FWIW I enabled HW-GRO recently,
> to get the zero-copy tests to work, finally(?) And it increased
> the reconfig time by ~2x :(
Yes this is a known issue: each ZC ndo queue cycle triggers setup and
teardown of all queues. We want to improve that eventually.
 
I think in this particular case it is due to ncdevmem which takes half
of the queues during probe.

Thanks,
Dragos
