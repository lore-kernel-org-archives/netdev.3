Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011031.outbound.protection.outlook.com [52.101.57.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FABA39A7F0;
	Tue, 29 Sep 2026 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675364; cv=fail; b=d2HtlORAfcUogTCrNCFTzFE6wqnt2YBB75wF5G0qSGDDMRFdt/ZX9pxvA1SM0PvpOsU4yl1/dt6q+IAusY5TwTtXsfWjy80kumW/hQXwcrvgaJBfswjHTFKcaQsSMKuQRG+fRHlIgmSWblUnnF0+kJa91tT6ItNFBWK+nOLezcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675364; c=relaxed/simple;
	bh=xDRq1Z9aXD73lrmA0tfoEy1H4DCncsI4SBruyWxWKBk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nyrzVbzVC6T5ea8o/aJWTMzfX+8RDUtzj3oHOCjFioooy04gDp/IB0ogTPyOJ9FXlWhQHIlrXNc8rWwsrwgQBSQav0Dw1fNKfUh4wfCE+FhKRnhIfQNNbD4jMS5b3gbI7XfSzRmA2aJR7X1XBKw1iLEZxF7FOvMpJxwAH81TfCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tF/jl2Oo; arc=fail smtp.client-ip=52.101.57.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tF/jl2Oo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bma2cpcMmcGGlt2/ZMuCnJBrbQIgLFs0u7U06auN/LoXPFaHYoxDQ/zcwU3WtU5PuYYp94xZ0yRkVO5FSCRMWYHSbO7HtkJRPdn9OgqXWQbhq9KSG9dkshhBeKojNxbYXdA/0cdEI8+XO88ynbLleqe8e6/UL4T/7GhsS5UVEeutLHcenbj15/NlP4pgqzK5NoQrzx8svidE7+EuhVWVN77JW1Arkw/oDHQnElI3sSxE3Kwbfdr83SwpapgPBTo4InV47f5S45dvApLxYyLc60vTXKMkIuOPi6CTdhj2Sj5Tpbhlcb76qmCc3AlZHQESVBkR/MQ6QSzmHNriwlOosw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0VpCc3d2fiF688BiNWcm9WVakRbNl+IY81ollvRBn0=;
 b=Lx2Ds2dbsugghG7QS2oa70mxtJK8QgA2r0C8RCD/W+rcZsy5ya59NrHwBvAcwXHfHubyvHmLE5ofo+15jCdPoKdvDnE0Ih43WywUKqoEKLlvls/uYij3+dp2+dJ8HkxUPnULrFLOIjx8aYNvgj8bdX1IPuXp5Ufwv5XYOymGEH3kWHzLBSIWIsQYbeK15xqvhHgcvaYQmFsDLpIGUSSDrKvKhAdxdotGusLwVw3K0BBIYKcEwidAT0tj5puGpUKxIXK8SE6+grMlf8x1A3UfeUYymPfwbPhqFxOXiP/PtS5ni/C1QFCsAe9t/zLcTyrZFMEH/eoGDCdYFNupcj5/Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0VpCc3d2fiF688BiNWcm9WVakRbNl+IY81ollvRBn0=;
 b=tF/jl2OoIECdOpQ3sZEDaLYom5bhBlLTJ9KggIV3mKk2KBANuDEYsW1KoXtAuL+k+cotDKKTjAvoEvGvRTTl+NSbIasQoRExvz/0UWKSq2ag5jg2DEo9gTo1Wf+sOMxl1/1vK+z6LZdvBY5GvRCrwUXKk9iMqYuI7GtMSnKU2nsNQW10kWBhJCWyJ8Q5zl7FZ4V6cuqifr9tsOqwtjAB1k0JS81ZaY6f1iOFItEEGrSW0jCHYwKqM8LCnj67WRYVSJEHVPXgfgOIiMHzCgxDGvTO2n+zOFYUOyxKVrAN6DkymJspsWvYpc3lSSKWTTHDQr6hcZ9P6nrXhCQMgPpFsA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10)
 by DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 09:49:19 +0000
Received: from CH1PR12MB9647.namprd12.prod.outlook.com
 ([fe80::228c:766a:191d:77b2]) by CH1PR12MB9647.namprd12.prod.outlook.com
 ([fe80::228c:766a:191d:77b2%3]) with mapi id 15.21.0451.026; Tue, 29 Sep 2026
 09:49:19 +0000
