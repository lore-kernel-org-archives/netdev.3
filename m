Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6236B34CFDC;
	Tue, 24 Mar 2026 00:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313420; cv=none; b=sD8pMWXg8qhJ6HznEpWctCqht0EPBYzdQRNjPorLMIRRgNQ3y0hixZzg6Jwpd1PiMHBfrkJjV4gAoRQasvhd0JUe22kdk8239hiE7eJQnlm61YJumhAmbXdlPvMia/A7SLgFJRYj/30EbmJLBnWg3E1QrUBmIfIhIGbwmcJ0Zwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313420; c=relaxed/simple;
	bh=JKi37m02ysGGaDX22rah6C5f382uv4n68JZXkVg1/pw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DVzDKwpYC3UqykIsoMk3ROud3bVaYHuFMiTA1GTLXKHl/yl8n1c+ZM4H91MDJQ2MWndn6RqSCdL5v/gIz3CYQoI0mIu1bWL7alN9Jhp82FNRw5Qu9yTNH7K2EHMzER4CZsDUcvskPZw80atUkVdx5O5CbB0WsNS/MWrpOv8Oc3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EA1lPRk7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EA1lPRk7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14178C2BCB3;
	Tue, 24 Mar 2026 00:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774313420;
	bh=JKi37m02ysGGaDX22rah6C5f382uv4n68JZXkVg1/pw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EA1lPRk7femanXt0GavT4f4tPdaMa2ueHPgOVGMETEsdhpOojt20I3hrOri+XQedb
	 4K3UB+rQ3tDaxkHAe7Rv5nY70rL+aPqNR2IpSr82CgVpKNd3NgjAoCpyoiBx+zHhFh
	 A7DEfb/50zGe8OdpPck6Cp8clL8q2WnVmc4ht4RZwtT5nhl3q1nti85kI7X+i6lPdm
	 LXSBBpAsurBm/L8aQueHdae8FRc0uYQOk3tnJ4qq8SfLz8IXouTAjPIrILjofv37uF
	 9JZNehWFeJF/ndP2kZK9XMf4c1Hqx56/dSw7egIV8ezieQKCjXFZWAiEWTjmnv44BX
	 GVVTHo79shKdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D04F3808200;
	Tue, 24 Mar 2026 00:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: airoha: add RCU lock around
 dev_fill_forward_path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177431340803.395707.9019086790298315376.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 00:50:08 +0000
References: <20260320094315.525126-1-dqfext@gmail.com>
In-Reply-To: <20260320094315.525126-1-dqfext@gmail.com>
To: Qingfang Deng <dqfext@gmail.com>
Cc: lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pablo@netfilter.org,
 horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Mar 2026 17:43:15 +0800 you wrote:
> Since 0417adf367a0 ("ppp: fix race conditions in ppp_fill_forward_path")
> dev_fill_forward_path() should be called with RCU read lock held. This
> fix was applied to net, while the Airoha flowtable commit was applied to
> net-next, so it hadn't been an issue until net was merged into net-next.
> 
> Fixes: a8bdd935d1dd ("net: airoha: Add wlan flowtable TX offload")
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: airoha: add RCU lock around dev_fill_forward_path
    https://git.kernel.org/netdev/net/c/1065913dedfd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


