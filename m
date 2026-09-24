Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A614B252917
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257876; cv=none; b=ioM8OUsO9JQxcK9tozXL2PW+3SOzsXdk5PXdSi7tidxDTFRtZEvWBWVjuiSGabg6RvBVEbgFRp5gqqM5sPSqb7b7RN006hzAz2BSEabCuq3hJrgDjMzYDzV0bSzJNGn3eFzkLWhWhLA8WcIGZoT8Wzjf2ATL2Oiavarlzk4yn4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257876; c=relaxed/simple;
	bh=qVcGzAjHO0k2bsEht9dtPKTbKHqQJfUEx1F1coqrMd0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bnrl1UrBKNkmsWe2n+qjREW2ZMtDsaYx39SRRiZK9ZHccJpkq0JgDdhyHe9Ic1QR8clMHCzfGgcQthG5n+An/YdbAjo3qdWZdr2MhvhES4OS4wgOI6hxtL/EvpMpQB9R4s51ZIDzGZ33RRvp+/L/hCodzww375km4KSz/sADZsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOZgRR9M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOZgRR9M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AB51F000FF;
	Thu, 24 Sep 2026 13:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790257875;
	bh=muQxY1xJRrt5M9dL1zT8j72OHEAtnHphJUlIf1kmmoU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bOZgRR9MTovzxy3JIpAjHN59YUteYccmtEDvVbK39yfgj2LfhmpTbIr3yPyWZcZDu
	 esm/6/oeWbYTEsNbXsd7p8xvWOEwKsubvU52GDyYOI1WVyk74jSDsq5V/2LdWd5AUm
	 /IBjPegMBBE8MAJ+Iekcnijn50C+udZQbtQ9XN81izeXqa4oSb5awdxa8YC3y8JNpH
	 WHKHAgL7I/hcYeX9J6ZUEC88H6Dj4eFiK2cJjK3L8FmVadzow9uhjlr4MqGgm4IS3s
	 obNmsULF3S5JMzSpacZv23+TO4isecDbq5IbFZQf2Pfp/UGzo4KMmoDhLstzqW1qaR
	 PJZnL9hIjiT0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B9339FD338;
	Thu, 24 Sep 2026 13:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: emac: move setting of netops to fix crash
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179025780443.1559027.2090766663428094551.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 13:50:04 +0000
References: 
 <49cd7343bc0e507c022071f3e2b5662b053dca73.1790007431.git.chunkeey@gmail.com>
In-Reply-To: 
 <49cd7343bc0e507c022071f3e2b5662b053dca73.1790007431.git.chunkeey@gmail.com>
To: Christian Lamparter <chunkeey@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org,
 davem@davemloft.net, jacob.e.keller@intel.com, nb@tipi-net.de,
 edumazet@google.com, maxime.chevallier@bootlin.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 21 Sep 2026 18:28:17 +0200 you wrote:
> fixes the following crash on driver initialization:
> 
> |BUG: Kernel NULL pointer dereference on read at 0x00000158
> |Faulting instruction address: 0xc0566b40
> |Oops: Kernel access of bad area, sig: 11 [#1]
> |BE PAGE_SIZE=4K  PowerPC 44x Platform
> |Modules linked in:
> |CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: GW 7.3.0-rc3+ #1
> |Tainted: [W]=WARN
> |Hardware name: MyBook Live APM821XX 0x12c41c83 PowerPC 44x Platform
> |NIP:  c0566b40 LR: c05648f8 CTR: c04c1e9c
> |REGS: c1053a20 TRAP: 0300   Tainted: GW  (7.3.0-rc3+)
> |MSR:  0002b000 <CE,EE,FP,ME>  CR: 24008808  XER: 00000000
> |DEAR: 00000158 ESR: 00000000
> |GPR00: c05648f8 c1053b10 c1063600 c1030000 c5ab3000 00000000 [...]
> |GPR08: 00000002 00000000 00000000 c1053b40 84002808 00000000 [...]
> |GPR16: cfffd210 00000002 c0beafcc cfffc960 00000000 c1030644 [...]
> |GPR24: c0beafbc c1037000 00000000 0000000a 00000000 c1030000 [...]
> |NIP [c0566b40] phy_link_topo_add_phy+0x2c/0x1d0
> |LR [c05648f8] phy_attach_direct+0x1a4/0x368
> |Call Trace:
> |[c1053b10] [c0811e04] klist_put+0x54/0xb4 (unreliable)
> |[c1053b40] [c05648f8] phy_attach_direct+0x1a4/0x368
> |[c1053b70] [c0564ae8] phy_connect_direct+0x2c/0x60
> |[c1053b90] [c056c7a8] of_phy_connect+0x50/0x74
> |[c1053bc0] [c0572a88] emac_probe+0xd50/0x119c
> |[c1053c90] [c04cb770] platform_probe+0x74/0xa4
> |[c1053cb0] [c04c8f08] really_probe+0x120/0x2b0
> |[c1053cd0] [c04c9254] __driver_probe_device+0x1bc/0x1fc
> |[c1053d00] [c04c9334] driver_probe_device+0x38/0xa8
> |[c1053d30] [c04c9560] __driver_attach+0xf4/0x10c
> |[c1053d50] [c04c6af8] bus_for_each_dev+0x68/0xd0
> |[c1053d90] [c04c7c34] bus_add_driver+0xcc/0x1ec
> |[c1053dc0] [c04c9f6c] driver_register+0xcc/0x110
> |[c1053de0] [c0aa3f40] emac_init+0x1c4/0x200
> 
> [...]

Here is the summary with links:
  - [net,v2] net: emac: move setting of netops to fix crash
    https://git.kernel.org/netdev/net/c/7c9f391ec89c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


