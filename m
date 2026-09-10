Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB9F30D3FA;
	Thu, 10 Sep 2026 01:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002076; cv=none; b=BxvFrNV+3mHWwXWQGv/nrr3YIAbE54bbB65aI24CRdlaMa+D1AI3w+Ov2JCqcUrDy3T5izcX4HahEsi8lj/AWpx43ntjZdAx3WNbZSq5qnbplh3TumVMvLZRsJTdF5D8vJ/NQGAGjYqNZP2gmWah+ca2023r7WwxX2YB3279jmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002076; c=relaxed/simple;
	bh=hpwp320oyhphw0vKWCOXtcEb+ohOzBfvgsiZ6ZSnSUI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rziLvRhIMCX3cBBL7ZDzvOw3WwgeIwVAQm5K5cNtsBaObap2AQYVORT20QGY2UumC9BwEiecdKFD0STZ/7uLgEh+DG815JlXt2bsbSk0SdtINkTtw40Hlya9nzI5ZQRM5snoygN1TZLDaVX0EF+09QNq6vk2eYYtqJjhzjeQCBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UK9gfjRP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UK9gfjRP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1032E1F00898;
	Thu, 10 Sep 2026 01:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789002073;
	bh=tgb2+2WOQg+lMH/OLhbpr3ews9Kn7F2CdfYO05cllpA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UK9gfjRP7nmOMwgqQY1+ZQWrCM8h9SfwE5VMO3/QbQPNTUejU1xtmhluvhDSGA8HF
	 tSpZBhahiA4TQ5OLfvrEezYYP64RjQ3BsFPfbhm+1qefL2gVhg8D78Tzf2Tx/PNbEY
	 ke3ZRK3mvqF7NFYtDRV5cNdaX8G4lx+fHBSsIts0hzdhmcv/DOujHfQVK8XGpDcxFR
	 KIo2P2hqNbQFaR9pFqMijIuAG+xLxwhqu1kgttyjKEMlyOYqFolHotnGcvNe01RORJ
	 92Pv0JqhVd4R08IFYQj3EJeSurlItdYYfqz5UPHPZJj1tWifJ9qMIOw5k4vxuxqFrL
	 +Xjicc+gq54kA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1986B380CEC5;
	Thu, 10 Sep 2026 01:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: motorcomm: Handle degenerated blink
 delays
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178900201063.1131357.3109250834192847666.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 01:00:10 +0000
References: <20260904134752.635133-1-mmyangfl@gmail.com>
In-Reply-To: <20260904134752.635133-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Sep 2026 21:47:46 +0800 you wrote:
> The LED core defines delay_on == 0 as steady off and delay_off == 0 as
> steady on, which was treated as a blink in our LED driver. Fix it.
> 
> Fixes: 9af9a8168213 ("net: dsa: motorcomm: Add LED support")
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  drivers/net/dsa/motorcomm/leds.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [net-next] net: dsa: motorcomm: Handle degenerated blink delays
    https://git.kernel.org/netdev/net-next/c/10973152f2f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


