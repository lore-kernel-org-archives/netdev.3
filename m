Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874617;
	b=TfC1LDvXw0jFC6jWlXza9AGz6Iyndwsa+XNr9dTdIb2NPjxzOZzlSNJwISibdJ3WYxoQ
	 rK6zFctXWFez+2SkYAmLD0a7ScO4IEHmxlJvgPbTD11eGcfce5rTOwNoUwPnz3YTLoWZs
	 RR+YRLTKInRn4rGTDrtsXU4UGcTycmrPnFBMipYP6mv3E3gVoqin7uBFITq5CTeOfvOKr
	 y37aUkyrFUo0FJs4tKDyuwVAaHUn75F5LxxOJbpj/KBVC4OiHSL8j7J0WEGVuELyRq3bs
	 F+d7jZDdc9kJ8kaVBeyTE3FZbF3nA6Jy4Fb6XbQw5kyHseMDJPO6GNtjunocURjv1GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874617;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=aY4AUfbfJDpppsRiExRd+4IldJoEWi704rjSVmMKD7A=;
	b=BQ8gccL4hP+D1VN7dKAtIS5QuzxvaFVoFizN5lEZg58OdHmwhhAdibpfsHpwoZkgO20o
	 OIkehxRSoFzehD/Wnfp+JcxMkGqH/vDIMF327e3n7qUOxax/uadpTSF7y7YMRWQWfB7z/
	 208g425QwK5mnkO0yrKMwwtG/TV/GM1t4cetduP9zcgEXjX0f38W//EWumDU31A2EnKuW
	 JbVi9lDANH7QXo0z/LIZfWfVGmwTEikdrwvQ/ILVhivTRPYuwxhcbcpMBitw7w/yUVG5u
	 YUvkVOBM+8VPbRlF4l66PZYQaGyu4dXhH6cAQieS1Q4auUTfNpFSnddYCKE7X24tF7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HttCFaqY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9DE606A329;
	Thu,  5 Nov 2026 10:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HttCFaqY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498F21F000C1;
	Thu,  5 Nov 2026 10:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793874616;
	bh=aY4AUfbfJDpppsRiExRd+4IldJoEWi704rjSVmMKD7A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HttCFaqYkoYo+r4yowGWKstYxuZRqG4osY6wLCMgMjdb6cw1CBBX8vmv7kNfTkCzM
	 lR1WNwl+8RWzxPbCxY65CzmOBP2y0BFhKb4irPF4z48XwFBtz+PVWqFrLPja/dEPZD
	 JLE7jtAN+DGyf9rDaQw1LtPgeq7TDIj9+aQV74Tda18G4kWRhxvWJYgrn7XrAND0Zn
	 mQjr/z4qNVyqu3icq+JJHZyQXlWCQxF9qaWiTnfIh8fNzzBseRgTKdOB8UA/qs8WgO
	 iOQmdQI62IjMR2rwYOyA1dVX/7DZhg/kCIRMrtI70Pj/VKgX0MPYNCfF3mvNqlQ4JV
	 7q25Gi6lf0rpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4013D391AFB4;
	Thu,  5 Nov 2026 10:30:16 +0000 (UTC)
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
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw-nuss: Enable
 timestamping of
 unicast PTP packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179387461505.3576987.13427871090312904727.git-patchwork-notify@kernel.org>
Date: Thu, 05 Nov 2026 10:30:15 +0000
References: <20261102135117.419539-1-jjc@jclark.com>
In-Reply-To: <20261102135117.419539-1-jjc@jclark.com>
To: James Clark <jjc@jclark.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, c-vankar@ti.com,
 s-vadapalli@ti.com, horms@kernel.org, daniel.zahka@gmail.com,
 bigeasy@linutronix.de, oss@vassilevski.com, nora.schiffer@ew.tq-group.com,
 grygorii.strashko@ti.com, robertcnelson@gmail.com, mlichvar@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  2 Nov 2026 20:51:17 +0700 you wrote:
> On a BeagleY-AI (J722S), ptp4l as a unicast master (unicast_listen) logs
> "received DELAY_REQ without timestamp" for each unicast Delay_Req, and
> its port goes to FAULTY after "timed out while polling for tx timestamp"
> for the first unicast Sync.
> 
> am65_cpsw_nuss_hwtstamp_set() does not set the TS_UNI_EN bit (bit 24) of
> the port's TS_CTL_LTYPE2 register. According to the TRM (J722S TRM
> SPRUJB3D, 12.2.1.4.7.13.5.1 Ethernet Port Receive Event and
> 12.2.1.4.7.13.5.2 Ethernet Port Transmit Event), this bit must be set
> for the port to timestamp PTP event messages over UDP sent to a unicast
> address; without it, only messages sent to the PTP multicast addresses
> selected by the TS_107 and TS_129 to TS_132 bits are timestamped. TI's
> netcp_ethss driver for the Keystone 2 Ethernet switch, which has the
> same timestamping registers, always sets TS_UNI_EN.
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: ti: am65-cpsw-nuss: Enable timestamping of unicast PTP packets
    https://git.kernel.org/netdev/net/c/6887a8f98244

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


