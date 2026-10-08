Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8289A305695;
	Thu,  8 Oct 2026 23:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791502815; cv=none; b=PWTt3ZPY0Wt6WQI3tnm0zFZ0a9SlqPpIkG4p9g4wC06R0+aXqCHz+KD74IzA3y4Ozy7uL5+lYt0kBfJfMvWmu5d9AaQHpDhkvxzAC8/QNuUCybohYnXDQ4GNUbsAt9Cwycxm5JTXyGA2r63pnFO/xzZ+9O7BWSLl5mkCx6QXGKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791502815; c=relaxed/simple;
	bh=4htzrZaJ/PID1NRHDqE2nzZnYloIrATNFerd+1j2U5Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kQ2bKySta1q+1Z+4oUF/h7PcgT/5CbjmUMx69WzgQOPW+ShV2qyrFIKb0f/3PAG0aqce6KIbpYlDWwLWbO+FMH4fiGiS2YLVv3nfJYdgAxsvxbJDxitEUXoJfadknz10Ad2mF8OWQysJKspzUJRBQ7v+hbSIeHaTWmTAuYaN1Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNMtWPTI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNMtWPTI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDDE1F000FF;
	Thu,  8 Oct 2026 23:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791502814;
	bh=xxXb5XwAcH9S11N19Y66Uia5rWboylK7c85aGLZoJ18=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BNMtWPTIpJ4Q2kEtGwlndZuJrn1U5T4WiNOfcjrsmME+fVel3jH0fHVzKFnj+lBOG
	 kJ7Rl2rupeRb3lLyABYpbGd5d5PCqcOorerUgzlE1vC4hWDyM/fngnnXxkowWBrXpl
	 WqTiNBat+gZR3YNg6x7rWZgzPQISNEDGGJosPnq2EnTvf9V+PgV7uUvISwC+WhikDN
	 7C5Gm9/1Iu7+ruKeaE82XyOcZ3BQhY4Mo/ckkHhCED7VyyLf81K2+4PfPpRXPpibgZ
	 GOh5m507nopzOQtKucj+/yXNubvrVgs/cRJuSzHwC+yt0oXYlXWjZrUiIzY1OLt6lU
	 6xipy/lLKJviA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F151E380AA60;
	Thu,  8 Oct 2026 23:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/5] net: mdio: realtek-rtl9300: add bus
 frequency
 handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179150281262.481494.17430896222307600212.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 23:40:12 +0000
References: <20261005074908.1273383-1-markus.stockhausen@gmx.de>
In-Reply-To: <20261005074908.1273383-1-markus.stockhausen@gmx.de>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Oct 2026 09:49:03 +0200 you wrote:
> The Realtek Otto switch platform consists of four different series
> 
> - RTL838x aka maple   : 28 port 1G Switches
> - RTL839x aka cypress : 52 port 1G Switches
> - RTL930x aka longan  : 28 port 1G/2.5G/10G Switches
> - RTL931x aka mango   : 56 port 1G/2.5G/10G Switches
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/5] dt-bindings: net: realtek,rtl9301-mdio: restrict MDIO buses by family
    https://git.kernel.org/netdev/net-next/c/d5b2fb6761ae
  - [net-next,v5,2/5] dt-bindings: net: realtek,rtl9301-mdio: add clock-frequency
    https://git.kernel.org/netdev/net-next/c/dbaa9e9e05eb
  - [net-next,v5,3/5] net: mdio: realtek-rtl9300: convert "fwnode" left-overs to "of"
    https://git.kernel.org/netdev/net-next/c/d2d69812552b
  - [net-next,v5,4/5] net: mdio: realtek-rtl9300: reject duplicate MDIO bus IDs
    https://git.kernel.org/netdev/net-next/c/808c15994074
  - [net-next,v5,5/5] net: mdio: realtek-rtl9300: support non-default clock frequencies
    https://git.kernel.org/netdev/net-next/c/72356fed7965

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


