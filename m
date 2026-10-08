Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3BD4B829D;
	Thu,  8 Oct 2026 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470009; cv=none; b=mvY4xK5lOuukAfkKqXAXyWHPgQMWaVX1zT9bu9TWNEEns9B3zu14IgB2Pzvknb0rrV4wV2y5+eRkLD8tUxXh4W0L0Sh3/aMkn9xg2yoB7tPqXlCSaM7/DLR3LN1R0qNKlbyVFmZKyOSUE0qYMywakGBadz/5JrpNNhRf8JgjrbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470009; c=relaxed/simple;
	bh=ZWuwnIex3MvCUx3SKPrDSozmvcwRrW0CefBSXvse1z4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RFTq4y2tjSLMr3eywFNZx8FiWRr+o8t6GcFQ1c2g1MZ5qgwAi/suHGUbOHnZbiOaartneyVFJlQDxfXJwH3VpOVXbPo/BvCfjuI9uGHwKvIq5zkbA+nT2JCgFC00Xcckv47KzSDMgeLOHDC/Nv+2Ys1ix82dNdJqGz8o/2xci1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org; spf=pass smtp.mailfrom=phrozen.org; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phrozen.org
Received: from [2a04:4540:1400:26fc:ddc6:af15:b0f7:2808] (helo=bertha10..)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <john@phrozen.org>)
	id 1xEpBB-000l4X-13;
	Thu, 08 Oct 2026 16:33:05 +0200
From: John Crispin <john@phrozen.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org
Subject: [RFC net-next 00/12] net: add the PON subsystem
Date: Thu,  8 Oct 2026 16:32:37 +0200
Message-Id: <20261008143249.3439762-1-john@phrozen.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds net/pon, a subsystem for the ONU side of an ITU-T
passive optical network. It follows the thread "[RFC] net: towards a
generic PON framework" [1], which converged on a wiphy-like PON object
that is not a netdev, PLOAM in the MAC driver, service traffic on
ordinary netdevs and OMCI in userspace. This is that design as working
code.

The model is cfg80211 with a fullmac driver:

- struct pon_dev is the PON object. It is not a netdev. Userspace
  addresses it by a device id, as nl80211 addresses a wiphy.
- The MAC driver runs PLOAM activation and the key hierarchy. It
  reports the activation state through pon_dev_state_report(). The
  core validates the edge against ITU-T G.9807.1 Table C.12.4,
  publishes it and sets the carrier from it.
- The core owns the T-CONTs, the GEM ports and the upstream classifier
  rules (the 802.1p mapper of the thread). It stores them and dumps
  them. The driver offloads them.
- The core lends the driver a serialized context: an ordered workqueue
  per instance and the instance lock that the netlink handlers take.
- Service traffic uses a data netdev plus GEM netdevs (rtnetlink link
  kind "gem") where a GEM port needs a bridge port of its own. Frames
  ride the rings of an ethernet controller, the conduit, with the per
  frame information passed as arguments.
- OMCI travels over the pon genl family the way nl80211 carries
  management frames. One socket registers for the OMCI PDUs of a
  device, receives them as notifications and sends with omci-tx. No
  OMCI netdev and no new address family.
- Control is one generic netlink family with a YAML spec. The uapi
  header and the policy are generated.

This posting is the minimal core. The counters, alarms, events, the
ETS scheduler offload, a PON mode for the generic PHY framework, the PON
PCS object and the flow offload are further commits on top of it that
come in later series.

The scope is XGS-PON. The mode enum keeps gpon and xg-pon so that the
uapi order stays clean for later drivers. The core refuses a mode that
the device does not list.

The first driver is for the Airoha AN7581 PON MAC, with its PON PHY, an
optics driver and the conduit in airoha_eth. It is not part of this
posting, because it depends on the Airoha PCS series that is not
upstream yet. pon-tool [2] consumes the family through the libpon
library. It has a verb for every attribute of the family and runs in
OpenWrt today. The stack reaches O5, passes traffic and recovers from
fiber pulls against a production OLT with HGU, SFU and IP host services
at the same time.

[1] https://lore.kernel.org/netdev/20260926174601.1675-1-yhyxwgy@gmail.com/
[2] https://github.com/blogic/pon-tool

John Crispin (12):
  net: pon: add the netlink specification of the pon family
  net: add a PON device pointer to struct net_device
  net: pon: add the PLOAM vocabulary and message codec
  net: pon: add the device state and the lent context
  net: pon: add the conduit contract
  net: pon: add the GEM network devices
  net: pon: add the OMCI channel
  net: pon: add netlink support
  net: pon: add the device registration
  net: pon: build the PON subsystem
  Documentation: networking: describe the PON subsystem
  MAINTAINERS: add the PON subsystem

 Documentation/netlink/specs/pon.yaml     |  604 ++++++++
 Documentation/netlink/specs/rt-link.yaml |   14 +
 Documentation/networking/index.rst       |    1 +
 Documentation/networking/pon.rst         |  302 ++++
 MAINTAINERS                              |   11 +
 include/linux/netdevice.h                |    6 +
 include/net/pon.h                        |   14 +
 include/net/pon/functions.h              |  129 ++
 include/net/pon/ploam.h                  |  266 ++++
 include/net/pon/ploam_msg.h              |  306 ++++
 include/net/pon/types.h                  |  443 ++++++
 include/uapi/linux/if_link.h             |   10 +
 include/uapi/linux/pon.h                 |  166 +++
 net/Kconfig                              |    1 +
 net/Makefile                             |    1 +
 net/pon/Kconfig                          |   17 +
 net/pon/Makefile                         |    6 +
 net/pon/pon-nl-gen.c                     |  286 ++++
 net/pon/pon-nl-gen.h                     |   45 +
 net/pon/pon.h                            |  162 +++
 net/pon/pon_conduit.c                    |  614 ++++++++
 net/pon/pon_gem.c                        |  537 +++++++
 net/pon/pon_main.c                       |  454 ++++++
 net/pon/pon_nl.c                         | 1671 ++++++++++++++++++++++
 net/pon/pon_omci.c                       |  326 +++++
 net/pon/pon_ploam_msg.c                  |  312 ++++
 net/pon/pon_state.c                      |  408 ++++++
 net/pon/pon_work.c                       |  106 ++
 tools/net/ynl/Makefile.deps              |    1 +
 29 files changed, 7219 insertions(+)
 create mode 100644 Documentation/netlink/specs/pon.yaml
 create mode 100644 Documentation/networking/pon.rst
 create mode 100644 include/net/pon.h
 create mode 100644 include/net/pon/functions.h
 create mode 100644 include/net/pon/ploam.h
 create mode 100644 include/net/pon/ploam_msg.h
 create mode 100644 include/net/pon/types.h
 create mode 100644 include/uapi/linux/pon.h
 create mode 100644 net/pon/Kconfig
 create mode 100644 net/pon/Makefile
 create mode 100644 net/pon/pon-nl-gen.c
 create mode 100644 net/pon/pon-nl-gen.h
 create mode 100644 net/pon/pon.h
 create mode 100644 net/pon/pon_conduit.c
 create mode 100644 net/pon/pon_gem.c
 create mode 100644 net/pon/pon_main.c
 create mode 100644 net/pon/pon_nl.c
 create mode 100644 net/pon/pon_omci.c
 create mode 100644 net/pon/pon_ploam_msg.c
 create mode 100644 net/pon/pon_state.c
 create mode 100644 net/pon/pon_work.c


base-commit: 8df0638138d3e0344fd1fb36cf2d1ca1cf5028f0
-- 
2.34.1

