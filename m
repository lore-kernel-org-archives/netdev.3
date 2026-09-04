Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D913E9C37;
	Fri,  4 Sep 2026 21:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788558680; cv=none; b=q0DCM4etGDubU8dievVHwPzTd7yq2Z6ZFnPUvWp56T9s7FrANKnhw3x9paWTjaqDYAqYP7iJeyzt9qafzxORC64ytsxwYaP8JFmaqkx8RCcjGrbayk0625luOwMaAAP8+mICffV6fHIatt+Q+oIT1UHMPjHuivlaIqB9oK8HJts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788558680; c=relaxed/simple;
	bh=sXzEZegIR5Md5NortDhNUIBrv4sQE9/YOu71fbW76w4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OWSlBiUvngBdmvSi9MI2V2mBZWoa8XkzeB0jryE1va/wWnowd/ep3mWZcr9Naiug2KSkLf1AVnVcc/rmE+QCE0uQ4MtWbUSuxq7WOPJcOkWsd3waidj8Y/4K4r1lW4qBl15Fxshwc1c5DkmDxRKlcK2PhbyhoxVYCe6qdbHuGyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/sbxcQd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/sbxcQd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31E61F00A3D;
	Fri,  4 Sep 2026 21:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788558675;
	bh=R/Cav9XFZogHfbk3qfyQXktqQTqrSNLZGy7/hGqnHlo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=a/sbxcQdSpuV+Duwy7dwHKA7wBpO9FiD2mSIcsv+cZ7yh55mrKeUO4Tz623L4dht3
	 Ep5O6AYRown1MVY3UVkYtp4jH84Ta6RI8rbfxto01LQloWzNPSncubLb4PNi3Exdad
	 KSaVgL8QH/G74MZAlEY+Z/dBeU4V3s8MrDq/LRpHzbGUudEvnHm5X18UZsRkVEb/ln
	 T14Pw+ApkRKfJc+sP1p+Jqp4myxC06YvYh5mO//f9PeIuPGz/hd5ZNaWFUgF0XhfvX
	 CHfrqF8DHPsRJKMTdv5zUAldSeEyGEi7XPt0F4NSzueL/d3qwfvHAGwjZadG5JbQTA
	 BXxrIUhKXrH5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93BA73924A7C;
	Fri,  4 Sep 2026 21:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 0/7] r8169: add support for phylink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178855861639.981964.11852847781303360318.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 21:50:16 +0000
References: <20260831053745.1197-1-javen_xu@realsil.com.cn>
In-Reply-To: <20260831053745.1197-1-javen_xu@realsil.com.cn>
To: Javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, linux@armlinux.org.uk,
 enelsonmoore@gmail.com, daniel@thingy.jp

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Aug 2026 13:37:38 +0800 you wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This series patch adds support for phylink. RTL8116af is a fiber mode
> card, link status and speed can not be read from standard phy reg. So
> we read link status and speed from serdes reg by pcs. So as RTL8127atf.
> 
> Javen Xu (7):
>   r8169: add speed in private struct
>   net: phy: phylink: add helper to modify pause
>   r8169: add support for phylink
>   r8169: add support for RTL8116af
>   r8169: add support for RTL8127atf
>   r8169: add ltr support for RTL8117 series
>   r8169: fix RTL8116af can not enter s0idle and c10
> 
> [...]

Here is the summary with links:
  - [net-next,v9,1/7] r8169: add speed in private struct
    https://git.kernel.org/netdev/net-next/c/ddffc67d89c8
  - [net-next,v9,2/7] net: phy: phylink: add helper to modify pause
    https://git.kernel.org/netdev/net-next/c/9f8cb9cbcdc8
  - [net-next,v9,3/7] r8169: add support for phylink
    https://git.kernel.org/netdev/net-next/c/8a3c76523e44
  - [net-next,v9,4/7] r8169: add support for RTL8116af
    https://git.kernel.org/netdev/net-next/c/dab515216def
  - [net-next,v9,5/7] r8169: add support for RTL8127atf
    https://git.kernel.org/netdev/net-next/c/97dee72abc37
  - [net-next,v9,6/7] r8169: add ltr support for RTL8117 series
    https://git.kernel.org/netdev/net-next/c/6e445f3d9538
  - [net-next,v9,7/7] r8169: fix RTL8116af can not enter s0idle and c10
    https://git.kernel.org/netdev/net-next/c/a306cbd79e07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


