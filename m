Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D80430EF7E;
	Thu, 30 Jul 2026 00:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785372048; cv=none; b=OTD6ADrwuvmD13EZG47UcwpnR02pBrk01qXxnb1qgP/j+HIN3ebTn4bjB+x/BaBWm14J4iI8Gp131AsbCOXuF5KlcXfc7WtzH7Wo4fTG/Knub57GgApUMw+dnmJx9A7tsFPzdR1rKwfavdCdcL5Vnvqy9p5IZ9rfAAjMEx8QxPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785372048; c=relaxed/simple;
	bh=Sv6CPSSG71R+UXFLBdPjBWVgXk7ktp4YaUPevaNdQrE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OZMJiPw7m7V2oizy3mlPPx2vdrOFews3zL/e/QoNO3oME1aGMTNd+5l4aRgTB8T4EqBmXUZaNOHTj7leC9YnCcThZa3JhzJzIkneNyl5FjvEL1urxjrzLde4JqjYNlArDL/DFQr2bX0qVwnpsg+6sacFh81QjnQXxy8yMGQfp6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqCczNNi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqCczNNi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D811F000E9;
	Thu, 30 Jul 2026 00:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785372046;
	bh=NdY0BKHWph5EOwbrDaQoxQuPkpzGFFgegddJCFpDceU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RqCczNNiZuvDEbli0Zx/NGjRSjKFFlmkFDUBAnDJ/xtP6zPyRPum56X07xjomVw1C
	 X8gdkFQ/SOH++6iS3EWJ1Pi6WOiNk1VbbIGOIy/dc9aRTxrPJXyQQL80BH72RU9VY6
	 7WjlnlwnVA0MFDkQdHVTyBQTh040/VHToXzM7QD0vf+TvS+mIHO8nGE/pUH0pydViW
	 ju3E981raAN6xkb9Cl+5vV9MlVaazgG13SXc3EHGwBVJL4ISBqmRdxaRwFL9D5RS6Z
	 QGeQBT8rqaw+LNwrMfJkLdsx1ZC2xKlOcGMPb9g39DZHO2GHV3e5PvcliQilGs2iyq
	 f22UXX8XEPB7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BED3926251;
	Thu, 30 Jul 2026 00:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] net: dsa: mt7530: fix swallowed MDIO read errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178537201040.3298470.15022630671470651266.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 00:40:10 +0000
References: <cover.1785213071.git.daniel@makrotopia.org>
In-Reply-To: <cover.1785213071.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: chester.a.unal@arinc9.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 Landen.Chao@mediatek.com, f.fainelli@gmail.com, sean.wang@mediatek.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Jul 2026 05:52:05 +0100 you wrote:
> While working on a register access cleanup for the mt7530 driver, the
> Sashiko AI reviewers flagged long-standing error handling gaps in the
> driver's read paths [1].
> 
> The MDIO regmap backend truncates negative bus->read() errnos into u16
> register halves and returns success, handing garbage data to callers
> and to read-modify-write cycles which then write it back to the switch.
> 
> [...]

Here is the summary with links:
  - [net,1/3] net: dsa: mt7530: check bus->read() errors in the MDIO regmap backend
    https://git.kernel.org/netdev/net/c/b4ce102b2cd8
  - [net,2/3] net: dsa: mt7530: error out on failed reads in ATC/VTCR command polling
    https://git.kernel.org/netdev/net/c/ed9adac35b8f
  - [net,3/3] net: dsa: mt7530: error out on failed reads in MT7531 PHY polling
    https://git.kernel.org/netdev/net/c/77a9ebe8818c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


