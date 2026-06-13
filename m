Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8871538AC6A;
	Sat, 13 Jun 2026 01:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781313625; cv=none; b=qIULUGqE1dS0cvAzpDwaci/tmFlWiEUvwXvPHlMchSMO/Cep3HuHGO9AM8TjdosizVwzJAb9jEYcSC51Q81ot6pmDWPHdyzlM7oLdVynTQlrrFrepo6DiBgRtEYMIE23ogYbg+ib2UPmVK/riQgHkb/rRUC25i5XcZMKck39YWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781313625; c=relaxed/simple;
	bh=84CpOJkdZCFir8st5kyGHSjsPyktDjaHNuTVfgvlclk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cf69RseWALEitU1wVVZG98voI06Hh/rUBNYoa/XY77ndGzHKswsCwIUvkosXJk89A62d/tO06JzklXbkowTDaMGRYk0eC608+QCqfoubYkncwIdbWJq3rUcvcbRIJFUYSGmotT2Ifcjn5v1vjWfThQbdTcTTFMHeDFM+GBPz2tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3SBtoih; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3SBtoih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8AB1F000E9;
	Sat, 13 Jun 2026 01:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781313623;
	bh=tdesUJBUuGtmIZkR5LhtnJJL+Z1i/RT/i62u3EL1di4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=f3SBtoihbDrVbNYwKz6moxzMk9T9ESz9aRuZCRdt6KAcyHRwB3VqIBxLhXT5f7r/1
	 1I2SV/M+QgCfLcyoK9BniFWEIrADxzAX9e7auGjhQu0fkbWaY4gzfaK0K/CsNUMZQu
	 NcTdGe0OemWfdoWZq4fWs8Vy3VmHXPQjAjSYe+kjB1Jjba1LsTR8/yPSDFu/rmScdo
	 c/LDKCmb2Hc1lGxeOzYHYmDoO7S/aLdkvEbg9RsIZ5JXQViWb+CbWrva9lgAcdEHwm
	 mh/b8M1GfkUOShKbDU/pL6mcaGPdQdtmQRxIBr2b6YaCvwc8GiQbN+kybipE8fncFA
	 nl+TXxZDZlT2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09EE39E9607;
	Sat, 13 Jun 2026 01:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/10] net: dsa: microchip: remove unnecessary
 dsa_switch_ops callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178131361939.1320584.3348315807801285505.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 01:20:19 +0000
References: <20260608-clean-ksz-3rd-v2-0-6e61b7be23c4@bootlin.com>
In-Reply-To: <20260608-clean-ksz-3rd-v2-0-6e61b7be23c4@bootlin.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 tristram.ha@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, vladimir.oltean@nxp.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 08 Jun 2026 16:10:03 +0200 you wrote:
> Hi all,
> 
> This series continues the rework of the KSZ driver initiated by two previous
> series (see [1] & [2]).
> 
> The KSZ driver handles more than 20 switches split in several families.
> This was previously handled through a common set of dsa_switch_ops
> operations that used device-specific ksz_dev_ops callbacks. The two
> previous series have split this common struct dsa_switch_ops into 5
> to connect the ksz_dev_ops's implentations directly to the new
> dsa_swicth ops.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/10] net: dsa: microchip: remove useless common cls_flower_{add/del} operations
    https://git.kernel.org/netdev/net-next/c/e6759c4acc8c
  - [net-next,v2,02/10] net: dsa: microchip: remove VLAN operations for ksz8463
    https://git.kernel.org/netdev/net-next/c/b54a8087c43c
  - [net-next,v2,03/10] net: dsa: microchip: implement get_phy_flags only if needed
    https://git.kernel.org/netdev/net-next/c/4d574a5cfa48
  - [net-next,v2,04/10] net: dsa: microchip: wrap the MAC configuration checks in a function
    https://git.kernel.org/netdev/net-next/c/c90e80103ba5
  - [net-next,v2,05/10] net: dsa: microchip: remove setup_rgmii_delay() KSZ operation
    https://git.kernel.org/netdev/net-next/c/b97d51f4501c
  - [net-next,v2,06/10] net: dsa: microchip: implement .support_eee() only if needed
    https://git.kernel.org/netdev/net-next/c/d654b3241436
  - [net-next,v2,07/10] net: dsa: microchip: implement .{get/set}_wol only if needed
    https://git.kernel.org/netdev/net-next/c/75ad8c1bc79f
  - [net-next,v2,08/10] net: dsa: microchip: implement port_hsr_join for KSZ9477 only
    https://git.kernel.org/netdev/net-next/c/e33c16843686
  - [net-next,v2,09/10] net: dsa: microchip: implement lan937x-specific MDIO registration
    https://git.kernel.org/netdev/net-next/c/03d10c776802
  - [net-next,v2,10/10] net: dsa: microchip: implement port_teardown only if needed
    https://git.kernel.org/netdev/net-next/c/af472a40b276

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


