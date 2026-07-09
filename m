Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884EA4014AA
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590652; cv=none; b=OvSITG6H7omijdp5lsAvIvt4SmvUFLYz2Bt2+WSniFs/pVCOoUuJtJaVw7R7DVP58ux1XracFf2rVnyReqExdT6ddCz63YJdzXf/PzasbQUFBvJ4WKnntQCsYjE+zUbZYhzVP6b73hY1R0ZfSfV7+XTExnd+aE9RScVGTzepEdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590652; c=relaxed/simple;
	bh=3WW68cR3PpAaNDNQmwLx2kQNym8ESUmbz5A6dyo4gPE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pGDa+63kv9UuqPF8vBMpnKPhhL0iXiYhoxZ4FcPW8kHJ4IptkIgfe+FbZ3G+OqwTtUbIxm1PMBRIBdtEWLYB9LSVLYd/422A+ReVTbVGREXYMQUpdkSQRlxsqEUPfrc8fnv3bZ9arJiwJgBs/xSNeVX8Emq1IOhTil8wuAE6iiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCw+Mw6l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCw+Mw6l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D981F000E9;
	Thu,  9 Jul 2026 09:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783590651;
	bh=xMBiQNR+YhGWbWwIZlbIoDiHmoM6ROWNTprhVM8gtp8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HCw+Mw6lBYdS/qo02nvfiZe/4JS+7BDdO0ET6VzOkA3/nHdIgkRZ0XoZMeVDeFclU
	 3CjlVuDsqClCvWj25O+OTR9q1I9JF/2S6u5Kua1J2/i5eJZEwBVuyj8uJouTg1rAhf
	 D2SXHxl948nljqpWrcrtoR1BtnOFI/Kny0fiZSqKJXPSX+crOuLYHG3l79rR+vudK3
	 W5TXo7PoE3RtPtJPqDWQhChwy2F6xf0zJ5YBlS4cgOPTlpDH72mA0xEGdBXXdkUnPu
	 7LF+ONXD4IFxdWug1M2WMvEUmY2ppWyLEbgZBOs0MyivjSn2JF2Ph+COOiclJfr2Bs
	 o0mQYo4nws/sg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A42393A57D;
	Thu,  9 Jul 2026 09:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ethtool: rss: Fix hfunc and input_xfrm parsing on big
 endian
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178359062964.3372474.18117015857680043750.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 09:50:29 +0000
References: <20260706055017.3355806-1-gal@nvidia.com>
In-Reply-To: <20260706055017.3355806-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 andrew@lunn.ch, horms@kernel.org, dtatulea@nvidia.com, noren@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 6 Jul 2026 08:50:17 +0300 you wrote:
> ETHTOOL_A_RSS_HFUNC and ETHTOOL_A_RSS_INPUT_XFRM are NLA_U32 attributes,
> but ethnl_rss_set() and ethnl_rss_create_doit() parse them with
> ethnl_update_u8(), which reads a single byte.
> 
> On little endian this happens to read the least significant byte and
> works as long as the value fits in a byte. On big endian it reads the
> most significant byte, so the requested value is parsed incorrectly.
> 
> [...]

Here is the summary with links:
  - [net] ethtool: rss: Fix hfunc and input_xfrm parsing on big endian
    https://git.kernel.org/netdev/net/c/b62869a81a7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


