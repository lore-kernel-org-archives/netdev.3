Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAAE3FF1AD;
	Wed, 17 Jun 2026 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781701116; cv=none; b=kwDEGV6WxqGwlTsF7MLKD3RJ8ah+wAQyEACkuxq5kNCmO17vC05ZU/J5vjMbJkWU+O4+BBbEmDSW3lU8nNDDNEN6UGw6pCGOvLirLQtL/KskAmcB/m1R8Ldtwl6Es5G+wABv9xsWIpcvt8s74LZcAyUIjlUrLYMekSyRLJ5TbJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781701116; c=relaxed/simple;
	bh=iK2ZWTSF7L93Etn4Phm9syUtj0nmrXOQvs6fpSsNjdo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oUdZXG8lUc4B6tLmxPyRyyK1pZ14skoLq5ZF70GxAQgxGi0iNZjEZYaO74kCZkC4IubDieW9x01OxIwveK2kcOy7DGnMSxYRYHz4ZuboqkwDd4PGOXFFBTFp2D6cwEcJwOLH+FDb1Kau0Uf5lUM8ETYoN6w0eGIk1tWaqTKf3cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFVnfYIw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFVnfYIw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEAA3C2BCB0;
	Wed, 17 Jun 2026 12:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781701116;
	bh=iK2ZWTSF7L93Etn4Phm9syUtj0nmrXOQvs6fpSsNjdo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=uFVnfYIw44Rju20GmDv1agE2BQdk0vOcHXQnRiklAoydXPbuMS0bVKDvnT2o1+qpG
	 GxvB9qiojRisB0rTz6u5bpW0buwedz6XNYmGPCooWYEd02T6BU0MgqMC1XsrUYjtmf
	 O6Jegj346CF6Qm3CVvtn/tOcJQ0bS5PLUWIk7K/NNN60eguudEUYGs5aV00cZIUmAQ
	 rC+BUWpWq+YRGHvXnC81lEnI516lXi7Pewh1Md44UKvErmRkMd8RlfJGJf26fNylYN
	 PdnlFR7DkRWdyD4VHr6nCAYmwBTJOz6p3+72yDLIkAZ5+qz1Yzx1UxoZuUqll9F6vE
	 jIEbQ67r9538g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC79CD98E2;
	Wed, 17 Jun 2026 12:58:35 +0000 (UTC)
From: Ricardo Pardini via B4 Relay <devnull+ricardo.pardini.net@kernel.org>
Subject: [PATCH v4 0/3] describe RTL8125 PCIe NICs on Rockchip boards (and
 add DT binding)
Date: Wed, 17 Jun 2026 14:58:27 +0200
Message-Id: <20260617-rk3588-dts-rtl-eth-describe-dt-alias-v4-0-2bd38922d129@pardini.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OTU7DMBAF4KtUXjPIv7HTFfdALCb2hAxUaWWbC
 FTl7jhFCASbLN/o6XtzFYUyUxHHw1VkWrjweW7B3h1EnHB+JuDUstBSd9JpC/nVuBAg1QK5noD
 qBIlKzDxQOwKeGAtERUkFP/jopGjUJdPI77eZx6evXN6GF4p1s7fGxKWe88ftj0Vtve9Jt29yU
 aAAuzEmdJ3B6B8umBPPfD9TFdvoon+z/U5WgwTbeym1Dcqa8T9rftgG72RNYwOG4Pxg+oR/2HV
 dPwFlosSemgEAAA==
X-Change-ID: 20260524-rk3588-dts-rtl-eth-describe-dt-alias-c1ed187b7c50
To: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Ricardo Pardini <ricardo@pardini.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3702;
 i=ricardo@pardini.net; h=from:subject:message-id;
 bh=iK2ZWTSF7L93Etn4Phm9syUtj0nmrXOQvs6fpSsNjdo=;
 b=owEBiQF2/pANAwAIATteP+Oex+3pAcsmYgBqMpn4fSKiL6WLMJiO4lZ7wl5/feW3yruuYoEgB
 W04aHyAtzaJAU8EAAEIADkWIQSsGCMM9q/qytxIiJM7Xj/jnsft6QUCajKZ+BsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQO14/457H7emxXwf/e94Y0R4VyLNLAv8lziyAVCXu4rrDeRG
 WPGnCHi0bhGdF/Yd1WZZoEHaNBvOA6eHWv8S3mRRHu42gd/nb9JWavMEVrRls1/loicvt5Xx7c2
 5bEfo7vMHQ3+IcP6haGXT487ZV31xbthuA3kqGdCNCT5Wr4YFXVoFKPOKnmhgHLb7R0u74OpAqe
 s9fW4Kt9/ffhqWcthbG9OX3XrKxrsJAmbAhpHqsyBK3+EwUaucMFZo5dVQuKjUaCn1zMwWMtKfQ
 a4GpYWcg/a2lky/qb0AVe8C2pAfI4x7bRO5dW6HWJSdVyBGoyHCg/gt7PSmHA/QZFHHMP1GIRm4
 80pmFQzWo6A==
