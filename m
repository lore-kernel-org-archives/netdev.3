Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793113510;
	b=rWkNfZtRZj4NueguHJGPWY4j15oC0vhRZd9T9W6R7sM/UnqU3sgDSpU4iV4ziMMOgQRU
	 PjXXazteuj9C8VAX1KlWn+ghefP6EeG3W73VGojCDqqCxvfX1WiADdmH+TZn5QzOfjuKN
	 RA1oD4InCGhlOjRJJLDvu8QzqsN3t5DgW71VBgS/KsyVy0xAYWD5LoU40rimnbAIxxdzW
	 4u9AtNmwzvWoCfNYJBnaz61HaLlDKzFaKEEdAFXzgH+m3h0OQkIQ8jrBRQYgc3ryEnI5t
	 akOju2hFJQiNsJNTZ5HkC0k8cBXzMyV0kj03ARnbrokUFuFjjq0PMnpNQTTLYgukcpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113510;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=EFUBP9r0uhJUC2NosuOfxHervV9PZkCLshZWrOKwAKc=;
	b=Abj8bLMK3MAs41lF4tKfxJLkHv1evcrLhQGUVgh/qdleXHU/+q+u3xA2DsbY6xb+JZ/C
	 SiGH+c8fVx6lLLWm02PR6NxuhPCZCyB6kZOYFyZtoGFULRwh+TBqV/9Lbfu2uD+XIVqIx
	 sKo5cdYtQndsYaEVG6qlgWm6n38LikV7Bm3thhSFkP/hZIZL+1o/eI/qXHJFAYFyHf/5f
	 aCT+qLrubmNQZrZlTexVnzpBRWS9lkVHj2Bo+ptmKlwv2FGbA/3YTiFddyYpJs2HWkwln
	 8cgGv/xQdF9yEuQ/AA2kSZrtYkeZSvZuniehwSgQmYS5k+n8/TyVH59lXip66TZQ6jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QhA6qn3+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.29
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64762606A33B;
	Tue, 27 Oct 2026 15:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64762606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QhA6qn3+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqS6m6nJJD7mEDM3o5+NrmKbrPrPfGiE4ZpN8XTipIygzLDbqbPvzQFHe69kMkxEPaokg8uc3CrP44wwzJ4LFaPgz+W7wnCuf4oTwRxgxdTSZh6jUz/grjWbzaVI+k7WC5KTXWH0n4SzE5camDoFqWtzQuGXlRstkQST85sQpR9I+gZRiUWseqWX28rch4EVNkegFoE0bSXahDHu/w6vrMSUN5ZHZrjc2LTv1W6w24PcOTq0tIqKxnA/cshFGOfxGGH+0zT4A4QyYY07rxgvijIMReW4fcxGMe3s07qO3RBXuZdxvA5gDP2gYpc2DJro9FBykPCEs2nPs/0nN3kuNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFUBP9r0uhJUC2NosuOfxHervV9PZkCLshZWrOKwAKc=;
 b=urhniBjyWFo40uXYvm/3rv5IPXanMd83sS8iKHQtljOO30nlGUALPWRFLw6A2xdrsrGK3UA2AkYQ/80LAjwWSmkSJwJ3JF9pm49zXT3Q5rLNjdrNa09np5QvBDygRKcRS1rqeQNBwfObTpZ7PP0Qr9GNnV2wp2hb2XfA+xy9z98tEuuWxSImMpODAUfjUv24RHW4/glxXrnHhn6f9pPkaWOV5Vk3aixrfUcUqR1O9RTXYyAc22A5oVcScUJLRfVvJ+ekHjBX5rq+aJ3fwm20Y3NOBCI2rCR+6h+7eXsOxwpxrvW95YVJ0RVCkFASaOfZcNLW8p4NvVMD0DvPkqsZ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=microchip.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFUBP9r0uhJUC2NosuOfxHervV9PZkCLshZWrOKwAKc=;
 b=QhA6qn3+flj/hEeQjWEhQVl4e6cJ9v/e5Of56y61bFi8XzcmXrORZuiZEzkdFJG0IwPIvme0XsyOPYJkRcLwvX80bZIJ5D4Gc463BhBy4dBBq5Fz/m2D4BbObEcdM2XD/MpkqHXI6vbV+S7i8MrUHLNB42nB4bYAb0j05QKQ/x33CmqI72JKtsJf4rSEsk9sW5bnBYzwXkEHTGwPZ0ijNpm7E6Z9wM1NaM9Ur2+uCEx3m4gDqbegKf1BRIM1zquI8feDqz/lg9ulgYWNs3TFyMzu5p+IBqvdttRKRzj7h8zd0k4SC67se+AgxQ7V5eCETM3Rsv8LrCP/VU5lDth3kQ==
