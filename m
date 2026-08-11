Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2291B3921D8;
	Tue, 11 Aug 2026 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473990; cv=fail; b=YOl0kMyUD57FGa4jG5J5AAv7ldm/iVyUq6oK8Kq1MzaQmZllRbeVGmz2s5eiDdc+17RYkGA0+HSbvP9pwDfjHSohR2tK2ZoNQM+EBYq/Ulbg23zfGgKITmTBddTG6dGSefwvtSnzVqmjUWCpNSa3q2mntebe/uG405ef8yGRDVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473990; c=relaxed/simple;
	bh=i4WNGCW6eeFkyC3B1+ybDkLdXFpjAzp22VbbTCLahto=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rp6+QKNMm6EODAgQYq0MdQKdHGW79kIDUlo7JM1Ujoa9W5cR+LSf4GC9V2nDCjpTuC/FYvmWogmAJHQcPKEm3uCpXyj2iNBwueePERLoxTsIHBjzHgmEiS+cO9e8SCxqV9ruDA6sRQ2y9O8DbLvL5VzFpYIKQsfLO7ORNgarDh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ltmjq+ET; arc=fail smtp.client-ip=52.101.61.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ltmjq+ET"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Shksh/xN907U4WVfxzUVySu7XxYS+qW0UUqbeMDtEvi9HsHxsfNIPfbDnRwaW8GVjTI2oAfD9UbikKBTKGQ6VG5homBZoA8Rxn2xlRNyBmGSdZACygj3lS31ha9z6MVvsK9kuLRDIyS5luizS1VNtqLDYkNYbi3E+4q9CcDHopBlinM1OWQSmw2kwqhLZyukvV/lsXRpB2V1AQPxg30+QsQaLxrUAHvF+vVZ3RmxmLR6k4zR53tV5CcfjOyRPXJzFakwgO96I8lwNi0gTfMVUqK4bHzCw/6hoSp4hQl3CFjYYDmWNvU/gWsckm7QyOdqcao581Mv+DRfCF/xtviA9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbloDR2WQVJ8QNqHebnguOgcJWHqVpnNC3YNpSuJy7g=;
 b=I4ilUPmm9QlxI1SmJ1ehfiExun1WhW262WBsPP8qRjFxZfSd54rDrlT0bx5ht9weHJFEbmQVlKMKyb31GmPpaNw3czjFMcrYlevIPwgpE8Od37gHHa7ZyCkgDdWEYmittn2POqaH85GUijXcGRByx3mGungRgTvjwz2gFODnlXt/UzRF+3uTBptXYkxg87HsKejlFxLMFJbRr+Au/5fW/3nx8ruEAKY7dm1EiKlsGGlSG9yo+hH35o86C8X8eSS4PYjjl41ZCxIVYPWo6ZpFOrKjB0sidYaJb6oZf33pIB94b60laVEuwqgQOPgr1JR+urvMKVpGj8gSjzYdgYX/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbloDR2WQVJ8QNqHebnguOgcJWHqVpnNC3YNpSuJy7g=;
 b=ltmjq+ETWZ0IhEmXmsSrQcNcnVAL+lXopOeRG2Cxsi/N5LXbqZSipBheltuWp035UnBy4mykY5yXUE0kexjLLknPvlMNASrAzSzBNJ2EZa7S6WJVaZ59OZucuB2ijQE995/YGEERMRB900HBdBJualTt2vrW4wjA6dtPhnaepooBDF6jTtPZnCqdmu+DlhbM1rASQG7qpWLvPCRJ6DmAjksYxT3TYWDgnYtF8C0T6vRAHf/Q96Y9Xr5g1QQg2j0SN0ewrKUKmnpis563hRmto8S99+SGDX6MAoRC7CZIhMYLWHqIu9gsX1ZFRWtEZObEi/kBT0UplO3iba7GWjsAgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by SN7PR12MB7785.namprd12.prod.outlook.com (2603:10b6:806:346::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 18:46:12 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.21.0315.008; Tue, 11 Aug 2026
 18:46:12 +0000
Message-ID: <0ba50bc1-d7ea-4874-9bee-acc8a3f89bd7@nvidia.com>
Date: Tue, 11 Aug 2026 20:46:08 +0200
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next] net: devmem: add netdev_has_dmabuf_binding()
 helper
