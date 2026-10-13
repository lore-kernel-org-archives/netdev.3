Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3CB3806B4;
	Tue, 13 Oct 2026 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885006; cv=none; b=eg1ONyShHTXfkGJ+lKg9KSlSbzl7WAv2eZYUCLs1aFz0L0hXqHm++37PZ70oxzTp/jYMbHGuEpqW3/9UF34FvXKql4zQaJ9adqkXHLRRS6LoWNrVoxvchXstEs8SyP4kZYnsVyigTeyKlry4+k7D2zio5nUVbS1Yqj+CQ2tMsns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885006; c=relaxed/simple;
	bh=NXAtj3ghpHjf8aaVPjmzBSzFIT23PVn57KUgoGolgiA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SQqZlbCrjuzrTdKct4esMbH44r5bcXxIhUtKJGLW0N2FqHnQZ9OrVB3CemdyCRQ8lWsp3HMcFNru47V7MqDZ0sO54vuxbmSX0hebbnrWv+NNAWVrj4it9lrFthYZSkMSj2RZWOtgK4Ft3nmjH7RSMU7Z9cZd+E4geO8gqxB2ZrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGK9UFV0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGK9UFV0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7581F000FF;
	Tue, 13 Oct 2026 09:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791885005;
	bh=ztPUa1U92ZM+yjVuQhmEia3J8WOM/4O6AHdcgl55hu4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IGK9UFV0ZQP26jgCMggWX3LSTpsg7r5SM1LtItiCVWVV3CajnyNb0JvzrPAWYS58I
	 1TUpoGBmK4HqH5TLO8OoRgmEOjs0YOMyEnfeOZw0O8+NGr083JWzS+UUF7h/puhYEr
	 fiTHck5jU3KzN8Qfr79gE00yMzrFB1x5Fn9BN1OKO92sOA6PxnaUHQeGw1DaPE8hNw
	 8pJwBtzZQbjzf0S1Bb840aORmQP8hQedBHx2tUC++LhKSb409yF+el8W6MMevFxpvE
	 BO8PtzqrekORZPWGQuHuNUTbvwZGgE6rLe6hkwGlbZBO+ObfrGmVcYTjwr2eml8kEz
	 AbIvrUkz7mESQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7740F392665B;
	Tue, 13 Oct 2026 09:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netlink: reset skb headers before unicast and
 multicast
 filtering
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179188500427.177823.5830234053974309894.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 09:50:04 +0000
References: <20261006224232.50724-1-kylebot@openai.com>
In-Reply-To: <20261006224232.50724-1-kylebot@openai.com>
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 outbounddisclosures@openai.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  6 Oct 2026 15:42:32 -0700 you wrote:
> Socket filters can use SKF_NET_OFF and SKF_LL_OFF to read relative to
> an skb's network and MAC headers. Netlink producers may reserve
> headroom without resetting those headers, allowing a receiving socket's
> filter to read data before the initialized message.
> 
> For example, IWPM HELLO replies are allocated with dev_alloc_skb(),
> which reserves NET_SKB_PAD bytes. An unprivileged NETLINK_RDMA user can
> attach a classic socket filter and disclose this headroom through the
> length of the delivered reply. The resets in netlink_dump() do not help
> because IWPM sends a separately allocated skb through netlink_unicast().
> 
> [...]

Here is the summary with links:
  - [net] netlink: reset skb headers before unicast and multicast filtering
    https://git.kernel.org/netdev/net/c/8bf659bd54e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


