Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A523019DC;
	Thu, 23 Jul 2026 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820068; cv=none; b=iKUetqKltvkm7bqHIcT0Ss/rMJlWTF5jQRWl5G6WPAMxbM7NpT1HbS3JjAE4tLPKThaC+/pCh7YSzkArjKR5j6iDZaXVmRgakMtz8aYMJDYMb9IrQmUY0dQL1W46exFJTZrivk0tNe6bUT+Ouw682QflsniagYZWeye9GEQgj/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820068; c=relaxed/simple;
	bh=i8Vn27uDCZBSnRgcGY6iMPo95YyfHjxstLMOO/YDvXc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AZO2ciUWKGKJL7y9Myh2y5gp+TLUVUxJoPxD+r0LxfhA0gukjYeicha//raE0JBuZx7hFABcW70JZeQz1SwlgHDAUHJRBNU3P1jZQU+589d6PyLXUKf50InC54PmlrwWhrltS28EWU1qI7oa7oTusjrdKfK/OfM910BcL8e8sew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113841F00A3A;
	Thu, 23 Jul 2026 15:21:02 +0000 (UTC)
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939FA3924454;
	Thu, 23 Jul 2026 15:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] raw: annotate lockless match fields in
 raw_v4_match()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178482001813.2315735.14825927789469935052.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 15:20:18 +0000
References: <20260716142958.3064224-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260716142958.3064224-1-runyu.xiao@seu.edu.cn>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: netdev@vger.kernel.org, kuniyu@google.com, edumazet@google.com,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Jul 2026 22:29:58 +0800 you wrote:
> raw_v4_match() is a lockless match helper under sk_for_each_rcu(). It
> still reads inet->inet_daddr, inet->inet_rcv_saddr and
> sk->sk_bound_dev_if with plain loads while bind, connect and
> bind-to-device paths can update the same match fields concurrently.
> 
> Annotate only those mutable match fields in raw_v4_match(), and do so
> at the point of use instead of hoisting the bound-device read before
> the earlier short-circuit tests.
> 
> [...]

Here is the summary with links:
  - [net,v4] raw: annotate lockless match fields in raw_v4_match()
    https://git.kernel.org/netdev/net/c/18f116931f52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


