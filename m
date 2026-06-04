Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6683C2BE03C;
	Thu,  4 Jun 2026 02:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780540217; cv=none; b=lXwW84jyE33gF/Y4nowETzP/e599LYGnp5h8J18QbIMd5Uuf4BzBu4wgr3FiBlunif1i5p3/vsonW78/S7kVWVp2i8Sqh25zcRtX0ssY7oMklIRLi22oeV0u4Iq8v72TraMESXHj8hxmDfx27q43irQK4BPWIWGVsXod2YFvzAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780540217; c=relaxed/simple;
	bh=sdCzHy7C40HMOj4/b7kN8+YkH4JkzzQucO2MAVnyLK4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hBks4cqzr/ZgTo32dZFVSw8j45z121Ntn/N+4TbyY7ohI1KaFI4kdydphEQOpSGI3zoL+LkjolCzv85nx/bSJmgvpBBRqfLPWyvkbSJAOpNhijGlM8iaGHP/K5gjuF4AN6V45YzjYm/BdFnUD/ZA2BGkwX9g/YytF19jELr6LcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcNmzFKn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcNmzFKn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340B11F00893;
	Thu,  4 Jun 2026 02:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780540215;
	bh=9wU2AxMPhoOp7B/T3SMAKEa5O1kX2NJAEi/Oh9Z6D5o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IcNmzFKnDaBPQVTFAu+lROvtOHA/BFQHeCMnym0wKTIhA0y9xlqjuS122INkcBR01
	 7C1oAaA8LPvz5dVCGnC9UglQju8ikMDo9fI+r+Gvz+b+BSnL2zU4JectbpxEx3AR6Z
	 rJIAXCnAM/mEW8o9gIy5JidNC50UN+g0anc7W1R/wg2GK3nD4IwKppTVFxlYl1OvlN
	 2pEFwmS9/dX+XG8wNrJjUKVAh2orSTbTOSDs/Y6RpiGKnq9OorkD7ePT2UWFchNLzZ
	 u1Aei8v3Uq9NXtBnUayxwuzoIAh8UuKvnlNH2aZc84EcC0DwXMOCfd15jtxh1mFZqx
	 2Q5x2x5ylBzuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9393939308E6;
	Thu,  4 Jun 2026 02:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net/sun: Fix multiple typos in comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178054021614.2211213.3521363278754692746.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 02:30:16 +0000
References: <20260601163727.554364-1-j.raczynski@samsung.com>
In-Reply-To: <20260601163727.554364-1-j.raczynski@samsung.com>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, kuba@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Jun 2026 18:37:27 +0200 you wrote:
> There are some typos in comments and while they are harmless and not visible,
> there is no reason not to fix them. Fix the ones that are not register related,
> which might have intentional naming convention.
> 
> Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
> ---
> Changes in v3:
> - Just fix typos, no funny business, no changing spaces
> - Restore commit message to original
> Changes in v2:
> - Fix typo within typo fix ('empirical' word)
> - Change autoneg related sentence to make sense
> - Fix double spaces in lines where typos are fixed.
>   Add annotation to commit message why only these
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net/sun: Fix multiple typos in comments
    https://git.kernel.org/netdev/net-next/c/8bcffff57d57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


