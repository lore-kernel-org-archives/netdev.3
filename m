Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012024.outbound.protection.outlook.com [40.93.195.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9EE21ABB1;
	Fri, 17 Jul 2026 11:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784287180; cv=fail; b=RLgbbUcjiH/fyWt7iBFTdnWhQUfOz0eS4i66ybnO0HnPFEehjuk8oHD6h3LLU6HbgmL0MG8BVTaKlysZg8zLPn3kmAizaNtnWQTPyTWA0s680RjqxRVLsQiRSVwHOcNGWKJ/r1A/Lk7GsiBJIhfHoqK19PcKRxtZ5dWmQn0S9cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784287180; c=relaxed/simple;
	bh=MsUyMdwzeb4/Cikt2qHgR8fGx1IwZl8H3YQQmmw4wWk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iof5NaViKpclyBcRep1WRN0XTbsma9n9cNjMypE1wZ7pLnFJKjjxrISLw8EsSuGEnSErRQoqYJMX/pQFDajVQX3dk70jm4aXtQy8+LgD/dX4eK6lzocCAeccb7Hg/vi35LrRDTXksD8m8TX/hRNe5J89NtLuFUrqY3pKdSURxVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zkv0a4s7; arc=fail smtp.client-ip=40.93.195.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zkv0a4s7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIr0EydVpYRQ3gwAWMvHIaFBlstZdbYjCexPSuryiWy+mVs1i2pl84jvwQWBpxb5p7kUJZVWjDJ0L1JSJVsFiJxpaqIWCJAfr80NZiiEUMIzZsLbkbAhCqWAW+HRenctN6KOY7lCYjs1oW1xJWEeYJHyyfC1Xob5/ThaGp7I0sLbBU2j6nyXbPJwsjq43EFTjH6bsCmEMdFvNz8F3DGOrIAAldIqMXgYQHmFKwnvNk9HysMsqFH64pH2coNQPCXMcaDXpfg7N2CYsAqUtUmanvrLPbSCWzqlejQb3kVJVxgivoIA/3nv0f34sHsWQi5VnSh1o7IPBEVQdAgqmS87yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LWAQXZu1AkRXVRD3WAzJkcpKIpNh+GvLZvBxraoa6s=;
 b=wsEeE4Tr125y2tVm5OV1A+IQPP4kig986qH8vIhlDf3JVETa4MmvXGYzn18g83wnQOxgh+VtbEuLXhFRpr+fw2A4BJa53aYRMPs3gGRFsswhxeh3IaNEgxhuyWQi/wwBdoZixNB+MrkMconTQqGCj//LGFv98cisTLTlToHhVO/2p6S09cBxZ7Z57jJ2j1nWQtLCUuHgdzqD3zyCk3QLZ6hNdOyXi1iOg+5QXrwVtFOrsnbVfrSj7e/mkFoek4rdSZBK9M2Zdq/LbKdd6sowmV6nj5FufGbJGKWuMnSgvbbk7AtPtUY3K1jgokHRQGaVjzw8+ByTmUcQ9c/7Oh2Unw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LWAQXZu1AkRXVRD3WAzJkcpKIpNh+GvLZvBxraoa6s=;
 b=zkv0a4s7o0L/YLxR2VyJDLpnFkV2Knc3x73Hfo4BYgqaojW7xDI67L/Xb7IJt4zSTj9a2/IHioFSq+NqBcy7TzcElENu+NzLwcC28LP1ssW3XJ4B72fBSB/ID3TWsDPZhaWJCycdB+di7Xneau96cSGjq5HHCFWA1GsNJmPzqr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 11:19:33 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 11:19:32 +0000
Message-ID: <22f1a796-0aaa-4a46-bfd1-dcb680d742b1@amd.com>
Date: Fri, 17 Jul 2026 16:49:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] dmaengine: xilinx_dma: Extend metadata handling
 for AXI DMA and MCDMA
