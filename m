Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63943A1A26;
	Fri,  8 May 2026 22:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280061; cv=none; b=sNpW7PZ8vjDt3HA4PPEUVuBZRXksq5oDE9JtzMw4FT9sCi07fr0E527dNLfwu90gv9ne11Ag6ns1jFDJSegenatInU0/TiHKoWUi8gDBp0G9dyhPj7ikYoKNUr5Czj334/PHtF4/a4qkUnhaTwalgiG2VHXZQ8uI1Q/c5akxCXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280061; c=relaxed/simple;
	bh=FYU/15qOeVBqPbvSjXhyZXA3TJXjTjc4EpIfifg/PwU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cCuvggo6/CbFWKl9JZmtwLIsAGS2Dtu+Gv5Lyrch3BYA7z53XXnwJtAAYqkqZiA6WbHtXPbcOoPEjsnVPXVkMcg5jbjVJtc7uc+EwZcs7f7lSxMM0Fii8Ymkizq/tefBleDgem8SchRxYSbWp1LF3ezVSWwh3gp5NY+UUVZLrZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oe6pVYeo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oe6pVYeo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97949C2BCB0;
	Fri,  8 May 2026 22:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778280060;
	bh=FYU/15qOeVBqPbvSjXhyZXA3TJXjTjc4EpIfifg/PwU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Oe6pVYeox2+qqYgcZWf+Q4AN+uhEr35Fs7Q433jPfVEqRe+zwzCWEraBsWad58/Y0
	 BLRjt7e4ACn9T5otwG8i2OLqqksLfrY60HwWQX1NqSihzMiRl6QdvDO2JgIBIqL+GC
	 fcy7BUtFsJ3AGwQw3/nsJo+iaOO6nQApRwrZzJYokn4AHrmQ5Boua4IScDLZT6uDZI
	 daN+Qc7rTOW677wYCzC8kZsm1kulQUR8DBPWtIXIwADqnM9qxHVSqkPB9PKGuHtVLR
	 cN7fkPeupD9gZh/Ud27b5jM3aOfjRTB1iuh9b0kZ3GcIjzU9UdYh27u0T1AMUN7J0c
	 AnWsa2ks9LGzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDCC38119D3;
	Fri,  8 May 2026 22:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: change maintainers for macb Ethernet driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177828000904.878212.12911947829161473740.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 22:40:09 +0000
References: <20260507120444.9733-1-nicolas.ferre@microchip.com>
In-Reply-To: <20260507120444.9733-1-nicolas.ferre@microchip.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com,
 claudiu.beznea@tuxon.dev, netdev@vger.kernel.org,
 alexandre.belloni@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 7 May 2026 14:04:44 +0200 you wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> I would like to hand over the macb maintenance to Théo, as I'm unable to
> keep up with the recent flow of patches for this driver. After speaking
> with Claudiu, he indicated that he is in the same position as me.
> To help with this work, Conor has agreed to act as a reviewer.
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: change maintainers for macb Ethernet driver
    https://git.kernel.org/netdev/net/c/0a549298f452

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


