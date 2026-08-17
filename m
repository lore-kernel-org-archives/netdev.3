Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276032EEE99;
	Mon, 17 Aug 2026 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952548; cv=fail; b=mvBuFRflsArJb8U+P7EmW4lD3dew+/tTEno8qUIumDK/rhOSTCYx+JiBvyafZr81bdHm+oYJOHqPgpArY7IgJMCN3oPE+ZK0x6WJ4rWMRVc2w6D6BLJeUQF4lHl33MSsjimqrkZ0BFTaA0vGWJUidkLr34eWUb5eYRULCTSdHEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952548; c=relaxed/simple;
	bh=m3A+PRw5kl1OHMpa1tlqQ6Ia46aLYD8QtmkYGzjbLZI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=erMAjqbi0jku8keCFzUYufa2pgLQM1ZRP7XeWJ2AimiwoP3pUhcbzHNMWL1OKIYcBnuGKgkJoviekntUIAEFG7yXU6BHr50bTmuroQGXdR7JK0y/Ik4NQyQYM2IY9OGr90+zkmZJuSLUmAddkWUJ5qMtCoWs7GZBELQX4TQkwIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=H2bkWGuk; arc=fail smtp.client-ip=52.101.48.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="H2bkWGuk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ESuodwBltrE5FLFtUV3YNXb5YjdOGRg3R15egPaWQQifvfZjzNtlrbDYdUTZHiVsEwZ6ahsepyaRxtmnxUvjPR5RAnEqeJ0MDLLlEbV420sShTWiB82Bro02iDat1BBOwcVG8bfSZb6rVxYjjhkl7Gjz7bsMPKFpPQqhvTkrkjEmUghiACkUtn8Xqpg71C/R2vo6UbnaipM9/hGKcYGanNWSPz0io+60iiFDg/eKZO1I6Q69MWbDsmgB12d+TLhaiISZk2WR7qngeV/9whxRHKrHzNur4+HdP9eSXX3c9Zyqvgfs2fc0a344S1xXDIZ3bdRG90tnwjCf7pKyczZgyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkJGmn3GjTG+TKVsaCZSMO4CX8kJnJ5rRdvMBX2DnqI=;
 b=Y+F2iYYM6iyHUQe8NrMP8Kg+KXKwKma7YYKoELLj0BSzJi+uLrO2q1kO6Hyuwev5D4yGOC/FYqD2pstGFQexP87NkX+dga/SVSTrq9aKCkfONhLZoOWcruqLTeyRciq3eOwDbUQtHvyxzDDzJR4Amplfieg/SKesRn92xN29GWU8Dss2l7PxUpIiGSB0Eicg8NHYU0mtKRXsUuQnVnW3JnFJJiCgAFemITZ1JB2cU7gUh35fk10urP947nQufF52Z9RKfOvDNIjlO6EYngpL99JfRrs+M1MLG+i4iy+Nnp7kPeWFE8YodNoiWOpQ7HM1NISmv1O/5oQH4LZhNkYEBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkJGmn3GjTG+TKVsaCZSMO4CX8kJnJ5rRdvMBX2DnqI=;
 b=H2bkWGukFGfytvhtNmlaejJsv5pQ0Gnf/cxrj0U0DC6Ms4wU7Mqxq07tTGaqLMpuZmHyYPFdd3RmVIXeOOn7FHUlMhdoUZlSE4j6irZIk2PjrrfSE2MUWm2cWdzaoiJZDq/D3zrZIzG/0ixWPgmWuOu+CLfjH/mk5Gxb2V4zggCyUns5Igjexi5DSzGETNZpcex75g8ElpXus4wni8qdSzKh3LavFkvjhVAqcvF8FgB0OdqTXAnbl8WxW89x9tbureQV7WJL1e7vWsSpMgL6OC2P/rivm2xAweLnsGALedM2SCWU4S5YDPpi4n9HESE7M7hk2agJwDLXiBud5QI7KQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by SJ0PR03MB5502.namprd03.prod.outlook.com (2603:10b6:a03:279::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 07:42:24 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 07:42:24 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org,
	dinguyen@kernel.org,
	maxime.chevallier@bootlin.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] SoCFPGA Agilex5: enable stmmac per-queue IRQs
