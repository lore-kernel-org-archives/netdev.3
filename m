Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561C7283CB1;
	Fri, 13 Mar 2026 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773393689; cv=none; b=RDqFslDRyPPbSzqxigfODuvwgvZwlK6zIvCfJw8p0uYqX5gllsoMQWplctyMqqF6V0CKWe5rUFewy2qRHXpD4YI9fKVkSMrDZjVLftbcPp5KxG3EHBP/pwCDYORBFtks4DtzWzXo888sFeXLOQyQaUwgqQaMMg73j/S+/qu2750=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773393689; c=relaxed/simple;
	bh=Wxb2u96KoePw869ffsam6tjeZ/4nyHjobdEGPPgNXFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=exZpMA2LzQV3DfJfcyiUEb2ixVWapbLtTODn29Mw7iB6cbhQ87/adroICAygxPIkCZ5APCn0HdI+tSfwCgJL3kn0292HOQ1i2R2zHgDGMXdorijaSoagGZdN6avIuvyeylO16gg8vjoyovdEndDCV2RKz6XdstOnu7fc66it250=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=pfE7c0x7; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="pfE7c0x7"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A6F2CA20FA;
	Fri, 13 Mar 2026 10:21:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773393678; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=vXxZA4KpuJLnz7J4K96OCL4loTIcUeOjHbr5+Mu7vUI=;
	b=pfE7c0x7HO3gko7HTczZ6nfoac53imLjtIn7X51nix1q5itSGglrP0Rz6meDu9E/rIRljQ
	ilhMRtB4X/5cA/c1RlLrBkXKAOdiPBGGswxnqerx7pEKUwFIyjR0YlvYvRqGG+gw5Lx2Gv
	kpNG587mLNFI2nDPTQ0j6wY9P2CsC3Q6SFNADkgSi2cg+v0+d8HKnZ0jiL7KOpGhsVH405
	qJcFhUion5siNHR3X2n9K/8bsGHJqo0lc6c1A1zuQWn5rkFIVunbcU5eIwMgHlVH2QU5CZ
	qgZYcpj6VMx5FsB9WMcV8HcbGWylXzU/h5+5r6t8BRrt8pxXuf9rqnWsb3w9bA==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	=?UTF-8?q?Markus=20Bl=C3=B6chl?= <mbloch@rooftopnetworks.de>,
	Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next 0/6] net: bcmgenet: add XDP support
Date: Fri, 13 Mar 2026 10:20:55 +0100
Message-ID: <20260313092101.1344954-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add XDP support to the bcmgenet driver, covering XDP_PASS, XDP_DROP,
XDP_TX, XDP_REDIRECT, and ndo_xdp_xmit.

The first patch converts the RX path from the existing kmalloc-based
allocation to page_pool, which is a prerequisite for XDP. The remaining
patches incrementally add XDP functionality and per-action statistics.

Tested on Raspberry Pi CM4 (BCM2711, bcmgenet, 1Gbps link):
- XDP_PASS: 943 Mbit/s TX, 935 Mbit/s RX (no regression vs baseline)
- XDP_PASS latency: 0.164ms avg, 0% packet loss
- XDP_DROP: all inbound traffic blocked as expected
- XDP_TX: TX counter increments (packet reflection working)
- Link flap with XDP attached: no errors
- Program swap under iperf3 load: no errors

Nicolai Buchwitz (6):
  net: bcmgenet: convert RX path to page_pool
  net: bcmgenet: register xdp_rxq_info for each RX ring
  net: bcmgenet: add basic XDP support (PASS/DROP)
  net: bcmgenet: add XDP_TX support
  net: bcmgenet: add XDP_REDIRECT and ndo_xdp_xmit support
  net: bcmgenet: add XDP statistics counters

 drivers/net/ethernet/broadcom/Kconfig         |   1 +
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 484 +++++++++++++++---
 .../net/ethernet/broadcom/genet/bcmgenet.h    |  17 +
 3 files changed, 425 insertions(+), 77 deletions(-)

-- 
2.51.0

