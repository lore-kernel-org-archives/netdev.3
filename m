Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E089D489FCE
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044685; cv=none; b=JrEkMZopq+hPSa1RbJ22eQjSXEFmIITL4DnOI9o8r4jUO67rNa/4rlRbGkR2UwD5dAMiTHYnJRNkM+jt2nzZCE9V04T8o0IadlaNqvXIg4RJE5nThbVqrS8ojaZKcy0KoZyWoaLAyrXQyckv/lTsXocDWEEhvvnwbEQLfDC5sZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044685; c=relaxed/simple;
	bh=Pw5rZVUsMRF6r4mniy9u5NLCZjqefkSOojZeMKfqIr8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q9fYLFdwXv8e+6n0XUbs7WAMp+0C6d27SliKKj7wS0Gds9jsDLGkWA1+T+2jzHflyy7JwWxP34oQSBApdcJvQXSYyqvIrOiqvf1bblg1Jt65H8LOs4ONhxeWLmUmVrgwCnNS9ulzgVBDKQMasbXfhNC+wuQHnYjHUMjIo8Ae9WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJHDvw8x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJHDvw8x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5832D1F00899;
	Thu, 10 Sep 2026 12:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789044683;
	bh=9ITA/Cvc4J08cUyaOPgaE9QFLLU+uuqFklRS2uXAnds=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kJHDvw8xbsNVB7ng6xo4kcmXm3qmVqsaR+9AALkJSWW7baPxH2BcsV7AqhvYkLj6K
	 Lt6knpGUc6GxMwgNCYDx4//PTDKUN5hFwcYjgTYJ++IWET+Sv5hVYU/e7hKqTV9nAH
	 F6RLJ+i4Ix1zaqwB/ikyntgYvm4OfT3MPVI3JLsxkG2+scrUE/tLbOxIV8siefxx79
	 fGhWHjbMUFkzIbyEx5H2DXHUyFfBn05YTvG99L8zOqng49fQUCcMyKegRRJDS7lEkB
	 t7P/xX4+CUGc2FF+Gsj3kPeZdZQonySHf3lh/ocjTtBKyMObgKrY4znIH3cGobqzxX
	 WwRQaUXgOCGhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199B3380CFEE;
	Thu, 10 Sep 2026 12:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/1] tcp: reject non zerocopy devmem tx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178904462058.1411984.7973332298016907409.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 12:50:20 +0000
References: 
 <fdc2478d8f21268d7078556409887d8e6ba0ad32.1788529053.git.asml.silence@gmail.com>
In-Reply-To: 
 <fdc2478d8f21268d7078556409887d8e6ba0ad32.1788529053.git.asml.silence@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 almasrymina@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  4 Sep 2026 14:43:07 +0100 you wrote:
> Devmem tcp tx doesn't work without zero-copy, however it's not currently
> enforced if NETIF_F_SG isn't present. In this case, tcp_sendmsg_locked()
> will try the copy path and try to copy data from an iovec which consists
> of offsets into the dma-buf and would normally fail. Moreover,
> d9c56501c72fd ("net: tcp: block mixing readable and unreadable frags")
> relies on that and assumes that the devmem binding is present IFF we're
> using the zero-copy path, which can be used to mix net-iov and pages in
> a single skb, and break invariants. Let's reject devmem tx without
> zero-copy.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] tcp: reject non zerocopy devmem tx
    https://git.kernel.org/netdev/net/c/125755776bc6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


