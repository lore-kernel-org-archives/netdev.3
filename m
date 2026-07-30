Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170E6410D36;
	Thu, 30 Jul 2026 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410447; cv=none; b=iyPk6XTTR4sB9ChrRhjCXFiIsSf1Go48F7ncnDKaZVbX6Hqe3UIrsjoZPZby5uxwWQxnumbUEXRvvZFPSMrEyj/gbAC24cnBnE5yqnOG7SPvli1RdH5Zs2IehbowjePW89QPR9nti3HPAgqiNt+SAYUs8u8Dp2vykaE8RDkOxRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410447; c=relaxed/simple;
	bh=h7alxLmP5zbNW4hwJnxRBB6qls55uW/cAclcjq8Bdaw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fQ1BMhgEK0YSCsAocwCHHxTP4Z5WBqZQwrWG0Ntm/lju+ulEGnI/y4zdgK992FS7m4tgALqtOdoQAF1aRaFE0igzqCx2lRr0eFTuRf6a2rv31EpsYcqPh8xmrSbssI5e0n+ltt50XlGu8o4jtKUg0gbs+5HM0fGH0D4sIDnbD9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esoC/stz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esoC/stz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3E31F00A3A;
	Thu, 30 Jul 2026 11:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785410445;
	bh=NVLb5U3N/Gsako6jvQtqUi/sH0ZmjtezvsNwVaFpxWc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=esoC/stzkcVn/If3r6Yzc5m84NWBPITjMqYw9np6IGXEmqVoKGwJnC2nmZArW+RJK
	 hu4p+/vess6LW2XUku2Q6Et6U/jdNwnc0Guvi2+AeExh0Q+LBv8IjKZDE+0Rc7ZAu/
	 g26mpxo6DmX0/Cz2gYw/9d/yoXe8dRUTpXGUq1BQTIm4RO4FJ6wTOK6cyRXXtUD30M
	 /z8CqVDKcNKlKlXBX7V8b+yZ/Tc58PqkFzv/nFz/F9NL02HiKjRRYoX35FC1XS4/rh
	 CDndKf5YV9ID6nd5aOHdWpcfN39q6JJREgDTBUBd/7oV7dMgaRKSjxsdJQnU2YL68s
	 zuiGxfCjNOxGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938DA38119C6;
	Thu, 30 Jul 2026 11:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: micrel: Add loopback support for
 ksz9131
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178541040931.3517205.1099776087314813526.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 11:20:09 +0000
References: <20260728075222.956780-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20260728075222.956780-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 hkallweit1@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 28 Jul 2026 09:52:20 +0200 you wrote:
> ksz9131 is configured for local loopback in a similar fashion as the
> ksz9031, with a need for full-duplex operation, but with some extra
> steps to take as specified in section 4.13.1 :
> 
> 1. Configure the following registers:
> - MMD 1C, Register 15 = EEEE
> - MMD 1C, Register 16 = EEEE
> - MMD 1C, Register 18 = EEEE
> - MMD 1C, Register 1B = EEEE
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: micrel: Add loopback support for ksz9131
    https://git.kernel.org/netdev/net-next/c/a5c6ae8de11e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


