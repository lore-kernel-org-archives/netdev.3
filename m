Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E88A2DFF3F;
	Mon,  3 Aug 2026 13:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763597; cv=none; b=SIY9zZVR5XJ4E2HUISXmMmGQv+9WbdM/0/2/kGbPyXhYW2AyEPTBaBtEPMX1WQmkB8Ripc+fjGUlNs7wsRJv3S9MGbyW6/rWxT9+2fEWtIkxGZTwv+ENp+PA/Wgnx3QPvkuOpmqWDY117qT7rIcczXBhJTLvSdGEteGaIN+kchs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763597; c=relaxed/simple;
	bh=CgQekaSBKiwGwQlmTbvZap2wDYLYC+sOdOFwQID3ujw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JwwCgM7WcK+3CnLvh5+neYjwT5+osD7Mxe6AS8UOf1FcgDA0dMAEY+IQiQmQ+njMmAjl2nuwUlbiJF31LqKvd8xIUU2aXTQyEXvL9IfHPi7gxSjlIoC2eixY9VwUH6mc1+uTPGn+0Yu3H7T0Q/0KAQLJ/pMP4zzE2eNXcdjPXTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=AI8wdpcm; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="AI8wdpcm"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEB4C143D;
	Mon,  3 Aug 2026 06:26:24 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 035753F66F;
	Mon,  3 Aug 2026 06:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785763588; bh=CgQekaSBKiwGwQlmTbvZap2wDYLYC+sOdOFwQID3ujw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AI8wdpcm2aMKJ505gancdMukS3yvBZ+XAjUyHzPdkagYkGQKeNh/ALlU/SNiXk3Cp
	 99KN05T3EoniLvdPjUA48uB3JMJMmrZUGaKiwppIlNJ8+a2ITl/xMoY+XD2DdG/Xth
	 FyRAseTyc8hKX/MGOK1sCHQoX6Sc2OruSHJivWpU=
Message-ID: <aaec8809-8218-4412-a60d-931406dbf287@arm.com>
Date: Mon, 3 Aug 2026 15:26:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/21] net: phy: add X-Powers AC200/AC300 EPHY support
To: James Hilliard <james.hilliard1@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Maxime Ripard <mripard@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Saravana Kannan <saravanak@kernel.org>,
 Lee Jones <lee@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 mfd@lists.linux.dev, linux-rockchip@lists.infradead.org
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

thanks for sending this to the list, but as Andrew already mentioned: 
this is quite a beast, and would need to be broken down.
Jernej and I created some patches just for the AC200 PHY on the H6, 
which Jernej recently revived, and IIUC, wanted to send to the list. 
This would probably be a more workable route: start easy, then add 
support for more SoCs (H616 depends on the WIP PWM driver) and more 
variants (AC300) later.

Which also brings me to some attribution questions: If I understand 
correctly, this has been written mostly by some LLM? I think you would 
need at least to disclose that, if not even add an official tag?
Also I wonder how this relates to the patches floating around for a 
while already: https://github.com/jernejsk/linux-1/commits/ac200-v4. 
This branch is relatively new, but the ac200-v3 branch for instance is 
much older.

On 8/3/26 07:14, James Hilliard wrote:
> The Allwinner H616/H618 secondary EMAC is commonly connected to a Fast
> Ethernet PHY in an X-Powers AC200 or AC300 companion package.  The two
> packages expose the same link PHY ID and largely compatible link-side
> registers, but require different control paths before those registers can
> be accessed: AC200 is initialized through its I2C MFD, while AC300 uses a
> non-PHY Clause 22 control endpoint.
> 
> Some H616-family products were shipped with either package under the same
> board identity.  For those systems, this series uses a SID NVMEM field to
> select the control provider at run time.  With CONFIG_OF_DYNAMIC, the link
> PHY enables only the selected fail-needs-probe provider, so an AC300 board

Just to bring that shallow discussion we had on IRC to the list: I 
wonder if this is the right solution? Alternatively I was wondering if 
just patching the DT in U-Boot would simplify things, and also help 
other DT users like *BSD or U-Boot (proper) itself, to not boil the 
ocean, but just allowing them to follow a standard DT description.

Cheers,
Andre

