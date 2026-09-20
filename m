Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233057E792;
	Sun, 20 Sep 2026 00:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789863691; cv=none; b=EsCN0lEXjn93mj/O/yS9fpNtKGV1AcDnU/xh/6xl2wKiCtKLtvwoMzI/NkKu86DE6RyFS9dZnQBcWh0/UDJGBkZJwWY5Rd5Mn41fCi+tJrXeRAE3j7/jfXkqwcXE1ijDKiFpM0dc/ZeCNlomYPv8StAnRxP0AC5joE2sM38Ayas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789863691; c=relaxed/simple;
	bh=kGFseRasWwbB6iOmMj53vQNJaQDHiXBFSzx/xT1oZ4Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IpvLc+t+SAJdT919KTnpOhg+Vdt64fMjcGf3jTN5nGLMvxHME49gMNVjlaCEU74oSh/GvgSlqrdhIPAY76bbKndn/jEgMdCsqKXbRwVsVOwj306Vz5GYOatZ6Jq0lAqdnvkSyJyKnN31an2OeztXHJ9iZEDbqK3ViKx2VtDRyS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEQCh21k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEQCh21k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E5B1F000FF;
	Sun, 20 Sep 2026 00:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789863689;
	bh=9Ee1bfiF8bYqUs6qv8VGWdrbY4WyGsvYZkgPd3sFY+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WEQCh21kCdzVFhj/juXE1CNDaiytbOl3ibLx9VA/S+myvfJ5YowHLuRDhQw9x7x7R
	 9qQEzt7bDFgHk6f/IwpCyDehHXgz6zyhIQqWU7uCQ4RmyhD9syYnkKNzvaA0THwcYg
	 evSU4VhvvwhIGLd5GbV/i8in+rTBsodc7DdmIfIvdBxxZefJCcA7N7pGjJHkX0suvj
	 xRk6bZGEotuyigYD7TI0G8zOvklN0nH0UPqyVqquzVErRb7jPuK54Gw2lPjHM/cX06
	 JRUtmEbe/idPvTQlt7i/wqMsQJoXR+GJzC2hROLqE/EPC3Xe0zZ/DVcq+pNgS/JgDN
	 lshDhr7vnGaBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56F863924A47;
	Sun, 20 Sep 2026 00:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 0/3] add support for phy chip and firmware
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178986362215.1500872.6234896093992126433.git-patchwork-notify@kernel.org>
Date: Sun, 20 Sep 2026 00:20:22 +0000
References: <20260916081444.497-1-javen_xu@realsil.com.cn>
In-Reply-To: <20260916081444.497-1-javen_xu@realsil.com.cn>
To: javen <javen_xu@realsil.com.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 freddy_gu@realsil.com.cn, nb@tipi-net.de, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, daniel@makrotopia.org,
 vladimir.oltean@nxp.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 16:14:41 +0800 you wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This series patch add support forRTL8261CE_CG and RTL8261D_VM, and add
> firmware support for RTL8261D.
> 
> Javen Xu (3):
>   net: phy: realtek: add support for RTL8261CE_CG
>   net: phy: realtek: add firmware for RTL8261D
>   net: phy: realtek: add support for RTL8261D_VM
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/3] net: phy: realtek: add support for RTL8261CE_CG
    https://git.kernel.org/netdev/net-next/c/ca44c21fc117
  - [net-next,v1,2/3] net: phy: realtek: add firmware for RTL8261D
    https://git.kernel.org/netdev/net-next/c/c1edd457d216
  - [net-next,v1,3/3] net: phy: realtek: add support for RTL8261D_VM
    https://git.kernel.org/netdev/net-next/c/5a13a6152fd0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


