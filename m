Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792623290A6;
	Sun, 20 Sep 2026 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789922874; cv=none; b=uQ81EDbqZhlqIsIPEfyGP8kuoTOEPjneSTGRQ2Zq/lzQODyJp8G/cHsoJ4+DAJM7VMseIO+cHNIReeBzTjNwm73YHz2bsHBDLug5Nvv19udJY9mpaRS5jVpCVn9niaFPvLudLlt7X1BVW1K/g30tIPw/UohpHYCKJcsQvUzOf9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789922874; c=relaxed/simple;
	bh=nuUFMhUjsbqzprN9C7tDISO76a5ZwhsVc48pyj46dWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gKJkXIkZ1mbrksCMCiBQzsc7MXALvozhvhGwO66d8unyMu50/2mu+h67iL3ERGjHV1QGPtdpzxGTOAgkuxMsMywEqn68auEUMH1CxW2xWXsKs1mhEbi4J7S08K56k9vwYIqdJvcR3bmUEIE1YbkaygDQ9rwdw1hrR9fNxbsjhAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xzG06tKi; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xzG06tKi"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1ACEB4E40928;
	Sun, 20 Sep 2026 16:47:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D99CD6033F;
	Sun, 20 Sep 2026 16:47:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3DF45103290A5;
	Sun, 20 Sep 2026 18:47:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789922861; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=ypewpLhezS9SRlhK/uCzxNRxTVVx1jmG37iawzuvaJo=;
	b=xzG06tKinEF2NQHtoRp/TgGCq2JfcAdZRgSbcmScBYIKrDZvkF1ippjnYgTaXrRVF826M7
	miWyyEYO6/RfeU0r8EJtjPccScIF7+dLj8YnvpRrQbsoMW+64D/De8xp5uES+fRt8CdvdO
	GvKe+LRkvrt2XT0VpWkfmGIFjl235dU5scxCxAfedxI79qhE+Wt+TPSAWjOispE5JovGOw
	oXcpr1onbVa9cInW34sDWBvRucavpY/CUzes5AE16SWbsFLeGUhdOMh+FWsC/r4HcPi479
	44kZj08KlsvW/HFFZVkogzb2ant9OIlmflI+tAPKDBXeyfiV2I8HNTYJG0to2A==
From: "Maxime Chevallier (Netdev Foundation)" <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: "Maxime Chevallier (Netdev Foundation)" <maxime.chevallier@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	thomas.petazzoni@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next 0/3] selftests: drv-net: Introduce flow-control selftest
Date: Sun, 20 Sep 2026 18:47:26 +0200
Message-ID: <20260920164732.349744-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

This series introduces a test suite for Flow Control, to validate that
drivers behave correctly according to 802.3, but also in a homogenous
way.

Flow control is tricky to get right, for multiple reasons :
 - The negotiation process uses Pause + Asym, while the ethtool API to
   configure pause with TX and RX modes

 - It involves multiple drivers :

  - The MAC driver implements the actual Pause frame handling and
    generation by controlling and reporting these settings to/from the
    hardware. It's also in charge of reporting what the MAC can do.

  - The PHY driver does the actual Pause parameters negociation with the
    LP, and reports that to the MAC

  - Some PCS are also involved in pause to some extent.

phylink helps to some extent, as it implements a lot of the 802.3
translation between RX/TX and Pause/Asym, but not all drivers use
phylink.

Some PHY drivers also tweak the pause advertising, due to HW issues. For
example, KSZ9031 may fail to establish link when advertising Asym Pause.

On top of that, there are 2 toggles for pause autoneg :

 - Link-wide autoneg, dictating whether or not we negotiate ANY
   parameter with the partner
 - Pause autoneg, that only dictates the Pause advertising

To top it all off, the Pause autonegotiation isn't a strict "pick modes
that match exactly what users requested on both ends of the link", the
negotiated pause params may actually differ from what the user asked.

This set of tests is aimed at catching all these issues.

This was tested on a wide variety of HW, some that support Pause + Asym,
some that only support Pause, with a peer that can or can't do pause.

Some issues were found, e.g. even with phylink, setting pause tx off rx
off aneg on makes the local interface still advertise Pause + Asym.

Tested on Macchiatobin, Espressobin, Turris omnia, and around 10
different boards that run stmmac.

Thanks to the Netdev Foundation for funding that work,

Maxime

Maxime Chevallier (Netdev Foundation) (3):
  selftests: drv-net: Introduce a selftest for ethtool flow control
  selftests: drv-net: pause: Validate the pause autonegotiation with a
    partner
  selftests: drv-net: pause: Validate pause autoneg interactions with
    link autoneg

 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/lib/py/__init__.py         |   7 +-
 .../testing/selftests/drivers/net/hw/pause.py | 973 ++++++++++++++++++
 .../selftests/drivers/net/lib/py/__init__.py  |   7 +-
 .../selftests/drivers/net/lib/py/ethtool.py   | 205 ++++
 5 files changed, 1191 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/pause.py
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/ethtool.py

-- 
2.55.0

