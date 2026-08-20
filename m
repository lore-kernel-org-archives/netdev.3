Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012013.outbound.protection.outlook.com [52.101.43.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FACE473C94;
	Thu, 20 Aug 2026 14:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787234687; cv=fail; b=MeTPUv4H8UvGciEaZocdeEq8Wn6AhU2twYFfIF+mi9xZw4F0PM++JAXHPiH2OMVgw9nNOtv2dtO/6PtiaDd6ftRizU2AMECNRfxOZ6kuqwsk2XrO8X2hk1UUY6rA+yGPpmNz90cKF1ydWzKxvpu9XDddTxh4+jkPY38rIAqmB4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787234687; c=relaxed/simple;
	bh=VCPFlcURsyITv3pVq+vQ6QBQ/qahgeuCRxAbV3dVvsQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CQfW0A9OnenrGqfhBrfEiWoLjXPlUISKhhjfuAWc3CJXPLzBCHsUNsUACUIjb5AuT4uIm++SJbr0oGdLgQmK9egreVoP4sYJbQlSN9MSBzGOwWY835KH4rtHNYqFiSVHWEDHe+c0HjkPboUBVbza22rLO1iWbgGELx940N77Wbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KXpEFb2P; arc=fail smtp.client-ip=52.101.43.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KXpEFb2P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8GX79w+FwXOu6A5k0Ij+c7f9DnPx0cMxC0TUr3MBZUZK9K9grUo0pGTjh9qMb37ryl7vpjaLp0XyCCuFO9nLAe7qGmqz85vpEQ7tFcHNcXwwivklbTh6NbhmOixx7e0qWF1G95bsZVQ+cIJA6YMFHh+j9ZxLU322g6MSrXUzFZA0vmX7DK2fNyj947EdEIpHbjfFnOUuFaSBCOBOS2QiObq/DWYqnS41cfbGCeswUvKUm0qt1BuCGLvky3P2p7cuyVzVqo2XUavGDLZn8yQ+BxKHWG0jJgeYnn4XkoNXcSLRXtl5RsouTjeOCARwWaADZlm4vx5XmNO0Z86UYznxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjMFIVvDqIFfX6+tzAtY+Muu62nXMGb8WbIEjgl7RS4=;
 b=XjWjCdbF/9lw7CpEApig40TEgwk4MLA+Yhrt5U0GAVGzUkgcRO5oZAS1PbnL7q+0TnyerF4VkyahayONsHa8D00zuf6WLHVAx4yjNCxK81temLZTQzhGRsOQc/+Pjd8L+yzH9i35H/v9haI1lWIlhWK97KnF6uB32OgnZV3yt/ZYHob2WTHG/R758Vns/W61m5hBeUjUf9vSv1hVQEUjEuHGHUdPYxUP8MkVTvKzCKHcJOEP12Du3m8IjboW2Pe2Pt5NrCR+JeUO6/82dFIE0HLNq1FYaHzqV70FhYJmTQkdb0HrxqMrly2IKgmmNTIEPZbOSnHHGjo0/8Fb/VUmIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjMFIVvDqIFfX6+tzAtY+Muu62nXMGb8WbIEjgl7RS4=;
 b=KXpEFb2PrZzE/HXCUsnslXHlyEXV+AnZTmYz9+DSdHiz7Yd/sF12xGiDQHFE3xPnBOWEqqM4wjS7hDrmIUrBtjZxle0xI5hxc4Zgu95BsC81jG1nE9mixOmKCeIwwu0cTltjSh7PUIrfCNIQlps9cYK9bG9Q46d5gZJmHlwGOkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999083.namprd12.prod.outlook.com
 (2603:10b6:806:49e::15) by CH3PR12MB8903.namprd12.prod.outlook.com
 (2603:10b6:610:17a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 14:02:38 +0000
Received: from SA1PR12MB999083.namprd12.prod.outlook.com
 ([fe80::53f:1e1f:a95:29af]) by SA1PR12MB999083.namprd12.prod.outlook.com
 ([fe80::53f:1e1f:a95:29af%4]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 14:02:38 +0000
Message-ID: <fafe633d-bc42-4d8b-bca2-574a4b4909e9@amd.com>
Date: Thu, 20 Aug 2026 19:32:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/20] net: dsa: xilinx: implement port_stp_state_set
To: Jakub Kicinski <kuba@kernel.org>, nagadheeraj.rottela@amd.com
Cc: srinivas.neeli@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, michal.simek@amd.com,
 andrew@lunn.ch, olteanv@gmail.com, horms@kernel.org, linux@armlinux.org.uk,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 git-dev@amd.com
References: <20260807104431.157230-12-nagadheeraj.rottela@amd.com>
 <20260808194827.133042-1-kuba@kernel.org>
Content-Language: en-US
From: "Rottela, Nagadheeraj" <nrottela@amd.com>
In-Reply-To: <20260808194827.133042-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0305.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21e::14) To SA1PR12MB999083.namprd12.prod.outlook.com
 (2603:10b6:806:49e::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB999083:EE_|CH3PR12MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: 9912fc3b-4b43-418c-ad93-08defec3b17f
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|18002099003|22082099003|3023799007|4143699003|11063799006|5023799004|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	CdUO7wn0qrkKru4frFDz0B0D5lwZkR7Xn8LH4mmSgGgH+BN/D5E8okixYfWoHuQyqQDTVS0QQ0inG2wgFkxvnNP2wbJHOVSo20+slueYJVyS0tNTNQ1gYk929tYUA4YODADx3Aqj2Th8unXHYRAWUWMmGx13Mq0dvfYbaw+fg9QuZII6PJ68EpfmtECOWdBAVlPZ647SBYKmfsYPzdYlm8VXpZswn3dAze3mjYMau3y7gbowa0b6iaynEQpA8cvAmoS7JzO1FxsbMPWNuT/VyOFnMPVquj88qy39m2ZVyh5+82WsPTBIs6kBZ01fnAk0AqisB5n2WkMFe0fl/xDvt3sMpJFqgpIjWUR8cYFu2uSB/8zJwCIRjuCl0eA30d0OAB3iEcqlxWQmqjS+7A7NnnzzuBb8AWlW0gdnXnt3Bjgho6qCKmimXIO1c6rG3iYLqby3dPMVtp6vZSR0eQgNk55kdMoMW2ruc1o/R1ag0Q6K6N8Pq3YFcKmH8YCYeZ92kB0VjYTmG7bwp6sRmGIxPwHj2sXwS6pcHTXvH5Q+GmSgObCmweBsYantrUr5T2t/ZeLfBeDerb56oTv0cFg4BJCqap4R6f/yE4eGCa5S5z4bXbePLfuq98ftDoCbi0fUG3pPuoPs4HrMqAfhjnr8rVIt2ZXTUAT+uSH/tqQe7tc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999083.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(18002099003)(22082099003)(3023799007)(4143699003)(11063799006)(5023799004)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mk5QR3ZjRzBadVFHVUtCVUs2aGU5TjFkQUVwU3VSbEUvcGNLaWhRcVI1K2NI?=
 =?utf-8?B?R2tLdnVoczM1MjJ4M2JCL0R1UE9sNHV3bG1WRXh5WEpZLytVV3hySzY5dDR5?=
 =?utf-8?B?Q0VXZXBuTmhzRnJGME1RRm5NdFhHM3hBMHZ5RHF1ZVVJcklBK3lGT0lWVFls?=
 =?utf-8?B?bjhRZjI4TmZ2eG9oakFJOVZkNDIrZDBPVUw4azlXeEdRVW1RZGx3ckJSU0kw?=
 =?utf-8?B?WDlOZGhKK1VVUEU4SFZBc28xRnYyeUdXUE8zSHhGNnJxWEErK1B4NHQ2OU1a?=
 =?utf-8?B?MTZvcXhxVEo5R1JvblFqNTZQUUxQdW05ZEE0NkthR3RBMFdmdm1nMGg4cDR2?=
 =?utf-8?B?MDRqclpKVkgyczRiVFRNZ3dYeHhYOWRZRENrZWNuM0l1OTFRRkUxLzBLSWdE?=
 =?utf-8?B?WjlIcWJVcEpGT1NjamRIOW9mYUx1c2FTN2hxZVpNVllTQk00ME5GS2xCZTJu?=
 =?utf-8?B?SVBjSDdZSnIvVVVnRXZNdzZEa3FJc0tTOTNNckVWdFQycElQaHFBdHhzZHE4?=
 =?utf-8?B?N1ZoY2tRNGJ4SWtnR1FDeHh0YUkyd2xQNkVsMHdnUmlzSUtvWnRBb1hONU9H?=
 =?utf-8?B?b2ZlaWI4WWFYV3VYK0s2dXVlQmZmSE1Ca2dVakU0eXA0eVJwWmkrSzJlVWJI?=
 =?utf-8?B?cXpkNnB2cmJTQTBoUDVhMGVYa2cyZkVnSERDS0paRGpYYXNlaEtNMEdWR3ZP?=
 =?utf-8?B?SVZXay9QMm01ZnExR3BvLzI4R2JnbnQ4cDNxb1VjMlVWRE11WEhhWVFkOW1F?=
 =?utf-8?B?WjYyQkpocmRYRS9IRDhuWTNhZHYxSUQvOXVkckI1UnhmMTFjbVpIZy93WkVo?=
 =?utf-8?B?R2tjR25BV1pqZTBXUDl0c0F4dThXRWE0eFZsR1ZSZmM0QVJxRmZ4N2Z4ZU5T?=
 =?utf-8?B?L3pjUEQwMmt2VkM4TThQK081WEkxM2hTb0VhMEFLN1dDbjhsTTlTZzlNaVc2?=
 =?utf-8?B?S1diUGczSTNnamhHRDRvNGlmVzgvenV4dW00YVpldUN3ZzR4V0w2bGRsTTlt?=
 =?utf-8?B?OFo1bGhKbU5OQjQyZ09iRXN3S1pyd0VBNkllYUp0Rit4M2JxbDJNQlhFRXRq?=
 =?utf-8?B?ZGIxTVE2UzAxUUJ4a0RvdDhmallwcFNtb0JzeFQ1UmpFd1htRi9qNmJqM2Nj?=
 =?utf-8?B?Skd2YzNJck9aaVJacmRPMjJ2WDkxaXVkNG9GaVgxUHAwYVlKcXNsT3FCNkpo?=
 =?utf-8?B?eTdHYmQ1cHB4ZEQ5TnRrN3NYSm1hbzM0QjNvYjJ0VEROdEdxNTNQL1p3cWZ3?=
 =?utf-8?B?T25MTzRKVlpQUmQwdnlkVjNqOVpYaGMzMVJOR2UrM0hkOFl2RWlWRjdTTmZn?=
 =?utf-8?B?TlgzY0FsNkV3UWUvMnFtd1cwZVBseHpReUJHaEpqOFNDcktjY1QweHVtSjAz?=
 =?utf-8?B?L3lSdmhBMWZqZ1RUMlJwd3NiVHY3UVhXSUdZZHVOb0pGZnhRdUlBTHg0K0Rx?=
 =?utf-8?B?VWtVTXAwcWx5QU1OQnM4akZTVGpyN000OGpMN0ZQTlVlN09ma1ZPK2tLZ3Fy?=
 =?utf-8?B?a0lxQ09iOWhwZUpqSXRabnlQdmowQU11ZFV5YVVPOEFzK3ZUamtwNkRQdWNv?=
 =?utf-8?B?QXZtOThpV3ZVODY1TVFORkpoMGRSeUdqaXI5eGJ6bGIrbXBkMldleEdWSWJo?=
 =?utf-8?B?dGhRTldpdlNMOHNtT29pQU93MXViWmVURXkvaXYxQmlqMzgwR0s3UGZMc0Vv?=
 =?utf-8?B?K2UyVnJnWGlDZTIrSUErdHllcmJweCt3ekhHNFpDQXdLd21kNlUwdDRFbGxx?=
 =?utf-8?B?OE9MVGFPdDhiL1c0dkJsenhPU2lvQ2ExUUtiN3phSE1GTnVxdGFPZzVKV0cy?=
 =?utf-8?B?WU1YdXc0Q3Z5OExPeDI0RTNtcTE3TUlieldEMEFDeEIzRUoyRVpIbXhhMlhr?=
 =?utf-8?B?SGk1Z1RkMVhzMHE0akZrRGRyblhmVEhSbnEvQlhjR2k1ekRyU21qd2duSnpl?=
 =?utf-8?B?WlZESDBUUDg4Wi9tMnl5SUxEWW9ZVFFsM0tZeHRWTGt6azg4SEd6UC9vQlRp?=
 =?utf-8?B?RkpFbE1teXNjTWVJeVJQY0xneXdFT25sMHlPVGdPMGwyVmdIR05LbG5oSUkv?=
 =?utf-8?B?aEdMWEJ2NmdXcHE3dEN6QkVxVEtGQ0hKZHpmTjI5RDFpMXE0R0o0UzF1eThh?=
 =?utf-8?B?K2FPbVpTRzREUzQxOGRERW1VRjRXTVdNY1g2UlNlbWJTN29Pc2p6TWg5cDBs?=
 =?utf-8?B?VkczOWNrbFZQYlpxWkkwWW9oTEtEUEZ4NU8rNDN0allFOXUzQzIwN3ZoRzQy?=
 =?utf-8?B?clVGL1F1R2ljVElNWHUwZ1hVSVdRaWlPd0VoMlFPUmZRWWpiTmVxNTNsNFV3?=
 =?utf-8?B?TGFCTVpmcC91ZEJrWVBrUzZENkVqTEtIMnJ1cG9WcTEzRHRMVmlCdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9912fc3b-4b43-418c-ad93-08defec3b17f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999083.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 14:02:38.4401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mh8cHw1fMWf1+ITTtaDSO0BUnoqx6SrMrXB8u2tcECS5LkvOdD9Ol7+r61W7z5pvZH3oF5A/V9iWMdwzwWd1RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8903


On 8/9/2026 1:18 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: dsa: xilinx: implement port_stp_state_set
> 
> This adds a .port_stp_state_set callback that maps the five bridge STP
> states onto the 3-bit per-port fields of the Switch Port State Control
> register at +0x004C, using a self-clearing commit bit plus
> readl_poll_timeout() for the acknowledge. setup() puts the CPU port in
> FORWARDING and the user ports in DISABLED, and teardown() puts the ports
> back to DISABLED.
> 
> A few questions on the new code below.
> 
> First, on the commit message itself:
> 
>> The bridge STP machine does not manage the CPU port. Its forwarding
>> state does not change after setup().
> 
> [Severity: Low]
> Is this accurate?  The teardown() added by this same patch writes DISABLED
> to the CPU port:
> 
> 	xlnx_tsn_set_port_state(sw, XLNX_TSN_CPU_PORT, TSN_PORT_STATE_DISABLED);
> 
> And because the driver now provides .port_stp_state_set, the DSA core also
> drives the CPU port state on its own:
> 
>    dsa_port_setup()   [DSA_PORT_TYPE_CPU] -> dsa_port_enable(dp, NULL)
>      -> dsa_port_enable_rt() -> dsa_port_set_state_now(dp, BR_STATE_FORWARDING, false)
> 
>    dsa_port_teardown() [DSA_PORT_TYPE_CPU] -> dsa_port_disable(dp)
>      -> dsa_port_disable_rt() -> dsa_port_set_state_now(dp, BR_STATE_DISABLED, false)
> 
> So the CPU port is written FORWARDING twice at bring-up (making the
> explicit write in setup() redundant) and DISABLED from two paths at
> unbind.  Could the changelog be reworded to say the core drives the CPU
> port state too, and that teardown disables it?
> 
>> diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.c b/drivers/net/dsa/xilinx/xilinx_tsn.c
>> index 6b285c528724..020b1622670c 100644
>> --- a/drivers/net/dsa/xilinx/xilinx_tsn.c
>> +++ b/drivers/net/dsa/xilinx/xilinx_tsn.c
> 
> [ ... ]
> 
>> @@ -11,6 +15,86 @@
>> +static int xlnx_tsn_set_port_state(struct xlnx_tsn *sw, int port,
>> +				   enum tsn_port_state state)
>> +{
>> +	u32 chg_bit, mask, val, reg;
>> +	int err;
>> +
>> +	err = xlnx_tsn_port_state_bits(port, &mask, &chg_bit);
>> +	if (err)
>> +		return err;
>> +
>> +	err = xlnx_tsn_switch_status_ready(sw);
>> +	if (err) {
>> +		dev_err(sw->dev, "port %d: switch not ready for state change\n",
>> +			port);
>> +		return err;
>> +	}
>> +
>> +	/* Bit won't re-arm if a previous change never cleared it. */
>> +	val = sw_ior(sw, TSN_PORT_STATE_CTRL_OFFSET);
>> +	if (val & chg_bit) {
>> +		dev_err(sw->dev, "port %d: previous state change still pending\n",
>> +			port);
>> +		return -EBUSY;
>> +	}
>> +
>> +	val &= ~mask;
>> +	val |= (state << __ffs(mask)) & mask;
>> +	val |= chg_bit;
>> +	sw_iow(sw, TSN_PORT_STATE_CTRL_OFFSET, val);
>> +
>> +	err = readl_poll_timeout(sw->sw_base + TSN_PORT_STATE_CTRL_OFFSET, reg,
>> +				 !(reg & chg_bit), TSN_SW_POLL_DELAY_US,
>> +				 TSN_SW_POLL_TIMEOUT_US);
>> +	if (err) {
>> +		dev_err(sw->dev, "port %d: state change ack timed out\n", port);
>> +		return -ETIMEDOUT;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> [Severity: Medium]
> Can this timeout path wedge the port permanently?  When the 5 ms ack poll
> expires, xlnx_tsn_set_port_state() returns -ETIMEDOUT with chg_bit still
> set in TSN_PORT_STATE_CTRL, and it neither clears the bit nor re-drives
> the transfer.  Per the comment right above the precondition check, the bit
> will not re-arm, so every later call for that port hits:
> 
> 	val = sw_ior(sw, TSN_PORT_STATE_CTRL_OFFSET);
> 	if (val & chg_bit) {
> 		dev_err(sw->dev, "port %d: previous state change still pending\n",
> 			port);
> 		return -EBUSY;
> 	}
> 
> That includes a subsequent probe attempt, since xlnx_tsn_setup()
> propagates the error and aborts registration.  Meanwhile the state field
> and the 0->1 commit edge have already been written, so the hardware may
> still latch the new encoding.
> 
> Would it make sense to write the commit bit back to 0 (or otherwise
> re-drive it) on the timeout path, and to clear a stale commit bit once
> before the first programming attempt in setup()?
> 
> The exact behaviour of the commit bit is not visible from the tree, so
> this rests on the assumption stated in the comment.
> 
>> @@ -18,19 +102,83 @@ static enum dsa_tag_protocol xlnx_tsn_get_tag_protocol(struct dsa_switch *ds,
>> +static void xlnx_tsn_port_stp_state_set(struct dsa_switch *ds, int port,
>> +					u8 state)
>> +{
>> +	struct xlnx_tsn *sw = ds->priv;
>> +	enum tsn_port_state hw_state;
>> +
>> +	switch (state) {
>> +	case BR_STATE_DISABLED:
>> +		hw_state = TSN_PORT_STATE_DISABLED;
>> +		break;
>> +	case BR_STATE_BLOCKING:
>> +		hw_state = TSN_PORT_STATE_BLOCKING;
>> +		break;
>> +	case BR_STATE_LISTENING:
>> +		hw_state = TSN_PORT_STATE_LISTENING;
>> +		break;
>> +	case BR_STATE_LEARNING:
>> +		hw_state = TSN_PORT_STATE_LEARNING;
>> +		break;
>> +	case BR_STATE_FORWARDING:
>> +		hw_state = TSN_PORT_STATE_FORWARDING;
>> +		break;
>> +	default:
>> +		dev_warn(sw->dev, "port %d: unsupported STP state %u\n",
>> +			 port, state);
>> +		return;
>> +	}
>> +
>> +	xlnx_tsn_set_port_state(sw, port, hw_state);
>> +}
> 
> [Severity: High]
> Does this bridge MAC1 and MAC2 in hardware even when the two netdevs are
> not bridged?  The DSA core requests FORWARDING for any user port that is
> not bridge-offloaded, on every ndo_open:
> 
> net/dsa/port.c:dsa_port_enable_rt() {
> 	...
> 	if (!dp->bridge)
> 		dsa_port_set_state_now(dp, BR_STATE_FORWARDING, false);
> 	...
> }
> 
> That reaches the BR_STATE_FORWARDING case above and programs
> TSN_PORT_STATE_FORWARDING on the MAC port.  The ops table below adds no
> port_bridge_join/leave and the driver programs no forwarding vector,
> port-based VLAN, or any other isolation register (the only registers
> touched are TSN_SW_STATUS_OFFSET and TSN_PORT_STATE_CTRL_OFFSET).
> 
> So after:
> 
> 	ip link set <mac1port> up
> 	ip link set <mac2port> up
> 
> both switch ports sit in FORWARDING in the same flooding domain, and
> frames received on one wire port are forwarded out the other in hardware
> without reaching the host stack.
> 
> Documentation/networking/dsa/dsa.rst says of setup():
> 
>    "This function is also expected to properly configure the switch to
>     separate all network interfaces from each other, that is, they should be
>     isolated by the switch hardware itself"
> 
> Should setup() program a per-port forwarding domain (for example a
> port-based VLAN allowing only the CPU port and that port) so standalone
> ports stay isolated?

Yes. This IP bridges MAC1 and MAC2 in hardware by default and so once 
both ports are up they share the same flooding domain. I'm looking at 
per-port VLANs (tag_8021q) to isolate the ports from each other. I'll 
address this in the next series.

Nagadheeraj

> 
> [Severity: Medium]
> The return value of xlnx_tsn_set_port_state() is discarded here.  Since
> .port_stp_state_set is a void callback, an -EBUSY or -ETIMEDOUT failure is
> invisible to the bridge, which then records e.g. BLOCKING while the
> hardware can still be FORWARDING.  Would at least a dev_err() on failure
> here help make that divergence visible?
> 
>>   static int xlnx_tsn_setup(struct dsa_switch *ds)
>>   {
>> +	struct xlnx_tsn *sw = ds->priv;
>> +	struct dsa_port *dp;
>> +	int ret;
>> +
>> +	if (!dsa_is_user_port(ds, XLNX_TSN_PORT_MAC1) ||
>> +	    !dsa_is_user_port(ds, XLNX_TSN_PORT_MAC2))
>> +		return dev_err_probe(sw->dev, -EINVAL,
>> +				     "both MAC1 and MAC2 must be enabled as switch ports\n");
> 
> [Severity: Low]
> This adds a probe-time topology requirement that isn't mentioned in the
> changelog and isn't expressed in the binding.  In
> Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
> the wire ports are described only as:
> 
> 	patternProperties:
> 	  "^port@[1-2]$":
> 
> with no "required" entry, so a device tree describing only port@0 and
> port@1 validates against the schema but fails dsa_register_switch() with
> -EINVAL, taking down the whole DSA tree for that conduit.
> 
> Should the binding mark port@1 and port@2 as required, or should the
> driver tolerate a single wire port?
> 
>> +
>> +	/* CPU port stays in FORWARDING so host traffic always flows.
>> +	 * User ports start in DISABLED and transition from there under
>> +	 * bridge STP control.
>> +	 */
> 
> [Severity: Low]
> Is the second half of this comment correct?  The DSA core replaces the
> DISABLED encoding on the first ifup, with no bridge STP event involved:
> 
> net/dsa/port.c:dsa_port_enable_rt() {
> 	if (!dp->bridge)
> 		dsa_port_set_state_now(dp, BR_STATE_FORWARDING, false);
> }
> 
> net/dsa/port.c:dsa_port_disable_rt() {
> 	if (!dp->bridge)
> 		dsa_port_set_state_now(dp, BR_STATE_DISABLED, false);
> }
> 
>> +	ret = xlnx_tsn_set_port_state(sw, XLNX_TSN_CPU_PORT,
>> +				      TSN_PORT_STATE_FORWARDING);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dsa_switch_for_each_user_port(dp, ds) {
>> +		ret = xlnx_tsn_set_port_state(sw, dp->index,
>> +					      TSN_PORT_STATE_DISABLED);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>>   	return 0;
>>   }
> 
> [Severity: Low]
> Should these error returns undo the CPU port write?  The endpoint port has
> already been committed to FORWARDING when the user-port loop runs, and if
> xlnx_tsn_set_port_state() returns -EBUSY or -ETIMEDOUT for a user port the
> fabric is left half-programmed.
> 
> The core does not call teardown() when setup() fails:
> 
> net/dsa/dsa.c:dsa_switch_setup() {
> 	...
> 	err = ds->ops->setup(ds);
> 	if (err < 0)
> 		goto unregister_notifier;
> 	...
> }
> 
> so probe fails, devm releases the register windows and frees struct
> xlnx_tsn, but the endpoint port stays in FORWARDING with no driver bound.
> Mirroring xlnx_tsn_teardown() on setup()'s error paths would keep this
> symmetric.
> 
>>   static void xlnx_tsn_teardown(struct dsa_switch *ds)
>>   {
>> +	struct xlnx_tsn *sw = ds->priv;
>> +	struct dsa_port *dp;
>> +
>> +	dsa_switch_for_each_user_port(dp, ds)
>> +		xlnx_tsn_set_port_state(sw, dp->index, TSN_PORT_STATE_DISABLED);
>> +
>> +	xlnx_tsn_set_port_state(sw, XLNX_TSN_CPU_PORT, TSN_PORT_STATE_DISABLED);
>>   }
>>   
>>   static const struct dsa_switch_ops xlnx_tsn_switch_ops = {
>>   	.get_tag_protocol	= xlnx_tsn_get_tag_protocol,
>>   	.setup			= xlnx_tsn_setup,
>>   	.teardown		= xlnx_tsn_teardown,
>> +	.port_stp_state_set	= xlnx_tsn_port_stp_state_set,
>>   };
> 
> [ ... ]

