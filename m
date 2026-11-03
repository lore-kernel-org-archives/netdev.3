Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699407;
	b=luHySS9Pv2dYhZZXsUG2w9kJqFCJxiBqe9U0t04zH1JU0TT7QUbR6g9UmhUH3VJJuZ6p
	 uio/4jughZoEwpPnS6bfiTIFxn5kDcycQ8w79VWiGGDe+27gWnnrPpvHLuEDGipPnLZxk
	 aTU8J94Bj9Cr5foYP3Zu+wn3LAI/mJzwLK4g60HyZiEjqCnyGzjfJLPDEJoUI8HiWiNjW
	 FkCnBikaHRgZjBPBFA1G7a2PyDSC1rrLC0pOUJK2SYaVqKRFjftKcO6GJr7YfYRiD7Srl
	 w8yECYtIX4YUB6zyICXj9k6Me4WVRd7UCrT/o3QhYuSNGQIe8gU6SB6ST2Wdt1UaRiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699407;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=LmLtyCM55I8wW1tS/KVJF6td/pa17uMaap49/NRy7HQ=;
	b=4vqUASdf5KzQRNN23awoBTeHXNVeHBUUqHttgp62jJUm/aqnGdG72zsUBkVSQdL6zSDe
	 AGIVQPJ+dmFDOKKT9qiNV8usByKWRAzPWosgwH8KZclnp7MjR11yWTbKypeqrFYDbsAty
	 J6sx0xQ4cuotCZPfOvlHXSHIMipBCLIA0TX38t09zOonNZkG1KEcgAfnrgZA2HE4WnhD7
	 vIO5Iw5o4XVCiYBCvS1743U6/81N7VUQl6KHU9n2XH4B9RZjByRxa4lNzkFaLaQdb6FWv
	 t+SdERiNeAGgZ1W1wMio/UHGFegxp06BlSQEi14JdAJiNotYzh1dwqaCXssd5JvFynA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kfOHj3NH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15875606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kfOHj3NH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B251F000C1;
	Tue,  3 Nov 2026 09:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793699406;
	bh=LmLtyCM55I8wW1tS/KVJF6td/pa17uMaap49/NRy7HQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kfOHj3NHyMfUiHPZ5u4Vn8wBjgKzEsJX+3ZkA13p6r6pe1vMlvr0r4iaobf+I+oFh
	 RjHVYpTpOWUT0+jcEVSsNzUoo7HNYq5noM+283XvSt8tydXZ8u5dTbR76MPxeGgZVr
	 PiEWCuIYMy4pF8Fl/VYJckxbNbEYc0fFqt9mL9WXOymOieh8KZefNypjOWo7cwAOY+
	 c54O81JQG45QD/j1gGMGdkVB+G2HZACYuhs41kr0XUN24j1JJNSbtNg9FTHkvNt6NO
	 VVQ80Is+PLl2CkK+bFrZfs44JQeuHYdIRBZNyRIFX6IiV0vdGmAYYugU9sf6qQom2J
	 0ZwsS5iA93SXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D2E13805CCA;
	Tue,  3 Nov 2026 09:50:06 +0000 (UTC)
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
Subject: Re: [PATCH net] soreuseport: annotate data-races around
 reuse->socks[]
 and num_socks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179369940540.991644.4129274458698167088.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 09:50:05 +0000
References: <20261030120956.3026324-1-edumazet@kernel.org>
In-Reply-To: <20261030120956.3026324-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, kuniyu@google.com, horms@kernel.org,
 netdev@vger.kernel.org, edumazet@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 30 Oct 2026 13:09:56 +0100 you wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> reuseport_select_sock() and reuseport_migrate_sock() read
> reuse->num_socks and reuse->socks[] locklessly under RCU, while
> writers holding reuseport_lock can change them.
> 
> Readers snapshot num_socks once, then index socks[] with it.
> Meanwhile, writers can perform several operations, storing into
> slots below the reader's stale count:
> 
> [...]

Here is the summary with links:
  - [net] soreuseport: annotate data-races around reuse->socks[] and num_socks
    https://git.kernel.org/netdev/net/c/213d491308b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


