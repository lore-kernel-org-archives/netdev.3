Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE524C77A0;
	Tue,  8 Sep 2026 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862868; cv=none; b=LgJEeBAIJVSMFwC8aKGxtm+SZfMzsZ46e1ATLNEGs+FGlFZ5iRKvJZO1cnhwZ34meurlHnQm393S/G4UlGdbOBdksNfzQ6rTmEPH6CivSM/Upfpm4SYQt1bVt/K6N3SRQSYRr/bkBrdB0ZuB0lID99CzMEeVn6SDp3eUkFDMH2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862868; c=relaxed/simple;
	bh=ZHIgJ3S8Q8RJ9GB90CO93chXrJG8bKGqZvNs9SQZuU0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NgqAH2YPbENCc6wywbroAmx1qIVZOFii6Ts6/6YIKF/zFPZ/ATIq9PNjAALh3GfxCVGb4ktMuEZQ+opz+o1F3e/6or7mfEw098kmnGH1lX9gqlP+PZR0yxv8QreESucTYDw7EwbJQLVh+qZY0Iz6rtpd9ryO1FLnbT7tbpI58yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDr4rG1j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDr4rG1j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EE11F00A3A;
	Tue,  8 Sep 2026 10:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788862867;
	bh=d0RVUKGzQViRfhpTWiTrG2gQKE1cWfQApfz0Noa/nxQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FDr4rG1jykxjH42fVaoN3noXPX3ildn87M7q7ySMDJV9Uto2rD25ishapl9v/Tp/S
	 rcrM6B5Uf9+PXJLuvpv9rYpa6YCKVMLHfFaF1lZ4mCDxzo7DnZeMt7ZGbeNe+/Ez7S
	 4WuEKlQZRMWMVvPDi1mb+8JkrqOadPHvtt+x2F/QaGZzkqpp9I7J+BtGRe2hMPMb5V
	 QT2b8qFNojxEp6ZYsN5jlm4v3AYIJ2ps5m8Dwsuf8d+WoWc5FMogEEHlQjBVq1SX+Q
	 nRcekTtBEl5Wm5PQcFkuqfsFOB/OM9Lb9E7Z9nsrbKdNKzR9zGXX19o4jEl0qZ84uu
	 3D0Mp5QpoCqZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1983539E9602;
	Tue,  8 Sep 2026 10:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] net: Make sure clk_init_data is fully
 initialized
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178886280589.3447437.8919325096369252990.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 10:20:05 +0000
References: <cover.1788425654.git.geert+renesas@glider.be>
In-Reply-To: <cover.1788425654.git.geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, neil.armstrong@linaro.org, khilman@baylibre.com,
 jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  3 Sep 2026 11:00:38 +0200 you wrote:
> Hi all,
> 
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: macb: Make sure clk_init_data is fully initialized
    https://git.kernel.org/netdev/net-next/c/83e6bb28644a
  - [net-next,v2,2/3] net: mdio: mux-meson-g12a: Make sure clk_init_data is fully initialized
    https://git.kernel.org/netdev/net-next/c/4bee840c7e43
  - [net-next,v2,3/3] net: phy: air_en8811h: Make sure clk_init_data is fully initialized
    https://git.kernel.org/netdev/net-next/c/64adb67e4568

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