X-Developer-Key: i=ricardo@pardini.net; a=openpgp;
 fpr=AC18230CF6AFEACADC4888933B5E3FE39EC7EDE9
X-Endpoint-Received: by B4 Relay for ricardo@pardini.net/default with
 auth_id=588
X-Original-From: Ricardo Pardini <ricardo@pardini.net>
Reply-To: ricardo@pardini.net

Several Rockchip rk35xx boards carry on-board Realtek RTL8125 2.5GbE
NICs whose PCI function nodes are not described in the DT. Describing
them allows for stable ethernetN aliases (matching the GMAC alias
convention on these boards) and lets U-Boot's fdt_fixup_ethernet()
inject mac-address properties from its ethaddr/ethNaddr env, so MACs
stay stable across boots and U-Boot and kernel MAC match.

Patch 1 adds a DT binding for Realtek RTL8125 family PCIe Ethernet
controllers.

Patch 2 describes the on-board RTL8125 function nodes on the
FriendlyElec NanoPC-T6 (and variants).

Patch 3 describes the on-board RTL8125 function nodes on the Radxa
ROCK 5B / 5B+ / 5T family done based on lspci output provided by
helpful Armbian folks.

---
Changes in v4:
- binding: simplify the binding YAML ref Sashiko's and Krzysztof's
  reviews
- binding: describe only the RTL8125 + rename to match ref Heiner's
  review.
- dt: fix the bus-range according to Sashiko's review.
- Link to v3: https://patch.msgid.link/20260605-rk3588-dts-rtl-eth-describe-dt-alias-v3-0-8a8857b39daf@pardini.net

Changes in v3:
- new patch: add a DT binding for Realtek r8169 family PCIe Ethernet
  controllers, per Sebastian Reichel's review (the "pciVVVV,DDDD" OF
  spelling still needs a binding when used in a board DT).
- new patch for Rock5 series, and include a brief rationale in each.
- retitle the series, since it now covers a few boards and a binding
  rather than just DeviceTree changes for the NanoPC-T6.
- drop the v2 "rename vcc3v3_pcie2x1l0 regulator" patch from this
  series; it will be sent separately as it is not relevant to this.
- Link to v2: https://patch.msgid.link/20260529-rk3588-dts-rtl-eth-describe-dt-alias-v2-0-49700248143f@pardini.net

Changes in v2:
- fix: pcie2x1l0, not pcie2x1l1; indirectly caught by Sashiko's review [1]
- while-at-it: rename regulator vcc3v3_pcie2x1l0 to l1
- Link to v1: https://patch.msgid.link/20260525-rk3588-dts-rtl-eth-describe-dt-alias-v1-1-a6fcda563ac7@pardini.net

[1] https://sashiko.dev/#/patchset/20260525-rk3588-dts-rtl-eth-describe-dt-alias-v1-1-a6fcda563ac7%40pardini.net

To: Heiner Kallweit <hkallweit1@gmail.com>
To: nic_swsd@realtek.com
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Ricardo Pardini <ricardo@pardini.net>

---
Ricardo Pardini (3):
      dt-bindings: net: add Realtek RTL8125 PCIe Ethernet
      arm64: dts: rockchip: describe PCIe RTL8125 Ethernet on NanoPC-T6
      arm64: dts: rockchip: describe PCIe RTL8125 Ethernet on Radxa ROCK 5 family

 .../devicetree/bindings/net/realtek,rtl8125.yaml   | 43 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi | 30 +++++++++++++++
 .../boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi   | 15 ++++++++
 arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts    | 18 +++++++++
 5 files changed, 107 insertions(+)
---
base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
change-id: 20260524-rk3588-dts-rtl-eth-describe-dt-alias-c1ed187b7c50

Best regards,
--  
Ricardo Pardini <ricardo@pardini.net>


