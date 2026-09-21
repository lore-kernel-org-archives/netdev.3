Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA4B4B0CA3;
	Mon, 21 Sep 2026 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013066; cv=none; b=j7j/h66DJxJMv/uvzVU9S0vtMEsMdYXjgoN//3eY49aFXYyTlorIGuel9cNunfIJeCte6yU+Dgk8Br5LZa7kF2ni3oK3dZ7EuW3DEFyCr0vSyCXBrzjYO0RD88mj6FYjK2NoRpoYf4r4btL3Yfk1ys9TNDqY179qPbMl01U1awo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013066; c=relaxed/simple;
	bh=kk89AyaRmMooqVzsTR/8r4GXGWHwMSHjz9YHDZNwZiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cTE3JQrlqXSjvSR9MaF+wW9YCyWwIcq280BlppOglKml9vllTdz4PUn78udXSzvKJsr218Al2yy/InlDBivNlywSm08C0G1g6y6LH48HlwXbAApL9ruvq3cUMpDxDnfHQzJrH+uhXlqaaWV913VEdxEYWDbYiB1MlStif3cz1FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=MgJ8CYJy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eJ0ZralK; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="MgJ8CYJy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eJ0ZralK"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 77B031D000C9;
	Mon, 21 Sep 2026 13:51:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 21 Sep 2026 13:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1790013060; x=1790099460; bh=AZ
	SWgVi8KR9ykiB37v/aXW4EFkKJeHtb/urRd614hYY=; b=MgJ8CYJyeS4sSiEVxc
	FFVqnMb8Ielj4UCunezjX/837E6i2iHw2fB0a9NsGQicSvl1xswFKKk1RF6vxGF4
	4sVPz+liBJDTC+9TuYLCrcyCZ3H4QmKf2eyv6a3vcqTS1/8guZJ3BGdXmo4g93/g
	hLsJz/z7kRSwBX1BsGXzxHYCd3vwrI6PGQRc0I4H+VuVl9oF3sQglEdqIy/NueD0
	9AQJJZiuJU7SkaOCkadjmI//WoCCu+Xx8f+jofp9BSaco7QjVMWFsWjfUVru7V0D
	73RWm2+lL2KAuOIZFMh4IGUYo6IZLCufZvmLDqB0Pe9fRUmQBEzQUExloZhhSBnt
	G8YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1790013060; x=1790099460; bh=AZSWgVi8KR9ykiB37v/aXW4EFkKJ
	eHtb/urRd614hYY=; b=eJ0ZralKovwaa3h8gL/zTkgeoZevdVk3WSV2YNetovxZ
	LT4loeLJyYpBTN16Wnf+RNOJDERpCcqH1baej5o3qoe/fgy03Ueo45J6hMz5onpT
	yJLHvdLeUHexQOdEtt8qY25OUcx6hDxOMayiCHULCXY+JvkzXop3Iqa+rMHGY0Hp
	Q/vzwB3thKdoxQhit1sXy4maxTnsZVt70Be1e640f3jsDkXxmqiBJw+cHcm6/Vb3
	qXABhkKW8VKzZKXEz/H2fMju6RFF0G3FoHNTRI5sOMgvWntUAj0wiYE9yZ6VgW3w
	BJVCHPLNTdUjhdsc2YmG+Id5FrAC2A2aK2mniQ0L7A==
X-ME-Sender: <xms:g26xaowbK4knmPTMN6_46IwYdoIw50KPNNm7qzG419MiQAJAON8GyQ>
    <xme:g26xajPgDQQw-R1lAX2DryaqcOWtrigIDA1MwuSy2TDlYujFz2FZdEJuwrXA7DVnw
    -YEqqqnOfbSdHeYs2Hy8kt4JCwbjkQ7fnMAGDmke2vSg2L-xMY5Qswk>
X-ME-Received: <xmr:g26xavaZScyEuKbsGKcgE_0ALDmI-M7IRctY8MocrEfDDrJOrTHQ-00Z6fBx8-paOkvVdxuIBWYgCOK6pR06_JkuwiI1eg0>
X-ME-Proxy-Cause: dmFkZTGemg6ZCdKxxSzX3bAG22iakyM/hAJskJfP834DoqUiUjpTx6tfqGTcT+xy4dGjr2
    pCU6ah8QHf3YAwc8eN3DExyk02MNzHFl8hbLYE5y6URO3yAQrMwKu6fN2TmbdDbkCQNeTU
    zqEZzhS7JgHhfLMTPibIRCCGB0BxJfipo6Q4xnt3qDmh0kNPptK2It9v/oEBwsH2+h+Gmi
    rLSqJhJyaacDkGuMWtdU+Rgkwx3c7j335w7srw7xLUZYDgBzKbKQE+YVSS4Z1j3QgI2LEp
    TC5XSfAljbdfpj+OkOmgQrOrwkNa4xawJtM5lueDOBLStPQQ+8r/WHHjIOUp3CDSYyVtfk
    /qPNUlhY7yk1oyQ3iO2mmH2r8iVdzrFoZ5kqA9ziF9PYt15wjwY7xwN4rxcA/TPtwaNFY9
    O8LKmAjmTpyBYLnprdSre/zFqrp0P3jko2vnTckjYHpAsiQ1MndLlDFyYn+ce2KQIzScb3
    uIG7pQp/t4ovM9Ozbx8+3cbPzqYzjsKHIRoQ+wCiCqvq8RBAX46O56JYZXIJfbjwdd4Tjf
    kHawOWNze1nCsVQ7kKyWrNYoL357PW3nBifZL+WCPyyvdMUDPhPdmCdDTrqK7wrkIhn4QA
    D8nJuN/z9XJA7S8GUEvWnAjFu9JfLh7rVCC5547XYRGeXJurdn810i/SCy4A
X-ME-Proxy: <xmx:g26xatrJJ4Pr3AKUXAuX-jLhED9p9Yv1dMfaumUQrE9eolrsxJvivA>
    <xmx:g26xakzCodLUO3WYfbcvAFMYTBP4own5YK01iK0nMJNiPZjcEpO0gg>
    <xmx:g26xatLZUYZAxvipKmE97jj_IDwB6jPvXY0n9reISNgajGS0IMs2fA>
    <xmx:g26xau6ycNcgRsXDdWTBtVEUbVkK5Yi7yh2Hcw4kQF_FWx6sOX5QFA>
    <xmx:hG6xauhrYzxG2m0DO1i1eWoFDx0KPvzrYiJJC4lIsYditcylFHHegO3L>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 13:50:58 -0400 (EDT)
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
Subject: [PATCH net-next v5 00/10] ravb: Add gPTP support for Gen4
Date: Mon, 21 Sep 2026 19:50:27 +0200
Message-ID: <20260921175037.4084310-1-niklas.soderlund+renesas@ragnatech.se>
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

1.  
    https://lore.kernel.org/all/20260803095232.3527111-1-niklas.soderlund+renesas@ragnatech.se/

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
 drivers/net/ethernet/renesas/ravb_main.c      | 253 ++++++++++++------
 drivers/net/ethernet/renesas/ravb_ptp.c       |  38 +--
 4 files changed, 231 insertions(+), 106 deletions(-)

-- 
2.55.0

