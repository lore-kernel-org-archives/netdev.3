Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103A746D2A9
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157492; cv=none; b=bk1Dg4kN1n9Te0aNwuAqTpDaqY1p/2ZBaTTLYy9YTXreK2q5/PIUTUUp4lkN3zHJPQHSU9L+2ysCRYo/Q2m7odnJPWBosFmerpBINGXH5LF/K9ymSiFPAXE3pC6efNre/m2Zkwi1654SYVBQkenbfhlaBaTE4Tr63h1FM8kg0x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157492; c=relaxed/simple;
	bh=cri7IscqRhGSVuW0BhhphROyoOUHnDnAYr/iEnSbmMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qISjh2Ta/yddC7TcuWtm6uts03EeLlFK7h2zZtCxyQodVLaYcKKLPY3cUVGvvYMnCRVinxhFLmhvlhyy+XTM6V5qQqj+f0+VZgnjzzdGZ1V/8THIx7ROPSHijx+cjlMm4ir9qAgnmxa2GkYYsd86cJLODWj//u3+pTV+BWeqr9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ox1DSh2X; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ox1DSh2X"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 396421A1255;
	Fri, 16 Oct 2026 13:31:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 07A846075D;
	Fri, 16 Oct 2026 13:31:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5318110328528;
	Fri, 16 Oct 2026 15:31:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792157481; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=gl+x/C1QFLhR5c9dolFfUEsI5T+0oocy2ijGBeeEIYc=;
	b=ox1DSh2Xj96sQhNbM0EChWLyGnNOU90mIJEvXc6X/mSeHNa+AnjRC7ARq9olcKAU1+OYXM
	3PqvSbqOgvtQex6xWYJKJOmrV5hHVXWnXwEgu4TX++zF9H6mHuq9qCvZV4dIXqsreyQDFj
	sMy9Y7CnsDjHuXnRqabSOVurttn4fM4nObzu+/BV2hypUlLEabIkwEeXXuEBd8ZT71OHWw
	7mtomnNz/knB0TR2DhTLlUq+fzhnAVe5LrmTdMmlAImysviXSGzX274Fzh0pBJ1vtQ7TqT
	N65dMigJnm8NJnR22yk1e0P7GbBkoYNmtmRxHhfAb1yh72X+fut2XnWIFaTpKg==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Frank Wunderlich <frank.wunderlich@linux.dev>,
	Pietro Ameruoso <p.ameruoso@live.it>,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH net-next v19 00/10] net: phy_port: SFP modules representation and phy_port listing
Date: Fri, 16 Oct 2026 15:30:55 +0200
Message-ID: <20261016133107.54054-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hello everyone,

v19 addresses Jakub's comments on the netlink part, the only missing bit
is the phy_modes() rework as we'd need that even when CONFIG_NET is off
(for OF and generic PHY), so there's no clean place where to put it. It
also addresses the medium/high *ashiko issues.

Thanks to Christophe for reviewing and testing, this is much
appreciated.

This work extends on the recent addition of phy_port representation to enable
listing the front-facing ports of an interface. For now, we don't control
these ports, we merely list their presence and their capabilities.

As the most common use-case of multi-port interfaces is combo-ports that
provide both RJ45 and SFP connectors on a single MAC, there's a lot of
SFP stuff in this series.

This series is in 2 main parts. The first one aims at representing the
SFP cages and modules using phy_port, as combo-ports with RJ45 + SFP are
by far the most common cases for multi-connector setups.

The second part is the netlink interface to list those ports, now that
most use-cases are covered.

Let's see what we can do with some examples of the new ethtool API :

- Get MII interfaces supported by an empty SFP cage :

# ethtool --show-ports eth3

Port for eth3:
	Port id: 1
	Supported MII interfaces : sgmii, 1000base-x, 2500base-x
	Port type: sfp

- Get Combo-ports supported modes, on each port :

# ethtool --show-ports eth1

Port for eth1:
	Port id: 1
	Supported link modes:  10baseT/Half 10baseT/Full
	                       100baseT/Half 100baseT/Full
	                       1000baseT/Full
	                       10000baseT/Full
	                       2500baseT/Full
	                       5000baseT/Full

	Port type: mdi

Port for eth1:
	Port id: 2
	Supported MII interfaces : 10gbase-r
	Port type: sfp

- Get Achievable linkmodes on a SFP module (combo port with a DAC in the
SFP cage)

# ethtool --show-ports eth1

Port for eth1:
	Port id: 1
	Supported link modes:  10baseT/Half 10baseT/Full
	                       100baseT/Half 100baseT/Full
	                       1000baseT/Full
	                       10000baseT/Full
	                       2500baseT/Full
	                       5000baseT/Full
	Port type: mdi

