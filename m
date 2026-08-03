Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4D035C183;
	Mon,  3 Aug 2026 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763927; cv=none; b=YQFwSZZs4br8RrVCzwYTWNvaOqino+2TsQgZkeDc1SWC0OgEJN4Ug5vB9OvWdRwu0wtqwKaV3KYqrJ3Y/pHo5vobfZ8Twac7O1sLZW/Nt3FTyukhSRMjrpF6EdhINEjdEo5Xu32gObkzLCVA5dF1/RvQBAkIo/2gJOGByvRP5U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763927; c=relaxed/simple;
	bh=9ff33wS8IPyJtj9+LwYLWA+CchM0/9Kcw0hwBUzW+G4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gfVfvha8bVlyH8wP1KrYMiZJLhBgUW5ciUyvouFRtaUv+dp57eCcTBze90Gaq26hMqMhigNKqis5MmAS0qAlJSjcLc/vKydw7L44EzorW2kgMBjUT9ZfYM/wdpfksY0Mu2aqDD8NBmFYfHNjtQFDQU6os79PV1NyF4u8ArE0Uy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=C8vOmgBW; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="C8vOmgBW"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAD751476;
	Mon,  3 Aug 2026 06:31:56 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A1033F66F;
	Mon,  3 Aug 2026 06:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785763920; bh=9ff33wS8IPyJtj9+LwYLWA+CchM0/9Kcw0hwBUzW+G4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C8vOmgBWumd/IrLAX0iAMZNyUPVhapYAbmX/j/z0X+O/FFMQD5S4wn8udWgUFFsEp
	 m/+quoEE+D3Yar9eKUcmRijRxITURBtedLeh8WzPSTQ3vEVB//l5JHCm18FBVrMDRc
	 Bk+KSaIRtckB745grmz9/GWcJd4/MWY4R1nPYrH0=
Message-ID: <2635661d-4be2-4abf-84aa-c3024941f787@arm.com>
Date: Mon, 3 Aug 2026 15:31:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/2] net: phy: Add Maxio MAE0621A support
To: Liu Changjie <liucj1228@outlook.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Luo Jie <jie.luo@oss.qualcomm.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <MN0PR19MB609154F210DF84DCB29D3696ACC62@MN0PR19MB6091.namprd19.prod.outlook.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <MN0PR19MB609154F210DF84DCB29D3696ACC62@MN0PR19MB6091.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

thanks for sending this, one question and an update below ...

On 7/17/26 05:39, Liu Changjie wrote:
> Add a binding and PHY driver for the Maxio MAE0621A Gigabit Ethernet
> PHY. The driver matches the exact PHY ID and optionally selects a
> 125 MHz clock on CLKOUT. When the property is absent, the driver
> preserves the hardware strap or bootloader setting.
> 
> This was tested on the LCKFB Taishan Pi 3M. With the PHY's default
> CLKOUT configuration, the RK3576 GMAC negotiated a 1 Gbit/s link but
> the data path did not work. A read-modify-write of page 0xa43,
> register 0x19, setting bits 0 and 11 produced a readback value of
> 0x0823 and restored the data path without changing the RGMII delays.
> The readback also confirmed that the unrelated set bits were
> preserved.
> 
> Only the 125 MHz setting has been exercised on hardware and only that
> value is exposed by this series. The 0 and 25 MHz choices from the
> initial draft have been removed.

So what is this clock for, exactly? Is that the RXC clock, supposed to 
depend on the line speed? Then it would need to change if a 100MBit/s 
link is negotiated?
Or is this something else entirely, and merely used as an optional 
auxiliary clock, to support a switch or other network chips?

If I read the schematic of that Taishan board correctly, it's the 
former? But it's odd that both on the Radxa Cubie A5E (sporting the same 
-Q3C variant) and the X96QPro+ box (-Q2C) don't need any extra setting, 
and the clock there looks like the normal PHY controlled RXC clock.

> Public documentation for the MAE0621A register is not available. The

There seems to be now a datasheet, explaining all the non-standard 
registers, including the one for the 125MHz clock out register:

https://www.lcsc.com/datasheet/C49308069.pdf

If the link doesn't work (in the future), just find the PHY in the LCSC 
catalogue, it should have a link to the datasheet there.

Cheers,
Andre

> exact definitions of page 0xa43, register 0x19 bits 0 and 11, their
> reset defaults, and whether a soft reset is required after changing
> them still need confirmation from Maxio. The register programming in
> this series is therefore supported by the hardware A/B result, not by
> a public datasheet citation.
> 
> Hardware tests with the 125 MHz setting:
> - all supported 10/100/1000 Mbit/s link modes
> - 100 ICMP packets in each direction with no loss
> - 936/934 Mbit/s host-to-board iperf3, no retransmits
> - 943/941 Mbit/s board-to-host iperf3, no retransmits
> - link unplug/replug and a normal reboot, followed by another 100 ICMP
>    packets in each direction with no loss
> - no RX errors, missed packets, carrier errors or collisions
> 
> Static tests on net-next commit f6f3b36c15ed:
> - dt_binding_check with dtschema 2026.6
> - W=1 arm64 defconfig build of drivers/net/phy/maxio.o with GCC 10.3
> - W=1 arm64 allmodconfig build of drivers/net/phy/maxio.o with GCC 10.3
> - git diff --check and checkpatch.pl
> 
> Changes in v2:
> - Extend hardware validation to all supported 10/100/1000 Mbit/s link
>    modes.
> - Keep the binding limited to the tested 125 MHz setting. CLKOUT-disable
>    support can be added later after its register behavior is documented
>    and tested.
> - No binding or driver code changes.
> 
> Link: https://lore.kernel.org/r/MN0PR19MB6091CD5A84D2DA5DACF434DAACF92@MN0PR19MB6091.namprd19.prod.outlook.com [v1]
> 
> Liu Changjie (2):
>    dt-bindings: net: Add Maxio MAE0621A PHY
>    net: phy: Add support for the Maxio MAE0621A
> 
>   .../bindings/net/maxio,mae0621a.yaml          |  38 +++++++
>   .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>   drivers/net/phy/Kconfig                       |   8 ++
>   drivers/net/phy/Makefile                      |   1 +
>   drivers/net/phy/maxio.c                       | 103 ++++++++++++++++++
>   5 files changed, 152 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/net/maxio,mae0621a.yaml
>   create mode 100644 drivers/net/phy/maxio.c
> 
> 
> base-commit: f6f3b36c15ed44de1fbb44e645e4fae8c4a4453e

