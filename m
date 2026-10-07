Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636FD35F619;
	Wed,  7 Oct 2026 23:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791417011; cv=none; b=TJDqBd4ZdO8oThKEJNhWBcDAMMcyyOt6hS3fXMXLIoeJVngj1wTws2zZXwU6S1B4EYk1DrHbl/Uibf67D1554yWcZyI+ikuBRQftaj3WgxKEgFjbNFjOJTuLcBxBtNFt++ktpxurW3AsmhI6dO+0N6sZpiLKkoH9dE+thVUtu+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791417011; c=relaxed/simple;
	bh=JbTztyFIvqyGePww5m+R077nd7Bl6c8uT21VweUddOc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rik41ZOxv0aHWg41Ac7XVrih+xgFJdKqznnXz4bmVGDm2o7jrc3kiM0hSMU6VyLRuAYTt3Em9LVzhpSRIfoFdwp1eAeiozRXTh6DkJG9YxWTfd43pCSQSNrwMXUSzbFYj61QKEKo807SlkQWAO3TZ136Ks57Wthp0RInlIZbC7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lz3wT1G8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lz3wT1G8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066981F000FF;
	Wed,  7 Oct 2026 23:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791417010;
	bh=FHCZ4jzwq0SUmQozvYYGYAytoGKzCG0emXp6tqpGgyg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lz3wT1G8q9z5RJ/SDn2oaMdKQM2Vl5EmX+Qf7Ylp54t23KDdaI4wOAEQV6+v7AS2b
	 dT4W57fzc0vsz5l5NMrWHqVFudXzsZnlU+a9Blxc43+31LlECwRpQvDT8SLeWSgiVB
	 mrKv4uJyKkb3iHmDa0WOS71FeBJTCaBeYm2ZdrutCDJ2kwd01cKcOO7mFGqsKWdpbT
	 1m8r8XL4zRiYC5aJtfIYzd2Kik5POV9wXAkQu5WsRLKqvOoqiYOQ0S3qzFS5YS66C9
	 xq97vHNziboxK4utu2JTwPuPt3TMkahLbwryEuBSrXyNKr0FBq4t05NKLSBBgLZA3b
	 ijaNEy+lRlieA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F14BC3809A08;
	Wed,  7 Oct 2026 23:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] net: axienet: do not report TX completions as NAPI
 work
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179141700857.3739009.7908196051581049456.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 23:50:08 +0000
References: <20261004065930.1004953-1-maimon.sagi@gmail.com>
In-Reply-To: <20261004065930.1004953-1-maimon.sagi@gmail.com>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 suraj.gupta2@amd.com, radhey.shyam.pandey@amd.com, michal.simek@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 robert.hancock@calian.com, sean.anderson@linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  4 Oct 2026 09:59:30 +0300 you wrote:
> axienet_tx_poll() reclaims every completed TX descriptor in one pass:
> it passes lp->tx_bd_num to axienet_free_tx_chain() as the descriptor
> limit, and @budget is only used as the napi_consume_skb() bulk-free
> hint.  It then returns the number of packets reclaimed, which is bounded
> by the ring size rather than by the budget, so the poll can report more
> work than it was given.  This was seen after TX completion interrupts
> had not been taken for a while and a full ring was reclaimed at once:
> 
> [...]

Here is the summary with links:
  - [net,v5] net: axienet: do not report TX completions as NAPI work
    https://git.kernel.org/netdev/net-next/c/f9d58127380a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


