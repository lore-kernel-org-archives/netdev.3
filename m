Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD3D3822BB;
	Wed,  2 Sep 2026 08:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338840; cv=none; b=fc3qqy4lTFajWDzRaVcyOQN5mxxRh1OnkI2DX0E97gYvb0xoza7+TGzFP2SAWPNspLP06DP1CmQ/hA4IGtGx7Pq4+kYRnjZ85yzaBqoOSBX4g3BNZn7vFbDR/88TH2j8rW0nokCqmOybN8w5p1FvE3SQ96HWbHXed5k8IxXvxnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338840; c=relaxed/simple;
	bh=jXt64wKgSMZ86ZURBwrhsjeEPSALi0zPSzDSWoqGIlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BQ1kcp8NmCAOY+jsjKQGv+FNxUGi1jkI5VBgHVvT/+AZiiHAB5U4rEUWN9+oyEM820gbk7Tbe32zSzfmx4QN5hlhmY932jX6bc1zEQ13oPRtzxqTq2UdIPXiqD/AxK3eADloum1l+5Kq/6cmGN8XgN5kPh947JAVS8MRQI03/j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=lGrZGk+l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PqK2ysBY; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="lGrZGk+l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PqK2ysBY"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 904C514000F0;
	Wed,  2 Sep 2026 04:47:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 02 Sep 2026 04:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1788338837; x=1788425237; bh=m4
	+ccpfkRN1PlU7b/aa3wVZ/lRQs9FP3U1GS23Jonb8=; b=lGrZGk+l889bOzOTzT
	wjERMR0ui0gMKp2iyDfGAFYWqeVtwtf6GJEdkRuxSUJ5OetQPL3++geeV2QEuE02
	OkfZ6vfsygC0GEniu/u/qteBu4b3hjULgUdTGrGk7gSweYDOrHy/I+aNwCJitrlU
	ShsjrHNnaCJrVUcj/tGTFEd6Wb7oBxE/74JWn9t1/95kCGZDwlq2hIcKjdIi9L7W
	f+aAl2aCMcFpztRxSzQ95yopw2dbULUCjTZJ8/yPhAW9UFv+RwMr0pqqJfFFpawI
	Y6XOgZA9swlr+7QP5NBlNBS5lknJ+ZS44ruF2PtyZ1wwEwIXRLPR8iKzvZH2w3nV
	oY+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1788338837; x=1788425237; bh=m4+ccpfkRN1PlU7b/aa3wVZ/lRQs
	9FP3U1GS23Jonb8=; b=PqK2ysBYdDbWx5e9MX4l4zXMdDYBkrS+78cczvHagvR/
	tq9PvHdALCmIO5z/d8dW8tIBN2YaKbBCcd2IwRGdtx1KsOa+WNLjbW+Pxycqwe+x
	6QjD/a4I3PBYdz732KwjbfaNSvBAGKoKyVBzDULkyxLpgouJdl3MzOYPlNe5cijQ
	AwRlkv+01+KisdB4C4shosZslQFysTkG1b6Qxl8G5Jo+lgxKXXUPDy0oYBgmtDpm
	QUjjjVD7XelgZhLrv9Gv95dy4cvPsF6zvzUvPwirEDc9ElpUv+ygy5y9zIcU59LP
	oPIuq/HH1vxo8/6BDxDLPFcfRkZkpzrn/qj3jq00CA==
X-ME-Sender: <xms:leKXaspYE6YvoRappB67x_O3qocNPgZ0ev9je8GcMKCH8LHqlWGyww>
    <xme:leKXaoJp2WjcAO3evTwGnoc8TqWkhrpeFT_7c5jyq14k6-RdYiIhQugHW5zP1brlR
    maDt_wtQLRueKuQu5WoK6O8Lt4wr8sDoyaaX1x-hShCy9mnch6yDT-z>
X-ME-Received: <xmr:leKXaphPT1vX5KhMM-9muTabf2nNJ2JoznzSSoRSIaHRFP9pV7CSurRElLh-Ju1hHZR73ZqzqD3xsAB38bKoWYQwwz_dDMM>
X-ME-Proxy-Cause: dmFkZTFzDl9M6rl1j/5qy4MnWqNuD/F5Jlgenm+wc8bWAbbR2mwc6fKkjguZKqkvQo8Mf4
    aBxJQjklxo2dycdA9QCCGMVlO3bMvv47KVR/AHTgYZ4j0hFYMr+TS9IP6qaBF63VKGhxL4
    kIODmr0QPRKtGb68gOoP1ZPz7nhp9nsQN41w5PkBDvCrNAbJCSz9ZsvC8wVzRSqduBiLQ1
    pA5Jwh6ZsHz6qNPAI9+C2FkmFMb/nC3qqWVaNnojSgyMuSDaW4rBho22KYSnP4BTm7Ews8
    DEwjgdVhbwpH1atfDCxSXHjaQjbVb6Q1N/R7cLXUCaffFMY+N2i1RrELwTCON0FRoVl8b4
    rnJ8HAX7n/3fYm5S4o14QHniyMbb6yNKFBz9ZeDBYE1S/QU+pGe8TNdNiDivhOGX1RIzkD
    92tZrG8qUKhbgRbzj4NUcg0YzSay/NnctyFs7c6yMF1eSBcghNEi9C3SSqxHZRUsrJcA3Z
    aFC2IX4kQsfGARyBoLLf/8QrDft4e+5uqnfbj7xXDD4sQyEzmKgcCjfXhfDmsJG928kI4K
    2gHlepG93gqNHkZ+4sCM4qEHRX4p5gFgIX8we2fijjJMTzbvCMRHMDEg65wGROxQcvcQkT
    33YWJyo3QQcQ96T7AMuQ0lLMa1EL1m7g5cnGVgUeMeiyJBgJPtNrLDE6Fu6A
X-ME-Proxy: <xmx:leKXah8zHu4Uueh1JBhuNZCcAC54pzTgfjzNmMNHhr7wruVJXVdQXw>
    <xmx:leKXatpUVIu2FBWdBpWJCgFxKf0gf4sOdNv2j5I8071NpDhD8J4bYg>
    <xmx:leKXamMGwnHQhoB3N61y2IGyLHlYZf7iUqvGAic-UwBG6G_-zcb3JQ>
    <xmx:leKXar4HgZPhiHe9MnkE_Ugr6Wi8IHUAZmcaRn7II3k_zNds2R_lCg>
    <xmx:leKXanfjNT7psNmlYw8JN82ZaUGFGgEW8VznGmE8MdhdzfmZrIavAx4->
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 04:47:16 -0400 (EDT)
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
	Sergey Shtylyov <sergei.shtylyov@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH net-next v3 00/10] ravb: Add gPTP support for Gen4
Date: Wed,  2 Sep 2026 10:46:53 +0200
Message-ID: <20260902084703.3228504-1-niklas.soderlund+renesas@ragnatech.se>
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
 drivers/net/ethernet/renesas/ravb_main.c      | 249 ++++++++++++------
 drivers/net/ethernet/renesas/ravb_ptp.c       |  36 +--
 4 files changed, 224 insertions(+), 107 deletions(-)

-- 
2.55.0

