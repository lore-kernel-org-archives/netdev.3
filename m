Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A290E25228C;
	Fri, 10 Jul 2026 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692633; cv=none; b=Dqlu7Ne+h7+25oEe4We2mqfBVWuYaB06dQcRr///oa0dPHZGlo97fJVsYrvae7PlOvltYDEdgh5UUz5lbPwQni+CYXewhbyAF2ZNOKBmjlCtwx8U5qJJmWeWSGAcgXRpu1Gbv7SPUTD4dyJScNaXDdJP8f1CMM7ZuuQb/UvrbK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692633; c=relaxed/simple;
	bh=TB6LVnogQ5WCudz4xcq7b0N9xJRjekuPV1SKqWMUQPM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q5Bg/1FkoEKlA7IqAHldbQL9yIw1MXpFnH+D4Tv4jGMJwOnrx+04qQimfScAa3AB5ceYDArgUyfvyBJaWfxUM8/gR/aBV2t86yCVVYQ92Mgi9PZ7KX8eenItPCdc+/7iqleJGUn8aAMRsp9eEzeOt5v1L4MHATKF4giJjhCggas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFlJYMek; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFlJYMek"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859A41F00A3A;
	Fri, 10 Jul 2026 14:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783692632;
	bh=N0Sm3pthzpHlYcy64+pRdWJ903nZpnSTlIILQ9Vexd8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZFlJYMek6zuREhxcrBwJ4vpWEi7+aoAOK4OVpTCJA3x6qOr/IXHX6htkpRXTBWLuO
	 fYMXrqkLtR/SxjiirEJLC2U7oBrPdua1XgcbGxpXxOMZ0YIScSGWRKD78BNkGPaYer
	 Cing/yh3ZuYbrPIxJl9MQ95hfUQojDDKNj9pAjdaFwPAQZU1urhQAX3GaSXRjfPTeI
	 +jooqNCNIl64mV751oc7IZlqQhGhvoE57bDx8HpvvoeoO4sHCwQr8rw8skPpaCS6sN
	 ixD9826c0iRhuO8NI6ltKYzu2Jb+Ueigi/yygktNZOwBhxr3ZAxaYVPZ6D3Jnu5AEU
	 CxrYTtvWfvs1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B7A3924F95;
	Fri, 10 Jul 2026 14:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv4: fib: free fib_alias with kfree_rcu() on insert
 error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178369261015.702516.15852641414111977103.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jul 2026 14:10:10 +0000
References: <20260704171421.1786806-1-bestswngs@gmail.com>
In-Reply-To: <20260704171421.1786806-1-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 horms@kernel.org, xmei5@asu.edu, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  4 Jul 2026 10:14:21 -0700 you wrote:
> fib_table_insert() publishes new_fa into the leaf's fa_list with
> fib_insert_alias() before calling the fib entry notifiers. When a
> notifier fails, the error path removes new_fa with fib_remove_alias()
> (hlist_del_rcu) and frees it right away with kmem_cache_free().
> 
> fib_table_lookup() walks that list under rcu_read_lock() only, so a
> concurrent lookup that already reached new_fa keeps reading it after the
> free:
> 
> [...]

Here is the summary with links:
  - [net] ipv4: fib: free fib_alias with kfree_rcu() on insert error path
    https://git.kernel.org/netdev/net/c/f2f152e94a67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


