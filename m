Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AE328850E
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011811; cv=none; b=TkZoETECdMKIHhZODGjw0uPHimmBL3YZWR7sfie9KKiEkWyo5aeZvnMvLpD3C4Wv6x8LK5lQdsQwpqS1nEWvcuIrCF8lX3d3vBNrZ2RvUch++X6dEYv8g+W5khZf/xtCivN4pSqhIoTWmqqx3akTfkIcFma+IIPXGv/Ij1RzRis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011811; c=relaxed/simple;
	bh=fLLXdIlG+c1WK8htpNpQKmWEMgm10IiWOwSGccnoIc8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t/zZLqcLsw5BfUHGV30gfgaEEtcwgm2XOzVNWx9vnqctRk1A5DOSxAFhQWbkEM8aer8Nzu0n7Oj442tTcXmkcV8RtzzRIOvbudDkZPR/Ud72Xn5OxQmw0/dMIUEr2d6DcMFb/nfemnqZAXBOcMTmh9qQH3PDjInRPJjNYFq/GkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTWh8AYf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTWh8AYf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9F91F00893;
	Tue,  9 Jun 2026 13:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781011810;
	bh=/yRustlpKO/BsoqJ5LoKaT/yPOd5LE85+DB3PDO9sFk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bTWh8AYffpChG+So00/Qi2ZUmMuEoFfjLQc8MLo7Ov+bn+LWmBagIdDM5qz6w/SWK
	 awi4JXVUuBeUTDA1Q1syjIhzBLORGYMMpWffmAmvTfhGrjxHE5jN+IJng/+J2IKdYF
	 7+JfkNtv85d/ic1LwzxwQ/3pC77ETQRg5EgjNtwc4Ft32voPNn38me6beBCSR6hMvJ
	 S8b5a1t55iiJVpEyYEamtnKJm7Jq7Zh+wnSCsOU8PWh1iuHxstwO3QhX4lMztOV+rl
	 cb886wIX3vM2XiwbMtOjJfqNYMY4JrMqaXvbv0H3VREvj8tEid3J/LoxVSiuASbh4b
	 vK+AurQaIp68g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56E6239308D4;
	Tue,  9 Jun 2026 13:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] net: mctp: usb: minor fixes for MCTP over USB
 transport driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178101180914.2029912.4636936255342101999.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 13:30:09 +0000
References: 
 <20260608-dev-mctp-usb-rx-requeue-v2-0-29a3aa507609@codeconstruct.com.au>
In-Reply-To: 
 <20260608-dev-mctp-usb-rx-requeue-v2-0-29a3aa507609@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: matt@codeconstruct.com.au, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 08 Jun 2026 09:25:39 +0800 you wrote:
> This series adds a couple of fixes in the ndo_open / ndo_stop path for
> the MCTP over USB transport, where we are incorrectly sequencing two
> error cases.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> ---
> Changes in v2:
> - Add fixes tags
> - Add re-queue note in 1/2 commit message
> - Link to v1: https://patch.msgid.link/20260605-dev-mctp-usb-rx-requeue-v1-0-b86993d01ac0@codeconstruct.com.au
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: mctp: usb: fix race between urb completion and rx_retry cancellation
    https://git.kernel.org/netdev/net/c/54665dce9826
  - [net,v2,2/2] net: mctp: usb: don't fail mctp_usb_rx_queue on a deferred submission
    https://git.kernel.org/netdev/net/c/881a3113b749

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