Received: from BN0PR04CA0018.namprd04.prod.outlook.com (2603:10b6:408:ee::23)
 by CH8PR12MB9839.namprd12.prod.outlook.com (2603:10b6:610:274::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 15:03:02 +0000
Received: from BN7PEPF000000A2.namprd04.prod.outlook.com
 (2603:10b6:408:ee:cafe::ad) by BN0PR04CA0018.outlook.office365.com
 (2603:10b6:408:ee::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 15:03:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN7PEPF000000A2.mail.protection.outlook.com (10.167.248.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 15:03:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 27 Oct
 2026 08:02:27 -0700
Received: from vdi.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 27 Oct
 2026 08:02:24 -0700
From: Chris Babroski <cbabroski@nvidia.com>
To: <woojung.huh@microchip.com>
CC: <Bryan.Whitehead@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<cbabroski@nvidia.com>, <davem@davemloft.net>, <davthompson@nvidia.com>,
	<edumazet@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux@armlinux.org.uk>, <maxime.chevallier@bootlin.com>, <nb@tipi-net.de>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>
Subject: RE: [PATCH net-next v1 1/5] net: lan743x: reset DMA channels that fail to stop
Date: Tue, 27 Oct 2026 11:02:14 -0400
Message-ID: <20261027150214.565776-1-cbabroski@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <BN7PR11MB283662722179019676EFA167E7642@BN7PR11MB2836.namprd11.prod.outlook.com>
References: <BN7PR11MB283662722179019676EFA167E7642@BN7PR11MB2836.namprd11.prod.outlook.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A2:EE_|CH8PR12MB9839:EE_
X-MS-Office365-Filtering-Correlation-Id: fb85af38-4231-4bd4-750f-08df343b65c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|23010399003|82310400026|261026140227099003|11063799006|56012099006|261009223027099003|261021135927099003|261022075727099003|10067099003|261022105027099003|22082099003|18002099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	53EuBdx2lFnp1omW+au5F7YDytVkaRbxyw7iRqsBaamvnMklcnfqHdUby6qx5rll2jtZg+pg5dDc2Fb3+zzVfuG8qNWKFiiTnXO6mMTPWfrwu0KVDqcrU/iCjX4aALHg0qvVpcY6mMBZtqJQDlhPKm5Z12FsjdMJ774PfIO9xUYfsrmNzplD3y5Zxje0Nd/4ARwrdT2t1qBk6TrDfqe0JD3XsUdCCgz2Mw4BiaQLfXb5ufCEYhBuenak007np/BM21IqpfKeQrDJ17KSvhgxvLgBzSVNiwTRPCJFJE1gaQCy7A7/thjKhUeHuPoPNKYUNAn7Ee6wSI4C+pUxbql4V3RwCsjFvZxVDnM3fVia+d1+5Tuq3Ni8nXbQGISp3g5xvKiIaWdh3ERc5rBTHgBxrNn7Sa7Qzftwc9+CT1ZAU2Nv06+MmhVbDfl5Q3qi99/EXyH0JHn++dD5Zx6b+RYOTRH8bH9LCxB8amfEyVNhnRQkdAJG20/9Yo/3OpFnPpOdQeGxVtvsFgxcJyaRWi5NGS6m+EOGAaVo3mRz9bsO6NCplPCn7Kk5fQFaUZ+hwSL0NJH6S7qvp7oFgPcKMYM2lrqSUOWCCUy6762nBVo7Ijee/fNYQ+Z8Rx0yNA0foCE9seSEk+b6gj4iQ8Moa6FNnUI6Rd4Y65vyOPmzwAosprM4jcSHC7BftW77lGE0ySanMHjwc2sxPkWCsOskIHj2FA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(23010399003)(82310400026)(261026140227099003)(11063799006)(56012099006)(261009223027099003)(261021135927099003)(261022075727099003)(10067099003)(261022105027099003)(22082099003)(18002099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	642WUIpMtXuMKFI6cGIeTRj0n5I5IUc9gsztNqMawvWvHvSJLlI0zks8HvJ8YtFEJH7fWWh/w6Rfz3cUY4rf6InNeXvLtEjq6XCCoj3O/6Ut2taZPJIdLHN8FFJX20YWckCUnag4rNj1cYekg+ot9m7hiilDCDri43XVG6LyKFXxzAkDjtiMfy/QnyXLvNwejlXfEwchUnXpQkICXBLM3eUVAjzTvdSPEsb5NB5lryWEqUlpDygoFQtYy7T9EE3uQz/q0dcSsExyJVipc6/7kSci2Yla2W7SCaW/6QOELGHLAEJHlmibJfObaL93AlchOyfWg24NcrMzxPz7Wy7gm1vETION3He4N/ZWt9C5XgcvfbEKkgsDyo896WxdxizD84IGlkPJs7TK7yMJBJOGGlmqimN+9feRVdVDuN6aRuDIpffVI76T0F4IIkFi0B3O
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 15:03:02.3315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb85af38-4231-4bd4-750f-08df343b65c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9839

Hi Woojung and Nicolai,

> Recommended way of setting TX_SWR_x is after stopping and flushing FCT
> to avoid in-flight frames during TX DMA reset.
> 
> lan743x_dmac_tx_reset() is already called lan743x_tx_open() with
> proper sequence of initializing FCT at lan743x_netdev_open().
> 
> lan743x_reset_work() in the patch 4/5 is doing lan743x_netdev_close(),
> ... and lan743x_netdev_open(), I think no additional
> lan743x_dmac_tx_reset() may be needed at failure of
> lan743x_dmac_tx_wait_till_stopped() in lan743x_tx_close().
> 
> Hi Chris,
> Did you see calling lan743x_dmac_tx_reset() at lan743x_tx_close() is a
> necessary step in addition to lan743x_dmac_tx_reset() at
> lan743x_tx_open() when lockup happened?

Thanks for clarifying the reset flow. I did not see that it is
unnecessary, but is it an issue to leave the DMAC in a started state on
close if the descriptor ring was freed even though the FIFO is disabled
after?

I can remove the call to lan743x_dmac_tx_reset() in lan743x_tx_close().
It sounds like changing the order of lan743x_tx_close() to disable FIFO
beforehand could also work, but that feels out of scope for this patch
series.

I also noticed in lan743x_rx_close() the FIFO is already disabled before
checking DMAC channel state. This means we can leave the call to
lan743x_dmac_rx_reset() inside lan743x_rx_close() or I can remove it as
well if you prefer.

Thanks,
Chris
