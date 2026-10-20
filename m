Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792480075;
	b=tKtt4c6J6IbEvMGtq+DloBdrQ7MM+Gl1CjQX1L1RiK894uBgcMOzmKEWdBv/eaG4d5IJ
	 WqmvZ/dpelf50joU9y4gcNeJN1NglbGgNOBeOcmNs2bDOK6BllAOMuhO30J9v4kCgou/q
	 9LqgmtYxx01iLjKeM2ZxBbd0WWECswbV5sqKsPgoyRjm6N8mJMr3tXlE1Kn5nbWUzTYlb
	 d5nn4iNOOrazUfDd9cSoNpJyDRAp0YkUGzpdESTnBWcSs5HwVEmU/sIhOtBOSjQIkkum6
	 qipTzJOnE0VqIf11YqedSS5cxVK4k6nGISR0EGWv6H/Tpg42Rr8FG74nX/epjDKj94g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480075;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
	bh=euAv5d+3BLGaxfQnwws0pRqgOu0Vow2kH9KRzh+h8os=;
	b=YMk5LqD9FaskoiECEVtyBfXkvwdS34aJ/UOkSXtMz628+/a1ZDhL0snVJk3oYJLyzGqp
	 rMFYfV1lFf96J9Z3CmJotfCUtjXBs8wnJpTgYj8zpKo1f2fINHSUQbPpUC4IxzCYc0SDE
	 IJNWLRFqoawi3yqBGNdZnFi9vXEL8/sbEP+3oNPre0xYI/phVzPsgW+jF0iHZmoa7KzEp
	 dLcsdKkthfeB7jsdQ757LoF07zsyIx1ginBt9k4bNk7c7V7LfIskOiyMxZbgE9EGry6jO
	 Cbul1m4SXyn+1saBY02DwIka1yTlq19ZP/wynYqVmIHcuy3PVYi2+HyrDIQQxX6C/AQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QDvCdJzN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.0
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012000.outbound.protection.outlook.com [52.101.48.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D189606A31C
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 07:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D189606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QDvCdJzN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSjdZ9gOjVtmaqDzqGalYvQNhT1bvsOZkpHEIotTTT0l9+J5yCIcFzcB2VIv77vM1rHr1nYUjlDQV52i6ZOv9WvMiOL9RJZ9AXAqR1r+3GKqEm4fHVdbukZcDw5rqec4P+tmhU7ZqcIbbxx4QJMlpcyfAUV7o/iQcz5kDwwL+ffD3D0xbtDQ1pX9TBQ19BjZ61FqbkTclk+M7leF3mrOa7himp4Upq5wuaSTYOFmI5K10kAtYBmqxXBmwVLCXr+nrUiEQyrxaRoYL9T8GAF/eAhLvGjHPEThfZO90slSY4sWLbagjhej+fRlMDsaY1v/lbRp+EoHfH+OW0fTA+UrkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euAv5d+3BLGaxfQnwws0pRqgOu0Vow2kH9KRzh+h8os=;
 b=MSOTom30ITXQ8xVitrlaxUXARreubZKrmMJUbdoJJN/XTIKGuuB2n+pT0KDuaRsdvlTAtiLkq05vgdtFPWIo100HmGAmTW5KtUiXc7x0LvhnCVpYL+dyqJ6bu06MBHnPASrAZ0yaV6ANZ2Thc8OPBuQUdnBdhgRABzxUSRu9XEyZYer25Esk9T9TFzk97LiKHNLu1xZbEVB241w8pjvQp2a1Ez2uX6y9ZNUyS0gKcYFrz3bWS+Ir6INBrtkWihFbDzfMcHqD+P2DZvOFQhxjL/I0Pnb49vaN9xW/fPyWUWQSe0VA+oPkLbkT1VenA9hhwkYf18gkBOpRlcJnrDekJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euAv5d+3BLGaxfQnwws0pRqgOu0Vow2kH9KRzh+h8os=;
 b=QDvCdJzNfto3IUJlf4YWkMoyQqKbTqQpx3nd6Og09c7SkQYUbDrIzdJD4hBPBXvD9qztdLFNW6FpaZxbLBpEMjDsR9EfIJ7ThdPxFKc/plRHiI1/2LuSqtjPHItAGuFWvO4+anQ4CEkHb7e9rVlNKwyvGAYm1KNmzzaJdIrLg/DA5erKl6Vig37qvZ9zKdkBkM4DWbIcemyvoNRlP2zMAvFkygRWyYaPv8RuNH8Oi7WfsvSxLngpf2Mwcn0LiLwCmjhs5dOZYuSNg+cN1//YHRo0N3w1kUIeAxVlH/QPtAi7cEUAm4sl2mfWpwO4b19cNM3FmfjkdcVPqQKjVTa9Hg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA4PR12MB932075.namprd12.prod.outlook.com
 (2603:10b6:207:12d::15) by CH3PR12MB8852.namprd12.prod.outlook.com
 (2603:10b6:610:17d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 07:07:50 +0000
Received: from IA4PR12MB932075.namprd12.prod.outlook.com
 ([fe80::5a6f:1f74:6ccb:cf2f]) by IA4PR12MB932075.namprd12.prod.outlook.com
 ([fe80::5a6f:1f74:6ccb:cf2f%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 07:07:50 +0000
Message-ID: <5c1f549c-7d65-4deb-a72d-bb9080ee3664@nvidia.com>
Date: Tue, 20 Oct 2026 10:07:44 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5e: Update netdev features only after a
 successful ringparam set
To: Nimrod Oren <noren@nvidia.com>,
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Gal Pressman <gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, netdev@vger.kernel.org
References: <20261017005401.1582755-1-dimitri.daskalakis1@gmail.com>
 <ede9a336-1be7-47b8-bb6c-e6c428d1fa2f@nvidia.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <ede9a336-1be7-47b8-bb6c-e6c428d1fa2f@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::19) To IA4PR12MB932075.namprd12.prod.outlook.com
 (2603:10b6:207:12d::15)
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
X-MS-TrafficTypeDiagnostic: IA4PR12MB932075:EE_|CH3PR12MB8852:EE_
X-MS-Office365-Filtering-Correlation-Id: 8059d33b-c550-4f6d-9317-08df2e78da2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	FiffzzCMeS8rfbZRF5nfUjsF0Xvz1rdt7ZJE6ynvFFIWtN05orfQDMvrLgEIGvl1eD4itfPuxnu5/EW0Vaf5HxecJ14HR3xDeGQ+SvWipxnP2l+nK8sGZ+o5DXEP/b0rOo1Eh06KdDEnlck6efzda2CmqLmTUYb6n8+/N8v3YsYUUzuCFkATl7cDZ7yhnFOyebuSQAj/Tsdx0H/YEOMNyHxF7MY4R4jp9BaZvsw1MSWjx5LHUs3G+WEgiAMVBabi6dbkvTRHaswHFG5/iC+wT7T3Em9bV4OM3CK1pb82mJ9jdJhEDDqrUGZFMoOFO0H1B0qw9+jBMn6ZWPGDlDNn+c+/V4mbqGlTpnQcqp9VpcFqQT7SHnsvLYP3GVYJkV5N693CThBdPt7Mw2fOUfHd7Mtgpcm7IELu/wgJonQuu8tcD8CImzCEGG7V10t3HreeiIbubpMrdef9z6RFpBxL7lH31lP5T3NMxVDsCEEnIfZoODBvxx00CK+SPsBX66sJLjSYzxpvypd+OOYhrBwWoId+4v0xiJ+Weslt4QWcnRNbGXU/Y+B3rYpHamnEBd3O7OvWBztRxG23lhRfnp1BdP2HXstZd4QtixF0kLosCOr3vh5J9/EbpWvXbK8DwBDVcP/9esSjsu0h7UVYPHFzH+4kKL5j5xa0b+hRKBQD4Is=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR12MB932075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2FSb0dQaHRaU2ZScExCWUpHR0xOZUNRSFk4dmJnZG1GTGtIazBCZzZPb01y?=
 =?utf-8?B?TTZDMEJxWDRWOTl3amMzOFY2UWdQeEJPTGYwL3ZVTWdqL1lBaE9iZDc4NFgv?=
 =?utf-8?B?dWpKS0RYa0k3YWJ1ZFhCdWdQMzJmRms1M3BPckZ0aFpFM3B2WU5yaHdiNkpK?=
 =?utf-8?B?TnRrOFQwb3ZkTis3UjE3ODgyeXJXNGNVTXNvaS9LL1h0dkpTNDJpd0lxKzlq?=
 =?utf-8?B?T0pFVFY3dk1uMkdqNEFKWU5NbVgwWG50TzM5Rmt1M2dTRytEOXdMc0w4OHgz?=
 =?utf-8?B?d2NGTFl6cmpDb2syTllBUC96NFdFVVRUV3Fwakhua0l6Z01EaWhBdkxDWkNI?=
 =?utf-8?B?Z2dMSW1WMWgxVzFwVHFiRmJrL0I2dW10SkxRZjQ5RlR2ZGhPVnoxdFBlZ0ZT?=
 =?utf-8?B?WUVCdUJVN1RJSlNhTitDQmpKRWJDVkV2YnZFUHlLdzlzYThmamdUajVrMkpK?=
 =?utf-8?B?dkMxcEpqN002TjVMa2FKcTVjYjhPY0Z0OXpveFUyWS92WCtPZGZMdmVjV2l2?=
 =?utf-8?B?LzdRbEx5QWsyVGxvTEk4VWFRQXQ4MEhlK2hKS3BlVDVKdXpqMVp2aHZORVhK?=
 =?utf-8?B?WklKWUJYbzJqTS9GYU8zSkRXcC9Nc2xXVTluYkFTdzFBR2hIR3AxdDdRTDRn?=
 =?utf-8?B?ME0zejJNNEUwT2pxT2x6WVBUOE4yeTNNa0JMRFNFVm1lQjE3Z1JqS3JaSUxu?=
 =?utf-8?B?L0ZWUktUYldkeGNXYnlDUExIZWFEQUFRQmthcTBPVllOeW1WaU95Wlk0UGdi?=
 =?utf-8?B?UlpBdUtnTG5yMFYyWnJkOEtiUE1RZmJYL2FCeTV3ZkVPNUJsNC9rSjIzYTVR?=
 =?utf-8?B?ME1WeHcyeVJ5TzZ1aFdKMGYwNzkzZ1pCUVlWMHBwMnFwZjZpUjFOVFZwSzc3?=
 =?utf-8?B?bHUrZ1k3Y1EyWFlJRjVhSTRScXVYTkxvOEtvZ3BSTkJ0a0QxSzZjbTlHakIz?=
 =?utf-8?B?ZVB5OXdzOHUwLzV2emVMdDVTZUY4bWQrNVF5WVpTNThMVGJmMUZwcTlQbXpu?=
 =?utf-8?B?M2QxVk9HUm56SHlucTJsWnFzcmpmM1YzRVY2ZU9LVUt3VjVjRVd6eEtvY2xu?=
 =?utf-8?B?NFhKOER0OUx1Z0MvblVkV2hReFBwMDBGZ3NwUFRmUWtQazRjZTJTRnhyVFNy?=
 =?utf-8?B?UVdhUGlaWGRMb0I5NGtjVCtxaCtEV2JicWFtUGpGcG9vU0NUbnlFRERvTFpT?=
 =?utf-8?B?VWNnS1RrWkxvYVFDUkp2U0svSFlYSU9kN2tIdEFmcitZbi9BZ01TeWdyRUVo?=
 =?utf-8?B?dW0wWkhSRlE4NGxjUy9kVTJLckJQYUxVd25SdFlIVnA0Nm9JRUMrZ1ZoSEtJ?=
 =?utf-8?B?ZHE1ZktDbzBTenE0OEEyak5kV2hnTmN0Q3VaaGMrR0h2QmpVQzJKWmtJcnQ4?=
 =?utf-8?B?VFhJaUtNWWw1bVp0ZTlTdGJpZDdqUDViVVNpYjdDcWZmQk8vdUdTT1FGZGJp?=
 =?utf-8?B?L1hUL3BKRC9kRlYwbkxmalZEbzZVY0FGQkFvU0phb2ZiMUZhVGpsVjFoclJI?=
 =?utf-8?B?YUpaQzVtNG14UEE0ZURmTFliaTdrRFREMitJdWMrQ2RWMERybUR3Y3lId0FO?=
 =?utf-8?B?M0NrTDlXY0w2UXdEUDVGSXF4MWh3M0VaTjZTQ0JPT05GNTZJdWh2Ry9sSExO?=
 =?utf-8?B?NVI4b3RVbmVGU25lc1ovRTRBa0UwalZUT2tkdzhZVDluaHZQQUlXWVNMcGxX?=
 =?utf-8?B?bE1XSUVvL0s4VnBjRGJ2Tk9WSk02SUo5Nk1PVzJmUHpzNURlUUlJMFdkWkts?=
 =?utf-8?B?TlBrS1l4clpKbzlPQWRSYXRSMHVRQkQzQXIvVENyRzU1R1hPd1Q1OHBBellr?=
 =?utf-8?B?MWt3S3hMYnEvY1hibDUvSWRyLzZNSVBFS3VxVkgxbUVOSnRsSWtBSXA3ZW5v?=
 =?utf-8?B?QktMdnVhNzBUTC9PNHBVQXVsWlFGa3gyanZxVkk0aUtHVDdGWHpqdFdjWW1y?=
 =?utf-8?B?SVVLOFE5bXRWUVBrVEx1S2dPM2xmOGZoOEdMM1dkZmVJdWJYQXBnZ2hML1hH?=
 =?utf-8?B?cmE1djZidXdLcWh5Kzg2clJ0SVlmdTJHQ3dNTVFIV3FEMFhlZGt6aWliR21Q?=
 =?utf-8?B?TDkraUFOUzZ3QkRpUFlhd3RmUW53Y1dQUURDM0VkUTZIRUdWSTUvZkhlaUtW?=
 =?utf-8?B?ZHRVVXlodmJTeHExeGdhMnJpem1xNEhqcnRNNUFneFRhY3FFYmZNS3ptQ29t?=
 =?utf-8?B?ZTErbTdBTlJHOHBIRTZlYVRFZzVOVkZLWjJ5bmExeUZ0eDVoRUk5RmxDbkJP?=
 =?utf-8?B?V29tRU82VGRwYVMxYjlWWCtoeHFOZ0VoRm5VSVUyQmlMM3BTUkNtbDhZNnB2?=
 =?utf-8?B?UmVmY1VKTGZ4SDgwZG54a1FHSFAvNUlxUjJaN1lROE5ORkk2UG0rdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8059d33b-c550-4f6d-9317-08df2e78da2e
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB932075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 07:07:50.2026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KdbXKHS4phoxsaecj/OR5YX+AXy12zb2wz5i/s/qJIIFwjtmeoQaVNIkgjjiXZx4hNo1tYYdpiNv0gEBLt7tMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8852



On 18/10/2026 19:55, Nimrod Oren wrote:
> On 17/10/2026 3:54, Dimitri Daskalakis wrote:
>> From: Dimitri Daskalakis <daskald@meta.com>
>>
>> mlx5 couples HW-GRO with tcp-data-split. If a user sets rx-gro-hw on ->
>> tcp-data-split on -> rx-gro-hw off, the driver will leave HW-GRO on.
>> mlx5e_ethtool_set_tcp_data_split() calls netdev_update_features() when
>> tcp-data-split goes from enabled to disabled in case HW-GRO needs to be
>> released. mlx5e_fix_features() reads the new HDS config from
>> dev->cfg_pending, so HW-GRO is released before all ring parameters are
>> validated.
>>
>> If the subsequent call to mlx5e_ethtool_set_ringparam() fails, the
>> ethtool core discards the pending change and reports tcp-data-split
>> enabled. The device is no longer splitting, and subsequent ring changes
>> are blocked.
>>
>> Move the call to netdev_update_features() after
>> mlx5e_ethtool_set_ringparam() exits successfully.
>>
>> The issue was discovered by manual code inspection during review of
>> a change that stops mlx5 users from disabling tcp-data-split. It was
>> reproduced on a ConnectX-7 with ethtool alone.
>>
>> Steps to reproduce:
>> ethtool -K eth0 rx-gro-hw on
>> ethtool -G eth0 tcp-data-split on
>> ethtool -K eth0 rx-gro-hw off # HW-GRO kept on for tcp-data-split
>>
>> ethtool -G eth0 tcp-data-split off rx 1 # de-sync driver & kernel state
>>   netlink error: mlx5_core: rx (1) < min (16)
>>   netlink error: Invalid argument
>>
>> ethtool -G eth0 rx 1024 # valid ring changes are now blocked
>>   netlink error: mlx5_core: TCP-data-split is not supported when GRO HW is disabled
>>   netlink error: Invalid argument
>>
>> This is not a terminal state, users can recover by setting rx-gro-hw on.
>> With the fix, the failing ringparam set leaves rx-gro-hw on and later
>> ring changes succeed.
>>
>> Fixes: 46bcce5dfd33 ("net/mlx5e: Support ethtool tcp-data-split settings")
>> Reported-by: Björn Töpel <bjorn@kernel.org>
>> Closes: https://lore.kernel.org/87se2grw3d.fsf@all.your.base.are.belong.to.us/
>> Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
> 
> Reviewed-by: Nimrod Oren <noren@nvidia.com>

Acked-by: Tariq Toukan <tariqt@nvidia.com>

