Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4024E3DB65A
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783422035; cv=none; b=HJba8y2rVl6kfdrLzrQImoAwykLuCjGd06varEqrtJJzceZjSsnTB0KBbkuNOKlS9oHX3PDE3ALafZtrMnVGPByIMIXflWn+FgiPhUYMBBvCft5NzAVFxVC0mApFUpS7INg4Z0w9QEHghezGZP1IPZ5+z6fna5xFqTefhSOXgbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783422035; c=relaxed/simple;
	bh=Ry6VoGstTO4mM1xLDubI9yra5JGj+DzJHMW3aOeP7ME=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LVQ4pTsB1uR8BAH+/ZeNPT1d7OCNIvkMXgK5LnGGrCcdfDuPjHc5NDzktE4krSHV+8InmTguqxm36dUVzuNLXKVpw74kttDbogpd8jhaD4QaUjeS56ftJ2VMqA2RUc+bA908EGS5J2/kDnMh+TUWvFakvqU624ZpjEWrJu6w6AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IILQLy1y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IILQLy1y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC431F000E9;
	Tue,  7 Jul 2026 11:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783422033;
	bh=0+lW/HyoCQKv86mW2wwMMjW384TD69xk7+ot2UpKnlQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IILQLy1yl3g5hwaO467sMXJ7x/ow/gtpvVci2uLzzZds7oK2Q2aC/VxLmsww0WSLv
	 hlfZc8K/Wy7xrQuuaX1X6FzLMue86Wn4evU4vNS1kunU9z8RiWFwkWC9iuuatVtS+d
	 pfAAF8QoQpgc7mmX5h7D+oRBPt08lT8iy3f5A5f318qnH9CyUiW3UeWCmD85mY5L1h
	 b/GtMRpZwgEUrRBRTQyfLg53J08z98zYk9KawDu0aamq72+MquURwB2kg+yUW+p4kh
	 lzPBXFb7LzPQ3fmgSAvr/9u7Tq4XSrOwuayMB2Q+xSatL+ZvtRuXr1Ya1AapFN8nl2
	 Zs5f6ku/fkQpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19B383925479;
	Tue,  7 Jul 2026 11:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/7] cxl: Support Type2 cxl regs mapping
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178342201363.1497513.7679658303612517121.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jul 2026 11:00:13 +0000
References: <20260701113805.14072-2-alejandro.lucero-palau@amd.com>
In-Reply-To: <20260701113805.14072-2-alejandro.lucero-palau@amd.com>
To: Lucero@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Palau@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Alejandro <alejandro.lucero-palau@amd.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 dave.jiang@intel.com, alucerop@amd.com, dan.j.williams@intel.com,
 Jonathan.Cameron@huawei.com, benjamin.cheatham@amd.com,
 ecree.xilinx@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Dave Jiang <dave.jiang@intel.com>:

On Wed, 1 Jul 2026 12:37:59 +0100 you wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Export cxl core functions for a Type2 driver being able to discover and
> map the device registers.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Link: https://patch.msgid.link/20260629183727.51502-2-alejandro.lucero-palau@amd.com
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> [...]

Here is the summary with links:
  - [net,1/7] cxl: Support Type2 cxl regs mapping
    https://git.kernel.org/netdev/net-next/c/2c599da8231f
  - [net,2/7] cxl: Support dpa without a mailbox
    https://git.kernel.org/netdev/net-next/c/96ddf1af34f5
  - [net,3/7] sfc: add cxl support
    https://git.kernel.org/netdev/net-next/c/a3fc56b12e3a
  - [net,4/7] sfc: Map cxl regs
    https://git.kernel.org/netdev/net-next/c/08699796dabf
  - [net,5/7] sfc: Initialize cxl dpa
    https://git.kernel.org/netdev/net-next/c/230284c1b165
  - [net,6/7] sfc: obtain and map cxl range using devm_cxl_probe_mem
    https://git.kernel.org/netdev/net-next/c/0418860ef2ca
  - [net,7/7] sfc: support pio mapping based on cxl
    https://git.kernel.org/netdev/net-next/c/bd6550bcdb0c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


