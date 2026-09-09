Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E892314A90;
	Wed,  9 Sep 2026 17:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975059; cv=none; b=d9soAWkpkCvbyfaFxvJurjAh/Yfdg7prpGFzH0BoyDAfSl8Ibco0VZsBYCKnjUIWQfr34VgQ12ApwYUjJj2QtR+Y4rC1evzkZ8iutx252hxpCFsvqlH448t84SxfOha9XizJYuouVmxw3TPQ83ZtHuDDbRNJe+anGiWTtEzI04Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975059; c=relaxed/simple;
	bh=dQjE+RwsHInwltVRzRb4IjXTLdVMdG61NPPsKcjbQyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XACxqNZzIXTuzmQiWzZWy3IIGcK524mNzZk9vRtubgIpdzNpyXsPxlTx4U02tCPMpUNBSjvdrHFXnkdwR8UFXj9JyocKxIPgNwzUVSRVztAObGXZygsYWOxrxRhOGpicUq4MbiWSuAcnPrj8utf9ZgkZAFct2SWuwvkUJcgnEzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=djSWlXcZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lx09PRnC; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="djSWlXcZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lx09PRnC"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id BCE451D0010C;
	Wed,  9 Sep 2026 13:30:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 09 Sep 2026 13:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1788975055; x=1789061455; bh=SK
	H2OWglpoQsUvsjYnDDgxhT5TRDxhaJ+ptsB0U9zU8=; b=djSWlXcZWCseqq3uRZ
	1vLe1Z6+tELqnKd5mtle8fmFUFi51cg1RwxNQkOWHEd15OYmj8FykTfnssj1BEMK
	Rps/YOggDDzvq1+WEOeAm3NereWbT3+GYQQ78qx9Ie33U8TjOdwXMyoJyyBKjZHL
	5JU3laS8GF0bv3iYZ4KKF0ZPEDUaneKrfHKxxGAH5mTodI0tzZzvrJArp5HVQ2uZ
	Z4AZBB2P0ELazdrxoZJzzqRtjKFo3ubTH5wtc/q3Din/ZMvEVZivdUsSLbT5uuCq
	pGgRo4+AQH1PZDASg5JpEn8WYnE5WtxQ3i8Nmen/I2KJX+7HDBHbgBWDyCygA3hU
	yIqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1788975055; x=1789061455; bh=SKH2OWglpoQsUvsjYnDDgxhT5TRD
	xhaJ+ptsB0U9zU8=; b=Lx09PRnCk+Wr1q7b6l4t66YMO4wunIYC05DYWXfwUFRB
	AxV5EZ/ibXpXNWqyyAfFGC9Ol8STzw+eRnCsIVLiICd2pWkWICTvQE/IdsxnnxED
	Us2Bu4nf9wBcexhZiuFh4d1zJx7PkU8qy6CUsiBE6vt/jHkXAacJv8qtDpzlF9U7
	3eyY9m/tOjlwEpc7CZG7ttkqNU5hUgtjMO4YTRZwkbfkFz2D2/sXbNZhysH63+Uu
	EPteOD31W++xB9DMdCl+gRQeNiAUL2trKk1uhKF4Jw3nGgEVTGthaAFEmGohZR2e
	lc7yzaNPxbOuwTRWdbO43uDzHb3nrbAzZVUuXnP9Sg==
X-ME-Sender: <xms:zpehap6-Vrd7mhMYX_7sLNQ_bkvhqkNIVMgeFRd2giFOuc12I38McQ>
    <xme:zpehat16vNGSqilcFRZE80PyfX9--KfzUuF9gTooQkmtkR1ApdiS2tDyQoyGBt5uy
    jpGsNSaxCvjJ4NvH1R9CyqXzesfBf_7WdKi6S5Kg3DBU8bwGJVy70CL>
X-ME-Received: <xmr:zpehalgwTj_b6dKZ4gFOx_E7Vtu_lT8Ro7xLwq1fQbKYRB5WcigD7ugixinE7HzXgAqDmMEYkwBnrPGLOcOgpqx6ly1XP2U>
X-ME-Proxy-Cause: dmFkZTGAfwMPSlRcQ8iW76yBMFmruLeVm+OOssNsXM4ZvoYxYmHA5zdqQPN7XoFIcRTlAx
    b/g2XUayIf3ROaXl1eH+rUvmd3W+ekqD6EcFLVRpRCxE8SsalsltK9eIaAGQqPVeEcthgm
    YBI1Y1cG/GXxSobUzUJj+3JZ7VPvH35pnP9SNaiEqK/UnJnbrs44bigo5QXTH2BMoqtRP3
    rD+Qsv4K+Q4LlnVJOKjV1spwQ7dSqfNBZpccXkM2QA4SZcdHJWAmbM7qf33KJRLGpZ1zvd
    ItNLpG8QKja0qtC2x2ZMJdDYlvWdwrWVB46OmzM0bYXe+9Xa/lyr8s6Wwb0rgeJaC7TFPI
    dKEQ4vqHX8r9Xyj6QelqMTDhfA5kzVEqVy/RExnptEn8QQcIXqu9aD44JZAzJATFaAXNDm
    +yWXEF7lkHk63ZsvvgGeJoHtAN3eVe8SXwa32NV3rlgR2YRemU0dXGQWQlxxBKTI86WVm2
    2DGcOjNTBudDeUtkyKWcrIsdyAOwDS4mi0YWvvuKnH1NFnRmxxftYWN2xqt0I/mx8Ou2bn
    y8YvUjqGVhG4uXpba/AQimbb5O8AOe1sLOdr/g4yLXxsLm7wTAaToYZia5/xZnbSNfRj0/
    UolarE0CGEd0n4XGWXCVxS/2mHiG5bFhh5bNphBG2chJPxzsG55FefcSqpZA
