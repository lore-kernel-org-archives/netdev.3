Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501606;
	b=EEIBpT6Kc7r3o6e5z7S0Fd1YAAj0KuIrrOSSSfxKXu4H8CJkTyDAr8rd8lvLs/tPwvu2
	 Ni8NBb2QkhN4oWURlQz/6GPFpWbW11fZalrwAXhksryb37yrcjV1tl5WaUdSQKDyru3Wk
	 kBRL1LWwlgg7zNAAqFSSHtK2XE0rQ3AjjA6CsVDO1dfzecR9PDEt3bItK0BIz9TTqpVC7
	 4fvb7cNoGnIAuRy5N6fwaiR82zKfRJNvE2fknGAyU8UY3mK8Jj/ihyjTnC6OQiQ7r/k2P
	 ZgdukD5VZkwz4/ycjC5wXaaRibsi+TRv5sTaxwkX5fI/LLhEu/j+F26uXyf7Ag2kyMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Lq1TICx3qkA5CbbonbKpcn+aZhZNyYUwzWGq9B9pKXA=;
	b=BB4oKkxp3fe5e2pm/0MhSo1cUUvGJ6AuzGESja+uKBkAT5wQx8L0KMZ+ydMpoK5mQpy4
	 gFhhmpABJ7mayDJBArevWwXTYWR32tk1hYeNEiEfmkH5Gf7A/P2JJ0uDBJ3u5VHBQ/Ykw
	 WI+gasRmy/z12/v5kBEOFT0Dl1L3Cc3miSfTEC6xPfxZp46ZuZoo1zfiSz/9mW8U0QEBM
	 fMOZULi7Zari67Tir+d1TFoQWYypGbp0AC0vnQc8Kno/4x3MXjsUFQoFbW3zYzp4DPFZC
	 EGtrYH0TXZMg84rvHNp4wQ4h8ge/e++Z9thzkCTRolbgGNskUy47sQJ38ibqjZUVxUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bMw8zU+l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39318606A8BB;
	Thu, 12 Nov 2026 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bMw8zU+l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7F01F000C5;
	Thu, 12 Nov 2026 16:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794501606;
	bh=Lq1TICx3qkA5CbbonbKpcn+aZhZNyYUwzWGq9B9pKXA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bMw8zU+lfv80QfDOFILC9ANYGN78R5hhaeTn+xi4eFylm5xofoCPkjTY1EivpN8WO
	 66CbtsmCJZzzGnjWqXjPO9gGYKZUH+Shmbc/GSAVzj4iwKsOdfOEdeEDQthmK294zc
	 eUf7h0Y0/Cyyefx2W/bwQveTGz5f8l4+BIJmCHbmYLnsiErBjIvs2idt6GK7iko6A7
	 WjpHlEDZRUfs5gUHeS1USXsuqGakH1/n713XQTHuv/5xN05gBrxVugRuWBd4Qg7bbK
	 k5ZbAWq7xO+a4cdUys3uryda0NXy8o0UzVVm+WAvuA4cCjeWUFk08wNd0jJb0kZxBm
	 yHiMnz8f8VU3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F149D380AA5F;
	Thu, 12 Nov 2026 16:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ptp: Report clock removal to poll waiters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179450160478.52552.8310562765355263034.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 16:40:04 +0000
References: <20261108064928.1931917-2-thnkslprpt@gmail.com>
In-Reply-To: <20261108064928.1931917-2-thnkslprpt@gmail.com>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: richardcochran@gmail.com, netdev@vger.kernel.org, horms@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, arnd@arndb.de, john.stultz@linaro.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  8 Nov 2026 08:49:29 +0200 you wrote:
> ptp_clock_unregister() marks the clock defunct and wakes timestamp
> waiters before posix_clock_unregister() marks it a zombie. A poll
> waiter can consume the removal wakeup while the event queue is empty,
> return no events, and remain blocked until timeout after device
> removal.
> 
> Using netdevsim's mock PTP clock in an x86_64 QEMU/KVM guest,
> the unpatched kernel missed all eight epoll removal notifications.
> The four poll waits returned POLLERR only at timeout. With this
> patch, all 12 poll and epoll waits reported clock removal promptly.
> 
> [...]

Here is the summary with links:
  - [net,v2] ptp: Report clock removal to poll waiters
    https://git.kernel.org/netdev/net-next/c/92be25a17ed6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


