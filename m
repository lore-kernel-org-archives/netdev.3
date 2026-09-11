Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F409E47206C;
	Fri, 11 Sep 2026 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117801; cv=none; b=roivbyxDGdRsJTPqSR/1imvb25Ww15dVRDoLValR+iIBG2ZhSTFojbPE045Vxjx5+CkURvwJGj1ejjZ4Tyr/amge4krsh145rZ9l6QxekTBRb8AUeHAa48YIRrY/rsmXtuq4wE6M95w2aywC9HZP97fCDRr6lKeky3+L12mbsqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117801; c=relaxed/simple;
	bh=wZu00lwEYHUXbmU6RUXgRJ/UFLtfrncH2/xO6lkP158=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SW4nGyp5rdXgHJKiHTXN3EpiyBq7tWXu306qk39zTpwQxAOcEZcOZakAg57Wpu81FLKHAy5dwYgJXA4JsTCezwmxKHQNC5LnSShwpEQbLyHsaKjlg0c3/3s3YyEeQ4pDTK6fllshpufD1wqJppzTDAP2uKF2XpihCSlV7DIf1a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NO6UPQRE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NO6UPQRE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544651F000FF;
	Fri, 11 Sep 2026 09:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789117796;
	bh=2hReAYFbaxGE7WUYX7QFK0GSbkYIS1ZpzP9xYDx0bVc=;
	h=From:Subject:Date:To:Cc;
	b=NO6UPQREwYtwO6QRZXB9LUl8A4WZ/IUrxw9Bs8RvavtZaBQpsY+pJ/UBFNgHrkQ2L
	 yqOZxWC97hs92jS09MPHkjtb15Yf2jdMFs12VyMmwQ6a0dtFgSj8lwVo1j0hLYLDfM
	 npIZqqNjWCS3qOcT8Jg2iw/CCvZNPeR5Q125hKFQK4ovZ5lHgl6kRVc+B4d20CkPBg
	 lerar9qIfls2JphJOc47Indphjq7PCraIPo0W2MeOUcGetxyZa6zrHkhGbgOTfgCOx
	 i6Pa3AsvjFxhNqL+h6aqE2w5BC1g/vY0jEMm4kJDps03rwe1XCq8PHjmYeBMRb92Lg
	 tWRbYzpmkna7Q==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH net-next v12 0/4] net: dsa: microchip: Add support for
 KSZ8995XA/KS8995XA
Date: Fri, 11 Sep 2026 11:09:43 +0200
Message-Id: <20260911-ks8995-to-ksz8-v12-0-5c3422d0d72e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23SwU6EMBAG4FfZcBbTaTttx5PvYTwAne7iGjCAZ
 HWz725hD6DjjUK//2+GXouRh5bH4ulwLQae27Htu7wA/XAomlPVHblsY35RaKWdQkXleQxEWE5
 9fvoOJWAyiZqgPaQio4+BU3tZE1+Kjqey48tUvN6/jJ/1GzfTkrfsPbXj1A9fa/kMq7jXgPtbM
 0OpSq+i4mSrCpN9PvPQ8ftjPxzX9FnvvNbC6+zRg25UbIg9Cm/2Xvab7Bs0KjkECpSEt5t3ygh
 vs2dAsMRJA3vhce+t8Jg9hbri2iI7J8/v9j4I77KPBJkbjk0jvd+8/6ffZ6+rpDhP32IVhA+bD
 waED9mnCLGude0dS0+bJyXnT9mHGAJgRVBH6UHtA+QAQC03yHjShrh2KP8gwD6BZMJyBxUrawE
 qRIq/Em632w/8zkToTgMAAA==
X-Change-ID: 20260509-ks8995-to-ksz8-15f3f9c8271f
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Woojung Huh <Woojung.Huh@microchip.com>, 
 devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0

This series breaks with the dated attempt to polish the old
KS8995 driver, and instead implement support for the KS8995XA
in the KSZ driver, and after that delete the old KS8995 driver.

The hardware clearly has the same ancestry, the KSZ8995XA is
just a rebrand of the much older Micrel KX8995XA switch.

The old driver identified the shared 0x95/0x0 ID as KS8995MA, but
this ID cannot distinguish MA from XA. No KS8995MA users are known,
and KS8995E has no documented SPI management interface. Neither
variant has been verified with the replacement driver.

