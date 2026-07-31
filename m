Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BFB48987E;
	Fri, 31 Jul 2026 23:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785541266; cv=none; b=lQnwEYR75RQEC63/afnfgH9JvAmVuefXkITFfzLtOXUKz30zKQAjDCEKFBnqEzce4qVRvRHkWhm6oJ6XgXN11lBI4dOcGruia7erNIuBoJP5VwEa/Kd2qRtO1uijxNP54X5la4Xy/LOmiFFzDFvi3ndMP23ZclpmZMmON8udeA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785541266; c=relaxed/simple;
	bh=39e2nYASdbtwqSNyjJ6ULs0bJMjGoxPmhQbdNYSttqQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=byJB+YIqFBAkcDeQNYaP8zd4YN32v8Qwk+VDNPJC6XJ6xuzk5gYnm312IxvVczhDorSaWAyVJ1pDnhw120gdusjfFjeWJjyo/LNSjVRfw/aAxArIEGjnz00+bqRw6aoJaCsoCgi4sLLbNdudGeBwW5Y+eFF/41a0Jun+bEjf06U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrBY4he5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrBY4he5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A575D1F00AC4;
	Fri, 31 Jul 2026 23:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785541264;
	bh=KdvF1vWGllmt1Z/cak9Vulkh3Bg6BSA4aOmaJ9vZ/us=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jrBY4he5ECtWfanT3ZZ3t/KiNk8b392DI0YbsJ+k4fUJ3Xgysxjk3MSxjtdtdUVxS
	 xYWGj18/o8tuZGIzL62MroMe9qJMErcd02yUrJn6gVeEIpzv6KT5xqk2k6PK8Hn2bP
	 DlPmm7ETa2T6u9hbZBQ5xpeyqznRjnyWhslc6zDEVMb8ZXgl5U4zy99YOXvP+SN61O
	 QHKFFPrAZsDl/KLLYpW5PGAcEDaj8iaKtPXL3JBkkvOTgboJWnrEbPsMc6bi3hoTvx
	 1j5SM8Y48OnVVrN3N7pe18cXHItdxLNdsnj2cN7Gjxtk4JPTMXUhGghucaIlJfMWdE
	 3glA6vZvpRHeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939AF392665D;
	Fri, 31 Jul 2026 23:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 00/10] net: dsa: microchip: add PTP support
 for
 KSZ8463
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178554122713.949682.6030341343716045373.git-patchwork-notify@kernel.org>
Date: Fri, 31 Jul 2026 23:40:27 +0000
References: <20260727-ksz-new-ptp-v3-0-caba39e680e3@bootlin.com>
In-Reply-To: <20260727-ksz-new-ptp-v3-0-caba39e680e3@bootlin.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, linux@armlinux.org.uk,
 horms@kernel.org, maxime.chevallier@bootlin.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Jul 2026 12:20:42 +0200 you wrote:
> Hi all,
> 
> This series adds PTP support for the KSZ8463.
> 
> The KSZ8463 differs quite a lot from other KSZ switches supporting PTP:
> it has a different interrupt logic and a different 'PTP engine'.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,01/10] net: dsa: microchip: implement ksz8463_setup()
    https://git.kernel.org/netdev/net-next/c/7ed1d2b87f37
  - [net-next,v3,02/10] net: dsa: microchip: split ksz8_config_cpu_port()
    https://git.kernel.org/netdev/net-next/c/9089bde4db60
  - [net-next,v3,03/10] net: dsa: microchip: allow the use of other IRQ operations.
    https://git.kernel.org/netdev/net-next/c/2a6aab5d5bd4
  - [net-next,v3,04/10] net: dsa: microchip: add PTP interrupt handling for KSZ8463
    https://git.kernel.org/netdev/net-next/c/b3422f60e931
  - [net-next,v3,05/10] net: dsa: microchip: adapt port offset for KSZ8463's PTP register
    https://git.kernel.org/netdev/net-next/c/ac99cc6cd3f8
  - [net-next,v3,06/10] net: dsa: tag_ksz: move the KSZ8795 tag handling below ksz_xmit_timestamp()
    https://git.kernel.org/netdev/net-next/c/e5a0c1316368
  - [net-next,v3,07/10] net: dsa: tag_ksz: share code for KSZ8795 and KSZ9893 xmit operations
    https://git.kernel.org/netdev/net-next/c/a97c78093e9b
  - [net-next,v3,08/10] net: dsa: microchip: add KSZ8463 tail tag handling
    https://git.kernel.org/netdev/net-next/c/46e8ceb399d5
  - [net-next,v3,09/10] net: dsa: microchip: explicitly enable detection of L2 PTP frames
    https://git.kernel.org/netdev/net-next/c/172397752efb
  - [net-next,v3,10/10] net: dsa: microchip: add two-steps PTP support for KSZ8463
    https://git.kernel.org/netdev/net-next/c/d06c58f4fcf2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


