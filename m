Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D384ADD9E;
	Fri,  5 Jun 2026 11:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780660156; cv=none; b=g2EtzL4U6cjgU7fPnB/l/oEKX1wNYXfiaZvBp+h2e/9q3YWMX7SvWTRusuiwixOj9OoKpGcKL6VwebnrdPNcFrwxk+Gf6eILdx6zuRYUlxIG/s3Kn/L986v+9/Egx+rXuRMSKUa+x9kUsZ64KXO9A+scTo8qpn1w/Ft1py1xvJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780660156; c=relaxed/simple;
	bh=tfvXGYpzHzgUbT4fabiFINiO/Hli57gjTIUW/sYiq14=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gox+1Ql4zYBbVxyKuq9j81Yvfa0c38cUFnqYbb+1+0+lWItK6iYQkdcAiJ4Hnd8VeZ/jpSljIoLBlK8o9COt9MfG2Z+Dme5MvYTamuQkfbwjbUo6TF0/ydyq47x4VzVu4EtldFRD9ipUrg5wryM5PU5J1itaKMrrRKUr0FEuDe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpEJ3aTq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpEJ3aTq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DADB3C2BCB4;
	Fri,  5 Jun 2026 11:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780660156;
	bh=tfvXGYpzHzgUbT4fabiFINiO/Hli57gjTIUW/sYiq14=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=TpEJ3aTqK3Ke/9+fIlU+olDB3VyMDoJDXr0r9jj66qTMUwbeANvZdSD1VeFr8zgYf
	 gkTX4nj09ggSmo5VCvY6OIEQAq/T/cHfAEor9jgEzxtekk73N0clLTjgxSSGv/7OVd
	 h7jqBo58NSmSUiNAqojEJiYXMArELZxIUkH26lugOrjCp5ouiGtLrDex83hNWJ7iB8
	 7gl+EU0eH6k2VEtA/i1ArvceLVUAwHtF1TfHKDNRAKXfIlY1cgJLNDY/wvm9qTAyhi
	 4O/SuGxqdhJqswAxgT2mcjxsP44VpHTryXZSIZXkeuONdaQ4+LEpoFWMsDYsbDRU7B
	 dE8bUTIgRFmAQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF733CD6E79;
	Fri,  5 Jun 2026 11:49:15 +0000 (UTC)
From: Ricardo Pardini via B4 Relay <devnull+ricardo.pardini.net@kernel.org>
Subject: [PATCH v3 0/3] describe RTL8125 PCIe NICs on Rockchip boards (and
 add DT binding)
Date: Fri, 05 Jun 2026 13:49:07 +0200
Message-Id: <20260605-rk3588-dts-rtl-eth-describe-dt-alias-v3-0-8a8857b39daf@pardini.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OzQ6CMBAGX4X07Jq2UH48+R7GQ2kXWTWFtJVoC
 O8uYEz0xnE2X2Z2ZAE9YWCHZGQeBwrUuRnSXcJMq90FgezMTHKZcyUz8LdUlSXYGMDHO2BswWI
 wnmqcj6DvpAMYgVaURV0Yxdms6j029Fwzp/OHw6O+oomLe1m0FGLnX+sfg1h236TalhwECNB5Y
 6xWeapNcey1t+Ro7zCyJTrIX221USuBQ1YVnMusFFna/GunaXoDhth9zkMBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3319;
 i=ricardo@pardini.net; h=from:subject:message-id;
 bh=tfvXGYpzHzgUbT4fabiFINiO/Hli57gjTIUW/sYiq14=;
 b=owGbwMvMwMFoHWf/eN7xty8ZT6slMWQpbd8l9ppxGm9Z+qldOh58e89cS7V+FJzGyqzcGLDzo
 FtUWf7KTkZ/FgZGDgZLMUWWNRLKPN/Wvzp1x6NjMswgViaQKdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Z2ikY6BjzMDFKQBTXfiC/X+iBof8pSn+UyotKn6xTXr3xbUg2Pj34n/ztRb/DtSuWOa0b8GhCcH
 MFz8oeW2T7Yov5/5f5vXKTeOXhLAyn4PVp+1BvFGqy69/uyJguMPyynW93YrLNvFyl2SbRwfNe3
 Pmc2P1wjQ2yYq5n9bY+2z6/+DvkZLL8QyvPOW/i7v38f0OsmVKflC1/ny8hOQRljmZL810+xeF3
 SxUyrh69ECWzlZFHRkG9p2dZ4xWiuWdbPPs7vGRuSpjavPkRE695iU9g8b/mvePp+bdYNKaPz3T
 Z+lHIb4dc/i3mjEW7LWM3ftQ6ewmw/VNvYmPF6v90ZW0K5yhxV52YnLyWcOPEott6suLbi9hX6R
 +TVEnHAA=
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

Patch 1 adds a DT binding for Realtek r8169 family PCIe Ethernet
controllers.

Patch 2 describes the on-board RTL8125 function nodes on the
FriendElec NanoPC-T6 (and variants).

Patch 3 is the same, but for the Radxa ROCK 5B / 5B+ / 5T family
done based on lspci output provided by helpful Armbian folks.

---
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
      dt-bindings: net: add Realtek r8169 family PCIe Ethernet
      arm64: dts: rockchip: describe PCIe RTL8125 Ethernet on NanoPC-T6
      arm64: dts: rockchip: describe PCIe RTL8125 Ethernet on Radxa ROCK 5 family

 .../devicetree/bindings/net/realtek,r8169.yaml     | 54 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi | 30 ++++++++++++
 .../boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi   | 15 ++++++
 arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts    | 18 ++++++++
 5 files changed, 118 insertions(+)
---
base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
change-id: 20260524-rk3588-dts-rtl-eth-describe-dt-alias-c1ed187b7c50

Best regards,
--  
Ricardo Pardini <ricardo@pardini.net>