To: bobbyeshleman <bobbyeshleman@devvm29614.prn0.facebook.com>,
 j@devvm29614.prn0.facebook.com
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, tariqt@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260810175446.3945358-2-dtatulea@nvidia.com>
 <anpN3vJUig93aSB8@devvm29614.prn0.facebook.com>
 <dab8a7cc-f202-4975-93a7-7e80a386e214@nvidia.com>
 <aeafaafd-29bf-4e17-bfb0-e61e6690477b@nvidia.com>
 <anthYJ3RSVWnhVoE@devvm29614.prn0.facebook.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <anthYJ3RSVWnhVoE@devvm29614.prn0.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0277.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::9) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|SN7PR12MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: 8399f05f-cc98-4940-b83c-08def7d8d0cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|18002099003|22082099003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	P36TXp6Q1mDKS8M1eG7150ATDx1kZjGoCQrNm7HV1D9ya7ATfXPqzFAi6hYm3V6n0Yb1Qpzr+1FVRKnBYpkIT0LtLRpZmB+IvuF0vG/xxXOfhiEmKMSKeYqg0KKh5O9w94XVn+ReEXdjGOmb5EEyAKDH8Fqw3YdupTKOe2Hmc+i5hQGjxHpnFyCc9NFMVPYIAoTdkyKCUUZvVE1+i60iggT1DG7h59pnHz+FhDgsvxsGA3++z3cmONG9/9/iK++lFS2fEO5Kjr3n4L9o00cbpJH4qaOZ0ZbuhnVB5vY7dvyE+ayr/LJmUd60UB0ifHeGrl0gdqxvkjDikESATNxEb3Cxkp1bR1USqvxJAJbZSYkvUnuEWMZBePMJtSm1F4BLFLPXMjMeo+OcWCX7aATUfkZxEPU+nXX4Ye1/nwN3AsDKQqHBbid1dMgRB6rA44UL6O+Xf1XFQKm0+bA4A/MSLMhFv1jGs38to5dcFZD6eYLKZZZ8Go0ANZjLYoGXk4oGbizOSJD5DJZhxFUadqV+oE1tZuhc691I/eQ8TaOV06BtWNiEKQ1Yb+QtWI8XponwMcQS4HZZ5IULzdMlyNPa2s14tVraTYUA2dyk+na9EgOBS3+gNmtvCMyFTI6U5AR1SumYQV0uS5TAYhZ1bN40KOKGposze3XygApdyN62UBk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UG5mYmxoMFk2VnNPT3orWEZRYmpqc3Q4Qkwxc0wyWTY5dURiV0dHYU0rZXZm?=
 =?utf-8?B?SlF3VDlRaVNvcEx0dFN6T3BNVkYwWGFISmtseFhZUzdPS1I3U1NZekg0dmxm?=
 =?utf-8?B?RXN6TlRkRG5iNVdwZlE4ZHQ3RDhJdUpNeHFmVEkwQTljT243TEMvdHZJWVhk?=
 =?utf-8?B?MUhvSkYvZTZtajM0MVN5T3VMZ05ncXpyOWdaaWlUMVoyOUNTeU82ZEh3WHlX?=
 =?utf-8?B?WU90bFZITnJhdTRpMmFpeWw4UlFsN3FjTzNxTHl5bStPZGFYdWRWcDNGK3ND?=
 =?utf-8?B?MHpxOGlSeC9hSlh0Ly9NSU0zNVlJcWM2T3hTZzhCakRNMGRRUjhWMXNBRzd3?=
 =?utf-8?B?aElteEtPK0xIVVlEZTNtWjdtUWROTkloTDZaNFhkNU1UekMwcEFxaFJYR2JQ?=
 =?utf-8?B?aDBmTWljVGtpK0lDay9qTExmVXhOenp4bFZtNGRkNFk4KzFBM0M0N2RsRjVh?=
 =?utf-8?B?UndTaGI5QjNVZkprV0FPUUNOOXN3ZG5FenpvU2NZRGhta3Q4aXF0L1ZLOUIv?=
 =?utf-8?B?TXhDRmYyMEtWc0NHN2ZaZGxXajFUZHdLZlVFTFpiZmpPbmd6RlVjUjUwZHUz?=
 =?utf-8?B?UElVVmVlendvZDd3QW4xSDFxMElqcTYya2NCTktNZFFidTFnMlV3R3NpYlNa?=
 =?utf-8?B?bTUzeWNwdVFZL0xFU1FLZXNTNFEzbThrcWNYT2U1SHlHbGVSTGIrV3RNNnQw?=
 =?utf-8?B?cGMyNHZyeWN0MHFUT3RUVkRhMzRzUVduM1BTbTRIVDcvM05kUk84cFpuVFg2?=
 =?utf-8?B?RE1UcThhcEU1b1NVYjllMDNaRlNvendJcjRLZTlobDFVeXBodVBMbGliYjZV?=
 =?utf-8?B?ZEpwVXVmMUoySmx5MVptWjFraU52eWFSV3dNRFNNdThTemN5OFlvRmU2dURj?=
 =?utf-8?B?VVUwUGNaTzh3WlVUdFNGdURHMzhweE16d3lKMnVFS1dYbCtuclVmN1NjRlZs?=
 =?utf-8?B?VW9HMW55dFBOVldGTEY2elBQd2tGakpvODk3NDFSTU5HWjgwOGZMcy8yRXpT?=
 =?utf-8?B?VlQrbWwrczBaMzJwaHh6cEVqbUdsdWRXYUlrSXlla2Z4ZHBLYzNwcDQyWjQv?=
 =?utf-8?B?V0Npb1crVjdpdVQ5dzQvMUpLVy9lRjI0TjhHalhleTFnSm4xVzVib1ZBcGI1?=
 =?utf-8?B?OFg2bjkzVTMweS9raG5zTHNnUTVPdTBGalV6UHAvZWFVZllpZVNPWUpwVzBq?=
 =?utf-8?B?VWMzbkJVRXhEcXc2NFNHdDQ5Q09LNFdHcW5PbVBaS2kySTRWd2JQN094T0t4?=
 =?utf-8?B?SGJ5M0NnNFR0QmhKMFFySmh0WFFxTmcvYVlPMUU1aTM4a2dKaHdiRTdPL1FV?=
 =?utf-8?B?RUYzQXZnVGF5SCs1MW5mNjdMdnBaYVFrWmpML1dlU29WdGtSUURtNFNIQ0sr?=
 =?utf-8?B?dkl2QnZNQU53S0NBTk11WUpPamRBa3JFSGtLY0lLU2xadzkvSkxKS0Vtblp0?=
 =?utf-8?B?ZDc2MDY2QjErWWJDdnZEYXlNY0pNQVV0Q01mTGRMd2x2bzBjcVIxa3pTQy8w?=
 =?utf-8?B?a25WakFsODcxMXM5SVdLaThMQVlhREs4djdXTmM1bGNoNGd3bFd0YXBYMU1U?=
 =?utf-8?B?eWVDQTV5N2R6NXlGL3IrVXlKdU5pcjBYMDJxVUFIdzdlOHdTZmZKSlVvRGdk?=
 =?utf-8?B?cndOVTE3bHRnOFpIaVZIRkhCS2NJZ0ZOeTlpNEpQd25CaVZ5cFdTdjc0T2hT?=
 =?utf-8?B?Q0pKQnFJR2NRRXVQLzNUZjFyc1hQcnJpdU8zVG1qdytMNS90emFMTUpuMmxs?=
 =?utf-8?B?elJybGNPUDJlQnYzQTl5eEVQVmlIWitvZnR5eTBFWk5KL3JBeVdWZXRxRFpx?=
 =?utf-8?B?WC90bUtpTWpGUDI5aEt6T0Q5ZUxzMHNobGJtTG00eFRCL0xJdXdoSi9KQ0Fv?=
 =?utf-8?B?Yk5IdDFMYjlQalR4MXZMMnc4K0xuVHlIN2JXa0Vsa2ZDaGt2MlBzUFRpTFB4?=
 =?utf-8?B?eVUxK0p3c1kvL1NXNE5iTHFjZjl6REl1aUJXNnhHMCtUUUN1QklWcE90c1cw?=
 =?utf-8?B?OW9KYjhZUFNwQitWcG1xMmx4dUFZYkJrZHdiemE1RTJlc09COThFaTJwRk9J?=
 =?utf-8?B?TFdrRnhwRkRXSmI0MnhoVEkrVGdJWk56ZWVsZ1RZSklUVThEZlRSWFI0ZlB5?=
 =?utf-8?B?R2N6bXNJc0g2NmRrRXpyRE1OOEJuYnoxY3NoZ0l1TFZSV3ZGcU9aTk8raWQ5?=
 =?utf-8?B?LytEdW9aeGxpUVFhUC91dmhCK0I0ZnB6eFFtaEhWZXlMck1KMjNFWHplVUNN?=
 =?utf-8?B?MlNvejVRZGJ6c0FCSVR6RjVJTVhxUlh4ZWJSMlpydVZPakVOL09ZTTdTS05Q?=
 =?utf-8?B?WTZ3Q1d4dElnUkhVclJvZHQvUlNrdEd2RnNKNXN0c1Qyb2V4alN3UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8399f05f-cc98-4940-b83c-08def7d8d0cd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 18:46:12.3971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dsrH1M61BHwiry87PHA3LmDkmPaG95j45sJ1Dd6Ram4SXLUF+/UdBczFKIQ1sD9AsDMPlTedbQqhamy56e0tqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7785



