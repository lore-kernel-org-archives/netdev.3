Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ABB39280A;
	Fri, 16 Oct 2026 02:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117208; cv=none; b=O4gQvEp941JOoRZ3Tk/hIRA3SngGQCi3IsHBGNjbXXiGQWwc/LXfWN9toFL7LN7Tepvxlw0cSAZ/xT+rnw2urDzkCSrFNcl5/fhHRShqeRaLxEfllOiWckx8aa4VxfaIuleg/VwlzkvbYdFPUPAFURsG592zjV07eXJznaG0Fdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117208; c=relaxed/simple;
	bh=RSX+4nXRYb6tF/eBdUz+A6Xl/K0HXVPC0hFrPvZ1ZcY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P4srSG8gZmrPRo+szZtPyQdITXjn1/eI4BXvckT9aCxdeeCmYC9hmGnuXI79XsJJ7ysQick+MuVlRfpiTKrOGvuUG3kW26l46qABt6GE3BzJ35C5qgEh4+K0D4N9s5XNA0mj1+rBt3VEj7tVR7EI5S4B9guRIBn3ddy0cHsMS+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGlaHKom; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGlaHKom"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831371F000C4;
	Fri, 16 Oct 2026 02:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792117207;
	bh=+SOsYnUxcsp4rmruGbrB7lpTSGL/Kvdc9rNKiksd3P4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QGlaHKomcGqaKCXTuQn4Pry4mCXL9oUXvlY/q+Z3+DyULKWXNhH8V3T4wC2TGhLEc
	 i+9UfNwSqPChfSe4PD+Dpw0N/jcGmOY6XV7ubQdcYOLPSFsrIDLW3J6U+nAQzBvLJP
	 mwmU+o+LOFI1zHpCPCjJ6up6yN2cTtwfwmf+fsazWAgG6rBULUHrQ9uaDozv/fYv0z
	 RmQCd9vH7RIQymJouslrIxcM5NxcNUr3nalV1EdBeVPRBTTRw36EqC8KLikaz8QnT6
	 njEbi7TfHnGbCud+Ea4bYntFuifs/3ZxqCLcjYg83BlMz1QAQX8/E/LD7QaI/BFTNF
	 Ad5jkfo04/cag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7757C3808209;
	Fri, 16 Oct 2026 02:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bgmac: enable interrupts only after NAPI is
 ready
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179211720602.18595.409341972831796996.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 02:20:06 +0000
References: <20261010070011.60403-1-rosenp@gmail.com>
In-Reply-To: <20261010070011.60403-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 jon.mason@broadcom.com, f.fainelli@gmail.com, zhongx@broadcom.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 10 Oct 2026 00:00:11 -0700 you wrote:
> bgmac_open() calls bgmac_chip_init(), which unmasks the interrupts and
> enables the MAC receiver, before request_irq() and napi_enable().
> bgmac_enet_resume() also enables NAPI only after bgmac_chip_init().
> 
> When frames arrive in that window, the first RX interrupt masks all
> interrupts in bgmac_interrupt() and calls napi_schedule() on a NAPI
> instance that is still disabled, so nothing is scheduled. Nothing
> unmasks the interrupts again, the RX ring fills up and the interface
> stays deaf until it is brought down and up without traffic.
> 
> [...]

Here is the summary with links:
  - [net] net: bgmac: enable interrupts only after NAPI is ready
    https://git.kernel.org/netdev/net-next/c/ac1f6e58cb77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


