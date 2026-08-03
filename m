Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24562367F5E;
	Mon,  3 Aug 2026 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750770; cv=none; b=E+gBIFk5K9S+yBcE3QQrK6CPxygg9YdlInwWNfd0kB9zqe81MdqlLkURxJ98MdQVVL+eM5rx7o7gNSE3UIem+YHclyJKGmd2kKvk/0hRuE0gcVq+IAPvHZcKUxtWE5hNPTEAhm3n5q94OpRb9ynETftXyQpnL/dNFWUAD2QCqSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750770; c=relaxed/simple;
	bh=PQ8ebD61+c5OLJpuj87jWP9f182aPDCi3aavkR1n4RY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F+895pQ4mQt4vCuXKA/d4p1UjfDkT+XidcxN4Ab4FKK1D41ExF5FAjmaXC2ynctEV2oE3ZVlsPgd4hgrJuT+0PIuGhXrldh1Yp/qGDl0v9BDFAdmP1bzC2NiS3/xrVXVw1Pd+ZqvbIfeowsNHDsB88ipnwreBJ96UqS58dXVN1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=mi5jhJDb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OxrSILBP; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="mi5jhJDb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OxrSILBP"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 2EA31EC00CA;
	Mon,  3 Aug 2026 05:52:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 03 Aug 2026 05:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1785750768; x=1785837168; bh=5a
	YFBkyrYly6Ddvg3yeIwGjX2vJqdqTGlopKOy8rO64=; b=mi5jhJDb/eqi6gPGml
	8rM8KBka0coduQ9EWxTSDxnMG9KSI9uPK7eo6FDsYm7WxAauDndlthgc3lFAxLYo
	OI8M7W9jV9P3waU8D7XUXkcZS0qH4ncAV0O6BqQPO4XQT7bFArkjsUk7SXeXdjxc
	RMJbYS/EcoYnRb/6kdxjzSRTZWpyrDFieamhoHMSihe24kCwIojHJB8rDCEFyoqy
	2+n1IWSx9lo0opr5j00IVMdoZv4WuTg9Cdc50zVoySSimUKxhMz3sTPtaUsusj0t
	iDmcuqDGb437jJp5owi2zL5zz9Dr1n6NBII65NwrsR6lj48aIEqxm+mDuD4yxCtk
	Xe6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1785750768; x=1785837168; bh=5aYFBkyrYly6Ddvg3yeIwGjX2vJq
	dqTGlopKOy8rO64=; b=OxrSILBPYlXX1ha5HXMcZ9udlaQjaHb4fbaAem3fo0Qj
	PcFvpteHPauLOVMZbEeKaQPZkF+CTHKfcAs3Od+AOgRqAbsGEaRFkFnlSrouQHFk
	2GTv0v7ptRrwL7QX0oHT+R8vuQ5A5dz1yFxbdAYLRs0mxHdnASuiIOGpwQ+OTUGm
	S/yWdMKohgaH4VClAZagzYSHMkzgx6g92xuoNWYS3In5wDctBvd8J3hXUqJTOdli
	CRLWdWTS7r9embhEJfJlEOfKHp+ZgqDnKPoWS1jHcXC5qhZUnwqia8A7donA8wF1
	YPCuXZS9LVOtWCnfW//Zpbn4VUxq4MNI3N2imSfv3g==
X-ME-Sender: <xms:72RwaqVCESlmxe5DU0dN7NChOgwq8hv6s5NN7NTOsuzWwNnc1XJA5w>
    <xme:72Rwai5o1zGpeAbDe0zbD2VXw-ngrjm4x5rs4LwaWVOXgg20XHaTwom17oMtNiwDo
    FXxMh87wqO1QKBPmYw70yfQzPEkC7AUsXVhUqgKS3aBJGMFSI1yyExt>
