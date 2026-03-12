Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86604375F9F;
	Thu, 12 Mar 2026 02:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773281417; cv=none; b=k78MzuWw3c7Rex+zgvvPOtaeVARzRoLFBK0QaohSUPMB4rwMW5ehA3egJWgX4end5/tes1opfEpnXmZ328Tc7NicL6/HK4ecwwOAtwiQ/qw+2iMg1EXmfexm7xPkvaMqHA2rj40ykv9pgtqGkp0WnRheEWYeszVt32L1vkwrkms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773281417; c=relaxed/simple;
	bh=VnzFnkrlCTLmrNTpntOestxzZJHPZEQt+LJJg2UbIxE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cbwhY07wnWf1hk+Mcsixis6GPFvic6Q5pVKa/GxHQfk/L67vMqPbGNHSjd+K1Yadifatl0wB4klj2Xg4vKxRM58VGVcEVWIZJXnvB05CV0bRF3QNaRK2CFqEx7AzRTzNUzkra+6EEFxdcDEF1D+M2P2BWsPS6+0pUJt0xL85l6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVJ8WzEV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVJ8WzEV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B5EC19425;
	Thu, 12 Mar 2026 02:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773281417;
	bh=VnzFnkrlCTLmrNTpntOestxzZJHPZEQt+LJJg2UbIxE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MVJ8WzEVQKDpF6r9yPKr0Fsg7mfxGsaXQVlffu1VTSDJXwxgUx1qNlCeYnA+2GS/9
	 BYYnC09O8bGkm+ErInqw23PlocceEfurLlK7uHUbEmGV7DNmTN1PIkHycjyrgKALy/
	 Kf5mhFMJsGAGatc30PzhjL/xhHgGF4NzbTVff48I/4epuTiUI1GZA70KHyjXyD0K2X
	 QU5lnSeJKgZDpjMeoFZa6W5s8vbLwqVOabnXfrJtZ590BoWPy8BwVEdYIajxh31aAK
	 TRFnQjtXwZ9jd6N8TqQ9uNXM+RJGsWwtRlM04HjuI0Gs4PtwsAqLSJbmniHcgs70di
	 dyXOgKpuCFO0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D09F3808200;
	Thu, 12 Mar 2026 02:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] tipc: fix divide-by-zero in
 tipc_sk_filter_connect()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177328141304.3905617.1945002746161310845.git-patchwork-notify@kernel.org>
Date: Thu, 12 Mar 2026 02:10:13 +0000
References: <20260310170730.28841-1-mehulrao@gmail.com>
In-Reply-To: <20260310170730.28841-1-mehulrao@gmail.com>
To: Mehul Rao <mehulrao@gmail.com>
Cc: jmaloy@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ying.xue@windriver.com,
 tung.q.nguyen@dektech.com.au, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Mar 2026 13:07:30 -0400 you wrote:
> A user can set conn_timeout to any value via
> setsockopt(TIPC_CONN_TIMEOUT), including values less than 4.  When a
> SYN is rejected with TIPC_ERR_OVERLOAD and the retry path in
> tipc_sk_filter_connect() executes:
> 
>     delay %= (tsk->conn_timeout / 4);
> 
> [...]

Here is the summary with links:
  - [net,v3] tipc: fix divide-by-zero in tipc_sk_filter_connect()
    https://git.kernel.org/netdev/net/c/6c5a9baa15de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


