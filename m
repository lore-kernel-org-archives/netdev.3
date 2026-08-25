Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9396948095B
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787664667; cv=none; b=WOpw+VQpt0UUl2m1QFu+m+a5dvme+caoRU/gfBR6+oalwP8vpt+PQblK9TRbRJka/MztS05G1pwBWZ6leibbOr9UOBtaUcopS7MMV+rplOVnaTz5MnnxT8HY5ny9MtlRWd7eBAMYzx9f2EcRVeGH8POLtOkC0pgr3X5qtf9WbwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787664667; c=relaxed/simple;
	bh=/iGLgLdta5ZXXaLm/FKK5X/ORtfw4YRfnDoHC5wG7Bo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pqcuBazAdhF/4Rkm6VcBm0h8gxYl7zXWBh6VFS/KjQAjyCvPOJwndH/4NnCu041smhiHYqkngTxlITVVkjB41sje87H9FGPC3n+C/kWc6jv5vEYFqErEwkLr06FHjmO45IAaBuAH1HuWsLIE3TDpcL7GRzkNq87BCkL6f1JkWcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bv71UzB5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bv71UzB5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634BB1F000E9;
	Tue, 25 Aug 2026 13:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787664666;
	bh=M6ti4z7e7UUK60FucVebPOC+uu9RRdeMVKb1B+d5NOI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Bv71UzB5Yoh38II+enVOBSxKqVZNJDuXXlzH76ku8OVz6rn1KTGqcc2JEfdBz+s97
	 brby76iBCi9PjD3mamsFAFA3qRovZtAPTJwq4nO9a5H5bVuUX+606Ag0fMMXoFTMui
	 +V6An7/YRt2jXzCK+UVNHOeah6FndefiKfSSeaAUVwxMUk6ZSL50EYTZ6uuQTqOHk/
	 qEgD+57JxmTCj1RPS8j5OsaUJcDzUhwCeunTl0jh42gB0t3ax30mlvgm+4YFZUY+RM
	 hfPshvJ2ULleXkVF1Fsu3wKVSPBjneEHLnD0HcrtgpPvpbVqVReBPrDlelo400R/2W
	 VlzdOJDOZ8lmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 953863924FE1;
	Tue, 25 Aug 2026 13:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net RESEND] net/sched: sch_teql: restore skb->dev on the
 slave
 failure path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178766461348.3460835.4622970017775216040.git-patchwork-notify@kernel.org>
Date: Tue, 25 Aug 2026 13:30:13 +0000
References: <20260824115928.4099988-1-victor@mojatatu.com>
In-Reply-To: <20260824115928.4099988-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, horms@kernel.org,
 bestswngs@gmail.com, vega@nebusec.ai, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 24 Aug 2026 08:59:28 -0300 you wrote:
> teql_master_xmit() sets skb->dev = slave before calling the slave's
> ndo_start_xmit(), but never restores it when that transmit fails. The
> skb then walks on to the next slave still pointing at the previous one.
> 
> If a later slave has no resolved neighbour, teql_resolve() hands the skb
> to neigh_event_send(), which queues it on that neighbour's arp_queue
> with the stale skb->dev. skb->dev holds no reference, so deleting the
> previous slave frees the net_device while the skb is still queued.
> Whatever runs next on that skb - arp_error_report() on timeout, or
> neigh_direct_output() -> dev_queue_xmit() once the neighbour resolves -
> causes a UAF like the one below:
> 
> [...]

Here is the summary with links:
  - [net,RESEND] net/sched: sch_teql: restore skb->dev on the slave failure path
    https://git.kernel.org/netdev/net/c/dc4b95b8fee9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


