Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E94742AFBA;
	Thu, 23 Jul 2026 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821259; cv=none; b=mF8fcRtufiuSV4lRXxJifHNWFmC8h20vf0msdZoFS7EaKIGLdpTVF15Mjko9vXY6Tf9pZI20QSoA4JA4ySU8i81U0YJqvR8YQVnb/TC/wLNTMe9T8OGpU4ihzHKgjyE0Y3C55iYapLF1Woc3mSCVVXFIS7SGVu0VZLLZqqndFWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821259; c=relaxed/simple;
	bh=0YIy1yBxyVM4rP3C7XOWEghR6o7eAg8m2hWT+kfNf7Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fu34Ndzh6ei3etdVGrEkzEQWjcWbWRa3JJV4lPn14e5q4qReOOItWozinSS2jx3IYgoqUsrBA35OXprN+vNMp/IqYuCq8JIANqcYhB5D5fICs+idmNrMQOi3+1CMjKieQd4SPXEFQAHByjtzoqRrHIOLS2oh/Lb+dZ1iL7IW8mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Adxw61dM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Adxw61dM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AB01F000E9;
	Thu, 23 Jul 2026 15:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784821257;
	bh=aa7V7kV6u9RIhcBqtlxBXVYoo0CCm+Rs57nq8u9XUu0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Adxw61dM0fNWry+j+ItfMUg01IyXlLr3UFaR1yqhoq3H+3P9dEg2HixBSC9UbCDLN
	 vubIcXWM1+r9im5t66R+6T9aydlOhU/R4W6hADp7VY6Jw90w+hOWEic+fgUV0M5nD8
	 Q7jMahUeqWLkuOt5LQGOs0TA2SxcdOr8UV8IsHKs10RqPARAlmsok7fgO6ONbqKCI7
	 Dmknumi7bGhDG34KkQUxdtKlIpL13xLfn4p5VE+Hht+g77uAB5snmMqgaehVs5fymP
	 AEFgEWBi59lmSQ03Ro/PN6SJ3XXpllY8uUj5hbE8nYNI1+rAWDAdaI6E4JyRaFQjTL
	 tamvatTA3TZ3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199033924456;
	Thu, 23 Jul 2026 15:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-pf: tc: fix egress ratelimiting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178482121264.2324960.7688882916467745838.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 15:40:12 +0000
References: <20260717084349.2227796-1-nshettyj@marvell.com>
In-Reply-To: <20260717084349.2227796-1-nshettyj@marvell.com>
To: Nitin Shetty J <nshettyj@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hkelam@marvell.com,
 sgoutham@marvell.com, gakula@marvell.com, rkannoth@marvell.com,
 sbhatta@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 naveenm@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Jul 2026 14:13:49 +0530 you wrote:
> From: Hariprasad Kelam <hkelam@marvell.com>
> 
> The egress rate calculation computes an incorrect mantissa and exponent,
> causing up to ~50% deviation from the configured rate at lower speeds.
> 
> Rework the computation to follow the hardware rate formula:
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-pf: tc: fix egress ratelimiting
    https://git.kernel.org/netdev/net/c/bb0d96ebe5f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


