Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5362E34B66F
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 02:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788402090; cv=none; b=PLMKdbrReLWTOqMNFXtBqef3ugEpUgXyxV8lxWpVKDCMqn0bCXapR5+tcez8MXHbvZXf1Kp1l6kjnO+K+vIZW3ntUDJ964WCZjhH9ppmbGA908c2kC0t0iRmbFGsh4lLDUYluskKYCLFKDdyLAy00hOE9xDb9um3IBTMtw4EVs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788402090; c=relaxed/simple;
	bh=7lm3Nt2X8Dy67mnSoJ71HUuXgbfLJDtD3FLzqB2o9hI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O1Pt+AxwsydDWnNlXMFxu64oCCyC9g/9GnNjXfaXCcBElNEstoOrkErnDHPKIuPxHJZt8q5XXKLUuD/lsMuvKmssT6AIjTmaWrlrVhxy4J518vzhUXeIJ5o7ODRNgpr3JMygxPeLVbvPhNb8Vzp1I+exzp7gohzZZcm/xV7uv5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anYxVPTA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anYxVPTA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C5E1F000E9;
	Thu,  3 Sep 2026 02:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788402089;
	bh=/rLdeBmsEZNzQeezcNsWKRrbBKw/WIClYSQlEmVvwaQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=anYxVPTANkKmNXcX8ztY7Z9tLinp5mUAR3G25cf48+hIjakitUPF4HcFaTdgjNe2k
	 QFcIw7eM9YjFyy5ZufFxSmvWC2FH1rHa+TwQjYGf/XkYs+2whK5X03u+rOHkZFG498
	 4aV2/mU818y0hG01BfetY2LWLhdcyNp9PtTZGJCzNLLz+uhOv2MY6vm6EH896SVF/F
	 aXWdBBPncxAS8JEKR+6Zp+ypmkzUcVjBKGHYrU74+SrMxtaGiBcbyN7Bfscrxpsanv
	 WDjiW+oYfC4CTRKU631nfZcD1TvJUyZFUAw8H1RT5xGVxJXrfq8H6821/130LdWVKl
	 k/BmulzUy1o1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09E03927056;
	Thu,  3 Sep 2026 02:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] netdev: address a handful of nit picks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178840203040.3047971.12295032087873985710.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 02:20:30 +0000
References: <20260831164159.1124679-1-kuba@kernel.org>
In-Reply-To: <20260831164159.1124679-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 daniel@iogearbox.net, razor@blackwall.org, bobbyeshleman@meta.com,
 sdf@fomichev.me

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Aug 2026 09:41:55 -0700 you wrote:
> v1 of this has been sent back in June, it seems to have fallen thru
> the cracks.
> 
> I got slightly concerned about the state of the netdev-genl implementation
> after Gemini found the bug fixed by commit c849de7d8757 ("netdev: fix
> double-free in netdev_nl_bind_rx_doit()"). I fed the file into a couple
> of models to make sure we're not sitting on more bugs. The models haven't
> found anything worthy of a Fixes tag but some of the nit picks are
> borderline worth addressing.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] netdev: correct error code in netdev_nl_queue_fill_lease()
    https://git.kernel.org/netdev/net-next/c/fcfb5ff9dfc3
  - [net-next,v2,2/3] netdev: avoid skipping objects on race with device disappearance
    (no matching commit)
  - [net-next,v2,3/3] netdev: don't use dev->flags for IFF_UP
    https://git.kernel.org/netdev/net-next/c/17d7aa695408

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


