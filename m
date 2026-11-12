Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794447609;
	b=QMSoee2dVFMEYItN6dOeXdihzQugI2l8qosFt9ldeVquIZtl8f8IG7jlCGBU4Vs6zq98
	 vuPsXSZ4CY65/AFOSl1ITEtu+vm2GnCA/j26lkmRz29pecjWMjxF7LJkWbd38MELjTlRN
	 Uz4d8HtQypWaqUQ6KFzzffNPpB3S9sjiKj5JLTWKo8kCOj+OkNbE/F+WF7i4mh7BbACas
	 7X+9X17fxso+ji/vGuA/KkAWYrSu6fz6vbowiJiVecG8BlNNbaEVMgN1YlK8g84mQiXpi
	 jjGz3X6Bs52IUvCLRPXfKP+za7l9jrhNe6lJ8z4DglA7pOa0RLuxBkFkkrVmaE+KAVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447609;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=qTUaQA0nyGIM0NFnBZIeMHfCdwcPW+K4thi1hIIi2LQ=;
	b=2YefUGamd5oWVXODY0+BsPDN6l0JC+06ClpKjbDhv7LnGtFviHRp9JJmr0wDmlx7t00h
	 U1+ld+UFjfrgXrqLQdUx/a8v5x6ugW+j1NgSvuXihmtzEPJoVppCh62Er5O8IVPDcHmve
	 6i7o7zIO//5/Gj9DnPW0bW0Tush2ZjsiA8SlTZ52PAU2GCF7iqvIxBSDoFChIo/B8Q6WM
	 NimuoNtmjpIXBEAXpUuGMFPR8IIp7ShASytTp8Z2KtXhy7FcBTxvrtlTNVQw9dEQ8Np6/
	 kbHAeE0RpzhYHqmAMcTV3AK0aama2xUQMrD+jFmbQUHoobWE3uI733athsay34WA+uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddO5SrZi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90297606A889;
	Thu, 12 Nov 2026 01:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddO5SrZi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD631F00A0A;
	Thu, 12 Nov 2026 01:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794447609;
	bh=qTUaQA0nyGIM0NFnBZIeMHfCdwcPW+K4thi1hIIi2LQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ddO5SrZijBP9vKh6rWyaTjZx0P7MLRyEbzTfcPvLdteNbnZvAnt6G5rN5RsKYQL+u
	 3ueb/iWUBTqclHeHatUhs/VcVbLajiQ23NHCqjXJU+2uFImWXi3KbFfJiWVvl6gi2k
	 KrS4HDGvNCjjrc8r8BjJJeFd+hsthGh94lJnzJJEyWIQ1tImYvuqLuViq5Gh1syiIY
	 BqbaXnUVNWc2pZgTbCMOezH1BR+mhIZwR8ouVx7gC6cbxBB88BmprVVlSn7unW7MWC
	 Oq57wNWCCBodpsMNDik54xc0iosr1Ut3SVJAL3RKI19poJWBa6Y+p3f6so88lMHR/G
	 BkAkIhNncx12w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 20FD4391AFCF;
	Thu, 12 Nov 2026 01:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] netconsole: register one console per target
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179444760792.1758664.17215567314338079058.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 01:40:07 +0000
References: 
 <20261110-netcons_one_console_per_target-v2-1-bebf45b2733f@debian.org>
In-Reply-To: 
 <20261110-netcons_one_console_per_target-v2-1-bebf45b2733f@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: gustavold@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 john.ogness@linutronix.de, pmladek@suse.com, samuelcrossley@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Nov 2026 05:10:01 -0800 you wrote:
> netconsole registers a single console (or two in case someone wants
> basic and extended at the same time), independent of the number of
> targets.
> 
> This was not ideal, but, there was no reason to change.
> 
> Now that we want to replay some messages [1], we cannot do it per
> target, but, per console [2].
> 
> [...]

Here is the summary with links:
  - [net-next,v2] netconsole: register one console per target
    https://git.kernel.org/netdev/net-next/c/0d97bae9abbe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


