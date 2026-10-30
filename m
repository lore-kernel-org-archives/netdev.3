Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793401207;
	b=4mqbBT1RissTjNUCM99dRvj1r+FzSInCbv+F1AdguTT+M/P/MO9bUBh/uRmH5ErI1T/u
	 nAEJGjesclWE7KInPKtOmaq0nudXnf+FxzDkY5eB9xlq9u3yb1escGvA8IP6bJRJtHTwN
	 7JzU07szhRPnnOTMKWsKIiWpYEf9Pk1gh7FXcZVlgbMVSkxVcS+FaWohAk/2L4QpGIpKQ
	 rbGWZHOxA5Qd4yn1QUlm8HCUiIdo5qSA8wVaWfUAN+WlpMHNApfov4kfQVQfcgIg3C9V9
	 bHPxTu01KBTC5QyhxJovFLK+MwuhyvkSNJURgn196rmbfJU/TGClbNJEGxF0esbaVvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793401207;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=osr5VkiWXvDktjhH5ErCuXVZ8pTUO5HJxnMX8wvP8OQ=;
	b=F53O4nSFcbDz936poL0bkI9meJ7THjm8+hGm+RRS2XhigBaZEiaKtIxTDOTsZ8/z07wO
	 7D7rqBzdFir6qwH8xoan7G44q2EVDFrvulohX1VTLKJYeuVrWFUdK0YmhrNFZ9IBsV+E3
	 CqFesnCTiSRVI30QlKPDQrT+isf/1UiftgOK8l9gq2qNQmFlOxSS1CI2VnCVsM502rtR4
	 Yd8axM+NVzDkZ5LeAFpM4ZJvh4t6Ky03eOFKdL+uQnilTttMbOi9hpVGzSLME4Fx7qrRq
	 Cr56o/avJKdic1/ZI0W19XDqyjKd2HPg0mK+1/8ctLT15n+sMrg1wubaSM5aAAtEkCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S6MC5x4a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B827A606A31A;
	Fri, 30 Oct 2026 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S6MC5x4a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C94C1F0093A;
	Fri, 30 Oct 2026 23:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793401206;
	bh=osr5VkiWXvDktjhH5ErCuXVZ8pTUO5HJxnMX8wvP8OQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=S6MC5x4a6Zj745NPvimsN7uFs2MbYzpY+Nt1KpWjaeZPW3GRUgM04g52GVMVUkYIp
	 2U7cvBUcxTkN4vcgn7w5g8OvQCFhIPBwIt9KnszcGqlqTRJzE/30d5FT0Xpe65+pQ5
	 fIAOBL7pbDKPYRVAcHHnDn1bosUWuI0Iu2ukSNYF2+wjXewAbUN2UrU3sbpEllErHL
	 bPQ8Bbsiw+my+arF2CSH9+HP7PEMKN9XSOvB7fzn3HN8Wa+06hRgstl8WqIYGtF7If
	 wE4xt9bPMfjHypocAEU8ZtcCgzlI6kTq2AGIHt+RmErZTNe/GIVEP1tCh6Dqy5ieJW
	 CixNMMIsYDKYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4012D3800478;
	Fri, 30 Oct 2026 23:00:06 +0000 (UTC)
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
Subject: Re: [PATCH net v4] net: Use a dedicated flag to track disabled napi
 instances
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179340120505.1817172.4977674769262712465.git-patchwork-notify@kernel.org>
Date: Fri, 30 Oct 2026 23:00:05 +0000
References: <20261029153130.121204-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20261029153130.121204-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux@armlinux.org.uk, kuniyu@google.com, sdf.kernel@gmail.com,
 thomas.petazzoni@bootlin.com, alexis.lothore@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel.machon@microchip.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 Oct 2026 16:31:29 +0100 you wrote:
> Trying to disable the napi threaded state while the napi instance is
> disabled will hang forever in napi_stop_kthread(), as it waits for
> NAPIF_STATE_SCHED_THREADED to clear.
> 
> This won't happen until the next ____napi_schedule() call, which won't
> happen as it's disabled.
> 
> [...]

Here is the summary with links:
  - [net,v4] net: Use a dedicated flag to track disabled napi instances
    https://git.kernel.org/netdev/net/c/8dc87fc5d6a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


