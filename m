Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735DD4963BE;
	Tue, 19 May 2026 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779212294; cv=none; b=FnO21NdKtIwRi6L0DdJ69WNVv4i5jBQaBmRCLZCXTKrOaVUIqjsC862wpC/Yr5eV6CSbIs2l6+qmP6k96ArjtUcbdO69u0mrKsoknllfqDIXcuVMfoyzp+rbWY+ZDmRXNpYiFHR4pr+nfRamohVk5RaFf5GbP/hJS/3UQN8W6r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779212294; c=relaxed/simple;
	bh=M34YFTLToBpjfj88NBBaS+M/mGr7lyKIXgnsgl8sP0M=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BxLtfzEMqlk/NY4UYaErjNSFET8rD6/mhS6FanP7++BmWu5e7bVtSYGk/fm1dT8SDZkhiR0nRhXZBIr4hit/xf81edXTWZvyHPePr27cTKD74Wxli4VhssJWurG2l6XEb4fGLkvwvUm0hG/1f3ZRieYpl6v4EgTHmLB+FSo843s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wPOOM-000000001d8-45Mg;
	Tue, 19 May 2026 17:38:07 +0000
Date: Tue, 19 May 2026 18:38:04 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 0/5] net: dsa: mxl862xx: SerDes ports and stats
Message-ID: <cover.1779203863.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add support for the two SerDes PCS interfaces of the MxL862xx switch
ICs, which can both either be used to connect PHYs or SFP cages, or as
CPU port(s). 1000Base-X, 2500Base-X, 10GBase-R, 10GBase-KR, SGMII,
QSGMII and USXGMII (single 10G or quad 2.5G) are supported.

The firmware only added the API to directly control the PCS as of
version 1.0.84, so the PCS features are gated behind a version check.

As the driver is growing do some refactoring to break out the phylink
parts into mxl862xx-phylink.h.

Also add custom ethtool stats for the various diagnostic values related
to the SerDes interfaces which can be read from the firmware.

Daniel Golle (5):
  net: dsa: mxl862xx: store firmware version for feature gating
  net: dsa: mxl862xx: move phylink stubs to mxl862xx-phylink.c
  net: dsa: mxl862xx: move API macros to mxl862xx-host.h
  net: dsa: mxl862xx: add support for SerDes ports
  net: dsa: mxl862xx: add SerDes ethtool statistics

 drivers/net/dsa/mxl862xx/Makefile           |   2 +-
 drivers/net/dsa/mxl862xx/mxl862xx-api.h     | 392 +++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h     |  11 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.h    |   8 +
 drivers/net/dsa/mxl862xx/mxl862xx-phylink.c | 446 ++++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-phylink.h |  27 ++
 drivers/net/dsa/mxl862xx/mxl862xx.c         |  60 +--
 drivers/net/dsa/mxl862xx/mxl862xx.h         |  58 +++
 8 files changed, 957 insertions(+), 47 deletions(-)
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-phylink.h

-- 
2.54.0
