Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F9D37C10C;
	Thu, 10 Sep 2026 01:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789005076; cv=none; b=ZLz30ijYW7gjR5i2RoP5TLzoLmwMQtc2iDl3sOA4qChB2K7XOUk5zs7ZO3mWvCXC9rinhLLDGRKtgwy9l5W1xMbco3kK2nrFQJjpAidNusTvYYOTAaCOM2wka0+ekvDjCcQciir5ySsbo53HkwG6B7mdkJ20kdp3PL93rxGKv2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789005076; c=relaxed/simple;
	bh=sBS3ohsNFU+sGNeno4Q7KCztFphlvdyxUQW5u9jxbWE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NzxvMEY8PZ9Evbw1AFH2Hpu3CctX1XsoKTGHTWngLmyRU5J2zeaKZSDlZXUJEH6IGjxZ761flJhblx7WpZetb5BS46eDN4jhsTWFth6fDaOV0qbk9oLsAjzq9FRROznrhlUkJvGy3Z1aoPEiekDQ+C4JRUbWORVTNkFUb5aevAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLI2NE5/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLI2NE5/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545C11F00899;
	Thu, 10 Sep 2026 01:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789005074;
	bh=Ytm6j20954Sf8oNZxXXYzU5ZL6cayrdzOWfaxTcZgcg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BLI2NE5/FpOD8DZGo2bHmLZh6pf3rpSejETZELRMdgn98C4GSmLlLT2PuxHPcxCva
	 JRCB6XOmQjZ/dSftx+EznIHQTU1WtCLfhijVZ1MiL74Jj3IuWP/HP0k6nCDc0SCkCk
	 bAQSwbauhtdchiVmavLstQv3hiqw77IsRVi56pwZp17TawMHGU2O/aO5QXQjdZRhXV
	 +t6WDkGw4p/kHaoYcBT/VOsBXdkjwtiCk+uYuzlB/VheWnS1KC58noSr/zLztqOrDD
	 qDX4g0NrMOl4UOyQP6NoX+qwbOC5Wz+VOdBsJpMZ0D/jhvO8sboAATsd3ybwzA/fL/
	 stVM8Pm6g0QLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56946380CEC7;
	Thu, 10 Sep 2026 01:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5] net: dsa: microchip: enable the SGMII port of
 the KSZ9897S
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178900501187.1147948.14444954736072489989.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 01:50:11 +0000
References: <20260904-ksz9897-sgmii-port-v5-1-9bd4a0381aa8@vaisala.com>
In-Reply-To: <20260904-ksz9897-sgmii-port-v5-1-9bd4a0381aa8@vaisala.com>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, tristram.ha@microchip.com, nb@tipi-net.de,
 Jerry.Ray@microchip.com, Tristram.Ha@microchip.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 04 Sep 2026 06:03:00 +0000 you wrote:
> The KSZ9897 has an SGMII/1000BASE-X capable port 7, but its chip_info
> entry never set .sgmii_port. ksz_has_sgmii_port() is therefore false,
> ksz9477_pcs_create() is never called and ksz9477_phylink_mac_select_pcs()
> returns NULL for port 7, so a phy-mode = "sgmii" or "1000base-x" link on
> that port cannot come up.
> 
> Only the KSZ9897S has that port; the KSZ9897R has a second RGMII port
> instead. Both report chip ID 0x00989700, so the port cannot be enabled
> from the chip ID alone, and enabling it unconditionally breaks the
> KSZ9897R badly: ksz9477_setup() propagates the failure of
> xpcs_create_pcs_mdiodev() on a part without an XPCS, so the switch as a
> whole stops probing.
> 
> [...]

Here is the summary with links:
  - [net-next,v5] net: dsa: microchip: enable the SGMII port of the KSZ9897S
    https://git.kernel.org/netdev/net-next/c/3037c2f6a9de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


