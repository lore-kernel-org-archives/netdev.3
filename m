Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E053CA4AF
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779790213; cv=none; b=ZB5rfgSunlMOmmQ+JSVqBThqemLtlx0ElRqfQtxwLdLLoBACV8yhzfmlOKvrAhj19EDuqbV/ItIHJ1tji54iiEBXXSMDz/im68GqtTecipcgz0ab9VRP45e5QkwZv7vYMATprefI4WwtTAyD5/uY43DZb9GOz2V/TGhl31E6MdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779790213; c=relaxed/simple;
	bh=toqSzHyGE5vMlnTOSmxU6ryVsakV5LDNnfvwen6VLZs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hr1XC2DGYKosZQ4UHV3QsagMAxqs4POfCornEsbXkCTYq//1a7LM/+tuf1tyVp9PfoHwXTgyabFwpLI2N7R6D7ktBOtQxl1e+gQr7wx38tyX6u+FodUImG1bNVB96B8PHErDxm7JYW7NbtfGObGwQ8XYmyTPFDGZgPTTAjCwIVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aY5/2mwp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aY5/2mwp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F271F000E9;
	Tue, 26 May 2026 10:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779790212;
	bh=4nXci8guigpxw0FiToG5awnHCsiwyJ13956m3zL0xT4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aY5/2mwpAEo7RnTY4xZKtEPGzbIxgINokL7LnDVjrVZvCkIVRo1S3wIrYr9XcVK05
	 ekFJjFggmKb+bSSq15Gl+WZXUiFqiAA9VFa3wlkBOeHd1QNM0BHmhwpLrqPfdDU/0r
	 2Q56zPOiAcjeQOXNBYFO8NO7SDXAXdhCxrUFBZI8TjeQuz10JN1dU24gJymAYFcsy+
	 eSMgNQGswzGLg4XNBU7LQwCCIhHtzt2mzWuVWZU5dH73PU1vW6Xf0+enW092Rxz3XT
	 JKzRaP4udJY4FLYuyCmPZBMTrBKdqAg5aNO/yZE19NTCCxzQLP9R3al2t8p1EYlY0w
	 +K9KAG5MT5pZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93F19380CED2;
	Tue, 26 May 2026 10:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/9] net: mdio: realtek-rtl9300: Groundwork
 for
 multi SOC support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177979021839.3302983.7872741518824440277.git-patchwork-notify@kernel.org>
Date: Tue, 26 May 2026 10:10:18 +0000
References: <20260521175918.1494797-1-markus.stockhausen@gmx.de>
In-Reply-To: <20260521175918.1494797-1-markus.stockhausen@gmx.de>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
 daniel@makrotopia.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 21 May 2026 19:59:09 +0200 you wrote:
> The Realtek Otto switch platform consist of four different series
> 
> - RTL838x aka maple   : 28 port 1G Switches
> - RTL839x aka cypress : 52 port 1G Switches
> - RTL930x aka longan  : 28 port 1G/2.5G/10G Switches
> - RTL931x aka mango   : 56 port 1G/2.5G/10G Switches
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/9] net: mdio: realtek-rtl9300: enhance documentation & naming
    https://git.kernel.org/netdev/net-next/c/d15c0d1df494
  - [net-next,v2,2/9] net: mdio: realtek-rtl9300: Add device specific info structure
    https://git.kernel.org/netdev/net-next/c/315a02b39e8c
  - [net-next,v2,3/9] net: mdio: realtek-rtl9300: Add ports to info structure
    https://git.kernel.org/netdev/net-next/c/215701873a7e
  - [net-next,v2,4/9] net: mdio: realtek-rtl9300: Add pages to info structure
    https://git.kernel.org/netdev/net-next/c/38c9d5b64404
  - [net-next,v2,5/9] net: mdio: realtek-rtl9300: Add register structure
    https://git.kernel.org/netdev/net-next/c/62baf5f1d80f
  - [net-next,v2,6/9] net: mdio: realtek-rtl9300: Add command/C22 register
    https://git.kernel.org/netdev/net-next/c/8bf7e2b133db
  - [net-next,v2,7/9] net: mdio: realtek-rtl9300: Add I/O register
    https://git.kernel.org/netdev/net-next/c/ffc92cd00914
  - [net-next,v2,8/9] net: mdio: realtek-rtl9300: Add port mask register
    https://git.kernel.org/netdev/net-next/c/cad6a373f7f6
  - [net-next,v2,9/9] net: mdio: realtek-rtl9300: Link I/O functions in info structure
    https://git.kernel.org/netdev/net-next/c/826a1926f084

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


