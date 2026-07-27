Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85DD3FBEAB;
	Mon, 27 Jul 2026 23:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785195662; cv=none; b=AKcqSp57C17JJaoBcm1jrMo+LpJEQqVabRE+4WtJ65u7M96lo4nX7hv8KZMDpMQZWG7lLY2xusHgtYJtvHwi0b/dQowDvJWsaZpQDBYIS8QVH3x5+Yklb+9H14wxWZllbaNsQBXwORAJpy6t0bDApNm3tmHShaSEBafj1fsAkPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785195662; c=relaxed/simple;
	bh=zc8S+Te32538dsqXhNyDDKcl9I5cteXaEMIU9pL6ObQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OEmlYzlN+tHd84l3yzwReHm5wzPAQUoFd3M6sX8gv2ku/9z8xGEm4ntNz1e/LI5jXQcw1j83buluk0OWWaX23KZVO5EgYvv1WI3UmJnzzQQ2yBEXrI1mH3CDPExB/zp7A2W2rnpN7Rdff7kAgHlHzUxCtqWW5O7cmszUUhq3KLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqNRNaMr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqNRNaMr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFEF1F000E9;
	Mon, 27 Jul 2026 23:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785195660;
	bh=+AkDulFJvGbU+T4ibTyIoVY+rmeIInL85BGIirfLA5k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kqNRNaMrE1Z23E7OwSTuE8VhlwGmYwdoexj10/ehEOPMpB6r9rIS5aigWPz0UrFGP
	 ZRevf6/7PzYKgG8YmSryF5fLbnPt23wvSxtkYPI2IEPAOwDYxOqjk9UKSXqRTwtYkJ
	 niKE5vcMKJ2sOrvAwlftF7fAmTiiPoqj0u4U4e7kr0f4Q1X5NWMIyEtPWNi3rKa2pH
	 bvLPZ7Ge1DzRee5WHPBqKIIqmj8LRU+2YISrm/OQDs814IdAndNM27o1VW5bkvcNwR
	 XXNF1oE2pejeg6pIkWzrwHDX/KbtLGSoIxRaSb0S37Cv3wsL6Te60OIJ+ipH6JAguM
	 26eI5t0Hjmiag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198EC380CED4;
	Mon, 27 Jul 2026 23:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND v4 net-next 00/14] net: enetc: cleanups and
 improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178519562589.1461983.12874776848447820701.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jul 2026 23:40:25 +0000
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
In-Reply-To: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
To: Wei Fang (OSS) <wei.fang@oss.nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, wei.fang@nxp.com,
 chleroy@kernel.org, maxime.chevallier@bootlin.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 20 Jul 2026 09:43:02 +0800 you wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> The first group of patches (1, 2, 5-7) eliminates code duplication
> between the ENETC v1 and v4 drivers. Since both hardware generations
> share identical register layouts for MAC promiscuous mode, MAC hash
> filters, and VLAN promiscuous mode - differing only in register address
> offsets - common helper functions are extracted into enetc_pf_common.c
> and shared by both drivers.
> 
> [...]

Here is the summary with links:
  - [RESEND,v4,net-next,01/14] net: enetc: extract common helpers for MAC promiscuous mode setting
    https://git.kernel.org/netdev/net-next/c/2557834ad0ff
  - [RESEND,v4,net-next,02/14] net: enetc: extract common helpers for MAC hash filter configuration
    https://git.kernel.org/netdev/net-next/c/0ce10770963e
  - [RESEND,v4,net-next,03/14] net: enetc: convert ndo_set_rx_mode() to ndo_set_rx_mode_async()
    https://git.kernel.org/netdev/net-next/c/debf0c7a34fa
  - [RESEND,v4,net-next,04/14] net: enetc: improve MAFT entry management with bitmap tracking
    https://git.kernel.org/netdev/net-next/c/6228fc9c2bbe
  - [RESEND,v4,net-next,05/14] net: enetc: use PCI device name for debugfs directory
    https://git.kernel.org/netdev/net-next/c/9db43e6f35db
  - [RESEND,v4,net-next,06/14] net: enetc: simplify enetc4_set_port_speed()
    https://git.kernel.org/netdev/net-next/c/c969fbc01d9e
  - [RESEND,v4,net-next,07/14] net: enetc: differentiate phylink capabilities for pseudo-MAC and standalone MAC
    https://git.kernel.org/netdev/net-next/c/7c9a6ae0edb2
  - [RESEND,v4,net-next,08/14] net: enetc: remove invalid code from enetc4_pl_mac_link_up()
    https://git.kernel.org/netdev/net-next/c/59bb3d62489c
  - [RESEND,v4,net-next,09/14] net: enetc: open-code enetc4_set_default_si_vlan_promisc()
    https://git.kernel.org/netdev/net-next/c/75e134261f61
  - [RESEND,v4,net-next,10/14] net: enetc: refactor SI VLAN promiscuous mode configuration
    https://git.kernel.org/netdev/net-next/c/f7c6dcd6444b
  - [RESEND,v4,net-next,11/14] net: enetc: move enetc_set_si_vlan_promisc() to enetc_pf_common.c
    https://git.kernel.org/netdev/net-next/c/ba07e3bef1b5
  - [RESEND,v4,net-next,12/14] net: enetc: remove redundant num_vsi field from enetc_port_caps
    https://git.kernel.org/netdev/net-next/c/75b136cf0f6f
  - [RESEND,v4,net-next,13/14] net: enetc: use alloc_etherdev_mqs() to create netdev for VF driver
    https://git.kernel.org/netdev/net-next/c/f0c1f31afd97
  - [RESEND,v4,net-next,14/14] net: enetc: use kzalloc_flex() for enetc_psfp_gate allocation
    https://git.kernel.org/netdev/net-next/c/18bf0ac84334

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


