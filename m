Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294982BE04F;
	Tue, 10 Mar 2026 02:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773108013; cv=none; b=KC6hJGIRJc3468si9qmI01O4Z8kiW5CZVDE6LsRx4OhcjNhDzSiO5mc8HZUhQP4wMm4+twNQkFZvyLhxdcxzBbIl76UTw47PQgdeucyOi0z6l90D/pBKsngqYkOY8s35yhYrFC9ZIRYsUjUD70DEGC1yE1itG58H7oXgHTZ09lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773108013; c=relaxed/simple;
	bh=Se+7+AEu3Jr+o8EeFBcFMgLKW/Ke1Mo28UFO0nvdEpk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L4VqI07RVKocoPZgOsd0z3cqrwW96TPqeR2lkwbEX0tiNMAySkG2IQ+s0j2uwNJGOC0NucrM5SJfHaCsJDf3KtWt6FKA/G2gmoQH8NPbWKBed5digNyzLeMxXkIWR6PKkgsIdFqNsgmVy8+fHifPYvyqj1IsO/v/yTG79PMkqAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGS9hl2r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGS9hl2r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27A5C2BCAF;
	Tue, 10 Mar 2026 02:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773108012;
	bh=Se+7+AEu3Jr+o8EeFBcFMgLKW/Ke1Mo28UFO0nvdEpk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aGS9hl2ryEhaaeMTjmM4NUeg9pxDsXU64EGeJiE6PnOjOgkP6LuRMdo9jg8ot24g+
	 T6cYUdk3Dvh8JySqgN+GWaJYpazxJIwM2NDAGW7aaWKXg5VN+Evf4XXOc4nI4qO1XW
	 DsR2h/erEUfkrCEcUkzXgqc2YaBU29EIbhR2eQgSER1K6mMM9bKB/JIadf14RdlWIu
	 pql8yxJ2NEBkkqX/qKAxXvL5izt9xhzEiJEi0+0lkYAxS0EdDd41nD/aYBhb97q3WA
	 aMXPubNMLvz4HuODI0gwUjBJ76/rVUlM3mIlFfcmTXEXgG7SuDUVgjlDtWeiL7QkkQ
	 PLpfZR8yvEPRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D923808200;
	Tue, 10 Mar 2026 02:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: nexthop: fix percpu use-after-free in
 remove_nh_grp_entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177310800954.2022132.3786789819097611279.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 02:00:09 +0000
References: <20260306233821.196789-1-mehulrao@gmail.com>
In-Reply-To: <20260306233821.196789-1-mehulrao@gmail.com>
To: Mehul Rao <mehulrao@gmail.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, petrm@nvidia.com,
 idosch@nvidia.com, netdev@vger.kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Mar 2026 18:38:20 -0500 you wrote:
> When removing a nexthop from a group, remove_nh_grp_entry() publishes
> the new group via rcu_assign_pointer() then immediately frees the
> removed entry's percpu stats with free_percpu(). However, the
> synchronize_net() grace period in the caller remove_nexthop_from_groups()
> runs after the free. RCU readers that entered before the publish still
> see the old group and can dereference the freed stats via
> nh_grp_entry_stats_inc() -> get_cpu_ptr(nhge->stats), causing a
> use-after-free on percpu memory.
> 
> [...]

Here is the summary with links:
  - [net] net: nexthop: fix percpu use-after-free in remove_nh_grp_entry
    https://git.kernel.org/netdev/net/c/b2662e7593e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


