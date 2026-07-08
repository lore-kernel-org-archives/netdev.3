Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7EC322768;
	Wed,  8 Jul 2026 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504228; cv=none; b=NNEuOZVaEWKS0Cj6jby1ClwB9KAeQP9qOivkNNhxMRimM/OmaeREEq7MFnvjVA6jvub4iVjdC9bDzjY2bZRwXg0G7HXsF0bAZJiCP4/oRwQgqzm4K2FrbuY0BQYFgpf2l+Px5uOegnGsXV8YERBB04YcbmsUsAs8/vbNm7cLg/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504228; c=relaxed/simple;
	bh=iy35GBWFC/MrIA3370XuDu2OpM58GQ4Uc3qsS8cBalY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FrvGUmat2ENoVgdjxFKsVszA+BXL/b488B2P7kSy5AqAejdH4Ldi6PPRFBGy6xL1rXs/55wrI3mlBDKvqjPblAErx7yJyGJOfrStpEV2TfWKyYvjyqft3ATy3TSky8xYExRqliWqtIWftwtfdZ7XhZr19jN3LJZVgincrdlTkBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9SrlQfH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9SrlQfH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19091F00A3A;
	Wed,  8 Jul 2026 09:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783504226;
	bh=/BuyvH1dcxTv4VZSu0HO7PZC50NBeOGm81a2slkrjoY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=V9SrlQfHOhqF0FHD6ZdW4xNfsEvuwrbzo3VE0itsZ+4Tj1SCQlDaIvBFpxOK/zynQ
	 gXlyMen2zUGcod3/+EuS6zN1jOoRjOJ6NlY1HGzsINLhsa3w0lIvOZRdlAwcmGFwiy
	 HC9Kxke2uvJWFAWH2AcZ0fP+y4MAmy4TWTJiLleGoWMxfCDFIwDvuw7PD1Q+6GONhG
	 39aIhHPZVQn7F9UPbKFdUme8LMHI9CDErI7pA3BT7oH50yHQkH0p2CYv/KrBP1hkkP
	 gGKlEiJ42XcTyRREbpP3t98C43zCXqomyhR3l2CI634awpJkB/HDTfgSZA8ZqBIl3y
	 vhxbNNPiecaOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5697339263BF;
	Wed,  8 Jul 2026 09:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net/sched: cake: reject overhead values that underflow
 length
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178350420589.2406324.14854685159827268973.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jul 2026 09:50:05 +0000
References: 
 <20260702000758.297407.e5c888d9d99d.cake-overhead-underflow@trailofbits.com>
In-Reply-To: 
 <20260702000758.297407.e5c888d9d99d.cake-overhead-underflow@trailofbits.com>
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: toke@toke.dk, jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 cake@lists.bufferbloat.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  2 Jul 2026 00:07:59 +0000 you wrote:
> CAKE accepts signed overhead values and stores them in an s16, but the
> adjusted packet length calculation uses unsigned arithmetic.  A negative
> effective length can therefore wrap to a large value.
> 
> Such configurations make rate accounting depend on integer wraparound
> rather than on the packet size userspace intended to model.  A static
> netlink lower bound is not enough because packets reaching CAKE can be
> smaller than any reasonable manual-overhead allowance.
> 
> [...]

Here is the summary with links:
  - [v3] net/sched: cake: reject overhead values that underflow length
    https://git.kernel.org/netdev/net/c/b7f97cae7ec1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


