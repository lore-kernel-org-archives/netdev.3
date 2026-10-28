Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793199967;
	b=ZVLcJ5xIBvu7AshH2y9jERMpcH5r76IRm1ml655CGJ0p/HjhN4I2AA7Gepofcn18d8M/
	 dQKfn9xmxfct10ui5KDHX2OqCcPgaP9aojWwLm8b7NgFeUHDigEKxU9Rhz/VWaSRx73Id
	 cz4QURUr6m734xX5Dwp0hn9m9m8DWhb2/dzO0nMhtZzUmiNLJbTa4nADXBkehvfv1MghH
	 i2dMwGPNN8/jOFM2PyVRJ4m7kOpC0kvhICffEto9NG+dSsHMAbDRQ9K9mshpRYJ8EkP4W
	 TPXpk7R0ZpXSa/+lgWJuSaLJPiy5Yu/1y0/v8Szyenv3R5uKOQwJsr6pNov/6FGQdgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199967;
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
	bh=zsCqrh1dihTp0DSpLhKP3InuAvtlGZvxQMdJ5rHB++8=;
	b=tI/pU53Fzq17gqnpVdeEMe5QDEdQu5Iq9pB9iNtwal1lMYzkc3uz2e5yeI9AKvk74o20
	 bWbEi6MtOP3sW6TEoUVE6mgH/2WxUehKj3jURtjCRhCzrLOggvS8qnk0X9rc60aNJenTB
	 OHAv6D7FiBBDs7/OVT5zqEIfDsLPyTWl3tUGu6uez6RkHjC7mkosD/8HdtwsS0LoJ5+jH
	 u+g6+xeMfNU1vHsP03HtJppTUm4ZdiO/Kg0RWiJw1cY9EGuh6pr4fRrk1QRwrMOWeDR20
	 9mHLwFKA3oRe2r74nvkHOVR881QkKSnpjsZbeMQ7A4pS5DO4Kp1wTz81oZ4CdJphZAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hFNRT9eP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.1
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012001.outbound.protection.outlook.com [52.101.48.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC343606A31C;
	Wed, 28 Oct 2026 15:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC343606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hFNRT9eP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7qLHbbLkt7jTpRECDidybEDqxwiTjSPrb/+YchZTW6ViXAcm/Ovm9Mdp4PB/tK9bYYOI+q8RWZaffDyT0Fb8TNMGIkoH722zEeISAmSdy2VOqszJnv1tU8dOwgqSg9Zpa44RobHrR6Z86DllIxiG4fgvR6l8Fz67Kza0izczLPQxmWLUJmsXNpLZlphlkrs6xG7aoyWZqG6jOcM8TjHAVQAYwBIiWclVBBxy2/bOYDc1Xoz0nQ6QowUqPl/T/Chg4c4BqFHdW2awkeZCAlvTrxssSw1aSvZwFyHwkAlUsDaGObtAkTbURaI+4sy+yUvMOY6AK0p8lng9DBOfTqzsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsCqrh1dihTp0DSpLhKP3InuAvtlGZvxQMdJ5rHB++8=;
 b=xnjQBtESFvggxnoojTs5qsWMH7mhiWfeqR4kxG2pFrnUVkgP5SxIky25Z9xluBe0D82S4RjCUCaNKJdYbPETV4KXXX842QLhbLotHLGjvbXHYwfQJZfH7WoUNuII6Wcrw4/mOstedfCLhrkt8ngU7UbnLOJEotNMx11jWdwOa42lj4BRnHi5eeJU8W5Fwe1MxEtjVcN27TSeB3yOGmRY4uAE3BDq+qvNyKj8VZJie/k1M3OHfkdl76yVlVK01KWgsD1hQfA+5K0r8SiLEeImYAurlCBIh1/OpuWPyBQIdTdXuN0frPRBFP8EKCXddWUdXiklJgfrUQRvQk4ZZxZ13w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsCqrh1dihTp0DSpLhKP3InuAvtlGZvxQMdJ5rHB++8=;
 b=hFNRT9ePdrSWfMYGgjG6Bzzc9sc3zGtdlYB9mFbjOWgq7kHoe9ruei/YGAiJiNDU8RZndTqUIKFbhBHpQsgrmrgM7XBkTZGe2m0RBwEdw6SrrzxQCW3pU945G/AH8WRmKQHMXpLf1fj3wnOoH+FOYDTXpQezDtvSKy2MHoe2j4PMGErFwqb6HKsrUL742nq9YBMdeRI1QXKQeVD0RlG/RVcXP5gclUOnls8g8w95Bm5x5E7c7DqNtO0VqmU2c+S7CUPN1L+vn/xDaQOfJBbYhFHwXEp5+S/zKsqQXR/DvYtBqSPYi+ptIBBlac+X9hRdduF+yBbWHpXuoKV8sYO+Og==
Received: from PH7PR02CA0020.namprd02.prod.outlook.com (2603:10b6:510:33d::28)
 by CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 15:06:02 +0000
Received: from PH5PEPF0000002D.namprd04.prod.outlook.com
 (2603:10b6:510:33d:cafe::53) by PH7PR02CA0020.outlook.office365.com
 (2603:10b6:510:33d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 15:06:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 PH5PEPF0000002D.mail.protection.outlook.com (10.167.243.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 15:06:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 08:03:37 -0700
Received: from vdi.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 08:03:34 -0700
From: Chris Babroski <cbabroski@nvidia.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <nb@tipi-net.de>, <Raju.Lakkaraju@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<bryan.whitehead@microchip.com>, <cbabroski@nvidia.com>,
	<davem@davemloft.net>, <davthompson@nvidia.com>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>
Subject: Re: [PATCH net-next v1 4/5] net: lan743x: reset the device on TX timeout
Date: Wed, 28 Oct 2026 11:03:24 -0400
Message-ID: <20261028150324.9007-1-cbabroski@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <179242764729.3135.6473581413465367257@kernel.org>
References: <179242764729.3135.6473581413465367257@kernel.org>
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
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH5PEPF0000002D:EE_|CH2PR12MB4262:EE_
X-MS-Office365-Filtering-Correlation-Id: 98369b99-46f0-40e9-704b-08df3504fb27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|82310400026|36860700016|5023799004|11063799006|56012099006|261009223027099003|261022105027099003|261026121527099003|261026140227099003|261021121427099003|261022075727099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Mmtk/X/CAAioSIcHwZOE8jC+L55atSJ2YX/5H11RNTDdm1gIgeVHM44HMjpvx6heGU6RvMWbEs7r31S0xYJFC6buMEwfKi5m/WbMnRFIN4OgtKgDWTy6oavER2c2RPACaIBIXcmjf+55w+Ht5y0/JI7OWVf3dyIcGlyWxRKRT7GniwfUvb/VzJkuw50VkILPNuScy6s7pWjL8qoaKVJXBH1/LlW1Q53pUgASrdVPYjLVzmJPe6K1uBch2fYzRSwZr97zq7o/bI44gsMivBDoF0n2C5L4S03woUVizJbiGv7KK8/bY4W9G4qlMdZYP5uafnzS/Hn0s/mftprMuafFIUbWXcoAYS+71fOKwbGKWynuWyVmKRItCST0zWDC+hPKAi9os2dY10jqVGXq5UUao5edNoFdKPzgvsasahQvcbGOMVviCru4+93maRygvzIQGpKvox86oS8ViQoPtfEmDpwDOWlI1wkOx6n1LKh+n1RZVWyCu5l6oBGvdRGuMaue4sbQcxtFo33pny1hnnPWpGijh0uJWG9wDkrI3uJgpQpHSpaWJUFrbKu0eYdIUwDYqJPGBzFwAVBFdq4XhWFg7RYnwzpCWkagM3lsdzDnjQzuMQRs1jVYva0fTld1dytS/gGkFjIQ1tx8z9VbenJeOxVsKlCqR1TjmkhDWcIFdAcfUQk1WUtC9HyLnjK8gCo4ocftNxQ8kKo72MeAY5Z8mw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(82310400026)(36860700016)(5023799004)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uc07KmWBC/MQnDUL2GMbW8mzK8th+hzxFeDYaVn3QNHIKP2EndB5VYZQtkwnSW+7SwZyU514+UbmmImgCcBHKH7xjHeFwHeqw7GJgXjHB0rq4EPtYFQp2BRnLY+UcGulsBmu5cDS7OYrmJg8ZD5eQlqq4poDi9kTv+8jYwhWyyMOlERty47rKzT9mXKfnXDqbHGASNE/uxTGhZMY+wXfdcDlrOBjDlCllwaKhnQFUtCjLV7fz61khHQWJwYqkjI21989s1YywY9GMFyKbgVVhf+ymMEcV5SLcvm9B930lBr45GmK6szMyto2Fuq6ybHAtGeRysKP+f3A8d1c3HSKe0kwnyNWUiTLPgfMtgTX4qOi3Ded1my05VUjEAiCTNCx9ADb9SSAQNUSTBWSQ2msTew1dkGkjtHjEDNkMCb/4Tchrc8htnAVfkiufsyQ4te8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 15:06:01.8365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98369b99-46f0-40e9-704b-08df3504fb27
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH5PEPF0000002D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4262

> >  static int lan743x_dmac_init(struct lan743x_adapter *adapter)
> >  {
> >  	u32 data = 0;
> > +	int ret;
> >  
> >  	lan743x_csr_write(adapter, DMAC_CMD, DMAC_CMD_SWR_);
> > -	lan743x_csr_wait_for_bit(adapter, DMAC_CMD, DMAC_CMD_SWR_,
> > -				 0, 1000, 20000, 100);
> > +	ret = lan743x_csr_wait_for_bit(adapter, DMAC_CMD, DMAC_CMD_SWR_,
> > +				       0, 1000, 20000, 100);
> > +	if (ret)
> > +		return ret;
> 
> [Severity: Medium]
> The commit message only talks about probe here. However,
> lan743x_hardware_init() is also called from lan743x_pm_resume().
> 
> Before this change lan743x_hardware_init() could not fail in practice,
> so the resume error branch was dead code. Does this new return make that
> branch reachable?
> 
> lan743x_pm_resume() {
>     ...
> 	ret = lan743x_hardware_init(adapter, pdev);
> 	if (ret) {
> 		netif_err(adapter, probe, adapter->netdev,
> 			  "lan743x_hardware_init returned %d\n", ret);
> 		lan743x_pci_cleanup(adapter);
> 		return ret;
> 	}
>     ...
> }
> 
> If that branch runs, the netdev stays registered and detached. A later
> unbind then runs:
> 
> lan743x_pcidev_remove()
>   lan743x_full_cleanup()
>     lan743x_hardware_cleanup()   <- INT_EN_CLR write to a disabled device
>     lan743x_pci_cleanup()        <- second region release and disable
> 
> Would that release the PCI regions twice and trigger the "disabling
> already-disabled device" warning?

Yes, and this issue can be resolved by removing the call to
lan743x_pci_cleanup() on lan743x_hardware_init() error and continuing to
return early from resume, leaving the device in a detached state.
lan743x_pci_cleanup() would then only be called in remove which matches
how lan743x_pci_init() is called in probe and not resume.

Will fix this as part of v2.

> > +static void lan743x_reset_work(struct work_struct *work)
> > +{
> > +	struct lan743x_adapter *adapter =
> > +		container_of(work, struct lan743x_adapter, reset_work);
> > +	struct net_device *netdev = adapter->netdev;
> > +	int ret;
> > +
> > +	rtnl_lock();
> > +
> > +	if (!netif_running(netdev) || !netif_device_present(netdev))
> > +		goto unlock;
> > +
> > +	netdev_warn(netdev, "resetting after TX timeout\n");
> > +
> > +	netif_device_detach(netdev);
> > +	lan743x_netdev_close(netdev);
> 
> [Severity: Medium]
> Here lan743x_netdev_close() runs on a controller that is already assumed
> to be wedged. The controller-wide DMAC_CMD_SWR_ reset only happens later,
> in lan743x_dmac_init().
> 
> In lan743x_tx_close(), suppose the channel does not stop and the
> per-channel reset also times out. The error is only logged, and the ring
> is freed anyway:
> 
> lan743x_tx_close() {
>     ...
> 		ret = lan743x_dmac_tx_reset(adapter, tx->channel_number);
> 		if (ret)
> 			netdev_err(adapter->netdev,
> 				   "TX channel %d reset timed out\n",
> 				   tx->channel_number);
>     ...
> 	lan743x_tx_release_all_descriptors(tx);
>     ...
> 	lan743x_tx_ring_cleanup(tx);
> }
> 
> lan743x_rx_close() does the same for the RX ring, the head write-back
> buffer and the RX skbs.

In another thread we discussed removing the call to
lan743x_dmac_tx_reset() inside lan743x_tx_close() as part of v2 because
recovery happens in the following lan743x_tx_open(), but this still does
not solve the issue flagged here that the descriptor ring is freed while
the DMAC is still started.

Woojung already clarified that TX reset should occur after FIFO disable,
so we could fix this by adding a conditional "stop_failed" flag that is
used to determine if lan743x_dmac_tx_reset() should be called after
lan743x_tx_fifo_disable().

The conditional would make it so that we don't have to re-order the
lan743x_tx_close() flow (which has higher change to introduce
regressions on a common code path).

I can add as part of v2.

> [Severity: Medium]
> This is a pre-existing issue, not one introduced by this patch. The same
> close/open sequence leaves the TX one-step state inconsistent, and with
> this patch the watchdog can trigger that sequence automatically.
> 
> lan743x_ptp_open() calls lan743x_ptp_reset() and sets the RX filter back
> to HWTSTAMP_FILTER_NONE. However, tx->ts_flags still has
> TX_TS_FLAG_ONE_STEP_SYNC, and nothing turns one-step Sync insertion back
> on in the hardware.
> 
> After the reset, lan743x_ptp_hwtstamp_get() still reports:
> 
> 	if (tx->ts_flags & TX_TS_FLAG_ONE_STEP_SYNC)
> 		config->tx_type = HWTSTAMP_TX_ONESTEP_SYNC;
> 
> and lan743x_tx_xmit_frame() still sets ignore_sync for Sync frames:
> 
> 		if (tx->ts_flags & TX_TS_FLAG_ONE_STEP_SYNC)
> 			ignore_sync = true;
> 
> Can Sync frames go out without a hardware-inserted origin timestamp until
> the application sets up timestamping again?
> 
> Admin down/up and suspend/resume already have the same mismatch. The
> commit message also documents it ("one-step sync insertion is disabled,
> while the driver keeps its TX timestamping flags"). The PHC is
> unregistered and registered again, so applications have to reconfigure.
> Reconfiguring applies one-step mode again through
> lan743x_ptp_hwtstamp_set().

As mentioned by Sashiko, this is a pre-existing issue and already the
behavior that happens with admin down/up and suspend/resume. I was not
planning to change this behavior as part of this patch series.

We have a discussion going in a separate thread for this patch about how
PTP recovery should be handled across reset (if at all as part of this
series).

This is an issue that could get worse if we register the PHC at probe,
as discussed in the other thread, so ptp4l is no longer forced to
restart. It would then require restoring the hwtstamp config in the
driver after reset.

> > +
> > +	ret = lan743x_dmac_init(adapter);
> > +	if (ret) {
> > +		netdev_err(netdev, "DMA controller reset failed: %d\n", ret);
> > +		goto close;
> > +	}
> 
> [Severity: Medium]
> According to the commit message, lan743x_dmac_init() now returns the poll
> error so the work does not reopen a controller whose reset timed out. It
> also says the interface is taken down "so it can be brought back up
> later".
> 
> lan743x_netdev_open() never calls lan743x_dmac_init(). That function is
> only called from lan743x_hardware_init() (probe and resume) and from this
> work.
> 
> So if the user runs "ip link set up" after this failure, does
> lan743x_netdev_open() reopen the same controller that never came out of
> reset?
> 
> The early return in lan743x_dmac_init() also skips the DMAC_CFG,
> DMAC_COAL_CFG and DMAC_OBFF_CFG writes. Nothing on the open path writes
> them again.
> 
> Should the open path retry the DMAC reset, or should the device be kept
> from coming back up in this case?

I think adding DMAC reset to the open path increases regression risk on
a common code path, but the alternative of keeping the device detached
after lan743x_dmac_init() failure would work to prevent future "ip link
set up" from opening the device after a failed reset.

In v2 instead of "goto close" which includes device attach we could call
dev_close() without netif_device_attach() in this error case and leave
the device detached.

> > +
> > +	ret = lan743x_netdev_open(netdev);
> > +	if (ret) {
> > +		netdev_err(netdev, "failed to reopen after reset: %d\n", ret);
> > +		goto close;
> > +	}
> 
> [Severity: Medium]
> Some boards use the fixed-link fallback in lan743x_phylink_connect():
> LAN7431 or PCI11x1x with no DT node and no PHY on the MDIO bus. Can this
> reopen ever succeed on those boards?
> ... 
> The fixed-link handling is existing code. On these boards, though, the
> new recovery turns a stalled TX queue into an interface that cannot come
> back up until the driver is probed again.

This same issue was flagged in another thread as well and I wasn't
planning to make changes because they seemed out of scope.

It sounds like the fix would not be complicated though. I can attempt to
fix this as part of v2 and then may need some help testing on HW that
uses fixed-link mode.

> > +
> > +	goto attach;
> > +
> > +close:
> > +	dev_close(netdev);
> > +attach:
> > +	netif_device_attach(netdev);
> 
> [Severity: Medium]
> While the device is detached under rtnl here, multicast list writers that
> do not take rtnl can still change dev->mc. The IPv6 socket join path is
> one example:
> 
> ipv6_sock_mc_join()
>   igmp6_group_added()
>     dev_mc_add()
>       __dev_set_rx_mode()
> 	if (!netif_device_present(dev))
> 		return;
> 
> These changes never reach the hardware. After netif_device_attach(),
> nothing reprograms the filter. lan743x_rfe_open() only programs RSS, and
> lan743x_rfe_set_multicast() is only called from ndo_set_rx_mode.
> 
> The normal open path resyncs because __dev_open() calls dev_set_rx_mode()
> after ndo_open. This path has nothing equivalent.
> 
> Can the RFE filter get out of sync with dev->mc? Groups joined during the
> reset would not be received, and groups left would stay in the filter,
> until the next rx_mode change. Would a call to dev_set_rx_mode() after
> the reopen fix this?

It sounds like this issue can also already happen in resume when
lan743x_netdev_open() and netif_device_attach() are called.

If I understand correctly, it could potentially be fixed by calling
lan743x_rfe_set_multicast() after netif_device_attach() in the reset
and resume paths, but dev_set_rx_mode() cannot be called directly.

I can add this to v2 and keep or remove based on review feedback.

Thanks,
Chris

pw-bot: cr
