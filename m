Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3755C25B0AC;
	Mon, 19 Oct 2026 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417207; cv=none; b=T+HCSfGLdlaw8bHX8aUq2oYXlQ8KEgH2uVJGQyzM9lCk1bM79yxq9k9SC0KovKU6pI92JSm/PBWGAV3dZYhqfdWidbPaspIQKfv1vFZdMtYjy0mHEyNQeM5sguTIbNXBOQ86MAgrhDoiPirLGmZ94tk1Ocv31MiQdBomT/MexJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417207; c=relaxed/simple;
	bh=RgJyghLzBKDpDHe+EmU2wbzv+ckn30VHMaa2sWpzK44=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hNTQE4gu3iJt3hJapP3MIySXQXR9bKnY9t+XkFEBBRBe1uwvN/cSqaDxOcYaoRxmPDKJTodhfBxGBQcY/7FO+HxXfNfF+OSNiEEcM7HDbGdNXK+1Ye44P8OGNi+EsG4ar42Pu1aB1BGXX/bp1r/GP29zgAtNswK26Ozdn4eV9OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6Rv15To; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6Rv15To"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7421F000C4;
	Mon, 19 Oct 2026 13:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792417205;
	bh=xoEjR6t5ELBV0Ehld1uRhN2++C9qxzbzrI+HEJf6tz0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=d6Rv15TourIfcTkDQL3m+iTso1zkZP8LN7F0q6Na/vSwDJ4/n4WqGvm8HprhfxcAU
	 u82mEx3jYGH5KatejGP3v8TplirpU/HvJmzLsgD60A8MNZUxajOqLqwByNPFslBK7f
	 ojrxIztwjGfW6BYXJCijRNIyxy8Qf9yWYGCVOI7GrDN5mm4426Rsw9+W6uoLc5Nim7
	 PgvInHCbSowZJ19KCkThCrDQGefNrk+nPD9HxH7Nmo3VGM2hCt9TXpJZbY9OU9oDiZ
	 QV+0NWzo1cU6dLI3TOXjam9YcFTnNYDUuIeSdWL02JT/3J9zHEEc6Z/BRj56AtkasO
	 azCOI1M5UpJVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44963811A5C;
	Mon, 19 Oct 2026 13:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: stmmac: unwind the WoL IRQ after a
 safety
 IRQ request failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179241720453.2644569.6506845719154683565.git-patchwork-notify@kernel.org>
Date: Mon, 19 Oct 2026 13:40:04 +0000
References: <20261013-stmmac-irq-unwind-v3-1-fff4e2db805a@gmail.com>
In-Reply-To: <20261013-stmmac-irq-unwind-v3-1-fff4e2db805a@gmail.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, edumazet@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 fancer.lancer@gmail.com, davem@davemloft.net, nb@tipi-net.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 13 Oct 2026 11:37:11 -0600 you wrote:
> The safety IRQ is requested after the MAC and optional WoL IRQs. If its
> request fails, stmmac_free_irq() frees the unregistered safety IRQ and
> leaks the WoL handler. This can warn about an already-free IRQ and make
> the next open fail.
> 
> Move the safety and WoL cleanup labels into reverse acquisition order.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: stmmac: unwind the WoL IRQ after a safety IRQ request failure
    https://git.kernel.org/netdev/net-next/c/ecb8b18051a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