X-ME-Received: <xmr:72RwagBSrmgeaMyPWzEzj_c-AW4eA7qNf-FmZytUg9HQW4Dr87wMvkiI2l6pEBf0ct6IyUoPUY3KQWmJwrwjkvoO0C8wPxo>
X-ME-Proxy-Cause: dmFkZTFV3gmJRYjnEnT6Oqo8kOPCfaIlk6cRMICG3oImtoYICclt6O4gcnR75o4vPpu+3l
    KngpWdAyXWkAC3JmFaEDUOS13HQIjMv2lyMfM/haWjEXVbLau+BWoZqhs7KF/h0Med77R2
    R5sTTaKbMzppKk1ICyPMYDUl2S54xjDsuDYa6/84HYfgwGLnv1Jog44dgkqMdlHHv/3g9e
    9C9AH5RnZw5+R1ck2inCASQPyueYAdZmwMx66yLKgluoLF8lMxf9LPjIARXIXsjFh0Avef
    udU+QJci+iHuj7DtJ3b3TzWkUbpWj2ab5FvjQl8Jd3oqXTVt7WEZbkTa1pM0TFHYa4+OjI
    4AY+ydF3BdXCCqZtlb8ovYeJKC2Y0eO7P0P//JSsgfqhJu/O44t2Yu+EFkwAj2TPuSyu5B
    OoWTOwrM1kgwM3KUsZix/2n4RmY+tQe8O3sb6LAneTAE5wlTBAZZ15o6ymVUXaww4jVJDD
    tJ7FMS07kHf1sl/G6RbRJnm2V2eEqxuoQ1F9bGF9sgEeY185l8/lNVJptAb9KjVN2IVjMf
    RkooIY32qW3xmCLFhJ3livtjiHLgRFo5tKMgV49BLtras11KUYf/ADAGEJOTut8Zl/90L0
    NLYeYXU0KHMHxQSTOK4XPM/KnayoKVMx/kDwSQbXWYOljc7pT9gyK2iCxcBw
X-ME-Proxy: <xmx:72RwaueoKRFtPCcCnxZDsPjUegzOvLpwmIOuXN7L4TSaNjwtbl0ArQ>
    <xmx:72RwapsQUoYbRNBklgxLvAtYmFAbnJLMi3WzFoxuUTFyJ8D2sbz6qw>
    <xmx:72RwatIsZseugX80vFDb2dG3IrX2SgjTkeE88D3EKvIjk1lzuH9SLA>
    <xmx:72RwajZ0HS3fhscEzZutuo0mQzA95xjTSElWZGsp8euCitc6VugG-g>
    <xmx:8GRwamDKz86_xNHSCR9AKPAyxnRyw6cJCkEPeUa65xuF0SwT0f9TxEMo>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 05:52:46 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"DavidS. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH net-next v6 0/3] ptp: Add driver for R-Car Gen4
Date: Mon,  3 Aug 2026 11:52:29 +0200
Message-ID: <20260803095232.3527111-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

This series is the first part cleaning up how PTP timer support is
implemented on R-Car Gen4. Currently there is partial support for it in
some of the Ethernet devices that can use it, but not all.

The partial support have been implemented by hacking the gPTP module
directly into the first Ethernet device driver that used it, RTSN for
V4H and RSWITCH for S4. This is understandable as earlier R-Car
generations had a dedicated gPTP timer for each Ethernet device, but on
Gen4 there is a single system-wide PTP timer shared by all.

The current implementation makes it impossible for other Ethernet
devices on the platform to use the PTP timer without messing around with
other Ethernet device drivers.

The effort to clean this up starts with this series which adds the
system-wide gPTP timer as its own driver and device tree node.

This series will then be followed by work to add proper PTP support to
the R-Car RAVB Gen4 driver, which currently advertises to user-space it
supports PTP but which implementation is broken and does not work.

This will in turn be followed by work to the RTSN and RSWITCH drivers
will be be switched from its current partial support by mapping the gPTP
address space directly to instead use this driver.

Having both this and RTSN/RSWITCH described and enabled (!) in device
tree will not work as they will try to use the same memory region. For
this reason this new solution will only be enabled on platforms
after all user's of the gPTP clock have moved to only use the new
centralized timer. But in the interim both devices will be described
(but not enabled) in the platforms base dtsi file.

For some platforms this is straight forward, such as V4H Sparrow Hawk,
which only have the RAVB Ethernet interface. This platform currently
have no users of the PTP timer, but still advertise it supports it. This
and the soon to be posted RAVB patches solves that.

As the RAVB patches depends on this series the device tree node for the
gPTP clock is added in this series but will be enabled and linked to
consumers in the RAVB gPTP series for platforms where it will not
conflict with RTSN and RSWITCH. And further enabled as more of this is
cleaned up.

The gPTP driver itself is heavily influence by the existing partial
support for gPTP in the RTSN and RSWITCH drivers and the Renesas BSP.

Niklas Söderlund (3):
  dt-bindings: ptp: renesas,rcar-gen4-gptp: Add R-Car Gen4
  ptp: Add driver for R-Car Gen4
  arm64: dts: renesas: r8a779g0: Add gPTP node

 .../bindings/ptp/renesas,rcar-gen4-gptp.yaml  |  64 +++++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi     |   9 +
 drivers/ptp/Kconfig                           |  12 +
 drivers/ptp/Makefile                          |   1 +
 drivers/ptp/ptp_rcar_gen4.c                   | 225 ++++++++++++++++++
 6 files changed, 318 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ptp/renesas,rcar-gen4-gptp.yaml
 create mode 100644 drivers/ptp/ptp_rcar_gen4.c

-- 
2.55.0

