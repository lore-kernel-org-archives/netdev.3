Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906FD258EC2;
	Fri,  1 May 2026 00:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777596054; cv=none; b=fl1x9jzhQpiY99kWGhw0HhdWamYyXLXe1wtLYn6fH2Ec3ez/F7fHXHoxZCNWWjVsAHm8tklx11mVlrLRU36TZXQ1tc0Q7Mmlosg1TqQD1b2+eSSkpOvN424F6Xf4UFSXRkOp5LhVvzE69de7hhV+biVI4ZC3NU1ImtHepCzltiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777596054; c=relaxed/simple;
	bh=yB2dqy60cZe8sAYp2WzCeGNldzziA+aAUH97WCrF4NQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fIPSh7hka5ZIAg6k7VYQZs6wRCr9pcHeaRTqgkH39RCOJGzPTvPC9F3tjKc+MF2W8cdGRx9NLx9aTl2wGaX6Uq44eVy+92OuTXZgW5HstaL0G1ekf+paRGrd3E7x7vtilIipwoLYUo9oYhVCZMvyx4yP+gaPpaeeyv4t3T/EO7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIVgbQxE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIVgbQxE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541C5C2BCB3;
	Fri,  1 May 2026 00:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777596054;
	bh=yB2dqy60cZe8sAYp2WzCeGNldzziA+aAUH97WCrF4NQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XIVgbQxEUGNHJHLrnDITP4dzGFLw6iQfAxdmZpPDDIQBAjUOul9OjR38WWML53nWd
	 3C8I5b3GqUJViEqtwFFOGb7U3ZQokrOzWNOkfLXXFd+B3RRZt0lYmwIImRtgQVmEkg
	 3mU/rAV2SFVLwdlUtd3ymLOfep6cTcb2vdZC3F4kE1Ru2Q4gCLnVZym32RDQfLtud8
	 H+5mCgzYMnpwUF5rwc4w2gi7SGKOWaUJ4jgg/lY1BR1CdFPwyNY6iId9ZsY024evQW
	 t97gk1EVuZQCsnvDmA8nCa66rIT4k+ua+YyD4TG831rFp0HoVlZbvMR/I0ztsCHHP7
	 BxBErxQcLDPHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E45380CEC4;
	Fri,  1 May 2026 00:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: micrel: fix LAN8814 QSGMII soft reset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177759600829.3265014.7486508387010194955.git-patchwork-notify@kernel.org>
Date: Fri, 01 May 2026 00:40:08 +0000
References: <20260428134138.1741253-1-robert.marko@sartura.hr>
In-Reply-To: <20260428134138.1741253-1-robert.marko@sartura.hr>
To: Robert Marko <robert.marko@sartura.hr>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Divya.Koppera@microchip.com, horatiu.vultur@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Apr 2026 15:41:01 +0200 you wrote:
> LAN8814 QSGMII soft reset was moved into the probe function to avoid
> triggering it for each of 4 PHY-s in the package.
> 
> However, that broke QSGMII link between the MAC and PHY on most LAN8814
> PHY-s, specificaly for us on the Microchip LAN969x switch.
> Reading the QSGMII status registers it was visible that lanes were only
> partially synced.
> 
> [...]

Here is the summary with links:
  - [net] net: phy: micrel: fix LAN8814 QSGMII soft reset
    https://git.kernel.org/netdev/net/c/e027c218c482

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