Port for eth1:
	Port id: 2
	Supported MII interfaces : 10gbase-r
	Port type: sfp

Port for eth1:
	Port id: 3
	Upstream id: 2
	Supported link modes:  10000baseCR/Full
	Port type: mdi

Note that here, we have 3 ports :
 - The Copper port
 - The SFP Cage itself,
 - The SFP module

This series builds on top of phy_port and phy_link_topology to allow
tracking the ports of an interface. We maintain a list of supported
linkmodes/interfaces on each port, which allows for fine-grained
reporting of each port's capability.

What this series doesn't do :
 - We don't support selecting which port is active. This is the next step.
 - We only support PHY-driven combo ports. The end-goal of this whole
   journey that started with phy_link_topology is to get support for MII
   muxes, such as the one we have on the Turris Omnia. This will eventually
   be upstreamed as well.

If you want to play around with it, here's [1] the patched ethtool that I've
been using to produce the outputs above.

Thanks !

Maxime

[1] : https://github.com/minimaxwell/ethtool/tree/mc/ethtool_port

Changelog :

Changes in v19:
 - Add Review/Tested tags (except on specs/docs)
 - grab rtnl when adding the mac-driver sfp cage
 - rework the port registration to avoid overriding a mod port
 - phy interface names are now exposed as strings
 - rework on the port_get/dump following Jakub's comments

Changes in v18:
https://lore.kernel.org/netdev/20260927133619.955236-1-maxime.chevallier@bootlin.com/
 - Add Review/Tested tags
 - add missing rtnl() in phylink when removing the cage port
 - add a missing NULL check on netdev ops
 - Added missing items in the netlink docs

Changes in v17:
https://lore.kernel.org/netdev/20260910170103.1029108-1-maxime.chevallier@bootlin.com/
 - Handle port index wraparound
 - Regen the ethtool headers, now with the comment :)

Changes in v16:
https://lore.kernel.org/r/20260902212135.1805948-1-maxime.chevallier@bootlin.com
 - unregister phy_ports at phy_detach
 - typos in patch 1 (of -> or)
 - Fix the netlink specs

Changes in v15:
https://lore.kernel.org/netdev/20260801074332.98755-1-maxime.chevallier@bootlin.com/
 - Fail on port access for ops-locked devices
 - Use a direct phy_port pointer for upstream tracking
 - Addressed the kdoc issues

Changes in v14:
https://lore.kernel.org/netdev/20260720174808.139573-1-maxime.chevallier@bootlin.com/
 - Added a big comment on the first patch for the topo alloc potential
   races
 - Fixed the multi-buff DUMP on last patch with a separate iterator for
   dumps
 - Fixed some typos in the documentation

Changes in V13:
V13: https://lore.kernel.org/r/20260701110427.143945-1-maxime.chevallier@bootlin.com
 - Rebase on net-next
 - Fix the SFP bus cleanup path in patch 5

Changes in V12:
V12: https://lore.kernel.org/r/20260615153907.862987-1-maxime.chevallier@bootlin.com
 - Rebased on net-next, including fixes on the phy probing and cleanup
   paths
 - Rebased on Jakub's netdev_ops_locked changes in phy_link_topology
 - Fixed some typos reported by Andrew and sashiko in the documentation

Changes in v11:
V11:https://lore.kernel.org/r/20260521121040.1199622-1-maxime.chevallier@bootlin.com
 - Aggregated Andrew's reviews :)
 - Removed the "vacant" field, replaced it with "upstream_port"

Changes in V10:
V10: https://lore.kernel.org/r/20260513130521.1064094-1-maxime.chevallier@bootlin.com
 - Rebase on net-next
 - Rename phylink/phy_device sfp_bus_port to sfp_cage_port
 - Sashiko's reviews were mostly unrealistic or wrong :(

Changes in V9:
V9: https://lore.kernel.org/r/20260403123755.175742-1-maxime.chevallier@bootlin.com
 - Added missing netlink doc updates for u8->u32 conversion
 - Removed dead code with a condition that can never be true in
   phylink's mod_port code
 - Fixed the error path in phy_sfp_connect_phy

Changes in v8:
V8: https://lore.kernel.org/r/20260325081937.571115-1-maxime.chevallier@bootlin.com
 - Set the new phydev.has_sfp_mod_phy field when we're sure that no
   errors occured
 - Fix formatting of the copyright info in ethnl port
 - Use a policy to validate the range of port_id
 - Use GENL_REQ_ATTR_CHECK
 - alpha-sort headers
 - use u32 in netlink messages
 - return better error codes
 - don't check the skb len, the core does that

