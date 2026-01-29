Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A88364E8D
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 03:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769658631; cv=none; b=KYI4EO3iNZeynhrrCKknvRrbNl+EOn9Ba2JYNO6Mye+7YJVZ75gxYDZl4Q3ooIq5jVbAxSNBajy0Uj0imBwLfGSIxD7hXrYFkcKctteBOiETyNfj1ANZZGrWLPmra8bUCfweDJP0YQGrYpC6s+NKscEhBqhzc0J31qWVsnASQZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769658631; c=relaxed/simple;
	bh=S7nnudoR03GXaWFE/RhCjN/u20WXJ1Mj68j70X9isVc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FldZC0pw3DmgxxR/B7ygNZlQXwpSf1fejqHQhyammEhD6RdpD2iKC1gXonkfe4knkmTVF0PUSKsuXMS8r7G1F55Jn1SHvXo4cZG34ndlwj4Ah4opV3w2zGMg+Dp0XfOnh6a1vqYLAo2uuaBFNxygw81NdrxXFQ8vuPWYDAHcggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jg++Joee; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jg++Joee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A40BC19421;
	Thu, 29 Jan 2026 03:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769658631;
	bh=S7nnudoR03GXaWFE/RhCjN/u20WXJ1Mj68j70X9isVc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jg++JoeePwqrwXaKXRf3N/ekZq27xkCw6bN+R7iNzkbYW7Z/AZCZrnYd/8j3CHWkN
	 pGdB1qpF0URQawsg5Z3hdZts8ObfqcfQxkgV+zw8fFGJ2d23MCEMyBlv+cS7L1NUfP
	 MyPWiThJwjSC8cFzbA3UINMJ8tuOvDZ1yGiBWvNwoWL39NbpFt/rpzy9a25KI8Hb3U
	 W9W3cqOK6xjEcSDxQqUWW76a8Yvxw53Knu3Wf1z2nYXI6N+kmwsvMGwVhu/3CC/rkr
	 lljKqF+BHoh5irM+UZXZviLpQrnxnLas3TAj2UkKhqFYSG1QZB9LmOZVCObd8GvHd1
	 xdzxwPfxrUvQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BB35380AA61;
	Thu, 29 Jan 2026 03:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] ipv4: Use EXPORT_IPV6_MOD_GPL() for
 ip_fib_metrics_init().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176965862410.2339773.13101134116882357269.git-patchwork-notify@kernel.org>
Date: Thu, 29 Jan 2026 03:50:24 +0000
References: <20260127081335.646666-1-kuniyu@google.com>
In-Reply-To: <20260127081335.646666-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Jan 2026 08:13:20 +0000 you wrote:
> ip_fib_metrics_init() is only called from fib_create_info()
> and ip6_route_info_create().
> 
> Let's use EXPORT_IPV6_MOD_GPL() instead.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> 
> [...]

Here is the summary with links:
  - [v1,net-next] ipv4: Use EXPORT_IPV6_MOD_GPL() for ip_fib_metrics_init().
    https://git.kernel.org/netdev/net-next/c/5b71de34b7ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


