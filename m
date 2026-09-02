Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF48531F98E
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 00:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309476; cv=none; b=kixVOhWEr/8tvo7PeT82JixT9TwhR0pg0ysU1d5S7oPJxMdTwPz0uz7KqQgJy/JvyoCesJlNhIyFMkP7V7Unymf9o6E/bVaCU/U2x6VkucAIKVj9maCaPkmNCka7Ibc9As/9+4Q3oYQhsbGL6lw1TUQQVcE6VUb1s+4CB96oz3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309476; c=relaxed/simple;
	bh=3rSdOUOdLQA/CjRbON5DrDieFxFyrU9ZigMwarZEAXA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GgNQz2OlhMZyOIMPZL4Amt0ssnwbmvk3qv2XSSCcT6w9DFpKaHR4qAvGljkFkr1nvv7VFQacNL5ZRSK1Ki36NcVEAMCy2uj+B+KRgtvRym15gTbWF1ByyVMnxsbi6y9H/cKT+z9yI0CopmbFymESemCrNW6pDoLFXIVIke7t/EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBnh4x4U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBnh4x4U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5444A1F00A3D;
	Wed,  2 Sep 2026 00:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788309475;
	bh=P/beyfgHiYkD7yccJZSIUoACqQjKs20K1T83Efa2pZk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cBnh4x4UW0FCcet7VBeA6mDe/StJNU3dlWCcF20YdlK5gOycpPp4x3wAkcQfI1Ggl
	 SakjkzO5wgG4fLEByVvX2QyQ4P4D9AM/XKlUr8sXNFEutDVJGLn1rz976fKoKkkoqO
	 ac33FZPueJR0EWyrDqdBg1OnaMK+VCOkOX453UnxbPSKFbpR5O8T6FnobZYyJEQYcC
	 DVNWSxJ1bjnbG9ZE9vGxREXI+xRyDcUosud3VolyMu6PZ1K2WG3tDlMRLHcoUlEYSF
	 fKBNgCsXpV7ZiIXG/wAfb98sdKithSUOv6fbnUtweBM/vwQjkqgibu0XuF8TOdE6lf
	 mOC0Qn4lMirVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09F83926244;
	Wed,  2 Sep 2026 00:36:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: Prepare skb extensions for reuse across
 scrubs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178830941739.1844276.786807530247881380.git-patchwork-notify@kernel.org>
Date: Wed, 02 Sep 2026 00:36:57 +0000
References: <20260831-skb-ext-prep-work-v1-0-ecc2a8542fd9@cloudflare.com>
In-Reply-To: <20260831-skb-ext-prep-work-v1-0-ecc2a8542fd9@cloudflare.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, fw@strlen.de, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 jk@codeconstruct.com.au, matt@codeconstruct.com.au,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 kernel-team@cloudflare.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Aug 2026 08:27:37 +0200 you wrote:
> Following Florian's suggestion from the discussion in [1].
> 
> The skb extension allocator retains the extension's offset after the
> extension is deleted. This, in theory, allows skb_ext_add() to reuse the
> existing storage instead of appending another copy when an extension is
> added again.  However, it also means that we can't rely on the offset as an
> indicator that the extension is present.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: Make skb_ext_put_sp() idempotent
    https://git.kernel.org/netdev/net-next/c/d7470cba6dfa
  - [net-next,2/2] net: Make skb_ext_put_mctp() idempotent
    https://git.kernel.org/netdev/net-next/c/dbe45b209edf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


