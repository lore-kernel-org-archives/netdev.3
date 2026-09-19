Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAF123ABBE;
	Sat, 19 Sep 2026 22:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789857080; cv=none; b=oPNemdnXhEM8VPrq+633MAfE55h1/KGUFjgLHhbE+dCtZbvH8203MVK2Lsv24dMBcLwGp//qvYiSu6r+ruEAFd7KT51xbgK+WK2OW8wvWM1x33i/To1ZWMKCVZ+/hzkkOuNM2jonbyK1LkFcyT10QsTsXfJZpPJFCyPLFlYbvwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789857080; c=relaxed/simple;
	bh=hupbXQ4hWbgHlcnOxDyjKxM9aL059LNHQycVoHMthxE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GD+eSeJiNBU97QI+P9hBkPXBh/UPApnqIfXdbQyHqyhjh05YDggFy3pXTft9jJ2issInxXoMQDSYYBzNa7MAX3Y8km2LfUKGeavBkWr34UFmGfkNPuBz/f2ks3Lq3PMGqZGa75opMOLuDK8vZbd26wfMIlCbHOaZ0FUU07sTQF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWIcNBdW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWIcNBdW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86391F000FF;
	Sat, 19 Sep 2026 22:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789857077;
	bh=4ROEOjTAhr1PNsdMKch/E7xRZKAbqxNH1MQ2yCdQakA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BWIcNBdWyMK2xYnbAfbk+ALETRVOI1WgrSTUexTZbWIRoPbbWTUQZNpl35H7lJTKm
	 9Q2uMN3OYaHZl4jqKuS+dG0GgOoaoO/9JgaLS37QxntYfJFwOvNFRuWJQ3RbDjVRV1
	 30v39pLlUkJ0F6roEn1HMSsSRyezPKX8NbEiGVCzw7m5Ed/vp4F4aMSBjyqgP28WnK
	 uhepPJVxQi0jMrzA08jRiMPNfN8EU+dVxRTGbXCZhFiaB5uJDpwZz97D+iTTYKQ2kU
	 Ijj08+vOy6tVzw2i+2fW2rUERxBnUYPhxqSPFMDVQi+omHJekALKYnlh3rHeiRuEIx
	 /J8eQkb4kFMpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93FA8392447A;
	Sat, 19 Sep 2026 22:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v12 00/15] ax88179_178a: Add support for
 AX88179A-based chips
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178985701013.1481324.4514554358004911097.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 22:30:10 +0000
References: <20260916-ax88179a-v12-0-60c04c9924a2@birger-koblitz.de>
In-Reply-To: <20260916-ax88179a-v12-0-60c04c9924a2@birger-koblitz.de>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com, nb@tipi-net.de

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 05:23:59 +0200 you wrote:
> This adds support for the current generation of ASIX network adapter chips,
> which are based on the AX88179A. This includes the AX88179A/B (1GBit-PHY),
> AX88772D/E (100MBit) and AX88279 (2.5GBit).
> 
> The AX179A-based chips all provide both a CDC-NCM compatible USB interface,
> and a proprietary vendor interface with more features. By default, the
> proprietary vendor interface is not active and Linux will load the CDC-NCM
> driver to support the devices. If the ax88179_178a module is configured by
> the OS to have precedence over CDC-NCM, then this driver will switch the
> device to use the vendor interface, and the device will be controlled by
> the ax88179_178a driver when the device is probed again after an automatic
> reset of the device bringing up the vendor interface.
> 
> [...]

Here is the summary with links:
  - [net-next,v12,01/15] phylink: Add phylink_mac_interrupt
    (no matching commit)
  - [net-next,v12,02/15] phylib: Add support for PHYs with broken forced mode
    (no matching commit)
  - [net-next,v12,03/15] ax88179_178a: Fix endianness of pause watermark register
    https://git.kernel.org/netdev/net-next/c/a4e22e9253e7
  - [net-next,v12,04/15] ax88179_178a: Split driver into library and device specific code
    (no matching commit)
  - [net-next,v12,05/15] ax88179_178a: Add netdev2data() convenience function
    (no matching commit)
  - [net-next,v12,06/15] ax88179_178a: Add HW support for AX179A-based chips
    (no matching commit)
  - [net-next,v12,07/15] ax88179_178a: Add EEE configuration support for AX88179A MACs
    (no matching commit)
  - [net-next,v12,08/15] ax88179_178a: Add EEE configuration support for AX88179A PHYs
    (no matching commit)
  - [net-next,v12,09/15] ax88179_178a: Add VLAN offload support for AX88179A
    (no matching commit)
  - [net-next,v12,10/15] ax88179_178a: Add AX179A/AX279 multicast configuration
    (no matching commit)
  - [net-next,v12,11/15] ax88179_178a: Add Suspend/resume support for AX88179A/772D/279
    (no matching commit)
  - [net-next,v12,12/15] ax88179_178a: Add ethtool get_drvinfo
    (no matching commit)
  - [net-next,v12,13/15] ax88179_178a: Update driver name and information
    (no matching commit)
  - [net-next,v12,14/15] ax88179_178a: Add support for AX88179A/772D/279 EEPROM access
    (no matching commit)
  - [net-next,v12,15/15] ax88796b: Add support for AX88772D, AX88179A and AX88279
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


