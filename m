Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011051.outbound.protection.outlook.com [40.107.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E050B529412;
	Tue,  8 Sep 2026 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877062; cv=fail; b=Xqih61hsRK6eozhW9yctcVnSSN/Zx7U/m7i8LQyVM/VIQdJMtoXKGh2EGBJOH8HGUfukyM72QiegOgYetVH5aXFXCtHR0oL4ha9NVAE0obqKv5O0U9rbQ6BIxVrOLCHY5a70n2GDMXZyuUXjbcNe7wZlGeOWgfZyeYPwhMT69LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877062; c=relaxed/simple;
	bh=2Y67zrmRvfpTevotoBoql7/a4j4u9eXs4GID0y8TBZU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rHvaXzrn5BoUP79OhPVrZXMfKqggwk1vvM10p1ayALTtSy3WqoVwiOEInThXsKsmKh320GASLYGQkeQy7GAKg/Tx2iYPV9fsbOhNLN/kUd+dAqynnqRzcqG4oDvhvo6rH3xejd4aMkBOTrRtbrsDY0Bx3bFHeaFolK+Sjjkk9Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gcouUaCv; arc=fail smtp.client-ip=40.107.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gcouUaCv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+t0nDx1YQxoyRdEN/9miL/0w2vs9lzV/tJAVZtwfwvPJFKCZFTTufSVGqYC+EApfaw93cI+CrpRdZfvnkKXeYx538iiWh2hlPkixP5nUsjr7mlNLGDsytpBiD8Uu6BPKDLv9DtoWKj56HXC2yygjoi6O21o0Q9aaYK7Gbcb0v25babV4ZnVBp+FNhmdMUzqT9Z85zu9dO5Q9WT6Rgy/+RspkrUGVbs6ddPYtXSEon450W2XaYyn3LUzBUj2fbeKUMTD7Ti4IWjg++EP4LAG2lwT7rL1ruGVVDhMLAiTjrd3ISs88kV5TBZ1bAlHFCqIHvkFAHyXpaktAxMO5Aquag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dP2UwtAiTtz8zbgE+UurznTtTK0B5CJ9mFa9nTXLA40=;
 b=WP02yR6bugZ4EDXlTpUHffCV4RO0V2xbCncdB891bkRhSCVJiLPmOQjpyE9je9VgQ8sjysdHDQserBq65rvDGF4y09yiBLWAq1BDsuFwQYfRlmLuTa3GBRuo52oGgPdL8APTjgS45dlRLNMXGXh5Do/5QGjOTPt8p63dnoeqzNggf/d40vMb15T7/xKqyDHdcX8zbjs8Y/tjclCSdBgmLz7WirMP4zXVZenORYJYMr8gOsjUMku8aqIc3cVFQva8w3dNKNBrI7QsUSJY4EFQgARbhnfoKbH4BnNDNtZA5OmeuHEoaRjAdMjR+dFI+ab5pUp0j0I7YMmQl7X9/4iTnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dP2UwtAiTtz8zbgE+UurznTtTK0B5CJ9mFa9nTXLA40=;
 b=gcouUaCvHrKz0xJDtajqFo7GcL3MX1QVNJs9f4FTQdhISiIz/SIGdlhVObIW8zuyJJGjRxDT5T6wyq7NKsarmCDYwkeJZPasGcg8TQSoedo6TwaD77hRTJCGLBDONr1AlLlk1qhJvqn3Fc50zITp9ZZociuVmQwnHEtflH9Djvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14)
 by DS7PR12MB6240.namprd12.prod.outlook.com (2603:10b6:8:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 14:17:25 +0000
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b]) by SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b%2]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 14:17:25 +0000
Message-ID: <afeccf78-8e2d-4103-910d-277bf052d74f@amd.com>
Date: Tue, 8 Sep 2026 19:47:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: macb: detach netdev before closing on
 shutdown
To: Jakub Kicinski <kuba@kernel.org>,
 Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, git@amd.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260901142541.1469544-1-vineeth.karumanchi@amd.com>
 <20260904184432.02fd59a1@kernel.org>
