Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7BB4FECF3;
	Thu,  3 Sep 2026 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788459109; cv=none; b=qD2tVF7GlpDLSkFPsY3fxKVm81u3tIDeHlF9cETgTPllNS7T5/ngopY5oNhnc22yhLnskj7etP6rlJU/f1rxOGbz/0GYrpV6iUUGhi0iRnkl8+w4fxLm1CgOAx2jXpaIBW+sUqSTQYomWWPQ2Q7SjKMI17beqjUYvhyaVb2GQ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788459109; c=relaxed/simple;
	bh=kKNyd9ZnEdlbCMumzWU+mW9Jc79UMKjWUuFYZ8JFb7M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=An3BxrGyUi9Hr3p2rbtsyKC6TC5mVrVUh+H3v1fdls/zCVdnSz6ue1rTSTLAqQoQ/dvZzj3XAVwCxB1IpUcxyRD/LwFBzWeAcB2C0wqMOfW7By1BNs+vkZ2j3vYz7JvoNa+/8n/So46Bnq5OO0jvAr7EAvd3w6rf7wbUwkxL+cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yqlm+ikz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CHO/dV3V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yqlm+ikz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CHO/dV3V"
From: Vasilij Strassheim <v.strassheim@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788459103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AKqUVZngA9Q3l9uJneqmlIzpd3gmfrzz2Q2jB94Vn1s=;
	b=Yqlm+ikzbVhcOxyGEBkawyYJPiFXv9Q3/X/pnucu8JXvp0v7sLc6/U1E3kx2sGc2L6LBo3
	gIZ7cQcgB7xbHtTXteomnL0/Fp5att71habouG2Rtc0qx2/MVXMzu3x5R/o/f8ZzjsmY0T
	y5A6FV/RhzvuDn09Wu6EOH3pmY5ljTiZ74ql9BLSZOWcuQh/dlMiOImQZ0IJc5wu1N/o3n
	ZpeSqzoGyyhepXDxBGn+9dlZKeAOx8vnrBtgABOXJUZnvNSBWSlfFD8KbPe1x+dH3drK9h
	EUMT+KpzFPFkZ09ByGzue/06XfrqfLMNmiI97UBqvWtwl9gmAXYFzV0LfFgAZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788459103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AKqUVZngA9Q3l9uJneqmlIzpd3gmfrzz2Q2jB94Vn1s=;
	b=CHO/dV3VxZIYhLtDJ9D5jeAjUeDHd8Xy4IGndc9X3mMGU7HVqBfkemMWcusDR+6DftfsFG
	NSlTWsbpu8i/TECw==
Subject: [PATCH net-next v2 0/4] net: dsa: Add SoC-e DSA driver
Date: Thu, 03 Sep 2026 20:10:57 +0200
Message-Id: <20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADG4mWoC/42OwQ6CMBBEf4Xs2TWlBgRP/ofhUOgqa7A13dJgC
 P8u4A94nMzMm5lBKDAJXLIZAiUW9m4V+pBB1xv3IGS7atBKl+qsa7SUaMAkMRiRnviF4jtCKwZ
 fA2plS1MY21anClbGO9Cdp51/A0cRHU0Rmp8jY/ukLm74LduzRB8++5WU740/V1OOClsqytoay
 lutrgO7MQbveDpagmZZli/rwKUS6gAAAA==
X-Change-ID: 20260729-devel-vstrassheim-soce-dsa-ml-20d6a5adb838
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>, 
 Benedikt Spranger <b.spranger@linutronix.de>, 
 Vasilij Strassheim <v.strassheim@linutronix.de>

Add support for SoC-e Ethernet switch IP cores synthesized for and
implemented in FPGAs.

The series introduces the SoC-e vendor prefix and device tree binding,
an EtherType-based SDSA tagger, and an initial DSA switch driver.

The driver uses a memory-mapped control interface. During probe, it
detects the core version and the licensed and implemented port counts,
and verifies that the synthesized core provides DSA support. Port
counts from 1 through 31 are supported.

The initial implementation supports Ethernet switching using MII, GMII,
RMII, and RGMII port interfaces. Offloading features are not
implemented.

External MDIO outputs are exposed as separate logical MDIO buses sharing
the integrated MDIO controller.

The driver was tested with a SoC-e MRS 25.01 IP core on a Xilinx ZynqMP
platform.

Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
---
Changes in v2:
- Correctly use net-next prefix
- Rework the binding into a single MMIO-based switch node
- Model hardware MDIO outputs as separate logical MDIO buses
- Detect the switch version, features, and port count from hardware
- Drop incomplete STP, bridge, and FDB offloading
- Derive phylink capabilities from each port's phy-mode
- Harden MDIO access and SDSA receive validation
- Address binding, naming, and coding style review comments

Link to v1: https://patch.msgid.link/20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de

To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Simon Horman <horms@kernel.org>
To: Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org

---
Vasilij Strassheim (4):
      dt-bindings: vendor-prefixes: Add soce
      dt-bindings: net: dsa: Add SoC-e SWIP switch
      net: dsa: Add tag handling for SoC-e switches
      net: dsa: soce: Add basic support for SoC-e switch IP cores

 .../devicetree/bindings/net/dsa/soce,swip.yaml     | 161 ++++++++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 drivers/net/dsa/Kconfig                            |   2 +
 drivers/net/dsa/Makefile                           |   1 +
 drivers/net/dsa/soce/Kconfig                       |  12 +
 drivers/net/dsa/soce/Makefile                      |   4 +
 drivers/net/dsa/soce/soce_dsa.h                    |  44 +++
 drivers/net/dsa/soce/soce_dsa_core.c               | 297 +++++++++++++++
 drivers/net/dsa/soce/soce_mdio.c                   | 411 +++++++++++++++++++++
 drivers/net/dsa/soce/soce_mdio.h                   |  38 ++
 include/net/dsa.h                                  |   2 +
 net/dsa/Kconfig                                    |   6 +
 net/dsa/Makefile                                   |   1 +
 net/dsa/tag_sdsa.c                                 | 123 ++++++
 14 files changed, 1104 insertions(+)
---
base-commit: 7042c8c193e5d634198b7c766bb3a01c8e3ee0e2
change-id: 20260729-devel-vstrassheim-soce-dsa-ml-20d6a5adb838

Best regards,
--  
Vasilij Strassheim <v.strassheim@linutronix.de>

