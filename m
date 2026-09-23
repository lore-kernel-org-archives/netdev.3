Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D763331EB7;
	Wed, 23 Sep 2026 02:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790128890; cv=none; b=fhFFU+uAOAvYefItadUjB2aCW7+1tQnTr3IeB72FFGIaaITFIi0TWaGNTyFjbRSMOjGv9gWZS9wL7dOiBjtEF6no9p+rLyFsnqJB+EJJwIPfZ3LVNHqDGSgKtvxMuLd5EeDgmdUhzrQylKrDfCvh8LGsQUT4aOmAG2FvydoLc2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790128890; c=relaxed/simple;
	bh=tNTG42ZIy78PN9+ZrwM6qIyRNTasmC+Jj9HKNPxouww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dxp1QSa0FQBCi4TskTAgJt7P/sYqbqcIAr6Y9fxjDC1x3J/m/1byoIzeWeEatZX6UnCBqMkOvgfrhkHFi+3XRElksvuZxLkhQMhZJ82TrUzYdxeGchRQvOZMsDq18GY5iF0149nIYOnQFEPSdR4ZOXi7O8wak3qsWdokTDQYLbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5RYFte7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5RYFte7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C701F000FF;
	Wed, 23 Sep 2026 02:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790128883;
	bh=cjVf/BP3sAKxnxVOhWV4Vm/Ia/pnCYn4LG8MN74Ip5o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=I5RYFte7Ap0dD3YfNZL6idCCjaG2RMFjSDkkcyGTF0WMRjhwFaFky3xP30OJp6TlS
	 3Yipd0hkJuvucgNx6jcZW3xw1rlzjkZCdZotKzNk9Pw3m/Ih5EFl/PEmoz0oLRL60n
	 ZYKyuMegtOV7c0Pql9s50xWNhFBS50cgqhdZHNiHhneUdm7PF/ogoybey0z2TlWE9m
	 V6Go8FdX7WbwbhqFDBiyamxV3K9utK5m/qjZ21FzU85yyfHLqR23XFerywdc+5bJ7u
	 U2YTmLPRBOarFre7IZzxI/ab+IMEbNRH+1OnuoTFeYugiTUS+fX4blOjfU3rPV3+UQ
	 Q2bjXtSREI+ow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B2C3924472;
	Wed, 23 Sep 2026 02:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] eth: fbnic: Avoid rounding zero ring sizes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179012881389.173471.9124331643235118175.git-patchwork-notify@kernel.org>
Date: Wed, 23 Sep 2026 02:00:13 +0000
References: <20260918114641.1281172-1-bjorn@kernel.org>
In-Reply-To: <20260918114641.1281172-1-bjorn@kernel.org>
To: =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 mohsin.bashr@gmail.com, mike.marciniszyn@gmail.com, joe@dama.to,
 netdev-bot+sashiko@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Sep 2026 13:46:40 +0200 you wrote:
> roundup_pow_of_two() is undefined for zero. ethtool permits a zero ring
> size to reach the driver, where the minimum-size check should reject it.
> 
> Leave zero unchanged while rounding nonzero ring sizes. The minimum-size
> check then rejects zero deterministically without changing the established
> behavior for other values.
> 
> [...]

Here is the summary with links:
  - [net,v2] eth: fbnic: Avoid rounding zero ring sizes
    https://git.kernel.org/netdev/net/c/0160953d8eec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


