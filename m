Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012010.outbound.protection.outlook.com [52.101.53.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422743AE6E6
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784136825; cv=fail; b=cEGFOmxXg3fOhLAzwHNzF2IWHcpPi0ZZ5BAMGX5YN7XrrjUdXs1BULPrw8xdx+Qr+EUHZsos6bsWLcJpk8kBy9uXJ3kedJGV/zX/yiV4DRtlsMW/1u1ZMv3MkEAH0om1tOa4T8O45UmPjpnabu89hy4PkSX4BKILH+SlrJq4M24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784136825; c=relaxed/simple;
	bh=sTgVgrY7QnLFMS+aoFILHEc3dnhRXaSOjBRo+MDFJoY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mQIMO2zL/GqZwpI9Iu/oA6+ibO6gzoosBZ8IjWJeyWB4hn3ttLgBqpSkwl4Ut4f+CgNc1W8hOxGAc2xqXepad4cBBccfR/gMRuo4xcbfuc++ZwgqxiwtFsphH4KyPDo062LuuaX5DjkYFHrjREEdwy1GVWmvLJMyp+wFG0wO0Xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GF0vP1FQ; arc=fail smtp.client-ip=52.101.53.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GF0vP1FQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yldw/1Nizv/V1yQLta8Y8YFTi2B7Xk7k0Eu7YfS48U3VG11FtfzXX17oeJ6yexZUchFFiztOKY1NGeJ9ZQ7j557wSq8X3mX/hpaylhkJcPNfIC/6lwITSd05rWEA9k0qCg7RxppHf+vtc21Z+KdI3csGNVY8a2s7TYQ7oyaDrDvp5RI4gzd6BaSCH4CmWRnLNsdwPTzoNC5xttG4UMax9t2SFuZhkmZv/bqWW65tlWjXmhzIeuHJDqCoYMR4cc5c7FgQQFcvBPLXQewte3a1cWvbBJmo5gmue24BvF6yjoWEJGVyS7S5HVdIOQYB7MnFPmqjv+BQyCz73exeseLHrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHY1SdI6VwdvqyW+XEsfxv7xfPl9x8NWWOay3+Lh+Ks=;
 b=IP/2zsnlIVeDZqqul4ju4/ho+200pdSnxrN5fvrhU+B4KUn7xU/ZYN0nIJFCz9f3xyZEUvV+fYBhje/H/LHOqPXvFaXDpCiBjTlsNPvXzPgJIWHNc9WMv4HRX1EWL6B058sCZjMB6VbArr80DA4uIARkyXO1K2f9n0b5lIQhf+34P+x7G3MySRw881BYx6TssNtnpXxLEn7vW2VOgZ8f2Nis/IWeqdre03++NuGvzIhxmbo5zOH595CKpn1HvETMzGwumBjSfcI54yY+iCxBrXBT8y8TaKTYliSR22D79thiyYXeo8CQIdcVScSDUeYSNamu7T154MJqsnsMdI5Jzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHY1SdI6VwdvqyW+XEsfxv7xfPl9x8NWWOay3+Lh+Ks=;
 b=GF0vP1FQ/lO0zQFymAVsBs9EAJDbAgXNfAEm70ptYFXu9GsD1ETRDdI9uz4Ub16mPH2iL32lbPLi58HkVKB5f+w83S3Yumk22U4BMLJp4pNPUxHFVfp31/Q/cOWR11ImP1HC1r3egkbRm4Us++3ZG7xDzqE/L/G4xWsxnpF8Mm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) by
 LV2PR12MB5823.namprd12.prod.outlook.com (2603:10b6:408:178::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.12; Wed, 15 Jul 2026 17:33:38 +0000
Received: from DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a]) by DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a%6]) with mapi id 15.21.0202.014; Wed, 15 Jul 2026
 17:33:38 +0000
Message-ID: <716ab63a-1683-44c9-8646-2a5f706dc0cb@amd.com>
Date: Wed, 15 Jul 2026 10:33:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] pds_core: fix auxiliary device add/del races
To: Pavan Chebbi <pavan.chebbi@broadcom.com>,
 "Nikhil P. Rao" <nikhil.rao@amd.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, brett.creeley@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
References: <20260714210745.1785625-1-nikhil.rao@amd.com>
 <CALs4sv1dBCLDtWBrYLizmKH=E4+ZNgNCmyubqd46Yk9OHodrbw@mail.gmail.com>
