Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010041.outbound.protection.outlook.com [52.101.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B14F3F0A85
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427861; cv=fail; b=s0kwXqidHKEUx42quigtca/Xrw/cINiLVKnqr/EBicuF8r9A4E7KZGXn5GfK6pjPyhECvK9YBHxveco9sOZ6JHhB/5Z5LH55v+EPj9E9AhKuBVr+g/JCKQYgm+ghXVteULV9bPksTnzl49qroXx2Q9s9VNjn2ob17g+u7mqAUJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427861; c=relaxed/simple;
	bh=7+DM+ytWgucKs+UhRAb4RobK18iORUZySWCMY9O/qWY=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kL/4SBW5XkHNeTo/scjzK8SreoLQc6KtgRzZCqdF5EtOD9k9t6eb3OJvN3NDM2x5/mktnuGHMmuljzpP0AReKMS+OaGwifNWKPQ/UznN8CaVE3rwiWkUD28gbZPbcldfjOsiOv5IRMnMetG/lJkIeyrcXr0nSfwGdG53cOM05uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IF/679yZ; arc=fail smtp.client-ip=52.101.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IF/679yZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yN9nujH/zREzkwTwHKbRc4ik3NxGXZPtyR43LQMLp7o3zEwIfTYjHSd/HELA9mwmzCwBZyflug2WLSkwVR1knJUldbVbTRbbf5YqZSCv7M0XOafVlimy3wtcFYIrMu6bdlgNjmHOrDDMDXzVUmjtQTOJ/sAjEYjhNFSJRMIyyI9KGcnr0MYy0CKLcIPHeXdaeLoAXlbWarW9mHKUj3l6dQJbq+OuLPMWXgRguJBVmIRPz75QF90K6/TPVLS2xQFJUjGs+JLcs6/USU3FWR226uTHQUtnjCWrzijIhtBeToPAzuJIIQO524tMz+z930NyeQGiP9DPFBjpcogQlfQPOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0v8rY+DY//STuP63/v6ICz4IgZ+AF//yp7qJoj+tVgw=;
 b=ZcvVrcdCflQy0oVAlR6TPvclTEEIGSxdD3PH+xxPfemYGB7y+YDOk+k/SbiHvTQm256AOVYtLF5kKjXZrxSm9u7wxlJx+wv3bYfmrc3DxGhrgslWu+Y9YNmE3pOv83NJ6kYr40i43Up8MZ19pLfw2K6/5RA7p6KTh4h9fXwW8grPUToTuLuUMStgXjR1ROz9eG8C2Tr17dxckkQc/opEKR1w/M1CnVW9qje3Ku6P/OBoZdc5HG8f86LENglkoypHXS4SRyVSYVjzsxOENovl63hhSHnGszC0AXwJ7V0HnhfhR/B3YOiSkR2odiKKAZCO8sOgiaMb2cvUJxrkbi+q1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0v8rY+DY//STuP63/v6ICz4IgZ+AF//yp7qJoj+tVgw=;
 b=IF/679yZmkRtjFUvzvOYxsb8NwHZOCqqzc2jQv+6WACsTLA8CO/Wq7XGrlooIZHi474UrFp6Eij9StwXW1qTIiidVN2+J6/Kd+SAKcnLnBXkE7k1jMI30snhPPOiFPQWDoLEWKzbLsVjmfxtbh+PVJYt1fFq1oBcZ7qK8UXKALNMjZFIQzjP/Yw+1MJkBspbU0E6ZBy/Wxn1bQ/mch+AC4N6gp8ktpJdRrlAQ91J/8pem4CkM3inX7ydM3Amsyt1JjLUWltDtxNlsS2WWacLmwVqvx2aRrSYY/yPrKPKfg8ODN6vngUFe7iNzNtUu1xo5zr893stafBNc+Qy4wtH5Q==
Received: from BN0PR04CA0171.namprd04.prod.outlook.com (2603:10b6:408:eb::26)
 by LV9PR12MB9805.namprd12.prod.outlook.com (2603:10b6:408:2ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 09:30:56 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:eb:cafe::af) by BN0PR04CA0171.outlook.office365.com
 (2603:10b6:408:eb::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 09:30:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 09:30:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 02:30:34 -0700
Received: from tuxedo (10.126.230.37) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 02:30:29 -0700
From: Petr Machata <petrm@nvidia.com>
To: Taylor Bates <tmbates12@gmail.com>
CC: <idosch@nvidia.com>, <petrm@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <amcohen@nvidia.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net] mlxsw: spectrum_ptp: Fix napi_gro_receive() call
 from GC workqueue context
In-Reply-To: <20260902024949.2273997-1-tmbates12@gmail.com> (Taylor Bates's
	message of "Tue, 1 Sep 2026 22:49:46 -0400")
References: <20260902024949.2273997-1-tmbates12@gmail.com>
User-Agent: mu4e 1.12.15; emacs 30.2
Date: Thu, 3 Sep 2026 11:30:24 +0200
Message-ID: <87mrtyznpr.fsf@pmachata.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|LV9PR12MB9805:EE_
X-MS-Office365-Filtering-Correlation-Id: 140338c7-f492-4a50-adb9-08df099e0e98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|56012099006|11063799006|3023799007|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jbxdZdZtLCLLHF0IVuF3jZCQdrfd2OV/t2Ka5Nu7iCOGmguUhShizj7LZTi7e7Qhf2UGsLWktVXvYAgkDt7Fe/TFHvB5oc6V+CNEvSSqsho7NFTSG1u6qRZAFU4M9c4MfCukyYBvGtvG5aNOiBrae7oMnAYnSW4UwXYTSal4fDL9U8jvc5zmO763Y2geAMzFGEAcSfgH8+yzpVB7M8KDO9Z6ZEwl5SJji5O+Js6HlyVxuZEjDXhW49BITazKyN8Y9dKsVa1QQ5IOUNuuV041PaeL3NAtrLLaaZ7iXYXOkNrxAjZ+sbDF74TcahvoekF/exJJ/F4HpSZckj3UeMAYyk5oq/f/7QdXLxXkRBZo4cYzGpRiskT7S7F5TBT8vjkGtzI2A/IZXngYQXdW3oDg+lxaZH4RPHvK4h5B82wqABbRETLp6vHAIPhHS4yMOzFVuB3qWDi4PBCGGv8y0hyyvlgpDIiDuwCqiWAJhAPH/Edxl7RquQgM2H79L97NTAWoDNiilp9y6hPIgWATPTx7RFz3LdOu611spkZqsHc5S64eACiTft9dUYBbUS6UWLbnc1uweQOdIwwFnj/xumBvod3kqEieDOEgrawLKeDv7g+t1YQ4RAVTYOb2NE1+8cUV3WWYsBdL+3CagGkf9XeCB0owunbYjDg1gy8IEKRXbU6nUD370XAyW5EiU+LOJldh1Ld4BjgxDGcEkl7nOjVdEg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(3023799007)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zaZ0N1W+kEKxRqba4i7AY6KNzbHNUHaPSrU7Lovqz8FavII1ugZ0mexLTzuoTdoCTJv00PzoXnNm9tGsFn5dqz07RBM+yurrI6yDRc/00dlgJ0wrDFyevEgMaLCvmt7cID4/xp7zjdWcKjjlv0dlmzBmkiEu1PegsCXDdVKoXWBcMtDofPRbGl6NIFs03IpLOWXrX6F818440weSz2EpI/uiITYyVD3f7fRqQ6MVxgl6k6aS8WLWEk+bWjZas9Hcvwm7I3Lsws5ITm7V3QDZ1bkwV5IKfwK7qNikpctKhqhCWt5hySiUlJ4jc2IaP8Tm/fv/43FtmoPrHWJ6DzHdXXrI2DvZoN1p3OJjHkLUb8V5aht05Afw8lQu8ckTOb2eyTeUoJMTNU9qNbcA0q2xqUY9/scQHx/iUUq+Zm4aCWaN5wYDqOMaYTRWpWPy/6O/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 09:30:56.2487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 140338c7-f492-4a50-adb9-08df099e0e98
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9805

Taylor Bates <tmbates12@gmail.com> writes:

> This patch adds an ingress-delivery helper for the PTP packet_finish()
> path that calls netif_receive_skb() instead of napi_gro_receive().
> netif_receive_skb(), unlike napi_gro_receive(), can be called from outside
> of the NAPI instance's poll context, which can occur at the call site for
> this path. RX stats accounting and the skb->dev assignment are still
> preserved; the only change is the delivery call itself.
>
> This removes GRO batching for any PTP event traffic received by the mlxsw
> trap, but given the relatively low volume of traffic characteristic of the
> protocol, and impact limited to only Spectrum-1 ASICs, this is an
> acceptable solution.
>
> Fixes: 1ba06ca96ca2 ("mlxsw: Switch to napi_gro_receive()")
> Signed-off-by: Taylor Bates <tmbates12@gmail.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

> ---
>  .../ethernet/mellanox/mlxsw/spectrum_ptp.c    | 34 ++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
> index 9939749c47bc..9c5862f4e16a 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
> @@ -572,6 +572,38 @@ mlxsw_sp1_ptp_unmatched_remove(struct mlxsw_sp *mlxsw_sp,

> +static void mlxsw_sp1_ptp_rx_finish(struct mlxsw_sp_port *mlxsw_sp_port,
> +				    struct sk_buff *skb)
> +{
> +	struct mlxsw_sp_port_pcpu_stats *pcpu_stats;
> +
> +	skb->dev = mlxsw_sp_port->dev;
> +
> +	pcpu_stats = this_cpu_ptr(mlxsw_sp_port->pcpu_stats);
> +	u64_stats_update_begin(&pcpu_stats->syncp);
> +	pcpu_stats->rx_packets++;
> +	pcpu_stats->rx_bytes += skb->len;
> +	u64_stats_update_end(&pcpu_stats->syncp);
> +
> +	skb->protocol = eth_type_trans(skb, skb->dev);
> +	netif_receive_skb(skb);
> +}

Not entirely happy with inlining like this, but there are at least two
copies of this block already. We could factor out the commonality at
some point, but the code is mechanical and I think it's OK.

> +
>  /* This function is called in the following scenarios:
>   *
>   * 1) When a packet is matched with its timestamp.
