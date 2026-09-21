Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A112D44C50E;
	Mon, 21 Sep 2026 23:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790034675; cv=none; b=YH8Ty7rjh9HSZ+e56V2YvdLM1XqWIj9+UhWYQKK9hr7MiJNqqSEdOIe9EWlsU5HABBWJVuIeO5Zdc/Iasu+zmpqh/xI6OgZ6u47vOkD6LmoYu/nPxjxvpa9+Lyc0IM8WfUkCvshBVB6wucDNgQiBAdi4iiOe8xOj8kvZGuCLkaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790034675; c=relaxed/simple;
	bh=Ex5UyPRzbikK8x7tFipfIIcbeGDq/vbtYdr+K8Q//Y0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OW1Rrpysdb1b3VOd+dVvJMZY66YK9T3btZnVwMN0omjoMUIyTzycNqE8P9pBtn4ngOIFOuYQgSAfB2CFwm6WJMa03IE+PSwFdX/lphgDPSsDPFGWN2OguYyFq8bxF785IFyWUsqbOo3VqLfsAp96rp6g8r60oVq0Y9p+cmHP1Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEsWHO9k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEsWHO9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364041F000FF;
	Mon, 21 Sep 2026 23:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790034674;
	bh=Wsl2VBLn5W3uQDDUrMxhsFq33OiDZ19fnk+ImeG7+5Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eEsWHO9k6PxJvK2a5CBNV2UUKr5v33evDRRlFJne3hOSVsPZ+2PwVEjfzyQEAwApT
	 sdvuR4oTPCXSxVFeeh7pa0iCNfn+PrqUaSw4NsiMA/O41VtShIVrry1CB5Ebj1pj41
	 PA3TSo/lhgeP3RWv9HORFN56ooe9RIKrEmagaB6oAlC5NqvgS7avNwqer8jT7g6ue8
	 b0K5xf+TYKsUDY5vfZQ6LtnBgdNTuKqsmxP9XxMzCczf1buLzULuXOVPMLt5/PErH9
	 OqZU5QOl0X0EH5TJymJmg8Uh14nHRlw8TYsgFxSJC2vNG3W05or69RIdlRqlJEC8i6
	 P46AzXxmIY2/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0F1C3930202;
	Mon, 21 Sep 2026 23:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] net: devmem: remove gen_pool from dma-buf
 allocations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179003460565.3294616.1011395712325066826.git-patchwork-notify@kernel.org>
Date: Mon, 21 Sep 2026 23:50:05 +0000
References: <20260917181116.3319017-1-sdf@fomichev.me>
In-Reply-To: <20260917181116.3319017-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me,
 bobbyeshleman@meta.com, almasrymina@google.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Sep 2026 11:11:13 -0700 you wrote:
> Replace devmem's gen_pool based fixed-size allocator with a binding-level
> freelist similar to the one used by io_uring zero-copy receive.
> 
> This is motivated by allocation latency observed in the NAPI receive path:
> 
>   [ 1036.228913]  ? gen_pool_create+0x90/0x90
>   [ 1036.228915]  net_devmem_alloc_dmabuf+0x1f/0x60
>   [ 1036.228918]  mp_dmabuf_devmem_alloc_netmems+0x17/0x80
>   [ 1036.228920]  mlx5e_post_rx_mpwqes+0xdbe/0xdd0
>   [ 1036.228926]  mlx5e_napi_poll+0x113/0x830
>   [ 1036.228928]  ? sched_clock+0x5/0x10
>   [ 1036.228931]  ? wake_up_process+0x778/0x14b0
>   [ 1036.228933]  net_rx_action+0x15d/0x570
>   [ 1036.228934]  ? update_rq_clock+0x31/0x240
>   [ 1036.228937]  ? __napi_schedule+0x55/0xa0
>   [ 1036.228938]  ? mlx5_eq_comp_int+0x137/0x230
>   [ 1036.228940]  ? atomic_notifier_call_chain+0x36/0x90
>   [ 1036.228943]  ? sched_clock+0x5/0x10
>   [ 1036.228944]  ? sched_clock_cpu+0xc/0x170
>   [ 1036.228947]  irq_exit_rcu+0x12b/0x370
>   [ 1036.228950]  common_interrupt+0x85/0x90
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] net: devmem: replace gen_pool with freelist
    https://git.kernel.org/netdev/net-next/c/083e64a3af77
  - [net-next,v3,2/3] net: devmem: embed net_iov_area in binding
    https://git.kernel.org/netdev/net-next/c/13648ba78722
  - [net-next,v3,3/3] net: devmem: batch net_iov allocations into the page_pool cache
    https://git.kernel.org/netdev/net-next/c/050bacb138f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


