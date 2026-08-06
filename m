Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD51DF76;
	Thu,  6 Aug 2026 02:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785982847; cv=none; b=g/yhMSzEljnb9ETsxul1oUgIc18ZwLCO/QVXHoJWcY71y9Azpk/go+pQX2HiHGfI7fHn9xbk66KDpuxWi3l7oF9dxndzWNInuAdJAF/LATnEb6a0Rr0pS5KxRzD4sPkdxIPh6O+8xPeDqEcfwoaeJ4lqefKs/NCaXkUduaTZlPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785982847; c=relaxed/simple;
	bh=Db7le1/FY7MpvuuEgqgUXiPVfzH/SK77Zot6SCwEvVw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KbC/TDr9ejc/9JRrvvCbJVDGjGdnBSECYjXlbKEwN0auv6aMz6sszX1MLrV8OmP/AiysUJ2Z7QklVClKn4zRgDqStQUyz6nAtEs+NX30tA3OGv8tV1njM3p9p7I8CqEbQ1gVYi9kLeRv+ubaspqsnvlEJlZt7kmaditWui5iQxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPFFO2mk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPFFO2mk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4811F000E9;
	Thu,  6 Aug 2026 02:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785982846;
	bh=TydB11UB/GCYIDS8q/suvoTcvc1zyeq7+Pt4k8NwUgw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VPFFO2mkSl9nBAMvvzcZEZleV8fvx9CPSZ5MR1nkwiU7kpa+CWv9Baya3Z/U2i6eB
	 IQLZD19pbyCFWydeDEIG7iV3W8JskDy5Ju2cyBI9nuhYDnD6tJ891tg6xo1GdIsNfs
	 jSqOw93gs+LKd26+7jzZyCvgc7anNJqJCVprpx5B5yuxncGvaF2EL6jCuviFQ0hAP1
	 nOuFUQWi8xLGEzvljSDqIaduxjWXhm5gpAaLKeXONUtIFe3cwcrgmM7MKKvSeypRiH
	 jTu85Shl26uKFv25KVSdyWOziTjtkHqlk0sU+lfDlu0cWC7oLo2hXX/P68/jfWBA8D
	 +AWDv98CZj4PQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19940392FFF9;
	Thu,  6 Aug 2026 02:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net RESEND] net: stmmac: raise TX completion interrupt at
 the
 end of an xmit burst
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178598280589.610432.15021421797770719608.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 02:20:05 +0000
References: <20260731194522.55069-1-contact@c127.dev>
In-Reply-To: <20260731194522.55069-1-contact@c127.dev>
To: Johan Alvarado <contact@c127.dev>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 Jose.Abreu@synopsys.com, rmk+kernel@armlinux.org.uk, pavel@ucw.cz,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 Jul 2026 14:45:22 -0500 you wrote:
> The TX mitigation logic only sets the Interrupt on Completion bit once
> every tx_coal_frames descriptors (STMMAC_TX_FRAMES = 25), with the
> tx_coal_timer hrtimer (STMMAC_COAL_TX_TIMER = 5000 us) as the only
> fallback. TX skbs are freed exclusively from the TX completion path,
> so any flow that keeps fewer than 25 frames in flight has all of its
> skbs held for up to 5 ms after transmission.
> 
> [...]

Here is the summary with links:
  - [net,RESEND] net: stmmac: raise TX completion interrupt at the end of an xmit burst
    https://git.kernel.org/netdev/net-next/c/d21a374995df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