Date: Mon, 17 Aug 2026 00:42:19 -0700
Message-ID: <20260817074221.27459-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0025.namprd21.prod.outlook.com
 (2603:10b6:a03:114::35) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|SJ0PR03MB5502:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ea312f-f01b-4a41-6d75-08defc331392
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|6133799003|10067099003|11063799006|56012099006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	B9dJMLE5K8We7EP9fGbfILViYOUHgEQ9mYVI8oJJx7R197F3E7NhP6fqWW7YRZLN8EyXTTGBOmdF0dg/ybcz0l6vTp0FrL0GFlmedZ1WOfeqwzFTCtRfoa4+11ZXkyK6uosTqd/78C8TNhS8UO8QlwfIMWz53FLf7GKOIwAOeeubIlYfeaX/x41Aa+ODlWQLpmR1MQOu0DWV96Pze5Vivo3LZU5mMS7N77oBQwkL/B7Czr38VXEuFVyjfZx63S1PTXfMo5FM4gbzdITkvWx1XYd3YN5x4DiyBkhqQd8IuvuofeLhgWVgig6OVzZBfSPJp/M8sJDcU4xj/Eyp12+pwZ2pbEsmHjc8Q1SAHYmsySOmvGpWxyzsuiDg/7rH37ASEMYN6mFAGhB1GZ+/fkli104KjXCMYqp252sZqZDUi8B0be4Mgl555deh/hjZDbKGE/W8i3w8TRIYY3x6YN4LfN2jPrLU18ybgVyvq5/n/v0eXvcdlMXFBKVwJo8NFiJVGM/kTPH7xqnt5Nx2W+DnBxcCT8o0cYCLvBhBnUCtBo3CJTxsFyLLSJTkEJTkw+MhBy4U+0e6ys79v+t4OLloC8/2qdU6Y4lpCvq7QoLG6UO9dxlo1qQif95XnNT8aaGrzvfq8/X8DSTxwW07mcq6o4FgrJMSUwQalT4pft/esTM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b7L0j0O4p++155AKT7A9ln09KJww8Fcalcp4zTlLRdKzlkL6DeeaCFvVqNxY?=
 =?us-ascii?Q?JrvK+ZJb8u4cp/NBf948Gorw9EbcE2MUUTJlAMkYzBQHGWKYKtTv3Vt+1KsK?=
 =?us-ascii?Q?iDFowLKgxI16EXM2LjcIWE4h1Gi7KqCO4eu4k4i0/cyIBf2DlcljM+K8Pn8E?=
 =?us-ascii?Q?WVKpXwru17lHXOzp4xxwBsVfIdxtUcuvJqTqYf5Bba1n2FIFH/CXgfaXyQvK?=
 =?us-ascii?Q?xMYexfYr6nl/PtL9b5dA//gb+Yv3KhJyWdZbly24goomZL+FuxqBjaY0VBET?=
 =?us-ascii?Q?LzI71SfuB8QNHlAo8XMmAQnPM8m+hfxNJ2lakpA5Kks5/lhYlAgCPxmT1cNS?=
 =?us-ascii?Q?+hj8cnSE5kaR+uvGNh4GHYkNR6WUouGMjsyMu+0a1PMZV/KPQdfAB3eLNkmu?=
 =?us-ascii?Q?SsMPNmAqCtjvAjzgFKtM9wMW0nQW/ezI9tW3EtZ1dfwU8f4ct5OHqYIJ5KnJ?=
 =?us-ascii?Q?OnL05psMDevEsFOGvFXDyeJEuKB3AcuJDjzVOpyEKUIfNCx91J6Q5Um6LyIG?=
 =?us-ascii?Q?coKehktbavfh+qP6R9wBE4qKzn0dV5hHDei+tEif1eAFJlszLqKrIaRSJxVu?=
 =?us-ascii?Q?94nD6quR8DnTi6QsBxsqqDAdLVcXTQhjErBHAMAVBzQVr+UJThazSgf/KuUn?=
 =?us-ascii?Q?wU1o/S9AHwkQ3bELXLmyGOfunJkGCWdd6uRLS0lbHjNg8+hwHmhPXtUWkPvG?=
 =?us-ascii?Q?FzufR+oZJzZ5/dQFeUwkfrY7F9Fe1eSqmp5FuILWy/VLG6PGQV2EsSygqtYm?=
 =?us-ascii?Q?lbkuBQoRj4AoqtBv/2Vu+okoLdCcfqdhZ8nUTwRPgtJA0gGeJE+zt3rXLNkj?=
 =?us-ascii?Q?omKXXG3rz9ZDWH2nywmZSNcyBCMmYjZY6+CgttFYtRuTj3t7+zPjLT7nRrX4?=
 =?us-ascii?Q?3k5Wu89iRDs0r5OtAKu0A8w1PfuLnbgi1M5rkce+IGqfYWlqslWvSdWxT+7v?=
 =?us-ascii?Q?AY7KwOFljiD+5KiVbTjM/UbJnXJiThhUFEzrqTT22GJPM4X4/jSOQC+ml8uZ?=
 =?us-ascii?Q?g6qiKU9/ngRI/RrNWQYm0yjZETfO+XJiUZJfkn/lzBl53BLdDmRzOmUcsSTk?=
 =?us-ascii?Q?XkEZKmL5tGIzlkEX9sUYb9U9y+Vff2afuQHbXtww+bMzOF8x90CxFtjW66De?=
 =?us-ascii?Q?liXMcOTiUqLu+QhRjoji4UcP18l4F8Shghz17+cAUMtNYVXWtu8VrfE0QL8E?=
 =?us-ascii?Q?h13Q3rKGc+DKivquiZVPzgjqgX3iEm3SUdCFAmv874ELkrc1QnpfKIX5qke1?=
 =?us-ascii?Q?Wwwp9ipQh2HN415/AlsnFzoeKSDzdjnwrygYwZK5KsRD/CXOgkgvU00YXs7x?=
 =?us-ascii?Q?mdF4SHxMa+1cG1CSbB0Pal74yozLIHKs2cUo7y0uYxmaWkL1zeGdr+qePHEZ?=
 =?us-ascii?Q?bzGIWs+nhOqVKTvTFC9zVTgPYRz4jFJSHudHdsd7VmEBImkPKUj5dkArO8Lh?=
 =?us-ascii?Q?HKdhSybr2KZRTtMM9kxiBVtu3yHjVmtU7RR/p83t8b4YSOrdiZ7lWk5XR/xj?=
 =?us-ascii?Q?/3a8zULlqgga9+MO6SxYKqI7WxyLBp46fRt1ukSBho7CvL8OvCLA8SBgcpzi?=
 =?us-ascii?Q?sVkzLenHWmSI+euBRkebo5oBep9SwwLfZmHKCSxk184I/KUzhJe57saAYAe4?=
 =?us-ascii?Q?lGEXkBypgBSH2K/NdkN9bQnjt4WYLtavjkq774MNbfGj6QqZUadpBKVR/bLk?=
 =?us-ascii?Q?pd7axRB6ImRc24WymgTE9+CuoqSh3fgSd6F0tERodsVoInzQurXWKBJbRye9?=
 =?us-ascii?Q?CcTdxsdvuPiva5tXpSKwfyw7Xh09naVv508KMPsPcECp4ig52tvouSwZXzh0?=
