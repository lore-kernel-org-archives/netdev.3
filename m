Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9718B11CBA;
	Thu,  9 Apr 2026 02:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775701237; cv=none; b=jt03gZYN4L8HBOHBE/ovVh2+WP0+fAuD45v0h0Tgx+E+yyz9nUe32apdyey2i4paPNdFOMClCXsDSTARvkslVu6K6SwKd7m0clifbGnFV5gdHOGdPPyCM5OtCLBD7c4O8+DhU46kEUyfRyJgSuVcdY5UfN7MhZbQV3acg72lLzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775701237; c=relaxed/simple;
	bh=qoi9xVGCqtYjQswTkzXS2tdt5i5ZfAFUx4+tieqtuDc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S++G37Mi6DBFTzLyRVgyBjbiSSv1d7+gzwhUyvZFTnfiq/uWwWrQRpr55XJA18qfJ37nPVm+uuMxdJ3jU0qnuvdf+uGTRJWXDGW2Frn4E995Z8yJkcw6nFg/1YjqKxqPxn1IjcUtA4f/vVm4ZND7LTGVs3Cv+jCfBkbp5yGrCcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CshDwujp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CshDwujp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A89C19421;
	Thu,  9 Apr 2026 02:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775701237;
	bh=qoi9xVGCqtYjQswTkzXS2tdt5i5ZfAFUx4+tieqtuDc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CshDwujp4BV4aldmh4XaSVicLJe7/szGP+pZAIPAHqxxY9OAB+9woKylSgx4nKqTr
	 YtjeQE1sdDNGiv+Sn8KNcZju14IOuWN4oT58biLYuyBuHL3bqSIuvFm1PnKyQJfyxP
	 7PPfrCi97IuQtgckqIrwrRQwmPwdzEJ1wpNJnTCgGBy+Sfzp9EPino9P34MZW3YX3L
	 1uF8sc6fxMYT4JrK1FWHr5Zf2zMziFIu29LWcz2T2d6QELvL50SXNAmFt1GQpFIF4V
	 Lpm8MOrOp+MO2vsI0iGyfPwW1HvwXaxusb1uouUpOoBgaajALtgfTP7vfXVhdIVvVn
	 Co1iU22cnw85w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F093930793;
	Thu,  9 Apr 2026 02:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: realtek: get rid of magic numbers in
 rtl8201_config_intr()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177570121329.959042.3872817800550229913.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 02:20:13 +0000
References: <20260406201222.1043396-1-olek2@wp.pl>
In-Reply-To: <20260406201222.1043396-1-olek2@wp.pl>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 daniel@makrotopia.org, vladimir.oltean@nxp.com, michael@fossekall.de,
 markus.stockhausen@gmx.de, ih@simonwunderlich.de, rmk+kernel@armlinux.org.uk,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  6 Apr 2026 22:12:12 +0200 you wrote:
> Replace the magic numbers with defines. Register names were obtained from
> publicly available documentation[1]. This should make it clear what's going
> on in the code.
> 
> 1. RTL8201F/RTL8201FL/RTL8201FN Rev. 1.4 Datasheet
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: realtek: get rid of magic numbers in rtl8201_config_intr()
    https://git.kernel.org/netdev/net-next/c/dbc2bb4e8742

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


