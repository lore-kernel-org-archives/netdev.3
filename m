Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A3C2E7F2C
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169064; cv=none; b=rinF46CzJvvWm6OuVSDDhxQRhUD5zY2XjkbdiaTVcE0xUkESO/lHz8EDb5V0swNXhCADxGu6hD0PK0M2IOTzMbrvY3l9PRMJKuy0JgpK+AJwAENEpnCnbpOx7T7r1zgDH4MyaaCWA/XnzreRF111bPS5bwLZugJXanwzepF4gQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169064; c=relaxed/simple;
	bh=u9TRKh/3JjS5/b72s5g60LX9yvJbj6Nz5kI3r7lcvGA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cov2vqc1hTAS4+jmlDnmapqpXtyww79JDUwGBOJlSXaHrvUHoe5nyFLATjSJjzEvHrvRZ9S9CbNauJUSblPsSuE2ANKVoY2QdOWYQeyTJc/3B5RDToNtpsNCECtAe/pCpuV0YS9j30uvRfAzMBOCtYkAVpL3OND9FehtFg3CU3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EclxiNiN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EclxiNiN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF821C2BCB2;
	Thu,  7 May 2026 15:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778169063;
	bh=u9TRKh/3JjS5/b72s5g60LX9yvJbj6Nz5kI3r7lcvGA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EclxiNiNUbtdBb/C95fXOG+RqH/LqyiViXGaDc7RXHm2ipbOGNwKBhKZbGNgpY0E3
	 L9Vi4PEKon/u5tz3kPBZ1fsoccp47J7jlPOy5C18umTGc3rPYRnnoyK01qTzQUFE+D
	 zNdwYAe0TGZ3XukeY2qsN3VTsWlH/ATm0MPykbGGJ4YoI3eeGroRNJFunsbP7cX4I8
	 9LR6Y16vjg0i6WNQYbvakPStigtrUtmrWJOyb1sBP32L7NKCvc06cSElIpSph4vSpT
	 RmrcpYKm8OW1JwWzgOXrVDwX1BZ+ZkWT4Luvbm+CgNosxn5hmayKGxjU2PWfz4cfdy
	 FSI8i8EuX1iGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDD13930909;
	Thu,  7 May 2026 15:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] tcp: Fix dst leak in tcp_v6_connect().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177816901305.4048611.11304684545945707554.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 15:50:13 +0000
References: <20260506070443.1699879-1-kuniyu@google.com>
In-Reply-To: <20260506070443.1699879-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org, melotti@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 May 2026 07:04:42 +0000 you wrote:
> If a socket is bound to a wildcard address, tcp_v[46]_connect()
> updates it with a non-wildcard address based on the route lookup.
> 
> After bhash2 was introduced in the cited commit, we must call
> inet_bhash2_update_saddr() to update the bhash2 entry as well.
> 
> If inet_bhash2_update_saddr() fails, we must release the refcount
> for dst by ip_route_connect() or ip6_dst_lookup_flow().
> 
> [...]

Here is the summary with links:
  - [v1,net] tcp: Fix dst leak in tcp_v6_connect().
    https://git.kernel.org/netdev/net/c/ecddc523cfdb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