X-MS-Exchange-AntiSpam-MessageData-1: VM9vry6Sdru3+A==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ea312f-f01b-4a41-6d75-08defc331392
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 07:42:23.8278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVW4gsH6vqN+hybCeURKvClfpSfx/PXyAhtwwUNGmECmDmTZr2EfSsDrZlXhGmiV8midlGqS5GgLHXywe3BtUoHtswFft46VpBYQzaMpREmXTK7xXCbWcAkKLCT5LG5DzdsKcMGB7sWT7sRMXm9w2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5502

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Agilex5 GMAC instances expose per-DMA-channel TX/RX completion SPIs.
Common stmmac already parses interrupt-names "tx-queue-N" / "rx-queue-N"
and can request them when STMMAC_FLAG_MULTI_MSI_EN is set.

This series mirrors dwmac-s32: enable that flag from dwmac-socfpga when
all configured queue IRQs are present, and describe those IRQs in the
Agilex5 DTSI with upstream names (no vendor-specific macirq_tx*/rx* or
snps,multi-irq-en binding).

Patch 1 is for netdev; patch 2 for SoCFPGA/arm64 DT.

Nazim Amirul (2):
  net: stmmac: dwmac-socfpga: Enable multi-IRQ when per-queue IRQs
    present
  arm64: dts: intel: agilex5: Add per-queue GMAC interrupts

 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 108 +++++++++++++++++-
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |  31 +++++
 2 files changed, 133 insertions(+), 6 deletions(-)

-- 
2.43.7
