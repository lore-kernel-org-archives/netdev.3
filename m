Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D692D876B;
	Wed,  5 Aug 2026 01:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785892854; cv=none; b=Jd7HJrUulXl/XaJ0bcAVklwab+zuCj8R5ttVAZ8iO16xNb2CrrjG8cnF5etlaGCYb/WtC3nLcP8YVN2bUrhjOxAKtd3e/Yw8e+20Ik7cD7sCUNkLqCkl2yHMx8toa/gjs774VoDdAadLEtRNmehmNxMr/MdyB0iYk/ljAW0gXyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785892854; c=relaxed/simple;
	bh=WeOVXEZIJZFYqYykoPqi6F5YKUGqvBd358BQjMk/CDE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YTg7F1SgoqyplruTdqDXpKXjUyl52vhyxkXdv5mYzeJ/ekyFCPE66q+SxYAglNmDgjRa+m/jixE5ZZmVw+oEvQuDligYiPzrSOgXbwXgm+dCzY/bALHE4Hd0uuZqZ9n6NCNIjx9cK0QmYWeD4voLrCyO2FvlhoETG7ROovCYSSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsYXvOiR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsYXvOiR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0C41F000E9;
	Wed,  5 Aug 2026 01:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785892852;
	bh=tanJGOMFgccBzlCaqBOzJpMOkkSzoUZZ4+u7syZ88c4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hsYXvOiRMuG4uArviX7Kt8qnCS6+J3nhDWtW3ek2wtt4sWgnOerbnJyXir2IwGYAX
	 EsSeV64VFI3lPZ+8djB1aqXYUIrdx2XmDZf1sw4cyNjHtNOozAai66YbGMSBfw2gwp
	 crN14eMGNycUizlUt2pa8I8LYKj/bSbu2A5/B4D+Hbp2qb3hYuOGGRpLOfZjeg49ZO
	 CZdHGET8ziFxX0MNlibxR9pbKMtQ+IBdLN3EswwJSzg+CF1bPI9yxa3hy+zjuBbKci
	 1EuewEo553trBAjfADuJERMpHREvlaan6AUCM3O8ZYJJ2VZqa3hXd//doBmPqUVcwl
	 klyaGB9kXDGfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568D93926666;
	Wed,  5 Aug 2026 01:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: stmmac: resume PHY before hardware setup when
 opening the interface
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178589281289.3863162.5474751490038386802.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 01:20:12 +0000
References: <20260803095156.132827-1-stefan@agner.ch>
In-Reply-To: <20260803095156.132827-1-stefan@agner.ch>
To: Stefan Agner <stefan@agner.ch>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, rmk+kernel@armlinux.org.uk,
 maxime.chevallier@bootlin.com, j.raczynski@samsung.com,
 alexander.stein@ew.tq-group.com, ovidiu.panait.rb@renesas.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, regressions@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Aug 2026 11:51:56 +0200 you wrote:
> Since the referenced commit, changing the MTU on a running interface no
> longer disconnects and reconnects the PHY; __stmmac_release() merely
> stops phylink, which also suspends the PHY (BMCR power-down) when WoL
> is not enabled. __stmmac_open() then performs the DMA software reset in
> stmmac_hw_setup() before phylink_start() resumes the PHY again.
> 
> IEEE 802.3 22.2.4.1.5 allows a PHY to stop its receive clock while
> powered down, and stmmac requires a running receive clock for the DMA
> software reset to complete (the phylink config sets mac_requires_rxc).
> On such setups, e.g. the RK3566-based Home Assistant Green with an
> RTL8211F-VD PHY in RGMII mode, any runtime MTU change now times out and
> leaves the interface dead:
> 
> [...]

Here is the summary with links:
  - [net,v3] net: stmmac: resume PHY before hardware setup when opening the interface
    https://git.kernel.org/netdev/net/c/06232cb44bc8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


