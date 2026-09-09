Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B37D52B1FF;
	Wed,  9 Sep 2026 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963084; cv=none; b=ZYVc4bNaGpaKUC9Y0IJHa+r/j4Y3PTO02jeKpXsx351CUUaU9CgHRTJm5ZuflrUbn3U6GQC2V3tbZT9cHl5+GW8qcuF/JhchZTbcuxEI5M7ZISWKzsg7Dqd+jNX33ZRoLV6Ek76P0bXzJcvtq8vVLWsGIAgnQRu06b71gwonJtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963084; c=relaxed/simple;
	bh=em9lEzcQ17j77nlA5ULbhP+JQpXBNU+/2cH/TEM6/vM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=icESTv3TMAN1wux9dFfSUSBFbE5HML5WkhiG+rFX+t+T6iA2BN0t0+zVLo7JelQD3LF9BEuFQXCMWSVdj54zGp1H1m8ezK4yFU4x36uHXaFvtjXSN5da/bOyTpOaGnJKCzLxFFsHj0vDZxdFKYLgHmVzFLGjQLQAyRHD3CggL2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=pass smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=V0Bl0Pyn; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="V0Bl0Pyn"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2E5023F4CFF;
	Wed,  9 Sep 2026 16:03:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1788962643; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=xLi0wt5EgiuhG354z8EC8PK2vbC5Ize9fBnpPsOtAkc=;
	b=V0Bl0Pynw325ad30OOqtsTgd1yy+X9jSaAEch0YTYZ+H/IqpjOLcVkvGjn5vlvzjYG0Twp
	322UmHarUlALPu8E3kVfVPMrfbyAIpKBxegkb/jPhDalfwID+SMImaFC/aJVgrDK90qb+z
	MgNZYpZ1DJmU44bxby8v0DBpww2hinmM2ilAy2ToniI7xCSqS/L4TwjKMXN3TVep1s4L+l
	hw8IBhFHsTVVXmywRbcr4bKY8QTSu/wiD0w8QiE1RYBPE4Y2OnZROBSSgDAva18/149yAc
	HESXKlEaH4dpQ3puhNxjqTaPcmvM4fMwBpMelP4SL9UtDBKFAV6hM5AYL+h80w==
From: Caleb James DeLisle <cjd@cjdns.fr>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	chester.a.unal@arinc9.com,
	daniel@makrotopia.org,
	linux@armlinux.org.uk,
	arinc.unal@arinc9.com,
	Landen.Chao@mediatek.com,
	dqfext@gmail.com,
	sean.wang@mediatek.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	naseefkm@gmail.com,
	b.larsson@gmx.com,
	Caleb James DeLisle <cjd@cjdns.fr>
Subject: [PATCH net-next 0/7] net: dsa: mt7530: support EcoNet EN751221
Date: Wed,  9 Sep 2026 14:03:39 +0000
Message-Id: <20260909140346.2861572-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The EcoNet EN751221 has a unique switch configuration. Every chip made
with an EN751221 die has at least one on-die MT7530 that is MMIO based.
This switch has 3x 10/100 ports and 1x gigabit port.

Some popular chip packages such as the EN7513G and EN7526G have another
MT7530 implemented as a multi-chip-module that connects to port 5 of
the on-die switch and is controlled via the MDIO controller integrated
in the on-die MT7530.

In this configurations, the upstream switch is put into a "passthrough"
mode in which all traffic is forwarded between port 5 and port 6
without altering its DSA tags.

Furthermore, since the DSA core does not call mt753x_setup until all
switches are present, and the downstream switch only becomes available
when the upstream switch has configured its MDIO controller, the MDIO
controller setup on MMIO implementations must be done before
mt753x_setup, or else it will never complete.

Finally, the on-die switch and the MCM switch connect via a TRGMII link
which requires calibration. In order to calibrate this, PLL adjustment
must be possible on the on-die switch, necessitating changes to the
core_(set|clear|write|rmw) functions to support MMIO implementations.

Solve all of these issues, add the TRGMII calibration, and add support
for both switches.

Since this patchset will probably be subject to some discussion, please
consider accepting any patches that are non-controversial since it will
make future re-submissions easier.

Thanks!

Caleb James DeLisle (7):
  net: dsa: mt7530: get ctrl phy addr using a function
  dt-bindings: net: dsa: mediatek,mt7530: add passthrough mode
  net: dsa: mediatek: add support for passthrough mode
  net: dsa: mediatek: support PLL setup on MMIO MT7530
  net: dsa: mediatek: support MDIO switch downstream of MMIO switch
  dt-bindings: net: dsa: mediatek,mt7530: add econet,en751221
  net: dsa: mediatek: support EN751221 switch

 .../bindings/net/dsa/mediatek,mt7530.yaml     |  50 +-
 drivers/net/dsa/mt7530-mdio.c                 |   1 +
 drivers/net/dsa/mt7530-mmio.c                 |   8 +-
 drivers/net/dsa/mt7530.c                      | 575 ++++++++++++++++--
 drivers/net/dsa/mt7530.h                      |  46 +-
 5 files changed, 628 insertions(+), 52 deletions(-)

-- 
2.39.5

