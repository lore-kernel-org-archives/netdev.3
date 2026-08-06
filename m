Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CBC3AEF45;
	Thu,  6 Aug 2026 01:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785980451; cv=none; b=sTfEHpOGBUHnHpV/N0kNvkRQhiON9zPFFQqf38j/QVqOT6V4gn2/QrjOA99ZUFtsHGL56JMy+mMP+frsTlwoB6nIc/sZGBUd7SD3mmnznms/5VO1KlFgq3iz6qEJ5+q7TtQs51f7VKhfd5W7JtiEfDApVzEZV9R4xQf3gjAnuzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785980451; c=relaxed/simple;
	bh=OqN7kXg/l2DJdmowLIU0xU8rxbLgBV9U9u3S9KVVeKc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m4Rl2iesZxPJo3ZgnUHgd/ObqVUQa/+ifyqrWrZXDfw3g3lvJ6kRod6MM/4TyZqssDXVnUCmngUv9Xg9jInz6JmABZF3YZRr1mbDDmLlmv7a9HziEaio7ycyly8KHTWCXJ3S6ACf0T7pk9OAnahFPMXXchP/QxHmAE8luM3IyOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOA/qkrK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOA/qkrK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722CB1F000E9;
	Thu,  6 Aug 2026 01:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785980450;
	bh=pj94K1DL+x4lDby71m72BqfAv1swFYEJ8oAR31TnWaU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iOA/qkrKLW/7DyNaPjvqTvrJ7tucSEPt3DuH9L+gH+KeBLtf+foUt0R4OQi2MW7eR
	 H6G23Vq9mNIzxr8lfm8cPfeOQ/cYsO5stR58ijBrzBPS+SvyCxGfBG2U4lV/rAPBD2
	 XfLD04boeavxEbtXff7boJyk2WibKu8xTys5muX3KQmo5AHBXDK4nCkvcrYMpSsYhq
	 PNKRIP4OhsMAEYjrpcYXG+RoKENTI0tg3DLhE7HfiMibfjlLkle3aKq6n4ajmdYgRi
	 qv6gCgfzMhX7VgLKopk29u+u0s47v7jO3OjL4UiCELah4c/971z543QEMVkvSmua5g
	 J5m8rii/GDvgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56920392FFF3;
	Thu,  6 Aug 2026 01:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re:
 =?utf-8?q?=5BPATCH_net-next_v10_0/2=5D_Add_ZTE_DingHai_Ethernet_PF_?=
	=?utf-8?q?driver?=
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178598040988.599522.8462097247667886071.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 01:40:09 +0000
References: <20260802160048653KdUvSUgDsEs4zwYF9Ey0q@zte.com.cn>
In-Reply-To: <20260802160048653KdUvSUgDsEs4zwYF9Ey0q@zte.com.cn>
To: Junyang Han <han.junyang@zte.com.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, ran.ming@zte.com.cn,
 han.chengfei@zte.com.cn, zhang.yanze@zte.com.cn

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 2 Aug 2026 16:00:48 +0800 (CST) you wrote:
> From: Junyang Han <han.junyang@zte.com.cn>
> 
> This series adds initial support for the ZTE DingHai Ethernet controller,
> a high-performance PCIe Ethernet device supporting SR-IOV, hardware
> offloading, and advanced virtualization features.
> 
> Changes from v9:
> - Makefile: remove unnecessary ccflags-y -I$(src).
> - zxdh_pf_pci_init(): dma_set_mask_and_coherent() never fails for
>   DMA_BIT_MASK(64).Just call it once.
> - zxdh_pf_probe(): reorder local variable declarations in reverse
>   xmas tree order.Don't print dev_err on devlink_alloc() failure.
> - Remove redundant initialization of fields in kzalloc'ed structs
>   (bar_chan_valid, vepa).
> - en_pf.h: drop unused includes,forward declaration of struct
>   devlink, unused enum zxdh_coredev_type, and unused struct fields
>   (bar_chan_valid, vepa, irq_lock, lock mutex, coredev_type).
> - Reply to Sashiko's review comments:
>   (1) zxdh_pf_map_capability(): validate the BAR index against
>       ZXDH_PF_MAX_BAR_VAL right after re-reading it from config space.
>   (2) zxdh_pf_map_capability(): bound-check length + offset (instead of
>       minlen + offset) against the BAR size before mapping, so the reported
>       *len never exceeds the actually mapped region and later MMIO accesses
>       cannot run past the pci_iomap_range() boundary.
>   (3) Search capabilities with IORESOURCE_MEM only (common/notify/device
>       cfg), matching the pci_request_selected_regions(IORESOURCE_MEM) call,
>       so a capability located in an I/O BAR is never mapped without having
>       been requested.
>   (4) zxdh_pf_notify_cfg_init(): rewrite
>       "if (notify_length + (notify_offset % PAGE_SIZE) <= PAGE_SIZE)" as a
>       subtraction: notify_length <= PAGE_SIZE - (notify_offset % PAGE_SIZE).
>       This removes the addition, so there is no integer wrap a
>       malicious length could exploit to bypass the check.
> 
> [...]

Here is the summary with links:
  - [net-next,v10,1/2] dinghai: add ZTE network driver support
    https://git.kernel.org/netdev/net-next/c/b8180f7977aa
  - [net-next,v10,2/2] dinghai: add hardware register access and PCI capability scanning
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


