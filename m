Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549CC4AB1A1;
	Thu, 10 Sep 2026 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055483; cv=fail; b=Nr3EuRXWyvD0R5nBP7ISz9rfc+jZPQlV77dhWnitLJWdwYj+0rh4AEDb8IMDXuWB0hyRvZZlSikSR+i0kb/O5I/+oekAAlYsgkVuqiBTVCZcS3WuA9fuq2PpA1REMukvhh0c7cA188o5UYEj2ix/bqxEC52lMrNcyldSFmMGNQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055483; c=relaxed/simple;
	bh=q0gJcYDyT4XUcAHcplJhA0ossq6N9F+XWYEoKDnKoMo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WUywv8GkaPvDUzNcNejCdMe6OVOczOKBZgYs1VqH8rB+XhmUMuJWq0ofp/0G0PmvQzwEZN9Q+56eG6bODEfGZaeA8ntDYYktFMERrIm1neU2UqIeMO5/nwkB374P9E5l9zwANbvqYi+QvGhzV0Ii9TkjGiBDaz0ANSYsr9Em3hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ez78J9Dt; arc=fail smtp.client-ip=52.101.46.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ez78J9Dt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BG6004MDc6bT1i2Gs+hwP/+EfOD6DA8Nrp6YEM78xkdBpfO5BIJ030dyoVikTyucifKBKnfZVOFao8QPDDy5rU+x1FInQAyUirPWDb60hHk7b2h4Ys77Q8Zb+eluYtPJ7IL9zAQcKjoWOKelQdLO6sjr+s1rGNo0vzLggnQvAwpBZ7b3tiokYSpWxEZcM83hDoO205c7+j9CNtLAbyfZ8d5GHtoTzEkkg3Fnz+lrC1Kd4HC09aMDJmAfDIg+FGJl/24Bj8w6bgCAZpqO+9jMnva7SqEjOjnJB3+NvjCLdMzXS/It3wFEBR/P3rkglKzYmLTbQGpp4FtgtV0v+45OOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r80HMBEx+foDNWh1CWBDTbb3wlo7/5Xf/O0pXeHfY5I=;
 b=RyRPndaoIkyunL68BRIHQCOsgdD9Vk87qD77qamFiMGVPwmIA7Ml1IWdBAr4AnKHLgdmmCGeJZNoo7/z4PzzXfPQJ0AVM35U2JOI8+RQUZdBhMvJWSclsV9fOL4S5Cx8tKFv2FDdJcfaqdJ9kqYgYBpUm0JhZEYURhNRwemlRWhbxCuHIj7qsuPyPENLBgtQHJ5+v27pW4bCBtLQBm4LK4irULTfBCDJQOFZ668umEiYz/bFFyFFvPa/H2KYy6hKJHJ1XHKf+sXRbvkDekGixJGFYOz6zbogiUFmsvctkyJauQaEYOwgBGtyCNKcQJxT1AFVE+F+CmTDBUKYMEuheg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r80HMBEx+foDNWh1CWBDTbb3wlo7/5Xf/O0pXeHfY5I=;
 b=ez78J9DteK8sVNnmHpiHmTVLaZc1RGiKBzi4mlW9NDWLe4MaiCZ6QGvlhCpXQaLPnTit7X6DxoVIqXZHOVX+jJdXCnVReJBCyu50/jkVO3ku8/f5Ntb8jFfVnFZFyO3hXOGEKfXbeeSezZyNmQdB3yzHC25CVkyhkDUe8T8vVgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 by SN7PR12MB7953.namprd12.prod.outlook.com (2603:10b6:806:345::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 15:51:15 +0000
Received: from SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2]) by SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2%5]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 15:51:15 +0000
Message-ID: <2d436698-b880-4c8d-ba28-e7cf37d40835@amd.com>
Date: Thu, 10 Sep 2026 21:21:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 3/4] net: xilinx: axienet: Derive RX frame length from
 residue in dmaengine path
To: Srinivas Neeli <srinivas.neeli@amd.com>, Vinod Koul <vkoul@kernel.org>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Jakub Kicinski <kuba@kernel.org>
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
References: <20260818174151.1608971-1-srinivas.neeli@amd.com>
 <20260818174151.1608971-4-srinivas.neeli@amd.com>
