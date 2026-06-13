Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7257B1A4F2F;
	Sat, 13 Jun 2026 00:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310631; cv=none; b=uFuTrbhgyt7tzfDECdqX3TdDdSDQ4jXfJsoJ0Ql0QLL3ewn14bM6ARV0cFz1DuxHIGTbzhihXcq6SW3fzAcS55ZIlpEMf+uHphks9AbSPyK0J+Mdlob4Zm8Q8LsVe/WsEkq8YPBKfxqJNdEyZoW1cZ0lJ4Li3Ki+k0n7722bS80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310631; c=relaxed/simple;
	bh=55Lql7/jlPLf+UXidgPTbRvesAlaiA8wilA730SAx74=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QpTDpNDgIR+6cCY8yWw+d/JozLDr8eT1wTr1nddcIM+bOVCPb5Ylq4hw2Xo0GljUuPPSukdl3vJpwR6TasLrOn1gaU+fDBzk8pSpU2CxzS8vwD+DO1ZswewlnxkUun2iqnXBvqotFPl/yJy0iwxf9vEKEoWXed2c+u2ky4FyFHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J67zc2ZW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J67zc2ZW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3AF1F00A3A;
	Sat, 13 Jun 2026 00:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781310630;
	bh=K+3fFf7xyfRl6bjkfifquQyPuhOlzULkW6RmmH9d4FA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=J67zc2ZWkbCam+xAPE7g9ysCv2oWPy36oCc+ecIXtDJPUMlSwdxeLebw6UIzuIrwj
	 MhztPKOuUGNvpQoCReNJiiXHfEEUa0yVOFeGq9c9XQGyRFOcAJlZa3ew+vgsihga8c
	 c1sH5TJ3l17/gowvvNfix2nxJKM9WYnBGK/TLW1NcuaHc4DhOLxmP9hvZIUkE+i+L2
	 6V/vHdkTGEj4md80ukUsA5i48F0W10FprFpChQ7M9zc1m8ExDu5/m54FaXoQvETwH6
	 MByj65hczstQRXGC8YIPI3eZQdqlGMZf/guChanadI46NkjOd9ZPsQBiym02FhISaM
	 5o31mzWuio+XA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B1639E9607;
	Sat, 13 Jun 2026 00:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/5] net: mdio: realtek-rtl9300: Add RTL931x
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178131062638.1306549.12279863558431672494.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 00:30:26 +0000
References: <20260610194145.4153668-1-markus.stockhausen@gmx.de>
In-Reply-To: <20260610194145.4153668-1-markus.stockhausen@gmx.de>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
 daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jun 2026 21:41:40 +0200 you wrote:
> The Realtek Otto switch platform consists of four different series
> 
> - RTL838x aka maple   : 28 port 1G Switches
> - RTL839x aka cypress : 52 port 1G Switches
> - RTL930x aka longan  : 28 port 1G/2.5G/10G Switches
> - RTL931x aka mango   : 56 port 1G/2.5G/10G Switches
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/5] dt-bindings: net: realtek,rtl9301-mdio: Add RTL931x series
    https://git.kernel.org/netdev/net-next/c/a390863b493e
  - [net-next,v3,2/5] net: mdio: realtek-rtl9300: Add prefix to register field defines
    https://git.kernel.org/netdev/net-next/c/29a540b56e51
  - [net-next,v3,3/5] net: mdio: realtek-rtl9300: Make otto_emdio_read_cmd() generic
    https://git.kernel.org/netdev/net-next/c/6e1d8b024de7
  - [net-next,v3,4/5] net: mdio: realtek-rtl9300: Add registers for high port count models
    https://git.kernel.org/netdev/net-next/c/3e8035b861c2
  - [net-next,v3,5/5] net: mdio: realtek-rtl9300: Add support for RTL931x
    https://git.kernel.org/netdev/net-next/c/5ebdcac59aff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


