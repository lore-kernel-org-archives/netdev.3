Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012022.outbound.protection.outlook.com [40.93.195.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F963E49C3;
	Fri,  4 Sep 2026 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537695; cv=fail; b=WMkMGdKUV1cQeowDGOPivoGZkFvyVzOD95S1/kac+jZG4KIORibQ8TtysV/wrNTbAYLcOSnrj7LD2h2S6hwpprDHQMixZHny/VXfuGBueG+FJLn6l2AIsMnVN0scnL9uXZDTQNCNCOGnRC1uAWXkk1lqV9UiiqFmFdRmU6ONos4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537695; c=relaxed/simple;
	bh=YlMg8JdR8yc5W43UgpCSkci3tbOcs85zz/5FcLLxC2A=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NyYR4aq1j+VI4LajgzPss2eoMXZcMxmAsPq/QBKa6VxZGu9CbnTIW7DCneVsO64tsUP4IGnT5/E0ix0Wt5FJGUNe/Xuapg+TCmdagSBC8RVWpV9z14GDGjCEzXIpnN9aKHuUq8asEeCW3+Swu/9EDbD0hB/kAp+aAWcrLhtqJV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DbKgDUJb; arc=fail smtp.client-ip=40.93.195.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DbKgDUJb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlIKLgQZuawiBLxHd6oqQHHbwYsngru3eDZzVStYp56NqJBRFOltCZKf9dVkAbanV5AMS0y0E6ktvGr7/z5FGD35SRk7k1dJtAii+UTehCxy3g30/BixL38N4VyDPFfj7kjC7BM5AYCJisCQjtACkaFdszeTmCHynT2fUuJsdSFDXFOFAl2+MobJNlbnRaroXC9fEXkx6qF8DnwdQ2Z9hFmbfL+QYFzR7HvuIAF99wqVlQOnXaCqPUk+IXY39eBr12skaCYZwOXkVTBzfglTQVBIYHei3jR4b3iSCSHSJNPX5wwZzf/O9XocqCBvoKpedmxpa/s65b9/9B7wDqzV4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G88Pz0CDEVr+aJknGemmbb6N0mQtFDCW96SGMbPEGQc=;
 b=dEtRENPGBifE2M9xcP4tpuzMwCnN0p/UYcN80WhA9BLTkmPdWh5bMLrQl+yUR7FE/KCH31GGhyz7ZH2Rtq8o58+3LJgbuddDkVeL60ykbQsiw/5OPt01WAAeSmt0VgYUQjI+zpF/sf2dOfPrrAy28Vm/m+uxgq6jG0DAHsoGHcgIR/3kcXq+QBPt58pDpDAarhsbz813Pn30c2oqsO6hqdvveQXdKqlgEN1W1eyymgCQaRpNJ6RrXIsFTQ6m+x9rfb+qr/wyIdsamOM5QxgqszrNvD58ABIYv03kQw5c05BYRvRA1BvgQSjmZeGZ7obGBLacf6HhY5kq+mQRo3fuvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G88Pz0CDEVr+aJknGemmbb6N0mQtFDCW96SGMbPEGQc=;
 b=DbKgDUJb1WUIYakvhD06Gemr/91+UEfSjByWPiycezXbL5uw13b8nKIoVczV6dbQrzT83LVNtbyi0e8Ukkhln4hcxOTFP4fViG7rUmMbQrgCZOm5OQgLx3Weph8n5EzDoWfo+aWBe35TDDFiNtyhWa8TXj13cPbjhQuZJEM5HoJ3Lf5UYgAOPM0dqvUubiQjus4djfyD1kj/v4E3c4I99EVwLQFUJzsftbMR36WImlBlg+xwLw5GHYa0QxNTFxKqQ0JcrISDxK41H5IJW9r7H18xQxa+svdcjDGQVrEvHxCO+rbbRBhswbjxjovV48sWSUuOFvB4SySJdjXg/0nnDg==
Received: from SJ0PR03CA0292.namprd03.prod.outlook.com (2603:10b6:a03:39e::27)
 by DM4PR12MB7527.namprd12.prod.outlook.com (2603:10b6:8:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Fri, 4 Sep 2026
 16:01:10 +0000
Received: from SJ1PEPF000037A4.namprd04.prod.outlook.com
 (2603:10b6:a03:39e:cafe::4c) by SJ0PR03CA0292.outlook.office365.com
 (2603:10b6:a03:39e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 16:01:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000037A4.mail.protection.outlook.com (10.167.244.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 16:01:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 09:00:34 -0700
Received: from tuxedo (10.126.231.37) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 09:00:29 -0700
From: Petr Machata <petrm@nvidia.com>
To: Ruizhe Zhou <zhouruizhe@resnics.com>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 10/14] mlxsw: pci: Remove obsolete 32-bit DMA
 mask fallback
In-Reply-To: <20260903084339.870562-11-zhouruizhe@resnics.com> (Ruizhe Zhou's
	message of "Thu, 3 Sep 2026 16:43:35 +0800")
References: <20260903084339.870562-1-zhouruizhe@resnics.com>
	<20260903084339.870562-11-zhouruizhe@resnics.com>
User-Agent: mu4e 1.12.15; emacs 30.2
Date: Fri, 4 Sep 2026 18:00:24 +0200
Message-ID: <8733vpypk7.fsf@pmachata.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A4:EE_|DM4PR12MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 505779f3-0f7a-474d-dab4-08df0a9dbab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|11063799006|56012099006|10067099003|4143699003|6133799003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	zX0Slw1MyEsFoziKML9MN7WCYfQh1B/eqrFDJqnZ4wbF0WH+ra90ZJhqR8DLWGk4jvtYwci53rApqqWsMGS2JiaXnJEfixGkl55f++z+oEbQS9oxIG6uHzX27uA4IM3lfStq5/h7nd6dEdeeNO7oLAMSX685g6Dms0rmnNZrCuCPQBZxSVwa7A/JvZE3RMKMDUw18iG25oePhRTBscgAn21nlgHesgumhpte0zWN30DqGUJs/ORFCQ188T53OnXznu5tadSuk9SRjh/1KP6iq/ftto0HNpT9JE1HAB2i8DFs0wQ8fAnZULJELay8VAYBQgWfFg1aHdixg4Xypguog9HQIrpZxImxUCsOxHctGubGKRjUN7IjADysVTQHNiwL5iPAUQ5JlTBJ6JZrSvabkOfFauG8S1MCykcy2uGz0S0UU/4n0UaK9IOmuS4hq3A0ipnvLDeapTL0KmoeK0fW4pHsrT7JgPI3Ii1B4zHT9VrDoFMprcHZZluOhvsLjBN3k8753/A1TebZ1yjNCcHbn4zkrECXWM2aJZbO4IeQNZe/dwnu+ivTqgONBt6KRIf9e4tbsJYNvdIsmK2QjdJhyFMzOsuyWA2it9RulS1zMSNR9NY5UtJTcbWhOExI01dt3QqH5aNa83IL08RLeL5f494S+qmwqbbVoY0nKEpk5IEDkLpomkvLmD7HcTpiiA+MOyaHJ7ydJ2VqnPH9taErgA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(11063799006)(56012099006)(10067099003)(4143699003)(6133799003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0hGDeRLxLNoSNBSsmGnBdOjqiS2QQ66++NTbpIamUuBEsYYGBzNWrSA1aRJJNL1h7C+kqbQl6wKVatGK9/UsmYQSJ2K7gGnlzTi+shGJzf6JQ+wSL43hO9AGZs+ScM3MuT2AajqSp9iUjasepppNA4sZovdIjy/RQoTq/NYSV+q5EynKU5FH15ZGDQeptMcKhmnXLK3gkuSNppjwInGXa2psx0SXbN/z8hv0L3xp4bGZq7nkstNiD0R0YCQrW1Nc7Le4VR/0jL/LHHwnIezbC4syjAI6qjOHBOGBpu0oB79PT/9Q9K/eJj4vhN65e//PSCU7aQe/V6CfYpDd1DVQBAIu/6nPcuNnZ++OF546PRKKrPVu+IydfTYlBKPWCepxRMax/aVZrfg04u55BBd3U/zTGR+sL+WgOupQoBQSv2n0XIuBSOHTlTxJyU+mVDE4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 16:01:06.7308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 505779f3-0f7a-474d-dab4-08df0a9dbab7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7527

Ruizhe Zhou <zhouruizhe@resnics.com> writes:

> The DMA API guarantees support for masks of 32 bits or wider and
> explicitly identifies retrying a 32-bit mask after a 64-bit request as
> incorrect:
> https://docs.kernel.org/core-api/dma-api-howto.html#dma-addressing-capabilities
>
> Remove the obsolete fallback while retaining the error check so that a
> genuine DMA setup failure is still reported and aborts initialization.
> Update the error message to identify the combined streaming and coherent
> DMA mask operation.
>
> Signed-off-by: Ruizhe Zhou <zhouruizhe@resnics.com>

Doco: "dma_set_mask_and_coherent() never return fail when DMA_BIT_MASK(64)."

Checking code, the only way that I see that dma_set_mask_and_coherent()
returns error is if dma_supported() returns 0. This could happen if:

- use_dma_iommu() fails, but that doesn't consider mask, so retrying
  with 32 doesn't help.

- if ops->dma_supported fails. But I checked several architectures where
  mlxsw could even theoretically be relevant, and it's basically always
  some mask > X type of expression, so retrying with a smaller mask does
  not help.

- The fallback of dma_direct_supported() is like that as well.

So yeah. I think this is correct.

Reviewed-by: Petr Machata <petrm@nvidia.com>

> ---
>  drivers/net/ethernet/mellanox/mlxsw/pci.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
> index bfe3268dfdc1..dceb69945d26 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
> @@ -2429,11 +2429,8 @@ static int mlxsw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>  	if (err) {
> -		err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
> -		if (err) {
> -			dev_err(&pdev->dev, "dma_set_mask failed\n");
> -			goto err_pci_set_dma_mask;
> -		}
> +		dev_err(&pdev->dev, "dma_set_mask_and_coherent failed\n");
> +		goto err_pci_set_dma_mask;
>  	}
>  
>  	if (pci_resource_len(pdev, 0) < MLXSW_PCI_BAR0_SIZE) {
