Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE491F8AC8
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769203219; cv=none; b=m2twMzf2hfAc/hH4twtewwAWJSwJPsXQy9DbkzIe8C7vGP5S3RgstFcMNyV/byaofaEqucbGwykwOjRcSq83OhgS5StRHDMUyponP3YB2tPU9g8Q42jTxbEEGDC0C08g7E5fngYyI5eERr2eaY2yZXeYXSLD4aJCz7DrbY1aW9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769203219; c=relaxed/simple;
	bh=d1W/GHQaPSj3LwGJPbDM3RXZYsa3e2Mg/iD37XkQZv0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WEhOm3iwpA/NVca9KFNC/TI8EAvw4ZxMFywlt/su79tInwKJANjVRGQoygfbTOASgYLYT9sVBRbYSgy3QR0lixJtHWr1mNkbfo88BlIgXEo6iVufy1xa/pFF+80WZ+D3hN3jELl3dn1ZyTPsgFnKAxkUHKBNeeJ+jzyn0l92EvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=if3heCLu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="if3heCLu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6693C4CEF1;
	Fri, 23 Jan 2026 21:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769203218;
	bh=d1W/GHQaPSj3LwGJPbDM3RXZYsa3e2Mg/iD37XkQZv0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=if3heCLu2gfWmtDReBL7G28GJISDAoYTHyHxz5MzP68hjVjn21hk8xpoRjseHIhlO
	 LRUbJfg692FuaGNAsbYVXhYP96EV3VuKl2GGTHbWCeYa2UeDffz+CDSNxoepTVPVHM
	 ZNgc70pL6sY47VWzWTs3tVJiV/Nx49nD87wqqOAkS7D77hHZLfYZjJl+wbCkla4cct
	 pDFqs4a+/eSK2c1CFmBgH5Tl6pr38ZW+ibDAkZmWZf15PkhbRk62P598ybArEcwMyj
	 0VCJzkXnv3xUZuFubHSaJsnL1zIp3tjAPB7VaUwkrdkwTj97pMqCRrEg6/7jDLQz6Y
	 vFyQTy89dvg+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C88E03808200;
	Fri, 23 Jan 2026 21:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] net: restore the structure of driver-facing
 qcfg
 API
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176920321460.2718299.16926426130797400779.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jan 2026 21:20:14 +0000
References: <20260122005113.2476634-1-kuba@kernel.org>
In-Reply-To: <20260122005113.2476634-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, sdf@fomichev.me, almasrymina@google.com,
 dtatulea@nvidia.com, asml.silence@gmail.com, dw@davidwei.uk,
 daniel@iogearbox.net

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jan 2026 16:51:07 -0800 you wrote:
> The goal of qcfg objects is to let us seamlessly support new use cases
> without modifying all the drivers. We want to pull all the logic of
> combining configuration supplied via different interfaces into the core
> and present the drivers with a flat queue-by-queue configuration.
> Additionally we want to separate the current effective configuration
> from the user intent (default vs user setting vs memory provider setting).
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] eth: bnxt: always set the queue mgmt ops
    https://git.kernel.org/netdev/net-next/c/1410c7416dc3
  - [net-next,2/6] net: introduce a trivial netdev_queue_config()
    https://git.kernel.org/netdev/net-next/c/b9ac2c60a3ad
  - [net-next,3/6] net: move mp->rx_page_size validation to __net_mp_open_rxq()
    https://git.kernel.org/netdev/net-next/c/da7772a2b4ad
  - [net-next,4/6] net: use netdev_queue_config() for mp restart
    https://git.kernel.org/netdev/net-next/c/fc1a78a25c5e
  - [net-next,5/6] net: add queue config validation callback
    https://git.kernel.org/netdev/net-next/c/8e3245cb3086
  - [net-next,6/6] eth: bnxt: plug bnxt_validate_qcfg() into qops
    https://git.kernel.org/netdev/net-next/c/b33006ebb78a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


