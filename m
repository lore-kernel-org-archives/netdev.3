Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A1C1E89C;
	Sat,  2 May 2026 00:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777680672; cv=none; b=Zox8TqFdTbgNxvAzLrXM35AYF63MXhAPlaRxT61aof3EVIph3eQjFRqTHe0elNi5UrDjv4PZDM5kRw7PDI/H7AChDr//ItiY0h8A0vQQtfUSUfw+togV5Fu4psF4fqu/6s75KKrhxkr8zRxuOWRKsbCRSTXAIoFCvwX7CvGSrOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777680672; c=relaxed/simple;
	bh=JZN9ie2AMUJx5uAVO0fXxl1MGFjhOA872Atu97tMJMk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TQp5ym7OgTFufPB2iQ8rOySzhX5oJCd/41jYEH2gGFRvmgP7oOONVJIDWBZwpfRKlcCH/21OOp9jkv/JRg3m1CjBlQIz5BABNGoutekTCVFl3xtdWcOtKEGxnm71QWmT5TUfQEJvAy1JjchFK0F7OXSmdUOWyqd8z7ZqdorEovA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/frPHhj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/frPHhj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF4BC2BCB4;
	Sat,  2 May 2026 00:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777680671;
	bh=JZN9ie2AMUJx5uAVO0fXxl1MGFjhOA872Atu97tMJMk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y/frPHhjfmO5IuHnnVoGtkuORxG+eZXA19uZ6JYdRnLX7+gTkkzRn1QVqX5FDu3p+
	 q0MZ1sGcHLdMyWPHs0zH7odL94hLMQ9FXKBiGecAoM9zUEs5rdRkAsr5IbIF+aWM5A
	 jZNuhB5ICA5PGzWWV+3MEgjp2IyFW9G4NpUYOcsa3tNeISU9NrXyW989qyNdej3wK6
	 WvQmM3S6fvScGRDyuygwWqF3Xwe4dlvFZTS2dEfv0NJiiyzOUt8tctEjEU+mN0oyv2
	 1QSOtVW0JZYnU4A9JwrBPcVU/Xy+UrHd2wTysi1vgsDDJrgAT/Yee/6TrMF2q/DRuz
	 8aOz6YNDXFWAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDCE380CEF5;
	Sat,  2 May 2026 00:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] net: cs89x0: remove ISA bus probing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177768062479.3667015.170430092826347194.git-patchwork-notify@kernel.org>
Date: Sat, 02 May 2026 00:10:24 +0000
References: <20260429145624.2948432-1-arnd@kernel.org>
In-Reply-To: <20260429145624.2948432-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, corbet@lwn.net, andrew+netdev@lunn.ch, arnd@arndb.de,
 akpm@linux-foundation.org, horms@kernel.org, skhan@linuxfoundation.org,
 mengyuanlou@net-swift.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Apr 2026 16:55:45 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The cs89x0 driver is really two in one, and they are mutually exclusive:
> 
>  - the ISA driver was used on 486-era PCs. It likely has no remaining
>    users, like the other ethernet drivers that got removed in
>    linux-7.1. The DMA support in here is the last device driver use of
>    the deprecated isa_bus_to_virt() interface, all other users are either
>    x86 specific or or got converted to the normal dma-mapping interface.
>    The driver was maintained by Andrew Morton at the time, based on
>    the linux-2.2 vendor driver from Cirrus Logic.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: cs89x0: remove ISA bus probing
    https://git.kernel.org/netdev/net-next/c/93cda0c120ac
  - [net-next,2/2] ne2k: fold drivers/net/Space.c into ne.c
    https://git.kernel.org/netdev/net-next/c/4fe18ddd17d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


