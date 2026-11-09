Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794189606;
	b=HHoqQvMHWI1AwKIEpMYNqa1OmNst6Mopbko2OJ2mBkLEy8i4aTp1b4hLZlqnHZnpQ9kc
	 AxAJfn0fUAfWbNFnKlgtETTyrOLB8zK4gPucm5iXHk64aLMaedpTrvRy6aOOf1tuXU4h8
	 lL8FqNDzZ6kHdE7X8Q3kvOYks8zhNCSPewcOiyqYJ0kvsaujxjsgMdkWQ0sd2EEtv4/NR
	 RkyKLN/kmrPMAvayse0l7rkjmWRXfSC1CgJvqiU6oDB0ROt55YyzlE18rHFSDpu1lWxY1
	 /RzfL526PKnfZ7GZFayAsJjYTY0Dazsfsz+0ZcRxIZZ3WWbFV/0bCZLwbX1Q5iVdyDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794189606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=4O7b9maEIF1lUn+r9vtV3zrFTuCwJwOQGcTwpTgyKVI=;
	b=gDj7RZpfu4UcvpaiBq26RTjL6U5ZMIauipj2z3YF9K26qdzOTlZbephbUjhzB0+aTCik
	 +xA+m6dCGVrT7cet0MXDN+WaOh8E0XL3aui1nP/aPoPgiD3qB7Em+b5AugkpCod92lpzB
	 7z5J2UlrCQj38SCYoiWJqA3C2DIvux0EZaKAwmJ9DauGU0jHi00tI3k38eG9x5FMejPB2
	 jCziZqQYIbE3pS0748lbpPgAZUeLWMYKpPoc4v1c2yhza0CF7AtwIwWWMk4LlFUX0AGzl
	 fK8NirM6p2oLG8B7adx67nEZffoPxQthjeS7l/IinHuwz+ZwPhfqht2bmIZ5Jku0grQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U0aikYsZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54160606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 02:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U0aikYsZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F321F0089F;
	Mon,  9 Nov 2026 02:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794189605;
	bh=4O7b9maEIF1lUn+r9vtV3zrFTuCwJwOQGcTwpTgyKVI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=U0aikYsZvgN/YQC4n54yKqUUjojwWKk7VoorpAr0KCPXSrnnZbyJxdG0CG/PgnmlG
	 C0B+Ujl4xkpxzcHltSd79WWBR6GPhWvE5YhI0tHZJFvl9TtTSroy7MYQ2FpF728fIe
	 BIL+kNZ10tU3KtgclMW4dhWktxx9jrnUHPnx9aLnN+XP4xW3zOuSTtwUi1C95GUj9n
	 NiT94o1gCa3eEERikcUkJ6Pu86Qq6V2eeTb8Y8WIZ45kijns4jWMtpTAPeR+Fb4Z8h
	 RWkDlNG0IY0al4CT3Phjq2uMllRWHp4AAzAzyJ39qyb5RC9v1uxaeJlPNt+fFilyEf
	 JcQyZqT/TCCew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D82B4380821F;
	Mon,  9 Nov 2026 02:00:05 +0000 (UTC)
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
Subject: Re: [PATCH iproute2-next] man: ip-neighbour.8: document protocol
 keyword
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179418960467.2493343.2506764682205641354.git-patchwork-notify@kernel.org>
Date: Mon, 09 Nov 2026 02:00:04 +0000
References: <20261104121702.56526-1-prijeshpatel.dev@gmail.com>
In-Reply-To: <20261104121702.56526-1-prijeshpatel.dev@gmail.com>
To: Prijesh Patel <prijeshpatel.dev@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org,
 prpatel@redhat.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Wed,  4 Nov 2026 17:47:02 +0530 you wrote:
> Document the `protocol PROTO` keyword, which tags a neighbour entry
> with its origin (e.g. static, boot, dhcp, or a routing daemon's own
> protocol id) on `ip neigh add/change/replace/delete`, and filters
> entries by that origin on `ip neigh show/flush`, including the
> special `all` value. Supported since 6b83edc0 ("neighbor: Add
> support for protocol attribute").
> 
> [...]

Here is the summary with links:
  - [iproute2-next] man: ip-neighbour.8: document protocol keyword
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=d95f66508b32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


