Received: from mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65325357CFC
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787675891; cv=none; b=CTF1VI6VyygbPx0BDI90xhuSfMi8BPoNSePhe1mq4MrNJ1Hny0urogP55ZsFs4cQOpYvCEVrq9xbdXzopaeY68XELxRG5sGQ8Z8Z/W4CtmkPX4BY6iK0OpRJu7+M2oNxs+OCmiKesQep5PEET3TKB23XDexOdfnQNuTYaaBh/M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787675891; c=relaxed/simple;
	bh=MkUNQA/yksKCC3jjEFhp3OpzbEjgIqUw+pL+P+grodk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Akp+rR1YRvAV1SrGUxuyDnKf0vYbR1JEhwiCGoInXcjZBeFNcbk9vyDJQ52ynOUPxQgAg2SJycvcOupMdbckFfqr/nzBSJd1RSyIodelBDqnmCiCqj7kmEX5VcTTYSqUv4VxU1kb/GZvlcFe4D6sWO/UCKH4jYCfqT6HnSlfcrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lOOd4f2S; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lOOd4f2S"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MkUNQA/yksKCC3jjEFhp3OpzbEjgIqUw+pL+P+grodk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787675888; v=1; x=1788280688;
 b=lOOd4f2SfhygoSFf8Dm2qUpN6kyfrvLbM0XHGT4qHiJ7x1uNNO1QlUazBLl1/nBmYI394IeS
 Xg4uP44YUO4TVr8o4g8po9VX7tk8ckIFYes6BIEP7QF43Ovvp3D8qe5DKGVRs8L1KFXUfAgP4EG
 SpHNhli6ON4WKle/If+18R3k=
X-Envelope-To: netdev@vger.kernel.org
Received: from [IPV6:2a03:83e0:111e:2:c6:2f62:38ca:59d8] (2620:10d:c092:500::7:692)
	by smtp.migadu.com with ESMTPS id 76f75ebeae15f9e3;
	Tue, 25 Aug 2026 16:38:08 +0000
X-Mizu-Trace-ID: 76f75ebeae15f9e3
X-Migadu-Flow: FLOW_OUT
Message-ID: <8c5c1254-34b9-4d38-8cd4-71b3c13e00e4@linux.dev>
Date: Tue, 25 Aug 2026 17:38:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] ptp: ocp: exposing the TimeCard X2 AXI Ethernet port -
 which approach?
To: Sagi Maimon <maimon.sagi@gmail.com>, Netdev <netdev@vger.kernel.org>
Cc: Jonathan Lemon <jonathan.lemon@gmail.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 linux-kernel@vger.kernel.org
References: <CAMuE1bHr84n5LKcj02HmMR5XefPtvQ-UEJAx7+UKfYvRgS0eDg@mail.gmail.com>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAMuE1bHr84n5LKcj02HmMR5XefPtvQ-UEJAx7+UKfYvRgS0eDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/08/2026 16:01, Sagi Maimon wrote:
> Hi,
> 
> Before posting patches I would like to check which of two approaches you would
> prefer, since they differ a lot in how much code lands and where.
> 
> The ADVA TimeCard X2 is a PCIe card whose FPGA image contains a Xilinx AXI
> Ethernet MAC and an AXI DMA engine alongside the timing blocks ptp_ocp already
> supports. We want to expose that Ethernet port as a netdevice.
> 
> Approach A - let xilinx_axienet drive it.
> 
> ptp_ocp creates a platform device describing the two register windows and the
> three MSI-X vectors, and xilinx_axienet binds to it. This is what ptp_ocp
> already does for the Xilinx SPI and I2C cores on the same card, see
> ptp_ocp_i2c_bus() and ptp_ocp_register_spi().
> 
> There is no device tree, so a software node stands in for one: "phy-mode"
> replaces a phy-handle, since the MAC is wired to the fabric internally with no
> MDIO and no PHY, and a "fixed-link" child node pins the link at 1 Gbit/s full
> duplex.
> 
> This needs two things from xilinx_axienet:
> 
>    1. Read its configuration through the generic device property API instead of
>       the OF-specific one, so it can be described by a software node. On a
>       device-tree system dev_fwnode() resolves to the OF fwnode and the reads
>       land in the same OF code as today, so this is a no-op for existing users.
>       It is also in line with the wider move from of_* to
>       device_property_*/fwnode_*.
> 
>    2. A dma_dev in struct axienet_local. Descriptors and buffers must be mapped
>       against the device that masters the bus, which for a platform device
>       created by a PCIe parent is that parent - a platform device does not
>       inherit its parent's DMA ops or IOMMU domain. For every existing user
>       dma_dev would equal dev, so no behavioural change.
> 
> That comes to about 50 changed lines in xilinx_axienet and about 180 new lines
> in ptp_ocp.
> 
> Approach B - a separate driver under drivers/ptp.
> 
> Reimplement the descriptor rings, NAPI and ethtool support against the same IP,
> roughly 2500 lines, and share xilinx_axienet's register definitions out of
> drivers/net/ethernet/xilinx/.
> 
> We have both working. Approach A is tested on 7.0.0-rc1 with the card:
> 
>    xilinx_axienet xilinx_axienet.512 eth0: configuring for
> fixed/internal link mode
>    xilinx_axienet xilinx_axienet.512 eth0: Link is Up - 1Gbps/Full -
> flow control off
> 
> ping at 0% loss, a 90 s bulk TCP transfer moving ~9000 packets each way with
> zero errors and no TX timeouts, ethtool -S/-g/-c/-a all working, and clean
> module unload and reload.
> 
> We would much rather do A than maintain a duplicate of an existing driver, so
> the questions are:
> 
>    1. Is instantiating xilinx_axienet from a PCIe parent as a platform device
>       acceptable, or would you prefer the driver split so the device can be
>       created on the auxiliary bus? The platform device route keeps the change
>       to xilinx_axienet small and matches what ptp_ocp already does for the SPI
>       and I2C cores, but auxiliary bus is the more usual choice for sub-devices
>       of a PCIe function and would make the DMA parent explicit.
> 
>    2. For the dma_dev, we currently infer it by testing whether the parent is a
>       PCI device. That is concise but implicit; we are happy to pass it in
>       explicitly if you would prefer it were not inferred.
> 
> I can post the series straight away if you would rather look at the code.

Well, we definitely don't want to copy code but rather reuse existing as
much as possible. Looks like platform device is the way to go. Let's
discuss the code.

