Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4673175A68
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 00:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789259715; cv=fail; b=dywEg8SCIg1R0YRA2pdTtpVPe+5SOmpyDoNaLiQuf9BzouS5Y1g2UXqTEG7odNufsieGlSZy0bWq/yb6eogKCLIzoACfpGiPkfWJ9jgaYzDUfXULtOxzswilbLdpWspWoeZmb29Hn9KKTXRPtbof3/VdheMuDL5DTf7zkEiVFRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789259715; c=relaxed/simple;
	bh=bbBUgVy8BTO46FzwBRX5dx4fVOIjjwv3kQ5Gr8GzEZc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=oe1fyOMWhYoAi/POZU/0DoJsgejKCtO6OHHj3ucTcwaej/eMQXmWJOzekniRsNf6IQYTPmtpb3Tl0azvtbSkn7viYDxXRzbToAIwWQ+pEbsBrJmCAQaECyoGijojEyKCRM92UmHfxlZV0ezWm8T0nI3Fh2d9YgDjNDQ0aKMf1HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XWMxj/8l; arc=fail smtp.client-ip=52.101.46.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XWMxj/8l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rre1Dtfj00kv+QnNRzG+YAliX/nH6gFSNHP+WtIFLdFNkL4GU+tEgfxEnOEs65G+5cSjkeuJAndccOrqbfJLZ+ZHKE52JiGHjaFmBEyOeq/HQXCCouAp7Zom90Fr/bdFu7eCjqFu3YEaT2Cka6vcAvl5CwzZMHX098crWFbemAlcmLRjC3XeZveVil+JPs7aB2K1qz1loh2e/49wwRlTBKwjpuWpOlt0HoQoaL5ySMJ6CfcnfGWsSViQkqeURtC/Z3RGwySPx+B9gQGYKA1m1JQ3Yy+CLalOF2U1ckrOALsAk43skraxRy/xC+CiKC2UpgBk2Nhhst5ZqSO6PBW8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvKFgnbZ1Pan5IfnGT/pzImZU8EFTGmhkNdZuZYCTfY=;
 b=MOpklORoVvOz4xr+3fXwVohLuRKH72nZUGhQAIV99tvIdznxlkpa8gfhloZQmTn9BH7RUUFxPqnQ+p8Q/E8M2xq986XnzkbBmyc1taN+9cujaA563KID79Sm+jWVeFqVirFC5OL3dKYYLIXgnyAIpw7uzchIVcG0rlxx2VYs0/7YjAzaDfBAJg6SpjO/5X9Y7D1OiiNClyRTHg758lsfUjzWb4h9Xczha98Lzxx9Y7jUcFXMTJq0+0bE6MnJvHFMJMdQun5K1xWRnTdQKLqbIEUtazAM4oR6k5KiRSTc1eOU0pcSAehsMrrh7WYqeUK1DKRNF1KhvCmdFWMT1YWEww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvKFgnbZ1Pan5IfnGT/pzImZU8EFTGmhkNdZuZYCTfY=;
 b=XWMxj/8lz749goZSBVD2klwa/ha+rZZejkek6VEYiTFhYcWGgqtd8v/lvOyERrDEDe+aXSc5j+2y19+BlQxa516iF2020Ydsdbuu9y25uED4edqAoKpCXRTqnQz/KNUNEFYcfOr7CzJGOkz/8tcVPezQby1ERHDrMDveBBwWFJftcNdeUUiCepjuMyY9MiUo8cghZqv0FoPXEUJkSJWeFJUN0Zqn6h0F3nM6m4pXK9soKYqQ4mkIqppp25Qc8ptO73GjkipDYu7aX4VDT9hdJ6p3Y2FZkDL2oi9zTXL8qjl0kmJFzCBRM2wi2ArRnAuoOn+j5mqj3krMSdyX0T03Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB9490.namprd12.prod.outlook.com (2603:10b6:806:45b::21)
 by DS0PR12MB8814.namprd12.prod.outlook.com (2603:10b6:8:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Sun, 13 Sep
 2026 00:35:06 +0000
Received: from SA1PR12MB9490.namprd12.prod.outlook.com
 ([fe80::7092:45bd:c4f7:e583]) by SA1PR12MB9490.namprd12.prod.outlook.com
 ([fe80::7092:45bd:c4f7:e583%3]) with mapi id 15.21.0406.007; Sun, 13 Sep 2026
 00:35:06 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,  Andrew Lunn
 <andrew+netdev@lunn.ch>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Maxime Coquelin <mcoquelin.stm32@gmail.com>,
  Alexandre Torgue <alexandre.torgue@foss.st.com>,  Gal Pressman
 <gal@nvidia.com>,  Carolina Jubran <cjubran@nvidia.com>,
  netdev@vger.kernel.org,  linux-stm32@st-md-mailman.stormreply.com,
  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: report phc_index as -1 when no PTP
 clock is registered
In-Reply-To: <6ef48513-6302-44a1-833d-613f2b8a9e21@bootlin.com> (Maxime
	Chevallier's message of "Sat, 12 Sep 2026 23:39:02 +0200")
References: <20260912-stmmac-fix-phc_index-v1-1-26e1ead25324@oss.qualcomm.com>
	<6ef48513-6302-44a1-833d-613f2b8a9e21@bootlin.com>
User-Agent: mu4e 1.14.2; emacs 30.2
Date: Sat, 12 Sep 2026 17:35:03 -0700
Message-ID: <87v78avvig.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0187.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::12) To SA1PR12MB9490.namprd12.prod.outlook.com
 (2603:10b6:806:45b::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB9490:EE_|DS0PR12MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: ee825c42-92e1-442e-43f9-08df112edb9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	9YKu2dKBQa8jylUcmMypyiXn6rEsbyG2PIAsKqjqHPPTjrRHEEM7gNdkKT+huEofrRaO8JXH4n/a9Npv8bXx3AceeooNxsnIlz5Ragaz2dZgDze4lQ40sNTvDc9RjvQ+58hpwxfjhEzUc5kE08z3rC+KGaBmDDsMRo37xHP2txoNctVh0ChovVmKW5fOFJebFBwUGN9jUARmys4i7JzYdgHEL42Gaksm/TKNhDDh4wXe0XiTZ0Usot1elFKTc0QqDpBPhQjepHMh3pDZI4Qy5q9KsBO03kmOBwIvQpXOGGYJoElRtUr971H6kNhh8FOKUQdwV7iUKmwVO8ETi1VqjxrcyY1t+xBO6MkyNu0gmVK/cFgr+zHUCVDxGmEFTRdZegO/6xaoQdrhh4oBFrwQ0QDwPuDNQzmelHw/kaMWUwtxlp8mkDhW+rAS5xQXtInd99enNoo3SJyfXNFQM9XmphYwQ+DioHv98UWtvYPta6Z3Y9lIAcRj2Rg2AVe7TPlrY7QPuBA8kj5gkeD+ovutJuFDsNT0e5GDRoMK18N2WbjqiMPd5Xy57FqXoC41JekoRdCaHVwBPpDB5HO153fsdUZDC1aJCExXSog/nWaml6tu90xNsdGI8U/cw+exDqVUmfCJaNK1IMPwh/MXl97w3x6jxwjlqAZARFsWaJetv0s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB9490.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Y35yznVTWKuMP7dCeFW75bAfXPDGz4cUDV6C8I7tIB5L3xNYCew29Z7CR0m?=
 =?us-ascii?Q?UY4n3bJ+vOOm31Pue3QhL88TdM/xXH/wfXsoGaSOdpJ5DeiHq2nfXbBdH/4u?=
 =?us-ascii?Q?7MGxtB8z7cZ9g9TKAfWOlT4KhIrItRSG+s/uKyhx4DEMXaeve5VOorxrIy0k?=
 =?us-ascii?Q?+lNVirTTwKkTN9rTJgJFtD47jBrw7lB5CsJYftvNj1u5Jz+0WD8bv+E73Zeu?=
 =?us-ascii?Q?JZR29BUoz5rcpfDAb/46iWyPQ8LlkQvrUfeMHDJKUR4skXJFftbmPv48/Kwp?=
 =?us-ascii?Q?scRN8aDdsJLZSJ/I6aOkH8dmYB1bZeRWWtiAvwopSzbVn0zBMHQ33TdwkSa4?=
 =?us-ascii?Q?wTDh03/QSJbdKhdHnTnfIQhY3OSH6cRD4DBCWfujU/U3wyO8TGoygk977xrG?=
 =?us-ascii?Q?qvOqyt+m2dHqFhFY8EJy61mmbKDPcxaLjhNdBneLEwYGzXU7ZU/bNRFu7lhg?=
 =?us-ascii?Q?DRGl2XQSSIrVAFiKLPnS9IBOwICmZKvY/YVTuivFkss1co023iSNwmVSrw+V?=
 =?us-ascii?Q?MDShgMemb2Z8NjXWJzkMm5xM1PX7No8uLltrgSfWxnR/LQl0zK26v+ZMJaCm?=
 =?us-ascii?Q?nOM8uCRR8oPPyejcw5oYN3Q6h3ZXlMjiGYl1cZY/78CyhpItESxm0h93KdB1?=
 =?us-ascii?Q?mRtkA7TO3AjWQGHWORkiGZwADX1BscdxZ9zlrDIAtvYVMXUZ8pvTqFaT8J7H?=
 =?us-ascii?Q?hWh8x+qeoupXMwypMrC5SO4xPKhdl/X2cMq/GKNfaWASxmKBv8K8371GY8lh?=
 =?us-ascii?Q?PlO13Gujnlo9jeEjOGW8ifbJGjmvXesqWCBThavrGVRzIW98+kejqrs0CRTP?=
 =?us-ascii?Q?oiEVHjPKSlti3DviwQ1wUFqmvS5GSsk07zjiB9tLqDAykOx37aBARIYo7Tgh?=
 =?us-ascii?Q?uBspYsRJSojFzr5V5ydwyMhxx0A1HHcKCuG/eavOKDt/2esRwrO3ODD3xrO7?=
 =?us-ascii?Q?pP1ji4/5x/fKV7bz49lmeA7dlT6l7am95VxON6aAjTtt9L8KJRB/nQahOOAi?=
 =?us-ascii?Q?l5J6aVuUyDS9U0nxm8uOmnd9tSNJZqcocMMf2M8EfBZGSbUm4FYfUx1fW/Iv?=
 =?us-ascii?Q?txE7WSQzpqajaN45Tjw+3LBX2KzevzBT/Zsc1Ifc4Iwoccc0HVzw6oHgl9zC?=
 =?us-ascii?Q?MaWpWk2gJE5qS/6S23yHaEXwjpt/j1OZfa0l+w1Fxc/zNZFXW2676v+4l8Ln?=
 =?us-ascii?Q?cEXxm0w8CH/sSy78eGf6wIs2jPHw0IDjpSo5wm66qXyCPd+m/o3ZUkovDD18?=
 =?us-ascii?Q?Nev8awemRCVBAJOVcAQJ6MoQrztI+KivuGaz1dsbDbrSPpRYpEzYFdNKybvq?=
 =?us-ascii?Q?Tq1ZkSBpG2j8NUrwtk1NH8KAHLayuoUpNTIyVC4DDGV5CO5a6O3TO2RNwHRD?=
 =?us-ascii?Q?lkNvWHQduiV3+uB56ha8iFdWd2Q0uyTmiWSqpDIWDm5PlCacuylgPiNaz53I?=
 =?us-ascii?Q?CXlPZRveZa8SHW7W74BjsPHpz4BdWX4ryVBeqVTPq6nBefsh1qYE05PCp6ue?=
 =?us-ascii?Q?anz5jK+xVruWJgM+kHuFL/Wn/DABSSR2lxv2bkq6LeTthRV54mZQng3SYSyt?=
 =?us-ascii?Q?fHryDuNu/4qd0kfTfeCdFxNb6fQt30Y6yKFm3Sb+6pySw88VfZxMvzRF1L7U?=
 =?us-ascii?Q?VVFYDZGeRUQgqyib8fDS6l4Rgn6A1C2IRVHovcYQrAvS7nmoOV4M7TdG2Cvt?=
 =?us-ascii?Q?8SxiidaU4L0hlNEFjPipuOAmdF0RAPhZ7ZflG6kAvzv5eXPxjIpi97nl9Tqi?=
 =?us-ascii?Q?55mPokWwBa+LZ9bRDZvr4HS3QUWG8nE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee825c42-92e1-442e-43f9-08df112edb9b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB9490.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2026 00:35:06.1804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57nMEXsJgpSB8ulEInDgfMyF6SGCvFLE/u/eWvpc6grUoi8OAcfgc/sGTuc52KxuQ7TuV9EvrDn1OnDjKLl0lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8814

On Sat, 12 Sep, 2026 23:39:02 +0200 Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
> Hi Lorenzo,
>
> On 9/12/26 23:16, Lorenzo Bianconi wrote:
>> When hardware timestamping is supported but no PTP clock has been
>> registered yet (e.g. while the interface is down), stmmac_get_ts_info()
>> currently reports phc_index as 0. Zero is a valid PHC index and would
>> make userspace resolve the wrong clock; the absence of a clock should
>> be reported as -1, matching ethtool_init_tsinfo() and
>> ethtool_op_get_ts_info().
>> 
>> Report -1 when no PTP clock is available.
>> 
>> Fixes: 9364fa7fcf12 ("net: stmmac: Remove setting of RX software timestamp")
>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>
> Ah nice, I've briefly saw that just yesterday but haven't started digging,
> thanks for fixing this :)
>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks for the change. Good catch.

Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>

>
> Maxime
