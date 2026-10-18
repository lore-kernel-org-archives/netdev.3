Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013055.outbound.protection.outlook.com [40.107.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFA8351C06
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792342533; cv=fail; b=qD4n/uEMJjS3BEsyavZWT896XM3yyfbRAIvpzN9RpDc8snxyzKah4GCGJAk+O37ry4sWi/7WORgKYc2mIzAvLjrPQF/m4c34UP6NVZ+EKrMPoWJHQ9ENzOocrm9sGwllVw8+BU3kmikSasluonHCRloxMxcD9HRtyGj3obg+/J4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792342533; c=relaxed/simple;
	bh=u0zyAmx4mxjP9fEJyLEBnwoFtoDD0bhb9+UnafeH3Bg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nsklqn8+w54cljGS7RchmmYOZg2ahFTZ2D4nzkPMJUS6sz/pNu03rg2Jmv+lQ4V86fMHRhztQaGNLepI0xOOq7qZhnfl1L3GXN6FNAeMTy6n8CQvTTyhqluamODD2cZFMFCD8N7P2BqFP9KHyhdexpUxmacGTlzx3PoJ7jKR5tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qh+6BU4R; arc=fail smtp.client-ip=40.107.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qh+6BU4R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctP3ldZoOW5iIb0gPCMNkatnKfEQCWMWROBW7qEgldSiGPinYjGhncTIU7l/6P4sjtmwSa1cC9Ltp8IXaXmwjnV93VFCG2okS71WcOGcBlcvminaDgIYRXhAMy8q1lV68XgC+RImIRaI+H/z0Zj+cr3eghyznHp5mAzaa9GlmcGEEQU229+778nDlULA7j2xkRAVe+MLa91MA8Sw9DvQ7jj2y7nC9JcQY1Lzio382fonEXAuRnj3q+lLzgfv/ew+1BzkRlCAtaxi7yggwlr+HRR+DMZxCV6/fWFdsIVmxkKleo3agPyf0wFh+U0563zE/NJVcymmrYUbYvce8yHJiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSZwRW+s7zQ4XXCkG/UvZmmLX/w0m9gEWfrfsOBDOPk=;
 b=PyYUxEoGzik0pkH83SDK/floP0RQcpv3dmSwbjzbYJ+KASbiRRbeYHZ/EJzMcc9RJWL5u8/3f4y4HiBVKPu1ABwHSpUQYP7MWl2HA4nHsYD2rNtGVlc5ft3g2i9P8RhhS6BNGBQR/pbt9dji81L1kULBSNazaqg3wE8joSJOrAzmRilGoHjzGM0vhrmoh5Yc5MG+w0r2LyRlyHOqs23HysJWwzn1gvu8nHw/JT5q/HS3099yIaSLb5tzxH0bnqXH94UFcfEpafR3wBx8adxNiJFcVhDRl+b2njuNnamZJqPPSD3Gg8Z/s8IUNtSgn3EQHQtj6fth13MCIDfgsCeKiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSZwRW+s7zQ4XXCkG/UvZmmLX/w0m9gEWfrfsOBDOPk=;
 b=Qh+6BU4RuKxoGlK9QItSAG582GnAQvBbGQOWFIFHRgEgZ2W/vTNoJTjqk1dQJD1zEOBaaQ16xM/+yiy+t9jbg365r5IhRcRIgbTL6irDIe6sqNL8VeME5sJCdV+deoCD/DPIC7fDw4+RY818iR+TaxYb32UiCclfYQ8P6rRXMt0S5cycfmhc9zIUK2lIud+wXKajPHC/OeeZnCawc6oX90oNcudJhmMMFJC5xtALMd5IBtE3zRuVtXEuxUwueGACK88s5d5V1O6kEVumtL7m+IhhOilnKPSccygQGKrxMe75nJxqlsNxFUnEiskH50+fUefUVW+UpNd+QkEsqMLi9g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19)
 by SN7PR12MB6982.namprd12.prod.outlook.com (2603:10b6:806:262::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 16:55:29 +0000
Received: from MW4PR12MB6802.namprd12.prod.outlook.com
 ([fe80::51f4:a3d9:b44e:9587]) by MW4PR12MB6802.namprd12.prod.outlook.com
 ([fe80::51f4:a3d9:b44e:9587%4]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 16:55:28 +0000
Message-ID: <ede9a336-1be7-47b8-bb6c-e6c428d1fa2f@nvidia.com>
Date: Sun, 18 Oct 2026 19:55:20 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5e: Update netdev features only after a
 successful ringparam set
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Gal Pressman <gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, netdev@vger.kernel.org
References: <20261017005401.1582755-1-dimitri.daskalakis1@gmail.com>
Content-Language: en-US
From: Nimrod Oren <noren@nvidia.com>
In-Reply-To: <20261017005401.1582755-1-dimitri.daskalakis1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0198.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::8) To MW4PR12MB6802.namprd12.prod.outlook.com
 (2603:10b6:303:20f::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6802:EE_|SN7PR12MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: e9af9e72-f1a4-497b-51eb-08df2d389ce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|10067099003|3023799007|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	8QM0hbr69VD+vwNbyH6AlifcTLcIQ5ZMOuyuT2hjiMb2K7BtPe3nd8G+OtJQ2M0FSkizpAmCVgVExGjWzz50I29OR1Q1vLG+CWI0Jqo7LFjFwjgmg2Pt6W7xObT4/NTYny5SSrH6FNzXR9usIb4hsjw9MN9FOO/gHxQjSt6pkpN6i5U1hc57DyCeR3zpfOLj2EAcFFis2XHjREQxz6dGoV8hlq8kh/5/HwgTJYHwHr1EEsA4st/cKRLq8fLazyBheAA5bEUi3MYzIL4wPGSI0Ob/TdsP4x5Od29o1PFr6S+dRoozYa/ueWSz2InvvdHH6wXkITfatgxuiApdF+vzF2RG7s0pnFomxQ2w3BIYjF3DofELKPUdV2ZUa48TPSxffizX4i3KPWiTQWb+/MlkAGioh697HBa7nK7rJXcbYgsPU5ItPxIB2D+B3Iz8hs755Eeh5OvqGxqWUhnGsePTNip4qIy3hj72xqRBTD+Fr9dHWJhYBnPVa7Z42hougHuEJWca8gisyY8hiDN/HJRUn/KUHBFKOkC1CuAdbvVBAb7MvRpPI96l6ANiMVqeE5CqmEVgvibcg3iWzNYjqfR/Pcw9UK+nV2PZ7CulKEmwgLUXZ50+byQaWCdyQDjMhvsTYwGloDrzpVyfQZ0zR9bV7X//ICF2b2QzpGzMzX5obIE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(10067099003)(3023799007)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHgvc1h3c29ERElBempHT0U5TTliSmY0Yk8ybEtRVzlVOEUwbnBNVWw5Z2Ji?=
 =?utf-8?B?SFZudVNWL29CQmd6YWRlS3h6RFdmRFNrYW9TU3FTRy83L01WOEExSjNUK3hs?=
 =?utf-8?B?Z1E3UUI4M0VLeXFGR0owR0ZsVFBXc0FOaUpHdnV4c3o3ZTEvTGZFRmV3T0Vk?=
 =?utf-8?B?NXRyL0ZIY2NKUXRWOWE4bDZLaWhTUGRBaTJVQW0zTkNmRW5UdFd3U3VhOWpj?=
 =?utf-8?B?MTlxeHBsVmtaRVlFcWI2WEgwdEF5K1BJR2Z4YlVuaUhUc2d1RjQxSzArQWUy?=
 =?utf-8?B?WktkMXJ1Y09vYWZwQit1UkdROTNtZDluU1pxU09jR25HZFU4dmVwWU55NE4x?=
 =?utf-8?B?L2RLQVZLbnVrNjBwVmcxYzFld1dTVzNYMEdqNWFxcVdidzJoYXltYk9kYVhJ?=
 =?utf-8?B?eEk2dE5zcFQrUC9EWDRQZ0dMaFNGd1FkMEhaKy9TdytKamc2WjBVdk45MDZC?=
 =?utf-8?B?Qm91cTFBNWZtZEJRMXNFYXM2Rm1UbGlzS2NGNy9nb09jWGFtVllLSVZKZGZs?=
 =?utf-8?B?aTFnM2ZuTnczeW9la2Z3Y3NFYkwxT0EzNGlzejUzMzRCRVYycC80K0xsV0t5?=
 =?utf-8?B?UDBmcXBDb0krOG81ek15Y2VNT0wxMzFOaEU3Sjg0TnJBSFBCdlZleXpQcGd6?=
 =?utf-8?B?dUFjSE5nU0lGSGJNOU1UeVlwZ2xZSlcwRkRSaTRUNUZ4SmZQQnh4T3M2UXY0?=
 =?utf-8?B?ZTB5VldDRUVtNU5XbEdOL3UxQ2ZOMndsdFNQbVZYM1M3V3NLZ0dKZmR0dUh6?=
 =?utf-8?B?enA4Q0dSWHBnaFZJYUlOTGFXQTFzd1NkUlBzcy90aGpCZ1Q5dmkrUEpZdnp1?=
 =?utf-8?B?VVl3SFl3SGQ0akNtNXR2dzhVdGZWS09uRjZKeEVybDUvV1JFUTVrSDZ5a0Fq?=
 =?utf-8?B?bVhuSDZlNWp2TzlST1hkbURCWkZncDkzWS9WQnpzMjVjUjBNeWNHTk5kT25W?=
 =?utf-8?B?TVZUUEdZbHNpWDkyYmI5VlpwdEFnd0haVTVPMG1qdWFnVFJ0bng0TXl4WTgw?=
 =?utf-8?B?R3F1dXNlWGs3Ui9KRllWNm9ySFc1REdJSlRzM0V0M3VxN1kyOUFTdUxyRUMv?=
 =?utf-8?B?WktNY09kN0hZQytxVEtpcWFNZzBlcWoyL3Zzdkw0ODRTQllSM2lBOU1UVFQ3?=
 =?utf-8?B?R3JVVHdwMmFwNzhCZDBRYjVxN0lEOUh2MU1XZkJUQ3ZKTDVVTmo4NlBKQUtM?=
 =?utf-8?B?V2tnSVZwUEhSOG5EQlFoZmRtb2hhS0lZeHJKa0hMVktVQVRjMDMvUXZMbmNM?=
 =?utf-8?B?bXRWd0RaMHJBaXhvYW8yOHNCakZzS0VWdHdNWStmRXljWlhHbHh6OUk2dFhK?=
 =?utf-8?B?M2ExVHhXaldxeFBRZ04xblRDYnNjdFBxckcxNjV1cGN5MFFXR1NqMDVBMUs5?=
 =?utf-8?B?cUxIaWVtQnBzUk9DTEI3bDdoSkp4VjAxR01UbXA5a3FYRlJDaTBXZ2dha0ll?=
 =?utf-8?B?bHFrNFBaclpOazlmajZpZnU5RHRQTmYwdDBQbUVuVy9YUTZGZkR3MXgrdjBL?=
 =?utf-8?B?djdKZEpFYUk2eWVQRjlSVjBXeXFlMC9BR2xkSzA4NFZRbmttbXJOVlpqbGVR?=
 =?utf-8?B?LzJhOW5LdGJ6UHhZSFpNTU50TzIzNG8zUWc5UW1WWDhsYVVWN2todW44clFB?=
 =?utf-8?B?cGMzMFNUWjgrVXpjWjVaNUc3eGF6QUx2OGxxYWRzOUNqMU5wTWxnTzIrZDJM?=
 =?utf-8?B?SU1XTjVWdDlVSm9HREpIMDJvVU4vQ1VGTmhaUk5ObTZ5cElzSGo0cVhlaVJY?=
 =?utf-8?B?aFRGeEJ5VGZUQjAwM2NwN2wrZy9KRjZVNHhsUENhKzF4UVY5eitCY3cwZHgw?=
 =?utf-8?B?R1c0cFVBVFZDZXVoRHVzV1N4am9UcTh6Q2lMdGtOdjE2Q1crc1lhRVZRd3d3?=
 =?utf-8?B?ak9wR1JEYUJBMi9DbW1WSSsrbjFBMUtCOXJZZDg1NCtGbUt2SW9nL3hXV3Uv?=
 =?utf-8?B?RUd4NDloOUNnZnc5VkVVYVd2Q3Z1Nk54TEEyL09VRUNncEoraEF5bzZxYzZD?=
 =?utf-8?B?MEl2elpwZnNHUkUvZGZyMS9nY2RYSkRuQ21ycjlaMW51SGlVa2hjVmwwc2hO?=
 =?utf-8?B?c1dxZFJ5TDFtY3hmclFQUkQ3R0syUUU0TktlQU9Bb1hpUVZ0dEkrN0V3Y3RE?=
 =?utf-8?B?OXVaWERTN1FuVWZCODBCelBwVDVRYmhpUzdocng0K3FvRDRPNE14dllUQ01i?=
 =?utf-8?B?WGpPNzdYRDZkZEdSdkU1S2FYZGNuZkxTOVB4Ty84c1RoODJ0R1RzOUZYWU5Y?=
 =?utf-8?B?R0V5bWlTQkV3bHgzLzYyZEc0TTI2NVdmc1VveElTdFFtNTJQTmlha1ViMlJY?=
 =?utf-8?Q?m1OyJgCGXYJQLRDUYK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9af9e72-f1a4-497b-51eb-08df2d389ce0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 16:55:28.4710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rO7mrYxiTL7gkM/UPQshnw2NNNxjotfyBv/nagExJF+Auu7Yxk3klhrZUGD3iR/qfqZ2K2QqaGmNfMbkSunkbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6982

On 17/10/2026 3:54, Dimitri Daskalakis wrote:
> From: Dimitri Daskalakis <daskald@meta.com>
> 
> mlx5 couples HW-GRO with tcp-data-split. If a user sets rx-gro-hw on ->
> tcp-data-split on -> rx-gro-hw off, the driver will leave HW-GRO on.
> mlx5e_ethtool_set_tcp_data_split() calls netdev_update_features() when
> tcp-data-split goes from enabled to disabled in case HW-GRO needs to be
> released. mlx5e_fix_features() reads the new HDS config from
> dev->cfg_pending, so HW-GRO is released before all ring parameters are
> validated.
> 
> If the subsequent call to mlx5e_ethtool_set_ringparam() fails, the
> ethtool core discards the pending change and reports tcp-data-split
> enabled. The device is no longer splitting, and subsequent ring changes
> are blocked.
> 
> Move the call to netdev_update_features() after
> mlx5e_ethtool_set_ringparam() exits successfully.
> 
> The issue was discovered by manual code inspection during review of
> a change that stops mlx5 users from disabling tcp-data-split. It was
> reproduced on a ConnectX-7 with ethtool alone.
> 
> Steps to reproduce:
> ethtool -K eth0 rx-gro-hw on
> ethtool -G eth0 tcp-data-split on
> ethtool -K eth0 rx-gro-hw off # HW-GRO kept on for tcp-data-split
> 
> ethtool -G eth0 tcp-data-split off rx 1 # de-sync driver & kernel state
>  netlink error: mlx5_core: rx (1) < min (16)
>  netlink error: Invalid argument
> 
> ethtool -G eth0 rx 1024 # valid ring changes are now blocked
>  netlink error: mlx5_core: TCP-data-split is not supported when GRO HW is disabled
>  netlink error: Invalid argument
> 
> This is not a terminal state, users can recover by setting rx-gro-hw on.
> With the fix, the failing ringparam set leaves rx-gro-hw on and later
> ring changes succeed.
> 
> Fixes: 46bcce5dfd33 ("net/mlx5e: Support ethtool tcp-data-split settings")
> Reported-by: Björn Töpel <bjorn@kernel.org>
> Closes: https://lore.kernel.org/87se2grw3d.fsf@all.your.base.are.belong.to.us/
> Signed-off-by: Dimitri Daskalakis <daskald@meta.com>

Reviewed-by: Nimrod Oren <noren@nvidia.com>

