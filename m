Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4844AF17C;
	Thu, 24 Sep 2026 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269881; cv=none; b=UK0qbNA6rzzlc/O+8RM8m8ylvc0samr5RqKtcs9La+U6GCYgsR28SGneB5hssWYeW5iKoU+iSYOs3UbaU6JwkuImhJUw4g1Q2+KVCWuhJldnlImTVJ3vkEwJLctdUaCEZKxryJMsEveCaB6fvUTLutthL3ugQR3XiZ5qsZ+7tTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269881; c=relaxed/simple;
	bh=8eVDPGbjmxuLxsVurGwaVx1bhFCgBXrxfOOz3c9XzZY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W1UO2J3ka3frNGuXwTf89P3LPFwaLP2Ad7AB1EoBm8h865SwzRpmkaYIeYI2E96R0hANqhIcxr0jdOtueuNLk4VqvBxq/LJLvFp0tl3f8RKOPSJXGtNE5aN6faDb8BUOT0ntXHXWMzJVyDv/YdC9di0LyQSRc1IdiTeo8pIImVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWQ0noia; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWQ0noia"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691A71F0089B;
	Thu, 24 Sep 2026 17:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269880;
	bh=8+vfo13QOebvRLT6jUfgH8h0tQsUj84ffg1IEMcd2qQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MWQ0noiaqREzwNDsjOtOMTMqxYn6yWzbo4sgoUEfV9hpg8aPrfv7tOx5YGESR+IAN
	 E/vvaPkoSEVVmA8Br6/vjPyXB3fwh6E3Zsy3wxVV2Ywe4D69k0P7l2+As9+NnWbPKT
	 7ZfBc8fiWYMVtY9yfAdxr9wqfLWZejZQisH+pgHuGlZIq/GafJTkbgfm2/yZyDIT9y
	 5gFF4eK7p+oU29ix8NLDM1Wtueb2J/BdD1ECoxCbMma0mGKZguREasb8pu9TgV79rP
	 /tbqh7N5okwXjALJ4UbYu3S3Q8WN9VW8yXgfuEsWNOniDB9DUGtcVokatEbF3btRk8
	 U2hhBu1nmQEYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A0E3A566D8;
	Thu, 24 Sep 2026 17:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] net: ena: fix resource cleanup on probe failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179026980914.1660211.16967446500117783389.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 17:10:09 +0000
References: <20260921154202.471662-1-lgs201920130244@gmail.com>
In-Reply-To: <20260921154202.471662-1-lgs201920130244@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: akiyano@amazon.com, darinzon@amazon.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ioana.ciornei@nxp.com, ekffu200098@gmail.com, dawei.feng@seu.edu.cn,
 amitbern@amazon.com, netanel@annapurnalabs.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Sep 2026 23:42:00 +0800 you wrote:
> This series fixes two resource leaks in the ena_probe() error path after
> ena_device_init() has successfully initialized device resources.
> 
> Patch 1 adds the missing PHC cleanup.
> Patch 2 adds the missing MMIO read request cleanup.
> 
> v2:
>   - Resend the PHC and MMIO cleanup fixes as a two-patch series, as
>     requested by Arthur Kiyanovski.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] net: ena: fix PHC cleanup on probe failure
    https://git.kernel.org/netdev/net/c/0958ea4355e2
  - [v2,2/2] net: ena: fix MMIO read buffer leak on probe failure
    https://git.kernel.org/netdev/net/c/9476b4468862

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