Add new compatibles, add special code paths for the KSZ8995XA,
including support for its two-level DCB priority model, and add a
new tagger for the special front tag found in the KSZ8995XA.

The patches, including the per-port PHY reset polling, were tested
with the Actiontec MI424WR rev D (which has the KS8995XA) and
OpenWrt as userspace.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Changes in v12:
- Program both KSZ8995XA port tag-control bits together, clearing the
  opposite setting so stale bootloader configuration cannot leave both on.
- Handle KS8995 receive tags in VLAN metadata as well as in-band,
  validating the source-port bits before deciding whether to untag.
- Reserve eight bytes of KS8995 transmit headroom for the switch tag
  and a hardware-accelerated VLAN tag, avoiding an extra head expansion.
- Link to v11: https://patch.msgid.link/20260909-ks8995-to-ksz8-v11-0-0e04411a559d@kernel.org

Changes in v11:
- Drop KSZ8995XA from the three-port binding exception so ports 3 and
  4 receive generic DSA port validation.
- Reject invalid KS8995 receive port masks before ilog2() so plain
  802.1Q frames are dropped safely.
- Propagate KSZ8995XA PHY reset assertion errors instead of treating
  a failed write as a completed reset.
- Do not advertise legacy VLAN behavior for KSZ8995XA, preserving genuine
  ingress VLAN tags through the DSA receive path.
- Link to v10: https://patch.msgid.link/20260908-ks8995-to-ksz8-v10-0-7379239eb65f@kernel.org

Changes in v10:
- Wait for the KSZ8995XA per-port PHY reset bits to clear before
  continuing setup; verified to work on Actiontec MI424WR rev D
  hardware.
- Drop the unreachable KSZ8995XA VLAN filtering check because the
  restricted switch operations do not expose that callback.
- Add KSZ8995XA to the binding's Ethernet-port schema exception list.
- Convert big-endian KS8995 transmit tag fields to host byte order
  before logging them.
- Align the KSZ8995XA SPI ID with its DT compatible to restore module
  autoloading and avoid the SPI registration warning.
- Link to v9: https://patch.msgid.link/20260906-ks8995-to-ksz8-v9-0-8d8815a91bd8@kernel.org

Changes in v9:
- Fold the legacy Micrel compatibles into KSZ8995XA support and use an
  exact tristate dependency to avoid probe races and bisect gaps.
- Always prepend a distinct KS8995 switch tag to preserve existing VLAN
  headers and avoid unsafe MAC-header access on direct transmit paths.
- Rate-limit KS8995 receive untagging errors to avoid log flooding.
- Link to v8: https://patch.msgid.link/20260831-ks8995-to-ksz8-v8-0-fd1dbb2b76e8@kernel.org

Changes in v8:
- Add DCB support for the KSZ8995XA two-level priority model and set its
  internal priority map count to two.
- Initialize the KSZ8995XA per-port default tags to VID 0 so the tagger can
  distinguish originally untagged packets from VLAN-tagged frames.
- Push non-802.1Q hardware-accelerated VLAN tags into the packet before
  adding the KS8995 tag, so they cannot displace the switch tag from its
  required offset 12.
- Account for the discrepancy between the documented and observed
  KSZ8995XA MTU behavior. Its packet-size control bits use the same
  polarity as the other KSZ8 switches, while using the opposite polarity
  documented in the manual makes the switch hang on big packets.
- Rebased on v7.3-rc1
- Link to v7: https://patch.msgid.link/20260704-ks8995-to-ksz8-v7-0-2af0eaa545a8@kernel.org

Changes in v7:
- Rebased on v7.2-rc1
- Rebased on top of Bastiens cleanups.
- Rebased and reworked on top of my patch changing the SKB ownership
  model in the taggers.
- Drop bogus reset routine, keep per-port reset but use the right
  defines.
- Properly implement the 2way queue split support (low/hi prio)
- Drop bogus surplus ops assignment.
- Link to v6: https://patch.msgid.link/20260608-ks8995-to-ksz8-v6-0-d91eb43edcc5@kernel.org

Changes in v6:
- Provide a prompt along with the transition symbol NET_DSA_KS8995
  so that oldconfig works.