To: Srinivas Neeli <srinivas.neeli@amd.com>, Vinod Koul <vkoul@kernel.org>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: Frank Li <Frank.Li@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Suraj Gupta <suraj.gupta2@amd.com>, Marek Vasut <marex@nabladev.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Alex Bereza <alex@bereza.email>,
 Folker Schwesinger <dev@folker-schwesinger.de>, dmaengine@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <20260717090824.2364230-1-srinivas.neeli@amd.com>
 <20260717090824.2364230-5-srinivas.neeli@amd.com>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <20260717090824.2364230-5-srinivas.neeli@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|SJ1PR12MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cace94e-0806-4b81-2b39-08dee3f54662
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|6133799003|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	l2ilJzUEKaLIpw+mVtqK+V4/O/qO94Z8kiBBCWjI2gc2pfVXbKBeVmtnEILBzGn6OrAN4aQiwRPbd4I58cnU47Vcy4NhhHjClEW4JGoHnbbemml3blP9ZJxcBO0yMM854mWTWBWWBzNhh7H8KYnCTFqtPhmfFicfAyOF+ZEUs/JagYAqXWGPMI3r1F5brYvWJREv8fUVB1WloLJwGo50oFIIXKjfQz7luSHPOlgfXsqlf8l8lfEZ953MOLU1HlyCwzkusGjWvCIwnPuecpkToxFllZeSVNnMWDnF0cvExwRZr33O8Irpge9VflT5Xg8REELptzTufEaPxPZVAdXrNQGoKZbd8ZiL93yolpyJ45Otv1X57Yj1mgmaKf7PHsyvgP1sIrIvBKjGXhf9Bd/Thrl0U7tb4cYJSINuhEw1EvTBcw4t+UWaL/289krIn/tJMyON6nDa7Kf+xIbUbuMM6eTmhcIDDZsjg86tuIJSo7ztxPkV+v+B9bEc9ZkuIL/GbTjZEPxIs/L8xCra0H3SDjPIJoFBZA4pe1++R7lCiZ7CZgolMo0jnjI3N0dPrLteNpoFb3RK5w8A9JI/V4s68IxeOmnHxjOB02RQX9DnloX3dV88sOPrLfg2LOuDJoEP9NRvNK9c1S3Ovw0EPdgka2YwxKSIU4LOeY7AmZMohyU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(6133799003)(11063799006)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qm5UdUdRd05NRkg3YUVmYXdkK0xWWEdwRnl2Y0Rocm4zUzFtWGlyU29MYklt?=
 =?utf-8?B?aGQrVzlSTWZmUWpRT3NPcFNqZzd5SnFRTmJCejRuSTIwV01LSHVhSmk2dStC?=
 =?utf-8?B?SU56bjNNcFMwQzdVRXJzT2lCS0JLWU41bzdQVVlLYTFkOUJWRXJVcnZrZnZH?=
 =?utf-8?B?YUdndmV5RTJMQ2VRVDNJMFdqSktVR3RXRTUxelNEUmxKWFVHMUorZDlncUVu?=
 =?utf-8?B?ZitMWXErcVhNVDlXZSt6ZUlSU2xvaGVzbU02T1h4VjMvWGxWY2tyc1NrRmRE?=
 =?utf-8?B?U3lLNGs2dlBuVTdsK2hDQlFkOXBwNW0yZ2NSZENLbkZsMmVaeEJQUW9RemtJ?=
 =?utf-8?B?R21XQVkvZXpMSkFJaDNFZk5OdDNoNExtUHFwUE81clBlUTFsRExFY205TTZE?=
 =?utf-8?B?cEQ4RVJMTzdFc0t4LzhEWlFnU0VYUE1pYW5DYnFXMFc3TUl5VFVvSGRZQWky?=
 =?utf-8?B?OFc5Yy9xKzZ6UGNqQVFRK0ZpUlhPaWhTeTA1bzVrM1VLck5SSzFNekZMTjVz?=
 =?utf-8?B?TUphaVpmbG9FRkxOK3ZPa0FYSU9xajNwaGVleVVOSmNLYVlIRWxId0o4ZHVv?=
 =?utf-8?B?MVFqQlExR0tlTlIyZVdWUDBxbUhYQXVBSnoxb3E4NjlXaU8rNHFvSFRjWDls?=
 =?utf-8?B?UkdlaDdTdHpRc1pIY1lmVUhoakZ3bGtHS0l0bnFCeU0vTEIwRmFieVg5dUc1?=
 =?utf-8?B?RDV0N0NRb2ZEWTJ6ZVczdVBnaTlYai83ZVdpeWdpeGxmcjRRS3BpeHNucVBK?=
 =?utf-8?B?MW5Temp5MExpeWVvV1MyUnJLbW1hVnQ0RFVMV2NVditWUTVEcG92TmJFK3Fi?=
 =?utf-8?B?Nk43M2czRUV4QVluRDY4ZkxVT2FTVzVPMmxlY3hIbmVaNDhpRmwxZ3I5dFlr?=
 =?utf-8?B?U3F5OE9vTWNKZ1Z6Y1ZOdVlVUEpySHVuQXdRWXVPUFEwZEVZRmYxc3BiZGJW?=
 =?utf-8?B?bGxsN3NPKy9pOEdZTC80SWx5LzVOa09CL0o3UE1HMGc5Nmx5UmV6bVpuQjd1?=
 =?utf-8?B?VFFuYmUyd2M2RjNLMXhISFA2NnhXblQyNFNUd3BjTG1aZW54OGpnTEtWNncy?=
 =?utf-8?B?cUw2ajZSWkRTRHBMUkQreTVmdC92V2pSMnRlS2pGc0RvVnAxeFIzMkU5Y3Rk?=
 =?utf-8?B?bHFSWVNFQ2Z5OGRQNGZkU2czWnZFTWpJbXlJeURCaEFQeER1eFFETlFWU1Jz?=
 =?utf-8?B?WU9hQUc1VHRrREw1eVlBbzVObHNNVlBvb1duRUZxTW1wY2hVYmlOVDM5cjFZ?=
 =?utf-8?B?eTNYRzFqMXhtZDhQSkI3WU5uTXVBczhCdE5XN1M5Y3NWS2V5S2pTeU9veFJ0?=
 =?utf-8?B?enVTbmNST1AvSnhuMzZJbFRVQlhtYUJZS2kxKzU5ZHhYY3MydUt5b3FieTFj?=
 =?utf-8?B?ZkhtQS9QVXBHRVNRVGpVU0NNLzNqMFNRcHlPc1RUSVZtbWg2dDVTYlMwOVZO?=
 =?utf-8?B?cXZLZFJvKytmM1pMUEx3NEU2T2xBcEJqQnBtakNoTWNUWUJOQmtLc1V0TVZa?=
 =?utf-8?B?Rktpb0Y0RmNQRk9kdk80a3VTdWRYZXNBeFBEMnlYTVczbUExUUhtMmNQN1NF?=
 =?utf-8?B?TzVIbjZMcndJYzFnYjJURkFXR0I4dUhBYkdqOVd4cVA0SEZkcUVvUG04dHEv?=
 =?utf-8?B?K0ZBOXRVSHdqVVhhWDNzZXdtOE9ieC9MOWUvMnhELzJTSjAwOU02R28xQ3Vt?=
 =?utf-8?B?cHkzbCtwU2o3d3JjbDNLbUFBSnFiSTNpWmJCaHoyKzlhek13N1lmU29kNmR4?=
 =?utf-8?B?RU10aHErM2JzVUtFVzJ0eFN5UDd6L2kvM1ZXaUhWMkJia3pjdVZOSUppTUF2?=
 =?utf-8?B?azRZcnRzSEp3NEltYmFVVjhValJNZEd5RSsrcFh2L0RpZDJ4YUxCdG5aOHhT?=
 =?utf-8?B?ZmxrUWRSaE5JTDlmUHZwWkpTT0lpczExRi9BeVo2d1gwZ1AvQ2N2MU1Icjc4?=
 =?utf-8?B?K1paYWc1YW0yS0JiREJ2VzdKRFI5RXJwbkxGd3dwQXViSEdTc1R0VTRJZjNG?=
 =?utf-8?B?cStOcVhLdnhBeTB4a3pPQ0swbXc2NzRWZ3IvUFRNYzk0blRCZ0g0VkptNWw0?=
 =?utf-8?B?ZWZUMjV5T1dIQjJhYkF6aDU2RGJFYzlCeVY4MXBOaWtSTzM2WG82OWtsTkJt?=
 =?utf-8?B?b1pNZWVmUmxjUlByK0djbWRFd0hPYUNQRWpFTkFTalJrdUpCUWdWYlFuRTFB?=
 =?utf-8?B?bXczK01hV0g5MnJnN1pPalgzTDl6Z1p5ZTdkVWpyaG0rbnRnWG94bUZGemlI?=
 =?utf-8?B?OHJjQVFycnFISFI2SDFUV1dZQUNDSVFXOEFDaEZNeHFWVlRhdjBDcWhIOG5N?=
 =?utf-8?B?NEgwS0FZam1SWHpnTFRORUtiYmc1RFBBNUdKeGNGbm9ZWWhWNFEwdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cace94e-0806-4b81-2b39-08dee3f54662
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 11:19:32.3624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFTtbspRQ+5wBrFumBk42B1m7914APXoLG0SEJWe2bqx9cB/uobR8C2CtezUm6w3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6172

