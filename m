Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E007262E
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 04:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770267018; cv=none; b=XcsBYezpqgax29Wfg5wCuOlizBQ4sJGMkr6VHPqeBF20vw4rudzEAi4Omuvz2t9umai5X/PC0OAHzOy6ZSvIgY3dH3thyOqjpvmUoWD5JtToblXRe5bm4ZOXYWR3yQ9Kt45hFSU9OciIVpIpjcvoJv/5KXarXoAk9cgh6UOMXMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770267018; c=relaxed/simple;
	bh=JeMW1bvYxorZFwlXeRYXI1+MWEAhxcFctKjNyB32qRo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CzMyIb6EvjEfTYzErh4jsUv9ElKqOAVyuoK+UOaTvw/Jf/ASgD3u21odJV8wNzCcS34QEwyB53rGQTqNeSGspDX24Rs7zUFvXWQn4dW+GLOvB+YGp7UqaVaLx9MT3nCOhshK/Yop05G1z+UZDd41IQmhdXXSWsRUUIcpZZ5zX5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGsu36Vj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGsu36Vj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53896C4CEF7;
	Thu,  5 Feb 2026 04:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770267018;
	bh=JeMW1bvYxorZFwlXeRYXI1+MWEAhxcFctKjNyB32qRo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OGsu36VjH9nizwhKs4kyjtItmnQH4Xr7Oyu65FF6RD1lHobWGqxkomSw/Ryl+WxPV
	 Yuf/4stRvEQUguPS6EJRfCKFMYuMw3Mx0n0b7uFwjAQQUreW9WXJwtcU+EelwY5ua3
	 MnCffXNOip87tpQjUT7KPDRQDlcIQNsyiRFHR9RRTcewTe6MaMBT1h0UFD6IbPKcKB
	 SPYw7Ehi1wWX/R9lWPePGeWIw4kE9IKENqvTZcDusDQLWheJWtXLWlKtClO7ryGnlq
	 VvGqNkCrJQV3hi8CCfh0Sq8fCUUV9tvpwxocJDvTUxjnVqfQwq66frNNqmeVkbiZkK
	 nKFx67WJ1o2fA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 851133808200;
	Thu,  5 Feb 2026 04:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: use __skb_push() in __tcp_transmit_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177026701607.165764.16266380346111928375.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 04:50:16 +0000
References: <20260203044226.3489941-1-edumazet@google.com>
In-Reply-To: <20260203044226.3489941-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Feb 2026 04:42:26 +0000 you wrote:
> We trust MAX_TCP_HEADER to be large enough.
> 
> Using the inlined version of skb_push() trades 8 bytes
> of text for better performance of TCP TX fast path.
> 
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/0 grow/shrink: 1/0 up/down: 8/0 (8)
> Function                                     old     new   delta
> __tcp_transmit_skb                          3181    3189      +8
> Total: Before=24896035, After=24896043, chg +0.00%
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: use __skb_push() in __tcp_transmit_skb()
    https://git.kernel.org/netdev/net-next/c/59b5e7f47c7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


