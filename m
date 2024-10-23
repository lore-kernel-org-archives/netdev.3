Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21CF1AAE25
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729683029; cv=none; b=cPCaJt8j5tX7G8GD1E+dehzn3aDwAjRxsKeKRuUaQsK4WT4dBqiFCPu9hB+nUybRxEpwU79Z9ca7swg1G5qxpWTT0M0VY9VRcEdDD8c1HBqP5TOkPu6gEFlfKnWeukYqE6BiGLjI1u8nVlzbZrDkLOEB6FxZsgAbyiALs4/IYkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729683029; c=relaxed/simple;
	bh=hSoel8DEEE6dl9GDVv77BG49yyOq6w92bnMH5wFKjh8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xc8tCh8dPrwkF7IikVfNf3VvNuqtHa1Xqm86Si0hxYr8/9Hbqrq4R75OvTsyGke3+L5zJL1Y3ZnOZuyhXRHZGmpfQpXuY2EjS65qwO+LNIXGiR1eHT24J6+h6XN2hsIXjnrPuNVn+NmjTCC1Jy1MWsmGc2w3JYjy1GRtCsoOkcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnn05L9d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnn05L9d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B381C4CEC6;
	Wed, 23 Oct 2024 11:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729683029;
	bh=hSoel8DEEE6dl9GDVv77BG49yyOq6w92bnMH5wFKjh8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dnn05L9d7uVwg5sFgBSlzFEH/mwza8m7/ERTBYFAXFAswRXuH+WoZu6qsLP+miADG
	 GMFEi+eB3d1Hq7Asi3k4J4L/VkDMCR28YEOE/Qw8uT//JLnnFfvHOhDLP6lBgl2kkA
	 6u7klfuVL4aGrIn5DEYS1KmXOPPF4MqA/b82Jq40+7e7zWTYH7E6uyp7biG+R3BHSo
	 K+0ONgDj+L34rekHIB90MsNfSe8agNrTWaSm7VTpCxrGhnpDDA/RbT1ixpf367IzBy
	 59HUBC0/z7+Rd9wD+e4LH0UugSrZVV3SmwJkgjihq3Y7FfME2oNTU5Zcsp35ciLUcS
	 ae6YzIMSjuLBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD8A3809A8A;
	Wed, 23 Oct 2024 11:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] ipv4: Switch inet_addr_hash() to less predictable
 hash.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172968303574.1569665.13653791438579407891.git-patchwork-notify@kernel.org>
Date: Wed, 23 Oct 2024 11:30:35 +0000
References: <20241018014100.93776-1-kuniyu@amazon.com>
In-Reply-To: <20241018014100.93776-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 17 Oct 2024 18:41:00 -0700 you wrote:
> Recently, commit 4a0ec2aa0704 ("ipv6: switch inet6_addr_hash()
> to less predictable hash") and commit 4daf4dc275f1 ("ipv6: switch
> inet6_acaddr_hash() to less predictable hash") hardened IPv6
> address hash functions.
> 
> inet_addr_hash() is also highly predictable, and a malicious use
> could abuse a specific bucket.
> 
> [...]

Here is the summary with links:
  - [v1,net-next] ipv4: Switch inet_addr_hash() to less predictable hash.
    https://git.kernel.org/netdev/net-next/c/c972c1c41d9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


