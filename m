Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFE7259C82;
	Sat, 27 Jun 2026 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782525031; cv=none; b=E1psj3DCGhpQIG1G1Ehi3KaYvrMXU3AHnDKIDwPNF2RgVrPiTdQ56GBSd8gutAxgbOJf8LdSpXvgd+5+1ZRuPHbWm3d3D6YXqaBTcUWu4+JEwiQ4BPok/2PI4QHJTRTCEsC9NLu6vnI5t1eMlnMNH03F8I4MIxmI/6W8O6j3taY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782525031; c=relaxed/simple;
	bh=Sk4pWI5MXwJ3FyfGMprFGVWbLtqkznttaPGszFBnoYM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sEP84Z7FwfvyyFI+DBpv4nr5iIilkYpy1iaQcOkV02CpFi/B3a1aHiwFhaW8vj56VkmPfcGVXZlnfxrQsF3cEEetkdfxjcTp3wgXupTX8WftVRhUwQidFBmK1/HeUil+t3zWbgz5NbitbsRNfWohlZMZECXhwu52Ov+LRrtlHxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osgeK+kU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osgeK+kU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE071F00A3A;
	Sat, 27 Jun 2026 01:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782525029;
	bh=mW/Md5slDKdXQwiHCdWi8GyJm1tqD46vKekkDfH4pGI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=osgeK+kUIwIl2oX10Xs5LePUP88oqBB8XJWRpllyH6NVAafD4iziMu+LGmxdEy1Vb
	 G1NeR0AyFdP2BySEHMnPKc2iSWX6ninotquUWd/MtGRZNnD00QqsgFDrgvF9M28PnB
	 azhf0+fZx6XueDSr/0SkbIscJt9TIpycaLIcRHEo8aLDBoBHNrdXzZGup/CbJap5dT
	 rnmp+aXBZFjLEi/HUWmhyDQgkgNox0gsaVEYI9Gfj6qn06tQklA0v4SZ/trobBnbpQ
	 ypSwqvq9zEHT6wGV26xd08Jq4ZAhd0y+Xg39tYDOPhIWx9FJkSQ62nrStnOZL+ISdm
	 /GcssI5adJeHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198EB3938C76;
	Sat, 27 Jun 2026 01:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: pse-pd: scope pse_control regulator handle to
 kref lifetime
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178252501581.1164679.1241502299993931016.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jun 2026 01:50:15 +0000
References: <20260624204017.2752934-1-github@szelinsky.de>
In-Reply-To: <20260624204017.2752934-1-github@szelinsky.de>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, corey@leavitt.info, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jun 2026 22:40:16 +0200 you wrote:
> From: Corey Leavitt <corey@leavitt.info>
> 
> __pse_control_release() drops psec->ps via devm_regulator_put(), which
> only succeeds if the devres entry added by the matching
> devm_regulator_get_exclusive() is still present on pcdev->dev at the
> time the pse_control's kref hits zero.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: pse-pd: scope pse_control regulator handle to kref lifetime
    https://git.kernel.org/netdev/net/c/16759757c4d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


