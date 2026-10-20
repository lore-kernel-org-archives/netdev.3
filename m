Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792459811;
	b=k/p/Dz2FQalZcnP7uDiDHIOXol+3hoNuGL7QWFd+SNIDSc5rqKXzL/ObXHpbqwMwmViz
	 aLDVjuXrQAQC4iL6pY7ZvsuDlHqnGFk3/6DDBeZZ5ZPHbcJSlaqMMpPUqDbjcdEI6mEKZ
	 d5kdG+BZM92q7+8WIlh6J1CDpmAhqEeTZMyOakBp9CclXcvTSrLTbnXW1NrqTMTy/3yoy
	 yBZtoW88w4eutydvmsN0vlFNTffnXCLJjFsIebzUFwJuIDuhQtiRS7FgmZZSBPiqKORYy
	 cDDcz0LVrP1SjpgyKtCk6xgfMOCodqPx7K163CUtMGUDQfXMO8EvUBKGheAHNO0yoXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792459811;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Nr/CEPOzBBBJCwa/nOw7aYctJE8L0LWSYjvBLUHHXPY=;
	b=3yl0R8bHVGC0NnUlCGxzDy0TkprPlZec/hzzMvZPnlr6T2wzHT9i1/6Nwz6/PtBcjbp5
	 0MpDoptpFS11G+XMef9DW2Y6/C6XVWlCcriuZPC9Prq/I8jVxR2TQCIMMci7cZZVSnG+l
	 1/3Fv8h6UVRNJ91WOUe75CJJStEKxgMg7PPm8mris4o2yvPOSYcIoyuhLwF6XEhSNj4gM
	 /cpZW/+Sse7GdfHN22wHLNfd7zZ8hhxkbxYCHwnxS5Or7rU8O/qxut0EV+MmUTvW5V3y7
	 rRGdGf6GKGK+8fen1JRSNUhFftwZ7+Rj9hkEbsZVZfc2uED+sOCH3XDqpct5pq/N9qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hs4TBmWI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4A2606A326;
	Tue, 20 Oct 2026 01:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hs4TBmWI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FA11F000C7;
	Tue, 20 Oct 2026 01:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792459810;
	bh=Nr/CEPOzBBBJCwa/nOw7aYctJE8L0LWSYjvBLUHHXPY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hs4TBmWIMGctWAukjihukJ7atoeVBirF/LnPAu73mOyajryQCXsDFMf0d+2XO72qu
	 bjG2D1Zh5FQ3e1DSdbjvDZ1NHqH2ogFtItObFiC0AMeS5ixGEskHkP0/5usG22DNL3
	 3YMnsJxOLfYIKlx5VDbb4vsUl5ZDEVVG053ehoo+ISqgd5gQDSp16GzDWJm8gABkoB
	 7XQUwiG0cYoex+PAwHzS3T0cjZqaNzgbdgthAFVDhs2yt5erMGRWYVZrk+pWMRL17q
	 wwjIX4BRiAX49ilMn1knt4L/KyCDso2wxwsS7/LdRuyTV6ZfinskX/XUlqZGzhGkuH
	 4lAbjsd0an9bQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774283924A6F;
	Tue, 20 Oct 2026 01:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2] net/dcb: Validate bandwidth for non-ETS
 traffic
 classes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179245980903.3422113.4762636508765499257.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 01:30:09 +0000
References: <20261011083929.739261-1-tariqt@nvidia.com>
In-Reply-To: <20261011083929.739261-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 alazar@nvidia.com, cjubran@nvidia.com, gal@nvidia.com, kees@kernel.org,
 linux-kernel@vger.kernel.org, oss-drivers@corigine.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 11 Oct 2026 11:39:29 +0300 you wrote:
> From: Alexei Lazar <alazar@nvidia.com>
> 
> The IEEE 802.1Qaz standard defines that bandwidth allocation percentages
> only apply to ETS traffic classes. Reject ETS configurations that
> specify non-zero bandwidth for non-ETS traffic classes.
> 
> Placing this check in dcbnl_ieee_set() enforces the constraint uniformly
> for all drivers rather than relying on each driver to validate it
> independently.
> 
> [...]

Here is the summary with links:
  - [net-next,V2] net/dcb: Validate bandwidth for non-ETS traffic classes
    https://git.kernel.org/netdev/net-next/c/0e36a335c84e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


