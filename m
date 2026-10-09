Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDA147AF5C
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 18:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570533; cv=none; b=UA/IfHb2/uHSyDNyLtiJ27uF5pYOF4cf2VkVqbXqlkX7R+39BFsHhHQIu0IxbOgSmbQqtZWNfokZyzVlc3wxBn2NJDENOoshrLmLiCWKWGNxSzd22h0raIOvIbm4ykW8jeiAbwjdIQHRXfjwbpDNu3wngSn+OqZOzTwwuh8+2Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570533; c=relaxed/simple;
	bh=IYyqgx5JcHOWkuqCp2zJcb0PCeEIP0YYVqn7rZlVMEg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jKXjhSDVURgfGUWDbK2nylUvafPBoRbsOXgvacgE6/FIOi8jidiLBKH5W7Yp7X4OvKS+lP9L0aoXVZcw2ljunM1N5Mw8uHugyoAiuD+dVywmivQg8uE5ZP8+Y4gcnk19ZGbpMwGrQKL9FJrL/bKS3+0zveOn/yPp6zoTAcp+jXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5CCiHxq; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5CCiHxq"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so85734f8f.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 11:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791570529; x=1792175329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=liOZ2qPZKDQcuxqPF4XuoGdGKnTH2Ji5nF/arH7paqc=;
        b=E5CCiHxqFgp0gqWr6frrtvhcEuSuEGznJZvurJcwWIBKFe5xQZaiDJtIZ+npnjDYcQ
         3WEKdbiEwgO9ycCaF7HX+p2+ZQJjIIgE6T9K0V6+Al0vnhGXK+w20bd9s/yn4ybmJtci
         Bun2NI+tNCiJg8qdVmRqNSXA+0C9pf6WuM5jHXsdZ9ViLSMa1ex0kCP6jStdIHsvXQzp
         6pNIYUBNFOwuHxzDxZCv68ui0VT9MltdZFdsujF/L8HLJ0mVJAQxh4A1vbJQduAJHF86
         mBy3ic6uLvBeR2oI47d6Hc2ZXT4MbSHex0TIKL3N+A9uLtomNFvV2tPNdh9a69tSdYOL
         B05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791570529; x=1792175329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=liOZ2qPZKDQcuxqPF4XuoGdGKnTH2Ji5nF/arH7paqc=;
        b=de2QQZhGoc1TWuvNTo4wzxL5wJZ6RivNvxyHZNKmKey9rrHxm4J36xmtLcX9pdZbpJ
         TPQfKHO3QEIw0EhjOA0omy6u8p78LYP2vCypCLXvb8yXwhe0IUJ2sUe2f0zGge4aEkiI
         202rrC4Tduv2w39Ow2VxA6D3xmXEslV2NQsmu8fbWTPpsSExOAa4/zehVKBOYa4IRckN
         UjwnMiSD/G7WBo9YLOBs1kUGcd1hp+21F3mfh7hLv1ajET7VcQNbOnjvDgFU81NXFmH9
         NGKjIVeAzoSS1cbbU5Hn9demrLBAxlb1gbv/JVsHDVBhrkIQ8Pqo1Kd6EZ9xXUku4jaS
         tK9w==
X-Forwarded-Encrypted: i=1; AKwUvBwwJmkJYwIMlJsls1CFB9/fkoPOPF0Od1vBTkfWkI+nVivzZDxM8nHw3rIBrxr+tv42qJgEvWw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKtyFA47sSnQNCLOPnDm8xcXKUuuQlwvd4gjaGM1yny+kDTBTWH
	OimUqDkIolmIlxVbSmZIB5m4HLgixAylgxwxtIVaNLA847pKeqVnL1fs
X-Gm-Gg: AYBFou2SxiccthZF+OhixabDjoC3hJS/xWIdEGk9ifB292ckWWCKIvZ7KjLCokn1inN
	j0e57snCsUbzgLzRTkhHLmhsbL4S2J5zWFMp6XQTL9AUFad0NfrXRZqi9ycGXzn+Ju01J0HESmU
	Fs9HW7IXb59rRNHj2k+hsIdeFAeO6C71/92t/RUCyS3DlpyG1GOICe2KnrEsQnG6NOqb5YQrsll
	FLxMOBxkC0gvH6+mbDCxGfUrHcYOK9SVjNdFyXMSIceZBWwPX7efJHo/+TdTcHyahnuULR0PpJ/
	tqhxJN6bDKD9GtjYQptP5mWoOxyGrnTrHKQbakLrrOcWjI7wPUUJz2/5vaixzi3WbTFhxhr0sE8
	5odG5WglDEZIgL1dIxBP5LotTkuEn+LkJ3b+BwfpMlTN3EWUDbgw/11ULYh6xGvi1ehOQzr4iac
	NlIPkEmbaDZrNRv4V1zSZ7lZzPTBbXAuplaiXZSrrqR3PP2A6ibfplCmp/i5KCCt58YU17+WA3J
	BrOT1jNskldSzLJxDKXCTn+d3YywE09zkzRO/cbzgeB5oCY9+Mu78dJdeE7KKKe+gWLSRuW1SRQ
	nh9GtIrVXTMv8j4Rjg+zDbgnjOM1
