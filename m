Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792629018;
	b=trjLr/assD/ZQSEDZOuY+VO6PItdejObp7D4sUfGENB72QVu1mz3HsIg3BIXh9s19pzt
	 Cl1yyE8+sonbIQ0ImM/t+oqxSJdR+a5KtcEtI5Y2bqEhyrQS3bSG+Z7KQ9S1o2Vw8km65
	 ZisNJNceVp3aj+Nh1bGLxp/d4RB5KzIb5UEk5jWiW9GR+KE6fl+b8G55ASC5kswhkI0uU
	 9pF5s4s6AF3opbDtyhSKg89I69AyeVzPopCDVWBx3GhFkum731BFS1utMnc1GJOk3TuGr
	 go2KGKB7TEn8JKCLv195uuHxFGpXVvfKw4s+tdVz97vclLArguwX76lNrI/G6mMgMXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792629018;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=bAiMTnVAiAf3Kz4ElubQPcKVGYEkRh7RA+Bbz6fnqOw=;
	b=lvCOJp3901rsvleJhVXSMzuoRY5GxOaqjCIUOvS70WAxEFPRz1xLRu1RzrV7aNYakuHK
	 O+jmaKyYit8EcgszumNGJr4+xc5WTawgrYbi5iiXx+TxzHGrgGrYBZ6Q20OnMLl9pCGjk
	 CkEAQVBWoTP5hyaNrYncItSFY5zA8aN7rtf4jdQaPqfeUXZetIPRPv44XbAQ2aB0UJfwV
	 IQ/IoR/jjQVg0uxavJHaov3/aTbVmSI7sgBtD8OuSkEseR1eM/gRvRZ3NgwsjDfobJbsh
	 5IL2l5EarCkkrMDq1vg0kB4qZoR1q9sJ8wLIhcUsfxIz5ZyXK9HFLGo/6RI8pG1eJ4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bGPo3AUx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CC2606A333;
	Thu, 22 Oct 2026 00:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bGPo3AUx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BC81F000C9;
	Thu, 22 Oct 2026 00:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792629018;
	bh=bAiMTnVAiAf3Kz4ElubQPcKVGYEkRh7RA+Bbz6fnqOw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bGPo3AUxBAHqjOjMengyLm8bEJrfbRD21LkofqwB/zJj/ZHUELhewWgVJ32IGs3tw
	 aoxPupmqQqzCDdi9KvQI8CsqPaiIpmqD1B0g1zjhZuNN2caAiulRIhNkzF/tJafxaP
	 Yuw7bPr/5WIly479xpYyMctgROuxN9GHYlWCFlQZGodKohFD7htbRpl276Q/pnZaf7
	 1mMIbugmGyndG031WS86p4fM65vaqOX59XmnjxVeeZL0UsTZYrMhJSOFuGBvY1z563
	 vGbZHInw6iV4pjjTGoZakFfFjpmS9jfEQi4n3giyQWYm1KdbCUp3eHyO1+1KhM+zLG
	 JDjudorVamj9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A1C4380A963;
	Thu, 22 Oct 2026 00:30:18 +0000 (UTC)
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
Subject: Re: [PATCH net] net: hibmcge: set netdev_ops before hbg_init() to fix
 NULL pointer dereference
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179262901677.1378903.766655502279729876.git-patchwork-notify@kernel.org>
Date: Thu, 22 Oct 2026 00:30:16 +0000
References: <20261016110421.2288670-1-shaojijie@huawei.com>
In-Reply-To: <20261016110421.2288670-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
 liuyonglong@huawei.com, chenhao418@huawei.com, yangshuaisong@h-partners.com,
 ningwei15@huawei.com, shiyongbang@huawei.com, fengzheng6@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Oct 2026 19:04:21 +0800 you wrote:
> The driver assigns netdev_ops after hbg_init(), but hbg_init() calls
> hbg_mdio_init() -> hbg_phy_connect() -> phy_connect_direct() ->
> phy_attach_direct() -> phy_link_topo_add_phy(), which invokes
> netdev_need_ops_lock(). With CONFIG_NET_SHAPER enabled, this function
> dereferences dev->netdev_ops->net_shaper_ops. Since netdev_ops is still
> NULL at this point, a NULL pointer dereference occurs.
> 
> [...]

Here is the summary with links:
  - [net] net: hibmcge: set netdev_ops before hbg_init() to fix NULL pointer dereference
    https://git.kernel.org/netdev/net/c/9b8ae9aaa1b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


