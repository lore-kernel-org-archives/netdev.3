Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F13327BF3
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 05:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770786610; cv=none; b=OoNAEJSBUF06EOtQR/OF6w8O/erdHfqdLyjd5G6MMvF/DvnSWhj93oLYfnmuwxyYCRJ7GEczFa8MreNm2NlTsth7RzMUwxG1akso31MDZIYskW13lFLxE1yDyhpiQw4ZurZtUo9ttyqsWCij5+MN+jjRww5ga6JjBM5G01zwX54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770786610; c=relaxed/simple;
	bh=2Wsk9J6KBxK3iA8HSQ84vhrIO8hdJFvwB7BYJoWDo8Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nDDWr0SExrrqY09QSEzh1kfB5si49aMY8IJ9LMW+P4XOdzgRAqnwbcklEaB4Tz8hhSQR3GqRtCbWw1FgEuLrZclTYC5swYl7DKQ90N0Hzgp0cUFFm6qwODOcKwAU6zndmElxctMURUwIMuYGpkTeQ67D0e3XdE3DpxoPPUE1FUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlzW3tW+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlzW3tW+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7127C4CEF7;
	Wed, 11 Feb 2026 05:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770786609;
	bh=2Wsk9J6KBxK3iA8HSQ84vhrIO8hdJFvwB7BYJoWDo8Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DlzW3tW+aGIoaQuNTRsaSoJvnZPm3i1vpqB+Uaqc+Ytg1aaBOTWtRLKSHcDpCbHO+
	 00VF7EYT9BUx3TL+/QbMnKelEN86NcEJRaKHbvF71v2IgDu4rclsRLaGPf55ebfJoF
	 DdAh9o7+THj8dwpJ9FibmxqHYT2UalzDXvNWBZlVR71Hmqdm0Aqza8rVH5KR904AVT
	 QDmlsVLMOjOBPr39KloKb7fu68D7jEAqCi38EgDFhJD5YxLoP7Ppg2S3d8b00YgTWS
	 YcxuNAj61mYb8uwYmfXAzuY7XULd2bUuDy9XINGpVWKmTyFCiDFYDEajE1eXc3vnTE
	 McZc7hCJYszOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B07B380AA50;
	Wed, 11 Feb 2026 05:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ionic: Rate limit unknown xcvr type messages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177078660483.7583.7365563668694669374.git-patchwork-notify@kernel.org>
Date: Wed, 11 Feb 2026 05:10:04 +0000
References: <20260206224651.1491-1-eric.joyner@amd.com>
In-Reply-To: <20260206224651.1491-1-eric.joyner@amd.com>
To: Eric Joyner <eric.joyner@amd.com>
Cc: netdev@vger.kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 6 Feb 2026 14:46:51 -0800 you wrote:
> Running ethtool repeatedly with a transceiver unknown to the driver or
> firmware will cause the driver to spam the kernel logs with "unknown
> xcvr type" messages which can distract from real issues; and this isn't
> interesting information outside of debugging. Fix this by rate limiting
> the output so that there are still notifications but not so many that
> they flood the log.
> 
> [...]

Here is the summary with links:
  - [net] ionic: Rate limit unknown xcvr type messages
    https://git.kernel.org/netdev/net/c/cdb1634de3bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


