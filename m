Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456DD1F91E3;
	Tue,  7 Apr 2026 01:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775526044; cv=none; b=M3r3lm/L/PaZNKEMfflB0KPDKAq9Y8XU222qJlgjTk8gvn0nZjbbakWSUdLSZRjWiBCwjog9/5Vf2hu+0GQWvrm7af0Gup7BP1dunXf8yMXaLWF2Mk4WYSqsqltViNuMxmir+kMzLaIXtjUL38kFL6Mx+8RBxftpEIFjNNHtm+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775526044; c=relaxed/simple;
	bh=mXclUZmgJUOdXn03HQYM/pVwprZ7bm+qfDCAMotdKO4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nKRghbPGC9NhxD4mC/tLvH7soZjGDghujGuRfpxDaf3+tN5iwY9Ro/pACo0jL6QoiKjzr7hGDMP3hf+2nMVtP+JzkdmD8NhNHBjW65bP1NFjv63LTmnOYVvl+Elq0eKqnraPmBlPq1rd6R+gZC2GwhcNtLfCaE48lxiVd50yB5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LINRKQ1s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LINRKQ1s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01E1C4CEF7;
	Tue,  7 Apr 2026 01:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775526043;
	bh=mXclUZmgJUOdXn03HQYM/pVwprZ7bm+qfDCAMotdKO4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LINRKQ1sbcaaWAtl3oby2NMRqikQmcj6ABgGBM7g9RkeTN7RaVacZp0aRUH+dWXXX
	 GlCVxEg+8xP08kQArUikTUgf9Vyy+SG93/jRimA6uNDPxSmud0KBhWVF/OCpqvyK5A
	 mQCBAS8Y+miNlsvExcPzSCkhQmfaE/bl4tN7xIkxbRBGlLHL1MCQJ7cfJ4vO6vJkw/
	 W9D6RDf23JBcelUZ92zmWn2995PLTzD9BAWNSVpfOspzJrSYiQVEPJ0rUqA94HwbKL
	 8jBs0XdVDqQuFcUeSj7DtoiIx97CSASFZDyZrdBgK/JAL94LDdD15sqbVT5/RDZ36j
	 ILrIBMzPI7+sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDED3809A28;
	Tue,  7 Apr 2026 01:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 0/4] net: dsa: mxl862xx: add support for
 bridge
 offloading
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177552602207.3334922.4407334605667597596.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 01:40:22 +0000
References: <cover.1775049897.git.daniel@makrotopia.org>
In-Reply-To: <cover.1775049897.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, frankwu@gmx.de, chad@monroe.io,
 cezary.wilmanski@adtran.com, lxu@maxlinear.com, yweng@maxlinear.com,
 jverdu@maxlinear.com, ajayaraman@maxlinear.com, john@phrozen.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 1 Apr 2026 14:34:11 +0100 you wrote:
> As a next step to complete the mxl862xx DSA driver, add support for
> offloading forwarding between bridged ports to the switch hardware.
> 
> This works pretty much without any big surprises, apart from two
> subtleties:
>  * per-port control over flooding behavior has to be implemented by
>    (ab)using a 0-rate QoS meters as stopper in lack of any better
>    option.
>  * STP state transition unconditionally enables learning on a port
>    even if it was previously explicitely disabled (a firmware bug)
> 
> [...]

Here is the summary with links:
  - [net-next,v9,1/4] net: dsa: move dsa_bridge_ports() helper to dsa.h
    https://git.kernel.org/netdev/net-next/c/b0a79590d108
  - [net-next,v9,2/4] net: dsa: add bridge member iteration macro
    https://git.kernel.org/netdev/net-next/c/f259e08494c4
  - [net-next,v9,3/4] dsa: tag_mxl862xx: set dsa_default_offload_fwd_mark()
    https://git.kernel.org/netdev/net-next/c/4250ff1640ea
  - [net-next,v9,4/4] net: dsa: mxl862xx: implement bridge offloading
    https://git.kernel.org/netdev/net-next/c/340bdf984613

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


