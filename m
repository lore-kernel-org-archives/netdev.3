Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C656C3750CA;
	Thu, 11 Jun 2026 22:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781215811; cv=none; b=Yn2ro4tJxLiUhKhP6RxQXhksmw/WKF72GJXEDT3vyX3UXttD5lHfjywwbJ4ANKO+iEephV94ePtjPlSXUtRu8LDo1C6GmfNveuC3v0fj0DpCDrrHEPHNzFEKDQfnB6xRAlcriMVc/Z9aT1uAo9pU8Tzer55PnU43uhYAVxwbFRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781215811; c=relaxed/simple;
	bh=o5jItAJcIaHmIf3DqJBevsH95Nzgxf2jcgTqWkCMNo0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HavLs3QeUWLdlk7rDSgN5ufOsMLw3fpxnZHE0KLF79ZWFi9Dp3ieltiM1og7UKjMoEw55y/fvFmziTbf3wEImTUnN1omEpH05TbpmXNpLGewzGmQ7kD5SYv/ug5o4AmrHVflCkUeV2NAdO0Iul9HJ3dJw11LyEAfNtpuNVuMMGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWRjSyTj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWRjSyTj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8FC1F000E9;
	Thu, 11 Jun 2026 22:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781215808;
	bh=WKV4caxo9laTzKngvavBKIZfdPi/VjaqX66Lf1iIXXw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hWRjSyTjqHq1kdPH9NDk6i8wHkR8rOW8cKFP+cTfLcVdZlt/nzt5ca0ULHAUbDJc0
	 BRAfvjv611SEKIrHWfBaDzMxB2gkuQM/xmwheBYmPxyipvhnU8vZoAbT/AP2mz3kzl
	 uhSsPRDRLT7XefKhEuekdvf0aBxJlumAJK5KVyeKysN4wwMxHF8FwXA9pgY68Ep31m
	 sGlUQYjgo2lX5EoKOTPkxkUKIIrBtzfp2jNdpEYOzJs3ZVYwuryPZmaal7SgWzYGEq
	 RYDJ1524qmXfBPXDhGgE5/9OS8baJLhexpUOfEDSKLhnyQtqquEdVNrfSKMuzDnDxc
	 ADe39F8LJlgqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939DB3930FAD;
	Thu, 11 Jun 2026 22:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: dsa: qca8k: fix led devicename when using
 external
 mdio bus
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121580514.383948.11834573355322337930.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 22:10:05 +0000
References: <20260608-qca8k-leds-fix-v3-1-a915bb2f37ae@outlook.com>
In-Reply-To: <20260608-qca8k-leds-fix-v3-1-a915bb2f37ae@outlook.com>
To: George Moussalem <george.moussalem@outlook.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ansuelsmth@gmail.com, f.fainelli@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 08 Jun 2026 11:22:08 +0400 you wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> The qca8k dsa switch can use either an external or internal mdio bus.
> This depends on whether the mdio node is defined under the switch node
> itself. Upon registering the internal mdio bus, the internal_mdio_bus
> of the dsa switch is assigned to this bus. When an external mdio bus is
> used, the driver still uses the internal_mdio_bus id which is used to
> create the device names of the leds.
> This leads to the leds being prefixed with '(efault)' as the
> internal_mii_bus is null. So let's fix this by adding a null check and
> use the devicename of the external bus instead when an external bus is
> configured.
> 
> [...]

Here is the summary with links:
  - [v3] net: dsa: qca8k: fix led devicename when using external mdio bus
    https://git.kernel.org/netdev/net/c/0b7b378ce6ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


