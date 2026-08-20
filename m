Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D32C37C923
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787238099; cv=pass; b=g2M7jTBVxy1hS7wGJ/Qz18GhsMHjCURmGhSgt2rRxPrC7vAUiruhLUY79VGgBopHK6GhAzEoVNlGzYZ2TDftMKiH/fR1Tp47DjRBf13CgxzS9wcPXL2Bp2BhCOAn/PcGktFwpgTc0C4SA4vBR5BK9iPRextJ3df7b07X3OzZ0e4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787238099; c=relaxed/simple;
	bh=D2RYwrgKpm1Dr/0cRan7fmW2KfUcHQ42FPGSFv7Bbso=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=K1xWmT4ZqasOFm5VIcHEsoX5x/LzWh7Io8tS9Cd4j3JjbUEQH2Bm/vaycyCMcjFh/jHgipw82ApcaRsUgVtVTkwpRSschsbdH0H/hNYGErsDyBOQaKH651EBf2bWot7oAmzntg+mtEyprZG4mqOL6TP/Ul510OvqFev5FIyhJaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhDBX2g5; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhDBX2g5"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b15dcaca31so2535750e87.0
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 08:01:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787238095; cv=none;
        d=google.com; s=arc-20260327;
        b=ceVHfLKIiYIemRL4YitslpjbsGkxC+SWFBlqdgngh+USpiWeNFp2RMxZzEmkJreW/1
         lNrk7j/gNw4Sj5ZOG6N5fqLL8U2Boiweq5PAkc57lkY8QylgnV6RHcuThsh4t1hTo4Da
         ihoi74HnV6E9mFTOsIzOb4zXfhm6BrhkFbD09HZkY5qnc4tFRpqmzRe6WDL0noSwkUyp
         rvQs9gJUAjc0kP7xjDiHyZIJgy4DbIChFlORNCzvp2JONq6DXmji1m+g8PBP3YL4HJ7U
         GSZbhdegBglWZ0jeX3xEEfInhGF9fXaZZ5Bz6/C9DUQ1kxjiKbPFxj2d6/RNXHrvCXOE
         D6EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=OSZwf29aWQYmqvx2RohxX/kujaj1xOnXQAP4WizdVvA=;
        fh=yaTypwqVjjXAB91v8X7WXvNnfxO4YfwGsjJrhQBzCu8=;
        b=RMtQANDAHDpK0B98wAZ3Ukl4FQzsR33NyyUA1xEpJTgTf6df9fuGDnouBv4PSoBrju
         GbvE0xg6+BcDu8T4VgT0qYHca2IecxcihpKd7d2oWl9Lmv85xr+4UQTq5WRsfm0vnieS
         bsmHHzjnDx8pm8FAQfC0T55+IL+gL9ATKDlNHX6ylbrPKAFj1laafSRwCFrcGSob/k9m
         qJcBcwYJaBAzz4GTCCflXqXighEC5r1j1mnU78aiIPimSiFVvrq8OEReBeaP98ado6GY
         eE2C3+gI0Vblg7H6e1JCtzAd+/5jP4BhqVzZOZM6w/kvyjIOqL66+bI8e5xCzkQXbXy2
         YKeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787238095; x=1787842895; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OSZwf29aWQYmqvx2RohxX/kujaj1xOnXQAP4WizdVvA=;
        b=WhDBX2g5UkkTpNBG9Nu9/W90AiB98dxzXaYf4PteOmubZCELWbVeTTZz3lytfLccQ1
         EI71dZFYfU7W6RznPfRWtSCEIQv71ljXIRJOd/JCYfZnyoWvDUN/D87h3aeCF8BEyGqe
         yQdJVWA0RF7RAEmiv88If/n6xlQelAghaE1CI8SdQZvqQnHb5pkmbs+WysxJrvjGtoaK
         QNwPgk+yn9PbeFGcSHGfota+3MclgNd9eRBXmgIiqZ2pPox/WG3JGZe35YZqei0pZMt8
         YLbZMiAuRqfOmbJZoE3Itc7qAsQOFe0USpewcrQbuZN/odrjkYPlZGO0+5T8SHP8uvCw
         bPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787238095; x=1787842895;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OSZwf29aWQYmqvx2RohxX/kujaj1xOnXQAP4WizdVvA=;
        b=W/uyEXqkH/0hcCS0/yZwKknnRN1+PPT9njHe2qhSzXsukh0FDjkcfWhgOJvpINpNw+
         W8uE/u7Lp4CO+NRJ7F3tAW75O/LCmPQLAf4DFVFofddJSq9X1estqF1pfXc2uPnrI6bO
         AqLX2CdQXm8BUp4M5HmhlDH3IX6h8huoavecWjri89PtezcXB8M97FGWhk/JHsdJ4Wvh
         obzyhqC2ZG9RakTgnBe+7z9ov8hBUXEsIF/Tbq8ZUIiQFVw73nIHBxbONBvb8prWlfkl
         KhTRE9qw2zHuu2FEaQ0rn6wzDuWPsihct3Pb1lYFolUuOM4mf45r5spgbr2uetcvjk2x
         DF7A==
