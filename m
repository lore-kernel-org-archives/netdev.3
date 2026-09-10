Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F653033DF;
	Thu, 10 Sep 2026 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789040470; cv=none; b=ZlUtzZxPTu3uC/IJ9ZLDGIkBRYvSoVhsfI1y1+bztax5B7UAxNnpdfhAHsPJclWCiG3IXcoMoKr4IfXLZk1YZ70w9ewF5SrTTBhgJwZlyvDEv4vkvfXVReFQsQoVv4h2n0ng8TkELSTkleTdwDayjrTVRTgW6mBuoboYUweGvuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789040470; c=relaxed/simple;
	bh=fX5N4faLlxqGlrRi3ZqPEdOKgg7unUH6NkQWjbCmLJw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C6vphhvFaK/WjqXD0KdFTHXkp+LOf1aR6zZ4gvqsAbkRbzFTSIoRX9+ZaKvOa4rnyRutuWwemXFsdQhxrmTjPKWAdk4N6f74n5634kztuGuMHVfCUvrOy+Gxuw9VB/kqr1YX9srgaoozDwfx0VG0Q0V/QjXQUNKPC+pitthTio0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+OrbAjN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+OrbAjN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125131F00893;
	Thu, 10 Sep 2026 11:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789040467;
	bh=DeGR29QlguE5S6672UQs1iNNz/omuVwEQS0a1AuP0ro=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Q+OrbAjNSXS69kLu7KxVfyL/qqSP2DU2RcajzTEaPC6mZp5xAgpWLz1DYvjdA85x4
	 +LrMq1+C9Su34aX0n9RbYgH3P/sd++76kAljR08YCDtlPHTjCi5l8vqRh6iZPLbR5D
	 BGABrbyATxWkAWd+RkJFGOA6tifIkX83hk3WVei1JeMoMTb0+1zfG7xP+M091at1yy
	 Dl/g1R1DRGC+m+BLE9ev+4FNVeAu43nxecmosw1zYWN1ErszZN8iylPoa0EgzHTKM0
	 l43FdpiAajGB7N3FPHjwBCiZ3s0evwx5nMm6yPwwT5mvWVuXdGoSOdQSqJdUU1sk4B
	 9rSibZxFhu13w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A8A380CFEC;
	Thu, 10 Sep 2026 11:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 0/2] net: restore EEE on MediaTek switches and SoC
 MACs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178904040463.1380647.8328651784613064419.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 11:40:04 +0000
References: <20260903123644.23800-1-f@lex.la>
In-Reply-To: <20260903123644.23800-1-f@lex.la>
To: Aleksei Sviridkin <f@lex.la>
Cc: chester.a.unal@arinc9.com, daniel@makrotopia.org, andrew@lunn.ch,
 olteanv@gmail.com, nbd@nbd.name, lorenzo@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux@armlinux.org.uk, dqfext@gmail.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  3 Sep 2026 12:36:42 +0000 you wrote:
> Both drivers fill in phylink_config.lpi_capabilities and
> lpi_timer_default but never lpi_interfaces. phylink treats a MAC as
> supporting managed EEE only when the tx_lpi methods are implemented and
> BOTH bitmaps are non-empty, which phylink_create() decides once and for
> all, so EEE has been off on every mt753x port and on every mtk_eth_soc
> MAC that uses mtk_phylink_ops since the two commits named in the
> Fixes: tags. Because the tx_lpi methods ARE implemented, phylink takes
> the other branch and calls phy_disable_eee(), which fills
> eee_disabled_modes - so userspace cannot enable EEE either.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/2] net: dsa: mt7530: populate lpi_interfaces to fix EEE support
    https://git.kernel.org/netdev/net/c/3c18e3c9a54e
  - [net,v5,2/2] net: ethernet: mtk_eth_soc: populate lpi_interfaces to fix EEE support
    https://git.kernel.org/netdev/net/c/d876c9cb2d16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


