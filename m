Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C47539762;
	Tue, 22 Sep 2026 11:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790074877; cv=none; b=WvKgp/eit0bDi06IiylmwKNH+jrwZj02BlAcbM5Zbk+/LfSqWn/mcvmuLtC11P3HZdH2D7nLz7AJFzuHJeIma6zbaLa6xeoBuCH5A/eAX4cBrnOLX0rjsR1/wPThqAUohMz6Kg43tSc8LUUJIcb0Fz/KxMnvSKfbOVetFDNwdGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790074877; c=relaxed/simple;
	bh=WIFqIyjzWt+/9sQwK068IvZyxXOO2WqnStzPOAksiio=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=moFHmMx5qqnZB26PN3tBf42zyMCvnn7t1/j28fOMFXCEJ+lxxs2ZdBJF6gE6J/lbV1FqpfPRMc9XWAQaKAsnyq1j7v8WNiwh7sZOUqgNKMrtY01I/sE6dX5Xxqye9zcuTB4eH0tmCypHn9iBGiXdR4AaBVasFR5HdsRq/8EGRpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=au3gdWzb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="au3gdWzb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F771F000FF;
	Tue, 22 Sep 2026 11:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790074876;
	bh=Y1vdsGOY/KDvyzcJWbwWtxtfK60TGHQsGcIdVzaWuz4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=au3gdWzbGbTFqrEnZJR+b/2Tlg2WMPlv3PsxS+oPZN/5GhLsAbD1m1Sxb4nq5W9AM
	 zGe6/az5pmJZQoCiYmU22mUrdPDYUfxTyCA062u5imaevgjMgj0ieyXHMh7nZPhfUI
	 b66Vp3L2qt+Bs0Tvw1NA5jY8DnLjsGorJXcxGaqjUWvu/pVBw/hWPI3OEMFwvXRKB3
	 B+p/9RE5oomLxr9y6EGk/YuoN42fRvWsPvtJUz2z6O5jvfYM2skc8oU1+aSCobP8Hs
	 l0i8o/T3CWrAWzOwoQ1UFQSmx5/fQbrTC2dcMmFz+I2FqF81taNFfYYV3yTckO5zdx
	 sI6Bt9TZ7GhjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9390738119DF;
	Tue, 22 Sep 2026 11:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/3] net: dsa: realtek: EEE support for
 RTL8365MB-VC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179007480745.3557644.10659834331217655473.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 11:00:07 +0000
References: <20260918091722.3270534-1-o.rempel@pengutronix.de>
In-Reply-To: <20260918091722.3270534-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: linusw@kernel.org, luizluca@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, a.fatoum@pengutronix.de,
 alvin.sipraga@analog.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 18 Sep 2026 11:17:19 +0200 you wrote:
> On these switches EEE is enabled by default, but so far it is neither
> visible nor controllable from user space. This series wires EEE up to
> phylib/phylink on the RTL8365MB-VC integrated-PHY ports so it can be
> observed and controlled per port via ethtool
> 
> Oleksij Rempel (3):
>   net: phy: realtek: use C45 for RTL8365MB-VC internal PHY MMD access
>   net: dsa: realtek: rtl8365mb: extract PHY OCP address halves with
>     FIELD_GET
>   net: dsa: realtek: rtl8365mb: add EEE support
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/3] net: phy: realtek: use C45 for RTL8365MB-VC internal PHY MMD access
    https://git.kernel.org/netdev/net-next/c/4ef25721f7c8
  - [net-next,v4,2/3] net: dsa: realtek: rtl8365mb: extract PHY OCP address halves with FIELD_GET
    https://git.kernel.org/netdev/net-next/c/e9ba480ec820
  - [net-next,v4,3/3] net: dsa: realtek: rtl8365mb: add EEE support
    https://git.kernel.org/netdev/net-next/c/61c59309b6f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