X-Received: by 2002:adf:efc3:0:b0:48b:6f3:667f with SMTP id ffacd0b85a97d-48dbacef900mr3994727f8f.56.1791570528649;
        Fri, 09 Oct 2026 11:28:48 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-213-45-9-252.retail.telecomitalia.it. [213.45.9.252])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48db9adf5e6sm5037794f8f.56.2026.10.09.11.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 11:28:48 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v18 00/12] net: pcs: Introduce support for fwnode PCS
Date: Fri,  9 Oct 2026 20:27:56 +0200
Message-ID: <20261009182836.50631-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
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
implementation, fwnode_pcs_simple_xlate.

A PCS provider on driver removal must call fwnode_pcs_del_provider()
to delete itself as a provider.

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

Changes v18:
- Improve handling on late PCS addition
- Fix wrong comment on airoha PCS driver
- Rebase on top of net-next
Changes v17:
- Rebase on top of net-next
- Add Review tag for DT patch
- Recalculate capabilities on late removal/attach
Changes v16:
- Rebase on top of net-next
- Add Tested-by tag
- Add ACK for airoha ethernet patch + nit fix 
Changes v15:
- Rebase on top of net-next
- Fix Coccicheck  warning
Changes v14:
- Fix deadlock when fill_available_pcs fails
- Move notifier and fill down after resolve disable bit is set
- Fix kconfig description
Changes v13:
- Fix regression in fwnode_pcs_get_from_pcsspec from v12
- Fix reverse lock for phy_lock and state_mutex
- Better handle lock in phylink_validate_mac_and_pcs and inband
- Fix wrong pointer to fwnode_pcs_add_provider notifier
- Fix compilation error for new C type in pcs_provider_notify
Changes v12:
- Fix kdoc for function
- Rework PCS provider add and delete to be provider driven (instead of
  relaying on scan of fwnode every time) (this also handle
  multi PCS scenario)
- Even further rework state mutex locking for concurrent pcs list
- Restore MAC supported_interfaces validation in phylink_create()
  wrongly dropped.
- Use get/put for fwnode reference
- Fix possible unment depndency for FWNODE_PCS
- Fix almost impossible problem for PCS calibration
- Hold rtnl with PCS deletion
Changes v11:
- Rework PCS release to notifier way (fix race as pointed out by bot)
- Add Ack from Lorenzo for Airoha Ethernet driver
- Introduce devm variant for pcs_provider_add
- Better support firmware node reference for PCS late attach
- Better protect list iteration with state mutex
- Minor fixup to airoha pcs driver (flow control fixup)
- Rebase on top of net-next
Changes v10:
- Minor code cleanup and fixes as suggested by bot
- Drop devlink patch
- Add reviewed by tag
- Configure old_link_state on PCS release
- Unlink PCS on error in phylink_create()
- Use list_add_tail
- Fix typo in Airoha PCS driver
- Update phylink migration guide
- Better handle late PCS attach (idempotent function and
  add unser state_mutex)
- Use dedicated lock in Airoha ethernet driver
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
  net: pcs: implement Firmware node support for PCS driver
  net: phylink: save phylink instance fwnode on phylink_create
  net: phylink: support PCS provider release
  net: phylink: support late PCS provider attach
  net: Document PCS subsystem
  MAINTAINERS: add myself as PCS subsystem maintainer
  net: phylink: add .pcs_link_down PCS OP
  dt-bindings: net: pcs: Document support for Airoha Ethernet PCS
  net: pcs: airoha: add PCS driver for Airoha AN7581 SoC
  net: airoha: add phylink support

 .../bindings/net/pcs/airoha,pcs.yaml          |  261 ++
 Documentation/networking/index.rst            |    1 +
 Documentation/networking/pcs.rst              |  234 ++
 Documentation/networking/sfp-phylink.rst      |   35 +-
 MAINTAINERS                                   |    9 +
 drivers/net/ethernet/airoha/Kconfig           |    2 +
 drivers/net/ethernet/airoha/airoha_eth.c      |  197 +-
 drivers/net/ethernet/airoha/airoha_eth.h      |    5 +
 drivers/net/ethernet/airoha/airoha_regs.h     |   12 +
 drivers/net/pcs/Kconfig                       |    8 +
 drivers/net/pcs/Makefile                      |    3 +
 drivers/net/pcs/airoha/Kconfig                |   13 +
 drivers/net/pcs/airoha/Makefile               |    7 +
 drivers/net/pcs/airoha/pcs-airoha-common.c    | 1303 ++++++++++
 drivers/net/pcs/airoha/pcs-airoha.h           | 1311 ++++++++++
 drivers/net/pcs/airoha/pcs-an7581.c           | 2100 +++++++++++++++++
 drivers/net/pcs/pcs.c                         |  314 +++
 drivers/net/phy/phylink.c                     |  416 +++-
 include/linux/pcs/pcs-provider.h              |   70 +
 include/linux/pcs/pcs.h                       |  174 ++
 include/linux/phylink.h                       |   28 +
 21 files changed, 6445 insertions(+), 58 deletions(-)
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
2.55.0

