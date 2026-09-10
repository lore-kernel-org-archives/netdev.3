Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5495A373BE6;
	Thu, 10 Sep 2026 08:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789027268; cv=none; b=rCUVwTV0Dx3R0afPVRuCVJxNMQNFvWB3kkuHjFMIi1x20o6Z7QplGcLxaSb1zss90WJcMRF+1VFwS5KM/RIc2wLrqPvBbY4rzlMZ7O/UREeTHLjG5VTwvqx6k318puFUzi8a2+yKsnr4jE/7dDqiQDe7aBDU0HIffkGTzmDtxMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789027268; c=relaxed/simple;
	bh=VCeu36DRTdCebLEnV79Ces0SfMWnnV3bXKIeLKHWiCY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sdf6wKsbP5YtmTbL/0AebaiNiLEK5FYoif42KRUbTEqUhAbHaxpgrsvVf06Hp4/EZse3VMCAgQNE+J2IV1eXE5pO5HCBTETnaHGm4BN8g/jhXuTFoJtuj5icSDjNgUINtsZxOPPH+ARBuiqQ3luocFPSA9UUhjobytdNnWZB1nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBSt8NJV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBSt8NJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DC51F00893;
	Thu, 10 Sep 2026 08:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789027267;
	bh=KulZ5ntvT05J8pJb1j7TYhOmQiMKN9mbyqyrj1mXhEE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jBSt8NJVj6M8nvjX+F6JTfxKNDI3bxCCQPFb1B46q0iVdrnvEq0x/t9DP15JXvHEw
	 tkVR+fUdZxF1R829bqKSXymGWH06thKGAp4ifln/s8eIVQSAu29RT9v3MXhuUve4/q
	 1ISIQg9zdfsVS5Uhqgvlc+2Cr+QH11Cm19L40119XpBBdrnrKIvQhB9zJePNzAtdIy
	 vl8VT6OeiH9Sd5RjsFUU0amYcdrwOcrkFKyVtJdDQf6JvGqQAxWi9XtDNmQXotpXq7
	 NfqL7IWgXo+hCB2gQ0Z3XPzGquN6FfKM9G1DWDrEhSVdIY/aBbhiWKOtI6vOFWsFS5
	 2D5naDrR5YFAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D08AE380CEDD;
	Thu, 10 Sep 2026 08:00:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: run netdev work under the ops-compat lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178902720439.1264762.7524807749415366717.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 08:00:04 +0000
References: <20260904180058.3803849-1-kuba@kernel.org>
In-Reply-To: <20260904180058.3803849-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, sdf@fomichev.me,
 kuniyu@google.com, linux-doc@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  4 Sep 2026 11:00:58 -0700 you wrote:
> netdev_work_proc() took rtnl_lock() for the whole batch, forcing
> even ops-locked drivers onto rtnl just to run their rx_mode / ndo_work
> callbacks. Take the per-device ops-compat lock instead: the instance
> lock for ops-locked drivers, rtnl_lock for the rest. That's what the
> callbacks already assert (e.g. netif_rx_mode_run() asserts
> netdev_assert_locked_ops_compat()), and non-ops-locked work
> such as vlan ndo_work keeps rtnl, since its compat lock resolves
> to rtnl anyway.
> 
> [...]

Here is the summary with links:
  - [net-next] net: run netdev work under the ops-compat lock
    https://git.kernel.org/netdev/net-next/c/5a81c72ef9ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


