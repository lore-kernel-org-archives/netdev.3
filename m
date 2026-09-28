Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85DD378D74
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581384; cv=none; b=Lqc+NCemorvVfFPTLXBhb6fEJT32qZIePOJIfR7MtfGw/d3Laf/qBE+8RS/YHdmVxnB+7AMVSpi62Mvd4m/eydCoHqZvtqIhBloj6Jt1zlxl09/srW19jo+FdpNb79nlYrbV3+3adHymQBMSxkmPBbq37K77h95axOPPNR3S4J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581384; c=relaxed/simple;
	bh=lmGXDbYVJ4P/Gl0CZ3e6mbtv65rIVdEbeZHx2e/i/nM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I7JDRTIxVm5/de0NhHKbZB3BLjuFXWOMAiOK22hshA0qIkUrWX5oip5ktPwDNQSpiupQ0Z/CsJAJu7m01DP2diCIVsZl7YjhW5Sfde4VvxjKsV7zb+DdQppk+blXa3Chskmhas3AcnbSsxhoP4N1R8wNk6FkAc6AjiwNM1cAyY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=omOS5BWk; arc=none smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omOS5BWk"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2db9cc3b45so153443066b.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 00:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790581381; x=1791186181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FP+gLOszNdkYTUHyCbw8OXVGoIovDektjO/Dfou+tRs=;
        b=omOS5BWkwlX4ewc3ESkuJOiefR/2MFY+cgnUQOv/0FEsbULfyVzGRlBGMi4rgoUPVw
         ppqu/uqYXOTFL5RKgOdUMioQ3hGdbQvMpJjYw1p3rUUye6pjdnn0MCFafNKuGhiHeAEv
         HWH8QmfRzWiVRv27mJ/rLPujU71W1aFWvoKaWz66r5GwFp4A/w1MQBJB8pWPDANBZEqJ
         iaxltmCCvLJN8YQstdAVyJJuIXPhitUF8qNby2w0Jz23ldS3OnoW/cEJxAmGF3MTaqUt
         ZfjoGLDjXnGPmkm8MVd4A0Kpnk5DrhQDRkYuRcBgHa3/yPv3dMI6Aj9VYaUjHTLTtQt4
         Oy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790581381; x=1791186181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FP+gLOszNdkYTUHyCbw8OXVGoIovDektjO/Dfou+tRs=;
        b=T+rWtOwl5A55Bcef2jwV6k7av0umtA2fo8BMAz3NbzFEQ9ErPlEe+rD1G/+5Yqsfo+
         Nsas+ZziCQhCTa5XA9Bcvvbo8hkqUNqcedKY1TwDo2uQZGqFuJBeLrAwyo6rqXZdiTVG
         Q0kWG7rF8F2akZfyeFTf9NZubM428Cgv2MGJweU/Ahtmjw5LAxwfuOxZ3VZPW+mJ8Og0
         2aA5UpngUP4hkOSHUaGrLJFe8vl6do0mo3WO1c6bGE6sErwBxRGYiJBQfNfYXD2wJeNv
         sXiv8TxF2Itvq+c3xw5v1fVttHgyXZRkmBWkejkcVa87NnSgRQm731lpOFidRd2WrOwW
         pXdw==
X-Gm-Message-State: AFq9FYIX0Fh1dTZVjTk8fxmL19w+I6fZvYQJJk+z34OZxHIFTxZgwzpj
	2D8mPdrhLR193nIaz/iG1E869LA52ppjiGp0zxyna7QNH4TLJarU2OCnXonMruR/
