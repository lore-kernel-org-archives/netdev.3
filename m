Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253072D9EE2;
	Sat,  7 Feb 2026 04:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770438029; cv=none; b=RAjKSsjwYSWDKOesLCBrL8cXBs8phxNTS7KsxPP8crzYKvLu4bLyTgy0m6Yml3I95XSCYzQI6o1lQaW6k71EhtZr+/jxtOPK5+YZj7CuKnMJCK7KL3QanMe+tCVoPPLgs2NDtbOrB2TDqJdjojUJoQcwOzAA8XX8z/yOPi2Z5iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770438029; c=relaxed/simple;
	bh=cHunVYjdi3QqN59UjSYF/Xx79kytWAjzEEwOQecXZkc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MZwZ0yqwh2anhwMu5fGvZbWkypSbaoshHvs4LncSvaoIJrw880GZAZ3AOnCIRmO2uO+p1NUeK1II72rJwT7Jg2JlON26BsxjoWnXIKwIA9LWrZS1rYur3ZWk3kl+m47rH0XBzcN56c885VT4tPMeoYB/FJz3bIsp1Bf5syc3kKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+PvP3J/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+PvP3J/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC21BC116D0;
	Sat,  7 Feb 2026 04:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770438028;
	bh=cHunVYjdi3QqN59UjSYF/Xx79kytWAjzEEwOQecXZkc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D+PvP3J/xupPJvahwC18U1TRy181+9jGxLmpdOepxOrIz3lpcnbW4k2RuQHPmcVs/
	 zm0I0OB4I8hvd8lVznjAHT2kBfxS4qL8sTFXfedEyuBszbPTRPuAUk2GkbefytacVb
	 S5R1dwIX2vbnbJvsyrsG8smnkw2BPRXHAFhBp9ZZhNabw35tGXRwE2FVb+i7XKX5ny
	 MLxHLf3yYdlG3+/4tr83GYQMGfupFkPibpGWfox/CmKDM/uAdT0mgzaRbeF/zBcjFc
	 qOB1C1KlhkC7OI2QZFu1KvEQbwkehu09Nf88kWb9iiEQnlstbydWCfkSVpl8TVKd5f
	 ZGvEy/YwJlN0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B33E3809A1A;
	Sat,  7 Feb 2026 04:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: skb: allow up to 8 skb extension ids
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177043802582.1183264.2392961763237391882.git-patchwork-notify@kernel.org>
Date: Sat, 07 Feb 2026 04:20:25 +0000
References: <20260205-skb_ext-v1-1-9ba992ccee8b@hartkopp.net>
In-Reply-To: <20260205-skb_ext-v1-1-9ba992ccee8b@hartkopp.net>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, fw@strlen.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 05 Feb 2026 15:44:05 +0100 you wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> The skb extension ids range from 0 .. 7 to fit their bits as flags into
> a single byte. The ids are automatically enumnerated in enum skb_ext_id
> in skbuff.h, where SKB_EXT_NUM is defined as the last value.
> 
> When having 8 skb extension ids (0 .. 7), SKB_EXT_NUM becomes 8 which is
> a valid value for SKB_EXT_NUM.
> 
> [...]

Here is the summary with links:
  - [net-next] net: skb: allow up to 8 skb extension ids
    https://git.kernel.org/netdev/net-next/c/abf981bb8de6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