- Clarify in commit message that the platform data probe path is
  unused in the kernel and it is fine to delete this mechanism.
- Link to v5: https://patch.msgid.link/20260604-ks8995-to-ksz8-v5-0-98baeb45e665@kernel.org

Changes in v5:
- Rebase on net-next again to be sure we apply.
- Fix the codepath where DCB was set up per-port, damaging KS8995XA
  port registers.
- Fix up the transitional symbol NET_DSA_KS8995 to depend on
  SPI and select both NET_DSA_MICROCHIP_KSZ_COMMON and
  NET_DSA_MICROCHIP_KSZ_SPI.
- Link to v4: https://patch.msgid.link/20260603-ks8995-to-ksz8-v4-0-e15149ef21e7@kernel.org

Changes in v4:
- Create a stub symbol for NET_DSA_KS8995 to phase over users to
  the new driver.
- Link to v3: https://patch.msgid.link/20260526-ks8995-to-ksz8-v3-0-c530f651989f@kernel.org

Changes in v3:
- Rebase on net-next again, moving target!
- Fix a netdev_info() print in the tagger to be netdev_debug()
- Add net/dsa/tag_ks8995.c to MAINTAINERS
- Link to v2: https://patch.msgid.link/20260522-ks8995-to-ksz8-v2-0-5712c0dc9e75@kernel.org

Changes in v2:
- Avoid trying to configure TOS priority settings (DCB) on the KSZ8995XA.
  It does have some support for this, but let's add that later.
- Pick up Krzysztof's ACK on the new DT bindings.
- Reset the KSZ8995XA by disabling and enabling the switch like the old
  driver does.
- Move mutually exclusive Kconfig over to the patch introducing the
  old Micrel compatibles to the Microchip ksz_spi driver.
  (this complaint from Sashiko.)
- Use __be16 instead of u16 when casting into the SKB in the tagger
  (this complaint from Sashiko.)
- Do not modify the hdr->h_vlan_TCI if no hardware accelerated tag
  is detected, it would get nullified. Use whatever the Linux network stack
  assigned to TCI there.
  (this complaint from Sashiko.)
- Avoid dereference of NULL in debug prints in the tagger.
  (this complaint from Sashiko.)
- Ignored comment: Sashiko complains about ilog2(0) being potentially
  undefined but that is clearly defined as 0 in the Linux kernel.
- Link to v1: https://patch.msgid.link/20260516-ks8995-to-ksz8-v1-0-70d0ef4aa5f4@kernel.org

---
Linus Walleij (4):
      dt-bindings: net: dsa: microchip: Add KSZ8995XA
      net: dsa: tag_ks8995: Add the KS8995 tag handling
      net: dsa: microchip: Support Microchip KSZ8995XA / KS8995XA
      net: dsa: ks8995: Delete surplus driver

 .../devicetree/bindings/net/dsa/microchip,ksz.yaml |   1 +
 MAINTAINERS                                        |   1 +
 drivers/net/dsa/Kconfig                            |   9 +-
 drivers/net/dsa/Makefile                           |   1 -
 drivers/net/dsa/ks8995.c                           | 857 ---------------------
 drivers/net/dsa/microchip/Kconfig                  |   1 +
 drivers/net/dsa/microchip/ksz8.c                   | 242 +++++-
 drivers/net/dsa/microchip/ksz8.h                   |   2 +
 drivers/net/dsa/microchip/ksz8_reg.h               |   2 +
 drivers/net/dsa/microchip/ksz_common.c             |  53 +-
 drivers/net/dsa/microchip/ksz_common.h             |  11 +-
 drivers/net/dsa/microchip/ksz_dcb.c                |  55 +-
 drivers/net/dsa/microchip/ksz_spi.c                |  33 +-
 include/linux/platform_data/microchip-ksz.h        |   1 +
 include/net/dsa.h                                  |   2 +
 net/dsa/Kconfig                                    |   6 +
 net/dsa/Makefile                                   |   1 +
 net/dsa/tag_ks8995.c                               | 153 ++++
 18 files changed, 499 insertions(+), 932 deletions(-)
---
base-commit: 17d3afadf539c93def8106bbb83c88274bdc7ab1
change-id: 20260509-ks8995-to-ksz8-15f3f9c8271f

Best regards,
--  
Linus Walleij <linusw@kernel.org>

