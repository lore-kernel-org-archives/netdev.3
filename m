Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ABC35AC30;
	Thu,  2 Apr 2026 03:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775100040; cv=none; b=Dw0R6SRlL8tertYslft9JQhrGi6pUO5t2+YYH1zvQt73a1DiNIRdP/0uUQwkPbBXkOq6GtGK2kKT3Xp4tQcxQ/Vmxfm+5+vI2YcJdEaPe/6/lTRVD9BNN56sZeabeS4Gw2KSJe6rabAaVHH9+SXB4N/5WvJa0P5t/SAZDVoHDso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775100040; c=relaxed/simple;
	bh=u0x1fSFcKwiVPStrlhOTI8axZqxAxcTsBCnAD6DJ1oI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aT0daCRY/uXoT/nDz6pIOMgtLozC1SexwX73ynJSxm26eFS4/fyK0GbrHL8GBlGkaCwX9xvovTMJmLCumaA0k4UjftW3aMd4esQCrm2H1sbu739eJLtptzRm/UCVlVr/sZCcqZ2f7fg6SgfUy7c7ReNYVj8D5Lafcvs/YS87NI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5Ga3WoK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5Ga3WoK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59641C4CEF7;
	Thu,  2 Apr 2026 03:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775100040;
	bh=u0x1fSFcKwiVPStrlhOTI8axZqxAxcTsBCnAD6DJ1oI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q5Ga3WoKaOvrZDXF/ZjD84fFFaarrhTCVxeJ48ET7qmYJyQsrtPpGVqFDex3FTKGC
	 YITsK1zI6fHdJjWcB5p8cQgn6WNcT6bospEwU2ZDROw2XCccZTDPDCWDkuuGnt+thh
	 0fBrSy/xtTOBTYaVyTlNf5B/sAr6+XMnCsCHaTEvJ4EOMyqZ6Jk1lHTI+U6ah6B5Vs
	 h6XalI44Np57AbXu0grrC6cxWtjHRb/jQFKw409YyyzN7QJ0lvbAOHRDGjP9KhGzv4
	 J76/snEI2+N1wYWc7TsiR65VH71BYz7hgYA6mX3CM7kGNbuehsPOws22qjsMcvEM/a
	 yw7j98dq8WaYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 401323808203;
	Thu,  2 Apr 2026 03:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: microchip: dead code cleanup in kconfig for FDMA
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177510002303.3972881.3590806528750380597.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 03:20:23 +0000
References: <20260329185348.526893-1-julianbraha@gmail.com>
In-Reply-To: <20260329185348.526893-1-julianbraha@gmail.com>
To: Julian Braha <julianbraha@gmail.com>
Cc: pabeni@redhat.com, davem@davemloft.net, daniel.machon@microchip.com,
 andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 29 Mar 2026 19:53:48 +0100 you wrote:
> The Kconfig in the parent directory already has the first 'if NET_VENDOR_MICROCHIP'
> gating the inclusion of this Kconfig, meaning that the second
> 'if NET_VENDOR_MICROCHIP' condition is effectively dead code.
> 
> I propose removing the second 'if NET_VENDOR_MICROCHIP' in
> drivers/net/ethernet/microchip/fdma/Kconfig
> 
> [...]

Here is the summary with links:
  - net: microchip: dead code cleanup in kconfig for FDMA
    https://git.kernel.org/netdev/net-next/c/48c6255cda81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


