Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEDB47FAE8;
	Thu,  6 Aug 2026 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031469; cv=none; b=bFLjqpN1sqQtT8K7xSZQTjh+GoD0Qf2pDMzoIo5BWSGX2x5SvC40m9th1CqxbkfNwX0MMUrF8aDhLVWSqOMAjXicuPI2DN4ffj2shw9fMYAE+UIgxQN6Xz5SBOf5RpFYOawGBrTpUpyU6bnj6SCVzutE4BMAzjlcQ5klEI/KLi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031469; c=relaxed/simple;
	bh=uy0j+cXFYcXjDH1oTZy6UMKCfiFsGUN5FpwJHySYjYQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X/LCOCGO0IAQgsBX7JLB4WFYrRLahmkSv3OSmGets/Eb9lzhRUtr+eFqUWpwy9ykmrC7WgUUf923nETa0UHMyN2ujXalZUJ36c2ltBMnR4i/MXaHuQ2ZUCeRopAWFROKuMroo38XoRnpPNkoSItPoW+vcQVKYseI8WfG7Dcpt0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ww5lpZDF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ww5lpZDF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77251F000E9;
	Thu,  6 Aug 2026 15:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786031460;
	bh=5pNZDgf8ZOg8v9ynAw2wFEX5dr/aTec1LVvDu0T1sVk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ww5lpZDFrRhYRJ4Fysr7LefNgviklAIbIK69R+E5XKTwPxUeOuG4XoQhCbDZNRows
	 fz7btQ6nWIkoYy1hEgBlN3dpkY7yr3/vwZ1PeIdbQl7XANyU+zf60U1wfg8UUEh7/M
	 n7uX0w/78L47i6qYqrCpKasWqZ9R7Cx6mUums8rLzxAbLIsxM/D/R8op4agB4KbOfk
	 o5Yp3juQ8MqnmIQc4GmVu8NbklhDBBcSuRLtOtBL9b+0Jp0Tn/yIKkOxKEL3tTQjmr
	 SksvcHptEhnUgOufNm23RmHrB03m/eRDUNnQh5y2tA+L237DbOqtODmhS1xKyGGoXX
	 jFF2jDyONbn7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56969380820D;
	Thu,  6 Aug 2026 15:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: thunderbolt: Tear down DMA paths before
 stopping the rings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178603141989.1348318.7897759415546724643.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 15:50:19 +0000
References: <20260803-b4-tbnet-teardown-v2-1-27de6a13ca2d@gmail.com>
In-Reply-To: <20260803-b4-tbnet-teardown-v2-1-27de6a13ca2d@gmail.com>
To: Fan XinRan <shinjiangjiang@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 mika.westerberg@linux.intel.com, davem@davemloft.net, YehezkelShB@gmail.com,
 westeri@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 03 Aug 2026 14:38:50 +0000 you wrote:
> From: Fan XinRan <shinjiangjiang@gmail.com>
> 
> tbnet_tear_down() stops both rings and frees their frame buffers before
> calling tb_xdomain_disable_paths().  tb_ring_stop() zeroes the ring's
> descriptor base and tbnet_free_buffers() unmaps and frees the pages the
> frames sit in, so by the time __tb_path_deactivate_hop() polls the hop's
> 'pending' bit, anything still in flight has nowhere to drain to.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: thunderbolt: Tear down DMA paths before stopping the rings
    https://git.kernel.org/netdev/net/c/68bf02b6b4ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


