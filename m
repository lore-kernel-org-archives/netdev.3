Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85341EB5E1;
	Sat,  7 Mar 2026 01:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772845808; cv=none; b=m69b1N7GID9XPVpMMWptvR43NZBFLdG22lAw3tFB6IgIEos1YvC9Xz0XFqv08/C1Sm1p4GBfKjXpLqARDC9K2dYNJHstodOGtezYwd5vQ6qM3YyS+fIJu6ZF3nTCPg/xCV3YYYOEfRPouJRuFgb0p5PIcHw4pfBxWK0GKztilxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772845808; c=relaxed/simple;
	bh=NZIOhlmstK9g/Rc3Wawp1DZhKRqRWjccpgWOpIAlC1M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rB3HOaJcIbioCm4RwdJpZ2uJoZtPBxxHK6bQdADszO3K6VxxWMsBvOYKIWDHXTpZ+AnVveYJFsksiIU8L1vdzoZRDDECWxsbWStKReEhhQn0rMPpLnG483OEWl27s0PJcf4dvL9U3HK5Kd0jUifGdCYv5mNC8nSno+KMzWF7ZlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7WkVJqJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7WkVJqJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695E4C4CEF7;
	Sat,  7 Mar 2026 01:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772845808;
	bh=NZIOhlmstK9g/Rc3Wawp1DZhKRqRWjccpgWOpIAlC1M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r7WkVJqJUv3BqzqlcxYAUGjPdp8y9QV6d/ftlQmXmJwdjmM708RjlD8YT1Qj0SMmD
	 NaNNCAmlSLiuHnGx5JE0Fl5vTjAors6e4te6xaNlQxgksmnq/GwAe/BJafd3tyMJvj
	 or2wvaLNthM433dYrvlotNr8MlRDRSpV7qjqLMP2dz48aUcf0X+9EkQ8DY8UWYqybB
	 Bv+EOrBNhj88rgkbYqfIEEKaRE0+s6fDWPF6bfrmn8dnW4kLm/Jg6gobvzQykn0aBc
	 y33gKF72vZTYEZ85zSb6Gly9iceKCQsdNnDKERFxSF+lXg8UoHslaKvtehAWdyU3E8
	 vKHeeR8XREEdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F8C3808200;
	Sat,  7 Mar 2026 01:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: annotate data races around sk->sk_prot
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177284580755.113222.11663195355403915801.git-patchwork-notify@kernel.org>
Date: Sat, 07 Mar 2026 01:10:07 +0000
References: <20260304064253.16955-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260304064253.16955-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, kuniyu@google.com, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Mar 2026 14:42:52 +0800 you wrote:
> inet_sendmsg() and inet_recvmsg() access sk->sk_prot without
> lock_sock() or any other synchronization.
> 
> sock_replace_proto() (used by sockmap), TLS and MPTCP can change
> sk->sk_prot under us, so these functions need READ_ONCE() to avoid
> load tearing.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: annotate data races around sk->sk_prot
    https://git.kernel.org/netdev/net-next/c/ad4c9559603e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


