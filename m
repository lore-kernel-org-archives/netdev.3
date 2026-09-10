Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217933603E9;
	Thu, 10 Sep 2026 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030274; cv=none; b=Mlj0kIstXBGYwDZzWmXLsiBvL8rBleXSWaBcuvNI9uL6zBfyTlNl18DDqSxH4tiOLyDByng+kd3vDzeSlkonTGoSpZq1+KUSMLJhFFhfBVolxN4calqmFh+MRGUs47rp9HKHHV1+v4XId22daip5iymzuA4vlQ7ltYPo57doyXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030274; c=relaxed/simple;
	bh=TQ7dfFZmLduK3B5RsOPj1VT0mdroiV8QjlBc0B3jk8E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kOiQBy3YUkQFjaPyu5rMR5P9ZcpYS79t9SRMP/CbQUp/VRr0KIVkiROaJKPMfdQOCPzGAmH+6RZbIsTJIqcS1FaXJBCHZk5l1L1QHS2nmaD82QHoDZ/kFZlitV6ry4ABO2QkE1NqkMC6S8okOIYflRzUmrVY9lWM3YHeJXGnHfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E911ouiR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E911ouiR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA5C1F000FF;
	Thu, 10 Sep 2026 08:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789030267;
	bh=rrkfOSxLddbUOfL7Xbg9jSW10/8qwrLgWoRjxVeerfg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=E911ouiRnshT0fokrv1wwThNADwZuO2rPqVJ1hyoIxweNQqRAZhFdHEnCV/Tlzgmx
	 /sQi3zDFo2Lf36ml3fujjZITB+9yXQZgV3xPJFiFfwSnIxw0k0P5mVRd36A+zQifsj
	 Z+k2IO26sE5BW3MDxkX1tfKqScUkQzMf15J+3Rb9VytLDDnrUSN1eFiXuiiOlVyB0/
	 g6GdW833z3eLuK/jqHSQqyQnmtC54vxJ0YS23I9CEYgwpJBfhTUNIbRoTXuKL+M9rM
	 dLuPeTjjaM4DVV3hsY6lCypzQVn+si3xmNGjWD7reOW4i45CbDjt8uHKuGk8uwhNB7
	 KTzJx+GgUBytA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569A0380CEDF;
	Thu, 10 Sep 2026 08:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] net: stmmac: Add common RGMII delay
 handling and DP1000 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178903020504.1290091.17816102096772468224.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 08:50:05 +0000
References: <20260907-dwmac-ultrarisc-v2-0-9a39bf8db313@ultrarisc.com>
In-Reply-To: <20260907-dwmac-ultrarisc-v2-0-9a39bf8db313@ultrarisc.com>
To: Jia Wang <wangjia@ultrarisc.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 peppe.cavallaro@st.com, joabreu@synopsys.com, chen.wang@linux.dev,
 inochiama@gmail.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, sophgo@lists.linux.dev,
 conor.dooley@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 07 Sep 2026 15:46:49 +0800 you wrote:
> The UltraRISC DP1000 integrates a Synopsys DesignWare GMAC from the 5.20
> series with fixed internal delays on both TX and RX RGMII clock paths.
> 
> For boards without PCB delays, "rgmii-id" describes the link. Passing this
> mode unchanged to the PHY would enable another pair of delays and break
> RGMII timing.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] net: stmmac: Add common internal RGMII delay handling
    https://git.kernel.org/netdev/net-next/c/cc54f9667188
  - [net-next,v2,2/5] net: stmmac: sophgo: Use common RGMII delay handling
    https://git.kernel.org/netdev/net-next/c/7d1cbb9ba933
  - [net-next,v2,3/5] net: stmmac: eic7700: Use common RGMII delay handling
    https://git.kernel.org/netdev/net-next/c/345d78e30980
  - [net-next,v2,4/5] dt-bindings: net: Add UltraRISC DP1000 GMAC
    https://git.kernel.org/netdev/net-next/c/8dbfb46c233a
  - [net-next,v2,5/5] net: stmmac: Add UltraRISC DP1000 GMAC support
    https://git.kernel.org/netdev/net-next/c/c6ff098cb63a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


