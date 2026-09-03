Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7CC175A9D;
	Thu,  3 Sep 2026 02:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788401487; cv=none; b=oFb/1PvRK9ubXhne7dnyJhxBKLn/3a/QBfRSPjnt39SkhRQAlhWXhnOKHKkopviULGGkppkc4kc4/00dRus8OgAuAzQfI5QJMghsklBGTn+43CiVrixxGmoJ1LupeGDW4wrl5ut5HW12saIVy9LFr/8Jcv2qQ2CqATa2c5fHw9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788401487; c=relaxed/simple;
	bh=P7qa9QjRVWobqSBV6sSx/3sPUbNV5jmWEl/ZxwfphCc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=isPylT1f/sqKXiV6K5kqtmJTzZO0f19sXPZKZ23nXPEG2Qd4Y/J4UY7Qe2PEBU07QocAfyfLIIzX7OlSMvwpoNrd4spq/vATAoXPBZzbTcrlqgwNHO4QpWrotosFd3gvefqUG1tXVk3N1SPGEOG1XJysUxKjYSmOWY1bZPSAntk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opiOf8p+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opiOf8p+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38C91F000E9;
	Thu,  3 Sep 2026 02:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788401485;
	bh=jsLIZ1+Oo0USNfs6WZ3ohesOY6oLKK9O64JfxHs0IlM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=opiOf8p+fx/Ep8KDbuuYxS9q0qssDWINerrU72TFbtjY9ApgGpA7QTgnjJDQOK04z
	 F64CUc0sy0ddNee6hWJc98mlgv1OAce++w7qNtV/9BMZC4P3RDkypPH4UAB20mT1J8
	 s0EvFu+UFSfOV3UY8NQTR3lA4ZD7ELivsugZeGVDgbHCpSaq4UQ32HjyvQq976sype
	 sT9E0RQjzQhE8D6i9i+im9V75sj0F4O7s0EZNXRfq5G+w1CTMjMhr+qMSyEnqAli+H
	 5TevuwRZB+ppumpveCLfZpzhKaJ/nBcxchG6pRc5MaWpDYAaFxJZYyo0RQQOeneeXQ
	 VfCWkHGQ/C0Mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C5B3927056;
	Thu,  3 Sep 2026 02:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v15 00/13] net: mdio: realtek-rtl9300: Add
 RTL83xx
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178840142714.3044566.2508555848930726226.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 02:10:27 +0000
References: <20260831143439.2404484-1-markus.stockhausen@gmx.de>
In-Reply-To: <20260831143439.2404484-1-markus.stockhausen@gmx.de>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
 daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Aug 2026 16:34:26 +0200 you wrote:
> The Realtek Otto switch platform consists of four different series
> 
> - RTL838x aka maple   : 28 port 1G Switches
> - RTL839x aka cypress : 52 port 1G Switches
> - RTL930x aka longan  : 28 port 1G/2.5G/10G Switches
> - RTL931x aka mango   : 56 port 1G/2.5G/10G Switches
> 
> [...]

Here is the summary with links:
  - [net-next,v15,01/13] dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series
    https://git.kernel.org/netdev/net-next/c/c3a1b6763f4d
  - [net-next,v15,02/13] net: mdio: realtek-rtl9300: Add polling documentation
    https://git.kernel.org/netdev/net-next/c/1c86cd693716
  - [net-next,v15,03/13] net: mdio: realtek-rtl9300: deny C45 over C22 access
    https://git.kernel.org/netdev/net-next/c/3383b50c1695
  - [net-next,v15,04/13] net: phy: add phy_detach_internal() helper
    https://git.kernel.org/netdev/net-next/c/2df76677c1c0
  - [net-next,v15,05/13] net: phy: add (*notify_phy_attach/detach)() hooks to struct mii_bus
    https://git.kernel.org/netdev/net-next/c/4b1d5d51528a
  - [net-next,v15,06/13] net: mdio: realtek-rtl9300: suppress sysfs bind/unbind attributes
    https://git.kernel.org/netdev/net-next/c/fe7a07ff5194
  - [net-next,v15,07/13] net: mdio: realtek-rtl9300: Configure hardware polling during probing
    https://git.kernel.org/netdev/net-next/c/ee18e22c6342
  - [net-next,v15,08/13] net: mdio: realtek-rtl9300: Add page tracking
    https://git.kernel.org/netdev/net-next/c/cc3cb8db1eef
  - [net-next,v15,09/13] net: mdio: realtek-rtl9300: Increase MDIO timeout
    https://git.kernel.org/netdev/net-next/c/6be4be074be8
  - [net-next,v15,10/13] net: mdio: realtek-rtl9300: Open up C22 and C45 space in parallel
    https://git.kernel.org/netdev/net-next/c/cc7a5bfaea14
  - [net-next,v15,11/13] net: mdio: realtek-rtl9300: Add support for RTL838x
    https://git.kernel.org/netdev/net-next/c/6ab6cb66b3b9
  - [net-next,v15,12/13] net: mdio: realtek-rtl9300: Add support for RTL839x
    https://git.kernel.org/netdev/net-next/c/11b8be84ccaf
  - [net-next,v15,13/13] net: mdio: realtek-rtl9300: reword Kconfig and module description
    https://git.kernel.org/netdev/net-next/c/d4ce2cef189e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


