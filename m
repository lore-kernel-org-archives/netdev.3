Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E4F3A1B5;
	Thu,  7 May 2026 00:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778115066; cv=none; b=QZrwH09p1qc0j+p/8MUMMasN7SreZ+HOKY8TVqSVjwJo8chFULHUEx5k8cT+NUBOWOODGmWK12iWkKWGWwj2fzTMhVfl/foxNYkddcPAGoQden38gXh0QTDr2RcWjqwQauMIcIgTZ9Rv+BezCPipYH1ERD87SBmOmJWpXmLSEss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778115066; c=relaxed/simple;
	bh=zR7sFFYFJAjQQGbCRgoYjQn3+Ja+hAAxRZlOC0HrOY4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uSwF806OxaG3BFWEIBMOtEqZ7s/Wc1VsJuCbn+iHLgQO6/3w3K6u0DwF7tQre0Ig5w3ErriQgxdURmrMsBIKIylufKoJCcXGXE7jGbh4CYHXX5BcgJxKesy3KQc+xa+FvZYL3gKcbSwwtripFmKhEUwoA+j+cCKzbsNq9erkibQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmNFwson; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmNFwson"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1D6C2BCB0;
	Thu,  7 May 2026 00:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778115065;
	bh=zR7sFFYFJAjQQGbCRgoYjQn3+Ja+hAAxRZlOC0HrOY4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BmNFwsoniN/14y19zfCBZz4V81ERflEi+ghphceYvq93kig/rNIi/mKNiMA5v7O9+
	 j/CLlZP2545x8YIqPetbGoaZxtLIy9kw6LBgNAijghtAAWdv2P+lxe3Hqjxq6FYKxp
	 H7FXn3+Vvf+OzWS1khnqlu4sTHDYVM/BabGCAWaxwGHMnGs2xJ0vsp2mvewk1sL7b6
	 AY5fPHVOaOwoSOHbdTapZLzfOarzrz6Y5ub54gPlWCBMQ1/oweoBO+b8RrwKWpOeoz
	 oE/GGOaYOfJpKGPU/s/DYD9zmqCAAmF2OhvyIXBPmT+PKLeaIPjEa40QsOEPPC2SSx
	 SSSVkat4Mmo/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDF9393089F;
	Thu,  7 May 2026 00:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: rtsn: fix mdio_node leak in rtsn_mdio_alloc()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177811501510.3280886.3966126681952503544.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 00:50:15 +0000
References: <20260505123236.406000-1-shitalkumar.gandhi@cambiumnetworks.com>
In-Reply-To: <20260505123236.406000-1-shitalkumar.gandhi@cambiumnetworks.com>
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: niklas.soderlund@ragnatech.se, geert+renesas@glider.be, andrew@lunn.ch,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, shitalkumar.gandhi@cambiumnetworks.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 May 2026 18:02:36 +0530 you wrote:
> of_get_child_by_name() takes a reference. The rtsn_reset() and
> rtsn_change_mode() failure paths jump to out_free_bus and leak
> mdio_node.
> 
> Add out_put_node to drop it before falling through.
> 
> Fixes: b0d3969d2b4d ("net: ethernet: rtsn: Add support for Renesas Ethernet-TSN")
> Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: rtsn: fix mdio_node leak in rtsn_mdio_alloc()
    https://git.kernel.org/netdev/net/c/701ea57feaab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


