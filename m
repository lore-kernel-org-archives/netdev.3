Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3414F8632B;
	Tue,  5 May 2026 02:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777946458; cv=none; b=b8TxVg2Wga0vii/RXdsHwoTtrxL2U5N49B5fHoNpFhvkvixI4ACduvkyQbk2/0jomQh47sLwUPne+Vn51f/3D4rucuw+e300fXBbHXg1uK64vRR/6y0AEDxyMlv3ZFDtJ/1FkMNXXztjdJkMl9tySw0BNE/kAtF5qkBU61o/sbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777946458; c=relaxed/simple;
	bh=mCtQBBJTBguiVZJ/fql3IKesu+8Fkk90kckPyJPD5Ks=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=km/YXsoxFCqnvTtpEHX5AyjV39jbTJ6G3N6AvooU9CoEbbRDICzUPNqkaQ89H4FI/EcrsQlJusNvjJCg+eVlgBgOS9gnhaHEyr6ppFcv95H92k7uBLsGQDYixR62GwedZggOZu947prniLHUucO6xJBSV5hy2TvyN3k76BdwQVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sv+X+8YI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sv+X+8YI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BAE7C2BCF5;
	Tue,  5 May 2026 02:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777946458;
	bh=mCtQBBJTBguiVZJ/fql3IKesu+8Fkk90kckPyJPD5Ks=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Sv+X+8YI5YigCqtYvqeyplXtGd3iW2vfRpmAQH3BBRTP/Q+hb7JQHd3oyt2+N4SJc
	 nFpZWNCJYNjf9mA6/eavGSjNUJskIKNJ/tdiKWd+PEDyfEBlQ1zyociKPCzcXMgp3z
	 XhFracPzVI5LRsHtzMkty0GL2SpQgFNSIJh7RK7ZUlp2oDllDbMwe0tkAlC57ENjUp
	 TjeoCLyggRZLkHfjnTHPF77YE9A64jfAZTx+7cUEhe15A7aLApu3hvnMfuY+5lgh2D
	 l122nDwgheoL2Q0f0GU+7qiZmvEp+Ya+RTke2FkHY58rybzD3xdEMp0TmH8636ij3R
	 wesk4ZAzIKQMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D483930197;
	Tue,  5 May 2026 02:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netpoll: pass buffer size to egress_dev() to avoid
 MAC
 truncation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177794640854.1386640.5844242432544883755.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 02:00:08 +0000
References: <20260501-netpoll_snprintf_fix-v1-1-84b0566e6597@debian.org>
In-Reply-To: <20260501-netpoll_snprintf_fix-v1-1-84b0566e6597@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, ushankar@purestorage.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, clm@meta.com,
 kernel-team@meta.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 01 May 2026 02:58:41 -0700 you wrote:
> egress_dev() formats np->dev_mac via snprintf() but receives buf as
> a bare char *, so it cannot derive the buffer size from the pointer. The
> size argument was hardcoded to MAC_ADDR_STR_LEN (3 * ETH_ALEN - 1 = 17),
> which is silly wrong in two ways:
> 
>  1) misleading kernel log output on the MAC-selected target path
>     (np->dev_name[0] == '\0'); for example "aa:bb:cc:dd:ee:ff doesn't
>     exist, aborting" was logged as "aa:bb:cc:dd:ee:f doesn't exist,
>     aborting".
> 
> [...]

Here is the summary with links:
  - [net] netpoll: pass buffer size to egress_dev() to avoid MAC truncation
    https://git.kernel.org/netdev/net/c/76b93a810757

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


