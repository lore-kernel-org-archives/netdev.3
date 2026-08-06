Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576CE3AA4FA;
	Thu,  6 Aug 2026 01:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785979262; cv=none; b=mtRfibQac+kuQ/5Ww+wYTawp5+OimEW4HKLvlnb7YlfZectzUWQuJyscRABa+PckmCcyYwakH2OK1ehXC3JZQdtorNl93xJ0NNuKbC/xLFV1msFADAt9IOTuD1nA+u7u/u9Uk3sitN6PZBpaP8zrMebJyizn6J8lH5fvts09nho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785979262; c=relaxed/simple;
	bh=YPFlRkUjM7Z9gVyCdp9VZF5SDWMEoptmeATsjQmQeGo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T9rSyyVg3a+wAY0CejQd6yzez5uwL+kTdmO3kQm7xCx4kgo4McrYmyR7BNIxAscM+Ejp1njwB9YdVucSvPRlf5CDyrEqiec5j8KdZEcSbQLHXJJPmSXAxRGIMVl/Ww8ehyrYXWCj35caf40hvqNK/RUKloXF7D8bqwBEDg+BHy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbly2vqf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbly2vqf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB42A1F00A3A;
	Thu,  6 Aug 2026 01:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785979261;
	bh=3fxGL6riYetsJkvSTv/2CuF78hbEv/cEtHlqHYVry5Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dbly2vqfuWGVlTbj4USEE8wVTz0FoS8BQlgZNC10EShvODsTEz2p/4/rsmV5oua1c
	 7L5xMl27F0EheFM7iSKUbU+o+SHXD2Lv2Yxh6rJ0aSW0sN3y3KLYQpSs6d3KqEnrkh
	 GjiTN6+lnWkUfk4dW8hkYnqriGr8DXdyzSZIEwOXsIHF4W3LUfaBxaczBAx3cKiNHU
	 yMUt1sI+Ldccnai2BihfHHmybxaHoS1mvRcAbsGDJ9wz6oQghjAg++BUZGMNxYQMsN
	 zEDWkLwtAA4Huj8voTESkxEPjrV9EuWWcQjhnBMyo0g6tIB1E2B4g6O0RL+WocyZyj
	 l+dQBZXmSb0yQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09FB392FFF2;
	Thu,  6 Aug 2026 01:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: cdc_ether: add quirk for AMI BMC stale link
 events
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178597922038.593652.1432741241165291582.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 01:20:20 +0000
References: <20260730051341.24930-1-guojinhui.liam@bytedance.com>
In-Reply-To: <20260730051341.24930-1-guojinhui.liam@bytedance.com>
To: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: oliver@neukum.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Jul 2026 13:13:41 +0800 you wrote:
> On AMD Genoa/Turin platforms the BMC-provided USB-Ethernet gadget
> (American Megatrends, VID 0x046b PID 0xffb0) intermittently fails to
> respond to ARP after AC cold boot.  usbmon captures a stale
> NETWORK_CONNECTION(off) immediately followed by
> NETWORK_CONNECTION(on) on the interrupt endpoint (~130us apart)
> after enumeration.  Because alloc_netdev() leaves
> __LINK_STATE_NOCARRIER cleared, netif_carrier_ok() returns true
> when the spurious OFF arrives, so usbnet_cdc_status() cannot
> recognise it as redundant and schedules EVENT_LINK_CHANGE.
> __handle_link_change() then calls unlink_urbs(), killing ~60 rx
> URBs whose payload has already been DMA'd into memory — xHCI trace
> confirms them completing as -ECONNRESET with non-zero residual
> length.  rx_complete() drops these unconditionally.  The following
> ON restores the carrier and re-submits URBs, but the ARP reply is
> already lost; the interface looks "up but silent" until ifdown/ifup.
> 
> [...]

Here is the summary with links:
  - net: usb: cdc_ether: add quirk for AMI BMC stale link events
    https://git.kernel.org/netdev/net-next/c/089ca284afb0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


