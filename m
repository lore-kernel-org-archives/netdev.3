Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAEB33F8A3;
	Thu,  1 Oct 2026 00:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790814012; cv=none; b=SdxGrQxpPihl6ORWFA9Kn4pzfl/tw2IOUiCvnpZYLj+Hdrj/1gc78RyWmuxipKlYcR0d6Aub1cygQfwLy67U0sAVEw16zNMs9bzAgsE56rIP/ZqCQ5wNPXvYeQ2f5fCUMeNq3owSkuCQQb4L/6dcv8XYoOnJ+mI3gdLwhoneg4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790814012; c=relaxed/simple;
	bh=wUzDw4Gmoz61tOPnjGlHYqKabnpzEoNZ6zhxWoCGcD8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t9P0IN917ZJ3Egg+soMOZ1CJA1YNIxz/277NfmH2bLqeaBMVEgtl+WQ1+wjQY8LI9JoYkhy868PR4us+ubquTcP3QK2N/SFueKTO3lTEcWBMm12DSLDVE93MFXHSYAYMsSarOz86wzFsKYHpNtIlT7V/AzDq52aZ+LaPv/aDCJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMEMHuDT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMEMHuDT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444581F000FF;
	Thu,  1 Oct 2026 00:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790814010;
	bh=YGnqpqpo3QzBxu5OJwYRpWOXn23kehLy4lHrmA7+bjs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bMEMHuDThCL+Z4iDlvucefPopJB3GIKA5nvEBprlf8pGUVAa3JKPpmP6eSx0Sxu9m
	 EodCYXjUxL/hTs7SPVZ5bF04nwr+r8etXVQSu6ZJKXPqHmjXVQQ0krpiLhFG0GZ6pN
	 8LC8ZzmwRm0uj5dYZzuQruzAWCKVU1RFSjl4NnL5kIS0UWO0kywtThQMqSPQAfWhPH
	 1FbBhxzEhIaClasRj9H9g7kXO69ljYj1MNV8UKhn3j2JSVgdyxxntIVY7a84/piU/k
	 f20WZD36fpyb+W4X3bgK1PgOYkZyNsPWnz1cJ7+2EcmgEnIDj+/oQeh4kb3abjrQkp
	 xTAzNrE5wtEQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A31B3AA6A61;
	Thu,  1 Oct 2026 00:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 00/11] net: dsa: microchip: add periodic
 output
 support for the KSZ8463
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179081400903.2186961.15882174017132197950.git-patchwork-notify@kernel.org>
Date: Thu, 01 Oct 2026 00:20:09 +0000
References: <20260925-ksz-perout-v4-0-d675bd21ce49@bootlin.com>
In-Reply-To: <20260925-ksz-perout-v4-0-d675bd21ce49@bootlin.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Sep 2026 13:38:46 +0200 you wrote:
> This series aims to add periodic output support for the KSZ8463. The
> way the KSZ8463 handles periodic output differs from that of the other
> KSZ switches. It therefore needs its own set of perout callbacks
> (configure, start, reset, enable, restart).
> 
> Patch 1 saves the full request to be able to retrieve all its
> information in case of restart
> 
> [...]

Here is the summary with links:
  - [net-next,v4,01/11] net: dsa: microchip: fully save the periodic output request
    https://git.kernel.org/netdev/net-next/c/1fadd469b628
  - [net-next,v4,02/11] net: dsa: microchip: add the number of pins to chip infos
    https://git.kernel.org/netdev/net-next/c/1599393bf3ff
  - [net-next,v4,03/11] net: dsa: microchip: add the number of periodic signals to chip infos
    https://git.kernel.org/netdev/net-next/c/7242c96652e3
  - [net-next,v4,04/11] net: dsa: microchip: use dynamic mask to check pulse width validity
    https://git.kernel.org/netdev/net-next/c/3336fa200718
  - [net-next,v4,05/11] net: dsa: microchip: extract PTP callbacks configuration from PTP registration
    https://git.kernel.org/netdev/net-next/c/cfd0011cb5c2
  - [net-next,v4,06/11] net: dsa: microchip: extract ptp_get_pin
    https://git.kernel.org/netdev/net-next/c/5b2bb536a341
  - [net-next,v4,07/11] net: dsa: microchip: extract compute_width
    https://git.kernel.org/netdev/net-next/c/8885b5406a58
  - [net-next,v4,08/11] net: dsa: microchip: extract prepare reset
    https://git.kernel.org/netdev/net-next/c/ff327ef4488d
  - [net-next,v4,09/11] net: dsa: microchip: extract time update
    https://git.kernel.org/netdev/net-next/c/7273205d31db
  - [net-next,v4,10/11] net: dsa: microchip: extract time adjustment
    https://git.kernel.org/netdev/net-next/c/a7cc3395d17e
  - [net-next,v4,11/11] net: dsa: microchip: add periodic output support for the KSZ8463
    https://git.kernel.org/netdev/net-next/c/64854d9aab3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


