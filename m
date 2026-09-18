Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A98D14900E;
	Fri, 18 Sep 2026 00:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789689673; cv=none; b=toYQjLEb+h0TFL3xd+OQbOR4Q5tg1fGQ34Jv4BcO/JEIIlOo/FhOKZiiBcwqC6f/9eAKBDhgYoHA5B+LAOEc27zcLvWoJ6ElI5kupG6rBEVIeljy4c7FVuHCYDdcYe1b/0Mxn4pXPQsTo4dzvBnS/CVu11RbHgq7UI19qjIVWwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789689673; c=relaxed/simple;
	bh=UCkH4kNel5g6Gg7wIGhdGeLKmoI5xMyANUFkK96wN+4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=igFFAaKh1yzWCzh/4HKyoSfiC0TlGH1grUJB3t8e8O7GqiCUbIZk00BAB69dMnO0I3ty0pYjIS3E0CeZ09UrYk3R3U5gcMbAQsiT5qGJQmSXoKFhK/15rBN5mcBuYYFrvhPsYtlCumkW1Kz42BvVrnGMbAKEH6xXjub6Vm5IIO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8hn7m7A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8hn7m7A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E903E1F000FF;
	Fri, 18 Sep 2026 00:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789689672;
	bh=xAW6jyG4MeuFRaidl8Lz2Z86rGKSwl6wJqFA3JUXbR4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=D8hn7m7A2CfuSxBK3cY0lHFMi6jrL8X1klHUzhuBQA80U3OwAaEfjo9qqa2U76cyo
	 p47RRVvv2Vm/F5s83IBT2zMKEfMRnn9GbjtCdKMmVLiwS39uUH+gpe7IG3mkWPZLpj
	 40RenqQPylZEJ9o8gIy3YasN5aRqfSSQxsUTvY/+kj9Sj8TZnCDxJ27u83f8mxiLjb
	 0nvB3zEs+5ZwGaVNPQUR0AJgSdl6A4CGguOptv8SXKGoXHmRYtpHS4q6mzUdX3Oc2C
	 1Yp4EwTJLscL7ah5kmmLL7fKm6TjXTg9GmF/BT78Gk9TDlk2iCbUKpkeYGDQisVUnl
	 UFKrUp7OKyELg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93893380820D;
	Fri, 18 Sep 2026 00:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] eth: fbnic: Fix payload page pool error cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178968960512.187564.8129422138547444186.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 00:00:05 +0000
References: <20260915104917.3978113-1-bjorn@kernel.org>
In-Reply-To: <20260915104917.3978113-1-bjorn@kernel.org>
To: =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, almasrymina@google.com,
 linux-kernel@vger.kernel.org, netdev-bot+sashiko@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Sep 2026 12:49:15 +0200 you wrote:
> The payload page pool pointer contains an error pointer when its
> allocation fails. The cleanup path passes that error pointer to
> page_pool_destroy() instead of destroying the header page pool. This
> can dereference the error pointer and leave the header page pool
> allocated.
> 
> Destroy the header page pool instead.
> 
> [...]

Here is the summary with links:
  - [net] eth: fbnic: Fix payload page pool error cleanup
    https://git.kernel.org/netdev/net/c/8e0b235bd918

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


