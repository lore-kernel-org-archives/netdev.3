Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F5731B131;
	Thu, 13 Aug 2026 01:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786585259; cv=none; b=J1oH7IxWydWwuf/0CgH73KNzA+hLsIP1EesQ4NgkTvBSYMT8AiHsetLGPClXkeCv6j8yzSIu5fS5u5B5aVFo81ccjguyvlW0vGESVKeA2b+2RBcKvG4BfUcPE2Fl3z+rXjv0ziFZzQxDNPCCbOe/pi2JmuI6+3IYbkx9g2rx3Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786585259; c=relaxed/simple;
	bh=8XCKCFHhu0QsQ736HRT4V70YFd20piKHINNvkond9vg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cHbVpCnrKCd4QotTkgev0ljUwZF8lgiN9r2w3mdOfXieLQFyE34mgzYpvY4aUkh7+DBPEGy6Uv1JaRIUWxL2ZyfFLwA2uqg0QEwXMmwW1xx5E1gp2NO7nAxy6PR6YyuLpdREf3TyRZ/1c8voBBt5DI+NQu/nL+5o+CXkWVNp850=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zz8pYVaU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zz8pYVaU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393311F000E9;
	Thu, 13 Aug 2026 01:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786585258;
	bh=c55dWbt3HYDi9ywXJ79loyBhHCdKSXsFfGsHtj4HJ38=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Zz8pYVaUzz4lNt96Ca8nMYo6D0tN1d61cDRwIiJKRKz3XLPX+ds/dFHVV2kc2E005
	 N8PLLgQtvI5GvfTp6chyM3uazfxmqOq7HE5PuFL68mWvVAL5ocu4/u/0zKh8aTc3JO
	 BRmVhbOrbVsrTlzE488UA53gXjTN6osasA8IHCD29F8InDc40ZkrqFfaveS2WnEMR0
	 hlNLzEARDT0nUB/U4lA4Qpndftm0ZpspksHwyNae8QssrQpivCHLsF13tQsu1YrMbj
	 TYY12g4g7pcmhSYsfa1JishU3NWEI7uPzyGMqmtnaAQCnMMpTe1b13n+TOXInkQieX
	 UB+uxDcKX9GoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A0A380CED0;
	Thu, 13 Aug 2026 01:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tcp: clarify comment for mdev_us in struct tcp_sock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178658521313.2182080.17382827673130126816.git-patchwork-notify@kernel.org>
Date: Thu, 13 Aug 2026 01:40:13 +0000
References: <20260805131927.27661-1-zhangcoder@yeah.net>
In-Reply-To: <20260805131927.27661-1-zhangcoder@yeah.net>
To: Ziran Zhang <zhangcoder@yeah.net>
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Aug 2026 21:19:27 +0800 you wrote:
> The existing comment for mdev_us says "medium deviation", but this
> term is inaccurate. The field stores the "mean deviation" of RTT,
> as originally defined in Van Jacobson's paper "Congestion
> Avoidance and Control", and it is scaled by 4 (<< 2) in the Linux
> implementation.
> 
> Update the comment to reflect the correct terminology and storage
> format.
> 
> [...]

Here is the summary with links:
  - tcp: clarify comment for mdev_us in struct tcp_sock
    https://git.kernel.org/netdev/net-next/c/9b20885f1472

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