Content-Language: en-US
From: "Neeli, Srinivas" <srneeli@amd.com>
In-Reply-To: <20260818174151.1608971-4-srinivas.neeli@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::15) To SN7PR12MB8147.namprd12.prod.outlook.com
 (2603:10b6:806:32e::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8147:EE_|SN7PR12MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 08c90e06-c35f-459f-d551-08df0f53589f
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|6133799003|3023799007|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	U1/ktCAEC8v+Bdm6jxSdYiYzTbSm53x6grLTEhVKoo3CAXUDvRAhcelaKWrVlXeE6C9/hUtbXr4ZXbu+50eMXCoVdirOB/3bx5gNss9w5vgIjNx4gET40BqAfKp1HTLX67LWwkwDpjYqJhrX6JuzWqS2UPpSgWAifUtb/RDXWMwsuDswLdh9UDMrch5VHTUTOF5F4jZvjGKJ1lebmX9SdJe4sT70zBpl/MJqc5ML9WXp+gVyQFUX4D9DQMxsQHRaqtCEX1a/sTHpPTvNMH9rbuwNgHDivLKPCZyYGehdv/qMMFHesmq7OCqs8zXKdECFmU7F49fsl2Fqe6ZSh8QojqzcIL6kgIrA29icOycc9OCZUvKZkQ9zMtI67DGF/ZnUREZ/+gw3GT5zL+xSH66DbSiFtZQXEGXNilg+I/Nb+HXRKpCupBL6MrnL9UIa+dRBz3bEfOS4U7DvHMGpOR0U1Ew1F3efUS6pz7Jtj1H8R5rP1CrY+sglThSCUOi5CUdImAdv1zFKksv7vXiasnUhj0L4yXHTJNaqmyuQw3Q2101uzoeXISuH9Kvs87wSQW+5eK2WE9mZf7IE/v4TtXISgAocWbqG0PIJD2jESWJc/mZ6nB05+AM+AZ0c1nBJA9LaviEuf84MMpWxHYSRBdDV1E2PbDJljircW4BJZrDqRQw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ek5zaGkybkthdERLOThKYjFJQ0toaTN0dEpEa3hyZFlKNFg1VGtPT2NON2JL?=
 =?utf-8?B?UlBYS1EwQkkzODdSbEsySzUvYUJXOFJKMGljWXV3V1lHd080RjFzeEJ5d3h2?=
 =?utf-8?B?Y1pJV05BakUxdHo4VkFuNGhIZHAxbWpUdmE1cUxhdStuM3VacEt1QWg0QnN4?=
 =?utf-8?B?WEJlNWlXVE9iYW1vQ05ucG5SUDJ2d0Y4a2FVL2wySHBhU2krajJEVVR2b0RR?=
 =?utf-8?B?YkhjYzV5bWNpWjdFVjUxZDRFTklWdHVmaFJEVmFWRmZwL09QeVBTcFoxU2Fv?=
 =?utf-8?B?amhqUlZhSmtKSXltOEUraVZjS0RocVFuQURnMWxpa1lFa0llaTlOdGVYTzdB?=
 =?utf-8?B?TlVqZThNRllMT0VLeW10V0lvNEVLcm1XaW9qcTlqQ2Y0Y2d2alYzbWtuUTZH?=
 =?utf-8?B?UFM4Q2ZGRXArTWZRcG8zM20yaVFmYmk5LzN5cVpZQWdLMEU4Z3JETHFUT3lO?=
 =?utf-8?B?SkE3RCtyZ0E0VEUvTWhvb21oWmM4UzJPcXVyQlJWTWhwdWt5WXZHUVJMb093?=
 =?utf-8?B?NGt1ZlpNT2ZpUWZYRFdsR2N2TzVvUDMxZ1dsQXpwcEJEQ3dmSSt5SldzTnlK?=
 =?utf-8?B?VGtBclNydEdFYUVETmxMTEJ0ZzRGY1kwOEo5RHorU2FhWFlodDg3dkxJMllq?=
 =?utf-8?B?UVBuWnNKcVhPdUNLaWpOblpJQnpUVFdPZVBtTGZISUpVMDhIODhEKzZqMG9y?=
 =?utf-8?B?ZW8yUWJiOUNLdWpoeDZURHQ2QjdpNHYwNWFoSG4xZGNwZ2V6WExLVzJDTDBu?=
 =?utf-8?B?NkN4d2tYdmFrV3dmSDdzbUZleVM5ZzV2TU9VWGJqZG5IQXZjTDRPMkgrQ2Nn?=
 =?utf-8?B?QjJ2K05FNWVuR05ucDBwbTlWU3VTUHZzZlpXdktTSkYrLzRZNmM4OWwrSy9E?=
 =?utf-8?B?eXh5QXJ2R0o1MjBWTVNzanptN25FbDFUUG1qc0dNcnJaVWxFZkJ0WVFVd0VP?=
 =?utf-8?B?ZkJDQjlMakJ4cDhpSGQ3c2czKzA2SndyUmV5clcweUp1dEwxWnRoN2JpN0Vh?=
 =?utf-8?B?MjdPT2JJYzNkcmk3S0d6SVNPZ0F1RDFyZ1k3NGYySjl0R2xpdi9FTCtqVStR?=
 =?utf-8?B?alUyTC9yc3pwNGNKYVM4bC9YcW9iRHEwZHB1REgzM2tsVlJPVXNqdTAvTUN6?=
 =?utf-8?B?Z01CaDg5TElZblNSNFp6TmJrQ3dhdXBiWWVxaVJsNGxCTngwYmZidmFqUndw?=
 =?utf-8?B?WThibzZHQkJObWptajJZbi9yanNDVkxCTThqRXc0WnlGWWZWSkt5M2lHbjM4?=
 =?utf-8?B?dis1YmV2UkFnRk1HVmg0YlJaS3BncU1JU3JZbERtRk9xU0NLa2VBUVRweHJ3?=
 =?utf-8?B?akZ0eTh4b2RXeE1jOExQUG1DUml4WnZnMUpnc0k0QUhua3N2Y25JRmhRZUo3?=
 =?utf-8?B?NUFRSVJxS1diRU9tSm5INEROb2RaTzJPenhqVTl5UVdnSXdnZ1FnN0VNS1dv?=
 =?utf-8?B?V0tVcW1sS1VIYlB0NXRrSlVzVmJhcmJPYVgzejZDMzF6WTNMQk1Gc1ZxQW55?=
 =?utf-8?B?SEc1TXZMZXFqOWRCZ05Qbmx6ZnJnMVJ2WkVOK2dDME9LelpvcDAwVzhHeUZ6?=
 =?utf-8?B?ckdrTlFuYzUyblVDdmNDL3R4RkxYNk8waWxnVG5nMS9mYmsyWXZXTEl2V2wx?=
 =?utf-8?B?elJqMVJ5N3BXdDI3WlNLcW5mZHI5aGtFeU9qbFRmRlZpNStYZFNjZzE4N21k?=
 =?utf-8?B?eDMydVJPSnlnMkNCZnFWZjNUM25Qb2NCWU5wRmo5S1hINnpsZm5tTEZ5T3VP?=
 =?utf-8?B?S0hIdlYwL2dzaHkwbm5ldU1VeWcrNC95S1FQSmFoRnNWUGxxdFlKQnFZa0FJ?=
 =?utf-8?B?djNMaC9GRjlwajRnZ3RqNGNGZE82QmFQWjRadWRlMHYxWktjRnBtRGFFVWpR?=
 =?utf-8?B?STFZMjBxWjYrL04zME5jTzFnMm1ydmFCdG5lYWRxOEVyaHhjVWo1c1JtalJI?=
 =?utf-8?B?SW40K28vdEtsblNpTFZUSGJnZDFNUkFMR1V1d0l5QzNvdGVKNnl0YzErM3hv?=
 =?utf-8?B?NXVzbkFTQ2lMM3FhajdSMUlocXdueGdhMFlBTmxMNFE0M2J6SU51TEtETGlB?=
 =?utf-8?B?ZmM3T1VyUDhRTk1rYy8wMzV5OTd5anVzVSs2OEJUa2s3enVwU0gwYXJtTVc5?=
 =?utf-8?B?NUlZODB3RmloQXVSeTFmaC9TcEtKU2NZWFlNbEwzbXcxNWU0VE8rT0ZMYUxP?=
 =?utf-8?B?U1R5U285RGFFemNxYk83NTU4d2Q2d05ET0ZneG5BMXpoSXJsbUQ3K0V3Qk9l?=
 =?utf-8?B?cXArdG43TWR5T0lzY1VudUhuUytsR1g1VllBdTUzTkpiWHdrUzNOMkZCcnV6?=
 =?utf-8?Q?1Niww1lpx5UQ+PL2ky?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c90e06-c35f-459f-d551-08df0f53589f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 15:51:15.6783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Rag2FnJUddB3yOuqMSQQSa7FhuX3oorFfo+f2Lt3qLtPdGUIj7rzeY6dI+V+1Ja
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7953

Hi Jakub,

I would like to follow up on this patch. The dependent DMA patches (1/4, 
2/4, and 4/4) from this series have already been applied through the 
DMAEngine framework.
Could you please advise if there are any remaining concerns with this 
patch or how you would prefer it to be handled on the netdev side?
Also, I noticed that you were inadvertently included in the CC list 
rather than the To list in the original posting. Apologies for that.

Thanks
Srinivas neeli


On 8/18/2026 11:11 PM, Srinivas Neeli wrote:
> The dmaengine RX path derived the received frame length from the descriptor
> APP metadata. That only works when the optional AXI4-Stream status/control
> interface is present, because the hardware populates the APP fields solely
> when that interface is enabled. On designs without it the length read back
> is invalid.
>
> The AXI DMA engine already reports how many bytes it wrote into the buffer
> through the standard dmaengine residue mechanism. Compute the RX frame
> length as the posted buffer length minus result->residue, which is
> independent of the status/control interface and correct across all designs,
> including multi-descriptor frames where the residue is summed over the
> chain.
>
> Drop the descriptor metadata lookup, which was only used for this purpose.
> Detect a failed transfer from dmaengine_result.result instead of the
> metadata pointer return value, and remove the now unused LEN_APP macro.
>
> The transmit path is unaffected. It still passes APP metadata for checksum
> offload and derives its length from the skb.
>
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
> ---
> Changes in V6:
>   - No change.
>
> Changes in V5:
>   - No change.
>
> Changes in V4:
>   - Renamed subject to "Derive RX frame length from residue in dmaengine
>     path".
>   - Condensed the commit message.
>   - Dropped the Fixes tag.
>
> Changes in V3:
>   - New patch in this series.
>   - This patch enables axienet to work on designs where the AXI4-Stream
>     status/control interface is not present. By using the standard
>     dmaengine residue mechanism, the driver no longer depends on APP
>     fields being populated by hardware.
>   - This approach replaces the V2 xferred_bytes mechanism (V2 patch 5/5),
>     making the dt-bindings patch (V2 patch 4/5) for xlnx,include-stscntrl-strm
>     also unnecessary. Both V2 patches are dropped in this series.
> ---
>   drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 1722b7038f34..f9252880f411 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -53,7 +53,6 @@
>   #define TX_BD_NUM_MAX			4096
>   #define RX_BD_NUM_MAX			4096
>   #define DMA_NUM_APP_WORDS		5
> -#define LEN_APP				4
>   #define RX_BUF_NUM_DEFAULT		128
>   
>   /* Must be shorter than length of ethtool_drvinfo.driver field to fit */
> @@ -1159,29 +1158,26 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>   static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
>   {
>   	struct skbuf_dma_descriptor *skbuf_dma;
> -	size_t meta_len, meta_max_len, rx_len;
>   	struct axienet_local *lp = data;
>   	struct sk_buff *skb;
> -	u32 *app_metadata;
> +	size_t rx_len;
>   	int i;
>   
>   	skbuf_dma = axienet_get_rx_desc(lp, lp->rx_ring_tail++);
>   	skb = skbuf_dma->skb;
> -	app_metadata = dmaengine_desc_get_metadata_ptr(skbuf_dma->desc, &meta_len,
> -						       &meta_max_len);
>   	dma_unmap_single(lp->dev, skbuf_dma->dma_address, lp->max_frm_size,
>   			 DMA_FROM_DEVICE);
>   
> -	if (IS_ERR(app_metadata)) {
> +	if (result->result != DMA_TRANS_NOERROR) {
>   		if (net_ratelimit())
> -			netdev_err(lp->ndev, "Failed to get RX metadata pointer\n");
> +			netdev_err(lp->ndev, "RX DMA transfer failed\n");
>   		dev_kfree_skb_any(skb);
>   		lp->ndev->stats.rx_dropped++;
>   		goto rx_submit;
>   	}
>   
> -	/* TODO: Derive app word index programmatically */
> -	rx_len = (app_metadata[LEN_APP] & 0xFFFF);
> +	/* Actual length = posted buffer length - residue. */
> +	rx_len = lp->max_frm_size - result->residue;
>   	skb_put(skb, rx_len);
>   	skb->protocol = eth_type_trans(skb, lp->ndev);
>   	skb->ip_summed = CHECKSUM_NONE;

