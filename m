Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1B749E5C2;
	Thu, 24 Sep 2026 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790268681; cv=none; b=KhaJOyL0Rlc+i5Y4umLOksCx9W96+EUdICzvQ7raX0lp8HFkLjgJnKUvq2XTjsiR+Y/Hb1GQh6fNiCG6E6HJA9us0gRgJuMpcEd2CyuA0WR8ShwwyBb13DghebcOXwfQLJNFJiXr7Wn5zWuf/tMFnfLGkz6LbZKEOZzoa24l0vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790268681; c=relaxed/simple;
	bh=vrh6u0XHEI7xjUi0d0k6wrotFUcQcnO7/DRhqsNTfog=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t1YnQDIBhTitSK3ugjtgq7xDQceYBsWG/D3KJaQ66BMt5sDWkx+5NbCrsn1pkr8RGEeNIVAiglbOGkByjiEkcj8+HlveizthLv6YTQ6z2kIi8mb/2O2qZ0SDX/2dWqgV2k9R+ME0nAyFjTXD1uIAVBIdLQ/F64H0XDWiTvw4oz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoAxh6b0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoAxh6b0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278F81F000FF;
	Thu, 24 Sep 2026 16:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790268680;
	bh=sIJjjJZg4BSGa0jI4YLtKZ0rTNKCQwcMD/DWqSQdRe0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IoAxh6b0IahGnOKMLdkWU/sm0A27m1bnYSzTy/hn9lEFwoaZ13rNY11v/z9HuS120
	 AsoWEbuU/hSXbJ3zQJ9dwb1TGZmZj7FtpnOMHyLnv7//bn1zic+ctxMGGF4C0b4xgQ
	 3d1b73K0Pox7LzazxoQXno6Ts7hHVhjn/Q/f0qVKcbBNz7iYCOqP7i4pYTh5YSmF12
	 ANc6pZcdlEVjPH7LAQPorlUoqr/Cj4bvNBwWtEzdfF0bz/j2wZXQP2zULUbsc0kV88
	 tqwJo/bsYHhicR2RN3qOLcBInuEbSppiEA2vanhGl4OHPn3qE1QgmMaCxP5gx2SiX0
	 XfDTVguE/iPqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568153A566CE;
	Thu, 24 Sep 2026 16:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: phylink: record the PHY only once bringup
 cannot
 fail
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179026860889.1650423.15381201853782128326.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 16:50:08 +0000
References: <20260920222044.1752860-1-f@lex.la>
In-Reply-To: <20260920222044.1752860-1-f@lex.la>
To: Aleksei Sviridkin <f@lex.la>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, linux@armlinux.org.uk,
 andrew+netdev@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Sep 2026 01:20:44 +0300 you wrote:
> phylink_bringup_phy() stores the PHY in pl->phydev before its last
> fallible step: on a MAC whose phylink ops implement LPI,
> phy_eee_rx_clock_stop() can fail with a real MDIO error. The callers
> unwind with phy_detach(), which knows nothing about pl->phydev, so a
> pointer to a PHY that is no longer attached outlives the failed
> connect.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: phylink: record the PHY only once bringup cannot fail
    https://git.kernel.org/netdev/net/c/a940003f44e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


