Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793132100;
	b=lwKCEh+g2wufT8osvXpyBbY4mrJB/JqmmGExued1ghtYdLd6g1B8HESGwgzPNLYnMoKw
	 ufO6RZwAi9BW1PqnfwAo95ZPYRFmW6CB6pvOafz1OwZajrjK7ztqcl3sJdXuijIza8mb6
	 1qcX35CyH/HJQSuGYpZ77EzeS0VK0XFrqhuuek2ufdEpC7Ab5sS3VZJbP9GiDbnJBASEh
	 mis6ks6CQyUEXTkOh2kbDDm5qsWDV9DgOloDXrfoAs1tQ/Y0K76xJY49if573LkJPCybV
	 GviNFfNUx/pp+WireHDB8m7uLWFaM8LgHPojgXJICD91EOBEeHiB8g5x3/T5ynI65ag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132100;
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
	bh=7Aduw+yPPteWlHU8tXNAS5CeKCH9vRmOo7s5mIfuCJE=;
	b=zBCfRjLagtluvOEyUW2jVBMIpxjYrHxTztVMEPJwwTOt4eXSYLmyJfvjU+BkwvVTLYjI
	 SUedl/QPvNk+KERQsSFH/mINa931yzLvlXslqTgmIwZgmiT5opvOxta1VG75+RXrDQ5tA
	 TWIBoYzxbK5i2aregf7oARlxw1AqxcgdVOaAJdE2kixgDejpEhm9eVpCP8Xas1qWDyf88
	 4mmBEjCGVUv6u9dma7M6KmWQTxnQsAP0/fy5z3X6ykcIOFbcZUb6wzUU8rPP5CQJ36hD4
	 rvEFuxTMskPgbHW3bey1UH0+yoTev2RFLRurN0WBG07Xx8ONbURFlXKutDeVRtaYT5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=b219F7uF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.67
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010067.outbound.protection.outlook.com [52.101.193.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB1A606A31A;
	Tue, 27 Oct 2026 20:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFB1A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=b219F7uF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PzYBI8XrwnFL5in8JlNSlVCZGpzWg7uawZ3j3tavFv3c5TIkqcPivRmX3bzh81/aPORZB+/TvRDXLE4n6kTD+7dVPOZnyNfjgdKVUjuNkDlwB2578SH8xZHgYkxmfiKvWq43MpBdNiwD7mt9kby84yXRhpfUy+MFAzj22UJNN2UJqqKYwLSe9IziAghx64u/SF7W0ghpFC37Y6tkHbbCgLPUIrzDcC0C3VsJRnE2gyltcV6QKt3s5jd1MXztsEIx9lkFMl9hMnUHtdT6HtR2y0f3/DCz0VgRvUSTfsGtBVhf691T+rR+byh56AFpXBulzqEZHQLwHiBNFZK7MBDT+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Aduw+yPPteWlHU8tXNAS5CeKCH9vRmOo7s5mIfuCJE=;
 b=u4kPjSOHVT0uSk2GSPnMkOH96nkor6kYIk7MpCjQLJ97OhQSCX7TVlpQSM53dqZ86uoQ+VXy4E2+wHNqr8wQ4fcwcjoZ5ZRhhhQ/Mtz7qX8hJaSjTnaDPenZEImkQTgG5I72RB2hLa9SCG+WDtY7/jIPd0dQahivev022dF9+/7mLJDCrTWW3cwlcf5CuwK8bCskxsO3yfmWW7HhYrdDE0A07NAGNEAxabkPIhP2u+k1CKX/6V/qfTfUXNhkUtbhW/+TUthysllb+V9A+PjDJQTwe+evygIlleVwjCYcGIpgWIar3MJ4BvBp1BhGHl/6/WMYF57P0FlbbUEZkS4FfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=tipi-net.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Aduw+yPPteWlHU8tXNAS5CeKCH9vRmOo7s5mIfuCJE=;
 b=b219F7uF2Af0E0RdmDLLFOQqnpNXSB/i3muymTwmto2hLtU6wGw0k3mYwkllkwK4aI4dcphuBDyXI/7zfVivAn6vBgEUk+kn93AjfyukocMgwqljh78p7Pc5QFlmK3zH2LIUsAhnnCcOenh3b6ZOkycVR0pIbJLMtPdKV6PqYRCe/hR2X86SNU08pf0cKVZBDj3vf7MIU9/mdCGOf4ITNx7VE/ihl64eG8HloULftSYDQBOKZ6KKkbb3Mv/ib4601IS0r3PUGhdCKuNfv3iXmOUmyNeXKnULljnPXkjOLgkxJ0Hylg2tJlOD96Ylbh1dYpP4K9WOtbW50pCgUl7+hg==
Received: from DS1PR06CA0014.namprd06.prod.outlook.com (2603:10b6:8:458::9) by
 PH7PR12MB8177.namprd12.prod.outlook.com (2603:10b6:510:2b4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.22; Tue, 27 Oct 2026 20:14:54 +0000
Received: from DM3PEPF000265C0.namprd03.prod.outlook.com
 (2603:10b6:8:458:cafe::96) by DS1PR06CA0014.outlook.office365.com
 (2603:10b6:8:458::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 20:14:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM3PEPF000265C0.mail.protection.outlook.com (10.167.23.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 20:14:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 27 Oct
 2026 13:14:35 -0700
Received: from vdi.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 27 Oct
 2026 13:14:33 -0700
From: Chris Babroski <cbabroski@nvidia.com>
To: <nb@tipi-net.de>
CC: <Raju.Lakkaraju@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <bryan.whitehead@microchip.com>,
	<cbabroski@nvidia.com>, <davem@davemloft.net>, <davthompson@nvidia.com>,
	<edumazet@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux@armlinux.org.uk>, <maxime.chevallier@bootlin.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>
Subject: Re: [PATCH net-next v1 4/5] net: lan743x: reset the device on TX timeout
Date: Tue, 27 Oct 2026 16:14:13 -0400
Message-ID: <20261027201413.589706-1-cbabroski@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5cabe797885011ea204a793557d8639a@tipi-net.de>
References: <5cabe797885011ea204a793557d8639a@tipi-net.de>
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
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C0:EE_|PH7PR12MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca13be4-3082-4da7-783e-08df3466f6a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|376014|7416014|82310400026|10067099003|261022105027099003|261022075727099003|261021121427099003|261021135927099003|56012099006|6133799003|22082099003|18002099003|261026140227099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	rIH8bsqn3AQS/u9ZMV+FFuNYAzRTk/gq0KzdwRDhuEMvRHHfZWjARWPrRyJ4dKnyR7Kx7kDtOyjZXc/NxLEFJ+gdFXmBa1FEdWFtxsNcY65Rl72Tx6JW/46OOfbVJ+Ikp1Cwo9Mu7ioAY53Bw0QLT6teKD9zldrkueYaD5CUJJPnkdknyQ18D2BRD9zutTaW7yC+Wrb9sAjbUXh50rYg0g20MJMcFh2E7BjJmQvpzqr746z6pO5pn9r1QkWmI4kriAifQMw1ypERlelPQPx17sKwBXAOUw668QscnGDIkhamvhyLAf8SVUhLKJs6BpLasR33PjV5nJapBYyGg+NYl+Ebq+6A24cZFzQypqwUHQ/N/ZKmYg+kLmcZ38a2ugPL8WalZ7+Qk6OE8O05zX8G9pjyAA8SskY6yw3Y+FLHZIcC8xkZbHX/RseC8zt6kG0YaPVcKteQOJJ+/kBvdeeARPVIzwextgQFs2nj4A8gjyKTEwmlvDOoALafwLjnh3WjnF/jMevYyaLCW7I7Qxp9XxN3F89sW87nIEmsCTUvAM9RSX2uP8ihKz0P1yamMEYNDAbPjua58/PkgrNn/gtn8w2GoZD19HJXYHhdMEfK1J5JxJQK9qb6rCdFRTs/+36qcLhgekkuFedVUG4/i15MtT0RT0M/R6xMRrNNZHcrd6fVFcwpTDdnold8dKKa12p3
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(7416014)(82310400026)(10067099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021135927099003)(56012099006)(6133799003)(22082099003)(18002099003)(261026140227099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wBGKmr/0JLKhI60sWqa4uylPvFThfVucnN0cdNg5FyLRGZVR3n1EGg/qPjrDmJTb7iWyjeHrMLLTHQcaEaz6wVFGIkTSToD8QqASg2Exm+AX9s821WGHWjIuhCOFPcoozkUMl9j8N/38YsADwdodVI257DLLSg3mGt0UyaaxpNilD/nNx8bSmXTQTu8j+1v6C5XZi0Bs5JoB+sGfgt9JEgrod/CwfJ+gctvHs3f7RHcyk8beTl26Moln9QQBAK2ih6ayqhny5wDwtgxc+osXbrmq7Xz9aqPA0FYZ9lUPBI3I4xw5sUTe+yaY6TPQRLgRaTiAzAFZXfd2TfJp7MYLltTUA55vMz1D8CbIKD4uBDzhNZIjUVzfoLpiOXPo6VknIc1pPzu8tRXJFk0ePH9mT/9mcjQSqWRlBt1mCwwBthTxo80ROXhQFx3o3lnxmE9G
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 20:14:53.7414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca13be4-3082-4da7-783e-08df3466f6a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265C0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8177

Hi Nicolai,

> Is it ok to re-register the PTP clock on a reset the driver starts by 
> itself?
> 
> ptp_clock_unregister() makes the open /dev/ptpN return -ENODEV, and
> since the old index stays taken while ptp4l holds it, the reopen comes
> back as a different /dev/ptpN. So ptp4l has to be restarted, which is
> more than "set up timestamping again"...
> 
> How about moving clock registration to probe instead, so it survives
> the reset? Then only the hw timestamping config would need to be put
> back.

It may be best to get Microchip's opinion about how this should be
handled. Woojung, can you answer this?

Makes sense that moving clock registration to probe and remove would
keep the PTP device valid across TX hang reset, but I'm not sure if
there are other consequences to PTP still being disabled and re-enabled
during reset.

I'll update the commit message to be more clear about ptp4l needing to
be restarted and try to run some tests to see what the effect is of
moving clock registration.

> > +	ret = lan743x_netdev_open(netdev);
> > +	if (ret) {
> > +		netdev_err(netdev, "failed to reopen after reset: %d\n", ret);
> > +		goto close;
> > +	}
> 
> Unrelated to this series, but lan743x_pm_resume() seems to ignore this
> return value.

This issue has been flagged by the Sashiko AI review bot twice as well
now. It would not be difficult to add similar error handling to
lan743x_pm_resume() so I can add that as a separate small patch when I
send the v2 series.

Thanks,
Chris
