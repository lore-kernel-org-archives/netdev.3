Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D49C4519A6;
	Tue, 22 Sep 2026 09:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068877; cv=none; b=FM5Y1Tr3Fcjysa5+zqgVrcFPU0ijPiNBICvg7kgkHRF56H7NQUBpuOBvxljVLALYtqYUpObf8ojXucrswtdzHJ1arP3fMof2qQMVuQfZiMttuoEzYjJU8GiWGT+4bEUS8qI3+4wsjXVprHKk+zLTeheT5cHIOjl5zd0ER0rbpJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068877; c=relaxed/simple;
	bh=iYFylkrRCYiHafmlZNQXvYWQiWJntKKmIo6ABcCZUdA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KgKLNI4YV4kzZD5L3zLmNgNiFZLYSDiQ+g1v1gOByMm3WS4uNWAhqI93VqTJzC2dLAtl0RwNRdQTcWSSaXcc6qEkRoQ3bOFMtL5zSi5zv53ItK86T2lkJIgBLGS352XScmN6DdEp3qCCx0MjL2GUvk0VoROLq2pzcjgBXkkxQ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDzTdj76; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDzTdj76"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA75D1F0089B;
	Tue, 22 Sep 2026 09:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790068874;
	bh=baWabGjQWvZYqPpIWsZhMX4j2Buumq3WHDl6HOiphcQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EDzTdj76fX5PnA/25GZTn3IHPva/SMU3IRCXHVctHXVbiAQpgznRSAdsnfJEwuURG
	 Zu4H0/z2QhDbZa+wv+12xvBXhECE3KQ+a82HlWRUPW05LYUUk1FXQE0SMzyxW4fl9M
	 ek2w0F4GV4R4FPDex0tkworDjyVT7zBfgAJns2yLw3wwLYbboi3EysfPROw0yRqD3H
	 PCII92ZzUtUII5t2o9YiyC4ilUQtmY20LW7saX/kSfKWyHTifDQ2RInHxcAAvp5dHX
	 vodeTIof2HNxBbbsUKDgDBQ1m3xtbpA0vvIENQqq6xoPH3i0nHCs9A6tf0J5TokpUa
	 4pvijGFKqDJyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B5F3811954;
	Tue, 22 Sep 2026 09:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] tg3: clean up PHYLIB resources on probe failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179006880515.3509277.1692281209215676980.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 09:20:05 +0000
References: <20260917183336.36239-1-mhun512@gmail.com>
In-Reply-To: <20260917183336.36239-1-mhun512@gmail.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: pavan.chebbi@broadcom.com, mchan@broadcom.com, andrew@lunn.ch,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ae878000@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 17 Sep 2026 14:33:36 -0400 you wrote:
> tg3_get_invariants() can register an MDIO bus and connect a PHY for
> USE_PHYLIB devices. If tg3_init_one() later fails, its common error path
> releases the mappings and netdev without undoing those PHYLIB resources.
> 
> Disconnect the PHY and unregister the MDIO bus before the remaining
> teardown. Guard PHY cleanup with USE_PHYLIB to match tg3_phy_init(), and
> call tg3_mdio_fini() unconditionally to match tg3_mdio_init(). The existing
> IS_CONNECTED and MDIOBUS_INITED flags make both helpers safe when
> initialization only completed partially.
> 
> [...]

Here is the summary with links:
  - [v3] tg3: clean up PHYLIB resources on probe failure
    https://git.kernel.org/netdev/net/c/a92e1a412c53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


