Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AED238C1F;
	Thu, 19 Mar 2026 00:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773881077; cv=none; b=pAo08Nn2WWK9TbT0An5+Nz3T03tdsB5mHjnHsk5Y/1hdQV4kgKuAyXPagImJK9Lbb5ePguVYKC7puH9sRPq8HJdpqf8ZPeuT+9ZN8fTIJsc6fZLXeSK+Z694vSlN1ckPVTecT41yThU9LkMcOraJCWovbVuSU/4xjX+1mxwhaa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773881077; c=relaxed/simple;
	bh=GzYi/jrtTlNMK+iHdYJOu1dfREM0Aom7yQwJfnjWg4Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vEkvUTR2fIZOChbGx0OnEyVWHH91WscSyBpFR0SLf3JNSG8AHW0CBO03COGGkuKSZvBeOHy6sxc/fcBcBJaUnjKVXirU3w1gOrx1/iOlYTI/RdbKaplpeNz2ZkMQHQgSe+MgOAfSA4zIMJgrWyooj3w0iHUAex8Fkkr8ReH9fas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZdA4du1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZdA4du1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D50CC19421;
	Thu, 19 Mar 2026 00:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773881077;
	bh=GzYi/jrtTlNMK+iHdYJOu1dfREM0Aom7yQwJfnjWg4Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GZdA4du1hSwVH6gEngWuvUXJLLxvgHfzJoj7LOqqcxRehRV8Oxm75U69uiQPTl5l4
	 lmomRsONz8dRTJ/ri+g+7b06krdM5DntAS9ks7SBRKpB4XX1lhFm54t3l8RkT0dN4A
	 W7viOxlXlUYIJ2BH31tfR6dzQNlLSSfpF9o4KHZQoiYmHnbVDrR/AMHBU3UyCNi+iO
	 95Hl43J3+O8z16eadzrF0wpKSklZqyEak31jqtF9OwImDt3Wd+xtrpNKySJkC24NKm
	 ohkCl7/fwogmRAQR2n/DmK+XC+qIrAQlXsaNoLanyWUIRw6ojFxUAlMPwiGJJMa3im
	 1Hv27hVqUokbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FA53808200;
	Thu, 19 Mar 2026 00:44:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] dt-bindings: net: micrel: Fix KSZ8041RNLI
 dtbs_check
 warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177388106828.935482.9940657343984545762.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 00:44:28 +0000
References: <cover.1773734298.git.geert+renesas@glider.be>
In-Reply-To: <cover.1773734298.git.geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: eichest@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Mar 2026 09:02:44 +0100 you wrote:
> Hi all,
> 
> "make dtbs_check" reports several warnings due to some KSZ8041RNLI PHY
> nodes having the "micrel,led-mode" property, while the DT bindings
> prohibit this.
> 
> Apparently the DT bindings are incorrect, so this patch series fixes
> that, after a customary cleanup.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] dt-bindings: net: micrel: Sort lists
    https://git.kernel.org/netdev/net-next/c/46906242fe61
  - [v2,2/2] dt-bindings: net: micrel: KSZ8041RNLI supports LED mode
    https://git.kernel.org/netdev/net-next/c/22214fb2fad0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


