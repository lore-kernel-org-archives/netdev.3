Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538F938F935
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414830; cv=none; b=Ttw4yWn2aE8UmfGgNaayZmSlo/kXmYf1y5HD9oC8kG/JfokLPv1MO9x2cqEmekNu1PB3BvBDumkied6pD/+w0qKWXc4e4ypVQzPPhbapZpXGWfrJFqoIdI35t/ER9jAmYOOzAMLOQVyunk8rhqX4WiLb+olxAy+T4tCfO505k2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414830; c=relaxed/simple;
	bh=WD38vU9qj6RE7Qw4d6wBHckhc78/BF58mYwrqiklAUI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=buSzRRJLKn3r87KuZ+BvFW49LvaIr+0qNOjPT9x+BazmEqCSppnJjzC0nFCdH7wCfO4shFvz4KFkmM9SQuIzQ4o/YxiMDSKDdF6mGlHxk1BqmLPwKZPBu2cgwjIagYoWDLNn/TSt1RW8PGqB+ydw2f7IaRZkPw0x4zgmerb1PPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMOa9ITv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMOa9ITv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DBE1F00AC4;
	Tue,  7 Jul 2026 09:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783414828;
	bh=IQtBSMcTFTA73Mwq5MrR9mMYhZkGbcqBX2BlopJrNFg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DMOa9ITvuLkC3kaKJdYU0GQBeVzFG8hqHIpenlzE6qJYnPX6YZysKK3L4RCcpdaxS
	 QZwTFLcOMQwxroPUDN48f7djrvoUCHbmbUawmI10mLKxvJd4zbaRF1VggYzMZ+0vT8
	 JJL148ZOX2E3EgPuk9nGvRy7FzuV8UXRYhJUBvsnRqA7VC0it0l21MhPtYlqvnDMux
	 5acSHisWxZVahfe4kVdfezCopKftAmLxIf+NwGzWNwAsHRL54tSChZFnZBuhpYXUkI
	 kEeE9AabB2xXUjonQYCfxYtctxyDkdtotDbEcGe//I4k1J9bVn0fCFdMwOOIA5sTn3
	 q8x9mrqStDatw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1996B3925466;
	Tue,  7 Jul 2026 09:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 0/2] net: Misc follow-up on RTNL-less
 fib_rules
 series.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178341480863.1439689.8864452646287174123.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jul 2026 09:00:08 +0000
References: <20260702044437.591864-1-kuniyu@google.com>
In-Reply-To: <20260702044437.591864-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  2 Jul 2026 04:44:13 +0000 you wrote:
> Patch 1 moves net->ipv4.fib_table_hash_lock under
> CONFIG_IP_MULTIPLE_TABLES.
> 
> Patch 2 adds mutex_destroy() for fib_rules_ops.lock.
> 
> 
> Kuniyuki Iwashima (2):
>   ipv4: fib: Define fib_table_hash_lock under CONFIG_IP_MULTIPLE_TABLES.
>   net: fib_rules: Destroy ops->lock in fib_rules_unregister().
> 
> [...]

Here is the summary with links:
  - [v1,net-next,1/2] ipv4: fib: Define fib_table_hash_lock under CONFIG_IP_MULTIPLE_TABLES.
    https://git.kernel.org/netdev/net-next/c/6041421dd087
  - [v1,net-next,2/2] net: fib_rules: Destroy ops->lock in fib_rules_unregister().
    https://git.kernel.org/netdev/net-next/c/99c13f8020df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