On 7/17/2026 2:38 PM, Srinivas Neeli wrote:
> From: Suraj Gupta <suraj.gupta2@amd.com>
> 
> xilinx_dma_get_metadata_ptr() returns the AXI DMA APP words from the SOP
> descriptor in both directions. This is wrong for RX, where the hardware
> writes the APP words into the EOF descriptor. It also leaves AXI MCDMA
> without metadata support.
> 
> Return the metadata from the SOP descriptor for TX and from the EOF
> descriptor for RX, matching where the hardware reads and writes the
> fields. For AXI DMA, expose the APP words (20 bytes). For AXI MCDMA,
> expose the control sideband, status, and APP fields (28 bytes). On TX
> the control sideband holds TID and TUSER configuration for the outgoing
> stream. On RX the sideband status holds the received TID, TDEST and TUSER
> from the incoming stream. The field layout differs between MM2S and S2MM,
> and the wider payload lets a consumer distinguish the two controllers.
> No in-tree consumer is affected.
> 
> Read xlnx,axistream-connected for AXI MCDMA. Attach metadata_ops in
> xilinx_mcdma_prep_slave_sg() when an AXI4-Stream interface is present,
> so MCDMA clients use the metadata API the same way as AXI DMA clients.
> 
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> Co-developed-by: Srinivas Neeli <srinivas.neeli@amd.com>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
> ---

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!

