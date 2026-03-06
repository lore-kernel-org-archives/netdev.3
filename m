Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB6E36AB56
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 03:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772767985; cv=none; b=Q6lORCZLjRxP592wHomFkLELdvRAWJjGivKrkKgtCqcU49zIMgN/PFB2ltvdwOgdr+zsL3LKqpYxxvKVVaGQo8hgXN+t7E1I/bAVrYikKKHuFKnm9VGuNkyjnWMf5/2dbtnpbliOrKa6K1IfCArv9RHknh5nDhIHUyaHt0Mt78E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772767985; c=relaxed/simple;
	bh=264xRMgQkWDa/DtGsrfLbt3YCB4JVDH60zGybAEiWWE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mWbtBUnu+QUw7WNliUU+6yeBAlYWnnP6+0j/JN16D0+i5eUdwSKPs/77LKNG+WTW56y2u8lfL/vJ2FEByO5ZfxrRXL7XN4fK1BwzCox8Xp/FH2Zhey5dzyNDYCyD86h3a+sGg9q29S33rbTCB8g2pMOwV/yLzNSw2qaG5Ji+IV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncTefXzp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncTefXzp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F9AC116C6;
	Fri,  6 Mar 2026 03:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772767985;
	bh=264xRMgQkWDa/DtGsrfLbt3YCB4JVDH60zGybAEiWWE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ncTefXzpek6HCIWpe1lSpW29aT515Z3TXbTwlnv4JJYmrlsv3knDua2v1vCMGQC/0
	 +DZOI4K+CCDCXfT2syrxuHoGC2LCM7rH3F47+4xjupl/buGqZRGLlaa+nlPN/rSDbY
	 vMbytu/SyjjCMZBdZ0Gp0WNj1Cr0DdEGGD1RebD7QcOmI6gBSsoaNBOjLmT4Cdz4ul
	 2TuNM62yk5zlK1r1Rwjetfgi4zWbxGhARZJOWKTJr17xisPnqSrn2ilMqGq7wEOmMX
	 vCrFsmV6mBhnCEGf9Zoa2eJGz2XcrDl6VbESFHCdCEQjJDeCP9zC+K0FHXQv8kJmWb
	 I8H7UxmzAC90w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DCE3808200;
	Fri,  6 Mar 2026 03:33:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] tcp: Initialise ehash secrets during
 connect()
 and listen().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177276798454.3348267.8827722413212897387.git-patchwork-notify@kernel.org>
Date: Fri, 06 Mar 2026 03:33:04 +0000
References: <20260303235424.3877267-1-kuniyu@google.com>
In-Reply-To: <20260303235424.3877267-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ncardwell@google.com, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Mar 2026 23:54:16 +0000 you wrote:
> inet_ehashfn() and inet6_ehashfn() initialise random secrets
> on the first call by net_get_random_once().
> 
> While the init part is patched out using static keys, with
> CONFIG_STACKPROTECTOR_STRONG=y, this causes a compiler to
> generate a stack canary due to an automatic variable,
> unsigned long ___flags, in the DO_ONCE() macro being passed
> to __do_once_start().
> 
> [...]

Here is the summary with links:
  - [v2,net-next] tcp: Initialise ehash secrets during connect() and listen().
    https://git.kernel.org/netdev/net-next/c/d4d8c6e6fd2a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