X-Gm-Gg: AYBFou31/vkl1k7eG6xjRguFJGI+Yw0473SfdXVT8Lnoa6jzdCZzQRiA/lN1GhP1fOe
	dppUR0A2q6W6tX2WhU+pD7wUO3dCFOhbCdyRuiMFb5Dm6hUh91BA3sa5KaNhz35lCcPh/0XBd+h
	2LPpQ/AoppIrgdQFmnErodWGliYeNPXcGoulS7GyvYLzGf1dFP01c59Dvrn+0VLaIe8z0VC+itp
	ve/CiBXi2NeGjHF+9f8W2F7ZobPkh8VIUrWlC+qEC+21SJrSpb2A1nyFHigyjLUZrMEnf1no58A
	o3bf7NzJnaBp9N9Jy0NP273Hc4/hjLaz+PEdQBRCtDPmJp5v14B2TqU19T2TfR27Njvjvs9s8/8
	q674GF5DRg8lIPSLgA16sX7Qq2qRPfweEGvYoIdx10MPNeoTCo5OG26jKzHWmoeDb5K1MlhQph/
	AUUhfrGNPigp90DijG6edmoTO8LE0yc3o8IEsbHUoiI2bslvq11uLMbdLngy1mgz+/V3R1Usdhd
	oQ6Iw3UpJdpiqFMnWWzR/IfMxDWyjG7Xm76sirn
X-Received: by 2002:a17:907:1888:b0:c26:19de:9ae3 with SMTP id a640c23a62f3a-c2ac25ed786mr991954666b.34.1790581380877;
        Mon, 28 Sep 2026 00:43:00 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae76ac760sm419415166b.39.2026.09.28.00.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 00:43:00 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: netdev@vger.kernel.org
Cc: radhey.shyam.pandey@amd.com,
	michal.simek@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	vadim.fedorenko@linux.dev,
	richardcochran@gmail.com,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH net-next v2 0/2] net: axienet: allow instantiation without a device tree
Date: Mon, 28 Sep 2026 10:42:54 +0300
Message-ID: <20260928074256.462345-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADVA TimeCard X2 is a PCIe timing card driven by ptp_ocp.  Its FPGA
contains an AXI Ethernet MAC with an AXI DMA engine.  The plan discussed
on netdev [1] is for ptp_ocp to register the MAC as a child platform
device described by a software node, so that this driver runs it rather
than a copy in ptp_ocp; Vadim Fedorenko agreed that a platform device is
the way to go.

These two patches are what axienet needs for that, apart from one more
change - letting the DMA device differ from the platform device - which
has no user without ptp_ocp and will be posted together with the ptp_ocp
patches:

1/2 reads the probe-time configuration through the device_property and
    fwnode APIs, so it can come from a software node.  No change for
    device tree users.
2/2 adds a MODULE_ALIAS, so a device registered by name autoloads the
    module.

Both were tested on the X2 with a local ptp_ocp change.

[1] https://lore.kernel.org/netdev/CAMuE1bHr84n5LKcj02HmMR5XefPtvQ-UEJAx7+UKfYvRgS0eDg@mail.gmail.com/

Changes in v2:
- 1/2: convert only the four lookups a software node provides:
  xlnx,rxmem, phy-mode, the MAC address and the PHY connection.
  xlnx,switch-x-sgmii and the deprecated xlnx,phy-type stay OF only, as
  Andrew asked, and so do xlnx,txcsum, xlnx,rxcsum and the "dmas" test,
  which the X2 does not use either.
- 1/2: v1's hardware test was not re-run.  The X2's software node sets
  none of the lookups that went back to OF, so each finds nothing with
  either version.
- 2/2: unchanged.
- v1: https://lore.kernel.org/netdev/20260927073843.346910-1-maimon.sagi@gmail.com/

Sagi Maimon (2):
  net: axienet: use device_property and fwnode APIs for probe-time
    config
  net: axienet: add a MODULE_ALIAS for platform instantiation

 .../net/ethernet/xilinx/xilinx_axienet_main.c | 22 ++++++++++++++-----
 1 file changed, 16 insertions(+), 6 deletions(-)


base-commit: 014d795c73837ea2339a4ea8e8f82c6e959b845d
-- 
2.47.0

