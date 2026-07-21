Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B921F12E0;
	Tue, 21 Jul 2026 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784640651; cv=none; b=XIPqNyJUZyMt3/nrAI/x5mYYpyiE1csv5aewEY4yyzFIfW+jErsgQ0OqA1uODM137xdTW07G3aDApy5ZR2nF49x+D2GbOavf6yGF12ErFDrbhrtCthPmMpa8UOnLtnN7ZzDsYDzedL3pCsCuDHi/2aTKIaVuuZRnXYWYXWpbK+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784640651; c=relaxed/simple;
	bh=PQ8ebD61+c5OLJpuj87jWP9f182aPDCi3aavkR1n4RY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=saQoMU+5nlo1I+8PlvSaQOFE4Ubc12uhG9C3pbLQXej9UYy09fXd02fUsqfRSJTr5+LjpvKhS7YCAbelqK4EhKhcOX7+c46eFAGy9DSG5MdzUFMxwj1rPSm0PFoVGBy7QyOrKkQMqhzMGD2h63wQD/SFf12qHT+D6IgQhJbHCgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=1FrfPNvK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZGpSIyDo; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="1FrfPNvK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZGpSIyDo"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D1582EC0070;
	Tue, 21 Jul 2026 09:30:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 21 Jul 2026 09:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1784640647; x=1784727047; bh=5a
	YFBkyrYly6Ddvg3yeIwGjX2vJqdqTGlopKOy8rO64=; b=1FrfPNvKvQDOHhbypM
	M5DBiPADFU9zse6obrdpwspxOOcqrEqbuMQNHca4XnnRMBdAqqZG/fgyl2au+cyU
	O46NGXrmJog66nvA02/S/Tq1uFSWV5eNEU5X6IB9eZ/vaeDrBT+sgEYDvAJGv5dl
	eOiDC9o+FgiuzhsLsjtXUiC3NYXPXByEl0d7bZPwjDavhlNS0snCg9gajQ1efTzj
	R0W3ABBdLbYCOfzQGMVCUZC7ywunobrVkrYsdUy5o8a+71qUBODz6hVRTFfTOVfb
	M2hvRUMCucBdJR3D0c5T3SW14aesY6YcrVPjgmAE+ssLcxoEjZXcBqAPsUzoH+xk
	DNqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1784640647; x=1784727047; bh=5aYFBkyrYly6Ddvg3yeIwGjX2vJq
	dqTGlopKOy8rO64=; b=ZGpSIyDo1tjGEdnIhTjWjRZOKBGWUaIUUqCJfF9P1WNI
	ukhvqnjLsTQbGXN90ZkMLndMEDNGis55sQTTd71QuLRGmyweUnrSd4+RsSqwNn/j
	Fti4FUo+Dhokdww3EjG0k5jAyyDrbas+wMcE1ffk2Tp2hObsfiFU7acyhLRCx7vz
	jAfT6yadBT0m+catPHmbKgN7Ba4AFZmjKYftqYIrHo+V17++VJS6Bf/a5S2GBTyd
	BrFA6xycNFoD7COqL91DBw9ZNdmOVPyb0hN7q/ljEmSNBN1v/HVlfpa5eKoDV840
	nepqUAskwfxt7/HqW0luXgxXI6ft3OsmcajSbGUF/g==
X-ME-Sender: <xms:h3RfajpL02SnW2qgKcCl63BSf8WO732Mr5XNbn_F8CsSU9qqtj5QTA>
    <xme:h3RfahzG-iJONT_FtMPQVmGin9nuI7RIdRCpTiR-Ms3WqHpyx2jE4yYpAjfroSE2P
    ECxHaBgMVSBViF58OvyFMhcQSapY9ZtUaxrJOUBkpo7_JCPJ7i4oBw>
X-ME-Received: <xmr:h3RfatNA2GX72Z24e5b7SlhymwFy8bjtgCM5vxBFmdDMPgFaSLrdHib9LQQS8fzYH7BjRCU-JDFWN7oPqnI7ZvacrclhYmg>
X-ME-Proxy-Cause: dmFkZTEox4neDqmGLXDYman1kOJ8lVHIUwaEKpvcxcTM5+G6LcooCfbJhmob/lZ8OaTgAD
    uD/UptFMQ1hiG/uAe8xFbKB90RiCUwjrkxIk/R2RbNuX7KjSwBPL3jeoR5xcsh2UxoUF87
    Fks7uCeYveq51iGxN5fuc1GF7JdkLDtJgf4ZuAwzPkHFzbrb3pTZgxAT3SkQQLjF68lSoH
    qO7tRbVCJ8LYf8LRdeTo+nGV/mNiliYT8hGk6r7ypT41V40eDQaewRE9WQ5hS1Rr6ByrUx
    4mTf0/82EQChPdPkZq3M6G3+6KLFKQB1NdIJVRVK38TMHlsr8r3GNSAYZWZyxgKf95WUQb
    Uv5qXvg9//KuodO0z9gyT6ocYFmzbpUNpVdSveq/eVNgcKtWMLKvNaM5fPJRsyC8Mfzh1q
    ybtPZaiN80i/vNYWa9AzXJ075tw79/d6SQqDs5GJV0LTLkxjozf3kzFXTv9Ja/qehGKOQw
    x3qLbxFEVeUUmewfmEzKGQ/O3mG5JrY0iyXSRaoLsI/79MPuL29cOojS6NKsoQRJcK4q8p
    WjDML33qjefTBWhb6dSPyq2bWrG7xQwQlM714l1ylFLPKuhP0Gu8oxClHX29Y8/UwwNfdE
    aGYNBWQj1kYvwoy4U39iiqAJzxrfOBuxjvRDf3vqIz1Y3gtaPUpth+Kv7yPg
X-ME-Proxy: <xmx:h3RfahfItia_0x-TK0VEACP2Tnmu_sTG4Mdq_pbjyOWBmlxxwNa6Cg>
    <xmx:h3Rfap60cT1NUBAVeg7SeNBfnYjrp73oCFbApCIo1sjnsGVvyUdwIQ>
    <xmx:h3RfahKOF-SMSJFF_lvecMQtnziAPMtGMhzLzYpCIBxeGaujWw8wOA>
    <xmx:h3Rfal5FbHkKFQbKWYluxkH6WkcKLb3ZeHXu313ZlAyY79xdIIx-3A>
    <xmx:h3Rfak69SFUZTsMQn7Qynx9a7rZ0E-lu0t5urKi5XVRghcxDpDeXgDsY>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 09:30:46 -0400 (EDT)
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
Subject: [PATCH net-next v5 0/3] ptp: Add driver for R-Car Gen4
Date: Tue, 21 Jul 2026 15:29:33 +0200
Message-ID: <20260721132936.1331318-1-niklas.soderlund+renesas@ragnatech.se>
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

