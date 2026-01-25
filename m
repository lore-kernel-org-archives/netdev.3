Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40F530FF03;
	Sun, 25 Jan 2026 22:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769381411; cv=none; b=R46X2QjHw+hFce6t7CePCyxT1+dQPTCPdBxADYqxMiyGSzF5DJCDgqDCDRqjIsQsZjP1tIJi9R4bmR2wIp9bgRckjL6O8g8Xv9OeV3U4W43q1L10ANMEuGAzCy954ALMkZfNl3QUiauyKnSSl5m2xkRb4FGus2btNYvnNwL4xBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769381411; c=relaxed/simple;
	bh=JApt7qolCyCZ5meHirp90rY1uSwkUUTiQ31yZ2UGZH8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pwi2SenMCp/Qg6dn895VGesv+AXdUYSEOVI4tR9q+X+O6hnAEUbilOp7Vm6QNQJ+oSppjTEt12hyawS4UpKdGROSJhirCMRjx0pozfi12RnnZSGl6toc+LLzhJFj/JBv5zkMJ1ocWY5pAeBkPNPqEFxty5+s8lID5Pie2AzWNHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iy1EZFWV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iy1EZFWV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45ADBC4CEF1;
	Sun, 25 Jan 2026 22:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769381411;
	bh=JApt7qolCyCZ5meHirp90rY1uSwkUUTiQ31yZ2UGZH8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iy1EZFWV/xP8FCvxCnPqEVLfCmNLqXDDyCmxgBiWlUF/GwhzGunoX1uNVnV4e/mDl
	 8u/YVl2+Sotkm6aeNH7QYsQ9zoEhqLoSsM7VM6uzOWFfA0A1tmVCt3Ny13mvM0ICOU
	 pTRI6PryGD9cAnc8l3m9HWYIW14oFYhPHzycggfAV/Gn/UmKc9oI3mviXJwpavXDM8
	 6e2SGtwe+w96qU0JZtdgYDvQ5oMKBnQPG7dYe1LLif0QmxFgkoI4np441m581tgz9p
	 w4z13HkBjxT2wkDOgn/HiIYyyCTf9YzkoIfaQ/33nCJ3RwoYrL4HAdGbGVdA9Ia9mX
	 49UJN4cGRfnFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EBB33809A15;
	Sun, 25 Jan 2026 22:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: wwan: t7xx: fix potential skb->frags overflow in RX
 path
 v2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176938140610.4002147.1030329011149082820.git-patchwork-notify@kernel.org>
Date: Sun, 25 Jan 2026 22:50:06 +0000
References: <20260122170401.1986-2-qikeyu2017@gmail.com>
In-Reply-To: <20260122170401.1986-2-qikeyu2017@gmail.com>
To: Kery Qi <qikeyu2017@gmail.com>
Cc: chandrashekar.devegowda@intel.com, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
 ricardo.martinez@linux.intel.com, johannes@sipsolutions.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Jan 2026 01:04:01 +0800 you wrote:
> When receiving data in the DPMAIF RX path,
> the t7xx_dpmaif_set_frag_to_skb() function adds
> page fragments to an skb without checking if the number of
> fragments has exceeded MAX_SKB_FRAGS. This could lead to a buffer overflow
> in skb_shinfo(skb)->frags[] array, corrupting adjacent memory and
> potentially causing kernel crashes or other undefined behavior.
> 
> [...]

Here is the summary with links:
  - net: wwan: t7xx: fix potential skb->frags overflow in RX path v2
    https://git.kernel.org/netdev/net/c/f0813bcd2d9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