Changes in V7:
V7: https://lore.kernel.org/all/20260309152747.702373-1-maxime.chevallier@bootlin.com/
 - Changed the port cleanup path to use list_for_each_entry_continue_reverse
 - Adjusted the cleanup path in phylink for the port vacant state
 - Pass the right cmd for the netlink dump message

Changes in V6:
V6: https://lore.kernel.org/r/20260304145444.442334-1-maxime.chevallier@bootlin.com
 - Added some comments in th mod_port cleanup
 - changed some kmalloc to kmalloc_obj
 - Removed some phy_link_topo_del_port that wasn't needed

Changes in V5:
V5: https://lore.kernel.org/r/20260205092317.755906-1-maxime.chevallier@bootlin.com
 - Fixed a check on a potentially un-initialized pointer, reported by
   Simon
 - Fixed a documentation formatting issue
 - Remove a stray pr_info
 - Rebased on net-next

Changes in V4:
V4 : https://lore.kernel.org/netdev/20260203172839.548524-1-maxime.chevallier@bootlin.com/
 - Add a cleanup patch for the of port parsing
 - Added a match to sync the port's linkmodes with the PHY's for OF
   ports
 - Added RTNL assert in the port_get topo helper
 - nullify the bus port for phylink support
 - Fix some typos

Changes in V3:
V3: https://lore.kernel.org/netdev/20260201151249.642015-1-maxime.chevallier@bootlin.com/
 - Remove the sfp bus ops for nophy, and use .module_start() as
   suggested by Russell
 - Added missing cleanup for the topology, as per AI review
 - Fixed a few typos as per Romain's review
 - Changed "occupied" to "vacant" as per Romain's review
 - Added missing checks for null ports, per AI review

Changes in V2:
V2: https://lore.kernel.org/netdev/20260128204526.170927-1-maxime.chevallier@bootlin.com/
 - Fix the cleanup path of phy_link_topo_add_phy, as per AI review
 - Fix the cleanup path of phy_sfp_probe, as per AI review
 - Fix the call-site of the disconnect_nophy sfp bus ops, per AI review
 - Fix the netdev-less case uin phylink, per AI review
 - Fix the prototype of phy_link_topo_get_port for the stubs
 - Dropped patch 11. It ended-up breaking 'allnoconfig', so instead we
   built a phy_interface_names array in net/ethtool/netlink.c
 - Fix an ethool-netlink spec discrepancy with the type of an attribute
 - Fix the size computation in the netlink port API
 - Fix the cleanup path in the netlink port API

V1: https://lore.kernel.org/netdev/20260127134202.8208-1-maxime.chevallier@bootlin.com/

Maxime Chevallier (10):
  net: phy: phy_link_topology: Add a helper for opportunistic alloc
  net: phy: phy_link_topology: Track ports in phy_link_topology
  net: phylink: Register a phy_port for MAC-driven SFP cages
  net: phy: Create SFP phy_port before registering upstream
  net: phy: Represent PHY-less SFP modules with phy_port
  net: phy: phy_port: Store information about a port's upstream
  net: phy: phy_link_topology: Add a helper to retrieve ports
  netlink: specs: Add ethernet port listing with ethtool
  net: ethtool: Introduce ethtool command to list ports
  Documentation: networking: Update the phy_port infrastructure
    description

 Documentation/netlink/specs/ethtool.yaml      |  55 +++
 Documentation/networking/ethtool-netlink.rst  |  36 ++
 Documentation/networking/phy-port.rst         |  26 +-
 MAINTAINERS                                   |   1 +
 drivers/net/phy/phy-caps.h                    |   2 +
 drivers/net/phy/phy_caps.c                    |  26 ++
 drivers/net/phy/phy_device.c                  | 192 +++++++--
 drivers/net/phy/phy_link_topology.c           | 101 ++++-
 drivers/net/phy/phylink.c                     | 137 ++++++-
 include/linux/phy.h                           |  10 +
 include/linux/phy_link_topology.h             |  43 ++
 include/linux/phy_port.h                      |   5 +
 include/uapi/linux/ethtool.h                  |   2 +
 .../uapi/linux/ethtool_netlink_generated.h    |  22 +
 net/core/dev.c                                |   1 +
 net/ethtool/Makefile                          |   2 +-
 net/ethtool/netlink.c                         |  25 ++
 net/ethtool/netlink.h                         |   8 +
 net/ethtool/port.c                            | 385 ++++++++++++++++++
 net/ethtool/strset.c                          |   5 +
 20 files changed, 1046 insertions(+), 38 deletions(-)
 create mode 100644 net/ethtool/port.c

-- 
2.56.0

