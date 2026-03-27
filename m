Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A8936C9D9;
	Fri, 27 Mar 2026 03:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774581621; cv=none; b=hWQdswL2/sjMqvh1oasLvv00osyhzhlZvLGw4NND7rWafowVGPfj3qYFaa1INIDslg5h85fX98nYVj+FPORlRADs2/E8GLxRKykfYy8x1btHbmyRVBtFZelZJ/blLtfYbgB0icGDzcvjwEaEFI/8XNKM/PysJlf24IBqJbvdFlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774581621; c=relaxed/simple;
	bh=DhbcKHjh5x2YBkGqLZ2b6lJ88BJYAnATP1LfKr6nbf0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rAh3ExZHEtX7MccQSMgQ5XL1SseM4UY3haRWtuP7HLEpf9O5AAhsQUExopfSEGqWAhR3xpwemQSjTNfiHmJC5+8HN2/ngnWrM1+7JfL5lna/IEvrBq1dgMf3l/3guvnbRKXbS2feBO6OssDVL86w7ZNnWLOSzS0o8UwC98xxTo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ot8s8f3X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ot8s8f3X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFD6C116C6;
	Fri, 27 Mar 2026 03:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774581621;
	bh=DhbcKHjh5x2YBkGqLZ2b6lJ88BJYAnATP1LfKr6nbf0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ot8s8f3X1nadVwsLnSL494VTQH9h1OnIWHCQQb89zbJSBeGa2OhbvOXr9qZT80SYU
	 KIX6E5kOErx72eiKIsFIttM9vvDR6HEhp4G5NJkMuqM/PC6Cw/gupJX/ddJGHzWDRG
	 nscoRi/mUSHuR1TST0zWHDzAnYNkFejC53EbsdosvLuyOCgerLQEytb1yeDoOSKDgD
	 7q8iKIbiEDlnreDm4ZZkae3VUiKCQ2cG89Fr+HwoMagvjwjlSPaZhj9gnbWRwpdvUn
	 cwX5EobON5a4Ua+vEjCzJm4br4MpsPojQzidIXt1JglZrT/PyzTsZmlipbgRdtdn0h
	 32YXvO9NbXT7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FF13809A0B;
	Fri, 27 Mar 2026 03:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netdevsim: fix build if SKB_EXTENSIONS=n
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177458160728.3283168.17126892713307578593.git-patchwork-notify@kernel.org>
Date: Fri, 27 Mar 2026 03:20:07 +0000
References: <20260324140857.783-1-dqfext@gmail.com>
In-Reply-To: <20260324140857.783-1-dqfext@gmail.com>
To: Qingfang Deng <dqfext@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, atwellwea@gmail.com,
 daniel.zahka@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Mar 2026 22:08:56 +0800 you wrote:
> __skb_ext_put() is not declared if SKB_EXTENSIONS is not enabled, which
> causes a build error:
> 
> drivers/net/netdevsim/netdev.c: In function 'nsim_forward_skb':
> drivers/net/netdevsim/netdev.c:114:25: error: implicit declaration of function '__skb_ext_put'; did you mean 'skb_ext_put'? [-Werror=implicit-function-declaration]
>   114 |                         __skb_ext_put(psp_ext);
>       |                         ^~~~~~~~~~~~~
>       |                         skb_ext_put
> cc1: some warnings being treated as errors
> 
> [...]

Here is the summary with links:
  - [net] netdevsim: fix build if SKB_EXTENSIONS=n
    https://git.kernel.org/netdev/net/c/57a04a13aac1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


