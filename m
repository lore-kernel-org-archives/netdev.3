Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012033.outbound.protection.outlook.com [40.93.195.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586FE361656
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 00:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785889689; cv=fail; b=IPhwhlOX2gG/BNTmXPBjTKsqHYW2mn1AuDnFfdxLW9CC5pQNDOeSkE7urlcdC0DcrzAj0698AnsQwnUeaUDUpPRKPUbVrTnciy2tX6VTxoP79O/H5GjGCwrvIT6Qaor8eTRkV6zo3X/gkwObVGQUbTuAaFDPvNa/Hbgk+VwEAy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785889689; c=relaxed/simple;
	bh=52AuUdu0COjVQNOCGo5J/uhNCfWjer2niINHGkLsAR0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N57IQzFkQh3MFwABHuW0FjOEJcqORbNtozDNtFDn5vLevsItDtmvUJQ3LiYTtQNt7FryPmndDujsI1fHsW/Dj9ccK2Eu4iibgrmEcYBNJgtHkm7ntWyZd3bAzIhW/oeAIWBp5cpHAd4Lg5uEe7+0SuRqqBSiBzPVw0J+rljA28g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1YbCRuzC; arc=fail smtp.client-ip=40.93.195.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1YbCRuzC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTAwY5I1C53UEWMhNEy8AJVRCi+0UyKH8Tk0a0uqncLYd2XxfC7rdrOHJaXJqgOVelac9V3oh//NfRziWc4JcM2Qfn0NhOanDY4BhP7a5QR6sGXt9TESQDPvBt2VZUjdSsPdn83Pcfl0AYJJfIg0C/7cwlZKfRVEDkRaVO+ubVZQ7wZRGw9cnYkjhBeK99OcDB1QMmvdKy8+lxkw4C+0PX1ND9KFPOARjBvfstK9Od2Q/cc30rahNUgRKv2cd196iuN3x4Ofr1ukfoAfQlUZwyCCU6lrXrueiomCDsang0234XMJ8/E2kYHwQzcmi2fefFEHzUKFdw0p0CIenpuwBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhU3MRzl+FMo4LfBwEKXknH5XNVfWpJK0xqp+GeV6m0=;
 b=fdwABIBhAdWCL9Uj+o2/LTUmqIBGdmIuA2bxQk+9as0ULM4XQWDE1T8RazFJXfsoVTjZk+rwGeO9heEZeV9n7hf62YfRIla73Tb41+Z3a3rHgrjIcNHcOZD88weeBvuwVX0nqPfegzv1NYi7oXRX1RcPrZEGNqzf8WlaLyOPlDuxJHW3lbMwuzeN9TbdbXFhphN5zTppXo+cegNfhghBb7HrputF/5hI8nOIc9NfVGRbCkaR0jL286CgP8aJ01YbkGkbm2nnr4fdKug1j6/BC/y7spHgNKDNS+zRxafA6u7YBEuLRz0xgIgXekdBovymGa2sI0xMlm1RNhxLp8AZOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhU3MRzl+FMo4LfBwEKXknH5XNVfWpJK0xqp+GeV6m0=;
 b=1YbCRuzCHPqsaGfdgaeKnQsngb8ZN6VyCvqrifHOP2K6RA7vejDs8d0d5E0kuj/OK4XbgzbKSiEQspCnCFi7b85UTcli0E++C1OFlz7uSmcQVSPy00ukkcEekfHPOLGh6VZC4JIKVo7xtXsWU2/qIM46VNSXym8XdCgofOPre/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3485.namprd12.prod.outlook.com (2603:10b6:208:c9::22)
 by SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Wed, 5 Aug
 2026 00:28:02 +0000
Received: from MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9]) by MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 00:28:02 +0000
Message-ID: <1c2694d9-3d4e-4dca-b8be-40cc7f59f594@amd.com>
Date: Tue, 4 Aug 2026 17:28:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] pds_core: fix cmd_regs access racing BAR unmap on
 reset
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, brett.creeley@amd.com, eric.joyner@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 "Nikhil P. Rao" <nikhil.rao@amd.com>
References: <20260729055258.1416225-1-nikhil.rao@amd.com>
 <917affb8-f750-4e11-aade-e4ebf13e96ce@redhat.com>
