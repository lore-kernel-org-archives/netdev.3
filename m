Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1049847127C
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806839; cv=none; b=SFLGZILsaTm0Z4NdSOpQaxzGB0EMeVoXGkVGCaJQ8czV5RK8n4OV8ba+hatX83PFzA/XFgiNjLKTs/RV8YoTDPwJh1oXn3RFEC249LI8hsivYV+cnzKx85aF8O6kPDHFCWeyk6nNu+zGhbM1WOc0b+VmPpGFhNrbtITz7QnOpkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806839; c=relaxed/simple;
	bh=VX9TavvWI0dgyauHgoZZJyZcqgqDFDTfAq3xJ6EdVHA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k8KtrfZ5bwJ+fJOZ75AEvbzRES8k4dRFni7k7OsfziSMc8Rj7Q4aA0FKQJhgk4DSVeyqvIxnp8nuv5tTQ2NWoJMH6T6bLjUq8CrhDZMS8K9e3uwYXkqCMc1VejQVqBnq4CmziyXjzpFZNMObeEYB16l7TGy/bvO+OQtWa43QolM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsJ6CMJf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsJ6CMJf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01BA1F000E9;
	Thu, 23 Jul 2026 11:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784806837;
	bh=qH/0wJisIu49EFVKxxmjojQMW0Hgz5lgIbgMs2x/Bbk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NsJ6CMJffZ1EDsr4fhSVc6XlrsBQc6aIGiX3HUqKCkcAA8Mspjd/U30P3YvY9+3O6
	 +E59Ji73E1SqeGBnMinJtKsi6A9v2EHK+7fm7c9RhreBw8ABv77uJBdSQiT9Ml4zQy
	 Gn4HawN0xoasHqivKcyEetjFEU7xbvnh+N82wJvvLCVD7D9QsC0Q2UBd7YxAwWGF70
	 UeqikX04NxcdCbshKqrD932xpaG0S1PRYET3n3Ayt9faKp9JVueN74v64l91yHUS7c
	 hf3kFVcnK5OAsMCrmozjJDmTDPSbGg01cTiFINPYemBorOSxqheFx7cyGMLVFAEXp8
	 0TxRVs31yTBqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568B6380DBFA;
	Thu, 23 Jul 2026 11:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] mpls: Set rt->rt_nhn just before returning from
 mpls_nh_build_multi().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178480680590.2232236.6951588478851077198.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 11:40:05 +0000
References: <20260716170609.804629-1-kuniyu@google.com>
In-Reply-To: <20260716170609.804629-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, gnault@redhat.com, kuni1840@gmail.com,
 netdev@vger.kernel.org, anthony.doeraene@uclouvain.be

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 16 Jul 2026 17:06:07 +0000 you wrote:
> Commit f0914b8436c5 ("mpls: Hold dev refcnt for mpls_nh.") added
> change_nexthops() loop to call netdev_put() for the nexthop devices
> before freeing mpls_route.
> 
> Then, mpls_nh_build_multi() was also changed to avoid iterating
> uninitialised nexthops in mpls_rt_free_rcu().
> 
> [...]

Here is the summary with links:
  - [v1,net] mpls: Set rt->rt_nhn just before returning from mpls_nh_build_multi().
    https://git.kernel.org/netdev/net/c/3671f0419d90

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


