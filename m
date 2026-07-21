Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225181DED40;
	Tue, 21 Jul 2026 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784650855; cv=none; b=NqfNoooHY1ft5Mr/UPsC9N9uc6ghl2X4fF54aBG0/Gpu0HPQJJEcH/AJxfFMOZQIVr/SFop4ZvL9e+g1Hxh/ryDfgmsAdcO6rGPge10IpQlPfzt1ztwa6cdZuTg6f7ii/PALDs0IXHg52+mRqax+o7qMJBtAd7prCIWrnCz0Y4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784650855; c=relaxed/simple;
	bh=3czJiOrTZONuB0Wv2W7rwXTThEepmfm8ktEDGutFHhs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H3A0VKwJlY5Zvvg2X7ZWaI/y11qS86GBNBQytXxqxwK7Hno1AFmfaw3uZ2FYpIpb6rYihXGRfQIBENEb8r5yGd59Gnmv6D5wkflpASKea/5QV/LjEHKx8Kw70ClqpcqYudlVsiQYcGAS3uX/5ZIhMWi10P0L8+iqiA8n62POxuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jK1ndsfV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jK1ndsfV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DF71F000E9;
	Tue, 21 Jul 2026 16:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784650854;
	bh=bEG6vCAcUC/yCdp1H+s6Wajs7MSRFTdsbhrIlFQCEgE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jK1ndsfVBSv3BNeFXkt3dhSKYCK7O7p4dyBgSU+fk0kotS5SxirWaJ8gisYW/+xqK
	 bp1TQv7dsctYc611Ei62EVPYsp7GUD7oS2DIGJQS6HPVJ2XAh+0mJ3kqp2EfEdE/DV
	 IW7zUmFdaXKMykb75+YNtvnh4uZMOtv+OMPba6tHQmPNomhJeoCq7WXDkgthsh5irO
	 Pv1YMotEn6Pmeh6oROGk9HWBXl4QF5qE1RdI2ehgfpFzs+i09BfTkzFph1aG50Q+qY
	 62q7MnbX+cv++OJHw/QFlYDeh88OmawE/YTxeIiv2HRtg+G1rsRKGK6M5PxBiM6t3W
	 ivZi6hy4jJxtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C013924FFE;
	Tue, 21 Jul 2026 16:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: drop duplicated header include in
 mdio-device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178465082339.386198.15609399317877306300.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 16:20:23 +0000
References: <20260715201213.206180-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20260715201213.206180-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 hkallweit1@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Jul 2026 22:12:12 +0200 you wrote:
> During a tree-wide gpio include cleanup, the linux/gpio.h include was
> replaced with linux/gpio/consumer.h.
> 
> mdio-device.c was already including that header, resulting in a
> duplicated inclusion. Let's drop it.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: drop duplicated header include in mdio-device
    https://git.kernel.org/netdev/net-next/c/7e7bd5158e98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


