Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792528655;
	b=4kOjnX6x/JGuhCwlXiP2t7ojougqMlvdV6BbOpd9dDfEELeZKT7ZsJ2RmiylV2NqqCn3
	 yfCt3pO+Z4gKxr/OFr5PIBiUMYtThWo89VAhBz5ckz+fuXg0Zv7KuKhtAFTwf9eMw4moD
	 TkpR9d8nY8X5IEvR1YUFm/QqWR9jRdhqfTxhgGzYizFJ6WovysB1vPE7jq7Hx23mBSMll
	 f9SvQA5Zvri3zjPnd5DNcH2otRIpG/QtWIawyober83mXVTADOy7rGg2EubPsSi88v8/r
	 Aeu16utvYTcn5ozdANKr5FFZufgarAjAPCfVMMp0oJOzC/0qSktqJ47ObidKs/oZuUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528655;
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
	bh=W93JmP/X5xWzuUdX0qR20oJMM78ypmbnM/kmJPCC24M=;
	b=ne18ryBwsd1hWUmq3+H5uTPTPMfFZyuXxdDwxtdZWBUmRHmdEhnZGTzO2Xt5fMaXnLO3
	 CLEdl9FtAzFOujHRwwVzIcKVamyu64iejpxpZEZ8BQgP/JwoRJ88VW8DaaSZ165LCwb2O
	 d+vN+sYg9vzDIltJyY77mitalo/zMNKd2RCm9mtuWF0NSjEIA/NeH71dtU89T9ZJcm6ei
	 3nbG1QhkCW3jD5ATsEv4WwnLhDNVST9nO5PGLTlkNO9VP7n8PQNfI9Mra8oNnrWpnUYol
	 331crDxWfiRPkKIthYBrw3Abn5vq373Exr1Q5TWJKIlNLWDFLBUTWtfgbWcTaSbXYAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cRGiCq+H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.14
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26465606A31A;
	Tue, 20 Oct 2026 20:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26465606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cRGiCq+H
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUBajVfhi4AkpLWh0XGJEg+3oAZTGr3/B5iWoyVVzH/GJ8XfNMY12eX4xMXjVtWFq+JwUaKIHQDB9WfYXtKjhG88UlMRO2nYv275bAB8erq6xwHOepIoEvfNXeTZRlp+3OqYFs6gekwfuby8mp070y+9s8xWqePULn8Bq3IOmO0pJt0rq6lzRYJ6LbPry0WuMKye1CW8QPxNktFI6pDQs32uVBY+15MLQu1FDNTljQdNsNyLTmDPsffLp3PLtEdP7oQtFlKKOS/5Ixf8PovVAPUzK3yZDmEzFyCfISNgPD/RwVTFadTDP4O6ngc4AiJjjFlUcafvx8zaMk0RN4lYzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W93JmP/X5xWzuUdX0qR20oJMM78ypmbnM/kmJPCC24M=;
 b=V04UYZnsrV0ekzEOFvr6cIW2bjoOpCIZEijYUS/WfOAMNhFlpqbDyxHDhwVFnMzq0sZ3eecrhQC3IkEylC56PSKDW5xJEMLmx7RU6o0M2GLb5cOyi4IcN2U4DntqVtL4LZzCEzIIrnpCv6b7ayXpaUz8zzvuulUwk3TY2XcuRjbTMUj2fc/ULEPwFbUJA3h/dGB0gVqIp4uTJaBMgTl4aFfJV2Px2IoOKZ4nX/ddpRoZcY/+6wA6ZIozyC+JiEYiUkezx6wLCM8PqkcStjLwojmiCgcoOU1jhxgPI4xGNGWfXrvNR6rYpUSCLVFBhal38QML0L2GYY3uA55ZC8u1Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=tipi-net.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W93JmP/X5xWzuUdX0qR20oJMM78ypmbnM/kmJPCC24M=;
 b=cRGiCq+HrKnz+tA9ZZWjIUH1d8RptuILya6+T2cphsFnCBL/JAx0nEX4XnCKnse+71bFSwTUw5C6pRvcCXWSd+rPqCbnyrDj6x5wrNwutPksJEUglHYre3V4vM3csC48NJQBfybVDl0XHMDiU7FCh2QAkzS7wWzaWnDLNAXeFqM4bhFCoNUC/i0jqn/M+XVuNAx9D1GFx5BDllAE5wZedCZtQQWuQTuYWFrZSr5RVSvkY9CVAKZtwfpeMkFpbiIeAd2ozDnuMcznwhD/HQXE6MSL+sanLY13CPRK/Wtek6XZrs54m08zIaCueaNZEdx78O/3dYwr4IkYHJopQ6kD6Q==
Received: from BL1PR13CA0016.namprd13.prod.outlook.com (2603:10b6:208:256::21)
 by PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 20:37:21 +0000
