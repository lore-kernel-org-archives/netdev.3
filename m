Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E073C31AF2D;
	Tue, 20 Jan 2026 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926608; cv=none; b=lXJJrldp1Rexl5MaARTaGFmrFdJEYOGWyN2/T4vizVgCyroFQL1s8bzp16YSGGSUNAuBIB5QOniS5llUFVAQ0/ueGHNMA7JlBOuHUs4hwniXwk/qWd7jzgJ71KclXO1qNdDnKI66WM1RKqINGoCEWl95sSC+CoVqZHRFDBWCcu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926608; c=relaxed/simple;
	bh=pBpKOZhNvenUVHqUyiVbuZTAOpSxq9FVRJcMRVLUnHw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=buOaJDkg7STRmR7IcTrKVWQQUCrbzHabDRFdl6z30TAUlEylkr9cy01LYzWAhbVHhCAWmTK/uVU2RwPv6Sz1MmPnSAmESMFeh/4nzLycF1iMqafu2SrlgRNp5hXezDQaDs5wvII42ntZVDETm08EE3MTzWpZL+9LOf1JiQajznQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIZqh4AO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIZqh4AO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC676C16AAE;
	Tue, 20 Jan 2026 16:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768926607;
	bh=pBpKOZhNvenUVHqUyiVbuZTAOpSxq9FVRJcMRVLUnHw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pIZqh4AOftcTdgpt6qm4QafQiTQ1cfqvoyoJG8jjO74YwWJ/zd0tm+M3/n/oBcRdj
	 IQI6SCTWKc4/z30yA9ybVUsfHaGrJptewG/371Oyv70k5Po4i5a9V7OaQDWd0RFfcU
	 Qs2DClCQKYhE8ROfCj2jjj3su4+kz3akNpcx338kpJhYgNW0sI/NJrakBiJzfTKOCN
	 YMPSvfMqcgNLz83TmhFj4TjkGeNFRL1k4wbUhp5WPJCZlHjJkUOkPMmyYeS0Abcmey
	 xlt9pOVasH1v0DP7Eb4lJPYesuVkyFXj7SgDQ16T223T7j1eTCZ1UDE8wHRgvZw134
	 o67tGiBq5RH6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8B9B03806671;
	Tue, 20 Jan 2026 16:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] netdevsim: fix a race issue related to the operation on
 bpf_bound_progs list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176892660514.117222.932562208137734331.git-patchwork-notify@kernel.org>
Date: Tue, 20 Jan 2026 16:30:05 +0000
References: <20260116095308.11441-1-luyun_611@163.com>
In-Reply-To: <20260116095308.11441-1-luyun_611@163.com>
To: Yun Lu <luyun_611@163.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 16 Jan 2026 17:53:08 +0800 you wrote:
> From: Yun Lu <luyun@kylinos.cn>
> 
> The netdevsim driver lacks a protection mechanism for operations on the
> bpf_bound_progs list. When the nsim_bpf_create_prog() performs
> list_add_tail, it is possible that nsim_bpf_destroy_prog() is
> simultaneously performs list_del. Concurrent operations on the list may
> lead to list corruption and trigger a kernel crash as follows:
> 
> [...]

Here is the summary with links:
  - netdevsim: fix a race issue related to the operation on bpf_bound_progs list
    https://git.kernel.org/netdev/net/c/b97d5eedf497

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


