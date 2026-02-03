Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357C3214A97
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 01:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770081613; cv=none; b=a2phZsNBsfjkvAnIFMDKe5rfURU47202hej5Z+XeLKO3cOZ8xvaOKBdeyGB7sobGTA7lMVmWcSq17j/j0nCAUl4XZ6mJEVaxkt1huETPPOTBtrgfmF04DqbWQw2p/Daik9IAebiS7/5DClKKXONboDkkr8huRIcRrCe0ASotI3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770081613; c=relaxed/simple;
	bh=fB/JU1ZWoJM4GHuDeik5eH9kxIX/HvQDUthIcqLEziA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qq01wwu141LwWQsU7aG9yFqSVhsq6aaWcf83D5l4T9vgGzxRk4zqMVYdT96ffu6rPlWvb2YW5skhQgVCxLYTVpzw/T7/cVJj7u6sRD81k2WBgyX7mQhbdQfWNrdQs91lgmOKaGmzl2XJYQh7vOysdv7Uw2HvbxKHTQn1+JjPWl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrdqPw4p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrdqPw4p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AD5C116C6;
	Tue,  3 Feb 2026 01:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770081613;
	bh=fB/JU1ZWoJM4GHuDeik5eH9kxIX/HvQDUthIcqLEziA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DrdqPw4pBPknPvKz6AJbpJ787kcXnS2Ay+kMVUmgXBmYAddZv01OpLhDEGpQvlrSZ
	 D4tO+s5lHplVksKi5ZhH1539f2Co+HXDLMBHHCm/v7YnlIuJUfs5jRix/ZoqejAyJv
	 tcjrQGTqdEiZxS4tYLiPEwtlUXVAFIsbmbNt8rUXEoSDEtwciCKVUzSokckjUsMzhh
	 uHLvCZSnuGwSrQEySXlRJjYlue7wP97/tPGLpDAC9fxICrsB0tToavIPg7ak2sO8Xf
	 KVQHJOOteguzyhkeHGM725X1SHeKwVzkZDyQWr5wvQDVYq8+fbLJ+VbLqofPe8TE+b
	 R+CDzdL0CXaaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 16C243808200;
	Tue,  3 Feb 2026 01:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: l3mdev: use skb_dst_dev_rcu() in
 l3mdev_l3_out()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177008160953.1261691.9109500679746313414.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 01:20:09 +0000
References: <20260130191906.3781856-1-edumazet@google.com>
In-Reply-To: <20260130191906.3781856-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 30 Jan 2026 19:19:06 +0000 you wrote:
> Extend the RCU section a bit so that we can use the safer
> skb_dst_dev_rcu() helper.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/l3mdev.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net-next] net: l3mdev: use skb_dst_dev_rcu() in l3mdev_l3_out()
    https://git.kernel.org/netdev/net-next/c/82f35bec11bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