Received: from BN7PEPF0000009E.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::7c) by BL1PR13CA0016.outlook.office365.com
 (2603:10b6:208:256::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Tue,
 20 Oct 2026 20:37:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN7PEPF0000009E.mail.protection.outlook.com (10.167.248.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 20:37:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 13:36:55 -0700
Received: from vdi.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 20 Oct
 2026 13:36:52 -0700
From: Chris Babroski <cbabroski@nvidia.com>
To: <nb@tipi-net.de>
CC: <Raju.Lakkaraju@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <bryan.whitehead@microchip.com>,
	<cbabroski@nvidia.com>, <davem@davemloft.net>, <davthompson@nvidia.com>,
	<edumazet@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux@armlinux.org.uk>, <maxime.chevallier@bootlin.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>
Subject: Re: [PATCH net-next v1 0/5] net: lan743x: automatically recover from TX hang
Date: Tue, 20 Oct 2026 16:36:41 -0400
Message-ID: <20261020203641.335809-1-cbabroski@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <c2a65a9425d8a5dbac493a2b4ad3005e@tipi-net.de>
References: <c2a65a9425d8a5dbac493a2b4ad3005e@tipi-net.de>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009E:EE_|PH7PR12MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: 43b9cacd-bede-4137-ac1e-08df2ee9f079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|36860700016|82310400026|56012099006|11063799006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	X+iY74ZD3zwHYG+AREmptXzjVRaDCQiTJIgDSBoRGxRNo8/oaJNjK2CB04PUz3cF8LQkkvqDzmaZXyX25YJRPIBprl9QzwjwNL8cZkbxfNd7eXB31B/9I7CIZZywlO8pZtYfMkwfnyH1OUL0CBut++rizHhw0msXV3CkGDfygD119yYLUmg0CS/NCRRW4NnfZpLar1JYE/lw/or85PqraU7J4rtrcg7HkoKqDNv/+8EE9XGW9nQBOpSqMiDo/I7jeXIc2MYhgU0RDgWG8ou+ENGQl3mP7uGiOofsS8+H/sIO9IPhTBuVVeGldQlQiz7v6P7piwSF4qi3qKbo4TtEKu4P0WMskgrH2RdqAAtHN/BpxqfG4Gvh2X4qtH9Z3q/BVClMH+w0HbYWaO63XTG35i5moX9lZTHwc3ylBICY036vznk+1EMV1OymT7NtfbExmmKvwLgu1bQjmOG2y3df8RZPjZaWY1M2t3ihZsSrXZpPSEcEv+rOHirLJYh2US6fxmV9L+vZjxLFwsrUkmq4BN2BOnQ5IevzqykXBt9Xw47qCDpfdx2OLYhqgxSzR4TiCElywqKPfgPE+MM7aOrRzehNOoIPIPbjK2bgs/AdfobPo1P3lZi4BVa1RUyTgCWkfzampOJvxEGawi6XFT/4qTPPc/eNk7lT2lEjLAAvAT992e0rbb71c8xu9H4RVmccbUVSGQAHOkZjSylanB1JGg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cq8hVFkMRg1FnZGHbS5PWvPexkMMs7GneMsFhSCvqkZ/bYchOGcRxW+0ABGHc7R1dktX/rmrXNpmePCPUF8EhAygK4X1ce37bL1BZ9MGhCv0kjjTI8vQWfwb9TYLlgqEn39pRMXm9yEJHDyJ8IcILDG4GgYwnVDoL9rsXBNd84U9JhCj3pu6CJCDVF1dIdtV5xsIBAz6ln5w4CUoGyCywXniaKb6tdZ4dDjljWk7ezBWNFxwpClgv4sC5mWxu6ZTXfdcME67tZ7BZManfUjeJriFWenwVV3WZcBT25Z9wQ4iMSYt2DTi5+rbDsxIxK68oxb1EVE/8r7JXFd8On7vKiHUakfKCM85GAaqderIwmKA+1PP1vLfb7kjIyzenAPztgK2j/Ve92L7vnxK7nNbRbCEQFoq3vsvjuYzP+f0LNn5vktDU6hktBbPGVW0Dlm3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 20:37:20.4778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b9cacd-bede-4137-ac1e-08df2ee9f079
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF0000009E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709

Hi Nicolai,

Thanks for taking a look at these patches; will respond to your other
comments soon.

> A TX channel that says started, no error, with TX_HEAD not moving is
> also what you see when the MAC stops draining the TX FIFO. When it
> hangs, is the FCT TX FIFO full?

Interestingly, we are consistently seeing FCT_TX_USED=0x34 when
reproducing the TX hang. We have FCT_TX_FIFO_END=0x27, default of 20kB,
so it is mostly empty when we reproduce. Is there anything special about
the 52 byte usage?

> Is the MAC in LPI, or paused by the link partner? Does it still happen
> with EEE and rx pause turned off?

In all repro cases so far the MAC does not appear to be in LPI and EEE
is disabled (MAC_CR=0x200C and EEE_EN is clear). I also tested with
"ethtool -A <if> autoneg off rx off tx off" and could still reproduce
the tx hang.

We have a PCIe switch connecting the NIC to our SoC and on the switch I
can see that the NIC's read requests drop to ~0 implying that it stops
fetching TX data and descriptors rather than the MAC stopping queue
drain.

> The other place to look is the PCIe link. We had a LAN7430 stall on a
> BCM2712 root complex that was also platform specific. The RC driver
> cleared an undocumented bit in its CLKREQ#/L1 control register. That
> one took the whole MMIO window down, so it is probably a different
> failure, but it took days of uptime to show up too. Do the Device Status
> or AER registers on the hung device show anything (UnsupReq, CmpltTO)?
> Is the link running with ASPM L1 or L1 substates on that platform?

I do think the PCIe link could be related; our current best guess is
that there is some issue between the NIC and PCIe switch and we have
tickets open with both vendors to help debug (along with setting up EVBs
to run comparison tests on).

UnsupReq and CmpltTO appear clean. ASPM and L1 substates are disabled;
the link stays in L0 at 2.5 GT/s x1.

Recently we found that after every reproduced hang we see that the NIC
sent a NAK to the switch, potentially in response to a CplD from switch
while reading TX data and descriptors, but I am not yet able to see the
rejected TLP or NAK reason with my setup.

We also found that disabling scatter gather makes this issue
significantly harder to reproduce. So it seems that a full TX descriptor
ring and the NIC sending a NAK while fetching TX data/descriptors
increases repro rate.

Best,
Chris
