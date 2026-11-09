Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794219006;
	b=R1bfAVxd3idCADhZpI95roIv59EQC2K2xOFXTMemJ5SPDuv2BB6y2wY6G5B2OWNa/uAM
	 +hqm7aS0A6l2UzWnqTjo09fzy6ssEC4gmCJKN0CCGlWSRQPHWE4PeRvYpSrlyCrax/lWC
	 V2E0B3iHI/CrVdB2kWBUUyZy24yXODd4oAMV0qsMmmEp4ZZ7pg0G89C/laitLtH3Bu3Ud
	 sQ71jbFb3KEZiNnyOOj16OdCr+DdPMXr8aAiCkOlihYtAes6tf26tc6kPR3lMNNyiwe4t
	 5L3CNrbqbHvQ+gb7hKCg1nBn0R4S9sfOVINKSiUn33J+Iwj+kA9AtMFTDEgAOo93qNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794219006;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=CMJEtzILuNn3I2Jmk5TXkZKrrv9n1NP0tA5pa/79/1A=;
	b=HgJQPp1NPmoVN57mEo8oNsCA12q4pmTZxZ83g0lPo3WN+Fhsj62wIXyDo/ZCs4LpKDDu
	 5yA2/wQr94fWRYTi+25OxabOSoNdL3qj/LCbdJjwkAqEqsCFNwlqNVSJdW9hyuHSrWrot
	 jFkjKhcDjzVN8LvJdY0C6crnid8QUwuAS4Acb8xTl0CHQ1WxZj1Ez3x+EuPET5ZBRbvT0
	 houBnrtk8YPNCnqFYNRs/GF9Ah5VRDjVd8GB8L3wrJF1IKI4CbmiJPSEa0dK+Du3PxtDv
	 7TJScuAOatHEZbbiJx43Mj9UsjUajfZqX0a8EaJV8V3o/YPpwZZwYXamAXw4e5mdJxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q6Ko42Xc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74D0606A31C;
	Mon,  9 Nov 2026 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q6Ko42Xc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676AA1F0089F;
	Mon,  9 Nov 2026 10:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794219005;
	bh=CMJEtzILuNn3I2Jmk5TXkZKrrv9n1NP0tA5pa/79/1A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Q6Ko42XcOLMalNZH0lVEIv9pmQG0mHWPegT7SAW3hqIhFKbSK8Vxf/l5+J5tWlcVC
	 gq11a82+ULXf574sOEw5Bj17c4XqYCUIeDeTYzSfTY0ok9l+5Ytib3UnxXAulGLniu
	 cFafqLSvM8q9Nv7Sd0Og0ZvpDXbXlS3EJ76y9b36CTYLNdDU2c+tqjm8gzkJWoI8TR
	 OrZ1IB4jsEscKc4yPZwko/X8dPmLX7BPIuMh7oLwuxd7XgRVW3HJihTjV3mynBapnj
	 kEyGRy42/uK7xdFwdIqAQ2Z8gmtW4OzHrV2t2SPlUAUTCMdZyF1dB3kjPRyVYwagRQ
	 0GWgFezsoTC2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E2E2380822A;
	Mon,  9 Nov 2026 10:10:05 +0000 (UTC)
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
Subject: Re: [PATCH] macsec: reject frames that decapsulate into runt Ethernet
 frames
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179421900417.2681732.2334748130206762249.git-patchwork-notify@kernel.org>
Date: Mon, 09 Nov 2026 10:10:04 +0000
References: <20261030042237.74106-1-kylebot@openai.com>
In-Reply-To: <20261030042237.74106-1-kylebot@openai.com>
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org, sd@queasysnail.net, linux-kernel@vger.kernel.org,
 outbounddisclosures@openai.com

Hello:

This patch was applied to netdev/net.git (main)
by Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>:

On Thu, 29 Oct 2026 21:22:37 -0700 you wrote:
> When an SCI is unknown and the C bit is clear, macsec_handle_frame()
> removes the SecTAG and the default ICV without checking how much of the
> frame remains. A short frame can therefore become an skb shorter than
> ETH_HLEN. eth_type_trans() cannot pull its Ethernet header, and a second
> stacked MACsec device can copy stale skb headroom into a packet delivered
> to a packet socket.
> 
> [...]

Here is the summary with links:
  - macsec: reject frames that decapsulate into runt Ethernet frames
    https://git.kernel.org/netdev/net/c/1d5e2c57e9ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


