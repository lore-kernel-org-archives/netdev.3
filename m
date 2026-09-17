Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011027.outbound.protection.outlook.com [52.101.57.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317354EC659;
	Thu, 17 Sep 2026 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655794; cv=fail; b=GYxGJPFiJQTLZs7yE3eU45AbKS/8MQTcv9kXmpL0rhK8CZsxQROgJ331iqC46iwbdF+pKOFurkCgtADfm18NO9kRDxHIYomwqYiB4MfRwlKNCUnPIgWKtUeleI/s4fW5J5g7L1lq8iHBmZg1ACnqdwOY0+uoqeR4JEVThCcxfOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655794; c=relaxed/simple;
	bh=e7Pao/sYaCExUKMN83kKCn/Lom1g6cdsJVpAolt6hk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WMf4sW03qobnPSFKeCMVQKAxFzSk4OA+R5nV9LXHMTAD04mVwmhhce5wNlR0iFW0EiOunijua2qpBvD8yiz21JuWiDKq/Mw5Z+qWyWNtPV2+mfEC+C7WckfFvLILNcco07lYnKx+7hLe1DEe2TpIG+z6Lv+ccjdbhCBrHwAl930=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cyFFfc3J; arc=fail smtp.client-ip=52.101.57.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cyFFfc3J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbXLgA1RzYXe/QqJ/kKy360R2XvGiiTBXO4qUy9t/brlzgxEl9b/vIrpKhy08bBS7p7D3H8ClAr6DwU6eg+1zISEsrXHG50ef0LSHGFr2QnsgpfScSEj92k/jPP2CQXeYR4XlTr/9yC7yMruQnOKnrd47sxBz8ye/8PN7wcV/KDxoxNjYYKxGdZ90Di0g8Y/H/yP05RUszQ5yNJS+EjMBgLEVYkabeUXiAAkpUvnxd2Ap+DonyOA/LWZetOm3Di8Rd+7jfp8EZ3JdISQFcvaV56d14pt/6UNi/EsbFiskBZJUaj+Ix0gs6PfAaxAynQC1quCiX+a0z2TGxxF93b2Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIkZOLrISs+afL6+mikM+sEExrqNfANe7+CYnMLCEFg=;
 b=mOutDKI+2H+x6/vR0+qRqdoCu7NuSTVYqU3MluXPgpy0pYi97W91LHUYNDKpa1mOaObgjnqRO6PnlwlN5fV+UKS2Llal1aWxw64zuACcprlo9/VcCymAQzbJ9TWy8SDxIRwkgm43Q2UD24L5k1+QyGycvrRPu0t5UnBS8myMS8XWZM1kSW4QZ/7CKCcyzvNxbeuYoqI/1dtlkhyeajklQIZn7hK0xO+c4XKRHzGKTINqInRCpIUJz3huOEBrtjTVO4mmotU5+r+yjB99hZlewTg4BHhFLCr3dCRUnuFr4kDbeaSmbXzqhxjTsZhCwPwLjoxAFACyIxV65SgC8AMMoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=fiberby.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIkZOLrISs+afL6+mikM+sEExrqNfANe7+CYnMLCEFg=;
 b=cyFFfc3JUM9ap+u8NJsN2n5iKrFEqRiSFlZ7gAMPMyzz20KFmmfMQBo7sBPT9dJh+tHpGxqvEbEOqsl70yNOHutnZ0fTUd3hSnClm5VREin062II2kqExHJIKrEJa09+Hg+UgvPen3K3PFIT854mr7TIu74jWwjJtr0ThqBKYlQQX2o73f4YcLqSdBbC2dd3ZJiKqL4iTjl0+oeC6ACZ8IiCrjAruMEGTr0PWtySgYuEUo5vtXS6DEM5UR+pN81ywip+wGGcEfYF3OSTVlMmhz3vSw2RTjkZqX8nIBkJ3JEGH//+P+vb16yvYJ9u244N1YiQL/pHX94SaHrg0V6X0A==
Received: from CH3P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::35)
 by SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 14:36:25 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::58) by CH3P221CA0004.outlook.office365.com
 (2603:10b6:610:1e7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 14:36:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 14:36:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 07:35:54 -0700
Received: from [10.242.158.215] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 07:35:50 -0700
Message-ID: <b7fb15eb-916d-4006-aed7-8e3057a0c8a6@nvidia.com>
Date: Thu, 17 Sep 2026 17:35:48 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/10] netlink: specs: devlink: fix
 resource-scope type
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
	<netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
	Danielle Ratson <danieller@nvidia.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>, Or Har-Toov <ohartoov@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