Content-Language: en-US
From: "Karumanchi, Vineeth" <vineeth@amd.com>
In-Reply-To: <20260904184432.02fd59a1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYPR01CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b7::9) To SJ2PR12MB8953.namprd12.prod.outlook.com
 (2603:10b6:a03:544::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8953:EE_|DS7PR12MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e5fe1d-b030-489f-dfc2-08df0db3e794
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	brCW98zR/tW1Vxv+nVaPCAhBZspyTvKlJBl/fMy23XB8Xh28cErofsslKZHxMDp+YDCL9NJ56lcr7Q4sVNyy5tuBjKiBzdID0Bg7lgkF5exSwv2d+7bVOWokJgYVgnyTePV4edEGyhQ//aLGVPC0DA7b8SGk1LHd3PWPXvP7tR18/p3zueUgaxlf0ANVN7cyYboNnmf1E6x+Clg6oI4zpDCbSmgRoQ/xEGXhf5/XxYOwjftpqYv2STPrvCIXIePXNzhPAGadsBv8ZXHkqza/yyykR7vYgFsjhvfYlaX1e1709uWG1rfswiVX2kmvfiGu8WwoOBG3qoT+g0GqU7cuNbZyfEssWS3TwFRS54Hm2AkF6322aj/lnVNjNXVmlq9dA0OviqQvNRLKfGl8bcoId0W+cpTmE1I1BiCJRvCMJwoLhP69Uih61X9ETmZZNFU9d990eZXmSaQGlNZYaHjV1lPR5Hd1ClE6pYhJpJDHUxcPSlIURroqGxYu5/RG94omn1/f0c5zk9aLzKH/8tRRrAlmWqBtf6QT9Wns2Auyg12CbUllcC1l8OpfvqFG94So0zvwTH4JHh59vezpD2QilNv5EOB4C1jQQkWqpoyfus4zDzC3VuIHAKQhbiarxEi74mfb7mNiRRbR0VqF8Ex7zqO7B73SMcKL3ehudHYNgck=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mnd1eWk2dENVWHZvVUF3eURuV3Z5RHBQNm1oTjR5TUFsNDNkYTdFdUlCN1Zj?=
 =?utf-8?B?MWlHM1pGZ0crUlF3ZlF0Tm9UR3Q1WGRmclFnb1NJeC8yYXo0eURFSVdWc08v?=
 =?utf-8?B?RG4vdTArbDhxdythYklJZmprUFh4YXMzTnZiemRDV20weUc2NjVPQnFvb2dZ?=
 =?utf-8?B?WU8vRDFQNlROR3E5UGFXeHp2RXJEa2k4VlJwd3hKcG9ZcXFmQVdGZWVpV043?=
 =?utf-8?B?K2pDSmFhY003QWM2cGtiTEhvT3VSTDdoSmI5cFJ5dmswSjE1Wmd3RUZ2ZGJF?=
 =?utf-8?B?b3dVbUsxWmNZWk9WbTJzQkNWa3hQNEZVd2dlRndWb2s5SnBkbGh3c3ZCUmtT?=
 =?utf-8?B?QWVHdTZkQ2JtcmxaTFBReEFIRFpNL3RXOUl5VldpOVNUR0NYU05hTm9RekhL?=
 =?utf-8?B?bG5EMStNRDZzRmJGUEEvenJwN1ozRzVoT3BVWkZ5WVdLSG9MVTlEaHV6Q0hJ?=
 =?utf-8?B?MElFVUFwLzROUG9ZaGUzUnh6eGRBN3Y4SkN1bkxnQ0lZb0JUVlNGNDBKUGVz?=
 =?utf-8?B?M0lPMEp1U0pNalh0Vk1tckwwMTZrQlQ1UTBsZGMxcUFuVnFGdEpMMDYyTkph?=
 =?utf-8?B?amVLZ3laU0hFVmVWbFN4WW4yNVhpOUppTjlpeXNmY1QwV2F3S1VadThTbHRI?=
 =?utf-8?B?eXhDRVJLSmRDbEZjeEhOSlAzc1J1blBFNXA4aWZkemhUQjEvZlU4MElJekJl?=
 =?utf-8?B?MHcxNThTckZMUkgxUVUwZzZ2WTUvNENka3JabzFyanQ1aGNaKzNhUS8xSzJ5?=
 =?utf-8?B?UUJ0MlZDNy9uajJmQXRJTXdYNi9QS0FaOGp4MXF3UDV0R0JNRTNYSXIwQTdI?=
 =?utf-8?B?Z28yVHplaXR5aVZsb2IxM2hZWlM1M1J5bUE4WFR6ZDVOK2dNdzgxYVV2TlBi?=
 =?utf-8?B?blI5REd3amRRektnWjN4dWtPWXZUT255ODV1Z3pWcEppbTVGeXRXTk1oL05z?=
 =?utf-8?B?T3Y2VjRRM211aWRtR00yUEIzbVdSZjFnZmtmb29ZZGpEMElTSHdRaXJBVGw5?=
 =?utf-8?B?R2ZMS3pVU2FVaXN5Yk00WUlkZXB3Vy9NM01YMjltU2Jyd0R1Vmxic2FEY2Rt?=
 =?utf-8?B?d1ZCbVF3WWRZYXN3M2R4b3Y3MUVtb3pQRjYwUzhTNnU4djhHM2R4L0RlS2RP?=
 =?utf-8?B?eTJBN2EzUjVmMmNnOVcwNktzY0FIbkRoR0p5WDhWRU9oTHd0dWpTZ3NUWEhh?=
 =?utf-8?B?WGxFb3Q4TWpRSkhseUR3d1k5YkErUGRHaTBQL1pzbVdKNzZOS0xDU01YcGFa?=
 =?utf-8?B?T2kwMFZaU0JVbDZoRHhYRFgySUJYWVp2QWlFa2ljV2NDcXU5dUtkd2NERXdp?=
 =?utf-8?B?anVHNUJ4SjRKaktqVytkK0ZYNTY3ekdNTCtWc1JVY1BhUFEvdkJDQlJzWWJV?=
 =?utf-8?B?Q2JIUlNDWFE3T1JTbEFCR2x2cXk0am81TlI4Y0NFQTRrV09PNTlDWkhrSEMw?=
 =?utf-8?B?ZjI2ME5LcXNvNzF5T1RmQ0E1dk9DOUJHZ0I2NzJWV3R5NndXcTdMclhkdTdv?=
 =?utf-8?B?R0dqVmdXdW5kODJ1dGh2T0JXVURraWEwM0RYYTJhbmNtTTU1Q3gwdUlxRUJO?=
 =?utf-8?B?eE0yZWk3REdIQllRUVczNkJ3WklRcUp2eHkyZHlVK1dhQThGeTgvNzQvWktH?=
 =?utf-8?B?U0cwamRVK21jOVAxcjhpaUdRMGRXN3BCK3Q1WWhkQ0p2V2dQNXZ4WWxuMS9k?=
 =?utf-8?B?cWVCVU5UYkZUNTJiZHQ0T2pwTm5zUUx5WXpPMVJPblFsV3pubG9HbGVQWisv?=
 =?utf-8?B?a29qRHE2NHdJVlYzelIvcE1PbmNJdnlEL2hURmdaMzQ1c3d6dmF6QStiSUdS?=
 =?utf-8?B?OGw2Q2h1N1FwT21nY3VWUmxyNmp0VDFZUC9DbDkxZHlQMHJhaWdxUUhzcTQ4?=
 =?utf-8?B?QXFYc1g0bFJLckVmUnF1OWxjYlA5TmlWTEN0WUVEZjJSMUIzVjZhbnA0UXZP?=
 =?utf-8?B?QU0zR2dOOTBEVnI4YXl4Ym5RT3YxRUhKdzdmUHc2L2ZabzVSRWRiWUEyT2lO?=
 =?utf-8?B?aTVaU3lzQWFIdml1S3lMdkJGZlVoU1lzaWRLTE45N2p2YzcyQmVGVlRpc3pw?=
 =?utf-8?B?R2d4TDZENGx3d2dzb29KbzFoajhsMk1MbjUrNzFtNmg0bEZTRWp3eXJKdDRz?=
 =?utf-8?B?WjZtTittckMzVzJYdERBTVI0RnBqVmdzaU9PRWNyK2k1US9zNWY4dEV2RmNm?=
 =?utf-8?B?cmh3bTNCYVQ3Zk1HeEVHK0U4Z04yZ21GUGxCODliTVdDUDZQb1pxbDhhSWM3?=
 =?utf-8?B?dXdnTGRRcmp5TmlhSHdWcERCVHRnTTZsNFhWRHVhWG5TUGcrc3VZN1UzRUxx?=
 =?utf-8?B?UTh6YTkwWHEvYk9WU3FObkJFeVdiWFE2Q0tROHRuWis4QVE0UkM3dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e5fe1d-b030-489f-dfc2-08df0db3e794
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 14:17:24.7607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HHESrS+g1z0fc/0AF/kIg4dnVlGBXp7itdJg3E9uSkM0uuyQiG+213/9x+tcRqR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6240

Hi Jakub,

On 9/5/2026 7:14 AM, Jakub Kicinski wrote:
> On Tue, 1 Sep 2026 19:55:40 +0530 Vineeth Karumanchi wrote:
>> macb_shutdown() calls netif_device_detach() after dev_close().
>> netif_device_detach() only stops the TX queues when the device is
>> still running:
>>
>> 	if (test_and_clear_bit(__LINK_STATE_PRESENT, &dev->state) &&
>> 	    netif_running(dev))
>> 		netif_tx_stop_all_queues(dev);
>>
>> By that point dev_close() has already cleared the running state, so the
>> detach only clears __LINK_STATE_PRESENT and the netif_tx_stop_all_queues()
>> step is skipped.
>>
>> Reorder so the device is detached while still running, letting
>> netif_device_detach() mark it absent and stop the TX queues as intended,
>> before dev_close() tears the interface down.
>>
>> This is a cleanup with no functional change: dev_close() stops the queues
>> and quiesces the DMA/HW via macb_close() regardless of ordering, so the
>> reboot/kexec safety path is unaffected.
> 
> I'd guess the driver is trying to clear PRESENT so that the device
> can't be opened again. It's not about stopping queues.
> The patches doesn't make sense to me as is. You say yourself that
> the move is a nop.
> 

You are right, I will drop this patch.
Thanks for the clarification.

Thanks,
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>> index 76ee4f506033..21ebaee00f9e 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -6246,12 +6246,11 @@ static void macb_shutdown(struct platform_device *pdev)
>>  	struct net_device *netdev = platform_get_drvdata(pdev);
>>  
>>  	rtnl_lock();
>> +	netif_device_detach(netdev);
>>  
>>  	if (netif_running(netdev))
>>  		dev_close(netdev);
>>  
>> -	netif_device_detach(netdev);
>> -
>>  	rtnl_unlock();
>>  }
>>  
> 

-- 
🙏 Vineeth

