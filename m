Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEEE378839;
	Tue, 11 Aug 2026 01:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786411254; cv=none; b=nMpGoCPa+UULePLEbyjSGormsvkdjH01aHmJ75tVij2Ik/5nZ2UpEjPVkwhL64sovN3e7nScp8JgoRtiChE3xfW5edjztMB1wHukFqQ2DtAovBbl8z2nt/He5f8NtNuC9wChQq15rki2NYrCfjzl4kXKXF1I+f6OxSknpTrLi28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786411254; c=relaxed/simple;
	bh=4MdAnbp+TlkKB/LptomYLQBMiwWueWsRcWR+icz55D4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IAzFtA27LY3Rms0ayV/7VoKPaQiCNYEJaOyco16Szz3Is6Vs/OITqt5ShLU36y36fs8K/4pGcjMT3q3jzSg/SY8YTyJXeaiViJVqkPdUOyG3XmNvenrSwEDCNmoKc8vfADL1acXW7y3B1rNbahsU6ezpbY5KeXh+BQkvYqbJaf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=io6fGNyA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="io6fGNyA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2553F1F00A3A;
	Tue, 11 Aug 2026 01:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786411253;
	bh=teTqb+ziQs5zCNxLaCXLIfuEvD33OLnhu5kwHv2Q0BQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=io6fGNyA72Q8N77jiPrLPBe5++JAwaq+E2WlDAHw5cYPIEGk6HGV7D5NRxoEsTRO5
	 i48BKc2v5c8RpdgkuzNJnh/Tiou+6lcf7M0hK2vf9VZEJnfCMZeoRxq3wtQC2TPqX5
	 ETkEJbEoTNfdISpWo2H9JQZeLJaA7oVs+oe6pE+ogH4SbwWcpY52DZFYPKeRPVQ6Pd
	 j5ZOH+eWRRuHrC07e8BwKw0SncFjzecEARfgzMhcMp3Tjq/HnMyVquxZxcqRaj8ViS
	 2UAIqYjdm/dd7gG7xr8SfCPJ5Usr6DhajvGbl4QOsoVAeZk8wcgj8lzHi0iFx2OtbP
	 x4FzGdHsGVOjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A81392626F;
	Tue, 11 Aug 2026 01:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] et131x: propagate EEPROM readiness errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178641120938.284305.6118228918143411776.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 01:20:09 +0000
References: <20260808194347.813242-1-thnkslprpt@gmail.com>
In-Reply-To: <20260808194347.813242-1-thnkslprpt@gmail.com>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: mark.einon@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mgr@kernel.org,
 kees@kernel.org, jacob.e.keller@intel.com, u.kleine-koenig@baylibre.com,
 alan@linux.intel.com, gregkh@suse.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  8 Aug 2026 22:43:47 +0300 you wrote:
> eeprom_wait_ready() returns a negative error when the LBCIF status
> cannot be read or the device does not become ready for some other
> reason.
> 
> eeprom_write() propagates this error before starting a write, but
> currently returns 0 when the same readiness check fails after the
> write begins.
> 
> [...]

Here is the summary with links:
  - [net] et131x: propagate EEPROM readiness errors
    https://git.kernel.org/netdev/net-next/c/341d8aff93e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


