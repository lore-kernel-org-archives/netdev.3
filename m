Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86FB370D70;
	Thu, 21 May 2026 16:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779379212; cv=none; b=QfNAOCR2Y44CI/0TykHwsGzlEfpvEpxVNbz9BAmYcJyfYAlossm6u+mPIWAtw79VQNNwzONmA/fPtGSUXXpwsFIQtfcexOvKFSyqhR5KiNxEKIAgv37gf+K0s17Sqhq9TyhnsMBR1P/TGB9cj2nfgaggQbwtIx4lwtAtTRpsWB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779379212; c=relaxed/simple;
	bh=rITkirD2uTUBYnsNArSerbG9BdZE0iZ6h3vyqgdqLhY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RAzxjii2RUoT1KCqGM6tvO1HV6lY3O6iX+fB4HX74fJ5ADh5UeCYayUKWTguWlr9VMREUNd2KV2AZn/J+KcFuRNhXsSJwM2yuGSzYW2pLP2YgxkEW5HduWi+9fKxWYV6wxgiGKDFgNyVUd8KZSkLcsq+zZROM4MjyM09NtJqObI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5+sp8Hc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5+sp8Hc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5201F00A3B;
	Thu, 21 May 2026 16:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779379211;
	bh=lXZG8Nuh1gjzWA1ZQS9DRDpYWOBFcIujbgEZdYrGYdI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=S5+sp8HccBv8yPTyQw9DkagbImSKY8YwAOo7t0HZ8txaxx9LdDVLaHawT9szLtwg6
	 l7/m4C8fj7jfLd3AR7LJkia63obT1cWhpmimqzkufyXxpgj49YUUwrrDjAtl1EaoL7
	 qRSHFpqEXBhsL1Oodn/fXoL/sboHivhOjko2LyXG5S9e00FdyyR3tRg9hTCzR2MwmR
	 TopbX6ztBj5yrMadCSGa/iEF9QXDI/kq8hz3uOtQvgUqnUl1JEOar6+pYxb8EtD1re
	 K3tevkiuNnR4lzbU+DxCNWQSN0xpMOh1fMJQpnPGXkJwRUAxx+rOESACH/x/sKEZfE
	 7zIMe1XiqpM8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09973930E0B;
	Thu, 21 May 2026 16:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] l2tp: use list_del_rcu in l2tp_session_unhash
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177937922139.398712.13031007990966134157.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 16:00:21 +0000
References: <20260518183447.64078-1-michael.bommarito@gmail.com>
In-Reply-To: <20260518183447.64078-1-michael.bommarito@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jchapman@katalix.com, tparkin@katalix.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 May 2026 14:34:47 -0400 you wrote:
> An unprivileged local user can pin a host CPU indefinitely in
> l2tp_session_get_by_ifname() by issuing L2TP_CMD_SESSION_GET on
> L2TP_ATTR_IFNAME concurrently with L2TP_CMD_SESSION_CREATE and
> L2TP_CMD_SESSION_DELETE on the same tunnel. All three commands take
> GENL_UNS_ADMIN_PERM, so CAP_NET_ADMIN in the netns user namespace
> suffices; on any host that has l2tp_core loaded the trigger is
> reachable from a standard `unshare -Urn` sandbox.
> 
> [...]

Here is the summary with links:
  - [net] l2tp: use list_del_rcu in l2tp_session_unhash
    https://git.kernel.org/netdev/net/c/979c017803c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


