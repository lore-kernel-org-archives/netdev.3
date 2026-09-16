Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071E52D63E5;
	Wed, 16 Sep 2026 00:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789519877; cv=none; b=HcWt1PGrEKGPUQ6aSXTRQnu0awgTgDuDMs9H0Y4xMHkA8KKZaE9Og46zrH/P7Pw1xJy59/7L1oDTe44pRQMZgnsSzv9NO2c+fYX9bFXir0g6nBG0+rAYQGuHdpfY4L2VPu8zYLKNj6OQ8PyAvbtX9YBA5As62y963U4kFPTpWh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789519877; c=relaxed/simple;
	bh=bfQzHVnvHjBqcPRiF7fNcJ7tust5Dk//ZKVemXZ6aYg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uOkp4hBDyITj6iFQPZdM3DBWitd0/sn0jJmeyONOrux57LY7o8ZepQSZJ595XKx7/q6cSzEnZZl33fU/M0tsqv8UxRv8l4ZHMIPUV9+ILGaTdmnO9tEDpAZqTzFBtHWw3SNCVCg2l1LbenvtvVLyixxTeMjriQlSET3omDNbN6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjniXSyn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjniXSyn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26C61F00893;
	Wed, 16 Sep 2026 00:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789519873;
	bh=+rv/gSqVCAewuJ2dU/6tLYPKGMMcqsXnqxtbXdkyy9U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CjniXSynPkljYCdEG6CJ71cY/R+F8Uq2XzeNjqnjuK4VaqAQuoADWySnDCgmmEoKI
	 /NIUcciNqyyfLgT+RfOs0tIeEPkl/L14ydzsTgvxXwZE8Q3eEH0+E2Pl75j8FQiR6h
	 iWXBCxRAew7UU4QtBjTvjBBMzx4SR2UHzWq+CmJYRG65TQDQSQg7d+cof/uDPnLM8y
	 W9F2NgF5RsgVsZELjzYlxKbtvG2LjL5hP9U4t2QVc+c0CcBAqfeFGRUKMiO2FAsWSh
	 LYimXMdDAc98Va3csZnNcyMxiGhRoK4MJX0tVWCd6PN3Nw7lGM7QifQGu++Z/X1UQu
	 QdSXQKokmhTmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939C83927074;
	Wed, 16 Sep 2026 00:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/qla3xxx: disable the PCI device on remove
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178951980712.2341174.5297094058191389457.git-patchwork-notify@kernel.org>
Date: Wed, 16 Sep 2026 00:50:07 +0000
References: <20260913204534.53825-1-mhun512@gmail.com>
In-Reply-To: <20260913204534.53825-1-mhun512@gmail.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: GR-Linux-NIC-Dev@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ae878000@gmail.com,
 horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 13 Sep 2026 16:45:34 -0400 you wrote:
> ql3xxx_probe() enables the PCI device and balances that reference on
> probe failure. However, ql3xxx_remove() releases the mappings and PCI
> regions without disabling the device, leaving the enable reference
> held after unbind.
> 
> Add pci_disable_device() at the end of ql3xxx_remove() to balance the
> successful probe's pci_enable_device() call. Keep the existing manual
> cleanup and probe error handling unchanged.
> 
> [...]

Here is the summary with links:
  - [net,v2] net/qla3xxx: disable the PCI device on remove
    https://git.kernel.org/netdev/net-next/c/d328b5ad4a52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


