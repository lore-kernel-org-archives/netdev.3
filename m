Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEDB21CC59;
	Thu, 11 Jun 2026 23:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781218821; cv=none; b=WY60yeVE28M0VDUmCLf47C2eofsIftE7XFYX55l99hLXZsgOoJpLUVisQOf1ZhSq+OUunMyI757YDVSy/5HoxHBdM09YVOn4mvrzTCtyfJMe5wB43l+tOGPWoCsSLY8TrqXJwFfyD2TK/McgpWOsizb3dIpnH3ec3fKw17MMp5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781218821; c=relaxed/simple;
	bh=VoCsTSoTByRBFLT58EhugOdy0Lh/UeFOVyiiUgZHmxg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jmo5MKlPMQh2qf8iW1yj4IbttUN+jWfb+QiV5uPqET+pLC8DGjsJ+nebBXTomz2Df8A9pOo/ntidYyuf/PWRe3rd5j07gttD4fvxRn4yYrQO/t+gxTLL3bWtmAZ2FCATpDGX+I/Odv7bzqNBb1A+U0z4mEWODysz1HAGKjr9Bzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsfJ40Nl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsfJ40Nl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7CD1F000E9;
	Thu, 11 Jun 2026 23:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781218819;
	bh=jDGfFn2KEiiONblxjqElyzZGfZI1fC5PCDvVnAfxoJM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MsfJ40NlwSgaCTcuD+B5ADH94U6UHEsxzkqMs9lB13smGiyDuVv2MQtCp0ReywmnU
	 uSbFL/YkIlWZsx0DE6PD6S5v6zYgbMAujZZtyDobQnYtN2isZbej645Ew2BHCHxLvg
	 h2k3YNuSwGo38WqIdx0g5A2CsjNTQprs74LraOt40qcGSkNXsA3Qz1Tzp1KaZuLutG
	 SVJN2G9fXPwSspFJjrme6Y4OuWpTHF4p21YUQFe2bnDqhG0Gm9xBTJARyKNlO0Gn/q
	 OQlZaWJerb0OZFxfH7cqxiZr73QEy8HKBZL8xpyRi0QWZwdDfsAQ9TW/14R9tfXh1k
	 gQ0AY05FWdm+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197F43930FB3;
	Thu, 11 Jun 2026 23:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v10 0/3] ksz87xx: add support for low-loss cable
 equalizer errata
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121881663.398116.1095367021130351842.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 23:00:16 +0000
References: 
 <20260609-ksz87xx_errata_low_loss_connections-v10-0-9ba4418cf3db@exotec.com>
In-Reply-To: 
 <20260609-ksz87xx_errata_low_loss_connections-v10-0-9ba4418cf3db@exotec.com>
To: Fidelio Lawson <lawson.fidelio@gmail.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, marex@denx.de, maxime.chevallier@bootlin.com,
 horms@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 Tristram.Ha@microchip.com, Woojung.Huh@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, nb@tipi-net.de, fidelio.lawson@exotec.com,
 marex@nabladev.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 09 Jun 2026 18:19:54 +0200 you wrote:
> Hello,
> 
> This patch implements the KSZ87xx short cable erratum
> described in Microchip document DS80000687C for KSZ87xx switches
> and the following support article:
> 
> Link: https://support.microchip.com/s/article/Solution-for-Using-CAT-5E-or-CAT-6-Short-Cable-with-a-Link-Issue-for-the-KSZ8795-Family
> 
> [...]

Here is the summary with links:
  - [net-next,v10,1/3] net: dsa: microchip: implement KSZ87xx Module 3 low-loss cable errata
    https://git.kernel.org/netdev/net-next/c/014f0c98cf1d
  - [net-next,v10,2/3] net: ethtool: add KSZ87xx low-loss cable PHY tunables
    https://git.kernel.org/netdev/net-next/c/13655144ddca
  - [net-next,v10,3/3] net: phy: micrel: expose KSZ87xx low-loss cable tunables
    https://git.kernel.org/netdev/net-next/c/a1ee1b9beb7d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


