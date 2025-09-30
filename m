Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187052F8BF3
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 11:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759231816; cv=none; b=cNnj6FH58s+aR3B8ON4VCwZiuyTLwOpYz2eZb6XXXpuS3koF8ikLrM94uEf2b4l+dhOvONnEXzQL+s635FKV2so6foC3aZXHEjk5jgpxOmUsnYGN45CU7ezBPnCkMEfTSZy6eubMODEbNxcQVUKHEQpub7652i6Dobt/zKv7b8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759231816; c=relaxed/simple;
	bh=MOL7pxFYiz9w95I2/71DIHzfRoZnwwoaBPRu9WOb0bI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LyJQyNrEu3bTUkhSswgcl8XewSHCven85L7Vwwez0a/7Ue+LCKUsu3U3ERAZZjkawIqookzdDxEa22Oft4c8EjnyYktheCV6GBARWGrVFxvKIxkS6qXGFqLQqPJcQkZ2ZZfnpi/UXxXg7k9/ZydC2H8HzhgN9+BAlsFc7ipBuJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLpnGKRr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLpnGKRr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A556AC4CEF0;
	Tue, 30 Sep 2025 11:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759231815;
	bh=MOL7pxFYiz9w95I2/71DIHzfRoZnwwoaBPRu9WOb0bI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bLpnGKRrJSlD2Lu+rMcjLo/KERfpecTf6LPremjnZkgWv4Lv3314thLN99r2uznuH
	 +CGt0Pcnihkl4kVy1Oe+MV3GwzgHxbpIDVoSLUEM9ZyTV2X274g3jp4LJMCxbizWBJ
	 wpFRLVO7JHXJLQaVi0rJOrCb8Nv9Tuade7F25b/cJquM41JHblIwu1IxG3w7FQCdZo
	 H6m2j8GIsKgbHlCbdv4KSc7R+UEBeErhLpEN/EtJnpNGjJm/1yQYs46MFq3Lj6YBbH
	 YV3sSNdfI1k4e58KokHD9Ganu6i+pH+uoGF8rpzoCaj9iA3ULwg6GL62wvhwRjiYJr
	 mOCWXhfFrejzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1244839D0C1A;
	Tue, 30 Sep 2025 11:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: stop exporting phy_driver_unregister
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175923180874.1951629.15363973844289169041.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 11:30:08 +0000
References: <2bab950e-4b70-4030-b997-03f48379586f@gmail.com>
In-Reply-To: <2bab950e-4b70-4030-b997-03f48379586f@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, linux@armlinux.org.uk,
 pabeni@redhat.com, edumazet@google.com, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 27 Sep 2025 21:52:30 +0200 you wrote:
> After 42e2a9e11a1d ("net: phy: dp83640: improve phydev and driver
> removal handling") we can stop exporting also phy_driver_unregister().
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/phy/phy_device.c | 11 +++++------
>  include/linux/phy.h          |  1 -
>  2 files changed, 5 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [net-next] net: phy: stop exporting phy_driver_unregister
    https://git.kernel.org/netdev/net-next/c/e211c463b748

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


