Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25C3307AF4
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823064; cv=none; b=UZSr5E07/tQaTCJ6Zof2BhNpXJ9dp2uEYsGDsy6k106DSvnNDBp2eAzT/vX81NVt3JcPls3gQMvtafs1Q0BMPqeJgoqsCtzpxA4MWfN6QTy3eNRgbzjCdS2A40dXmFMiDPGmBE5Df+yOrSESoJzf0acte1BSnyfA40KZrlLdViA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823064; c=relaxed/simple;
	bh=/EPP/Eo3mBS2H294APjG2zJypNY++P9Tr6sc/rCuccU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X78KV5AE79xCjJNTyrdz/8Rvk7fk3df36G6i6DmXJ9ashn9KmP+0yscFIcKftz/QPkYPv1wIVfj1/16YiG0WfpghuPs0u7q/Bf1j3JFzaLKnIG3WRo/9zmPxE7X8JUaLRzrJopY7qzMAWKZf0ZdHtt5KusyBrA+EKQ8oP6N0TCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2F31F00A3A;
	Thu, 23 Jul 2026 16:11:03 +0000 (UTC)
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D24EC3924477;
	Thu, 23 Jul 2026 16:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 00/13][pull request] Intel Wired LAN Driver Updates
 2026-07-17 (ice, idpf, iavf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178482301664.2765357.2035133153923309824.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 16:10:16 +0000
References: <20260717185340.3595286-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260717185340.3595286-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Jul 2026 11:53:22 -0700 you wrote:
> For ice:
> Vincent Chen fixes issue preventing VF creation when switchdev is not
> enabled in the configuration.
> 
> Michal fixes issue with checksum advertisement and handling with
> extension headers.
> 
> [...]

Here is the summary with links:
  - [net,01/13] ice: allow creating VFs when !CONFIG_ICE_SWITCHDEV
    https://git.kernel.org/netdev/net/c/99d0f42b0e5c
  - [net,02/13] ice: remove redundant switchdev check in ice_eswitch_attach_vf()
    (no matching commit)
  - [net,03/13] ice: pass the return value of skb_checksum_help()
    https://git.kernel.org/netdev/net/c/2d19302f6288
  - [net,04/13] ice: always do GCS if hardware supports it
    (no matching commit)
  - [net,05/13] ice: use NETIF_F_HW_CSUM instead of IP/IPV6
    (no matching commit)
  - [net,06/13] ice: fix LAG recipe to profile association
    https://git.kernel.org/netdev/net/c/d6da9b7d4859
  - [net,07/13] ice: support SBQ posted writes with non-posted support for CGU
    (no matching commit)
  - [net,08/13] ice: use READ_ONCE() to access cached PHC time
    https://git.kernel.org/netdev/net/c/2915681b89f8
  - [net,09/13] ice: fix PTP Call Trace during PTP release
    https://git.kernel.org/netdev/net/c/f6a7e00b81e3
  - [net,10/13] ice: prevent tstamp ring allocation for non-PF VSI types
    https://git.kernel.org/netdev/net/c/144539bbfd3c
  - [net,11/13] ice: reject out-of-range ptype in ice_parser_profile_init
    https://git.kernel.org/netdev/net/c/59abb87159c5
  - [net,12/13] idpf: fix max_vport related crash on allocation error during init
    https://git.kernel.org/netdev/net/c/237f1f7653b8
  - [net,13/13] iavf: validate num_vsis in VIRTCHNL_OP_GET_VF_RESOURCES response
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


