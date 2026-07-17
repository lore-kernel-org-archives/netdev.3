Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6D03AF647
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 06:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271311; cv=none; b=l7LkRi2g6lIthDJeLmPbZJ4HqEvkQXLbsuHhAPmJYoF1IWtApz0gCFOmEHNAKgquPXFHR40u8W/u7hSMv3dRlAUAqqQM9Uk228dU1XKyhldQs0M2IZfafYLpIamoFZQteq8pFwVdaFfpaup7Pq7zZTomXlTPlUom3Kt8JspLwZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271311; c=relaxed/simple;
	bh=JETqst9Fon2crKtqIHNEcl7ls3EvP5xzuBOxhJMVC3w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jGin814/LyiPpJNt7aVkkodNAGUyp81D5zUX/aScqwQw2M6SSTbnvvdpintKxrFLwaNV+BM6YVBvzof3rdtM1F+43cDgpVGwUC4pOYzT/kXmrG3r3Bz5CaLpTGPlX/85x0VVZJYXw76kjd09eyonr9V+Pq5EF+xWiBXeEFc45X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMxEXDRq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMxEXDRq"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4954a2e73a9so1645725e9.3
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 23:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784271308; x=1784876108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xUKU1D5cUN0Qg6xvLwdian0LsUeuBf5DwRzyt6yTiC8=;
        b=IMxEXDRqUj5caI+fd1AvZexUWkUXD1iEf1rzgFSwIepNKLrbPxMRH2wEeIEK+bymOS
         Cpq+heTNxoqb1NLvcB5MqfSrM+gdnUsoyqfD4qhlmJb/AMwIAObsfx949tD0UPj6Rx7m
         IjURku2ZkGRs0DJ4NZ7zwSY5orCDW+HAihMeScL4mUmGSZ9iVqZ5540BFaJLjoTnX19Y
         tgkf+3oucYJAGHwsOtU+PlQ4W+rE71Caonm69t58h6nHG2xh8td1DDKt9ok4h5TDpdPH
         ekgzvCNsyXQmqbfopDhPgiXENLFLyetKZQZgW8NsEsi9gpx39zIswPexCXvvsE82eVYd
         4yBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784271308; x=1784876108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xUKU1D5cUN0Qg6xvLwdian0LsUeuBf5DwRzyt6yTiC8=;
        b=KWt25+yTcswUKdbCJmp/VKnrphwxwogdNuawMb3KMvellQ17Hekd4QN3MxLNT7OmKk
         NN4oQF419YxjicA6jDp62REYajiN3KWY0NIjFgGDmnEPEON1CLE3IESK9gbPxOZeAlTb
         QcOQcCdcNc8xTVDKbhoHfa+RhVmk7ZZfyocwae4gPcIRx8IW97u4DTSgJ8y/PDVGcJE7
         yU5rvLyBruD6rPDRNdFayl8Xiun+rZLSNAdgkfF/VqFMHWS1dGfV3/GEHNw5ik0/KEgi
         dtnMJiAxvrkl1/ureZmv0HB75/KbVckmbtWUYFu4av3CB4jUCmjkrcPbx1B7ogAQzye7
         HwJw==
X-Forwarded-Encrypted: i=1; AHgh+RoACBFULKaiLogk4o1BxsK6LYxMX1paRabhiV3s26Igro59U7NPMS6EWe6aUEPmj/ztHiTgfl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YywkpzaNyWaVfs5g9B5E4vmaxfcogqdgv53Xb5lTMDH556BRxo4
	2jLMJo1Vm+RWz8W2fEDPTl3uZZPqCAMTFq36mdIclpueRNe/tuif+2uk
X-Gm-Gg: AfdE7cnzfmKSHUeOwUJeR7Aza4ROr8zy6RY7zGr/AbLdKwJxLelROdaA0zGvKTkljvl
	rwPDDDUSu/dnb+jOheXb62xnG+RGjRZFHmK5Z04EEBHzRk299ERuUyHqItq+ScxCgvIsrnC4Eic
	leQbPUNEfHYyuMH5wfzPqpccGpkg9+Hlb8EwydZbkEyVJMWturR9jFwJyI7JAaTRvjvPdtEQP6x
	fZ51NrMSxUVqLAkUmXAG+N3OM8wFJnKkMzzzjVcLbKMe6/i8GdIvnqBfhDcflCnyw08/Lthzn1L
	3OBt/+v6BN4KUMOkYnOd96lnB4O9737pvwn68ETcCpulk+bEJJf4sNIMximWhDXlOWTir+Kgjgn
	s2/1fm6Ypcm6+sQBv5i3zmvNM/WD4jMsAtuHDySzENHGH1DHzHAZiUFQa29a0CUbvteXUZJv79H
	gWkzSpiEmgh4bP2AW1pANns0Wv9EkrMgDBv40aushvMx76+2i1qvDhjQQOehal2DpyEqQR+Q==
