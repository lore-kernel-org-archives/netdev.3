Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390783;
	b=vAL3oAaiEkP/BcqUxa+uGN/xj+OjTQsxYC45l9XB3RywzSJR2vLgiW9B1qPwbjs6eZ02
	 Ok+fDmQnnEsrxRXbU0KL/dSmh0RFyWswZaJFxXOjpwO9QES6EHjO0LaEr8+bfnbW/xhS8
	 JDuMQFfz1wv21ONnCI4qqkobwQ8sFPb8mEitrIaY/it6KwA2jI9YGio2mJ+GSjccsx5ue
	 D/UyZqDkg3GuF36cdSKf3NzIxhGcJDsBXfD/1S3mzktabN5wKuYRhg9ezb9EiCh+WwTZN
	 nnul4M8/qJgc1R6ziVitc9eJP8VGNandWcPTKyTVAy9lCXJ1KELp3Eec5K6fuL4c/DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390783;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dosgcgtYnwjGfg33mXVJN1zPstrhDPbH2LgaYc37HQ4=;
	b=Nc2Xwm9UMn5bmxEKQYMn/vhsKuvpUddCSUGxH81o0FhnNPmKQ26Erx1H3CLMeJpDi/1T
	 wOUpJqsmvD/soQH51VAaZJ+vMp3DMKnO7mDDGMDvWltTxmSZMKuEOmwVTaadDtJsBICRX
	 DsXzr4ZK6td6bqJO9c+mLdGg3cITRApcoFFFETRzdXkwDclgqAz9i1DBymavXcRLcpEJO
	 PT/tC9AwrvBkyrtPgIFkGya2xUtoqhZFLtWf7CKRTiv/64SCaeOzKykuQvWedDIwP7Dcn
	 tM1NTqXeUSvN+f1HH/V3+JMPSInjJOYyZslhsGjoZlrtTrJaj4EHQ4H5b8O5kme8U+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BA0j1gTn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFF560A2615;
	Wed, 11 Nov 2026 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BA0j1gTn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D791F00A06;
	Wed, 11 Nov 2026 09:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794390783;
	bh=dosgcgtYnwjGfg33mXVJN1zPstrhDPbH2LgaYc37HQ4=;
	h=From:To:Cc:Subject:Date;
	b=BA0j1gTn9JckxqLcIm6KxVmr7UL/nxUDp1DN3aVZ3IpISTEjfDkYWKmJj4RVTXfON
	 p1GhjTKkKofZMBNnhijiFHs4vMHgtIwmuMQn9bFur59fY8CF9ytpMJgOVhaFKEyeMt
	 scBaMAMCPX9SxY1eLoR3UBIkWCsjD6wCQ+6UqUGSfZvTAoY/RWRplmCUsdjHy9KJMO
	 NBIcMa7lwuu8GX2y7LvSXeppn5Fj4f+hdq+6SfFkX5dvQpEI3fkJBoH0yJKZd3Ur+b
	 US2yGSDHa8jXeC2RTdvNAOsF23N/2DWGzqUBlZRKoQvAf1YKXGOOguW90Tc+Q0uDps
	 MQN9hTLe1Uzqw==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: sgi: ioc3-eth: two changes for the IOC3 on SGI IP35 machines
Date: Wed, 11 Nov 2026 10:51:36 +0100
Message-ID: <20261111095138.1757-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the IP35 support series [1] posted, these two changes let ioc3-eth
drive the IOC3 of the SGI Fuel, which sits behind an XBridge and has no
MAC PROM.

Patch 1 applies the DMA attributes and the RX barrier's upper address
bits only to 64-bit direct-mapped addresses, so the IOC3 can use a
bridge's 32-bit direct window. Patch 2 asks
eth_platform_get_mac_address() when the 1-wire MAC PROM read fails,
and uses a random address once deferred probing gives up.

Both were posted as 25/53 and 38/53 of the IP35 series v2 [1] and are
reposted on their own for net-next, as Jakub asked [2]. The rest of that
series puts an IOC3 behind an XBridge or PIC on the 32-bit window and
supplies the MAC address from the L1 system controller. There is no
build dependency in either direction, and IOC3 Ethernet on IP35 machines
needs both sides.

Tested on an SGI Fuel.

[1] https://lore.kernel.org/all/cover.1791890466.git.kaloz@kernel.org/
[2] https://lore.kernel.org/all/20261021073921.07632a37@kernel.org/

Imre Kaloz (2):
  net: sgi: ioc3-eth: apply the DMA attributes only to 64-bit addresses
  net: sgi: ioc3-eth: fall back to the platform MAC address

 drivers/net/ethernet/sgi/ioc3-eth.c | 43 ++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 7 deletions(-)


base-commit: 97ced2c090bfc2156db31fca9f52cf253e4bc186
-- 
2.47.3

