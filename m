Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C882512DE;
	Sat,  6 Jun 2026 01:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780709417; cv=none; b=D2BUMwX2ZRs4Nk8mFf7UKwzM536Acd3vUqLBHEfrqd4KS4+4idn4fsdDa0BpYq1PxhIZEkRvvHYvTgLfKUB6p1NFDo1iLoEdzbkfYT5HtXV7hOWjjaH83NCQ5movW1Mk9dtU5HCNoraWQcw5zALoZcJCAyBCiaYPtiqntWpWsT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780709417; c=relaxed/simple;
	bh=AOpJt3/ScylghXXV+c6MMBc7qzCZkF7NfEl7CWFjgKc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ULdfRUetjE/A6aFH7OTD8r4Fwlm4hw9i/RqGOJlxx7AzWY1wY9XAKQVtjHSknicl8XcFJ9DpbpfBw84usyVbjeYSPPG9IKacFVuoQO1JLqMVIr2AyD8rIV5Rjl/zGtjLpNNVItEOsjshGTqIIPmzgNqaLuBHbyhyAQAPxCqsN4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPJDRbo0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPJDRbo0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740981F00893;
	Sat,  6 Jun 2026 01:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780709416;
	bh=1pA8EYe0YDMvOlb0ipV6gDcp+OABRcE4wIuWa+Yf2rc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VPJDRbo0RLzBD7u319t3gnBdP+eTBpMUnlFQO7M7JbgOoSaTtlBkCstHd9fnmPi5M
	 qhdD5m/VNgVn2vXsbdzsPp+6eF1Na2+Um8sfhHVKZr3QhjggOuLjScL4Ix/d13isEf
	 IRWRjeUxl7FRUGaouyDLqRJwqdMHvFjBG1QMEyWYQuypeTF6MvmfJ14GA2OhoYrtYU
	 j6KyNb7Yg3tq5RgjaSDa5xRSpgjFUc6iKRI9iDEVtVJBjgPDN7FfLnLGE4f80GEqKj
	 KGDhbw8ZfYqCyG1jZukLlsp0lTeUKC/F+Lu2X1LSN6w26V9eDzNouuHPj8LhjiY1FU
	 CtXSyS3ZJ+acw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A093930A9C;
	Sat,  6 Jun 2026 01:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] hsr: broadcast netlink notifications in the
 device's net namespace
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178070941639.3983833.443113643619993173.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jun 2026 01:30:16 +0000
References: <20260604054949.2999304-1-maoyixie.tju@gmail.com>
In-Reply-To: <20260604054949.2999304-1-maoyixie.tju@gmail.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, fmancera@suse.de, jvaclav@redhat.com,
 andrew@lunn.ch, luka.gejak@linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ap420073@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jun 2026 13:49:49 +0800 you wrote:
> The HSR generic netlink family sets .netnsok = true. HSR devices can
> live in network namespaces other than init_net.
> 
> Two async notifiers broadcast events with genlmsg_multicast(). They
> are hsr_nl_ringerror() and hsr_nl_nodedown(). That helper delivers
> only on the default genl socket in init_net. So the events always land
> in init_net. The network namespace of the device does not matter.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] hsr: broadcast netlink notifications in the device's net namespace
    https://git.kernel.org/netdev/net-next/c/a762fabd7ef9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