X-Received: by 2002:a05:600c:154e:b0:495:405c:38d3 with SMTP id 5b1f17b1804b1-4954a3df9f9mr16057155e9.9.1784271307739;
        Thu, 16 Jul 2026 23:55:07 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-95-248-227-210.retail.telecomitalia.it. [95.248.227.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-495499f3f99sm24260835e9.0.2026.07.16.23.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 23:55:07 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v9 00/12] net: pcs: Introduce support for fwnode PCS
Date: Fri, 17 Jul 2026 08:54:00 +0200
Message-ID: <20260717065448.1498335-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduce a most awaited feature that is correctly
provide PCS with fwnode without having to use specific export symbol
and additional handling of PCS in phylink.

At times there were 2 different implementation (this and the one
from Sean) but Sean agreed that this can be picked and used in favor
of his implementation as long as his case with race condition is
correctly handled.

---
First the PCS fwnode:

The concept is to implement a producer-consumer API similar to other
subsystem like clock or PHY.

That seems to be the best solution to the problem as PCS driver needs
to be detached from phylink and implement a simple way to provide a
PCS while maintaining support for probe defer or driver removal.

To keep the implementation simple, the PCS driver devs needs some
collaboration to correctly implement this. This is O.K. as helper
to correctly implement this are provided hence it's really a matter
of following a pattern to correct follow removal of a PCS driver.

