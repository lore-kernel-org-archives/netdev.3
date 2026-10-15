Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461D5511E73
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071850; cv=none; b=fW95bz7eZoXZjutqBUMVw2A9IRUfWNjSdcvgip8N+rkZpnuWDJVGgFYDcLAciFtTBg45/AmTCU4h+CL4MyYz8VCpz5c6uYNc7raa5tS4s/vW7mAgxmfMTz6NrPrYkRbez+VtY7eV66vZjbkUdYa+U43Tv++5otn9MAm/Pk5rllg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071850; c=relaxed/simple;
	bh=GeYIrwEr5LIVkJZNbjjYKIyA0l3cb3yOCAu+wvW5dWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WvEQFw1WELDOEnVSJhDTdpxUYh+rbnczXEkgmYE525vMAaisUJEXdBdVX7Xtv6JVzYoTd+/DQu+YcTGggMRkWCiN5j1usXtX8RzXrmkdelbAPzRsfqSa4K5/DByND5B6GV/j7X36OZ8EOMw4QnaKMN7h5uG47Kb+lIEZly/wJME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vv+4V30y; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vv+4V30y"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5FC5D4E41260;
	Thu, 15 Oct 2026 13:44:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 317D160360;
	Thu, 15 Oct 2026 13:44:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 38C1210328C52;
	Thu, 15 Oct 2026 15:43:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792071840; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=ZGLegN9PwLLCHoWQeOO/R0S13KTF7tB79ZezrC+Umig=;
	b=vv+4V30yOTk7QwajkRtZbYp3wgF3lnOeZJ0V2lA7sEeUdM5EJQQvCKP34NJ4/G6RAdi5HZ
	JdKrp5FI5fdriQKYeKKtYgURBe/aovVp2TRDgEKjN5G0hSCy+mvNxTv/GQiCrUjrLLupHa
	84j0fYviVGqYvRMxYZPCvKOnnwRJNOkMY57fn84S0PrTn7T2S2BrA2xQFMqLyVWU2Jl8nO
	mA/kNzmT3kWnOLXcnkw0k2fbBxg3UUJKHOU72Q/GtW4XfWwgfHJ8O5vLebasyuzqR21T5I
	9JuuMFpbcO7m/JK8lr9kg7o9Vt3jznqbJ3RrtBuqk0xktbPpyoJnTZdO2Cq4tg==
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
Subject: [PATCH net-next v3 0/3] selftests: drv-net: Introduce flow-control selftest
Date: Thu, 15 Oct 2026 15:43:45 +0200
Message-ID: <20261015134350.629593-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi everyone,

This is V3 for the ethtool flow control test.

This test aims at validating the flow control implementation in drivers,
using the ethtool API.

The test can run in various conditions :

DUT <-----> Anything that has link up (not controllable)
DUT <-----> A directly connected device

It enumerates the local and remote device's capabilities, to test as
much as possibly testable. I've run it on 17 different boards connected
to other boards through various means : Usb to Eth dongles, direct
connection to the board, connection through a switch. Some of the ports
tested were user ports of DSA switches too.

Contrary to V2, on V3 we really only have a collection of actual
failures that show during tests, as one of the peer's I'm running these
on has a v6.18 kernel that pre-dates the realtek phylink port and show
actual bugs in the driver.

Thanks to the Netdev Foundation for funding this work :)

Maxime

Changes in V3:
 - Use Jakub's loop on carrier state when waiting for the interface to
   be up
 - Following discussions with Andrew, we now detect the link partner
   using ethtool -r to trigger an autoneg, instead of assuming the link
   will drop when the interface is brought down
 - Numerous typo fixes and comment reworks
 - wait_for_link and wait_for_aneg have been reworked
 - We no longer expect that pause advertising is empty when pause
   autoneg is off, as documented in uAPI.

Changes in V2:
V2: https://lore.kernel.org/r/20260925182628.214667-1-maxime.chevallier@bootlin.com
 - Don't add stuff to the lib
 - Fix most pylink errors (module's too long for pylint ...)
 - Ditch the fail=False from the defer()
 - Remove duplicate patches
 - Clean the comments
 - Drop the return type annotations, most were wrong...

V1 : https://lore.kernel.org/netdev/20260920164732.349744-1-maxime.chevallier@bootlin.com/

Maxime Chevallier (Netdev Foundation) (3):
  selftests: drv-net: Introduce a selftest for ethtool flow control
  selftests: drv-net: pause: Validate the pause autonegotiation with a
    partner
  selftests: drv-net: pause: Validate pause autoneg interactions with
    link autoneg

 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../testing/selftests/drivers/net/hw/pause.py | 944 ++++++++++++++++++
 2 files changed, 945 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/pause.py

-- 
2.55.0

