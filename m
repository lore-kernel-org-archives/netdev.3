Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191D2442B10;
	Wed, 22 Jul 2026 22:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784758250; cv=none; b=ds7/jUXBXSK8emzzaJsWNqGISiSEbLuQaa7sKtZWZAExPCzRhPuV4D7kTgT7rH6KujuVlHObrc0j82Fnjt/ijBbbN1iYuEKCQHkVKSAnpFeypQKUzbfWTxN+H7ztIXpfbgGdB+hwzAhWaWYP8u/fNPBZjGuuyf5zps5+84R4Eas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784758250; c=relaxed/simple;
	bh=m45fdGPHPgCPEIkmb8nzH3JxBtoQXwWLNrTAg5isPVo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kdipHJNW/eP4y3dFCEueGAFEYIeVGKSr+oalgpeE5FpiyBrm/pds3uir1yY1Geu/dm4HAiwFEPnKJnvwFT2hFI0ydhGmM/LhEYHM1J+pxBZryJh4YLbGCKmnJ9NSRaCh1QfyPfTZNO7t3O9LS3fs63UATHvIKmC3VhT99AtFNXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avz0UVal; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avz0UVal"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E651F000E9;
	Wed, 22 Jul 2026 22:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784758248;
	bh=0uHYrT5v501dchQxN0Umi5SXsK5+uVMzVlVa4iM6/Oc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=avz0UVal7sljNP5qdTPFnkW7xRekE8FD09leWUYBUasgxqKSoBQ2Paifn6wqnqXAz
	 CztZwCtDsEZHkZPnDV3BaIoYzvOhVEyAawkvae4NGAOYt6X4sU+o0cmxCOX5Ajyoyz
	 QhMe5rrsD0vJlpdASSm+3un475T/fZ/YRqv5CF48cYkACHlCXX8e79ilHUObezj3Sn
	 gCwpgDAp1T9+xfMXfyHFJizKX5RIEkdZRzCzMM3+CYXA9jpR5fk1BXvrEAaYt9YQ1w
	 a4SAJR4yrOMaG8qkLc27aYYmVf+tlJBTT9l7TMasMGuC4BPxdzCYWw9R+ymGCDEqXw
	 O6bC7DRtyxdRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B13380CED7;
	Wed, 22 Jul 2026 22:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: mdio: Rearrange Kconfig menus
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178475821713.2043959.12427826664923685351.git-patchwork-notify@kernel.org>
Date: Wed, 22 Jul 2026 22:10:17 +0000
References: <20260715082226.51481-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20260715082226.51481-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 hkallweit1@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Jul 2026 10:22:23 +0200 you wrote:
> In menuconfig, all MDIO controllers and muxes are listed directly under the
> Device drivers -> Network device support menu.
> 
> Let's group these in their own subenu :
> 
> Device drivers ->
>   Network device support ->
>     MDIO controller drivers ->
>       Mdio driver A
>       Mdio driver B
>       ...
>       MDIO Multiplexers ->
>         MDIO Mux driver A
> 	MDIO Mux driver B
> 	...
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: mdio: Kconfig: Group mdio controller drivers in a submenu
    https://git.kernel.org/netdev/net-next/c/65f1820835f3
  - [net-next,v2,2/2] net: mdio: Kconfig: Group mdio multiplexers in a submenu
    https://git.kernel.org/netdev/net-next/c/8a48eb846f7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