Content-Language: en-US
From: "Rao, Nikhil" <nikhirao@amd.com>
In-Reply-To: <917affb8-f750-4e11-aade-e4ebf13e96ce@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:a03:5db::12) To MN2PR12MB3485.namprd12.prod.outlook.com
 (2603:10b6:208:c9::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3485:EE_|SA3PR12MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dfff61b-9a3a-43ff-cea7-08def28868fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	qXKcuWblOFUMKZcQKc69sw+0WV0VsUj6iojDHEFe7FDj2ijYu21Aylpz83Ng1ccRiZhMjpSWPekQWQyRPopQSasKB/og5ELp7pdguPcfYzsiFydnuYKSCrDbhw5G3vswIViQeB769dDAgFIK8YYbuNK2amf2FxtVs1SXHH+6uebmM+i7inPN8xex0P6BFpyoaxUw3+EJPCm2A/yssEdTGtJ9L4oL1DlAehVVpvUnGawJ60cMqElID7SPKa+gxOpcxeSHp9yAfin1uKzfhxaOLgBjxDkeT6dJDVSaRelwDtQ9n3PaH+CthAlvRWAndTbMwC2TUWrWtNfBLG5wxWvDHYPYq8yxKzhzLqqdkRXZ9+45q4i2X/duHjejPoDHtYoBs4+MsMnbbgdf9NAOFC6MCnTDezAUiSDcS46INdCCRyIfTwsBt0+qg+JoYu7NhjKMMbGhCckWHRvLAsO8a1OllTOxwAiBnI2kCrWJfvRv4OQg9YQkWeu+jkibAX8J2sz8V7H+ZVL88hGF+/NXC5LEFfnor3mnhUK44tLgcXQLCv9vg8wwE+HD/jq5Dvp7M5t0R0CcdyQZrqln6Py025dsCZa/eWta5c1lpCnM7T6EVs0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3485.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXdtMzEvR0dMQytxN0xqTDIyeE1iS01WdVNhZXMyNFZJQmw3UU51ZmtoenZK?=
 =?utf-8?B?cjNrVGoyRHFOd3JzUEFyU2R6OU16azNSV0hTclJEU2x6cmtnem1OY2JkN21p?=
 =?utf-8?B?Y2liZ0wvdDBnUU9SSWk3MDd2amRwR1IrZjA3N25UdDJVVlp2Y2dDanE0SkZL?=
 =?utf-8?B?SlpXOS9iSEJuL0VHZG1OemJld3FuWWpaSHdwOXkwVWFyZlVyaVJ5L01DNDFv?=
 =?utf-8?B?TkZoTCtndDZsUmNWSk5EY20vL3diN0Q2OVVSNGJpNURTN1NzNlE1WUcwRjFy?=
 =?utf-8?B?TXVIK1JWRGZONWt2am9OUlRFVlpmZllVTm4xTS9DWDhwUTVrbW0wRE9SZGRT?=
 =?utf-8?B?T3ZMQTk3V2pHOXMwSWNrL0U4bnNhN1BPbW5HeEpSN3kyV21RZkhXYm5icXMy?=
 =?utf-8?B?SHJybjhKbHpJN2ExZE5xNWx6UEVDQzFSMVJ5K3VaQmRqYXpRbWRHSW1SWSsw?=
 =?utf-8?B?UTliOStjZ2JaRGsrNjVLZ3RvRWc4bEZoZVdLcVRnc3UxYXpQLzJIWW82Qkw3?=
 =?utf-8?B?a2xYVVM3QldBVlJPbDFJS2tnengvYmlzRXpHY1RvazhacEwvUSt0UHA4NHRI?=
 =?utf-8?B?Q3ZWOTA3ZVQrZ3dGYXZJSFAxU2E5UU9LSzlGUVl0RGM0TUJ4WXVNS2xWMHJ2?=
 =?utf-8?B?V1J5QVFUa2lxOU03YnM0c2RYa1o5cXFiNGR1cTZZRmVwaVFrV3NSMFlsQ1FP?=
 =?utf-8?B?Y3crMDNXOUQzUmRWV0pWLzdqc3E0TkZPYVVGNy9uK2hheWpjQndTcU9kRkk3?=
 =?utf-8?B?TElxZW5SVHBmUUFUMzVqczQ5MVdqVmFXYnhkNU1XbkFPMUtSU2VPaUNLTXhZ?=
 =?utf-8?B?UUtRVzh3NFNDa1hOLzgvdDVaTGpKYXA3Q2NFcUZPQkdvYmVyblZJS04zY2Ji?=
 =?utf-8?B?OFpldnJiZmFWc2RncjZsOU9yZnhJWS9KTDFVcFpDSXJYSURhN1ZPQ2lPQXZM?=
 =?utf-8?B?eUlhTVgyck9YVUtKY0dIK1JGOUh5RXFyZVcwaUdKK0h1a2dzeGVKRUtRTTJP?=
 =?utf-8?B?MklWbC9Ebnd0YlN0NkFrNU95cHZtVFd2WXBISDFsNmtGN3VLaS81MHAvem1W?=
 =?utf-8?B?YTRLNmdDOHJEVnQ3ZjIrbTdtV2Z5NzhrZS9XeW9LLzlLRUNtNndEdGpLcVdp?=
 =?utf-8?B?NXFCNkZBQXI0WXRJaHlsbC8zSEVYcWx4Q1M5M1d3NnMvcmlGVUg0dUc4MjVy?=
 =?utf-8?B?NFMrbUx1MGRmTW50UllFQ2l3dnl3UUtZRXFyRUZtWDFWNEloM3dJTHpncHEz?=
 =?utf-8?B?N0pSMGpIUG9wZ0FMZCs4Q1IxcWFydGMwdGs5dU5EVmk5b3Z2TUpxQWJLcjhQ?=
 =?utf-8?B?RUwvZkFDNjFXTlRNMk94YlUzdUNqaWptbFZsMG12c29ZRFFpeEc4bTd6ZWYw?=
 =?utf-8?B?YWo0b2pJdWloeFVPamszbnpmRlJYWkUrdHd1VGx0am14dHZRVFNTTlZPVWta?=
 =?utf-8?B?VHZsVEY5c0s0OTZDdjJZenJIM1BwZnNOYWJ6eWVDRjdibXJFUG0wUjdqdnA4?=
 =?utf-8?B?RkxPUlFkK0JNSStwcjJPa2N5N2MwRXVTSUU5ZVYyTmdLbnJiZXRSNFI3SE5l?=
 =?utf-8?B?VmxpMWYzUmFJTXRBcmRMMG84WUt5dTA1VGZrY2E3c2txUEhUNWtCWUdERjNY?=
 =?utf-8?B?eUE1dWtCeFl5RSttVHAwZEhVSnZLV1lHcU5Ia1p0aUkwRS82OVdpa21GSG40?=
 =?utf-8?B?Y3pQZEJOS3hwZ2liWFk0NDN2R2MzbkxhSFFuaUsrTnRoNHdrYkg2WEw0dzNH?=
 =?utf-8?B?NHhRRURxMWYvaG5qeS9vZzgxcjNjb3JqSy9LNFliSERMVmhPUXAzdnZqSHp5?=
 =?utf-8?B?V2hXR0VmbURvK1h1OTEvMzBYcXJLZ0p2RU4wanMySXdoS3hGUmJCT0dKK1JP?=
 =?utf-8?B?bXRaOVhZNHV6YzFWSnZWL0dFYlJ0Qkx0RmxwTGZwd3E2MjZqbk15Z2wxWlA1?=
 =?utf-8?B?NTVlbCt5Um5QSFRxSzEzOUdtQjhLWXdHbGtSWk10ekdhaDZ0aDVHTk5HSmRN?=
 =?utf-8?B?TS9TeDdBbk42eXJaWCtPQ1RlV3hTcmtaQkFTRGtMRWM1UjY5bHkvUDB1bXZW?=
 =?utf-8?B?bTNKNGhvN3FPNzJIS3AxSStUTHN6OC9hTVV5M0JyOG9Yc0VQZFIxc2hjd3JL?=
 =?utf-8?B?Y3ZtUnYwemkxNmZzMi93TXpIMEt4MW1CU3dBSk1XYW5EeHorMjFGajNXNTVo?=
 =?utf-8?B?ekVBZlAyL1dOVU80K3dmUE1Ud1BZRXpHTmlwZisyVVdjbkpucWVGMmhodG9R?=
 =?utf-8?B?NHU0NGErU0ZQeTRUZUtLeEVaZ1l4RDU5ZG9lcHNCb2o0TmNLazIreHhTV0sv?=
 =?utf-8?B?cURjdWJhZHByUGJSK0pQSCtjZGVsbDNvc2lGMFM3amg2WUlCTmczUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dfff61b-9a3a-43ff-cea7-08def28868fc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3485.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 00:28:02.6350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLGEwlqPEXZfDLdwqN7HJYRTiijuCmGpA3w4uSDfXK8ZhBvWl+rfvIss9m/nY5Uw5HZFF6HSpxLrrafd+o5kyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950

On 8/4/2026 3:26 AM, Paolo Abeni wrote:
> 
> On 7/29/26 7:52 AM, Nikhil P. Rao wrote:
>> pdsc_reset_prepare() and pdsc_reset_done()'s pdsc_map_bars() error path
>> clear/iounmap cmd_regs without devcmd_lock, and pdsc_firmware_update()'s
>> download loop derefs cmd_regs after dropping and retaking the lock
>> without re-checking. An FLR concurrent with a devlink flash can unmap
>> cmd_regs under an in-flight devcmd, causing a NULL deref or a write to
>> unmapped MMIO.
>>
>> Take devcmd_lock across the BAR unmap/remap. Only the PF maps cmd_regs
>> and runs devcmd, so guard the locking to the PF.
>>
>> pdsc_unmap_bars() also clears info_regs, which has its own readers under
>> config_lock (and a lockless debugfs reader); that teardown race is
>> pre-existing and handled separately.
>>
>> Fixes: e96094c1d11c ("pds_core: Clear BARs on reset")
>> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
>> Closes: https://sashiko.dev/#/patchset/20260708212222.296202-1-nikhil.rao%40amd.com?part=3
>> Assisted-by: Claude:claude-opus-4.8
>> Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
>> ---
>>   drivers/net/ethernet/amd/pds_core/fw.c   |  6 ++++++
>>   drivers/net/ethernet/amd/pds_core/main.c | 10 +++++++++-
>>   2 files changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/amd/pds_core/fw.c b/drivers/net/ethernet/amd/pds_core/fw.c
>> index fa626719e68d..cd7616ed9ef3 100644
>> --- a/drivers/net/ethernet/amd/pds_core/fw.c
>> +++ b/drivers/net/ethernet/amd/pds_core/fw.c
>> @@ -134,6 +134,12 @@ int pdsc_firmware_update(struct pdsc *pdsc, const struct firmware *fw,
>>
>>                copy_sz = min_t(unsigned int, buf_sz, fw->size - offset);
>>                mutex_lock(&pdsc->devcmd_lock);
>> +             if (!pdsc->cmd_regs) {
> 
> Sashiko notes this is still racy:
> 
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260729055258.1416225-1-nikhil.rao%40amd.com
> 
> The issue is marked as a pre-existing one, but IMHO is so strictly
> related that deserve fixing in the same change.
Agreed, v2 folds in the cmd_regs part:

https://lore.kernel.org/netdev/20260804235946.177762-1-nikhil.rao@amd.com/T/#u

A note on reachability: the path the review describes 
(pdsc_devcmd_locked() re-arming the health worker during reset, the 
worker then running pdsc_fw_up() -> pdsc_setup() -> pdsc_identify()) is 
no longer reachable since cd09971dcc1c ("pds_core: keep the health 
thread stopped during reset"), which disables the work item across the 
reset instead of cancelling it.

I left the download loop alone. An interrupted download is not committed
to flash: a reset clears the device's update session so a resumed
download is rejected, and the device verifies the staged image before 
writing it to a flash slot, reports PDS_RC_BAD_FW rather than activating it.

On centralizing the check, pdsc_devcmd_with_data() in the
PLDM series under review for net-next does exactly that. It isn't in
net, I'll convert pdsc_identify() and pdsc_core_init() to it once that 
series lands.

On intr_ctrl, intr_status and db_pages: the readers are quiesced before 
the unmap -- pdsc_fw_down() runs pdsc_teardown() -> pdsc_dev_uninit(), 
which frees the interrupts and the queues, so the interrupt and 
start/stop paths cannot run by then. v2 says this in the commit message.

What is left is debugfs, which outlives a reset: identity_show() reads
info_regs with no lock or NULL check, and the intr_ctrl regset reads
through a base captured at file creation. I have not posted a fix for
those; v2 says they are out of scope rather than claiming they are
handled elsewhere, as v1 did.

Thanks,
Nikhil