> does not probe the unused AC200 I2C controller or claim its pins.  The same
> drivers also support fixed descriptions without CONFIG_OF_DYNAMIC: a board
> can reference one enabled provider, or enable both candidates when runtime
> selection is still required.
> 
> The series adds:
> 
>    - the H616 EMAC1 binding, stmmac variant and controller node;
>    - generic MDIO OF reconfiguration support for PHYs, packages, scanned
>      addresses and generic MDIO devices;
>    - the AC200 MFD and AC200/AC300 EPHY control providers;
>    - the shared AC200/AC300 link-PHY driver, including calibration, power and
>      reset sequencing, MDI/MDI-X, statistics, EDPD, PHY-managed EEE, package
>      LEDs, interrupts and Wake-on-LAN; and
>    - H6 and H616-family device-tree descriptions and arm64 defconfig support.
> 
> The AC200 and AC300 control and link paths were exercised on H616-family
> hardware during development, including link traffic, address handling,
> ethtool EDPD/EEE controls, statistics and LEDs.  The H6 interrupt and
> Wake-on-LAN description still needs validation by an H6 hardware user.
> 
> This series depends on Richard Genoud's v7 H616 PWM controller series,
> which provides the bypass clock used by the companion EPHY:
> 
>    https://lore.kernel.org/all/20260703152215.192859-1-richard.genoud@bootlin.com/
> 
> The PWM patches are an external prerequisite and are intentionally not
> included in this 21-patch series.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> James Hilliard (18):
>        net: mdio: factor out OF child registration helpers
>        net: mdio: make device map changes hotplug-safe
>        net: mdio: support dynamic OF device changes
>        dt-bindings: net: x-powers: add AC200 EPHY control
>        dt-bindings: mfd: x-powers: add AC200
>        mfd: add X-Powers AC200 support
>        net: phy: add X-Powers AC200 EPHY control driver
>        dt-bindings: net: x-powers: add AC300 EPHY control
>        net: phy: add X-Powers AC300 EPHY control driver
>        dt-bindings: net: x-powers: add AC200/AC300 EPHY
>        net: phy: support configuring PHY-autonomous Tx LPI
>        net: phylink: allow PHY-autonomous EEE without MAC LPI
>        net: phy: add X-Powers AC200/AC300 EPHY driver
>        arm64: dts: allwinner: h616: add ACx00 EPHY resources
>        arm64: dts: allwinner: orangepi-zero2w: enable Ethernet expansion
>        arm64: dts: allwinner: h6: add AC200 EPHY resources
>        arm64: dts: allwinner: h6: tanix: enable AC200 EPHY
>        arm64: defconfig: enable X-Powers ACx00 Ethernet support
> 
> Richard Genoud (3):
>        dt-bindings: net: allwinner: add H616 EMAC1
>        net: stmmac: sun8i: add support for Allwinner H616 EMAC1
>        arm64: dts: allwinner: h616: add EMAC1 controller
> 
>   .../devicetree/bindings/mfd/x-powers,ac200.yaml    |  118 ++
>   .../bindings/net/allwinner,sun8i-a83t-emac.yaml    |   18 +-
>   .../devicetree/bindings/net/snps,dwmac.yaml        |    2 +
>   .../bindings/net/x-powers,ac200-ephy-ctl.yaml      |   46 +
>   .../bindings/net/x-powers,ac300-ephy-ctl.yaml      |   77 ++
>   .../bindings/net/x-powers,acx00-ephy.yaml          |  217 +++
>   arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi |   45 +
>   arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi       |   73 +
>   .../boot/dts/allwinner/sun50i-h616-acx00-ephy.dtsi |   61 +
>   arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi     |   51 +
>   .../dts/allwinner/sun50i-h618-orangepi-zero2w.dts  |   13 +
>   arch/arm64/configs/defconfig                       |    6 +
>   drivers/mfd/Kconfig                                |   13 +
>   drivers/mfd/Makefile                               |    1 +
>   drivers/mfd/ac200.c                                |  302 ++++
>   drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |   21 +
>   drivers/net/mdio/of_mdio.c                         |  508 ++++++-
>   drivers/net/phy/Kconfig                            |   30 +
>   drivers/net/phy/Makefile                           |    3 +
>   drivers/net/phy/mdio_bus.c                         |   14 +-
>   drivers/net/phy/mdio_bus_provider.c                |  140 +-
>   drivers/net/phy/mdio_device.c                      |  235 +++-
>   drivers/net/phy/phy.c                              |   35 +-
>   drivers/net/phy/phy_device.c                       |  127 +-
>   drivers/net/phy/phylib-internal.h                  |    4 +-
>   drivers/net/phy/phylink.c                          |   35 +-
>   drivers/net/phy/xpowers-ac200-ctl.c                |  330 +++++
>   drivers/net/phy/xpowers-ac300-ctl.c                |  454 ++++++
>   drivers/net/phy/xpowers-acx00.c                    | 1457 ++++++++++++++++++++
>   drivers/net/phy/xpowers-acx00.h                    |   27 +
>   include/dt-bindings/mfd/x-powers,ac200.h           |   13 +
>   include/linux/mdio.h                               |    6 +
>   include/linux/phy.h                                |   36 +
>   33 files changed, 4384 insertions(+), 134 deletions(-)
> ---
> base-commit: 075b74841bd0065a3bda3440873c747938e69b68
> change-id: 20260802-submit-acx00-of-dynamic-v1-94a0dc15f282
> prerequisite-message-id: <20260703152215.192859-1-richard.genoud@bootlin.com>
> prerequisite-patch-id: 8c447ebd677ea7bf9e63a77d34d8fdaa05eebe7f
> prerequisite-patch-id: c7574f9c0e2571ce8c6129ac6db7aa959c986ef3
> prerequisite-patch-id: e8b00768102951244927ecf054314f6e02f9ff1b
> prerequisite-patch-id: a3e2055ed7f3b5751a3e02d57e674b25ee404ff7
> 
> Best regards,
> --
> James Hilliard <james.hilliard1@gmail.com>
> 

