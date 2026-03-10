Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D8F391E45;
	Tue, 10 Mar 2026 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773151816; cv=none; b=imLSCgYjEImwAFB23TA8zJyrxlEl+eF8Wul9G2fhEGKoMy445OHJUrn943z5/r0ldhIPCaXTxpzzas3H3oqVJTsVHKxaobkaVXhYmhFA54AWmTjJ0rvqCTjj8qH2pEf45eWepDxiQJ7HgxAM0E/e+2S35XvdpmtyGzBr/1sxuww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773151816; c=relaxed/simple;
	bh=hw0U+dqyOQ+r5mhPE5KmUNaonkDT01PHNU6EVQqbZJs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N2H7BaAiYRt0DAP7gfpEvDie5gbMuCyV8BDm84R2vAzgRE1GnICaOMQwyQBgtQpB8GTUs/XBMC5bMOd50J2574PgTwkhAAk3s4+GpgvT+BsbMQCVQnEqRfpopyRUpcKWl9HHZbJI04sdYROJ3BWtd8gn+K0NWA8k3kQYPENZB0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9aO59sO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9aO59sO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790C4C19423;
	Tue, 10 Mar 2026 14:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773151815;
	bh=hw0U+dqyOQ+r5mhPE5KmUNaonkDT01PHNU6EVQqbZJs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M9aO59sO32sXKZcxj4L3AZfSimopPrBKjlTbgQuPQyDxzWw5M1FW1toXGK5B3RMqa
	 rfsSPUHYDaSfeEpnhJRjR6a/jOk80lJKuV55u8lPNdUTP2d3V4z4I0NgZY+STg+A3z
	 pFDfOLEiGdHwKu2XIuElha4XovZoNfU+hDLc/qdJ+wV0d0XarcyH6pagEzOIwNw2Bt
	 25m1QSVGtH6TjKLZaxS0HdHaght6KpMNl50zD2+8RPijW7tHuUdPmO6QrWPmN3znSU
	 1Vwa7uyHcsq3WM3/1iDH9Fu6iMVkeeXUbY2374gtmRqvX1M3JG0BhbnDGB+MkuXqAr
	 JLJyXkbOeD0ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CFD33808200;
	Tue, 10 Mar 2026 14:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/5] eth fbnic: Add fbnic self tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177315181230.2317951.1910179248060656686.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 14:10:12 +0000
References: <20260307105847.1438-1-mike.marciniszyn@gmail.com>
In-Reply-To: <20260307105847.1438-1-mike.marciniszyn@gmail.com>
To: Mike Marciniszyn <mike.marciniszyn@gmail.com>
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux@armlinux.org.uk,
 jacob.e.keller@intel.com, mohsin.bashr@gmail.com, lee@trager.us,
 dan.carpenter@linaro.org, xiaopei01@kylinos.cn, sdf@fomichev.me,
 kuniyu@google.com, skhawaja@google.com, liuhangbin@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  7 Mar 2026 05:58:42 -0500 you wrote:
> From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
> 
> This series adds self tests to test the registers, the
> msix interrupts, the tlv, and the firmware mailbox.
> 
> This series assumes that the
> [PATCH net-next 0/2] Add debugfs hooks [1]
> is present.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/5] net: export netif_open for self_test usage
    https://git.kernel.org/netdev/net-next/c/3fdd33697c2b
  - [net-next,v4,2/5] eth fbnic: Add register self test
    https://git.kernel.org/netdev/net-next/c/b43498b7e9be
  - [net-next,v4,3/5] eth fbnic: Add msix self test
    https://git.kernel.org/netdev/net-next/c/99fc8d3d00c9
  - [net-next,v4,4/5] eth fbnic: TLV support for use by MBX self test
    https://git.kernel.org/netdev/net-next/c/d522b1b00480
  - [net-next,v4,5/5] eth fbnic: Add mailbox self test
    https://git.kernel.org/netdev/net-next/c/8e5218199da4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


