Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011047.outbound.protection.outlook.com [40.93.194.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E8A3C09E5;
	Wed, 22 Jul 2026 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784713058; cv=fail; b=jW0JkpMalFr4JW/Tenypp2q23K7/B9pag27oTcUR5CLi4AEOfon60AZ+5TdUyeifmFbr3Bf9WbH9O+R2sypySpZAQuezeJJViI296ZrYmoOqSBEDD00gbOGb7tMcc/62B/03fjMcomPuwHeBeSn/SH6qpJAL1X6Y8haRv/iadcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784713058; c=relaxed/simple;
	bh=YdoXYoOKWsd2XzZX1qZvtQICuYdLveIPJQxxR1adxmQ=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=LWAGBc/23kjJuzbr9VvZB215SugJBcDWKewoHZwZfGGh04xR9Nu8sv5/ObO63Uer/m5HoWkwgsEr9PGPhDw7ZUv520w7EdqNeeuEtCJa3uOfkQnQdGpoA2g6r/HP4YzJrSDkNlHTTN+fREn4Zozi8+rV3MjkK+fFQbSHJE1l68Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GWzH+n6V; arc=fail smtp.client-ip=40.93.194.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GWzH+n6V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZ5ce+DRvE/fVyqtuAegApnPKh9PIJiqwmmhBmdcpZCxnYzQadnA/qA/stvwh4r4tI29FDq9yI3ewZUhd5eOIDzsrk0RgtcKkozJsL3IT7MvBP3afdOIA1gWQjddGuY4TwlEvjwF7qnMKDE5noWHKKOcD8uPuLH0MhxPhhAGAkSBllMX0bLzadv19CjpZauNVndav5JgRKfjxDgfvGc4u/PMIi8QsVd8zv5cAn0icrw0MRf1rV0olaKcv3pn2sKWCBm7RlwiRWf3i/rdk2O2p4Hu0HVBydcMoF7oqFRbl0Fv+hT5SJmIXzT1PfzGLhmSiexx4SEpjfVyTLoMl5wQ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdoXYoOKWsd2XzZX1qZvtQICuYdLveIPJQxxR1adxmQ=;
 b=Qf6kUDlk7Q9XQAXkIEosmV5G5awC/q2IEAfX604jASu5fqEmzdZLXw6/TZggubuxmgjbEJwd5mlojVlW4zNrtPJ/+uSTCuUsDFxL0tvpLCiwL3399xxvi2Ca+m31vEHhlO348Cs0PsfjmBZE2ENZoLZBtC/jg4/fW6gCxgsKxEdGdBvBuLHB/9Ow2fDWiQyKDbkpG8G3WoB1U8DSJr8a8Myrzhu/Y2uwhmSfL846Wj38bbYm853FINA4UOx4KnknQZck9Zz1iBdbzpImF3jcN135c6+TDpT7p7iq66pG8vltpqTfarEZvMbdvQxveuAW6bIrju1PqA6k8NusNOMwpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdoXYoOKWsd2XzZX1qZvtQICuYdLveIPJQxxR1adxmQ=;
 b=GWzH+n6VKqXzjSfXRiRzu4i/7IrZ7UR/ujshwmBKUBZh6+u7unVE6ULX1vCdKV9VlIlJ20/YuI3FXMsXuGPxz8mXwbOOJOTGjtmGZ6cH59D/xVfzPTv1WpoBRvvZlqJ0PDz/ZVBTR1qEPZj7GdULU5YQWgF62NAx9uOIgwsz0TPMPu8waTKV1eJV9RcFv9UqljGXLrgqz/y82FM1I5T/yhnTZccGGX3FEyF4YypiY2OWuQP7ov4/5n07EsMbMgcqf7VJDw0NByJOCYknMrP0TjKs+bzBrbiaGaJoX2sShR5piI/qxI+h7nQi+tZGj+T3pN9ONJSR5Yly7lvIRePvqQ==
Received: from BL1PR13CA0323.namprd13.prod.outlook.com (2603:10b6:208:2c1::28)
 by CY5PR12MB9055.namprd12.prod.outlook.com (2603:10b6:930:35::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 09:37:31 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:208:2c1:cafe::3c) by BL1PR13CA0323.outlook.office365.com
 (2603:10b6:208:2c1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 09:37:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.0 via Frontend Transport; Wed, 22 Jul 2026 09:37:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 22 Jul
 2026 02:37:08 -0700
Received: from fedora (10.126.230.37) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Jul
 2026 02:37:03 -0700
References: <20260721125753.35944-1-mhun512@gmail.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Myeonghun Pak <mhun512@gmail.com>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, kernel test robot <lkp@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ijae Kim
	<ae878000@gmail.com>
Subject: Re: [PATCH net v2] mlxsw: pci: Quiesce EQ tasklet and CQ NAPI
 before teardown
Date: Wed, 22 Jul 2026 11:20:31 +0200
In-Reply-To: <20260721125753.35944-1-mhun512@gmail.com>
Message-ID: <87cxwf8iwz.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|CY5PR12MB9055:EE_
X-MS-Office365-Filtering-Correlation-Id: 34615bec-9eee-4e21-ec54-08dee7d4d9cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|23010399003|82310400026|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EyC6SQ+iP0BfxWHdGscMf4o/H4EAQKS5qeg2fviCoxpiTiEurR3UoC5FhZM0Q9RSD1QYPBI6Oz9rW4FkRpF89cpkmMY/5dziRT4i7EZcPL1kVyuND3CJv6rde1wr5WdfyTStLD5NCaHc12xZcoIt0eivJhOnnkkj1BKTlcYv++cPc6QzxfVKFbvlM/DplY9efv/L5tfrB3JEqasXW+elajYarvAN+QRwTLBa19oEVwuLzOI9M9xPt4Y4lbsgh5jBb9I64SIiNQi99Exb2/rUXtN1sHLKnxvYblc2O2O5DGQjSsdS5s+iQCX26KV2WiyNeryT89R+Eqw+7yVNLski/ji1yTVjWglbjjLNl9xpLNRJfXawg3TpO4kt+JSl6rNN4Zhfo0vo5AE3GmodewU/bQHSRENObSTStDXgCGit/iPLilNWY7DGWfes27j+oNCa5hySQveHFXl8uCtVe93hmk7SHtRChI/pruz2OD4VKca694UKRSJHOW0IaffGI+937U6usZyRKHx12yLtRuODzXn2oWk37cktByBhSs10qpQk/l5X6sXz2xmq8foGeLTbvK2VtoHg3RtiKl6xJGvKbHdCQ7vYk7BOnxaDKCUeenkweWseqDsdiZqXA1otGdxQEyQ7e1ER7HIGycHvVkpScsN66qYcjCSa42MU973wfgp1fsNKBMhpYrlr4+T9PPVpz0TEepcTMBzn0pPM1blB6A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(23010399003)(82310400026)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3VIdHXEZJQ2sv8/IeFy78Vy7+VxlJGRadKSdWDnKHn1Wjxhy5mzouyS5qb3Y54shHAY+PTJqq78NLIKnyJf/umgJOWbrUKJExVH7eOL0XVBa6h1SF+BikatywtVp+fTMNrMcTnMhttHG0Z1gLprWyHyp7NvghHDepQG8YLDC81ICxBrtPwO0TSckFVYv1jc1+htEs/mol++IJboAjd1THOCm676Fs6nDTbtL+gACHha/yL5xr56JCQ60o8LlErAytccOBoiRAG6Yy1Pr/Z/upjR+MIgMIfdYKy8Hj1Hiq0NQTItA3ExjecdO6K15/g9JBqUEPLKgOwrEXuAbOBoIQh7wGnWZU/GFl44/6OmlcZs/zZIStK5ci2ZFvyk+rtCkkdSBy15mjsgNf9xM4/4xRoEIOdckvBidCbRVchFYObPmJosfTQa+0DErbsPmpgUE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 09:37:30.4384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34615bec-9eee-4e21-ec54-08dee7d4d9cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9055


Myeonghun Pak <mhun512@gmail.com> writes:

> mlxsw_pci_eq_irq_handler() schedules the EQ tasklet. The tasklet reads
> the EQ ring and schedules CQ NAPI instances. The CQ poll callbacks, in
> turn, dereference the RDQ or SDQ associated with the CQ.
>
> mlxsw_pci_fini() unregisters the IRQ and immediately tears down the
> asynchronous queues in RDQ, SDQ, CQ, EQ order. free_irq() waits for IRQ
> handlers, but not for a tasklet already scheduled by one. In addition,
> mlxsw_pci_cq_fini() disables each CQ NAPI only after all RDQs and SDQs
> have been freed. A pending tasklet or NAPI poll can therefore access
> freed queue storage.
>
> Kill the EQ tasklet after free_irq() so it cannot schedule any more CQ
> NAPI instances. Disable all CQ NAPI instances before freeing the first
> descriptor queue, ensuring their poll callbacks have completed. Track
> the enabled state per CQ to avoid disabling a NAPI instance twice when
> the CQ is later destroyed, while preserving the partial initialization
> unwind.
>
> Fixes: eda6500a987a ("mlxsw: Add PCI bus implementation")

Please leave at least 24 hours between submissions. I'll look at the
patch in more detail, but wanted to get this out before you send a v3.

Seeing you cite the commit that actually added this code, this never
worked, is therefore no regression, and should be aimed at next instead
of net / stable.

> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
> v2:
> - Fix typo in napi_enabled assignment reported by kernel test robot.
>
> v1: https://lore.kernel.org/r/20260721062105.55014-1-mhun512@gmail.com/
>
> Found by static analysis on v7.2-rc2; not tested on hardware.

I understand you don't have Spectrum switches lying around to actually
test this out, but seeing the 'truea' typo... this _was_ at the very
least build-tested, right?
