Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC2B3043D2
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 01:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772242807; cv=none; b=RStjnhdKxs0J22+ge8Lj/k+fbnY7ussHXRN6T96DcVRRCRjK7mUIg35THhNwGepEPEvaNY71t09r6O+k+tQzk6KC8WXqZfgtddVxrGan0AsfIrMalu5jEQIOvhL+7VfzY8tGXsHDBF5f/6tB6qb6mgAPgLUQuYU6Kw2ZW44sZSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772242807; c=relaxed/simple;
	bh=pexQoI7Tkmnq6LPpw94cPrFy/IOpKjmGMxKaDuwJSfA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lpyAB5Qsxh6PmYd8XlZST1tatbGkQVSTg4YwlS6AKBRBU3aRiK4amxyQ/yWuNvECtTZ1QaQagSTSqMZDzevvYKRuWMWBW/QWAEmeaxxQZY+Bnb7wrf0Ue9vcldp8RW3rORB+s6Sw1aFT/6DMTt8u1rHFW60UgIvBTUtItOBA9RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xv/ka/7A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xv/ka/7A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4176BC116C6;
	Sat, 28 Feb 2026 01:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772242807;
	bh=pexQoI7Tkmnq6LPpw94cPrFy/IOpKjmGMxKaDuwJSfA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xv/ka/7AuaeyS7/79IYqFYlvZaJUucCEvAgk7irRPG6IK5Bme84qIr+YOfpcZfPVI
	 ff57FNebEXv2ZTApFBM+iONld9p2nD9Bwrf2zDMPB0uWO2/rGKHjVF6W/fHRYp7OHX
	 68l17bjIRUGhgtW6RfYF038ILf3a7k6lE3mO3q8IC691FhUK6g37+vPOjWTtGItTfX
	 lFlRbY2IYwtIG06FYLOSOQexoZMAogOLj/szm7SfnGMfiL07q4d+zXG0fiuUYEtPF0
	 LuuShP5yhhcUnjGZFMJQREQdlLBId9pVxOju5DxKHfsPFJbbhKCfioTi2fnwnYB5Ue
	 GiBrStXHhcNYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C0939EF96A;
	Sat, 28 Feb 2026 01:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: use try_cmpxchg() in lock_sock_nested()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177224281078.2834458.629658727119303611.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 01:40:10 +0000
References: <20260226021215.1764237-1-edumazet@google.com>
In-Reply-To: <20260226021215.1764237-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Feb 2026 02:12:15 +0000 you wrote:
> Add a fast path in lock_sock_nested(), to avoid acquiring
> the socket spinlock only to set @owned to one:
> 
>         spin_lock_bh(&sk->sk_lock.slock);
>         if (unlikely(sock_owned_by_user_nocheck(sk)))
>                 __lock_sock(sk);
>         sk->sk_lock.owned = 1;
>         spin_unlock_bh(&sk->sk_lock.slock);
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: use try_cmpxchg() in lock_sock_nested()
    https://git.kernel.org/netdev/net-next/c/5151ec54f586

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


