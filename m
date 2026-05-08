Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BCD377EDD;
	Fri,  8 May 2026 22:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280657; cv=none; b=eKycYiZUTtrmMpL2IgjSK2FSerdjGochTF80XyQ5IBav7aAK6sW7NPnx+25q4NonSPZNPAncpEpOJiypf6E/EHsbqReUjwpIe24+J+xm0K66YntcuRH1mAxfaO8SW7RViFAIWKXoIaVHi/eGfiBXcgZ1+APLNnFWu7u8EvzzPoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280657; c=relaxed/simple;
	bh=MPh1d6oFUV5JHfG0QF650MwQ9Wo9IgpRIALDr5Lp0hw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lvxZG8O6A3wPnTaM8F/Jl9Evu+sMJUJvyQYtNUlDFURMl7JaeSG87exPr+4TwBwp5gn3NwnU/SCV1v/kVkQl7iNfd2atPtMk/QnQTRxOfqMWMEF5ybim0Es1NZ+dkmkYhNNJoPS0DYbdUo/7A7Dt+S3CdLSUkUOdgk2bDhpu7T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nkllh9it; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nkllh9it"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F821C2BCB0;
	Fri,  8 May 2026 22:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778280657;
	bh=MPh1d6oFUV5JHfG0QF650MwQ9Wo9IgpRIALDr5Lp0hw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Nkllh9itxSNEWAnclSbsJkT2H8ErGJNRCPuCMQl+anKw/uTWi6AG4Zr7bh8B46yyL
	 0wJpfdBcDxKXCZu/9E3HPq93Gvv4T8Aa9SpA+CQGztnT4ZjLlXA1IDis63+bQdyxPS
	 2gZ8NSyACJE6E7AbdRmscwiSaNZlN0D5PMFALmtgI2zqO/e7vVWsXYjQzvuntPYVt3
	 JYPtp7LYlXcdsjXeZaC0382S/q8a+F//rdRgoxzTQoqloIlkuCIFjlI7CMccLE30+T
	 jkM6saW7pF1sZpgDNY+85EvqHFqGSacXLzQtjMvnXTmlOLbU352QxeuVdt6Fku28EC
	 Kd55Vv5u3E0Dw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F1D38119D3;
	Fri,  8 May 2026 22:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] genetlink: free the skb on 'group >=
 family->n_mcgrps'
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177828060530.880817.15926150905197144874.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 22:50:05 +0000
References: <20260506-genlmsg-return-v2-1-a63ee2a055d6@google.com>
In-Reply-To: <20260506-genlmsg-return-v2-1-a63ee2a055d6@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch, mmaurer@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 06 May 2026 20:07:13 +0000 you wrote:
> These methods generally consume ownership of the provided skb, so even
> if an error path is encountered, the skb is freed. This is because the
> very first thing they do after some initial setup is to unconditionally
> consume the skb via consume_skb(skb). Any subsequent errors lead to the
> core netlink layer freeing the skb.
> 
> However, there is one check that occurs before ownership is passed,
> which is the check for the group index. So if this error condition is
> encountered, then the skb is leaked. This error condition is generally
> considered a violation of the netlink API, so it's not expected to occur
> under normal circumstances. For the same reason, no callers check for
> this error condition, and no callers need to be adjusted. However, we
> should still follow the same ownership semantics of the rest of the
> function. Thus, free the skb in this codepath.
> 
> [...]

Here is the summary with links:
  - [net,v2] genetlink: free the skb on 'group >= family->n_mcgrps'
    https://git.kernel.org/netdev/net/c/efda25ee8432

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