X-ME-Proxy: <xmx:z5ehapTdjzlupdYIda-9kLzjNCRPWukZgnF7w-qCRrFrTuQ2GLbVEA>
    <xmx:z5ehan5EI3ovZEl7exjVu-kzQhlcynxCcntmc5YeT_zvzAOH2HRMmg>
    <xmx:z5ehahw1h5XfaRyqygnToQaCzNhnRbCN2126OS8qcyBwIdHToXNgOg>
    <xmx:z5ehanANZZVUPWssIQYZiKzrReVPn2fcPBRuUwk2kx9p08f6RZHvcg>
    <xmx:z5ehakK5PiCmWZSFM7VeGC_xw5NYPtnhHhIDCx1T-PLINI4YJX0phZWE>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 13:30:54 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: paul@pbarker.dev,
	Rob Herring <robh@kernel.org>,
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
	Sergey Shtylyov <sergei.shtylyov@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH net-next v4 00/10] ravb: Add gPTP support for Gen4
Date: Wed,  9 Sep 2026 19:30:17 +0200
Message-ID: <20260909173027.2201560-1-niklas.soderlund+renesas@ragnatech.se>
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

This series is the second part cleaning up how PTP timer support is
implemented on R-Car Gen4. Currently there is partial support for it in
some of the Ethernet devices that can use it, but not all.

On Gen2 and Gen3 each RAVB instance have it's own private PTP clock as
part of the RAVB register space. For this reason the PTP functionally
was implemented directly in the RAVB driver. For Gen4 however there is a
system-wide PTP clock shared by all RAVB instances, and on some Gen4
platforms with other Ethernet devices.

The RAVB Gen4 driver currently advertise PTP support to user-space, but
the support is in fact completely broken. It tries to use RAVB private
PTP clock, which do not exist on Gen4.

Further more the PTP clock behaved slightly different on Gen2 and Gen3.
These decencies have been handled by adding platform specific flags
inside the driver.

The usage of these flags have grown organically and been extended all
over the driver as it gained new features. Adding a new third set of
flags for Gen4 would be messy and add to the confusion.

Therefore patches 1/10 thru 8/10 refactors the usage of the PTP flags
into optional callbacks and untangles the usage. This allows adding Gen4
support easy as it can just implement it's own set of Gen4 specific
callbacks without altering the driver logic.

Patch 9/10 is a small DT binding addition adding an optional phandle to
link a RAVB device to the external PTP clock. Ideally this property
should be mandatory, but for backward comp ability is is made optional.
If the phandle is not set, or the PTP clock not enabled, the RAVB driver
will continue to faction as before, but no longer advertise PTP support
to user space.

Finally patch 10/10 adds the Gen4 specific PTP callbacks which allows
the driver to use the external PTP clock.

For part one of this work see [1]. The two series are independent of
each other but both are needed before a third series liking the RAVB to
the PTP clock in the platforms device tree. I will hold posting the
third series until all dependencies are merged. For this reason there is
no user of the new renesas,gptp device tree property added in this
series.

The work is tested on both Gen3 and Gen4 R-Car devices (with [1] and
appropriate DTS). I do however not have access to any Gen2 device where
the RAVB IP is wired to a MAC, so the small rework of the flags for Gen2
to callbacks have only been compiled tested. If anybody have a RZ device
where RAVB is wired and uses the Gen2 method of starting/stopping the
PTP timer together with the DMAC please test this.

1.  https://lore.kernel.org/all/20260803095232.3527111-1-niklas.soderlund+renesas@ragnatech.se/

Niklas Söderlund (10):
  net: ethernet: ravb: Remove gPTP control from WoL setup and restore
  net: ethernet: ravb: Move programming of gPTP timer interval
  net: ethernet: ravb: Simplify gPTP start and stop
  net: ethernet: ravb: Remove redundant argument to ravb_ptp_init()
  net: ethernet: ravb: Propagate error from ptp_clock_register()
  net: ethernet: ravb: Replace gPTP flags with callbacks
  net: ethernet: ravb: Add callback for gPTP probe
  net: ethernet: ravb: Add callback for gPTP clock index
  dt-bindings: net: renesas,etheravb: Add optional gPTP phandle for Gen4
  net: ethernet: ravb: Add gPTP support for Gen4

 .../bindings/net/renesas,etheravb.yaml        |  11 +
 drivers/net/ethernet/renesas/ravb.h           |  35 ++-
 drivers/net/ethernet/renesas/ravb_main.c      | 252 ++++++++++++------
 drivers/net/ethernet/renesas/ravb_ptp.c       |  38 +--
 4 files changed, 229 insertions(+), 107 deletions(-)

-- 
2.55.0

