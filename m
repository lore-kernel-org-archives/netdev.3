Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B44C4CF471;
	Fri, 16 Oct 2026 23:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792194608; cv=none; b=eJYg7Y+PKwqm6R0fgTsV80QFlfCz7bux6cBTmj8hPlmMcxNcHQuojFLRLCRlh1kgu40R6TpNb7ZEYC+8ZYcwSjQnZMkZzoF2o3BsO7DdH3lo/Sl92gxqWRcVDz1Bq3gL3K231iTFZoYIHZl+NtDDh0RQlf7GYPvvIcgkfcsjSpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792194608; c=relaxed/simple;
	bh=Jzau5Zs36QLahvULJ0vVF89cMo9+XwnRCzgTGBuX7XQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e16OdUWVKxi1kW65a2ff2Re8lchL/iXzZ/5zW/Bsc3pwbxtRwKJyF+sV4JU5OpGNzSJbf4aVaHxn381bu/zBgCCfHSSRmHBGUu/lk/dZZZfUvDBxeEe45gBQ98Kd/1Ai4VIy1GPhHpYgmHBGleohNHcHimL3UZ9dsYntCESdZNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXfjNq8t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXfjNq8t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E5B1F000C4;
	Fri, 16 Oct 2026 23:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792194607;
	bh=Czw/lh14HoM3oBp7m7rksbbW1fhyazY+7Yq29EDqtac=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kXfjNq8t04Hiwf5WEPapYRF4cLesZZRXjvLQwH+3vKnIMagMVAa2M8VhTW7N7Pq1M
	 OTVlWPKtPfSQXSQbLsCglZpdHvzpgGfb5t37f2vPu0kqeb56c2AS63uJNZFo0W/gcT
	 72Ffk5CKCM4tGylliXhZqYsStfze1vCi4YiH4t8yp8CFAMYYB0dRo+rVVPf9xEvGjh
	 AbdXi3ZzTYKRO743Sl+DPoBTw5jMcdCB8aRA5FHhvBI7X7WPpyPrVbJARCAEjyHlI2
	 Z2N+TtmryiWaaD942/jdo1mA0aq3Yc6I8BG9AiunFpFx4fJhZgkcJXe92pMw7mPXke
	 PuNnkI/GhQqJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1581380CECD;
	Fri, 16 Oct 2026 23:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 00/13] ARM: dts: imx6ul: Extend VAR-SOM-6UL and add
 DART-6UL support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179219460577.1014323.18259783279842882110.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 23:50:05 +0000
References: <cover.1791487179.git.stefano.r@variscite.com>
In-Reply-To: <cover.1791487179.git.stefano.r@variscite.com>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: Frank.Li@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, pierluigi.p@variscite.com,
 stefano.r@variscite.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, shawnguo@kernel.org,
 qijian.guo@nxp.com, francesco.dolcini@toradex.com, josua@solid-run.com,
 ernest.vanhoecke@toradex.com, mehmet.fide@screeningeagle.com,
 Markus.Niebel@ew.tq-group.com, maudspierings@gocontroll.com,
 hvilleneuve@dimonoff.com, eichest@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 Oct 2026 21:37:40 +0200 you wrote:
> VAR-SOM-6UL already has mainline support on the Concerto-Board with
> i.MX6UL and i.MX6ULL. This series extends that support with additional
> module configurations, the Symphony-Board carrier and i.MX6ULZ variants.
> It also adds support for DART-6UL on VAR-6ULCustomBoard with i.MX6UL,
> i.MX6ULL and i.MX6ULZ.
> 
> The 90 new DTBs describe reference configurations with alternative
> storage, wireless and audio assemblies. These choices change the devices
> connected to the same SoM interfaces and require different controller,
> pin or device-node descriptions: eMMC versus NAND, SD card versus SDIO
> wireless, and the available wireless modules and audio codecs. They do
> not enumerate every possible combination of fitted and unfitted optional
> peripherals. The four existing Concerto DTBs remain available with their
> original names and compatible strings.
> 
> [...]

Here is the summary with links:
  - [v5,01/13] dt-bindings: arm: fsl: Add Variscite i.MX6UL board variants
    (no matching commit)
  - [v5,02/13] dt-bindings: arm: fsl: Add Variscite i.MX6ULL board variants
    (no matching commit)
  - [v5,03/13] dt-bindings: arm: fsl: Add Variscite i.MX6ULZ board variants
    (no matching commit)
  - [v5,04/13] net: phy: micrel: Check RMII clock select property presence
    https://git.kernel.org/netdev/net-next/c/5babd12ed114
  - [v5,05/13] dt-bindings: net: micrel: Fix RMII clock select property type
    https://git.kernel.org/netdev/net-next/c/1b93cd0f6584
  - [v5,06/13] ARM: dts: imx6ul: Extend VAR-SOM-6UL and add DART-6UL files
    (no matching commit)
  - [v5,07/13] ARM: dts: imx6ul: Add Variscite WM8904 and WM8731 support
    (no matching commit)
  - [v5,08/13] ARM: dts: imx6ul: Add Variscite storage and wireless options
    (no matching commit)
  - [v5,09/13] ARM: dts: imx6ul: Extend Variscite carrier board descriptions
    (no matching commit)
  - [v5,10/13] ARM: dts: imx6ul: Share Variscite PHY clock and update PHY options
    (no matching commit)
  - [v5,11/13] ARM: dts: imx6ul: Add Variscite i.MX6UL board variants
    (no matching commit)
  - [v5,12/13] ARM: dts: imx6ull: Add Variscite i.MX6ULL board variants
    (no matching commit)
  - [v5,13/13] ARM: dts: imx6ulz: Add Variscite i.MX6ULZ board variants
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


