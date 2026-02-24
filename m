Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350FA36C5B8;
	Tue, 24 Feb 2026 09:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771926000; cv=none; b=UBe8K+ldtliResYfuiG1i9iiog/cdmDlz3a2APUehdS2UNvz+Y1lIxRItZh9XEGV3amJSRQVtfr0IXFwZjJpwhFdN8wmxXzZ+/lOF0I+OJKNCg/h5B+Oy+HEL/nXqNPvDDeK6ayrPvf7oaBo2JSDX0riJguYAsJXnkLb3zQSu0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771926000; c=relaxed/simple;
	bh=3iuNubO8BP4ONayibakgKuxtNEx1i/qtGPJCat4KKoU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gVMjAxb89uuOD9s6afXtKHuFW3uGwUeI/eAnkhKwqjTkfyQqhgsF7+LltKYoz0s/+U2qJYLoHfYc+UPcOcZA0uJs3ealczLw29kopLEEw9KU5T7UOu1JfG7r/Sx6ZBY+BVv4z9tu4HQ4hL2otXifElgi3BBVe7I8+l+eb91u4nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stGvJM8j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stGvJM8j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EA4C116D0;
	Tue, 24 Feb 2026 09:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771925999;
	bh=3iuNubO8BP4ONayibakgKuxtNEx1i/qtGPJCat4KKoU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=stGvJM8jEbV2L3vYcuUzBkm6ap/YzTbdiUzv5G3nzOyUNIJCocBppHwNgTQyAZESy
	 ILzW204k027ksB3rC/HRaA8qKvwJ9N3RTiKSbiX73BIS3imEAU7mF5ndYLcvXLRoDM
	 4U5si0zONXF9XzblWcLsSqJOMGmVoJLrSk1tYL0gUS26jzg35f49JLTfVxsyM3PwTh
	 CuD6KkFV+TS5jAOr+g1ZbGuGwzVIjK3TzfER0PAuqgHgI4f2Qtg6ht5eahT1d45g+g
	 ePISvX28tZ0wokLORalkM0HUKQXpoUI3HtTVNAPBYqA8c4Y7Srhv0y0EoY5Jk8LRwz
	 E03HDe7VHVk3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0EF3808200;
	Tue, 24 Feb 2026 09:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: wan: farsync: Fix use-after-free bugs caused by
 unfinished tasklets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177192600555.3415379.13624523743993789507.git-patchwork-notify@kernel.org>
Date: Tue, 24 Feb 2026 09:40:05 +0000
References: <20260219124637.72578-1-duoming@zju.edu.cn>
In-Reply-To: <20260219124637.72578-1-duoming@zju.edu.cn>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kevin.curtis@farsite.co.uk, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 19 Feb 2026 20:46:37 +0800 you wrote:
> When the FarSync T-series card is being detached, the fst_card_info is
> deallocated in fst_remove_one(). However, the fst_tx_task or fst_int_task
> may still be running or pending, leading to use-after-free bugs when the
> already freed fst_card_info is accessed in fst_process_tx_work_q() or
> fst_process_int_work_q().
> 
> A typical race condition is depicted below:
> 
> [...]

Here is the summary with links:
  - [net] net: wan: farsync: Fix use-after-free bugs caused by unfinished tasklets
    https://git.kernel.org/netdev/net/c/bae8a5d2e759

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


