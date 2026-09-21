Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2890630D3F4;
	Mon, 21 Sep 2026 23:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790034075; cv=none; b=AIL/i6Tgr9vVwmI4mi73lrJ9Ld1r3idwgPUpEBZIY1gIsRdP5NWD+VTTPstlCILMhokcDivsMHEFCDJcr3CsrhQ4iHAG4x3q3kDubHnmepls6ICecZp5LhkPiArLdsVvmMUnWpZOwRMwUnn5CJd/wwBNYnEikVErQgcEz6xYkFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790034075; c=relaxed/simple;
	bh=Nkx6+x8o6bKfmZKiZjA29B2G6AwDMDD3Ur/jnmr5FNQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YxQP0/2tHxtNcgkj95AXuraSg+H7dsrstDUP5G39o4WMgydT4uKq3hoRxCU7dv/GrA9VWjkcPH6GXIzmjO4ISOk9IoVsTAJbFXixp/ltur1ipObFPovWQqL+rU+1CVGx7paqTB5s4T4sC/W5sU+rltlETsOv0mA0qIqHf2/B9L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=co3upfHs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="co3upfHs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF56A1F000FF;
	Mon, 21 Sep 2026 23:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790034073;
	bh=m3FYD1va0y5OAcPm5AHwdiobaJAN1Jgy6Ce/dHx1OPw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=co3upfHsO60JcbxLhj63idHdf6Bt/fO0q+HjwWFonlX10hcQaJHOPVW+Ta9kGYW9R
	 15x9+PyXhfJT2VuFHuzQqQwpSfD6gmNvJiz+z2ZMpxn49CAEWeQprmmRJWYoLiOKZ5
	 CwE+/HAKRWj4kLEYFTETrG2CLv9eTzdGqYU+T3kNMuObst9aB8MywkYg8z+qXcTbBp
	 CV7Wf038YrhyElquUkHE2bY81vFA650O7Daj7KkOrSjg0PxT/I6MBAhm0PFt9oM8Gj
	 HnBVneFG9CsGkKhOzbZYYvy0anLPRMW9/g8D8uXbNrIEOANZitmVMFzDlfl67vuZ+T
	 Qw72RhNScgXAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568C53927205;
	Mon, 21 Sep 2026 23:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: don't require the hwtstamp NDOs when a PHY
 provides
 timestamping
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179003400490.3291212.256143915218058697.git-patchwork-notify@kernel.org>
Date: Mon, 21 Sep 2026 23:40:04 +0000
References: <20260918095540.34286-1-nb@tipi-net.de>
In-Reply-To: <20260918095540.34286-1-nb@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, richardcochran@gmail.com,
 kory.maincent@bootlin.com, vadim.fedorenko@linux.dev, jjc@jclark.com,
 florian.fainelli@broadcom.com, opendmb@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Sep 2026 11:55:40 +0200 you wrote:
> Removing the legacy ioctl fallback made both hwtstamp NDOs mandatory. A
> device that only timestamps in its PHY implements neither, so
> SIOCSHWTSTAMP fails with EOPNOTSUPP before anything looks at the PHY and
> PTP stops working there.
> 
> The check only ever picked the legacy path. That path is gone, so drop it
> and test where the NDOs are actually called.
> 
> [...]

Here is the summary with links:
  - [net] net: don't require the hwtstamp NDOs when a PHY provides timestamping
    https://git.kernel.org/netdev/net/c/31995571219c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


