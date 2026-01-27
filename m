Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEED30AAC9;
	Tue, 27 Jan 2026 03:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769485222; cv=none; b=YO0w5AWFHhcf+/GVpoh8f4l9ZM35mLIb16gLJOdFUVaz9xEpKhQvNQ9vS1iEw8QDH7Cx8ntpbCh0CTxc616fY2aDx1XrWc+jPwGR2H++9/feH3HNMKJOe0qbdGvH7Bz/7m/GEH+ivGKBUbhnd+NCLEJ8JCp9WrLnIn1MrPUT+5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769485222; c=relaxed/simple;
	bh=IR+yotQzvPiox9qPcf4J+ItsBUx50Bmv0BKxWqGEcrI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NTkeujTRNSXrvnOzegiJh0CKIJ1B0fZqtpr0DNvxX9J3m7NHjdmoyqTi99ZTv+TBHDYf0UDwcJk7DvjcUhB53Gkhp+D3L6t4/BJHbPONzGAHOkjnWY4NAvU0JAro6NQLjwA0hNwjdZV/yrpk/FzmKB7k+dZcke9WExe6L+QR1UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEoi3Mmx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEoi3Mmx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54EDEC19425;
	Tue, 27 Jan 2026 03:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769485222;
	bh=IR+yotQzvPiox9qPcf4J+ItsBUx50Bmv0BKxWqGEcrI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EEoi3MmxSaPrwWte96c57ys1BKCgYwq0WnV+2Bei0rvJWKY0tmiHyUEraVjbw1V9P
	 DRz12cihN0QEdGVSAtgpEIjRX3k9DJmkcFJO+JrdmdvODKSkuzqqwtuuHhKgx6smkc
	 HlNu6GU2RPl7S7RVIFOTLCR8/YfQ8bljMXrFzFQ44KhvgGlu5qbVW9EQjfof7Xg6rc
	 uLL5hSb9r5cmfUOWFiABO1jShdBH+0ckEjRxaL5A9lImH/zDxmkGOHkTeW51EJWF3r
	 bzIKeMv5lk5ReHbOZvGaDcu/kD5bVdaoDOdIo+M1g29s15Zie/UDmpgsdXiMRB06lc
	 VnT+5GaOKwkdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8D9E380A961;
	Tue, 27 Jan 2026 03:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: usb: smsc95xx: use phy_do_ioctl_running
 function
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176948521660.672496.7653187492992183401.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 03:40:16 +0000
References: <20260124080751.78488-1-enelsonmoore@gmail.com>
In-Reply-To: <20260124080751.78488-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 steve.glendinning@shawell.net, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 24 Jan 2026 00:07:51 -0800 you wrote:
> The smsc95xx_ioctl function behaves identically to the
> phy_do_ioctl_running function. Remove it and use the
> phy_do_ioctl_running function directly instead.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  drivers/net/usb/smsc95xx.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)

Here is the summary with links:
  - [net-next] net: usb: smsc95xx: use phy_do_ioctl_running function
    https://git.kernel.org/netdev/net-next/c/2dd698f68e3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


