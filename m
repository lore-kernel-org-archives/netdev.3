Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB32E263F4A
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770306007; cv=none; b=HZT/RBci/q54BehdBZwyS94QcaugeYcJUcRQAQeWWW0TDqWI7+nXGb0FwW2vMLroFOBTZY8kFXw1xZdGDqW9TlR6icmU+zNuWDZB9YkjP0JDGPwJddxw+HoDuGd7Di5C5J8aT+eueoxK86b06xW7oeOlpDTHICv2Gvjv/UbCdUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770306007; c=relaxed/simple;
	bh=UJOPREeqZrulHVwrnsw1zB9Ji+r91GdOFxYwIwR5y9k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ym63Li1graCJysSR/MI+Ay2uq8iQ5VE/GZKQlIqKzxoaLc3y5E7XyeohGmHGmE+dOG/HNYrphBaUxaD9y3gLVdrdb1tGXicuZtKdPI+Z2+iNDU0OYa7gobNhHLl6wC4IrqXEvxn7BNtRQUNAG5peYvWXxz7RMbuS4WJepyJMegA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVwCE8rP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVwCE8rP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4A2C4CEF7;
	Thu,  5 Feb 2026 15:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770306007;
	bh=UJOPREeqZrulHVwrnsw1zB9Ji+r91GdOFxYwIwR5y9k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qVwCE8rP5xTppzwlbMSMpO5jmu3BSvTBHTGkG3sM4HJBTLwg3Kk1JUg4d/HZuzXMp
	 nQSljl07YREwWAkf5COy0gVtQw6WSc2qaQ7gJ1be4Lau2Mr7hTPVfsTiv2l926JRah
	 c3hkm916aPDAY6k9NW9RndkTpAlUXr539vsPG8P76Jl8ixd7cFdZvhlQPeHmTte8c/
	 WTwZ5pDBxWttmvVsCcswPInxYgMvlzM/1JYGNU0XYI/EE+jEQKy0mBqr25bdFXEFF3
	 kAMSlshT+XGiyh+9TqvjJKYhhhFKxrxI+VlgpabFysR2rCmZWGtIp4j2EcI+08VYOS
	 TQYvdHvZvqoTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4857F3808200;
	Thu,  5 Feb 2026 15:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: add vlan_get_protocol_offset_inline()
 helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177030600508.457708.194857151276798513.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 15:40:05 +0000
References: <20260204053023.1622775-1-edumazet@google.com>
In-Reply-To: <20260204053023.1622775-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  4 Feb 2026 05:30:23 +0000 you wrote:
> skb_protocol() is bloated, and forces slow stack canaries in many
> fast paths.
> 
> Add vlan_get_protocol_offset_inline() which deals with the non-vlan
> common cases.
> 
> __vlan_get_protocol_offset() is now out of line.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: add vlan_get_protocol_offset_inline() helper
    https://git.kernel.org/netdev/net-next/c/7a4cd71fa451

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