On 11.08.26 19:52, bobbyeshleman wrote:
> On Tue, Aug 11, 2026 at 12:44:07PM +0200, Dragos Tatulea wrote:
>>
>> On 11.08.26 09:24, Dragos Tatulea wrote:
>>>
>>>
>>> On 11.08.26 00:17, bobbyeshleman wrote:
>>>> On Mon, Aug 10, 2026 at 08:54:45PM +0300, Dragos Tatulea wrote:> [...]
>>>>> +bool netdev_has_dmabuf_binding(struct net_device *dev, struct device *dma_dev)
>>>>> +{
>>>>> +	struct net_devmem_dmabuf_binding *binding;
>>>>> +	unsigned long id;
>>>>> +	bool found = false;
>>>>> +
>>>>> +	rcu_read_lock();
>>>>> +	xa_for_each(&net_devmem_dmabuf_bindings, id, binding) {
>>>>> +		if (READ_ONCE(binding->dev) == dev &&
>>>>> +		    (!dma_dev || binding->attachment->dev == dma_dev)) {
>>>>> +			found = true;
>>>>> +			break;
>>>>> +		}
>>>>> +	}
>>>>> +	rcu_read_unlock();
>>>>> +
>>>>> +	return found;
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(netdev_has_dmabuf_binding);
>>>>> +
>>>>>  void net_devmem_get_net_iov(struct net_iov *niov)
>>>>>  {
>>>>>  	net_devmem_dmabuf_binding_get(net_devmem_iov_binding(niov));
>>>>> -- 
>>>>> 2.54.0
>>>>>
>>>>
>>>> I think netdev_has_dmabuf_binding() can return false even when there
>>>> exists one or more in-flight skbs (e.g., in sk_write_queue) backed by
>>>> the txq binding (won't technically be inactive until the final reference
>>>> is dropped and the binding is freed)? If so, can this still detect when
>>>> it is safe to swap the underlying dma dev?
>>>>
>>> Oh, good point! I didn't realize that the binding is refcounted and can
>>> outlive its xarray slot.
>>>
>> I can only think of adding another list that tracks bindings for their
>> lifetime or between xarray erasure and deletion. Not too happy about it
>> though.
>>
>> There's also the possibility of iterating over dmabufs and their attachment.
>> But this requires a function in dmabuf to scan the dmabufs and attachments
>> under the internal lock similar to dma_buf_debug_show(). But I don't think
>> that will be accepted. So this is even worse.
>>
>> Thanks,
>> Dragos
> 
> I agree, those options aren't great.
> 
> Would it be possible to drop these skbs (based on some comparison with
> binding->attachment->dev) in validate_xmit_unreadable_skb()? Not sure if
> we have enough context at that point in the TX path?
> 
Even if we would, I wouldn't do it...

> tbh I'd lean towards your idea of adding a new lifetime list, if there
> isn't a better way.
>
Ok. Will implement the lifetime list (or xarray) if I can't come up with
something better until then.

Thanks,
Dragos