X-Gm-Message-State: AOJu0YzsuCu9CK8Yi0CpA0POgN+LoWP8cbvkQX/6MZy8fw1eDLHBOqx4
	G+P0dX+yIL3RfMZhxiF6J0toFvbijeObELXP01ovuhHJcJUctz5TB/xBH4eLrYMG9uJpHqMmfmE
	lQVDVzhwGAfbx4Ep2RJz4nyxy0LbXnLizP95T
X-Gm-Gg: AR+sD13wkvf0HeJQxHv6lIvexIpyGS5tP9WS65M72PTWqaYnuJuzP0U4YcB/XulYjn4
	e/oIk4m6MYhrb1GtGZDwiy4JyehU2TldXyAYzwzmXjBV+pT42CHfrOWvLAXTKiYJcsRckZ8Lam0
	66OGsmjWK3qfGEP8oEvzWx8CfgDs+LhzuRmx2/AeM7tUdee1RHeLxSYPh5WBrT5+Yua/6qrfGnT
	2/aGQcYEmONnoqEnV0utpfGL6SusAjQWEmx21I/dkDuhTHl6/WM6AC6Yhtk3wyyAwD/GIERXQim
	8NUV+uPVk+hXHaXkNaF5UPnKQmIF5xZTploJRaGLysk=
X-Received: by 2002:a05:6512:b97:b0:5b0:6ae9:c4de with SMTP id
 2adb3069b0e04-5b478bc61fdmr4854266e87.5.1787238094765; Thu, 20 Aug 2026
 08:01:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Thu, 20 Aug 2026 18:01:08 +0300
X-Gm-Features: AcwNN1VzRv-ECUsEcu1CHy39ydYIXDbKBCbYQCKYfM7Am5QSe-gSNbU_ds8Mwf0
Message-ID: <CAMuE1bHr84n5LKcj02HmMR5XefPtvQ-UEJAx7+UKfYvRgS0eDg@mail.gmail.com>
Subject: [RFC] ptp: ocp: exposing the TimeCard X2 AXI Ethernet port - which approach?
To: Netdev <netdev@vger.kernel.org>
Cc: Jonathan Lemon <jonathan.lemon@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Before posting patches I would like to check which of two approaches you would
prefer, since they differ a lot in how much code lands and where.

The ADVA TimeCard X2 is a PCIe card whose FPGA image contains a Xilinx AXI
Ethernet MAC and an AXI DMA engine alongside the timing blocks ptp_ocp already
supports. We want to expose that Ethernet port as a netdevice.

Approach A - let xilinx_axienet drive it.

ptp_ocp creates a platform device describing the two register windows and the
three MSI-X vectors, and xilinx_axienet binds to it. This is what ptp_ocp
already does for the Xilinx SPI and I2C cores on the same card, see
ptp_ocp_i2c_bus() and ptp_ocp_register_spi().

There is no device tree, so a software node stands in for one: "phy-mode"
replaces a phy-handle, since the MAC is wired to the fabric internally with no
MDIO and no PHY, and a "fixed-link" child node pins the link at 1 Gbit/s full
duplex.

This needs two things from xilinx_axienet:

  1. Read its configuration through the generic device property API instead of
     the OF-specific one, so it can be described by a software node. On a
     device-tree system dev_fwnode() resolves to the OF fwnode and the reads
     land in the same OF code as today, so this is a no-op for existing users.
     It is also in line with the wider move from of_* to
     device_property_*/fwnode_*.

  2. A dma_dev in struct axienet_local. Descriptors and buffers must be mapped
     against the device that masters the bus, which for a platform device
     created by a PCIe parent is that parent - a platform device does not
     inherit its parent's DMA ops or IOMMU domain. For every existing user
     dma_dev would equal dev, so no behavioural change.

That comes to about 50 changed lines in xilinx_axienet and about 180 new lines
in ptp_ocp.

Approach B - a separate driver under drivers/ptp.

Reimplement the descriptor rings, NAPI and ethtool support against the same IP,
roughly 2500 lines, and share xilinx_axienet's register definitions out of
drivers/net/ethernet/xilinx/.

We have both working. Approach A is tested on 7.0.0-rc1 with the card:

  xilinx_axienet xilinx_axienet.512 eth0: configuring for
fixed/internal link mode
  xilinx_axienet xilinx_axienet.512 eth0: Link is Up - 1Gbps/Full -
flow control off

ping at 0% loss, a 90 s bulk TCP transfer moving ~9000 packets each way with
zero errors and no TX timeouts, ethtool -S/-g/-c/-a all working, and clean
module unload and reload.

We would much rather do A than maintain a duplicate of an existing driver, so
the questions are:

  1. Is instantiating xilinx_axienet from a PCIe parent as a platform device
     acceptable, or would you prefer the driver split so the device can be
     created on the auxiliary bus? The platform device route keeps the change
     to xilinx_axienet small and matches what ptp_ocp already does for the SPI
     and I2C cores, but auxiliary bus is the more usual choice for sub-devices
     of a PCIe function and would make the DMA parent explicit.

  2. For the dma_dev, we currently infer it by testing whether the parent is a
     PCI device. That is concise but implicit; we are happy to pass it in
     explicitly if you would prefer it were not inferred.

I can post the series straight away if you would rather look at the code.

Thanks,
Sagi Maimon