Message-ID: <e6a557b3-2986-486d-9679-e7a4fd1cee5c@nvidia.com>
Date: Tue, 29 Sep 2026 11:49:15 +0200
User-Agent: Mozilla Thunderbird Beta
Subject: Re: mlx5e:zero-prefix corruption during TCP DMA-BUF RX - help
 requested
To: jiabin deng <dengjiabin2023@gmail.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, linux-kernel@vger.kernel.org
References: <CAFxp=AY2cVRQrZvB9WNnigbsobuw11NMG-cagHx0_V+ur2ToFw@mail.gmail.com>
 <e4054f5a-e60c-4253-bccf-d05cc7c615b7@nvidia.com>
 <CAFxp=AapgUYLUhipVjR8oM0fRDSLDX60AQf0UP8=U4M1ASqmOA@mail.gmail.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <CAFxp=AapgUYLUhipVjR8oM0fRDSLDX60AQf0UP8=U4M1ASqmOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0225.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::17) To CH1PR12MB9647.namprd12.prod.outlook.com
 (2603:10b6:610:2b0::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PR12MB9647:EE_|DM6PR12MB4265:EE_
X-MS-Office365-Filtering-Correlation-Id: d85ba95d-79f5-4145-39ec-08df1e0eeeca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|4143699003|22082099003|18002099003|6133799003|10067099003|260925022911599003|260925021311599003|260925021911599003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	cF70OF9laDxjQkAAjIEsDDz47lYVyxomWnJKMTwfohhvK5cLMVfWO/CFdbQdVylqHaw7/FethH01Az4j7YCnBNLb7I+NwKfm6cgiJLXGCet9lmwdkk4oewLYhV5GUTxWBbvMpG/leTmst10UJpKZAA0/LNnq4DeYxsSZZKzCjW72rWDCd8WH1cXnnHPZg0ovx44Xwxbw1bjfmX5FBSr3HisTabuLMp2IrfevQED0MHGowWENaXy1l6Sb8E/BVRY51R68yw/8mEIqViGmjrcNctOr9IklQUSaiz/lRMTX06ckLb3Uj2+CBNVlvXf4F14ETNYszdJaUmO2u25ka3jn0hYT9p6TFbQDfihIhEPDBMtV4DMW9M3vM/1KI8hgQtzIDkKdw6g859l0NrUlFtt4yjI7wq7rdI56G+Gecktnwqx8FUTAzg5nPAnsWke7QAsHIb4YDkHv2QVjww7EmOTYGihM2iwVkO+b4iaP4Byv5KcJPmgsWzdva1d4JehtRCdLHG5DLnubFU76q7kd6thSiREMZNoN6o+lb0zCJL06c5wN/I/V40WV/SfAVjEIlBjWUVQ6YwOau0ZQ9QdGcMY6SGNgS57dLg446YXYroORczFIWo9F0awtbjbJXXJs2NnnkDotnD9nOwc5CkFUzKXRUexIf6zNhL+6MjjH2N2OsSg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PR12MB9647.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(4143699003)(22082099003)(18002099003)(6133799003)(10067099003)(260925022911599003)(260925021311599003)(260925021911599003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXdqbTlCeTZuZXI3OCs3ZGs3QUsvVnpBdjRMeWljbDl5NVdYK2gzVHlUd3B5?=
 =?utf-8?B?NzRiVlQ3akVmd1VtUGF2Y2FnNS9hZTFWQmVUU3RsZ2dBR3hMR2h4S25qMElo?=
 =?utf-8?B?SENFblhZRWVMQ0crMFQ5bjdtR2UxdHZsS2V1NHhJU0lxOFd1QnA1ZTdsOXJx?=
 =?utf-8?B?c0Y2ZTNqaWQ5eU5QRFlYSFRUcmtnWGNoTjlwZnFXakVmMFpRQ1lCUmRNQlE3?=
 =?utf-8?B?eTdOK3NlWU9SZExpL3Y4WTNHMDNaWWxSVEZnOEkrd3h6VDNOVzNOcGpRam8y?=
 =?utf-8?B?VDlTM1MzMDA4c3NpRkN5Yk1Qa1JWTlVvck0wemFybm1DMnZpRVNFZjJrYjBo?=
 =?utf-8?B?N0NJR3RHVzJUNStzR3lzTU5lSlN4eU10N242V3hTZHNyZ012SDhhbDJqSTV3?=
 =?utf-8?B?VU85cG1oQzZoa2wzN2xJTjVEb1NUeVFEdUtTVzJqanJ5by9hSXRCT29LWDc5?=
 =?utf-8?B?UTdYMTd5Wk55WTJuWlFqNmRXVWpjR1p3bUs3anBPcG1XTUxFeFBQZlV2RGFt?=
 =?utf-8?B?RkZNeGxiWldlb3daNHlVc1pWY2htNjYrdkEycnpJV0pYVURSTHBrNE9ZYjdX?=
 =?utf-8?B?ZDYwcWkyY0FtRGFXMWJ3MkEwcTNZeGl3S3E0MjZvbzN1UDZlOUhJRmFsVTMy?=
 =?utf-8?B?cTZkaFptbmFmck5hRkx6RGMxWmlSTytWTUo2RDF2cVFrcDJkdUtjYk5xOFAy?=
 =?utf-8?B?NFFkdC91ZjFNamRqOWJFRVRvOFE3NTM4aGZaK2xSQjhDQkF1aElFamNqR256?=
 =?utf-8?B?d2o4Q0NUQ1pLOFQ5Q3hCemF2WVVubGo2TWFDWHp1dFFKckFuL1NYSmEvNTl3?=
 =?utf-8?B?dWlrZVZFd0w0UzB0Y0lINis1eUxmOU1YYUFlYm91RTNJR3JES3BTZFo1WFNN?=
 =?utf-8?B?TkRyM2cwL21EWXh1WXJsOGk1WG9kQmJ6OXd2MTVHRUhIejh1bTZVSHRJTG93?=
 =?utf-8?B?c2QzVmFCQVFKeUt2WEtRaHp5aW45dzQ0ZTZwbTBweWZUbFpERStDbE1RZVBI?=
 =?utf-8?B?OUVoemtmb0kzb0REcEJtaG1uOE56dzl6QklpQlN2b0pZOEJFYWdmWk4waFBs?=
 =?utf-8?B?SUIrbVV3cXRwWkUxa3ZrRHhzdWZ6UDRwNDJzQ3FrTm1WVytySHlzbjVrY0lv?=
 =?utf-8?B?OXZlczBCbHFOcEpjWEZWYWNHOW1qcnZ3eXc4VE1jTUtSR3dBZGozS2VQVm5X?=
 =?utf-8?B?akdmYlY2bGt3MlcrSDY3TGRtM24xRWRvV1BPeVh6ek5PSXUxZ1kyMythQUts?=
 =?utf-8?B?Lys5Y0RybWdwOWpqelV0Qm84a1c0MGx2anJOU3lnbXdhVlhGajlKTlFCRVlZ?=
 =?utf-8?B?SmVuNW9jd1pUdVB0WHFoZENWanY2UVFaQWJmY1FjNVEvbDNZclg3di9nRkdS?=
 =?utf-8?B?bk05bDJ1VkpZWlcwSEFYZWxCZUxzOUo1djQ2NDBORERGSFZScU5ITmVMSC9n?=
 =?utf-8?B?UE9FZUUrcDhUcXhqbWl5WjV2R21PMzRuWS9FYnpxM3FKSU13TzIrbHVLQTRn?=
 =?utf-8?B?MjFpVWgwYkFuSnBObGJmckl5MTQ3RkdsYWx2QWpEcmx5cTdoTk8wbzBhNVlk?=
 =?utf-8?B?WCtaY3NrczlDRmZRQmRXaXE4U3NhZnZ6MGV5K2U0dE4weFdGTnJ5RkJvVTFN?=
 =?utf-8?B?TEhGblhPczBUd0hDbnNkdmUrMkNST0M3UzVWbDhuc0VBSlhBWjY5eTVFT0dV?=
 =?utf-8?B?c2hLbk5KVHRFbmV2SWc3aGpWbGgvaXdjU3UyZTJTS3hITDNhd0J0REtwcEZ3?=
 =?utf-8?B?ejgzOVIxY3VJVGtYUVQ3dFNGWHhCN3Z5Q1ZlOWw4MHdRWEQ4YTc1UmxmVGty?=
 =?utf-8?B?V3J2WE9sK09RSGNhVXlwN0dlYmVUcE5veFlZL1U0MXBWNVZydWRLckxMUUpF?=
 =?utf-8?B?SkNNMDErMDRjNld1YVhEWUlQZEdnR1pmQVNSeHpjREM5aWZ0d2lOZnlPSnZX?=
 =?utf-8?B?ZjlZcGk4dW93R2NSNkN1dFVvZ0l1cnYwVVU5Q0dLZnk5bmRtRW11TWVKbERo?=
 =?utf-8?B?WXdYTTVyUW5aUEJHaTVKZXNJRHlUSmJoejFhUTJILzlFT1VZN29xU1B4VjNj?=
 =?utf-8?B?RUlzcGhyVVhPQkxIeXdMc1VmL0p1ZzJ4YWVNRmJZN05WWG5zUEh2MXRVajdV?=
 =?utf-8?B?MGNsUGUrdkF2ZDZUNG5mbjlYMkdwdURQWDU0dFhqYnJFTFBsek55TVR6TTA3?=
 =?utf-8?B?c1ZTaVhvZGZhYkZiM3JscHBNYnhLWjBXUUt6L2xReC9wNU5BWUMwUG5WUmJh?=
 =?utf-8?B?S3pTZnZ1bFc2RXY4ZGNRMzFQQkpUOUd1NGlOMzJCWVZUMzc0V0cvVGN2am9W?=
 =?utf-8?B?SlNHanZnQWZDSnJkSE8wUGVsK0l5ejJHcTg5MWpzQ2kzc0NFL2V3Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d85ba95d-79f5-4145-39ec-08df1e0eeeca
X-MS-Exchange-CrossTenant-AuthSource: CH1PR12MB9647.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 09:49:19.7080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LpFLakMrLTNFYI22tTF7cZNqwukPQZ5KmOVitefcS70mM3Uuvu0J0wJALAMsi73cgHcud/kdCl14sdSvETVihw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265



On 18.09.26 08:06, jiabin deng wrote:
> Hi Dragos,
> 
> Thank you for pointing us to this fix.
> 
> Our original test used Ubuntu kernel 7.0.0-30-generic, based on
> v7.0.12, and did not include that change. We have now repeated the
> test using Ubuntu's mainline build of Linux 7.2.6
> (7.2.6-070206-generic), with its in-tree mlx5_core driver.
> 
> I checked the v7.2.6 source: it contains the small-frame guard from
> commit e2466392a0b8496000e12181cb1ee1535eb0da25  In
> mlx5e_handle_rx_cqe_mpwrq_shampo(), frames with
> cqe_bcnt <= ETH_ZLEN + 2 * VLAN_HLEN set match = false and
> flush = true [2].
> 
> The zero-filled corruption ending at the next 64-byte boundary in
> GPU memory still reproduces with this kernel.
> 
> We kept the same sender and receiver data-checking logic, with
> tcp-data-split on and rx-gro-hw on. One additional environment
> change is that the NVIDIA GPU driver was updated from 595.71.05 to
> 595.91.07. The NIC firmware remains 32.43.2400 (MT_0000001117).
> 
> We repeated the same eight message sizes, from 32 KiB to 4 MiB,
> with 50 iterations per size:
> 
> - All 400 iterations completed.
> - 105 iterations passed; 295 contained corrupted data.
> - 21,599 corrupted ranges were recorded, all zero-filled and
>   ending at the next 64-byte boundary in GPU memory.
> - For each size from 256 KiB through 4 MiB, all 50 iterations
>   contained corruption.
> - The full-message snapshots taken before and after
>   cuFlushGPUDirectRDMAWrites() were identical in all iterations.
> 
> For example, in the first 32 KiB iteration, an 8-byte corrupted
> range starts at offset 2147495416 bytes from the beginning of the
> GPU buffer. This offset is 56 bytes into a 64-byte-aligned block,
> so the eight zero bytes end exactly at the next 64-byte boundary.
> 
> These results come from the reproducer's runtime byte comparisons.
> 
> Could you suggest the next targeted checks or additional debug
> information that would help narrow this down?
> 
Did you also try CPU buffers? From the NIC perspective it shouldn't
be any different.

Could you share a program + reproduction steps?

Thanks,
Dragos
