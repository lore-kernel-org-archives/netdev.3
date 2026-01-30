Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6B81C32FF;
	Fri, 30 Jan 2026 04:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769746212; cv=none; b=uA8+ckLqlVhMRdy6jnVWQLOU2SqLnVkPqdjh2Q0xVjxH6VSSvF9xOzn4UPqbimfe5FUPPD4+DyhANsiVGbqN34DElB3xgq6B32TPLmaB8LWO+ac1zxk2nUPhK/d+stBJEagybBrq3o7ePmNDDefoyFw7l1DP5ScApTspkMHUl48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769746212; c=relaxed/simple;
	bh=78aminbX3d4iFaeJkolx6Lhb/dvX9hmKbofH1g8EPqQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EiivHgMxvEVV6CB+oAQs56a7hTP/KkaqkWxiXXUfEnsDYzh2+V1+VxPcWVGraghDy3oszbP4FHGBThzLZaryxd4UlQ9loGeJRNzVOnK08LkpdgaWzoH2PtgnSMIiX/EOlYu/G9oOBWvty/jVH9v7vWWtgAu9/GiUWkVDIn98AXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqT1P2Od; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqT1P2Od"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275ADC4CEF7;
	Fri, 30 Jan 2026 04:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769746212;
	bh=78aminbX3d4iFaeJkolx6Lhb/dvX9hmKbofH1g8EPqQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CqT1P2Od26nVERm7ykkwrwPtD2TzNQGImZq0RbKx8UAcGq8aNhrY/++DtTHt3YV51
	 QQOW2Lg8dLzMEYwjwRX6RVdBNhB5npxoaALaz0OvPYnj+XV3FKvP4mZiTn2kWMzfIi
	 2o6fctPkj1kQ08neYtdJspjDkbLjLZWFstkG9GNiTxotSymfnIpppakFn6pgERbI8x
	 uzWV8eSS9WprOz/cpfOpbz7afrivxUiia0EWtpZahxO9PBSUk0apjLJK//RE/J4Sg5
	 dFpM3lGlmiG4PorNXVGp+OnIRmFeCPPEfXGegy+/KgxwVUuOJRloShyZrwArtyA1PH
	 q3Jy2zl7BcVfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11B63380CEE0;
	Fri, 30 Jan 2026 04:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dpaa2-switch: add bounds check for if_id in IRQ
 handler
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176974620486.3168593.12672784481432882393.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jan 2026 04:10:04 +0000
References: 
 <SYBPR01MB7881D420AB43FF1A227B84AFAF91A@SYBPR01MB7881.ausprd01.prod.outlook.com>
In-Reply-To: 
 <SYBPR01MB7881D420AB43FF1A227B84AFAF91A@SYBPR01MB7881.ausprd01.prod.outlook.com>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: ioana.ciornei@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, danisjiang@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 Jan 2026 00:55:13 +0800 you wrote:
> The IRQ handler extracts if_id from the upper 16 bits of the hardware
> status register and uses it to index into ethsw->ports[] without
> validation. Since if_id can be any 16-bit value (0-65535) but the ports
> array is only allocated with sw_attr.num_ifs elements, this can lead to
> an out-of-bounds read potentially.
> 
> Add a bounds check before accessing the array, consistent with the
> existing validation in dpaa2_switch_rx().
> 
> [...]

Here is the summary with links:
  - [net] dpaa2-switch: add bounds check for if_id in IRQ handler
    https://git.kernel.org/netdev/net/c/31a7a0bbeb00

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


