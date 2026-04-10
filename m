Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97434329C7B;
	Fri, 10 Apr 2026 03:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775792442; cv=none; b=O4oSA53moCzwJZyIzweF43WlS3ixayhSA/NynQi23nj6+zbrwX1UqDveXwGrwsRpy9y9P5zEO+EenaVvt/wQgsYPkaCs6sYW74aZ8RF5nSGWZ11j8Ic4Jp7RfczAD+N8qOv0E7apTv6Qv9XDpFHRzz3mwPd4cSlhvqxwWsCkPxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775792442; c=relaxed/simple;
	bh=aXzlY695ELQLeU8wOevQrLZVVyeNKLQhpUaT173Mz/g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lDICkg6q+2OdYzUUwQ8rGcKtDpq9RHVadCEy0jBQwEs1AAObuTjnXDltRcFPNiAtb7j2/VdxPtdVL0KEIPF26O9I82kCIbCVkLcUwU6771K5LL/heDkoY9OznxQPNHG6GkI046JqACMiQt1i8CBc6yKlUV+WYZ81eohPPu5k2PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxSl24sa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxSl24sa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710F4C2BCAF;
	Fri, 10 Apr 2026 03:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775792442;
	bh=aXzlY695ELQLeU8wOevQrLZVVyeNKLQhpUaT173Mz/g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uxSl24saTb3LDCWbCsz21C2h45sXpJnunRGGlE8br3RIA+uXjibidFtNBlL5KdOMy
	 MdaCzJpYy6/U8NOOMLFG9zXFXk1VBefVyclSsd3iJZOip6rGyIbzl3rcP1wVRGaSPz
	 tSeTvCv5Cqvye0guLBj7K73ZkDZVNH4CTeDI7KMzpNYyRT83uhKHBkyWTaa0adYHr+
	 xrTpzB8iNZmi6Adargh6cazGbXv3VZuxBdHY8yCGKcCG/My43TTl89+RKFdnVnYDRO
	 qwzeuy6a7IZbZDU6DTDJrhBh1FN2mRnYmuQevlgu9nVr6FNMnGI5yfMyHiHTKyBUrb
	 CagM40iE445rg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EFC3809A22;
	Fri, 10 Apr 2026 03:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: txgbe: fix RTNL assertion warning when remove
 module
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177579241729.1854480.1241266241288314093.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 03:40:17 +0000
References: <8B47A5872884147D+20260407094041.4646-1-jiawenwu@trustnetic.com>
In-Reply-To: <8B47A5872884147D+20260407094041.4646-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, mengyuanlou@net-swift.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 Apr 2026 17:40:41 +0800 you wrote:
> For the copper NIC with external PHY, the driver called
> phylink_connect_phy() during probe and phylink_disconnect_phy() during
> remove. It caused an RTNL assertion warning in phylink_disconnect_phy()
> upon module remove.
> 
> To fix this, add rtnl_lock() and rtnl_unlock() around the
> phylink_disconnect_phy() in remove function.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: txgbe: fix RTNL assertion warning when remove module
    https://git.kernel.org/netdev/net/c/e159f05e12cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


