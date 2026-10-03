Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch [185.70.43.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A7348F018
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791046307; cv=none; b=qUYNIjnUAYibHBrx/peBgyBH9fbvX3WvqFWc7a/O0jA9q3rnHhvweHCbbfUcWaWQ4gtIuUX4HT4+Mq8u4OkAEOVuGQ46RWhslOWP2FNUVdgor9FreBtsXG7r5u97wXrNMwSDyOICEZ0/SK3OLB2v+HWxmmRjfiiiu7HdthlVm+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791046307; c=relaxed/simple;
	bh=iN2dacuD2WXWVPe3pa7Hiwu4Q8mHr64UNBGkwL/Vsxo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDLD0MABgrAZTgR3KHMXGGnHCbo4xeYdAYVU0mv5+gDLZ5zoU1Dtb/tkDrMF4v4Tr54R4QQFg3RN5+xOMjbPERWP+aXM9hhcDG2M++1dfgh8+22K/MUlaAs/jVUGwe3T6BO2mGPpmQB83eY9dDhOCgGl/NWKEtaB4r9d1zul3y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=NPj4ASj3; arc=none smtp.client-ip=185.70.43.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="NPj4ASj3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791046291; x=1791305491;
	bh=jhnKxC1jfYQTIuTmaIFSI31CFkT8/+tMwqpFmimI1mE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NPj4ASj3XEB0AC4FSjoNSNY4thPPfkhDBceN/B6WWS+OtBflPV1mvNX8MFPV4VWrJ
	 GkSGEHVXJAlj863kX7PKt3+YeM/wbnItd53pFWe9wJrrvhLcW5llncYSe4ERPi+kO2
	 p7MNtEO4eHGAVsLe3q/7l28e68457E8nhgNnpp5sVYNeMaeCWxaSvsXWhwamcRYQMY
	 jdR2D8BWxlanXhb46a6pJgkqEBFU4aVU6ZKDv/7jG2NY/PzJ3mOrUzC/suFYCKdfpm
	 mt+AAma/lVJL5I9QzILJvPtnP+WwNmtEXWwt9WDETHlRbbx2Gj2a0UBn0FrypYQpgW
	 sKWGp2wa3lCTw==
Date: Sat, 03 Oct 2026 16:51:24 +0000
To: Junhui Liu <junhui.liu@pigmoral.tech>
From: Norman Herms <dockseed@proton.me>
Cc: wens@kernel.org, Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, netdev@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>, Enzo Adriano <enzo.adriano.code@gmail.com>, Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v5 3/8] clk: sunxi-ng: a733: Add PRCM CCU
Message-ID: <IX5E2OTO5TApj5Vn4djIoBmcguIRvSNmVwcbXPiXUUGdVZr1NAJHSRomSnI2U5zgW9LWkNXJUpSIlkvHGCwlb1n6mYkGZoH4l1EOvNgua38=@proton.me>
In-Reply-To: <DLVAHLGLB6W5.1X87X6JJ6MY5H@pigmoral.tech>
References: <20260930-a733-clk-v5-0-11175b41cd2d@pigmoral.tech> <20260930-a733-clk-v5-3-11175b41cd2d@pigmoral.tech> <CAGb2v65q8w6NLzTtuMX3HZR98nAvR=Z4ODUCFZb5j3TgkDu_3Q@mail.gmail.com> <DLVAHLGLB6W5.1X87X6JJ6MY5H@pigmoral.tech>
Feedback-ID: 144388465:user:proton
X-Pm-Message-ID: f0d0ad3ff4b1cce1df4b4fde15de0e8f3c9593c9
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Junhui, ChenYu,

> > The three bus dividers are secure by default, and either need to be tog=
gled
> > to non-secure by the bootloader, or (I'm guessing) the system is runnin=
g
> > without secure boot and the secure access bit isn't in effect.
> >
> > Please add a comment about this.
>
> Okay, I will add a comment explaining this.

A data point for that comment, measured since my last reply. For the
registers behind a security switch, ChenYu's guess holds on our boards.
Two test BL31s, each clearing a switch again after
sunxi_security_setup(), then reads and writes from U-Boot at
non-secure EL2:

- PRCM_SEC_SWITCH_REG bit 0 cleared (0x07010290 reads 0x6): r-ahb
  reads 0x03000000 and r-apb1 0x04000000, the values EL3 reads, and a
  write to r-apb0 (0 -> 1 -> 0) sticks.

- CCMU_SEC_SWITCH_REG cleared to 0 (PLL, BUS and MBUS secure): PLL_PERI0,
  AHB, APB0, APB1, TRACE, the AHB and MBUS master gating, NSI and MBUS
  read the values EL3 reads. Writes to PLL_NPU pattern 0 and to TRACE
  stick, and U-Boot's own write to the MBUS gate enable register
  (0x4 -> 0x804) sticks.

So on these non-fused parts (SID + 0xA0 =3D 0) the switch bits do not
gate non-secure access, as the UM notes on these registers say for
non-security mode. With secure boot enabled, the bootloader has to set
them; we cannot test that.

That narrows what I wrote earlier about secure filtering without the
fuse: on our boards it applies to the registers the UM marks as fixed
secure (S_TWD_BGR_REG), to CCMU_SEC_SWITCH_REG itself and to the SPC
status words, not to the registers behind a switch. We tested a sample
of each switch group, not every register.

One board, AI agents (Claude) on my board as before, so a report, not
a Tested-by.

Thanks,
Norman