> Changes in V5:
>   - Take the metadata pointer from the SOP descriptor for TX and the EOF
>     descriptor for RX, matching where the hardware reads and writes the
>     fields (TX previously used the EOF descriptor).
>   - AXI DMA now exposes only the APP words (20 bytes) in both directions,
>     instead of the status word followed by APP (24 bytes).
>   - AXI MCDMA exposes the control sideband, status and APP fields
>     (28 bytes), with the sideband position differing between MM2S and S2MM.
>   - Reworked the kernel-doc index table and commit message accordingly.
> 
> Changes in V4:
>   - Restructured xilinx_dma_get_metadata_ptr(): AXIDMA is now the
>     fall-through path instead of a separate branch guarded by
>     WARN_ON_ONCE()/ERR_PTR().
>   - Rewrote the kernel-doc as an index table covering AXI DMA, MCDMA S2MM
>     and MCDMA MM2S, and documented that the pointer and payload length are
>     the same for both MCDMA directions.
>   - Added an inline comment explaining the union aliasing.
>   - Condensed the commit message.
> 
> Changes in V3:
>   - Renamed subject to include "AXI DMA and MCDMA" (was "AXI MCDMA" only).
>   - Complete rewrite of commit message and implementation.
>   - Metadata pointer now returns status field at index 0 instead of APP
>     fields, exposing status and sideband information to clients.
>   - Changed from list_first_entry to list_last_entry to return the EOF
>     descriptor where hardware writes status and APP fields.
>   - Added explicit handling for both AXIDMA and MCDMA types with proper
>     payload length calculation.
>   - Added WARN_ON_ONCE for unsupported DMA types.
>   - Removed the 'chan' field from struct xilinx_dma_tx_descriptor (was
>     added in V2) as it's no longer needed; channel is obtained from
>     tx->chan instead.
>   - Dropped V2 patches 4/5 (dt-bindings xlnx,include-stscntrl-strm) and
>     5/5 (xferred_bytes support) as the approach changed to use residue.
> 
> Changes in V2:
>   - Added support for MCDMA metadata handling alongside AXIDMA.
>   - Added 'chan' field to struct xilinx_dma_tx_descriptor.
> ---
>   drivers/dma/xilinx/xilinx_dma.c | 48 +++++++++++++++++++++++++++++----
>   1 file changed, 43 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 1b5b00f08c5f..6bf509d33e7c 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -651,17 +651,51 @@ static inline void xilinx_aximcdma_buf(struct xilinx_dma_chan *chan,
>    * @tx: async transaction descriptor
>    * @payload_len: metadata payload length
>    * @max_len: metadata max length
> - * Return: The app field pointer.
> + *
> + * The metadata lives in the SOP descriptor for TX and the EOF descriptor for RX.
> + * Field order depends on dmatype and direction:
> + *
> + *   AXI DMA:         [0..] app
> + *   AXI MCDMA (TX):  [0] ctrl_sideband, [1] status, [2..] app
> + *   AXI MCDMA (RX):  [0] status, [1] sideband, [2..] app
> + *
> + * Return: Pointer to the first metadata word.
>    */
>   static void *xilinx_dma_get_metadata_ptr(struct dma_async_tx_descriptor *tx,
>   					 size_t *payload_len, size_t *max_len)
>   {
>   	struct xilinx_dma_tx_descriptor *desc = to_dma_tx_descriptor(tx);
> +	struct xilinx_dma_chan *chan = to_xilinx_chan(tx->chan);
> +
> +	if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
> +		struct xilinx_aximcdma_tx_segment *seg;
> +
> +		if (chan->direction == DMA_DEV_TO_MEM) {
> +			seg = list_last_entry(&desc->segments,
> +					      struct xilinx_aximcdma_tx_segment, node);
> +			*max_len = *payload_len = sizeof(seg->hw.s2mm_status) +
> +						  sizeof(seg->hw.s2mm_sideband_status) +
> +						  sizeof(seg->hw.app);
> +			return &seg->hw.s2mm_status;
> +		}
> +		seg = list_first_entry(&desc->segments,
> +				       struct xilinx_aximcdma_tx_segment, node);
> +		*max_len = *payload_len = sizeof(seg->hw.mm2s_ctrl_sideband) +
> +					  sizeof(seg->hw.mm2s_status) +
> +					  sizeof(seg->hw.app);
> +		return &seg->hw.mm2s_ctrl_sideband;
> +	}
> +
>   	struct xilinx_axidma_tx_segment *seg;
>   
> -	*max_len = *payload_len = sizeof(u32) * XILINX_DMA_NUM_APP_WORDS;
> -	seg = list_first_entry(&desc->segments,
> -			       struct xilinx_axidma_tx_segment, node);
> +	if (chan->direction == DMA_DEV_TO_MEM)
> +		seg = list_last_entry(&desc->segments,
> +				      struct xilinx_axidma_tx_segment, node);
> +	else
> +		seg = list_first_entry(&desc->segments,
> +				       struct xilinx_axidma_tx_segment, node);
> +
> +	*max_len = *payload_len = sizeof(seg->hw.app);
>   	return seg->hw.app;
>   }
>   
> @@ -2639,6 +2673,9 @@ xilinx_mcdma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
>   		segment->hw.control |= XILINX_MCDMA_BD_EOP;
>   	}
>   
> +	if (chan->xdev->has_axistream_connected)
> +		desc->async_tx.metadata_ops = &xilinx_dma_metadata_ops;
> +
>   	return &desc->async_tx;
>   
>   error:
> @@ -3287,7 +3324,8 @@ static int xilinx_dma_probe(struct platform_device *pdev)
>   
>   	dma_set_max_seg_size(xdev->dev, xdev->max_buffer_len);
>   
> -	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
> +	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA ||
> +	    xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
>   		xdev->has_axistream_connected =
>   			of_property_read_bool(node, "xlnx,axistream-connected");
>   	}

