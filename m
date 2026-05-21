Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCE4364EA5;
	Thu, 21 May 2026 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377404; cv=none; b=LjruhIwBoYV+O+xpaZ7gYafbEqMKeDs83VtfU4tyKXeQ5BDIxFzJ+TI5IqwuYjEZfSENVaNCV8jybZd6eWlQq4e/RM0Pl9NYWDNsfbjuzjakCjywsc6XM83TWa1quVr1lWZx6LqjUf+a7r63Lv1TTgQB8hxlF8rkYmV+MlUwcEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377404; c=relaxed/simple;
	bh=r1mnfmvkRX9SMmDZdus6YhNreX8SnW+zV+H1XXECurA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gQUCK5gt3AMH97cUqf0R7pVztwjJNGOAWdX9oyHVhwZshCTy+QydH4rcYiuGjR2n7gPP3fe2ti2wjauZRbFsCaqg9wyj5Y32Jlm9vCmKo+68iiYyQgKwaS9UFq0iVpZOQfYarj9A35Y1Wt2yqrf4Zov5M4JOPpz3YRAXdJI4kHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSU+kHHO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSU+kHHO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8162C1F000E9;
	Thu, 21 May 2026 15:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779377403;
	bh=1jU9/CSxOb6fJcznlAn59JOWJxBhSZuTZEet7wdwa/M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TSU+kHHOPQ5d+d6VKLIPOUOrx2srsJVzzS8sy7GIOUbzzTyt6HwZ9gRL8ePr1iGGx
	 RgDEDX8pW8Gk7aMszx5Vy6rKhmkXT84ZiSjB7W6SJpkNOls8Y5ilIY2I40RTW7IeGY
	 qShF+5oW5gJuiRFWdApcAv/w5NzWhEwBFF3HS6nFxw/QyVZ+oYp3YoeGdxB0S8Vbnb
	 tdbkdJ+tw8RZgC++J/KRoykynF6npIEeW8QCESYUHDXh4BF1bepyVJDA3m/7By9zCx
	 65xuHij/F5uBo3ead54zxnuvBKO7s3GsMNqEUFemRU7IocjGksR1uV/X/J6ZEHbEsU
	 6bJzrBUFT1Prg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939063930E02;
	Thu, 21 May 2026 15:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: ioam: refresh hdr pointer before ioam6_event()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177937741316.384060.7911615095323709207.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 15:30:13 +0000
References: <20260520124242.32320-1-justin.iurman@gmail.com>
In-Reply-To: <20260520124242.32320-1-justin.iurman@gmail.com>
To: Justin Iurman <justin.iurman@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 May 2026 14:42:42 +0200 you wrote:
> Reported by Sashiko:
> 
> In ipv6_hop_ioam(), the hdr pointer is initialized to point into the
> skb's linear data buffer. Later, the code calls skb_ensure_writable(),
> which might reallocate the buffer:
> 
> 	if (skb_ensure_writable(skb, optoff + 2 + hdr->opt_len))
> 		goto drop;
> 
> [...]

Here is the summary with links:
  - [net] ipv6: ioam: refresh hdr pointer before ioam6_event()
    https://git.kernel.org/netdev/net/c/e46e6bc97fb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


