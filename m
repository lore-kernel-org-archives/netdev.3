Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8681C15B135;
	Wed, 29 Jul 2026 02:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785290444; cv=none; b=r2qAxX4EAE8k3TPvutsN+RIZUtstY/d/YuBa3/EyNxgNBzc2bfmxm5pDSfN3Lh+XnsJlCEORW14fMjemMsYLL49bYsskXoEn+9I1qewQ3VKEd4lcCJtFokHd1R2W3B2irS8Xdd7YJDDHqzLoHUrCDVkyBCxithjfbdDrlH/fAAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785290444; c=relaxed/simple;
	bh=SjdamARGu/cQsc2GeSn6NGV/RxRAtxqP4QYmM4tBJgw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gaGsPyOzmaK/qcodXTBNB52kiMRM9lAUa58ikVuAmMY7vVl1d9IDiBov1dLROn5rDQr9lD4DRRV+jRv606Ee6tepq8p9ARxa+vVY7qjPfnhzOWgoxpRsW3sZFswsrMpuGMC+QXWmzv+HrkIEqaqKTpRy4c5OBUUUHc6yuoQnrOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUASL0sp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUASL0sp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D781F000E9;
	Wed, 29 Jul 2026 02:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785290443;
	bh=YVwKMUybJr3GcOCLUFsK1345VgE1ywZbOV69wu+G+Q0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WUASL0sp4OTLNLF6GuA6sJr5+duT0zr4HL68r5i9o+ugxL6rYITH6nV4aMVD4wYng
	 8J6vheoVdNFobdxOVhSkE9BewrIvdMRNUahxqrJpgmP34xX25g0V1UPrDE+rGlEw0y
	 Wan2hoYICjZlgCceLvGRcsOn0sERTasPcpYfJQReJWdvg/uGWRsVvV36/EVZ+C+8sE
	 i94RZngrRUxi+nRoyJSrXCvkBWvVSHEuknB0rYpkNnPeOxc1LvCdDzTfaM1wC/VtwP
	 oHvxQAa5hMHnyklLw9uJ2sBaCwZJU/+dgPTIbQdp4GED8V6DQg86aYAn5PDgZ7RKco
	 poiuB60noWdlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09FC3924A60;
	Wed, 29 Jul 2026 02:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phylink: put link_gpio if phylink_create fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178529040738.2407687.1864328411673598959.git-patchwork-notify@kernel.org>
Date: Wed, 29 Jul 2026 02:00:07 +0000
References: <20260726150806.2437-1-ansuelsmth@gmail.com>
In-Reply-To: <20260726150806.2437-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 26 Jul 2026 17:08:05 +0200 you wrote:
> In phylink_create() if phylink_register_sfp() returns an error, link_gpio
> obtained by phylink_parse_fixedlink() is never released. While this is a
> very unlikely scenario, it's worth to fix/handle this.
> 
> This was present from the very first implementation of phylink but got
> relevant only with the introduction of ce0aa27ff3f6 ("sfp: add sfp-bus to
> bridge between network devices and sfp cages") where additional function
> were added after phylink_parse_fixedlink() making the release of link_gpio
> needed if such additional function errored out.
> 
> [...]

Here is the summary with links:
  - [net] net: phylink: put link_gpio if phylink_create fails
    https://git.kernel.org/netdev/net/c/0fe1e3e8f338

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


