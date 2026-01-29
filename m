Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BE22BF3E2;
	Thu, 29 Jan 2026 04:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769661612; cv=none; b=NlIIVoxQDbtxCfhcahSDDUP3hVTof6aVzRFL/Bm44nNsOI5uqRn79VI/FcwMHhbEn45qpmkV0F3bbn2X4ZIJf08wgx4qFmvuHkvd2+8y7Y9F24Px/+I6PkTMboLlZEc73NXEc3adpNP+lDP7eJ0R0qQW03KflQ+xmmcAPV4ekro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769661612; c=relaxed/simple;
	bh=/bcjNS9+oXzTvU7F2k28K0z+PbtHDmoK+wwOioZkOhQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D6nsKNSD1vkTo/Fg165/wQoKJndME3tH7UZukZvdRdT49Yr38AwlnkCMP80xmN9MfsRqV6uLkme02OiEv4BpX/DgshstRL3Z0jxaLkyk1/kK6TwxZIvscYi5ec1jJ4mcCcLAb9jlBPoFRWerTOUGWC2tJI/Xd7c3kn0z9j/+pv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNIQX73V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNIQX73V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC4EC116D0;
	Thu, 29 Jan 2026 04:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769661611;
	bh=/bcjNS9+oXzTvU7F2k28K0z+PbtHDmoK+wwOioZkOhQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SNIQX73VOK/nKnahkTQxfewnetmfCDQBTxAlr96uhSZu6ILFzzgkAFbDGMOP57RrN
	 eQFtwEzOIq16oi8MacStKhTZxhAcggDg8fzb4TxGSqXwrmAGsEPLpP6L+6367WYhSA
	 Sy1avPJYOyhumrxcVai7jKHcbUSVo5ucg/pwQOUuaQUSY9DMp3rQjSVf5wtJe12INj
	 a64oBIvq0PemAoh/QF/npQHKeO0UkQ0Ruv352t8cK48/E7z6BGuAvPsEF1+GsWWIHg
	 2PFC3lTsie+irSASWzvQiuKSDpgc5nw6hd3k9Fa3d3Au0jK4UcE8HrWKjuWQ8O0pkC
	 a46fmOD+02VJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EA5B380AA69;
	Thu, 29 Jan 2026 04:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: micrel: fix clk warning when removing the
 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176966160511.2349661.14928382440812259568.git-patchwork-notify@kernel.org>
Date: Thu, 29 Jan 2026 04:40:05 +0000
References: <20260126081544.983517-1-wei.fang@nxp.com>
In-Reply-To: <20260126081544.983517-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 florian.fainelli@broadcom.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Jan 2026 16:15:44 +0800 you wrote:
> Since the commit 25c6a5ab151f ("net: phy: micrel: Dynamically control
> external clock of KSZ PHY"), the clock of Micrel PHY has been enabled
> by phy_driver::resume() and disabled by phy_driver::suspend(). However,
> devm_clk_get_optional_enabled() is used in kszphy_probe(), so the clock
> will automatically be disabled when the device is unbound from the bus.
> Therefore, this could cause the clock to be disabled twice, resulting
> in clk driver warnings.
> 
> [...]

Here is the summary with links:
  - [net] net: phy: micrel: fix clk warning when removing the driver
    https://git.kernel.org/netdev/net/c/2aa1545ba8d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


