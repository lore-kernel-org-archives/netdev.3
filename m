Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317B23EBF11;
	Thu,  5 Feb 2026 21:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770325211; cv=none; b=W3Wu6IB918OH6dHjhEoI3RXAUHIjgyJGjsOmvTRPh6N0MODe2tx2Xw0XJMEAEb1DG1lx2mIjNMf3aPZMdc2q4I+ZiL5PrfXcRjPFVz2FA56j8e82OPP1KW7LK/hFTsQCcgBApU7LVNj84Fs9/VUzx7XWo32ailxTijPZmZGVODQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770325211; c=relaxed/simple;
	bh=9Dj6wCF0oFG08tWGUeGZ4q2OypV/kwPBGU3bcPqvJnA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LfrI8WSAyXwzvAF5FhUXQZwVvaARBLrjWj5YLsPJ/X8uFWyxSK/gS6nZhywAXGjf5zna4zPNhGmHcgLfREpYAnCeu7Ukes8q2DiuReNJ/CrWMK+Jaxpqnz+e+0/wqIBoxw0UawWkpfSa5tdOZCVUo/wxQEYrdBubNTlGA8XBcYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPd3lN2v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPd3lN2v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD72C4CEF7;
	Thu,  5 Feb 2026 21:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770325210;
	bh=9Dj6wCF0oFG08tWGUeGZ4q2OypV/kwPBGU3bcPqvJnA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fPd3lN2vMqXaT239PUB7SIg65Tpyhuoq5dCIlRhz5G59BPvVEHwcemc42VQmVS6H+
	 Qp6PUHWtg9u6bxSG/6SL7l9IMKOTNdQEd4w2mbA5y9gqEg9ODZiYboxathF0mUe30m
	 e4IgXz8JJoDUhfUEY8B10HNtmzlsP8EZg5BR8zuluf9aQspsKynvjCKqgeCb/8WBOk
	 7FKxBylyK3+8n7sNVjP1TbENVOsgaYcyKm2PnjjHdYs5SW3ILUCtXGtDGDWBtKRUds
	 J90mjM2tdrnJMYul8J8vdhD4aqkEvTwhqWTdgJdXSnHRhxDnYUcdatzIU4yjv97BvZ
	 LLpEgia6yfMDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8553E3808200;
	Thu,  5 Feb 2026 21:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] octeontx2-af: Fix PF driver crash with kexec kernel
 booting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177032520833.564062.4499148622952657788.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 21:00:08 +0000
References: <20260203050701.2616685-1-agaur@marvell.com>
In-Reply-To: <20260203050701.2616685-1-agaur@marvell.com>
To: Anshumali Gaur <agaur@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 jacob.e.keller@intel.com, sgoutham@marvell.com, lcherian@marvell.com,
 gakula@marvell.com, jerinj@marvell.com, hkelam@marvell.com,
 sbhatta@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 3 Feb 2026 10:37:01 +0530 you wrote:
> During a kexec reboot the hardware is not power-cycled, so AF state from
> the old kernel can persist into the new kernel. When AF and PF drivers
> are built as modules, the PF driver may probe before AF reinitializes
> the hardware.
> 
> The PF driver treats the RVUM block revision as an indication that AF
> initialization is complete. If this value is left uncleared at shutdown,
> PF may incorrectly assume AF is ready and access stale hardware state,
> leading to a crash.
> 
> [...]

Here is the summary with links:
  - [v2] octeontx2-af: Fix PF driver crash with kexec kernel booting
    https://git.kernel.org/netdev/net/c/2d2d574309e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


