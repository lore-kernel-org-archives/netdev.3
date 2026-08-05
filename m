Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF76023183F
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 01:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785891649; cv=none; b=lWZ+zH4xCDyfpGizaIwhbdyPLiFfgSDRsbLaE1EFuQTvNumXVPCmvp1zWvjRqTbIX6bLkTn/3rnrE9k1YSClstUV6+oHhXXuhnuqsRNUZmRBa7UKQSfxiUZxuM97QlfNVTsDmEhwCmPGmNtFevJzEl6rsQDEqQIcXUm5OQIEerU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785891649; c=relaxed/simple;
	bh=CwY1iCcHk1k0PTUsgmc9dthj989dX+DYIi31P7MAwI0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qofDis8kpvs9MFFdz2WfgCFZetvhx6BJGIMzWYKpswF2BnYRoxs/lKqXBV05X0bnzObLGF26l6xzWuJRRxN51fK6bupxOmRr+5COu9zF0Wh7syKHIweHkN2+GcP/1WofddSOdPXX3uy8ob/zl1cs8VHzhl2jVKspSA+kMTk8z1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PesEbmS3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PesEbmS3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515441F000E9;
	Wed,  5 Aug 2026 01:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785891647;
	bh=Wx8Sn4oDmmZxI24s+93wgMyL6pyq4TAylJ9ZKdSFkd4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PesEbmS3RhxToZIDXzXGl0nWYxBKn1rSOZpOEjAfdKUaIFlFoLU1K8JO87iX5A81E
	 SP8pkmCEb/QFUBGu92xzsNeM9a9Bwd3xHS6SpMonX1lDIfmYWMTi40kR6I/XLxw2OX
	 l0CHdNKdugDp+xwBCK7nK58LHrLvNi+WpUSDpveJrJ3j9vVmaZEtixcC28XhlyqkiS
	 B5Ajtbbp2NQgSZo9zNm44NqMz5kpFpiwTyJnIQ4aZ7yRgiiNzjwf6AgRVOUCT7qd47
	 qbDYzZgNfCvTOI8rutHcGe1E8HhbbU46FLJYXmAYMrucM50Fdy6uc/X2YjBWZgmNEZ
	 pkI0nyblLY5xg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0E933926663;
	Wed,  5 Aug 2026 01:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: dsa: realtek: rtl8366rb: Fix up port
 isolation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178589160739.3856351.16124809556388609774.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 01:00:07 +0000
References: <20260731-rtl8366rb-fixes-v4-1-fbf0c95b829a@kernel.org>
In-Reply-To: <20260731-rtl8366rb-fixes-v4-1-fbf0c95b829a@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: alsi@bang-olufsen.dk, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 Jul 2026 23:06:06 +0200 you wrote:
> Sashiko reports that we incorrectly disable isolation in the setup
> loop while what we want to do is to enable it.
> 
> Enable it by unconditionally setting the enable bit 0 in
> rtl8366rb_port_set_isolation() so a mask of 0 when passed in
> will enable isolation and isolate from ALL ports.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: dsa: realtek: rtl8366rb: Fix up port isolation
    https://git.kernel.org/netdev/net-next/c/6d356e408670

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


