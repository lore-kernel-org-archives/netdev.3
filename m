Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F295C2E3360;
	Wed,  4 Feb 2026 03:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770177025; cv=none; b=HJwAQ6+h8oEV3+B7QDu2noux71Zh0M0IqAPDflHj7Cu0/lkj3PT1lrrdCVNEh6ZKCstqvpd/2C8L5m6Zo4jwuRyZvzPiLI+g0WFW4nvvQ070shBnH5wgQ45Ck+FM+BhS10aTxGNAqvaeov+UpK0Isq5YSBW5GRoQK6PRXac2DkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770177025; c=relaxed/simple;
	bh=PmfXVzHumuHroAZxFJVALxzyJwaUMqCFjJNETsTwo0w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Su2rr2zdZHYP5PtcD0OvWsy+Y3LRkw+AhzeSyct8YSdAdaEEYo35Zajkl4Xyc8g1dDfW35qc2W1HHo2ltD7WgNW5AMt+8UwQCvQVpr1NesnFdM2lUFQ03yOCl1aUTJkc4Tm73NCF2c6lf7VWj6952SeAkYnreexxQJZ4vzJVnnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T89LGF1f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T89LGF1f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF047C116C6;
	Wed,  4 Feb 2026 03:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770177024;
	bh=PmfXVzHumuHroAZxFJVALxzyJwaUMqCFjJNETsTwo0w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T89LGF1fMbK/hQJPrTF5Cidx7pfA6NjyCDQ7c8k3PXB/TLD6rhDsc/A4pMxexqZl6
	 pshvTseWROu0GKev7jXgT20iJw6MtUxdAIOITYxzcmjaCqFtnMK6OpuziN4ORFpD9Z
	 LiZfBiZ5S2S1Dx6ytWRS0Zvxn7hzj3EscNwQJ2hOnjYqYIToMPpnUHxHgcARVhZ+Vf
	 LgU/0Zk2blDlk7ul6KUP2zH5bwQwQ+SJcxoo7kxMzguDxmswKRdlgtmRU1y9qY/925
	 PTq0MoxkaJpoaDfMjKGGRFY4SUD+MI7/II5MxGyb0QqXH9S1D9DIebRMOaO/gqzMru
	 CEBdvu0V/iOdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 16DEE3808200;
	Wed,  4 Feb 2026 03:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next 0/4] net: ethernet: renesas: rcar_gen4_ptp: Hide
 private
 data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177017702087.2171580.13124762758120229117.git-patchwork-notify@kernel.org>
Date: Wed, 04 Feb 2026 03:50:20 +0000
References: <20260201183745.1075399-1-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20260201183745.1075399-1-niklas.soderlund+renesas@ragnatech.se>
To: =?utf-8?q?Niklas_S=C3=B6derlund_=3Cniklas=2Esoderlund+renesas=40ragnatech=2E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	=?utf-8?q?se=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: yoshihiro.shimoda.uh@renesas.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 geert+renesas@glider.be, magnus.damm@gmail.com, richardcochran@gmail.com,
 netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  1 Feb 2026 19:37:41 +0100 you wrote:
> Hello,
> 
> The R-Car Gen4 PTP module started out as an exclusive feature of a
> single driver, but have since been extended to cover both R-Car Switch
> and TSN driver implementations on Gen4.
> 
> The feature have already been extended to be built as its own module
> with an interface exposed thru a local header file. The header file
> however also exposes the modules private data structure. The two
> existing users have already started to poke at members of the struct.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net: ethernet: renesas: rcar_gen4_ptp: Move address assignment
    https://git.kernel.org/netdev/net-next/c/642377346a4e
  - [net-next,2/4] net: ethernet: renesas: rcar_gen4_ptp: Add helper to get clock index
    https://git.kernel.org/netdev/net-next/c/9afe65e7e7d7
  - [net-next,3/4] net: ethernet: renesas: rcar_gen4_ptp: Add helper to read time
    https://git.kernel.org/netdev/net-next/c/5640afa0583d
  - [net-next,4/4] net: ethernet: renesas: rcar_gen4_ptp: Hide private data from users
    https://git.kernel.org/netdev/net-next/c/9c2f568eb236

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


