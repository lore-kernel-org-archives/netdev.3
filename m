Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0033CB91E;
	Tue, 15 Sep 2026 01:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437074; cv=none; b=ARzC3pE1ltNc6YUtzvQmvn/RdGm/cCFT8XPpkZ3TEpoDd/G7U0K8LkSISrbBuwW6/E05kfoT4JRMm9szt6bz66HvcQTn/Pwzsq3L0Bbqlg3aOkDJ8NjTZMqPMyG3SxDctg4mTyaujirgwa/SVij/v2/QTe8IjMys6JNRNklKgXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437074; c=relaxed/simple;
	bh=7rxEA6VsQyiUnTEZID31MTBLkgBvaJuw7FXnJeHREpU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kLN4BqEBf7I/2ge/UTv2p+/v53vwDheXBHsy6hOPzpB2wepK2oSsew1/ie7LO7dy+KcwCsMeu9dO0EUcoJcrRKTFDO+7z7eoiZ6b+RVuX6OOWJKtyUFnbpXQfe703a+FBo6eHz0U6Cgua5k3nYxpJ+lHk0Zwom93DB6d1PkXtN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBBkg2tf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBBkg2tf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6B71F000FF;
	Tue, 15 Sep 2026 01:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437073;
	bh=Mmo4xac/+LrEZqKT9mRhqDm+hzUlhFJcX3h8aVdbZ4s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iBBkg2tfSH2TOeuS7tCB+46YtySEf9xP9bNsp0OMrCDxhuR1erq+760wPyoUk+mgf
	 B7+l+7yBgIrVvrUHIrRMTgiE0V2eB+HeG3oOSeHoy4IQbF9M15BlXU+x5cO3LwjQZn
	 K0JpcF5HjJAU9LgA0xQt8Y+wrti6E5ytOf8OseeVfzkz0O0agXXeJlb3Fn2NK0P1yd
	 aJSRpLymY7+cKwsliS/ueewwJF1lJDWLobmcB4xwFiV/Nsa9PQIfxNXP5q6gyZEU9g
	 NCcUmAeIBc9QXcdlVXwtjnyQK30w4APTOMQnpRgULuetyfRtDIH0TKE06ggepxrHZm
	 DDp6lsx4iXoIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0F753924FFE;
	Tue, 15 Sep 2026 01:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v11 0/2] net: phy: add X-Powers AC200/AC300 EPHY
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178943700837.1306524.13969208982154394192.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 01:50:08 +0000
References: <20260909-submit-acx00-of-dynamic-v1-v11-0-eb45e89ef918@gmail.com>
In-Reply-To: 
 <20260909-submit-acx00-of-dynamic-v1-v11-0-eb45e89ef918@gmail.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, arnd@arndb.de, jedrzej.jagielski@intel.com,
 andre.przywara@arm.com, wens@kernel.org, jernej.skrabec@gmail.com,
 maxime.chevallier@bootlin.com, linux-sunxi@lists.linux.dev,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, krzysztof.kozlowski@oss.qualcomm.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 09 Sep 2026 18:15:36 -0600 you wrote:
> This submission contains only the networking binding and PHY driver and
> is intended for net-next. The AC200 I2C register provider was submitted
> separately for the MFD tree:
> 
>   https://patch.msgid.link/20260907-submit-ac200-mfd-v11-0-58dd9dc7f69a@gmail.com
> 
> The two series can build and be merged independently. AC300 needs only the
> networking series. The AC200 runtime path additionally needs the separately
> submitted MFD provider and binding. Their shared design point is the DT
> representation: the MDIO PHY-package node references the AC200 I2C node for
> access to package-control registers.
> 
> [...]

Here is the summary with links:
  - [net-next,v11,1/2] dt-bindings: net: x-powers: add AC200/AC300 EPHY packages
    https://git.kernel.org/netdev/net-next/c/783f6f1fdcd5
  - [net-next,v11,2/2] net: phy: add X-Powers AC200/AC300 EPHY driver
    https://git.kernel.org/netdev/net-next/c/6cc2fbceb49b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


