Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C020B38F653
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 23:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781218813; cv=none; b=vGdu736WcBtmXrbHCs1e9NLu0G4Cm4rH7j9YeqI17COmfAif+P5trS4nvNTeCIKXJ2ieTcfw0+HQdLSRRhygz080XQ/yyjPU42XUcN7ye4QzefFSWHy7gTAvXhTDyYGelMt/7aAS8+1ZmJ2mu9X711jo7KrpgnXXNr7fO1OeNhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781218813; c=relaxed/simple;
	bh=9O1YskzpxESLF+ULTwJ6Phzrzx4TH08iVICrP/Sdl64=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sfks0q3TwIDj+EeOhixEe39Fyg8ojliijs79AkmFWKUvaZc4KmqJDqKBSoA4dXWPo0Q9LYq7DtaRyWnaEt3crE/AzrAyHn76ZfpSYkGJDiuPDt9yRGISMs01w5tcfKlTgua4tOdxZeE6QNu1dAQGuKSVmcFy9ennLBALWOtqtCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gidQOxtY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gidQOxtY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1CF1F000E9;
	Thu, 11 Jun 2026 23:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781218808;
	bh=ttEuAiFKOLumhkb6P9TcgscWQyI1FaCS4vepa1KuZoM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gidQOxtYYwtjZI3vGZ2oEf5EUwbU8d36/9Vq/EMt1r8y3RPjVBhcN7fDBtY8wSP9o
	 0x0+VpaK2pPTMn9gYEVM4+xJPvhqSHVRdBwGRzT+aH6mdWFRAHdz5emLVueDXCEINk
	 UPTCSZup6savsNXA9GbzBLEchWga4K6RTgYPTJOJ+Eiip5+sbIG2G8PFVh62rrb37U
	 dSQW+TgLmKfJUCFusDSqUaAhXgq1CoxMy8q9elvR1JX1qiJGhnoDApU0X4Z+uy4ETr
	 iGgloiYfDUvdky15QiU4g09ejEGIBR2CvmbMaph2tEn0BlAAewYkgq87g0g+lvXQgx
	 96VdtJcMvyfjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09C03930FB3;
	Thu, 11 Jun 2026 23:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: Stop leased rxq before uninstalling its
 memory
 provider
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121880538.398116.5613332341830051618.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 23:00:05 +0000
References: <20260609212240.677889-1-daniel@iogearbox.net>
In-Reply-To: <20260609212240.677889-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, razor@blackwall.org, ahmedabdelmoumen05@gmail.com,
 netdev@vger.kernel.org, bobbyeshleman@meta.com, dw@davidwei.uk

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jun 2026 23:22:40 +0200 you wrote:
> netif_rxq_cleanup_unlease() tears down the memory provider that was
> installed on a physical RX queue through a netkit queue lease. It
> currently revokes the provider's DMA mappings before stopping the
> physical queue:
> 
>   __netif_mp_uninstall_rxq(virt_rxq, p);            /* DMA unmap */
>   __netif_mp_close_rxq(phys_rxq->dev, rxq_idx, p);  /* queue stop */
> 
> [...]

Here is the summary with links:
  - [net-next] net: Stop leased rxq before uninstalling its memory provider
    https://git.kernel.org/netdev/net/c/37314c9dbe95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


