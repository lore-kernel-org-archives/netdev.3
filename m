Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505AC255F2D
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 01:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791248415; cv=none; b=Ej1hqIQLHANtx4uO6dj4ok3MEkK5MVd7mOGMMVihHhfvxKn/LQsMq6Bo8DesZkIS0ozDc/MfmsS3lXthEqslv1Ei79LiSOQ46PP+VwzNx9x/Bvjlrjtz2TRtkdH2W/EGIrbHerve7tpTqFu6afmqkZ8SeUU6L9qCf0z6T1UfmoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791248415; c=relaxed/simple;
	bh=Duj2yKfESdX0uReszmNEh8BV+IlCdivPe54ViJa6yi0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qKUN2P6Eey4boLA4awFCzUrZlZU50FJjetJC1ib5GonxnHsP1I4c4W1C3l7rvpYUxULc/ucExwpzcJyFTb2kqTGAJvEEwAAa6serNFPedtTAuBU2z+pWIJud5xZ8zOdYcz3t3MAVl1n/HkdTkaTBEOp5fJAME6PuCgv5RfXsMRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClhPVlJR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClhPVlJR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE32F1F00898;
	Tue,  6 Oct 2026 01:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791248412;
	bh=I7WGnxWtefM/WIIpc7aEmHZ0HzROz7RVxkf8UhUT1AU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ClhPVlJRB3OrFvQ+YsHsHyHjKYIaCatGfR7mhsZICepBG/NOQ3OhWAsOl9RL1QbmI
	 QOs0ZPqOfzotLrHJTXh69Lu+gfqxXGEvaxluM0zeYghG6YmUJjC+rZ3tI3x31OZ/y1
	 6xxWdYM6M9zJaw49d92OLG4eu1cfRIIGs+gee8cEn9nIlR192BopJ2+2KNOkd0h1VZ
	 6/tsPahWvi+wseO8Jf5eKhgXE+cuMafDxwgRvtpTGHxZWXn4e8D4XDL8nEjeO0y3wZ
	 pplqEYpYZEkAelOfivUkLGuy392y942fvtzIiSCOtx23zBUKRBxTCzSUEqnIt63mmE
	 OlAK8baUCDKTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4486392667F;
	Tue,  6 Oct 2026 01:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/10][pull request] Intel Wired LAN Driver
 Updates
 2026-09-29 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179124841127.1963510.4127078462976627704.git-patchwork-notify@kernel.org>
Date: Tue, 06 Oct 2026 01:00:11 +0000
References: <20260929224153.1455466-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260929224153.1455466-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 grzegorz.nitka@intel.com, aleksandr.loktionov@intel.com,
 marcin.szycik@intel.com, jacob.e.keller@intel.com,
 przemyslaw.korba@intel.com, xiongwm2026@163.com, ynorov@nvidia.com,
 przemyslaw.kitszel@intel.com, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 29 Sep 2026 15:41:40 -0700 you wrote:
> Grzegorz reduces DSCP message from error to debug when FW DCB
> management is active since it's an expected condition.
> 
> Marcin utilizes, existing, ice_fill_eth_hdr() call to set ethernet
> header value.
> 
> Jake reduces padding in ice_flash_info struct by moving sr_words
> location.
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] ice: reduce loglevel to debug for 'Can't delete DSCP' message
    https://git.kernel.org/netdev/net-next/c/ecf7e8b5c39d
  - [net-next,02/10] ice: use ice_fill_eth_hdr() in ice_fill_sw_rule()
    https://git.kernel.org/netdev/net-next/c/c160960c7f7e
  - [net-next,03/10] ice: reorder ice_flash_info fields to eliminate padding
    https://git.kernel.org/netdev/net-next/c/74a4378ee5b9
  - [net-next,04/10] ice: increase OICR interrupt moderation rate to 20K interrupts/sec
    https://git.kernel.org/netdev/net-next/c/0b1419908406
  - [net-next,05/10] ice: use inline helpers instead of memcmp() for IPv6 mask checks in ice_ethtool_fdir
    https://git.kernel.org/netdev/net-next/c/49a4ae7adead
  - [net-next,06/10] ice: add rx timestamp tracepoint for debugging
    https://git.kernel.org/netdev/net-next/c/5443362bae71
  - [net-next,07/10] ice: parser: use kcalloc for table allocation
    https://git.kernel.org/netdev/net-next/c/ef1c1106e178
  - [net-next,08/10] ice: simplify ice_pf_state_is_nominal()
    https://git.kernel.org/netdev/net-next/c/f93a165c9bc3
  - [net-next,09/10] ice: drop pf == NULL check in ice_pf_state_is_nominal()
    https://git.kernel.org/netdev/net-next/c/2270d2bf1606
  - [net-next,10/10] ice: simplify ice_vc_dis_qs_msg() a little
    https://git.kernel.org/netdev/net-next/c/ce0e3e4b98c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


