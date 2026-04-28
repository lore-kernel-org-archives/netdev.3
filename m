Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF3F23504B
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 00:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777337458; cv=none; b=eIJBw4hnGsqLc6rWIUtp3CDHaJZwGo1VzBNUDU6VSjZHZqSgCmUDixGvDTTG3C+28pTy2aP77G5JqrHhB5wnJMNtdEjPGcMRsyklB1gw9PG9sZXstmqdbnM3LQPvdUwQXskghYVZ0hoDBDlytACAZZpT4fqzf+srh9GvYdrvoEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777337458; c=relaxed/simple;
	bh=4u3fOBLkg7bwwRHn/jMjMp3yIXtsrAn3Pp1vO36pLtg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uxS5k4CDqgzpzctfDGDWgCezaezRELkwamP6vLSnnq0luCmt3AWgxQa7UZL8cJly6p0WRkKt3NJNlB93t0RUnfwFAAG7oc8JN1N7jrOh/tTy4fBgTaTu6ii/GEof0Dr5TPA7Jpp7asHJ29D600ztABnGLzGlDmsIYtfDtmJdDw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YN5CLtgK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YN5CLtgK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B81C19425;
	Tue, 28 Apr 2026 00:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777337458;
	bh=4u3fOBLkg7bwwRHn/jMjMp3yIXtsrAn3Pp1vO36pLtg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YN5CLtgK8FNnYdReLhkkdpjhySnXvwSBYBGBI/n45z8BnDJwe18rd6OEsCQAsT5Ce
	 ZnoqHNzwuYkZzNEs/208yFmj138ZMFA3194VEmfhqkuwBG4sL6xCnjFzg0Of2iWrWP
	 DPZQ+/s8lobpFMJ/onVu7p1AvdiSTegiAFdPrraDZFOrK+Q6jlxwReuPIFcFwpVQgr
	 8rILaZuRs0bCrW+Op1NNqM8bx879M/EM5So53N1obvTnrlMmoCJqKsAHTfNx+bdLy/
	 JcKWHIO4NQ0SW/sJm9Lv8kQwdjStdvrJl1gQLtiWXgsh4bkPZBl4ZKPeigrNxqnfr+
	 6I61tvo9dFS0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E5338119DB;
	Tue, 28 Apr 2026 00:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: Do not read uninitialized fragment
 address in airoha_dev_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177733741530.177472.9248284506411567966.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 00:50:15 +0000
References: <20260424-airoha-xmit-fix-read-frag-v1-1-fdc0a83c79e8@kernel.org>
In-Reply-To: <20260424-airoha-xmit-fix-read-frag-v1-1-fdc0a83c79e8@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Apr 2026 11:00:28 +0200 you wrote:
> The transmit loop in airoha_dev_xmit() reads fragment address and length
> during its final iteration, when the loop index equals
> skb_shinfo(skb)->nr_frags, at which point the fragment data is
> uninitialized. While these values are never consumed, the read itself is
> unsafe and may trigger a page fault. Fix this by avoiding the fragment
> read on the last iteration.
> Additionally, move the skb pointer from the first to the last used packet
> descriptor, so that airoha_qdma_tx_napi_poll() defers freeing the skb
> until the final descriptor is processed.
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: Do not read uninitialized fragment address in airoha_dev_xmit()
    https://git.kernel.org/netdev/net/c/bde34e84edc8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


