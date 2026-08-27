Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EE2412BE4
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787824261; cv=none; b=q7Q51bDiVh8Qp/Qt6uO4CQgqLEcSG7IqVgrDFlS7VTfA5BX3fBjmKU8xGgPFNacrg4DvfA1lN1HVSPFlG2MhIk/g/Zx6K0b/qNrk/+BDqRtNVMB+zwqwdPXV1KUpsJU5AQ8Rsged3J7H16n6tiM7W0D4wfe+EXqx04KDD7uBrbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787824261; c=relaxed/simple;
	bh=oXqj11jaqr7lS5FArVDv6dR2jXMbMxDeueAx0rsigSY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qOgFDecdyIGoHwKIPDroBV2I2pYTrTQX2deEUZnww50O6A/YEm+Wtl/ARS+rWRL49XwAe93tIAiPYT/U+gz17yyZIPYYmi7AZgB3gBM2CEa3A44E7vXO8jfZPTjLoD6BvkZ96Dw7cV0yBYWfh3NXNazBORvHsJ/Qbc4E0zU3IRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJ2PKaib; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJ2PKaib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D84D1F000E9;
	Thu, 27 Aug 2026 09:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787824260;
	bh=b++QGExRCYc9cZ0LGGbUBeC/WMWu2ih26VoHO1yelsk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hJ2PKaibdisoCFD5/Fs0aJpiNs6uQhqVcUCFE/cZfgZc++oXE28ebXGNB6Rw3uOEB
	 Oiq6aZD+NJJJ/Se4m/WtugcQ0Y3WajmUWonSUIHnnLcFw9ZWYnuIC0D9qogNeLgQ7v
	 U7Tgv/POPCt+gjSudB2khUrGAriEFrQ6B2LSA8XqR1usanbSDWDiMyzBPhz6yeOf9n
	 M58ELOQNLAsMwaC3/B9+NSi5NAUTDZJ668k425jbBTSL/+1eCJiPrRHTUFItqATEpx
	 7Ws1n0p1WtxHNIARGR4KTQ5Hn/9GzjXzAzVGEcGe2FBZc2VT2JZGJ/Czs/PhVOAAU7
	 CP8bnhHTbYOSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199F33809A18;
	Thu, 27 Aug 2026 09:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] net: phy: air_en8811h: fix LED GPIO not surviving MCU
 restart
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178782420564.1138021.6032482247844307968.git-patchwork-notify@kernel.org>
Date: Thu, 27 Aug 2026 09:50:05 +0000
References: <20260823130638.1166453-1-sochnev.v.74@gmail.com>
In-Reply-To: <20260823130638.1166453-1-sochnev.v.74@gmail.com>
To: Vitaliy Sochnev <sochnev.v.74@gmail.com>
Cc: netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 23 Aug 2026 14:06:35 +0100 you wrote:
> The EN8811H PHY's LED GPIO pins are only ever configured as outputs
> once, in .probe(). Every .config_init() call after the first restarts
> the PHY's MD32 MCU, which resets that GPIO configuration back to
> inputs, so the LEDs silently stop reflecting link/activity state after
> the first link renegotiation, ifdown/ifup, or resume. Patch 1 fixes
> that. Patch 2 is a small follow-on cleanup enabled by patch 1's
> removal of code from .probe(), kept as a separate patch so patch 1
> stays a minimal, clean Fixes: change.
> 
> [...]

Here is the summary with links:
  - [1/2] net: phy: air_en8811h: move LED GPIO configuration to config_init
    https://git.kernel.org/netdev/net/c/03b4702fc5e3
  - [2/2] net: phy: air_en8811h: simplify en8811h_probe() trailing return
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


