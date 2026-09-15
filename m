Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04114078D1;
	Tue, 15 Sep 2026 23:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789514472; cv=none; b=hij3rajWz3gwZH0Ij5J0TGX/jY1GvRkzfKXQr+Fq+B2HTHIvQZPQ+NdYtO3ab+1mtJ6F7nVfd7d9s3j85bEtJmRThDRnP77jP7n8prKdie4OyV7/qITLbWEZIccw6nFUUKs4LEYO8WUiBqQbCkkotlwKWYqJLiHdbnehRXKRUHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789514472; c=relaxed/simple;
	bh=7oZgtQx3NJj8qinbOXAnUujdKeKQZolww67wAyv93qw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RmoSnZl1oRNJ1uONKj1Z8Vu0Okwtlc5IdHEMrKczvKqYjnKSE7x72Woxak6tnUsa+KNgb7kB4/56yWWMFR7gYOZnYQju1eMinyi/N2vVPH+2WtpUC0lZb0iVPHKAlS8pjP8vP8a/wQHr43/PSNUb6zi2pqv2oG+ZBEg9j/oEpUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9Bro8ww; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9Bro8ww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706201F000FF;
	Tue, 15 Sep 2026 23:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789514470;
	bh=v3pWVLhXI4/1ldBwBVlPWNppvl5GBq2ld1so1WrXcP8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W9Bro8wwpXMlgze73e4/dk9wMSM1kmo75Jm/co+kgicd59TzACf/WBw9wJWb5U2s8
	 z2wFXPxSfvp0BIZKCf5uev4VsrEgHqYCFRXsGroM2MKpQeNTgwIyhmjNW3MdSUZs/9
	 m9mkjXcIKeAZUtWv0Qs8MvXREYB143o9cZw186SksryTeJcZ9I/J6t7j8AYzK3yLNp
	 A9KkbhOD6qr2r1MhVmh3n1lV6o7zNYJVY7VWJkpH5jptKx7rvjg/NoKcjycSZbXhmy
	 qohR2CGBUk8PgIajZuhu6vrNpw5qkzyvyn6ouUgSCobta8t2wihK5+/KRIsw8+ZHOZ
	 sQV1BNjIlxUuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198A63927069;
	Tue, 15 Sep 2026 23:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] page_pool: Fix page_pool_alloc_va() reference in
 kernel-doc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178951440488.2314577.13886516225826420511.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 23:20:04 +0000
References: <20260912060019.39902-1-kmehltretter@gmail.com>
In-Reply-To: <20260912060019.39902-1-kmehltretter@gmail.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: hawk@kernel.org, ilias.apalodimas@linaro.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linyunsheng@huawei.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 12 Sep 2026 08:00:19 +0200 you wrote:
> The kernel-doc comment of page_pool_free_va() refers to
> page_pool_allo_va, which does not exist. The name is page_pool_alloc_va.
> Say page_pool_alloc_va.
> 
> The wrong name came in with commit 8ab32fa1c794 ("page_pool: update
> document about fragment API").
> 
> [...]

Here is the summary with links:
  - [net-next] page_pool: Fix page_pool_alloc_va() reference in kernel-doc
    https://git.kernel.org/netdev/net-next/c/47dbcfdf942a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


