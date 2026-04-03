Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6082823E320;
	Fri,  3 Apr 2026 23:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775257855; cv=none; b=hyNIgNrZT4wWdb4nXUCAudMAbu/umQVSxPyPZwN1Gf5IjYjDMDbw8LmlLq5lOZK+AF1HB6wrViH9SKJipy/3oZD/a504cX4/IOIis9ayMuO3H48eF1QO73hArN2XLwktPSu02OpITnR1AUB7NbNiWOk9Ulo75c6IPZzZu5Ba+LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775257855; c=relaxed/simple;
	bh=n3LehWgz9wnM7EuFvftUNoRlpMbwXDJqIaSXFpk9NEI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UHEGhpC8dm0Osb3VEr9b8qYLMGoQqGv9a5jwfS8DNKK/pAEFKYvD+XhgyMrNLz+6d9h0L/XkN8prGscja5pcFjMh6RohItbpDH8HhoMb58a3od3LlQWId92RsF0IJNT85JxAl5L+eEX+nr/2/Ne6Rr2qC27a17a6pwS5SIMGmUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKPFRKDa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKPFRKDa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43777C19423;
	Fri,  3 Apr 2026 23:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775257855;
	bh=n3LehWgz9wnM7EuFvftUNoRlpMbwXDJqIaSXFpk9NEI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jKPFRKDa6ASnKu0/FgjKgDVNXFPW40qQmZd2x71dXfNOoH6y9NNSEmBvC5qwBH+hq
	 fXlXtLEhtBVmp/Fj8ziOzD1aDV2ZzpW+KUxmqSQLKnCz9+nGN2o66epCOTV4FSGgTn
	 lP0PsLIZ9OFaJXnOsyi6+CANuin/OdQnIuuN9LcKjbPupVufAW6jexEQe47SRv1wQD
	 ynrPNp+PyGX/OfXuLb7zOY/UN8jWwQcZJw1ZDE42Ub/HKDn39IeKEAl07qoF6TvSlF
	 EsDNCxNYRG26RAfOpEeVVEr9w9TSsqRdR962GXw4s8iBjDkFjMo+4DVQkPbyFxDtL1
	 NFDk9erUEmfNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DC23809A14;
	Fri,  3 Apr 2026 23:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] stmmac: cleanup dead dependencies on STMMAC_PLATFORM
 and
 STMMAC_ETH in Kconfig
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177525783653.1484550.883019937304044818.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 23:10:36 +0000
References: <20260402145858.240231-1-julianbraha@gmail.com>
In-Reply-To: <20260402145858.240231-1-julianbraha@gmail.com>
To: Julian Braha <julianbraha@gmail.com>
Cc: davem@davemloft.net, peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
 mcoquelin.stm32@gmail.com, linux@armlinux.org.uk, kuba@kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, rmk+kernel@armlinux.org.uk

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Apr 2026 15:58:58 +0100 you wrote:
> There are already 'if STMMAC_ETH' and 'STMMAC_PLATFORM'
> conditions wrapping these config options, making the
> 'depends on' statements duplicate dependencies (dead code).
> 
> I propose leaving the outer 'if STMMAC_PLATFORM...endif' and
> 'if STMMAC_ETH...endif' conditions, and removing the
> individual 'depends on' statements.
> 
> [...]

Here is the summary with links:
  - [v2] stmmac: cleanup dead dependencies on STMMAC_PLATFORM and STMMAC_ETH in Kconfig
    https://git.kernel.org/netdev/net-next/c/e2f152c822cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