From: Eric Joyner <eric.joyner@amd.com>
Content-Language: en-US
In-Reply-To: <CALs4sv1dBCLDtWBrYLizmKH=E4+ZNgNCmyubqd46Yk9OHodrbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::17) To DS4PR12MB9708.namprd12.prod.outlook.com
 (2603:10b6:8:278::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9708:EE_|LV2PR12MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: 08529989-d461-426f-b9a6-08dee29734c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|22082099003|18002099003|4143699003|56012099006|20046099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	6+dw4iIXnedgzzQ6hKOs7uzAXqV9bv6I1CgQFno2SMHqv8L9H52LNUBo5BxnTADKNrqMPnpgBoeDUmlMJE9D7Mv5HcT2sGv67ENhf6idU49L7SsRmi2Z4RsmstFx/rFiA4AforlN/GFIF/3zMvs/X2Rsi5ztSXznMGxNCubsZCQh37+oaII1bqOWHSKg1b9J6vS69Vu0jJFhaaBa2IiJKbUMudiqndCnsGoIoQcoIStk0SNmIeNpwIaWt9EYZCupkL2U4VUO+jvbRwpznDPTKc4A0BQgoy4a0Tw5nupOhlAHrD78kb3SrPUMsimuJWrzXhmLnZXHHIENWg3vC6QIrQ2x4nnGhhfav2ZcHcmPHV4RW4uz2JoH4Hb4CDfFCWdAumC6DfDWhqx5ZFZUu6WXWihpsprlByZTc/t3a7f41hrQFNoXT5TxmQupe3za8OWY/1COnZjyZU7REEE+5zHZ2tLfrGZWeLW6UWryGecIJcdePz5UvgISLq4qnvysYNe89kawr7DpdCxe5ZrXKwGuhQYhZv0sQ8mv7kW4t20RzKtJ+fkz45hs4RZ8wNNN4GtNLG+wqj20G8rJjxth3VxrO+DPrtBd9rnqmvozVGggyVmbaoiXdASdWHsgPdl/Jl9J8HgEhDBRcGnhfweIns/SW0LzDh2ZRNwtmJ51SoDMrvg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9708.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(4143699003)(56012099006)(20046099003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnRWUDFsaHhSTldwSDJNOXg1cXNvTGhKSmlGcWFzL3c3ZUJhMmhMdjJCcm9o?=
 =?utf-8?B?T2gwamNvbUFIbkk2YU9nVlBwQUN3Z3lRdWNZTXdJTlRTbjZ6bENPZGdVSzBn?=
 =?utf-8?B?QkwrQmlhMWZ0bkQrbHdpMGFyZm9IR3doUnczUUE1LzE2Y1d3V2JPd1NFdXVZ?=
 =?utf-8?B?NmkyUWxac0t3WGlvd2UzR3IrMkl2UEdRQ1J5TlRuMGcyWFFCNlZHQis1VWVk?=
 =?utf-8?B?dEEydm9zakpOQnJoZVFFMHJPdU5IZXJiOFV0a295Z1NWL3diWXhHaFM3ZnFo?=
 =?utf-8?B?NmkyVnRxMzJTdEhSREtmYUVwNmxaOUpVQ0pzMTlyd29yT0ZXeFFtV2FYUGl1?=
 =?utf-8?B?eVQrQ3o3dU01a0I1T0Y5S0lCZGxXYjBac0FXZHNYYy9na0Y4K0lFTEhJNW1h?=
 =?utf-8?B?VVpsaWdUa0lMbTJwTkt6YWJxNUJYbWVMUmhxMGZUMThsWm0xLzg3SVZkVUhS?=
 =?utf-8?B?NkczWGVvd0dRaFh5aFVlTExhYkplNE9NNndtdUVka213ZlB3Zm03Y1R6YWNo?=
 =?utf-8?B?WlJhRFI1dFQ3NWphZjh3M3h4RmhaVHVtWVEwMkh0dWZJWDhpMWU4bUJoYnhB?=
 =?utf-8?B?bFJONGI3Qk54ZTlMOXNUcEFkdGI5eWFrM2ZkRzRHS21zK3dYenQvL0VIUlZo?=
 =?utf-8?B?aENUYS9BRVc5MUxDR2JQTmxiZW9xMXVrZUdRZURyZ0EycFdkOHhOclptcTdv?=
 =?utf-8?B?akxJeEltYjRmU1hiNWpQODg0NEhvSVhzYkNBWFZ0Q1N1bVJ2bkYyWFB6WWhV?=
 =?utf-8?B?aVZSMGdWSnNDNE5yeG9LVk9jNHl1NXZmOXZ2VWQ4a3J6bUtWL1c2MmRHQXJP?=
 =?utf-8?B?RlVCd2dHTGF2TForT1lqeDRrWWFPS0FKOXZWK2p3QjFBY1hyU3pEckVSTjNs?=
 =?utf-8?B?ZEI5WU54M0xXU2IrZXdvY0JRYk1lKzloWUtNbmJKSURPWXZhaEpXTnFUMU5L?=
 =?utf-8?B?cnlrM2YwdCtZTjluazQ3dGFINk9zeWVkeFVmOWgxVkE1dmdvc0FCK0hDL0x0?=
 =?utf-8?B?bDdFRjNWU2t2bXlwMEZaY29PaFFVdnRxQ2p6OHJKVU1SQk1NblRlVExhaHBy?=
 =?utf-8?B?bkxLcEh1ckxHRXRERFBmQThOUGQyYXhjSnovMXFaUnlxZXE2aVBkTTNyay84?=
 =?utf-8?B?MHA1dTdoRnovZjJZNjlwYXpnMVhsdnJMTnhkV0JnclRzVUZqSVcwTTd6VjhM?=
 =?utf-8?B?UlRRQnY1eW9aRjVQRE9RT3NNRDlyWjRMcTllVnV3azFsdWp3c0JkMi9lTmdh?=
 =?utf-8?B?SGpNb0xCVHo2NWExcDF4emFhWG1SYVJMVVVMY0FWM05KSnRNUEZQNGtPVCt3?=
 =?utf-8?B?SndPMFhHcXhRWXJ1TXpGSUxROVJjdVFXUWgwUU5xbldUV0pRZFZXc0NEMjhK?=
 =?utf-8?B?QVNIUEl4MHYzeTV0MWJyVGdCamlsV1ZkRTNzTVJQNm93ZnZOYkZLenhVQTVR?=
 =?utf-8?B?a1dmYTZIbVg3VFJFdzUzM3g1VHJpTWR5bWYwckJENXZLLzFRLzFianNWT2Ju?=
 =?utf-8?B?c3p1S0xzdkxBSFlHNTgwUk5aeVJ4RlVjQTNwUkNRR0JBaUpqa1RXdW1tUTJI?=
 =?utf-8?B?ZWk5ZHFxV2FibjAvcW1SYzVGZlFhOU1DSXBDTlRSRmpWaEtXdGNxeVNmd2Z0?=
 =?utf-8?B?aW16bWhGUDkxRVFDMkFjbTZPQ1hGdlRtMkxZNGI2L0I3eEtoSnN4ODlkS0JG?=
 =?utf-8?B?Zy80TEJBWjVoRnZsTXJWRi9YL05WSjhNdVN2YXp6U3E0MS93bFp5UjRoSWJQ?=
 =?utf-8?B?MFV1VW9ocHVxNjZhOEdUa3YzUG9INGdOWk5yMVRFL0didjF4NGk4Y2p0OGZN?=
 =?utf-8?B?OUNoS1htMUc4OG52WVJiWHQ4bVhBKzNsT012YmN2ZEZhWEs0OU1UT0wxRUNj?=
 =?utf-8?B?L3Ixcnk1NWVDWmRRNzkxNG1ndVRFSmtVQzdORVpuNXB1ZDRWa3FDaytzcW0r?=
 =?utf-8?B?UzUzTmtqQm5QZVdCQlF4cjQwMUZ5YlhhZksxZFd2YVhnTjRIQjl0UjJXNnBw?=
 =?utf-8?B?ZFQ1OWIyTzV1a0JBREd2VGNWS2N1K3l1NjRodDlCZG4rTzJraUlDS2E3Q3Fn?=
 =?utf-8?B?b3VnMzU4QVZoMzY5dGZsbEtSdHRXZjJIQWFqajViQkN4V2gxVGxoTTd6cDFO?=
 =?utf-8?B?QTlBU2Q4bUZBSW1kamgrTjhlMmxHSFQxbjU0WDc5N09zamxwcERac3RydWxR?=
 =?utf-8?B?c1Y4VjQ5OW5XY0JoQzF0ZkJ2SEMzSlhXdWZ5aVlLbFJzb0diekN5SnFmSnJK?=
 =?utf-8?B?eHBrR0xRbFQvV0grRk1JUmJaMVhVVlY2bThGeHB5cVRBQ0NrRVZhcmtWWDYw?=
 =?utf-8?B?dEo1OXh0RG4vek5EQzFoamlzNHFabER0dHdoS2pGVmNueVk2SWJoQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08529989-d461-426f-b9a6-08dee29734c0
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 17:33:38.7124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vpbhSpqu+MfKjt/8cNXN8V8+CmN5ySQmm7hK4/sgNVK1Ucb4lqMLfKReg8U5XvuX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5823

On 7/15/2026 6:23 AM, Pavan Chebbi wrote:
> On Wed, Jul 15, 2026 at 2:38 AM Nikhil P. Rao <nikhil.rao@amd.com> wrote:
>>
>> Two paths add or delete the same slot (pf->vfs[vf_id].padev): a VF's
>> pdsc_reset_done() and the PF's devlink enable_vnet/disable_vnet handler.
>> They serialize on config_lock, but neither guards the slot under it
>> correctly.
>>
>> add() registers and stores a new auxiliary device without first checking
>> the slot, so a second add of an already-populated slot leaks the first
>> device. del() makes that check outside config_lock, so two concurrent
>> dels can both pass it; the first clears the slot, and the second
>> dereferences a NULL pointer.
>>
>> Check and update the slot under config_lock in both paths.
>>
>> Fixes: b699bdc720c0 ("pds_core: specify auxiliary_device to be created")
>> Reported-by: sashiko-bot@kernel.org # Running on a local machine
>> Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
>> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
>> ---
>>  drivers/net/ethernet/amd/pds_core/auxbus.c | 17 ++++++++++++++---
>>  1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
>> index 73b3481220b1..3acafe10a6d5 100644
>> --- a/drivers/net/ethernet/amd/pds_core/auxbus.c
>> +++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
>> @@ -177,17 +177,21 @@ void pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf,
>>  {
>>         struct pds_auxiliary_dev *padev;
>>
>> -       if (!*pd_ptr)
>> -               return;
>> -
>>         mutex_lock(&pf->config_lock);
>>
>> +       /* A concurrent del may have already torn this device down and
>> +        * cleared it.
>> +        */

I don't know if this one is AI-generated, but it looked good to me; I appreciate
the comment that it is specifically supposed to guard against a scenario. Though
arguably it's a common enough pattern that it may not need it.

>>         padev = *pd_ptr;
>> +       if (!padev)
>> +               goto out_unlock;
>> +
>>         pds_client_unregister(pf, padev->client_id);
>>         auxiliary_device_delete(&padev->aux_dev);
>>         auxiliary_device_uninit(&padev->aux_dev);
>>         *pd_ptr = NULL;
>>
>> +out_unlock:
>>         mutex_unlock(&pf->config_lock);
>>  }
>>
>> @@ -210,6 +214,13 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf,
>>
>>         mutex_lock(&pf->config_lock);
>>
>> +       /* Nothing to do if the aux device is already present.  This also
>> +        * guards against a second add overwriting *pd_ptr and leaking the
>> +        * first, symmetric with the check in pdsc_auxbus_dev_del().
>> +        */
> 
> Are these AI-generated-appearing comments really necessary?
> Anyway, it is your driver.
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

This is a bit flippant, but if the kernel is going to send all of our patches
through an AI, we can at least be nice to the AI the mailing list uses and
reduce its credit usage by embedding comments from our AI in it so it doesn't
have to figure things out every time. :p

But I get your point, this one in particular seems gratuitous, and the language
it uses is recognizably AI-generated which is off-putting to me, too, though
maybe I'm also just sensitive to them. I think we review these comments with the
view that unless they're wrong, they're harmless to leave in; but instead we
should view these added comments more critically.

- Eric

> 
>> +       if (*pd_ptr)
>> +               goto out_unlock;
>> +
>>         mask = BIT_ULL(PDSC_S_FW_DEAD) |
>>                BIT_ULL(PDSC_S_STOPPING_DRIVER);
>>         if (cf->state & mask) {
>> --
>> 2.43.0
>>
>>

