Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3CA4334D3
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784741445; cv=none; b=Ifyw+AJ33V/iidYXAIv+4VBlue8sP9uuz6bVpVMvfEcIpbMmXawx9nsPsuzXLlUq6AxwBJNOu+MWYj6KlN8ezKVx0jK9eGycpGPs7d1zWvzZJ0XsoRkp0SbPbEAuC7NAqAtFtAZzWQhS3ibRY2R1R0tMb+l5b068Y82prncqVrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784741445; c=relaxed/simple;
	bh=yZ+2Qdcp/hkxIgQfyrxvHBwN7k0olVuWvPm1JjUVYAc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kj1KTLYimcHtohinmruifNNtlQsxgFH42ecDfva8jmZxZDwDQszQ94+bDeC3fRwYolEDONetAO9+dWZAZnYi9CIgs5tGyyAl9rwY+gQEtTSIOqDQgCNy2UGJqfH533xFpTa5X42EkFSpZu/T3Dcz/vy4KqLdBjJ3eI/pqKvIjsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErwMJ2kG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErwMJ2kG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6231F000E9;
	Wed, 22 Jul 2026 17:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784741443;
	bh=qeK7JfEiUDKRXz1SbwBlFA8KAfbXUrggQ1jhkPdArKw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ErwMJ2kGugydt6rix0c9bxPPfdXmygjG2t8eSwg9F3iDQk9PtFv+1Zd4cCfPA3rk5
	 U+xN59fUX2LDUczt6B5aiT1QdmT97eJpZIaHuNGpRMxekY1tYx9VYLo/woKGAt3utg
	 ZEITCoqB4YFgpkFS90EBhUC3QMkcVGhx9Qedjf1FENYRAtK0Hlx7QVA/RNXPX5p/CQ
	 kcCOsZBBvnlpq4lnmHzYnOUTzwg+zVddO9bdzAuAzIdIwrTl2mKOt18twvif7IAHsk
	 HrVvAQsWcWPr3ZiFXhtsZah4+y3bt8IMn8fEKCPKRCrEGSgYL7J+S8zK7lYxLamqBO
	 CczCbsyeqCbag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D127D380CEC5;
	Wed, 22 Jul 2026 17:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] geneve: fix geneve_config leak on
 register_netdevice() failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178474141239.1956205.1725844760567972969.git-patchwork-notify@kernel.org>
Date: Wed, 22 Jul 2026 17:30:12 +0000
References: <20260721163950.1483019-1-edumazet@google.com>
In-Reply-To: <20260721163950.1483019-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Jul 2026 16:39:50 +0000 you wrote:
> When geneve_configure() allocates a new geneve_config structure via
> geneve_config_alloc() and assigns it to geneve->cfg before calling
> register_netdevice(), if register_netdevice() fails early (for example,
> in dev_get_valid_name() due to an invalid or duplicate interface name),
> register_netdevice() exits without calling dev->priv_destructor.
> 
> The caller (e.g. rtnl_newlink()) subsequently calls free_netdev(), which
> frees the net_device structure directly via kvfree() because reg_state is
> NETREG_UNINITIALIZED, bypassing dev->priv_destructor (geneve_free_dev()).
> As a result, the newly allocated geneve_config and its per-CPU dst_cache
> are leaked.
> 
> [...]

Here is the summary with links:
  - [net-next] geneve: fix geneve_config leak on register_netdevice() failure
    https://git.kernel.org/netdev/net-next/c/24d0af194bcc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


