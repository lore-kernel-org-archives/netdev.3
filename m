Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A21F317163;
	Fri, 19 Jun 2026 01:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781832024; cv=none; b=DD1G7jgrXIZeRFA9paRUZB2Gq5knoZ/xwDmewR/q5PrICpnhjwcoR7511vxAS5BENn0ozthqIG+pQlb45ktV+olOMqdb8cGn0HJImXjGcnoazV5JEPRArfImELkFOccEc9aONJ1wNpYjWf7xJobM/WlC4W89b+d7RvZuGNf1+to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781832024; c=relaxed/simple;
	bh=bsehpxCV14IE3zucYBi1hTaIi2nad6dVmm5o2ert3pk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fyRSutt8NhVgGPVTuYYodE8n49JzH3sqcjm2qzeNqA1+CpQHEaSKtOXIsAHzQMX14gLdt7kOGn9h1O7zV9A+ppYtw/BaCSmX5UUkFwQKSkCSfR3foEeSFJlmg/4V1ZjoqLVFL52WNf9l6wJ3noehRb2uGKRoj+GR+k4QOmQWGSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3v9S4ax; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3v9S4ax"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CC51F000E9;
	Fri, 19 Jun 2026 01:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781832023;
	bh=KMIOW7jnmghWTWWFgbsC2pCb8XxcjJkyRaz3CckY270=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=U3v9S4axS5e60cgrWkOFW+m082Lg89+yx+xkMHNI/M0sXKU0khvQNO6BDF9eryBxF
	 Z957/q9o6uzZbMyRrDebtjNIp5ytnGBkZAr4CCwKbu8u0foJYTbOLO6fNYzBboQKps
	 WixXtvu61U4dv0PxYHQBIALczwCiQIZDIqiwZRl6YHu9TRLKLLtYOtdRhJUeIbHPYO
	 BdkflqK7EMlm59EEsFDSzet/LUAxp70rQr9JNN6ZMP5PPmNv5jmvw131jlYc7mPWf7
	 B/sG4K9UEMgDJXHwVhamXjbh8Y2XFPQsDVKedR0dkmFFA/o+u5qNMl+iAkJZo9Zu8u
	 okPwLtpSqkh2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C873A78A7C;
	Fri, 19 Jun 2026 01:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netconsole: don't drop the last byte of a full-sized
 message
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178183201638.3150917.11717754438673855642.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jun 2026 01:20:16 +0000
References: <20260616-max_print_chunk-v1-1-8dc125d67083@debian.org>
In-Reply-To: <20260616-max_print_chunk-v1-1-8dc125d67083@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, asantostc@gmail.com, gustavold@gmail.com,
 kernel-team@meta.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Jun 2026 09:09:52 -0700 you wrote:
> nt->buf is exactly MAX_PRINT_CHUNK bytes, but scnprintf() reserves one
> byte for its NUL terminator, so a non-fragmented payload of exactly
> MAX_PRINT_CHUNK loses its last byte (emitted as a stray NUL in the
> release path). Grow nt->buf to MAX_PRINT_CHUNK + 1 and bound the
> scnprintf() calls with sizeof(nt->buf); the transmitted length stays
> capped at MAX_PRINT_CHUNK.
> 
> [...]

Here is the summary with links:
  - [net] netconsole: don't drop the last byte of a full-sized message
    https://git.kernel.org/netdev/net/c/c0ebe492329a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


