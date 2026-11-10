Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310808;
	b=q+DQq5PwfieEzGQpiEhkTsbm3dl11BJe/hEPH4LK1oKUX12c/lsaPc6Kcy5MXQuzvkKr
	 wBocFyiB7i5Cbu4kT5qALs4bBo1QBwbhhctgadIwIFA6DDV/npju8tWxzC3vDt1FUo0jc
	 /6hxd1juuxNOGQCMlMdgKYnUsuO2czZnLxhSosOxazH9+0NpJN+jbfHYS83wzHabBj5eF
	 A2t+jT3h4I5CXTwrR2D8yG0VoCmTwW1CMcX1Xzhu3bobWqsMG2DQBHiXWIgqHIelZM7Y8
	 2e7PEBgkyeE3vlAfoJ8rg0Mxv3HD8Z+OwsnYKDFjndaBrVMAOVRqgYBX3C4LRo5J8Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=BF8sobvU6pHeaxsPx20qKWbz7UdI4CLkFqsFTAeUVto=;
	b=IlUCfLE+Y2bOW9sbyocUhXzU9NTFKd77zDl1qvZWheZtniQ8MX6pKyPkF6/8aFJ0J3VJ
	 Pe22LsJ6pQLEslwFPujzbe35GOvBKKgJD132k1wj1Guci9WxPLqlXcbycEIqiz60pQjD1
	 vyyanrSf7sfPW1a1tJmS2xAcqeq/MWmXZk7g9r9gAtRPH2DL9L0Ifc/UZ2in0JuZ16g9U
	 qWhhT43NxOh6MAw3GeAcsGrzQt9USyqOFKq1MlGimD1wLhGz5JztrvGlIrkr0h6g7aMhH
	 GXK6nrWILrwfY3/MDD0pBWBjmoMgdC+wTaoHreo8W6gNDihAjdfenBy3IF2vGLhUDew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dz0iwzTG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC36C606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dz0iwzTG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5041F0089F;
	Tue, 10 Nov 2026 11:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794310807;
	bh=BF8sobvU6pHeaxsPx20qKWbz7UdI4CLkFqsFTAeUVto=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Dz0iwzTGEVeTJcmAs81eyOe4YNCYX7qnhI+xm8Qtncn/GTE9cxGBP8JnJXuSESArQ
	 XZV1bZNwSJU0i4tBuQk5cu8Ohvy3INVgl/wJkWHseGfGQsb057aNCdUJJQIlgJTLTh
	 v06AJhsUMh39gcEy59wabv8lsbPGt7ty4pQCtkHFwyYTxdGFpuV8qenOL4uq9lz/Ex
	 bnU6C3/1D4AydYdDOyBqloesBpZ0aWhcQwdNygitHwjJRHibfPhRmVpoiw541jsdQA
	 aUO2Nrjp2oPLkh216PSKcA+lVL+vnqe6SyB1I9Axlx3Y7pIAlXrUAniv04iKn6Uu28
	 kABI48agf10nA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E00F391B17F;
	Tue, 10 Nov 2026 11:40:07 +0000 (UTC)
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
Subject: Re: [PATCH net-next v3 0/2] hdlc_cisco/hdlc_fr: shut down protocol
 timers
 on ->detach
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179431080617.3894066.4928049084608834040.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 11:40:06 +0000
References: <20261103142015.1588144-1-lui2012qwq@gmail.com>
In-Reply-To: <20261103142015.1588144-1-lui2012qwq@gmail.com>
To: Chengyu Liu <lui2012qwq@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, horms@kernel.org, khc@pm.waw.pl

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  3 Nov 2026 22:20:13 +0800 you wrote:
> Both cisco and fr arm a self-re-arming timer in ->start() but never shut
> it down on the protocol-detach path: detach_hdlc_protocol() calls only
> ->detach() (never ->stop()) and then kfree()s hdlc->state, so
> unregistering an up device leaves the timer armed on freed memory.  This
> is the same defect class as CVE-2026-63803 ("hdlc_ppp: sync per-proto
> timers before freeing hdlc state").
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] hdlc_cisco: shut down the keepalive timer on ->detach
    https://git.kernel.org/netdev/net-next/c/27e25418faf3
  - [net-next,v3,2/2] hdlc_fr: shut down the LMI timer in fr_destroy()
    https://git.kernel.org/netdev/net-next/c/d8186bd919e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


