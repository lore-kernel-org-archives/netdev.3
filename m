Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983BC27F01E
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 02:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774059618; cv=none; b=qvwtytIjz7V+CUT3gXz0ABw7vIY/OTkgWruK+deTafz2MV/3Ph8VJNH9E2i3ebfopupHHl4k2H38vumcPKEsTeifG+5vm4Hi5n8URzbdzJkwmB5uhPXiBn6XcyMiiQgy6uGUg2Naa6vTpCde6LCz3Evd72eRIAf1zMxbeQ7/PBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774059618; c=relaxed/simple;
	bh=8XK0wUdT8yBLDgwkKrmVOEcoZbGtB+T8NiWU3LLni5w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a4IRwcPvFD4AvjLoiZ5osWs9Y7JRlZQvtSfgS9MpSGHRiJupeFQSzKx8Mz6poN65o+zBrLeWeN2+we02pT1LEg9XX+QiGRSBJ/qAePc2nBspHO1M1V03ftRZ5fJDaZjHxfE5vaV4hW5e+FUZzRTYiZrv8PnDWN/1EwzqjSIQiWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZuLOIvV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZuLOIvV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DCCC4CEF7;
	Sat, 21 Mar 2026 02:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774059618;
	bh=8XK0wUdT8yBLDgwkKrmVOEcoZbGtB+T8NiWU3LLni5w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hZuLOIvVczZt0zhkTW3DHvDRsIfpEv2txXz3QHBv9IXFcbxWTTup+E0WCAX7PjwnU
	 0GrEDScPkv2lhebjtNc2+xpapBZ23gc6PIek+S+Eto5d70/HT7oaP7ggSTPY+oKqsw
	 T3z6/e6g1YMewSgFPlfqP3MSOKSB/lrM3LunRzHSsBSKhOZmpGsZUjuJ8N3MnnQkC4
	 xAQxn2VPqxypLT/C28FDTIm3pjctSdmkIMF4h0z6vcAKa8RcKR8ep14W6vikKo0Ziq
	 amsMV56ltz+1i+kq4p29VAN8BlZJcFZL5I5jqqLe0LpC+XTKTEooggSe8yq3hXa/Rn
	 AF1ugBgjfBpLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D1E53808200;
	Sat, 21 Mar 2026 02:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] net: bcmasp: Fix issues during driver unbind
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177405960829.2725242.16339301448912324002.git-patchwork-notify@kernel.org>
Date: Sat, 21 Mar 2026 02:20:08 +0000
References: <20260319234813.1937315-1-justin.chen@broadcom.com>
In-Reply-To: <20260319234813.1937315-1-justin.chen@broadcom.com>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, florian.fainelli@broadcom.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Mar 2026 16:48:11 -0700 you wrote:
> From: Justin Chen <justin.chen@broadcom.com>
> 
> Fix two issues when we unbind the driver. We hit a double free of the
> WoL irq and a double disable of the clk.
> 
> Justin Chen (2):
>   net: bcmasp: fix double free of WoL irq
>   net: bcmasp: fix double disable of clk
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: bcmasp: fix double free of WoL irq
    https://git.kernel.org/netdev/net/c/cbfa5be2bf64
  - [net,v3,2/2] net: bcmasp: fix double disable of clk
    https://git.kernel.org/netdev/net/c/27dfe9030acb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


