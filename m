Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25093C8738
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781172009; cv=none; b=EuCtuGJleK5EomPYPFZg4BMZ9kkPVUWbTBPQLwtkOBnsXLDCeVWFBwGotujd3vyE7UgJnLxl7oRL2qG1NGl7T2g5GPaiYKAstjRzK/1go6zFKXx6Y5z3lrVra2pI8uUPd9DQEYcWNMfHWtUOUU9fWEgY7sI4n22vVs8kyHDlgT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781172009; c=relaxed/simple;
	bh=SZwN0gCOutHbdQUmi+f5dQmZc9r2N+wX4KbimvKGTik=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nkl7AhflXdaaSGu4gWRGue/tYw0/lQmbjUfQtJPC7NRPBMI/4OcbrPeqM5Mtey8pR7jv+j9ZzVa6pDiftJ7JRXGmf+Q0wfY30GZAPckBg/p9Wkh0iPHs3IRQta5HqY67Z8VQ4IizZyHjcvNntHtJoR3XlqP5gfJBINul2Br4bN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgV0RiNQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgV0RiNQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BC61F00893;
	Thu, 11 Jun 2026 10:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781172008;
	bh=asH+ui33kBmo4h1i5N5E1JxA4Krlqec1UV6uWDz81cI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PgV0RiNQXwiByfhmeUcCCkIeceZAFRbr/+OYgfoY0JS/GZddvoqsx8wHBi936wdAZ
	 SYc82zRTTwOeonxX9jepMhjt9Dzmfqn7CH7w1NpfqMiaoQcjbl/49Ueo5uGyzUXneF
	 KtcL0QYcJoZQVzUZwr5NuLqpzur5cxeO7GLNewHLIBw/T17mR/zCWmJZ26iQSqLxsb
	 jKdx1Q/3XbSN5+m98bgduGRlorzGvx2XNRBR9MWwMTeY9EbzmcP2IPtjOgOATzEsY8
	 RRSkQ/vY6VVW0J6rb7meDLpUhn6KE6Rhnclaqd9S8jzKUGEgf1EzlRQHUL+V3YuXS7
	 OXf2qjXE6I0Zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EEECA3930E3F;
	Thu, 11 Jun 2026 10:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: Fix a potential NPD in cleanup_prefix_route()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178117200568.3869936.16889649583129791154.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 10:00:05 +0000
References: <20260609145448.768318-1-idosch@nvidia.com>
In-Reply-To: <20260609145448.768318-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org, horms@kernel.org,
 thinker.li@gmail.com, eilaimemedsnaimel@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  9 Jun 2026 17:54:48 +0300 you wrote:
> addrconf_get_prefix_route() can return the fib6_null_entry sentinel
> entry which has a NULL fib6_table pointer. Therefore, before setting the
> route's expiration time, check that we are not working with this entry,
> as otherwise a NPD will be triggered [1].
> 
> Note that the other callers of addrconf_get_prefix_route() are not
> susceptible to this bug:
> 
> [...]

Here is the summary with links:
  - [net] ipv6: Fix a potential NPD in cleanup_prefix_route()
    https://git.kernel.org/netdev/net/c/b70c687b7cf2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


