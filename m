Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F383F3DCDBC;
	Thu, 27 Aug 2026 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787859678; cv=none; b=JKg8wCYqU0/qyW+51IoMemLKuAgxAcSxe1TEIW8ik5SXuSdVKIjq0ujSs7MqyIdc9Fc+6frkoKhN3XJZdBEvJfhI6j20G/7dUliJaGTFs/TcgVbTHgk9M2TL0Qg4gQfZ3NLH2hUO7RQCRDVOrmVQhhmhG8p8GiwbinJL7yXSTgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787859678; c=relaxed/simple;
	bh=GrDlXsxDUff5YtMLADA+wjlJc4I5yQwkc1rBrWifFVU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kCARfSIz7Rccva/LuGT1zoHAfrk2tVrEs9WhQZgEqaY2j5PQZCVGLtfI7vSxRQOc6tZKW8YZYUKLeMfhYuQhLfQm8P6khLaWPvkHeTAQX6tFNHqV7ytMV/QSgHubvF04PR3XyWl2xCjxtGUTdVngHBzdKJ1zJceDyHFgjBpnhU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNfh1Qse; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNfh1Qse"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32801F000E9;
	Thu, 27 Aug 2026 19:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787859676;
	bh=KZaMdScOuViKuR5f8yRHEFF6Xafdvr12KHrN2lbVNtY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RNfh1QsecBVNl1WzAUJcgDE2ylUkIrkOMtk/rNxfGqq+CS1HnNWoGuStBLTnax6ZJ
	 9D5m7rrFS8+CzXrHlw+7G5KhLMbHNFmAhLRe3aEhgzbs49cXjeuCkBtDJoU0dfpBUq
	 l3a+kbc2mtAC7oHyRvQZE3K2veus191iqgycw54P/TyNexoLkbcP5UK3kG7AOOxqyA
	 NNjOddBE1FerK1tCVHmmQBBSyrQVxe3zPq7jWxezNZ8WO0P2/f46y7AZw2aSHYO0g3
	 bpbJVlafqXtJyPXG4QSk1Vieg/im1OupyJBVCqGAacZumzX++BEG6sRI2TehR87h/7
	 14wwO9CCeXYOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5694C3809A8D;
	Thu, 27 Aug 2026 19:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/6] net: stmmac: More selftest related fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178785962189.1816627.5526551046496058964.git-patchwork-notify@kernel.org>
Date: Thu, 27 Aug 2026 19:40:21 +0000
References: <20260826140500.616466-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20260826140500.616466-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 hkallweit1@gmail.com, alexis.lothore@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, kernel@esmil.dk, minda.chen@starfivetech.com,
 neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, jan.petrous@oss.nxp.com,
 ovidiu.panait.rb@renesas.com, Jose.Abreu@synopsys.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Aug 2026 16:04:52 +0200 you wrote:
> Hello everyone,
> 
> This series addresses some (but not all) issues found while running the
> ethtool selftest on various stmmac platforms. As a reminder, ethtool
> selftest are run with 'ethtool -t ethX', and for stmmac the goal is to test
> hardware features and bugs from the IP integration in the platform.
> 
> [...]

Here is the summary with links:
  - [net,1/6] net: stmmac: selftests: Check multiple MMC counters
    https://git.kernel.org/netdev/net/c/d29b399150b0
  - [net,2/6] net: stmmac: dwmac1000: Account for the primary MAC address for UC filtering
    https://git.kernel.org/netdev/net/c/9698b6da3714
  - [net,3/6] net: stmmac: dwmac4: Account for the primary MAC address for UC filtering
    https://git.kernel.org/netdev/net/c/82187f42c014
  - [net,4/6] net: stmmac: dwxgmac: Account for the primary MAC address for UC filtering
    https://git.kernel.org/netdev/net/c/2739d6f9a2b8
  - [net,5/6] net: stmmac: selftests: Account for the UC filter list for filtering tests
    https://git.kernel.org/netdev/net/c/cd8c3b2752c6
  - [net,6/6] net: stmmac: selftests: Don't test flow control for small rx fifos
    https://git.kernel.org/netdev/net/c/96e8cb5527ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


