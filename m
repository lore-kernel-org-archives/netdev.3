Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8183D36B934
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 00:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789689679; cv=none; b=GEHIzfQdZA35MNuQaXvucasucLNNJ9/MFruDo6FEip9S+twTJt2XaCWuBF4D657KUMdKOLLluaqhdAo9KTNV6v7qilpBx4ZWUc8dg5ZUgaMyXE4saxK+XIidulGIfy/XGro6ek80KAW953WnMXSy3KnoEnsBAIjz2ejLwubOi2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789689679; c=relaxed/simple;
	bh=eXg9vsW1zSoEQBo3rkQ9eW3UyLf0JBMsWuhysWzP02w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VLnHi1cS78SewnD3xzPre62VJ0iX/slFllfnUdchS2tbOPtQ/IPl5jaG0g8DTIiIw7PWuo14kkVDdrxUO2Ihr8cImshW1sjzw0d1RxZMtqLePvz94EwQ4xapk3qMyPh3/3StX/KjcMLC53usA7j7O94YsqClcEB3MgSzIs3fEvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrbxrsnd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrbxrsnd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD09C1F000FF;
	Fri, 18 Sep 2026 00:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789689676;
	bh=n6LQGYCCkmUFLGaSf/F7E3XUObv+0jXeA1KEc9uszEU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nrbxrsnd6E2YBNJikFAEJZvQ7mjNCdeC9fqms9OuEGyKH+AjmTUhuOrvsfz+18o9k
	 AYVTV/WJucUEEzsdwjUydJvTDzPpMskCy/AA1Rvlsr6WPz8/tUu7F7vCc6m5/34Dus
	 rswo4LJmst7a/xtC3oqp4o23tvAcdWCilhwgHgwshSPc0WEqeUbkm8CecET23bGpVy
	 uJ1fXyEf2kBT7FzchdrdW7eLvC2MplEt6aLxkMfaqg4I2r0iCyL0F3pWRiK7UAykU8
	 RRLGu7fLfj6IlNYWpMVSVbH7tFnKXJi7jzjkuBiDZRUIFhsLqSWDkfnfMSlcgSXtjZ
	 pe/rpCjclUWqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A78380820D;
	Fri, 18 Sep 2026 00:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netkit: no longer rely on RTNL in
 netkit_fill_info()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178968960987.187564.11512146067041073613.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 00:00:09 +0000
References: <20260916111953.1611574-1-edumazet@google.com>
In-Reply-To: <20260916111953.1611574-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, daniel@iogearbox.net, razor@blackwall.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 11:19:53 +0000 you wrote:
> netkit_fill_info() used rtnl_dereference() to fetch nk->peer,
> and thus required RTNL.
> 
> nk->peer is already an RCU protected pointer, updated with
> rcu_assign_pointer() and read from the fast path with
> rcu_dereference(). Simply use rcu_dereference() under
> rcu_read_lock() instead.
> 
> [...]

Here is the summary with links:
  - [net-next] netkit: no longer rely on RTNL in netkit_fill_info()
    https://git.kernel.org/netdev/net-next/c/aea70e81be7f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


