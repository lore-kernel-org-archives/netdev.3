Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.135.140.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299347;
	b=FEwk7sl0uJpjD1Zr13LpQWP39oXD5559FVRYLWK3MKPHYJnodaQseFGcx+jV5HXzudZz
	 MW06ydlqYbZkucCp4UJKQzHwuqz4/EG/rWrVnEWz7Id4cAT7GvGAE/uoTkM9B1yjWpXGU
	 XPiDGbtK8DN18HlezZASsq5m+f+u2DiakUR0ed4iSFCgdMZDr/rt6LG+giFv2f2g+8fJd
	 azLUuOviwDltJ9z+gFNDRrCO4jENGZ2qBG/BJapfg1/h9Wi9daLNZeLTBol+dbrbk+DPC
	 JX2QPkFJsDFFgzYT8PwQpOt57rsMQJKD6iCpfOp5GuxqnlYX9Bq1a8TJAL2csccF+GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299347;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-Id:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=og4tBGqFvRDzJbCD/irW7S0M6xxL79ugE1pS6Vzr5B8=;
	b=cnjURNwEkz47MtDmIqv/sLpxaRnwOQw5xcL8p9cx6YLqvi6fwsKPvbNoj3/nrFSCe145
	 EYduAOCpQef2dcOrUGNnV68HX+RWMcRgHqHs9ELlLgRt4dxybed14ONk/HX7aOe1MaytC
	 sGmpfEIcVpRH9Im/eBWaRrlvbx9cVj8Mz+WtTcok4Lir9RavqOFazo9sAkEBbZQcDAFTG
	 XxvH0FCvh8f2B75RwQ7e3MD8xlVud4H6wmnDRSUAfGXoX9lHdPGAKV0zmjJRJ3zq1twxU
	 dC2R7F4m5VpK/b0xLTnLVcou45zp5h0koPhbvjz2m43IK5PHWyr6SW8jSZoCqZ4HBbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cjdns.fr;
	spf=pass smtp.mailfrom=cjdns.fr;
	dkim=pass header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=iTQWdFyG;
	arc=none smtp.remote-ip=5.135.140.105
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18594606A31A;
	Thu, 29 Oct 2026 18:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18594606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=iTQWdFyG
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9C31E1AA48F;
	Thu, 29 Oct 2026 19:42:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1793299336; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=og4tBGqFvRDzJbCD/irW7S0M6xxL79ugE1pS6Vzr5B8=;
	b=iTQWdFyGso2A5Zj5jV1SBQjLPhnldAOYaYW7VCXyDd9PRckEcLZIBfCiF4TrrOySewpE8T
	B0lkTzKfOnEi2BJHc7atPq3z3ouszD9sxPF/BqTFkBALdqzfKBuHprR7yEhZ2ZNX/l4nCc
	6RTh9xldedGxxIzfSCRFrI7vxWHTc7mRKz/sb4IkpU7mttlnLnUr36BQ5I3HqY1RetUd10
	qPyQh7tjHQLDIiheY3vkjSaDLN259+AlihRAD07D+26g+Pmtfs92pIuYOZG76x6JKrqJE2
	ruCH2UgviulIPx6PTtNf71OY1qRl91jaW6MIGKzd6hiwIdN8WJ50EepT1YOfpg==
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
Subject: [PATCH v4 0/7] net: dsa: mt7530: support EcoNet EN751221
Date: Thu, 29 Oct 2026 18:41:55 +0000
Message-Id: <20261029184202.1859843-1-cjd@cjdns.fr>
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

Changes since v3:
* Fix "econet,en751221-gswitch" not correctly used in driver
* "support MDIO switch downstream of MMIO switch" - clearer comments
* mt7530_port_change_mtu prefer moved function to forward declaration
* dt binding "passthrough mode" documentation, clarify it is a
restricted case of switch hierarchy
* Use different dsa_switch_ops for passthrough rather than short
circuiting in each function.
v3: https://lore.kernel.org/netdev/20261028011317.1557238-1-cjd@cjdns.fr/

Changes since v2:
* The MCM switch previously identified as econet,en751221, similarly to
mediatek,mt7621, however since econet,en751221 is already used for the
SoC compatible, is it changed to econet,en751221-gswitch. The name
"gswitch" is chosen as there's apparently no standard and for EN751221
this is intuitive because it is the gigabit switch used in
implementations with a "G" in the chip name.

* Do not use a special mt7530_switch_ops for passthrough mode, instead
detect passthrough mode in each function and exit early so as to avoid
errors when trying to make a configuration switch-tree wide.

v2: https://lore.kernel.org/netdev/20260915174643.253660-1-cjd@cjdns.fr/

Changes since v1:
* Move mt7530_setup_mdio_irq out of mt7530_setup_mdio because
mt7530_setup_mdio may be called before mt753x_setup

* Do not return error in mt7988_probe if mt7530_setup_mdio fails because
doing so leaks the DSA switch registration, and in any case
mt7530_setup_mdio will be called again.

* default_taps_ondie not being used en751221_trgmii_cal_ok unused args

* Use clk_drvp / clk_drvp instead of drvp / drvn (typo)

* en751221_set_tx_drive ext values too large for fields - values taken
from reference implementation, reduced from 16 to 15.

v1: https://lore.kernel.org/netdev/20260909140346.2861572-1-cjd@cjdns.fr/

Caleb James DeLisle (7):
  net: dsa: mt7530: get ctrl phy addr using a function
  dt-bindings: net: dsa: mediatek,mt7530: describe 'passthrough'
    hierarchy
  net: dsa: mediatek: add support for passthrough mode
  net: dsa: mediatek: support PLL setup on MMIO MT7530
  net: dsa: mediatek: support MDIO switch downstream of MMIO switch
  dt-bindings: net: dsa: mediatek,mt7530: add EcoNet EN751221 switches
  net: dsa: mediatek: support EN751221 switch

 .../bindings/net/dsa/mediatek,mt7530.yaml     |  48 +-
 drivers/net/dsa/mt7530-mdio.c                 |   1 +
 drivers/net/dsa/mt7530-mmio.c                 |  17 +-
 drivers/net/dsa/mt7530.c                      | 800 ++++++++++++++++--
 drivers/net/dsa/mt7530.h                      |  46 +-
 5 files changed, 824 insertions(+), 88 deletions(-)


base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.39.5

