Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794402116;
	b=YiS3at+j0r+0wzFR5UsiP7a1s+gzbkQZZ4xKWMGaSnG8cdaAYpMcuIDIn2MYQKdxh+I9
	 2pIsvYvbWvrjhJ2Fo7oEKSF/ZErLS8kRl8RmW2247pWEZPoYZEdHIcfDEx43nJa/1co+Q
	 dDJgoo1V1BoMuVGR2b5BVz6h9HnBklNutolHx1aMfPMmM3XMtUFSg4eIKl/92EoaUp3fL
	 RyOdylKYY0U/pSOcwsLqrBu72+OnevbC/LLm25g14u89TkX61pRC97WXOyEs6Rt8ozpik
	 guiXQxmzA3UVnm+9/oS31pVVRvlYiICUWuFzwgfS7c+juBOlwNOx83xp49FHffjpwaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402116;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:In-Reply-To:References:User-Agent:Date:
	 Message-ID:MIME-Version:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=RxRNwrYFPTvPifH3hqkyYVyXyMJ9nlE+QTRIGJOFbF0=;
	b=MKNgZ6YsNfClYX34DS0TsiKOoMbgHEYcIkOF5l//Q1ZAIGiaPYqJCZl5akESsvpBANm5
	 x7MKjlEPXLz6euDuenH5yzHjYQVi6lt8UkOMGzl2u52Za86ppAToVqGYmyVWUH+zHaS+f
	 Z9HYTpfgYZm2jS6ztnURMEzhY1pzbfBxGz/h9lJ7ZA17Wl52bB6K8262Levwu0fThCr0K
	 QBS+fQ3QxixmOjyJbFQExzaeNPUpYwMhdCAJzM/2xvr5jTgru72eL05MOfue0Oz4EuSHv
	 pDWPX4OtkTIUkKfCzyBcPexQLD7GK++JEDRpyHGpSyFPmfmBcnoIbOs4NAjpvyoIeRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bxijEdiM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.3
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011003.outbound.protection.outlook.com [40.93.194.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4338A606A326;
	Wed, 11 Nov 2026 13:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4338A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bxijEdiM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CjlugRTHYhRFAEOc2bYq9aAb26HTOPAwjGW3LwLe6PLum57wZmlHVECugSb2dnLDd+7/H0RJYPUL3/O+gf3WOANjXf25v5QBz1e4TPIM7vUnJTT/VkNJj/oxXInpWZirmoL6AF9gtaFn8OGLI0GQk7iZ3ERQppjJZ8E/0rQbiY5AQ+2mo6DdTOVNdnDBcdVat0T4ez+AGK1GW2wbr8+WqjRSMlJh2Xhc2QuoglipBm+IIRnvUIZqO2Y9SjAL4JHtL3I5C7bryVYMoD1T8q2Ye6A1qUwko2SP0Dxk9SN0abcAr12i8Q+ERBIMkMl1+AHjWbrN2BKO0vhwgbVVmnwMwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxRNwrYFPTvPifH3hqkyYVyXyMJ9nlE+QTRIGJOFbF0=;
 b=hFZBq4yxTOF8D5e92iGWVCFZfIcbzeySZE3gr+7QGVs3SLlzNmv7Sh2sOmNGs9hjeyV2oIZOExNufwG9MyY5MSwqp2Bl33vgxFo3+sJbfK9SB0/jhn9Ru4SlPOMXKxfwk5VWnONe7qkGZm7FAo4r4WBrRzQjuLxkhx51M515QKbUabRUi9EQJZuxPRcv85w+S9oFwYUc257fvgJZLGsyU+7NIBXQ9mB/5qNn4WISleXuJkV9jEjKgAtJQ5Brq4gOns2QRBU03k28JMhG+0xwC7HTYy2Uz8OFeSDeSuKvfAvvZ9ZJ3BPcA+PW53XxauXGLJB9+jmzdLg12iCRXVQJ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=qq.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxRNwrYFPTvPifH3hqkyYVyXyMJ9nlE+QTRIGJOFbF0=;
 b=bxijEdiM8K3CXXM6DxCmGmzxCAhuAK3ni4j062Cm3mQb7KR8hEkOy2wOfcYv1lQ5QhQ0iTxhH+hFzHRMHZbVmxE3fnLHPcbY+rXY0GUSnwsF8CU/x69F1EhFl0p9JzcV3FFI0OuY+pknah32hH7sjJ54YpMpoX94kzokipEn4eMKYxhYTriq4iNtSwo3TuUtus3C9hFwTkS1aV/YbC0NE4OrI173vvbORLj+za+BnZGx/P+usluLZFP/cwlYpJxX5U2qzollf65lDLXtO9Qj4YoYpgoUUM4YQ8SrxXBQzcKLdynWn8SwKjbV4LC3HKM2gQEo2BGaKOnESAfF+SUX4g==
Received: from DS7PR03CA0120.namprd03.prod.outlook.com (2603:10b6:5:3b7::35)
 by SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 13:01:51 +0000
Received: from CY5PEPF00000E79.namprd02.prod.outlook.com
 (2603:10b6:5:3b7:cafe::7) by DS7PR03CA0120.outlook.office365.com
 (2603:10b6:5:3b7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 13:01:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY5PEPF00000E79.mail.protection.outlook.com (10.167.247.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 13:01:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 05:01:33 -0800
Received: from tuxedo (10.126.231.37) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 05:01:28 -0800
From: Petr Machata <petrm@nvidia.com>
To: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
CC: Daniel Machon <daniel.machon@microchip.com>, Petr Machata
	<petrm@nvidia.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei Lazar
	<alazar@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <1342116488@qq.com>
Subject: Re: [PATCH net] net: dcb: flush rewrite table on device unregister
In-Reply-To: <20261111033114.133296-1-sunwenbo@cmss.chinamobile.com> (Wenbo
	Sun's message of "Wed, 11 Nov 2026 11:31:14 +0800")
References: <20261111033114.133296-1-sunwenbo@cmss.chinamobile.com>
User-Agent: mu4e 1.12.15; emacs 30.2
Date: Wed, 11 Nov 2026 14:01:25 +0100
Message-ID: <871p8ry122.fsf@pmachata.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E79:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: ff550d47-2229-41e7-1b10-08df3ff3f3aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|82310400026|36860700016|11063799006|5023799004|56012099006|261021121427099003|261022075727099003|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	F5/+m7blg5KNTc0MDWhgBr0iNzUBHVGJrBKKbuyf/RM4PzDxA63qDQ0yTyi4enMCHJSt6xHXShyzHjUbHfFkRDszSG581+BdWQBkwNJ7Qdtgtp/SLLyc0OQ+sVfIw/PEBgCrRbrEmCly55c6N9jGVo0OzPhX748xyXTLkYOSMnRlmK7wYMr0TNsy7DF6tPplcIgbyiRDKsNi/GdDdxUacc8xsGMZhKbr+z9ZM9mWIC8nnd7ol7jGbgI072LgdusE0ebrjCld9B6HyhwvdbSNMKYXDWN7f685sbKKICatY+DOys56D2d89cWrk51p09q+/8Z9DeUoibzr2YoxERznzJR72pWy5rCir0ttkcDajN+td6WakpOzacytnQ6ZGDoHz+fdfgRXN0Nq3jTS4yZfeZFMHZ6AeksTOBHgXMnaRgovNPQ3MPx/nQ2Wjwj1J+kFrTrunxObmyGh1DyDKRXnirxsIIyHmrRiaD5KFbfR2NQD42vzFiQH0EnMPVEfkmTXuLF8omm6RDo11g2szuasQEVd9vYNDRbFrafIh6ESghoQ8gemPGXsOB6X+GmMPjAZheK/sNlLX2+BalL11M4+YhhSU2qLyx/sRMWA9HPqk/sASoipIDPaHULPICru6rdCLJKYTsf0qPTRpzbgRswkxTL95QEyLHlI92O/cQg+AzXsDT7iHcPgw8otzLNBthH4RRNUrrECX3csaxuneTdl/w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(82310400026)(36860700016)(11063799006)(5023799004)(56012099006)(261021121427099003)(261022075727099003)(261102123227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	e9kYAyb5Bpl4yyKVNqnDg8hqC24JRYFEsReTc0AQMq3eKjhSgoNZD1uf7Nt0FhtITDK2CJcu8vn7Jfo7ENgQmyeRuwP49CD1YerRBSrcoTLB3CBwxvW+qigFdcFGcCFZL5N/oy84sfgSCxckWF5bHSJvzqDq+RlTpneK85yYBXr+UyDc0XZDEbVha0kB/KR3uK3+MqDvUFksmVnpoTSLMaqXakZSCKpAab4ucFMw92YT46lP+I0pp2Gc6cSK8gXRRSpOqLueDiXHFFLkMwyuROCK5YKev7+LOBM5IbA4hwhv6k2m2nozqotgHnzem/okLeKTHbEeBNxDXA6waqp1dhApEpgvhT/2iAXFi2j1MpnRAR6n6y3Ny1yn3HiecwN7tFe5ckGCw261eDjIIaMRdWikNOB7Saz4iwH6+NSgLmnGIKW0oK1A//X27GXpO74f
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:01:50.6590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff550d47-2229-41e7-1b10-08df3ff3f3aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E79.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614

Wenbo Sun <sunwenbo@cmss.chinamobile.com> writes:

> In dcbnl_flush_dev(), which is called upon NETDEV_UNREGISTER for net
> devices with dcbnl_ops, only entries in dcb_app_list matching
> dev->ifindex are freed. The entries in dcb_rewr_list added via
> dcb_setrewr() are not flushed.
>
> This causes a memory leak of struct dcb_app_type nodes in dcb_rewr_list
> when a DCB-capable net device is unregistered, and leaves stale entries
> in the global rewrite table that could inappropriately match if another
> net device later reuses the same ifindex.
>
> Iterate over dcb_rewr_list in dcbnl_flush_dev() and remove and free all
> entries matching dev->ifindex, mirroring the cleanup performed for
> dcb_app_list.
>
> This issue was found via LLM-assisted code review, confirmed by
> reproducing the leaked rewrite table entry upon netdevice unregistration
> in a User-Mode Linux (ARCH=um) environment, and verified in UML by
> confirming that all rewrite table entries for the unregistered netdevice
> are flushed.
>
> Fixes: 622f1b2fae2e ("net: dcb: add new rewrite table")
> Signed-off-by: Wenbo Sun <sunwenbo@cmss.chinamobile.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

However, this has never worked, is therefore not a regression, and
should target net-next.
