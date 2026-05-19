Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A514EA361
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 10:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779187205; cv=none; b=qw40pWQFddUmenrj/eGTH083ESNAadoQniQWxcp3zLwRJ1GvMNLW3Pl/Cxj8YzUvoaMDa/Lqrtw+SdFmwEWuzaLv1qjd4+R0Ojk17xFeOJb4uASCULH1KMgRuwsAi+YQAIfxTAcQJL2hu3JdamCZrUXrmYDDssYatXE4VI5SH+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779187205; c=relaxed/simple;
	bh=S9xfbKU/5+L+W889/Jmnw/gLkpAM1/6X59r42BUU6L0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lp38Pcuo5GMU7o8ZcHOo3KXmGfPre+QPMiPUHwy5DUcDGH29HdDFl95xmYcXzdj+RcrX9zOSdXv45BXbYICfbloAUiO7UsfHg4isSZyk2gnkXSdktSKX9JE+Z9Md6yXV+bcsk49BDNFtiJZBTPdqPbhQWJW6kfFCf6EjMRr5qL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctbSiUkp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctbSiUkp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAB3C2BCC6;
	Tue, 19 May 2026 10:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779187204;
	bh=S9xfbKU/5+L+W889/Jmnw/gLkpAM1/6X59r42BUU6L0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ctbSiUkp28h7ia8CG+njljRUQ4wjv0Z+H4aZ5AbLqazOJpp3GpMz9tyNi1OIyJh7V
	 NgrK3vIZwJasnvwCB3XxArvNWQeeIVC2k++f2jyW4gsSe2O00y/fORnl0KaOlmjd23
	 oXw+506c/kBLI84BI+i68YpMcypWuUVZRa+Mn/SPq/LZUax0pTLKTgQ9AFJPmTXlv/
	 ZML1xPbCXxlBEwNYtX8pwCTfXxyKNHJ5INojbm53Ms7xCnQEjfu1IlozpN7oC88dvN
	 2MsgHI+l8+Nyw/E6zQFPtM26F/dA7roGBRoF2cwu3Y3YKcOIGrSr7hV4j6aG9YzWYl
	 zH1tUjgbCIARQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199293930DF5;
	Tue, 19 May 2026 10:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v43 0/8] eea: Add basic driver framework for
 Alibaba
 Elastic Ethernet Adaptor
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177918721596.2230567.180022003291116772.git-patchwork-notify@kernel.org>
Date: Tue, 19 May 2026 10:40:15 +0000
References: <20260514095138.80680-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20260514095138.80680-1-xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 guwen@linux.alibaba.com, lulie@linux.alibaba.com, vadim.fedorenko@linux.dev,
 dong100@mucse.com, 25181214217@stu.xidian.edu.cn, hkallweit1@gmail.com,
 dust.li@linux.alibaba.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 14 May 2026 17:51:30 +0800 you wrote:
> Add a driver framework for EEA that will be available in the future.
> 
> This driver is currently quite minimal, implementing only fundamental
> core functionalities. Key features include: I/O queue management via
> adminq, basic PCI-layer operations, and essential RX/TX data
> communication capabilities. It also supports the creation,
> initialization, and management of network devices (netdev). Furthermore,
> the ring structures for both I/O queues and adminq have been abstracted
> into a simple, unified, and reusable library implementation,
> facilitating future extension and maintenance.
> 
> [...]

Here is the summary with links:
  - [net-next,v43,1/8] eea: introduce PCI framework
    https://git.kernel.org/netdev/net-next/c/4f68ffc45e94
  - [net-next,v43,2/8] eea: introduce ring and descriptor structures
    https://git.kernel.org/netdev/net-next/c/039ce329dfe6
  - [net-next,v43,3/8] eea: probe the netdevice and create adminq
    https://git.kernel.org/netdev/net-next/c/4c45a51e5bf5
  - [net-next,v43,4/8] eea: create/destroy rx,tx queues for netdevice open and stop
    https://git.kernel.org/netdev/net-next/c/aa8bca4cf200
  - [net-next,v43,5/8] eea: implement packet receive logic
    https://git.kernel.org/netdev/net-next/c/df9cad6baf43
  - [net-next,v43,6/8] eea: implement packet transmit logic
    https://git.kernel.org/netdev/net-next/c/aef5055e9764
  - [net-next,v43,7/8] eea: introduce ethtool support
    https://git.kernel.org/netdev/net-next/c/5f4f7bc0ed11
  - [net-next,v43,8/8] eea: introduce callback for ndo_get_stats64 and register netdev
    https://git.kernel.org/netdev/net-next/c/4e88fb3234c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


