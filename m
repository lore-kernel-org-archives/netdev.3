Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA57C1A23A4
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780537213; cv=none; b=dsnhBFS3uhQNXEO2QRi0kbmI7Nba8fNGz/sRlvjysCVyuATZv9p5w0S/eVCnpTWxv/19NenB7BuyFW9bEo1fE8K+6GAqwSk1kxoyNN++qbhuMA3vRIsgkGLzGRJ1V6yns2YK9iJ6MXs/vKJ7d9HFfn+DFfZ5Rk1YBwpeDaQSiDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780537213; c=relaxed/simple;
	bh=CXnT+emaxZykkncFqpDp7V0Jx/ABeR+zjKQ4wFEwX/c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ldoSL/Hi8MYwFSdEUNba2aMBpR3Kza+ODGfhnWWwLmRCkwS9mw5lzvcRF5XXECbqa5MTNu0sqgIp83V8qDYkzWU1kX40dFO/Pgzd661zAGyBTaQFbDcc7cUpftURys+WFy86aixTL/xs45i1JCYPfYnsgG0XHbPjkFu9PaycH5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxBM6eMm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxBM6eMm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF6C1F00893;
	Thu,  4 Jun 2026 01:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780537212;
	bh=Tzehui0Iy9WQnvAALgxvoFeWt5iHCYmsyClyx8VCsDs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kxBM6eMmnv7rVnUoUp+aUv+52dEeUB5NDGCXLg4Tm6muIBcyuIyJupHG7TT619kwN
	 h4YsvshoFF1/OtTq2T6+nneZNSORERfi7jiuvQ/AGXsFtSkqySg9bAu2JcXapp2M3N
	 A3ZlT12y8DreXDSVu0aUpZ2YKwJLcTQWttpuOnWG5qcjsD3LMPi022ns1UcX+LmEoO
	 9t+szoJ0OORkmTN+ua71rPQlpzmw53/T9SDzWl7115CjEPL90PO+M6gBUxEeRnx6BD
	 rAlfXb+BTpzf++xm0qlq6yC74Ouy7TgTpi9lOsXE20gSFwKPoQrVcGAJfFo4sbmhQi
	 m5UuU+BP+Mi8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A9039308E0;
	Thu,  4 Jun 2026 01:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 net-next 0/5] geneve: Allow binding UDP socket to a
 specific address.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178053721339.2195898.4684053835699241610.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 01:40:13 +0000
References: <20260602190436.139591-1-kuniyu@google.com>
In-Reply-To: <20260602190436.139591-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 stephen@networkplumber.org, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Jun 2026 19:03:40 +0000 you wrote:
> By default, a GENEVE device bind()s its underlying UDP socket(s) to
> the IPv4 or IPv6 wildcard address because there is no way to specify
> a specific local IP address to bind() to.
> 
> This prevents deploying multiple GENEVE devices on a multi-homed host
> where each device should be isolated and bound to a different local IP
> address on the same UDP port.
> 
> [...]

Here is the summary with links:
  - [v5,net-next,1/5] geneve: Reuse ipv6_addr_type() result in geneve_nl2info().
    https://git.kernel.org/netdev/net-next/c/1221c53985e8
  - [v5,net-next,2/5] geneve: Pass struct geneve_dev to geneve_create_sock().
    https://git.kernel.org/netdev/net-next/c/c7f83b9de269
  - [v5,net-next,3/5] geneve: Pass struct geneve_dev to geneve_find_sock().
    https://git.kernel.org/netdev/net-next/c/0429413cc781
  - [v5,net-next,4/5] geneve: Add dualstack flag to struct geneve_config.
    https://git.kernel.org/netdev/net-next/c/2e5feb257ec5
  - [v5,net-next,5/5] geneve: Introduce IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6.
    https://git.kernel.org/netdev/net-next/c/afabbb56a726

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


