Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703612D7DE7;
	Mon,  5 Oct 2026 03:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791172208; cv=none; b=rIwnp/RtYw7Cm5me0RDXj5DK9vMtfe66BRZDqBfYIf6Il4BxmtNF9VSaDlfb6m82zbrdHm07fZIhGYBq0gzuzavfRADoghl7QND2prPL6HOh9+FJgsgELugOypcJKVaiitTHvLAlkVOuXEjDSfd6s9FLUVJFbuAAEOTgsL9yxSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791172208; c=relaxed/simple;
	bh=xiCh9O+sIIckE57/jwYPxpADT4sRY0bcY+wJ5BW3o0M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=igobBvqI5nKZzqvtCCbuHtj+0YwmZApegr0pzQKogA2cdD0YOj9XfRo1dTkSvcogzj+GBFbK6/R+npbsCeOCvjVIVQm3+FEgMkF8hYZPUqHdZeSxby3ZMHhpPvr/cWnTN6Sa0Jo6iRGtxiXsyxcXtqfnHCbkmibpwRIf0u9rfTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuGkv1R4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuGkv1R4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA3A1F000FF;
	Mon,  5 Oct 2026 03:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791172205;
	bh=ZMlbVtUguEy/7POGWYQdvAFxjw9Hnwu4EyA3dwp7i4M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PuGkv1R46aj4xBiUbt1G0AUYgkLgTPFFKNMGi07WN8uOtv48izbZ2B+a9mDYRAk/G
	 akj512i/hALMDeAdE2g2LsI4psisfkiMwQG2mFs73SsVYNDelhl3LTdIk86I/HNNYc
	 3Udnxlwtrw4hiMhvbTK+I9PtA3tDtVPfUS3U6bu9DM0xhttulk0vfe8dZm1Kluh4b2
	 PpuLBok4lBJCg0kGcsm8CSrbYgN1KAMvuuPr2DT9mL+HUAmFjVuAaZYS9axIOKlFZ/
	 57i5aEZ0RnvUXZZjlWqYryMbX0g1HCsQm4cZscqdPHU4X7SPZmiPDuvf7VNTjmho/F
	 825NWj6NZ/fDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B454539253C0;
	Mon,  5 Oct 2026 03:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] net: phy: realtek: add MDI-X support for
 RTL8365MB-VC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179117220453.1083104.4210804624959109242.git-patchwork-notify@kernel.org>
Date: Mon, 05 Oct 2026 03:50:04 +0000
References: <20260929092007.1184843-1-o.rempel@pengutronix.de>
In-Reply-To: <20260929092007.1184843-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: linusw@kernel.org, luizluca@gmail.com, andrew@lunn.ch,
 hkallweit1@gmail.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 alvin.sipraga@analog.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 29 Sep 2026 11:20:07 +0200 you wrote:
> Add MDI-X configuration and status reporting for the RTL8365MB-VC internal
> PHYs. Without a driver hook genphy cannot reach the chip's crossover
> control register, so forcing MDI/MDI-X with "ethtool -s <dev> mdix on|off"
> is a no-op and "ethtool <dev>" cannot report the resolved MDI-X state on
> this PHY.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/1] net: phy: realtek: add MDI-X support for RTL8365MB-VC
    https://git.kernel.org/netdev/net-next/c/8b4e7209c842

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


