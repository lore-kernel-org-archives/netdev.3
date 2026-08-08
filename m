Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A47026AC3
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 01:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786152664; cv=none; b=Vqud029KaSY63c1fv8wWolIOD8DcVVGxPV+rY3ybkfdrkjiJhCjk03QYT1/AXCTgAaPMtoHYkJPUWHLnG89bcFq38T4Gy05hqhVIbCx0LcNaMUkuWrYBb0XjCmRp2+MEduOvmQuKwB3bTH469X6Oo5ejbo+XgtYvItBmLHtAPxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786152664; c=relaxed/simple;
	bh=eqCyfMhTZOTBuGgTkkZAQdXt5274cRjG8yS1toRb5Pw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IMVeVvauXKehgR+fJrK+nAPQcM++Mb4roWTkD1xQfeywzwj+hJ8d3aNKR70grHES+JPnunV4oqCw1XjPdW6ztIfEumjb4702hU533z3uWuDk5nss59p94foJoymMp8mSBCYur33a+xO8Ge4Aoxm5PiIjQn3Lr9VXkdKzci3xDoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMP4ed3z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMP4ed3z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F421F000E9;
	Sat,  8 Aug 2026 01:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786152663;
	bh=p5W+QJj60BMWS8iKHoPsWlPBZQyhJSlyiYL1l8MoQnA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gMP4ed3zRoJxcpWUnXFJLDOHTks0DHX/wizeTUnsBzigXYbK9NeJyRbAv29ismtqH
	 bhwABRsetxYdL8QYw6MuNlfLUalhikGRmJ3ekUeYE8lsm3JXwW45VFMR7gSv6CNIjc
	 SYYzxCM3YShvwDxqnt5jEOJeiO8yIP76AAeWyeSdZ/6k5Ro1jEyKjI7mpViya9WOub
	 lWGbxHCPilQrew5Ocqx4BymQ7irVGtJ+TWUE5nXvObARhxTu99jAhUlMembh+epXig
	 hynm04IJ5uLp/dR59UfGAYjlzjB3zZ9+WwCv4aQ/JVAxOt9NnF2H6hAr/hyZQfCICk
	 gq/VQIyEYJ3eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A6F380CEE4;
	Sat,  8 Aug 2026 01:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v14 0/5] net: wangxun: timeout and error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178615262113.2491826.7324118583175627206.git-patchwork-notify@kernel.org>
Date: Sat, 08 Aug 2026 01:30:21 +0000
References: <20260803064334.21876-1-jiawenwu@trustnetic.com>
In-Reply-To: <20260803064334.21876-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, linux@armlinux.org.uk,
 aleksandr.loktionov@intel.com, jacob.e.keller@intel.com, kees@kernel.org,
 leitao@debian.org, larysa.zaremba@intel.com,
 michal.swiatkowski@linux.intel.com, u.kleine-koenig@baylibre.com,
 weirongguang@kylinos.cn, joe@dama.to, zhaochenguang@kylinos.cn,
 fabio.baltieri@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Aug 2026 14:43:29 +0800 you wrote:
> It is about adding the Tx timeout process and pci_error_handlers.
> When a PCIe error occurs, the txgbe device is able to recover on platform
> that support AER interrupt. And for Tx timeout, the txgbe driver can
> recover the device by reset process.
> For ngbe devices, due to the absence of the current function, it cannot
> br fully recovered once there is a PCIe error or Tx timeout. Its
> function will be completed in the future.
> 
> [...]

Here is the summary with links:
  - [net-next,v14,1/5] net: ngbe: implement libwx reset ops
    https://git.kernel.org/netdev/net-next/c/7d942a7bd924
  - [net-next,v14,2/5] net: wangxun: add Tx timeout process
    https://git.kernel.org/netdev/net-next/c/22d95e93c05b
  - [net-next,v14,3/5] net: wangxun: add reinit parameter to wx->do_reset callback
    https://git.kernel.org/netdev/net-next/c/c656a3b75c31
  - [net-next,v14,4/5] net: wangxun: implement soft quiesce for PCIe error recovery
    https://git.kernel.org/netdev/net-next/c/c023e9769de9
  - [net-next,v14,5/5] net: wangxun: add pcie error handler
    https://git.kernel.org/netdev/net-next/c/e73e4d187a1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


