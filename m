Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACFF40149D
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 11:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777549853; cv=none; b=eK3XXd80cYn6+QjLh7ED3MU9CWuW80HsFAuBTD4ZW0RyCX5Sz68Xrndwig9lPPOiyf4cHSa25YiG76h7ztB5C8kez4TpiKOIZFfNF1Wra38VR/MN3ssoF0457zFKi2iPyRbEO08Gi47qwqiS2rhsZ1dVpI89+LQ1FeMTUKRUnV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777549853; c=relaxed/simple;
	bh=3uBdR9qgNDSlfENt1NsMp6pLX9NbAgBfOl21LYm0Z0o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pEOib1N/l4Z3Z3FTN8Er3F5mwS85sWsHhBOZzzu3xr/ygks5AH244jCwgyaZNTU19kgQ8YkurBpqEcbWSkrHtsWNTl41ZJmsNzKZg6WHcXBrA+g1j3TfmEp1Owml6xjT2f6Nx97pKgS9GHVCWhMfyam4/C7d70by9kBXJ5sv/MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2vH1+tf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2vH1+tf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8351AC2BCB3;
	Thu, 30 Apr 2026 11:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777549853;
	bh=3uBdR9qgNDSlfENt1NsMp6pLX9NbAgBfOl21LYm0Z0o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R2vH1+tfO8TVKVp1evmJIJvXcqYXN9U9kcFzzgI9YH3LTmXBBUcV/X/GzsEkk/hbf
	 BuCNG0je0o9JgzaHviZHdeZ3IidK8aGkLCV3JbBZsx+qjKODcvJMbJB3fVnosFCeU4
	 6XIG2Ara/K+9JDGWnU3mtN0DG4wiU1u7h03jDo3BrWsvCXpjrAltIXGDScLwIDnafd
	 uHU/E0F2JEhT+InX5wDcwYdwYHCfzOvg/+SK8MNZRSGnZ10S7CDQffyTX4boXwrpZp
	 R+f8W95n4gS5BSq0WJz6ehxlX09vwtz+Abq/1PjJ++X0U6Eu2gEua+UHd08QUEbcsS
	 eb9RWBBmiDoqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD3B380A97E;
	Thu, 30 Apr 2026 11:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: tls: fix strparser anchor skb leak on offload RX
 setup failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177754980804.2967170.17616497515028307506.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 11:50:08 +0000
References: <20260428231559.1358502-1-kuba@kernel.org>
In-Reply-To: <20260428231559.1358502-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 john.fastabend@gmail.com, sd@queasysnail.net

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 28 Apr 2026 16:15:59 -0700 you wrote:
> When tls_set_device_offload_rx() fails at tls_dev_add(), the error path
> calls tls_sw_free_resources_rx() to clean up the SW context that was
> initialized by tls_set_sw_offload(). This function calls
> tls_sw_release_resources_rx() (which stops the strparser via
> tls_strp_stop()) and tls_sw_free_ctx_rx() (which kfrees the context),
> but never frees the anchor skb that was allocated by alloc_skb(0) in
> tls_strp_init().
> 
> [...]

Here is the summary with links:
  - [net] net: tls: fix strparser anchor skb leak on offload RX setup failure
    https://git.kernel.org/netdev/net/c/58689498ca33

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