References: <20260911214148.1184806-1-ast@fiberby.net>
 <20260911214148.1184806-6-ast@fiberby.net>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <20260911214148.1184806-6-ast@fiberby.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 815054ad-d959-412d-e1cb-08df14c90cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|23010399003|22082099003|10067099003|4143699003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	KLT1ywsjLiqfkJE1r1bjC9SDXvh5tHRSyDJJ39lCc6zSlAZblKtaTv/T1k+VjKmuVtm3TKhHh2ofvrNkzrG4TxlTV/HVMIkYQe/BuqeUJnCRy/eSIuJHYsCcblce+Wmfq+rnB+NRiBMrdv9b+jjQ5hmNxnGkycHj/qz1Z+Ue/uPiRryBfRbh2DZxU2mCXtLZJwl6m3QFqHAc7YcCZJt1bOy+d+XzwndKM4YL8AAb+Kj62wQAjwix2jDmhEB5xf3ItoFPaYJFguG4POLtgZ6Pfju240n3juu2uImficWQBOMSf55uyap+S5kFcUnLFeuYzhpUtb/Z6II1A0b/t20FLVuF/+KeUH9Sqbr7L4YaFL2WutnbpFLt4LKBb/RZIF1cDTSCpnKXMgdYDbaat/S7n4olmxXamlytjEAeBUXGlz/qpsULTmCAtKfzYH/0xH7D/brZEC3H4cybmga4PSWQxp8TxxztRbMVhN4LzTGWlsc7qjy18/old3yhDP7sAAEfNVTb0YxIahXyyHrLu1EH8N+5m9DCVb9r55Mz1ypwCzIsw3aerkx+TvtJYGkqtwmYR+GgoXnr/GjqYfGdPSLHjGRbLeNrapSzIaccRxbqbSE14TaPLxuuH/7awQee3vsO8O93R3v4LUIGeeSqYlJL9Qbt9BEauRNTw4Zi3RW6S7hwjMasGN2Gq1r/CjZJtLG2LUPu2DSObHKOdcS/W7whSg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(23010399003)(22082099003)(10067099003)(4143699003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mREXxS1Uj2IR2HFIAmm8c8vGCYiFuur2kZLGbLVrqPdPJi94tQCGs5iAplVsvKarm9fRuynszQx3xcH77jfNtuTZRCvP3kuLUVzvgAmBvha4cFLuzOJ7+nB25iBiFQ9Ak04+IXNPVhwbu39YRKPNs8InhnzlRFSxJbesrzNlNtEb7hmdhVbKIOLzc0tJEcT/sPs/OoQLh1M9EPtQ6Q7PibW2MIT4f8tpTyMSadusvgUm3hTRm/fheK8RLCwYAVXrXjZKpa9qy1Sv6Uk01jXRpNdl/TPqLeYvDVuJc0WsYlJfeMCjXo6ea/1sbp8iVs1xy36O52JF9CID+Al+nukudU2mdueDLL5RPey0DqN5I2iS0RPT6Yt6vZJbb5sTTvvmM0jnMtv22IaY3k8K8dgpg5Q+yslcwzdYaMRP2azjVskE/QG8tSywM/zbK7X1O2HV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 14:36:24.4278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 815054ad-d959-412d-e1cb-08df14c90cd1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370



On 9/12/2026 12:41 AM, Asbjørn Sloth Tønnesen wrote:
> 
> The correct type for resource-scope is flags, not enum:
> 
> - DEVLINK_RESOURCE_SCOPE_DEV is _BITUL(0) aka. 1, not 0.
> - DEVLINK_RESOURCE_SCOPE_PORT is _BITUL(1) aka. 2, not 1.

Note that once the resource-scope is defined as flags, the 
"enum-as-flags: true" on resource-scope-mask is redundant - please drop it.

With that:
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>

> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> CC: Cosmin Ratiu <cratiu@nvidia.com>
> CC: Jiri Pirko <jiri@resnulli.us>
> CC: Moshe Shemesh <moshe@nvidia.com>
> CC: Or Har-Toov <ohartoov@nvidia.com>
> CC: Tariq Toukan <tariqt@nvidia.com>
> ---
>   Documentation/netlink/specs/devlink.yaml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
> index 38b1190f3d26..0b3160e201da 100644
> --- a/Documentation/netlink/specs/devlink.yaml
> +++ b/Documentation/netlink/specs/devlink.yaml
> @@ -158,7 +158,7 @@ definitions:
>         -
>           name: entry
>     -
> -    type: enum
> +    type: flags
>       name: resource-scope
>       entries:
>         -
> --
> 2.55.0
> 

