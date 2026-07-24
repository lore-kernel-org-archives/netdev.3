Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021083.outbound.protection.outlook.com [40.107.208.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC293655DA;
	Fri, 24 Jul 2026 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784915971; cv=fail; b=Qky1xEpF08PzarP4GyI6l0xFUYi7VF2LfFe7KVAYJPe2FHjqwOoT5ienR+t5LJZWQPcyN4kEh9pQvkWtJaJBApfSyorp0bp7IWfMkiIwGdO4m8tkDdrW/lwbi02/nt1qoF1SDrx6R1TidW5lQqSQ3DkJqhBWqUtoCJRRG52jg+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784915971; c=relaxed/simple;
	bh=vGO7JBnbyv+OawmURwxLyxLYUVBMtt01Y3vP9hQh3gE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M79BKADvz79lUYZn0XPmaHQTkRbc+7lrA1iiTlEXdjDF4/bGgn2B7iZsSOeHTr+IH8Ut6C8kmvKvs9+Jdy3SbJhOW7zjwFNLuK18wlsvVYM+d8P+gKVPpA0uJAFSKr8Y2HaiDPHCEo3etkc+0G+CoZgvMexoP6i0e4iiEbaLCPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=nDzsKUH9 reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.208.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="nDzsKUH9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4hUuwU887req0WT9ZlhP/Holc4X6LEFqsC8JsMQi1rEBpAk5T3ShNqUGg/igar65sGMDde1L808zU+KlNJVZ8FxBFcVIkSAZx6CGkyt7rTqnKtWiwWz7pjTZuiSAELA+QWq5PDB1CwbBZ3RA8jyvj57VUp2DEicWkP7i/r9drw1Mwr4/CCZ3sa2MhgiXUhijMai2zhdgMNgKPyX1+vteX1Z5foVvVmMXBVZPVRltcpE7O+rkW2dGBRD5Lg4yweUbiFuF2bAauod7vnrydS0QoNY0DawXXcKozv6ymH0d0gATBvALgDJCLRifUkCPHsOMR8P1Btd6jQftdkln+1J0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21IDRseflUWTGAjR4GIh07EGutd4QOWvRUnnZqyOAIM=;
 b=HJsU+cjGoPZjNmlQHoCZigcB7RZQtrBzii+x21LMeeN4ghEqxn/Yrg/QD0kF3kpXfsA3xrvvgMhs63Z7yCp93BtR9wPAfgrZy1f6rrBCAGGV3tjlCX7kbj8FhLlTrw8RMu3JvZKkWbGYBdO7UFT2Nf/QhcXw81KjDy3FNIsZNIBiYb7WPMPbu7qrw1TITUsDVIQvnZofrZvVAhXpmbOoNIrx5I9SXUamn3+bRwSJotkYuQd7oFKLhiLQ2bBUxci5YO1bTU0kRe7twvEgmQMpbvJCRiUBGzGToju1GXqU9c67bvm6KrC/jzSXcLLKYXp3C3+hS92BJAzNmdfoXVe97g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21IDRseflUWTGAjR4GIh07EGutd4QOWvRUnnZqyOAIM=;
 b=nDzsKUH9BraEZc02zXzu5c6Q79G19qh7YrtpCmBDekcth5pW5jtC6bQ7Zvdgcfhv2ZE7/HhKKXEYnLTsrj7EAEJJLAfmz2TBG47tdbHNAYyo5b8htDf670No27zE1dWAOf1rZLYfVvJdIRmp8Oyl0xDLpTlpMbG9ogh01c2D3IE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 DS1PR01MB8748.prod.exchangelabs.com (2603:10b6:8:212::13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.11; Fri, 24 Jul 2026 17:59:24 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 17:59:24 +0000
Message-ID: <7089dd34-18e3-4b84-a01e-361a4ce6cc43@amperemail.onmicrosoft.com>
Date: Fri, 24 Jul 2026 13:59:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v45 1/7] mailbox/pcc.c: shmem map/unmap startup/teardown
To: Adam Young <admiyo@os.amperecomputing.com>,
 Sudeep Holla <sudeep.holla@kernel.org>, Jassi Brar
 <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20260721175258.87600-1-admiyo@os.amperecomputing.com>
 <20260721175258.87600-2-admiyo@os.amperecomputing.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20260721175258.87600-2-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY8PR11CA0043.namprd11.prod.outlook.com
 (2603:10b6:930:4a::18) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|DS1PR01MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: 432c2ac2-0edd-45f8-5721-08dee9ad4b7e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|376014|7416014|366016|10067099003|4143699003|11063799006|6133799003|22082099003|56012099006|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IQ6JGO8VKK8SZMxy1PliLyFvM2lNmgcO2fRI8iEuVfN/8pZblzfQlOdD6AMJQ5FLBzxj1MjAwx8EdbefK2N7Vf/T7+XrK6FU+LKg/5XYZ9BAE2CD5M1p7IXUPbBilQfRpNrqABqI2dhyYIxrWFSkpDD4BKy3rNA0IkNaqgWuMhxX1UiU+m5AC8teDiM6gTokpt34YT6KGPPdKW04po5mqoKbGxUYS+adnwrdvNrrgeoTuWhuoss9iR0dcIepBe6Q4hWMpvZaZ1ulTTQEz8i0vOda9yjflqwJi7vk2hfUiR6YuGIbyCvXRGlZOuyLdKQHhkelbUA5GOUfAif9HOHmy1NInqA0d8kPiGKNrziJo6gaNjHDEfQZhvOGI75j+Sn48BbUma9d3xuXjVaoIiTdJ7W+hvEeZg6wNSO98Wg5WIJQHaowSFBlpguFWR174l2HKTmGtAqipQhD1fG0mpXZKj39D2GXkT19z5P/BmzsI+24sCfGEEL9AC0ptpKi2aTAYyoUkCfhMMO1luPDxYbJ/UB/mKD6jB5S+8C57bqnRX3/ACxATiWKGHDaiaq3VhnBgcpXCPKiwd/N0srPgelitzBlSQbK07uVlr7Okct3+coNs8rtcAh6OKJsoD1z0FO8efdfST19VV7JPSnNZPcuSYdaUt4msh7pS+tTlIBpP7A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(376014)(7416014)(366016)(10067099003)(4143699003)(11063799006)(6133799003)(22082099003)(56012099006)(55112099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVRCRzZjeXdpclpDYWFsbWxsSnMxbXdlcDZhYlBOWDZHdFVXbEoxYWpSWnph?=
 =?utf-8?B?Nld2WXZiUlcyc0NQcUE4VUN4VDZuQ3JSUlBmK1hKQWxBOEZTNVJQUHB2ZHdD?=
 =?utf-8?B?N1N5bWthQWs1M3BadmU2YjUyK3ZxcVJFcDdsekdOT2tXeU5KaUZyYXRuQXQ2?=
 =?utf-8?B?R2ZrcE8wMGJxVDM2b2tXTGZQTjg5TkpiZlRObzlFcmpPUHlKNjBNMU81a2Vz?=
 =?utf-8?B?MmYwcHJtUk5jeW5EdCtsVURZdzIzZmZWdFh2UzNiZnlnVllXOURJQndodGpG?=
 =?utf-8?B?Qld4VU9UOVFhN2F0eTVjWFREd3Y0RS9RQVdxVlJSME1xa0hWUElMdDV1SGtp?=
 =?utf-8?B?dXZnNmxwMU5qa1U0cDBkVElJMENLYWF6UmhZTXB4K3FYNUJKUUF5OUxqbEZy?=
 =?utf-8?B?NExBamVLM1hreW54S2pTVjQ0WmZOMVpWeUI2VnczaDIwUkRVUzVTc0tSbDlk?=
 =?utf-8?B?VUVkQ3VVdjY0WXpjVnRIajZ4ZmMvNFZwdXF0YUNSb1BmUmpYWGVpRjdhOUNI?=
 =?utf-8?B?ZHQrK2Z1djI3ejhKT3dhZ0FlcUtwQnZLbzFTWkYyOGxyanRlSzdaVERGQnh2?=
 =?utf-8?B?Y2hLTURBcElrd0NUZ2xHVWNJc1JuQWRpVDlvQ1lUUE5BOWNQV0xXY1ZvcHls?=
 =?utf-8?B?VjhoZ3dYRVFqYXU1dEZWQ0RYM2RJY21VSCs2QTBVQ2twQjBXcDJGaHJ5OEVk?=
 =?utf-8?B?MkxlUE1GTXlEaXp5RDhScjhaT3NHRXhHQVpPbEkwaFJXM3FtR2lwUVQ5c2Zi?=
 =?utf-8?B?d0Uzb0tGRVpxR1RQUmhQRENVQ2wzQWhRR3FpNHJYdktTWlU0UHBrbHRuRVVl?=
 =?utf-8?B?MTAyVmowa28yVTFtRkVKdG5yZUpOWUxnSElnSkF6VTdpNkxRckdLUEhlKzkz?=
 =?utf-8?B?ZVM2anl2akluN0JYQjJZNUJiWFFYL0M2WUFSZkRpS0F2VDFXbkIxOW9KdDJt?=
 =?utf-8?B?ZUNlUzVyZVpUODNRT2dLL3IxSnlPY3lHQ1RiQ0w1QzFZMW5OVHllMXlmY1RE?=
 =?utf-8?B?ZnVFQUt2c09xK2V0aVpmaEt6clhoSkxVVVF5YnFMalJBZnZ2K2Y2cUlQdmZ6?=
 =?utf-8?B?SGltL2ZXWXFJL3VsZzJselY1TTZWN3RDNnYxbk50MUpZZmlveFNIZ2RCUkRT?=
 =?utf-8?B?ZUh6a0xtbmFWT0Z3elVGMzgrWW10M0FGK2JhWW5NZWF4a0k2NllVTzJhTGFD?=
 =?utf-8?B?YmV0djN2SGNoMktYUVQzRjFzVWRGOUZDMTVrYXl0MHNxOVFmWVdvcU1XNUEr?=
 =?utf-8?B?RmV5M0xDcUw0ZEN2VXM4TGl6WnYvdFgrejQvajMwODlPUDIxRE9NV1AxeDAr?=
 =?utf-8?B?ZFhnRkFjbmNNdnVmN21Ua2RLQzRQWEpoOFM5UDR4TXM4cmQrcTNXQkcvRWpC?=
 =?utf-8?B?b0lVVVdJUUZ6aU1Ea0I2VGJsL25LV2thcXFMbkZ4WFl5TEtrd2NPLy84SEJD?=
 =?utf-8?B?ZGcyVG1BRlVucGtYeUtoM2VZZjBrOXRsRWtwOVFxbkZ2SjFjQTFCaUk5Sk5I?=
 =?utf-8?B?OFlQZURrbDc3N05lMjFIZmVkQWl3WEtpdjNsR0tzcWozcWErMnp2OWhtRXJv?=
 =?utf-8?B?ZUxBbnpaYTJ0NmVhSjJ3bGgxeXdocXVNMDRvVCt1b1c0VzgrSUVrSDJYM1E5?=
 =?utf-8?B?RHpTYWI4ZWl0NjQwUmV1N0NnYWJJRE52RlNMbzg2ejFRemIycHZYQ0h2V0Nx?=
 =?utf-8?B?L01CUmx4M0lpOVMwNU9PaUVLVTJtS1lvOTJkYVVIZ0UyUFRwQko5WCttMTh1?=
 =?utf-8?B?bXFZVTV0d0E0WjJ2MzgrY2lkRUx4d1lZVFpucW8vU0U0SjJCRmwxdmIvZ3Y5?=
 =?utf-8?B?b1NUVCtJSFJiTHRSZ3JER3VpZm96V3EwMGlBZ3NvM2ZwREdPNVZCc0lOSlpV?=
 =?utf-8?B?d2h3SWJwK0lPSTkwOTZSd21scGFpT3MxSThiQnB3SWZPZG53bld4RFlFUzBB?=
 =?utf-8?B?ejVkdDRmcU0xekJscmMvWndNcWR0bUgzN1JSeUttbjhDeDhwRXc4SDBlS0du?=
 =?utf-8?B?QW1QNE56WFJhSGYrQUdtVnIzOXREYjJCK3ZjQTdVc1NPaUJCd2kzS1JxUS9F?=
 =?utf-8?B?Y0R6UnFMOHRaNHFDSnBid0lpcFIzTnFJRnJJREl1aDRHeW9LazJHczV1c0c3?=
 =?utf-8?B?bmZiMzFmTmtGcVBNcmxTVlo1T2Z5cmorTW1LMFFqeVJkOXBINFliMysrNHFl?=
 =?utf-8?B?UVNIVExCbE5qckwvOVJDYU53T3ZPd09YSzUxK2hjaGxDaUsrK2dQRzk0WGVh?=
 =?utf-8?B?REpGcEoxOGRFKy9RakYybUw1T01sUjRHV1pwYUxGOW8veVBKbnFSZlBVelYr?=
 =?utf-8?B?SjBCeWFkMk93L3JSa2VOb1ExOXNHb1U1d2RQdDYrQmhYRU5GVEkzNXIzbFBN?=
 =?utf-8?Q?D5bX5+BFGJZj6ozwy/jYrsjE9cxgDzTVpGqwbA9dF8gkz?=
X-MS-Exchange-AntiSpam-MessageData-1:
	I+ww7MFoYuh9D8h6JtHBblJZc43c9Sr2ylQyOphXRJMfCpnkB1eO9Hoq
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 432c2ac2-0edd-45f8-5721-08dee9ad4b7e
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 17:59:24.0388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxWWe22/LsknQ68+fFFXsAwmu2b6i6PF2PGGAHyAz2FCmmpHPc7aDCWx0FfeCOUP6Cj9M4EHQaCnU1e4P8SnIQCRsSBcOD7b5inNoPawf8LAeMg8RL3rZzIdBqRKdO/K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8748


On 7/21/26 13:52, Adam Young wrote:
> The mailbox IRQ and shmems are not cleaned up atomically, so there is a
> race condition. If the shmem is torn down while the IRQ is active, a late
> interrupt can trigger a write to un-mapped memory.
> If the shmem is torn down while the IRQ is active, and another thread
> requests the channel again, we can end up with a channel that has had
> its shmem unmapped.
>
> By moving the map to start up and the unmap to teardown, we can let
> the mailbox mechanism prevent re-entrance into the startup/teardown
> functions.
>
> Avoid doubly unmapping the region by removing the unmap in the
> direct error handler for the request.
>
> Assisted-by: Codex:gpt-5.4
> Fixes: fa362ffafa51 ("mailbox: pcc: Always map the shared memory communication address")
> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
> ---
>   drivers/mailbox/pcc.c | 48 +++++++++++++++++++++----------------------
>   1 file changed, 23 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 636879ae1db7..da26578a8aab 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -360,7 +360,6 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   struct pcc_mbox_chan *
>   pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>   {
> -	struct pcc_mbox_chan *pcc_mchan;
>   	struct pcc_chan_info *pchan;
>   	struct mbox_chan *chan;
>   	int rc;
> @@ -375,20 +374,10 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>   		return ERR_PTR(-EBUSY);
>   	}
>   
> -	pcc_mchan = &pchan->chan;
> -	pcc_mchan->shmem = acpi_os_ioremap(pcc_mchan->shmem_base_addr,
> -					   pcc_mchan->shmem_size);
> -	if (!pcc_mchan->shmem)
> -		return ERR_PTR(-ENXIO);
> -
>   	rc = mbox_bind_client(chan, cl);
> -	if (rc) {
> -		iounmap(pcc_mchan->shmem);
> -		pcc_mchan->shmem = NULL;
> -		return ERR_PTR(rc);
> -	}
> -
> -	return pcc_mchan;
> +	if (rc)
> +		return ERR_PTR(-ENXIO);
> +	return  &pchan->chan;
>   }
>   EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
>   
> @@ -400,19 +389,13 @@ EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
>    */
>   void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
>   {
> -	struct mbox_chan *chan = pchan->mchan;
> -	struct pcc_chan_info *pchan_info;
> -	struct pcc_mbox_chan *pcc_mbox_chan;
> +	struct mbox_chan *chan;
>   
> +	if (!pchan)
> +		return;
> +	chan = pchan->mchan;
>   	if (!chan || !chan->cl)
>   		return;
> -	pchan_info = chan->con_priv;
> -	pcc_mbox_chan = &pchan_info->chan;
> -	if (pcc_mbox_chan->shmem) {
> -		iounmap(pcc_mbox_chan->shmem);
> -		pcc_mbox_chan->shmem = NULL;
> -	}
> -
>   	mbox_free_channel(chan);
>   }
>   EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
> @@ -462,9 +445,15 @@ static bool pcc_last_tx_done(struct mbox_chan *chan)
>   static int pcc_startup(struct mbox_chan *chan)
>   {
>   	struct pcc_chan_info *pchan = chan->con_priv;
> +	struct pcc_mbox_chan *pcc_mchan;
>   	unsigned long irqflags;
>   	int rc;
>   
> +	pcc_mchan = &pchan->chan;
> +	pcc_mchan->shmem = acpi_os_ioremap(pcc_mchan->shmem_base_addr,
> +					   pcc_mchan->shmem_size);
> +	if (pcc_mchan->shmem  == NULL)
> +		return -ENOMEM;
>   	/*
>   	 * Clear and acknowledge any pending interrupts on responder channel
>   	 * before enabling the interrupt
> @@ -479,6 +468,8 @@ static int pcc_startup(struct mbox_chan *chan)
>   		if (unlikely(rc)) {
>   			dev_err(chan->mbox->dev, "failed to register PCC interrupt %d\n",
>   				pchan->plat_irq);
> +			iounmap(pcc_mchan->shmem);
> +			pcc_mchan->shmem = NULL;
>   			return rc;
>   		}
>   	}
> @@ -488,15 +479,22 @@ static int pcc_startup(struct mbox_chan *chan)
>   
>   /**
>    * pcc_shutdown - Called from Mailbox Controller code. Used here
> - *		to free the interrupt.
> + *		to free the interrupt and unmap the shared memory.
>    * @chan: Pointer to Mailbox channel to shutdown.
>    */
>   static void pcc_shutdown(struct mbox_chan *chan)
>   {
>   	struct pcc_chan_info *pchan = chan->con_priv;
> +	struct pcc_mbox_chan *pcc_mbox_chan;
>   
>   	if (pchan->plat_irq > 0)
>   		devm_free_irq(chan->mbox->dev, pchan->plat_irq, chan);
> +
> +	pcc_mbox_chan = &pchan->chan;
> +	if (pcc_mbox_chan->shmem) {
> +		iounmap(pcc_mbox_chan->shmem);
> +		pcc_mbox_chan->shmem = NULL;
> +	}
>   }
>   
>   static const struct mbox_chan_ops pcc_chan_ops = {


This will have to be rebased on the changes to the base PCC layer, 
specifically to add the signature check.


