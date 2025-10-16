Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD301D5CE8
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760623822; cv=none; b=Jauvth74Ba8o3WDSQZmmEyS3kDbr1SAdVP/cmdakYRVnJvBFzd1bUpwIh2IXn5WJUcgreeRFCfCkBa/V+ovYibzMcf4Z/sKpEb3l1SwFUNzd9XtRQfYg0INJOu2S61/oGZ/1nHLZ9f9s4qlK3+o8bN5mV1OyxQ7GwfKSMc/Ufz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760623822; c=relaxed/simple;
	bh=VsVPBNIITEBNKmEDKe1kdgO7Q8nK9FT6ONFFF8tQn/s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s9Hj0ssAN1kAi1zZWwuatFaTnTtZ4XIRrGLR5Bqqjyh0tIC87QgFjz2JD+DeuB67RzT7iLFclAjklF4uf8Q9zXnJv/JdsHNWbaUKGD53BwWgTBSNIFkFA9AIfYHuTxSx/8BRCMAhZXje0mypkS8G9htrLuVA/u0M2mVQFyWNjrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgJkRnGN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgJkRnGN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D611C4CEF1;
	Thu, 16 Oct 2025 14:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760623822;
	bh=VsVPBNIITEBNKmEDKe1kdgO7Q8nK9FT6ONFFF8tQn/s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XgJkRnGNaWVdydEkGjjLoWzGOTW1mqaaFqJ36QNXHuhCDFsitWure3y0yGpafSuuY
	 bpWLBF9RwPgJyDlzCLu28e2csfbR9M61MJbBzu2KjQVL/7I7bdH+KR+MQ066BMHFoh
	 v1zUPRYRx99PzLw0+sdd0HrbaodbafyN6MbAKx4BMGpALHPCdxF3nOfhFjxWLwujaN
	 Ss/FGbEftADJGHhlRac65v/1sZtwhpRwZmPJ/zS+tfMY7UZpzYWWyvZYeNxVotjghv
	 dLqegOV1nEqVFmyf3aEg1mbbSU13ReVS+UXGDrLdfL8DmuXQNM+HsVeymeZyU8ZJ6r
	 pzEUZLfPjCF+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF1B383BA04;
	Thu, 16 Oct 2025 14:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] udp: do not use skb_release_head_state() before
 skb_attempt_defer_free()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176062380651.1368238.6493983404009483154.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 14:10:06 +0000
References: <20251015052715.4140493-1-edumazet@google.com>
In-Reply-To: <20251015052715.4140493-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 mkubecek@suse.cz, sd@queasysnail.net, fw@strlen.de

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 15 Oct 2025 05:27:15 +0000 you wrote:
> Michal reported and bisected an issue after recent adoption
> of skb_attempt_defer_free() in UDP.
> 
> The issue here is that skb_release_head_state() is called twice per skb,
> one time from skb_consume_udp(), then a second time from skb_defer_free_flush()
> and napi_consume_skb().
> 
> [...]

Here is the summary with links:
  - [v3,net] udp: do not use skb_release_head_state() before skb_attempt_defer_free()
    https://git.kernel.org/netdev/net/c/6de1dec1c166

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


