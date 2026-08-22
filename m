Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F22493627;
	Sat, 22 Aug 2026 20:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787431264; cv=none; b=OjlRQTUve4aTMpvx7WlmUGI0yhVDAALaq8qz9F5s8NYZ6Kyw/3edhT/YSRJrAwOIKosHsEh2uOF7VAI04XmgF5i8iHhJxRoXS2CHI+2NU3eRPEs3Z/tLmQoNXkxrzWrpFk9O0L65vV63+lB/jlW9ds+GF20mp6ElueUqFq23jD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787431264; c=relaxed/simple;
	bh=mXcxXn7TdKgyyNRHwi50zBklP10iU4a37zOyUV83syM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W3K2YH6tG32uEd0mP4MMFlO7iy++fOyDWJy8MO4f5OXyV5qXeRvmOLWG3fxbs/fDnSoc1EUBrzDkb4Xndx1l0mka4bIri1LE7LAiQoKUE6NGzlCTgo0yAyKNFtb3uKA4S+sCFo6JAHUIzhJj87sQNkEhCVT5r+5AN2c0pE/w/VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNSyPlCT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNSyPlCT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1361F000E9;
	Sat, 22 Aug 2026 20:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787431263;
	bh=P229bHm+jMLEhJFf8fKLSjawrqZDK8aXagFFVEmo8rQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BNSyPlCT5DGSVqyOhT13WzpXDxs4CF8QCWz9BTKr9z1JffUJ9A+yXViYUOgdADEN/
	 UacZagfPDNm4qgY0mBJuOpf43g38M61OjDythGL2WGDt+eqxllFB7CJhSIYr6wlsdq
	 ylB9LMcWkoGBatV3vBN9nno4XCtOMQATHPHf9oL16LYbBGORr+e4yJ4c0Ov3eVGcjz
	 YvKuJVjabK5g9YMxW6i7bqjViTATlaazObYwV4SZjvjK9PjUokG/R5HZQnUUZZJbCf
	 l72ov+0cACwIhqRhgeuouSGpztTP86DK/qLXDa4hgyLddAnCjCCP5n90zllaNpBb/X
	 VkbGFbFdKZ4Ow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1988B380CEF9;
	Sat, 22 Aug 2026 20:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: page_pool: Remove zone/policy GFP flags when
 allocating XArray entries
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178743121165.1821669.13695262349197988811.git-patchwork-notify@kernel.org>
Date: Sat, 22 Aug 2026 20:40:11 +0000
References: <20260821-page-pool-xa-drop-dma32-v1-1-6eab295c3478@rong.moe>
In-Reply-To: <20260821-page-pool-xa-drop-dma32-v1-1-6eab295c3478@rong.moe>
To: Rong Zhang <i@rong.moe>
Cc: hawk@kernel.org, ilias.apalodimas@linaro.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 almasrymina@google.com, toke@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Aug 2026 01:41:25 +0800 you wrote:
> Net drivers request GFP flags according to both the current context and
> the device constraints, but the XArray entry itself is by no mean used
> by the device. Passing though device constraints to XArray allocation is
> a bug and will be warned and fixed up by slab, e.g.:
> 
>     Unexpected gfp: 0x4 (GFP_DMA32). Fixing up to gfp: 0x82820 (GFP_ATOMIC|__GFP_NOWARN|__GFP_NOMEMALLOC). Fix your code!
>     CPU: 2 UID: 0 PID: 1071629 Comm: kworker/u80:1 Not tainted 7.2.0-rc7+ #1 PREEMPT(lazy)
>     Hardware name: LENOVO 21Q4/LNVNB161216, BIOS PXCN27WW 10/20/2025
>     Workqueue: mt76 mt792x_pm_wake_work [mt792x_lib]
>     Call Trace:
>      <TASK>
>      dump_stack_lvl+0x6e/0x90
>      kmalloc_fix_flags+0x4d/0x6a
>      refill_objects+0x10a/0x330
>      __pcs_replace_empty_main+0x292/0x5c0
>      kmem_cache_alloc_lru_noprof+0x4c2/0x680
>      ? __xas_nomem+0x3a/0x120
>      __xas_nomem+0x3a/0x120
>      __xa_alloc+0xd4/0x190
>      page_pool_dma_map+0xef/0x400
>      __page_pool_alloc_netmems_slow+0xed/0x480
>      ? lock_release+0x280/0x490
>      page_pool_alloc_frag_netmem+0xe0/0x3a0
>      page_pool_alloc_frag+0xe/0x20
>      mt76_dma_rx_fill_buf+0x1f6/0x580 [mt76]
>      mt76_dma_rx_reset+0x1cf/0x230 [mt76]
>      mt792x_wpdma_reset+0x183/0x1b0 [mt792x_lib]
>      mt792x_wpdma_reinit_cond+0x5e/0xa0 [mt792x_lib]
>      mt792xe_mcu_drv_pmctrl+0x28/0x60 [mt792x_lib]
>      mt792x_mcu_drv_pmctrl+0x3e/0x90 [mt792x_lib]
>      mt792x_pm_wake_work+0x2d/0x1d0 [mt792x_lib]
>      ? process_one_work+0x20e/0x600
>      process_one_work+0x230/0x600
>      ? process_one_work+0x256/0x600
>      worker_thread+0x1ec/0x3c0
>      ? rescuer_thread+0x610/0x610
>      kthread+0xf2/0x130
>      ? kthread_affine_node+0x140/0x140
>      ret_from_fork+0x2a5/0x380
>      ? kthread_affine_node+0x140/0x140
>      ret_from_fork_asm+0x11/0x20
>      </TASK>
> 
> [...]

Here is the summary with links:
  - net: page_pool: Remove zone/policy GFP flags when allocating XArray entries
    https://git.kernel.org/netdev/net/c/039f248a6cc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