A PCS provider have to implement and call fwnode_pcs_add_provider() in
probe function and define an xlate function to define how the PCS
should be provided based on the requested interface and phandle spec
defined in fwnode (based on the #pcs-cells)

fwnode_pcs_get() is provided to provide a specific PCS declared in
fwnode at index.

A simple xlate function is provided for simple single PCS
implementation, fwnode_pcs_simple_get.

A PCS provider on driver removal should first call
fwnode_pcs_del_provider() to delete itself as a provider and then
release the PCS from phylink with phylink_release_pcs() under rtnl
lock.

---
Second PCS handling in phylink:

We have the PCS problem for the only reason that in initial
implementation, we permitted way too much flexibility to MAC driver
and things started to deviate. At times we couldn't think SoC
would start to put PCS outside the MAC hence it was OK to assume
they would live in the same driver. With the introduction of
10g in more consumer devices, we are observing a rapid growth
of this pattern with multiple PCS external to MAC.

To put a stop on this, the only solution is to give back to phylink
control on PCS handling and enforce more robust supported interface
definition from both MAC and PCS side.

It's suggested to read patch 0003 of this series for more info, here
a brief explaination of the idea:

This series introduce handling of PCS in phylink and try to deprecate
.mac_select_pcs.

Phylink now might contain a linked list of available PCS and
those will be used for PCS selection on phylink_major_config.

MAC driver needs to define pcs_interfaces mask in phylink_config
for every interface that needs a dedicated PCS.

These PCS needs to be provided to phylink at phylink_create time
by setting the .fill_available_pcs and .num_possible_pcs in phylink_config.
Helpers to parse PCS from fwnode are provided
fwnode_phylink_pcs_count() that will return the count of PCS entries
described in the firmware node and fwnode_phylink_pcs_parse() that will
fill a preallocated array of PCS pointer with the actual available PCS
(ignoring the one that still needs to be probed).

phylink_create() will fill the internal PCS list with the passed
array of PCS. phylink_major_config and other user of .mac_select_pcs
are adapted to make use of this new PCS list.

The supported interface value is also moved internally to phylink
struct. This is to handle late removal and addition of PCS.
(the bonus effect to this is giving phylink a clear idea of what
is actually supported by the MAC and his constraint with PCS)

The supported interface mask in phylink is done by OR the
supported_interfaces in phylink_config with every PCS in PCS list.

PCS removal is supported by forcing a mac_config, refresh the
supported interfaces and run a phy_resolve().

PCS late addition is supported by introducing a global notifier
for PCS provider. If a phylink have the pcs_interfaces mask not
zero, it's registered to this notifier.

PCS provider will emit a global PCS add event to signal any
interface that a new PCS might be available.

The function will then check if the PCS is related to the MAC
fwnode and add it accordingly.

A user for this new implementation is provided as an Airoha PCS
driver. This was also tested downstream with the IPQ95xx QCOM SoC
and with the help of Daniel also on the various Mediatek MT7988
SoC with both SFP cage implementation and DSA attached.

Lots of tests were done with driver unbind/bind and with interface
up/down also by adding print to make sure major_config_fail gets
correctly triggered and reset once the PCS comes back.

The dedicated commits have longer description on the implementation
so it's suggested to also check there for additional info.

It's worth to mention that OpenWrt is currently using this on
Mediatek SoC and QCOM ipq807x/ipq60xx/ipq50xx and Airoha are
already ported in staging tree for testing.

---

Changes v9:
- Rebase on top of net-next/main
- Drop early verification of supported_interface
  (it can also be provided by get_capabilites MAC OP)
Changes v8:
- Back to RFC (net-next closed)
- Address additional bug reported by Sashiko bot
  - Better handle priv interface for Airoha PCS driver
  - Better handle locking for modifying the PCS list in
    phylink code
  - Improve fwnode_phylink_pcs_parse() parsing on -ENOENT
  - Better handle error condition in phylink_create()
  - Turn down the link when current PCS is released
- Fix compilation warning caused by copy paste error
Changes v7:
- Address all the bug from the Sashiko bot
- Rename .num_available_pcs to .num_possible_pcs
- Link PCS in phylink_create()
- Correctly unregister the notifier on phylink_destroy()
- Introduce fwnode_phylink_pcs_count()
- Better handle locking in phylink for PCS handling
- Better handle unavailable PCS at phylink_create() time
- Improve Documentation file
- Other minor fixes to address suggestion from bot
- Rebase on top of net-next
Changes v6:
- Rebase on top of net-next
- Add Documentation files
- Add fw_devlink patch
- Fix some comments typo
- Rework the airoha_eth.c implementation with new multi serdes code
- Extend PCS code with PCIe and USB support
- Align schema to new property
Changes v5:
- Rebase on top of net-next
- Use the new force_major_config
- Reword some comments and commit description
- Return -ENODEV instead of -EPROBE_DEFER to perevent race condition
- Drop phy_interface_copy patch (Russell pushed an equivalent version)
Changes v4:
- Move patch 0002 phy_interface_copy to 0002 (fix bisectability
  problem)
- Address review from Lorenzo for Airoha ethernet driver
- Fix kdoc error with missing Return (actually missing : before Return)
- Fix UNMET dependency reported error for CONFIG_FWNODE_PCS
- Revert to pcs.c instead of core.c (due to name conflict with other kmod)
- Fix clang compilation error for Airoha PCS driver
- Add missing inline function to pcs.h function
Changes v3:
- Out of RFC
- Fix various spelling mistake
- Drop circular dependency patch
- Complete Airoha Ethernet phylink integration
- Introduce .pcs_link_down PCS OP
Changes v2:
- Switch to fwnode
- Implement PCS provider notifier
- Better split changes
- Move supported_interfaces to phylink
- Add circular dependency patch
- Rework handling with indirect addition/removal and
  trigger of phylink_resolve()

Christian Marangi (12):
  net: phylink: keep and use MAC supported_interfaces in phylink struct
  net: phylink: introduce internal phylink PCS handling
  net: phylink: add phylink_release_pcs() to externally release a PCS
  net: pcs: implement Firmware node support for PCS driver
  net: phylink: support late PCS provider attach
  net: Document PCS subsystem
  MAINTAINERS: add myself as PCS subsystem maintainer
  of: property: fw_devlink: Add support for "pcs-handle"
  net: phylink: add .pcs_link_down PCS OP
  dt-bindings: net: pcs: Document support for Airoha Ethernet PCS
  net: pcs: airoha: add PCS driver for Airoha AN7581 SoC
  net: airoha: add phylink support

 .../bindings/net/pcs/airoha,pcs.yaml          |  261 ++
 Documentation/networking/index.rst            |    1 +
 Documentation/networking/pcs.rst              |  229 ++
 MAINTAINERS                                   |    9 +
 drivers/net/ethernet/airoha/Kconfig           |    1 +
 drivers/net/ethernet/airoha/airoha_eth.c      |  194 +-
 drivers/net/ethernet/airoha/airoha_eth.h      |    7 +-
 drivers/net/ethernet/airoha/airoha_regs.h     |   12 +
 drivers/net/pcs/Kconfig                       |    8 +
 drivers/net/pcs/Makefile                      |    3 +
 drivers/net/pcs/airoha/Kconfig                |   12 +
 drivers/net/pcs/airoha/Makefile               |    7 +
 drivers/net/pcs/airoha/pcs-airoha-common.c    | 1324 +++++++++++
 drivers/net/pcs/airoha/pcs-airoha.h           | 1311 +++++++++++
 drivers/net/pcs/airoha/pcs-an7581.c           | 2093 +++++++++++++++++
 drivers/net/pcs/pcs.c                         |  261 ++
 drivers/net/phy/phylink.c                     |  366 ++-
 drivers/of/property.c                         |    2 +
 include/linux/pcs/pcs-provider.h              |   41 +
 include/linux/pcs/pcs.h                       |  140 ++
 include/linux/phylink.h                       |   30 +
 21 files changed, 6261 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml
 create mode 100644 Documentation/networking/pcs.rst
 create mode 100644 drivers/net/pcs/airoha/Kconfig
 create mode 100644 drivers/net/pcs/airoha/Makefile
 create mode 100644 drivers/net/pcs/airoha/pcs-airoha-common.c
 create mode 100644 drivers/net/pcs/airoha/pcs-airoha.h
 create mode 100644 drivers/net/pcs/airoha/pcs-an7581.c
 create mode 100644 drivers/net/pcs/pcs.c
 create mode 100644 include/linux/pcs/pcs-provider.h
 create mode 100644 include/linux/pcs/pcs.h

-- 
2.53.0

