Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7370336604F;
	Thu, 22 Jan 2026 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099940; cv=none; b=VkzkMIGNrwOMNRzfyInVgvMO7Ert3e122ks8i/XnYh1aRvElwJ/xQAmLa0VYnc32spPnVQl0snpl79oVy0FEB5lb77jjtnylDNP+dOm5z2A4NgVAcQwNlfmIq/tDc0CX36WaPfzb3g7xWmx3BiYsT4B+r145mw98Y1H1xerga3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099940; c=relaxed/simple;
	bh=q3BLYaETzihHTjn3740y+fY1++XF0dwoVviNbivMTww=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lz1WojhUGrfyR4PZ6KMoMkXtfqjMvB9JqRphnAHCXNPmeIGf2gp5aUk54Sumu499rBAiQHAEy+nqy9BHr0fq8XA11a4opZxq9B7aED7lP+QyOKvdiyCbjFBb+q2dEkSgle48FCqtgmVMghhCXsk/2C4hRoHGfFdNAi/t+u9wQzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vixhf-000000001Q4-1o9E;
	Thu, 22 Jan 2026 16:38:39 +0000
Date: Thu, 22 Jan 2026 16:38:36 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chen Minqiang <ptpt52@gmail.com>, Xinfa Deng <xinfa.deng@gl-inet.com>
Subject: [PATCH net-next v6 0/6] net: dsa: lantiq: add support for Intel
 GSW150
Message-ID: <cover.1769099517.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The Intel GSW150 Ethernet Switch (aka. Lantiq PEB7084) is the predecessor of
MaxLinear's GSW1xx series of switches. It shares most features, but has a
slightly different port layout and different MII interfaces.
Adding support for this switch to the mxl-gsw1xx driver is quite trivial.
---
Changes since v5:
 * rebase on top of current net-next
 * update Kconfig to mention GSW150
 * allow configuring RGMII slewrate introduced by commit dbf24ab58fec3
   ("net: dsa: mxl-gsw1xx: Support R(G)MII slew rate configuration")

Changes since v4:
 * fix wrong indexes in array default initializers

Changes since v3:
 * spell out mii_cfg and mii_pcdu values in struct gswip_hw_info instead
   of using default initializer which requires diag exception

Changes since v2:
 * enclose the gswip_hw_info initializers in compiler diag exception
   to prevent triggering -Woverride-init

Changes since initial submission:
 * add patch fixing node naming convention for dt-bindings
 * introduce GSWIP_MAX_PORTS macro
 * don't assert SGMII PCS reset in case chip doesn't have SGMII
 * use case ranges in phylink_get_caps


Daniel Golle (6):
  dt-bindings: net: dsa: lantiq,gswip: use correct node name
  dt-bindings: net: dsa: lantiq,gswip: add Intel GSW150
  net: dsa: lantiq: allow arbitrary MII registers
  net: dsa: lantiq: clean up phylink_get_caps switch statement
  net: dsa: mxl-gsw1xx: only setup SerDes PCS if it exists
  net: dsa: mxl-gsw1xx: add support for Intel GSW150

 .../bindings/net/dsa/lantiq,gswip.yaml        |   6 +-
 drivers/net/dsa/lantiq/Kconfig                |   4 +-
 drivers/net/dsa/lantiq/lantiq_gswip.c         |  46 ++++--
 drivers/net/dsa/lantiq/lantiq_gswip.h         |   6 +-
 drivers/net/dsa/lantiq/lantiq_gswip_common.c  |  27 +---
 drivers/net/dsa/lantiq/mxl-gsw1xx.c           | 151 ++++++++++++++----
 drivers/net/dsa/lantiq/mxl-gsw1xx.h           |   2 +
 7 files changed, 168 insertions(+), 74 deletions(-)

-- 
2.52.0
